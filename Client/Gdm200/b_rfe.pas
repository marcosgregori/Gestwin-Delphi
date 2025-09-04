
unit b_rfe;

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

  cxCalendar, cxRadioGroup, cxListBox, cxMCListBox, ComCtrls, dxCore,
  cxPCdxBarPopupMenu, cxDateUtils, cxNavigator, dxBarBuiltInMenu, dxDateRanges,
  cxCustomListBox,

  AppContainer,
  GridTableViewController, dxScrollbarAnnotations, Winapi.ShlObj,
  cxShellCommon, cxListView, cxShellListView, dxListView, dxShellControls,
  dxBreadcrumbEdit, dxShellBreadcrumbEdit, dxTreeView, cxTreeView,
  cxShellTreeView,

  Gim10Fields,
  Gim30Fields,

  dm_iex;

type
  TCarpetaCorreo = ( ccRecibidos, ccEnviados );
  TCarpetasCorreo = set of TCarpetaCorreo;

  TBoxRfeForm = class(TgxForm)
    formManager: TgxFormManager;
    ButtonsPanel: TgxEditPanel;
    gEditPanel1: TgxEditPanel;
    CorreoEnviadoDataSource: TDataSource;
    FacturasEmitidasQuery: TnxeQuery;
    ParametrosPanel: TcxGroupBox;
    FechaInicialCtrl: TcxDateEdit;
    cxLabel2: TcxLabel;
    FechaFinalCtrl: TcxDateEdit;
    cxLabel3: TcxLabel;
    TodosLosRegistrosCtrl: TcxRadioButton;
    DesdeHastaCtrl: TcxRadioButton;
    DataPanel: TcxGroupBox;
    GridTableViewController: TGridTableViewController;
    EmitidasGrid: TcxGrid;
    EmitidasView: TcxGridDBTableView;
    EmitidasLevel: TcxGridLevel;
    cxImage1: TcxImage;
    Panel3: TcxGroupBox;
    CloseButton: TgBitBtn;
    FacturasEmitidasQueryTipo: TSmallintField;
    FacturasEmitidasQueryEjercicio: TSmallintField;
    FacturasEmitidasQueryPropietario: TWideStringField;
    FacturasEmitidasQuerySerie: TWideStringField;
    FacturasEmitidasQueryNroFactura: TIntegerField;
    FacturasEmitidasQueryNIFPropietario: TWideStringField;
    FacturasEmitidasQueryImporte: TBCDField;
    FacturasEmitidasQueryCodigoUsuario: TWideStringField;
    EmitidasViewTipo: TcxGridDBColumn;
    EmitidasViewEjercicio: TcxGridDBColumn;
    EmitidasViewPropietario: TcxGridDBColumn;
    EmitidasViewSerie: TcxGridDBColumn;
    EmitidasViewNroFactura: TcxGridDBColumn;
    EmitidasViewImporte: TcxGridDBColumn;
    EmitidasViewCodigoUsuario: TcxGridDBColumn;
    EmitidasViewFechaRegistro: TcxGridDBColumn;
    FacturasEmitidasQueryId: TLongWordField;
    FacturasEmitidasQueryNombre: TWideStringField;
    EmitidasViewNombre: TcxGridDBColumn;
    FacturasEmitidasQueryFechaRegistro: TDateTimeField;
    FacturasEmitidasQueryFecha: TDateField;
    EmitidasViewFecha: TcxGridDBColumn;
    EmitidasViewFechaEnvio: TcxGridDBColumn;
    cxGroupBox3: TcxGroupBox;
    EnviarButton: TgBitBtn;
    cxLabel1: TcxLabel;
    cxImage2: TcxImage;
    FacturasEmitidasQueryFechaEnvioPorCorreo: TDateField;
    RegistroFacturaElectronicaTable: TnxeTable;
    procedure TipoPaqueteCtrlPropertiesChange(Sender: TObject);
    procedure GridTableViewControllerDelete(Sender: TObject);
    procedure RadionButtonCtrlClick(Sender: TObject);
    procedure FechaCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure FacturasEmitidasQueryCalcFields(DataSet: TDataSet);
    procedure GridTableViewControllerUserSelection(Sender: TObject;
      var AHandled: Boolean);
    procedure FormManagerInitializeForm;
    procedure FormManagerPreparedForm;
    procedure EnviarButtonClick(Sender: TObject);
    procedure EmitidasViewFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
  private

    RegistroFacturaElectronicaFields : TRegistroFacturaElectronicaFields;

    procedure UpdateGridData;
    procedure UpdateParamControls;
    procedure DoEnviarMensajes;

  protected

  public

  end;

var   BoxRfeForm : TBoxRfeForm = nil;

procedure RegistroFacturasElectronicas;


implementation

{$R *.dfm}

uses   EnterpriseDataAccess,
       LibUtils,
       Files,

       AppManager,

       dmi_iex,
       dmi_mov,

       dm_cli,
       dm_cer,
       dm_fdv,
       dm_fce,

       a_fdv,

       b_msg,
       b_pro;

resourceString
       RsMsg1 = '¿Está seguro de que desea suprimir los registros seleccionados?';
       RsMsg2 = 'La acción no afecta a las facturas de venta existentes, solo al registro de facturas electrónicas emitidas.';
       RsMsg3 = 'Envío de facturas electrónicas por correo';

procedure RegistroFacturasElectronicas;
begin
     CreateEditForm( TBoxRfeForm, BoxRfeForm, [] );
end;

procedure TBoxRfeForm.FormManagerInitializeForm;
begin

     RegistroFacturaElectronicaFields := TRegistroFacturaElectronicaFields.Create( RegistroFacturaElectronicaTable );

     TodosLosRegistrosCtrl.Checked := True;
     FechaInicialCtrl.EditValue := ApplicationContainer.Today30DaysAgoDate;
     FechaFinalCtrl.EditValue := ApplicationContainer.TodayDate;

     SetColumnDecimals( EmitidasViewImporte );

     EmitidasViewCodigoUsuario.Visible := UsuarioMaestro;

     EmitidasGrid.Hint := AccedaAlDocumentoHintMsg;
end;

procedure TBoxRfeForm.FormManagerPreparedForm;
begin
     UpdateGridData;
end;

procedure TBoxRfeForm.GridTableViewControllerDelete(Sender: TObject);
begin
     If   ShowNotification( ntQuestionWarning, RsMsg1, RsMsg2 )=mrYes
     then begin
          With EmitidasView.Controller do
            For var RecInx := 0 to SelectedRecordCount - 1 do
              begin

              var SelectedRecord := SelectedRecords[ RecInx ];

              var Ejercicio := SelectedRecord.Values[ EmitidasViewEjercicio.Index ];
              var Serie := SelectedRecord.Values[ EmitidasViewSerie.Index ];
              var NroFactura := SelectedRecord.Values[ EmitidasViewNroFactura.Index ] ;

              If   RegistroFacturaElectronicaTable.FindKey( [ Ord( rfeFacturaEmitida ), Ejercicio, Serie, NroFactura ] )
              then RegistroFacturaElectronicaTable.Delete;
              end;

          UpdateGridData;
          end;

     Abort;
end;

procedure TBoxRfeForm.GridTableViewControllerUserSelection( Sender: TObject; var AHandled: Boolean);
begin
     MntFacturasVenta( [ FacturasEmitidasQueryEjercicio.Value,
                         FacturasEmitidasQuerySerie.Value,
                         FacturasEmitidasQueryNroFactura.Value ] );
end;

procedure TBoxRfeForm.TipoPaqueteCtrlPropertiesChange(Sender: TObject);
begin
     UpdateGridData;
end;

procedure TBoxRfeForm.RadionButtonCtrlClick(Sender: TObject);
begin
     UpdateParamControls;
end;

procedure TBoxRfeForm.UpdateParamControls;
begin
     DesdeHastaCtrl.Checked := not TodosLosRegistrosCtrl.Checked;
     TodosLosRegistrosCtrl.Checked := not DesdeHastaCtrl.Checked;
     FechaInicialCtrl.Enabled := not TodosLosRegistrosCtrl.Checked;
     FechaFinalCtrl.Enabled := not TodosLosRegistrosCtrl.Checked;
     UpdateGridData;
end;

procedure TBoxRfeForm.EmitidasViewFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     EnviarButton.Enabled := EmitidasView.Controller.SelectedRowCount>0;
end;

procedure TBoxRfeForm.EnviarButtonClick(Sender: TObject);
begin
     CreateProcessForm( DoEnviarMensajes, RsMsg3 );
end;

procedure TBoxRfeForm.DoEnviarMensajes;
begin
     // Tipo;Ejercicio;Serie;NroFactura

     With EmitidasView.Controller do
       For var RecInx := 0 to SelectedRecordCount - 1 do
         begin

         var SelectedRecord := SelectedRecords[ RecInx ];

         var Ejercicio := SelectedRecord.Values[ EmitidasViewEjercicio.Index ];
         var Serie := SelectedRecord.Values[ EmitidasViewSerie.Index ];
         var NroFactura := SelectedRecord.Values[ EmitidasViewNroFactura.Index ] ;

         If   RegistroFacturaElectronicaTable.FindKey( [ Ord( rfeFacturaEmitida ), Ejercicio, Serie, NroFactura ] )
         then FacturaElectronica.EnviaFacturaPorCorreo( RegistroFacturaElectronicaFields );
       end;

     EmitidasView.DataController.RefreshExternalData;

end;

procedure TBoxRfeForm.FacturasEmitidasQueryCalcFields(DataSet: TDataSet);
begin
     FacturasEmitidasQueryNombre.Value := Cliente.Descripcion( FacturasEmitidasQueryPropietario.Value );
end;

procedure TBoxRfeForm.FechaCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     UpdateGridData;
end;

procedure TBoxRfeForm.UpdateGridData;

var  SQLText : String;

begin
     If  FormManager.FormInitialized
     then begin

          FormManager.ValidateDataArea( faData );

          SQLText := 'SELECT RegistroFacturaElectronica.*, FacturaVentas.FechaEnvioPorCorreo ' +
                     'FROM   RegistroFacturaElectronica ' +
                     '       LEFT JOIN FacturaVentas ON ( FacturaVentas.Ejercicio=RegistroFacturaElectronica.Ejercicio AND ' +
                     '                 FacturaVentas.Serie=RegistroFacturaElectronica.Serie AND ' +
                     '                 FacturaVentas.Nrofactura=RegistroFacturaElectronica.Nrofactura ) ' +
                     'WHERE Tipo=? ';

          If   not UsuarioMaestro
          then StrAdd( SQLText, ' AND CodigoUsuario=' + QuotedStr( CodigoUsuarioActual ) );
          If   DesdeHastaCtrl.Checked
          then StrAdd( SQLText, ' AND FechaRegistro BETWEEN ' + SQLDateTimeString( FechaInicialCtrl.EditValue, tvLowest ) + ' AND ' + SQLDateTimeString( FechaFinalCtrl.EditValue, tvHighest ) );

          try
            FacturasEmitidasQuery.DisableControls;
            FacturasEmitidasQuery.ExecSQLVars( SQLText, [ Ord( rfeFacturaEmitida ) ] );
          finally
            FacturasEmitidasQuery.EnableControls;
            end;

          end;

end;

initialization

end.
