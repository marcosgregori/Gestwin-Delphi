
unit dm_rdm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,

  cxProgressBar,

  LibUtils,
  AppForms,
  Gim30Fields,
  DB, nxdb, DataManager,
  nxllComponent;

type

  TRelacionDocumentosModule = class(TDataModule)
    DmRelacionDocumentosTable: TnxeTable;
    procedure ResultadosModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

  public

    function TieneDocumentos( NroRegistro : LongInt ) : Boolean;

  end;

var RelacionDocumentosModule: TRelacionDocumentosModule = nil;

function RelacionDocumentos : TRelacionDocumentosModule;

implementation

{$R *.DFM}

uses   AppManager,

       dmi_mov;

function RelacionDocumentos : TRelacionDocumentosModule;
begin
     CreateDataModule( TRelacionDocumentosModule, RelacionDocumentosModule );
     Result := RelacionDocumentosModule;
end;

procedure TRelacionDocumentosModule.DataModuleCreate(Sender: TObject);
begin
     //
end;

function TRelacionDocumentosModule.TieneDocumentos( NroRegistro : LongInt ) : Boolean;
begin
     If   NroRegistro<>0
     then begin
          DmRelacionDocumentosTable.IndexFieldNames := 'Tipo;NroOperacion';
          Result := DmRelacionDocumentosTable.FindEqualFirst( [ trdLineaMovimiento, NroRegistro ] );
          end
     else Result := False;
end;

procedure TRelacionDocumentosModule.ResultadosModuleDestroy(Sender: TObject);
begin
     RelacionDocumentosModule := nil;
end;


end.

