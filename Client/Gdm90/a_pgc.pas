
unit a_pgc;

interface

uses
  sysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, AppForms, stdCtrls, Buttons, ExtCtrls, Mask,

  AppContainer,
  tabs,
  cxControls,
  cxContainer,
  cxEdit,
  cxTextEdit,
  cxDBEdit,

  DataManager,
  DB,
  nxdb,
  dxmdaset,
  Menus,
  cxLookAndFeelPainters,
  cxButtons, dxSkinsCore, dxSkinsDefaultPainters, cxMemo, cxRichEdit,
  cxDBRichEdit, cxStyles, dxSkinscxPCPainter, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses,
  cxGridCustomView, cxGrid, cxImage, ClipBrd, cxCheckBox, cxLookAndFeels,
  cxGroupBox, cxNavigator, dxBar, dxDateRanges, dxScrollbarAnnotations;

const CM_SWITCH = CM_BASE + 200;

type
  TMyClipBoard = class( TClipBoard )
    procedure SetClipBoardBuffer( const Value: string );
    function GetAsRTF : string;
    end;

  TMntPgcForm = class(TgxForm)
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    CodigoTextEdit: TcxDBTextEdit;
    codigoCtrlCaption: TLabel;
    DataPanel: TgxEditPanel;
    CuentaTable: TnxeTable;
    BrowseCuentaTable: TnxeTable;
    CuentaTableCodigo: TWideStringField;
    CuentaTableNivel: TSmallIntField;
    CuentaTableDescripcion: TWideStringField;
    BrowseCuentaTableCodigo: TWideStringField;
    BrowseCuentaTableNivel: TSmallintField;
    BrowseCuentaTableDescripcion: TWideStringField;
    SubcuentaDataSource: TDataSource;
    NivelRecord: TgxMemData;
    NivelDataSource: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    DescripcionCtrl: TcxDBTextEdit;
    PGCTable: TnxeTable;
    PGCTableCodigo: TWideStringField;
    PGCTableDescripcion: TWideMemoField;
    NivelRecordTextoNivel: TWideStringField;
    NivelRecordCodigo: TWideStringField;
    NivelRecordDescripcion: TWideStringField;
    NivelRecordAyuda: TWideMemoField;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    Grid: TcxGrid;
    TableViewTextoNivel: TcxGridDBColumn;
    TableViewCodigo: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    TableViewAyuda: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    NivelRecordNivel: TSmallintField;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    TableViewNivel: TcxGridDBColumn;
    NivelRecordOculto: TBooleanField;
    TableViewOculto: TcxGridDBColumn;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    dxBarManager1: TdxBarManager;
    PopupMenu: TdxBarPopupMenu;
    PegarItem: TdxBarButton;
    CopiarItem: TdxBarButton;
    Ocultar1: TdxBarButton;
    Mostrar1: TdxBarButton;
    procedure CuentaTableGetRecord(DataSet: TDataSet);
    function CuentaTableCheckValidRecord(Dataset: TDataSet): Boolean;
    procedure CodigoTextEditPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoTextEditPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CuentaTableNewRecord(DataSet: TDataSet);
    procedure CuentaTableBeforeDelete(DataSet: TDataSet);
    procedure CuentaTableBeforePost(DataSet: TDataSet);
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure TableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure CopiarItemClick(Sender: TObject);
    procedure FormManagerDestroyForm;
    procedure PegarItemClick(Sender: TObject);
    procedure Ocultar1Click(Sender: TObject);
    procedure Mostrar1Click(Sender: TObject);
    procedure TableViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure TableViewOcultoGetCellHint(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord;
      ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
      var AHintText: TCaption; var AIsHintMultiLine: Boolean;
      var AHintTextRect: TRect);
    procedure TableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    RTFClipboard : TMyClipBoard;
    procedure ActualizaRegistroAyuda;
    procedure MostrarRegistroAyuda( Mostrar : Boolean );

    procedure CMSwitchMessage( var Message : TMessage ); message CM_SWITCH;
  public

  end;

var   MntPgcForm: TMntPgcForm = nil;

procedure MntPGC( keyValues : array of const );

implementation

{$R *.DFM}

uses   EnterpriseDataAccess,

       gdm00Dm,
       gdm10Dm,
       b_msg,

       dm_sub,

       bx_not,

       cx_sub,
       l_sub;

var    CF_RTF : Word;

resourceString
       RsMsg1   = 'Ocultar o mostrar la ayuda del nivel.'#13'Tecla <F4>';

procedure MntPGC( KeyValues : array of const );
begin
     CreateEditForm( TMntPgcForm, MntPgcForm, KeyValues );
end;

procedure TMyClipBoard.SetClipBoardBuffer( const Value: string);
begin
     SetBuffer( CF_RTF, PChar( Value )^, Length(Value) + 1);
end;

function TMyClipboard.GetAsRTF : string;

var Data: THandle;

begin
     Open;
     Data := GetClipboardData( CF_RTF );
     try
       If   Data<>0
       then Result := PChar( GlobalLock( Data ) )
       else Result := '';
     finally
       If   Data<>0
       then GlobalUnlock( Data );
       Close;
       end;
end;

procedure TMntPgcForm.FormManagerInitializeForm;
begin
     RTFClipboard := TMyClipBoard.Create;
     CF_RTF := RegisterClipboardFormat( 'Rich Text Format' );
end;

procedure TMntPgcForm.FormManagerReportRequest;
begin
     ListadoCuentas;
end;

procedure TMntPgcForm.MostrarRegistroAyuda( Mostrar : Boolean );
begin
     With NivelRecord do
       begin
       Edit;
       NivelRecordOculto.Value := Mostrar;
       ActualizaRegistroAyuda;
       Post;
       end;
end;

procedure TMntPgcForm.CMSwitchMessage( var message : TMessage );
begin
     MostrarRegistroAyuda( not NivelRecordOculto.Value );
end;

procedure TMntPgcForm.Mostrar1Click(Sender: TObject);
begin
     MostrarRegistroAyuda( False );
end;

procedure TMntPgcForm.Ocultar1Click(Sender: TObject);
begin
     MostrarRegistroAyuda( True );
end;

procedure TMntPgcForm.PegarItemClick(Sender: TObject);
begin
     NivelRecord.Edit;
     NivelRecordAyuda.Value := RTFClipBoard.GetAsRTF;
     NivelRecord.Post;
end;

procedure TMntPgcForm.TableViewCellClick(     Sender        : TcxCustomGridTableView;
                                              ACellViewInfo : TcxGridTableDataCellViewInfo;
                                              AButton       : TMouseButton;
                                              AShift        : TShiftState;
                                          var AHandled      : Boolean );
begin
     If   ACellViewInfo.Item=TableViewOculto
     then PostMessage( Handle, CM_SWITCH, 0 , 0 );
end;

procedure TMntPgcForm.TableViewCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     If   not NivelRecordOculto.Value
     then MntAnotacion( NivelRecordAyuda );
end;

procedure TMntPgcForm.TableViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     case Key of
       VK_F4  : PostMessage( Handle, CM_SWITCH, 0 , 0 );
       end;

end;

procedure TMntPgcForm.TableViewOcultoGetCellHint(       Sender           : TcxCustomGridTableItem;
                                                        ARecord          : TcxCustomGridRecord;
                                                        ACellViewInfo    : TcxGridTableDataCellViewInfo;
                                                  const AMousePos        : TPoint;
                                                  var   AHintText        : TCaption;
                                                  var   AIsHintMultiLine : Boolean;
                                                  var   AHintTextRect    : TRect );
begin
     If   ACellViewInfo.Item=TableViewOculto
     then begin
          AHintText := RsMsg1;
          With AHintTextRect do
            begin
            Left := Left - 100;
            Top := Top + 22;
            end;
          end;
end;

procedure TMntPgcForm.CodigoTextEditPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsLinked, True, True );
end;

procedure TMntPgcForm.CodigoTextEditPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.CompruebaCodigo( DisplayValue, ErrorText, Error );
end;

procedure TMntPgcForm.CopiarItemClick(Sender: TObject);
begin
     RTFClipBoard.SetClipBoardBuffer( NivelRecordAyuda.Value );
     {
     var Text := NivelRecordAyuda.Value;
     Text := TableView.Controller.FocusedRow.Values[ TableViewDescripcion.Index ];
     RTFClipBoard.AsText := Text;
     }
end;

procedure TMntPgcForm.CuentaTableBeforeDelete(DataSet: TDataSet);
begin
     If   Cuenta.TieneMovimientos( CuentaTableCodigo.Value )
     then Abort;
end;

procedure TMntPgcForm.CuentaTableBeforePost(DataSet: TDataSet);

var   Index : Byte;
      SearchKey   : String;
      RecordFound : Boolean;

begin

     With BrowseCuentaTable do
       For Index := 1 to Cuenta.NivelSubcuenta - 1 do
         If   NivelRecord.Locate( 'Nivel', Index, [] )
         then begin

              SearchKey := Copy( CodigoTextEdit.EditValue, 1, Index );
              RecordFound := FindKey( [ SearchKey ] );

              If   Trim( NivelRecordDescripcion.Value )=''
              then begin
                   If   RecordFound
                   then Delete;
                   end
              else begin
                   If   RecordFound
                   then Edit
                   else Append;
                   BrowseCuentaTableCodigo.Value := SearchKey;
                   BrowseCuentaTableDescripcion.Value := NivelRecordDescripcion.Value;
                   BrowseCuentaTableNivel.Value := Index;
                   Post;
                   end;

              If   not NivelRecordOculto.Value
              then With PGCTable do
                     begin
                     RecordFound := FindKey( [ SearchKey ] );
                     If   Trim( NivelRecordAyuda.Value )=''
                     then begin
                          If   RecordFound
                          then Delete;
                          end
                     else begin
                          If   RecordFound
                          then Edit
                          else Append;
                          PGCTableCodigo.Value := SearchKey;
                          PGCTableDescripcion.Value := NivelRecordAyuda.Value;
                          Post;
                          end;
                     end;

            end;
end;

function TMntPgcForm.CuentaTableCheckValidRecord(Dataset: TDataSet): Boolean;
begin
     Result := CuentaTableNivel.Value=Cuenta.NivelSubcuenta;
end;

procedure TMntPgcForm.ActualizaRegistroAyuda;
begin
     With NivelRecordAyuda do
       If   not NivelRecordOculto.Value and PGCTable.FindKey( [ NivelRecordCodigo.Value ] )
       then Value := PGCTableDescripcion.Value
       else Clear;
end;

procedure TMntPgcForm.CuentaTableGetRecord(DataSet: TDataSet);

var   Index : SmallInt;
      SearchKey : String;
      Reload : Boolean;
      
begin
     If   BrowseCuentaTable.Active and not ValueIsEmpty( CodigoTextEdit.EditValue )
     then try
            NivelRecord.DisableControls;

            For Index := 1 to Cuenta.NivelSubcuenta - 1 do
              begin

              SearchKey := Copy( CodigoTextEdit.EditValue, 1, Index );
              Reload := True;

              If   NivelRecord.Locate( 'Nivel', Index, [] )
              then begin
                   If   NivelRecordCodigo.Value=SearchKey
                   then Reload := False
                   else NivelRecord.Edit;
                   end
              else begin
                   NivelRecord.Append;
                   NivelRecordNivel.Value := Index;
                   case Index of
                     1 : NivelRecordTextoNivel.Value := 'Grupo';
                     2 : NivelRecordTextoNivel.Value := 'Subgrupo';
                     3 : NivelRecordTextoNivel.Value := 'Cuenta';
                     end;
                   end;

              If   Reload
              then begin

                   NivelRecordCodigo.Value := SearchKey;

                   With NivelRecordDescripcion do
                     If   BrowseCuentaTable.FindKey( [ SearchKey ] )
                     then Value := BrowseCuentaTableDescripcion.Value
                     else Clear;

                   ActualizaRegistroAyuda;

                   NivelRecord.Post;
                   end;

              end;

          finally
            NivelRecord.EnableControls;
            end;
end;

procedure TMntPgcForm.CuentaTableNewRecord(DataSet: TDataSet);
begin
     CuentaTableNivel.Value := Cuenta.NivelSubcuenta;
end;

procedure TMntPgcForm.FormManagerDestroyForm;
begin
     RTFClipboard.Free;
end;

function TMntPgcForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := 1; // alAllowed
    // Result := DataModule00.DmUsuarioFields.AcGCFicheros.Value;
end;

end.
