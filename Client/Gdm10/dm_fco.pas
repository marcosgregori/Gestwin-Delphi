unit dm_fco;

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
  TFormaCobroModule = class(TDataModule)
    DmFormaCobroTable: TnxeTable;
    procedure formaCobroModuleDestroy(Sender: TObject);
  private

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean; IsInfoControl : Boolean = False );
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean  = True) : String;
    function  Obten( Codigo : String; FormaCobroFields : TFormaCobroFields = nil; NotificaSiNoExiste : Boolean = False ) : Boolean;

  end;

var
  FormaCobroModule: TFormaCobroModule = nil;


function  formaCobro : TFormaCobroModule;

implementation

uses Gim00Fields,
     AppManager,

     b_msg;

{$R *.DFM}

resourceString
     RsMsg1 = 'La forma de cobro de código [%s] ha sido dada de baja.';

function formaCobro : TFormaCobroModule;
begin
     CreateDataModule( TFormaCobroModule, formaCobroModule );
     Result := FormaCobroModule;
end;

procedure TFormaCobroModule.formaCobroModuleDestroy(Sender: TObject);
begin
     FormaCobroModule := nil;
end;

procedure TFormaCobroModule.Valida(     EditControl    : TcxCustomEdit;
                                    var DisplayValue   : Variant;
                                    var ErrorText      : TCaption;
                                    var Error          : Boolean;
                                        IsInfoControl  : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmFormaCobroTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

function TFormaCobroModule.Descripcion( Codigo             : String;
                                        NotificaSiNoExiste : Boolean = True ) : String;
begin
     GetRelationDescription( DmFormaCobroTable, [ Codigo ],  Result, NotificaSiNoExiste, RsDescripcion );
end;

function TFormaCobroModule.Obten( Codigo             : String;
                                  FormaCobroFields   : TFormaCobroFields = nil;
                                  NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmFormaCobroTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), '' );
          Abort;
          end;
     If   Assigned( FormaCobroFields )
     then FormaCobroFields.Update( DmFormaCobroTable );
end;

end.
