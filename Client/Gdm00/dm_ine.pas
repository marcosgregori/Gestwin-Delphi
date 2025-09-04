unit dm_ine;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  cxIndexedComboBox,

  LibUtils,

  AppForms,

  Gim00Fields,
  DB,
  nxdb,
  DataManager;

type
   TModeloImpreso = ( impDocumentoCobro,
                      impCartaRemesa,
                      impDocumentoPago,
                      impCartaPago,
                      impEtiquetasClientes,
                      impEtiquetasProveedores,
                      impEtiquetasArticulos,
                      impEtiquetasEnvio,
                      impPedidosCompra,
                      impAlbaranesCompra,
                      impFacturasCompra,
                      impPresupuestos,
                      impPedidosVenta,
                      impAlbaranesVenta,
                      impFacturasVenta,
                      impOfertas,
                      impEtiquetasContactos,
                      impImpresosClientes,
                      impHojaCarga,
                      impMovimientosCaja,
                      impPackingList,
                      impMovimientosAlmacen,
                      impInformeContable,
                      impReservado9,
                      impReservado10,
                      impReservado11,
                      impReservado12,
                      impReservado13,
                      impReservado14,
                      impReservado15,
                      impReservado16,
                      impDefinidoUsuario );


  TInformeExternoModule = class(TDataModule)
    DmInformeExternoTable: TnxeTable;
    procedure DmInformeExternoTableAfterOpen(DataSet: TDataSet);
    procedure InformeExternoModuleDestroy(Sender: TObject);
  private

    DmInformeExternoFields : TInformeExternoFields;

    FImpresora,
    FPagina,
    FFichero : String;

  public

    procedure Valida( ModeloImpreso : TModeloImpreso; EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; InformeExternoFields : TInformeExternoFields = nil; IsInfoControl : Boolean = False  ); overload;
    function  ObtenFormatoUsuario( modeloImpreso : TModeloImpreso ) : smallInt;
    procedure AsignaTextoModeloImpreso( ComboBox : TcxDBIndexedComboBox );
    procedure FijaFormato;
    procedure LimpiaFormato;
    property Impresora : String read FImpresora;
    // property Pagina : String read FPagina;
    property Fichero : String read FFichero;
  end;

var  InformeExternoModule : TInformeExternoModule = nil;


function  InformeExterno : TInformeExternoModule;

const  TextoModeloImpreso : array[ Ord( impDocumentoCobro )..Ord( impInformeContable ) ] of String =
                                 ( 'Documento de cobro (recibo)',
                                   'Carta de remesa',
                                   'Documento de pago (pagaré, cheque, etc..)',
                                   'Carta de pago',
                                   'Etiquetas de clientes',
                                   'Etiquetas de proveedores',
                                   'Etiquetas de articulos',
                                   'Etiquetas de envío',
                                   'Pedidos de compra',
                                   'Albaranes de compra',
                                   'Facturas de compra',
                                   'Presupuestos',
                                   'Pedidos de venta',
                                   'Albaranes de venta',
                                   'Facturas de venta',
                                   'Ofertas',
                                   'Etiquetas de contactos',
                                   'Impresos de clientes',
                                   'Hojas de carga',
                                   'Movimientos de caja',
                                   'Packing list',
                                   'Movimientos de almacén',
                                   'Informe contable' );


implementation

uses Variants,

     AppManager,
     AppContainer,
     DataAccess;

{$R *.dfm}

resourceString
     RsMsg1 = '[Predeterminado]';

function InformeExterno : TInformeExternoModule;
begin
     CreateDataModule( TInformeExternoModule, InformeExternoModule );
     Result := InformeExternoModule;
end;

procedure TInformeExternoModule.DmInformeExternoTableAfterOpen(DataSet: TDataSet);
begin
     DmInformeExternoFields := TInformeExternoFields.Create( DmInformeExternoTable );
end;

procedure TInformeExternoModule.InformeExternoModuleDestroy(Sender: TObject);
begin
     InformeExternoModule := nil;
end;

procedure TInformeExternoModule.FijaFormato;
begin
     With DmInformeExternoFields do
       begin
       FImpresora := Impresora.Value;
       FPagina := Pagina.Value;
       FFichero := Fichero.Value;
       end;
end;

procedure TInformeExternoModule.LimpiaFormato;
begin
     FImpresora := '[]';
     FPagina := '[]';
     FFichero := '';
end;

procedure TInformeExternoModule.Valida(     ModeloImpreso        : TModeloImpreso;
                                            EditControl           : TcxCustomEdit;
                                        var DisplayValue         : Variant;
                                        var ErrorText            : TCaption;
                                        var Error                : Boolean;
                                            InformeExternoFields : TInformeExternoFields = nil;
                                            IsInfoControl        : Boolean = False  );
begin
     If   ValueIsEmpty( DisplayValue, varSmallInt )
     then begin
          LimpiaFormato;
          EditControl.Description := RsMsg1;
          If   Assigned( InformeExternoFields )
          then InformeExternoFields.Clear( DmInformeExternoTable );
          end
     else begin
          ValidateRelation( EditControl, DmInformeExternoTable, [ Ord( ModeloImpreso ), VarToSmallInt( DisplayValue ) ], DisplayValue, ErrorText, Error, InformeExternoFields, RsDescripcion, IsInfoControl );
          FijaFormato;
          end;
end;

function TInformeExternoModule.ObtenFormatoUsuario( ModeloImpreso : TModeloImpreso ) : SmallInt;
begin

     { Se busca primero una combinación de Modelo-Empresa-Usuario, si no se encuentra
       se pasa a buscar una del tipo Modelo-Empresa genérica-Usuario }

     LimpiaFormato;

     Result := 0;
     With DmInformeExternoTable, ApplicationContainer do
       try
         IndexFieldNames := 'Empresa;Usuario;TipoDocumento;NroRegistro';
         If   FindEqualFirst( [ CodigoEmpresaActual, CodigoUsuarioActual, Ord( ModeloImpreso ) ] )
         then Result := DmInformeExternoFields.NroRegistro.Value
         else If   FindEqualFirst( [ Null, CodigoUsuarioActual, Ord( ModeloImpreso ) ] ) or
                   FindEqualFirst( [ '', CodigoUsuarioActual, Ord( ModeloImpreso ) ] )
              then Result := DmInformeExternoFields.NroRegistro.Value;
         If   Result<>0
         then FijaFormato;
       finally
         IndexFieldNames := 'TipoDocumento;NroRegistro';
         end;

end;

procedure TInformeExternoModule.AsignaTextoModeloImpreso( ComboBox : TcxDBIndexedComboBox );

var  Index : SmallInt;

begin
     With ComboBox.Properties do
       begin
       Items.Clear;
       For Index := Ord( impDocumentoCobro ) to Ord( impInformeContable ) do
          Items.Add( TextoModeloImpreso[ Index ] );
       end;
end;

end.
