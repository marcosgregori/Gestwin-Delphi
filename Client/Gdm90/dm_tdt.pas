
unit dm_tdt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,

  AppForms,

  DB, nxdb, DataManager, cxEdit,

  Gim90Fields;


type
  TTipoTareaModule = class(TDataModule)
    DmTipoTareaTable: TnxeTable;
    procedure TipoTareaModuleDestroy(Sender: TObject);
    procedure TipoTareaModuleCreate(Sender: TObject);
  private

  public

    DmTipoTareaFields : TTipoTareaFields;

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False );
    function Obten( Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function Descripcion( Codigo : String; NotificaSiNoExiste : Boolean ) : String;
  end;

var  TipoTareaModule: TTipoTareaModule = nil;


function  TipoTarea : TTipoTareaModule;

implementation

{$R *.DFM}

uses  LibUtils,
      AppManager,

      b_msg;

resourceString
     RsMsg1  = 'El tipo de tarea de código [%s] ha sido dado de baja.';

function TipoTarea : TTipoTareaModule;
begin
     CreateDataModule( TTipoTareaModule, TipoTareaModule );
     Result := TipoTareaModule;
end;

procedure TTipoTareaModule.TipoTareaModuleDestroy(Sender: TObject);
begin
     TipoTareaModule := nil;
end;

procedure TTipoTareaModule.Valida(     EditControl   : TcxCustomEdit;
                                   var DisplayValue  : Variant;
                                   var ErrorText     : TCaption;
                                   var Error         : Boolean;
                                       IsInfoControl : Boolean = False );
begin
     ValidateRelation( EditControl, DmTipoTareaTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

function  TTipoTareaModule.Obten( Codigo             : String;
                                  NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmTipoTareaTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), '' );
          Abort;
          end;
end;

function TTipoTareaModule.Descripcion( Codigo             : String;
                                       NotificaSiNoExiste : Boolean ) : String;
begin
     Result := '';
     If   DmTipoTareaTable.FindKey( [ Codigo ] )
     then Result := DmTipoTareaFields.Descripcion.Value
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente;
end;

procedure TTipoTareaModule.TipoTareaModuleCreate(Sender: TObject);
begin
     DmTipoTareaFields := TTipoTareaFields.Create( DmTipoTareaTable );
end;

end.
