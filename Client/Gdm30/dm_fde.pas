
unit dm_fde;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, cxEdit,
  AppContainer,

  AppForms,
  DB,
  nxdb,
  DataManager,

  Gim30Fields;

type
  TFormaEnvioModule = class(TDataModule)
    DmFormaEnvioTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

    FFormaEnvioFields : TFormaEnvioFields;

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean;IsInfoControl : Boolean = False; CheckRestriction : Boolean = True );
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : string;
    function  Obten( Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;

    property FormaEnvioFields : TFormaEnvioFields read FFormaEnvioFields;
  end;

  TipoPortes = ( fePagados = 0, feDebidos=1 );

var FormaEnvioModule: TFormaEnvioModule = nil;

function FormaEnvio : TFormaEnvioModule;

implementation

uses AppManager,
     LibUtils,

     EnterpriseDataAccess,

     Gim00Fields,

     b_msg;

{$R *.DFM}

resourceString
    RsMsg2  = 'La forma de envío de código [%s] no existe.';

function FormaEnvio : TFormaEnvioModule;
begin
     CreateDataModule( TFormaEnvioModule, FormaEnvioModule );
     Result := FormaEnvioModule;
end;

procedure TFormaEnvioModule.Valida(     EditControl      : TcxCustomEdit;
                                    var DisplayValue     : Variant;
                                    var ErrorText        : TCaption;
                                    var Error            : Boolean;
                                        IsInfoControl    : Boolean = False;
                                        CheckRestriction : Boolean = True );
begin
     ValidateRelationEx( EditControl, DmFormaEnvioTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

procedure TFormaEnvioModule.DataModuleCreate(Sender: TObject);
begin
     FFormaEnvioFields := TFormaEnvioFields.Create( DmFormaEnvioTable );
end;

procedure TFormaEnvioModule.DataModuleDestroy(Sender: TObject);
begin
     FormaEnvioModule := nil;
end;

function TFormaEnvioModule.Descripcion( Codigo             : String;
                                        NotificaSiNoExiste : Boolean = True ) : string;
begin
     GetRelationDescription( DmFormaEnvioTable, [ Codigo ], Result, NotificaSiNoExiste, RsDescripcion );
end;

function  TFormaEnvioModule.Obten( Codigo             : String;
                                   NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmFormaEnvioTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg2, [ Codigo ] ), '' );
          Abort;
          end;
end;

end.

