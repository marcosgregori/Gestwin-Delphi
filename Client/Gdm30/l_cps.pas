
unit l_cps;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     LibUtils,
     AppContainer,

     ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
  DataManager, dxmdaset, ReportManager, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit,

  cxCheckBox, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxIndexedComboBox, frxNXComponents, cxGroupBox,
  cxRadioGroup, cxLabel, cxCheckGroup, cxDBCheckGroup,
  
  Gim30Fields,
  
  f_grd;


type
    TRptCpsForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    ArticuloInicialCtrl: TcxDBTextEdit;
    ArticuloFinalCtrl: TcxDBTextEdit;
    AlmacenInicialCtrl: TcxDBTextEdit;
    AlmacenFinalCtrl: TcxDBTextEdit;
    Shape1: TShape;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
    DataAlmacenInicial: TWideStringField;
    DataAlmacenFinal: TWideStringField;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox3: TgxRangeBox;
    gxRangeBox4: TgxRangeBox;
    FechaEntregaCtrl: TcxDBCheckBox;
    DesglosarCtrl: TcxDBCheckBox;
    DataFechaEntrega: TBooleanField;
    DataDesglosar: TBooleanField;
    DataAgrupacion: TSmallintField;
    AgrupacionCtrl: TcxDBRadioGroup;
    Label3: TcxLabel;
    Label6: TcxLabel;
    Label1: TcxLabel;
    Label5: TcxLabel;
    Label16: TcxLabel;
    Label2: TcxLabel;
    Label4: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Report: TgxReportManager;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    ParametrosGroupBox: TcxGroupBox;
    ParametrosCtrl: TcxDBCheckGroup;
    DataParametros: TIntegerField;
    cxGroupBox1: TcxGroupBox;
    TransportistaGroupBox: TcxGroupBox;
    cxGroupBox3: TcxGroupBox;
    gxRangeBox5: TgxRangeBox;
    TransportistaInicialCtrl: TcxDBTextEdit;
    TransportistaFinalCtrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    DataTransportistaInicial: TStringField;
    DataTransportistaFinal: TStringField;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure AlmacenCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TransportistaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TransportistaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure DesglosarCtrlPropertiesChange(Sender: TObject);
    procedure AgrupacionCtrlPropertiesChange(Sender: TObject);
    private

      FormHeight : SmallInt;

      procedure UpdateReportList;

    public
      CarteraArticulosTable : TnxeTable;
      CarteraArticulosFields : TCarteraArticulosFields;

      procedure AjustaAlturaVentana;

    end;

var  RptCpsForm: TRptCpsForm = nil;

procedure ListadoPendienteServir;


implementation

uses   SysUtils,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gim10Fields,

       dm_sto,
       dm_cls,
       dm_cli,
       dm_art,
       dm_mov,
       dm_fdv,
       dm_alm,
       dm_tra,

       b_msg,

       cx_art,
       cx_cli,
       cx_alm,
       cx_tra,

       q_cps,
       m_cps;

{$R *.DFM}

procedure ListadoPendienteServir;
begin
     CreateReportForm( TRptCpsForm, RptCpsForm );
end;

procedure TRptCpsForm.InitializeForm;

var  RadioGroupItem : TcxRadioGroupItem;

begin

     ID := idRptCpsForm;

     FormHeight := Height;

     With DataModule00.DmEmpresaFields do
       begin
       AlmacenInicialCtrl.Enabled := Stock_MultiAlmacen.Value;
       AlmacenFinalCtrl.Enabled := Stock_MultiAlmacen.Value;
       end;

     DataClienteFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataFechaEntrega.Value := False;
     DataDesglosar.Value := False;
     DataAgrupacion.Value := 0;
     DataArticuloFinal.Value := HighStrCode;
     DataAlmacenFinal.Value := HighStrCode;
     DataTransportistaFinal.Value := HighStrCode;

     TransportistaGroupBox.Visible := DataModule00.DmEmpresaFields.Ventas_Transportista.Value;
     ParametrosGroupBox.Visible := False;  // Se activa desde el módulo correspondiente

     If   TransportistaGroupBox.Visible
     then With AgrupacionCtrl do
            begin
            RadioGroupItem := AgrupacionCtrl.Properties.Items.Add;
            RadioGroupItem.Caption := 'transportista';
            RadioGroupItem.Value := 2;
            Properties.Columns := 3;
            Width := 300;
            end;

     AjustaAlturaVentana;
end;

procedure TRptCpsForm.TransportistaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Transportista.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCpsForm.AgrupacionCtrlPropertiesChange(Sender: TObject);
begin
     UpdateReportList;
end;

procedure TRptCpsForm.AjustaAlturaVentana;
begin
     Height := FormHeight;
     If   not TransportistaGroupBox.Visible
     then Height := Height - TransportistaGroupBox.Height;
     If   not ParametrosGroupBox.Visible
     then Height := Height - ParametrosGroupBox.Height;
end;

procedure TRptCpsForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptCpsForm.ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptCpsForm.TransportistaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTransportistas( Sender );
end;

procedure TRptCpsForm.DesglosarCtrlPropertiesChange(Sender: TObject);
begin
     AgrupacionCtrl.Enabled := DesglosarCtrl.Checked;
     FormManager.ShowQueryOption := DesglosarCtrl.Checked;
     UpdateReportList;
end;

procedure TRptCpsForm.UpdateReportList;
begin
     With Report do
       begin
       If   DesglosarCtrl.Checked
       then FileName := 'dm30\l_cps' + IntToStr( AgrupacionCtrl.ItemIndex + 1 )
       else FileName := 'dm30\l_cps0';
       UpdateReportList;
       end;
end;

procedure TRptCpsForm.FormManagerOkButton;

var  CpsQueryModule : TCpsQueryModule;

begin
     CpsQueryModule := VistaPendienteServir( Data );
     If   FormManager.GridOutputField.Value
     then RejillaPendienteServir( CpsQueryModule )
     else With Report do
            try

              Load( CpsQueryModule );

              Clase.SetReportTitles( Report, 4 );
              FacturaVentas.FijaDecimalesInforme( Report );

              Start;
            except on E : Exception do Cancel( E );
              end;

end;

procedure TRptCpsForm.AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TRptCpsForm.AlmacenCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scVentas, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCpsForm.ArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scVentas, False, Sender );
end;

procedure TRptCpsForm.ArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

end.
