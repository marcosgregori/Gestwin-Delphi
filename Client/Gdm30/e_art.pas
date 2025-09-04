
unit e_art;

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
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxGroupBox,
  cxLookAndFeels, cxLabel, cxPCdxBarPopupMenu, cxNavigator,
  dxBarBuiltInMenu, dxDateRanges,

  Gim10Fields,
  Gim30Fields,

  AppForms,
  GridTableViewController,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations, dxUIAClasses;


type
    TEtqArtForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Panel1: TgxEditPanel;
    Report: TgxReportManager;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    ArticuloTable: TnxeTable;
    Data: TgxMemData;
    DataSource: TDataSource;
    GridData: TnxeTable;
    GridDataSource: TDataSource;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataNroCopias: TSmallintField;
    DataFormato: TSmallintField;
    DataFamiliaInicial: TWideStringField;
    DataFamiliaFinal: TWideStringField;
    DataPrimeraPosicion: TSmallintField;
    GridDataCodigo: TWideStringField;
    GridDataNroCopias: TSmallintField;
    GridDataDescripcion: TWideStringField;
    DataTarifa: TWideStringField;
    GridDataNroLinea: TSmallintField;
    GridPanel: TcxGroupBox;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewCodigo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewNroCopias: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    GridTableViewController1: TGridTableViewController;
    ArticuloQuery: TnxeQuery;
    Panel2: TcxGroupBox;
    Bevel1: TBevel;
    FormatoCtrl: TcxDBSpinEdit;
    TarifaCtrl: TcxDBTextEdit;
    PrimeraPosicionCtrl: TcxDBSpinEdit;
    Label8: TcxLabel;
    FormatoLabel: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label16: TcxLabel;
    Panel4: TcxGroupBox;
    PageControl: TcxPageControl;
    TabSheet2: TcxTabSheet;
    gxRangeBox1: TgxRangeBox;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label7: TcxLabel;
    TabSheet1: TcxTabSheet;
    gxRangeBox2: TgxRangeBox;
    FamiliaInicialCtrl: TcxDBTextEdit;
    FamiliaFinalCtrl: TcxDBTextEdit;
    Label6: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    NroCopiasCtrl: TcxDBSpinEdit;
    Label5: TcxLabel;
    Label19: TcxLabel;
    ArticuloQueryCodigo: TWideStringField;
    ArticuloQueryDescripcion: TWideStringField;
    procedure ReportSetReportName;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ReportSelectPrinter;
    procedure CodigoArticuloPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FamiliaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FamiliaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TarifaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure TarifaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewNroCopiasPropertiesEnter(Sender: TcxCustomEdit);
    procedure FormManagerPreparedForm;
    procedure GridDataNewRecord(DataSet: TDataSet);
    procedure PageControlExit(Sender: TObject);
    procedure NroCopiasCtrlPropertiesValuePosted(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure GridViewCodigoPropertiesValuePosted(Sender: TObject);
    private
      RptEtiquetaArticuloTable : TnxeTable;

      RptEtiquetaArticuloFields : TEtiquetaArticuloFields;
      ArticuloFields : TArticuloFields;
      TiposIVAFields : TTiposIVAFields;

      procedure ActualizaRejilla;

    protected
    class var
      CodigoArticulo : String;
    public


    end;

var
  EtqArtForm: TEtqArtForm = nil;

procedure EtiquetasArticulos( CodigoArticulo : String );


implementation

uses   Variants,
       SysUtils,
       LibUtils,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm30Dm,
       Gim00Fields,

       dmi_mov,

       dm_ine,
       dm_cli,
       dm_art,
       dm_fam,
       dm_iva,
       dm_cdt,
       dm_fdv,
       dm_mov,

       a_imp,

       b_msg,

       cx_art,
       cx_imp,
       cx_cdt,
       cx_fam;

{$R *.DFM}

procedure EtiquetasArticulos( CodigoArticulo : String );
begin
     TEtqArtForm.CodigoArticulo := CodigoArticulo;
     CreateEditForm( TEtqArtForm, EtqArtForm );
end;

procedure TEtqArtForm.InitializeForm;
begin
     ArticuloFields := TArticuloFields.Create( ArticuloTable );
     TiposIVAFields := TTiposIVAFields.Create( Self );

     DataNroCopias.Value := 1;
     DataCodigoInicial.Value := CodigoArticulo;
     DataCodigoFinal.Value := CodigoArticulo;
     DataFamiliaFinal.Value := HighStrCode;
     DataPrimeraPosicion.Value := 1;
     DataFormato.Value := InformeExterno.ObtenFormatoUsuario( impEtiquetasArticulos );
end;

procedure TEtqArtForm.NroCopiasCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaRejilla;
end;

procedure TEtqArtForm.GridDataNewRecord(DataSet: TDataSet);
begin
     GridDataNroCopias.Value := 1;
end;

procedure TEtqArtForm.CodigoArticuloPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TEtqArtForm.GridViewCodigoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TEtqArtForm.GridViewCodigoPropertiesValuePosted(Sender: TObject);
begin
     GridDataDescripcion.Value := Articulo.Descripcion( GridDataCodigo.Value, False );
end;

procedure TEtqArtForm.GridViewNroCopiasPropertiesEnter(Sender: TcxCustomEdit);
begin
     With GridViewNroCopias do
       If   ValueIsEmpty( EditValue )
       then EditValue := 1;
end;

procedure TEtqArtForm.FamiliaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFamilias( Sender );
end;

procedure TEtqArtForm.FamiliaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Familia.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TEtqArtForm.FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impEtiquetasArticulos ), Sender.EditingValue ] );
end;

procedure TEtqArtForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impEtiquetasArticulos, Sender );
end;

procedure TEtqArtForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impEtiquetasArticulos, Sender, DisplayValue, Errortext, Error );
end;

procedure TEtqArtForm.FormManagerOkButton;

procedure SeleccionaRegistros;

var   Index : Integer;

procedure InsertaRegistro;

var   Index,
      NroCopias : Integer;

      _PrecioVenta : Double;
      _PuntoVerde,
      _RecargoVenta,
      _Descuento : Decimal;

      EsUnaOferta : Boolean;

begin

     {
     If   PageControl.ActivePage.PageIndex=0
     then NroCopias := GridDataNroCopias.Value
     else NroCopias := DataNroCopias.Value;
     }

     NroCopias := GridDataNroCopias.Value;

     With RptEtiquetaArticuloFields do
       For Index := 1 to NroCopias do
         begin

         RptEtiquetaArticuloTable.Append;

         Codigo.Value := ArticuloFields.Codigo.Value;
         Descripcion.Value := ArticuloFields.Descripcion.Value;
         Anotacion.Value := ArticuloFields.Anotacion.Value;
         CodigoBarras.Value := ArticuloFields.CodigoBarras.Value;

         PrecioVenta.Value := 0.0;
         RecargoVenta.Value := 0.0;
         Descuento.Value := 0.0;

         _PrecioVenta := 0.0;
         _PuntoVerde := 0.0;
         _RecargoVenta := 0.0;
         _Descuento := 0.0;
         EsUnaOferta := False;

         Articulo.ObtenPrecioyDtoVenta( tmNodefinido,
                                        '',
                                        ArticuloFields.Codigo.Value,
                                        '',
                                        '',
                                        '',
                                        1.0,  // Cantidad (por las cantiadades mínimas de las tarifas de venta)
                                        _PrecioVenta,
                                        _PuntoVerde,
                                        _RecargoVenta,
                                        _Descuento,
                                        EsUnaOferta,
                                        DataTarifa.Value,
                                        { Inicializar } True,
                                        ApplicationContainer.TodayDate );

         PrecioVenta.Value:= _PrecioVenta;
         PuntoVerde.Value := _PuntoVerde;
         RecargoVenta.Value := _RecargoVenta;
         Descuento.Value := _Descuento;

         Tasa.TipoIVA( ApplicationContainer.TodayDate, ArticuloFields.TipoIVA.Value, TiposIVAFields );
         TipoIVA.Value := TiposIVAFields.IVARepercutido.Value;
         PrecioIVAIncluido.Value := Redondea( PrecioVenta.Value + ( ( PrecioVenta.Value * TipoIVA.Value ) / 100.0 ) );
         PrecioVentaIVAIncluido.Value := PrecioIVAIncluido.Value;

         If   DataModule00.DmEmpresaFields.Articulo_Bultos.Value
         then begin
              NroBultosLinea.Value := ArticuloFields.Bultos.Value;
              Volumen.Value := ArticuloFields.Volumen.Value;
              Kilos.Value := ArticuloFields.Kilos.Value;
              end;

         RptEtiquetaArticuloTable.Post;

         ApplicationContainer.ShowProgression;
         end;

end;

begin

     With RptEtiquetaArticuloTable do
       For Index := 1 to DataPrimeraPosicion.Value - 1 do
         begin
         Append;
         Post;
         end;

     With GridData do
       try
         GridData.DisableControls;
         ApplicationContainer.StartProgression( RecordCount );
         First;
         While not Eof do
           begin
           If   ArticuloTable.FindKey( [ GridDataCodigo.Value ] )
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

         RptEtiquetaArticuloTable := CreateEmptyTable( 'EtiquetaArticulo', DataModule30.SQLSet );
         RptEtiquetaArticuloFields := TEtiquetaArticuloFields.Create( RptEtiquetaArticuloTable );

         SeleccionaRegistros;

         FacturaVentas.FijaDecimalesInforme( Report );

         Start;

       except on E : Exception do Cancel( E );
         end;

end;

procedure TEtqArtForm.FormManagerPreparedForm;
begin
     ActualizaRejilla;
end;

procedure TEtqArtForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TEtqArtForm.ReportSelectPrinter;
begin
     Report.ReportPrinter := InformeExterno.Impresora;
end;

procedure TEtqArtForm.PageControlChange(Sender: TObject);
begin
     PageControl.ActivePage.SetFocus;
     SelectNextControl;
end;

procedure TEtqArtForm.PageControlExit(Sender: TObject);
begin
     If   Assigned( ActiveControl )
     then ActualizaRejilla;
end;

procedure TEtqArtForm.ReportSetReportName;
begin
     Report.FileName := InformeExterno.Fichero;

end;

procedure TEtqArtForm.TarifaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosTarifa( Sender );
end;

procedure TEtqArtForm.TarifaCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoTarifa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TEtqArtForm.ActualizaRejilla;

var   SQLText : String;
      NroLinea : SmallInt;

begin
     If   not ( csDestroying in ComponentState )
     then With ArticuloQuery do
            begin

            Close;

            SQLText := 'SELECT Codigo, Descripcion FROM Articulo WHERE NOT Obsoleto AND ';

            case PageControl.ActivePageIndex of
              0 : StrAdd( SQLText, SQLFormat( 'Codigo BETWEEN %s AND %s', [ DataCodigoInicial, DataCodigoFinal ] ) + ' ORDER BY Codigo' );
              1 : StrAdd( SQLText, SQLFormat( 'Familia BETWEEN %s AND %s', [ DataFamiliaInicial, DataFamiliaFinal ] ) + ' ORDER BY Familia, Codigo' );
              end;

            ArticuloQuery.SQL.Text := SQLText;

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
                  GridDataCodigo.Value := ArticuloQueryCodigo.Value;
                  GridDataDescripcion.Value := ArticuloQueryDescripcion.Value;
                  GridDataNroCopias.Value := DataNroCopias.Value;

                  Post;
                  Inc( NroLinea );
                  end;

                Next;
                end;

            finally
              Close;
              GridData.EnableControls;
              end;
            end;
end;

end.

