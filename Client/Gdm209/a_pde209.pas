
unit a_pde209;

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
  GridTableViewController, dxScrollbarAnnotations, cxButtonEdit,
  System.ImageList, Vcl.ImgList, cxImageList, dxUIAClasses;

type
  TMntPde209Form = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    DataSource: TDataSource;
    Data: TgxMemData;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    GrupoClienteDataSource: TDataSource;
    GrupoClienteData: TnxeTable;
    GrupoClienteDataNroLinea: TSmallintField;
    GrupoClienteDataCodigoTarifa: TWideStringField;
    GrupoClienteDataDescripcion: TWideStringField;
    cxLabel7: TcxLabel;
    DataFormatoImagenes: TStringField;
    FormatoImagenesCtrl: TcxDBComboBox;
    GrupoClienteDataConIVAIncluido: TBooleanField;
    GrupoClienteDataNombre: TStringField;
    CamposLibresComoAtributosCtrl: TcxDBCheckBox;
    DataCamposLibresComoAtributos: TBooleanField;
    DataNombreAtributo1: TStringField;
    DataPreciosConIVAIncluido: TBooleanField;
    PreciosConIVAIncluidoCtrl: TcxDBCheckBox;
    NoPublicarArticulosSinPrecioCtrl: TcxDBCheckBox;
    DataNoPublicarArticulosSinPrecio: TBooleanField;
    GrupoClienteDataModeloImpositivo: TSmallintField;
    GrupoClienteDataSerieFacturacion: TWideStringField;
    PreciosConDescuentoPrevioCtrl: TcxDBCheckBox;
    DataPreciosConDescuentoPrevio: TBooleanField;
    PublicarClasesComoVariantesCtrl: TcxDBCheckBox;
    DataPublicarClasesComoVariantes: TBooleanField;
    PublicarArticulosSinExistenciasCtrl: TcxDBCheckBox;
    DataPublicarArticulosSinExistencias: TBooleanField;
    cxGroupBox2: TcxGroupBox;
    NoIncluirPendienteRecibirCtrl: TcxDBCheckBox;
    DataNoIncluirPendienteRecibir: TBooleanField;
    cxGroupBox3: TcxGroupBox;
    cxGroupBox4: TcxGroupBox;
    ExistenciasVirtualesCtrl: TcxDBCheckBox;
    cxDBCheckBox2: TcxDBCheckBox;
    ArticulosPorTarifaCtrl: TcxDBCheckBox;
    DataArticulosPorTarifa: TBooleanField;
    DataExistenciasVirtuales: TBooleanField;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
  private


  protected

  public

  end;

var   MntPde209Form : TMntPde209Form = nil;

procedure MntConfiguracionPedidosOnline;

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,

       AppManager,

       Gdm00Dm,

       Gim30Fields,

       Gdm00Frm,

       f_cnf209,

       dmi_iva,
       dmi_cpo,

       dm_pga,
       dm_reg,
       dm_alm,

       cx_alm,

       b_dir;

resourceString
     RsMsg1 = '';

procedure MntConfiguracionPedidosOnline;
begin
     CreateEditForm( TMntPde209Form, MntPde209Form, Gds00Frm.ConfigurationSection, True );
end;

procedure TMntPde209Form.FormManagerOkButton;

var  I : SmallInt;

begin

     With Registro do
       begin

       ClavePadre := CodigoEmpresaActual + '.' + ncpParametrosPedidosOnline;

       GuardaValor( ncpFormatoImagenes, DataFormatoImagenes.Value );
       GuardaValor( ncpPublicarArticulosSinExistencias, BoolToStr( DataPublicarArticulosSinExistencias.Value ) );
       GuardaValor( ncpExistenciasVirtuales, BoolToStr( DataExistenciasVirtuales.Value ) );
       GuardaValor( ncpNoIncluirPendienteRecibir, BoolToStr( DataNoIncluirPendienteRecibir.Value ) );
       GuardaValor( ncpPreciosConDescuentoPrevio, BoolToStr( DataPreciosConDescuentoPrevio.Value ) );
       GuardaValor( ncpCamposLibresComoAtributos, BoolToStr( DataCamposLibresComoAtributos.Value ) );
       GuardaValor( ncpNombreAtributo1, DataNombreAtributo1.Value );
       GuardaValor( ncpPreciosConIVAIncluido, BoolToStr( DataPreciosConIVAIncluido.Value ) );
       GuardaValor( ncpPublicarClasesComoVariantes, BoolToStr( DataPublicarClasesComoVariantes.Value ) );
       GuardaValor( ncpArticulosPorTarifa, BoolToStr( DataArticulosPorTarifa.Value ) );

       end;

     FormManager.CloseWindow := True;
end;

procedure TMntPde209Form.FormManagerInitializeForm;

var  I : SmallInt;
     IdGrupoValue : String;

begin

     CloseWindowWhenFocusLost := True;

     PublicarClasesComoVariantesCtrl.Enabled := DataModule00.DmEmpresaFields.Articulo_ExisteClase[ 1 ].Value;
     
     // Artículos

     With Registro do
       begin

       DataFormatoImagenes.Value := ObtenValorString( ncpFormatoImagenes );
       DataNoPublicarArticulosSinPrecio.Value := ObtenValorBool( ncpNoPublicarArticulosSinPrecio );
       DataPublicarArticulosSinExistencias.Value := ObtenValorBool( ncpPublicarArticulosSinExistencias );
       DataExistenciasVirtuales.Value := ObtenValorBool( ncpExistenciasVirtuales );
       DataNoIncluirPendienteRecibir.Value := ObtenValorBool( ncpNoIncluirPendienteRecibir );
       DataPreciosConDescuentoPrevio.Value := ObtenValorBool( ncpPreciosConDescuentoPrevio );
       DataCamposLibresComoAtributos.Value := ObtenValorBool( ncpCamposLibresComoAtributos );
       DataNombreAtributo1.Value := ObtenValorString( ncpNombreAtributo1 );
       DataPreciosConIVAIncluido.Value := ObtenValorBool( ncpPreciosConIVAIncluido );
       DataPublicarClasesComoVariantes.Value := ObtenValorBool( ncpPublicarClasesComoVariantes );
       DataArticulosPorTarifa.Value := ObtenValorBool( ncpArticulosPorTarifa );

       If   DataFormatoImagenes.Value=''
       then DataFormatoImagenes.Value := 'png';

       end;

     Data.Modified := False;
end;

end.

