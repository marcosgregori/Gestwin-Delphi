unit dm_lmp;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB,
  nxdb,

  LibUtils,
  DataManager,
  ServerDataModule,
  SessionIntf,

  Gim70Fields,

  dmi_lmp;

type

  TListaMaterialesProcesosService = class( TSessionModule, IListaMaterialesProcesosService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    function Bucle( CodigoBusqueda, CodigoReferencia : String ) : Boolean;
    function TieneRelacion( CodigoArticulo : String; CodigoClaseA, CodigoClaseB, CodigoClaseC : String ) : Boolean;
    function EsComponente( CodigoArticulo : String ) : Boolean;
    end;

  TListaMaterialesProcesosModule = class(TServerDataModule)
    DmRelacionMaterialesTable: TnxeTable;
    DmRelacionOperacionesTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

    DmRelacionOperacionesFields : TRelacionOperacionesFields;
    DmRelacionMaterialesFields : TRelacionMaterialesFields;

  public

    function Bucle( CodigoBusqueda, CodigoReferencia : String ) : Boolean;
    function TieneRelacion( CodigoArticulo : String; CodigoClaseA, CodigoClaseB, CodigoClaseC : String ) : Boolean;
    function EsComponente( CodigoArticulo : String ) : Boolean;
  end;

const
    NivelMaximo = 20;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses DateUtils,

     nxdbBase,
     nxllBde,
     nxrdClass,
     nxrbTypes,

     AppManager,
     SessionData,
     EnterpriseData;

{$R *.DFM}

var    RelacionMaterialesControl : InxClassFactoryControl;

procedure TListaMaterialesProcesosModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmRelacionMaterialesFields := TRelacionMaterialesFields.Create( DmRelacionMaterialesTable );
     DmRelacionOperacionesFields := TRelacionOperacionesFields.Create( DmRelacionOperacionesTable );
end;

procedure TListaMaterialesProcesosModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm70.ListaMaterialesProcesosModule := nil;
end;

function TListaMaterialesProcesosModule.EsComponente( CodigoArticulo : String ) : Boolean;
begin
     With DmRelacionMaterialesTable do
       begin
       IndexFieldNames := 'CodigoComponente;ClaseAComponente;ClaseBComponente;ClaseCComponente';
       Result := FindEqualFirst( [ CodigoArticulo ] );
       end;
end;

function  TListaMaterialesProcesosModule.Bucle( CodigoBusqueda, CodigoReferencia : String ) : Boolean;

var   Error : Boolean;

procedure CompruebaBucle( CodigoArticulo : String );

var ClaveActual : TStringKey;
    ListaComponentes : TStringList;
    Index : SmallInt;

    // Tabla para uso recursivo

    DrRelacionMaterialesTable : TnxeTable;
    DrRelacionMaterialesFields : TRelacionMaterialesFields;

begin

     If   Error
     then Exit;

     ListaComponentes := TStringList.Create;

     DrRelacionMaterialesTable := TnxeTable.Create( nil );
     DrRelacionMaterialesTable.AssignRootPropertiesFrom( DmRelacionMaterialesTable );
     DrRelacionMaterialesTable.Open;
     DrRelacionMaterialesFields := TRelacionMaterialesFields.Create( DrRelacionMaterialesTable ) ;

     try

       With DrRelacionMaterialesTable do
         begin
         SetRange( [ CodigoArticulo ] );
         First;

         With ListaComponentes do
           begin

           While not Eof do
             begin
             Add( DrRelacionMaterialesFields.CodigoComponente.Value );
             Next;
             end;

           For Index := 0 to Count - 1 do
             If   Strings[ Index ]=CodigoBusqueda
             then begin
                  Error := True;
                  Exit;
                  end
            else CompruebaBucle( Strings[ Index ] );

            end;

         end;

     finally
       ListaComponentes.Free;
       DrRelacionMaterialesTable.Free;
       end;

end;

begin
     Error  := False;
     DmRelacionMaterialesTable.IndexFieldNames := 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso;NroLinea';
     CompruebaBucle( CodigoReferencia );
     Result := Error;
end;

function  TListaMaterialesProcesosModule.TieneRelacion( CodigoArticulo : String;
                                                        CodigoClaseA,
                                                        CodigoClaseB,
                                                        CodigoClaseC   : String ) : Boolean;
begin
     With DmRelacionMaterialesTable do
       begin
       IndexFieldNames := 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso;NroLinea';
       Result := FindEqualFirst( [ CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC ] );
       end;
end;

{ TListaMaterialesProcesosService }

procedure TListaMaterialesProcesosService.AssignSession( const SessionID : Integer );
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

function TListaMaterialesProcesosService.Bucle( CodigoBusqueda, CodigoReferencia: String): Boolean;
begin
     Result := SessionDataModule.Dm70.ListaMaterialesProcesosModule.Bucle( CodigoBusqueda, CodigoReferencia );
end;

function TListaMaterialesProcesosService.EsComponente( CodigoArticulo : String ) : Boolean;
begin
     Result := SessionDataModule.Dm70.ListaMaterialesProcesosModule.EsComponente( CodigoArticulo );
end;

function TListaMaterialesProcesosService.TieneRelacion( CodigoArticulo,
                                                   CodigoClaseA,
                                                   CodigoClaseB,
                                                   CodigoClaseC : String ) : Boolean;
begin
     Result := SessionDataModule.Dm70.ListaMaterialesProcesosModule.TieneRelacion( CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC );
end;

initialization
    TnxClassFactory.RegisterClass( CLSID_ListaMaterialesProcesosService, TListaMaterialesProcesosService, RelacionMaterialesControl );


end.
