
unit e_pro;

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
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations;


type
    TEtqProForm = class(TgxForm)
    FormManager: TgxFormManager;
    Panel1: TgxEditPanel;
    Report: TgxReportManager;
    ProveedorQuery: TnxeQuery;
    DataSource: TDataSource;
    GridData: TnxeTable;
    GridDataSource: TDataSource;
    GridDataCodigo: TWideStringField;
    GridDataNroCopias: TSmallintField;
    GridDataNombre: TWideStringField;
    GridDataNroLinea: TSmallintField;
    GridPanel: TcxGroupBox;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewCodigo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewNroCopias: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    GridTableViewController: TGridTableViewController;
    Data: TgxMemData;
    DataProveedorInicial: TWideStringField;
    DataProveedorFinal: TWideStringField;
    DataOrdenar: TBooleanField;
    DataTodosLosDatos: TBooleanField;
    DataCodigoPostalInicial: TWideStringField;
    DataCodigoPostalFinal: TWideStringField;
    DataProvinciaInicial: TWideStringField;
    DataProvinciaFinal: TWideStringField;
    DataCodigoPais: TWideStringField;
    DataFormaPagoInicial: TWideStringField;
    DataFormaPagoFinal: TWideStringField;
    DataNroCopias: TSmallintField;
    DataFormato: TSmallintField;
    DataPrimeraPosicion: TSmallintField;
    DataDireccionAdministrativa: TBooleanField;
    ProveedorQueryCodigo: TWideStringField;
    ProveedorTable: TnxeTable;
    Panel2: TcxGroupBox;
    Bevel1: TBevel;
    FormatoCtrl: TcxDBSpinEdit;
    PrimeraPosicionCtrl: TcxDBSpinEdit;
    DireccionAdministrativaCtrl: TcxDBCheckBox;
    Label8: TcxLabel;
    FormatoLabel: TcxLabel;
    Label16: TcxLabel;
    Panel4: TcxGroupBox;
    NroCopiasCtrl: TcxDBSpinEdit;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    gxRangeBox2: TgxRangeBox;
    ProveedorInicialCtrl: TcxDBTextEdit;
    ProveedorFinalCtrl: TcxDBTextEdit;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label6: TcxLabel;
    TabSheet3: TcxTabSheet;
    gxRangeBox4: TgxRangeBox;
    CodigoPostalInicialCtrl: TcxDBTextEdit;
    CodigoPostalFinalCtrl: TcxDBTextEdit;
    ProvinciaInicialCtrl: TcxDBTextEdit;
    ProvinciaFinalCtrl: TcxDBTextEdit;
    CodigoPaisCtrl: TcxDBTextEdit;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    Label17: TcxLabel;
    cxTabSheet1: TcxTabSheet;
    gxRangeBox5: TgxRangeBox;
    FormaPagoInicialCtrl: TcxDBTextEdit;
    FormaPagoFinalCtrl: TcxDBTextEdit;
    Label18: TcxLabel;
    Label20: TcxLabel;
    Label21: TcxLabel;
    Label5: TcxLabel;
    Label19: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure ReportSetReportName;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ReportSelectPrinter;
    procedure CodigoProveedorPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridDataCalcFields(DataSet: TDataSet);
    procedure CodigoProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewNroCopiasPropertiesEnter(Sender: TcxCustomEdit);
    procedure FormManagerPreparedForm;
    procedure GridDataNewRecord(DataSet: TDataSet);
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
    procedure FormaPagoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormaPagoCtrlPropertiesValidate(Sender: TcxCustomEdit;
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
      CodigoProveedor : String;
    public

      RptEtiquetaPostalTable : TnxeTable;

      RptEtiquetaPostalFields : TEtiquetaPostalFields;
      ProveedorFields : TProveedorFields;

    end;

var
  EtqProForm: TEtqProForm = nil;

procedure EtiquetasProveedores( CodigoProveedor : String );


implementation

uses   Variants,
       SysUtils,
       LibUtils,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm30Dm,

       a_imp,

       b_msg,

       dm_ine,
       dm_pai,
       dm_prv,
       dm_cop,
       dm_pro,
       dm_fpa,

       cx_imp,
       cx_pro,
       cx_prv,
       cx_pai,
       cx_cop,
       cx_fpa;

{$R *.DFM}

procedure EtiquetasProveedores( CodigoProveedor : String );
begin
     TEtqProForm.CodigoProveedor := CodigoProveedor;
     CreateEditForm( TEtqProForm, EtqProForm );
end;

procedure TEtqProForm.InitializeForm;
begin
     ProveedorFields := TProveedorFields.Create( ProveedorTable );

     DataNroCopias.Value := 1;
     DataProveedorInicial.Value := CodigoProveedor;
     DataProveedorFinal.Value := CodigoProveedor;
     DataCodigoPais.Value := CodigoEspaña;
     DataProvinciaFinal.Value := HighStrCode;
     DataCodigoPostalFinal.Value := HighStrCode;
     DataFormaPagoFinal.Value := HighStrCode;
     DataOrdenar.Value := False;
     DataTodosLosDatos.Value := False;
     DataPrimeraPosicion.Value := 1;
     DataFormato.Value := InformeExterno.ObtenFormatoUsuario( impEtiquetasProveedores );
end;

procedure TEtqProForm.NroCopiasCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaRejilla;
end;

procedure TEtqProForm.GridDataCalcFields(DataSet: TDataSet);
begin
     GridDataNombre.Value := Proveedor.Descripcion( GridDataCodigo.Value, False );
end;

procedure TEtqProForm.GridDataNewRecord(DataSet: TDataSet);
begin
     GridDataNroCopias.Value := 1;
end;

procedure TEtqProForm.CodigoProveedorPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TEtqProForm.CodigoPaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TEtqProForm.CodigoPaisCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
     If   not Error
     then CodigoPostal.SetupCPControl( DisplayValue, [ ProvinciaInicialCtrl, ProvinciaFinalCtrl ],
                                                     [ CodigoPostalInicialCtrl, CodigoPostalFinalCtrl ] );
end;

procedure TEtqProForm.CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( DataCodigoPais.Value, DataProvinciaInicial.Value, Sender );
end;

procedure TEtqProForm.CodigoPostalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( DataCodigoPais.Value, DataProvinciaInicial.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TEtqProForm.GridViewCodigoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TEtqProForm.GridViewNroCopiasPropertiesEnter(Sender: TcxCustomEdit);
begin
     With GridViewNroCopias do
       If   ValueIsEmpty( EditValue )
       then EditValue := 1;
end;

procedure TEtqProForm.FormaPagoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasPago( Sender );
end;

procedure TEtqProForm.FormaPagoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     FormaPago.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TEtqProForm.FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impEtiquetasProveedores ), Sender.EditingValue ] );
end;

procedure TEtqProForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impEtiquetasProveedores, Sender );
end;

procedure TEtqProForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impEtiquetasProveedores, Sender, DisplayValue, Errortext, Error );
end;

procedure TEtqProForm.FormManagerOkButton;

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

         Codigo.Value := ProveedorFields.Codigo.Value;

         If   DataDireccionAdministrativa.Value
         then begin
              Nombre.Value := ProveedorFields.Nombre.Value;
              Domicilio.Value := ProveedorFields.Domicilio.Value;
              localidad.Value := ProveedorFields.localidad.Value;
              CodigoPais.Value := ProveedorFields.CodigoPais.Value;
              NombrePais.Value := Pais.Descripcion( ProveedorFields.CodigoPais.Value, true );
              CP.Value := ProveedorFields.CodigoProvincia.Value + ProveedorFields.CodigoPostal.Value;
              Provincia.Value := dm_prv.Provincia.Descripcion( ProveedorFields.CodigoPais.Value, ProveedorFields.CodigoProvincia.Value, False );
              end
         else begin
              Nombre.Value := ProveedorFields.Envios_Nombre.Value;
              Domicilio.Value := ProveedorFields.Envios_Domicilio.Value;
              localidad.Value := ProveedorFields.Envios_localidad.Value;
              CodigoPais.Value := ProveedorFields.CodigoPais.Value;
              NombrePais.Value := Pais.Descripcion( ProveedorFields.CodigoPais.Value, true );
              CP.Value := ProveedorFields.Envios_codigoProv.Value + ProveedorFields.Envios_codigoPostal.Value;
              Provincia.Value := dm_prv.Provincia.Descripcion( ProveedorFields.CodigoPais.Value, ProveedorFields.envios_codigoProv.Value, False );
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
           If   ProveedorTable.FindKey( [ GridDataCodigo.Value ] )
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

procedure TEtqProForm.ActualizaRejilla;

var   SQLText : String;
      NroLinea : SmallInt;

begin
     With ProveedorQuery do
       begin

       Close;

       SQLText := 'Select Codigo From Proveedor Where ';

       case PageControl.ActivePageIndex of
         0 : StrAdd( SQLText, SQLFormat( 'Codigo Between %s and %s', [ DataProveedorInicial, DataProveedorFinal ] ) + ' Order By Codigo' );
         1 : StrAdd( SQLText, SQLFormat( 'CodigoPais=%s and ( CodigoProvincia Between %s and %s ) and ( CodigoPostal Between %s and %s ) ',
                                         [ DataCodigoPais,
                                           DataProvinciaInicial, DataProvinciaFinal,
                                           DataCodigoPostalInicial, DataCodigoPostalFinal ] ) +
                                         'Order By CodigoPais, CodigoProvincia, CodigoPostal' );
         2 : StrAdd( SQLText, SQLFormat( 'Pago_FormaPago Between %s and %s', [ DataFormaPagoInicial, DataFormaPagoFinal ] ) + ' Order By Pago_FormaPago, Codigo' );
         end;

       ProveedorQuery.SQL.Text := SQLText;

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
             GridDataCodigo.Value := ProveedorQueryCodigo.Value;
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

procedure TEtqProForm.FormManagerPreparedForm;
begin
     ActualizaRejilla;
end;

procedure TEtqProForm.PageControlChange(Sender: TObject);
begin
     PageControl.ActivePage.SetFocus;
     SelectNextControl;
end;

procedure TEtqProForm.PageControlExit(Sender: TObject);
begin
     If   Assigned( ActiveControl )
     then ActualizaRejilla;
end;

procedure TEtqProForm.CodigoProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TEtqProForm.ReportSelectPrinter;
begin
     Report.ReportPrinter := InformeExterno.Impresora;
end;

procedure TEtqProForm.ProvinciaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProvincias( DataCodigoPais.Value, Sender );
end;

procedure TEtqProForm.ProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( DataCodigoPais.Value, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TEtqProForm.ProvinciaFinalCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ProvinciaFinalCtrl.Editing
     then CodigoPostalFinalCtrl.PostEditValue( '' );
end;

procedure TEtqProForm.ProvinciaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ProvinciaInicialCtrl.Editing
     then CodigoPostalInicialCtrl.PostEditValue( '' );
end;

procedure TEtqProForm.ReportSetReportName;
begin
     Report.FileName := InformeExterno.Fichero;
end;

end.

