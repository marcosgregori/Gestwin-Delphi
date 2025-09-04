
{$TYPEINFO ON}   // Rtti

unit Gsm207Dm;

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

      dm_cat,

      dm_rea207,
      dm_sdt,
      dm_pde207;

type
  TDataModule207 = class(TServerDataModule)
    Dictionary:TnxeDatabaseDictionary;
    SQLSet: TgxSQLSet;
    SourceTable: TnxeTable;
    TargetTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure DictionaryVerify;
    procedure DictionaryAfterUpdate;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure DictionaryBeforeUpdate;
  private

    FCategoriaModule : TCategoriaModule;
    FRegistroActualizacionModule : TRegistroActualizacionModule;
    FSincronizacionTiendaModule : TSincronizacionTiendaModule;
    FConfiguracionTiendaVirtualModule : TConfiguracionTiendaVirtualModule;

    procedure Ajustes110153;

    procedure AjustesPrevios110163;

    function GetCategoriaModule : TCategoriaModule;
    function GetRegistroActualizacionModule : TRegistroActualizacionModule;
    function GetSincronizacionTiendaModule : TSincronizacionTiendaModule;
    function GetConfiguracionTiendaVirtualModule : TConfiguracionTiendaVirtualModule;

  public

    function GetSQL( Title : String ) : String;

    procedure FreeCategoriaModule;
    procedure FreeRegistroActualizacionModule;
    procedure FreeSincronizacionTiendaModule;
    procedure FreeConfiguracionTiendaVirtualModule;

    property CategoriaModule : TCategoriaModule read GetCategoriaModule write FCategoriaModule;
    property RegistroActualizacionModule : TRegistroActualizacionModule read GetRegistroActualizacionModule write FRegistroActualizacionModule;
    property SincronizacionTiendaModule : TSincronizacionTiendaModule read GetSincronizacionTiendaModule write FSincronizacionTiendaModule;
    property ConfiguracionTiendaVirtualModule : TConfiguracionTiendaVirtualModule read GetConfiguracionTiendaVirtualModule write FConfiguracionTiendaVirtualModule;

  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

{$R *.DFM}

uses    Variants,
        Files,
        Generics.Collections,
        nxsdDataDictionaryStrings,

        nxdbBase,
        nxllBde,

        AppManager,
        SessionData,

        dmi_sdt,

        Gsm00Dm,

        dm_reg;


procedure TDataModule207.ServerDataModuleCreate(Sender: TObject);
begin
     With SessionDataModule do
       SetupDatabaseDictionary( Dictionary, EnterpriseDataModule.Database );
end;

procedure TDataModule207.ServerDataModuleDestroy(Sender: TObject);
begin
     FSessionDataModule.DictionaryList.Remove( Dictionary );
     SessionDataModule.Dm207 := nil;
end;

procedure TDataModule207.Ajustes110153;
begin
     SessionDataModule.Dm00.RegistroModule.ClavePadre := SessionDataModule.CodigoEmpresa + '.' + ncrParametrosTiendaVirtual;
     var PublicarClasesComo := StrToIntDef( SessionDataModule.Dm00.RegistroModule.ObtenValorString( 'PublicarClasesComo' ), 0 );
     SessionDataModule.Dm00.RegistroModule.GuardaValor( ncrPublicarClasesComoConfiguraciones, BoolToStr( PublicarClasesComo<>0 ) );
end;

procedure TDataModule207.DictionaryAfterUpdate;
begin
     With SessionDataModule.EnterpriseDataModule do
       begin
       CheckVersionAndExecute( 11, 0, 153, Ajustes110153 );
       end;
end;

procedure TDataModule207.AjustesPrevios110163;

var  ListaCategorias : TStringList;
     CodigoField,
     CategoriasField,
     CodigoArticuloField,
     CodigoCategoriaField,
     NroOrdenField : TField;

begin

     // Categorias

     // Primero compruebo si existe el campo Tienda_CodigoCategoria

     SourceTable.Close;
     SourceTable.DatabaseDictionary := Dictionary;
     SourceTable.Database := SessionDataModule.EnterpriseDataModule.Database;
     SourceTable.TableName := 'Articulo';
     SourceTable.IndexName := csSeqAccessIndexName;

     try

       SourceTable.Open;

       CategoriasField := SourceTable.FindField( 'Tienda_CodigoCategoria' );
       If   CategoriasField=nil
       then Exit;

       CodigoField  := SourceTable.FindField( 'Codigo' );

       TargetTable.Close;
       TargetTable.DatabaseDictionary := Dictionary;
       TargetTable.Database := SessionDataModule.EnterpriseDataModule.Database;
       TargetTable.TableName := 'CategoriasArticulo';
       TargetTable.IndexName := csSeqAccessIndexName;

       With TargetTable do
         If   not Database.TableExists( TableName, '' )
         then begin
              DataDictionary.AddLocaleDescriptor;
              Database.CreateTable( True, TableName, '', DataDictionary );
              end;

       try

         TargetTable.Open;

         CodigoArticuloField := TargetTable.FindField( 'CodigoArticulo' );
         CodigoCategoriaField := TargetTable.FindField( 'CodigoCategoria' );
         NroOrdenField := TargetTable.FindField( 'NroOrden' );

         ListaCategorias := TStringList.Create;

         StartSequence( TargetTable );

         try

           ListaCategorias.Delimiter := ';';

           With SourceTable do
           begin
           First;
           While not Eof do
             begin

             If   CategoriasField.AsString<>''
             then begin
                  ListaCategorias.DelimitedText := CategoriasField.AsString;
                  var NroOrden := 1;
                  For var CodigoCategoria in ListaCategorias do
                    try
                      TargetTable.Append;

                      CodigoArticuloField.AsString := CodigoField.AsString;
                      CodigoCategoriaField.AsString := CodigoCategoria;
                      NroOrdenField.AsInteger := NroOrden;

                      Inc( NroOrden );

                      TargetTable.Post;
                    except
                      end;
                  end;

             IncSequence;

             Next;
             end;

           end;

         finally
           ListaCategorias.Free;
           end;

       finally
         TargetTable.Close;
         end;

     finally
       SourceTable.Close;
       end;

end;

procedure TDataModule207.DictionaryBeforeUpdate;
begin
     With SessionDataModule.EnterpriseDataModule do
       begin
       CheckVersionAndExecute( 11, 0,  163, AjustesPrevios110163 );
       end;
end;

procedure TDataModule207.DictionaryVerify;
begin
     //..
end;

function TDataModule207.GetSQL( Title : String ) : String;
begin
     Result := SQLSet.GetSQLText( Title );
end;

function TDataModule207.GetCategoriaModule : TCategoriaModule;
begin
     Result := TCategoriaModule( CheckServerDataModule( EnterpriseDataModule, TCategoriaModule, FCategoriaModule ) );
end;

function TDataModule207.GetRegistroActualizacionModule : TRegistroActualizacionModule;
begin
     Result := TRegistroActualizacionModule( CheckServerDataModule( EnterpriseDataModule, TRegistroActualizacionModule, FRegistroActualizacionModule ) );
end;

procedure TDataModule207.FreeCategoriaModule;
begin
     If   Assigned( FCategoriaModule )
     then FCategoriaModule.Free;
     FCategoriaModule := nil;
end;

procedure TDataModule207.FreeRegistroActualizacionModule;
begin
     If   Assigned( FRegistroActualizacionModule )
     then FRegistroActualizacionModule.Free;
     FRegistroActualizacionModule := nil;
end;

function TDataModule207.GetSincronizacionTiendaModule : TSincronizacionTiendaModule;
begin
     Result := TSincronizacionTiendaModule( CheckServerDataModule( EnterpriseDataModule, TSincronizacionTiendaModule, FSincronizacionTiendaModule ) );
end;

procedure TDataModule207.FreeSincronizacionTiendaModule;
begin
     If   Assigned( FSincronizacionTiendaModule )
     then FSincronizacionTiendaModule.Free;
     FSincronizacionTiendaModule := nil;
end;

function TDataModule207.GetConfiguracionTiendaVirtualModule : TConfiguracionTiendaVirtualModule;
begin
     Result := TConfiguracionTiendaVirtualModule( CheckServerDataModule( EnterpriseDataModule, TConfiguracionTiendaVirtualModule, FConfiguracionTiendaVirtualModule ) );
end;

procedure TDataModule207.FreeConfiguracionTiendaVirtualModule;
begin
     If   Assigned( FConfiguracionTiendaVirtualModule )
     then FConfiguracionTiendaVirtualModule.Free;
     FConfiguracionTiendaVirtualModule := nil;
end;

initialization

end.



