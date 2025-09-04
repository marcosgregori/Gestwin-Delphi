unit dm_usr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,

  AppForms,

  DB,
  nxdb,
  DataManager,

  Gim00Fields;


type
  TAccessLevel = ( alDenied     = 0,
                   alAllowed    = 1,
                   alReadOnly   = 2,
                   alCantModify = 3 );

  TUsuarioModule = class(TDataModule)
    DmUsuarioTable: TnxeTable;
    procedure DmUsuarioTableAfterOpen(DataSet: TDataSet);
    procedure UsuarioModuleDestroy(Sender: TObject);
  private

    DmUsuarioFields  : TUsuarioFields;

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean; UsuarioFields : TUsuarioFields = nil; IsInfoControl : Boolean = False ); overload;
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean ) : string;
    function  Obten( Codigo : String; UsuarioFields : TUsuarioFields = nil ) : Boolean;
    function OpcionUsuario( OpcionUsuarioField, OpcionGlobalField : TBooleanField ) : Boolean;
    procedure CompruebaPalabraPaso( CodigoUsuario, PalabraPaso : String );
  end;

var  UsuarioModule: TUsuarioModule = nil;

function  Usuario : TUsuarioModule;

implementation

uses AppManager,
     AppContainer,
     DataAccess,

     b_cda;

{$R *.DFM}

function Usuario : TUsuarioModule;
begin
     CreateDataModule( TUsuarioModule, UsuarioModule );
     Result := UsuarioModule;
end;

procedure TUsuarioModule.UsuarioModuleDestroy(Sender: TObject);
begin
     UsuarioModule := nil;
end;

procedure TUsuarioModule.Valida(     EditControl    : TcxCustomEdit;
                                 var DisplayValue  : Variant;
                                 var ErrorText     : TCaption;
                                 var Error         : Boolean;
                                     UsuarioFields : TUsuarioFields = nil;
                                     IsInfoControl : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmUsuarioTable, [ DisplayValue ], DisplayValue, ErrorText, Error, UsuarioFields, 'Nombre', IsInfoControl );
end;

function TUsuarioModule.Descripcion( Codigo : String; NotificaSiNoExiste : Boolean ) : string;
begin
     GetRelationDescription( DmUsuarioTable, [ Codigo ], Result, NotificaSiNoExiste );
end;

procedure TUsuarioModule.DmUsuarioTableAfterOpen(DataSet: TDataSet);
begin
     DmUsuarioFields := TUsuarioFields.Create( DmUsuarioTable );
end;

function TUsuarioModule.Obten( Codigo        : String;
                               UsuarioFields : TUsuarioFields = nil ) : Boolean;
begin
     Result := DmUsuarioTable.FindKey( [ Codigo ] );
     If   Assigned( UsuarioFields )
     then UsuarioFields.Update( DmUsuarioTable );
end;

function TUsuarioModule.OpcionUsuario( OpcionUsuarioField, OpcionGlobalField : TBooleanField ) : Boolean;
begin
     If   OpcionUsuarioField.IsNull
     then Result := OpcionGlobalField.Value
     else Result := OpcionUsuarioField.Value;
end;

procedure TUsuarioModule.CompruebaPalabraPaso( CodigoUsuario, PalabraPaso : String );
begin
     If   Obten( CodigoUsuario )
     then begin
          If   DmUsuarioFields.Password.Value<>0
          then If   not CheckPassword( DmUsuarioFields, PalabraPaso )
               then Abort;
          end
     else Abort;
end;

end.
