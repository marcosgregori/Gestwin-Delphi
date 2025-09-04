
unit dm_ope;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, cxEdit,
  AppContainer,
  DB,
  nxdb,
  AppForms,
  DataManager,
  Gim30Fields;

type
  TOperarioModule = class(TDataModule)
    DmOperarioTable: TnxeTable;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

    DmOperarioFields :TOperarioFields;

  public

    procedure Valida( CodigoCliente : String; EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False  );
    function  Descripcion( CodigoCliente : String; Codigo : String; NotificaSiNoExiste : Boolean = True ) : String;
    function  Obten( CodigoCliente : String; Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;
  end;

var  OperarioModule: TOperarioModule = nil;

function Operario : TOperarioModule;

function NombreOperarios( Capital : Boolean = False; Plural : Boolean = False ) : String;

implementation

uses LibUtils,
     AppManager,

     EnterpriseDataAccess,

     Gdm00Dm,
     Gim00Fields,

     b_msg;

{$R *.DFM}

resourceString
     RsMsg1 = 'El operario de código [%s] ha sido dada de baja.';

     RsMsg2 = 'operario';

function Operario : TOperarioModule;
begin
     CreateDataModule( TOperarioModule, OperarioModule );
     Result := OperarioModule;
end;

procedure TOperarioModule.Valida(     CodigoCliente : String;
                                      EditControl   : TcxCustomEdit;
                                  var DisplayValue  : Variant;
                                  var ErrorText     : TCaption;
                                  var Error         : Boolean;
                                      IsInfoControl : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmOperarioTable, [ CodigoCliente, DisplayValue ], DisplayValue, ErrorText, Error, nil, RsNombre, IsInfoControl );
     If   Error
     then begin
          Error := False;
          ValidateRelationEx( EditControl, DmOperarioTable, [ '', DisplayValue ], DisplayValue, ErrorText, Error, nil, RsNombre, IsInfoControl );
          end;
end;

function TOperarioModule.Descripcion( CodigoCliente      : String;
                                      Codigo             : String;
                                      NotificaSiNoExiste : Boolean = True ) : String;
begin
     If   not GetRelationDescription( DmOperarioTable, [ CodigoCliente, Codigo ], Result, NotificaSiNoExiste, RsNombre )
     then GetRelationDescription( DmOperarioTable, [ '', Codigo ], Result, NotificaSiNoExiste, RsNombre );  // El genérico
end;

function TOperarioModule.Obten( CodigoCliente : String; Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmOperarioTable.FindKey( [ CodigoCliente, Codigo ] );
     If   not Result
     then Result := DmOperarioTable.FindKey( [ '', Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ CodigoCliente, Codigo ] ), '' );
          Abort;
          end;
end;

procedure TOperarioModule.DataModuleCreate(Sender: TObject);
begin
     DmOperarioFields := TOperarioFields.Create( DmOperarioTable );
end;

procedure TOperarioModule.DataModuleDestroy(Sender: TObject);
begin
     OperarioModule := nil;
end;

function NombreOperarios( Capital  : Boolean = False;
                          Plural   : Boolean = False  ) : String;
begin
     If   DataModule00.DmEmpresaFields.Ventas_NombreOperarios.Value=''
     then begin
          Result := RsMsg2;
          If   Plural
          then Result := Result + 's';
          Result := Capitaliza( Result, Capital );
          end
     else Result := Capitaliza( DataModule00.DmEmpresaFields.Ventas_NombreOperarios.Value, Capital, Plural );
end;

end.

