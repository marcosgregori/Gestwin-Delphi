
unit dm_eqm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, cxEdit,
  AppContainer,
  DB,
  nxdb,
  AppForms,
  DataManager,

  Gim30Fields;

type
  TEquipoMovilModule = class(TDataModule)
    DmEquipoMovilTable: TnxeTable;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

    FEquipoMovilFields : TEquipoMovilFields;

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False  ); 
    function  Descripcion( codigo : String; notificaSiNoExiste : boolean ) : string;
    function  Obten( codigo : String; EquipoMovilFields : TEquipoMovilFields = nil; NotificaSiNoExiste : Boolean = False ) : Boolean;
  end;

var
  EquipoMovilModule: TEquipoMovilModule = nil;

function EquipoMovil : TEquipoMovilModule;

implementation

uses LibUtils,
     AppManager,
     EnterpriseDataAccess,

     b_msg;

{$R *.DFM}

resourceString
     RsMsg1 = 'El quipo móvil de código [%s] ha sido dada de baja.';

function EquipoMovil : TEquipoMovilModule;
begin
     CreateDataModule( TEquipoMovilModule, EquipoMovilModule );
     Result := EquipoMovilModule;
end;

procedure TEquipoMovilModule.Valida(     EditControl   : TcxCustomEdit;
                                     var DisplayValue  : Variant;
                                     var ErrorText     : TCaption;
                                     var Error         : Boolean;
                                         IsInfoControl : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmEquipoMovilTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

function TEquipoMovilModule.Descripcion( codigo : String; NotificaSiNoExiste : Boolean ) : String;
begin
     GetRelationDescription( DmEquipoMovilTable, [ Codigo ], Result, NotificaSiNoExiste, RsDescripcion );
end;

function  TEquipoMovilModule.Obten( Codigo             : String;
                                    EquipoMovilFields  : TEquipoMovilFields = nil;
                                    NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmEquipoMovilTable.FindKey( [ Codigo ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( rsMsg1, [ Codigo ] ), '' );
          Abort;
          end;
     If   Assigned( EquipoMovilFields )
     then EquipoMovilFields.Update( DmEquipoMovilTable );
end;

procedure TEquipoMovilModule.DataModuleCreate(Sender: TObject);
begin
     FEquipoMovilFields := TEquipoMovilFields.Create( DmEquipoMovilTable );
end;

procedure TEquipoMovilModule.DataModuleDestroy(Sender: TObject);
begin
     EquipoMovilModule := nil;
end;

end.

