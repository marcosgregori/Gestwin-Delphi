unit a_clsa;

interface

uses
    StdCtrls, Buttons, Mask, Controls, Classes, ExtCtrls, Forms, Tabs,
    ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
    cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxStyles,
    cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData,
    cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
    cxGridTableView, cxGridDBTableView, cxGrid, dxmdaset, cxCurrencyEdit,
    dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels, dxSkinsDefaultPainters,
    cxLabel, cxGroupBox, cxNavigator, dxDateRanges, dxScrollbarAnnotations,

    AppContainer,
    AppForms,
    DataManager,
    GridTableViewController,

    Gim30Fields, dxUIAClasses;

type

  TMntClsaForm = class(TgxForm)
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCodigoArticulo: TWideStringField;
    DataCodigoClaseA: TWideStringField;
    DataCodigoClaseB: TWideStringField;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox30: TcxGroupBox;
    ClaseArticuloGrid: TcxGrid;
    ClaseArticuloTableView: TcxGridDBTableView;
    ClaseArticuloTableViewCodigo: TcxGridDBColumn;
    ClaseArticuloTableViewDescripcion: TcxGridDBColumn;
    ClaseArticuloGridLevel: TcxGridLevel;
    ClaseDataSource: TDataSource;
    ClaseTable: TnxeTable;
    ClaseTableNroClase: TSmallintField;
    ClaseTableCodigo: TWideStringField;
    ClaseTableNroOrden: TSmallintField;
    ClaseTableDescripcion: TWideStringField;
    ClaseTableDisponibleTienda: TBooleanField;
    ClaseArticuloTable: TnxeTable;
    ClaseArticuloTableCodigoArticulo: TWideStringField;
    ClaseArticuloTableNroClase: TSmallintField;
    ClaseArticuloTableCodigoClase: TWideStringField;
    DataPanel: TgxEditPanel;
    StyleRepository: TcxStyleRepository;
    SelectionStyle: TcxStyle;
    cxGroupBox1: TcxGroupBox;
    CodigoArticuloCtrl: TcxDBTextEdit;
    codigoCtrlCaption: TcxLabel;
    DescArticuloLabel: TcxLabel;
    cxGroupBox3: TcxGroupBox;
    capClaseALabel: TcxLabel;
    CodigoClaseACtrl: TcxDBTextEdit;
    descClaseALabel: TcxLabel;
    cxGroupBox4: TcxGroupBox;
    capClaseBLabel: TcxLabel;
    CodigoClaseBCtrl: TcxDBTextEdit;
    descClaseBLabel: TcxLabel;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    procedure FormManagerFocusedAreaChanged;
    function FormManagerGetAccessLevel: SmallInt;
    procedure CodigoArticuloCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoClaseACtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClaseACtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoClaseBCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClaseBCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoClaseACtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoClaseBCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure ClaseArticuloTableViewSelectionChanged(Sender: TcxCustomGridTableView);
    procedure ClaseAArticuloTableViewControllerUserSelection(Sender: TObject; var AHandled: Boolean);
    procedure ClaseAArticuloTableViewControllerAfterRowShift(Sender: TObject);
    procedure PropertiesChange(Sender: TObject);
  private

    procedure ActualizaSeleccionRejilla;

  public

    DsArticuloFields : TArticuloFields;

    NroClaseActiva : SmallInt;

  end;

var
  MntClsaForm: TMntClsaForm = nil;

procedure MntClasesPorArticulo;

implementation

{$R *.DFM}

uses   SysUtils,
       Variants,
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gim10Fields,
       Gdm30Frm,

       dmi_pga,
       dmi_art,

       b_msg,

       dm_pga,
       dm_art,
       dm_cls,

       a_art,
       a_cls,

       cx_art,
       cx_cls1{,

       l_tct};


procedure MntClasesPorArticulo;
begin
     CreateEditForm( TMntClsaForm, MntClsaForm, [], TGds30Frm.AlmacenSection );
end;

procedure TMntClsaForm.FormManagerInitializeForm;
begin

     DsArticuloFields := TArticuloFields.Create( Self );

     Clase.SetupEditControl( CodigoClaseACtrl, tcClaseA, 0 );
     Clase.SetupEditControl( CodigoClaseBCtrl, tcClaseB, 0 );

     With DataModule00.DmEmpresaFields do
       begin
       SetupPanelableCtrl( CodigoClaseACtrl, Articulo_ExisteClase[ tcClaseB ].Value );
       SetupPanelableCtrl( CodigoClaseBCtrl, Articulo_ExisteClase[ tcClaseC ].Value );
       end;

end;

procedure TMntClsaForm.FormManagerReportRequest;
begin
     // ListadoTarifaClaseVentas;
end;

procedure TMntClsaForm.ClaseAArticuloTableViewControllerAfterRowShift(Sender: TObject);
begin
     ActualizaSeleccionRejilla;
end;

procedure TMntClsaForm.ClaseAArticuloTableViewControllerUserSelection(Sender: TObject; var AHandled: Boolean);
begin
     var RecordIndex := ClaseArticuloTableView.DataController.FocusedRecordIndex;
     If   RecordIndex>=0
     then begin
          var RecData := ClaseArticuloTableView.ViewData.Records[ RecordIndex ];
          RecData.Selected := not RecData.Selected;
          end;
end;

procedure TMntClsaForm.ClaseArticuloTableViewSelectionChanged(Sender: TcxCustomGridTableView);

var  ExisteRegistro : Boolean;
     RecordIndex : SmallInt;
     Selected : Boolean;

begin
     If   ClaseArticuloGrid.IsFocused and not ClaseTable.ShiftingRecords
     then begin
          RecordIndex := Sender.DataController.FocusedRecordIndex;
          If   RecordIndex>=0
          then begin
               Selected := Sender.ViewData.Records[ RecordIndex ].Selected;
               ExisteRegistro := ClaseArticuloTable.FindKey( [ DsArticuloFields.Codigo.Value, NroClaseActiva, ClaseTableCodigo.Value ] );
               If   Selected
               then begin
                    If   not ExisteRegistro
                    then begin
                         ClaseArticuloTable.Append;
                         ClaseArticuloTableCodigoArticulo.Value := DsArticuloFields.Codigo.Value;
                         ClaseArticuloTableNroClase.Value := NroClaseActiva;
                         ClaseArticuloTableCodigoClase.Value := ClaseTableCodigo.Value;
                         ClaseArticuloTable.Post;
                         end;
                    end
               else If   ExisteRegistro
                    then ClaseArticuloTable.Delete;
               end;
          end;
end;
procedure TMntClsaForm.PropertiesChange(Sender: TObject);
begin
     ClaseDataSource.Enabled := False
end;

procedure TMntClsaForm.CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TMntClsaForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scVentas, False, Sender );
end;

procedure TMntClsaForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, DsArticuloFields );
end;

procedure TMntClsaForm.CodigoClaseACtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ tcClaseA, Sender.EditingValue ] );
end;

procedure TMntClsaForm.CodigoClaseACtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( tcClaseA, Sender );
end;

procedure TMntClsaForm.CodigoClaseACtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( tcClaseA, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntClsaForm.CodigoClaseBCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ tcClaseB, Sender.EditingValue ] );
end;

procedure TMntClsaForm.CodigoClaseBCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( tcClaseB, Sender );
end;

procedure TMntClsaForm.CodigoClaseBCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( tcClaseB, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntClsaForm.FormManagerFocusedAreaChanged;
begin
     If   FormManager.DataAreaFocused
     then begin

          If   ValueIsEmpty( DataCodigoClaseA.Value )
          then NroClaseActiva := tcClaseA
          else If   ValueIsEmpty( DataCodigoClaseB.Value )
               then NroClaseActiva := tcClaseB
               else NroClaseActiva := tcClaseC;

          ClaseTable.SetRange( [ NroClaseActiva, 0 ], [ NroClaseActiva, MaxSmallint ] );

          ClaseDataSource.Enabled := True;

          ClaseArticuloTableView.DataController.RefreshExternalData;

          ActualizaSeleccionRejilla;

          end;

end;

procedure TMntClsaForm.ActualizaSeleccionRejilla;
begin
     try
       ClaseArticuloTableView.BeginUpdate;
       For var RecInx := 0 to ClaseArticuloTableView.ViewData.RecordCount - 1 do
         begin
         var RecData := ClaseArticuloTableView.ViewData.Records[ RecInx ];
         var CodigoClase := VarToStr( RecData.Values[ ClaseArticuloTableViewCodigo.Index ] );
         RecData.Selected := ClaseArticuloTable.FindKey( [ DataCodigoArticulo.Value, NroClaseActiva, CodigoClase ] );
         end;
     finally
       ClaseArticuloTableView.EndUpdate;
       end;
end;


function TMntClsaForm.FormManagerGetAccessLevel: SmallInt;
begin
     With dataModule00.DmUsuarioFields do
       Result := CheckAccessLevel( [ acALFicheros.Value ] );
end;

end.
