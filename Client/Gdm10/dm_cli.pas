unit dm_cli;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  DB, nxdb, DataManager,

  AppContainer,

  AppForms,

  Gim00Fields,
  Gim10Fields,

  dmi_iva,

  dm_iva;

type
  TClienteModule = class( TDataModule )
    DmClienteTable: TnxeTable;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

    DmClienteFields : TClienteFields;

  public

    function Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; ClienteFields : TClienteFields = nil; IsInfoControl : Boolean = False; ShowAdvise : Boolean = True ) : String;
    function Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : String;
    function Obten( Codigo : String; CodigoSubcuenta : String = ''; ClienteFields : TClienteFields = nil; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function ObtenPorSubcuenta( Codigo : String; ClienteFields : TClienteFields; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function ObtenCodigoPaisIVA( ClienteFields : TClienteFields; DatosDisponibles : Boolean = True ) : String;
    function ObtenDireccionCorreo( Codigo : String; CompruebaDireccion: Boolean = True ): String;
    function ObtenPorEMail( EMail : String; ClienteFields : TClienteFields = nil; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function ObtenPorNIF( NIF : String; ClienteFields : TClienteFields = nil; NotificaSiNoExiste : Boolean = False ) : Boolean;

    procedure CompruebaPalabraDepaso( CodigoCliente, PalabraPaso : String );
    procedure MuestraAviso;
    function IBAN( ClienteFields : TClienteFields ) : String;
    function ObtenCodigosPaisBICeIBAN( ClienteFields : TClienteFields; var CodigoISOPais : String; var BIC : String; var IBAN : String ) : Boolean;
    function ObtenModelosImpositivos( PaisFields : TPaisFields ) : String;

    procedure SuprimeReferencias( ClienteFields : TClienteFields );

  end;

var ClienteModule: TClienteModule = nil;

function Cliente : TClienteModule;

// Modelos impositivos de clientes

const  TextoModeloImpositivoCliente : array [ micExento..micVentasOnline ] of String = ( 'Exento de I.V.A.',
                                                                                         'Sin recargo de equivalencia',
                                                                                         'Con recargo de equivalencia',
                                                                                         'Tipo fijo de I.V.A.',
                                                                                         'Ventas online intracomunitarias' );
implementation

uses EnterpriseDataAccess,
     LibUtils,
     AppManager,

     Gdm00Dm,

     dm_pai,
     dm_sec,
     dm_sub,
     dm_ecc,
     dm_sal,
     dm_ban,
     dm_enf,

     b_msg,
     b_pro;

{$R *.DFM}

resourceString
     RsMsg1 = 'Este cliente ha superado el CREDITO establecido.';
     RsMsg2 = 'El cliente de código [%s] ha sido dado de baja.';
     RsMsg3 = 'No existe ninguna ficha de cliente o deudor cuya subcuenta sea la %s.';
     RsMsg4 = 'Este cliente ha superado el riesgo LIMITE establecido.';
     RsMsg5 = 'Este cliente consta como obsoleto o bloqueado y no puede ser utilizado.';
     RsMsg6 = 'Código de cliente o palabra de paso incorrectos.';
     RsMsg7 = 'Si no conoce alguno de estos datos, póngase en contacto con el administrador de su aplicación.';
     RsMsg8 = 'No existe ninguna ficha de cliente o deudor cuya dirección de correo sea %s.';
     RsMsg9 = 'No existe ninguna ficha de cliente o deudor cuyo N.I.F. sea %s.';
     RsMsg10 = 'El cliente %s tiene asociado el siguiente aviso';
     
function Cliente : TClienteModule;
begin
     CreateDataModule( TClienteModule, ClienteModule );
     Result := ClienteModule;
end;

procedure TClienteModule.DataModuleDestroy(Sender: TObject);
begin
     ClienteModule := nil;
end;

function TClienteModule.Valida(     EditControl   : TcxCustomEdit;
                                var DisplayValue  : Variant;
                                var ErrorText     : TCaption;
                                var Error         : Boolean;
                                    ClienteFields : TClienteFields = nil;
                                    IsInfoControl : Boolean = False;
                                    ShowAdvise    : Boolean = True  ) : String;
begin
     var WasEditModified := Assigned( EditControl ) and EditControl.ModifiedAfterEnter;
     Result := ValidateRelationEx( EditControl, DmClienteTable, [ DisplayValue ], DisplayValue, ErrorText, Error, ClienteFields, RsNombre, IsInfoControl );
     If   not Error and
          not ValueIsEmpty( DisplayValue ) and
          not IsInfoControl
     then begin
          If   ShowAdvise and  DmClienteFields.MostrarAviso.Value and  WasEditModified
          then MuestraAviso;
          If   DmClienteFields.Obsoleto.Value or   // El campo Obsoleto se utiliza para clientes que ya no se quieren utilizar más, sin embargo,
               DmClienteFields.Bloqueado.Value     // Bloqueado se utiliza para bloquear temporalmente a un cliente (sigue apareciendo en listados y consultas)
          then begin
               Error := True;
               ErrorText := RsMsg5;
               end;
          end;
end;

procedure TClienteModule.MuestraAviso;
begin
     If   DmClienteFields.MostrarAviso.Value
     then ApplicationContainer.ShowAlert( Format( RsMsg10, [ DmClienteFields.Nombre.Value ] ), DmClienteFields.Aviso.AsString, atCliente );
end;

function  TClienteModule.Obten( Codigo             : String;
                                CodigoSubcuenta    : String = '';
                                ClienteFields      : TClienteFields = nil;
                                NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     If   Codigo=''
     then Result := ObtenPorSubcuenta( CodigoSubcuenta, ClienteFields, NotificaSiNoExiste )
     else try
            Result := DmClienteTable.FindKey( [ Codigo ] );
            If   NotificaSiNoExiste and not Result
            then begin
                 ShowNotification( ntStop, Format( RsMsg2, [ Codigo ] ), '' );
                 Abort;
                end;
          finally
            If   Assigned( ClienteFields )
            then ClienteFields.Update( DmClienteTable );
          end;
end;

procedure TClienteModule.DataModuleCreate(Sender: TObject);
begin
     DmClienteFields := TClienteFields.Create( DmClienteTable );
end;

function TClienteModule.Descripcion( Codigo             : String;
                                     NotificaSiNoExiste : Boolean = True ) : String;
begin
     GetRelationDescription( DmClienteTable, [ Codigo ], Result, NotificaSiNoExiste );
end;

function TClienteModule.ObtenPorEMail( EMail              : String;
                                       ClienteFields      : TClienteFields = nil;
                                       NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     With DmClienteTable do
       try
         IndexFieldNames := 'EMail';
         Result := FindKey( [ EMail ] );
         If   not Result and
              NotificaSiNoExiste
         then begin
              ShowNotification( ntStop, Format( RsMsg8, [ EMail ] ) );
              Abort;
              end;
       finally
         If   Assigned( ClienteFields )
         then ClienteFields.Update( DmClienteTable );
         IndexFieldNames := 'Codigo';
         end;
end;

function TClienteModule.ObtenPorNIF( NIF                : String;
                                     ClienteFields      : TClienteFields = nil;
                                     NotificaSiNoExiste : Boolean = False ): Boolean;
begin
     With DmClienteTable do
       try
         IndexFieldNames := 'NIF';
         Result := FindKey( [ NIF ] );
         If   not Result and
              NotificaSiNoExiste
         then begin
              ShowNotification( ntStop, Format( RsMsg9, [ NIF ] ) );
              Abort;
              end;
       finally
         If   Assigned( ClienteFields )
         then ClienteFields.Update( DmClienteTable );
         IndexFieldNames := 'Codigo';
         end;

end;

function TClienteModule.ObtenPorSubcuenta( Codigo             : String;
                                           ClienteFields      : TClienteFields;
                                           NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := False;
     With DmClienteTable do
       try
         IndexFieldNames := 'Subcuenta';
         Result := FindKey( [ Codigo ] );
         If   not Result and NotificaSiNoExiste
         then begin
              ShowNotification( ntStop, Format( RsMsg3, [ Codigo ] ), '' );
              Abort;
              end;
       finally
         ClienteFields.Update( DmClienteTable );
         IndexFieldNames := 'Codigo';
         end;

end;

procedure TClienteModule.SuprimeReferencias( ClienteFields : TClienteFields );

var  CodigoSubcuentaRiesgo : String;
     Descripcion : String;

begin

     // Solo suprimo las subcuentas si no tienen movimientos (SuprimeSubcuenta lo comprueba)
     // Tambien compruebo si la descripción de la posible subcuenta de riesgo coincide con la del cliente

     Descripcion := Cuenta.Descripcion( ClienteFields.Subcuenta.Value, True, False );
     If   Cuenta.SuprimeSubcuenta( ClienteFields.Subcuenta.Value )
     then begin
          CodigoSubcuentaRiesgo := EfectoCobrar.ObtenSubcuentaRiesgo( ClienteFields.Subcuenta.Value );
          If   Cuenta.Descripcion( CodigoSubcuentaRiesgo, True, False )=Descripcion
          then Cuenta.SuprimeSubcuenta( CodigoSubcuentaRiesgo );
          end
     else Abort;

end;

procedure TClienteModule.CompruebaPalabraDePaso( CodigoCliente, PalabraPaso : String );
begin
     If   DmClienteTable.FindKey( [ CodigoCliente ] )
     then If   PalabraPaso=DmClienteFields.PalabraPaso.Value
          then Exit;
     ShowNotification( ntWarning, RsMsg6, RsMsg7 );
     Abort;
end;


function TClienteModule.ObtenCodigoPaisIVA( ClienteFields    : TClienteFields;
                                            DatosDisponibles : Boolean = True ) : String;
begin
     If   DatosDisponibles and ( ClienteFields.Factura_ModeloIVA.Value=micVentasOnline )
     then Result := ClienteFields.CodigoPais.Value
     else Result := CodigoEspaña;  // España por defecto
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

function TClienteModule.ObtenModelosImpositivos( PaisFields : TPaisFields ) : String;

var  UltimoModelo : Short;

begin

     Result := '';

     var VentasOnline :=  DataModule00.DmEmpresaFields.Contable_VentasOnlineIntracomunitarias.Value and
                          PaisFields.Intracomunitario.Value and
                          ( PaisFields.Codigo.Value<>CodigoEspaña );
     If   VentasOnline
     then UltimoModelo := micVentasOnline
     else UltimoModelo := micTipoFijo;

     For var Inx := micExento to UltimoModelo do
       begin
       If   Result<>''
       then StrAdd( Result, ',' );
       StrAdd( Result, '"' + TextoModeloImpositivoCliente[ Inx ] + '"' );
       end;

end;

function TClienteModule.IBAN( ClienteFields : TClienteFields ) : String;

var  CodigoIBAN : String;

begin
     CodigoIBAN := '';

     If   ClienteFields.CodigoPais.Value='011'
     then begin
          CodigoIBAN := Pais.CodigoISO2( ClienteFields.CodigoPais.Value ) +
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

function TClienteModule.ObtenCodigosPaisBICeIBAN(     ClienteFields : TClienteFields;
                                                  var CodigoISOPais : String;
                                                  var BIC           : String;
                                                  var IBAN          : String ) : Boolean;
begin
     Result := True;
     With ClienteFields do
       If   CodigoPais.Value='011' // España
       then begin
            CodigoISOPais := Pais.CodigoISO2( CodigoPais.Value );
            IBAN := CodigoISOPais + '00' + Cobro_CodigoEntidad.Value + Cobro_CodigoSucursal.Value + Cobro_DC.Value + Cobro_Cuenta.Value;
            CalculaDCIBAN( IBAN );
            BIC := EntidadFinanciera.ObtenBIC( Cobro_CodigoEntidad.Value, Cobro_CodigoSucursal.Value );
            If   BIC =''
            then Result := False
            end
       else begin
            BIC := Cobro_BIC.Value;
            IBAN := Cobro_IBAN.Value;
            end;
end;

end.
