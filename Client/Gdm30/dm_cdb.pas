
unit dm_cdb;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, cxEdit,

  AppContainer,
  AppForms, 

  DB, nxdb, DataManager,

  Gim30Fields;

type
  TCodigoBarrasModule = class(TDataModule)
    DmCodigoBarrasTable: TnxeTable;
    procedure CodigoBarrasModuleCreate(Sender: TObject);
    procedure CodigoBarrasModuleDestroy(Sender: TObject);
  private

    DmCodigoBarrasFields  : TCodigoBarrasFields;

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False  );
  end;

var
  CodigoBarrasModule: TCodigoBarrasModule = nil;


function CodigoBarras : TCodigoBarrasModule;

implementation

uses EnterpriseDataAccess,
     AppManager,

     Gim00Fields,

     dm_art,
     
     b_msg;

{$R *.DFM}

resourceString
     RsMsg1 = 'La codigo de barras [%s] no existe.';

function CodigoBarras : TCodigoBarrasModule;
begin
     CreateDataModule( TCodigoBarrasModule, CodigoBarrasModule );
     Result := CodigoBarrasModule;
end;

procedure TCodigoBarrasModule.CodigoBarrasModuleCreate(Sender: TObject);
begin
     DmCodigoBarrasFields := TCodigoBarrasFields.Create( DmCodigoBarrasTable );
end;

procedure TCodigoBarrasModule.CodigoBarrasModuleDestroy(Sender: TObject);
begin
     CodigoBarrasModule := nil;
end;

procedure TCodigoBarrasModule.Valida(     EditControl   : TcxCustomEdit;
                                      var DisplayValue  : Variant;
                                      var ErrorText     : TCaption;
                                      var Error         : Boolean;
                                          IsInfoControl : Boolean = False  );
begin
     ValidateRelationEx( EditControl, DmCodigoBarrasTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, '', IsInfoControl );
     If   not Error and Assigned( EditControl )
     then EditControl.Description := Articulo.Descripcion( DmCodigoBarrasFields.CodigoArticulo.Value, True );
end;

end.

