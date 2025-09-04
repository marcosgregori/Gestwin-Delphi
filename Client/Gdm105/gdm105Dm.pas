
{$TYPEINFO ON}   // Rtti

unit gdm105Dm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,
  
  nxllComponent,
  DB,
  nxdb,
  DataManager;

type
  TDataModule105 = class(TDataModule)
    Dictionary: TnxeDatabaseDictionary;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

  TVendedoresClienteFields = class( TnxeDatasetFields)
  public
    CodigoCliente : TWideStringField;
    NroRegistro : TSmallIntField;
    CodigoVendedor : TWideStringField;
    Comision : TBCDField;
  end;

  TVendedoresFacturaFields = class( TnxeDatasetFields)
  public
    Ejercicio : TSmallIntField;
    Serie : TWideStringField;
    NroFactura : TIntegerField;
    NroRegistro : TSmallIntField;
    CodigoVendedor : TWideStringField;
    ImporteBase : TBCDField;
    Comision : TBCDField;
  end;

function DataModule105 : TDataModule105;

implementation

uses  AppForms,
      AppManager,
      DataAccess,
      EnterpriseDataAccess;

{$R *.dfm}

var FDataModule105: TDataModule105 = nil;

function DataModule105 : TDataModule105;
begin
     If   not Assigned( FDataModule105 )
     then CreateDataModule( TDataModule105, FDataModule105 );
     Result := FDataModule105;
end;

procedure Initialize;
begin
     DataModule105;
end;

procedure TDataModule105.DataModuleCreate(Sender: TObject);
begin
     SetupDatabaseDictionary( Dictionary );
end;

procedure TDataModule105.DataModuleDestroy(Sender: TObject);
begin
     FDataModule105 := nil;
end;

initialization

     AddProcedure( imOptionalSectionModule, 105 );

     AddProcedure( imStartup, 0, Initialize );

end.

