
unit l_liv;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons, Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, dxmdaset, cxGraphics,
  cxDropDownEdit, cxDBEdit, cxIndexedComboBox, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxCalendar, dxSkinsCore, dxSkinsDefaultPainters,
  cxGroupBox, cxRadioGroup, cxLookAndFeels, cxLabel, AppContainer,
  dxUIAClasses,

  LibUtils,
  ReportManager,
  DataManager,
  EnterpriseDataAccess,
  DB,
  nxDB,

  Gim00Fields,
  Gim10Fields,

  dm_sal;


type
    TSeccionIVALiquidacion = ( siDevengado = 1, siDeducible = 2 );

    TRptLivForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    PeriodoCtrl: TcxDBIndexedComboBox;
    ApunteTable: TnxeTable;
    AsientoTable: TnxeTable;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataPeriodo: TSmallIntField;
    gxRangeBox1: TgxRangeBox;
    DataPeriodicidad: TSmallintField;
    PeriodicidadCtrl: TcxDBRadioGroup;
    Label4: TcxLabel;
    PeriodoLabel: TcxLabel;
    Label2: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    SQLQuery: TnxeQuery;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure PeriodoCtrlPropertiesChange(Sender: TObject);
    procedure FechaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure PeriodicidadCtrlPropertiesChange(Sender: TObject);
    private
      FFijandoPeriodo,
      FEjercicioAnterior : Boolean;
      function TrimestreLiquidacion : SmallInt;
    public

      LibroIVATable : TnxeTable;
      LibroIVAFields : TLibroIVAFields;
      AsientoFields : TAsientoFields;
      ApunteFields : TApunteFields;
      ClienteFields : TClienteFields;
      TiposIVAFields : TTiposIVAFields;
      ProveedorFields : TProveedorFields;
      FacturaFields : TFacturaFields;
      PaisFields : TPaisFields;

      SumaBaseImponibleIVA,
      SumaCuotaIVA,
      TipoIVA : array[ siDevengado..siDeducible, 1..NroMaximoTiposTasas ] of Decimal;  // 1 = Devengado y 2 = Deducible

      SumaBaseImponibleRE,
      SumaCuotaRE,
      TipoRE : array[ 1..NroMaximoTiposTasas ] of Decimal;

      SumaBaseImponibleDevengada,
      SumaBaseImponibleDeducible,
      SumaBaseImponibleISPDevengado,  // Inversión en facturas emitidas
      SumaBaseImponibleDevengadoRECC,
      SumaCuotaIVADevengadoRECC,
      SumaBaseImponibleSoportadoRECC,
      SumaCuotaIVASoportadoRECC : Decimal;

      BaseImponibleAdquisicionesIntracomunitarias,
      BaseImponibleISPDeducible,
      BaseImponibleOperacionesInternas,
      BaseImponibleIVAModificaciones,
      BaseImponibleREModificaciones,
      BaseImponibleRectificacionDeducciones,

      CuotaIVAAdquisicionesIntracomunitarias,
      CuotaIVAISPDeducible,
      SumaCuotaDevengada,
      SumaCuotaDeducible,
      CuotaOperacionesInternas,
      CuotaIVAModificaciones,
      CuotaREModificaciones,
      CuotaIVARectificacionDeducciones,
      EntregasIntracomunitarias,
      ExportacionesYOperacionesAsimiladas : Decimal

    end;

var
  RptLivForm : TRptLivForm = nil;

procedure liquidacionIVA;


implementation

uses   DateUtils,

       Gdm00Dm,
       Gdm10Dm,

       dmi_iva,
       dmi_ast,
       dmi_fac,

       dm_pai,
       dm_pga,
       dm_ast,
       dm_tas,
       dm_sub,
       dm_iva,
       dm_cli,
       dm_pro,
       dm_fac,

       b_msg;

{$R *.DFM}

resourceString
       RsOpIntracom1 = 'Adquisiciones intracomunitarias de bienes y servicios';
       RsOpInteriores = 'Por cuotas soportadas en operaciones interiores corrientes';
       RsOpIntracom2 = 'En adquisiciones intracomunitarias de bienes y servicios corrientes';
       RsOpInversion1 = 'Otras operaciones con inversión del sujeto pasivo (excepto. adq. intracom)';
       RsOpInversion2 = 'Operaciones no sujetas o con inversión del sujeto pasivo que originan el derecho a deducción';
       RsRECCDevengado = 'Importes de las entregas de bienes y prestaciones de servicios a las que habiéndoles sido aplicado el régimen especial del criterio de caja hubieran resultado devengadas conforme a la regla general de devengo contenida en el art. 75 LIVA';
       RsRECCSoportado = 'Importes de las adquisiciones de bienes y servicios a las que sea de aplicación o afecte el régimen especial del criterio de caja';
       RsModificaciones = 'Modificación bases y cuotas';
       RsModificacionesRE = 'Modificaciones bases y cuotas del recargo de equivalencia';
       RsRectificacionDeducciones = 'Rectificación de deducciones';
       RsEntregasIntracomunitarias = 'Entregas intracomunitarias de bienes y servicios';
       RsExportacionesYOperacionesAsimiladas = 'Exportaciones y operaciones asimiladas';

       // rsInversiones   = 'Regularización inversiones ()';

       RsTrimestre = '"<Definido por el usuario>","Primer trimestre","Segundo trimestre","Tercer trimestre","Cuarto trimestre"';
       RsMes = 'Mes';
       RsPeriodo = 'Periodo';

procedure LiquidacionIVA;
begin
     CreateReportForm( TRptLivForm, RptLivForm );
end;

procedure TRptLivForm.InitializeForm;
begin
     AsientoFields := TAsientoFields.Create( AsientoTable );
     ApunteFields := TApunteFields.Create( ApunteTable );

     PaisFields := TPaisFields.Create( Self );
     ClienteFields := TClienteFields.Create( Self );
     TiposIVAFields := TTiposIVAFields.Create( Self );
     ProveedorFields := TProveedorFields.Create( Self );
     FacturaFields := TFacturaFields.Create( Self );

     DataPeriodicidad.Value := 1; // Trimestral, por defecto
     DataPeriodo.Value := TrimestreLiquidacion;
end;

function TRptLivForm.TrimestreLiquidacion : SmallInt;
begin

     //* 03.03.2009  Ajustando correctamente al trimestre anterior al actual

     Result := ( MonthOf( ApplicationContainer.TodayDate ) - 1 ) div 3;
     If   Result=0
     then begin
          Result := 4;
          FEjercicioAnterior := True;
          end;
end;

procedure TRptLivForm.PeriodicidadCtrlPropertiesChange(Sender: TObject);
begin
     With PeriodoCtrl.Properties.Items do
       case PeriodicidadCtrl.ItemIndex of
         0 : begin
             PeriodoLabel.Caption := RsMes;
             CommaText := '"<Definido por el usuario>",' + RsMeses;
             DataPeriodo.Value := MonthOf( ApplicationContainer.TodayDate );
             end;
         1 : begin
             PeriodoLabel.Caption := RsPeriodo;
             CommaText := RsTrimestre;
             DataPeriodo.Value := TrimestreLiquidacion;
             end;
         end;
end;

procedure TRptLivForm.PeriodoCtrlPropertiesChange(Sender: TObject);

var   EjercicioLiquidacion : SmallInt;

begin
     try
       FFijandoPeriodo := True;
       case PeriodicidadCtrl.ItemIndex of
         0 : If   PeriodoCtrl.ItemIndex<>0
             then begin
                  DataFechaInicial.Value := EncodeDate( ApplicationContainer.Ejercicio, DataPeriodo.Value, 1 );
                  DataFechaFinal.Value := EncodeDate( ApplicationContainer.Ejercicio, DataPeriodo.Value, DaysInAMonth( ApplicationContainer.Ejercicio, DataPeriodo.Value ) );
                  end;
         1 : case PeriodoCtrl.ItemIndex of
               0 : ;
               1 : begin
                   DataFechaInicial.Value := EncodeDate(  ApplicationContainer.Ejercicio, 1, 1 );
                   DataFechaFinal.Value := EncodeDate( ApplicationContainer.Ejercicio, 3, 31 );
                   end;
               2 : begin
                   DataFechaInicial.Value := EncodeDate( ApplicationContainer.Ejercicio, 4, 1 );
                   DataFechaFinal.Value := EncodeDate( ApplicationContainer.Ejercicio, 6, 30 );
                   end;
               3 : begin
                   DataFechaInicial.Value := EncodeDate( ApplicationContainer.Ejercicio, 7, 1 );
                   DataFechaFinal.Value := EncodeDate( ApplicationContainer.Ejercicio, 9, 30 );
                   end;
               4 : begin
                   EjercicioLiquidacion := ApplicationContainer.Ejercicio;
                   If   FEjercicioAnterior
                   then Dec( EjercicioLiquidacion );
                   DataFechaInicial.Value := EncodeDate( EjercicioLiquidacion, 10, 1 );
                   DataFechaFinal.Value := EncodeDate( EjercicioLiquidacion, 12, 31 );
                   FEjercicioAnterior := False;
                   end;
               end;
         end;
       finally
         FFijandoPeriodo := False;
         end;
end;

procedure TRptLivForm.FechaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   not FFijandoPeriodo
     then DataPeriodo.Value := 0;
end;

procedure TRptLivForm.FormManagerOkButton;

var   SQLText : String;
      EfectoCobrarFields : TEfectoCobrarFields;
      EfectoPagarFields : TEfectoPagarFields;
      PeriodoAplicacionCriterioCaja,
      ExisteRegistroCriterioCaja : Boolean;

procedure SeleccionaRegistros;

var   Index,
      InxTipoIVA,
      InxTipoRE   : SmallInt;
      DescripcionTasa : String;

procedure NuevoRegistroDiario( Modelo         : SmallInt;
                               Nombre         : string;
                               Tipo           : SmallInt;
                               BaseImponible,
                               TipoIVA,
                               CuotaIVA       : Decimal );
begin
     LibroIVATable.Append;

     LibroIVAFields.Modelo.Value := Modelo;
     LibroIVAFields.Nombre.Value := Nombre;
     LibroIVAFields.Tipo.Value := Tipo;
     LibroIVAFields.BaseImponibleIVA.Value := BaseImponible;
     LibroIVAFields.TipoIVA.Value := TipoIVA;
     LibroIVAFields.CuotaIVA.Value := CuotaIVA;

     LibroIVATable.Post;
end;

function IndiceTipoIVA( SeccionIVA : TSeccionIVALiquidacion;
                        Tipo       : Decimal ) : SmallInt;

var  Index : SmallInt;

begin
     Result := 1;
     For Index := 1 to NroMaximoTiposTasas do
       If   ( SumaBaseImponibleIVA[ SeccionIVA, Index ]=0.0 ) or ( TipoIVA[ SeccionIVA, Index ]=Tipo )
       then begin
            TipoIVA[ SeccionIVA, Index ] := Tipo;
            Result := Index;
            Break;
            end;
end;

function IndiceTipoRE( Tipo : Decimal ) : SmallInt;

var  Index : SmallInt;

begin
     Result := 1;
     For Index := 1 to NroMaximoTiposTasas do
       If   ( SumaBaseImponibleRE[ Index ]=0.0 ) or ( TipoRE[ Index ]=Tipo )
       then begin
            TipoRE[ Index ] := Tipo;
            Result := Index;
            Break;
            end;
end;

begin

     try

       Saldos.Cuadra;  // Solo se muestra el aviso

       ApplicationContainer.StartProgression;

       PeriodoAplicacionCriterioCaja := YearOf( DataFechaInicial.Value )>=2014;

       // Cálculo del I.V.A. REPERCUTIDO

       // Cobrado

       BaseImponibleIVAModificaciones := 0.0;
       BaseImponibleREModificaciones := 0.0;
       CuotaIVAModificaciones := 0.0;
       CuotaREModificaciones := 0.0;

       SumaBaseImponibleISPDevengado := 0.0;
       SumaBaseImponibleDevengadoRECC := 0.0;
       SumaCuotaIVADevengadoRECC := 0.0;

       If   PeriodoAplicacionCriterioCaja and
            ( DataModule00.DmEmpresaFields.RegimenEspecialCriterioCaja.Value or Asiento.EjercicioTransicionCriterioCaja )
       then With AsientoTable do
              begin

              IndexFieldNames := 'Fecha';
              ApunteTable.IndexFieldNames := 'Ejercicio;NroAsiento;NroApunte';

              SetRange( [ DataFechaInicial.Value ], [ DataFechaFinal.Value ] );

              First;
              While not Eof  do
                begin
                If   ( AsientoFields.TipoAsiento.Value in [ taCobro, taCobroRemesa, taCancelacion ] ) or
                     ( ( AsientoFields.TipoAsiento.Value=taRegularizacionIVA ) and ( AsientoFields.NroRegistro.Value=2 ) )  // cobros
                then begin

                     ApplicationContainer.ShowProgression;

                     var DatosClienteDisponibles := Cliente.ObtenPorSubcuenta( AsientoFields.Propietario.Value, ClienteFields );

                     If   not ( DatosClienteDisponibles and ( ClienteFields.Factura_ModeloIVA.Value=micVentasOnline ) )
                     then With ApunteTable do
                            begin
                            SetRange( [ AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value ] );
                            First;
                            While not Eof do
                              begin

                              If   ApunteFields.TipoApunte.Value=tapTraspasoIVA
                              then If   Asiento.ObtenDocumento( taFraEmitida, ApunteFields.EjercicioFactura.Value, '', ApunteFields.Serie.Value, ApunteFields.NroFactura.Value ) // Compruebo si existe la factura que originó el cobro
                                   then begin
                                        Factura.ObtenRegistroContableFactura( tfAsiento, AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value, FacturaFields );
                                        If   ApunteFields.Tipo.Value in [ 1..NroMaximoTiposTasas ]
                                        then begin
                                             Tasa.TipoIVA( AsientoFields.Fecha.Value, ApunteFields.Tipo.Value, TiposIVAFields );
                                             If   TiposIVAFields.Liquidable.Value
                                             then If   ( FacturaFields.TipoFactura.Value in [ tfeRectificativa80_1_2..tfeRectificativaSimplificada ] ) and   // Factura rectificativa
                                                       ( TiposIVAFields.IVARepercutido.Value<>0.0 )                                                          //* 29.07.2014 Los tipos de I.V.A. exentos no deben incluirse
                                                  then begin
                                                       DecAdd( BaseImponibleIVAModificaciones, ApunteFields.BaseImponible.Value );
                                                       DecAdd( CuotaIVAModificaciones, ApunteFields.CuotaIVA.Value );
                                                       end
                                                  else begin
                                                       InxTipoIVA := IndiceTipoIVA( siDevengado, TiposIVAFields.IVARepercutido.Value );
                                                       DecAdd( SumaBaseImponibleIVA[ siDevengado, InxTipoIVA ], ApunteFields.BaseImponible.Value );
                                                       DecAdd( SumaCuotaIVA[ siDevengado, InxTipoIVA ], ApunteFields.CuotaIVA.Value );
                                                       end;
                                             end;
                                        end;
                              Next;
                              end;
                            end;

                  end;

                Next;
                end;

              end;

       // Devengado

       With AsientoTable do
         begin

         IndexFieldNames := 'TipoAsiento;Fecha';
         ApunteTable.IndexFieldNames := 'Ejercicio;NroAsiento;NroApunte';

         SetRange( [ taFraEmitida, DataFechaInicial.Value ], [ taFraEmitida, DataFechaFinal.Value ] );

         First;
         While not eof  do
           begin

           ApplicationContainer.ShowProgression;

           var DatosClienteDisponibles := Cliente.ObtenPorSubcuenta( AsientoFields.Propietario.Value, ClienteFields );
           If   DatosClienteDisponibles
           then Pais.Obten( ClienteFields.CodigoPais.Value, PaisFields );

           //** 02.04.2025  Excluidos de la liquidación los clientes de ventas online intracomunitarias

           If   not ( DatosClienteDisponibles and ( ClienteFields.Factura_ModeloIVA.Value=micVentasOnline ) )
           then begin

                Factura.ObtenRegistroContableFactura( tfAsiento, AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value, FacturaFields );

                With ApunteTable do
                  begin
                  SetRange( [ AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value, 2 ],
                            [ AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value, MaxSmallint ] );
                  First;
                  While not Eof do
                    begin

                    If   ApunteFields.TipoApunte.Value=tapManual
                    then begin
                         If   ApunteFields.Tipo.Value in [ 1..NroMaximoTiposTasas ]
                         then begin
                              Tasa.TipoIVA( AsientoFields.Fecha.Value, ApunteFields.Tipo.Value, TiposIVAFields );
                              If   TiposIVAFields.Liquidable.Value
                              then begin
                                   If   PeriodoAplicacionCriterioCaja and
                                        ( DataModule00.DmEmpresaFields.RegimenEspecialCriterioCaja.Value ) and
                                        ( ClienteFields.Factura_ModeloIVA.Value=micSinRE )
                                   then begin
                                        DecAdd( SumaBaseImponibleDevengadoRECC, ApunteFields.BaseImponible.Value );
                                        DecAdd( SumaCuotaIVADevengadoRECC, ApunteFields.CuotaIVA.Value );
                                        end
                                   else If   ( FacturaFields.TipoFactura.Value in [ tfeRectificativa80_1_2..tfeRectificativaSimplificada ] ) and   // Factura rectificativa
                                             ( TiposIVAFields.IVARepercutido.Value<>0.0 )
                                        then begin
                                             DecAdd( BaseImponibleIVAModificaciones, ApunteFields.BaseImponible.Value );
                                             DecAdd( CuotaIVAModificaciones, ApunteFields.CuotaIVA.Value );
                                             If   ApunteFields.CuotaRE.Value<>0.0
                                             then begin
                                                  DecAdd( BaseImponibleREModificaciones, ApunteFields.BaseImponible.Value );
                                                  DecAdd( CuotaREModificaciones, ApunteFields.CuotaRE.Value );
                                                  end;
                                             end
                                        else If   AsientoFields.Origen.Value=ofrInversionSP
                                             then DecAdd( SumaBaseImponibleISPDevengado, ApunteFields.BaseImponible.Value )
                                             else begin
                                                  InxTipoIVA := IndiceTipoIVA( siDevengado, TiposIVAFields.IVARepercutido.Value );
                                                  DecAdd( SumaBaseImponibleIVA[ siDevengado, InxTipoIVA ], ApunteFields.BaseImponible.Value );
                                                  DecAdd( SumaCuotaIVA[ siDevengado, InxTipoIVA ], ApunteFields.CuotaIVA.Value );
                                                  If   ApunteFields.CuotaRE.Value<>0.0
                                                  then begin
                                                       InxTipoRE := IndiceTipoRE( TiposIVAFields.RERepercutido.Value );
                                                       DecAdd( SumaBaseImponibleRE[ InxTipoRE ], ApunteFields.BaseImponible.Value );
                                                       DecAdd( SumaCuotaRE[ InxTipoRE ], ApunteFields.CuotaRE.Value );
                                                       end;

                                                  If   DatosClienteDisponibles
                                                  then begin

                                                       // Una extraña excepción

                                                       var ExportacionesTerritorioEspañol := ( ( ClienteFields.CodigoPais.Value=CodigoEspaña ) and
                                                                                               ( ( ClienteFields.CodigoProvincia.Value='35' ) or        // Canarias, Ceuta y Melilla
                                                                                                 ( ClienteFields.CodigoProvincia.Value='38' ) or
                                                                                                 ( ClienteFields.CodigoProvincia.Value='51' ) or
                                                                                                 ( ClienteFields.CodigoProvincia.Value='52' ) ) );

                                                       If  ( ClienteFields.CodigoPais.Value<>CodigoEspaña ) or ExportacionesTerritorioEspañol
                                                       then If   ExportacionesTerritorioEspañol or not PaisFields.Intracomunitario.Value
                                                            then DecAdd( ExportacionesYOperacionesAsimiladas, ApunteFields.BaseImponible.Value )
                                                            else DecAdd( EntregasIntracomunitarias, ApunteFields.BaseImponible.Value );

                                                       end;
                                                  end;
                                   end;
                              end;
                         end;

                    Next;
                    end;

                  end;

                end;

           Next;
           end;

         For Index := 1 to NroMaximoTiposTasas do
           If   ( SumaCuotaIVA[ siDevengado, Index ]<>0.0 ) or ( SumaCuotaRE[ Index ]<>0.0 )
           then begin
                DecAdd( SumaBaseImponibleDevengada, SumaBaseImponibleIVA[ siDevengado, Index ] );
                DecAdd( SumaCuotaDevengada, SumaCuotaIVA[ siDevengado, Index ] + SumaCuotaRE[ Index ] );
                end;

         SumaBaseImponibleDevengada := SumaBaseImponibleDevengada + BaseImponibleIVAModificaciones + BaseImponibleREModificaciones;
         SumaCuotaDevengada := SumaCuotaDevengada + CuotaIVAModificaciones + CuotaREModificaciones;

         // Cálculo del I.V.A. DEDUCIBLE

         BaseImponibleRectificacionDeducciones := 0.0;
         CuotaIVARectificacionDeducciones := 0.0;

         // Pagado

         SumaBaseImponibleSoportadoRECC := 0.0;
         SumaCuotaIVASoportadoRECC := 0.0;

         ExisteRegistroCriterioCaja := False;

         If   PeriodoAplicacionCriterioCaja
         then With AsientoTable do
                begin

                IndexFieldNames := 'Fecha';
                ApunteTable.IndexFieldNames := 'Ejercicio;NroAsiento;NroApunte';

                SetRange( [ DataFechaInicial.Value ], [ DataFechaFinal.Value ] );

                First;
                While not Eof  do
                  begin
                  If   ( AsientoFields.TipoAsiento.Value in [ taPago, taPagoRemesa ] ) or
                       ( ( AsientoFields.TipoAsiento.Value=taRegularizacionIVA ) and ( AsientoFields.NroRegistro.Value=1 ) )  // pagos
                  then begin
                       ApplicationContainer.ShowProgression;
                       With ApunteTable do
                         begin
                         SetRange( [ AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value ] );
                         First;
                         While not Eof do
                           begin

                           If   ApunteFields.TipoApunte.Value=tapTraspasoIVA
                           then If   Asiento.ObtenDocumento( taFraRecibida, ApunteFields.EjercicioFactura.Value, ApunteFields.Propietario.Value, ApunteFields.Serie.Value, ApunteFields.NroFactura.Value ) // Compruebo si existe la factura que originó el pago
                                then begin
                                     Factura.ObtenRegistroContableFactura( tfAsiento, AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value, FacturaFields );
                                     If   ApunteFields.Tipo.Value in [ 1..NroMaximoTiposTasas ]
                                     then begin
                                          Tasa.TipoIVA( AsientoFields.Fecha.Value, ApunteFields.Tipo.Value, TiposIVAFields );
                                          If   TiposIVAFields.Liquidable.Value
                                          then If   ( FacturaFields.TipoFactura.Value in [ tfrRectificativa_80_1_2..tfrRectificativaSimplificada ] ) and  // Factura rectificativa
                                                    ( TiposIVAFields.IVASoportado.Value<>0.0 )            //* 29.07.2014 Los tipos de I.V.A. exentos no deben incluirse
                                               then begin
                                                    DecAdd( BaseImponibleRectificacionDeducciones, ApunteFields.BaseImponible.Value );
                                                    DecAdd( CuotaIVARectificacionDeducciones, ApunteFields.CuotaIVA.Value );
                                                    end
                                               else begin
                                                    InxTipoIVA := IndiceTipoIVA( siDeducible, TiposIVAFields.IVASoportado.Value );
                                                    DecAdd( SumaBaseImponibleIVA[ siDeducible, InxTipoIVA ], ApunteFields.BaseImponible.Value );
                                                    DecAdd( SumaCuotaIVA[ siDeducible, InxTipoIVA ], ApunteFields.CuotaIVA.Value );

                                                    DecAdd( BaseImponibleOperacionesInternas, ApunteFields.BaseImponible.Value );
                                                    DecAdd( CuotaOperacionesInternas, ApunteFields.CuotaIVA.Value );
                                                    end;
                                          end;
                                     end;
                           Next;
                           end;
                       end;
                    end;
                  Next;
                  end;

                end;

         IndexFieldNames := 'TipoAsiento;Fecha';
         ApunteTable.IndexFieldNames := 'Ejercicio;NroAsiento;NroApunte';

         SetRange( [ taFraRecibida, DataFechaInicial.Value ], [ taFraRecibida, DataFechaFinal.Value ] );

         First;
         While not Eof  do
           begin

           ApplicationContainer.ShowProgression;

           Proveedor.ObtenPorSubcuenta( AsientoFields.Propietario.Value, ProveedorFields );
           Factura.ObtenRegistroContableFactura( tfAsiento, AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value, FacturaFields );

           With ApunteTable, AsientoFields do
             begin
             SetRange( [ Ejercicio.Value, NroAsiento.Value, 2 ], [ Ejercicio.Value, NroAsiento.Value, MaxSmallint ] );
             First;
             While not Eof do
               begin
               If   ApunteFields.TipoApunte.Value=tapManual
               then If   ApunteFields.Tipo.Value in [ 1..NroMaximoTiposTasas ]
                    then begin
                         Tasa.TipoIVA( AsientoFields.Fecha.Value, ApunteFields.Tipo.Value, TiposIVAFields );
                         If   TiposIVAFields.Liquidable.Value
                         then If   TiposIVAFields.IVASoportado.Value<>0.0
                              then If   AsientoFields.Origen.Value=ofrIntracomunitaria
                                   then begin
                                        DecAdd( BaseImponibleAdquisicionesIntracomunitarias, ApunteFields.BaseImponible.Value );
                                        DecAdd( CuotaIVAAdquisicionesIntracomunitarias, ApunteFields.CuotaIVA.Value );
                                        end
                                   else If   AsientoFields.Origen.Value=ofrInversionSP
                                        then begin
                                             DecAdd( BaseImponibleISPDeducible, ApunteFields.BaseImponible.Value );
                                             DecAdd( CuotaIVAISPDeducible, ApunteFields.CuotaIVA.Value );
                                             end
                                        else If   PeriodoAplicacionCriterioCaja and
                                                  ( ( ( DataModule00.DmEmpresaFields.RegimenEspecialCriterioCaja.Value ) and ( ProveedorFields.Factura_ModeloIVA.Value=mipNormal ) ) or
                                                      ProveedorFields.Factura_RegimenEspecialCC.Value )
                                             then begin
                                                  DecAdd( SumaBaseImponibleSoportadoRECC, ApunteFields.BaseImponible.Value );
                                                  DecAdd( SumaCuotaIVASoportadoRECC, ApunteFields.CuotaIVA.Value );
                                                  end
                                             else If   ( FacturaFields.TipoFactura.Value in [ tfrRectificativa_80_1_2..tfrRectificativaSimplificada ] ) and   // Factura rectificativa
                                                       ( TiposIVAFields.IVASoportado.Value<>0.0 )
                                                  then begin
                                                       DecAdd( BaseImponibleRectificacionDeducciones, ApunteFields.BaseImponible.Value );
                                                       DecAdd( CuotaIVARectificacionDeducciones, ApunteFields.CuotaIVA.Value );
                                                       end
                                                  else begin
                                                       InxTipoIVA := IndiceTipoIVA( siDeducible, TiposIVAFields.IVASoportado.Value );
                                                       DecAdd( SumaBaseImponibleIVA[ siDeducible, InxTipoIVA ], ApunteFields.BaseImponible.Value );
                                                       DecAdd( SumaCuotaIVA[ siDeducible, InxTipoIVA ], ApunteFields.CuotaIVA.Value );

                                                       DecAdd( BaseImponibleOperacionesInternas, ApunteFields.BaseImponible.Value );
                                                       DecAdd( CuotaOperacionesInternas, ApunteFields.CuotaIVA.Value );
                                                       end;
                         end;
               Next;
               end;

             end;

           Next;
           end;

         BaseImponibleOperacionesInternas := BaseImponibleOperacionesInternas + BaseImponibleISPDeducible;  // Se debe sumar a esta sección
         CuotaOperacionesInternas := CuotaOperacionesInternas + CuotaIVAISPDeducible;

         SumaBaseImponibleDevengada := SumaBaseImponibleDevengada + BaseImponibleAdquisicionesIntracomunitarias + BaseImponibleISPDeducible;
         SumaBaseImponibleDeducible := BaseImponibleOperacionesInternas + BaseImponibleRectificacionDeducciones + BaseImponibleAdquisicionesIntracomunitarias;

         SumaCuotaDevengada := SumaCuotaDevengada + CuotaIVAAdquisicionesIntracomunitarias + CuotaIVAISPDeducible;
         SumaCuotaDeducible := CuotaOperacionesInternas + CuotaIVARectificacionDeducciones + CuotaIVAAdquisicionesIntracomunitarias;

         // Sección del impreso de IVA Devengado

         For Index := 1 to NroMaximoTiposTasas do
           If   SumaCuotaIVA[ siDevengado, Index ]<>0.0
           then With LibroIVAFields do
                  begin

                  DescripcionTasa := Tasa.DescripcionTipoIVAPorcentaje( DataFechaFinal.Value, '', tpIVARepercutido, Self.TipoIVA[ siDevengado, Index ] );

                  NuevoRegistroDiario( 1,
                                       DescripcionTasa,
                                       Index,
                                       SumaBaseImponibleIVA[ siDevengado, Index ],
                                       Self.TipoIVA[ siDevengado, Index ],
                                       SumaCuotaIVA[ siDevengado, Index ]  );

                  end;

         NuevoRegistroDiario( 1, '', 99, 0.0, 0.0, 0.0 );  // Un espacio al final

         If   BaseImponibleAdquisicionesIntracomunitarias<>0.0
         then NuevoRegistroDiario( 2, rsOpIntracom1, 0, BaseImponibleAdquisicionesIntracomunitarias, 0.0, CuotaIVAAdquisicionesIntracomunitarias );

         If   BaseImponibleISPDeducible<>0.0
         then NuevoRegistroDiario( 3, rsOpInversion1, 0, BaseImponibleISPDeducible, 0.0, CuotaIVAISPDeducible );

         If   BaseImponibleIVAModificaciones<>0.0
         then NuevoRegistroDiario( 4, RsModificaciones, 0, BaseImponibleIVAModificaciones, 0.0, CuotaIVAModificaciones );

         For Index := 1 to NroMaximoTiposTasas do
           If   SumaCuotaRE[ Index ]<>0.0
           then With LibroIVAFields do
                  begin

                  DescripcionTasa := Tasa.DescripcionTipoIVAPorcentaje( DataFechaFinal.Value, '', tpRERepercutido, Self.TipoRE[ Index ] );

                  NuevoRegistroDiario( 5,
                                       DescripcionTasa,
                                       Index,
                                       SumaBaseImponibleRE[ Index ],
                                       Self.TipoRE[ Index ],
                                       SumaCuotaRE[ Index ] );
                  end;

         NuevoRegistroDiario( 5, '', 99, 0.0, 0.0, 0.0 );  // Un espacio al final

         If   BaseImponibleREModificaciones<>0.0
         then NuevoRegistroDiario( 6, RsModificacionesRE, 0, BaseImponibleREModificaciones, 0.0, CuotaREModificaciones );

         NuevoRegistroDiario( 7, '', 0, SumaBaseImponibleDevengada, 0.0, SumaCuotaDevengada );

         // Sección del impreso de IVA Deducible

         NuevoRegistroDiario( 8, rsOpInteriores, 0, BaseImponibleOperacionesInternas, 0.0, CuotaOperacionesInternas );

         {  No aparece en el modelo 303

         For Index := 1 to NroMaximoTiposTasas do
           If   SumaCuotaIVA[ siDeducible, Index ]<>0.0
           then begin

                DescripcionTasa := Tasa.DescripcionTipoIVAPorcentaje( DataFechaFinal.Value, '', tpIVASoportado, Self.TipoIVA[ siDeducible, Index ] );

                NuevoRegistroDiario( 7,
                                     DescripcionTasa,
                                     Index,
                                     SumaBaseImponibleIVA[ siDeducible, Index ],
                                     Self.TipoIVA[ siDeducible, Index ],
                                     SumaCuotaIVA[ siDeducible, Index ] );
                end;
         }

         // BaseImponibleRectificacionDeducciones

         If   BaseImponibleRectificacionDeducciones<>0.0
         then NuevoRegistroDiario( 9, RsRectificacionDeducciones, 0, BaseImponibleRectificacionDeducciones, 0.0, CuotaIVARectificacionDeducciones );

         If   CuotaIVAAdquisicionesIntracomunitarias<>0.0
         then NuevoRegistroDiario( 10, rsOpIntracom2, 0, BaseImponibleAdquisicionesIntracomunitarias, 0.0,  CuotaIVAAdquisicionesIntracomunitarias );

         NuevoRegistroDiario( 11, '', 0, SumaBaseImponibleDeducible, 0.0, SumaCuotaDeducible );

         // Resultado regimen general

         NuevoRegistroDiario( 12, '', 0, 0.0, 0.0, SumaCuotaDevengada - SumaCuotaDeducible );


         // Información adicional

         If   ( EntregasIntracomunitarias<>0.0 ) or
              ( ExportacionesYOperacionesAsimiladas<>0.0 ) or
              ( SumaBaseImponibleISPDevengado<>0.0 ) or
              ( SumaCuotaIVADevengadoRECC<>0.0 ) or
              ( SumaCuotaIVASoportadoRECC<>0.0 )
         then begin

              NuevoRegistroDiario( 13, '', 0, 0.0, 0.0, 0.0 );

              If   EntregasIntracomunitarias<>0.0
              then NuevoRegistroDiario( 14, RsEntregasIntracomunitarias, 0, EntregasIntracomunitarias, 0.0, 0.0 );

              If   ExportacionesYOperacionesAsimiladas<>0.0
              then NuevoRegistroDiario( 15, RsExportacionesYOperacionesAsimiladas, 0, ExportacionesYOperacionesAsimiladas, 0.0, 0.0 );

              If   SumaBaseImponibleISPDevengado<>0.0
              then NuevoRegistroDiario( 16, rsOpInversion2, 0, SumaBaseImponibleISPDevengado, 0.0,  0.0 );

              // RECC

              If   SumaCuotaIVADevengadoRECC<>0.0
              then NuevoRegistroDiario( 17, RsRECCDevengado, 0, SumaBaseImponibleDevengadoRECC, 0.0, SumaCuotaIVADevengadoRECC );

              If   SumaCuotaIVASoportadoRECC<>0.0
              then NuevoRegistroDiario( 18, RsRECCSoportado, 0, SumaBaseImponibleSoportadoRECC, 0.0, SumaCuotaIVASoportadoRECC );

              end;

         end;

     finally
       ApplicationContainer.EndProgression;
       end;

end;

begin

     With Report do
       try

         Load;

         LibroIVATable := CreateEmptyTable( 'Liquidacion', DataModule10.GetSQL( 'LiquidacionIVA' ) );
         LibroIVAFields := TLibroIVAFields.Create( LibroIVATable );
         LibroIVATable.IndexFieldNames := 'Modelo;Tipo';

         SeleccionaRegistros;

         SetValueField( DataFechaInicial );
         SetValueField( DataFechaFinal );
         SetValueField( DataPeriodo );

         SetValue( 'TextoPeriodo', PeriodoCtrl.Text );

         Start;

       except on E : Exception do Cancel( E );
         end;
end;

end.

