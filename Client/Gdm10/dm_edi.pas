unit dm_edi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  AppContainer,

  AppForms,

  Gim10Fields, DB, nxdb, DataManager;


type
  TInmovilizadoModule = class(TDataModule)
    DmInmovilizadoTable: TnxeTable;
    procedure InmovilizadoModuleDestroy(Sender: TObject);
    procedure InmovilizadoModuleCreate(Sender: TObject);
  private

    DmInmovilizadoFields : TInmovilizadoFields;

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False );
    function SubcuentaAmortizAcumulada( SubcuentaElemento : String ) : String;
    function SubcuentaDotacion( CuentaAmortizacion : String ) : String;

  end;

var
  InmovilizadoModule: TInmovilizadoModule = nil;


function  Inmovilizado : TInmovilizadoModule;

implementation

uses AppManager,
     EnterpriseDataAccess,

     dm_sub;

{$R *.DFM}

function Inmovilizado : TInmovilizadoModule;
begin
     CreateDataModule( TInmovilizadoModule, InmovilizadoModule );
     Result := InmovilizadoModule;
end;

procedure TInmovilizadoModule.InmovilizadoModuleDestroy(Sender: TObject);
begin
     InmovilizadoModule := nil;
end;

procedure TInmovilizadoModule.Valida(     EditControl   : TcxCustomEdit;
                                      var DisplayValue  : Variant;
                                      var ErrorText     : TCaption;
                                      var Error         : Boolean;
                                          IsInfoControl : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmInmovilizadoTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, '', IsInfoControl );
     If   not Error
     then EditControl.Description := Cuenta.Descripcion( DisplayValue, False, False );
end;

procedure TInmovilizadoModule.InmovilizadoModuleCreate(Sender: TObject);
begin
     DmInmovilizadoFields := TInmovilizadoFields.Create( DmInmovilizadoTable );
end;

function TInmovilizadoModule.SubcuentaAmortizAcumulada( SubcuentaElemento : String ) : String;
begin

     { 20x-xxxxx   -->  280xxxxx
       21x-xxxxx   -->  281xxxxx
       22x-xxxxx   -->  282xxxxx

       En la creación de la subcuenta de amortización acumulada se pierde el cuarto dígito
     }

     Result := '28' + Copy( SubcuentaElemento, 2, 2 ) + Copy( SubcuentaElemento, 5, 5 );
end;

function TInmovilizadoModule.SubcuentaDotacion( CuentaAmortizacion : String ) : String;
begin
     Result := '6' + Copy( CuentaAmortizacion, 2, 8 );
end;

end.
