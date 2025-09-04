
unit dm_def;

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

   TDefectoModule = class(TDataModule)
    DmDefectoTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
  public

    DmDefectoFields : TDefectoFields;

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean;IsInfoControl : Boolean = False );
    function  Descripcion( NroDefecto : SmallInt; NotificaSiNoExiste : Boolean ) : string;
  end;

var
  DefectoModule: TDefectoModule = nil;


function Defecto : TDefectoModule;

implementation

uses LibUtils,
     AppManager,

     DataAccess,
     EnterpriseDataAccess;

{$R *.DFM}

function Defecto : TDefectoModule;
begin
     CreateDataModule( TDefectoModule, DefectoModule );
     Result := DefectoModule;
end;

procedure TDefectoModule.DataModuleCreate(Sender: TObject);
begin
     DmDefectoFields := TDefectoFields.Create( DmDefectoTable );
end;

procedure TDefectoModule.DataModuleDestroy(Sender: TObject);
begin
     DefectoModule := nil;
end;

procedure TDefectoModule.Valida(     EditControl   : TcxCustomEdit;
                                 var DisplayValue  : Variant;
                                 var ErrorText     : TCaption;
                                 var Error         : Boolean;
                                     IsInfoControl : Boolean = False );

var  NroDefecto : SmallInt;

begin
     NroDefecto := VarToInteger( DisplayValue );
     ValidateRelation( EditControl, DmDefectoTable, [ NroDefecto ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl )
end;

function TDefectoModule.Descripcion( NroDefecto : SmallInt; NotificaSiNoExiste : Boolean ) : string;
begin
     Result := '';
     If   DmDefectoTable.FindKey( [ NroDefecto ] )
     then Result := DmDefectoFields.Descripcion.Value
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente;
end;

end.

