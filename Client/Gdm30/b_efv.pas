
unit b_efv;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,
     ComCtrls,

     Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxPC, cxCheckBox, cxMaskEdit,
  cxDropDownEdit, cxCalendar, DB, dxmdaset, DataManager,

  dm_fdv, cxSpinEdit, cxCurrencyEdit, nxdb, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox, cxPCdxBarPopupMenu, dxBarBuiltInMenu, dxUIAClasses;

type
    TBoxEfvForm = class(TgxForm)
    FormManager: TgxFormManager;
    Panel1: TgxEditPanel;
    ImprimirCtrl: TcxDBCheckBox;
    PageControl: TgxFilterPageControl;
    ClienteTabSheet: TcxTabSheet;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    GrupoClienteTabSheet: TcxTabSheet;
    GrupoInicialCtrl: TcxDBTextEdit;
    GrupoFinalCtrl: TcxDBTextEdit;
    VendedorTabSheet: TcxTabSheet;
    VendedorInicialCtrl: TcxDBTextEdit;
    VendedorFinalCtrl: TcxDBTextEdit;
    SerieFacturacionCtrl: TcxDBTextEdit;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    FormaCobroTabSheet: TcxTabSheet;
    FormaCobroInicialCtrl: TcxDBTextEdit;
    FormaCobroFinalCtrl: TcxDBTextEdit;
    RegistroAuxiliarTabSheet: TcxTabSheet;
    RegAuxiliarInicialCtrl: TcxDBTextEdit;
    RegAuxiliarFinalCtrl: TcxDBTextEdit;
    CodigoClienteCtrl: TcxDBTextEdit;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox3: TgxRangeBox;
    gxRangeBox4: TgxRangeBox;
    gxRangeBox5: TgxRangeBox;
    gxRangeBox6: TgxRangeBox;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataSerieFacturacion: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataGrupoInicial: TWideStringField;
    DataGrupoFinal: TWideStringField;
    DataVendedorInicial: TWideStringField;
    DataVendedorFinal: TWideStringField;
    DataFormaCobroInicial: TWideStringField;
    DataFormaCobroFinal: TWideStringField;
    DataCodigoCliente: TWideStringField;
    DataRegAuxiliarInicial: TWideStringField;
    DataRegAuxiliarFinal: TWideStringField;
    DataPrimerNroFactura: TIntegerField;
    gxRangeBox7: TgxRangeBox;
    NroFacturaInicialCtrl: TcxDBTextEdit;
    DesglosarRegAuxiliarCtrl: TcxDBCheckBox;
    DataDesglosarRegAuxiliar: TBooleanField;
    FechaFacturacionCtrl: TcxDBDateEdit;
    DataFechaFacturacion: TDateField;
    DataImporteMinimo: TBCDField;
    DataImprimir: TBooleanField;
    ImporteMinimoCtrl: TcxDBCurrencyEdit;
    RelacionAlbaranesTable: TnxeTable;
    Label5: TcxLabel;
    Label19: TcxLabel;
    Label20: TcxLabel;
    Label9: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label4: TcxLabel;
    Label3: TcxLabel;
    Label6: TcxLabel;
    Label12: TcxLabel;
    Label11: TcxLabel;
    Label13: TcxLabel;
    Label16: TcxLabel;
    Label15: TcxLabel;
    Label21: TcxLabel;
    Label22: TcxLabel;
    Label14: TcxLabel;
    Label23: TcxLabel;
    Label24: TcxLabel;
    Label7: TcxLabel;
    Label17: TcxLabel;
    Label18: TcxLabel;
    Label25: TcxLabel;
    Label26: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    UnaFacturaPorAlbaranCtrl: TcxDBCheckBox;
    DataUnaFacturaPorAlbaran: TBooleanField;
    function FormManagerGetAccessLevel: Smallint;
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroFacturaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure DataNewRecord(DataSet: TDataSet);
    procedure CodigoClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure RegAuxiliarCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure RegAuxiliarCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormaCobroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormaCobroCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure VendedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GrupoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GrupolCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SerieFacturacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SerieFacturacionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure FechaFacturacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SerieFacturacionCtrlPropertiesValuePosted(Sender: TObject);
    procedure PageControlCheckBoxClick(Sender: TObject);
    private
      procedure ActualizaEstadoSeleccion;
    public
      procedure DoProcess;
    end;

var BoxEfvForm: TBoxEfvForm = nil;

procedure EmisionFacturasVenta;


implementation

uses   Variants,
       SysUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,

       ParametrosFacturacionIntf,

       dmi_pga,

       dm_ast,
       dm_pga,
       dm_usr,
       dm_ine,
       dm_sdf,
       dm_cli,
       dm_gdc,
       dm_ven,
       dm_fco,
       dm_rac,

       a_imp,

       b_msg,
       b_pro,

       cx_cli,
       cx_fdv,
       cx_imp,
       cx_gdc,
       cx_ven,
       cx_sdf,
       cx_fco,
       cx_rac,

       r_fdv;

{$R *.DFM}

resourceString
       RsMsg1  = 'Desglosar por ';

procedure EmisionFacturasVenta;
begin
     CreateEditForm( TBoxEfvForm, BoxEfvForm );
end;

procedure TBoxEfvForm.FormManagerOkButton;
begin
     CreateProcessForm( DoProcess, Caption );
end;

procedure TBoxEfvForm.FormManagerInitializeForm;
begin
     GrupoClienteTabSheet.TabVisible := DataModule00.DmEmpresaFields.Cliente_GruposFac.Value;
     RegistroAuxiliarTabSheet.TabVisible := DataModule00.DmEmpresaFields.Cliente_RegAuxiliar.Value;
     RegistroAuxiliarTabSheet.Caption := NombreAuxiliarCliente( True, False );
     DesglosarRegAuxiliarCtrl.Caption := RsMsg1 + NombreAuxiliarCliente;
     SetEditControlDecimals( ImporteMinimoCtrl );

     Asiento.CompruebaEjercicioCerrado;
end;

procedure TBoxEfvForm.DoProcess;

var   ParametrosFacturacion : IParametrosFacturacion;

begin

     ParametrosFacturacion := TParametrosFacturacion.Create;

      With ParametrosFacturacion do
        begin

        TipoSeleccion := tsFecha;
        Serie := DataSerieFacturacion.Value;
        FechaInicial := DataFechaInicial.Value;
        FechaFinal := DataFechaFinal.Value;
        FechaFacturacion := DataFechaFacturacion.Value;
        PrimerNroFactura := DataPrimerNroFactura.Value;
        ImporteMinimo := DataImporteMinimo.Value;
        PropietarioInicial := DataClienteInicial.Value;
        PropietarioFinal := DataClienteFinal.Value;
        GrupoPropietarioInicial := DataGrupoInicial.Value;
        GrupoPropietarioFinal := DataGrupoFinal.Value;
        VendedorInicial := DataVendedorInicial.Value;
        VendedorFinal := DataVendedorFinal.Value;
        FormaCobroInicial := DataFormaCobroInicial.Value;
        FormaCobroFinal := DataFormaCobroFinal.Value;
        CodigoPropietario := DataCodigoCliente.Value;
        RegAuxiliarInicial := DataRegAuxiliarInicial.Value;
        RegAuxiliarFinal := DataRegAuxiliarFinal.Value;
        DesglosarRegAuxilar := DataDesglosarRegAuxiliar.Value;
        UnaFacturaPorAlbaran := DataUnaFacturaPorAlbaran.Value;

        SeleccionPropietario := ObtenSeleccionFilterPageControl( PageControl, ClienteTabSheet );
        SeleccionGrupoPropietario := ObtenSeleccionFilterPageControl( PageControl, GrupoClienteTabSheet );
        SeleccionVendedor := ObtenSeleccionFilterPageControl( PageControl, VendedorTabSheet );
        SeleccionFormaCobro := ObtenSeleccionFilterPageControl( PageControl, FormaCobroTabSheet );
        SeleccionRegAuxiliar := ObtenSeleccionFilterPageControl( PageControl, RegistroAuxiliarTabSheet );

        ParametrosFacturacion := FacturaVentas.GeneraFacturas( ParametrosFacturacion, RelacionAlbaranesTable );

        If   DataImprimir.Value and ( NroFacturaInicial<>0 )
        then ImpresionFacturasVenta( ApplicationContainer.Ejercicio, Serie, NroFacturaInicial, NroFacturaFinal, { Impreso } True );

        end;
end;

procedure TBoxEfvForm.GrupoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TBoxEfvForm.GrupolCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TBoxEfvForm.NroFacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFacturasVenta( DataSerieFacturacion, Sender );
end;

procedure TBoxEfvForm.ActualizaEstadoSeleccion;
begin
     ClienteTabSheet.Enabled := not ( RegistroAuxiliarTabSheet.Highlighted and ( CodigoClienteCtrl.Text<>'' ) );
     If   not ClienteTabSheet.Enabled
     then ClienteTabSheet.Highlighted := False;
end;

procedure TBoxEfvForm.PageControlCheckBoxClick(Sender: TObject);
begin
     ActualizaEstadoSeleccion;
end;

procedure TBoxEfvForm.RegAuxiliarCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAuxiliarClientes( Sender, CodigoClienteCtrl.EditValue );
end;

procedure TBoxEfvForm.RegAuxiliarCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     AuxiliarCliente.Valida( DataCodigoCliente.Value, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TBoxEfvForm.SerieFacturacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxEfvForm.SerieFacturacionCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxEfvForm.SerieFacturacionCtrlPropertiesValuePosted(Sender: TObject);
begin
     DataPrimerNroFactura.value := FacturaVentas.ProximoNroFactura( DataSerieFacturacion.Value, False );  // Se toma el valor pero no se registra
end;

procedure TBoxEfvForm.VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TBoxEfvForm.VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TBoxEfvForm.FechaFacturacionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TBoxEfvForm.FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

procedure TBoxEfvForm.FormaCobroCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

function TBoxEfvForm.FormManagerGetAccessLevel: Smallint;
begin
     If   ProgramNumber=pnTPV
     then Result := DataModule00.DmUsuarioFields.acCaProcesos.Value
     else Result := Ord( alAllowed );
end;

procedure TBoxEfvForm.ClienteCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TBoxEfvForm.ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TBoxEfvForm.CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TBoxEfvForm.CodigoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then CodigoClienteCtrl.Description := rsgMsgTodos
     else Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
     ActualizaEstadoSeleccion;
end;

procedure TBoxEfvForm.DataNewRecord(DataSet: TDataSet);
begin
     DataPrimerNroFactura.Value := FacturaVentas.ProximoNroFactura( '', False );

     DataClienteInicial.Value := ZeroStrCode;
     DataClienteFinal.Value := HighStrCode;

     DataGrupoFinal.Value := HighStrCode;

     DataVendedorInicial.Value := ZeroStrCode;
     DataVendedorFinal.Value := HighStrCode;

     DataFormaCobroInicial.Value := ZeroStrCode;
     DataFormaCobroFinal.Value := HighStrCode;

     DataRegAuxiliarFinal.Value := HighStrCode;

     DataFechaInicial.Value := ApplicationContainer.FirstDayOfYearDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;

     DataFechaFacturacion.Value := ApplicationContainer.TodayDate;
end;

end.

