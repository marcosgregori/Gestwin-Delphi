unit dm_prv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, cxEdit,

  AppForms,
  DataAccess,
  DataManager,

  Gim00Fields,
  DB,
  nxdb;


type
  TProvinciaModule = class(TDataModule)
    DmProvinciaTable: TnxeTable;
    procedure provinciaModuleDestroy(Sender: TObject);
    procedure provinciaModuleCreate(Sender: TObject);
  private
    DmProvinciaFields : TProvinciaFields;
  public
    procedure Valida( CodigoPais : Variant; EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean; IsInfoControl : Boolean = False ); overload;
    function  Descripcion( CodigoPais, Codigo : Variant; NotificaSiNoExiste : Boolean = True ) : String;
  end;

var  ProvinciaModule: TProvinciaModule = nil;

function provincia : TProvinciaModule;

implementation

{$R *.dfm}

uses  AppManager,
      AppContainer;

function Provincia : TProvinciaModule;
begin
     CreateDataModule( TProvinciaModule, ProvinciaModule );
     Result := ProvinciaModule;
end;

procedure TProvinciaModule.ProvinciaModuleDestroy(Sender: TObject);
begin
     ProvinciaModule := nil;
end;

procedure TProvinciaModule.Valida(       CodigoPais     : Variant;  // De esta forma se pueden pasar Nulls sin producir una excepción
                                         EditControl    : TcxCustomEdit;
                                   var   DisplayValue   : Variant;
                                   var   ErrorText      : TCaption;
                                   var   Error          : Boolean;
                                         IsInfoControl  : Boolean = False );
begin
     // Si no son provincias españolas no son obligatorias
     If   not( ( CodigoPais<>CodigoEspaña ) and ValueIsEmpty( DisplayValue ) )
     then ValidateRelationEx( EditControl, DmProvinciaTable, [ CodigoPais, DisplayValue ], DisplayValue, ErrorText, Error, nil, 'Nombre', IsInfoControl );
end;

function TProvinciaModule.Descripcion( CodigoPais,
                                       Codigo             : Variant;
                                       NotificaSiNoExiste : Boolean = True ) : String;
begin
     GetRelationDescription( DmProvinciaTable, [ CodigoPais, Codigo ],  Result, NotificaSiNoExiste );
end;

procedure TProvinciaModule.ProvinciaModuleCreate(Sender: TObject);
begin
     DmProvinciaFields := TProvinciaFields.Create( DmProvinciaTable );
end;

end.
