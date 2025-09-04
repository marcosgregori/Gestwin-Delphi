unit B_upd;

interface

uses
  SysUtils, windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,

  DataManager,
  DB,
  nxDb,
  ComCtrls,
  AppContainer,
  AppForms,
  cxPC,
  cxControls,
  Menus,
  cxLookAndFeelPainters,
  cxButtons, cxContainer, cxEdit, cxProgressBar,

  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox, dxGDIPlusClasses,
  cxImage, cxCheckBox, cxPCdxBarPopupMenu,

  Gim00Fields, dxBarBuiltInMenu, dxSVGImage;

type
  TBoxUpdForm = class(TgxForm)
    ButtonsPanel: TgxEditPanel;
    Panel2: TgxEditPanel;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    DictionaryProgressBar: TcxProgressBar;
    FileProgressBar: TcxProgressBar;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    EmpresaTable: TnxeTable;
    Image1: TcxImage;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    TitleLabel: TcxLabel;
    Label9: TcxLabel;
    FicheroLabel: TcxLabel;
    Label2: TcxLabel;
    ProcesoLabel: TcxLabel;
    CerrarButton: TgBitBtn;
    TodasLasEmpresasCtrl: TcxCheckBox;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    procedure OkButtonClick(Sender: TObject);
    procedure CerrarButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private

  protected
  class var
    CodigoEmpresa : String;
    Detected,
    UpdateAppDatabase : Boolean;

  public

    // GuardaCodigoEmpresa : String;
    CancelProcess : Boolean;
    EmpresaFields : TEmpresaFields;

    TableCount,
    CurrentTable,
    RecordCount,
    CurrentRecord  : LongInt;

    function DoUpdateProgress( ObjectName : String; Percent1, Percent2 : SmallInt ) : Boolean;

  end;

var BoxUpdForm : TBoxUpdForm = nil;

procedure UpdateDictionaries( CodigoEmpresa : String; Detected : Boolean );

implementation

{$R *.dfm}

uses  Files,
      DataAccess,
      EnterpriseDataAccess,
      LibUtils,
      
      AppManager,
      NexusRpcData,

      Gdm00Dm,

      dm_cnd,
      dm_pga,
      dm_upd,
      dm_usr,

      // b_uee,
      b_abo,
      b_msg;

resourceString
      RsMsg1  = 'No he podido crear el directorio [%s].';
      RsMsg2  = 'El proceso de actualización NO ha finalizado correctamente.';
      RsMsg3  = 'Póngase en contacto con su soporte técnico y notifíqueles el error mostrado. No es aconsejable que repita el proceso de actualización sin solucionar antes el origen del problema.';
      RsMsg4  = '¿Esta seguro de que desea interrumpir el proceso de actualización de sus ficheros?';
      RsMsg5  = 'El proceso de actualización ha finalizado correctamente.';
      RsMsg6  = 'Ahora es necesario abandonar el programa para hacer efectivos los cambios realizados.';
      // RsMsg7  = '¿Desea actualizar los ficheros de TODAS las Empresas existentes?';
      // RsMsg8  = 'Recuerde que NO DEBE HABER NINGUN USUARIO trabajando en NINGUNA de las Empresas a actualizar.';
      RsMsg9  = 'Solo el USUARIO MAESTRO (Código 00) puede realizar el proceso de actualización.';
      RsMsg10 = 'Si desea realizar la actualización de los ficheros acceda a la aplicación como Usuario Maestro y reintente el proceso.';
      RsMsg11 = 'No se puede realizar el proceso de actualización desde una localización remota.';
      RsMsg12 = 'Sitúese en el servidor y reintente el proceso.';
      RsMsg13 = 'Se ha detectado la presencia de un fichero que pertenece (probablemente) a una VERSION ANTERIOR del producto.';
      RsMsg14 = 'Actualización automática de todos los ficheros de la aplicación.';
      RsMsg15 = 'Ficheros de la Empresa %s.';
      RsMsg16 = 'Es necesario realizar una actualización de la base de datos, pero no se puede realizar desde una localización remota.';
      // RsMsg17 = '¿Desea que se actualice la contabilidad de sus Empresas al nuevo PGC 2008?';
      // RsMsg18 = 'Este proceso puede ser realizado posteriormente en cualquier momento.'#13'Si no tiene claro el cometido de esta operación no la realice.';
      // RsMsg19 = 'MUY IMPORTANTE : antes de realizar el proceso debe asegurarse de que dispone de la última versión de GESTWIN. Utilice el programa de "Actualización en línea" para comprobarlo.';
      {
      RsMsg20 = 'Se ha detectado una tabla que tiene una página de códigos diferente.';
      RsMsg21 = 'Cuando se trasladan los ficheros de un sistema a otro con una configuración de idioma diferente (NLS) es necesario compactar las mismas para adaptarlas al nuevo entorno.';
      }
      RsMsg22 = 'No se puede actualizar la base de datos de una versión de evaluación.';
      RsMsg23 = 'Si desea trabajar con una versión nueva debe ponerse en contacto con su distribuidor y adquirir una copia completa de GESTWIN.';


var   AutomaticDetection   : Boolean = False;
      ProcessStarted       : Boolean = False;

procedure UpdateDictionaries( CodigoEmpresa : String;
                              Detected      : Boolean );

var   FormResult : TModalResult;

begin

     If   ( ApplicationContainer.CanCloseAllForms( False )<>mrOk ) or ( Detected and UpdatingDictionaries )
     then begin
          If   Detected
          then PrgExit( False, True );
          Exit;
          end;

     With ApplicationContainer do
       If   Assigned( AboutForm )
       then FreeAndNil( AboutForm );

     If   Assigned( MsgBoxForm )
     then FreeAndNil( MsgBoxForm );

     If   ( CodigoEmpresa<>'' ) and                       // Se ha seleccionado una Empresa
          not UsuarioMaestro                              // Solo el usuario maestro puede actualizar
     then begin
          ShowNotification( ntStop, RsMsg9, RsMsg10 );
          If   Detected
          then begin
               PrgExit( False, True );
               Abort;
               end;
          Exit;
          end;

     {
     If   SpEvaluation and not UnprotectedApp
     then begin
          ShowNotification( ntStop, RsMsg22, RsMsg23 );
          PrgExit( False, True );
          Abort;
          end;
     }

     CloseAllDataModules( {IncludingPersistentOnes } True );

     UpdatingDictionaries := True;
     AutomaticDetection := Detected;

     TBoxUpdForm.CodigoEmpresa := CodigoEmpresa;
     TBoxUpdForm.Detected := Detected;
     TBoxUpdForm.UpdateAppDatabase := True;

     try
       Application.CreateForm( TBoxUpdForm, BoxUpdForm );
       If   Assigned( BoxUpdForm )
       then try
              If   Detected
              then BoxUpdForm.TitleLabel.Caption := RsMsg13
              else BoxUpdForm.TitleLabel.Caption := RsMsg14;
              try
                FormResult := BoxUpdForm.ShowModal;
              except
                end;
            finally
              BoxUpdForm.Free;
              end;

     finally
       UpdatingDictionaries := False;
       If   Detected or ProcessStarted
       then PrgExit( False )
       else DataModule00.OpenGlobalFiles;
       end;
end;

procedure TBoxUpdForm.FormDestroy(Sender: TObject);
begin
     BoxUpdForm := nil;
     PrgExit( False, True );
end;

function TBoxUpdForm.DoUpdateProgress( ObjectName : String;
                                       Percent1,
                                       Percent2   : SmallInt ) : Boolean;
begin
     If   Percent2=0  // Inicialización
     then begin
          If   Percent1>=0                     // Cuando solo se tiene que actualizar la barra de la tabla
          then DictionaryProgressBar.Position := Percent1;
          FicheroLabel.Caption := ObjectName;  // En este caso, el nombre de la tabla
          FileProgressBar.Position := 0;
          end
     else FileProgressBar.Position := Percent2;
     Application.ProcessMessages;
     Result := CancelProcess;
end;

procedure TBoxUpdForm.OkButtonClick(Sender: TObject);

var  ErrorMessage : String;
      
begin

     CerrarButton.GlyphBitmap := gmCancel;
     CerrarButton.Caption := '&Cancelar';
     CerrarButton.SetFocus;
     OkButton.Enabled := False;

     ProcessStarted := True;

     try

       NexusRpc.OnProgress := DoUpdateProgress;

       PageControl.ActivePage := TabSheet2;
       Application.ProcessMessages;

       ProcesoLabel.Caption := RsgMsg402;

       If   UpdateAppDatabase
       then Actualizacion.UpdateDatabase( '' );   // Si no se puede actualizar la base de datos global, no seguimos (por eso no hay try..except)

       EmpresaTable.Open;
       EmpresaFields := TEmpresaFields.Create( EmpresaTable );

       With EmpresaTable do
         begin

         If   TodasLasEmpresasCtrl.Checked
         then SetRange( [ '' ], [ HighStrCode ] )
         else If   CodigoEmpresa=''
              then Exit
              else SetRange( [ CodigoEmpresa ], [ CodigoEmpresa ] );

         First;
         While not Eof and not CancelProcess do
           begin

           ProcesoLabel.Caption := Format( RsMsg15, [ EmpresaFields.Codigo.Value ] );
           try
             Actualizacion.UpdateDatabase( EmpresaFields.Codigo.Value );
           except on E : Exception do
               begin

               If   ( E is EAbort ) or E.Message.Contains( '[EAbort]' )  // Pueder ser un EnxBaseException del servidor debido a un Abort
               then ErrorMessage := ''
               else ErrorMessage := E.Message + HtmlCR;
               StrAdd( ErrorMessage, RsMsg3 );
               ShowNotification( ntError, RsMsg2, ErrorMessage );

               // A solicitud del departamento técnico, opto por seguir con la adaptación de la siguiente Empresa y no aborto el proceso
               // si se ha producido un error. Si es una cancelación del usuario se detiene la actualización.

               // Abort;
               
               end;
             end;

           Next;
           end;

         end;

       ShowNotification( ntInformation, RsMsg5, RsMsg6 );

     finally
       NexusRpc.OnProgress := nil;
       end;
end;


procedure TBoxUpdForm.CerrarButtonClick(Sender: TObject);
begin
     If   PageControl.ActivePage=TabSheet2
     then If   ShowNotification( ntQuestionWarning, RsMsg4, '' )=mrYes
          then CancelProcess := True;
end;

procedure Initialize;
begin
     ApplicationContainer.OnUpdateDatabase := UpdateDictionaries;
end;

initialization
    AddProcedure( imInitialize, 0, Initialize, True );
end.


