unit a_cls;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, Datamanager, DB, nxdb,

  dm_cls, cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, cxDropDownEdit,
  cxIndexedComboBox, cxLabel, cxGroupBox, cxMaskEdit, cxSpinEdit, cxCurrencyEdit, cxCheckBox,

  Spring,

  Gim30Fields, dxUIAClasses;

type
  TMntClsForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    ClaseTable: TnxeTable;
    dataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    cxGroupBox1: TcxGroupBox;
    EnvasesPanel: TcxGroupBox;
    Label1: TcxLabel;
    DescripcionCtrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    TipoEnvaseCtrl: TcxDBSpinEdit;
    DescTipoEnvaseLabel: TcxLabel;
    cxLabel2: TcxLabel;
    PesoCtrl: TcxDBCurrencyEdit;
    CapacidadCtrl: TcxDBCurrencyEdit;
    cxLabel3: TcxLabel;
    TiendaVirtualPanel: TcxGroupBox;
    ArticuloConEnvaseCtrl: TcxDBCheckBox;
    cxLabel4: TcxLabel;
    MaterialCtrl: TcxDBIndexedComboBox;
    TarifaRAPNormalCtrl: TcxDBCurrencyEdit;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    TarifaRAPPeligrosoCtrl: TcxDBCurrencyEdit;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure FormManagerInitializeForm;
    procedure ClaseTableSetKey(DataSet: TDataSet);
    procedure TipoEnvaseCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure TipoEnvaseCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TipoEnvaseCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ClaseTableBeforeInsert(DataSet: TDataSet);
    procedure ClaseTableBeforePost(DataSet: TDataSet);
  private

    FOnClaseBeforeInsert : Event<TDataSetNotifyEvent>;
    FOnClaseBeforePost : Event<TDataSetNotifyEvent>;

  public

     ClaseFields : TClaseFields;

     NroClase : TNroClase;

     property OnClaseBeforeInsert : Event<TDataSetNotifyEvent> read FOnClaseBeforeInsert write FOnClaseBeforeInsert;
     property OnClaseBeforePost : Event<TDataSetNotifyEvent> read FOnClaseBeforePost write FOnClaseBeforePost;

  end;

var  MntClsForm : array[ tcClaseA..tcClaseC ] of TMntClsForm = ( nil, nil, nil );
     MntClsFormNroClase : SmallInt;

procedure MntClases( KeyValues : array of const );

implementation

{$R *.dfm}

uses   EnterpriseDataAccess,

       Gdm00Dm,
       Gdm30Dm,

       Gim00Fields,

       Gdm30Frm,

       dm_tde,

       a_tde,

       cx_cls1,
       cx_tde,

       l_cls;

procedure MntClases( KeyValues : array of const );
begin
     MntClsFormNroClase := KeyValues[ 0 ].VInteger;
     CreateEditForm( TMntClsForm, MntClsForm[ MntClsFormNroClase ], KeyValues, TGds30Frm.AlmacenSection );
end;

procedure TMntClsForm.FormManagerInitializeForm;
begin

     Id := IdMntClsForm;

     NroClase := TNroClase( FormValues[ 0 ] );

     If   FormValues[ 1 ]=''
     then FormTableState := dsBrowse;

     Caption := Clase.NombreClase( NroClase, True, True );

     SetupControlsPanel( EnvasesPanel,
                         DataModule00.Envases and ( ( DataModule00.DmEmpresaFields.Articulo_Envase.Value=NroClase ) or ( DataModule00.DmEmpresaFields.Articulo_Contenedor.Value=NroClase ) ),
                         { AdjustFormHeight } True );

     SetupControlsPanel( TiendaVirtualPanel, DataModule00.TiendaVirtual, { AdjustFormHeight } True );

     SetEditcontrolsDecimals( [ PesoCtrl, CapacidadCtrl ], 3 );
     SetEditcontrolsDecimals( [ TarifaRAPNormalCtrl, TarifaRAPPeligrosoCtrl ], 4 );

     ClaseTable.SetDefaultRangeValues( [ NroClase ], [ NroClase ] );

     ClaseFields := TClaseFields.Create( ClaseTable );
end;

procedure TMntClsForm.FormManagerReportRequest;
begin
     ListadoClases( NroClase );
end;

procedure TMntClsForm.TipoEnvaseCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTiposEnvase( [ Sender.EditingValue ] );
end;

procedure TMntClsForm.TipoEnvaseCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaTiposEnvase( Sender );
end;

procedure TMntClsForm.TipoEnvaseCtrlPropertiesValidate(      Sender       : TcxCustomEdit;
                                                         var DisplayValue : Variant;
                                                         var ErrorText    : TCaption;
                                                         var Error        : Boolean );
begin
     TipoEnvase.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntClsForm.ClaseTableBeforeInsert(DataSet: TDataSet);
begin
     FOnClaseBeforeInsert.Invoke( Dataset );
end;

procedure TMntClsForm.ClaseTableBeforePost(DataSet: TDataSet);
begin
     FOnClaseBeforePost.Invoke( Dataset );
end;

procedure TMntClsForm.ClaseTableSetKey(DataSet: TDataSet);
begin
     ClaseFields.NroClase.Value := NroClase;
end;

procedure TMntClsForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( NroClase, Sender, qgsLinked );
end;

function TMntClsForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.acALFicheros.Value;
end;

end.
