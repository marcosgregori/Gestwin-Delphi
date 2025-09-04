
unit dm_tma;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB,
  nxdb,
  DataManager,
  ServerDataModule,

  Gim30Fields;

type

   TTipoMovAlmacenModule = class(TServerDataModule)
    DmTipoMovAlmacenTable: TnxeTable;
    DmTipoMovAlmacenTableTipo: TSmallintField;
    DmTipoMovAlmacenTableDescripcion: TWideStringField;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private
  public
    function  Descripcion( Codigo : SmallInt; NotificaSiNoExiste : Boolean ) : String;
  end;

  const  tmUltimoPredefinido = 19;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses LibUtils,
     AppManager,
     SessionData,

     Gim00Fields,

     dmi_mov,

     dm_mov;

{$R *.DFM}

procedure TTipoMovAlmacenModule.ServerDataModuleCreate(Sender: TObject);

var  Index : SmallInt;
     Actualizar : Boolean;

begin

     With DmTipoMovAlmacenTable do
       If   not FindKey( [ tmInventario ] )
       then For Index := tmInventario to tmVenta do
              If   TextoTipoMovimiento[ Index ]<>''
              then begin
                   If   FindKey( [ Index ] )
                   then Edit
                   else Append;

                   DmTipoMovAlmacenTableTipo.Value := Index;
                   DmTipoMovAlmacenTableDescripcion.Value := TextoTipoMovimiento[ Index ];

                   try
                     Post;
                   except
                     end;
                   end;
end;

procedure TTipoMovAlmacenModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm30.TipoMovAlmacenModule := nil;
end;

function TTipoMovAlmacenModule.Descripcion( Codigo : SmallInt; NotificaSiNoExiste : Boolean ) : string;
begin
     Result := '';

     If   Codigo>tmUltimoPredefinido
     then begin
          If   DmtipoMovAlmacenTable.FindKey( [ Codigo ] )
          then Result := DmTipoMovAlmacenTableDescripcion.Value
          else If   NotificaSiNoExiste
               then Result := RsRegistroInexistente;
          end
     else If   Codigo>0
          then Result := TextoTipoMovimiento[ Codigo ];
end;

end.

