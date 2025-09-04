
unit dm_fam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, cxEdit,

  AppContainer,
  AppForms,
  DB, nxdb, DataManager,

  Gim30Fields;

type
  TFamiliaModule = class(TDataModule)
    DmFamiliaTable: TnxeTable;
    procedure FamiliaModuleCreate(Sender: TObject);
    procedure FamiliaModuleDestroy(Sender: TObject);
  private

   DmFamiliaFields  : TFamiliaFields;

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False  );
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean ) : String;
    function  Obten( Codigo : String; NotificaSiNoExiste : Boolean ) : Boolean;
  end;

var
  FamiliaModule: TFamiliaModule = nil;


function Familia : TFamiliaModule;

implementation

uses LibUtils,
     AppManager,

     EnterpriseDataAccess,

     Gim00Fields,

     b_msg;

{$R *.DFM}

resourceString
     rsMsg1 = 'La Familia de código [%s] no existe.';

function Familia : TFamiliaModule;
begin
     createDataModule( TFamiliaModule, FamiliaModule );
     Result := FamiliaModule;
end;

procedure TFamiliaModule.FamiliaModuleCreate(Sender: TObject);
begin
     DmFamiliaFields := TFamiliaFields.Create( DmFamiliaTable );
end;

procedure TFamiliaModule.FamiliaModuleDestroy(Sender: TObject);
begin
     FamiliaModule := nil;
end;

procedure TFamiliaModule.Valida(     EditControl   : TcxCustomEdit;
                                 var DisplayValue  : Variant;
                                 var ErrorText     : TCaption;
                                 var Error         : Boolean;
                                     IsInfoControl : Boolean = False  );
begin
     ValidateRelationEx( EditControl, DmFamiliaTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

function TFamiliaModule.Descripcion( Codigo             : String;
                                     NotificaSiNoExiste : Boolean ) : String;
begin
     GetRelationDescription( DmFamiliaTable, [ Codigo ], Result, NotificaSiNoExiste, RsDescripcion );
end;

function  TFamiliaModule.Obten( Codigo             : String;
                                NotificaSiNoExiste : Boolean ) : Boolean;
begin
     Result := DmFamiliaTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, format( rsMsg1, [ Codigo ] ), '' );
          Abort;
          end;
end;

end.

