unit l_imp;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,

  ReportManager,
  Menus,
  cxLookAndFeelPainters,
  cxButtons,
  DB,
  dxmdaset,
  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  cxGraphics, cxMaskEdit, cxDropDownEdit, cxIndexedComboBox, cxLookAndFeels,
  dxSkinsCore, cxGroupBox, dxSkinsDefaultPainters, dxUIAClasses;


type
    TRptImpForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    DataSource: TDataSource;
    Data: TgxMemData;
    Label3: TLabel;
    TipoImpresoCtrl: TcxDBIndexedComboBox;
    DataTipoDocumento: TSmallintField;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure ReportBeforeStart;
    private
    public

    end;

var
  RptImpForm : TRptImpForm;

procedure ListadoImpresos;


implementation

{$R *.DFM}

uses   dm_ine;

procedure ListadoImpresos;
begin
     CreateReportForm( TRptImpForm, RptImpForm );
end;

procedure TRptImpForm.FormManagerInitializeForm;
begin
     InformeExterno.AsignaTextoModeloImpreso( TipoImpresoCtrl );
     TipoImpresoCtrl.Properties.Items.Insert( 0, '<Todos>' );

     DataTipoDocumento.Value := 0;
end;

procedure TRptImpForm.FormManagerOkButton;
begin
     Report.Launch;
end;

procedure TRptImpForm.ReportBeforeStart;
begin
     Report.SetValue( 'TextoTipoDocumento', TipoImpresoCtrl.Text );
end;

end.

