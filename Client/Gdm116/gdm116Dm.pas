
{$TYPEINFO ON}   // Rtti

unit Gdm116Dm;

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
  TDataModule116 = class(TDataModule)
    Dictionary: TnxeDatabaseDictionary;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

function DataModule116 : TDataModule116;

implementation

uses  AppForms,
      AppManager,
      DataAccess,
      EnterpriseDataAccess;

{$R *.dfm}

var FDataModule116: TDataModule116 = nil;

function DataModule116 : TDataModule116;
begin
     If   not Assigned( FDataModule116 )
     then CreateDataModule( TDataModule116, FDataModule116 );
     Result := FDataModule116;
end;

procedure Initialize;
begin
     DataModule116;
end;

procedure TDataModule116.DataModuleCreate(Sender: TObject);
begin
     SetupDatabaseDictionary( Dictionary );
end;

procedure TDataModule116.DataModuleDestroy(Sender: TObject);
begin
     FDataModule116 := nil;
end;

initialization

     AddProcedure( imStartup, 0, Initialize );

end.

