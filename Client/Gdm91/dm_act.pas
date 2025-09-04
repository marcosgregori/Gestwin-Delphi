
unit dm_act;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,

  AppForms,

  DB, nxdb, DataManager, cxEdit,

  Gim90Fields;


type
  TActividadModule = class(TDataModule)
    DmActividadTable: TnxeTable;
    procedure ActividadModuleDestroy(Sender: TObject);
    procedure ActividadModuleCreate(Sender: TObject);
  private

  public

    DmActividadFields : TActividadFields;

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False );
    function Obten( Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean ) : String;
  end;

var  ActividadModule: TActividadModule = nil;


function  Actividad : TActividadModule;

implementation

{$R *.DFM}

uses  LibUtils,
      AppManager,

      b_msg;

resourceString
     RsMsg1  = 'La actividad de código [%s] ha sido dada de baja.';

function Actividad : TActividadModule;
begin
     CreateDataModule( TActividadModule, ActividadModule );
     Result := ActividadModule;
end;

procedure TActividadModule.ActividadModuleDestroy(Sender: TObject);
begin
     ActividadModule := nil;
end;

procedure TActividadModule.Valida(     EditControl   : TcxCustomEdit;
                                   var DisplayValue  : Variant;
                                   var ErrorText     : TCaption;
                                   var Error         : Boolean;
                                       IsInfoControl : Boolean = False );
begin
     ValidateRelation( EditControl, DmActividadTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

function  TActividadModule.Obten( Codigo             : String;
                                  NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmActividadTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), '' );
          Abort;
          end;
end;

function TActividadModule.Descripcion( Codigo             : String;
                                       NotificaSiNoExiste : Boolean ) : String;
begin
     Result := '';
     If   DmActividadTable.FindKey( [ Codigo ] )
     then Result := DmActividadFields.Descripcion.Value
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente;
end;

procedure TActividadModule.ActividadModuleCreate(Sender: TObject);
begin
     DmActividadFields :=  TActividadFields.Create( DmActividadTable );
end;
end.
