unit b_ccv;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  LibUtils,
  AppContainer,

  Mask,

  dm_sal,
  Menus,
  cxLookAndFeelPainters,
  cxButtons, DB, nxdb, DataManager, dxmdaset, cxCheckBox, cxDBEdit,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox, dxUIAClasses;


type
    TBoxCcvForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    FechaInicialCtrl: TcxDBDateEdit;
    ApunteTable: TnxeTable;
    SerieIncialCtrl: TcxDBTextEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    ContabilizarCtrl: TcxDBCheckBox;
    AsientoTable: TnxeTable;
    EfectoCobrarTable: TnxeTable;
    FacturaVentasTable: TnxeTable;
    MovimientoCajaTable: TnxeTable;
    SerieFinalCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataSerieInicial: TWideStringField;
    DataSerieFinal: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataContabilizar: TBooleanField;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label6: TcxLabel;
    Label3: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ContabilizarCtrlPropertiesEditValueChanged(Sender: TObject);
    private
      procedure ExecuteProcess;
    public

    end;

var BoxCcvForm: TBoxCcvForm;

procedure CierreCicloVentas;

implementation

uses   DateUtils,
       EnterpriseDataAccess,
       AppManager,

       Gdm30Frm,

       b_pro,
       b_msg,

       dm_ast,
       dm_sdf,
       dm_fdv,

       cx_sdf,

       f_prg;

{$R *.DFM}

resourceString
     RsMsg23 = 'El ejercicio contable está cerrado.';
     RsMsg24 = 'Si realiza el proceso de cierre la contabilidad podría quedar en una situación inconsistente.' + #13 +
               '¿Está seguro de que desea contabilizar las facturas?';


procedure CierreCicloVentas;
begin
     CreateEditForm( TBoxCcvForm, BoxCcvForm, TGds30Frm.VentasSection, True );
end;

procedure TBoxCcvForm.InitializeForm;
begin
     DataFechaInicial.Value := ApplicationContainer.FirstDayOfYearDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataContabilizar.Value := True;
end;

procedure TBoxCcvForm.FechaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TBoxCcvForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxCcvForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxCcvForm.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxCcvForm.ContabilizarCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ContabilizarCtrl.Checked
     then If   Asiento.EjercicioCerrado
          then If   ShowNotification( ntQuestionWarning, RsMsg23, RsMsg24 )<>mrYes
               then ContabilizarCtrl.PostEditValue( False );
end;

procedure TBoxCcvForm.ExecuteProcess;
begin
     FacturaVentas.CierreCicloFacturacion( DataSerieInicial.Value, DataSerieFinal.Value, DataFechaInicial.Value, DataFechaFinal.Value, DataContabilizar.Value );
end;

end.
