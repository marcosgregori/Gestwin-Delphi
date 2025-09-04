
unit dm_tlm;

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
  TTipoLineaMovimientoModule = class(TDataModule)
    DmTipoLineaMovimientoTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

    DmTipoLineaMovimientoFields  : TTipoLineaMovimientoFields;

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean;IsInfoControl : Boolean = False; CheckRestriction : Boolean = True );
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean ) : string;
    function  Obten( Codigo : String; NotificaSiNoExiste : Boolean ) : Boolean;
  end;

var TipoLineaMovimientoModule: TTipoLineaMovimientoModule = nil;


function TipoLineaMovimiento : TTipoLineaMovimientoModule;

implementation

uses LibUtils,
     AppManager,

     EnterpriseDataAccess,

     Gim00Fields,

     b_msg;

{$R *.DFM}

resourceString
    RsMsg2  = 'El tipo de línea de movimiento de almacén de código [%s] no existe.';

function TipoLineaMovimiento : TTipoLineaMovimientoModule;
begin
     CreateDataModule( TTipoLineaMovimientoModule, TipoLineaMovimientoModule );
     Result := TipoLineaMovimientoModule;
end;

procedure TTipoLineaMovimientoModule.Valida(     EditControl      : TcxCustomEdit;
                                             var DisplayValue     : Variant;
                                             var ErrorText        : TCaption;
                                             var Error            : Boolean;
                                                 IsInfoControl    : Boolean = False;
                                                 CheckRestriction : Boolean = True );
begin
     ValidateRelationEx( EditControl, DmTipoLineaMovimientoTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

procedure TTipoLineaMovimientoModule.DataModuleCreate(Sender: TObject);
begin
     DmTipoLineaMovimientoFields := TTipoLineaMovimientoFields.Create( DmTipoLineaMovimientoTable );
end;

procedure TTipoLineaMovimientoModule.DataModuleDestroy(Sender: TObject);
begin
     TipoLineaMovimientoModule := nil;
end;

function TTipoLineaMovimientoModule.Descripcion( Codigo             : String;
                                                 NotificaSiNoExiste : Boolean ) : string;
begin
     GetRelationDescription( DmTipoLineaMovimientoTable, [ Codigo ], Result, NotificaSiNoExiste, RsDescripcion );
end;

function  TTipoLineaMovimientoModule.Obten( Codigo             : String;
                                            NotificaSiNoExiste : Boolean ) : Boolean;
begin
     Result := DmTipoLineaMovimientoTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg2, [ Codigo ] ), '' );
          Abort;
          end;
end;

end.

