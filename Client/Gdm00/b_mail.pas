
unit b_mail;

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
  GridTableViewController,
  dxScrollbarAnnotations,

  dmi_iex, dxUIAClasses;

type
  TCarpetaCorreo = ( ccRecibidos, ccEnviados );
  TCarpetasCorreo = set of TCarpetaCorreo;

  TMailForm = class(TgxForm)
    formManager: TgxFormManager;
    ButtonsPanel: TgxEditPanel;
    gEditPanel1: TgxEditPanel;
    CorreoRecibidoQuery: TnxeQuery;
    CorreoRecibidoDataSource: TDataSource;
    CorreoEntranteDataSource: TDataSource;
    CorreoTable: TnxeTable;
    CorreoTableID: TUnsignedAutoIncField;
    CorreoRecibidoQueryTextoTipo: TWideStringField;
    CorreoEnviadoDataSource: TDataSource;
    CorreoEnviadoQuery: TnxeQuery;
    CorreoEnviadoQueryTextoTipo: TWideStringField;
    CorreoRecibidoQueryCodigoEmpresa: TWideStringField;
    CorreoRecibidoQueryCodigoUsuario: TWideStringField;
    CorreoRecibidoQueryCarpeta: TSmallintField;
    CorreoRecibidoQueryTipo: TSmallintField;
    CorreoRecibidoQueryAsunto: TWideStringField;
    CorreoRecibidoQueryRemitente: TWideStringField;
    CorreoRecibidoQueryFecha: TDateField;
    CorreoRecibidoQueryHora: TTimeField;
    CorreoRecibidoQueryFechaProceso: TDateField;
    CorreoRecibidoQueryHoraProceso: TTimeField;
    CorreoRecibidoQueryAdjunto: TBlobField;
    CorreoEnviadoQueryCodigoEmpresa: TWideStringField;
    CorreoEnviadoQueryCodigoUsuario: TWideStringField;
    CorreoEnviadoQueryCarpeta: TSmallintField;
    CorreoEnviadoQueryTipo: TSmallintField;
    CorreoEnviadoQueryAsunto: TWideStringField;
    CorreoEnviadoQueryRemitente: TWideStringField;
    CorreoEnviadoQueryFecha: TDateField;
    CorreoEnviadoQueryHora: TTimeField;
    CorreoEnviadoQueryFechaProceso: TDateField;
    CorreoEnviadoQueryHoraProceso: TTimeField;
    CorreoEnviadoQueryAdjunto: TBlobField;
    TipoPaquetePanel: TcxGroupBox;
    cxLabel1: TcxLabel;
    TipoPaqueteCtrl: TcxComboBox;
    Image1: TcxImage;
    ParametrosPanel: TcxGroupBox;
    FechaInicialCtrl: TcxDateEdit;
    cxLabel2: TcxLabel;
    FechaFinalCtrl: TcxDateEdit;
    cxLabel3: TcxLabel;
    TodosLosMensajesCtrl: TcxRadioButton;
    DesdeHastaCtrl: TcxRadioButton;
    CorreoRecibidoQueryParametros: TWideMemoField;
    FoldersPanel: TcxGroupBox;
    CarpetasPageControl: TcxPageControl;
    BuzonEntradaTabSheet: TcxTabSheet;
    EntranteGrid: TcxGrid;
    EntranteView: TcxGridDBTableView;
    EntranteViewSeleccionado: TcxGridDBColumn;
    EntranteViewAsunto: TcxGridDBColumn;
    EntranteViewRemitente: TcxGridDBColumn;
    EntranteViewFecha: TcxGridDBColumn;
    EntranteViewHora: TcxGridDBColumn;
    EntranteViewParametros: TcxGridDBColumn;
    EntranteLevel: TcxGridLevel;
    RecibidosTabSheet: TcxTabSheet;
    RecibidosGrid: TcxGrid;
    RecibidosView: TcxGridDBTableView;
    RecibidosViewTextoTipo: TcxGridDBColumn;
    RecibidosViewAsunto: TcxGridDBColumn;
    RecibidosViewRemitente: TcxGridDBColumn;
    RecibidosViewFecha: TcxGridDBColumn;
    RecibidosViewHora: TcxGridDBColumn;
    RecibidosViewID: TcxGridDBColumn;
    RecibidosViewParametros: TcxGridDBColumn;
    RecibidosLevel: TcxGridLevel;
    RecibidosViewManager: TGridTableViewController;
    EnviadosTabSheet: TcxTabSheet;
    GridTableViewController1: TGridTableViewController;
    EnviadosGrid: TcxGrid;
    EnviadosView: TcxGridDBTableView;
    EnviadosViewTextoTipo: TcxGridDBColumn;
    EnviadosViewAsunto: TcxGridDBColumn;
    EnviadosViewRemitente: TcxGridDBColumn;
    EnviadosViewFecha: TcxGridDBColumn;
    EnviadosViewHora: TcxGridDBColumn;
    EnviadosViewID: TcxGridDBColumn;
    EnviadosViewParametros: TcxGridDBColumn;
    EnviadosLevel: TcxGridLevel;
    ParametrosCtrl: TcxMCListBox;
    cxSplitter1: TcxSplitter;
    CorreoEnviadoQueryParametros: TWideMemoField;
    CorreoEnviadoQueryDestinatario: TWideStringField;
    Panel3: TcxGroupBox;
	OkButton: TgBitBtn;	
    CloseButton: TgBitBtn;
    CorreoEnviadoQueryId: TUnsignedAutoIncField;
    CorreoRecibidoQueryId: TUnsignedAutoIncField;
    procedure FormManagerCreateForm;
    procedure EntranteViewDblClick(Sender: TObject);
    procedure EntranteViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TipoPaqueteCtrlPropertiesChange(Sender: TObject);
    procedure RecibidosViewManagerDelete(Sender: TObject);
    procedure CorreoRecibidoQueryCalcFields(DataSet: TDataSet);
    procedure CorreoEnviadoQueryCalcFields(DataSet: TDataSet);
    procedure GridTableViewController1Delete(Sender: TObject);
    procedure RadionButtonCtrlClick(Sender: TObject);
    procedure FechaCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure TableViewCanFocusRecord(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; var AAllow: Boolean);
    procedure GridEnter(Sender: TObject);
    procedure FoldersPanelExit(Sender: TObject);
    procedure FormManagerPreparedForm;
  private

    procedure SeleccionaLineaCorreoEntrante;
    procedure UpdateRange;
    procedure UpdateParamControls;
    procedure UpdateParamsGrid( ATableView: TcxCustomGridTableView; ARecord : TcxCustomGridRecord );
    procedure UpdateParametrosCtrl(TextValue: String);

  protected

    class var
      CorreoEntranteDataset : TgxMemData;
      TipoPaquete : TTipoDatosExportados;

  public

    class procedure DoShowMail;

  end;

var   MailForm : TMailForm = nil;

function MailBox( TipoPaquete           : TTipoDatosExportados;
                  CorreoEntranteDataset : TgxMemData = nil ) : Integer;


implementation

{$R *.dfm}

uses   DataAccess,
       LibUtils,

       AppManager,

       dm_iex,

       b_msg;

resourceString
       RsMsg1 = '¿Está seguro de que desea suprimir los mensajes de correo seleccionados?';
       RsMsg2 = 'Los mensajes se borrarán de forma irrecuperable.';

function MailBox( TipoPaquete           : TTipoDatosExportados;
                  CorreoEntranteDataset : TgxMemData = nil ) : Integer;
begin
     Result := mrCancel;

     TMailForm.TipoPaquete := TipoPaquete;
     TMailForm.CorreoEntranteDataset := CorreoEntranteDataset;

     MailForm := TMailForm.Create( Application.MainForm );
     If   Assigned( MailForm )
     then try
            Result := MailForm.ShowModal;
          finally
            MailForm.Free;
            end;
end;

class procedure TMailForm.DoShowMail;
begin
     MailBox( tdCualquiera );
end;

procedure TMailForm.FoldersPanelExit(Sender: TObject);
begin
     UpdateParametrosCtrl( '' );
end;

procedure TMailForm.FormManagerCreateForm;
begin
     BuzonEntradaTabSheet.TabVisible := Assigned( CorreoEntranteDataset );
     RecibidosTabSheet.TabVisible := not Assigned( CorreoEntranteDataset );
     EnviadosTabSheet.TabVisible := not Assigned( CorreoEntranteDataset );

     TipoPaqueteCtrl.ItemIndex := Ord( TipoPaquete ) + 1;
     TipoPaqueteCtrl.Enabled := TipoPaquete=tdCualquiera;

     If   Assigned( CorreoEntranteDataset )
     then CorreoEntranteDatasource.DataSet := CorreoEntranteDataset
     else CorreoRecibidoDataSource.Enabled := True;

     ParametrosPanel.Visible := not Assigned( CorreoEntranteDataset );
     TodosLosMensajesCtrl.Checked := True;
     FechaInicialCtrl.EditValue := ApplicationContainer.Today30DaysAgoDate;
     FechaFinalCtrl.EditValue := ApplicationContainer.TodayDate;
end;

procedure TMailForm.GridTableViewController1Delete(Sender: TObject);
begin
     If   ShowNotification( ntQuestionWarning, RsMsg1, RsMsg2 )=mrYes
     then EnviadosView.DataController.DeleteSelection;
end;

procedure TMailForm.RecibidosViewManagerDelete(Sender: TObject);
begin
     If   ShowNotification( ntQuestionWarning, RsMsg1, RsMsg2 )=mrYes
     then RecibidosView.DataController.DeleteSelection;
end;

procedure TMailForm.SeleccionaLineaCorreoEntrante;
begin
     With ExportImportModule do
       begin
       CorreoEntranteDataset.Edit;
       CorreoEntranteDatasetSeleccionado.Value := not CorreoEntranteDatasetSeleccionado.Value;
       CorreoEntranteDataset.Post;
       end;
end;

procedure TMailForm.TipoPaqueteCtrlPropertiesChange(Sender: TObject);
begin
     UpdateRange;
end;

procedure TMailForm.RadionButtonCtrlClick(Sender: TObject);
begin
     UpdateParamControls;
end;

procedure TMailForm.UpdateParamControls;
begin
     DesdeHastaCtrl.Checked := not TodosLosMensajesCtrl.Checked;
     TodosLosMensajesCtrl.Checked := not DesdeHastaCtrl.Checked;
     FechaInicialCtrl.Enabled := not TodosLosMensajesCtrl.Checked;
     FechaFinalCtrl.Enabled := not TodosLosMensajesCtrl.Checked;
     UpdateRange;
end;

procedure TMailForm.CorreoEnviadoQueryCalcFields(DataSet: TDataSet);
begin
     CorreoEnviadoQueryTextoTipo.Value := DescripcionTipoDatosExportados( CorreoEnviadoQueryTipo.Value );
end;

procedure TMailForm.CorreoRecibidoQueryCalcFields(DataSet: TDataSet);
begin
     CorreoRecibidoQueryTextoTipo.Value := DescripcionTipoDatosExportados( CorreoRecibidoQueryTipo.Value );
end;

procedure TMailForm.GridEnter(Sender: TObject);

var  ATableView : TcxCustomGridTableView;

begin
     If   Sender is TcxGrid
     then begin
          ATableView := TcxCustomGridTableView( TcxGrid( Sender ).Levels[ 0 ].GridView );
          UpdateParamsGrid( ATableView, ATableView.Controller.FocusedRecord );
          end;
end;

procedure TMailForm.EntranteViewDblClick(Sender: TObject);
begin
     SeleccionaLineaCorreoEntrante;
end;

procedure TMailForm.TableViewCanFocusRecord(      Sender  : TcxCustomGridTableView;
                                                  ARecord : TcxCustomGridRecord;
                                              var AAllow  : Boolean);
begin
     UpdateParamsGrid( Sender, ARecord );
end;

procedure TMailForm.UpdateParametrosCtrl( TextValue : String );
begin
     With ParametrosCtrl do
       begin
       Items.Text := TextValue;
       Refresh;
       end;
end;

procedure TMailForm.UpdateParamsGrid( ATableView  : TcxCustomGridTableView;
                                      ARecord     : TcxCustomGridRecord );

var  Column : TcxGridDBColumn;

begin
     If   Assigned( ARecord ) and ARecord.HasCells and  ATableView.IsControlFocused
     then begin
          Column := TcxGridDBTableView( ATableView ).GetColumnByFieldName( 'Parametros' );
          If   Assigned( Column )
          then begin
               UpdateParametrosCtrl( ARecord.Values[ Column.Index ] );
               Exit;
               end;
          end;
     UpdateParametrosCtrl( '' );
end;

procedure TMailForm.EntranteViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     If   Key=VK_SPACE
     then SeleccionaLineaCorreoEntrante;
end;

procedure TMailForm.FechaCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     UpdateRange;
end;

procedure TMailForm.UpdateRange;

var  SQLText : String;

begin
     If   FormManager.FormInitialized
     then begin

          FormManager.ValidateDataArea( faData );

          SQLText := 'SELECT * FROM Correo WHERE Carpeta=? AND CodigoEmpresa=' + QuotedStr( CodigoEmpresaActual );

          If   not UsuarioMaestro
          then StrAdd( SQLText, ' AND CodigoUsuario=' + QuotedStr( CodigoUsuarioActual ) );
          If   TipoPaqueteCtrl.ItemIndex<>0
          then StrAdd( SQLText, ' AND Tipo=' + IntToStr( TipoPaqueteCtrl.ItemIndex - 1 ) );
          If   DesdeHastaCtrl.Checked
          then StrAdd( SQLText, ' AND Fecha BETWEEN ' + SQLDateString( FechaInicialCtrl.EditValue ) + ' AND ' + SQLDateString( FechaFinalCtrl.EditValue ) );

          RecibidosViewTextoTipo.Visible := TipoPaqueteCtrl.ItemIndex=0;
          EnviadosViewTextoTipo.Visible := TipoPaqueteCtrl.ItemIndex=0;

          try
            CorreoRecibidoQuery.DisableControls;
            CorreoEnviadoQuery.DisableControls;

            CorreoRecibidoQuery.ExecSQLVars( SQLText, [ Ord( ccRecibidos ) ] );
            CorreoEnviadoQuery.ExecSQLVars( SQLText, [ Ord( ccEnviados ) ] );
          finally
            CorreoRecibidoQuery.EnableControls;
            CorreoEnviadoQuery.EnableControls;
            end;

          end;

end;

procedure TMailForm.FormManagerPreparedForm;
begin
     UpdateRange;
end;

procedure Initialize;
begin
     If   Assigned( Application.MainForm )
     then With ApplicationContainer do
            If   Assigned( MailButton )
            then OnShowMailForm := TMailForm.DoShowMail;
end;

initialization
     AddProcedure( imInitialize, 0, Initialize );

end.
