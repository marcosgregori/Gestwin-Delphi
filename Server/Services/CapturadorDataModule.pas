unit CapturadorDataModule;

interface

uses
  Windows, Messages, SysUtils, Classes,
  DB,
  nxdb,
  KbmMemTable,

  DataManager,
  ServerDataModule, kbmMWCustomConnectionPool, kbmMWCustomDataset,
  kbmMWClientDataset;


type
  TCapturadorDataModule = class(TServerDataModule)
    ClaseTable: TkbmMemTable;
    ClaseTableNroClase: TSmallintField;
    ClaseTableCodigo: TWideStringField;
    ClaseTableDescripcion: TWideStringField;
    ArticuloTable: TkbmMemTable;
    ArticuloTableCodigo: TWideStringField;
    ArticuloTableDescripcion: TWideStringField;
    ArticuloTablePrecio_Venta: TFloatField;
    ArticuloTableCodigoBarras: TWideStringField;
    ArticuloTableUbicacion: TStringField;
    procedure DataModuleDestroy(Sender: TObject);
  private
  public

  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses LibUtils,

     AppManager,
     MainData,
     SessionData;

{$R *.dfm}

{
resourceString
     RsMsg1  = '';
}

procedure TCapturadorDataModule.DataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.DmCapturador := nil;
end;


end.
