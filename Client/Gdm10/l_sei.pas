
unit l_sei;

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
    TRptSeiForm = class(TgxForm)
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
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataProveedorInicial: TWideStringField;
    DataProveedorFinal: TWideStringField;
    InmovilizadoTable: TnxeTable;
    LineaInmovilizadoTable: TnxeTable;
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
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    gxRangeBox3: TgxRangeBox;
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

    InmovilizadoFields : TInmovilizadoFields;
    LineaInmovilizadoFields : TLineaInmovilizadoFields;
    TablaAmortizacionTable : TnxeTable;
    TablaAmortizacionFields : TTablaAmortizacionFields;

    PrecioCompra,
    ValorElemento,
    Amortizacion,
    AplicadoEjercicio : Decimal;

    public

    end;

var
  RptSeiForm : TRptSeiForm = nil;

procedure ListadoSituacionElementos;


implementation

uses   EnterpriseDataAccess,

       Gdm10Dm,
       Gim00Fields,

       dm_edi,
       dm_sub,

       cx_sub,
       cx_edi;

{$R *.DFM}

procedure ListadoSituacionElementos;
begin
     CreateReportForm( TRptSeiForm, RptSeiForm );
end;

procedure TRptSeiForm.FormManagerInitializeForm;
begin
     InmovilizadoFields := TInmovilizadoFields.Create( InmovilizadoTable );
     LineaInmovilizadoFields := TLineaInmovilizadoFields.Create( LineaInmovilizadoTable );

     DataCodigoInicial.Value    := '210000000';
     DataCodigoFinal.Value      := '22' + HighStrCode;
     DataProveedorInicial.Value := '400000000';
     DataProveedorFinal.Value   := '40' + HighStrCode;
     DataFechaInicial.Value     := ApplicationContainer.FirstDayOfYearDate;
     DataFechaFinal.Value       := ApplicationContainer.TodayDate;
end;

procedure TRptSeiForm.FormManagerOkButton;

procedure SeleccionaRegistros;
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
         While not Eof  do
           begin

           PrecioCompra := InmovilizadoFields.Importe.Value;

           ValorElemento := PrecioCompra;

           With LineaInmovilizadoTable do
             begin
             SetRange( [ InmovilizadoFields.Codigo.Value ] );
             First;
             While not Eof do
               begin
               DecAdd( ValorElemento, LineaInmovilizadoFields.Importe.Value );
               Next;
               end;
             end;

           Saldos.SaldoPeriodo( InmovilizadoFields.CuentaAmortizacion.Value, InmovilizadoFields.CentroCoste.Value, False, ApplicationContainer.Ejercicio, 0, 13 );
           Amortizacion := -Saldos.SaldoPeriodo( InmovilizadoFields.CuentaAmortizacion.Value, InmovilizadoFields.CentroCoste.Value, False, ApplicationContainer.Ejercicio, 0, ApplicationContainer.NroMesFinal ).Saldo;
           AplicadoEjercicio := Saldos.SaldoPeriodo( Inmovilizado.SubcuentaDotacion( InmovilizadoFields.CuentaAmortizacion.Value ), InmovilizadoFields.CentroCoste.Value, False, ApplicationContainer.Ejercicio, 0, ApplicationContainer.NroMesFinal ).Saldo;

           TablaAmortizacionTable.Append;

           TablaAmortizacionFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
           TablaAmortizacionFields.Codigo.Value := InmovilizadoFields.Codigo.Value;
           TablaAmortizacionFields.Descripcion.Value := Cuenta.Descripcion( InmovilizadoFields.Codigo.Value, False, False );
           TablaAmortizacionFields.FechaCompra.Value := InmovilizadoFields.FechaCompra.Value;
           TablaAmortizacionFields.Importe.Value := PrecioCompra;
           TablaAmortizacionFields.Valor.Value := ValorElemento;
           TablaAmortizacionFields.Amortizacion.Value := Amortizacion;
           TablaAmortizacionFields.AplicadoEjercicio.Value := AplicadoEjercicio;

           TablaAmortizacionTable.Post;
           
           ApplicationContainer.ShowProgression;

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

         SetValue( rsSeleccion, PageControl.ActivePage.PageIndex );

         Start;

       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptSeiForm.ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsLinked );
end;

procedure TRptSeiForm.ProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptSeiForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaElementosInmovilizado( Sender );
end;

procedure TRptSeiForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Inmovilizado.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

end.
