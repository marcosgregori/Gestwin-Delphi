
unit dm_inc;

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

   TIncidenciaModule = class(TDataModule)
    DmIncidenciaTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
  public

    DmIncidenciaFields : TIncidenciaFields;

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean; IsInfoControl : Boolean = False );
    function  Descripcion( NroIncidencia : SmallInt; NotificaSiNoExiste : Boolean ) : string;
  end;

var
  IncidenciaModule: TIncidenciaModule = nil;


function Incidencia : TIncidenciaModule;

implementation

uses LibUtils,
     AppManager,

     DataAccess,
     EnterpriseDataAccess;

{$R *.DFM}

function Incidencia : TIncidenciaModule;
begin
     CreateDataModule( TIncidenciaModule, IncidenciaModule );
     Result := IncidenciaModule;
end;

procedure TIncidenciaModule.DataModuleCreate(Sender: TObject);
begin
     DmIncidenciaFields := TIncidenciaFields.Create( DmIncidenciaTable );
end;

procedure TIncidenciaModule.DataModuleDestroy(Sender: TObject);
begin
     IncidenciaModule := nil;
end;

procedure TIncidenciaModule.Valida(     EditControl   : TcxCustomEdit;
                                    var DisplayValue  : Variant;
                                    var ErrorText     : TCaption;
                                    var Error         : Boolean;
                                        IsInfoControl : Boolean = False );

var  NroIncidencia : SmallInt;

begin
     NroIncidencia := VarToInteger( DisplayValue );
     ValidateRelation( EditControl, DmIncidenciaTable, [ NroIncidencia ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl )
end;

function TIncidenciaModule.Descripcion( NroIncidencia : SmallInt; NotificaSiNoExiste : Boolean ) : string;
begin
     Result := '';
     If   DmIncidenciaTable.FindKey( [ NroIncidencia ] )
     then Result := DmIncidenciaFields.Descripcion.Value
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente;
end;

end.

