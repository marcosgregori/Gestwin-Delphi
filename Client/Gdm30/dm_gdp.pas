
unit dm_gdp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, cxEdit,

  AppContainer,
  AppForms,
  DB,
  nxdb,
  DataManager,

  Gim30Fields;

type
  TGrupoProveedorModule = class(TDataModule)
    DmGrupoProveedorTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

    DmGrupoProveedorFields  : TGrupoProveedorFields;

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False );
    function  Descripcion( Codigo : String; NotificaSiNoExiste : boolean ) : string;
    function  Obten( Codigo : String; NotificaSiNoExiste : boolean ) : boolean;
  end;

var
  GrupoProveedorModule: TGrupoProveedorModule = nil;


function GrupoProveedor : TGrupoProveedorModule;

implementation

uses  AppManager,
      LibUtils,

      EnterpriseDataAccess,

      b_msg;

{$R *.DFM}

resourceString
     rsMsg1 = 'El grupo de proveedor de código [%s] ha sido dado de baja.';

function GrupoProveedor : TGrupoProveedorModule;
begin
     CreateDataModule( TGrupoProveedorModule, GrupoProveedorModule );
     Result := GrupoProveedorModule;
end;

procedure TGrupoProveedorModule.Valida(     EditControl   : TcxCustomEdit;
                                        var DisplayValue  : Variant;
                                        var ErrorText     : TCaption;
                                        var Error         : Boolean;
                                            IsInfoControl : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmGrupoProveedorTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

procedure TGrupoProveedorModule.DataModuleCreate(Sender: TObject);
begin
     DmGrupoProveedorFields := TGrupoProveedorFields.Create( DmGrupoProveedorTable );
end;

procedure TGrupoProveedorModule.DataModuleDestroy(Sender: TObject);
begin
     GrupoProveedorModule := nil;
end;

function TGrupoProveedorModule.Descripcion( Codigo             : String;
                                            NotificaSiNoExiste : Boolean ) : String;
begin
     GetRelationDescription( DmGrupoProveedorTable, [ Codigo ], Result, NotificaSiNoExiste, RsDescripcion );
end;

function  TGrupoProveedorModule.obten( Codigo : String; NotificaSiNoExiste : boolean ) : boolean;
begin
     Result := DmGrupoProveedorTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( rsMsg1, [ Codigo ] ), '' );
          Abort;
          end;

end;

end.

