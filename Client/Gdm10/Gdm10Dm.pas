{$TYPEINFO ON}   // Rtti

unit Gdm10Dm;

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
  DB,
  Sqlset,
  DataAccess,

  Gim10Fields;

type
  TDataModule10 = class(TDataModule)
    Dictionary: TnxeDatabaseDictionary;
    SQLSet: TgxSQLSet;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

  protected
    procedure DoOnBackupFileProcessed( ProgMessage : String = ''; Percent : Integer = -1 );
    procedure DoOnCopyFile( SourceName, TargetName : String );

  public
    function GetSQL( Title : string ) : string;

  end;

function DataModule10 : TDataModule10;


implementation

uses  LibUtils,
      DateUtils,
      Variants,
      Files,
      AppManager,
      EnterpriseDataAccess,

      nxdbBase,
      nxllBde,
      nxsdTypes,
      nxsdFieldMapperDescriptor,
      nxsdDataDictionaryStrings,

      // ReportManager,

      Gim00Fields,

      dm_pga,
      dm_sal,
      dm_sub,

      b_pro,
      b_msg,
      b_upd,

      cxEdit;

{$R *.dfm}

var FDataModule10: TDataModule10 = nil;

resourceString
    RsMsg1 = 'No se ha podido realizar el ajuste de las subcuentas de efectos comerciales en cartera';
    RsMsg2 = 'Se ha producido un error al realizar los ajustes adicionales de las tablas';

function DataModule10 : TDataModule10;
begin
     If   not Assigned( FDataModule10 )
     then CreateDataModule( TDataModule10, FDataModule10 );
     Result := FDataModule10;
end;

procedure Initialize;
begin
     DataModule10;
end;

procedure TDataModule10.DataModuleCreate(Sender: TObject);
begin

     SetupDatabaseDictionary( Dictionary );

     DataAccessModule.AddRestrictedTables( [ 'Asiento', 'EfectoCobrar', 'EfectoPagar', 'Remesa', 'RemesaPago' ] );

end;

procedure TDataModule10.DataModuleDestroy(Sender: TObject);
begin
     FDataModule10 := nil;
end;

procedure TDataModule10.DoOnBackupFileProcessed( ProgMessage : String = '';
                                                 Percent     : Integer = -1 );
begin
     With BoxUpdForm do
       begin
       FicheroLabel.Caption := ProgMessage;
       FileProgressBar.Position := Percent;
       end;
     Application.ProcessMessages;
end;

procedure TDataModule10.DoOnCopyFile( SourceName, TargetName : String );
begin
     BoxUpdForm.FicheroLabel.Caption := SourceName;
     Application.ProcessMessages;
end;

function TDataModule10.GetSQL( Title : string ) : string;
begin
     Result := SQLSet.GetSQLText( Title );
end;

initialization
   AddProcedure( imStartup, 0, Initialize );

end.
