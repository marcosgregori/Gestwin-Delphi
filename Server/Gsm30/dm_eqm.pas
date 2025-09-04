
unit dm_eqm;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB,
  nxdb,

  DataManager,
  ServerDataModule,

  Gim10Fields,
  Gim30Fields;

type
  TEquipoMovilModule = class(TServerDataModule)
    DmEquipoMovilTable: TnxeTable;
    DmMovimientoTable: TnxeTable;
    DmLineaMovimientoTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

  public

    DmEquipoMovilFields : TEquipoMovilFields;
    DmMovimientoFields : TMovimientoFields;
    DmLineaMovimientoFields : TLineaMovimientoFields;

    function  Obten( Codigo : String; EquipoMovilFields : TEquipoMovilFields = nil ) : Boolean;
  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses LibUtils,

     EnterpriseData,
     SessionData;

{%CLASSGROUP 'VCL.Controls.TControl'}

{$R *.DFM}

procedure TEquipoMovilModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmEquipoMovilFields := TEquipoMovilFields.Create( DmEquipoMovilTable );
     DmMovimientoFields := TMovimientoFields.Create( DmMovimientoTable );
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );

end;

function  TEquipoMovilModule.Obten( Codigo            : String;
                                    EquipoMovilFields : TEquipoMovilFields = nil ) : Boolean;
begin
     Result := DmEquipoMovilFields.Table.FindKey( [ Codigo ] );
     If   Assigned( EquipoMovilFields )
     then EquipoMovilFields.Update( DmEquipoMovilTable );
end;

procedure TEquipoMovilModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm30.EquipoMovilModule := nil;
end;


end.

