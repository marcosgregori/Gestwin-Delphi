unit dm_pro;

interface

uses
  Windows, Messages, SysUtils, Classes, 

  Gim10Fields,

  DB,
  nxdb,

  DataManager,
  ServerDataModule,

  dmi_iva;

type

  TProveedorModule = class(TServerDataModule)
    DmProveedorTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

    DmProveedorFields : TProveedorFields;

  public

    function  Descripcion( Codigo : String ) : string;
    function  Obten( Codigo : String; ProveedorFields : TProveedorFields ) : Boolean; overload;
    function  Obten( Codigo : String; CodigoSubcuenta : String; ProveedorFields : TProveedorFields ) : Boolean; overload;
    function  ObtenPorSubcuenta( Codigo : String; ProveedorFields : TProveedorFields ) : Boolean;
    function  IBAN( ProveedorFields : TProveedorFields ) : String;

    function SuprimeReferencias( ProveedorFields : TProveedorFields ) : Boolean;
  end;

// Modelos impositivos de proveedores

const TextoModeloImpositivoProveedor : array [ mipExento..mipRegimenEspecial ] of String =
                                       ( 'Exento de I.V.A.',
                                         'Normal',
                                         'Tipo fijo de I.V.A.',
                                         'Régimen especial de agricultura, ganadería y pesca' );
implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses LibUtils,
     SessionData,

     dm_pai,
     dm_ban;

{$R *.DFM}

procedure TProveedorModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmProveedorFields := TProveedorFields.Create( DmProveedorTable );
end;

procedure TProveedorModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.ProveedorModule := nil;
end;

function TProveedorModule.Descripcion( Codigo : String ) : string;
begin
     Result := '';
     If   DmProveedorTable.FindKey( [ Codigo ] )
     then Result := DmProveedorFields.Nombre.Value;
end;

function  TProveedorModule.Obten( Codigo          : String;
                                  CodigoSubcuenta : String;
                                  ProveedorFields : TProveedorFields ) : Boolean;
begin
     If   Codigo=''
     then Result := ObtenPorSubcuenta( CodigoSubcuenta, ProveedorFields )
     else begin
          Result := DmProveedorTable.FindKey( [ Codigo ] );
          ProveedorFields.Update( DmProveedorTable );
          end;
end;

function  TProveedorModule.Obten( Codigo          : String;
                                  ProveedorFields : TProveedorFields ) : Boolean;
begin
     Result := DmProveedorTable.FindKey( [ Codigo ] );
     If   Assigned( ProveedorFields )
     then ProveedorFields.Update( DmProveedorTable );
end;

function TProveedorModule.ObtenPorSubcuenta( Codigo          : String;
                                             ProveedorFields : TProveedorFields ) : Boolean;
begin
     With DmProveedorTable do
       try
         IndexFieldNames := 'Subcuenta';
         Result := FindKey( [ Codigo ] );
       finally
         IndexFieldNames := 'Codigo';
         end;
     If   Result
     then ProveedorFields.Update( DmProveedorTable )
     else ProveedorFields.Clear( DmProveedorTable );
end;

function TProveedorModule.SuprimeReferencias( ProveedorFields : TProveedorFields ) : Boolean;
begin
     Result := SessionDataModule.Dm10.CuentaModule.SuprimeSubcuenta( ProveedorFields.Subcuenta.Value );
end;

function TProveedorModule.IBAN( ProveedorFields : TProveedorFields ) : String;

var  CodigoIBAN : String;

begin
     CodigoIBAN := '';
     If   ProveedorFields.CodigoPais.Value='011'
     then begin
          CodigoIBAN := SessionDataModule.Dm00.PaisModule.CodigoISO2( ProveedorFields.CodigoPais.Value ) +
                                                                      '00' +
                                                                      ProveedorFields.Pago_CodigoEntidad.Value +
                                                                      ProveedorFields.Pago_CodigoSucursal.Value +
                                                                      ProveedorFields.Pago_DC.Value +
                                                                      ProveedorFields.Pago_CuentaCorriente.Value;
          If   CodigoIBAN.Length>4
          then CalculaDCIBAN( CodigoIBAN )
          else CodigoIBAN := '';
          end
     else CodigoIBAN := ProveedorFields.Pago_IBAN.Value;

     Result := CodigoIBAN;
end;
end.
