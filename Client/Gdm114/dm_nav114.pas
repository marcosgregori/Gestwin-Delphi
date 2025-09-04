unit dm_nav114;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  AppContainer,

  AppForms,

  DB, nxdb, DataManager,

  Gim114Fields,
  
  Gdm114Dm;


type
  TNavieraModule = class(TDataModule)
    DmNavieraTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    DmNavieraFields  : TNavieraFields;

  public
    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean;IsInfoControl : Boolean = False );
    function  Descripcion( Codigo : String; NotificaSiNoExiste : boolean ) : string;
  end;

var
  NavieraModule: TNavieraModule = nil;


function  Naviera : TNavieraModule;

implementation

uses AppManager,

     EnterpriseDataAccess;

{$R *.DFM}

function Naviera : TNavieraModule;
begin
     CreateDataModule( TNavieraModule, NavieraModule );
     Result := NavieraModule;
end;

procedure TNavieraModule.Valida(     EditControl   : TcxCustomEdit;
                                 var DisplayValue  : Variant;
                                 var ErrorText     : TCaption;
                                 var Error         : Boolean;
                                     IsInfoControl : Boolean = False );
begin
     ValidateRelation( EditControl, DmNavieraTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, 'Nombre', IsInfoControl );
end;

procedure TNavieraModule.DataModuleCreate(Sender: TObject);
begin
     DmNavieraFields := TNavieraFields.Create( DmNavieraTable );
end;

procedure TNavieraModule.DataModuleDestroy(Sender: TObject);
begin
     NavieraModule := nil;
end;

function TNavieraModule.Descripcion( Codigo             : String;
                                     NotificaSiNoExiste : Boolean ) : string;
begin
     GetRelationDescription( DmNavieraTable, [ Codigo ], Result, NotificaSiNoExiste );
end;

end.
