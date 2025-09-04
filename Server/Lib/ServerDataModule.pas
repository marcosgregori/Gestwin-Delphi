unit ServerDataModule;

interface

uses Classes,
     SysUtils,
     Generics.Collections,

     DB,
     nxDB,

     DataManager,
     BaseServerContainer,
     MainData,
     EnterpriseData,
     BaseSessionData,
     SectionData,
     Sessionintf;

type TServerDataModule = class( TDataModule )
     private

       function GetEnterpriseDataModule: TEnterpriseDataModule;
       function GetMainDataModule: TMainDataModule;

       protected

       FOpenDatasetsOnCreate : Boolean;
       FSessionDataModule : TBaseSessionDataModule;
       FSectionDataModule : TSectionDataModule;

       CurrentTableName : String;
       TableRecordCount,
       CurrentRecNum,
       LastPercent : LongInt;

       public

       constructor Create( AOwner : TComponent ); override;
       destructor Destroy; override;

       procedure OpenDatasets;
       procedure CloseDatasets;
       procedure IncSequence;
       procedure StartSequence( Table : TnxeTable );

       property SectionDataModule : TSectionDataModule read FSectionDataModule;
       property SessionDataModule : TBaseSessionDataModule read FSessionDataModule;

       property MainDataModule : TMainDataModule read GetMainDataModule;
       property EnterpriseDataModule : TEnterpriseDataModule read GetEnterpriseDataModule;

       published

       property OpenDatasetsOnCreate : Boolean read FOpenDatasetsOnCreate write FOpenDatasetsOnCreate;

       end;

     TServerDataModuleClass = class of TServerDataModule;

function CheckServerDataModule(     SectionDataModule     : TSectionDataModule;
                                    ServerDataModuleClass : TServerDataModuleClass;
                                var Reference ) : TServerDataModule;

implementation

uses  Forms,

      nxdbBase,
      nxllBDE,
      nxllConvertException,

      nxdmServer,

      LibUtils,
      AppManager;

resourceString
      RsMsg1 = 'Realizando ajustes adicionales (%s)';

procedure CreateServerDataModule(     SectionDataModule     : TSectionDataModule;
                                      ServerDataModuleClass : TServerDataModuleClass;
                                  var Reference             );

var  Instance : TServerDataModule;

begin
     Instance := TServerDataModule( ServerDataModuleClass.NewInstance );
     try
       TServerDataModule( Reference ) := Instance;
       Instance.Create( SectionDataModule );
     except on E : Exception do
         begin
         TServerDataModule( Reference ) := nil;
         If   Assigned( Instance )
         then With Instance do
                 If   not ( csDestroying in ComponentState )
                 then Free;
          SectionDataModule.SessionDataModule.SendNotification( ntExceptionError, ExceptionMessage( E, True ) );
          Abort;
          end;
       end;

end;

function CheckServerDataModule(     SectionDataModule     : TSectionDataModule;
                                    ServerDataModuleClass : TServerDataModuleClass;
                                var Reference ) : TServerDataModule;
begin
     If   Assigned( SectionDataModule )
     then begin
          If   not Assigned( TServerDataModule( Reference ) )
          then CreateServerDataModule( SectionDataModule, ServerDataModuleClass, Reference );
          end
     else begin
          // Abort;   // Si no está asignado el TSectionDataModule mejor cancelar la operación ?
          end;
     Result := TServerDataModule( Reference );
end;

{ TServerDataModule }

// Los módulos deben pertenecer al EnterpriseDataModule, de esta forma se descargan cuando se cambia de Empresa activa

constructor TServerDataModule.Create( AOwner : TComponent );
begin

     FOpenDatasetsOnCreate := True;

     inherited Create( AOwner );

     If   not IsDesignTime and ( AOwner is TSectionDataModule )
     then begin
          FSectionDataModule := TSectionDataModule( AOwner );
          FSessionDataModule := FSectionDataModule.SessionDataModule;
          OpenDatasets;
          end;

end;

destructor TServerDataModule.Destroy;
begin
     try
       // CloseDatasets;
       inherited;
     except on E : Exception do
       begin
       LogException( E, Self );
       end;
     end;
end;

procedure TServerDataModule.OpenDatasets;

var  Dataset : TnxDataset;
     Component : TComponent;

begin
     If   Assigned( FSessionDataModule )
     then begin

          For Component in Self do
            try
              If   Component is TnxDataset
              then begin

                   Dataset := TnxDataset( Component );

                   Dataset.Close;

                   If   Dataset is TnxeTable
                   then With TnxeTable( Dataset ) do
                          begin

                          Timeout := DefaultTimeout; // LockNoWaitTimeOut;

                          case TableType of
                            ttStandard,
                            ttRecover    : Dataset.Database := SectionDataModule.SectionDatabase;
                            ttTemporal,
                            ttVirtual    : Dataset.Database := SessionDataModule.TemporalDatabase;
                            ttMemVirtual : Dataset.Database := SessionDataModule.InMemoryDatabase;
                            end;

                          DatabaseDictionary := FSessionDataModule.GetTableDictionary( BaseTableName );

                          If   FOpenDatasetsOnCreate and ( TableType=ttStandard )
                          then Dataset.Open;

                          end
                   else If   Dataset is TnxMemTable
                        then Dataset.Database := SessionDataModule.InMemoryDatabase
                        else Dataset.Database := SectionDataModule.SectionDatabase;

                   end;

            except on E : Exception do
              begin

              If   E is EnxDatabaseError
              then If   EnxDatabaseError( E ).ErrorCode=DBIERR_TABLELEVEL
                   then begin
                        SessionDataModule.RequestDatabaseUpdate;
                        Abort;
                        end;

              end;

            end;
          end;
end;

procedure TServerDataModule.CloseDatasets;

var  Component : TComponent;

begin
     If   Assigned( FSessionDataModule )
     then For Component in Self do
            try
              If   Component is TnxDataset
              then TnxDataset( Component ).Close;
            except on E : Exception do
              begin
              ConvertException( E, dmServer.EventLog, Self, 0 );
              // Sigo con el proceso. Tampoco puedo hacer mucho más.
              end;
            end;
end;

function TServerDataModule.GetEnterpriseDataModule: TEnterpriseDataModule;
begin
     Result := TEnterpriseDataModule( SessionDataModule.EnterpriseDataModule );
end;

function TServerDataModule.GetMainDataModule: TMainDataModule;
begin
     Result := TMainDataModule( SessionDataModule.MainDataModule );
end;


procedure TServerDataModule.StartSequence( Table : TnxeTable );
begin
     CurrentTableName := Table.TableName;
     TableRecordCount := Table.RecordCount;
     CurrentRecNum := 0;
     LastPercent := -1;
end;

procedure TServerDataModule.IncSequence;
begin
     var Percent := Trunc( ( CurrentRecNum * 100 ) / TableRecordCount );
     If   Percent<>LastPercent
     then begin
          SessionDataModule.SendProgress( Format( RsMsg1, [ CurrentTableName ] ), 0, Percent );
          LastPercent := Percent;
          end;
     Inc( CurrentRecNum );
end;

end.



