
unit e_cli;

interface

uses StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,


     ComCtrls,

     DataManager,
     DB,
     nxdb,
     ReportManager, Menus, cxLookAndFeelPainters, cxButtons, dxmdaset,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGrid, cxPC, cxDBEdit, cxContainer, cxTextEdit, cxMaskEdit, cxSpinEdit,
  cxCheckBox,

  Gim10Fields,
  Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxLookAndFeels, cxLabel, cxGroupBox, cxPCdxBarPopupMenu, cxNavigator,
  dxBarBuiltInMenu, dxDateRanges, AppForms, GridTableViewController,
  dxScrollbarAnnotations;


type
    TEtqCliForm = class(TgxForm)
    FormManager: TgxFormManager;
    Panel1: TgxEditPanel;
    FormatoCtrl: TcxDBSpinEdit;
    NroCopiasCtrl: TcxDBSpinEdit;
    Report: TgxReportManager;
    ClienteQuery: TnxeQuery;
    PrimeraPosicionCtrl: TcxDBSpinEdit;
    DataSource: TDataSource;
    GridData: TnxeTable;
    GridDataSource: TDataSource;
    GridDataCodigo: TWideStringField;
    GridDataNroCopias: TSmallintField;
    GridDataNombre: TWideStringField;
    GridDataNroLinea: TSmallintField;
    DireccionAdministrativaCtrl: TcxDBCheckBox;
    GridPanel: TcxGroupBox;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewCodigo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewNroCopias: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    GridTableViewController1: TGridTableViewController;
    Data: TgxMemData;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataOrdenar: TBooleanField;
    DataGrupoInicial: TWideStringField;
    DataGrupoFinal: TWideStringField;
    DataCodigoPostalInicial: TWideStringField;
    DataCodigoPostalFinal: TWideStringField;
    DataProvinciaInicial: TWideStringField;
    DataProvinciaFinal: TWideStringField;
    DataVendedorInicial: TWideStringField;
    DataVendedorFinal: TWideStringField;
    DataCodigoPais: TWideStringField;
    DataFormaCobroInicial: TWideStringField;
    DataFormaCobroFinal: TWideStringField;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    gxRangeBox2: TgxRangeBox;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    GrupoClienteTabSheet: TcxTabSheet;
    gxRangeBox1: TgxRangeBox;
    GrupoInicialCtrl: TcxDBTextEdit;
    GrupoFinalCtrl: TcxDBTextEdit;
    VendedorTabSheet: TcxTabSheet;
    gxRangeBox3: TgxRangeBox;
    VendedorInicialCtrl: TcxDBTextEdit;
    VendedorFinalCtrl: TcxDBTextEdit;
    TabSheet3: TcxTabSheet;
    gxRangeBox4: TgxRangeBox;
    CodigoPostalInicialCtrl: TcxDBTextEdit;
    CodigoPostalFinalCtrl: TcxDBTextEdit;
    ProvinciaInicialCtrl: TcxDBTextEdit;
    ProvinciaFinalCtrl: TcxDBTextEdit;
    CodigoPaisCtrl: TcxDBTextEdit;
    cxTabSheet1: TcxTabSheet;
    gxRangeBox5: TgxRangeBox;
    FormaCobroInicialCtrl: TcxDBTextEdit;
    FormaCobroFinalCtrl: TcxDBTextEdit;
    DataNroCopias: TSmallintField;
    DataFormato: TSmallintField;
    DataPrimeraPosicion: TSmallintField;
    DataDireccionAdministrativa: TBooleanField;
    ClienteQueryCodigo: TWideStringField;
    ClienteTable: TnxeTable;
    Label5: TcxLabel;
    Label8: TcxLabel;
    FormatoLabel: TcxLabel;
    Label19: TcxLabel;
    Label16: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label3: TcxLabel;
    Label12: TcxLabel;
    Label11: TcxLabel;
    Label15: TcxLabel;
    Label4: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    Label17: TcxLabel;
    Label18: TcxLabel;
    Label20: TcxLabel;
    Label21: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Bevel1: TShape;
    procedure ReportSetReportName;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ReportSelectPrinter;
    procedure CodigoClientePropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridDataCalcFields(DataSet: TDataSet);
    procedure CodigoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewNroCopiasPropertiesEnter(Sender: TcxCustomEdit);
    procedure FormManagerPreparedForm;
    procedure GridDataNewRecord(DataSet: TDataSet);
    procedure GrupoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GrupoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure VendedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoPaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoPaisCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ProvinciaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure FormaCobroCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormaCobroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure PageControlExit(Sender: TObject);
    procedure NroCopiasCtrlPropertiesValuePosted(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure ProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure ProvinciaFinalCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ProvinciaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
    private
       procedure ActualizaRejilla;
    protected
    class var
      CodigoCliente : String;
    public

      RptEtiquetaPostalTable : TnxeTable;

      RptEtiquetaPostalFields : TEtiquetaPostalFields;
      ClienteFields : TClienteFields;

    end;

var
  EtqCliForm: TEtqCliForm = nil;

procedure EtiquetasClientes( CodigoCliente : String );


implementation

uses   Variants,
       SysUtils,
       LibUtils,

       EnterpriseDataAccess,
       SessionDataAccess,

       Gdm00Dm,
       Gdm30Dm,

       a_imp,

       b_msg,

       dm_ine,
       dm_pai,
       dm_prv,
       dm_cop,
       dm_cli,
       dm_gdc,
       dm_ven,
       dm_fco,

       cx_imp,
       cx_cli,
       cx_gdc,
       cx_ven,
       cx_prv,
       cx_pai,
       cx_cop,
       cx_fco;

{$R *.DFM}

procedure EtiquetasClientes( CodigoCliente : String );
begin
     TEtqCliForm.CodigoCliente := CodigoCliente;
     CreateEditForm( TEtqCliForm, EtqCliForm );
end;

procedure TEtqCliForm.InitializeForm;
begin
     ClienteFields := TClienteFields.Create( ClienteTable );

     DataNroCopias.Value := 1;
     DataClienteInicial.Value := CodigoCliente;
     DataClienteFinal.Value := CodigoCliente;
     DataGrupoFinal.Value := HighStrCode;
     DataCodigoPais.Value := CodigoEspaña;
     DataVendedorFinal.Value := HighStrCode;
     DataProvinciaFinal.Value := HighStrCode;
     DataCodigoPostalFinal.Value := HighStrCode;
     DataFormaCobroFinal.Value := HighStrCode;
     DataOrdenar.Value := False;
     DataPrimeraPosicion.Value := 1;
     DataFormato.Value := InformeExterno.ObtenFormatoUsuario( impEtiquetasClientes );
end;

procedure TEtqCliForm.NroCopiasCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaRejilla;
end;

procedure TEtqCliForm.GridDataCalcFields(DataSet: TDataSet);
begin
     GridDataNombre.Value := Cliente.Descripcion( GridDataCodigo.Value, False );
end;

procedure TEtqCliForm.GridDataNewRecord(DataSet: TDataSet);
begin
     GridDataNroCopias.Value := 1;
end;

procedure TEtqCliForm.CodigoClientePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TEtqCliForm.CodigoPaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TEtqCliForm.CodigoPaisCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
     If   not Error
     then CodigoPostal.SetupCPControl( DisplayValue, [ ProvinciaInicialCtrl, ProvinciaFinalCtrl ],
                                                     [ CodigoPostalInicialCtrl, CodigoPostalFinalCtrl ] );
end;

procedure TEtqCliForm.CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( DataCodigoPais.Value, DataProvinciaInicial.Value, Sender );
end;

procedure TEtqCliForm.CodigoPostalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( DataCodigoPais.Value, DataProvinciaInicial.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TEtqCliForm.GridViewCodigoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TEtqCliForm.GridViewNroCopiasPropertiesEnter(Sender: TcxCustomEdit);
begin
     With GridViewNroCopias do
       If   ValueIsEmpty( EditValue )
       then EditValue := 1;
end;

procedure TEtqCliForm.GrupoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TEtqCliForm.GrupoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TEtqCliForm.FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

procedure TEtqCliForm.FormaCobroCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TEtqCliForm.FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impEtiquetasClientes ), Sender.EditingValue ] );
end;

procedure TEtqCliForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impEtiquetasClientes, Sender );
end;

procedure TEtqCliForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impEtiquetasClientes, Sender, DisplayValue, Errortext, Error );
end;

procedure TEtqCliForm.FormManagerOkButton;

procedure SeleccionaRegistros;

var   Index : Integer;

procedure InsertaRegistro;

var   Index,
      NroCopias : Integer;

begin

     If   PageControl.ActivePageIndex=0
     then NroCopias := GridDataNroCopias.Value
     else NroCopias := DataNroCopias.Value;

     With RptEtiquetaPostalFields do
       For Index := 1 to NroCopias do
         begin

         RptEtiquetaPostalTable.Append;

         Codigo.Value := ClienteFields.Codigo.Value;

         If   DataDireccionAdministrativa.Value
         then begin
              Nombre.Value := ClienteFields.Nombre.Value;
              Domicilio.Value := ClienteFields.Domicilio.Value;
              localidad.Value := ClienteFields.localidad.Value;
              CodigoPais.Value := ClienteFields.CodigoPais.Value;
              NombrePais.Value := Pais.Descripcion( ClienteFields.CodigoPais.Value, true );
              CP.Value := ClienteFields.CodigoProvincia.Value + ClienteFields.CodigoPostal.Value;
              Provincia.Value := dm_prv.Provincia.Descripcion( ClienteFields.CodigoPais.Value, ClienteFields.CodigoProvincia.Value, False );
              end
         else begin
              Nombre.Value := ClienteFields.Envios_Nombre.Value;
              Domicilio.Value := ClienteFields.Envios_Domicilio.Value;
              localidad.Value := ClienteFields.Envios_localidad.Value;
              CodigoPais.Value := ClienteFields.CodigoPais.Value;
              NombrePais.Value := Pais.Descripcion( ClienteFields.CodigoPais.Value, true );
              CP.Value := ClienteFields.Envios_codigoProv.Value + ClienteFields.Envios_codigoPostal.Value;
              Provincia.Value := dm_prv.Provincia.Descripcion( ClienteFields.CodigoPais.Value, ClienteFields.envios_codigoProv.Value, False );
              end;

         RptEtiquetaPostalTable.Post;

         ApplicationContainer.ShowProgression;

         end;

end;

begin

     With RptEtiquetaPostalTable do
       For Index := 1 to DataPrimeraPosicion.Value - 1 do
         begin
         Append;
         Post;
         end;

     With GridData do
       try
         ApplicationContainer.StartProgression( RecordCount );
         GridData.DisableControls;
         First;
         While not Eof do
           begin
           If   ClienteTable.FindKey( [ GridDataCodigo.Value ] )
           then InsertaRegistro;
           Next;
           end;

       finally
         GridData.EnableControls;
         ApplicationContainer.EndProgression;
         end;
end;

begin
     With Report do
       try
         Load;
         RptEtiquetaPostalTable  := CreateEmptyTable( 'EtiquetaPostal', DataModule30.SQLSet );
         RptEtiquetaPostalFields := TEtiquetaPostalFields.Create( RptEtiquetaPostalTable );
         SeleccionaRegistros;
         Start;
       except on E : Exception do Cancel( E );
         end;

end;

procedure TEtqCliForm.ActualizaRejilla;

var   SQLText : String;
      NroLinea : SmallInt;

begin
     With ClienteQuery do
       begin

       Close;

       SQLText := 'Select Codigo From Cliente Where ';

       case PageControl.ActivePageIndex of
         0 : StrAdd( SQLText, SQLFormat( 'Codigo Between %s and %s', [ DataClienteInicial, DataClienteFinal ] ) + ' Order By Codigo' );
         1 : StrAdd( SQLText, SQLFormat( 'Factura_Agrupacion Between %s and %s', [ DataGrupoInicial, DataGrupoFinal ] ) + ' Order By Factura_Agrupacion, Codigo' );
         2 : StrAdd( SQLText, SQLFormat( 'Vendedor Between %s and %s', [ DataVendedorInicial, DataVendedorFinal ] ) + ' Order By Vendedor, Codigo' );
         3 : StrAdd( SQLText, SQLFormat( 'CodigoPais=%s and ( CodigoProvincia Between %s and %s ) and ( CodigoPostal Between %s and %s ) ',
                                         [ DataCodigoPais,
                                           DataProvinciaInicial, DataProvinciaFinal,
                                           DataCodigoPostalInicial, DataCodigoPostalFinal ] ) +
                                         'Order By CodigoPais, CodigoProvincia, CodigoPostal' );
         4 : StrAdd( SQLText, SQLFormat( 'Cobro_FormaCobro Between %s and %s', [ DataFormaCobroInicial, DataFormaCobroFinal ] ) + ' Order By Cobro_FormaCobro, Codigo' );
         end;

       ClienteQuery.SQL.Text := SQLText;

       Open;

       First;
       try
         GridData.DisableControls;
         GridData.DeleteRecords;
         NroLinea := 1;
         While not Eof do
           begin

           With GridData do
             begin
             Append;

             GridDataNroLinea.Value := NroLinea;
             GridDataCodigo.Value := ClienteQueryCodigo.Value;
             GridDataNroCopias.Value := DataNroCopias.Value;

             Post;
             Inc( NroLinea );
             end;

           Next;
           end;

       finally
         GridData.EnableControls;
         end;
       end;
end;

procedure TEtqCliForm.FormManagerPreparedForm;
begin
     ActualizaRejilla;
end;

procedure TEtqCliForm.PageControlChange(Sender: TObject);
begin

     //* 14.01.2009 Con esto trato de evitar que la página activa no reciba el focus cuando se cambia el tab con el ratón estando en otro control del Form

     PageControl.ActivePage.SetFocus;
     SelectNextControl;
end;

procedure TEtqCliForm.PageControlExit(Sender: TObject);
begin
     If   Assigned( ActiveControl )
     then ActualizaRejilla;
end;

procedure TEtqCliForm.CodigoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TEtqCliForm.ReportSelectPrinter;
begin
     Report.ReportPrinter := InformeExterno.Impresora;
end;

procedure TEtqCliForm.ProvinciaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProvincias( DataCodigoPais.Value, Sender );
end;

procedure TEtqCliForm.ProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( DataCodigoPais.Value, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TEtqCliForm.ProvinciaFinalCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ProvinciaInicialCtrl.Editing
     then CodigoPostalInicialCtrl.PostEditValue( '' );
end;

procedure TEtqCliForm.ProvinciaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ProvinciaFinalCtrl.Editing
     then CodigoPostalFinalCtrl.PostEditValue( '' );
end;

procedure TEtqCliForm.ReportSetReportName;
begin
     Report.FileName := InformeExterno.Fichero;
end;

procedure TEtqCliForm.VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TEtqCliForm.VendedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

end.

