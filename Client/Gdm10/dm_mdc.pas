
unit dm_mdc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  AppContainer,

  AppForms,

  DB, nxdb, DataManager,

  Gim10Fields;

type

  TTipoOperacionCaja = ( mcIngreso, mcPago );

  TMovimientoCajaModule = class(TDataModule)
    DmMovimientoCajaTable: TnxeTable;
    procedure MovimientoCajaModuleCreate(Sender: TObject);
    procedure MovimientoCajaModuleDestroy(Sender: TObject);
  private

    DmMovimientoCajaFields : TMovimientoCajaFields;

  public

    function  DescripcionTipoOperacion( TipoOperacion : TTipoOperacionCaja ) : string;
    function  ProximoNroOperacion( Serie : String ) : longInt;
  end;

var
  MovimientoCajaModule: TMovimientoCajaModule = nil;


function MovimientoCaja : TMovimientoCajaModule;

implementation

uses cxEdit,
     LibUtils,
     AppManager,
     NexusRpcData,

     Gdm00Dm,
     Gim00Fields,

     dmi_ast,

     dm_fco,
     dm_ast,
     dm_cli,
     dm_pro,
     dm_sub,
     dm_sal;

{$R *.DFM}

resourceString
     RsMsg1  = 'N/Factura nº %d';

function MovimientoCaja : TMovimientoCajaModule;
begin
     CreateDataModule( TMovimientoCajaModule, MovimientoCajaModule );
     Result := MovimientoCajaModule;
end;

procedure TMovimientoCajaModule.MovimientoCajaModuleCreate(Sender: TObject);
begin
     DmMovimientoCajaFields := TMovimientoCajaFields.Create( DmMovimientoCajaTable );
end;

procedure TMovimientoCajaModule.MovimientoCajaModuleDestroy(Sender: TObject);
begin
     MovimientoCajaModule := nil;
end;

function TMovimientoCajaModule.DescripcionTipoOperacion( TipoOperacion : TTipoOPeracionCaja ) : string;

const StrTipo : array[ 0..1 ] of String = ( 'Ingreso en caja',
                                            'Pago por caja' );
begin
     Result := StrTipo[ Ord( TipoOperacion ) ];
end;

function TMovimientoCajaModule.ProximoNroOperacion( Serie : String ) : longInt;
begin

     // Cuidado, esta operacion no preserva el contenido del registro

     With DmMovimientoCajaTable do
       begin
       IndexFieldNames := 'Ejercicio;Serie;NroOperacion';
       If   FindEqualFirst( [ ApplicationContainer.Ejercicio, Serie ] )
       then Result := DmMovimientoCajaFields.NroOperacion.Value + 1
       else Result := 1;
       end;
end;

end.

