unit dm_rpr;

interface

uses
  Windows, Messages, SysUtils, Classes, 

  DB,
  nxdb,

  LibUtils,
  DataManager,
  ServerDataModule,

  Gim10Fields,
  Gim30Fields;

type

   TAcumuladoProveedor = record
     TotalImporteCompras,
     TotalImporteDescuentos : Decimal;
     end;

  TAcumuladoProveedorFields = class( TnxeDatasetFields )
    public
    TotalImporteCompras,
    TotalImporteDescuentos,
    DescuentosSobreCompras : TBCDField;
    end;

  TRelacionesProveedorModule = class(TServerDataModule)
    DmProveedorDatEconTable: TnxeTable;
    DmTarifaComprasTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

  public

    DmProveedorDatEconFields : TProveedorDatEconFields;

    procedure AltaDatosEconomicos( Ejercicio : SmallInt; CodigoProveedor : String; ProveedorDatEconTable : TnxeTable = nil );
    procedure CalculaAcumulados( ProveedorDatEconFields : TProveedorDatEconFields; var AcumProveedor : TAcumuladoProveedor; MesInicial, MesFinal : Byte ); overload;
    procedure CalculaAcumulados( ProveedorDatEconFields : TProveedorDatEconFields; AcumuladoProveedorFields : TAcumuladoProveedorFields; MesInicial, MesFinal : SmallInt ); overload;
    function  ObtenDatosEconomicos( Codigo : String ) : Boolean;
    procedure SuprimeReferencias( ProveedorFields : TProveedorFields );
  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses SessionData,
     EnterpriseData,

     f_sec,

     dmi_art,

     dm_art;

{$R *.DFM}

resourceString
     RsMsg1 = 'No existen datos económicos disponibles del proveedor [%s].';
     RsMsg2 = 'El proveedor de código [%s] ha sido dado de baja.';
     RsMsg3 = 'No existe ninguna ficha de proveedor cuya subcuenta sea la %s.';
     //
     RsMsg5 = 'La ficha de este proveedor consta como BLOQUEADA y no puede ser usada.';

procedure TRelacionesProveedorModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmProveedorDatEconFields := TProveedorDatEconFields.Create( DmProveedorDatEconTable );
end;

procedure TRelacionesProveedorModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm30.RelacionesProveedorModule := nil;
end;

procedure TRelacionesProveedorModule.AltaDatosEconomicos( Ejercicio             : SmallInt;
                                                          CodigoProveedor       : String;
                                                          ProveedorDatEconTable : TnxeTable = nil );
begin
    with DmProveedorDatEconTable do
      begin
      Append;
      DmProveedorDatEconFields.Ejercicio.Value := Ejercicio;
      DmProveedorDatEconFields.Codigo.Value := CodigoProveedor;
      Post;
      If   Assigned( ProveedorDatEconTable )
      then ProveedorDatEconTable.FindKey( [ Ejercicio, CodigoProveedor ] )
      else FindKey( [ Ejercicio, CodigoProveedor ] );
      end;
end;

procedure TRelacionesProveedorModule.CalculaAcumulados( ProveedorDatEconFields   : TProveedorDatEconFields;
                                                        AcumuladoProveedorFields : TAcumuladoProveedorFields;
                                                        MesInicial,
                                                        MesFinal                 : SmallInt );

var  SecuenciaMes : TSecuenciaMes;

begin
     SecuenciaMes := TSecuenciaMes.Create( SessioNDataModule );
     With ProveedorDatEconFields, AcumuladoProveedorFields do
       try

         TotalImporteDescuentos.Value := 0.0;
         TotalImporteCompras.Value := 0.0;

         SecuenciaMes.Reset( MesInicial, MesFinal );
         With SecuenciaMes do
           repeat
             TotalImporteCompras.Value := TotalImporteCompras.Value + Compras[ MesActual ].Value;
             TotalImporteDescuentos.Value := TotalImporteDescuentos.Value + Descuentos[ MesActual ].Value;
           until UltimoMes;

       finally
         SecuenciaMes.Free;
       end;
end;

procedure TRelacionesProveedorModule.CalculaAcumulados(     ProveedorDatEconFields : TProveedorDatEconFields;
                                                        var AcumProveedor          : TAcumuladoProveedor;
                                                            MesInicial,
                                                            MesFinal               : Byte );
var  SecuenciaMes : TSecuenciaMes;

begin
     SecuenciaMes := TSecuenciaMes.Create( SessioNDataModule );

     With ProveedorDatEconFields, AcumProveedor do
       try
         FillChar( AcumProveedor, SizeOf( AcumProveedor ), #0 );
         SecuenciaMes.Reset( MesInicial, MesFinal );
         With SecuenciaMes do
           repeat
             DecAdd( TotalImporteCompras, Compras[ MesActual ].Value );
             DecAdd( TotalImporteDescuentos, Descuentos[ MesActual ].Value );
           until UltimoMes;
       finally
         SecuenciaMes.Free;
       end;

end;

procedure TRelacionesProveedorModule.SuprimeReferencias( ProveedorFields : TProveedorFields );
begin
     SuprimeReferencias( ProveedorFields );

     With DmProveedorDatEconTable do
       If   FindKey( [ SessionDataModule.Ejercicio, ProveedorFields.Codigo.Value ] )
       then Delete;

     EnterpriseDataModule.ExecSQLCommand( Format( 'DELETE FROM TarifaCompras WHERE Tipo=%d AND CodigoProveedor=%s', [ rtcProveedorArticulo, QuotedStr( ProveedorFields.Codigo.Value ) ] ) );

end;

function  TRelacionesProveedorModule.ObtenDatosEconomicos( Codigo : String ) : Boolean;
begin
     Result := DmProveedorDatEconTable.FindKey( [ SessionDataModule.Ejercicio, Codigo ] );
end;


end.
