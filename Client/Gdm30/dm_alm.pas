
unit dm_alm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, cxEdit,
  AppContainer,

  AppForms,
  DB,
  nxdb,
  DataManager,

  Gim30Fields;

type
  TAlmacenModule = class(TDataModule)
    DmAlmacenTable: TnxeTable;
    DmExistenciasArticuloTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

    DmAlmacenFields  : TAlmacenFields;
    DmExistenciasArticuloFields  : TExistenciasArticuloFields;

    ExisteModuleAprovisionamiento : Boolean;

  public


    procedure Valida( Seccion: TSeccionComercial; EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean;IsInfoControl : Boolean = False; CompruebaRestriccion : Boolean = True );
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : string;
    function  Obten( Codigo : String; AlmacenFields : TAlmacenFields = nil; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function  ObtenRegistro( Codigo : String; NotificaSiNoExiste : Boolean = False ) : TAlmacenFields;
    function AlmacenPorDefecto(Seccion: TSeccionComercial; ArticuloFields : TArticuloFields = nil ) : String;
    function UbicacionPorDefecto( CodigoAlmacen : String; ArticuloFields : TArticuloFields = nil ) : String;
    procedure SetDefault( EditControl : TcxCustomEdit; Seccion : TSeccionComercial; ArticuloFields : TArticuloFields );
  end;

var AlmacenModule: TAlmacenModule = nil;


function Almacen : TAlmacenModule;

resourceString
    RsAlmacenGenerico  = '<Almacén genérico>';

implementation

uses AppManager,

     EnterpriseDataAccess,

     Gdm00Dm,
     Gim00Fields,

     b_msg;

{$R *.DFM}

resourceString
    RsMsg1  = 'Tiene restringido el uso de este almacén.';
    RsMsg2  = 'El almacén de código [%s] no existe.';

function Almacen : TalmacenModule;
begin
     CreateDataModule( TAlmacenModule, AlmacenModule );
     Result := AlmacenModule;
end;

procedure TAlmacenModule.Valida(     Seccion              : TSeccionComercial;
                                     EditControl          : TcxCustomEdit;
                                 var DisplayValue         : Variant;
                                 var ErrorText            : TCaption;
                                 var Error                : Boolean;
                                     IsInfoControl        : Boolean = False;
                                     CompruebaRestriccion : Boolean = True );
begin

     With DataModule00.DmUsuarioFields do
       If   CompruebaRestriccion
       then If   ( ( Seccion=scVentas ) and Ventas_RestringirAlmacen.Value and ( DisplayValue<>Ventas_AlmacenDefecto.Value ) ) or
                 ( ( Seccion=scCompras ) and Compras_RestringirAlmacen.Value and ( DisplayValue<>Compras_AlmacenDefecto.Value ) ) or
                 ( ( Seccion=scAmbas ) and ( Ventas_RestringirAlmacen.Value or Compras_RestringirAlmacen.Value ) and ( ( DisplayValue<>Ventas_AlmacenDefecto.Value ) or ( DisplayValue<>Compras_AlmacenDefecto.Value ) ) )
          then begin
               Error := True;
               ErrorText := RsMsg1;
               Exit;
               end;

     If   ValueIsEmpty( DisplayValue )
     then begin
          If   Assigned( EditControl ) // Puede estar en una rejilla
          then EditControl.Description := RsAlmacenGenerico;
          end
     else ValidateRelationEx( EditControl, DmAlmacenTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsNombre, IsInfoControl );

end;

procedure TAlmacenModule.DataModuleCreate(Sender: TObject);
begin

     DmAlmacenFields := TAlmacenFields.Create( DmAlmacenTable );
     DmExistenciasArticuloFields := TExistenciasArticuloFields.Create( DmExistenciasArticuloTable );

     ExisteModuleAprovisionamiento := ApplicationContainer.IsModuleActive( [ 40 ] );

     // Compruebo si existe el almacén genérico

     With DmAlmacenTable do
       If   not FindKey( [ '' ] )   
       then If   Assigned( DmAlmacenFields )
            then begin
                 Append;
                 DmAlmacenFields.Codigo.Value := '';
                 DmAlmacenFields.Nombre.Value := RsAlmacenGenerico;
                 Post;
                 end;
end;

procedure TAlmacenModule.DataModuleDestroy(Sender: TObject);
begin
     AlmacenModule := nil;
end;

function TAlmacenModule.Descripcion( Codigo             : String;
                                     NotificaSiNoExiste : Boolean = True ) : String;
begin
     If   Codigo=''
     then Result := RsAlmacenGenerico
     else GetRelationDescription( DmAlmacenTable, [ Codigo ], Result, NotificaSiNoExiste );
end;

function TAlmacenModule.AlmacenPorDefecto( Seccion        : TSeccionComercial;
                                           ArticuloFields : TArticuloFields = nil ) : String;

var  NoExisteAlmacenFicha : Boolean;

begin
     Result := '';   // Almacén genérico
     If   DataModule00.DmEmpresaFields.Stock_MultiAlmacen.Value
     then begin

          NoExisteAlmacenFicha := not Assigned( ArticuloFields ) or not ArticuloFields.Initialized or ValueIsEmpty( ArticuloFields.CodigoAlmacen.Value );

          // El comportamiento es poco intuitivo. El almacén por defecto del usuario es imperativo, pero no el de la Empresa.
          // Si se fija el almacén por defecto de la Empresa y la ficha del artículo tiene asignado un código de almacén, se utiliza este último.

          case Seccion of
            scCompras : If   ValueIsEmpty( DataModule00.DmUsuarioFields.Compras_AlmacenDefecto.Value )
                        then begin
                             If   NoExisteAlmacenFicha
                             then Result := DataModule00.DmEmpresaFields.Compras_AlmacenDefec.Value;
                             end
                        else Result := DataModule00.DmUsuarioFields.Compras_AlmacenDefecto.Value;

            scVentas  : If   ValueIsEmpty( DataModule00.DmUsuarioFields.Ventas_AlmacenDefecto.Value )
                        then begin
                             If   NoExisteAlmacenFicha
                             then Result := DataModule00.DmEmpresaFields.Ventas_AlmacenDefec.Value;
                             end
                        else Result := DataModule00.DmUsuarioFields.Ventas_AlmacenDefecto.Value;

            scAmbas   : If   NoExisteAlmacenFicha
                        then Result := DataModule00.DmEmpresaFields.Stock_AlmacenDefecto.Value;
            end;

          If   Assigned( ArticuloFields ) and ArticuloFields.Initialized and ValueIsEmpty( Result )
          then Result := ArticuloFields.CodigoAlmacen.Value;

          end;
end;

function TAlmacenModule.UbicacionPorDefecto( CodigoAlmacen  : String;
                                             ArticuloFields : TArticuloFields = nil ) : String;
begin
     Result := '';
     IF   DataModule00.DmEmpresaFields.Stock_Ubicaciones.Value and
          Assigned( ArticuloFields ) and
          ArticuloFields.Initialized
     then begin

          // Ubicaciones y stocks min/max por almacén van juntos

          If   DataModule00.DmEmpresaFields.Articulo_StockMinMaxPorAlmacen.Value
          then If   DmExistenciasArticuloTable.FindKey( [ ArticuloFields.Codigo.Value, CodigoAlmacen ] )
               then Result := DmExistenciasArticuloFields.Ubicacion.Value;

          If   ValueIsEmpty( Result )  
          then Result := ArticuloFields.Ubicacion.Value;
          
          end;
end;

procedure TAlmacenModule.SetDefault( EditControl    : TcxCustomEdit;
                                     Seccion        : TSeccionComercial;
                                     ArticuloFields : TArticuloFields );
begin
     With EditControl do
       If   ValueIsEmpty( EditValue )
       then PostEditValue( AlmacenPorDefecto( Seccion, ArticuloFields ) );
end;

function  TAlmacenModule.Obten( Codigo             : String;
                                AlmacenFields      : TAlmacenFields = nil;
                                NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmAlmacenTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg2, [ Codigo ] ), '' );
          Abort;
          end;
     If   Assigned( AlmacenFields )
     then AlmacenFields.Update( DmAlmacenTable );
end;

function  TAlmacenModule.ObtenRegistro( Codigo             : String;
                                        NotificaSiNoExiste : Boolean = False ) : TAlmacenFields;
begin
     If   Obten( Codigo, nil, NotificaSiNoExiste )
     then Result := DmAlmacenFields
     else Result := nil;
end;

end.

