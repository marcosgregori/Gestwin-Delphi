
unit b_ife;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, AppForms, ExtCtrls, Generics.Collections,

  Mask, CheckLst, Menus, cxLookAndFeelPainters, cxButtons,
  cxControls, cxContainer, cxCheckListBox, dxSkinsCore,
  dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels, cxEdit, cxImage,
  dxSkinscxPCPainter, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxPC,
  dxGDIPlusClasses, cxSplitter, cxTextEdit, cxMemo, cxDBEdit, cxMaskEdit,
  cxDropDownEdit, cxIndexedComboBox, cxLabel, nxdb, DataManager,

  cxCheckBox,
  cxGroupBox,

  dm_iex, cxCalendar, cxRadioGroup, cxListBox, cxMCListBox, ComCtrls, dxCore,
  cxPCdxBarPopupMenu, cxDateUtils, cxNavigator, dxBarBuiltInMenu, dxDateRanges,
  cxCustomListBox,

  AppContainer,
  GridTableViewController, dxScrollbarAnnotations, Winapi.ShlObj,
  cxShellCommon, cxListView, dxListView, dxShellControls,
  dxBreadcrumbEdit, dxShellBreadcrumbEdit, dxTreeView, cxTreeView,
  cxShellTreeView, cxShellListView, dxUIAClasses;

type
  TCarpetaCorreo = ( ccRecibidos, ccEnviados );
  TCarpetasCorreo = set of TCarpetaCorreo;

  TBoxIfeForm = class(TgxForm)
    formManager: TgxFormManager;
    ButtonsPanel: TgxEditPanel;
    gEditPanel1: TgxEditPanel;
    FacturasRecibidasQuery: TnxeQuery;
    CorreoRecibidoDataSource: TDataSource;
    ParametrosPanel: TcxGroupBox;
    FechaInicialCtrl: TcxDateEdit;
    cxLabel2: TcxLabel;
    FechaFinalCtrl: TcxDateEdit;
    cxLabel3: TcxLabel;
    TodosLosRegistrosCtrl: TcxRadioButton;
    DesdeHastaCtrl: TcxRadioButton;
    FoldersPanel: TcxGroupBox;
    CarpetasPageControl: TcxPageControl;
    FicherosTabSheet: TcxTabSheet;
    RecibidasTabSheet: TcxTabSheet;
    RecibidasGrid: TcxGrid;
    RecibidasView: TcxGridDBTableView;
    RecibidasLevel: TcxGridLevel;
    RecibidosViewManager: TGridTableViewController;
    ShellListView: TdxShellListView;
    TabControl: TcxTabControl;
    cxImage1: TcxImage;
    cxGroupBox1: TcxGroupBox;
    Panel3: TcxGroupBox;
    CloseButton: TgBitBtn;
    cxGroupBox3: TcxGroupBox;
    ImportarButton: TgBitBtn;
    FacturasRecibidasQueryTipo: TSmallintField;
    FacturasRecibidasQueryEjercicio: TSmallintField;
    FacturasRecibidasQueryPropietario: TWideStringField;
    FacturasRecibidasQuerySerie: TWideStringField;
    FacturasRecibidasQueryNroFactura: TIntegerField;
    FacturasRecibidasQueryNIFPropietario: TWideStringField;
    FacturasRecibidasQueryImporte: TBCDField;
    FacturasRecibidasQueryCodigoUsuario: TWideStringField;
    RecibidasViewPropietario: TcxGridDBColumn;
    RecibidasViewSerie: TcxGridDBColumn;
    RecibidasViewNroFactura: TcxGridDBColumn;
    RecibidasViewImporte: TcxGridDBColumn;
    RecibidasViewCodigoUsuario: TcxGridDBColumn;
    RecibidasViewFechaRegistro: TcxGridDBColumn;
    FacturasRecibidasQueryNombre: TWideStringField;
    RecibidasViewNombre: TcxGridDBColumn;
    FacturasRecibidasQueryFechaRegistro: TDateTimeField;
    FacturasRecibidasQueryFecha: TDateField;
    RecibidasViewFecha: TcxGridDBColumn;
    ShellTreeView: TcxShellTreeView;
    cxSplitter1: TcxSplitter;
    cxLabel1: TcxLabel;
    cxImage2: TcxImage;
    RecibidasViewEjercicio: TcxGridDBColumn;
    RegistroFacturaElectronicaTable: TnxeTable;
    FacturasRecibidasQueryId: TUnsignedAutoIncField;
    procedure FormManagerShowForm;
    procedure TipoPaqueteCtrlPropertiesChange(Sender: TObject);
    procedure RecibidosViewManagerDelete(Sender: TObject);
    procedure RadionButtonCtrlClick(Sender: TObject);
    procedure FechaCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
    procedure ImportarButtonClick(Sender: TObject);
    procedure ShellListViewSelectionChanged(Sender: TObject);
    procedure FacturasRecibidasQueryCalcFields(DataSet: TDataSet);
    procedure FormManagerInitializeForm;
    procedure CarpetasPageControlPageChanging(Sender: TObject;
      NewPage: TcxTabSheet; var AllowChange: Boolean);
    procedure ShellTreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure RecibidosViewManagerUserSelection(Sender: TObject; var AHandled: Boolean);
  private

    StartPath : String;

    procedure UpdateGridData;
    procedure UpdateParamControls;
    procedure UpdateParametrosCtrl(TextValue: String);
    procedure ExecuteProcess;

  protected

  public

  end;

var   BoxIfeForm : TBoxIfeForm = nil;

procedure ImportacionFacturasElectronicas;


implementation

{$R *.dfm}

uses   EnterpriseDataAccess,
       LibUtils,
       Files,

       AppManager,

       Gim10Fields,

       dmi_mov,

       dm_pro,
       dm_fce,

       a_fdc,

       b_msg,
       b_pro;

resourceString
       RsMsg1 = '¿Está seguro de que desea suprimir los registros seleccionados?';
       RsMsg2 = 'La acción no afecta a las facturas de compra importadas existentes, solo al registro de facturas electrónicas recibidas.';
       RsMsg3 = 'Importación de facturas electrónicas.';

procedure ImportacionFacturasElectronicas;
begin
     CreateEditForm( TBoxIfeForm, BoxIfeForm, [] );
end;

procedure TBoxIfeForm.FormManagerInitializeForm;
begin

     RecibidasGrid.Hint := AccedaAlDocumentoHintMsg;

     TodosLosRegistrosCtrl.Checked := True;
     FechaInicialCtrl.EditValue := ApplicationContainer.Today30DaysAgoDate;
     FechaFinalCtrl.EditValue := ApplicationContainer.TodayDate;

     SetColumnDecimals( RecibidasViewImporte );

     RecibidasViewCodigoUsuario.Visible := UsuarioMaestro;

     StartPath := AddPathDelim( ApplicationPath ) + 'imports\facturae';

     CreateDirPath( StartPath );

     TabControl.TabIndex := 0;
     CarpetasPageControl.ActivePageIndex := 0;
end;

procedure TBoxIfeForm.FormManagerShowForm;
begin
     ShellTreeView.Path := StartPath;
end;

procedure TBoxIfeForm.ImportarButtonClick(Sender: TObject);
begin
     CreateProcessForm( ExecuteProcess, RsMsg3 )
end;

procedure TBoxIfeForm.CarpetasPageControlPageChanging(     Sender      : TObject;
                                                           NewPage     : TcxTabSheet;
                                                       var AllowChange : Boolean );
begin
     If   NewPage=RecibidasTabSheet
     then UpdateGridData;
end;

procedure TBoxIfeForm.ExecuteProcess;
begin
     With ShellListView do
       For var PathIndex := 0 to SelectedFilePaths.Count - 1 do
         FacturaElectronica.DoOnLeeFactura( SelectedFilePaths[ PathIndex ] );
end;

procedure TBoxIfeForm.RecibidosViewManagerDelete(Sender: TObject);
begin
     If   ShowNotification( ntQuestionWarning, RsMsg1, RsMsg2 )=mrYes
     then begin
          With RecibidasView.Controller do
            For var RecInx := 0 to SelectedRecordCount - 1 do
              begin

              var SelectedRecord := SelectedRecords[ RecInx ];

              var Ejercicio := SelectedRecord.Values[ RecibidasViewEjercicio.Index ];
              var Serie := SelectedRecord.Values[ RecibidasViewSerie.Index ];
              var NroFactura := SelectedRecord.Values[ RecibidasViewNroFactura.Index ] ;

              If   RegistroFacturaElectronicaTable.FindKey( [ Ord( rfeFacturaRecibida), Ejercicio, Serie, NroFactura ] )
              then RegistroFacturaElectronicaTable.Delete;
              end;

          UpdateGridData;
          end;
     Abort;
end;

procedure TBoxIfeForm.RecibidosViewManagerUserSelection(Sender: TObject; var AHandled: Boolean);
begin
     MntFacturasCompra( [ FacturasRecibidasQueryEjercicio.Value,
                          FacturasRecibidasQueryPropietario.Value,
                          FacturasRecibidasQuerySerie.Value ] );
end;

procedure TBoxIfeForm.ShellListViewSelectionChanged(Sender: TObject);
begin
     ImportarButton.Enabled := ShellListView.SelectedFilePaths.Count>0;
end;

procedure TBoxIfeForm.ShellTreeViewChange(Sender: TObject;Node: TTreeNode);
begin
     ShellListView.Path := ShellTreeView.Path;
end;

procedure TBoxIfeForm.TipoPaqueteCtrlPropertiesChange(Sender: TObject);
begin
     UpdateGridData;
end;

procedure TBoxIfeForm.RadionButtonCtrlClick(Sender: TObject);
begin
     UpdateParamControls;
end;

procedure TBoxIfeForm.UpdateParamControls;
begin
     DesdeHastaCtrl.Checked := not TodosLosRegistrosCtrl.Checked;
     TodosLosRegistrosCtrl.Checked := not DesdeHastaCtrl.Checked;
     FechaInicialCtrl.Enabled := not TodosLosRegistrosCtrl.Checked;
     FechaFinalCtrl.Enabled := not TodosLosRegistrosCtrl.Checked;
     UpdateGridData;
end;

procedure TBoxIfeForm.TabControlChange(Sender: TObject);
begin
     CarpetasPageControl.ActivePageIndex := TabControl.TabIndex;
     ParametrosPanel.Visible := CarpetasPageControl.ActivePageIndex<>0;
end;

procedure TBoxIfeForm.UpdateParametrosCtrl( TextValue : String );
begin

end;

procedure TBoxIfeForm.FacturasRecibidasQueryCalcFields(DataSet: TDataSet);
begin
     FacturasRecibidasQueryNombre.Value := Proveedor.Descripcion( FacturasRecibidasQueryPropietario.Value );
end;

procedure TBoxIfeForm.FechaCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     UpdateGridData;
end;

procedure TBoxIfeForm.UpdateGridData;

var  SQLText : String;

begin

     If   FormManager.FormInitialized
     then begin

          FormManager.ValidateDataArea( faData );

          SQLText := 'SELECT * FROM RegistroFacturaElectronica WHERE Tipo=? ';

          If   not UsuarioMaestro
          then StrAdd( SQLText, ' AND CodigoUsuario=' + QuotedStr( CodigoUsuarioActual ) );
          If   DesdeHastaCtrl.Checked
          then StrAdd( SQLText, ' AND FechaRegistro BETWEEN ' + SQLDateTimeString( FechaInicialCtrl.EditValue, tvLowest ) + ' AND ' + SQLDateTimeString( FechaFinalCtrl.EditValue, tvHighest ) );

          try
            FacturasRecibidasQuery.DisableControls;
            FacturasRecibidasQuery.ExecSQLVars( SQLText, [ Ord( rfeFacturaRecibida ) ] );
          finally
            FacturasRecibidasQuery.EnableControls;
            end;

          end;
end;

initialization

end.
