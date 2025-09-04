
{$TYPEINFO ON}   // Rtti

unit Gdm70Dm;

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
  TDataModule70 = class(TDataModule)
    Dictionary: TnxeDatabaseDictionary;
    SQLSet: TgxSQLSet;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
  public
    function GetSQL( Title : string ) : string;
  end;

function DataModule70 : TDataModule70;

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

      dm_pga;

{$R *.dfm}

var FDataModule70: TDataModule70 = nil;

function DataModule70 : TDataModule70;
begin
     If   not Assigned( FDataModule70 )
     then CreateDataModule( TDataModule70, FDataModule70 );
     Result := FDataModule70;
end;

procedure initialize;
begin
     DataModule70;
end;

procedure TDataModule70.DataModuleCreate(Sender: TObject);
begin
     SetupDatabaseDictionary( Dictionary );
end;

procedure TDataModule70.DataModuleDestroy(Sender: TObject);
begin
     FDataModule70 := nil;
end;

function TDataModule70.GetSQL( Title : string ) : string;
begin
     Result := SQLSet.GetSQLText( Title );
end;


initialization
   AddProcedure( imStartup, 0, Initialize );

end.


