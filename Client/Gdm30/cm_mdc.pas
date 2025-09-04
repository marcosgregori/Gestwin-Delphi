unit cm_mdc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls, DB,

  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,

  Gim10Fields;

type
  TCmdMdcModule = class(TDataModule)
    procedure DataModuleDestroy(Sender: TObject);
  private
  protected
    procedure SerieCtrlEditRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure MovimientoCajaTableSetKey( DataSet : TDataSet );
  end;

var CmdMdcModule : TCmdMdcModule = nil;

implementation

uses AppManager,

     a_mdc,

     dm_sdf,

     a_sdf,

     cx_sdf;

{$R *.dfm}

resourceString
     rsMsg1 = '';

procedure SetupModule;


begin
     If   Assigned( MntMdcForm )
     then begin

          // El DataModule está vinculado al Form por lo que se destruye al cerrar la ventana

          CreateDataModule( TCmdMdcModule, CmdMdcModule, MntMdcForm );
          If   Assigned( CmdMdcModule )
          then begin
               With MntMdcForm.SerieCtrl.Properties do
                 begin
                 OnEditRequest := CmdMdcModule.SerieCtrlEditRequest;
                 OnQueryRequest := CmdMdcModule.SerieCtrlQueryRequest;
                 OnValidate := CmdMdcModule.SerieCtrlValidate;
                 end;
               MntMdcForm.MovimientoCajaTable.OnSetKey := CmdMdcModule.MovimientoCajaTableSetKey;
               end;
          end;
end;

procedure TCmdMdcModule.SerieCtrlEditRequest(Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [ Sender.EditingValue ] );
end;

procedure TCmdMdcModule.SerieCtrlQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TCmdMdcModule.SerieCtrlValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TCmdMdcModule.DataModuleDestroy(Sender: TObject);
begin
     CmdMdcModule := nil;
end;

procedure TCmdMdcModule.MovimientoCajaTableSetKey( DataSet : TDataSet );
begin
     If   Assigned( MntMdcForm )
     then With MntMdcForm, MovimientoCajaFields do
            begin
            Ejercicio.Value := ApplicationContainer.Ejercicio;
            If   LockRangeButton.SettingDefaultRange
            then SerieFacturacion.FijaSeriePorDefecto( Serie );
            end;
end;

initialization
  AddProcedure( imOnCreateComponent, idMntMdcForm, SetupModule );

end.
