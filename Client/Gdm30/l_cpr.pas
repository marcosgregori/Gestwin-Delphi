
unit l_cpr;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     LibUtils,
     AppContainer,

     ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
  DataManager, dxmdaset, ReportManager, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit,

  Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, cxCheckBox, cxGraphics,
  cxLookAndFeels, cxLabel, f_grd, cxGroupBox, cxRadioGroup;


type
    TRptCprForm = class(TgxForm)
    FormManager: TgxFormManager;
    MovimientoTable: TnxeTable;
    LineaMovimientoTable: TnxeTable;
    DataPanel: TgxEditPanel;
    ProveedorInicialCtrl: TcxDBTextEdit;
    ProveedorFinalCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    ArticuloInicialCtrl: TcxDBTextEdit;
    ArticuloFinalCtrl: TcxDBTextEdit;
    AlmacenInicialCtrl: TcxDBTextEdit;
    AlmacenFinalCtrl: TcxDBTextEdit;
    Bevel1: TShape;
    Report: TgxReportManager;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataProveedorInicial: TWideStringField;
    DataProveedorFinal: TWideStringField;
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
    DataDesglosar: TBooleanField;
    DesglosarCtrl: TcxDBCheckBox;
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
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    FechaEntregaCtrl: TcxDBCheckBox;
    DataFechaEntrega: TBooleanField;
    Label10: TcxLabel;
    AgrupacionCtrl: TcxDBRadioGroup;
    DataAgrupacion: TSmallintField;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
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
    procedure DesglosarCtrlPropertiesChange(Sender: TObject);
    procedure AgrupacionCtrlPropertiesChange(Sender: TObject);
    private
    procedure UpdateReportList;

    public
      MovimientoFields : TMovimientoFields;
      LineaMovimientoFields : TLineaMovimientoFields;
      CarteraArticulosTable : TnxeTable;
      CarteraArticulosFields : TCarteraArticulosFields;
      Pendiente : Decimal;
    end;

var  RptCprForm: TRptCprForm = nil;

procedure ConsultaPendienteRecibir;


implementation

uses   SysUtils,

       Gdm00Dm,
       Gim00Fields,
       Gim10Fields,

       dm_sto,
       dm_cls,
       dm_pro,
       dm_art,
       dm_mov,
       dm_fdc,
       dm_alm,

       b_msg,

       cx_art,
       cx_pro,
       cx_alm,

       q_cpr,
       m_cpr;

{$R *.DFM}

procedure ConsultaPendienteRecibir;
begin
     CreateReportForm( TRptCprForm, RptCprForm );
end;

procedure TRptCprForm.InitializeForm;
begin
     
     With DataModule00.DmEmpresaFields do
       begin
       AlmacenInicialCtrl.Enabled := Stock_MultiAlmacen.Value;
       AlmacenFinalCtrl.Enabled := Stock_MultiAlmacen.Value;
       end;

     DataProveedorFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataArticuloFinal.Value := HighStrCode;
     DataAlmacenFinal.Value := HighStrCode;
     DataDesglosar.Value := False;
     DataAgrupacion.Value := 0;

end;

procedure TRptCprForm.ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TRptCprForm.ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptCprForm.FormManagerOkButton;

var  CprQueryModule : TCprQueryModule;

begin
     CprQueryModule := VistaPendienteRecibir( Data );
     If   FormManager.GridOutputField.Value
     then RejillaPendienteRecibir( CprQueryModule )
     else With Report do
            try
              Load( CprQueryModule );

              Clase.SetReportTitles( Report, 4 );
              FacturaCompras.FijaDecimalesInforme( Report );

              Start;
            except on E : Exception do Cancel( E );
              end;
end;

procedure TRptCprForm.AgrupacionCtrlPropertiesChange(Sender: TObject);
begin
     UpdateReportList;
end;

procedure TRptCprForm.AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TRptCprForm.AlmacenCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scCompras, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCprForm.ArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scCompras, False, Sender );
end;

procedure TRptCprForm.ArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptCprForm.DesglosarCtrlPropertiesChange(Sender: TObject);
begin
     AgrupacionCtrl.Enabled := DesglosarCtrl.Checked;
     FormManager.ShowQueryOption := DesglosarCtrl.Checked;
     UpdateReportList;
end;

procedure TRptCprForm.UpdateReportList;
begin
     With Report do
       begin
       If   DesglosarCtrl.Checked
       then FileName := 'dm30\l_cpr' + IntToStr( AgrupacionCtrl.ItemIndex + 1 )
       else FileName := 'dm30\l_cpr0';
       UpdateReportList;
       end;
end;

end.
