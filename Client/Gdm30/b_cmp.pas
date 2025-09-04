
unit b_cmp;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics, Dialogs,

     AppManager,
     AppContainer,
     Menus, cxLookAndFeelPainters, cxGraphics, cxGroupBox,
     cxRadioGroup, cxDBEdit, cxCurrencyEdit, cxControls, cxContainer, cxEdit,
     cxTextEdit, cxMaskEdit, cxDropDownEdit, cxIndexedComboBox, cxButtons, DB,
     dxmdaset, DataManager, cxCheckBox, dxSkinsCore, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, dxUIAClasses;

type

  TBoxCmpForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataOperacion: TSmallintField;
    DataPrecioBase: TSmallintField;
    DataTipoMargen: TSmallintField;
    DataPorcentajeMargen: TBCDField;
    DataAplicarDescuento: TBooleanField;
    DataSoloPaginaActiva: TBooleanField;
    Panel1: TcxGroupBox;
    Label5: TcxLabel;
    OperacionCtrl: TcxDBRadioGroup;
    Panel2: TcxGroupBox;
    SoloPaginaActivaCtrl: TcxDBCheckBox;
    Panel4: TcxGroupBox;
    PrecioBaseCtrl: TcxDBIndexedComboBox;
    PorcentajeMargenCtrl: TcxDBCurrencyEdit;
    TipoMargenCtrl: TcxDBIndexedComboBox;
    AplicarDescuentoCtrl: TcxDBCheckBox;
    Label4: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    procedure FormManagerOkButton;
    procedure OperacionCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure FormManagerInitializeForm;
    procedure PrecioBaseCtrlPropertiesEditValueChanged(Sender: TObject);
  private

  public

    FOnSelected : TSimpleEvent;

  end;

var  BoxCmpForm: TBoxCmpForm = nil;

procedure CalculoPreciosVenta( OnSelected : TSimpleEvent );

implementation

{$R *.DFM}

uses   SysUtils,

       Gdm00Dm,
       Gdm30Dm,
       Gim00Fields,
       Gim30Fields;


procedure CalculoPreciosVenta( OnSelected : TSimpleEvent );
begin
     CreateEditForm( TBoxCmpForm, BoxCmpForm );
     If   Assigned( BoxCmpForm )
     then BoxCmpForm.FOnSelected := OnSelected;
end;

procedure TBoxCmpForm.FormManagerInitializeForm;
begin
     SetupPanelableCtrl( SoloPaginaActivaCtrl, DataModule00.PartidasPresupuestarias, True );
     SetEditControlDecimals( PorcentajeMargenCtrl );
     DataOperacion.Value := 0;
end;

procedure TBoxCmpForm.FormManagerOkButton;
begin
     If   Assigned( FOnSelected )
     then FOnSelected;
end;

procedure TBoxCmpForm.OperacionCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     PrecioBaseCtrl.Enabled := DataOperacion.Value=1;
     TipoMargenCtrl.Enabled := DataOperacion.Value=1;
     PorcentajeMargenCtrl.Enabled := DataOperacion.Value=1;
end;

procedure TBoxCmpForm.PrecioBaseCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     AplicarDescuentoCtrl.Enabled := DataPrecioBase.Value=3;
end;

end.

