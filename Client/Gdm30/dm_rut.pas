
unit dm_rut;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, cxEdit,
  AppContainer,

  AppForms,

  DB, nxdb, DataManager,

  Gim30Fields;

type
  TRutaModule = class(TDataModule)
    DmRutaTable: TnxeTable;
    DmLineaRutaTable: TnxeTable;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

    DmRutaFields : TRutaFields;
    DmLineaRutaFields : TLineaRutaFields;

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean;IsInfoControl : Boolean = False );
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean ) : string;
    function  ExistenReferencias( Codigo : String ) : Boolean;
  end;

var
  RutaModule: TRutaModule = nil;


function Ruta : TRutaModule;

implementation

uses EnterpriseDataAccess, AppForm;

{$R *.DFM}

function ruta : TRutaModule;
begin
     If   not Assigned( RutaModule )
     then RutaModule := TRutaModule.create( ApplicationForm );
     Result := RutaModule;
end;

procedure TRutaModule.Valida(     EditControl   : TcxCustomEdit;
                              var DisplayValue  : Variant;
                              var ErrorText     : TCaption;
                              var Error         : Boolean;
                                  IsInfoControl : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmRutaTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

function TRutaModule.Descripcion( Codigo             : String;
                                  NotificaSiNoExiste : Boolean ) : string;
begin
     GetRelationDescription( DmRutaTable, [ Codigo ], Result, NotificaSiNoExiste, RsDescripcion );
end;

function  TRutaModule.ExistenReferencias( Codigo : String ) : Boolean;
begin
     With DmLineaRutaTable do
       Result := FindEqualFirst( [ Codigo ] );
end;

procedure TRutaModule.DataModuleCreate(Sender: TObject);
begin
     DmRutaFields := TRutaFields.Create( DmRutaTable );
     DmLineaRutaFields := TLineaRutaFields.Create( DmLineaRutaTable );
end;

procedure TRutaModule.DataModuleDestroy(Sender: TObject);
begin
     RutaModule := nil;
end;

end.


