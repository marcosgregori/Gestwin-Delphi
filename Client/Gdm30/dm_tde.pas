
unit dm_tde;

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

   TTipoEnvaseModule = class(TDataModule)
    DmTipoEnvaseTable: TnxeTable;
    procedure TipoEnvaseModuleCreate(Sender: TObject);
    procedure TipoEnvaseModuleDestroy(Sender: TObject);
  private

    DmTipoEnvaseFields : TTipoEnvaseFields;

  public
    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean;IsInfoControl : Boolean = False );
    function  Descripcion( Codigo : SmallInt; NotificaSiNoExiste : Boolean = True ) : string;
  end;

var
  TipoEnvaseModule: TTipoEnvaseModule = nil;


function TipoEnvase : TTipoEnvaseModule;

const  tmUltimoPredefinido = 19;

implementation

uses AppManager,
     LibUtils,

     DataAccess,
     EnterpriseDataAccess;

{$R *.DFM}

resourceString
     RsGenerico = '<Genérico>';

function TipoEnvase : TTipoEnvaseModule;
begin
     CreateDataModule( TTipoEnvaseModule, TipoEnvaseModule );
     Result := TipoEnvaseModule;
end;

procedure TTipoEnvaseModule.TipoEnvaseModuleCreate(Sender: TObject);
begin
     DmTipoEnvaseFields := TTipoEnvaseFields.Create( DmTipoEnvaseTable );
end;

procedure TTipoEnvaseModule.TipoEnvaseModuleDestroy(Sender: TObject);
begin
     TipoEnvaseModule := nil;
end;

procedure TTipoEnvaseModule.Valida(     EditControl   : TcxCustomEdit;
                                    var DisplayValue  : Variant;
                                    var ErrorText     : TCaption;
                                    var Error         : Boolean;
                                        IsInfoControl : Boolean = False );

var  TipoDeEnvase : SmallInt;

begin
     TipoDeEnvase := VarToInteger( DisplayValue );
     If   TipoDeEnvase=0
     then EditControl.Description := RsGenerico
     else ValidateRelationEx( EditControl, DmTipoEnvaseTable, [ TipoDeEnvase ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl )
end;

function TTipoEnvaseModule.Descripcion( Codigo             : SmallInt;
                                        NotificaSiNoExiste : Boolean = True ) : String;
begin
     GetRelationDescription( DmTipoEnvaseTable, [ Codigo ], Result, NotificaSiNoExiste, RsDescripcion );
end;

end.

