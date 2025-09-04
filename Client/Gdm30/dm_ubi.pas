
unit dm_ubi;

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
  TUbicacionModule = class(TDataModule)
    DmUbicacionTable: TnxeTable;
    procedure UbicacionModuleCreate(Sender: TObject);
    procedure UbicacionModuleDestroy(Sender: TObject);
  private

    DmUbicacionFields  : TUbicacionFields;

  public

    procedure Valida( CodigoAlmacen : String; PermitirUbicacionesCarga : Boolean; EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False );
    function  Descripcion( CodigoAlmacen : String; Codigo : String; NotificaSiNoExiste : Boolean = True; MuestraTextoGenerico : Boolean = False ) : String;
  end;

  TTipoUbicacion = ( ubNormal, ubCarga, ubTodas );

var UbicacionModule: TUbicacionModule = nil;


function Ubicacion : TUbicacionModule;

implementation

uses LibUtils,
     AppManager,
     EnterpriseDataAccess,

     Gdm00Dm,
     
     dm_alm;

{$R *.DFM}

resourceString
     RsMsg1     = 'El almacén %s tiene ubicaciones.';
     RsMsg2     = 'Debe especificar un código de ubicación válido para este almacén.';
     RsMsg3     = 'No puede utilizar ubicaciones de carga en éste contexto.';
     RsMsg4     = 'Las ubicaciones de carga están reservadas para movimientos de reubicación y salidas de material desde hojas de carga.';
     
     RsGenerica = '<Genérica>';

function Ubicacion : TUbicacionModule;
begin
     CreateDataModule( TUbicacionModule, ubicacionModule );
     Result := UbicacionModule;
end;

procedure TUbicacionModule.UbicacionModuleCreate(Sender: TObject);
begin
     DmUbicacionFields := TUbicacionFields.Create( DmUbicacionTable );
end;

procedure TUbicacionModule.UbicacionModuleDestroy(Sender: TObject);
begin
     UbicacionModule := nil;
end;

procedure TUbicacionModule.Valida(     CodigoAlmacen            : String;
                                       PermitirUbicacionesCarga : Boolean;
                                       EditControl              : TcxCustomEdit;
                                   var DisplayValue             : Variant;
                                   var ErrorText                : TCaption;
                                   var Error                    : Boolean;
                                       IsInfoControl            : Boolean = False );
begin
     If   ValueIsEmpty( DisplayValue )
     then begin
          If   Assigned( EditControl )
          then EditControl.Description := RsGenerica;
          end
     else begin
          ValidateRelationEx( EditControl, DmUbicacionTable, [ CodigoAlmacen, DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
          If   DmUbicacionFields.UbicacionDeCarga.Value and not PermitirUbicacionesCarga
          then begin
               Error := True;
               ErrorText := JoinMessage( RsMsg3, RsMsg4 );
               end;
          end;
end;

function TUbicacionModule.Descripcion( CodigoAlmacen        : String;
                                       Codigo               : String;
                                       NotificaSiNoExiste   : Boolean = True;
                                       MuestraTextoGenerico : Boolean = False ) : String;
begin
     If   not GetRelationDescription( DmUbicacionTable, [ CodigoAlmacen, Codigo ], Result, NotificaSiNoExiste )
     then If   MuestraTextoGenerico
          then Result := RsGenerica;
end;

end.

