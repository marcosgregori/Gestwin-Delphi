unit dm_rac;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,

  LibUtils,
  AppContainer,
  AppForms,

  DB,
  nxdb,
  DataManager,

  Gim30Fields;


type
  TAuxiliarClienteModule = class(TDataModule)
    DmAuxiliarClienteTable: TnxeTable;
    procedure AuxiliarClienteModuleDestroy(Sender: TObject);
    procedure AuxiliarClienteModuleCreate(Sender: TObject);
  private

    FAuxiliarClienteFields : TAuxiliarClienteFields;

  public

    procedure Valida( CodigoCliente : String; EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False );
    function  Descripcion( CodigoCliente : String; Codigo : String; NotificaSiNoExiste : Boolean = True ) : String;
    function  Obten( CodigoCliente : String; Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;

    property AuxiliarClienteFields : TAuxiliarClienteFields read FAuxiliarClienteFields;
  end;

var
  AuxiliarClienteModule: TAuxiliarClienteModule = nil;

function  AuxiliarCliente : TAuxiliarClienteModule;
function NombreAuxiliarCliente( Capital : Boolean = False; Plural : Boolean = False; Completo : Boolean = False  ) : String;

resourceString
   RsCampo1 = 'Campo1';

implementation

uses AppManager,
     EnterpriseDataAccess,

     Gdm00Dm,
     Gim00Fields,
     
     b_msg;

{$R *.DFM}

resourceString
     RsMsg1 = 'El registro auxiliar de código [%s,%s] ha sido dado de baja.';
     RsMsg2 = 'registro auxiliar';
     RsMsg3 = 'registros auxiliares';
     RsMsg4 = ' de clientes';

const
     CsCampo1 = 'Campo1';

function AuxiliarCliente : TAuxiliarClienteModule;
begin
     CreateDataModule( TAuxiliarClienteModule, AuxiliarClienteModule );
     Result := AuxiliarClienteModule;
end;

procedure TAuxiliarClienteModule.AuxiliarClienteModuleDestroy(Sender: TObject);
begin
     AuxiliarClienteModule := nil;
end;

procedure TAuxiliarClienteModule.AuxiliarClienteModuleCreate(Sender: TObject);
begin
     FAuxiliarClienteFields := TAuxiliarClienteFields.Create( DmAuxiliarClienteTable );
end;

procedure TAuxiliarClienteModule.Valida(     CodigoCliente : String;
                                             EditControl   : TcxCustomEdit;
                                         var DisplayValue  : Variant;
                                         var ErrorText     : TCaption;
                                         var Error         : Boolean;
                                             IsInfoControl : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmAuxiliarClienteTable, [ CodigoCliente, DisplayValue ], DisplayValue, ErrorText, Error, nil, CsCampo1, IsInfoControl );
     If   Error
     then begin
          Error := False;
          ValidateRelationEx( EditControl, DmAuxiliarClienteTable, [ '', DisplayValue ], DisplayValue, ErrorText, Error, nil, CsCampo1, IsInfoControl );
          end;
end;

function TAuxiliarClienteModule.Descripcion( CodigoCliente      : String;
                                             Codigo             : String;
                                             NotificaSiNoExiste : Boolean = True ) : String;
begin
     If   not GetRelationDescription( DmAuxiliarClienteTable, [ CodigoCliente, Codigo ], Result, NotificaSiNoExiste, RsCampo1 )
     then GetRelationDescription( DmAuxiliarClienteTable, [ '', Codigo ], Result, NotificaSiNoExiste, RsCampo1 );  // El genérico
end;

function TAuxiliarClienteModule.Obten( CodigoCliente : String; Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmAuxiliarClienteTable.FindKey( [ CodigoCliente, Codigo ] );
     If   not Result
     then Result := DmAuxiliarClienteTable.FindKey( [ '', Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ CodigoCliente, Codigo ] ), '' );
          Abort;
          end;
end;

// No forma parte del módulo para evitar que éste se cargue al utilizar la función (y porque no es necesario que esté, también)

function NombreAuxiliarCliente( Capital  : Boolean = False;
                                Plural   : Boolean = False;
                                Completo : Boolean = False  ) : String;
begin
     If   DataModule00.DmEmpresaFields.Cliente_NombreRegAuxiliar.Value=''
     then begin
          If   Plural
          then Result := RsMsg3
          else Result := RsMsg2;
          If   Completo
          then Result := Result + RsMsg4;
          Result := Capitaliza( Result, Capital );
          end
     else Result := Capitaliza( DataModule00.DmEmpresaFields.Cliente_NombreRegAuxiliar.Value, Capital, Plural );
end;

end.
