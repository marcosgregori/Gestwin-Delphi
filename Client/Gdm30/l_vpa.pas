unit l_vpa;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,

  Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, ReportManager, cxGraphics, cxSpinEdit, cxDBEdit, cxMaskEdit,
  cxDropDownEdit, cxIndexedComboBox, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxPC,

  cxGroupBox, cxRadioGroup, cxCheckBox, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels, cxLabel,
  cxPCdxBarPopupMenu, dxBarBuiltInMenu,

  Gim10Fields,
  Gim30Fields;


type
    TRptVpaForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    SerieCtrl: TcxDBTextEdit;
    PeriodicidadCtrl: TcxDBIndexedComboBox;
    MesPagoInicialCtrl: TcxDBSpinEdit;
    MesPagoFinalCtrl: TcxDBSpinEdit;
    Data: TgxMemData;
    DataSerie: TWideStringField;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataPeriodicidad: TSmallintField;
    DataMesPagoInicial: TSmallintField;
    DataMesPagoFinal: TSmallintField;
    gxRangeBox3: TgxRangeBox;
    SeleccionSerieCtrl: TcxDBRadioGroup;
    DataSeleccionSerie: TSmallintField;
    ValorarCtrl: TcxDBCheckBox;
    DataValorar: TBooleanField;
    Label19: TcxLabel;
    Label20: TcxLabel;
    Label3: TcxLabel;
    Label7: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
    gxRangeBox4: TgxRangeBox;
    ArticuloInicialCtrl: TcxDBTextEdit;
    ArticuloFinalCtrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxDBCheckBox1: TcxDBCheckBox;
    DataLineasSinCodificar: TBooleanField;
    gxRangeBox1: TgxRangeBox;
    CodigoClienteInicialCtrl: TcxDBTextEdit;
    CodigoClienteFinalCtrl: TcxDBTextEdit;
    Label1: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    cxLabel6: TcxLabel;
    AgruparCtrl: TcxDBRadioGroup;
    DataAgrupar: TSmallintField;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure MesPagoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SeleccionSerieCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure PeriodicidadCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerPreparedForm;
    procedure CodigoClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClienteCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    private

      ArticuloFields : TArticuloFields;

    public

    end;

var RptVpaForm: TrptVpaForm;

procedure ListadoVentasPeriodicasArticulo;


implementation

uses   LibUtils,

       nxsdDataDictionaryStrings,

       Gim00Fields,

       dmi_mov,

       dm_cls,
       dm_sdf,
       dm_fdv,
       dm_cli,
       dm_art,
       dm_mov,

       cx_sdf,
       cx_cli,
       cx_vpe,
       cx_art,

       m_vpa,
       q_vpa;

{$R *.DFM}

procedure ListadoVentasPeriodicasArticulo;
begin
     CreateReportForm( TrptVpaForm, RptVpaForm );
end;

procedure TRptVpaForm.InitializeForm;
begin

     ArticuloFields := TArticuloFields.Create( Self );

     DataClienteFinal.Value := HighStrCode;
     DataArticuloFinal.Value := HighStrCode;
     DataAgrupar.Value := 0;
     DataSeleccionSerie.Value := 0;
     DataPeriodicidad.Value := 0;
     DataMesPagoInicial.Value := 1;
     DataMesPagoFinal.Value := 12;
     DataValorar.Value := True;

end;

procedure TRptVpaForm.MesPagoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateMonth( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptVpaForm.PeriodicidadCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     MesPagoInicialCtrl.Enabled := PeriodicidadCtrl.ItemIndex<>4;  // Mensual
     MesPagoFinalCtrl.Enabled := MesPagoInicialCtrl.Enabled;
end;

procedure TRptVpaForm.SeleccionSerieCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     SerieCtrl.Enabled := DataSeleccionSerie.Value=1;
end;

procedure TRptVpaForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TRptVpaForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptVpaForm.FormManagerOkButton;

var  VpaQueryModule : TVpaQueryModule;

begin
     VpaQueryModule := VistaVentasPeriodicasArticulo( Data );
     If   FormManager.GridOutputField.Value
     then RejillaVentasPeriodicasArticulo( VpaQueryModule )
     else With Report do
       try
         Load( VpaQueryModule );
         FacturaVentas.FijaDecimalesInforme( Report );
         Clase.SetReportTitles( Report, 4 );
         SetValueControl( PeriodicidadCtrl );
         Start;

       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptVpaForm.FormManagerPreparedForm;
begin
     If   Assigned( FormManager.GridOutputFrame )
     then FormManager.GridOutputFrame.GridOutputCtrl.Width := ValorarCtrl.Width - 7; // por el margen de la caja
end;

procedure TRptVpaForm.ArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TRptVpaForm.ArticuloCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                      var DisplayValue : Variant;
                                                      var ErrorText    : TCaption;
                                                      var Error        : Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptVpaForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptVpaForm.ClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptVpaForm.CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptVpaForm.CodigoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptVpaForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVentasPeriodicas( Sender );
end;

end.


