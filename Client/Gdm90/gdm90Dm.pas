
{$TYPEINFO ON}   // Rtti

unit Gdm90Dm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  nxllComponent, 
  nxsdTableMapperDescriptor,
  nxsdRecordMapperDescriptor,
  nxsdDataDictionary,
  DB, nxdb, DataManager, AppContainer, DataAccess;

type
  TDataModule90 = class(TDataModule)
    Dictionary: TnxeDatabaseDictionary;
    MasterRecoverTable: TnxeTable;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure DoReestructureTareaTable( EventType : TReestructureEventType; var ReestructureData : TReestructureData );
  public

  end;

  // Tablas

function DataModule90 : TDataModule90;

implementation

uses  AppManager,
      AppForms,

      EnterpriseDataAccess,

      Gim90Fields;

{$R *.dfm}

var FDataModule90: TDataModule90 = nil;

function DataModule90 : TDataModule90;
begin
     If   not Assigned( FDataModule90 )
     then CreateDataModule( TDataModule90, FDataModule90 );
     Result := FDataModule90;
end;

procedure Initialize;
begin
     DataModule90;
end;

procedure TDataModule90.DataModuleCreate(Sender: TObject);
begin
     With DataAccessModule do
       begin
       SetupDatabaseDictionary( Dictionary );
       AddReestructureNotification( 'Tarea', DoReestructureTareaTable );
       end;
end;

procedure TDataModule90.DataModuleDestroy(Sender: TObject);
begin
     FDataModule90 := nil;
end;

procedure TDataModule90.DoReestructureTareaTable(     EventType        : TReestructureEventType;
                                                  var ReestructureData : TReestructureData );

var  TareaFields : TTareaFields;
     Bm : TBookMark;
     Hour,
     Min : Integer;

begin

     case EventType of
       reAfter : If   not FieldExists( ReestructureData.OldDictionary, 'Duracion' )   // No existe el campo Duracion
                 then try

                        With MasterRecoverTable do
                          begin
                          TableName := 'Tarea';
                          IndexFieldNames := '';
                          Open;
                          end;

                        With MasterRecoverTable do
                          begin

                          TareaFields := TTareaFields.Create( MasterRecoverTable );

                          With MasterRecoverTable do
                            begin
                            First;
                            While not Eof do
                              begin

                              With TareaFields do
                                If   Tiempo.Value>0
                                then try
                                       Edit;

                                       Hour := Tiempo.Value div 3600;
                                       Min := ( Tiempo.Value div 60 ) - ( Hour * 60 );

                                       Duracion.Value := EncodeTime( Hour, Min, 0, 0 );
                                       Post;
                                     except
                                       Cancel;
                                       end;

                              Next;
                              end;

                            end;

                          end;

                      finally
                        MasterRecoverTable.Close;
                        end;
       end;
end;

initialization
     AddProcedure( imStartup, 0, Initialize );

end.
