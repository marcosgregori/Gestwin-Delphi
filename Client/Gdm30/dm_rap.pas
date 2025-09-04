unit dm_rap;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,

  AppContainer,
  AppForms,

  DB,
  nxdb,
  DataManager,

  Gim30Fields;


type
  TAuxiliarProveedorModule = class(TDataModule)
    DmAuxiliarProveedorTable: TnxeTable;
    procedure AuxiliarProveedorModuleDestroy(Sender: TObject);
    procedure AuxiliarProveedorModuleCreate(Sender: TObject);
  private

    DmAuxiliarProveedorFields  : TAuxiliarProveedorFields;

  public

    procedure Valida( CodigoProveedor : String; EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False );
    function  Descripcion( CodigoProveedor : String; Codigo : String; NotificaSiNoExiste : Boolean ) : String;
    function  Obten( CodigoProveedor : String; Codigo : String; NotificaSiNoExiste : Boolean ) : Boolean;
  end;

var
  AuxiliarProveedorModule: TAuxiliarProveedorModule = nil;


function  AuxiliarProveedor : TAuxiliarProveedorModule;
function  NombreAuxiliarProveedor( Capital : Boolean = False; Plural : Boolean = False; Completo : Boolean = False  ) : String;

const
    CsCampo1 = 'Campo1';

implementation

uses LibUtils,
     AppManager,

     EnterpriseDataAccess,

     Gdm00Dm,
     Gim00Fields,
     
     b_msg;

{$R *.DFM}

resourceString
     RsMsg1 = 'El registro auxiliar de código [%s,%s] ha sido dado de baja.';
     RsMsg2 = 'registro auxiliar';
     RsMsg3 = 'registros auxiliares';
     RsMsg4 = ' de proveedores';

function AuxiliarProveedor : TAuxiliarProveedorModule;
begin
     CreateDataModule( TAuxiliarProveedorModule, AuxiliarProveedorModule );
     Result := AuxiliarProveedorModule;
end;

procedure TAuxiliarProveedorModule.AuxiliarProveedorModuleDestroy(Sender: TObject);
begin
     AuxiliarProveedorModule := nil;
end;

procedure TAuxiliarProveedorModule.AuxiliarProveedorModuleCreate(Sender: TObject);
begin
     DmAuxiliarProveedorFields := TAuxiliarProveedorFields.Create( DmAuxiliarProveedorTable );
end;

procedure TAuxiliarProveedorModule.Valida(     CodigoProveedor : String;
                                               EditControl     : TcxCustomEdit;
                                           var DisplayValue    : Variant;
                                           var ErrorText       : TCaption;
                                           var Error           : Boolean;
                                               IsInfoControl   : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmAuxiliarProveedorTable, [ CodigoProveedor, DisplayValue ], DisplayValue, ErrorText, Error, nil, CsCampo1, IsInfoControl );
     If   Error
     then begin
          Error := False;
          ValidateRelationEx( EditControl, DmAuxiliarProveedorTable, [ '', DisplayValue ], DisplayValue, ErrorText, Error, nil, CsCampo1, IsInfoControl );
          end;
end;

function TAuxiliarProveedorModule.Descripcion( CodigoProveedor    : String;
                                               Codigo             : String;
                                               NotificaSiNoExiste : Boolean ) : String;
begin
     If   not GetRelationDescription( DmAuxiliarProveedorTable, [ CodigoProveedor, Codigo ], Result )
     then GetRelationDescription( DmAuxiliarProveedorTable, [ '', Codigo ], Result, NotificaSiNoExiste );  // El genérico
end;


function TAuxiliarProveedorModule.Obten( CodigoProveedor : String; Codigo : String; NotificaSiNoExiste : Boolean ) : Boolean;
begin
     Result := DmAuxiliarProveedorTable.FindKey( [ CodigoProveedor, Codigo ] );
     If   not Result
     then Result := DmAuxiliarProveedorTable.FindKey( [ '', Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ CodigoProveedor, Codigo ] ), '' );
          Abort;
          end;
end;

// No forma parte del módulo para evitar que éste se cargue al utilizar la función (y porque no es necesariuo que esté, también)

function NombreAuxiliarProveedor( Capital  : Boolean = False;
                                          Plural   : Boolean = False;
                                          Completo : Boolean = False  ) : String;
begin
     If   DataModule00.DmEmpresaFields.Proveedor_NombreRegAuxiliar.Value=''
     then begin
          If   Plural
          then Result := RsMsg3
          else Result := RsMsg2;
          If   Completo
          then Result := Result + RsMsg4;
          Result := Capitaliza( Result, Capital );
          end
     else Result := Capitaliza( DataModule00.DmEmpresaFields.Proveedor_NombreRegAuxiliar.Value, Capital, Plural );
end;

end.
