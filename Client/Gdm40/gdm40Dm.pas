
{$TYPEINFO ON}   // Rtti

unit gdm40Dm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,

  nxllComponent,
  nxsdTableMapperDescriptor,
  nxsdRecordMapperDescriptor,
  nxsdDataDictionary,
  nxdb,
  DataManager,
  DataAccess,
  DB,
  Sqlset,

  Gim00Fields;

type
  TDataModule40 = class(TDataModule)
    Dictionary: TnxeDatabaseDictionary;
    SQLSet: TgxSQLSet;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
  public
    function GetSQL( Title : string ) : string;
  end;

function DataModule40 : TDataModule40;

implementation

uses  Variants,
      Files,
      AppManager,
      EnterpriseDataAccess,

      nxdbBase,
      nxllBde,
      nxsdFieldMapperDescriptor,

      b_upd,
      b_msg,

      dm_pga,
      dm_mov,
      dm_hdc;

{$R *.dfm}

var FDataModule40: TDataModule40 = nil;

function DataModule40 : TDataModule40;
begin
     If   not Assigned( FDataModule40 )
     then CreateDataModule( TDataModule40, FDataModule40 );
     Result := FDataModule40;
end;

procedure initialize;
begin
     DataModule40;
end;

procedure TDataModule40.DataModuleCreate(Sender: TObject);
begin
     SetupDatabaseDictionary( Dictionary );
end;

procedure TDataModule40.DataModuleDestroy(Sender: TObject);
begin
     FDataModule40 := nil;
end;

function TDataModule40.GetSQL( Title : string ) : string;
begin
     Result := SQLSet.GetSQLText( Title );
end;


initialization
   AddProcedure( imStartup, 0, Initialize );

end.


