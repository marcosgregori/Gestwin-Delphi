unit dm_lma;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  AppContainer,

  AppForms,

  DB, nxdb, DataManager, cxGridDBTableView,

  AppManager,

  Gim10Fields,
  Gim30Fields,

  dmi_lma;

type
   TListaMaterialesModule = class(TDataModule)
    DmListaMaterialesTable: TnxeTable;
    DmLineaMovimientoTable: TnxeTable;
    procedure ListaMaterialesModuleCreate(Sender: TObject);
    procedure ListaMaterialesModuleDestroy(Sender: TObject);
  private

    ListaMaterialesService : IListaMaterialesService;

    DmListaMaterialesFields : TListaMaterialesFields;
    DmLineaMovimientoFields : TLineaMovimientoFields;
    DmArticuloFields : TArticuloFields;
    DmTiposIVAFields : TTiposIVAFields;

    AplicandoDesglose,
    Desglosar : Boolean;

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False  );
    function TieneLista( CodigoArticulo : String; CodigoClaseA, CodigoClaseB, CodigoClaseC : String ) : Boolean; overload;
    function TieneLista( CodigoArticulo : String ) : Boolean; overload;
    function EsComponente( CodigoArticulo : String ) : Boolean;


    function RequiereDesglose( MovimientoFields      : TMovimientoFields;
                                LineaMovimientoFields : TLineaMovimientoFields;
                                ArticuloFields        : TArticuloFields ) : Boolean;

    procedure AplicarDesglose( MovimientoFields       : TMovimientoFields;
                               LineaMovimientoFields  : TLineaMovimientoFields );
  end;

var  ListaMaterialesModule: TListaMaterialesModule = nil;

function ListaMateriales : TListaMaterialesModule;

implementation

uses Variants,

     LibUtils,
     EnterpriseDataAccess,
     NexusRpcData,

     Gdm00Dm,
     Gim00Fields,

     dmi_mov,

     dm_art,
     dm_alm,
     dm_mov,
     dm_sto,
     dm_fdc,
     dm_fdv,

     b_msg,
     b_pro,

     MovimientoIntf,
     LineaMovimientoIntf;

{$R *.DFM}

resourceString
    RsMsg1  = 'El componente [%s], incluido en esta lista de materiales, ha sido dado de baja.';
    RsMsg2  = 'No será incluido en el desglose.';
    RsMsg3  = 'Verificando el estado de los registros de la lista de materiales.';
    RsMsg4  = 'Código de lista de materiales inexistente.';

function ListaMateriales : TListaMaterialesModule;
begin
     CreateDataModule( TListaMaterialesModule, ListaMaterialesModule );
     Result := ListaMaterialesModule;
end;

procedure TListaMaterialesModule.ListaMaterialesModuleCreate(Sender: TObject);
begin

     NexusRpc.CreateRemoteInstance( CLSID_ListaMaterialesService, IListaMaterialesService, ListaMaterialesService );

     DmListaMaterialesFields := TListaMaterialesFields.Create( DmListaMaterialesTable );
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );
     DmArticuloFields := TArticuloFields.Create( Self );
     DmTiposIVAFields := TTiposIVAFields.Create( Self );
end;

procedure TListaMaterialesModule.ListaMaterialesModuleDestroy(Sender: TObject);
begin
     ListaMaterialesModule := nil;
end;

procedure TListaMaterialesModule.Valida(     EditControl   : TcxCustomEdit;
                                         var DisplayValue  : Variant;
                                         var ErrorText     : TCaption;
                                         var Error         : Boolean;
                                             IsInfoControl : Boolean = False  );
begin
     ValidateRelationEx( EditControl, DmListaMaterialesTable, [ DisplayValue, 0 ], DisplayValue, ErrorText, Error, nil, '', IsInfoControl );
     If   not Error
     then If   Assigned( EditControl )
          then EditControl.Description := Articulo.Descripcion( DisplayValue, False );
end;

function TListaMaterialesModule.EsComponente( CodigoArticulo : String ) : Boolean;
begin
     With DmListaMaterialesTable do
       try
         IndexFieldNames := 'CodigoComponente;ClaseAComponente;ClaseBComponente;ClaseCComponente';
         Result := FindEqualFirst( [ CodigoArticulo ] );
       finally
         IndexFieldNames := 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;NroLinea'
         end;
end;

function  TListaMaterialesModule.TieneLista( CodigoArticulo : String;
                                             CodigoClaseA,
                                             CodigoClaseB,
                                             CodigoClaseC   : String ) : Boolean;
begin
     If   CodigoArticulo=''
     then Result := False
     else Result := DmListaMaterialesTable.FindKey( [ CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, 1 ] );
end;

function  TListaMaterialesModule.TieneLista( CodigoArticulo : String ) : Boolean;
begin
     Result := DmListaMaterialesTable.FindEqualFirst( [ CodigoArticulo ] );
end;

// Paso 1 : Comprobar si es necesario aplicar el desglose

function TListaMaterialesModule.RequiereDesglose( MovimientoFields      : TMovimientoFields;
                                                  LineaMovimientoFields : TLineaMovimientoFields;
                                                  ArticuloFields        : TArticuloFields ) : Boolean;
begin
     Result := ( ArticuloFields.EsListaMateriales.Value ) and ( ( ArticuloFields.Desglosar.Value ) or ( MovimientoFields.TipoMovimiento.Value in [ tmFabricacion, tmDespiece ] ) ) and
               ( LineaMovimientoFields.Dataset.State=dsInsert ) and not ValueIsEmpty( LineaMovimientoFields.Cantidad.Value );
end;

// Paso 2 : Aplicar el desglose. Si se llama al procedimiento se aplica sin más, por lo que hay que utilizar la función anterior en los procesos de edición de líneas de documentos.

procedure TListaMaterialesModule.AplicarDesglose( MovimientoFields       : TMovimientoFields;
                                                  LineaMovimientoFields  : TLineaMovimientoFields );
begin
     If   not AplicandoDesglose and
          not LineaMovimientoFields.Dataset.ControlsDisabled
     then try
            ListaMaterialesService.AplicarDesglose( TMovimiento.FromDataset( MovimientoFields ), TLineaMovimiento.FromDataset( LineaMovimientoFields ) );
          finally
            AplicandoDesglose := False;
            end;

end;

end.


