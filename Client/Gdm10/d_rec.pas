unit d_rec;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls, Graphics, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,

  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, dxmdaset, cxCurrencyEdit,
  cxCheckBox, cxLookAndFeels, cxLabel, cxGroupBox, cxNavigator, dxDateRanges,

  Gim10Fields,

  AppContainer,
  AppForms,
  GridTableViewController,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations;

type
  TBoxRecForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    CloseButton: TgBitBtn;
    EfectoCobrarQuery: TnxeQuery;
    EfectoCobrarDataSource: TDataSource;
    GridTableViewController: TGridTableViewController;
    DataSource: TDataSource;
    KeyPanel: TgxEditPanel;
    CodigoClienteCtrl: TcxDBTextEdit;
    AceptarButton: TgBitBtn;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    TableViewNroEfecto: TcxGridDBColumn;
    TableViewEntidad: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    TableViewFechaVencimiento: TcxGridDBColumn;
    TableViewImporte: TcxGridDBColumn;
    TableViewNroRemesa: TcxGridDBColumn;
    TableViewFechaCobro: TcxGridDBColumn;
    TableViewFormaDePago: TcxGridDBColumn;
    TableViewImpagado: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    EfectoCobrarQueryEjercicio: TSmallintField;
    EfectoCobrarQuerySerie: TWideStringField;
    EfectoCobrarQueryNroFactura: TIntegerField;
    EfectoCobrarQueryNroEfecto: TSmallintField;
    EfectoCobrarQueryCliente: TWideStringField;
    EfectoCobrarQueryEntidad: TWideStringField;
    EfectoCobrarQueryFechaVencimiento: TDateField;
    EfectoCobrarQueryFechaCobro: TDateField;
    EfectoCobrarQueryNroRemesa: TIntegerField;
    EfectoCobrarQueryImporte: TBCDField;
    EfectoCobrarQueryImpagado: TBooleanField;
    EfectoCobrarQueryFechaLibramiento: TDateField;
    TableViewEjercicio: TcxGridDBColumn;
    TableViewSerie: TcxGridDBColumn;
    TableViewNroFactura: TcxGridDBColumn;
    TableViewFechaLibramiento: TcxGridDBColumn;
    EfectoCobrarQueryDescripcion: TWideStringField;
    ClienteTable: TnxeTable;
    TableViewCliente: TcxGridDBColumn;
    ClienteTableCodigo: TWideStringField;
    ClienteTableNombre: TWideStringField;
    ClienteTableSubcuenta: TWideStringField;
    Label1: TcxLabel;
    Label11: TcxLabel;
    procedure FormManagerInitializeForm;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure TableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure GridTableViewControllerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure RefrescarButtonClick(Sender: TObject);
    procedure ClienteCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerPreparedForm;
    procedure EfectoCobrarQueryBeforeOpen(DataSet: TDataSet);
    procedure ClienteTableAfterScroll(DataSet: TDataSet);
  private
  protected
  class var
    CodigoCliente : String;
  public

  end;

var  BoxRecForm: TBoxRecForm = nil;

procedure RelacionEfectosCobrar( CodigoCliente : String = '' );

implementation

{$R *.dfm}

uses   SysUtils,
       LibUtils,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,

       dm_sub,
       dm_cli,
       dm_ecc,
       
       a_cli,
       a_ecc,

       cx_cli,

       l_rdc;

procedure RelacionEfectosCobrar( CodigoCliente : String = '' );
begin
     TBoxRecForm.CodigoCliente := CodigoCliente;
     CreateEditForm( TBoxRecForm, BoxRecForm, [ CodigoCliente ] );
end;

procedure TBoxRecForm.ClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TBoxRecForm.ClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TBoxRecForm.ClienteTableAfterScroll(DataSet: TDataSet);
begin
     TableView.ViewData.Expand(False);
end;

procedure TBoxRecForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TBoxRecForm.CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TBoxRecForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender, qgsLinked );
end;

procedure TBoxRecForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxRecForm.EfectoCobrarQueryBeforeOpen(DataSet: TDataSet);

var  SubcuentaCliente : String;
     SQLText : String;

begin
     With EfectoCobrarQuery do
       begin
       SQLText := 'SELECT Ejercicio, Serie, NroFactura, NroEfecto, FechaLibramiento, SubcuentaCliente, SubcuentaEntidad, FechaVencimiento, NroRemesa, Importe, FechaCobro, Impagado, Cuenta.Descripcion ' +
                  'FROM EfectoCobrar LEFT JOIN Cuenta ON ( Cuenta.Codigo=EfectoCobrar.SubcuentaEntidad ) ' +
                  'WHERE SubcuentaCliente=';
       SubcuentaCliente := ClienteTableSubcuenta.Value;
       StrAdd( SQLText, QuotedStr( SubcuentaCliente ) );
       If   DataModule00.DmEmpresaFields.Contable_DesglosarCtasCobros.Value
       then StrAdd( SQLText, ' OR SubcuentaCliente=' + QuotedStr( EfectoCobrar.ObtenSubcuentaRiesgo( SubcuentaCliente, srImpagados ) ) );
       StrAdd( SQLText, ' ORDER BY FechaVencimiento DESC' );
       SQL.Text := SQLText;
       end;
end;

procedure TBoxRecForm.FormManagerInitializeForm;
begin
     SetColumnDecimals( TableViewImporte );
end;

procedure TBoxRecForm.FormManagerPreparedForm;
begin
     If   CodigoCliente=''
     then begin
          ClienteTable.Last;
          FormManager.SelectFirstKeyControl;
          end
     else Grid.SetFocus;
end;

procedure TBoxRecForm.GridTableViewControllerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     With TableView.Controller do
       If   Assigned( FocusedRecord )
       then With FocusedRecord do
              MntEfectosCobrar( [ Values[ TableViewEjercicio.Index ],
                                  Values[ TableViewSerie.Index ],
                                  Values[ TableViewNroFactura.Index ],
                                  Values[ TableViewNroEfecto.Index ] ] );
end;

procedure TBoxRecForm.RefrescarButtonClick(Sender: TObject);
begin
     TableView.DataController.RefreshExternalData;
     Grid.SetFocus;
end;

procedure TBoxRecForm.TableViewCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                   ACanvas   : TcxCanvas;
                                                   AViewInfo : TcxGridTableDataCellViewInfo;
                                               var ADone     : Boolean );
begin
     If   VarToBoolean( AViewInfo.GridRecord.Values[ TableViewImpagado.Index ] )
     then With ACanvas do
            begin
            Brush.Color := clLightRed;
            Font.Color := clBlack;
            end
     else  If   ( VarToInteger( AViewInfo.GridRecord.Values[ TableViewNroRemesa.Index ] )=0 ) and
                ( VarToDecimal( AViewInfo.GridRecord.Values[ TableViewFechaCobro.Index ] )=0.0 )
           then With ACanvas do
                  begin
                  Brush.Color := clLightOrange;
                  Font.Color := clBlack;
                  end

end;

end.



