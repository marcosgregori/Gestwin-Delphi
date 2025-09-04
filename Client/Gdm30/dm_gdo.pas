
unit dm_gdo;

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
  TGrupoDocumentoModule = class(TDataModule)
    DmGrupoDocumentoTable: TnxeTable;
    procedure GrupoDocumentoModuleCreate(Sender: TObject);
    procedure GrupoDocumentoModuleDestroy(Sender: TObject);
  private

    FGrupoDocumentoFields : TGrupoDocumentoFields;

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False );
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : string;
    function  Obten( Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function ObtenCabeceraGrupos: String;

    property GrupoDocumentoFields : TGrupoDocumentoFields read FGrupoDocumentoFields;
  end;

var
  GrupoDocumentoModule: TGrupoDocumentoModule = nil;


function GrupoDocumento : TGrupoDocumentoModule;

implementation

uses  AppManager,
      LibUtils,
      EnterpriseDataAccess,

      Gdm00Dm,
      Gim00Fields,

      b_msg;

{$R *.DFM}

resourceString
     RsMsg1 = 'El grupo de documento de código [%s] ha sido dado de baja.';

function GrupoDocumento : TGrupoDocumentoModule;
begin
     CreateDataModule( TGrupoDocumentoModule, GrupoDocumentoModule );
     Result := GrupoDocumentoModule;
end;

procedure TGrupoDocumentoModule.GrupoDocumentoModuleCreate(Sender: TObject);
begin
     FGrupoDocumentoFields := TGrupoDocumentoFields.Create( DmGrupoDocumentoTable );
end;

procedure TGrupoDocumentoModule.GrupoDocumentoModuleDestroy(Sender: TObject);
begin
     GrupoDocumentoModule := nil;
end;

procedure TGrupoDocumentoModule.Valida(     EditControl   : TcxCustomEdit;
                                        var DisplayValue  : Variant;
                                        var ErrorText     : TCaption;
                                        var Error         : Boolean;
                                            IsInfoControl : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmGrupoDocumentoTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

function TGrupoDocumentoModule.Descripcion( Codigo             : String;
                                            NotificaSiNoExiste : Boolean = True ) : String;
begin
     GetRelationDescription( DmGrupoDocumentoTable, [ Codigo ], Result, NotificaSiNoExiste, RsDescripcion );
end;

function  TGrupoDocumentoModule.Obten( Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmGrupoDocumentoTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), '' );
          Abort;
          end;

end;

function TGrupoDocumentoModule.ObtenCabeceraGrupos : String;
begin
     With DataModule00.DmEmpresaFields do
       If   Ventas_NombrePaginas.Value<>''
       then Result := Capitaliza( Ventas_NombrePaginas.Value, True, False )
       else Result := 'Página';
end;

end.

