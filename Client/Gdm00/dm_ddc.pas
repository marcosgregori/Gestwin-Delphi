unit dm_ddc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  AppContainer,

  AppForms,

  DB,
  nxdb,
  DataManager,

  Gim00Fields;


type
  TTipoDireccion = ( tdIndividual, tdGrupo, tdAmbos );

  TDireccionModule = class(TDataModule)
    DmDireccionCorreoTable: TnxeTable;
    DmDireccionCorreoTableCodigo: TWideStringField;
    DmDireccionCorreoTableNombre: TWideStringField;
    DmDireccionCorreoTableEsUnGrupo: TBooleanField;
    DmDireccionCorreoTableEMail: TWideStringField;
    DmDireccionCorreoTableGrupo: TWideStringField;
    procedure DmDireccionCorreoTableAfterOpen(DataSet: TDataSet);
    procedure DireccionModuleDestroy(Sender: TObject);
  private

    DmDireccionCorreoFields : TDireccionCorreoFields;

  public

    procedure Valida( EditControl : TcxCustomEdit; TipoDireccion : TTipoDireccion; var DisplayValue : Variant; var ErrorText: TCaption; var Error: Boolean; DireccionCorreoFields : TDireccionCorreoFields = nil; IsInfoControl : Boolean = False );
    function  Descripcion( Codigo : String; NotificaSiNoExiste : boolean ) : string;
    procedure CompruebaEMail( var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean );
    procedure Redacta( DireccionCorreo : String );
    function DireccionValida(Value: String): Boolean;
  end;

var  DireccionModule: TDireccionModule = nil;

function  DireccionCorreo : TDireccionModule;

implementation

uses LibUtils,
     ShellAPI,
     AppManager,
     DataAccess;

{$R *.dfm}

resourceString
     RsMsg1 = 'Seleccione un destinatario, no un grupo.';
     RsMsg2 = 'Seleccione un grupo, no un destinatario de correo.';
     RsMsg3 = 'Estructura de la dirección de correo incorrecta.';
     RsMsg4 = 'Las direcciones de correo son del tipo usuario@dominio. Por ejemplo : ventas@gestwin.com.';
     RsMsg5 = 'Debe introducir una dirección de correo válida.';

function DireccionCorreo : TDireccionModule;
begin
     CreateDataModule( TDireccionModule, DireccionModule );
     Result := DireccionModule;
end;

procedure TDireccionModule.DireccionModuleDestroy(Sender: TObject);
begin
     DireccionModule := nil;
end;

procedure TDireccionModule.DmDireccionCorreoTableAfterOpen(
  DataSet: TDataSet);
begin
     DmDireccionCorreoFields := TDireccionCorreoFields.Create( DmDireccionCorreoTable );
end;

procedure TDireccionModule.Valida(     EditControl            : TcxCustomEdit;
                                       TipoDireccion         : TTipoDireccion;
                                   var DisplayValue          : Variant;
                                   var ErrorText             : TCaption;
                                   var Error                 : Boolean;
                                       DireccionCorreoFields : TDireccionCorreoFields = nil;
                                       IsInfoControl         : Boolean = False );
begin
     If   DisplayValue=''
     then begin
          EditControl.Description := '<Ninguno>';
          If   Assigned( DireccionCorreoFields )
          then DireccionCorreoFields.Clear( DmDireccionCorreoTable );
          end
     else begin
          ValidateRelationEx( EditControl, DmDireccionCorreoTable, [ DisplayValue ], DisplayValue, ErrorText, Error, DireccionCorreoFields, 'Nombre', IsInfoControl );
          If   ( TipoDireccion=tdIndividual ) and DmDireccionCorreoTableEsUnGrupo.Value
          then begin
               Error     := True;
               ErrorText := RsMsg1;
               end
          else If   ( TipoDireccion=tdGrupo ) and not DmDireccionCorreoTableEsUnGrupo.Value
               then begin
                    Error := True;
                    ErrorText := RsMsg2;
                    end;
          end;
end;

function TDireccionModule.Descripcion( Codigo : String; NotificaSiNoExiste : Boolean ) : String;
begin
     GetRelationDescription( DmDireccionCorreoTable, [ Codigo ], Result, NotificaSiNoExiste );
end;

function TDireccionModule.DireccionValida( Value : String ) : Boolean;
begin
      // mi@dom.com
      Result := ( Length( Value )>8 ) and ( Pos( '@', Value  )>2 ) and ( RightPos( '.', Value )>5 );
end;

procedure TDireccionModule.CompruebaEMail( var DisplayValue : Variant;
                                           var ErrorText    : TCaption;
                                           var Error        : Boolean );
begin


     If   not ValueIsEmpty( DisplayValue )
     then If   not DireccionCorreo.DireccionValida( DisplayValue )
          then begin
               ErrorText := JoinMessage( RsMsg3, RsMsg4 );
               Error := True;
               end;
end;

procedure TDireccionModule.Redacta( DireccionCorreo : String );
begin
     If   ValueIsEmpty( DireccionCorreo )
     then ShowNotification( ntStop, RsMsg5, '' )
     else ShellExecute( 0, 'open', PChar( 'mailto:' + DireccionCorreo ), '', '', SW_NORMAL );
end;

end.
