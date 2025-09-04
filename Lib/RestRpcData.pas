unit RestRpcData;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls,

  LibUtils,

  AppManager,

  clHttpRequest,
  clTcpClient,
  clTcpClientTls,
  clHttp,
  clJSON;

const  HTTP_RESULT_OK = 200;

type

  TRestRpcDataModule = class( TDataModule )
    HttpRequest: TclHttpRequest;
    Http: TclHttp;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);

  private

    FError : Boolean;
    FErrors : TclJSONObject;
    FErrorCode : String;
    FErrorMessage : String;
    FRequest,
    FResponse : TStringList;
    FResponseJSON,
    FLastResponseJSON : TclJSONBase;
    FResponseJSONObject : TclJSONObject;
    FResponseJSONArray : TclJSONArray;
    FHost,
    FUserName,
    FPassword,
    FAuthorization,
    FResponseText : String;
    FResponseIsJSON : Boolean;

    procedure SetAuthorization(const Value: String);
    function ParseResponse( Preserve : Boolean = False ) : Boolean;

  public

    function Get( const AUrl : String; PreserveResponse : Boolean = False ) : Boolean;
    function Post( const AUrl : String; Value : TclJSONBase; PreserveResponse : Boolean = False ) : Boolean; overload;
    function Post( const AUrl : String; Value : String; PreserveResponse : Boolean = False ) : Boolean; overload;
    function Put( const AUrl : String; Value : TclJSONBase; PreserveResponse : Boolean = False ) : Boolean;
    function Delete( const AUrl : String ) : Boolean;

    property Error : Boolean read FError;
    property Errors : TclJSONObject read FErrors;
    property ErrorCode : String read FErrorCode write FErrorCode;
    property ErrorMessage : String read FErrorMessage write FErrorMessage;
    property ResponseText : String read FResponseText;
    property ResponseJSON : TclJSONBase read FResponseJSON;
    property ResponseJSONObject : TclJSONObject read FResponseJSONObject;
    property ResponseJSONArray : TclJSONArray read FResponseJSONArray;
    property ResponseIsJSON : Boolean read FResponseIsJSON;
    property Host : String read FHost write FHost;
    property UserName : String read FUserName write FUserName;
    property Password : String read FPassword write FPassword;
    property Authorization : String read FAuthorization write SetAuthorization;
  end;

function RestRpc : TRestRpcDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

const JsonContentType = 'application/json';
      TextContentType = 'text/plain';

var   RestRpcDataModule: TRestRpcDataModule = nil;


function RestRpc : TRestRpcDataModule;
begin
     If   not Assigned( RestRpcDataModule )
     then RestRpcDataModule := TRestRpcDataModule.Create( Application );
     Result := RestRpcDataModule;
end;

procedure TRestRpcDataModule.DataModuleCreate(Sender: TObject);
begin
     RestRpcDataModule := Self;
     FResponse := TStringList.Create();
     FRequest := TStringList.Create();
end;

procedure TRestRpcDataModule.DataModuleDestroy(Sender: TObject);
begin
     FreeAndNil( FLastResponseJSON );
     FreeAndNil( FRequest );
     FreeAndNil( FResponse );
     RestRpcDataModule := nil;
end;

procedure TRestRpcDataModule.SetAuthorization( const Value : String );
begin
     FAuthorization := Value;

     Http.Server := FHost;
     Http.Username := FUserName;
     Http.Password := FPassword;
     Http.Authorization := FAuthorization;
     Http.SilentHTTP := True;

end;

function TRestRpcDataModule.Delete( const AUrl: String ) : Boolean;
begin
     Http.Delete( AUrl );
     Result := Http.StatusCode=HTTP_RESULT_OK;
end;

function TRestRpcDataModule.ParseResponse( Preserve : Boolean = False ) : Boolean;
begin

     FreeAndNil( FLastResponseJSON );

     FResponseJSONObject := nil;  // Son los mismos objetos que FResponseJSON pero con el tipo ajustado
     FResponseJSONArray := nil;
     FResponseIsJSON := False;

     FError := Http.StatusCode<>HTTP_RESULT_OK;
     FResponseText := StringReplace( FResponse.Text, #13#10, '', [ rfReplaceAll, rfIgnoreCase ] );

     If   Http.ResponseHeader.ContentType=JSONContentType
     then try

            FResponseJSON := TclJSONBase.Parse( FResponse.Text );
            FResponseIsJSON := True;

            // Si no se quiere preservar el objecto éste se destruirá en la próxima llamada a esta función

            If   not Preserve
            then FLastResponseJSON := FResponseJSON;

            If   FResponseJSON is TclJSONObject
            then FResponseJSONObject := TclJSONObject( FResponseJSON )
            else If   FResponseJSON is TclJSONArray
                 then FResponseJSONArray := TclJSONArray( FResponseJSON );

            If   FError and Assigned( FResponseJSONObject )
            then begin
                 FErrors := FResponseJSONObject.ObjectByName( 'errors' );
                 If   Assigned( FErrors )
                 then FErrorCode := FErrors.ValueByName( 'code' )
                 else FErrorCode := '';
                 end;

     except
       end;

     Result := not FError;

end;

{  Si se quiere que el objeto de respuesta (FResponseJSON) no se destruya en la siguiente llamada a ParseResponse
   se puede pasar una clase TclJSONBase inicializado a las funciones de llamada. Por supuesto es responsabilidad
   de quien las utilice el destruir la clase.
   }

function TRestRpcDataModule.Get( const AUrl             : String;
                                       PreserveResponse : Boolean = False ) : Boolean;
begin
     FResponse.Clear;
     Http.Get( AUrl, HttpRequest, FResponse );
     Result := ParseResponse( PreserveResponse );
end;

function TRestRpcDataModule.Post( const AUrl             : String;
                                        Value            : TclJSONBase;
                                        PreserveResponse : Boolean = False ) : Boolean;
begin
     FResponse.Clear;
     HttpRequest.BuildJSONRequest( Value );
     Http.Post( AUrl, HttpRequest, FResponse );
     Result := ParseResponse( PreserveResponse );
end;

function TRestRpcDataModule.Post( const AUrl             : String;
                                        Value            : String;
                                        PreserveResponse : Boolean = False ) : Boolean;
begin
     FResponse.Clear;

     With HttpRequest do
       begin
       Clear;
       AddTextData( Value );
       Header.ContentType := 'text/plain';
       Header.CharSet := 'utf-8';
       end;

     Http.Post( AUrl, HttpRequest, FResponse );
     Result := ParseResponse( PreserveResponse );

end;

function TRestRpcDataModule.Put( const AUrl             : String;
                                       Value            : TclJSONBase;
                                       PreserveResponse : Boolean = False ) : Boolean;
begin
     FResponse.Clear;
     HttpRequest.BuildJSONRequest( Value );
     Http.Put( AUrl, HttpRequest.Header.ContentType, HttpRequest.RequestSource, FResponse );
     Result := ParseResponse( PreserveResponse );
end;

end.


