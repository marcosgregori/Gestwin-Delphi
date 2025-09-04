unit dm_rdi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,

  AppForms, DB, nxdb, DataManager,

  Gim10Fields;


type
  TRelacionesDivisaModule = class(TDataModule)
    DmRelacionesDivisaTable: TnxeTable;
    procedure RelacionesDivisaModuleDestroy(Sender: TObject);
    procedure RelacionesDivisaModuleCreate(Sender: TObject);
  private

    DmRelacionesDivisaFields  : TRelacionesDivisaFields;

  public

    function  Obten( Codigo : String ) : boolean;
  end;

var
  RelacionesDivisaModule: TRelacionesDivisaModule = nil;


function  RelacionesDivisa : TRelacionesDivisaModule;

implementation

uses AppManager,
     EnterpriseDataAccess;

{$R *.DFM}

function RelacionesDivisa : TRelacionesDivisaModule;
begin
     CreateDataModule( TRelacionesDivisaModule, RelacionesDivisaModule );
     Result := RelacionesDivisaModule;
end;

procedure TRelacionesDivisaModule.RelacionesDivisaModuleDestroy(Sender: TObject);
begin
     RelacionesDivisaModule := nil;
end;

function  TRelacionesDivisaModule.Obten( Codigo : String ) : Boolean;
begin
     Result := DmRelacionesDivisaTable.FindKey( [ Codigo ] );
end;

procedure TRelacionesDivisaModule.RelacionesDivisaModuleCreate(Sender: TObject);
begin
     DmRelacionesDivisaFields := TRelacionesDivisaFields.Create( DmRelacionesDivisaTable );
end;

end.
