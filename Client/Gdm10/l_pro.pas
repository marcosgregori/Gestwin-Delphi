unit l_pro;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, ReportManager, DB,
  dxmdaset, DataManager, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxPC,
  cxControls, cxCheckBox, dxSkinsCore, dxSkinscxPCPainter, cxGraphics,
  cxLookAndFeels, dxSkinsDefaultPainters, cxLabel, cxGroupBox,
  cxPCdxBarPopupMenu, dxBarBuiltInMenu;

                                                                                                  
type
    TRptProForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    OrdenarCtrl: TcxDBCheckBox;
    TodosLosDatosCtrl: TcxDBCheckBox;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    ProveedorInicialCtrl: TcxDBTextEdit;
    ProveedorFinalCtrl: TcxDBTextEdit;
    TabSheet3: TcxTabSheet;
    CodigoPostalInicialCtrl: TcxDBTextEdit;
    CodigoPostalFinalCtrl: TcxDBTextEdit;
    ProvinciaInicialCtrl: TcxDBTextEdit;
    ProvinciaFinalCtrl: TcxDBTextEdit;
    CodigoPaisCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataProveedorInicial: TWideStringField;
    DataProveedorFinal: TWideStringField;
    DataOrdenar: TBooleanField;
    DataTodosLosDatos: TBooleanField;
    DataCodigoPostalInicial: TWideStringField;
    DataCodigoPostalFinal: TWideStringField;
    DataProvinciaInicial: TWideStringField;
    DataProvinciaFinal: TWideStringField;
    DataCodigoPais: TWideStringField;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox4: TgxRangeBox;
    Label4: TcxLabel;
    Label5: TcxLabel;
    Label2: TcxLabel;
    Label6: TcxLabel;
    Label1: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataIncluirObsoletos: TBooleanField;
    IncluirObsoletosCtrl: TcxDBCheckBox;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ProvinciaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalInicialCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalFinalCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalFinalCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoPostalInicialCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoPaisCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoPaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ReportAfterStart;
    procedure ProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure ProvinciaFinalCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ProvinciaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
    private

    public

    end;

var RptProForm : TRptProForm = nil;

procedure ListadoProveedores;


implementation

uses   Gim00Fields,

       dm_pai,
       dm_prv,
       dm_cop,
       dm_pro,

       cx_pro,
       cx_prv,
       cx_pai,
       cx_cop;

{$R *.DFM}

resourceString
       RsMsg1 = ' y acreedores';

procedure ListadoProveedores;
begin
     CreateReportForm( TRptProForm, RptProForm );
end;

procedure TRptProForm.InitializeForm;
begin

     If   ApplicationContainer.IsModuleActive( [ 30 ] )
     then begin
          Report.FileName := 'dm30\l_pro';
          HelpFile := 'hs30';
          end
     else Caption := Caption + RsMsg1;

     DataProveedorFinal.Value := HighStrCode;
     DataCodigoPais.Value := CodigoEspaña;
     DataProvinciaFinal.Value := HighStrCode;
     DataCodigoPostalFinal.Value  := HighStrCode;
     DataOrdenar.Value := False;
     DataTodosLosDatos.Value := False;
end;

procedure TRptProForm.ProvinciaCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaProvincias( DataCodigoPais.Value, Sender );
end;

procedure TRptProForm.ProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( DataCodigoPais.Value, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptProForm.ProvinciaFinalCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ProvinciaFinalCtrl.Editing
     then CodigoPostalFinalCtrl.PostEditValue( '' );
end;

procedure TRptProForm.ProvinciaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ProvinciaInicialCtrl.Editing
     then CodigoPostalInicialCtrl.PostEditValue( '' );
end;

procedure TRptProForm.ReportAfterStart;
begin
     Report.SetValue( RsSeleccion, PageControl.ActivePageIndex );
end;

procedure TRptProForm.ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TRptProForm.ProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptProForm.CodigoPaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TRptProForm.CodigoPaisCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptProForm.CodigoPostalFinalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( DataCodigoPais.Value, DataProvinciaFinal.Value, Sender );
end;

procedure TRptProForm.CodigoPostalFinalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( DataCodigoPais.Value, DataProvinciaFinal.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptProForm.CodigoPostalInicialCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( DataCodigoPais.Value, DataProvinciaInicial.Value, Sender );
end;

procedure TRptProForm.CodigoPostalInicialCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( DataCodigoPais.Value, DataProvinciaInicial.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptProForm.FormManagerOkButton;
begin
     Report.Launch;
end;

end.
