
{$TYPEINFO ON}   // Rtti

unit Gsm70Dm;

interface

uses  Windows,
      Messages,
      SysUtils,
      Classes,
      
      nxllComponent,
      nxsdTableMapperDescriptor,
      nxsdRecordMapperDescriptor,
      nxsdDataDictionary,
      DB,
      nxdb,
      LibUtils,
      DataManager,
      MainData,
      EnterpriseData,
      Sqlset,
      ServerDataModule,

      dm_pde7,
      dm_lmp,
      dm_cla,
      dm_maq,
      dm_cpr,
      dm_odf,
      dm_idf,
      dm_rla,
      dm_ccf,
      dm_rdip;

type
  TDataModule70 = class(TServerDataModule)
    dictionary:TnxeDatabaseDictionary;
    SQLSet: TgxSQLSet;
    DetailSourceTable: TnxeTable;
    MasterSourceTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure DictionaryVerify;
    procedure DictionaryAfterUpdate;
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

    FConfiguracionProduccionModule : TConfiguracionProduccionModule;
    FListaMaterialesProcesosModule : TListaMaterialesProcesosModule;
    FOrdenFabricacionModule : TOrdenFabricacionModule;
    FInformeFabricacionModule : TInformeFabricacionModule;
    FMaquinaModule : TMaquinaModule;
    FContenedorModule : TContenedorModule;
    FCalendarioModule : TCalendarioModule;
    FLanzamientoModule : TLanzamientoModule;
    FCierreCicloFabricacionModule : TCierreCicloFabricacionModule;
    FReconstruccionDatosInternosModule : TReconstruccionDatosInternosModule;

    function GetConfiguracionProduccionModule : TConfiguracionProduccionModule;
    function GetListaMaterialesProcesosModule : TListaMaterialesProcesosModule;
    function GetOrdenFabricacionModule : TOrdenFabricacionModule;
    function GetInformeFabricacionModule : TInformeFabricacionModule;
    function GetContenedorModule : TContenedorModule;
    function GetCalendarioModule : TCalendarioModule;
    function GetMaquinaModule : TMaquinaModule;
    function GetLanzamientoModule : TLanzamientoModule;
    function GetCierreCicloFabricacionModule : TCierreCicloFabricacionModule;
    function GetReconstruccionDatosInternosModule : TReconstruccionDatosInternosModule;

  public

    function GetSQL( Title : String ) : String;

    procedure FreeConfiguracionProduccionModule;
    procedure FreeListaMaterialesProcesosModule;
    procedure FreeOrdenFabricacionModule;
    procedure FreeInformeFabricacionModule;
    procedure FreeContenedorModule;
    procedure FreeCalendarioModule;
    procedure FreeMaquinaModule;
    procedure FreeLanzamientoModule;
    procedure FreeCierreCicloFabricacionModule;
    procedure FreeReconstruccionDatosInternosModule;

    property ConfiguracionProduccionModule : TConfiguracionProduccionModule read GetConfiguracionProduccionModule write FConfiguracionProduccionModule;
    property ListaMaterialesProcesosModule : TListaMaterialesProcesosModule read GetListaMaterialesProcesosModule write FListaMaterialesProcesosModule;
    property OrdenFabricacionModule : TOrdenFabricacionModule read GetOrdenFabricacionModule write FOrdenFabricacionModule;
    property InformeFabricacionModule : TInformeFabricacionModule read GetInformeFabricacionModule write FInformeFabricacionModule;
    property ContenedorModule : TContenedorModule read GetContenedorModule write FContenedorModule;
    property CalendarioModule : TCalendarioModule read GetCalendarioModule write FCalendarioModule;
    property MaquinaModule : TMaquinaModule read GetMaquinaModule write FMaquinaModule;
    property LanzamientoModule : TLanzamientoModule read GetLanzamientoModule write FLanzamientoModule;
    property CierreCicloFabricacionModule : TCierreCicloFabricacionModule read GetCierreCicloFabricacionModule write FCierreCicloFabricacionModule;
    property ReconstruccionDatosInternosModule : TReconstruccionDatosInternosModule read GetReconstruccionDatosInternosModule write FReconstruccionDatosInternosModule;

  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

{$R *.DFM}

uses    Variants,
        Files,
        DateUtils,
        nxsdDataDictionaryStrings,

        nxdbBase,
        nxllBde,

        AppManager,
        SessionData,

        Gim70Fields;

resourceString
        RsMsg1 = 'Realizando ajustes adicionales';

procedure TDataModule70.ServerDataModuleCreate(Sender: TObject);
begin
     With SessionDataModule do
       SetupDatabaseDictionary( Dictionary, EnterpriseDataModule.Database );

     ConfiguracionProduccionModule;
end;

procedure TDataModule70.ServerDataModuleDestroy(Sender: TObject);
begin
     FSessionDataModule.DictionaryList.Remove( Dictionary );
     SessionDataModule.Dm70 := nil;
end;

procedure TDataModule70.DictionaryAfterUpdate;

procedure Ajustes110109;

var  CalendarioFields : TCalendarioFields;

begin

     // Las fechas de los registros globales han pasado del rango 1/1/1..1/1/4 a 1/1/100..1/1/104 porque la versión de 64bits
     // de la función de conversión de fechas no admite fechas por debajo del 1/1/100 (SO)

     try

       MasterSourceTable.TableName := 'Calendario';
       MasterSourceTable.IndexFieldNames := 'Fecha';

       MasterSourceTable.Open;

       CalendarioFields := TCalendarioFields.Create( MasterSourceTable );

       For var Inx := 1 to 4 do
         If   MasterSourceTable.FindKey( [ EncodeDate( Inx, 1, 1 ) ] )
         then begin
              MasterSourceTable.Edit;
              CalendarioFields.Fecha.Value := EncodeDate( Inx + 100, 1, 1 );
              MasterSourceTable.Post;
              end;


       finally
         MasterSourceTable.Close;
       end;
end;

procedure Ajustes110150;
begin

     // No toco los ejercicios anteriores para evitar problemas con los ficheros relacionados con las órdenes de fabricación

     EnterpriseDataModule.ExecSQLCommand( 'UPDATE OrdenFabricacion SET CodigoClaseA='''' WHERE Ejercicio=' + IntToStr( SessionDataModule.Ejercicio ) +  ' AND CodigoClaseA IS NULL' );
     EnterpriseDataModule.ExecSQLCommand( 'UPDATE OrdenFabricacion SET CodigoClaseB='''' WHERE Ejercicio=' + IntToStr( SessionDataModule.Ejercicio ) +  ' AND CodigoClaseB IS NULL' );
     EnterpriseDataModule.ExecSQLCommand( 'UPDATE OrdenFabricacion SET CodigoClaseC='''' WHERE Ejercicio=' + IntToStr( SessionDataModule.Ejercicio ) +  ' AND CodigoClaseC IS NULL' );
end;

begin
     If   SessionDataModule.EnterpriseDataModule.ComparableVersion<'11000109'
     then Ajustes110109;
     If   SessionDataModule.EnterpriseDataModule.ComparableVersion<'11000150'
     then Ajustes110150;
end;

procedure TDataModule70.DictionaryVerify;
begin
     //..
end;

function TDataModule70.GetSQL( Title : String ) : String;
begin
     Result := SQLSet.GetSQLText( Title );
end;

function TDataModule70.GetConfiguracionProduccionModule : TConfiguracionProduccionModule;
begin
     Result := TConfiguracionProduccionModule( CheckServerDataModule( EnterpriseDataModule, TConfiguracionProduccionModule, FConfiguracionProduccionModule ) );
end;

procedure TDataModule70.FreeConfiguracionProduccionModule;
begin
     If   Assigned( FConfiguracionProduccionModule )
     then FConfiguracionProduccionModule.Free;
     FConfiguracionProduccionModule := nil;
end;

function TDataModule70.GetListaMaterialesProcesosModule : TListaMaterialesProcesosModule;
begin
     Result := TListaMaterialesProcesosModule( CheckServerDataModule( EnterpriseDataModule, TListaMaterialesProcesosModule, FListaMaterialesProcesosModule ) );
end;

procedure TDataModule70.FreeListaMaterialesProcesosModule;
begin
     If   Assigned( FListaMaterialesProcesosModule )
     then FListaMaterialesProcesosModule.Free;
     FListaMaterialesProcesosModule := nil;
end;

function TDataModule70.GetOrdenFabricacionModule : TOrdenFabricacionModule;
begin
     Result := TOrdenFabricacionModule( CheckServerDataModule( EnterpriseDataModule, TOrdenFabricacionModule, FOrdenFabricacionModule ) );
end;

procedure TDataModule70.FreeOrdenFabricacionModule;
begin
     If   Assigned( FOrdenFabricacionModule )
     then FOrdenFabricacionModule.Free;
     FOrdenFabricacionModule := nil;
end;

function TDataModule70.GetInformeFabricacionModule : TInformeFabricacionModule;
begin
     Result := TInformeFabricacionModule( CheckServerDataModule( EnterpriseDataModule, TInformeFabricacionModule, FInformeFabricacionModule ) );
end;

procedure TDataModule70.FreeInformeFabricacionModule;
begin
     If   Assigned( FInformeFabricacionModule )
     then FInformeFabricacionModule.Free;
     FInformeFabricacionModule := nil;
end;

function TDataModule70.GetContenedorModule : TContenedorModule;
begin
     Result := TContenedorModule( CheckServerDataModule( EnterpriseDataModule, TContenedorModule, FContenedorModule ) );
end;

procedure TDataModule70.FreeContenedorModule;
begin
     If   Assigned( FContenedorModule )
     then FContenedorModule.Free;
     FContenedorModule := nil;
end;

function TDataModule70.GetCalendarioModule : TCalendarioModule;
begin
     Result := TCalendarioModule( CheckServerDataModule( EnterpriseDataModule, TCalendarioModule, FCalendarioModule ) );
end;

procedure TDataModule70.FreeCalendarioModule;
begin
     If   Assigned( FCalendarioModule )
     then FCalendarioModule.Free;
     FCalendarioModule := nil;
end;

function TDataModule70.GetMaquinaModule : TMaquinaModule;
begin
     Result := TMaquinaModule( CheckServerDataModule( EnterpriseDataModule, TMaquinaModule, FMaquinaModule ) );
end;

procedure TDataModule70.FreeMaquinaModule;
begin
     If   Assigned( FMaquinaModule )
     then FMaquinaModule.Free;
     FMaquinaModule := nil;
end;

function TDataModule70.GetLanzamientoModule : TLanzamientoModule;
begin
     Result := TLanzamientoModule( CheckServerDataModule( EnterpriseDataModule, TLanzamientoModule, FLanzamientoModule ) );
end;

procedure TDataModule70.FreeLanzamientoModule;
begin
     If   Assigned( FLanzamientoModule )
     then FLanzamientoModule.Free;
     FLanzamientoModule := nil;
end;

function TDataModule70.GetCierreCicloFabricacionModule : TCierreCicloFabricacionModule;
begin
     Result := TCierreCicloFabricacionModule( CheckServerDataModule( EnterpriseDataModule, TCierreCicloFabricacionModule, FCierreCicloFabricacionModule ) );
end;

procedure TDataModule70.FreeCierreCicloFabricacionModule;
begin
     If   Assigned( FCierreCicloFabricacionModule )
     then FCierreCicloFabricacionModule.Free;
     FCierreCicloFabricacionModule := nil;
end;

function TDataModule70.GetReconstruccionDatosInternosModule : TReconstruccionDatosInternosModule;
begin
     Result := TReconstruccionDatosInternosModule( CheckServerDataModule( EnterpriseDataModule, TReconstruccionDatosInternosModule, FReconstruccionDatosInternosModule ) );
end;

procedure TDataModule70.FreeReconstruccionDatosInternosModule;
begin
     If   Assigned( FReconstruccionDatosInternosModule )
     then FReconstruccionDatosInternosModule.Free;
     FReconstruccionDatosInternosModule := nil;
end;

initialization

end.



