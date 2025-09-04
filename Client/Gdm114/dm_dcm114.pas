unit dm_dcm114;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  AppContainer,

  AppForms,

  DB, nxdb, DataManager,

  Gim10Fields,
  Gim30Fields,
  Gim114Fields,
  
  Gdm114Dm,

  dmi_dcm114;


type
  TDocumentoControlMercanciasModule = class(TDataModule)
    DmDocumentoControlMercanciasTable: TnxeTable;
    DmMovimientoTable: TnxeTable;
    DmLineaMovimientoTable: TnxeTable;
    DmLineaMovimientoAuxTable: TnxeTable;
    DmCargaTable: TnxeTable;
    DmDocumentoControlMercanciasAuxTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

    DocumentoControlMercanciasService : IDocumentoControlMercanciasService;
    
    procedure GeneraLineasDocumento( DocumentoControlMercanciasFields : TDocumentoControlMercanciasFields );
    function ExisteNroOperacion( ValorActual : LongInt ) : Boolean;
  public

    DmDocumentoControlMercanciasFields,
    DmDocumentoControlMercanciasAuxFields  : TDocumentoControlMercanciasFields;
    DmMovimientoFields: TMovimientoFields;
    DmLineaMovimientoFields : TLineaMovimientoFields;
    DmCargaFields : TCargaFields;
    DmClienteFields : TClienteFields;
    DmProveedorFields : TProveedorFields;
    DmSerieFacturacionFields : TSerieFacturacionFields;
    DmArticuloFields : TArticuloFields;
    DmTiposIVAFields : TTiposIVAFields;

    function GeneraAlbaranCompra( DocumentoControlMercanciasFields : TDocumentoControlMercanciasFields; CodigoProveedor : String ) : LongInt;
    function GeneraAlbaranVenta( DocumentoControlMercanciasFields : TDocumentoControlMercanciasFields ) : LongInt;
    procedure CompruebaDocumentoLibre( DocumentoControlMercanciasTable : TnxeTable );
    function ProximoNroOperacion : LongInt;
    procedure RetiraNroOperacion( DocumentoControlMercanciasFields : TDocumentoControlMercanciasFields; CompruebaEstado : Boolean = True );
  end;


const

  // TSituacionCarga

  scPendiente = 0;
  scAsignada  = 1;
  scBuzon     = 2;
  scTerminada = 3;

var
  DocumentoControlMercanciasModule: TDocumentoControlMercanciasModule = nil;


function  DocumentoControlMercancias : TDocumentoControlMercanciasModule;

implementation

uses LibUtils,
     DataAccess,
     AppManager,
     EnterpriseDataAccess,
     NexusRpcData,
     
     dmi_cnd,
     dmi_mov,

     dm_pga,
     dm_cnd,
     dm_sdf,
     dm_cli,
     dm_pro,
     dm_mov,
     dm_art,
     dm_fdc,
     dm_fdv,
     dm_fab114;

{$R *.DFM}

resourceString
    RsMsg1  = 'Documento de control de mercancías nº %d';
    RsMsg2  = 'El documento de control de mercancías vinculado a este albarán está siendo editado por otro usuario.';
    RsMsg3  = 'Espere a que sea liberado y reintente la operación.';

function DocumentoControlMercancias : TDocumentoControlMercanciasModule;
begin
     CreateDataModule( TDocumentoControlMercanciasModule, DocumentoControlMercanciasModule );
     Result := DocumentoControlMercanciasModule;
end;

procedure TDocumentoControlMercanciasModule.DataModuleCreate(Sender: TObject);
begin

     NexusRpc.CreateRemoteInstance( CLSID_DocumentoControlMercanciasService, IDocumentoControlMercanciasService, DocumentoControlMercanciasService );
     
     DmMovimientoFields := TMovimientoFields.Create( DmMovimientoTable );
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );
     DmDocumentoControlMercanciasFields := TDocumentoControlMercanciasFields.Create( DmDocumentoControlMercanciasTable );
     DmDocumentoControlMercanciasAuxFields := TDocumentoControlMercanciasFields.Create( DmDocumentoControlMercanciasAuxTable );
     DmCargaFields := TCargaFields.Create( DmCargaTable );

     DmClienteFields := TClienteFields.Create( Self );
     DmProveedorFields := TProveedorFields.Create( Self );
     DmSerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     DmArticuloFields := TArticuloFields.Create( Self );
     DmTiposIVAFields := TTiposIVAFields.Create( Self );
end;

procedure TDocumentoControlMercanciasModule.DataModuleDestroy(Sender: TObject);
begin
     DocumentoControlMercanciasModule := nil;
end;

procedure TDocumentoControlMercanciasModule.GeneraLineasDocumento( DocumentoControlMercanciasFields : TDocumentoControlMercanciasFields );

var  NroLinea : SmallInt;

begin
     With DmCargaTable do
       begin
       NroLinea := 1;
       SetRange( [ DocumentoControlMercanciasFields.Ejercicio.Value, DocumentoControlMercanciasFields.NroOperacion.Value ] );
       First;
       While not Eof do
         begin

         If   Fabrica.Obten( DmCargaFields.CodigoFabrica.Value, True )
         then If   Articulo.Obten( Fabrica.DmFabricaFields.CodigoArticulo.Value, DmArticuloFields, True )
              then begin

                   DmLineaMovimientoTable.Append;

                   DmLineaMovimientoFields.Ejercicio.value := DmMovimientoFields.Ejercicio.Value;
                   DmLineaMovimientoFields.NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;
                   DmLineaMovimientoFields.NroLinea.Value := NroLinea;
                   DmLineaMovimientoFields.Fecha.Value := DmMovimientoFields.Fecha.Value;
                   DmLineaMovimientoFields.FechaAplicacion.Value := DmMovimientoFields.Fecha.Value;

                   DmLineaMovimientoFields.CodigoArticulo.Value := Fabrica.DmFabricaFields.CodigoArticulo.Value;
                   DmLineaMovimientoFields.Descripcion.Value := DmArticuloFields.Descripcion.Value;

                   DmLineaMovimientoFields.CantidadAjustada.Value := 1;

                   If   DmMovimientoFields.TipoMovimiento.Value=tmCompra
                   then DmLineaMovimientoFields.Cantidad.Value := 1
                   else DmLineaMovimientoFields.Cantidad.Value := -1;

                   If   DmMovimientoFields.TipoMovimiento.Value=tmCompra
                   then begin
                        Articulo.ObtenPrecioyDtoCompra( DmLineaMovimientoFields, DmProveedorFields.Codigo.Value );
                        FacturaCompras.CalculaImportesIVA( DmLineaMovimientoFields, DmProveedorFields, DmArticuloFields, DmTiposIVAFields );
                        end
                   else begin
                        Articulo.ObtenPrecioyDtoVenta( DmMovimientoFields.TipoMovimiento.Value, DmLineaMovimientoFields, DmClienteFields.Codigo.Value );
                        FacturaVentas.CalculaImportesIVA( DmMovimientoFields, DmLineaMovimientoFields, DmClienteFields, DmArticuloFields, DmSerieFacturacionFields, DmTiposIVAFields );
                        end;

                   DmLineaMovimientoTable.Post;

                   Inc( NroLinea );
                   end;

         Next;
         end;

       end;
end;
function TDocumentoControlMercanciasModule.GeneraAlbaranCompra( DocumentoControlMercanciasFields : TDocumentoControlMercanciasFields;
                                                                CodigoProveedor                  : String ) : LongInt;

begin

     // Este proceso debe haber sido incluído en una transacción

     Result := 0;
     If   Proveedor.Obten( CodigoProveedor, '', DmProveedorFields, True )
     then begin

          DmMovimientoTable.Append;

          DmMovimientoFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
          DmMovimientoFields.NroOperacion.Value := Movimiento.ProximaOperacion;
          DmMovimientoFields.TipoMovimiento.Value := tmCompra;
          DmMovimientoFields.Fecha.Value := DocumentoControlMercanciasFields.FechaCarga.Value;
          DmMovimientoFields.Serie.Value := '';
          DmMovimientoFields.Propietario.Value := CodigoProveedor;
          DmMovimientoFields.NroDocumento.Value := Movimiento.ProximoDocumento( DmMovimientoFields );
          DmMovimientoFields.DescripcionMovimiento.Value := Format( RsMsg1, [ DocumentoControlMercanciasFields.NroOperacion.Value ] );

          DmMovimientoFields.Origen.Value := omDocumentoControlMercancias;
          DmMovimientoFields.EjercicioOrigen.Value := ApplicationContainer.Ejercicio;  // De momento no permito relaciones entre entre ejercicios
          DmMovimientoFields.NroOperacionOrigen.Value := DocumentoControlMercanciasFields.NroOperacion.Value;

          Movimiento.CompruebaPrimerNroPagina( DmMovimientoFields );

          DmMovimientoTable.Post;

          GeneraLineasDocumento( DocumentoControlMercanciasFields  );

          Result := DmMovimientoFields.NroOperacion.Value;
          end;

end;

function TDocumentoControlMercanciasModule.GeneraAlbaranVenta( DocumentoControlMercanciasFields : TDocumentoControlMercanciasFields ) : LongInt;
begin

     // Este proceso debe haber sido incluído en una transacción

     With DmMovimientoFields do
       begin
       DmMovimientoTable.Append;

       Ejercicio.Value := ApplicationContainer.Ejercicio;
       NroOperacion.Value := Movimiento.ProximaOperacion;
       TipoMovimiento.Value := tmVenta;
       Fecha.Value := DocumentoControlMercanciasFields.FechaCarga.Value;
       Serie.Value := SerieFacturacion.ObtenSeriePorDefecto;
       Propietario.Value := DocumentoControlMercanciasFields.CodigoCliente.Value;
       NroDocumento.Value := Movimiento.ProximoDocumento( DmMovimientoFields );
       DescripcionMovimiento.Value := Format( RsMsg1, [ DocumentoControlMercanciasFields.NroOperacion.Value ] );

       Origen.Value := omDocumentoControlMercancias;
       EjercicioOrigen.Value := DocumentoControlMercanciasFields.Ejercicio.Value;
       NroOperacionOrigen.Value := DocumentoControlMercanciasFields.NroOperacion.Value;

       Movimiento.CompruebaPrimerNroPagina( DmMovimientoFields );

       Cliente.Obten( Propietario.Value, '', DmClienteFields );
       SerieFacturacion.Obten( Serie.Value, DmSerieFacturacionFields );

       Result := NroOperacion.Value;

       DmMovimientoTable.Post;

       end;

       If   DocumentoControlMercanciasFields.NroOperacionCompra.Value=0
       then GeneraLineasDocumento( DocumentoControlMercanciasFields  )
       else With DmLineaMovimientoAuxTable do
              begin
              SetRange( [ DmMovimientoFields.Ejercicio.Value, DocumentoControlMercanciasFields.NroOperacionCompra.Value ] );
              First;
              While not Eof do
                begin

                DmLineaMovimientoTable.Append;

                DmLineaMovimientoTable.CopyFields( DmLineaMovimientoAuxTable );

                DmLineaMovimientoFields.NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;
                DmLineaMovimientoFields.CantidadAjustada.Value := DmLineaMovimientoFields.Cantidad.Value;
                DmLineaMovimientoFields.Cantidad.Value := -DmLineaMovimientoFields.Cantidad.Value;

                DmLineaMovimientoFields.Precio.Value := 0.0;  // Para que se vuelva a asignar
                DmLineaMovimientoFields.Descuento.Value := 0.0;

                Articulo.Obten( DmLineaMovimientoFields.CodigoArticulo.Value, DmArticuloFields );

                Articulo.ObtenPrecioyDtoVenta( DmMovimientoFields.TipoMovimiento.Value, DmLineaMovimientoFields, DmClienteFields.Codigo.Value );
                FacturaVentas.CalculaImportesIVA( DmMovimientoFields, DmLineaMovimientoFields, DmClienteFields, DmArticuloFields, DmSerieFacturacionFields, DmTiposIVAFields );

                DmLineaMovimientoTable.Post;

                Next;
                end;

              end;

end;

procedure TDocumentoControlMercanciasModule.CompruebaDocumentoLibre( DocumentoControlMercanciasTable : TnxeTable );
begin
     With DocumentoControlMercanciasTable do
       try
         try
           FailOnError := True;
           Edit;
         finally
           Cancel;
           end;
       except
         FailOnError := False;
         ShowNotification( ntWarning, RsMsg2, RsMsg3 );
         Abort;
         end;
end;

function TDocumentoControlMercanciasModule.ExisteNroOperacion( ValorActual : LongInt ) : Boolean;
begin
     Result := DmDocumentoControlMercanciasAuxTable.FindKey( [ ApplicationContainer.Ejercicio, ValorActual ] );
end;

function TDocumentoControlMercanciasModule.ProximoNroOperacion : LongInt;
begin
     Result := DocumentoControlMercanciasService.ProximoNroOperacion;
end;

procedure TDocumentoControlMercanciasModule.RetiraNroOperacion( DocumentoControlMercanciasFields   : TDocumentoControlMercanciasFields;
                                                                CompruebaEstado                    : Boolean = True );
begin
     If   Assigned( DocumentoControlMercanciasFields )
     then If   DocumentoControlMercanciasFields.Dataset is TnxeTable
          then With TnxeTable( DocumentoControlMercanciasFields.Dataset ) do
                 If   not CompruebaEstado or ( not InternalProcess and not ( State in [ dsEdit, dsInsert ] ) and ( PreviousState in [ dsEdit, dsInsert ] ) )
                 then Contadores.RetiraValor( cnControlMercancias, ApplicationContainer.Ejercicio, '', DocumentoControlMercanciasFields.NroOperacion.Value );
end;

end.
