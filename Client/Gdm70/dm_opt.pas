unit dm_opt;

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
  TOperarioTipoModule = class(TDataModule)
    DmOperarioTipoTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private


  public

    DmOperarioTipoFields  : TOperarioTipoFields;

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False ); 
    function Obten( Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean ) : String;
  end;

var OperarioTipoModule: TOperarioTipoModule = nil;


function  OperarioTipo : TOperarioTipoModule;

implementation

uses AppManager,
     LibUtils,

     EnterpriseDataAccess;

{$R *.DFM}

resourceString
     RsMsg1  = 'El operario tipo de código [%s] ha sido dada de baja.';

function OperarioTipo : TOperarioTipoModule;
begin
     CreateDataModule( TOperarioTipoModule, OperarioTipoModule );
     Result := OperarioTipoModule;
end;

procedure TOperarioTipoModule.Valida(     EditControl   : TcxCustomEdit;
                                      var DisplayValue  : Variant;
                                      var ErrorText     : TCaption;
                                      var Error         : Boolean;
                                          IsInfoControl : Boolean = False );
begin
     ValidateRelation( EditControl, DmOperarioTipoTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

function  TOperarioTipoModule.Obten( Codigo             : String;
                                     NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmOperarioTipoTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), '' );
          Abort;
          end;
end;

procedure TOperarioTipoModule.DataModuleCreate(Sender: TObject);
begin
     DmOperarioTipoFields :=  TOperarioTipoFields.Create( DmOperarioTipoTable );
end;

procedure TOperarioTipoModule.DataModuleDestroy(Sender: TObject);
begin
     OperarioTipoModule := nil;
end;

function TOperarioTipoModule.Descripcion( Codigo             : String;
                                          NotificaSiNoExiste : Boolean ) : String;
begin
     Result := '';
     If   DmOperarioTipoTable.FindKey( [ Codigo ] )
     then Result := DmOperarioTipoFields.Descripcion.Value
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente;
end;

end.
