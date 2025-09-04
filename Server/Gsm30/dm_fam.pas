
unit dm_fam;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB, nxdb,

  DataManager,
  ServerDataModule,

  Gim30Fields;

type
  TFamiliaModule = class(TServerDataModule)
    DmFamiliaTable: TnxeTable;
    procedure FamiliaModuleCreate(Sender: TObject);
  private


  public

    DmFamiliaFields  : TFamiliaFields;

    function  Descripcion( Codigo : String ) : String;
    function  Obten( Codigo : String; FamiliaFields : TFamiliaFields = nil ) : Boolean;
  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses LibUtils,
     AppManager,

     EnterpriseData,

     Gim00Fields;

{$R *.DFM}

resourceString
     RsMsg1 = 'La Familia de código [%s] no existe.';

procedure TFamiliaModule.FamiliaModuleCreate(Sender: TObject);
begin
     DmFamiliaFields := TFamiliaFields.Create( DmFamiliaTable );
end;

function TFamiliaModule.Descripcion( Codigo : String ) : String;
begin
     If   DmFamiliaTable.FindKey( [ Codigo ] )
     then Result := DmFamiliaFields.Descripcion.Value
     else Result := '';
end;

function  TFamiliaModule.Obten( Codigo        : String;
                                FamiliaFields : TFamiliaFields = nil ) : Boolean;
begin
     Result := DmFamiliaTable.FindKey( [ Codigo ] );
     If   Assigned( FamiliaFields )
     then FamiliaFields.Update( DmFamiliaTable );
end;

end.

