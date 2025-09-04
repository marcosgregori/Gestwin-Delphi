
unit a_sub;

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
  cxLabel, cxGroupBox, cxNavigator, dxBar, dxDateRanges, dxScrollbarAnnotations;

const CM_SWITCH = CM_BASE + 200;

type
  TMntSubForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    CodigoTextEdit: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
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
    Panel1: TcxGroupBox;
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
    NivelRecordNivel: TSmallintField;
    CodigoStyle: TcxStyle;
    AmpliacionStyle: TcxStyle;
    NivelStyle: TcxStyle;
    TableViewNivel: TcxGridDBColumn;
    NivelRecordOculto: TBooleanField;
    TableViewOculto: TcxGridDBColumn;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    dxBarManager1: TdxBarManager;
    PopupMenu: TdxBarPopupMenu;
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
    procedure ActualizaRegistroAyuda;
    procedure MostrarRegistroAyuda( Mostrar : Boolean );

    procedure CMSwitchMessage( var Message : TMessage ); message CM_SWITCH;
  public

  end;

var   MntSubForm: TMntSubForm = nil;

procedure MntCuentas( keyValues : array of const );

implementation

{$R *.DFM}

uses   EnterpriseDataAccess,

       Gim00Fields,
       Gim10Fields,
       Gdm00Dm,
       Gdm10Frm,

       b_msg,

       dm_sub,

       bx_not,

       cx_sub,
       l_sub;

resourceString
       HintMsg1   = 'Ocultar o mostrar la ayuda del nivel.'#13'Tecla <F4>';

procedure MntCuentas( KeyValues : array of const );
begin
     CreateEditForm( TMntSubForm, MntSubForm, KeyValues, TGds10Frm.ContableSection );
end;

procedure TMntSubForm.FormManagerInitializeForm;
begin
     //..
end;

procedure TMntSubForm.FormManagerReportRequest;
begin
     ListadoCuentas;
end;

procedure TMntSubForm.MostrarRegistroAyuda( Mostrar : Boolean );
begin
     With NivelRecord do
       begin
       Edit;
       NivelRecordOculto.Value := Mostrar;
       ActualizaRegistroAyuda;
       Post;
       end;
end;

procedure TMntSubForm.CMSwitchMessage( var message : TMessage );
begin
     MostrarRegistroAyuda( not NivelRecordOculto.Value );
end;

procedure TMntSubForm.Mostrar1Click(Sender: TObject);
begin
     MostrarRegistroAyuda( False );
end;

procedure TMntSubForm.Ocultar1Click(Sender: TObject);
begin
     MostrarRegistroAyuda( True );
end;

procedure TMntSubForm.TableViewCellClick(     Sender        : TcxCustomGridTableView;
                                              ACellViewInfo : TcxGridTableDataCellViewInfo;
                                              AButton       : TMouseButton;
                                              AShift        : TShiftState;
                                          var AHandled      : Boolean );
begin
     If   ACellViewInfo.Item=TableViewOculto
     then PostMessage( Handle, CM_SWITCH, 0 , 0 );
end;

procedure TMntSubForm.TableViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     case Key of
       VK_F4  : PostMessage( Handle, CM_SWITCH, 0 , 0 );
       end;

end;

procedure TMntSubForm.TableViewOcultoGetCellHint(       Sender           : TcxCustomGridTableItem;
                                                        ARecord          : TcxCustomGridRecord;
                                                        ACellViewInfo    : TcxGridTableDataCellViewInfo;
                                                  const AMousePos        : TPoint;
                                                  var   AHintText        : TCaption;
                                                  var   AIsHintMultiLine : Boolean;
                                                  var   AHintTextRect    : TRect );
begin
     If   ACellViewInfo.Item=TableViewOculto
     then begin
          AHintText := HintMsg1;
          AIsHintMultiLine := True;
          With AHintTextRect do
            begin
            Left := Left - 150;
            Top := Top + 22;
            Right := Left + 300;
            end;
          end;
end;

procedure TMntSubForm.CodigoTextEditPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsLinked, True, True );
end;

procedure TMntSubForm.CodigoTextEditPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     // Comprobando el estado permito que los códigos que se permitían en el pasado, y son erróneos, se puedan borrar
     If   CuentaTable.State=dsSetKey
     then Cuenta.CompruebaCodigo( DisplayValue, ErrorText, Error );
end;

procedure TMntSubForm.CuentaTableBeforeDelete(DataSet: TDataSet);
begin
     If   Cuenta.TieneMovimientos( CuentaTableCodigo.Value )
     then Abort;
end;

procedure TMntSubForm.CuentaTableBeforePost(DataSet: TDataSet);

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
            end;
end;

function TMntSubForm.CuentaTableCheckValidRecord(Dataset: TDataSet): Boolean;
begin
     Result := CuentaTableNivel.Value=Cuenta.NivelSubcuenta;
end;

procedure TMntSubForm.ActualizaRegistroAyuda;
begin
     With NivelRecordAyuda do
       If   not NivelRecordOculto.Value and PGCTable.FindKey( [ NivelRecordCodigo.Value ] )
       then Value := PGCTableDescripcion.Value
       else Clear;
end;

procedure TMntSubForm.CuentaTableGetRecord(DataSet: TDataSet);

var   Index : SmallInt;
      SearchKey : String;
      Reload : Boolean;

begin
     If   BrowseCuentaTable.Active and not ValueIsEmpty( CuentaTableCodigo.Value )
     then try

            NivelRecord.DisableControls;

            For Index := 1 to Cuenta.NivelSubcuenta - 1 do
              begin

              SearchKey := Copy( CuentaTableCodigo.Value, 1, Index );
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
            NivelRecord.First;
            NivelRecord.EnableControls;
            end;
end;

procedure TMntSubForm.CuentaTableNewRecord(DataSet: TDataSet);
begin
     CuentaTableNivel.Value := Cuenta.NivelSubcuenta;
end;

function TMntSubForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.AcGCFicheros.Value;
end;

end.
