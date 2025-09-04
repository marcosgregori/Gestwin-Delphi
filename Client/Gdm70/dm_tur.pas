
unit dm_tur;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, cxEdit,
  AppContainer,

  AppForms,

  DB,
  nxdb,
  DataManager,

  Gim70Fields;

type

   TTurnoModule = class(TDataModule)
    DmTurnoTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
  public

    DmTurnoFields : TTurnoFields;

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean;IsInfoControl : Boolean = False );
    function  Descripcion( NroTurno : SmallInt; NotificaSiNoExiste : Boolean ) : string;
  end;

var
  TurnoModule: TTurnoModule = nil;


function Turno : TTurnoModule;

implementation

uses LibUtils,
     AppManager,

     DataAccess,
     EnterpriseDataAccess;

{$R *.DFM}

function Turno : TTurnoModule;
begin
     CreateDataModule( TTurnoModule, TurnoModule );
     Result := TurnoModule;
end;

procedure TTurnoModule.DataModuleCreate(Sender: TObject);
begin
     DmTurnoFields := TTurnoFields.Create( DmTurnoTable );
end;

procedure TTurnoModule.DataModuleDestroy(Sender: TObject);
begin
     TurnoModule := nil;
end;

procedure TTurnoModule.Valida(     EditControl   : TcxCustomEdit;
                               var DisplayValue  : Variant;
                               var ErrorText     : TCaption;
                               var Error         : Boolean;
                                   IsInfoControl : Boolean = False );

var  NroTurno : SmallInt;

begin
     NroTurno := VarToInteger( DisplayValue );
     ValidateRelation( EditControl, DmTurnoTable, [ NroTurno ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl )
end;

function TTurnoModule.Descripcion( NroTurno : SmallInt; NotificaSiNoExiste : Boolean ) : string;
begin
     Result := '';
     If   DmTurnoTable.FindKey( [ NroTurno ] )
     then Result := DmTurnoFields.Descripcion.Value
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente;
end;

end.

