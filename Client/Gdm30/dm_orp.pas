unit dm_orp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  AppContainer,

  AppForms,
  DB,
  nxdb,
  DataManager,

  Gim30Fields;

type

  TOrganismoPublicoModule = class(TDataModule)
    DmOrganismoPublicoTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

    DmOrganismoPublicoFields : TOrganismoPublicoFields;

  public

    procedure Valida( Tipo : SmallInt; EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean; IsInfoControl : Boolean = False; CheckRestriction : Boolean = True );
    function  Descripcion( Tipo : SmallInt; Codigo : String; NotificaSiNoExiste : Boolean = True ) : String;
    function  Obten( Tipo : SmallInt; Codigo : String; NotificaSiNoExiste : Boolean = False ) : Boolean;
    end;

var  OrganismoPublicoModule: TOrganismoPublicoModule = nil;

const topOficinaContable = 0;
      topOrganoGestor = 1;
      topUnidadTramitadora = 2;
      topOrganoProponente = 3;

function OrganismoPublico : TOrganismoPublicoModule;

implementation

uses LibUtils,

     EnterpriseDataAccess,
     AppManager,

     Gdm00Dm,

     b_msg,

     dm_art,
     dm_sec;

{$R *.DFM}

resourceString
     RsMsg1 = 'El organismo público de código [%s] no existe.';

function OrganismoPublico : TOrganismoPublicoModule;
begin
     CreateDataModule( TOrganismoPublicoModule, OrganismoPublicoModule );
     Result := OrganismoPublicoModule;
end;

procedure TOrganismoPublicoModule.DataModuleCreate(Sender: TObject);
begin
     DmOrganismoPublicoFields := TOrganismoPublicoFields.Create( DmOrganismoPublicoTable );
end;

procedure TOrganismoPublicoModule.DataModuleDestroy(Sender: TObject);
begin
     OrganismoPublicoModule := nil;
end;

procedure TOrganismoPublicoModule.Valida(     Tipo             : SmallInt;
                                              EditControl      : TcxCustomEdit;
                                          var DisplayValue     : Variant;
                                          var ErrorText        : TCaption;
                                          var Error            : Boolean;
                                              IsInfoControl    : Boolean = False;
                                              CheckRestriction : Boolean = True  );
begin
     ValidateRelationEx( EditControl, DmOrganismoPublicoTable, [ Tipo, DisplayValue ], DisplayValue, ErrorText, Error, nil, RsNombre, IsInfoControl );
end;

function TOrganismoPublicoModule.Descripcion( Tipo               : SmallInt;
                                              Codigo             : String;
                                              NotificaSiNoExiste : Boolean = True ) : string;
begin
     GetRelationDescription( DmOrganismoPublicoTable, [ Tipo, Codigo ], Result, NotificaSiNoExiste );
end;

function  TOrganismoPublicoModule.Obten( Tipo               : SmallInt;
                                         Codigo             : String;
                                         NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmOrganismoPublicoTable.FindKey( [ Tipo, Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ) );
          Abort;
          end;
end;

end.

