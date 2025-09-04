
unit dm_cnt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,

  AppForms,

  DB, nxdb, DataManager, cxEdit,

  Gim90Fields;


type
  TContactoModule = class(TDataModule)
    DmContactoTable: TnxeTable;
    procedure ContactoModuleDestroy(Sender: TObject);
    procedure ContactoModuleCreate(Sender: TObject);
  private

  public

    DmContactoFields : TContactoFields;

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False );
    function Obten( Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean ) : String;
  end;

var  ContactoModule: TContactoModule = nil;


function  Contacto : TContactoModule;

implementation

{$R *.DFM}

uses  LibUtils,
      AppManager,

      b_msg;

resourceString
     RsMsg1  = 'El contacto de código [%s] ha sido dado de baja.';

function Contacto : TContactoModule;
begin
     CreateDataModule( TContactoModule, ContactoModule );
     Result := ContactoModule;
end;

procedure TContactoModule.ContactoModuleDestroy(Sender: TObject);
begin
     ContactoModule := nil;
end;

procedure TContactoModule.Valida(     EditControl   : TcxCustomEdit;
                                  var DisplayValue  : Variant;
                                  var ErrorText     : TCaption;
                                  var Error         : Boolean;
                                      IsInfoControl : Boolean = False );
begin
     ValidateRelation( EditControl, DmContactoTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, 'Nombre', IsInfoControl );
end;

function  TContactoModule.Obten( Codigo             : String;
                                 NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmContactoTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), '' );
          Abort;
          end;
end;

function TContactoModule.Descripcion( Codigo             : String;
                                      NotificaSiNoExiste : Boolean ) : String;
begin
     Result := '';
     If   DmContactoTable.FindKey( [ Codigo ] )
     then Result := DmContactoFields.Nombre.Value
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente;
end;

procedure TContactoModule.ContactoModuleCreate(Sender: TObject);
begin
     DmContactoFields :=  TContactoFields.Create( DmContactoTable );
end;
end.
