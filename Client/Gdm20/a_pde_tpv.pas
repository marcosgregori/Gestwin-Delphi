
unit a_pde_tpv;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask,
  Controls, Classes, ExtCtrls, printers,

  AppContainer, Tabs, ComCtrls, Menus, cxLookAndFeelPainters,
  cxButtons, cxGraphics, cxCurrencyEdit, cxDBEdit, cxGroupBox,
  cxRadioGroup, cxCheckBox, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxIndexedComboBox, cxPC, cxControls, DB, nxdb, DataManager,
  dxmdaset, cxSpinEdit, dxUIAClasses,

  Gim00Fields,
  Gim30Fields,
  Gdm20Dm,

  dxSkinsCore,
  dxSkinsDefaultPainters,
  dxSkinscxPCPainter,
  cxLookAndFeels,
  cxLabel,
  cxPCdxBarPopupMenu,
  dxBarBuiltInMenu;

type
  TBoxPdeTPVForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    PageControl1: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    TabSheet3: TcxTabSheet;
    TabSheet4: TcxTabSheet;
    InsAutAlbaranesCtrl: TcxDBRadioGroup;
    ModeloVisorCtrl: TcxDBIndexedComboBox;
    ImpresoraCtrl: TcxDBComboBox;
    InicializarPuertoCtrl: TcxDBCheckBox;
    TextoVisor1Ctrl: TcxDBTextEdit;
    TextoVisor2Ctrl: TcxDBTextEdit;
    ModeloCajonCtrl: TcxDBIndexedComboBox;
    PuertoCOMCajonCtrl: TcxDBIndexedComboBox;
    DocumentoArqueoCtrl: TcxDBRadioGroup;
    SaldoInicialCajaCtrl: TcxDBCurrencyEdit;
    EdicionPedidosCtrl: TcxDBCheckBox;
    ConfiguracionTable: TnxeTable;
    DataSource: TDataSource;
    ConfiguracionTableAplicacion: TSmallintField;
    ConfiguracionTableTipo: TSmallintField;
    ConfiguracionTableCodigo: TWideStringField;
    ConfiguracionTableData: TBlobField;
    Data: TgxMemData;
    DataEdicionPedidos: TBooleanField;
    DataInsAutAlbaranes: TSmallintField;
    DataPuertoCOMVisor: TSmallintField;
    DataModeloVisor: TSmallintField;
    DataImpresoraVisor: TWideStringField;
    DataInicializarPuerto: TBooleanField;
    DataPuertoCOMCajon: TSmallintField;
    DataModeloCajon: TSmallintField;
    DataDocumentoArqueo: TSmallintField;
    DataSaldoInicialCaja: TBCDField;
    DataTextoVisor1: TWideStringField;
    DataTextoVisor2: TWideStringField;
    Label5: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label9: TcxLabel;
    Label12: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label11: TcxLabel;
    Label13: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    PuertoCOMVisorCtrl: TcxDBSpinEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    UsarVisorCtrl: TcxDBCheckBox;
    DataUsarVisor: TBooleanField;
    VisorPanel: TcxGroupBox;
    procedure FormManagerOkButton;
    procedure FormManagerDestroyForm;
    procedure FormManagerInitializeForm;
    procedure puertoCOMVisorCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure InicializarPuertoCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure PuertoCOMCajonCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure cxDBCheckBox1PropertiesEditValueChanged(Sender: TObject);
  private

    ConfiguracionAppFields : TConfiguracionFields;
    ParametrosTPVRec : TParametrosTPVRec;
    RecordExists : Boolean;

  protected
    class procedure ConfiguracionTPV( Sender : TObject );

  public

  end;

var  BoxPdeTPVForm : TBoxPdeTPVForm =nil;

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,
       dxBar,

       AppManager,
       EnterpriseDataAccess,

       Gdm30Dm,

       Gdm00Frm,

       dm_pga,

       b_msg;


class procedure TBoxPdeTPVForm.ConfiguracionTPV( Sender : TObject);
begin
     CreateEditForm( TBoxPdeTPVForm, BoxPdeTPVForm, Gds00Frm.ConfigurationSection, True );
end;

procedure TBoxPdeTPVForm.FormManagerOkButton;
begin

     With ParametrosTPVRec do
       begin
       InsAutAlbaranes := DataInsAutAlbaranes.Value;
       EdicionPedidos := DataEdicionPedidos.Value;
       UsarVisor := DataUsarVisor.Value;
       PuertoCOMVisor := DataPuertoCOMVisor.Value;
       ModeloVisor := DataModeloVisor.Value;
       InicializarPuerto := DataInicializarPuerto.Value;
       ImpresoraVisor := DataImpresoraVisor.Value;
       PuertoCOMCajon := DataPuertoCOMCajon.Value;
       ModeloCajon := DataModeloCajon.Value;
       DocumentoArqueo := DataDocumentoArqueo.Value;
       TextoVisor1 := DataTextoVisor1.Value;
       TextoVisor2 := DataTextoVisor2.Value;
       SaldoInicialCaja  := DataSaldoInicialCaja.Value;
       end;

     With ConfiguracionTable do
       begin
       WriteMemoBuffer( ConfiguracionTableData, ParametrosTPVRec, SizeOf( ParametrosTPVRec ) );
       Post;
       end;

     FormManager.CloseWindow := True;
end;

procedure TBoxPdeTPVForm.InicializarPuertoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ImpresoraCtrl.Enabled := DataInicializarPuerto.Value;
end;

procedure TBoxPdeTPVForm.PuertoCOMCajonCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ModeloCajonCtrl.Enabled := DataPuertoCOMCajon.Value<>0;
end;

procedure TBoxPdeTPVForm.puertoCOMVisorCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ModeloVisorCtrl.Enabled := DataPuertoCOMVisor.Value<>0;
end;

procedure TBoxPdeTPVForm.cxDBCheckBox1PropertiesEditValueChanged(Sender: TObject);
begin
     SetGroupBoxControlsEnabled( VisorPanel, UsarVisorCtrl.Checked );
end;

procedure TBoxPdeTPVForm.FormManagerDestroyForm;
begin
     Configuracion.Update;
end;

procedure TBoxPdeTPVForm.FormManagerInitializeForm;

var   Inx : SmallInt;

begin
     With ConfiguracionTable do
       begin

       RecordExists := FindKey( [ ProgramNumber, ctTPV, CodigoEmpresaActual ] );
       If   RecordExists
       then begin
            Edit;
            ReadMemoBuffer( ConfiguracionTableData, ParametrosTPVRec, SizeOf( ParametrosTPVRec ) );
            end
       else begin
            Append;
            ConfiguracionTableAplicacion.Value := ProgramNumber;
            ConfiguracionTableTipo.Value := ctTPV;
            ConfiguracionTableCodigo.Value := CodigoEmpresaActual;
            FillChar( ParametrosTPVRec, SizeOf( ParametrosTPVRec ), #0 );
            end;

       With ParametrosTPVRec do
         begin
         DataInsAutAlbaranes.Value := InsAutAlbaranes;
         DataEdicionPedidos.Value := EdicionPedidos;
         DataUsarVisor.Value := UsarVisor;
         DataPuertoCOMVisor.Value := PuertoCOMVisor;
         DataModeloVisor.Value := ModeloVisor;
         DataInicializarPuerto.Value := InicializarPuerto;
         DataImpresoraVisor.Value := ImpresoraVisor;
         DataPuertoCOMCajon.Value := PuertoCOMCajon;
         DataModeloCajon.Value := ModeloCajon;
         DataDocumentoArqueo.Value := DocumentoArqueo;
         DataTextoVisor1.Value := TextoVisor1;
         DataTextoVisor2.Value := TextoVisor2;
         DataSaldoInicialCaja.Value := SaldoInicialCaja;
         end;

       end;

     SetEditControlDecimals( SaldoInicialCajaCtrl );

     If   DataPuertoCOMVisor.Value=0
     then DataUsarVisor.Value := False;

     With Printer do
       For Inx := 0 to Printers.Count - 1 do
         ImpresoraCtrl.Properties.Items.Add( Printers[ Inx ] );

end;

procedure ObtenParametros;
begin
     Configuracion.ObtenParametros( ctTPV, CodigoEmpresaActual, TParametrosRec( ParametrosTPVRec ) );
end;

procedure SetupUnit;
begin
     If   Assigned( Gds00Frm )
     then With Gds00Frm do
            begin
            ConfiguracionTPVItem.Visible := ivAlways;
            ConfiguracionTPVItem.OnClick := TBoxPdeTPVForm.ConfiguracionTPV;
            end;
end;

initialization
     AddProcedure( imStartUp, 0, SetupUnit );
     AddProcedure( imGetParamConf, 0, ObtenParametros );

end.

