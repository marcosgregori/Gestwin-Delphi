
unit e_fdv;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,
     ComCtrls,

     Menus, cxLookAndFeelPainters, cxButtons, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxPC, cxCheckBox, cxMaskEdit,
     cxDropDownEdit, cxCalendar, DB, dxmdaset, DataManager,

     cxSpinEdit, nxdb,

     ReportManager, dxSkinsCore, dxSkinsDefaultPainters,
     dxSkinscxPCPainter, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox,
     cxPCdxBarPopupMenu, dxBarBuiltInMenu,

     Gim10Fields,
     Gim30Fields,

     dm_fdv;

type
    TEtqFdvForm = class(TgxForm)
    FormManager: TgxFormManager;
    Panel1: TgxEditPanel;
    PageControl: TcxPageControl;
    NroFacturaTabSheet: TcxTabSheet;
    ClienteTabSheet: TcxTabSheet;
    NroFacturaInicialCtrl: TcxDBTextEdit;
    NroFacturaFinalCtrl: TcxDBTextEdit;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    FormatoCtrl: TcxDBSpinEdit;
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
    ExcluirClientesCorreoCtrl: TcxDBCheckBox;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox3: TgxRangeBox;
    gxRangeBox4: TgxRangeBox;
    gxRangeBox5: TgxRangeBox;
    gxRangeBox6: TgxRangeBox;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataSerie: TWideStringField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataFormato: TSmallintField;
    DataGrupoInicial: TWideStringField;
    DataGrupoFinal: TWideStringField;
    DataVendedorInicial: TWideStringField;
    DataVendedorFinal: TWideStringField;
    DataFormaCobroInicial: TWideStringField;
    DataFormaCobroFinal: TWideStringField;
    DataCodigoCliente: TWideStringField;
    DataRegAuxiliarInicial: TWideStringField;
    DataRegAuxiliarFinal: TWideStringField;
    DataExcluirClientesCorreo: TBooleanField;
    DataNroFacturaInicial: TIntegerField;
    DataNroFacturaFinal: TIntegerField;
    gxRangeBox7: TgxRangeBox;
    NroCopiasCtrl: TcxDBSpinEdit;
    DataNroCopias: TSmallintField;
    FacturaVentasTable: TnxeTable;
    Report: TgxReportManager;
    Label5: TcxLabel;
    Label8: TcxLabel;
    FormatoLabel: TcxLabel;
    Label19: TcxLabel;
    Label20: TcxLabel;
    Label9: TcxLabel;
    Label2: TcxLabel;
    Label1: TcxLabel;
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
    RegistroAuxiliarLabel: TcxLabel;
    Label17: TcxLabel;
    Label18: TcxLabel;
    Label25: TcxLabel;
    Label26: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
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
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure SerieFacturacionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerOkButton;
    procedure PageControlChange(Sender: TObject);
    procedure FormManagerInitializeForm;
    private
      FacturaVentasFields : TFacturaVentasFields;
      ClienteFields : TClienteFields;
      SerieFacturacionFields : TSerieFacturacionFields;

      RptEtiquetaPostalTable : TnxeTable;
      RptEtiquetaPostalFields : TEtiquetaPostalFields;

    public

    end;

var
  EtqFdvForm: TEtqFdvForm = nil;

procedure ImpresionEtiquetasFacturasVenta( Serie             : String;
                                           NroFacturaInicial,
                                           NroFacturaFinal   : LongInt );


implementation

uses   SysUtils,

       Gdm00Dm,
       Gdm30Dm,
       Gim00Fields,

       dm_ine,
       dm_sdf,
       dm_cli,
       dm_gdc,
       dm_ven,
       dm_fco,
       dm_rac,
       dm_pai,
       dm_prv,

       a_imp,

       b_msg,

       cx_cli,
       cx_fdv,
       cx_imp,
       cx_gdc,
       cx_ven,
       cx_sdf,
       cx_fco,
       cx_rac;

{$R *.DFM}

procedure ImpresionEtiquetasFacturasVenta( Serie              : String;
                                           NroFacturaInicial,
                                           NroFacturaFinal    : LongInt );
begin
     CreateReportForm( TEtqFdvForm, EtqFdvForm, [ Serie, NroFacturaInicial, NroFacturaFinal ] );
end;

procedure TEtqFdvForm.FormManagerOkButton;

procedure SeleccionaRegistros;

var  Index : SmallInt;

begin

     try

       With FacturaVentasTable do
         begin

         case PageControl.ActivePageIndex of
           0 : begin
               IndexFieldNames := 'Ejercicio;Serie;NroFactura';
               SetRange( [ ApplicationContainer.Ejercicio, DataSerie.Value, DataNroFacturaInicial.Value ], [ ApplicationContainer.Ejercicio, DataSerie.Value, DataNroFacturaFinal.Value ] );
               end;
           1 : begin
               IndexFieldNames := 'Serie;CodigoCliente;Fecha';
               SetRange( [ DataSerie.Value, DataClienteInicial.Value, DataFechaInicial.Value ], [ DataSerie.Value, DataClienteFinal.Value, DataFechaFinal.Value ] );
               end;
           2 : begin
               IndexFieldNames := 'Serie;GrupoFacturacion;Fecha';
               SetRange( [ DataSerie.Value, DataGrupoInicial.Value, DataFechaInicial.Value ], [ DataSerie.Value, DataGrupoFinal.Value, DataFechaFinal.Value ] );
               end;
           3 : begin
               IndexFieldNames := 'Serie;CodigoVendedor;Fecha';
               SetRange( [ DataSerie.Value, DataVendedorInicial.Value, DataFechaInicial.Value ], [ DataSerie.Value, DataVendedorFinal.Value, DataFechaFinal.Value ] );
               end;
           4 : begin
               IndexFieldNames := 'Serie;FormaCobro;Fecha';
               SetRange( [ DataSerie.Value, DataFormaCobroInicial.Value, DataFechaInicial.Value ], [ DataSerie.Value, DataFormaCobroFinal.Value, DataFechaFinal.Value ] );
               end;
           5 : begin
               IndexFieldNames := 'Serie;RegistroAuxiliar;Fecha';
               SetRange( [ DataSerie.Value, DataRegAuxiliarInicial.Value, DataFechaInicial.Value ], [ DataSerie.Value, DataRegAuxiliarFinal.Value, DataFechaFinal.Value ] );
               end;
           end;

         ApplicationContainer.StartProgression( RecordCount );

         First;
         While not Eof do
           begin

           If   Cliente.Obten( FacturaVentasFields.CodigoCliente.Value, '', ClienteFields )
           then With RptEtiquetaPostalFields, Cliente do
                  If   not ( DataExcluirClientesCorreo.Value and ClienteFields.Factura_EnviarPorCorreo.Value )
                  then For Index := 1 to DataNroCopias.Value do
                         begin

                         RptEtiquetaPostalTable.Append;

                         Codigo.Value := ClienteFields.Codigo.Value;

                         Nombre.Value := ClienteFields.Nombre.Value;
                         Domicilio.Value := ClienteFields.Domicilio.Value;
                         Localidad.Value := ClienteFields.Localidad.Value;
                         CodigoPais.Value := ClienteFields.CodigoPais.Value;
                         NombrePais.Value := Pais.Descripcion( ClienteFields.CodigoPais.Value, True );
                         Cp.Value := ClienteFields.CodigoProvincia.Value + ClienteFields.CodigoPostal.Value;
                         Provincia.Value := dm_prv.Provincia.Descripcion( ClienteFields.CodigoPais.Value, ClienteFields.CodigoProvincia.Value, False );

                         RptEtiquetaPostalTable.Post;

                         ApplicationContainer.ShowProgression;

                         end;

           Next;
           end;

         end;

     finally
       ApplicationContainer.EndProgression;
       end;
end;

begin

     Enabled := False;

     With Report do
       try

         Load;

         RptEtiquetaPostalTable := CreateEmptyTable( 'EtiquetaPostal', DataModule30.SQLSet );
         RptEtiquetaPostalFields := TEtiquetaPostalFields.Create( RptEtiquetaPostalTable );

         SeleccionaRegistros;

         Start;

       except on E : Exception do Cancel( E );
         end;
end;

procedure TEtqFdvForm.GrupoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TEtqFdvForm.GrupolCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TEtqFdvForm.NroFacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFacturasVenta( DataSerie, Sender );
end;

procedure TEtqFdvForm.PageControlChange(Sender: TObject);
begin
     FechaInicialCtrl.Enabled := PageControl.ActivePageIndex<>0;
     FechaFinalCtrl.Enabled := PageControl.ActivePageIndex<>0;
end;

procedure TEtqFdvForm.RegAuxiliarCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAuxiliarClientes( Sender, CodigoClienteCtrl.EditValue );
end;

procedure TEtqFdvForm.RegAuxiliarCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     AuxiliarCliente.Valida( DataCodigoCliente.Value, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TEtqFdvForm.SerieFacturacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TEtqFdvForm.SerieFacturacionCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, SerieFacturacionFields );
     If   ValueIsEmpty( DataFormato.Value ) and not FormManager.ValidatingFormData
     then If   SerieFacturacionFields.FormatoFactura.Value<>0
          then DataFormato.Value := SerieFacturacionFields.FormatoFactura.Value;
end;

procedure TEtqFdvForm.VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TEtqFdvForm.VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TEtqFdvForm.FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

procedure TEtqFdvForm.FormaCobroCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TEtqFdvForm.FormatoCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impFacturasVenta ), Sender.EditingValue ] );
end;

procedure TEtqFdvForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impFacturasVenta, Sender );
end;

procedure TEtqFdvForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impFacturasVenta, Sender, DisplayValue, ErrorText, Error );
end;

procedure TEtqFdvForm.FormManagerInitializeForm;
begin
     With DataModule00.DmEmpresaFields do
       begin
       GrupoClienteTabSheet.TabVisible := Cliente_GruposFac.Value;
       RegistroAuxiliarTabSheet.TabVisible := Cliente_RegAuxiliar.Value;
       RegistroAuxiliarTabSheet.Caption := NombreAuxiliarCliente( True );
       RegistroAuxiliarLabel.Caption := NombreAuxiliarCliente( True );
       end;

     FacturaVentasFields := TFacturaVentasFields.Create( FacturaVentasTable );
     ClienteFields := TClienteFields.Create( Self );
     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );
end;

procedure TEtqFdvForm.ClienteCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TEtqFdvForm.ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TEtqFdvForm.CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TEtqFdvForm.CodigoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then CodigoClienteCtrl.Description := rsgMsgTodos
     else Cliente.valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TEtqFdvForm.DataNewRecord(DataSet: TDataSet);
begin
     DataSerie.Value := FormValues[ 0 ];
     DataNroFacturaInicial.Value := FormValues[ 1 ];
     DataNroFacturaFinal.Value := FormValues[ 1 ];

     DataClienteFinal.Value := HighStrCode;
     DataGrupoFinal.Value := HighStrCode;
     DataVendedorFinal.Value := HighStrCode;
     DataFormaCobroFinal.Value := HighStrCode;
     DataRegAuxiliarFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
     DataFechaFinal.Value := ApplicationContainer.TodayDate;
     DataNroCopias.Value := 1;
     DataExcluirClientesCorreo.Value := False;
     DataFormato.Value := SerieFacturacion.ObtenFormatoDefecto( impFacturasVenta, DataSerie.Value );
end;

end.

