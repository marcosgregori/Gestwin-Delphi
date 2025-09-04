
{$TYPEINFO ON}   // Rtti

unit Gdm60Dm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,
  nxllComponent,
  DB,
  nxdb,
  DataManager,
  DataAccess,

  Gim00Fields;

type
  TDataModule60 = class(TDataModule)
    Dictionary: TnxeDatabaseDictionary;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

  TParametrosPreventaRec = packed record
    case Byte of
      0 : ( Parametros          : TParametrosRec );
      1 : ( CodigoEquipoMovil   : String[ 2 ];
            DocumentoTrabajo    : SmallInt;
            SeleccionConsumos   : Boolean;
            _Host               : String[ 128 ];
            MantenerDocumentos,
            _UsarServicio       : Boolean;
            _Puerto             : SmallInt  );

      end;

function DataModule60 : TDataModule60;

implementation

uses  AppForms,
      AppManager,
      EnterpriseDataAccess;

{$R *.dfm}

var FDataModule60: TDataModule60 = nil;

const RutaDistribucionTableName = 'RutaDistribucion';

function DataModule60 : TDataModule60;
begin
     If   not Assigned( FDataModule60 )
     then CreateDataModule( TDataModule60, FDataModule60 );
     Result := FDataModule60;
end;

procedure Initialize;
begin
     DataModule60;
end;

procedure TDataModule60.DataModuleCreate(Sender: TObject);
begin
     SetupDatabaseDictionary( Dictionary );
end;

procedure TDataModule60.DataModuleDestroy(Sender: TObject);
begin
     FDataModule60 := nil;
end;

initialization
     AddProcedure( imStartup, 0, Initialize );

end.

