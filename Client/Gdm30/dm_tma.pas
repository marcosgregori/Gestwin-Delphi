
unit dm_tma;

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

   TTipoMovAlmacenModule = class(TDataModule)
    DmTipoMovAlmacenTable: TnxeTable;
    DmTipoMovAlmacenTableTipo: TSmallintField;
    DmTipoMovAlmacenTableDescripcion: TWideStringField;
    procedure TipoMovAlmacenModuleCreate(Sender: TObject);
    procedure TipoMovAlmacenModuleDestroy(Sender: TObject);
  private
  public
    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean;IsInfoControl : Boolean = False );
    function  Descripcion( codigo : SmallInt; notificaSiNoExiste : Boolean ) : string;
  end;

var
  TipoMovAlmacenModule: TTipoMovAlmacenModule = nil;


function TipoMovAlmacen : TTipoMovAlmacenModule;

const  tmUltimoPredefinido = 19;

implementation

uses LibUtils,
     AppManager,

     DataAccess,
     EnterpriseDataAccess,

     Gim00Fields,

     dmi_mov,

     dm_mov;

{$R *.DFM}

function TipoMovAlmacen : TTipoMovAlmacenModule;
begin
     CreateDataModule( TTipoMovAlmacenModule, TipoMovAlmacenModule );
     Result := TipoMovAlmacenModule;
end;

procedure TTipoMovAlmacenModule.TipoMovAlmacenModuleCreate(Sender: TObject);

var  Index : SmallInt;
     Actualizar : Boolean;

begin

     With DmTipoMovAlmacenTable do
       try
         ShowErrorDialog := False;
         Actualizar := not FindKey( [ tmInventario ] ) or not FindKey( [ tmDevolucionEnvases] );
         If   Actualizar
         then For Index in [ tmInventario..tmVenta, tmDevolucionEnvases ] do
                If   TextoTipoMovimiento[ Index ]<>''
                then begin
                     try

                       If   FindKey( [ Index ] )
                       then Edit
                       else Append;

                       DmTipoMovAlmacenTableTipo.Value := Index;
                       DmTipoMovAlmacenTableDescripcion.Value := TextoTipoMovimiento[ Index ];

                       Post;

                     except
                       Cancel;
                       raise;
                       end;

                     end;
       finally
         ShowErrorDialog := True;
         end;
end;

procedure TTipoMovAlmacenModule.TipoMovAlmacenModuleDestroy(Sender: TObject);
begin
     TipoMovAlmacenModule := nil;
end;

procedure TTipoMovAlmacenModule.Valida(     EditControl   : TcxCustomEdit;
                                        var DisplayValue  : Variant;
                                        var ErrorText     : TCaption;
                                        var Error         : Boolean;
                                            IsInfoControl : Boolean = False );

var  TipoMovimiento : SmallInt;

begin
     TipoMovimiento := VarToInteger( DisplayValue );
     If   TipoMovimiento>tmUltimoPredefinido
     then ValidateRelationEx( EditControl, DmTipoMovAlmacenTable, [ TipoMovimiento ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl )
     else If   TipoMovimiento>0
          then EditControl.Description := TextoTipoMovimiento[ TipoMovimiento ];
end;

function TTipoMovAlmacenModule.Descripcion( Codigo : SmallInt; NotificaSiNoExiste : Boolean ) : String;
begin
     Result := '';
     If   Codigo>tmUltimoPredefinido
     then GetRelationDescription( DmTipoMovAlmacenTable, [ Codigo ], Result, NotificaSiNoExiste )
     else If   Codigo>0
          then Result := TextoTipoMovimiento[ Codigo ];
end;

end.

