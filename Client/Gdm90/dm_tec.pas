
unit dm_tec;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,

  AppForms,

  DB, nxdb, DataManager, cxEdit,

  Gim90Fields;


type
  TTecnicoModule = class(TDataModule)
    DmTecnicoTable: TnxeTable;
    procedure TecnicoModuleDestroy(Sender: TObject);
    procedure TecnicoModuleCreate(Sender: TObject);
  private

  public

    DmTecnicoFields : TTecnicoFields;

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False );
    function Obten( Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean ) : String;
  end;

var  TecnicoModule: TTecnicoModule = nil;


function  Tecnico : TTecnicoModule;

implementation

{$R *.DFM}

uses  LibUtils,
      AppManager,

      b_msg;

resourceString
     RsMsg1  = 'El técnico de código [%s] ha sido dado de baja.';

function Tecnico : TTecnicoModule;
begin
     CreateDataModule( TTecnicoModule, TecnicoModule );
     Result := TecnicoModule;
end;

procedure TTecnicoModule.TecnicoModuleDestroy(Sender: TObject);
begin
     TecnicoModule := nil;
end;

procedure TTecnicoModule.Valida(     EditControl   : TcxCustomEdit;
                                 var DisplayValue  : Variant;
                                 var ErrorText     : TCaption;
                                 var Error         : Boolean;
                                     IsInfoControl : Boolean = False );
begin
     ValidateRelation( EditControl, DmTecnicoTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, 'Nombre', IsInfoControl );
end;

function  TTecnicoModule.Obten( Codigo             : String;
                                NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmTecnicoTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ) );
          Abort;
          end;
end;

function TTecnicoModule.Descripcion( Codigo             : String;
                                     NotificaSiNoExiste : Boolean ) : String;
begin
     Result := '';
     If   DmTecnicoTable.FindKey( [ Codigo ] )
     then Result := DmTecnicoFields.Nombre.Value
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente;
end;

procedure TTecnicoModule.TecnicoModuleCreate(Sender: TObject);
begin
     DmTecnicoFields :=  TTecnicoFields.Create( DmTecnicoTable );
end;
end.
