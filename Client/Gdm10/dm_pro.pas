unit dm_pro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  AppContainer,

  AppForms,

  Gim10Fields,

  DB,
  nxdb,
  DataManager,

  dmi_iva;

type

  TProveedorModule = class(TDataModule)
    DmProveedorTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

    DmProveedorFields : TProveedorFields;

  public

    function Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; ProveedorFields : TProveedorFields = nil; IsInfoControl : Boolean = False ) : String;
    function Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : string;
    function Obten( Codigo : String; CodigoSubcuenta : String = ''; ProveedorFields : TProveedorFields = nil; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function ObtenPorSubcuenta( Codigo : String; ProveedorFields : TProveedorFields; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function ObtenPorNIF( NIF : String; ProveedorFields : TProveedorFields = nil; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function IBAN( ProveedorFields : TProveedorFields = nil ) : String;
    function ObtenCodigosPaisBICeIBAN( ProveedorFields : TProveedorFields; var CodigoISOPais : String; var BIC : String; var IBAN : String ) : Boolean;

    procedure SuprimeReferencias( ProveedorFields : TProveedorFields );

  end;

var  ProveedorModule: TProveedorModule = nil;

function Proveedor : TProveedorModule;

// Modelos impositivos de proveedores

const TextoModeloImpositivoProveedor : array [ mipExento..mipRegimenEspecial ] of String = ( 'Exento de I.V.A.',
                                                                                             'Normal',
                                                                                             'Tipo fijo de I.V.A.',
                                                                                             'Régimen especial de agricultura, ganadería y pesca' );
implementation

uses AppManager,

     dm_sec,
     dm_sub,
     dm_ban,
     dm_pai,
     dm_enf,

     {
     a_sub,
     a_pro,
     }

     b_msg,
     b_pro;

{$R *.DFM}

resourceString
     RsMsg1 = 'No existen datos económicos disponibles del proveedor [%s].';
     RsMsg2 = 'El proveedor de código [%s] ha sido dado de baja.';
     RsMsg3 = 'No existe ninguna ficha de proveedor cuya subcuenta sea la %s.';
     RsMsg4 = 'No existe ninguna ficha de proveedor o acreedor cuyo N.I.F. sea %s.';
     RsMsg5 = 'Este proveedor consta como obsoleto o bloqueado y no puede ser utilizado.';
     RsMsg6 = 'El proveedor %s tiene asociado el siguiente aviso';
     
function Proveedor : TProveedorModule;
begin
     CreateDataModule( TProveedorModule, ProveedorModule );
     Result := ProveedorModule;
end;

procedure TProveedorModule.DataModuleCreate(Sender: TObject);
begin
     DmProveedorFields := TProveedorFields.Create( DmProveedorTable );
end;

procedure TProveedorModule.DataModuleDestroy(Sender: TObject);
begin
     ProveedorModule := nil;
end;

function TProveedorModule.Valida(     EditControl     : TcxCustomEdit;
                                  var DisplayValue    : Variant;
                                  var ErrorText       : TCaption;
                                  var Error           : Boolean;
                                      ProveedorFields : TProveedorFields = nil;
                                      IsInfoControl   : Boolean = False ) : String;
begin
     var WasEditModified := Assigned( EditControl ) and EditControl.ModifiedAfterEnter;
     Result := ValidateRelationEx( EditControl, DmProveedorTable, [ DisplayValue ], DisplayValue, ErrorText, Error, ProveedorFields, RsNombre, IsInfoControl );
     If   not Error and
          not ValueIsEmpty( DisplayValue ) and
          not IsInfoControl
     then begin

          If   WasEditModified and DmProveedorFields.MostrarAviso.Value
          then ApplicationContainer.ShowAlert( Format( RsMsg6, [ DmProveedorFields.Nombre.Value ] ), DmProveedorFields.Aviso.AsString, atProveedor );

          If   DmProveedorFields.Obsoleto.Value or
               DmProveedorFields.Bloqueado.Value
          then begin
               Error := True;
               ErrorText := RsMsg5;
               end;
          end;

end;

function TProveedorModule.Descripcion( Codigo             : String;
                                       NotificaSiNoExiste : Boolean = True ) : string;
begin
     GetRelationDescription( DmProveedorTable, [ Codigo ], Result, NotificaSiNoExiste );
end;

function  TProveedorModule.Obten( Codigo             : String;
                                  CodigoSubcuenta    : String = '';
                                  ProveedorFields    : TProveedorFields = nil;
                                  NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     If   Codigo=''
     then Result := ObtenPorSubcuenta( CodigoSubcuenta, ProveedorFields, NotificaSiNoExiste )
     else try
            Result := DmProveedorTable.FindKey( [ Codigo ] );
            If   NotificaSiNoExiste and not Result
            then begin
                 ShowNotification( ntStop, Format( RsMsg2, [ Codigo ] ), '' );
                 Abort;
                 end;
          finally
            If   Assigned( ProveedorFields )
            then ProveedorFields.Update( DmProveedorTable );
          end;
end;

function TProveedorModule.ObtenPorNIF( NIF                : String;
                                       ProveedorFields    : TProveedorFields = nil;
                                       NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     With DmProveedorTable do
       try

         IndexFieldNames := 'NIF';

         Result := FindKey( [ NIF ] );

         If   not Result and
              NotificaSiNoExiste
         then begin
              ShowNotification( ntStop, Format( RsMsg4, [ NIF ] ) );
              Abort;
              end;

       finally
         If   Assigned( ProveedorFields )
         then ProveedorFields.Update( DmProveedorTable );
         IndexFieldNames := 'Codigo';
         end;

end;

function TProveedorModule.ObtenPorSubcuenta( Codigo             : String;
                                             ProveedorFields    : TProveedorFields;
                                             NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := False;
     With DmProveedorTable do
       try
         IndexFieldNames := 'Subcuenta';
         Result := FindKey( [ Codigo ] );
         If   NotificaSiNoExiste and not Result
         then begin
              ShowNotification( ntStop, Format( RsMsg3, [ Codigo ] ), '' );
              Abort;
              end;
       finally
         ProveedorFields.Update( DmProveedorTable );
         IndexFieldNames := 'Codigo';
         end;
end;

procedure TProveedorModule.SuprimeReferencias( ProveedorFields : TProveedorFields );
begin
     If   not Cuenta.SuprimeSubcuenta( ProveedorFields.Subcuenta.Value )
     then Abort;
end;

function TProveedorModule.IBAN( ProveedorFields : TProveedorFields = nil ) : String;

var  CodigoIBAN : String;

begin
     CodigoIBAN := '';
     If   not Assigned( ProveedorFields )
     then ProveedorFields := DmProveedorFields;

     If   ProveedorFields.CodigoPais.Value='011'
     then begin
          CodigoIBAN := Pais.CodigoISO2( ProveedorFields.CodigoPais.Value ) +
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

function TProveedorModule.ObtenCodigosPaisBICeIBAN(     ProveedorFields : TProveedorFields;
                                                    var CodigoISOPais   : String;
                                                    var BIC             : String;
                                                    var IBAN            : String ) : Boolean;
begin
     Result := True;
     With ProveedorFields do
       If   CodigoPais.Value='011' // España
       then begin
            CodigoISOPais := Pais.CodigoISO2( CodigoPais.Value );
            IBAN := CodigoISOPais + '00' + Pago_CodigoEntidad.Value + Pago_CodigoSucursal.Value + Pago_DC.Value + Pago_CuentaCorriente.Value;
            CalculaDCIBAN( IBAN );
            BIC := EntidadFinanciera.ObtenBIC( Pago_CodigoEntidad.Value, Pago_CodigoSucursal.Value );
            If   BIC =''
            then Result := False
            end
       else begin
            BIC := Pago_BIC.Value;
            IBAN := Pago_IBAN.Value;
            end;
end;

end.
