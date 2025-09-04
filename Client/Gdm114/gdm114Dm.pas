
{$TYPEINFO ON}   // Rtti

unit gdm114Dm;

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
  TDataModule114 = class(TDataModule)
    Dictionary: TnxeDatabaseDictionary;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

function DataModule114 : TDataModule114;

implementation

uses  AppForms,
      AppManager,
      DataAccess,
      EnterpriseDataAccess;

{$R *.dfm}

var FDataModule114: TDataModule114 = nil;

function DataModule114 : TDataModule114;
begin
     If   not Assigned( FDataModule114 )
     then CreateDataModule( TDataModule114, FDataModule114 );
     Result := FDataModule114;
end;

procedure Initialize;
begin
     DataModule114;
end;

procedure TDataModule114.DataModuleCreate(Sender: TObject);
begin
     SetupDatabaseDictionary( Dictionary );
end;

procedure TDataModule114.DataModuleDestroy(Sender: TObject);
begin
     FDataModule114 := nil;
end;

initialization

     AddProcedure( imOptionalSectionModule, 114 );
     AddProcedure( imStartup, 0, Initialize );

end.

