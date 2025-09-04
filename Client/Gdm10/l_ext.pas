
unit l_ext;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox, cxDBEdit,
  cxGroupBox, cxRadioGroup, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, DB, dxmdaset, DataManager,
  cxGraphics, cxIndexedComboBox, dxSkinsCore, dxSkinsDefaultPainters,
  cxLookAndFeels, cxLabel,

  AppManager,
  ReportManager, dxUIAClasses;


type
    TrptExtForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    TipoCtrl: TcxDBRadioGroup;
    SeleccionCentroCosteCtrl: TcxDBRadioGroup;
    SoloConSaldoCtrl: TcxDBCheckBox;
    NoArrastrarSumasCtrl: TcxDBCheckBox;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataTipo: TSmallintField;
    DataCentroCoste: TWideStringField;
    DataSoloConSaldo: TBooleanField;
    DataNoArrastrarSumas: TBooleanField;
    DataSeleccionCentroCoste: TSmallintField;
    MostrarPunteoPanel: TcxGroupBox;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    PunteoCtrl: TcxDBIndexedComboBox;
    DataPunteo: TSmallintField;
    CentroCosteCtrl: TcxDBTextEdit;
    Label4: TcxLabel;
    Label1: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label3: TcxLabel;
    Label9: TcxLabel;
    Label8: TcxLabel;
    Label2: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Report: TgxReportManager;
    procedure SeleccionCentroCosteCtrlPropertiesChange(Sender: TObject);
    procedure CentroCosteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    private
      MostrarPunteo : Boolean;
    protected
    class var
      OnInitializeForm  : TSimpleEvent;
    public

    end;

var  RptExtForm : TrptExtForm = nil;

procedure ListadoExtractos( MostrarPunteo : Boolean = False;
                            OnInitialize  : TSimpleEvent = nil );


implementation

uses Gim00Fields,

     Gdm00Dm,

     dm_pga,
     dm_sub,
     dm_cco,
     dm_ext,

     b_msg,

     cx_sub,
     cx_cco;

{$R *.DFM}

procedure ListadoExtractos( MostrarPunteo : Boolean = False;
                            OnInitialize  : TSimpleEvent = nil );
begin
     TrptExtForm.OnInitializeForm := OnInitialize;
     CreateReportForm( TrptExtForm, RptExtForm, [ MostrarPunteo ] );
end;

procedure TrptExtForm.InitializeForm;
begin
     SeleccionCentroCosteCtrl.Enabled := DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value;

     MostrarPunteo := FormValues[ 0 ];
     If   not MostrarPunteo
     then begin
          Height := Height - MostrarPunteoPanel.Height;
          MostrarPunteoPanel.Visible := False;
          end;

     If   Assigned( OnInitializeForm )
     then OnInitializeForm
     else begin
          DataCodigoFinal.Value := HighStrCode;
          DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
          DataFechaFinal.Value := ApplicationContainer.TodayDate;
          DataSeleccionCentroCoste.Value := 0;
          DataTipo.Value := 0;
          DataSoloConSaldo.Value := False;
          DataNoArrastrarSumas.Value := False;
          DataPunteo.Value := 0;
          end;
end;

procedure TrptExtForm.SeleccionCentroCosteCtrlPropertiesChange(Sender: TObject);
begin
     CentroCosteCtrl.Enabled := DataSeleccionCentroCoste.Value=1;
end;

procedure TrptExtForm.FormManagerOkButton;
begin

     With Extracto do
       begin

       With ParametrosExtracto do
         begin
         CodigoInicial := DataCodigoInicial.Value;
         CodigoFinal := DataCodigoFinal.Value;
         SeleccionCentroCoste := DataSeleccionCentroCoste.Value;
         CtroCoste := DataCentroCoste.Value;
         FechaInicial := DataFechaInicial.Value;
         FechaFinal := DataFechaFinal.Value;
         TipoFormato := DataTipo.Value;
         NoArrastrarSumas := DataNoArrastrarSumas.Value;
         SoloConSaldo := DataSoloConSaldo.Value;
         DirectoImpresora := False;
         Punteo := DataPunteo.Value;
         end;

       ImprimeExtracto( Report, ParametrosExtracto );
       end;
end;

procedure TrptExtForm.CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCentrosCoste( Sender );
end;

procedure TrptExtForm.CentroCosteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TrptExtForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True, True );
end;

procedure TrptExtForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

end.
