
unit b_ccc;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  LibUtils,
  AppContainer,
  Mask,
  Menus,
  cxLookAndFeelPainters,
  cxButtons,
  DB,
  nxdb,
  DataManager, cxCheckBox, cxDBEdit, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, dxmdaset,

  Gim10Fields,
  Gim30Fields,

  dm_sal, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox, dxUIAClasses;


type

    TBoxCccForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Data: TgxMemData;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataContabilizar: TBooleanField;
    DataSource: TDataSource;
    gxRangeBox2: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    ContabilizarCtrl: TcxDBCheckBox;
    Label1: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure FormManagerOkButton;
    procedure ContabilizarCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure FormManagerInitializeForm;
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private
      procedure ExecuteProcess;
    public

    end;

var BoxCccForm: TBoxCccForm = nil;

procedure CierreCicloCompras;

implementation

uses   AppManager,

       Gdm30Frm,

       dm_ast,
       dm_fdc,

       b_pro;

{$R *.DFM}

resourceString
     RsMsg23 = 'El ejercicio contable está cerrado.';
     RsMsg24 = 'Si realiza el proceso de cierre la contabilidad podría quedar en una situación inconsistente.' + #13 +
               '¿Está seguro de que desea contabilizar las facturas?';

procedure CierreCicloCompras;
begin
     CreateEditForm( TBoxCccForm, BoxCccForm, TGds30Frm.ComprasSection, True );
end;

procedure TBoxCccForm.FechaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TBoxCccForm.FormManagerInitializeForm;
begin
     DataFechaInicial.Value := ApplicationContainer.FirstDayOfYearDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataContabilizar.Value := True;
end;

procedure TBoxCccForm.ContabilizarCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ContabilizarCtrl.Checked
     then If   Asiento.EjercicioCerrado
          then If   ShowNotification( ntQuestionWarning, RsMsg23, RsMsg24 )<>mrYes
               then ContabilizarCtrl.PostEditValue( False );
end;

procedure TBoxCccForm.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxCccForm.ExecuteProcess;
begin
     FacturaCompras.CierreCicloFacturacion( DataFechaInicial.Value, DataFechaFinal.Value, DataContabilizar.Value );
end;

end.
