
unit l_mdc;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,
     comCtrls, Menus, cxLookAndFeelPainters, cxButtons, ReportManager, DB,
  dxmdaset, DataManager, cxGraphics, cxDropDownEdit, cxCalendar, cxDBEdit,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,

  Gim00Fields,
  Gim10Fields, cxIndexedComboBox, dxSkinsCore, dxSkinsDefaultPainters,
  cxLookAndFeels, cxLabel, cxGroupBox;


type
    TRptMdcForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    TipoOperacionCtrl: TcxDBIndexedComboBox;
    SerieCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    Data: TgxMemData;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataSerie: TWideStringField;
    DataTipoOperacion: TSmallintField;
    gxRangeBox2: TgxRangeBox;
    Label8: TcxLabel;
    Label19: TcxLabel;
    Label20: TcxLabel;
    Label6: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    private

    public

    end;

var
  RptMdcForm: TRptMdcForm = nil;

procedure ListadoMovimientosCaja( Serie : String );

implementation

uses   SysUtils,
       EnterpriseDataAccess,

       b_msg;

{$R *.DFM}

procedure ListadoMovimientosCaja( Serie : String );
begin
     CreateReportForm( TRptMdcForm, RptMdcForm, [ Serie ] );
end;

procedure TRptMdcForm.FormManagerInitializeForm;
begin
     DataSerie.Value := FormValues[ 0 ];
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataTipoOperacion.Value := 2;
end;

procedure TRptMdcForm.FormManagerOkButton;
begin
     Enabled := false;

     With Report do
       begin
       try
         Load;
         SetValue( 'TextoTipoOperacion', TipoOperacionCtrl.Text );
         Start;
       except on E : Exception do Cancel( E );
         end;

       end;

end;

end.
