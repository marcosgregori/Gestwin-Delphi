unit dm_tra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  AppContainer,

  AppForms,

  DB, nxdb, DataManager,

  Gim30Fields;


type
  TTransportistaModule = class(TDataModule)
    DmTransportistaTable: TnxeTable;
    procedure TransportistaModuleDestroy(Sender: TObject);
    procedure TransportistaModuleCreate(Sender: TObject);
  private

    FTransportistaFields  : TTransportistaFields;

  public

    function  Obten( Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;
    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean;IsInfoControl : Boolean = False );
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : string;

    property TransportistaFields : TTransportistaFields read FTransportistaFields;
  end;

var  TransportistaModule: TTransportistaModule = nil;

function  Transportista : TTransportistaModule;

implementation

uses AppManager,
     EnterpriseDataAccess,

     b_msg;
{$R *.DFM}
resourceString
     RsMsg1 = 'El transportista de código [%s] no existe.';

function Transportista : TTransportistaModule;
begin
     CreateDataModule( TTransportistaModule, TransportistaModule );
     Result := TransportistaModule;
end;

procedure TTransportistaModule.transportistaModuleDestroy(Sender: TObject);
begin
     TransportistaModule := nil;
end;

procedure TTransportistaModule.Valida(     EditControl   : TcxCustomEdit;
                                       var DisplayValue  : Variant;
                                       var ErrorText     : TCaption;
                                       var Error         : Boolean;
                                           IsInfoControl : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmTransportistaTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsNombre, IsInfoControl );
end;

function  TTransportistaModule.Obten( Codigo             : String;
                                      NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmTransportistaTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), '' );
          Abort;
          end;
end;
function TTransportistaModule.Descripcion( Codigo             : String;
                                           NotificaSiNoExiste : Boolean = True ) : String;
begin
     GetRelationDescription( DmtransportistaTable, [ Codigo ], Result, NotificaSiNoExiste );
end;

procedure TTransportistaModule.TransportistaModuleCreate(Sender: TObject);
begin
     FTransportistaFields := TTransportistaFields.Create( DmTransportistaTable );
end;

end.
