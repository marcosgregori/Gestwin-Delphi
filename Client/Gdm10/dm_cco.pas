unit dm_cco;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  AppContainer,

  AppForms,

  Datamanager,
  DB,
  nxdb,
  Gim10Fields;


type
  TCentroCosteModule = class(TDataModule)
    DmCentroCosteTable: TnxeTable;
    procedure centroCosteModuleDestroy(Sender: TObject);

  private

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False ); 
    function Obten( Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : String;
  end;

var CentroCosteModule: TCentroCosteModule = nil;


function  CentroCoste : TCentroCosteModule;

implementation

uses LibUtils,
     AppManager,

     EnterpriseDataAccess,

     b_msg;

{$R *.DFM}

resourceString
     RsMsg1  = 'El centro de coste de código [%s] ha sido dado de baja.';

function CentroCoste : TcentroCosteModule;
begin
     CreateDataModule( TCentroCosteModule, CentroCosteModule );
     Result := CentroCosteModule;
end;

procedure TCentroCosteModule.centroCosteModuleDestroy(Sender: TObject);
begin
     CentroCosteModule := nil;
end;

procedure TCentroCosteModule.Valida(     EditControl   : TcxCustomEdit;
                                     var DisplayValue  : Variant;
                                     var ErrorText     : TCaption;
                                     var Error         : Boolean;
                                         IsInfoControl : Boolean = False );
begin
     If   ValueIsEmpty( DisplayValue )
     then begin
          If   Assigned( EditControl )
          then EditControl.Description := '<Genérico>';
          end
     else ValidateRelation( EditControl, DmCentroCosteTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

function  TCentroCosteModule.Obten( Codigo             : String;
                                    NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmCentroCosteTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), '' );
          Abort;
          end;
end;

function TCentroCosteModule.Descripcion( Codigo             : String;
                                         NotificaSiNoExiste : Boolean = True ) : String;
begin
     GetRelationDescription( DmCentroCosteTable, [ Codigo ],  Result, NotificaSiNoExiste );
end;

end.
