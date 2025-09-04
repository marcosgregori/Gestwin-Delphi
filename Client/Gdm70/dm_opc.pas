unit dm_opc;

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
  TOperacionModule = class(TDataModule)
    DmOperacionTable: TnxeTable;
    procedure OperacionModuleDestroy(Sender: TObject);
    procedure OperacionModuleCreate(Sender: TObject);

  private


  public

    DmOperacionFields  : TOperacionFields;

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False ); 
    function Obten( Codigo : String; OperacionFields : TOperacionFields = nil; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : String;
  end;

var OperacionModule: TOperacionModule = nil;


function  Operacion : TOperacionModule;

type TTipoOperacion = ( topInterna, topExterna, topAmbas );

implementation

uses AppManager,
     EnterpriseDataAccess,

     LibUtils;

{$R *.DFM}

resourceString
     RsMsg1  = 'La operación de código [%s] ha sido dada de baja.';

function Operacion : TOperacionModule;
begin
     CreateDataModule( TOperacionModule, OperacionModule );
     Result := OperacionModule;
end;

procedure TOperacionModule.OperacionModuleDestroy(Sender: TObject);
begin
     OperacionModule := nil;
end;

procedure TOperacionModule.Valida(     EditControl   : TcxCustomEdit;
                                   var DisplayValue  : Variant;
                                   var ErrorText     : TCaption;
                                   var Error         : Boolean;
                                       IsInfoControl : Boolean = False );
begin
     ValidateRelation( EditControl, DmOperacionTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

function  TOperacionModule.Obten( Codigo             : String;
                                  OperacionFields    : TOperacionFields = nil;
                                  NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmOperacionTable.FindKey( [ Codigo ] );

     If   Assigned( OperacionFields )
     then OperacionFields.Update( DmOperacionTable );

     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), '' );
          Abort;
          end;

end;

function TOperacionModule.Descripcion( Codigo             : String;
                                       NotificaSiNoExiste : Boolean = True ) : String;
begin
     Result := '';
     If   DmOperacionTable.FindKey( [ Codigo ] )
     then Result := DmOperacionFields.Descripcion.Value
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente;
end;

procedure TOperacionModule.OperacionModuleCreate(Sender: TObject);
begin
     DmOperacionFields :=  TOperacionFields.Create( DmOperacionTable );
end;

end.
