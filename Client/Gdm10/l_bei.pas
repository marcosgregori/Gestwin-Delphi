unit l_bei;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, Buttons,
  Mask, Menus, cxLookAndFeelPainters, cxButtons, DB,
  dxmdaset, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox, cxMaskEdit, cxDropDownEdit,

  AppContainer,
  AppForms,
  ReportManager,
  DataManager,

  SpreadSheet, cxMemo, dxUIAClasses;

type
    TRptBeiForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    Label1: TcxLabel;
    Label3: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataInforme: TStringField;
    EditarInformeButton: TgBitBtn;
    NuevoInformeButton: TgBitBtn;
    InformeCtrl: TcxDBComboBox;
    cxLabel1: TcxLabel;
    DescripcionCtrl: TcxDBMemo;
    DataDescripcion: TBlobField;
    procedure InitializeForm;
    procedure NuevoInformeButtonClick(Sender: TObject);
    procedure EditarInformeButtonClick(Sender: TObject);
    procedure InformeCtrlPropertiesChange(Sender: TObject);
    procedure FormManagerDestroyForm;
    procedure FormManagerOkButton;
    private
      FReportList : TStringList;
      function GetSelectedFileName: String;
    public

    end;

var RptBeiForm: TRptBeiForm;

procedure BalancesEInformes;


implementation

uses   AppManager,
       Files;

{$R *.DFM}

procedure BalancesEInformes;
begin
     CreateReportForm( TRptBeiForm, RptBeiForm );
end;

function TRptBeiForm.GetSelectedFileName : String;

var  ErrorText : TCaption;
     Error : Boolean;

begin
     Result := CheckReportLocation( DataInforme.Value + ReportExtension[ dtSpreadSheet ], CodigoEmpresaActual, dtSpreadSheet, ErrorText, Error );
     If   Error
     then begin
          ShowNotification( ntWarning, ErrorText );
          Abort;
          end;
end;

procedure TRptBeiForm.EditarInformeButtonClick(Sender: TObject);
begin
     MntPlantillasHojasCalculo( GetSelectedFileName );
end;

procedure TRptBeiForm.FormManagerDestroyForm;
begin
     FreeAndNil( FReportList );
end;

procedure TRptBeiForm.FormManagerOkButton;
begin
     ImprimeHojaCalculo( GetSelectedFileName, { ShowPreview } True );
end;

procedure TRptBeiForm.InformeCtrlPropertiesChange(Sender: TObject);
begin
     EditarInformeButton.Enabled := InformeCtrl.EditValue<>'';
end;

procedure TRptBeiForm.InitializeForm;

var   FileFilter : String;

begin

     FReportList := TStringList.Create;
     FileFilter := '*' + ReportExtension[ dtSpreadSheet ];

     GetReportList( FReportList, { FileBaseName } '', dtSpreadSheet, { RootReports } True );
     For var Inx := 0 to FReportList.Count - 1 do
       InformeCtrl.Properties.Items.Add( FReportList.Names[ Inx ] );

     If   InformeCtrl.Properties.Items.Count>0
     then DataInforme.Value := InformeCtrl.Properties.Items.Strings[ 0 ];

end;

procedure TRptBeiForm.NuevoInformeButtonClick(Sender: TObject);
begin
     MntPlantillasHojasCalculo;
end;

end.


