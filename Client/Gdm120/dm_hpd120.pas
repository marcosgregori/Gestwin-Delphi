
unit dm_hpd120;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,

  clMailMessage,

  LibUtils,
  SqlSet,

  AppForms,

  DB,
  Nxdb,
  DataManager,

  Gim30Fields,

  dmi_mov;

type

  THojaPedidoFields = class( TnxeDatasetFields )
    Ejercicio : TSmallIntField;
    Serie : TWideStringField;
    NroDocumento : TIntegerField;
    NroOperacion : TIntegerField;
    Fecha : TDateField;
    FechaEntrega : TDateField;
    CodigoCliente : TWideStringField;
    NombreCliente : TWideStringField;
    NroLinea : TSmallIntField;
    CodigoArticulo : TWideStringField;
    CodigoClaseA : TWideStringField;
    CodigoClaseB : TWideStringField;
    CodigoClaseC : TWideStringField;
    Descripcion : TWideStringField;
    CodigoAlmacen : TWideStringField;
    NombreAlmacen : TWideStringField;
    Cantidad : TBCDField;
    Servido : TBCDField;
    Precio : TFloatField;
    ImporteBruto : TBCDField;
    Descuento : TBCDField;
    Recargo : TBCDField;
    ImporteNeto : TBCDField;
    Existencias : TBCDField;
    ExistenciasVirtuales : TBCDField;

    Ejercicio1 : TSmallIntField;
    Serie1 : TWideStringField;
    NroDocumento1 : TIntegerField;
    NroOperacion1 : TIntegerField;
    CodigoProveedor : TWideStringField;
    NombreProveedor : TWideStringField;
    Recibido : TBCDField;

    Ejercicio2 : TSmallIntField;
    Serie2 : TWideStringField;
    NroDocumento2 : TIntegerField;
    NroOperacion2 : TIntegerField;
    PrecioCompra : TBCDField;
    end;

  THojasDePedido120Module = class(TDataModule )
    DmRelacionDocumentosTable: TnxeTable;
    DmLineaMovimientoTable: TnxeTable;
    DmLineaMovimientoDestinoTable: TnxeTable;
    DmMovimientoDestinoTable: TnxeTable;
    DmMovimientoTable: TnxeTable;
    SQLSet: TgxSQLSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private

    DmRelacionDocumentosFields : TRelacionDocumentosFields;
    DmMovimientoFields,
    DmMovimientoDestinoFields : TMovimientoFields;
    DmLineaMovimientoFields,
    DmLineaMovimientoDestinoFields : TLineaMovimientoFields;

    procedure SituacionHojasPedidoItemClick(Sender: TObject);
    procedure CostesHojasPedidoItemClick(Sender: TObject);
    procedure DoOnAdjuntaFicherosCorreo(MailMessage: TclMailMessage; NroOperacion: LongInt);

  public

    function ObtenLineaMovimientoDestino( LineaMovimientoFields : TLineaMovimientoFields; TipoMovimientoOrigen  : TTipoMovimiento = tmPedidoVenta; TipoMovimientoDestino : TTipoMovimiento = tmPedidoCompra ) : Boolean;

    procedure DoOnLoadAttachment(     Sender    : TObject;
                                      ABody     : TclAttachmentBody;
                                  var AFileName : string;
                                  var AData     : TStream;
                                  var Handled   : Boolean );

    procedure DoOnFiltroSeleccionDocumentos( LineaMovimientoFields : TLineaMovimientoFields; var Accept : Boolean );

    property MovimientoDestinoFields : TMovimientoFields read DmMovimientoDestinoFields;
    property LineaMovimientoDestinoFields : TLineaMovimientoFields read DmLineaMovimientoDestinoFields;

  end;

var HojasDePedido120Module: THojasDePedido120Module = nil;

function  HojasDePedido120 : THojasDePedido120Module;

implementation

uses DateUtils,
     AppManager,
     EnterpriseDataAccess,
     AppContainer,

     Gdm30Frm,

     dm_iex,
     dm_pga,
     dm_mov,
     dm_rdm,

     a_mco,
     a_mve,

     l_shp;

{$R *.DFM}

function HojasDePedido120 : THojasDePedido120Module;
begin
     CreateDataModule( THojasDePedido120Module, HojasDePedido120Module );
     Result := HojasDePedido120Module;
end;

procedure THojasDePedido120Module.DataModuleCreate(Sender: TObject);
begin
     DmRelacionDocumentosFields := TRelacionDocumentosFields.Create( DmRelacionDocumentosTable );
     DmMovimientoFields := TMovimientoFields.Create( DmMovimientoTable );
     DmMovimientoDestinoFields := TMovimientoFields.Create( DmMovimientoDestinoTable );
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );
     DmLineaMovimientoDestinoFields := TLineaMovimientoFields.Create( DmLineaMovimientoDestinoTable );

     With Gds30Frm do
       begin
       SetBarItemsVisible( [ SituacionHojasPedidoItem, CostesHojasPedidoItem ] );
       SituacionHojasPedidoItem.OnClick := SituacionHojasPedidoItemClick;
       CostesHojasPedidoItem.OnClick := CostesHojasPedidoItemClick;
       end;
end;

procedure THojasDePedido120Module.DataModuleDestroy(Sender: TObject);
begin
     HojasDePedido120Module := nil;
end;

procedure THojasDePedido120Module.SituacionHojasPedidoItemClick( Sender : TObject );
begin
     ListadoSituacionHojasPedido;
end;

procedure THojasDePedido120Module.CostesHojasPedidoItemClick(Sender: TObject);
begin
     ListadoSituacionHojasPedido( { CostesAsociados } True );
end;

procedure THojasDePedido120Module.DoOnAdjuntaFicherosCorreo( MailMessage  : TclMailMessage;
                                                             NroOperacion : LongInt );

var  NroRegistro : LongInt;
     AttachmentBody : TclAttachmentBody;

begin
     With DmLineaMovimientoTable do
       begin
       SetRange( [ ApplicationContainer.Ejercicio, NroOperacion ] );
       First;
       While not Eof do
         begin
         If   DmMovimientoTable.FindKey( [ DmLineaMovimientoFields.Ejercicio.Value, DmLineaMovimientoFields.NroOperacion.Value ] )
         then begin
              If   DmMovimientoFields.TipoMovimiento.Value=tmPedidoVenta
              then NroRegistro := DmLineaMovimientoFields.NroRegistro.Value
              else NroRegistro := DmLineaMovimientoFields.NroRegistroOrigen.Value;
              DmRelacionDocumentosTable.SetRange( [ trdLineaMovimiento, NroRegistro ] );
              While not DmRelacionDocumentosTable.Eof do
                begin
                AttachmentBody := MailMessage.Bodies.AddAttachment( DmRelacionDocumentosFields.Documento.Value );
                AttachmentBody.ContentID := DmLineaMovimientoFields.CodigoArticulo.Value;
                DmRelacionDocumentosTable.Next;
                end;
              end;
         Next;
         end
       end;
end;

procedure THojasDePedido120Module.DoOnFiltroSeleccionDocumentos(     LineaMovimientoFields : TLineaMovimientoFields;
                                                                 var Accept : Boolean );
begin
     Accept := not ObtenLineaMovimientoDestino( LineaMovimientoFields );
end;

procedure THojasDePedido120Module.DoOnLoadAttachment(Sender: TObject; ABody: TclAttachmentBody; var AFileName: string; var AData: TStream; var Handled: Boolean);
begin
     //
end;

function THojasDePedido120Module.ObtenLineaMovimientoDestino( LineaMovimientoFields : TLineaMovimientoFields;
                                                              TipoMovimientoOrigen  : TTipoMovimiento = tmPedidoVenta;
                                                              TipoMovimientoDestino : TTipoMovimiento = tmPedidoCompra ) : Boolean;
begin

     Result := IsBitSet( LineaMovimientoFields.Parametros.Value, 0 ) or
               IsBitSet( LineaMovimientoFields.Parametros.Value, 1 )        // Marca de 'No pedir al proveedor'
     {

     // Solo se devuelve el primer movimiento del tipo especificado. En este caso el cliente no exporta las líneas de pedidos de venta a más
     // de un pedido de compra. Tampoco, en el caso de la exportación a albaranes de compra desde pedidos de compra, se supone que haya más
     // de uno.

     If   not Result
     then With DmLineaMovimientoDestinoTable do
            begin
            SetRange( [ LineaMovimientoFields.NroRegistro.Value ] );
            First;
            While not Eof do
              begin
              If   DmLineaMovimientoDestinoFields.TipoMovimientoOrigen.Value=TipoMovimientoOrigen
              then If   DmMovimientoDestinoTable.FindKey( [ DmLineaMovimientoDestinoFields.Ejercicio.Value, DmLineaMovimientoDestinoFields.NroOperacion.Value ] )
                   then If   DmMovimientoDestinoFields.TipoMovimiento.Value=TipoMovimientoDestino
                        then begin
                             Result := True;
                             Exit;
                             end;
              Next;
              end;
            end;
     }
end;

procedure SetupMovimientoModule;
begin
     Movimiento.OnAdjuntaFicherosCorreo.Add( HojasDePedido120.DoOnAdjuntaFicherosCorreo );
end;

procedure SetupFiltroSeleccionDocumentos;
begin
     If   Assigned( MntMveForm[ tmPedidoVenta ] )
     then MntMveForm[ tmPedidoVenta ].OnFiltroSeleccionDocumentos.Add( HojasDePedido120.DoOnFiltroSeleccionDocumentos );
end;

procedure SetupMantenimientoPedidos;
begin
     If   Assigned( MntMcoForm[ tmPedidoCompra ] )
     then With MntMcoForm[ tmPedidoCompra ] do
            MostrarNroDocumentoOrigen := True;
end;

procedure InitializeModule;
begin    
     HojasDePedido120;
end;

initialization

     AddProcedure( imOptionalSectionModule, 120 );
     AddProcedure( imOnEnterpriseAccess, 0, InitializeModule );
     AddProcedure( imOnCreateComponent, idMovimientoModule, SetupMovimientoModule );
     AddProcedure( imOnCreateComponent, idMntMcoForm, SetupMantenimientoPedidos );
     AddProcedure( imOnCreateComponent, idMntMveForm, SetupFiltroSeleccionDocumentos );

end.

