unit dm_cdi;

interface

uses
  Windows, Messages, SysUtils, Classes,
  DB,
  nxdb,

  DataManager,
  ServerDataModule,

  Gim00Fields;


type
  TDivisaModule = class(TServerDataModule)
    DmDivisaTable: TnxeTable;
    DmDivisaTableCodigo: TWideStringField;
    DmDivisaTableDescripcion: TWideStringField;
    DmDivisaTablePrecisionRedondeo: TFloatField;
    DmDivisaTableCambioFijo: TBooleanField;
    DmDivisaTableTipoCambio: TFloatField;
    procedure divisaModuleDestroy(Sender: TObject);
  private
  public
    function Descripcion( Codigo : String; NotificaSiNoExiste : Boolean ) : String;
    function Obten( Codigo : String; DivisaFields : TDivisaFields = nil ) : Boolean;
    function Decimales( Codigo : String ) : SmallInt;
  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses LibUtils,

     AppManager,
     MainData,
     SessionData;

{$R *.dfm}

resourceString
     RsMsg1  = 'La divisa de código [%s] ha sido dada de baja.';

procedure TDivisaModule.DivisaModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm00.DivisaModule := nil;
end;

function TDivisaModule.Descripcion( Codigo             : String;
                                    NotificaSiNoExiste : Boolean ) : String;
begin
     Result := '';
     If   DmDivisaTable.FindKey( [ Codigo ] )
     then Result := DmDivisaTableDescripcion.Value
     else If   NotificaSiNoExiste
          then Result := RsRegistroInexistente;
end;

function TDivisaModule.Decimales( Codigo : String ) : SmallInt;
begin
     Result := DecimalesMoneda;
     If   DmDivisaTable.FindKey( [ Codigo ] )
     then Result := LibUtils.Decimales( DmDivisaTablePrecisionRedondeo.Value );
end;

function TDivisaModule.Obten( Codigo       : String;
                              DivisaFields : TDivisaFields = nil ) : Boolean;
begin
     Result := DmDivisaTable.FindKey( [ Codigo ] );
     If   Assigned( DivisaFields )
     then DivisaFields.Update( DmDivisaTable );
end;

end.
