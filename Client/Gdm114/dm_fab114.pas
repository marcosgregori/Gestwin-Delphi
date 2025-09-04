unit dm_fab114;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  AppContainer,

  AppForms,

  DB, nxdb, DataManager,

  Gim114Fields,
  
  Gdm114Dm;


type
  TFabricaModule = class(TDataModule)
    DmFabricaTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

  public

    DmFabricaFields  : TFabricaFields;

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean;IsInfoControl : Boolean = False );
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : string;
    function  Obten( Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;
  end;

var
  FabricaModule: TFabricaModule = nil;


function  Fabrica : TFabricaModule;

implementation

uses LibUtils,
     AppManager,
     EnterpriseDataAccess;

{$R *.DFM}

resourceString
     RsMsg1 = 'La fábrica de código %s ha sido dada de baja.';

function Fabrica : TFabricaModule;
begin
     CreateDataModule( TFabricaModule, FabricaModule );
     Result := FabricaModule;
end;

procedure TFabricaModule.Valida(     EditControl   : TcxCustomEdit;
                                 var DisplayValue  : Variant;
                                 var ErrorText     : TCaption;
                                 var Error         : Boolean;
                                     IsInfoControl : Boolean = False );
begin
     ValidateRelation( EditControl, DmFabricaTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, 'Nombre', IsInfoControl );
end;

procedure TFabricaModule.DataModuleCreate(Sender: TObject);
begin
     DmFabricaFields := TFabricaFields.Create( DmFabricaTable );
end;

procedure TFabricaModule.DataModuleDestroy(Sender: TObject);
begin
     FabricaModule := nil;
end;

function TFabricaModule.Descripcion( Codigo             : String;
                                     NotificaSiNoExiste : Boolean = True ) : string;
begin
     GetRelationDescription( DmFabricaTable, [ Codigo ], Result, NotificaSiNoExiste );
end;

function  TFabricaModule.Obten( Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmFabricaTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), '' );
          Abort;
          end;
end;

end.
