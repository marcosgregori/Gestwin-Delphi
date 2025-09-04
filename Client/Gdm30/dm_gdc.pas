
unit dm_gdc;

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
  TGrupoClienteModule = class(TDataModule)
    DmGrupoClienteTable: TnxeTable;
    procedure GrupoClienteModuleCreate(Sender: TObject);
    procedure GrupoClienteModuleDestroy(Sender: TObject);
  private

    FGrupoClienteFields : TGrupoClienteFields;

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False );
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : string;
    function  Obten( Codigo : String; GrupoClienteFields : TGrupoClienteFields = nil; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function  ObtenCodigoPorCodigoTarifa(CodigoTarifa: String): String;

    property GrupoClienteFields : TGrupoClienteFields read FGrupoClienteFields;
  end;

var
  GrupoClienteModule: TGrupoClienteModule = nil;


function GrupoCliente : TGrupoClienteModule;

implementation

uses  LibUtils,
      AppManager,
      EnterpriseDataAccess,

      b_msg;

{$R *.DFM}

resourceString
     RsMsg1 = 'El grupo de cliente de código [%s] ha sido dado de baja.';

function GrupoCliente : TGrupoClienteModule;
begin
     CreateDataModule( TGrupoClienteModule, GrupoClienteModule );
     Result := GrupoClienteModule;
end;

procedure TGrupoClienteModule.GrupoClienteModuleCreate(Sender: TObject);
begin
     FGrupoClienteFields := TGrupoClienteFields.Create( DmGrupoClienteTable );
end;

procedure TGrupoClienteModule.GrupoClienteModuleDestroy(Sender: TObject);
begin
     GrupoClienteModule := nil;
end;

procedure TGrupoClienteModule.Valida(     EditControl   : TcxCustomEdit;
                                      var DisplayValue  : Variant;
                                      var ErrorText     : TCaption;
                                      var Error         : Boolean;
                                          IsInfoControl : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmGrupoClienteTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

function TGrupoClienteModule.Descripcion( Codigo             : String;
                                          NotificaSiNoExiste : Boolean = True ) : String;
begin
     GetRelationDescription( DmGrupoClienteTable, [ Codigo ], Result, NotificaSiNoExiste, RsDescripcion );
end;

function  TGrupoClienteModule.Obten( Codigo             : String;
                                     GrupoClienteFields : TGrupoClienteFields = nil;
                                     NotificaSiNoExiste : Boolean  = False ) : Boolean;
begin
     Result := DmGrupoClienteTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg1, [ Codigo ] ), '' );
          Abort;
          end;
     If   Assigned( GrupoClienteFields )
     then GrupoClienteFields.Update( DmGrupoClienteTable );
end;

function  TGrupoClienteModule.ObtenCodigoPorCodigoTarifa( CodigoTarifa : String ) : String;
begin
     Result := '';
     With DmGrupoClienteTable do
       try
         IndexFieldNames := 'CodigoTarifa';
         If   FindKey( [ CodigoTarifa ] )
         then Result := FGrupoClienteFields.Codigo.Value;
       finally
         IndexFieldNames := 'Codigo';
         end;

end;

end.

