{$TYPEINFO ON}   // Rtti

unit gdm203Dm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,

  nxllComponent,
  DB,
  nxdb,
  DataManager;

type
  TDataModule203 = class(TDataModule)
    Dictionary: TnxeDatabaseDictionary;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var  DataModule203 : TDataModule203 = nil;

implementation

uses  AppForms,
      AppManager,
      DataAccess,
      EnterpriseDataAccess;

{$R *.dfm}

procedure Initialize;
begin
     CreateDataModule( TDataModule203, DataModule203 );
end;

procedure TDataModule203.DataModuleCreate(Sender: TObject);
begin
     SetupDatabaseDictionary( Dictionary );
end;

procedure TDataModule203.DataModuleDestroy(Sender: TObject);
begin
     DataModule203 := nil;
end;

initialization
     AddProcedure( imStartup, 0, Initialize );

end.

