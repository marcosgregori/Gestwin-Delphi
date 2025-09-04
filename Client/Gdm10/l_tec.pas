
unit l_tec;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxPC, cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, dxmdaset, ReportManager,

  AppContainer,

  Gim00Fields,
  Gim10Fields, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox, cxPCdxBarPopupMenu,
  dxBarBuiltInMenu;


type
    TConsultaFields = class( TnxeDatasetFields)
      Ejercicio : TSmallIntField;
      Serie : TWideStringField;
      NroFactura : TIntegerField;
      NroEfecto : TSmallIntField;
      FechaVencimiento : TDateField;
      EjercicioAsiento : TSmallIntField;
      NroAsiento : TIntegerField;
      CodigoCliente : TWideStringField;
      NombreCliente : TWideStringField;
      CodigoEntidad : TWideStringField;
      NombreEntidad : TWideStringField;
      Importe1,
      Importe2,
      Importe3,
      Importe4,
      Importe5 : TBCDField;
      end;


    TRptTecForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    EfectoCobrarTable: TnxeTable;
    SerieInicialCtrl: TcxDBTextEdit;
    SerieFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    CodigoClienteInicialCtrl: TcxDBTextEdit;
    CodigoClienteFinalCtrl: TcxDBTextEdit;
    TabSheet2: TcxTabSheet;
    CodigoEntidadInicialCtrl: TcxDBTextEdit;
    CodigoEntidadFinalCtrl: TcxDBTextEdit;
    Report: TgxReportManager;
    DataSource: TDataSource;
    Data: TgxMemData;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    DataSerieInicial: TWideStringField;
    DataSerieFinal: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataEntidadInicial: TWideStringField;
    DataEntidadFinal: TWideStringField;
    gxRangeBox3: TgxRangeBox;
    gxRangeBox4: TgxRangeBox;
    Label6: TcxLabel;
    Label4: TcxLabel;
    Label3: TcxLabel;
    Label1: TcxLabel;
    Label11: TcxLabel;
    Label2: TcxLabel;
    Label8: TcxLabel;
    Label5: TcxLabel;
    Label7: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure SubcuentaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SubuentaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure SeriePropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SeriePropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

      EfectoCobrarFields : TEfectoCobrarFields;
      AsientoFields : TAsientoFields;
      ConsultaTable : TnxeTable;
      ConsultaFields : TConsultaFields;
    end;

var  RptTecForm : TRptTecForm = nil;

procedure TablaEfectosCobrar;


implementation

uses   DateUtils,
       EnterpriseDataAccess,

       b_msg,

       dmi_ast,

       dm_sub,
       dm_ecc,
       dm_sec,
       dm_ast,
       dm_sdf,

       cx_sub,
       cx_sdf;

{$R *.dfm}

procedure TablaEfectosCobrar;
begin
     CreateReportForm( TRptTecForm, RptTecForm );
end;

procedure TRptTecForm.InitializeForm;
begin
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );
     AsientoFields := TAsientoFields.Create( Self );

     DataSerieFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataClienteInicial.Value := '430000000';
     DataClienteFinal.Value := '43' + HighStrCode;
     DataEntidadInicial.Value := '570000000';
     DataEntidadFinal.Value := '57' + HighStrCode;
end;

procedure TRptTecForm.FormManagerOkButton;

type TPeriodo = record
       Ejercicio,
       Mes : SmallInt;
       end;

var  Periodo : array[ 1..4 ] of TPeriodo;
     Index,
     MesActual,
     EjercicioActual : SmallInt;

procedure seleccionaRegistros;
begin

    FillChar( Periodo, SizeOf( Periodo ), #0 );

     MesActual := MonthOf( DataFechaInicial.Value );
     EjercicioActual := YearOf( DataFechaInicial.Value );
     Index := 1;
     repeat

       Periodo[ Index ].Mes := MesActual;
       Periodo[ Index ].Ejercicio := EjercicioActual;

       Inc( MesActual );
       If   MesActual=13
       then begin
            MesActual := 1;
            Inc( EjercicioActual );
            end;

       Inc( Index );

     until Index=5;

     With EfectoCobrarTable do
       begin

       SetRange( [ DataFechaInicial.Value ], [ DataFechaFinal.Value ] );

       ApplicationContainer.StartProgression( RecordCount );

       First;
       While not Eof  do
         begin

         ApplicationContainer.ShowProgression;

         If   ( EfectoCobrarFields.Serie.Value>=DataSerieInicial.Value ) and
              ( EfectoCobrarFields.Serie.Value<=DataSerieFinal.Value ) and
              ( ( ( PageControl.ActivePageIndex=0 ) and
                ( ( AnsiCompareStr( EfectoCobrarFields.SubcuentaCliente.Value, DataClienteInicial.Value )>=0 ) and ( AnsiCompareStr( EfectoCobrarFields.SubcuentaCliente.Value, DataClienteFinal.Value )<=0 ) ) ) or
                ( ( PageControl.ActivePageIndex=1 ) and
                ( ( AnsiCompareStr( EfectoCobrarFields.SubcuentaEntidad.Value, DataEntidadInicial.Value )>=0 ) and ( AnsiCompareStr( EfectoCobrarFields.SubcuentaEntidad.Value, DataEntidadFinal.Value )<=0 ) ) ) )

         then If   EfectoCobrar.EfectoPendiente( EfectoCobrarFields )
              then begin

                   ConsultaTable.Append;

                   With EfectoCobrarFields do
                     begin

                     ConsultaFields.Ejercicio.Value := Ejercicio.Value;
                     ConsultaFields.Serie.Value := Serie.Value;
                     ConsultaFields.NroFactura.Value := NroFactura.Value;
                     ConsultaFields.NroEfecto.Value := NroEfecto.Value;
                     ConsultaFields.FechaVencimiento.Value := FechaVencimiento.Value ;
                     ConsultaFields.NroFactura.Value := NroFactura.Value;

                     //* 13.06.2005  Obtención del nº de documento

                     If   Asiento.ObtenDocumento( taFraEmitida, Ejercicio.Value, SubcuentaCliente.Value, Serie.Value, NroFactura.Value, NroEfectoRegistroFactura, AsientoFields )
                     then begin
                          ConsultaFields.EjercicioAsiento.Value := AsientoFields.Ejercicio.Value;
                          ConsultaFields.NroAsiento.Value := AsientoFields.NroAsiento.Value;
                          end;

                     ConsultaFields.CodigoCliente.Value := SubcuentaCliente.Value;
                     ConsultaFields.NombreCliente.Value := Cuenta.Descripcion( SubcuentaCliente.Value, True, True );
                     ConsultaFields.CodigoEntidad.Value := SubcuentaEntidad.Value;
                     ConsultaFields.NombreEntidad.Value := Cuenta.Descripcion( SubcuentaEntidad.Value, True, True );

                     If   ( MonthOf( FechaVencimiento.Value )=Periodo[ 1 ].Mes ) and
                          ( YearOf( FechaVencimiento.Value )=Periodo[ 1 ].Ejercicio )
                     then ConsultaFields.Importe1.Value := Importe.Value
                     else If   ( MonthOf( FechaVencimiento.Value )=Periodo[ 2 ].Mes ) and
                               ( YearOf( FechaVencimiento.Value )=Periodo[ 2 ].Ejercicio )
                          then ConsultaFields.Importe2.Value := Importe.Value
                          else If   ( MonthOf( FechaVencimiento.Value )=Periodo[ 3 ].Mes ) and
                                    ( YearOf( FechaVencimiento.Value )=Periodo[ 3 ].Ejercicio )
                               then ConsultaFields.Importe3.Value := Importe.Value
                               else If   ( MonthOf( FechaVencimiento.Value )=Periodo[ 4 ].Mes ) and
                                         ( YearOf( FechaVencimiento.Value )=Periodo[ 4 ].Ejercicio )
                                    then ConsultaFields.Importe4.Value := Importe.Value
                                    else ConsultaFields.Importe5.Value := Importe.Value;

                     end;

                   ConsultaTable.Post;

                   end;

         Next;
         end;

       end;

     ApplicationContainer.EndProgression;

end;

begin
     Enabled := False;
     With Report do
       try
         Load;
         ConsultaTable := CreateEmptyTable( 'Consulta', SQLSet.GetSQLText( 'Consulta' ) );
         ConsultaFields := TConsultaFields.Create( ConsultaTable );
         SeleccionaRegistros;
         SetValueFields( Data );
         SetValue( rsSeleccion, PageControl.ActivePageIndex );

         SetValue( 'CabeceraMes1', StrMonth( Periodo[ 1 ].Mes ) );
         SetValue( 'CabeceraMes2', StrMonth( Periodo[ 2 ].Mes ) );
         SetValue( 'CabeceraMes3', StrMonth( Periodo[ 3 ].Mes ) );
         SetValue( 'CabeceraMes4', StrMonth( Periodo[ 4 ].Mes ) );

         If   PageControl.ActivePageIndex=0
         then ConsultaTable.IndexName := 'Index0'
         else ConsultaTable.IndexName := 'Index1';

         Start;

       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptTecForm.SeriePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TRptTecForm.SeriePropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptTecForm.SubcuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender );
end;

procedure TRptTecForm.SubuentaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorTExt, Error, nil, True );
end;

end.
