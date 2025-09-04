
{$TYPEINFO ON}   // Rtti

unit gdm20Dm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,

  LibUtils,
  AppContainer,

  DataManager,
  nxllComponent,
  DB,
  nxdb,

  Gim00Fields;

type
  TDataModule20 = class(TDataModule)
    dictionary: TnxeDatabaseDictionary;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

   TArqueoFields = class( TnxeDatasetFields)
     public
       Serie : TWideStringField;
       Fecha : TDateField;
       SaldoInicial : TBCDField;
       ImporteVentas : TBCDField;
       ImpVentasEfectivo : TBCDField;
       ImporteMovimCaja : TBCDField;
       ImpMovimCajaEfectivo : TBCDField;
       ImporteRetirado : TBCDField;
       Cerrado : TBooleanField;
     end;

     TLineaArqueoFields = class( TnxeDatasetFields)
     public
       Serie : TWideStringField;
       Fecha : TDateField;
       TipoOperacion : TSmallIntField;
       FormaCobro : TWideStringField;
       Importe : TBCDField;
       ImporteEnEfectivo : TBCDField;
     end;

function DataModule20 : TDataModule20;

implementation

uses  AppForms,
      AppManager,
      DataAccess,
      EnterpriseDataAccess;

{$R *.dfm}

var  FDataModule20  : TDataModule20 = nil;

function DataModule20 : TDataModule20;
begin
     If   not Assigned( FDataModule20 )
     then CreateDataModule( TDataModule20, FDataModule20 );
     Result := FDataModule20;
end;

procedure Initialize;
begin
     DataModule20;
end;

procedure TDataModule20.DataModuleCreate(Sender: TObject);
begin
     SetupDatabaseDictionary( Dictionary );
end;

procedure TDataModule20.DataModuleDestroy(Sender: TObject);
begin
     FDataModule20 := nil;
end;

initialization
     AddProcedure( imStartup, 0, initialize );

end.
