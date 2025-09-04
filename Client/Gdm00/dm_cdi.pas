unit dm_cdi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  AppContainer,

  AppForms,
  DB, nxdb,

  DataManager,

  Gim00Fields;


type
  TDivisaModule = class(TDataModule)
    DmDivisaTable: TnxeTable;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

    DmDivisaFields : TDivisaFields;

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; DivisaFields  : TDivisaFields = nil; IsInfoControl : Boolean = False ); overload;
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = False ) : String;
    function  Obten( Codigo : String; DivisaFields  : TDivisaFields = nil; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function Decimales( Codigo : String ) : SmallInt;
  end;

var  DivisaModule: TDivisaModule = nil;

function  Divisa : TDivisaModule;

resourceString
     RsPrecioDivisa = 'Precio divisa';
     RsPrecioDivisaCodigo = 'Precio (%s)';

implementation

uses LibUtils,

     b_msg,

     AppManager,
     DataAccess;

{$R *.dfm}

resourceString
     RsMsg1  = 'La divisa de código [%s] ha sido dada de baja.';

function Divisa : TDivisaModule;
begin
     CreateDataModule( TDivisaModule, DivisaModule );
     Result := DivisaModule;
end;

procedure TDivisaModule.DataModuleDestroy(Sender: TObject);
begin
     DivisaModule := nil;
end;

procedure TDivisaModule.Valida(     EditControl    : TcxCustomEdit;
                                var DisplayValue  : Variant;
                                var ErrorText     : TCaption;
                                var Error         : Boolean;
                                    DivisaFields  : TDivisaFields = nil;
                                    IsInfoControl : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmDivisaTable, [ DisplayValue ], DisplayValue, ErrorText, Error, DivisaFields, RsDescripcion, IsInfoControl );
end;

function TDivisaModule.Descripcion( Codigo             : String;
                                    NotificaSiNoExiste : Boolean = False ) : String;
begin
     GetRelationDescription( DmDivisaTable, [ Codigo ], Result, NotificaSiNoExiste, RsDescripcion )
end;

procedure TDivisaModule.DataModuleCreate(Sender: TObject);
begin
     DmDivisaFields := TDivisaFields.Create( DmDivisaTable );
end;

function TDivisaModule.Decimales( Codigo : String ) : SmallInt;
begin
     Result := DecimalesMoneda;
     If   DmDivisaTable.FindKey( [ Codigo ] )
     then Result := LibUtils.Decimales( DmDivisaFields.PrecisionRedondeo.Value );
end;

function TDivisaModule.Obten( Codigo             : String;
                              DivisaFields       : TDivisaFields = nil;
                              NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmDivisaTable.FindKey( [ Codigo ] );
     try
       If   NotificaSiNoExiste and not Result
       then begin
            ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), '' );
            Abort;
            end;
     finally
       If   Assigned( DivisaFields )
       then DivisaFields.Update( DmDivisaTable );
       end;
end;

end.
