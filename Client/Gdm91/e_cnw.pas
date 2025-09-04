
unit e_cnw;

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
  Gim30Fields,
  Gim90Fields, dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, cxPCdxBarPopupMenu, cxNavigator, dxBarBuiltInMenu,
  dxDateRanges, AppForms, GridTableViewController, dxScrollbarAnnotations;


type
    TEtqCnwForm = class(TgxForm)
    FormManager: TgxFormManager;
    Panel1: TgxEditPanel;
    FormatoCtrl: TcxDBSpinEdit;
    NroCopiasCtrl: TcxDBSpinEdit;
    Report: TgxReportManager;
    ContactoWebQuery: TnxeQuery;
    PrimeraPosicionCtrl: TcxDBSpinEdit;
    Bevel1: TBevel;
    DataSource: TDataSource;
    GridData: TnxeTable;
    GridDataSource: TDataSource;
    GridDataCodigo: TWideStringField;
    GridDataNroCopias: TSmallintField;
    GridDataNombre: TWideStringField;
    GridDataNroLinea: TSmallintField;
    GridPanel: TPanel;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewCodigo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewNroCopias: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    GridTableViewController1: TGridTableViewController;
    Data: TgxMemData;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataOrdenar: TBooleanField;
    DataTodosLosDatos: TBooleanField;
    DataCodigoPostalInicial: TWideStringField;
    DataCodigoPostalFinal: TWideStringField;
    DataProvinciaInicial: TWideStringField;
    DataProvinciaFinal: TWideStringField;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    gxRangeBox2: TgxRangeBox;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    TabSheet3: TcxTabSheet;
    gxRangeBox4: TgxRangeBox;
    CodigoPostalInicialCtrl: TcxDBTextEdit;
    CodigoPostalFinalCtrl: TcxDBTextEdit;
    ProvinciaInicialCtrl: TcxDBTextEdit;
    ProvinciaFinalCtrl: TcxDBTextEdit;
    DataNroCopias: TSmallintField;
    DataFormato: TSmallintField;
    DataPrimeraPosicion: TSmallintField;
    ContactoWebQueryCodigo: TWideStringField;
    ContactoWebTable: TnxeTable;
    Label5: TcxLabel;
    Label8: TcxLabel;
    FormatoLabel: TcxLabel;
    Label19: TcxLabel;
    Label16: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label6: TcxLabel;
    Label9: TcxLabel;
    Label14: TcxLabel;
    Label17: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure ReportSetReportName;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ReportSelectPrinter;
    procedure CodigoPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridDataCalcFields(DataSet: TDataSet);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewNroCopiasPropertiesEnter(Sender: TcxCustomEdit);
    procedure FormManagerPreparedForm;
    procedure GridDataNewRecord(DataSet: TDataSet);
    procedure ProvinciaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure PageControlExit(Sender: TObject);
    procedure NroCopiasCtrlPropertiesValuePosted(Sender: TObject);
    procedure ProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure ProvinciaFinalCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ProvinciaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
    private
       procedure ActualizaRejilla;
    protected
    class var
      Codigo : String;
    public

      RptEtiquetaPostalTable : TnxeTable;

      RptEtiquetaPostalFields : TEtiquetaPostalFields;
      ContactoWebFields : TContactoWebFields;

    end;

var
  EtqCnwForm: TEtqCnwForm = nil;

procedure EtiquetasContactosWeb( Codigo : String );


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
       dm_cnw,

       cx_imp,
       cx_cnw,
       cx_prv,
       cx_pai,
       cx_cop;

{$R *.DFM}

procedure EtiquetasContactosWeb( Codigo : String );
begin
     TEtqCnwForm.Codigo := Codigo;
     CreateEditForm( TEtqCnwForm, EtqCnwForm );
end;

procedure TEtqCnwForm.InitializeForm;
begin
     ContactoWebFields := TContactoWebFields.Create( ContactoWebTable );

     DataNroCopias.Value := 1;
     DataCodigoInicial.Value := Codigo;
     DataCodigoFinal.Value := Codigo;
     DataProvinciaFinal.Value := HighStrCode;
     DataCodigoPostalFinal.Value := HighStrCode;
     DataOrdenar.Value := False;
     DataTodosLosDatos.Value := False;
     DataPrimeraPosicion.Value := 1;
     DataFormato.Value := InformeExterno.ObtenFormatoUsuario( impEtiquetasClientes );
end;

procedure TEtqCnwForm.NroCopiasCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaRejilla;
end;

procedure TEtqCnwForm.GridDataCalcFields(DataSet: TDataSet);
begin
     GridDataNombre.Value := ContactoWeb.Descripcion( GridDataCodigo.Value, False );
end;

procedure TEtqCnwForm.GridDataNewRecord(DataSet: TDataSet);
begin
     GridDataNroCopias.Value := 1;
end;

procedure TEtqCnwForm.CodigoPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaContactosWeb( Sender );
end;

procedure TEtqCnwForm.CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( CodigoEspaña, DataProvinciaInicial.Value, Sender );
end;

procedure TEtqCnwForm.CodigoPostalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( CodigoEspaña, DataProvinciaInicial.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TEtqCnwForm.GridViewCodigoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ContactoWeb.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TEtqCnwForm.GridViewNroCopiasPropertiesEnter(Sender: TcxCustomEdit);
begin
     With GridViewNroCopias do
       If   ValueIsEmpty( EditValue )
       then EditValue := 1;
end;

procedure TEtqCnwForm.FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impEtiquetasClientes ), Sender.EditingValue ] );
end;

procedure TEtqCnwForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impEtiquetasClientes, Sender );
end;

procedure TEtqCnwForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impEtiquetasClientes, Sender, DisplayValue, Errortext, Error );
end;

procedure TEtqCnwForm.FormManagerOkButton;

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

         Codigo.Value := ContactoWebFields.Codigo.Value;

         Nombre.Value := ContactoWebFields.Nombre.Value;
         Domicilio.Value := ContactoWebFields.Domicilio.Value;
         Localidad.Value := ContactoWebFields.localidad.Value;
         NombrePais.Value := Pais.Descripcion( CodigoEspaña, True );
         CP.Value := ContactoWebFields.CodigoProvincia.Value + ContactoWebFields.CodigoPostal.Value;
         Provincia.Value := dm_prv.Provincia.Descripcion( CodigoEspaña, ContactoWebFields.CodigoProvincia.Value, False );

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
           If   ContactoWebTable.FindKey( [ GridDataCodigo.Value ] )
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

procedure TEtqCnwForm.ActualizaRejilla;

var   SQLText : String;
      NroLinea : SmallInt;

begin
     With ContactoWebQuery do
       begin

       Close;

       SQLText := 'Select Codigo From ContactoWeb Where ';

       case PageControl.ActivePageIndex of
         0 : StrAdd( SQLText, SQLFormat( 'Codigo Between %s and %s', [ DataCodigoInicial, DataCodigoFinal ] ) + ' Order By Codigo' );
         1 : StrAdd( SQLText, SQLFormat( '( CodigoProvincia Between %s and %s ) and ( CodigoPostal Between %s and %s ) ',
                                         [ DataProvinciaInicial, DataProvinciaFinal,
                                           DataCodigoPostalInicial, DataCodigoPostalFinal ] ) +
                                         'Order By CodigoProvincia, CodigoPostal' );
         end;

       ContactoWebQuery.SQL.Text := SQLText;

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
             GridDataCodigo.Value := ContactoWebQueryCodigo.Value;
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

procedure TEtqCnwForm.FormManagerPreparedForm;
begin
     ActualizaRejilla;
end;

procedure TEtqCnwForm.PageControlExit(Sender: TObject);
begin
     ActualizaRejilla;
end;

procedure TEtqCnwForm.CodigoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ContactoWeb.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TEtqCnwForm.ReportSelectPrinter;
begin
     Report.ReportPrinter := InformeExterno.Impresora;
end;

procedure TEtqCnwForm.ProvinciaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProvincias( CodigoEspaña, Sender );
end;

procedure TEtqCnwForm.ProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( CodigoEspaña, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TEtqCnwForm.ProvinciaFinalCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ProvinciaFinalCtrl.Editing
     then CodigoPostalFinalCtrl.PostEditValue( '' );
end;

procedure TEtqCnwForm.ProvinciaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ProvinciaInicialCtrl.Editing
     then CodigoPostalInicialCtrl.PostEditValue( '' );
end;

procedure TEtqCnwForm.ReportSetReportName;
begin
     Report.FileName := InformeExterno.Fichero;
end;

end.

