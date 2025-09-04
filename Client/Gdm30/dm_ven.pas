unit dm_ven;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,

  LibUtils,
  AppForms,

  DB,
  nxdb,
  DataManager,

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

  TVendedorModule = class(TDataModule)
    DmVendedorDatEconTable: TnxeTable;
    DmTablaComisionTable: TnxeTable;
    DmVendedorTable: TnxeTable;
    procedure VendedorModuleCreate(Sender: TObject);
    procedure VendedorModuleDestroy(Sender: TObject);
  private

    FDmVendedorFields : TVendedorFields;
    FDmVendedorDatEconFields : TVendedorDatEconFields;
    DmTablaComisionFields : TTablaComisionFields;

  public

    function Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean; IsInfoControl : Boolean = False; CheckRestriction : Boolean = True ) : String;
    function Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : string;
    function Obten( Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;
    procedure AltaDatosEconomicos ( Ejercicio : SmallInt; CodigoVendedor : String; VendedorDatEconTable : TnxeTable );
    procedure CalculaAcumulados( VendedorDatEconFields : TVendedorDatEconFields; var AcumVendedor : TAcumuladoVendedor; MesInicial, MesFinal : Byte ); overload;
    procedure CalculaAcumulados( VendedorDatEconFields : TVendedorDatEconFields; AcumVendedorFields : TAcumuladoVendedorFields; MesInicial, MesFinal : Byte ); overload;
    procedure SuprimeReferencias( const Codigo : String );
    function  ObtenTipoComision( CodigoVendedor : String; CodigoCliente : String; ArticuloFields : TArticuloFields ) : Decimal;
    function VendedorPorDefecto( ClienteFields : TClienteFields ) :  String;

    property DmVendedorFields : TVendedorFields read FDmVendedorFields;
    property DmVendedorDatEconFields : TVendedorDatEconFields read FDmVendedorDatEconFields;
    end;

var  VendedorModule: TVendedorModule = nil;

function vendedor : TVendedorModule;

implementation

uses AppManager,
     EnterpriseDataAccess,
     AppContainer,

     Gdm00Dm,
     Gim00Fields,

     b_msg,

     dm_art,
     dm_sec;

{$R *.DFM}

resourceString
     RsMsg1 = 'El vendedor de código [%s] no existe.';
     RsMsg2 = 'Tiene restringido el uso de este código de vendedor.';
     RsMsg3 = 'El vendedor %s tiene asociado el siguiente aviso';
     
function vendedor : TVendedorModule;
begin
     CreateDataModule( TVendedorModule, VendedorModule );
     Result := VendedorModule;
end;

procedure TVendedorModule.VendedorModuleCreate(Sender: TObject);
begin
     FDmVendedorFields := TVendedorFields.Create( DmVendedorTable );
     FDmVendedorDatEconFields := TVendedorDatEconFields.Create( DmVendedorDatEconTable );
     DmTablaComisionFields := TTablaComisionFields.Create( DmTablaComisionTable );
end;

procedure TVendedorModule.VendedorModuleDestroy(Sender: TObject);
begin
     VendedorModule := nil;
end;

procedure TVendedorModule.AltaDatosEconomicos( Ejercicio            : SmallInt;
                                               CodigoVendedor       : String;
                                               VendedorDatEconTable : TnxeTable );
begin
    With DmVendedorDatEconTable do
      begin
      Append;
      FDmVendedorDatEconFields.Ejercicio.Value := Ejercicio;
      FDmVendedorDatEconFields.Codigo.Value := CodigoVendedor;
      Post;
      If   Assigned( VendedorDatEconTable )
      then VendedorDatEconTable.GotoCurrent( DmVendedorDatEconTable );
      end;
end;

procedure TVendedorModule.CalculaAcumulados(     VendedorDatEconFields : TVendedorDatEconFields;
                                             var AcumVendedor          : TAcumuladoVendedor;
                                                 MesInicial,
                                                 MesFinal              : Byte );

begin
     FillChar( AcumVendedor, SizeOf( AcumVendedor ), #0 );
     With SecuenciaMes do
       begin
       Reset( MesInicial, MesFinal );
       repeat
         DecAdd( AcumVendedor.TotalImporteVentas, VendedorDatEconFields.Ventas[ FMesActual ].Value );
         DecAdd( AcumVendedor.TotalImporteComisiones, VendedorDatEconFields.Comision[ FMesActual ].Value );
       until FinSecuencia;
       end;
end;

procedure TVendedorModule.CalculaAcumulados( VendedorDatEconFields : TVendedorDatEconFields;
                                             AcumVendedorFields    : TAcumuladoVendedorFields;
                                             MesInicial,
                                             MesFinal              : Byte );
begin
     With VendedorDatEconFields, AcumVendedorFields do
       begin
       TotalImporteVentas.Value := 0.0;
       TotalImporteComisiones.Value := 0.0;
       SecuenciaMes.Reset( MesInicial, MesFinal );
       With SecuenciaMes do
         repeat
           TotalImporteVentas.Value := TotalImporteVentas.Value +  Ventas[ FMesActual ].Value;
           TotalImporteComisiones.Value := TotalImporteComisiones.Value + Comision[ FMesActual ].Value;
         until FinSecuencia;
       end;
end;

function TVendedorModule.Valida(     EditControl      : TcxCustomEdit;
                                 var DisplayValue     : Variant;
                                 var ErrorText        : TCaption;
                                 var Error            : Boolean;
                                     IsInfoControl    : Boolean = False;
                                     CheckRestriction : Boolean = True ) : String;
begin

     If   CheckRestriction and DataModule00.DmUsuarioFields.Ventas_RestringirVendedor.Value
     then If   ( DataModule00.DmUsuarioFields.Ventas_VendedorDefecto.Value<>'' ) and
               ( DisplayValue<>DataModule00.DmUsuarioFields.Ventas_VendedorDefecto.Value )
          then begin
               Error := True;
               ErrorText := RsMsg2;
               Result := '';
               Exit;
               end;

     var WasEditModified := Assigned( EditControl ) and EditControl.ModifiedAfterEnter;
     Result := ValidateRelationEx( EditControl, DmVendedorTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsNombre, IsInfoControl );

     If   not Error and
          not ValueIsEmpty( DisplayValue ) and
          not IsInfoControl
     then If   WasEditModified and not ValueIsEmpty( FDmVendedorFields.Aviso.Value )
          then ApplicationContainer.ShowAlert( Format( RsMsg3, [ FDmVendedorFields.Nombre.Value ] ), FDmVendedorFields.Aviso.AsString, atVendedor );
end;

function TVendedorModule.Descripcion( Codigo             : String;
                                      NotificaSiNoExiste : Boolean = True ) : string;
begin
     GetRelationDescription( DmVendedorTable, [ Codigo ], Result, NotificaSiNoExiste );
end;

procedure TVendedorModule.SuprimeReferencias( const Codigo : String );
begin
     With DmVendedorDatEconTable do
       If   FindKey( [ ApplicationContainer.Ejercicio, Codigo ] )
       then Delete;
end;

function  TVendedorModule.Obten( Codigo             : String;
                                 NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmVendedorTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( rsMsg1, [ Codigo ] ), '' );
          Abort;
          end;
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
     If   ValueIsEmpty( DataModule00.DmUsuarioFields.Ventas_VendedorDefecto.Value )
     then Result := ClienteFields.Vendedor.Value
     else Result := DataModule00.DmUsuarioFields.Ventas_VendedorDefecto.Value;
end;


end.

