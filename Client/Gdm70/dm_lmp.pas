unit dm_lmp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,

  AppForms,

  DB,
  nxdb,
  cxEdit,

  DataManager,

  Gim30Fields,
  Gim70Fields,

  dmi_lmp;

type
  TListaMaterialesProcesosModule = class(TDataModule)
    DmRelacionMaterialesTable: TnxeTable;
    DmRelacionOperacionesTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    DmRelacionOperacionesFields : TRelacionOperacionesFields;
    DmRelacionMaterialesFields : TRelacionMaterialesFields;

    ListaMaterialesProcesosService : IListaMaterialesProcesosService;

  public
    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; ArticuloFields : TArticuloFields; IsInfoControl : Boolean = False  );

    function Bucle( CodigoBusqueda, CodigoReferencia : String ) : Boolean;
    function TieneRelacion( CodigoArticulo : String; CodigoClaseA, CodigoClaseB, CodigoClaseC : String ) : Boolean;
    function EsComponente( CodigoArticulo : String ) : Boolean;
  end;

var   ListaMaterialesProcesosModule: TListaMaterialesProcesosModule = nil;

const NivelMaximo = 20;

function ListaMaterialesProcesos : TListaMaterialesProcesosModule;

const  FmtDecComponentes = 'FmtDecComponentes';

implementation

uses AppManager,
     NexusRpcData,

     b_msg,

     dm_art;

{$R *.DFM}

resourceString
     RsMsg1  = 'La lista de materiales y procesos de código [%s] no existe.';

function ListaMaterialesProcesos : TListaMaterialesProcesosModule;
begin
     CreateDataModule( TListaMaterialesProcesosModule, ListaMaterialesProcesosModule );
     Result := ListaMaterialesProcesosModule;
end;

procedure TListaMaterialesProcesosModule.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_ListaMaterialesProcesosService, IListaMaterialesProcesosService, ListaMaterialesProcesosService );

     DmRelacionMaterialesFields := TRelacionMaterialesFields.Create( DmRelacionMaterialesTable );
     DmRelacionOperacionesFields := TRelacionOperacionesFields.Create( DmRelacionOperacionesTable );
end;

procedure TListaMaterialesProcesosModule.DataModuleDestroy( Sender : TObject );
begin
     ListaMaterialesProcesosModule := nil;
end;

procedure TListaMaterialesProcesosModule.Valida(     EditControl    : TcxCustomEdit;
                                                 var DisplayValue   : Variant;
                                                 var ErrorText      : TCaption;
                                                 var Error          : Boolean;
                                                     ArticuloFields : TArticuloFields;   // Es obligatioro
                                                     IsInfoControl  : Boolean = False );
begin
     If   not ValueIsEmpty( DisplayValue )
     then If   DmRelacionOperacionesTable.FindEqualFirst( [ DisplayValue ] )
          then begin
               If   Assigned( EditControl )
               then begin
                    Articulo.Valida( EditControl, DisplayValue, ErrorText, Error, ArticuloFields );
                    If   not Error
                    then EditControl.Description := ArticuloFields.Descripcion.Value;
                    end;
               end
          else If   not IsInfoControl
               then begin
                    Error := True;
                    ErrorText := Format( RsMsg1, [ DisplayValue ] );
                    end;
end;

function TListaMaterialesProcesosModule.EsComponente( CodigoArticulo : String ) : Boolean;
begin
     Result := ListaMaterialesProcesosService.EsComponente( CodigoArticulo );
end;

function  TListaMaterialesProcesosModule.Bucle( CodigoBusqueda, CodigoReferencia : String ) : Boolean;
begin
     Result := ListaMaterialesProcesosService.Bucle( CodigoBusqueda, CodigoReferencia );
end;

function  TListaMaterialesProcesosModule.TieneRelacion( CodigoArticulo : String;
                                                   CodigoClaseA,
                                                   CodigoClaseB,
                                                   CodigoClaseC   : String ) : Boolean;
begin
     Result := ListaMaterialesProcesosService.TieneRelacion( CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC );

end;


end.
