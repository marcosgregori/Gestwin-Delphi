
{$TYPEINFO ON}   // Rtti

unit gdm204Dm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,

  nxllComponent,
  DB,
  nxdb,
  DataManager;

type
  TDataModule204 = class(TDataModule)
    Dictionary: TnxeDatabaseDictionary;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var  DataModule204 : TDataModule204 = nil;

implementation

uses  AppForms,
      AppManager,
      DataAccess,
      EnterpriseDataAccess;

{$R *.dfm}

procedure Initialize;
begin
     CreateDataModule( TDataModule204, DataModule204 );
end;

procedure TDataModule204.DataModuleCreate(Sender: TObject);
begin
     SetupDatabaseDictionary( Dictionary );
end;

procedure TDataModule204.DataModuleDestroy(Sender: TObject);
begin
     DataModule204 := nil;
end;

initialization
     AddProcedure( imStartup, 0, Initialize );

end.

