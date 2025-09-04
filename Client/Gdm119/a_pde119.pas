
unit a_pde119;

interface

uses Forms, StdCtrls, Buttons, Mask,
  Controls, Classes, ExtCtrls, printers,

  AppContainer,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxGroupBox,
  cxRadioGroup, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, DB,
  DataManager, nxdb,

  dxSkinsCore, cxGraphics, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxHeader,
  dxmdaset, cxMaskEdit, cxSpinEdit, cxImage, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData, cxIndexedComboBox,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, dxGDIPlusClasses, cxCheckBox,
  cxDropDownEdit, dxBarBuiltInMenu, cxPC, dxSVGImage, dxDateRanges, AppForms,
  GridTableViewController;

type
  TMntPde119Form = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    DataSource: TDataSource;
    Data: TgxMemData;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    APIKeyCtrl: TcxDBTextEdit;
    DataHost: TStringField;
    DataNombreUsuario: TStringField;
    DataPassword: TStringField;
    cxImage1: TcxImage;
    cxGroupBox2: TcxGroupBox;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    NombreUsuarioCtrl: TcxDBTextEdit;
    PasswordCtrl: TcxDBTextEdit;
    DataAPIKey: TStringField;
    cxLabel2: TcxLabel;
    IdSocioCtrl: TcxDBTextEdit;
    DataIdSocio: TStringField;
    cxLabel5: TcxLabel;
    IdAlmacen1Ctrl: TcxDBTextEdit;
    DataIdAlmacen1: TStringField;
    ActualizarButton: TgBitBtn;
    CodigoAlmacen1Ctrl: TcxDBTextEdit;
    DescAlmacenLabel: TcxLabel;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    DataIdAlmacen2: TStringField;
    DataIdAlmacen3: TStringField;
    DataCodigoAlmacen1: TStringField;
    DataCodigoAlmacen2: TStringField;
    DataCodigoAlmacen3: TStringField;
    IdAlmacen2Ctrl: TcxDBTextEdit;
    CodigoAlmacen2Ctrl: TcxDBTextEdit;
    cxLabel9: TcxLabel;
    IdAlmacen3Ctrl: TcxDBTextEdit;
    CodigoAlmacen3Ctrl: TcxDBTextEdit;
    cxLabel10: TcxLabel;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure ActualizarButtonClick(Sender: TObject);
    procedure IdAlmacen1CtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoAlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoAlmacenCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure IdAlmacen2CtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure IdAlmacen3CtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private
      procedure ActualizaEstadoComponentes;
  protected

  public

  end;

var   MntPde119Form : TMntPde119Form = nil;

procedure MntConfiguracionAUNA;

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,

       AppManager,

       Gdm00Dm,

       Gim30Fields,

       Gdm00Frm,

       dm_pga,
       dm_reg,
       dm_alm,
       dm_sdp119,
       dm_sst119,

       cx_alm;

resourceString
       RsMsg1 = 'Se han actualizado las tablas globales de AUNA.';

procedure MntConfiguracionAUNA;
begin
     CreateEditForm( TMntPde119Form, MntPde119Form, Gds00Frm.ConfigurationSection, True );
end;

procedure TMntPde119Form.ActualizarButtonClick(Sender: TObject);
begin
     SuministroStocks.CompruebaFicherosGlobales( True );
     ShowNotification( ntInformation, RsMsg1 );
end;

procedure TMntPde119Form.CodigoAlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TMntPde119Form.CodigoAlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scAmbas, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntPde119Form.FormManagerInitializeForm;
begin

     CloseWindowWhenFocusLost := True;

     DataNombreUsuario.Value := SuministroPedidos.NombreUsuario;
     DataPassword.Value := SuministroPedidos.Password;
     DataIdSocio.Value := SuministroStocks.IdSocio;

     DataIdAlmacen1.Value := SuministroStocks.IdAlmacen[ 1 ];
     DataIdAlmacen2.Value := SuministroStocks.IdAlmacen[ 2 ];
     DataIdAlmacen3.Value := SuministroStocks.IdAlmacen[ 3 ];

     DataCodigoAlmacen1.Value := SuministroStocks.CodigoAlmacen[ 1 ];
     DataCodigoAlmacen2.Value := SuministroStocks.CodigoAlmacen[ 2 ];
     DataCodigoAlmacen3.Value := SuministroStocks.CodigoAlmacen[ 3 ];

     DataAPIKey.Value := SuministroStocks.APIKey;
end;

procedure TMntPde119Form.FormManagerOkButton;

var  I : SmallInt;

begin
     With Registro do
       begin
       ClavePadre := CodigoEmpresaActual + '.' + ncrParametrosSuministroPedidos;
       GuardaValor( ncrNombreUsuario, DataNombreUsuario.Value );
       GuardaValor( ncrPassword, DataPassword.Value );

       ClavePadre := CodigoEmpresaActual + '.' + ncrParametrosSuministroStocks;
       GuardaValor( ncrIdSocio, DataIdSocio.Value );

       GuardaValor( ncrIdAlmacen + '1', DataIdAlmacen1.Value );
       GuardaValor( ncrIdAlmacen + '2', DataIdAlmacen2.Value );
       GuardaValor( ncrIdAlmacen + '3', DataIdAlmacen3.Value );

       GuardaValor( ncrCodigoAlmacen + '1', DataCodigoAlmacen1.Value );
       GuardaValor( ncrCodigoAlmacen + '2', DataCodigoAlmacen2.Value );
       GuardaValor( ncrCodigoAlmacen + '3', DataCodigoAlmacen3.Value );

       GuardaValor( ncrAPIKey, DataAPIKey.Value );
       end;

     ActualizaParametrosSuministroStocks;
     FormManager.CloseWindow := True;
end;

procedure TMntPde119Form.IdAlmacen1CtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoAlmacen1Ctrl.Enabled := not ValueIsEmpty( DisplayValue );
     ActualizaEstadoComponentes;
end;

procedure TMntPde119Form.IdAlmacen2CtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoAlmacen2Ctrl.Enabled := not ValueIsEmpty( DisplayValue );
     ActualizaEstadoComponentes;
end;

procedure TMntPde119Form.IdAlmacen3CtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoAlmacen3Ctrl.Enabled := not ValueIsEmpty( DisplayValue );
end;

procedure TMntPde119Form.ActualizaEstadoComponentes;
begin
     IdAlmacen2Ctrl.Enabled := CodigoAlmacen1Ctrl.Enabled;
     IdAlmacen3Ctrl.Enabled := CodigoAlmacen2Ctrl.Enabled;
     ResetTab;
end;

end.

