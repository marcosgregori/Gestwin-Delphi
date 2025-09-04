
unit dm_cdt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, cxEdit,
  AppContainer,

  AppForms,

  DB, nxdb, DataManager,

  Gim30Fields;

type
  TCodigoTarifaModule = class(TDataModule)
    DmCodigoTarifaTable: TnxeTable;
    DmTarifaVentasTable: TnxeTable;
    procedure codigoTarifaModuleCreate(Sender: TObject);
    procedure CodigoTarifaModuleDestroy(Sender: TObject);
  private

    DmCodigoTarifaFields  : TCodigoTarifaFields;

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean;IsInfoControl : Boolean = False );
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : string;
    function  ExistenReferencias( Codigo : String ) : Boolean;
    procedure SuprimeReferencias( Codigo : String );
  end;

var
  CodigoTarifaModule: TCodigoTarifaModule = nil;


function CodigoTarifa : TCodigoTarifaModule;

resourceString
       RsTarifaMsg1  = '¿Está seguro de que quiere suprimir todas las tarifas seleccionadas?';
       RsTarifaMsg2  = 'Solo se suprimiran las referencias de las tarifas incluidas en la selección realizada.';

implementation

uses Variants,
     AppManager,
     EnterpriseDataAccess;

{$R *.DFM}

function CodigoTarifa : TcodigoTarifaModule;
begin
     CreateDataModule( TCodigoTarifaModule, CodigoTarifaModule );
     Result := CodigoTarifaModule;
end;

procedure TCodigoTarifaModule.CodigoTarifaModuleCreate(Sender: TObject);
begin
     DmCodigoTarifaFields := TCodigotarifaFields.Create( DmCodigotarifaTable );
end;

procedure TCodigoTarifaModule.CodigoTarifaModuleDestroy(Sender: TObject);
begin
     CodigoTarifaModule := nil;
end;

procedure TCodigoTarifaModule.Valida(     EditControl   : TcxCustomEdit;
                                      var DisplayValue  : Variant;
                                      var ErrorText     : TCaption;
                                      var Error         : Boolean;
                                          IsInfoControl : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmCodigoTarifaTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

function TCodigoTarifaModule.Descripcion( Codigo             : String;
                                          NotificaSiNoExiste : Boolean = True ) : string;
begin
     GetRelationDescription( DmCodigoTarifaTable, [ Codigo ], Result, NotificaSiNoExiste, RsDescripcion );
end;

function  TCodigoTarifaModule.ExistenReferencias( Codigo : String ) : Boolean;
begin
     With DmTarifaVentasTable do
       Result := FindEqualFirst( [ 0, Codigo ] ) or FindEqualFirst( [ 1, Codigo ] );
end;

procedure TCodigoTarifaModule.SuprimeReferencias( Codigo : String );
begin
     EnterpriseDataModule.ExecQuery( Format( 'DELETE FROM TarifaVentas WHERE CodigoTarifa=%s', [ QuotedStr( Codigo ) ] ) );
end;

end.

