unit dm_can;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,

  AppContainer,
  AppForms,

  DB,
  nxdb,
  DataManager,

  Gim10Fields;


type
  TCuentaAnaliticaModule = class(TDataModule)
    DmCuentaAnaliticaTable: TnxeTable;
    procedure CuentaAnaliticaModuleDestroy(Sender: TObject);
    procedure CuentaAnaliticaModuleCreate(Sender: TObject);
  private

    DmCuentaAnaliticaFields  : TCuentaAnaliticaFields;

  public

    procedure Valida( CentroCoste : String; EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False );
    function  Descripcion( CentroCoste : String; Codigo : String; NotificaSiNoExiste : Boolean ) : String;
    function  Obten( CentroCoste : String; Codigo : String; NotificaSiNoExiste : Boolean ) : Boolean;
  end;

var
  CuentaAnaliticaModule: TCuentaAnaliticaModule = nil;


function  CuentaAnalitica : TCuentaAnaliticaModule;

implementation

uses AppManager,
     EnterpriseDataAccess,

     Gim00Fields,
     
     b_msg;

{$R *.DFM}

resourceString
     RsMsg1 = 'La cuenta analítica de código [%s,%s] ha sido dado de baja.';

function CuentaAnalitica : TCuentaAnaliticaModule;
begin
     CreateDataModule( TCuentaAnaliticaModule, CuentaAnaliticaModule );
     Result := CuentaAnaliticaModule;
end;

procedure TCuentaAnaliticaModule.CuentaAnaliticaModuleDestroy(Sender: TObject);
begin
     CuentaAnaliticaModule := nil;
end;

procedure TCuentaAnaliticaModule.CuentaAnaliticaModuleCreate(Sender: TObject);
begin
     DmCuentaAnaliticaFields := TCuentaAnaliticaFields.Create( DmCuentaAnaliticaTable );
end;

procedure TCuentaAnaliticaModule.Valida(     CentroCoste   : String;
                                             EditControl   : TcxCustomEdit;
                                         var DisplayValue  : Variant;
                                         var ErrorText     : TCaption;
                                         var Error         : Boolean;
                                             IsInfoControl : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmCuentaAnaliticaTable, [ CentroCoste, DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

function TCuentaAnaliticaModule.Descripcion( CentroCoste        : String;
                                             Codigo             : String;
                                             NotificaSiNoExiste : Boolean ) : String;
begin
     GetRelationDescription( DmCuentaAnaliticaTable, [ CentroCoste, Codigo ], Result, NotificaSiNoExiste, RsDescripcion );
end;

function TCuentaAnaliticaModule.Obten( CentroCoste        : String;
                                       Codigo             : String;
                                       NotificaSiNoExiste : Boolean ) : Boolean;
begin
     Result := DmCuentaAnaliticaTable.FindKey( [ CentroCoste, Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ CentroCoste, Codigo ] ), '' );
          Abort;
          end;
end;

end.
