unit f_tpv;

{$TYPEINFO ON}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls,

  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,

  Menus,
  cxLookAndFeelPainters,
  cxButtons,

  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  AppForms, nxdb, DataManager,

  dmi_mov;

type
  TTPVModule = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
  public
    procedure DoOnMuestraTickets( TipoMovimiento : TTipoMovimiento; Ejercicio : SmallInt; Serie : String; NroDocumento : LongInt );
  end;

var TPVModule : TTPVModule = nil;

implementation

uses EnterpriseDataAccess,
     AppManager,

     Gim30Fields,

     b_rdc,
     a_fdv,
     a_tck;

{$R *.dfm}

procedure SetupRelacionDocumentos;
begin
     CreateDataModule( TTPVModule, TPVModule );
     If   Assigned( TPVModule )
     then BrwRdcForm.OnMuestraTicket.Add( TPVModule.DoOnMuestraTickets );
end;

procedure SetupFacturaVenta;
begin
     CreateDataModule( TTPVModule, TPVModule );
     If   Assigned( TPVModule )
     then MntFdvForm.OnMuestraTicket.Add( TPVModule.DoOnMuestraTickets );
end;

procedure TTPVModule.DoOnMuestraTickets( TipoMovimiento : TTipoMovimiento; Ejercicio : SmallInt; Serie : String; NroDocumento : LongInt  );
begin
     MntTickets( [ TipoMovimiento, Ejercicio, Serie, NroDocumento ] );
end;

procedure TTPVModule.DataModuleCreate(Sender: TObject);
begin
     //..
end;

procedure TTPVModule.DataModuleDestroy(Sender: TObject);
begin
     TPVModule := nil;
end;

initialization
   AddProcedure( imOnCreateComponent, idBrwRdcForm, SetupRelacionDocumentos );
   AddProcedure( imOnCreateComponent, idMntFdvForm, SetupFacturaVenta );

end.
