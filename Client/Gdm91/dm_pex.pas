
unit dm_pex;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,

  AppForms,

  DB, nxdb, DataManager, cxEdit,

  Gim90Fields;


type
  TProveedorExternoModule = class(TDataModule)
    DmProveedorExternoTable: TnxeTable;
    procedure ProveedorExternoModuleDestroy(Sender: TObject);
    procedure ProveedorExternoModuleCreate(Sender: TObject);
  private

  public

    DmProveedorExternoFields : TProveedorExternoFields;

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False );
    function Obten( Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean ) : String;
  end;

var  ProveedorExternoModule: TProveedorExternoModule = nil;


function  ProveedorExterno : TProveedorExternoModule;

implementation

{$R *.DFM}

uses  AppManager,
      LibUtils;

resourceString
     RsMsg1  = 'El proveedor externo de código [%s] ha sido dado de baja.';

function ProveedorExterno : TProveedorExternoModule;
begin
     CreateDataModule( TProveedorExternoModule, ProveedorExternoModule );
     Result := ProveedorExternoModule;
end;

procedure TProveedorExternoModule.ProveedorExternoModuleDestroy(Sender: TObject);
begin
     ProveedorExternoModule := nil;
end;

procedure TProveedorExternoModule.Valida(     EditControl   : TcxCustomEdit;
                                          var DisplayValue  : Variant;
                                          var ErrorText     : TCaption;
                                          var Error         : Boolean;
                                              IsInfoControl : Boolean = False );
begin
     ValidateRelation( EditControl, DmProveedorExternoTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, 'Nombre', IsInfoControl );
end;

function  TProveedorExternoModule.Obten( Codigo             : String;
                                         NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmProveedorExternoTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), '' );
          Abort;
          end;
end;

function TProveedorExternoModule.Descripcion( Codigo             : String;
                                              NotificaSiNoExiste : Boolean ) : String;
begin
     Result := '';
     If   DmProveedorExternoTable.FindKey( [ Codigo ] )
     then Result := DmProveedorExternoFields.Nombre.Value
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente;
end;

procedure TProveedorExternoModule.ProveedorExternoModuleCreate(Sender: TObject);
begin
     DmProveedorExternoFields :=  TProveedorExternoFields.Create( DmProveedorExternoTable );
end;
end.
