unit dm_fco;

interface

uses
  Windows, Messages, SysUtils, Classes, 

  DB,
  nxdb,
  DataManager,

  ServerDataModule,
  Gim10Fields;


type
  TFormaCobroModule = class(TServerDataModule)
    DmFormaCobroTable: TnxeTable;
    procedure FormaCobroModuleDestroy(Sender: TObject);
  private

  public


    function Descripcion( Codigo : String; NotificaSiNoExiste : Boolean = True ) : String;
    function Obten( Codigo : String; FormaCobroFields : TFormaCobroFields ) : Boolean;

  end;


implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses Gim00Fields,
     AppManager,
     SessionData;

{$R *.DFM}

ResourceString
     RsMsg1 = 'La forma de cobro de código [%s] ha sido dada de baja.';

procedure TFormaCobroModule.FormaCobroModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.FormaCobroModule := nil;
end;

function TFormaCobroModule.Descripcion( Codigo             : String;
                                        NotificaSiNoExiste : Boolean = True ) : String;
begin
     Result := '';
     If   DmFormaCobroTable.FindKey( [ Codigo ] )
     then Result := DmFormaCobroTable.FieldValues[ RsDescripcion ]
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente;
end;

function TFormaCobroModule.Obten( Codigo           : String;
                                  FormaCobroFields : TFormaCobroFields ) : Boolean;
begin
     Result := DmFormaCobroTable.FindKey( [ Codigo ] );
     FormaCobroFields.Update( DmFormaCobroTable );
end;

end.
