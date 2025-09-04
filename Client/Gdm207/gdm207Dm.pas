
{$TYPEINFO ON}   // Rtti

unit gdm207Dm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,

  nxllComponent,
  DB,
  nxdb,
  DataManager;

type
  TDataModule207 = class(TDataModule)
    Dictionary: TnxeDatabaseDictionary;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var  DataModule207 : TDataModule207 = nil;

implementation

uses  AppForms,
      AppManager,
      DataAccess,
      EnterpriseDataAccess;

{$R *.dfm}

procedure Initialize;
begin
     CreateDataModule( TDataModule207, DataModule207 );
end;

procedure TDataModule207.DataModuleCreate(Sender: TObject);
begin
     SetupDatabaseDictionary( Dictionary );
end;

procedure TDataModule207.DataModuleDestroy(Sender: TObject);
begin
     DataModule207 := nil;
end;

initialization
     AddProcedure( imStartup, 0, Initialize );

end.

