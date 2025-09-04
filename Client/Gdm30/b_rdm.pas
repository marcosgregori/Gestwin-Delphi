unit b_rdm;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes, Windows, ShellAPI, WinAPI.Messages,
  ExtCtrls, Graphics, ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxLabel, cxDBLabel, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLookAndFeels, cxGroupBox, cxNavigator, Vcl.Dialogs, dxBar,
  dxDateRanges, GridTableViewController, dxScrollbarAnnotations,

  AppManager,
  AppContainer,
  AppForms,
  DataManager,

  Gim30Fields,

  dm_art,

  dmi_mov, dxUIAClasses;

type
  TBrwRdmForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    RelacionDocumentosTable: TnxeTable;
    RelacionDocumentosDataSource: TDataSource;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    GridTableViewController: TGridTableViewController;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    CloseButton: TgBitBtn;
    RelacionDocumentosTableCodigoArticulo: TWideStringField;
    RelacionDocumentosTableCodigoClaseA: TWideStringField;
    RelacionDocumentosTableCodigoClaseB: TWideStringField;
    RelacionDocumentosTableCodigoClaseC: TWideStringField;
    RelacionDocumentosTableNroLinea: TSmallintField;
    RelacionDocumentosTableDocumento: TWideStringField;
    GridViewNroLinea: TcxGridDBColumn;
    GridViewDocumento: TcxGridDBColumn;
    OpenDialog: TOpenDialog;
    dxBarManager1: TdxBarManager;
    PopupMenu: TdxBarPopupMenu;
    FichaArticuloItem: TdxBarButton;
    RelacionDocumentosTableNroProceso: TSmallintField;
    RelacionDocumentosTableTipo: TSmallintField;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    RelacionDocumentosTableEjercicio: TSmallintField;
    RelacionDocumentosTableNroOperacion: TIntegerField;
    procedure FormManagerInitializeForm;
    procedure GridViewDocumentoPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure GridViewDocumentoPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure RelacionDocumentosTableNewRecord(DataSet: TDataSet);
    function GridTableViewControllerShowOrigin: Boolean;
    procedure GridViewDocumentoPropertiesEnter(Sender: TcxCustomEdit);
    procedure FormManagerCreateForm;
    procedure FormManagerDestroyForm;
    procedure FormManagerCloseForm(Sender: TObject;
      var Action: TCloseAction);
  private
    procedure WMDropFiles( var Msg: TMessage ); message WM_DROPFILES;
  public
  class var
    TipoRelacion : TTipoRelacionDocumentos;
    CodigoArticulo,
    CodigoClaseA,
    CodigoClaseB,
    CodigoClaseC : String;
    NroProceso : SmallInt;
    NroOperacion : LongInt;
    OnClose : TSimpleEvent;
  end;

var  BrwRdmForm: TBrwRdmForm = nil;

procedure EditarRelacionDocumentos( CodigoArticulo,
                                    CodigoClaseA,
                                    CodigoClaseB,
                                    CodigoClaseC : String;
                                    NroProceso   : SmallInt ); overload;

procedure EditarRelacionDocumentos( NroRegistro : LongInt;
                                    OnClose     : TSimpleEvent ); overload;

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,
       MsgFrame,

       EnterpriseDataAccess,

       Gdm00Dm,

       dm_cli,
       dm_cls,
       dm_sto,
       dm_sec,
       dm_mov,

       a_cli,
       a_art,

       cx_cli,

       l_ccl;

resourceString
     RsMsg1 = 'El fichero indicado no existe.';
     RsMsg2 = 'Solo se admiten ficheros PDF.';

procedure EditarRelacionDocumentos( CodigoArticulo,
                                    CodigoClaseA,
                                    CodigoClaseB,
                                    CodigoClaseC : String;
                                    NroProceso   : SmallInt );
begin
     TBrwRdmForm.TipoRelacion := trdListaMateriales;
     TBrwRdmForm.CodigoArticulo := CodigoArticulo;
     TBrwRdmForm.CodigoClaseA := CodigoClaseA;
     TBrwRdmForm.CodigoClaseB := CodigoClaseB;
     TBrwRdmForm.CodigoClaseC := CodigoClaseC;
     TBrwRdmForm.NroProceso := NroProceso;
     CreateEditForm( TBrwRdmForm, BrwRdmForm, [] );
end;

procedure EditarRelacionDocumentos( NroRegistro : LongInt;
                                    OnClose     : TSimpleEvent );
begin
     If   NroRegistro>0
     then begin
          TBrwRdmForm.TipoRelacion := trdLineaMovimiento;
          TBrwRdmForm.OnClose := OnClose;
          TBrwRdmForm.NroOperacion := NroRegistro;
          CreateEditForm( TBrwRdmForm, BrwRdmForm, [] );
          end;
end;

procedure TBrwRdmForm.FormManagerCloseForm( Sender : TObject; var Action : TCloseAction );
begin
     If   Assigned( OnClose )
     then OnClose;
     Action := caFree;
end;

procedure TBrwRdmForm.FormManagerCreateForm;
begin
     DragAcceptFiles( Handle, True );
end;

procedure TBrwRdmForm.FormManagerDestroyForm;
begin
     DragAcceptFiles( Handle, False );
end;

procedure TBrwRdmForm.FormManagerInitializeForm;
begin
     case TipoRelacion of

       trdListaMateriales :
         begin
         RelacionDocumentosTable.IndexFieldNames := 'Tipo;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;NroProceso;NroLinea';
         RelacionDocumentosTable.SetRange( [ TipoRelacion, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, NroProceso ] );
         end;

       trdLineaMovimiento :
         begin
         RelacionDocumentosTable.IndexFieldNames := 'Tipo;NroOperacion';
         RelacionDocumentosTable.SetRange( [ TipoRelacion, NroOperacion ] );
         end;

       end;

end;

function TBrwRdmForm.GridTableViewControllerShowOrigin: Boolean;
begin
     If   Assigned( GridView.Controller.EditingController.Edit )
     then GridViewDocumentoPropertiesQueryRequest( GridView.Controller.EditingController.Edit );
end;

procedure TBrwRdmForm.GridViewDocumentoPropertiesEnter(Sender: TcxCustomEdit);
begin
     GridTableViewController.OriginActive := True;
end;

procedure TBrwRdmForm.GridViewDocumentoPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   Assigned( Sender )
     then begin
          var Path := Sender.EditingValue;
          If   Path<>''
          then begin
               // De este modo, si existe el fichero, se posicionará en su directorio
               OpenDialog.InitialDir := ExtractFileDir( Path );
               OpenDialog.FileName := ExtractFileName( Path );
               end;
          If   OpenDialog.Execute
          then begin
               Sender.PostEditValue( OpenDialog.FileName );
               Sender.SelectAll;
               GridTableViewController.OriginActive := True;
               end;
          end;
end;

procedure TBrwRdmForm.GridViewDocumentoPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ValueIsEmpty( DisplayValue )
     then If   ( TipoRelacion=trdListaMateriales ) and ( UpperCase( ExtractFileExt( DisplayValue ) )<> '.PDF' )
          then begin
               Error := True;
               ErrorText := RsMsg2;
               end
          else If   not FileExists( DisplayValue )
               then begin
                    Error := True;
                    ErrorText := RsMsg1;
                    end;
end;

procedure TBrwRdmForm.RelacionDocumentosTableNewRecord(DataSet: TDataSet);
begin

     RelacionDocumentosTableTipo.Value := TipoRelacion;

     case TipoRelacion of

       trdListaMateriales :
         begin

         // Tipo;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;NroProceso;NroLinea

         RelacionDocumentosTableCodigoArticulo.Value := CodigoArticulo;
         RelacionDocumentosTableCodigoClaseA.Value := CodigoClaseA;
         RelacionDocumentosTableCodigoClaseB.Value := CodigoClaseB;
         RelacionDocumentosTableCodigoClaseC.Value := CodigoClaseC;
         RelacionDocumentosTableNroProceso.Value := NroProceso;
         end;

       trdLineaMovimiento :
         begin

         // Tipo;NroOperacion

         RelacionDocumentosTableNroOperacion.Value := NroOperacion;
         end;

       end;
end;

procedure TBrwRdmForm.WMDropFiles( var Msg : TMessage );

var  hDrop : THandle;
     FileCount : Integer;
     NameLen : Integer;
     I : Integer;
     S : string;

begin

     GridView.DataController.GotoLast;

     try
       hDrop:= Msg.wParam;
       FileCount:= DragQueryFile ( hDrop , $FFFFFFFF, nil, 0 );

       For I := 0 to FileCount - 1 do
         begin
         NameLen:= DragQueryFile( hDrop, I, nil, 0 ) + 1;
         SetLength( S, NameLen );
         DragQueryFile( hDrop, I, Pointer( S ), NameLen );

         RelacionDocumentosTable.Append;
         RelacionDocumentosTableDocumento.Value := S;
         RelacionDocumentosTable.Post;
         end;

     except on E : Exception do
       begin
       RelacionDocumentosTable.Cancel;
       ShowHintMsg( 'Error', E.Message );
       end;
     end;

     DragFinish( hDrop );
end;

end.
