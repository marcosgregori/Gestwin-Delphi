unit dm_mat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  AppContainer,

  AppForms,

  Datamanager,
  DB,
  nxdb,

  Gim70Fields;


type
  TMaquinaTipoModule = class(TDataModule)
    DmMaquinaTipoTable: TnxeTable;
    procedure MaquinaTipoModuleDestroy(Sender: TObject);
    procedure MaquinaTipoModuleCreate(Sender: TObject);

  private


  public

    DmMaquinaTipoFields  : TMaquinaTipoFields;

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False ); 
    function Obten( Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : String;
  end;

var MaquinaTipoModule: TMaquinaTipoModule = nil;


function  MaquinaTipo : TMaquinaTipoModule;

implementation

uses AppManager,
     EnterpriseDataAccess;

{$R *.DFM}

resourceString
     RsMsg1  = 'La máquina tipo de código [%s] ha sido dada de baja.';

function MaquinaTipo : TMaquinaTipoModule;
begin
     CreateDataModule( TMaquinaTipoModule, MaquinaTipoModule );
     Result := MaquinaTipoModule;
end;

procedure TMaquinaTipoModule.MaquinaTipoModuleDestroy(Sender: TObject);
begin
     MaquinaTipoModule := nil;
end;

procedure TMaquinaTipoModule.Valida(     EditControl   : TcxCustomEdit;
                                     var DisplayValue  : Variant;
                                     var ErrorText     : TCaption;
                                     var Error         : Boolean;
                                         IsInfoControl : Boolean = False );
begin
     ValidateRelation( EditControl, DmMaquinaTipoTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

function  TMaquinaTipoModule.Obten( Codigo             : String;
                                    NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmMaquinaTipoTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), '' );
          Abort;
          end;
end;

function TMaquinaTipoModule.Descripcion( Codigo             : String;
                                         NotificaSiNoExiste : Boolean = True ) : String;
begin
     Result := '';
     If   DmMaquinaTipoTable.FindKey( [ Codigo ] )
     then Result := DmMaquinaTipoFields.Descripcion.Value
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente;
end;

procedure TMaquinaTipoModule.MaquinaTipoModuleCreate(Sender: TObject);
begin
     DmMaquinaTipoFields :=  TMaquinaTipoFields.Create( DmMaquinaTipoTable );
end;

end.
