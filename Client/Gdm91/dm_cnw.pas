
unit dm_cnw;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,

  AppForms,

  DB, nxdb, DataManager, cxEdit,

  Gim90Fields;


type
  TTipoRemitente = ( rmSoporte, rmVentas, rmAdministracion );

  TContactoWebModule = class(TDataModule)
    DmContactoWebTable: TnxeTable;
    procedure ContactoWebModuleDestroy(Sender: TObject);
    procedure ContactoWebModuleCreate(Sender: TObject);
  private

    NombreFichero,
    NombreAplicacion,
    LineText,
    BodyText : String;

    function ObtenNombreAplicacion( Value : SmallInt ) : String;
  public

    DmContactoWebFields : TContactoWebFields;

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False );
    function Obten( Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean ) : String;

    function EnviaCorreo( ContactoWebFields : TContactoWebFields; FicheroMensaje, Asunto : String; Remitente : TTipoRemitente; MuestraAvisos : Boolean = True ) : Boolean;

  end;

var  ContactoWebModule: TContactoWebModule = nil;


function  ContactoWeb : TContactoWebModule;

implementation

{$R *.DFM}

uses  LibUtils,
      
      AppManager,

      clMailMessage,

      dmi_iex,

      dm_iex,

      b_msg;

resourceString
     RsMsg1  = 'El contacto de código [%s] ha sido dado de baja.';

     RsMsg2 = 'Se ha enviado el mensaje a la dirección de correo del contacto.';
     RsMsg3 = 'Se ha producido un error al enviar el mensaje.';
     // RsMsg4 = 'No se ha podido abrir el fichero HTML en la dirección %s.';
     RsMsg5 = 'Mensaje de error : %s.';

function ContactoWeb : TContactoWebModule;
begin
     CreateDataModule( TContactoWebModule, ContactoWebModule );
     Result := ContactoWebModule;
end;

procedure TContactoWebModule.ContactoWebModuleDestroy(Sender: TObject);
begin
     ContactoWebModule := nil;
end;

procedure TContactoWebModule.Valida(     EditControl   : TcxCustomEdit;
                                     var DisplayValue  : Variant;
                                     var ErrorText     : TCaption;
                                     var Error         : Boolean;
                                         IsInfoControl : Boolean = False );
begin
     ValidateRelation( EditControl, DmContactoWebTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, 'Nombre', IsInfoControl );
end;

function  TContactoWebModule.Obten( Codigo             : String;
                                       NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmContactoWebTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), '' );
          Abort;
          end;
end;

function TContactoWebModule.Descripcion( Codigo             : String;
                                         NotificaSiNoExiste : Boolean ) : String;
begin
     Result := '';
     If   DmContactoWebTable.FindKey( [ Codigo ] )
     then Result := DmContactoWebFields.Nombre.Value
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente;
end;

procedure TContactoWebModule.ContactoWebModuleCreate(Sender: TObject);
begin
     DmContactoWebFields :=  TContactoWebFields.Create( DmContactoWebTable );
end;

function TContactoWebModule.ObtenNombreAplicacion( Value : SmallInt ) : String;
begin
     case Value of
       0 : Result := 'Contable';
       1 : Result := 'Comercial';
       2 : Result := 'ContableComercial';
       3 : Result := 'TPV';
       4 : Result := 'Preventa';
       end
end;

function TContactoWebModule.EnviaCorreo( ContactoWebFields  : TContactoWebFields;
                                         FicheroMensaje,
                                         Asunto             : String;
                                         Remitente          : TTipoRemitente;
                                         MuestraAvisos      : Boolean = True ) : Boolean;

var  FromAddress,
     FromName,
     Contenido : String;
     MessageStream : TStringStream;
     MailMessage : TclMailMessage;

begin
     With ExportImport do
       begin

       Result := False;

       NombreFichero := ApplicationPath + 'reports_' + CodigoEmpresaActual + '\correo\' + FicheroMensaje + '.html';
       MessageStream := TStringStream.Create( '', TEncoding.UTF8, False );

       try

         try

           NombreAplicacion := ObtenNombreAplicacion( ContactoWebFields.AplicacionEvaluacion.Value );

           MessageStream.LoadFromFile( NombreFichero );

           Contenido := MessageStream.DataString;
           Contenido := StringReplace( Contenido, '{nombre}', ContactoWebFields.Nombre.Value, [ rfReplaceAll, rfIgnoreCase ] );
           Contenido := StringReplace( Contenido, '{aplicacion}', NombreAplicacion, [ rfReplaceAll, rfIgnoreCase ] );

           SMTPInit( tdContactoWeb,
                     [ ContactoWebFields.Nombre.Value, ContactoWebFields.EMail.Value ],
                     Format( Asunto, [ NombreAplicacion ] ),
                     Contenido,
                     [],
                     'text/html',
                     'html' );

           With OutgoingMailMessage do
             begin
              case Remitente of
                rmSoporte        : begin
                                   FromAddress := 'soporte@gestwin.com';
                                   FromName := 'Soporte - Winstation, S.L.'
                                   end;
                rmVentas         : begin
                                   FromAddress := 'ventas@gestwin.com';
                                   FromName := 'Ventas - Winstation, S.L.'
                                   end;
                rmAdministracion : begin
                                   FromAddress := 'administracion@gestwin.com';
                                   FromName := 'Administracion - Winstation, S.L.'
                                   end;
                end;

             From.FullAddress := FromAddress;
             // ReplyTo.FromName := FromAddress;

             SMTPSend;

             If   MuestraAvisos
             then ShowNotification( ntInformation, RsMsg2, '' );
             Result := True;
             end;

         except on E : Exception do
           If   MuestraAvisos
           then ShowNotification( ntError, RsMsg3, Format( RsMsg5, [ E.Message ] ) );
           end;

       finally
         MessageStream.Free;
         end;

       end;
end;

end.
