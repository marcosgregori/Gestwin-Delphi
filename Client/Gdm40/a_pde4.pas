
unit a_pde4;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask,
  Controls, Classes, ExtCtrls,

  AppContainer,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  dxmdaset, cxMaskEdit, cxSpinEdit,

  Gdm40Dm, dxSkinsCore, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox,
  cxDropDownEdit, cxIndexedComboBox, dxSkinsDefaultPainters,

  Gim40Fields, cxCurrencyEdit;

type
  TMntPde4Form = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    LineaHojaCargaTable: TnxeTable;
    DataPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataSerieAlbaranesSalida: TWideStringField;
    cxGroupBox2: TcxGroupBox;
    SerieAlbaranesSalidaCtrl: TcxDBTextEdit;
    Label4: TcxLabel;
    descSerieSalidaLabel: TcxLabel;
    cxLabel2: TcxLabel;
    DocumentoHojaCargaCtrl: TcxDBIndexedComboBox;
    DataDocumentoHojaCarga: TSmallintField;
    cxGroupBox8: TcxGroupBox;
    cxLabel15: TcxLabel;
    MetodoCalculoMargenCtrl: TcxDBIndexedComboBox;
    cxLabel16: TcxLabel;
    MargenPorcentualVentaCtrl: TcxDBCurrencyEdit;
    MargenPorcentualLabel: TcxLabel;
    DataMetodoCalculoMargen: TSmallintField;
    DataMargenPorcentualVenta: TCurrencyField;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure FormManagerDestroyForm;
    procedure AlmacenCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure SerieAlbaranesSalidaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure SerieAlbaranesSalidaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure SerieAlbaranesSalidaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure DocumentoHojaCargaCtrlPropertiesChange(
      Sender: TObject);
  private

  public

  end;

var   MntPde4Form : TMntPde4Form =nil;

      ParametrosAprovisionamientoRec : TParametrosAprovisionamientoRec;
      PedidoEnOrigen : Boolean = False;

procedure MntParametros;

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,
       AppManager,

       Gim00Fields,
       Gim30Fields,
       Gdm40Frm,

       dm_pga,
       dm_alm,
       dm_cls,
       dm_sdf,

       b_msg,

       a_alm,
       a_sdf,

       cx_alm,
       cx_sdf;

resourceString
       RsMsg1  = 'El fichero de hojas de carga tiene movimientos.';
       RsMsg2  = 'No puede modificar el tipo de documento de las hojas de carga si existen movimientos.'#13'Suprima todos los registros de hoja de carga existentes y reintente la operaci�n.';

procedure MntParametros;
begin
     CreateEditForm( TMntPde4Form, MntPde4Form, Gds40Frm.PrevisionSection, True );
end;

procedure ObtenParametros;
begin
     Configuracion.ObtenParametros( ctParametrosModuloAprovisionamiento, CodigoEmpresaActual, TParametrosRec( ParametrosAprovisionamientoRec ) );
     PedidoEnOrigen := ParametrosAprovisionamientoRec.DocumentoHojaCarga=0;
end;

procedure TMntPde4Form.FormManagerInitializeForm;
begin

     CloseWindowWhenFocusLost := True;

     SetEditControlDecimals( MargenPorcentualVentaCtrl );

     ObtenParametros;

     With ParametrosAprovisionamientoRec do
       begin
       DataSerieAlbaranesSalida.Value := SerieAlbaranesSalida;
       DataDocumentoHojaCarga.Value := DocumentoHojaCarga;
       DataMetodoCalculoMargen.Value := MetodoCalculoMargen;
       DataMargenPorcentualVenta.Value := MargenPorcentualVenta;
       end;

     DocumentoHojaCargaCtrl.Enabled := LineaHojaCargaTable.RecordCount=0;

end;

procedure TMntPde4Form.FormManagerOkButton;
begin

     With ParametrosAprovisionamientoRec do
       begin
       SerieAlbaranesSalida := DataSerieAlbaranesSalida.Value;
       DocumentoHojaCarga := DataDocumentoHojaCarga.Value;
       MetodoCalculoMargen := DataMetodoCalculoMargen.Value;
       MargenPorcentualVenta := DataMargenPorcentualVenta.Value;
       end;

    Configuracion.GuardaParametros( ctParametrosModuloAprovisionamiento, CodigoEmpresaActual,  TParametrosRec( ParametrosAprovisionamientoRec ) );
end;

procedure TMntPde4Form.SerieAlbaranesSalidaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [ Sender.EditingValue ] );
end;

procedure TMntPde4Form.SerieAlbaranesSalidaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TMntPde4Form.SerieAlbaranesSalidaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntPde4Form.DocumentoHojaCargaCtrlPropertiesChange(Sender: TObject);
begin
     SerieAlbaranesSalidaCtrl.Enabled := DocumentoHojaCargaCtrl.ItemIndex=0;
end;

procedure TMntPde4Form.FormManagerDestroyForm;
begin
     Configuracion.Update;
end;

procedure TMntPde4Form.AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scVentas, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntPde4Form.AlmacenCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAlmacenes( [ Sender.Editingvalue ] );
end;

procedure TMntPde4Form.AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

initialization
     AddProcedure( imGetParamConf, 0, ObtenParametros );
end.


