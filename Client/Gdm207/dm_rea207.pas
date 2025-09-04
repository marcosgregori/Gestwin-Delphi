
unit dm_rea207;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,

  AppForms,
  DB,
  nxdb,
  DataManager,
  cxEdit,
  cxEditRepositoryItems,

  Gim30Fields,

  dmi_iva,

  dm_rea;

const
   CodigoISOEspaña = 'ES';

type

  TTaxClassType = ( ttcCustomer, ttcProduct );

  TRegistroActualizacionTiendaModule = class(TDataModule)
    DmRegistroActualizacionIDTable: TnxeTable;
    DmRegistroActualizacionCodigoTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

  public

    DmRegistroActualizacionCodigoFields,
    DmRegistroActualizacionIDFields : TRegistroActualizacionFields;

    function ObtenId( TipoRegistro : Word; Codigo : String ) : Integer;
    function ObtenCodigo( TipoRegistro : Word; Id : Integer ) : String;

    function ObtenTaxClassId( NroTipoImpositivo : SmallInt; TaxClassType : TTaxClassType ) : Integer;
    function ObtenTaxRateId( NroTipoImpositivo: SmallInt; ModeloImpositivo : SmallInt = micSinRE; CodigoISOPais : String = CodigoISOEspaña ) : Integer;
    function ObtenCustomerGroupId( IndiceGrupo : SmallInt ) : Integer;

    procedure Modificado( TipoRegistro : Word; Codigo : String; ImagenModificada : Boolean = False );
    function PendienteActualizar( TipoRegistro : Word; Codigo : String ) : Boolean;

    procedure InvalidaRegistros( TipoRegistro : Word; Suprimir : Boolean = True );
    procedure SuprimeFechaUltimaActualización;
  end;

function  RegistroActualizacionTienda : TRegistroActualizacionTiendaModule;

// Tipo de registro

const rgaGlobal = 0;
      rgaCategoria = 1;
      rgaArticulo  = 2;
      rgaStock = 3;
      rgaCliente = 4;
      rgaCustomerGroup = 5;
      rgaTaxClass = 6;
      rgaTaxRate = 7;
      rgaTaxRule = 8;
      rgaOrder = 9;
      rgaShipment = 10;
      rgaInvoice = 11;
      rgaTarifaCliente = 12;
      rgaTarifaFamilia = 13;
      rgaVarianteArticulo = 14;
      rgaClase = 15;

implementation

uses LibUtils,
     Variants,
     EnterpriseDataAccess,
     AppManager;

{$R *.DFM}

var RegistroActualizacionTiendaModule: TRegistroActualizacionTiendaModule = nil;

function RegistroActualizacionTienda : TRegistroActualizacionTiendaModule;
begin
     CreateDataModule( TRegistroActualizacionTiendaModule, RegistroActualizacionTiendaModule );
     Result := RegistroActualizacionTiendaModule;
end;

procedure TRegistroActualizacionTiendaModule.DataModuleCreate(Sender: TObject);
begin
     DmRegistroActualizacionIDFields := TRegistroActualizacionFields.Create( DmRegistroActualizacionIDTable );        // TipoRegistro;ID
     DmRegistroActualizacionCodigoFields:= TRegistroActualizacionFields.Create( DmRegistroActualizacionCodigoTable ); // TipoRegistro;Codigo
end;

procedure TRegistroActualizacionTiendaModule.DataModuleDestroy(Sender: TObject);
begin
     RegistroActualizacionTiendaModule := nil;
end;

function TRegistroActualizacionTiendaModule.ObtenId( TipoRegistro : Word;
                                                     Codigo       : String ) : Integer;
begin
     If   DmRegistroActualizacionCodigoTable.FindKey( [ TipoRegistro, Codigo ] )
     then Result := DmRegistroActualizacionCodigoFields.Id.Value
     else Result := -1;
end;

function TRegistroActualizacionTiendaModule.ObtenTaxClassId( NroTipoImpositivo : SmallInt;
                                                             TaxClassType      : TTaxClassType ) : Integer;

const TaxClassTypeName : array[ ttcCustomer..ttcProduct ] of String = ( 'CUSTOMER', 'PRODUCT' );

begin
     Result := ObtenId( rgaTaxClass, IntToStr( NroTipoImpositivo ) + '-' + TaxClassTypeName[ TaxClassType ] );
end;

function TRegistroActualizacionTiendaModule.ObtenTaxRateId( NroTipoImpositivo : SmallInt;
                                                            ModeloImpositivo  : SmallInt = micSinRE;
                                                            CodigoISOPais     : String = CodigoISOEspaña ) : Integer;
begin
     var CodigoRegistro := CodigoISOPais + IfThen( CodigoISOPais<>'', '-' ) + IntToStr( NroTipoImpositivo ) + '-' + IntToStr( Ord( ModeloImpositivo ) );
     Result := ObtenId( rgaTaxRate, CodigoRegistro );
end;

function TRegistroActualizacionTiendaModule.ObtenCustomerGroupId( IndiceGrupo  : SmallInt ) : Integer;
begin
     Result := ObtenId( rgaCustomerGroup, IntToStr( IndiceGrupo ) );
end;

function TRegistroActualizacionTiendaModule.ObtenCodigo( TipoRegistro : Word;
                                                         Id           : Integer ) : String;
begin
     If   DmRegistroActualizacionIDTable.FindKey( [ TipoRegistro, Id ] )
     then Result := DmRegistroActualizacionIDFields.Codigo.Value
     else Result := '';
end;

procedure TRegistroActualizacionTiendaModule.Modificado( TipoRegistro     : Word;
                                                         Codigo           : String;
                                                         ImagenModificada : Boolean = False );
begin
     With RegistroActualizacion do
       try
         If   DmRegistroActualizacionTable.FindKey( [ TipoRegistro, Codigo ] )
         then DmRegistroActualizacionTable.Edit
         else begin
              DmRegistroActualizacionTable.Append;
              RegistroActualizacionFields.TipoRegistro.Value := TipoRegistro;
              RegistroActualizacionFields.Codigo.Value := Codigo;
              end;
         If   ImagenModificada
         then RegistroActualizacionFields.ImagenActualizada.Value := False;
         RegistroActualizacionFields.Actualizado.Value := False;
         DmRegistroActualizacionTable.Post;
       except
         DmRegistroActualizacionTable.Cancel;
         raise;
         end;
end;

function TRegistroActualizacionTiendaModule.PendienteActualizar( TipoRegistro : Word;
                                                                 Codigo       : String ) : Boolean;
begin
     Result := False;
     With RegistroActualizacion do
       If   DmRegistroActualizacionTable.FindKey( [ TipoRegistro, Codigo ] )
       then Result := not RegistroActualizacionFields.Actualizado.Value;
end;

procedure TRegistroActualizacionTiendaModule.InvalidaRegistros( TipoRegistro : Word;
                                                                Suprimir     : Boolean = True );

var  QueryCommand : String;

begin

     If   Suprimir
     then QueryCommand := 'DELETE FROM RegistroActualizacion'
     else QueryCommand := 'UPDATE RegistroActualizacion SET Actualizado=False ';

     If   TipoRegistro<>rgaGlobal
     then StrAdd( QueryCommand, ' WHERE TipoRegistro=' + IntToStr( TipoRegistro ) );

     EnterpriseDataModule.ExecQuery( QueryCommand );

     // Si se está invalidando el registro de clientes se borra también la fecha de la última actualización, porque se usa
     // para determinar los clientes a actualizar desde la tienda

     If   TipoRegistro=rgaCliente
     then SuprimeFechaUltimaActualización;

end;

procedure TRegistroActualizacionTiendaModule.SuprimeFechaUltimaActualización;
begin
     EnterpriseDataModule.ExecQuery( 'DELETE FROM RegistroActualizacion WHERE TipoRegistro=0 AND Codigo=''FUA''' );
end;

end.

