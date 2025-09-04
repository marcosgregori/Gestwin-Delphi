unit dm_rdi;

interface

uses
  Windows, Messages, SysUtils, Classes, 
  DB, nxdb, DataManager,

  Gim10Fields,
  SerVerDataModule;


type
  TRelacionesDivisaModule = class(TServerDataModule)
    DmRelacionesDivisaTable: TnxeTable;
    procedure RelacionesDivisaModuleDestroy(Sender: TObject);
    procedure RelacionesDivisaModuleCreate(Sender: TObject);
  private

    DmRelacionesDivisaFields  : TRelacionesDivisaFields;

  public


    function  Obten( Codigo : String; RelacionesDivisaFields : TRelacionesDivisaFields ) : boolean;
  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses AppManager,
     SessionData;

{$R *.DFM}

procedure TRelacionesDivisaModule.RelacionesDivisaModuleDestroy(Sender: TObject);
begin
     SessionDataMOdule.Dm10.RelacionesDivisaModule := nil;
end;

function  TRelacionesDivisaModule.Obten( Codigo                 : String;
                                         RelacionesDivisaFields : TRelacionesDivisaFields ) : Boolean;
begin
     Result := DmRelacionesDivisaTable.FindKey( [ Codigo ] );
     RelacionesDivisaFields.Update( DmRelacionesDivisaTable );
end;

procedure TRelacionesDivisaModule.RelacionesDivisaModuleCreate(Sender: TObject);
begin
     DmRelacionesDivisaFields := TRelacionesDivisaFields.Create( DmRelacionesDivisaTable );
end;

end.
