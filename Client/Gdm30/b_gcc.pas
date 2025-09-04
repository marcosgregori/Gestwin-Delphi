
unit b_gcc;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     AppManager,
     Dialogs,

     Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
  DataManager, cxCurrencyEdit, cxDBEdit, cxSpinEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxGroupBox, cxRadioGroup, cxGraphics, cxIndexedComboBox, dxmdaset,

  AppContainer,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, cxLookAndFeels, cxLabel,
  cxCheckBox, dxUIAClasses;

type

  TboxGccForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    MaximoCtrl: TcxDBSpinEdit;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    CantidadMinimaCtrl: TcxDBCurrencyEdit;
    OrdenacionCtrl: TcxDBRadioGroup;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    Data: TgxMemData;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataSource: TDataSource;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataMaximo: TSmallintField;
    DataCantidadMinima: TBCDField;
    DataOrdenacion: TSmallintField;
    Label7: TcxLabel;
    Label2: TcxLabel;
    Label10: TcxLabel;
    Label4: TcxLabel;
    Label12: TcxLabel;
    Label13: TcxLabel;
    Label3: TcxLabel;
    Label5: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    UltimoPrecioCtrl: TcxDBCheckBox;
    DataUltimoPrecio: TBooleanField;
    UltimoDescuentoCtrl: TcxDBCheckBox;
    DataUltimoDescuento: TBooleanField;
    cxLabel2: TcxLabel;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private

    CarteraArticulosTable : TnxeTable;

    MovimientoFields : TMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;
    CarteraArticulosFields : TCarteraArticulosFields;
    ConsumosClienteFields : TConsumosClienteFields;
    ClienteFields : TClienteFields;
    ArticuloFields : TArticuloFields;

  protected
   class var 
     CodigoCliente  : String;
     OnSelected : TSimpleEvent;
  
  public
  
    procedure ExecuteProcess;
  end;

var
  BoxGccForm: TboxGccForm = nil;


procedure GeneraConsumos( CodigoCliente : String;
                          OnSelected    : TSimpleEvent );

implementation

{$R *.DFM}

uses   Variants,
       SysUtils,
       LibUtils,

       EnterpriseDataAccess,
       SessionDataAccess,

       Gdm00Dm,
       Gdm30Dm,

       dm_cli,
       dm_pve,

       b_msg,
       b_pro,

       cx_cli,
       f_prg;

procedure GeneraConsumos( CodigoCliente : String;
                          OnSelected    : TSimpleEvent );
begin
     TBoxGccForm.CodigoCliente := CodigoCliente;
     TBoxGccForm.OnSelected := OnSelected;
     CreateEditForm( TboxGccForm, BoxGccForm );
end;

procedure TboxGccForm.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TboxGccForm.ExecuteProcess;
begin
     Preventa.GeneraConsumos( DataClienteInicial.Value,
                              DataClienteFinal.Value,
                              DataFechaInicial.Value, 
                              DataFechaFinal.Value,
                              DataUltimoPrecio.Value,
                              DataUltimoDescuento.Value,
                              DataMaximo.Value,
                              DataCantidadMinima.Value,
                              DataOrdenacion.Value );     
                              
     If   Assigned( OnSelected )
     then OnSelected;
     
end;

procedure TboxGccForm.FormManagerInitializeForm;
begin
     
     SetEditControlDecimals( CantidadMinimaCtrl, DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value );

     If   CodigoCliente=''
     then DataClienteFinal.Value := HighStrCode
     else begin
          DataClienteInicial.Value := CodigoCliente;
          DataClienteFinal.Value := CodigoCliente;
          end;

     DataFechaInicial.Value := IncMonth( ApplicationContainer.TodayDate, -6 );
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataUltimoPrecio.Value := False;
     DataUltimodescuento.Value := False;
     DataOrdenacion.Value := 0;
     DataMaximo.Value := 20;

end;

procedure TboxGccForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TboxGccForm.ClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

end.

