unit a_tas;

interface

uses Grids, StdCtrls, Buttons, Mask, Controls, Forms,
     Classes, ExtCtrls,

     AppContainer,
     ComCtrls,
     Tabs, Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox,
  cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, DB, nxdb,
  DataManager, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
  cxCurrencyEdit, dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, cxNavigator, cxMaskEdit,
  cxSpinEdit, dxDateRanges,

  AppForms,
  GridTableViewController, dxScrollbarAnnotations, dxUIAClasses;

type
  TMntTasForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    NroRegistroCtrl: TcxDBSpinEdit;
    DataPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    Panel1: TcxGroupBox;
    DescripcionCtrl: TcxDBTextEdit;
    DocumentoCtrl: TcxDBCheckBox;
    RegistroCtrl: TcxDBCheckBox;
    GridTableViewController: TGridTableViewController;
    TipoAsientoTable: TnxeTable;
    TipoAsientoDataSource: TDataSource;
    LineaTipoAsientoQuery: TnxeQuery;
    LineaTipoAsientoDataSource: TDataSource;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    GridViewSubcuenta: TcxGridDBColumn;
    GridViewCtroCoste: TcxGridDBColumn;
    GridViewContrapartida: TcxGridDBColumn;
    GridViewConcepto: TcxGridDBColumn;
    GridViewDH: TcxGridDBColumn;
    GridViewImporte: TcxGridDBColumn;
    TipoAsientoTableNroRegistro: TSmallintField;
    TipoAsientoTableDescripcion: TWideStringField;
    TipoAsientoTableDocumento: TBooleanField;
    TipoAsientoTableRegistro: TBooleanField;
    LineaTipoAsientoQueryNroRegistro: TSmallintField;
    LineaTipoAsientoQueryNroLinea: TSmallintField;
    LineaTipoAsientoQuerySubcuenta: TWideStringField;
    LineaTipoAsientoQueryCtroCoste: TWideStringField;
    LineaTipoAsientoQueryContrapartida: TWideStringField;
    LineaTipoAsientoQueryConcepto: TWideStringField;
    LineaTipoAsientoQueryDH: TWideStringField;
    LineaTipoAsientoQueryImporte: TBCDField;
    CaptionCodigoLabel: TcxLabel;
    Label1: TcxLabel;
    procedure TipoAsientoTableNewRecord(DataSet: TDataSet);
    procedure NroRegistroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure LineaTipoAsientoQueryNewRecord(DataSet: TDataSet);
    procedure GridViewConceptoPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewConceptoPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure GridViewDHPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewConceptoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewCtroCostePropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewSubcuentaPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCtroCostePropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewSubcuentaPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerInitializeForm;
    procedure NroRegistroCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure TipoAsientoTableUpdateState(DataSet: TDataSet);
    procedure GridViewCtroCostePropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewSubcuentaPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);

  private
  public

  end;

var MntTasForm: TMntTasForm = nil;

procedure MntAsientosTipo( keyValues : array of const );

implementation

{$R *.DFM}

uses   Windows,
       SysUtils,
       LibUtils,
       Variants,
       
       EnterpriseDataAccess,

       Gim00Fields,
       Gim10Fields,

       Gdm00Dm,
       Gdm10Frm,

       dm_con,
       dm_tas,
       dm_cco,
       dm_sub,

       b_msg,

       a_sub,
       a_con,
       a_cco,

       cx_tas,
       cx_con,
       cx_sub,
       cx_cco,

       l_tas;

resourceString
    RsMsg1  = 'Este código de concepto de apunte no existe.';
    RsMsg3  = 'El código debe ser mayor o igual a 20.';
    RsMsg4  = 'Los tipos de asiento comprendidos entre 1 y 19 ya han sido predefinidos por la aplicación.';

procedure MntAsientosTipo( KeyValues : array of const );
begin

     TipoAsiento;  // Esto fuerza la creación de las tablas.
                   // Es importante porque el mantenimiento utiliza un Query que necesita que LineaTipoAsiento exista.

     CreateEditForm( TMntTasForm, MntTasForm, KeyValues, TGds10Frm.ContableSection );
end;

procedure TMntTasForm.FormManagerReportRequest;
begin
     ListadoAsientosTipo;
end;

procedure TMntTasForm.GridViewConceptoPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntConceptosApunte( [ Sender.EditingValue ] );
end;

procedure TMntTasForm.GridViewConceptoPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaConceptosApunte( Sender );
end;

procedure TMntTasForm.GridViewConceptoPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ConceptoApunte.CompruebaTexto( DisplayValue, ErrorText, Error );
end;

procedure TMntTasForm.GridViewCtroCostePropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCentrosCoste( [ Sender.EditingValue ] );
end;

procedure TMntTasForm.GridViewCtroCostePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCentrosCoste( Sender );
end;

procedure TMntTasForm.GridViewCtroCostePropertiesValidate(     Sender       : TcxCustomEdit;
                                                           var DisplayValue : Variant;
                                                           var ErrorText    : TCaption;
                                                           var Error        : Boolean );
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTasForm.GridViewDHPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Ch : Char;

begin
     DisplayValue := AnsiUpperCase( DisplayValue );
     Ch := Copy( DisplayValue, 1, 1 )[ 1 ];
     If   not ( Ch in [ 'D', 'H' ] )
     then DisplayValue := 'D';
end;

procedure TMntTasForm.GridViewSubcuentaPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntTasForm.GridViewSubcuentaPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender );
end;

procedure TMntTasForm.GridViewSubcuentaPropertiesValidate(     Sender       : TcxCustomEdit;
                                                           var DisplayValue : Variant;
                                                           var ErrorText    : TCaption;
                                                           var Error        : Boolean );
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, { CuentaFields } nil, { IsInfoControl } False, { SoloSubcuentas } False );
end;

procedure TMntTasForm.LineaTipoAsientoQueryNewRecord(DataSet: TDataSet);
begin
     LineaTipoAsientoQueryNroRegistro.Value := TipoAsientoTableNroRegistro.Value;
     LineaTipoAsientoQueryDH.Value := 'D';
end;

procedure TMntTasForm.NroRegistroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposAsiento( Sender, True, qgsLinked );
end;

procedure TMntTasForm.NroRegistroCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     If   DisplayValue<20
     then begin
          Error := True;
          ErrorText := JoinMessage( RsMsg3, RsMsg4 );
          end;
end;

procedure TMntTasForm.TipoAsientoTableNewRecord(DataSet: TDataSet);
begin
     TipoAsientoTableDocumento.Value := False;
     TipoAsientoTableRegistro.Value := False;
end;

procedure TMntTasForm.TipoAsientoTableUpdateState(DataSet: TDataSet);
begin
     LineaTipoAsientoDataSource.Enabled := TipoAsientoTable.State<>dsSetKey;
end;

function TMntTasForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.AcGCFicheros.Value;
end;

procedure TMntTasForm.FormManagerInitializeForm;
begin
     GridViewCtroCoste.Visible := DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value;
     SetColumnDecimals( GridViewImporte, DecimalesMoneda );
     TipoAsientoTable.SetDefaultRangeValues( [ 20 ], [ 999 ] );
end;

end.
