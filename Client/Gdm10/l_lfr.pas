
unit l_lfr;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  LibUtils,

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

  dxSkinsCore, dxSkinsDefaultPainters, cxLookAndFeels, cxLabel,
  cxGroupBox,

  Gim00Fields,
  Gim10Fields, AppContainer;


type
    TRptLfrForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    SoloTablaCtrl: TcxDBCheckBox;
    PrimerNroOrdenCtrl: TcxDBSpinEdit;
    TipoIVACtrl: TcxDBSpinEdit;
    PorTipoIVACtrl: TcxDBCheckBox;
    TipoRetencionCtrl: TcxDBSpinEdit;
    PorRetencionCtrl: TcxDBCheckBox;
    LibroRegistroCtrl: TcxDBIndexedComboBox;
    AsientoTable: TnxeTable;
    ApunteTable: TnxeTable;
    Data: TgxMemData;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataSource: TDataSource;
    DataSoloTablaResumen: TBooleanField;
    DataPrimerNroOrden: TIntegerField;
    DataPorTipoIVA: TBooleanField;
    DataPorTipoRetencion: TBooleanField;
    DataTipoIVA: TSmallintField;
    DataTipoRetencion: TSmallintField;
    DataLibroRegistro: TSmallintField;
    gxRangeBox1: TgxRangeBox;
    DataOrdenarPorRegistro: TBooleanField;
    OrdenarPorRegistroCtrl: TcxDBCheckBox;
    LibroEspecialCtrl: TcxDBCheckBox;
    DataLibroEspecial: TBooleanField;
    Label4: TcxLabel;
    Label1: TcxLabel;
    descTipoIVALabel: TcxLabel;
    descRetencionLabel: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    DescNroOrdenLabel: TcxLabel;
    Label5: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    AgruparPorAcreedorCtrl: TcxDBCheckBox;
    DataAgruparPorAcreedor: TBooleanField;
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
    procedure PrimerNroOrdenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure LibroEspecialCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure OrdenarPorRegistroCtrlPropertiesEditValueChanged(
      Sender: TObject);
    private

    public

      DiarioTable : TnxeTable;
      DiarioFields : TDiarioFacturacionFields;

    end;

var RptLfrForm : TRptLfrForm = nil;

procedure libroRegistroCompras;               

implementation

uses   nxsdDataDictionary,
       nxsdTypes,

       Gdm00Dm,
       Gdm10Dm,

       dmi_iva,
       dmi_fac,
       dmi_ast,

       dm_ast,
       dm_fac,
       dm_pga,
       dm_tas,
       dm_sub,
       dm_iva,
       dm_pro,

       b_msg,

       cx_iva,
       cx_ret;

{$R *.DFM}

resourceString
       RsMsg2 = 'Libro registro de ';
       RsMsg3 = 'El nº de registro de la factura.';
       RsMsg4 = 'Números correlativos a partir del indicado.';

procedure libroRegistroCompras;
begin
     CreateReportForm( TrptLfrForm, RptLfrForm );
end;

procedure TRptLfrForm.FormManagerInitializeForm;
begin
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     If   DataFechaInicial.Value<ApplicationContainer.FirstDayOfYearDate
     then DataFechaInicial.Value := ApplicationContainer.FirstDayOfYearDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataLibroRegistro.Value := 0;
     DataPrimerNroOrden.Value := 0;
end;

procedure TRptLfrForm.FormManagerOkButton;

var  LibrosRegistro : TLibrosRegistro;
     ExisteRegistroCriterioCaja : Boolean;
     AcumuladoFacturacion : IAcumuladoFacturacion;

begin
     Enabled := False;

     With Report do
       try

         Load;

         If   not DataLibroEspecial.Value
         then Title  := RsMsg2 + LibroRegistroCtrl.Text;

         DiarioTable := CreateEmptyTable( 'Diario', DataModule10.GetSQL( 'DiarioFacturacion' ), tsServerSide );
         DiarioFields := TDiarioFacturacionFields.Create( DiarioTable );

         // Le asigno la misma tabla a la página que muestra el resumen

         AssignTable( 'DiarioResumen', DiarioTable );
         AssignTable( 'DiarioResumenCaja', DiarioTable );

         If   DataLibroEspecial.Value
         then LibrosRegistro := [ lrEspecial ]
         else case DataLibroRegistro.Value of
                0 : LibrosRegistro := [ lrFrasRecibidas, lrBienesInversion ];
                1 : LibrosRegistro := [ lrFrasRecibidas ];
                2 : LibrosRegistro := [ lrBienesInversion ];
                3 : LibrosRegistro := [ lrAdquisicionesIntracomunitarias ];
                4 : LibrosRegistro := [ lrRegimenEspecial ];
                5 : LibrosRegistro := [ lrInversionSujetoPasivo ];
                end;

         AcumuladoFacturacion := Factura.SeleccionaRegistrosFrasRecibidas( DiarioTable.TableName,
                                                                           False,  // No es la declaración informativa, es un listado
                                                                           LibrosRegistro,
                                                                           DataFechaInicial.Value,
                                                                           DataFechaFinal.Value,
                                                                           DataPrimerNroOrden.Value,
                                                                           DataPorTipoIVA.Value,
                                                                           DataTipoIVA.Value,
                                                                           DataPorTipoRetencion.Value,
                                                                           DataTipoRetencion.Value,
                                                                           DataSoloTablaResumen.Value );

         ExisteRegistroCriterioCaja := AcumuladoFacturacion.ExisteRegistroCriterioCaja;

         If   DataOrdenarPorRegistro.Value
         then DiarioTable.IndexFieldNames := 'NroRegistro;Fecha'
         else If   DataAgruparPorAcreedor.Value
              then DiarioTable.IndexFieldNames := 'Propietario;Fecha;NroRegistro'
              else DiarioTable.IndexFieldNames := 'Fecha;NroRegistro';

         SetValue( 'DescTipoIVA', Tasa.DescripcionTasa( DataTipoIVA.Value, '', siRepercutido, DataFechaInicial.Value ) );
         SetValue( 'DescTipoRetencion', Tasa.DescripcionRetencion( DataFechaInicial.Value, DataTipoRetencion.Value ) );
         SetValue( RsCriterioCaja, DataModule00.DmEmpresaFields.RegimenEspecialCriterioCaja.Value or ExisteRegistroCriterioCaja );

         SetValueField( DataSoloTablaResumen );

         Start;

       except on E : Exception do Cancel( E );
         end;

end;

procedure TRptLfrForm.LibroEspecialCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     LibroRegistroCtrl.Enabled := not LibroEspecialCtrl.Checked;
end;

procedure TRptLfrForm.OrdenarPorRegistroCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     AgruparPorAcreedorCtrl.Enabled := not OrdenarPorRegistroCtrl.Checked;
     If   not AgruparPorAcreedorCtrl.Enabled
     then AgruparPorAcreedorCtrl.Checked := False;
end;

procedure TRptLfrForm.PorRetencionCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     TipoRetencionCtrl.Enabled  := DataPorTipoRetencion.Value;
end;

procedure TRptLfrForm.PorTipoIVACtrlPropertiesEditValueChanged(Sender: TObject);
begin
     TipoIVACtrl.Enabled := DataPorTipoIVA.Value;
end;

procedure TRptLfrForm.PrimerNroOrdenCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     With PrimerNroOrdenCtrl do
       If   VarToInteger( DisplayValue )=0
       then Description := RsMsg3
       else Description := RsMsg4;
end;

procedure TRptLfrForm.TipoIVACtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposIVA( Sender, siRepercutido, ApplicationContainer.TodayDate );
end;

procedure TRptLfrForm.TipoIVACtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Tasa.ValidaTasa( Sender, DisplayValue, ErrorText, Error, siRepercutido, ApplicationContainer.TodayDate );
end;

procedure TRptLfrForm.TipoRetencionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRetenciones( ApplicationContainer.TodayDate, Sender );
end;

procedure TRptLfrForm.TipoRetencionCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Tasa.ValidaRetencion( ApplicationContainer.TodayDate, Sender, DisplayValue, ErrorText, Error );
end;

end.

