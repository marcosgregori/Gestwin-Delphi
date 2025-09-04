
unit l_tep;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxPC, cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, dxmdaset, ReportManager,

  AppContainer,

  Gim00Fields,
  Gim10Fields, dxSkinsCore, dxSkinscxPCPainter, cxGraphics, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, cxPCdxBarPopupMenu,
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
      CodigoProveedor : TWideStringField;
      NombreProveedor : TWideStringField;
      CodigoEntidad : TWideStringField;
      NombreEntidad : TWideStringField;
      Importe1,
      Importe2,
      Importe3,
      Importe4,
      Importe5 : TBCDField;
      end;


    TRptTepForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    EfectoPagarTable: TnxeTable;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    CodigoProveedorInicialCtrl: TcxDBTextEdit;
    CodigoProveedorFinalCtrl: TcxDBTextEdit;
    TabSheet2: TcxTabSheet;
    CodigoEntidadInicialCtrl: TcxDBTextEdit;
    CodigoEntidadFinalCtrl: TcxDBTextEdit;
    Report: TgxReportManager;
    DataSource: TDataSource;
    Data: TgxMemData;
    gxRangeBox2: TgxRangeBox;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataProveedorInicial: TWideStringField;
    DataProveedorFinal: TWideStringField;
    DataEntidadInicial: TWideStringField;
    DataEntidadFinal: TWideStringField;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox3: TgxRangeBox;
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
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure SubcuentaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SubuentaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    private

    public

      EfectoPagarFields : TEfectoPagarFields;
      AsientoFields : TAsientoFields;
      ConsultaTable : TnxeTable;
      ConsultaFields : TConsultaFields;
    end;

var  RptTepForm : TRptTepForm = nil;

procedure TablaEfectosPagar;


implementation

uses   DateUtils,
       EnterpriseDataAccess,

       dmi_ast,

       b_msg,

       dm_sub,
       dm_ecp,
       dm_sec,
       dm_ast,

       cx_sub;

{$R *.dfm}

procedure TablaEfectosPagar;
begin
     CreateReportForm( TRptTepForm, RptTepForm );
end;

procedure TRptTepForm.InitializeForm;
begin
     EfectoPagarFields := TEfectoPagarFields.Create( EfectoPagarTable );
     AsientoFields := TAsientoFields.Create( Self );

     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataProveedorInicial.Value := '400000000';
     DataProveedorFinal.Value := '4' + HighStrCode;
     DataEntidadInicial.Value := '570000000';
     DataEntidadFinal.Value := '57' + HighStrCode;
end;

procedure TRptTepForm.FormManagerOkButton;

type TPeriodo = record
       Ejercicio,
       Mes : Word;
       end;

var  Periodo : array[ 1..4 ] of TPeriodo;
     Index,
     MesActual,
     EjercicioActual : Word;

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

     With EfectoPagarTable do
       begin

       SetRange( [ DataFechaInicial.Value ], [ DataFechaFinal.Value ] );

       ApplicationContainer.StartProgression( RecordCount );

       First;
       While not Eof  do
         begin

         ApplicationContainer.ShowProgression;

         If   ( ( PageControl.ActivePageIndex=0 ) and
                ( ( AnsiCompareStr( EfectoPagarFields.SubcuentaProveedor.Value, DataProveedorInicial.Value )>=0 ) and ( AnsiCompareStr( EfectoPagarFields.SubcuentaProveedor.Value, DataProveedorFinal.Value )<=0 ) ) ) or
              ( ( PageControl.ActivePageIndex=1 ) and
                ( ( AnsiCompareStr( EfectoPagarFields.SubcuentaEntidad.Value, DataEntidadInicial.Value )>=0 ) and ( AnsiCompareStr( EfectoPagarFields.SubcuentaEntidad.Value, DataEntidadFinal.Value )<=0 ) ) )
         then If   EfectoPagar.EfectoPendiente( EfectoPagarFields )
              then begin

                   ConsultaTable.Append;

                   With EfectoPagarFields do
                     begin

                     ConsultaFields.Ejercicio.Value := Ejercicio.Value;
                     ConsultaFields.Serie.Value := Serie.Value;
                     ConsultaFields.NroFactura.Value := NroFactura.Value;
                     ConsultaFields.NroEfecto.Value := NroEfecto.Value;
                     ConsultaFields.FechaVencimiento.Value := FechaVencimiento.Value ;
                     ConsultaFields.NroFactura.Value := NroFactura.Value;

                     //* 13.06.2005  Obtención del nº de documento

                     If   Asiento.ObtenDocumento( taFraRecibida, Ejercicio.Value, SubcuentaProveedor.Value, Serie.Value, NroFactura.Value, NroEfectoRegistroFactura, AsientoFields )
                     then begin
                          ConsultaFields.EjercicioAsiento.Value := AsientoFields.Ejercicio.Value;
                          ConsultaFields.NroAsiento.Value := AsientoFields.NroAsiento.Value;
                          end;

                     ConsultaFields.CodigoProveedor.Value := SubcuentaProveedor.Value;
                     ConsultaFields.NombreProveedor.Value := Cuenta.Descripcion( SubcuentaProveedor.Value, True, True );
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
         SetValue( RsSeleccion, PageControl.ActivePageIndex );

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

procedure TRptTepForm.SubcuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender );
end;

procedure TRptTepForm.SubuentaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorTExt, Error, nil, True );
end;

end.
