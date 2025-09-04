
unit dm_tvp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, cxEdit,
  AppContainer,

  AppForms,

  DB,
  nxdb,
  DataManager,

  Gim30Fields;

type

   TTipoVentaPeriodicaModule = class(TDataModule)
    DmTipoVentaPeriodicaTable: TnxeTable;
    DmTipoVentaPeriodicaTableTipo: TSmallintField;
    DmTipoVentaPeriodicaTableDescripcion: TWideStringField;
    procedure DataModuleDestroy(Sender: TObject);
  private
  public
    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean;IsInfoControl : Boolean = False );
    function  Descripcion( Tipo : SmallInt; NotificaSiNoExiste : Boolean ) : String;
  end;

var
  TipoVentaPeriodicaModule: TTipoVentaPeriodicaModule = nil;


function TipoVentaPeriodica : TTipoVentaPeriodicaModule;

resourceString
    RsNoDefinido = '<No definido>';
    
implementation

uses LibUtils,
     AppManager,

     DataAccess,
     EnterpriseDataAccess,

     Gim00Fields;
     
{$R *.DFM}

function TipoVentaPeriodica : TTipoVentaPeriodicaModule;
begin
     CreateDataModule( TTipoVentaPeriodicaModule, TipoVentaPeriodicaModule );
     Result := TipoVentaPeriodicaModule;
end;

procedure TTipoVentaPeriodicaModule.DataModuleDestroy(Sender: TObject);
begin
     TipoVentaPeriodicaModule := nil;
end;

procedure TTipoVentaPeriodicaModule.Valida(     EditControl   : TcxCustomEdit;
                                            var DisplayValue  : Variant;
                                            var ErrorText     : TCaption;
                                            var Error         : Boolean;
                                                IsInfoControl : Boolean = False );
var  Tipo : SmallInt;                                                

begin
     Tipo := VarToInteger( DisplayValue );
     If   Tipo=0
     then EditControl.Description := RsNodefinido
     else ValidateRelationEx( EditControl, DmTipoVentaPeriodicaTable, [ Tipo ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl )
end;

function TTipoVentaPeriodicaModule.Descripcion( Tipo : SmallInt; NotificaSiNoExiste : Boolean ) : string;
begin
     If   Tipo=0
     then Result := RsNoDefinido
     else GetRelationDescription( DmTipoVentaPeriodicaTable, [ Tipo ], Result, NotificaSiNoExiste );
end;

end.

