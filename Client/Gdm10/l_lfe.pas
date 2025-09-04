
unit l_lfe;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,

  Mask,
  ComCtrls,

  dm_sal,
  ReportManager,
  DataManager,
  EnterpriseDataAccess,
  DB,
  nxdb, Menus, cxLookAndFeelPainters, cxButtons, cxGraphics,
  cxDropDownEdit, cxDBEdit, cxCheckBox, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxCalendar, dxmdaset, cxIndexedComboBox, cxSpinEdit,

  Gim00Fields,
  Gim10Fields, dxSkinsCore, dxSkinsDefaultPainters, cxLookAndFeels, cxLabel,
  cxGroupBox;


type
    TRptLfeForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    SoloTablaCtrl: TcxDBCheckBox;
    TipoIVACtrl: TcxDBSpinEdit;
    PorTipoIVACtrl: TcxDBCheckBox;
    TipoRetencionCtrl: TcxDBSpinEdit;
    PorRetencionCtrl: TcxDBCheckBox;
    Data: TgxMemData;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataSource: TDataSource;
    DataSoloTablaResumen: TBooleanField;
    DataPorTipoIVA: TBooleanField;
    DataPorTipoRetencion: TBooleanField;
    DataTipoIVA: TSmallintField;
    DataTipoRetencion: TSmallintField;
    gxRangeBox1: TgxRangeBox;
    DataSerieInicial: TWideStringField;
    DataSerieFinal: TWideStringField;
    gxRangeBox2: TgxRangeBox;
    SerieInicialCtrl: TcxDBTextEdit;
    SerieFinalCtrl: TcxDBTextEdit;
    DataLibroEspecial: TBooleanField;
    LibroEspecialCtrl: TcxDBCheckBox;
    Label4: TcxLabel;
    descTipoIVALabel: TcxLabel;
    descRetencionLabel: TcxLabel;
    Label1: TcxLabel;
    Label5: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DescSerieInicialLabel: TcxLabel;
    DescSerieFinalLabel: TcxLabel;
    LibroRegistroCtrl: TcxDBIndexedComboBox;
    Label2: TcxLabel;
    DataLibroRegistro: TSmallintField;
    procedure FormManagerOkButton;
    procedure PorTipoIVACtrlPropertiesEditValueChanged(Sender: TObject);
    procedure PorRetencionCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure TipoIVACtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure TipoIVACtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TipoRetencionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TipoRetencionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerInitializeForm;
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieFinalCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    private

    public

      DiarioTable : TnxeTable;
      DiarioFields : TDiarioFacturacionFields;

    end;

var RptLfeForm : TRptLfeForm = nil;

procedure LibroRegistroVentas;

implementation

uses   nxsdDataDictionary,
       nxsdTypes,

       Gdm10Dm,
       Gdm00Dm,

       dmi_iva,
       dmi_ast,
       dmi_fac,

       dm_ast,
       dm_fac,
       dm_pga,
       dm_tas,
       dm_sub,
       dm_iva,
       dm_cli,
       dm_sdf,

       b_msg,

       cx_iva,
       cx_ret,
       cx_sdf;

{$R *.DFM}

resourceString
       RsMsg2 = 'Libro registro de ';

procedure LibroRegistroVentas;
begin
     CreateReportForm( TrptLfeForm, rptLfeForm );
end;

procedure TRptLfeForm.FormManagerInitializeForm;
begin
     DataSerieFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     If   DataFechaInicial.Value<ApplicationContainer.FirstDayOfYearDate
     then DataFechaInicial.Value := ApplicationContainer.FirstDayOfYearDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
end;

procedure TRptLfeForm.FormManagerOkButton;

var   LibrosRegistro : TLibrosRegistro;
      AcumuladoFacturacion : IAcumuladoFacturacion;

begin
     Enabled := False;

     With Report do
       try

         Load;

         If   not DataLibroEspecial.Value
         then Title  := RsMsg2 + LibroRegistroCtrl.Text;

         DiarioTable := CreateEmptyTable( 'Diario', DataModule10.GetSQL( 'DiarioFacturacion' ), tsServerSide );  // Se crea en el servidor
         DiarioFields := TDiarioFacturacionFields.Create( DiarioTable );

         // Le asigno la misma tabla a la página que muestra el resumen

         AssignTable( 'DiarioResumen', DiarioTable );
         AssignTable( 'DiarioResumenCaja', DiarioTable );

         If   DataLibroEspecial.Value
         then LibrosRegistro := [ lrEspecial ]
         else case DataLibroRegistro.Value of
                0 : LibrosRegistro := [ lrFrasExpedidas, lrEntregasIntracomunitarias ];
                1 : LibrosRegistro := [ lrEntregasIntracomunitarias ];
                end;

         AcumuladoFacturacion := Factura.SeleccionaRegistrosFrasExpedidas( DiarioTable.TableName,
                                                                           False,  // No es la declaración informativa, es un listado
                                                                           LibrosRegistro,
                                                                           DataSerieInicial.Value,
                                                                           DataSerieFinal.Value,
                                                                           DataFechaInicial.Value,
                                                                           DataFechaFinal.Value,
                                                                           DataPorTipoIVA.Value,
                                                                           DataTipoIVA.Value,
                                                                           DataPorTipoRetencion.Value,
                                                                           DataTipoRetencion.Value,
                                                                           DataSoloTablaResumen.Value );

         SetValue( 'DescTipoIVA', Tasa.DescripcionTasa( DataTipoIVA.Value, '', siRepercutido, DataFechaInicial.Value ) );
         SetValue( 'DescTipoRetencion', Tasa.DescripcionRetencion( DataFechaInicial.Value, DataTipoRetencion.Value ) );
         SetValue( RsCriterioCaja, DataModule00.DmEmpresaFields.RegimenEspecialCriterioCaja.Value );
         SetValue( RsVentasOnline, DataModule00.DmEmpresaFields.Contable_VentasOnlineIntracomunitarias.Value );

         DiarioTable.IndexFieldNames := 'Serie;Fecha;NroRegistro';

         Start;

       except on E : Exception do Cancel( E );
         end;

end;

procedure TRptLfeForm.PorRetencionCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     TipoRetencionCtrl.Enabled  := DataPorTipoRetencion.Value;
end;

procedure TRptLfeForm.PorTipoIVACtrlPropertiesEditValueChanged(Sender: TObject);
begin
     TipoIVACtrl.Enabled := DataPorTipoIVA.Value;
end;

procedure TRptLfeForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TRptLfeForm.SerieFinalCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptLfeForm.TipoIVACtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposIVA( Sender, siRepercutido, ApplicationContainer.TodayDate );
end;

procedure TRptLfeForm.TipoIVACtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Tasa.ValidaTasa( Sender, DisplayValue, ErrorText, Error, siRepercutido, ApplicationContainer.TodayDate );
end;

procedure TRptLfeForm.TipoRetencionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRetenciones( ApplicationContainer.TodayDate, Sender );
end;

procedure TRptLfeForm.TipoRetencionCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Tasa.ValidaRetencion( ApplicationContainer.TodayDate, Sender, DisplayValue, ErrorText, Error );
end;

end.

