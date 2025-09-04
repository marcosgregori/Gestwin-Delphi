
{$TYPEINFO ON}   // Rtti

unit Gdm119Dm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,

  nxllComponent,
  DB,
  nxdb,
  DataManager,
  LibUtils;

type
  TDataModule119 = class(TDataModule)
    Dictionary: TnxeDatabaseDictionary;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

function DataModule119 : TDataModule119;

implementation

uses  AppForms,
      AppManager,
      DataAccess,
      EnterpriseDataAccess;

{$R *.dfm}

var FDataModule119: TDataModule119 = nil;

function DataModule119 : TDataModule119;
begin
     If   not Assigned( FDataModule119 )
     then CreateDataModule( TDataModule119, FDataModule119 );
     Result := FDataModule119;
end;

procedure Initialize;
begin
     DataModule119;
end;

procedure TDataModule119.DataModuleCreate(Sender: TObject);
begin
     SetupDatabaseDictionary( Dictionary );
end;

procedure TDataModule119.DataModuleDestroy(Sender: TObject);
begin
     FDataModule119 := nil;
end;

initialization

     AddProcedure( imStartup, 0, Initialize );

end.

