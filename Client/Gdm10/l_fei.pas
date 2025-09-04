
unit l_fei;

interface

uses
  SysUtils, DateUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  LibUtils,
  Mask,
  ComCtrls,

  Menus,
  cxLookAndFeelPainters,
  cxButtons,
  cxCheckBox,
  cxDBEdit,
  cxContainer,
  cxEdit,
  cxTextEdit,
  cxPC,
  cxControls,
  DB,
  ReportManager,
  dxmdaset,
  DataManager,
  nxdb,


  Gim10Fields,
  dm_ast,
  dm_sal, cxMaskEdit, cxDropDownEdit, cxCalendar, dxSkinsCore,
  dxSkinscxPCPainter, cxGraphics, cxLookAndFeels, dxSkinsDefaultPainters,
  cxLabel, cxGroupBox, cxPCdxBarPopupMenu, AppContainer, dxBarBuiltInMenu,
  dxUIAClasses;


type
    TRptFeiForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    TabSheet3: TcxTabSheet;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    ProveedorInicialCtrl: TcxDBTextEdit;
    ProveedorFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    UnaPorHojaCtrl: TcxDBCheckBox;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataProveedorInicial: TWideStringField;
    DataProveedorFinal: TWideStringField;
    DataUnaPorHoja: TBooleanField;
    InmovilizadoTable: TnxeTable;
    LineaInmovilizadoTable: TnxeTable;
    SimulacionCtrl: TcxDBCheckBox;
    DataSimulacion: TBooleanField;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    Label3: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label8: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    Label9: TcxLabel;
    Label6: TcxLabel;
    gxRangeBox3: TgxRangeBox;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure ProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerOkButton;
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerInitializeForm;
    private

    TablaAmortizacionTable : TnxeTable;
    TablaAmortizacionFields : TTablaAmortizacionFields;

    InmovilizadoFields : TInmovilizadoFields;
    LineaInmovilizadoFields : TLineaInmovilizadoFields;

    Periodos : SmallInt;

    ValorElemento,
    AdicionesElemento,
    BajasElemento,
    AdicionesEjercicioElemento,
    BajasEjercicioElemento,
    AmortizacionAnual,
    AmortizacionAcumulada,
    ValorResidual : Decimal;

    public

    end;

var
  RptFeiForm : TRptFeiForm = nil;

procedure FichasElementosInmovilizado;


implementation

uses   EnterpriseDataAccess,

       Gim00Fields,
       Gdm10Dm,

       dm_edi,
       dm_sub,

       cx_sub,
       cx_edi;

{$R *.DFM}

procedure FichasElementosInmovilizado;
begin
     CreateReportForm( TRptFeiForm, RptFeiForm );
end;

procedure TRptFeiForm.FormManagerInitializeForm;
begin

     InmovilizadoFields := TInmovilizadoFields.Create( InmovilizadoTable );
     LineaInmovilizadoFields := TLineaInmovilizadoFields.Create( LineaInmovilizadoTable );

     DataCodigoInicial.Value := '200000000';
     DataCodigoFinal.Value := '22' + HighStrCode;
     DataProveedorInicial.Value := '400000000';
     DataProveedorFinal.Value := '40' + HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.FirstDayOfYearDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
end;

procedure TRptFeiForm.FormManagerOkButton;

procedure SeleccionaRegistros;

var   Index : SmallInt;
      CodigoActual : String;
      PrimerRegistro : Boolean;
      DiasAmortizacion : SmallInt;

begin
     try

       TablaAmortizacionTable.IndexFieldNames := 'Codigo;Ejercicio';

       With InmovilizadoTable do
         begin

         ApplicationContainer.StartProgression( RecordCount );

         case PageControl.ActivePage.TabIndex of
             0 : begin
                 IndexFieldNames := 'Codigo';
                 SetRange( [ DataCodigoInicial.Value ], [ DataCodigoFinal.Value ] );
                 end;
             1 : begin
                 IndexFieldNames := 'CodigoProveedor';
                 SetRange( [ DataProveedorInicial.Value ], [ DataProveedorFinal.Value ] );
                 end;
             2 : begin
                 IndexFieldNames := 'FechaCompra';
                 SetRange( [ DataFechaInicial.Value ], [ DataFechaFinal.Value ] );
                 end;
             end;

         First;
         While not Eof do
           begin
           Periodos  := Trunc( ( 100 / InmovilizadoFields.Tipo.Value ) + 0.9999 );

           // Si la compra no se ha realizado el primer día del ejercicio la amortización siempre ocupará un ejercicio más

           If   not ( ( DayOf( InmovilizadoFields.FechaCompra.Value )=1 ) and ( MonthOf( InmovilizadoFields.FechaCompra.Value )=ApplicationContainer.NroMesInicial ) )
           then Inc( Periodos );

           For Index := EjercicioFecha( InmovilizadoFields.FechaCompra.Value ) to EjercicioFecha( InmovilizadoFields.FechaCompra.Value ) + Periodos - 1 do
             begin
             TablaAmortizacionTable.Append;
             With TablaAmortizacionFields do
               begin
               Ejercicio.Value := Index;
               Codigo.Value := InmovilizadoFields.Codigo.Value;
               Amortizacion.Value := Saldos.SaldoPeriodo( InmovilizadoFields.CuentaAmortizacion.Value, InmovilizadoFields.CentroCoste.Value, False, Ejercicio.Value - 1, 0, ApplicationContainer.NroMesFinal ).Saldo;
               AplicadoEjercicio.Value := Saldos.SaldoPeriodo( Inmovilizado.SubcuentaDotacion( InmovilizadoFields.CuentaAmortizacion.Value ), InmovilizadoFields.CentroCoste.Value, False, Ejercicio.Value, 0, ApplicationContainer.NroMesFinal ).Saldo;
               end;
             TablaAmortizacionTable.Post;
             ApplicationContainer.ShowProgression;
             end;
           Next;
           end;

         end;


       CodigoActual := '';

       With TablaAmortizacionTable, TablaAmortizacionFields do
         begin

         InmovilizadoTable.IndexFieldNames := 'Codigo';

         First;
         While not Eof do
           begin

           If   InmovilizadoTable.FindKey( [ Codigo.Value ] )
           then begin

                If   CodigoActual<>Codigo.Value
                then begin
                     CodigoActual   := Codigo.Value;
                     PrimerRegistro := True;
                     AmortizacionAcumulada := 0.0;
                     end
                else PrimerRegistro := False;

                AdicionesElemento := 0.0;
                BajasElemento := 0.0;
                AdicionesEjercicioElemento := 0.0;
                BajasEjercicioElemento := 0.0;

                With LineaInmovilizadoTable do
                  begin
                  IndexFieldNames := 'Codigo;Fecha';
                  SetRange( [ Codigo.Value ] );
                  First;
                  While not Eof do
                    begin

                    If   EjercicioFecha( LineaInmovilizadoFields.Fecha.Value )<Ejercicio.Value      // Adiciones y bajas anteriores a este ejercicio
                    then begin
                         If   LineaInmovilizadoFields.Importe.Value>0.0
                         then DecAdd( AdicionesElemento, LineaInmovilizadoFields.Importe.Value )
                         else DecAdd( BajasElemento, Abs( LineaInmovilizadoFields.Importe.Value ) );
                         end
                    else If   EjercicioFecha( LineaInmovilizadoFields.Fecha.Value )=Ejercicio.Value  // Adiciones y bajas en este ejercicio
                         then If   LineaInmovilizadoFields.Importe.Value>0.0
                              then DecAdd( AdicionesEjercicioElemento, LineaInmovilizadoFields.Importe.Value )
                              else DecAdd( BajasEjercicioElemento, Abs( LineaInmovilizadoFields.Importe.Value ) );

                    Next;
                    end;

                  end;

                Edit; // TablaAmortizacionTable

                Importe.Value := InmovilizadoFields.Importe.Value;

                If   ( Amortizacion.Value<>0.0 ) or
                     ( AplicadoEjercicio.Value<>0.0 ) or
                     PrimerRegistro or
                     DataSimulacion.Value
                then begin
                     Valor.Value := Importe.Value + Amortizacion.Value + AdicionesElemento - BajasElemento;
                     Adiciones.Value := AdicionesEjercicioElemento;
                     Bajas.Value := BajasEjercicioElemento;
                     end;

                Tipo.Value := InmovilizadoFields.Tipo.Value;
                Descripcion.Value := Cuenta.Descripcion( Codigo.Value, False, True );
                Ubicacion.Value   := InmovilizadoFields.Ubicacion.Value;
                FechaCompra.Value  := InmovilizadoFields.FechaCompra.Value;
                CodigoProveedor.Value  := InmovilizadoFields.CodigoProveedor.Value;
                DescripcionProveedor.Value := Cuenta.Descripcion( CodigoProveedor.Value, False, True );
                SerieNroFactura.Value := InmovilizadoFields.SerieNroFactura.Value;

                If   Tipo.Value<>0
                then Periodo.Value := 100.0 / Tipo.Value
                else Periodo.Value := 0.0;

                Pendiente.Value := Valor.Value + Adiciones.Value - Bajas.Value - AplicadoEjercicio.Value;

                If   DataSimulacion.Value
                then begin

                     ValorElemento := InmovilizadoFields.Importe.Value + AdicionesElemento - BajasElemento;

                     AmortizacionAnual := Redondea( ( Tipo.Value * ValorElemento ) / 100.0 );

                     If   EjercicioFecha( FechaCompra.Value )=Ejercicio.Value
                     then begin
                          DiasAmortizacion := Trunc( EncodeDate( Ejercicio.Value, 12, 31 ) - FechaCompra.Value );
                          AmortizacionAnual := Redondea( ( AmortizacionAnual * DiasAmortizacion ) / 365.0 );
                          end;

                     Valor.Value := ValorElemento - AmortizacionAcumulada;

                     If   AmortizacionAnual>Valor.Value
                     then AmortizacionAnual := Valor.Value;

                     ValorResidual := ValorElemento - AmortizacionAcumulada - AmortizacionAnual;

                     DecAdd( AmortizacionAcumulada, AmortizacionAnual );

                     Amortizacion.Value :=  AmortizacionAcumulada;

                     AplicadoEjercicio.Value := AmortizacionAnual;
                     ValorResidual := Valor.Value - AmortizacionAnual + AdicionesEjercicioElemento - BajasEjercicioElemento;

                     If   ( Valor.Value<0.0 ) or ( Amortizacion.Value<0.0 ) 
                     then begin
                          Valor.Value := 0.0;
                          Amortizacion.Value := 0.0;
                          AplicadoEjercicio.Value := 0.0;
                          Pendiente.Value := 0.0
                          end
                     else If   ValorResidual<=0.0
                          then Pendiente.Value := 0.0
                          else Pendiente.Value := ValorResidual;

                     end;

                Post;

                ApplicationContainer.ShowProgression;
                end;

           Next;
           end;

         end;

       finally
         end;

       ApplicationContainer.EndProgression;
end;

begin

     With Report do
       try

         Load;

         TablaAmortizacionTable  := CreateEmptyTable( 'TablaAmortizacion', DataModule10.GetSQL( 'TablaAmortizacion' ) );
         TablaAmortizacionFields := TTablaAmortizacionFields.Create( TablaAmortizacionTable );

         SeleccionaRegistros;

         SetValue( RsSeleccion, PageControl.ActivePage.PageIndex );

         Start;

       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptFeiForm.ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsLinked );
end;

procedure TRptFeiForm.ProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptFeiForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaElementosInmovilizado( Sender );
end;

procedure TRptFeiForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Inmovilizado.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

end.
