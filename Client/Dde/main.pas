unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DdeMan,

  Menus,
  nxllComponent,
  nxdb,
  DataManager,
  DB,

  AppContainer,

  Gim00Fields,
  Gim10Fields, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinsDefaultPainters,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, dxmdaset, dxDateRanges;

type
  TMainForm = class(TForm)
    EmpresaTable: TnxeTable;
    MainMenu1: TMainMenu;
    Acercade1: TMenuItem;
    Ayuda1: TMenuItem;
    N2: TMenuItem;
    Contenido1: TMenuItem;
    ProvinciaTable: TnxeTable;
    Data: TgxMemData;
    DataID: TIntegerField;
    DataTopic: TStringField;
    DataCodigoEmpresa: TStringField;
    DataNombre: TStringField;
    DataEjercicio: TSmallintField;
    DataEstado: TStringField;
    DataNotificaciones: TStringField;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    TableViewRecId: TcxGridDBColumn;
    TableViewCodigoEmpresa: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    TableViewEjercicio: TcxGridDBColumn;
    TableViewTopic: TcxGridDBColumn;
    TableViewEstado: TcxGridDBColumn;
    TableViewNotificaciones: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    DataSource: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Acercade1Click(Sender: TObject);
    procedure Contenido1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
  private
    FCurrentID : Integer;
    procedure WMDDEInitiate( var Msg : TMessage ); message WM_DDE_INITIATE;
  public

    DmEmpresaFields : TEmpresaFields;
    DmProvinciaFields : TProvinciaFields;

    property CurrentID : Integer read FCurrentID;
  end;

var  MainForm : TMainForm = nil;

implementation

{$R *.DFM}

uses   ShellAPI,
       AppForms,
       LibUtils,

       AppManager,
       DataAccess,
       EnterpriseDataAccess,
       NexusRpcData,

       b_msg,
       b_abo,

       Topic;

resourceString
       RsMsg1  = 'Aún existen canales activos. Si cierra la aplicación antes de cerrar los canales se podran producir resultados inesperados.';
       RsMsg2  = 'Está seguro de que desea cerrar la aplicación?.';
       RsMsg3  = 'La base de datos necesita ser actualizada.';
       RsMsg4  = 'No puede actualizarse la base de datos desde esta aplicación.'#13'Acceda a su aplicación GESTWIN más completa para actualizar la base de datos a la última versión.';

procedure TMainForm.FormCreate(Sender: TObject);
begin

     // LogMessage( 'Par�metros :' + CmdLine );

     // DataAccessMode := dmLocal;

     AppShortName := 'DDE';
     FCurrentID := 1;
     
     ApplicationContainer.RegisterProgram( Self );

     // LogMessage( 'NexusRpc' );

     NexusRpc;

     ExecuteProcedures( imStartup, [] );

     EmpresaTable.Open;
     ProvinciaTable.Open;
     Data.Open;

     DmEmpresaFields := TEmpresaFields.Create( EmpresaTable );
     DmProvinciaFields := TProvinciaFields.Create( ProvinciaTable );

     ShowErrorDialog := False;

     SpServerConnections := 999;  // No limito el n�mero de conexiones simult�neas

     ApplicationInitialized := True;

     If   DatabaseUpdateRequested
     then begin
          ShowNotification( ntError, RsMsg3, RsMsg4 );
          PrgExit( False, True, True );
          Abort;
          end;

end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
     // FreeSession;
     PostMessage( word( -1 ), wm_DDE_terminate, Handle, 0 );
end;

procedure TMainForm.FormResize(Sender: TObject);

var  Index : Integer;

begin
     If   ApplicationContainer.TDI
     then begin
          For Index := 0 to MDIChildCount - 1 do
            If   MDIChildren[ Index ] is TgxForm
            then CenterForm( TgxForm( MDIChildren[ Index ] ) );
          end  
     else For Index := 0 to MDIChildCount - 1 do
            If   MDIChildren[ Index ] is TgxForm
            then With TgxForm( MDIChildren[ Index ] ) do
                   If   Maximized
                   then MaximizeForm;
end;

procedure TMainForm.WMDDEInitiate( var Msg : TMessage );

var  AppGlobalAtom,
     TopicGlobalAtom : Atom;

     ZStrApp,
     ZStrTopic : array[ 0..40 ] of WideChar;
     StrApp,
     StrTopic : string;

     InitPos : Byte;
     Index : Integer;
     NuevoCanal : Boolean;

begin

     GlobalGetAtomName( Msg.LParamLo, ZStrApp, 40 );
     GlobalGetAtomName( Msg.LParamHi, ZStrTopic, 40 );

     StrApp := StrUpper( ZStrApp );
     StrTopic := StrUpper( ZStrTopic );

     If   ( StrApp='GW' ) and ( StrTopic<>'' )
     then begin
          try

          NuevoCanal := True;

          //*  24.01.2003  Incluido para dar soporte a StarOffice

          Data.First;
          While not Data.Eof do
            begin
            If   DataTopic.Value=StrTopic
            then begin
                 NuevoCanal := False;
                 Break;
                 end;
            Data.Next;
            end;

            If   NuevoCanal
            then DDEForm := TDDEForm.Create( Self );

            If   Assigned( DDEForm )
            then With DDEForm do
                   begin

                   If   NuevoCanal
                   then begin
                        ClientHandle := Msg.WParam;
                        ID := CurrentID;

                        try
                          Data.DisableControls;
                          Data.Append;
                          DataID.Value := CurrentID;
                          DataTopic.Value := StrTopic;
                          Data.Post;
                        finally
                          Data.EnableControls;
                          end;

                        Inc( FCurrentID );
                        end;

                 AppGlobalAtom := GlobalAddAtom( ZStrApp );
                 TopicGlobalAtom := GlobalAddAtom( ZStrTopic );
                 If   SendMessage( Msg.wParam, wm_DDE_Ack, Handle, MAKELPARAM( AppGlobalAtom, TopicGlobalAtom ) )=0
                 then begin
                      GlobalDeleteAtom( AppGlobalAtom );
                      GlobalDeleteAtom( TopicGlobalAtom );
                      end;

                   end
              else Abort;

            except on E : Exception do 
              begin
              ShowException( e, self );
              // PostMessage( word( -1 ), wm_DDE_terminate, Handle, 0 );
              Application.Terminate;   // se cierra la aplicacin
              end;
            end;
          end;

end;

procedure TMainForm.Acercade1Click(Sender: TObject);
begin
     ApplicationContainer.ShowAboutForm( True );
end;

procedure TMainForm.Contenido1Click(Sender: TObject);
begin
     ShellExecute( 0, nil, PChar(ApplicationPath + 'Ayuda\hs10\contenido_5.html' ), nil, nil, SW_SHOWNORMAL);
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
     If   Data.RecordCount>0
     then CanClose := ShowNotification( ntQuestionWarning, RsMsg1, RsMsg2 )=mrYes;
end;

initialization
              
end.


