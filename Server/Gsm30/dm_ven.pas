unit dm_ven;

interface

uses
  Windows, Messages, SysUtils, Classes, 

  DB,
  nxdb,
  DataManager,

  LibUtils,
  ServerDataModule,

  Gim10Fields,
  Gim30Fields;

type  TAcumuladoVendedor = record
        TotalImporteVentas,
        TotalImporteComisiones : Decimal;
        end;

      TAcumuladoVendedorFields = class( TnxeDatasetFields )
        TotalImporteVentas,
        TotalImporteComisiones,
        Porcentaje : TBCDField;
        end;

  TVendedorModule = class(TServerDataModule)
    DmVendedorDatEconTable: TnxeTable;
    DmTablaComisionTable: TnxeTable;
    DmVendedorTable: TnxeTable;
    procedure VendedorModuleCreate(Sender: TObject);
    procedure VendedorModuleDestroy(Sender: TObject);
  private

  public

    DmVendedorFields : TVendedorFields;
    DmVendedorDatEconFields : TVendedorDatEconFields;
    DmTablaComisionFields : TTablaComisionFields;

    function Descripcion( Codigo : String ) : string;
    function Obten( Codigo : String; VendedorFields : TVendedorFields = nil ) : Boolean;

    function ObtenTipoComision( CodigoVendedor : String; CodigoCliente : String; ArticuloFields : TArticuloFields ) : Decimal;
    function VendedorPorDefecto( ClienteFields : TClienteFields ) :  String;

    procedure AltaDatosEconomicos ( Ejercicio : SmallInt; CodigoVendedor : String; VendedorDatEconTable : TnxeTable = nil );
    end;


implementation

uses SessionData,

     dmi_art,

     dm_art,

     Gsm00Dm;

{%CLASSGROUP 'VCL.Controls.TControl'}

{$R *.DFM}

resourceString
     RsMsg1 = 'El vendedor de código [%s] no existe.';
     RsMsg2  = 'Tiene restringido el uso de este código de vendedor.';

procedure TVendedorModule.VendedorModuleCreate(Sender: TObject);
begin
     DmVendedorFields := TVendedorFields.Create( DmVendedorTable );
     DmVendedorDatEconFields := TVendedorDatEconFields.Create( DmVendedorDatEconTable );
     DmTablaComisionFields := TTablaComisionFields.Create( DmTablaComisionTable );
end;

procedure TVendedorModule.VendedorModuleDestroy(Sender: TObject);
begin
     //
end;

function TVendedorModule.Descripcion( Codigo : String ) : String;
begin
     Result := '';
     If   DmVendedorTable.FindKey( [ Codigo ] )
     then Result := DmVendedorFields.Nombre.Value;
end;

function  TVendedorModule.Obten( Codigo         : String;
                                 VendedorFields : TVendedorFields = nil ) : Boolean;
begin
     Result := DmVendedorTable.FindKey( [ Codigo ] );
     If   Assigned( VendedorFields )
     then VendedorFields.Update( DmVendedorTable );
end;

function  TVendedorModule.ObtenTipoComision( CodigoVendedor : String;
                                             CodigoCliente  : String;
                                             ArticuloFields : TArticuloFields ) : Decimal;
var TipoComision : Decimal;

begin
     TipoComision := ArticuloFields.Comision.Value;
     try
       With DmTablaComisionTable do
         If   FindKey( [ rtcoVendedorArticulo, CodigoVendedor, CodigoCliente, ArticuloFields.Codigo.Value ] )
         then TipoComision := DmTablaComisionFields.Tipo.Value
         else If   FindKey( [ rtcoVendedorArticulo, CodigoVendedor, '', ArticuloFields.Codigo.Value ] )
              then TipoComision := DmTablaComisionFields.Tipo.Value
              else If   not ValueIsEmpty( ArticuloFields.Familia.Value )
                   then begin
                        If   FindKey( [ rtcoVendedorFamilia, CodigoVendedor, CodigoCliente, ArticuloFields.Familia.Value ] )
                        then TipoComision := DmTablaComisionFields.Tipo.Value
                        else If   FindKey( [ rtcoVendedorFamilia, CodigoVendedor, '', ArticuloFields.Familia.Value ] )
                             then TipoComision := DmTablaComisionFields.Tipo.Value
                        end;
     finally
       Result := TipoComision;
       end;

end;

function TVendedorModule.VendedorPorDefecto( ClienteFields : TClienteFields ) :  String;
begin
     If   ValueIsEmpty( SessionDataModule.UsuarioFields.Ventas_VendedorDefecto.Value )
     then Result := ClienteFields.Vendedor.Value
     else Result := SessionDataModule.UsuarioFields.Ventas_VendedorDefecto.Value;
end;

procedure TVendedorModule.AltaDatosEconomicos( Ejercicio            : SmallInt;
                                               CodigoVendedor       : String;
                                               VendedorDatEconTable : TnxeTable = nil );
begin
    With DmVendedorDatEconTable do
      begin
      Append;
      DmVendedorDatEconFields.Ejercicio.Value := Ejercicio;
      DmVendedorDatEconFields.Codigo.Value := CodigoVendedor;
      Post;
      If   Assigned( VendedorDatEconTable )
      then VendedorDatEconTable.GotoCurrent( DmVendedorDatEconTable );
      end;
end;

end.

