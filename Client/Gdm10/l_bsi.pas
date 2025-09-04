
unit l_bsi;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons, Mask,
  ComCtrls,
  DataManager,
  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, cxTextEdit,
  cxMaskEdit, cxSpinEdit, cxDBEdit, cxControls, cxContainer, cxEdit,
  cxCheckBox, DB, dxmdaset,

  LibUtils,

  dm_sal,

  Gim00Fields,
  Gim10Fields,
  nxdb, dxSkinsCore, cxGraphics, cxLookAndFeels, dxSkinsDefaultPainters,
  cxLabel, cxGroupBox, AppContainer;

type
    TSeccionBalance = ( sbActivo, sbPasivo );
    TTipoRegistro = ( trCabecera, trLinea, trDesglose, trTotal, trTotalgeneral );
    TListaSaldos  = array[ 1..2 ] of Decimal;

   TRptBsiForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    ModeloAbreviadoCtrl: TcxDBCheckBox;
    PeriodoInicialCtrl: TcxDBSpinEdit;
    PeriodoFinalCtrl: TcxDBSpinEdit;
    SaldosFinalesCtrl: TcxDBCheckBox;
    DesglosarCtrl: TcxDBCheckBox;
    BalanceComparativoCtrl: TcxDBCheckBox;
    gxRangeBox1: TgxRangeBox;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataPeriodoInicial: TSmallintField;
    DataPeriodoFinal: TSmallintField;
    DataSaldosFinales: TBooleanField;
    DataModeloAbreviado: TBooleanField;
    DataDesglosar: TBooleanField;
    DataComparativo: TBooleanField;
    Label4: TcxLabel;
    Label3: TcxLabel;
    Label2: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure BalanceComparativoCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure PeriodoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure InitializeForm;
    procedure ReportBeforeStart;
    procedure FormManagerOkButton;
    private

    public

      BalanceTable : TnxeTable;

    end;

var  RptBsiForm : TRptBsiForm = nil;

procedure BalanceSituacion;


implementation

uses   Variants,
       Files,
       DateUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm10Dm,

       dm_pga,
       dm_sub,
       dm_cco,

       b_msg,

       cx_sub,
       cx_cco;

{$R *.DFM}

procedure BalanceSituacion;
begin
     CreateReportForm( TRptBsiForm, RptBsiForm );
end;

procedure TRptBsiForm.initializeForm;
begin
     DataPeriodoFinal.Value := MonthOf( ApplicationContainer.TodayDate );
     DataModeloAbreviado.Value := False;
     DataComparativo.Value := True;
end;

procedure TRptBsiForm.PeriodoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateMonth( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptBsiForm.FormManagerOkButton;
begin
     Saldos.Cuadra;
     Report.Launch;
end;

procedure TRptBsiForm.ReportBeforeStart;
begin
     With Report do
       begin
       BalanceTable := CreateEmptyTable( 'Balance', DataModule10.SQLSet );

       Saldos.SaldosBalanceSituacion( BalanceTable,
                                      ApplicationContainer.Ejercicio,
                                      DataPeriodoInicial.Value,
                                      DataPeriodoFinal.Value,
                                      DataDesglosar.Value,
                                      DataSaldosFinales.Value,
                                      DataModeloAbreviado.Value,
                                      DataComparativo.Value );

       SetValue( RsTextoPeriodoInicial, StrMonth( DataPeriodoInicial.Value, False ) );
       SetValue( RsTextoPeriodoFinal, StrMonth( DataPeriodoFinal.Value, False ) );
       end;
end;

procedure TRptBsiForm.BalanceComparativoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     SaldosFinalesCtrl.Enabled := DataComparativo.Value;
end;

end.
