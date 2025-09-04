unit dm_cli;

interface

uses
  Windows, Messages, SysUtils, Classes, 
  DB, nxdb,


  DataManager,
  ServerDataModule,
  Gim10Fields,

  dmi_iva;

type
  TClienteModule = class( TServerDataModule )
    DmClienteTable: TnxeTable;
    DmDireccionContactoTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);

  private

  public

    DmClienteFields : TClienteFields;
    DmDireccionContactoFields : TDireccionContactoFields;

    function  Descripcion( Codigo : String ) : String;

    function Obten( Codigo : String; ClienteFields : TClienteFields = nil ) : Boolean; overload;
    function Obten( Codigo : String; CodigoSubcuenta : String; ClienteFields : TClienteFields = nil ) : Boolean; overload;
    function ObtenPorSubcuenta( Codigo : String; ClienteFields : TClienteFields = nil ) : Boolean;
    function ObtenPorEMail( EMail : String; ClienteFields : TClienteFields = nil ) : Boolean;

    function  ObtenDireccionCorreo( Codigo : String; CompruebaDireccion: Boolean = True ): String;
    function ObtenCodigoPaisIVA( ClienteFields : TClienteFields ) : String;
    procedure ActualizaLocalizacion( Codigo : String; Latitud, Longitud : Double );
    function  IBAN( ClienteFields : TClienteFields ) : String;

    property ClienteFields : TClienteFields read DmClienteFields;
    property DireccionContactoFields : TDireccionContactoFields read DmDireccionContactoFields;
  end;

// Modelos impositivos de clientes

const  TextoModeloImpositivoCliente : array [ micExento..micTipoFijo ] of String =
                                     ( 'Exento de I.V.A.',
                                       'Sin recargo de equivalencia',
                                       'Con recargo de equivalencia',
                                       'Tipo fijo de I.V.A.' );
implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses EnterpriseData,
     LibUtils,
     SessionData,

     Gim00Fields,

     dm_ban;

{$R *.DFM}

procedure TClienteModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.ClienteModule := nil;
end;

function  TClienteModule.Obten( Codigo             : String;
                                CodigoSubcuenta    : String;
                                ClienteFields      : TClienteFields = nil ) : Boolean;
begin
     If   Codigo=''
     then Result := ObtenPorSubcuenta( CodigoSubcuenta, ClienteFields )
     else begin
          Result := DmClienteTable.FindKey( [ Codigo ] );
          If   Assigned( ClienteFields )
          then ClienteFields.Update( DmClienteTable );
          end;
end;

function  TClienteModule.Obten( Codigo          : String;
                                ClienteFields   : TClienteFields = nil ) : Boolean;
begin
     Result := DmClienteTable.FindKey( [ Codigo ] );
     If   Assigned( ClienteFields )
     then ClienteFields.Update( DmClienteTable );
end;

procedure TClienteModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmClienteFields := TClienteFields.Create( DmClienteTable );
     DmDireccionContactoFields := TDireccionContactoFields.Create( DmDireccionContactoTable );
end;

function TClienteModule.Descripcion( Codigo : String ) : String;
begin
     Result := '';
     If   DmClienteTable.FindKey( [ Codigo ] )
     then Result := DmClienteFields.Nombre.Value;
end;

function TClienteModule.ObtenPorSubcuenta( Codigo        : String;
                                           ClienteFields : TClienteFields = nil ) : Boolean;
begin
     With DmClienteTable do
       try
         IndexFieldNames := 'Subcuenta';
         Result := FindKey( [ Codigo ] );
         If   Assigned( ClienteFields )
         then ClienteFields.Update( DmClienteTable );
       finally
         IndexFieldNames := 'Codigo';
         end;
end;

function TClienteModule.ObtenPorEMail( EMail         : String;
                                       ClienteFields : TClienteFields = nil ) : Boolean;
begin
     With DmClienteTable do
       try
         IndexFieldNames := 'EMail';
         Result := FindKey( [ EMail ] );

         // El cambio de índice llama a ReSync y el cursor se reposiciona al principio si no se ha encontrado el registro.
         // Por eso hay que actualizar el dataset antes.

         If   Assigned( ClienteFields )
         then ClienteFields.Update( DmClienteTable );
       finally
         IndexFieldNames := 'Codigo';
         end;


end;

procedure TClienteModule.ActualizaLocalizacion( Codigo   : String;
                                                Latitud,
                                                Longitud : Double );
begin
     If   DmClienteTable.FindKey( [ Codigo ] )
     then try
            DmClienteTable.Edit;
            DmClienteFields.Latitud.Value := Latitud;
            DmClienteFields.Longitud.Value := Longitud;
            DmClienteTable.Post;
          except
            DmClienteTable.Cancel;
            // Si el registro está bloqueado no se actualiza y punto (no hay raise)
            end;
end;

function TClienteModule.ObtenDireccionCorreo( Codigo             : String;
                                              CompruebaDireccion : Boolean = True ) : String;
begin
     Result := '';
     If   DmClienteTable.FindKey( [ Codigo ] )
     then begin
          Result := DmClienteFields.EMail.Value;
          If   ( Result<>'' ) and CompruebaDireccion
          then begin

               // mi@dom.com

               If   ( Pos( '@', Result  )<3 ) or ( RightPos( '.', Result )<7 )
               then Result := '';

               end;
          end;
end;

function TClienteModule.ObtenCodigoPaisIVA( ClienteFields : TClienteFields ) : String;
begin
     If   ClienteFields.Factura_ModeloIVA.Value=micVentasOnline
     then Result := ClienteFields.CodigoPais.Value
     else Result := CodigoEspaña;  // España por defecto
end;

function TClienteModule.IBAN( ClienteFields : TClienteFields ) : String;

var  CodigoIBAN : String;

begin
     CodigoIBAN := '';
     If   ClienteFields.CodigoPais.Value=CodigoEspaña
     then begin
          CodigoIBAN := SessionDataModule.Dm00.PaisModule.CodigoISO2( ClienteFields.CodigoPais.Value ) +
                        '00' +
                        ClienteFields.Cobro_CodigoEntidad.Value +
                        ClienteFields.Cobro_CodigoSucursal.Value +
                        ClienteFields.Cobro_DC.Value +
                        ClienteFields.Cobro_Cuenta.Value;
          If   CodigoIBAN.Length>4
          then CalculaDCIBAN( CodigoIBAN )
          else CodigoIBAN := '';
          end
     else CodigoIBAN := ClienteFields.Cobro_IBAN.Value;
     Result := CodigoIBAN;
end;


end.
