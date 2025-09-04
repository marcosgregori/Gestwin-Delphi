
unit l_arq;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  Menus, cxLookAndFeelPainters, cxButtons, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxDBEdit, cxControls, cxContainer, cxEdit,
  cxTextEdit, ReportManager, DB, dxmdaset, DataManager, cxGraphics,
  cxLookAndFeels, dxSkinsCore, cxLabel, dxSkinsDefaultPainters, cxGroupBox;


type
    TRptArqForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataSerieInicial: TWideStringField;
    DataSerieFinal: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataSource: TDataSource;
    report: TgxReportManager;
    gxRangeBox1: TgxRangeBox;
    SerieInicialCtrl: TcxDBTextEdit;
    SerieFinalCtrl: TcxDBTextEdit;
    gxRangeBox2: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    Label19: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label6: TcxLabel;
    procedure FormManagerOkButton;
    procedure SerieCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SerieFinalCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerInitializeForm;
    private

    public

    end;

var  RptArqForm: TRptArqForm;

procedure ListadoArqueo;

implementation

uses   Gim10Fields,
       Gdm20Dm,

       dm_sdf,
       
       cx_sdf;

{$R *.DFM}

procedure ListadoArqueo;
begin
     CreateReportForm( TrptArqForm, RptArqForm );
end;

procedure TRptArqForm.FormManagerInitializeForm;
begin
     DataSerieFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
end;

procedure TRptArqForm.FormManagerOkButton;
begin
     Enabled := False;
     With Report do
       try
         Load;
         SetValueFields( Data );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptArqForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TRptArqForm.SerieFinalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

end.
