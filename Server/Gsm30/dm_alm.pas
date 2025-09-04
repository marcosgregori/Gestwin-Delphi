
unit dm_alm;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB,
  nxdb,
  DataManager,
  ServerDataModule,

  Gim30Fields;

type

   TAlmacenModule = class(TServerDataModule)
    DmAlmacenTable: TnxeTable;
    DmExistenciasArticuloTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

     DmAlmacenFields : TAlmacenFields;
     DmExistenciasArticuloFields : TExistenciasArticuloFields;

  public
    function AlmacenPorDefecto(Seccion: TSeccionComercial; ArticuloFields : TArticuloFields = nil ) : String;
    function UbicacionPorDefecto( CodigoAlmacen : String; ArticuloFields : TArticuloFields = nil ) : String;

  end;


implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses LibUtils,
     AppManager,
     SessionData,

     EnterpriseData,

     Gim00Fields,

     dmi_mov,

     dm_mov;

{$R *.DFM}

procedure TAlmacenModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmAlmacenFields := TAlmacenFields.Create( DmAlmacenTable );
     DmExistenciasArticuloFields := TExistenciasArticuloFields.Create( DmExistenciasArticuloTable );
end;

procedure TAlmacenModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm30.TipoMovAlmacenModule := nil
end;

function TAlmacenModule.AlmacenPorDefecto( Seccion        : TSeccionComercial;
                                           ArticuloFields : TArticuloFields = nil ) : String;

var  NoExisteAlmacenFicha : Boolean;

begin
     Result := '';   // Almacén genérico
     With SessionDataModule do
       If   EmpresaFields.Stock_MultiAlmacen.Value
       then begin

            NoExisteAlmacenFicha := not Assigned( ArticuloFields ) or not ArticuloFields.Initialized or ValueIsEmpty( ArticuloFields.CodigoAlmacen.Value );

            // El comportamiento es poco intuitivo. El almacén por defecto del usuario es imperativo, pero no el de la Empresa.
            // Si se fija el almacén por defecto de la Empresa y la ficha del artículo tiene asignado un código de almacén, se utiliza este último.

            case Seccion of
              scCompras : If   ValueIsEmpty( UsuarioFields.Compras_AlmacenDefecto.Value )
                          then begin
                               If   NoExisteAlmacenFicha
                               then Result := EmpresaFields.Compras_AlmacenDefec.Value;
                               end
                          else Result := UsuarioFields.Compras_AlmacenDefecto.Value;

              scVentas  : If   ValueIsEmpty( UsuarioFields.Ventas_AlmacenDefecto.Value )
                          then begin
                               If   NoExisteAlmacenFicha
                               then Result := EmpresaFields.Ventas_AlmacenDefec.Value;
                               end
                          else Result := UsuarioFields.Ventas_AlmacenDefecto.Value;

              scAmbas   : If   NoExisteAlmacenFicha
                          then Result := EmpresaFields.Stock_AlmacenDefecto.Value;
              end;

            If   Assigned( ArticuloFields ) and ArticuloFields.Initialized and ValueIsEmpty( Result )
            then Result := ArticuloFields.CodigoAlmacen.Value;

            end;
end;

function TAlmacenModule.UbicacionPorDefecto( CodigoAlmacen  : String;
                                             ArticuloFields : TArticuloFields = nil ) : String;
begin
     Result := '';
     IF   SessionDataModule.EmpresaFields.Stock_Ubicaciones.Value and
          Assigned( ArticuloFields ) and
          ArticuloFields.Initialized
     then begin

          If   DmExistenciasArticuloTable.FindKey( [ ArticuloFields.Codigo.Value, CodigoAlmacen ] )
          then Result := DmExistenciasArticuloFields.Ubicacion.Value;

          If   ValueIsEmpty( Result )
          then Result := ArticuloFields.Ubicacion.Value;

          end;
end;


end.

