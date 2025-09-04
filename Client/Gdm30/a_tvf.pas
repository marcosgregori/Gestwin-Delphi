unit a_tvf;

interface

uses StdCtrls, Buttons, Mask, Controls,
  Classes, ExtCtrls, Forms, Tabs,

  AppContainer,

  ComCtrls,
  Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, dxmdaset, cxCurrencyEdit,

  Gim30Fields, cxCheckBox, cxPC, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLabel, cxGroupBox, cxNavigator, dxDateRanges,
  AppForms, GridTableViewController, dxScrollbarAnnotations, Spring,
  dxUIAClasses;

type
  TMntTvfForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    CodigoTarifaCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    TarifaVentasTable: TnxeTable;
    Data: TgxMemData;
    DataSource: TDataSource;
    CodigoTarifaTable: TnxeTable;
    CodigoTarifaDataSource: TDataSource;
    CodigoTarifaTableCodigo: TWideStringField;
    CodigoTarifaTableDescripcion: TWideStringField;
    DataFamiliaInicial: TWideStringField;
    DataFamiliaFinal: TWideStringField;
    DataSoloFamiliasConTarifa: TBooleanField;
    TarifaVentasFamiliaCachedDataSet: TnxeCachedDataSet;
    TarifaVentasFamiliaDataSource: TDataSource;
    TarifaVentasFamiliaQuery: TnxeQuery;
    TarifaVentasFamiliaCachedDataSetCodigo: TWideStringField;
    TarifaVentasFamiliaCachedDataSetDescripcion: TWideStringField;
    TarifaVentasFamiliaCachedDataSetCodigoArticulo: TWideStringField;
    TarifaVentasFamiliaCachedDataSetDescuento: TBCDField;
    Panel2: TcxGroupBox;
    gxRangeBox2: TgxRangeBox;
    FamiliaInicialCtrl: TcxDBTextEdit;
    FamiliaFinalCtrl: TcxDBTextEdit;
    SoloFamiliasConTarifaCtrl: TcxDBCheckBox;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewCodigo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewDescuento: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    TableViewManager: TGridTableViewController;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    Label2: TcxLabel;
    DescCodigoTarifaLabel: TcxLabel;
    claseActivaLabel: TcxLabel;
    Label5: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    TarifaVentasFamiliaCachedDataSetPrecio: TFloatField;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: SmallInt;
    procedure CodigoTarifaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoTarifaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoTarifaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoTarifaTableAfterScroll(DataSet: TDataSet);
    procedure FamiliaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure FamiliaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FamiliaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TarifaVentasFamiliaCachedDataSetBeforeEdit(
      DataSet: TDataSet);
    procedure TarifaVentasFamiliaCachedDataSetBeforePost(
      DataSet: TDataSet);
    function FormManagerDeleteButton: Boolean;
    procedure CodigoTarifaTableGetRecord(DataSet: TDataSet);
    procedure SoloFamiliasConTarifaCtrlPropertiesChange(Sender: TObject);
    procedure RangeValuePosted(Sender: TObject);
    procedure CodigoTarifaTableRecordChanged(DataSet: TDataSet);
  private

    FTarifaTableChanged : Boolean;

    FOnTarifaBeforePost : Event<TDataSetNotifyEvent>;

  public

    TarifaVentasFields : TTarifaVentasFields;

    ExisteTarifa : Boolean;
    FamiliaSQLText : String;

    procedure UpdateQuery;

    property OnTarifaBeforePost : Event<TDataSetNotifyEvent> read FOnTarifaBeforePost write FOnTarifaBeforePost;
  end;

var
  MntTvfForm: TMntTvfForm = nil;

procedure MntTarifasVentaFamilia( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,
       
       AppManager,
       Variants,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       b_msg,

       dmi_pga,

       dm_pga,
       dm_cdt,
       dm_fam,
       dm_art,
       
       a_cdt,
       a_fam,

       cx_cdt,
       cx_fam,

       l_tvf;

procedure MntTarifasVentaFamilia( KeyValues : array of const );
begin
     CreateEditForm( TMntTvfForm, MntTvfForm, KeyValues, TGds30Frm.VentasSection );
end;

procedure TMntTvfForm.FormManagerInitializeForm;
begin

     Id := idMntTvfForm;

     TarifaVentasFields := TTarifaVentasFields.Create( TarifaVentasTable );

     With DataModule00.DmEmpresaFields do
       SetColumnDecimals( GridViewDescuento, Ventas_DecDto.Value );

     With Data do
       begin
       Open;
       Append;
       end;

     FamiliaSQLText := TarifaVentasFamiliaQuery.SQL.Text;

     DataFamiliaFinal.Value := HighStrCode;
     DataSoloFamiliasConTarifa.Value := True;
end;

procedure TMntTvfForm.FormManagerReportRequest;
begin
     ListadoTarifasVentaFamilia;
end;

procedure TMntTvfForm.SoloFamiliasConTarifaCtrlPropertiesChange(Sender: TObject);
begin
     DeleteButton.Enabled := SoloFamiliasConTarifaCtrl.Checked and FormManager.DataAreaFocused;
     UpdateQuery;
end;

procedure TMntTvfForm.CodigoTarifaTableAfterScroll(DataSet: TDataSet);
begin
     UpdateQuery;
end;

procedure TMntTvfForm.CodigoTarifaTableGetRecord(DataSet: TDataSet);
begin
     FTarifaTableChanged := True;
     DataSoloFamiliasConTarifa.Value := True;
end;

procedure TMntTvfForm.CodigoTarifaTableRecordChanged(DataSet: TDataSet);
begin
     FTarifaTableChanged := True;
     UpdateQuery;
end;

procedure TMntTvfForm.FamiliaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFamilias( Sender );
end;

procedure TMntTvfForm.FamiliaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Familia.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TMntTvfForm.RangeValuePosted(Sender: TObject);
begin
     UpdateQuery;
end;

procedure TMntTvfForm.FamiliaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntFamilias( [ Sender.EditingValue ] );
end;

procedure TMntTvfForm.TarifaVentasFamiliaCachedDataSetBeforeEdit(DataSet: TDataSet);
begin
     ExisteTarifa := TarifaVentasTable.FindKey( [ rtvTarifaFamilia, CodigoTarifaTableCodigo.Value, TarifaVentasFamiliaCachedDatasetCodigo.Value ] );
end;

procedure TMntTvfForm.TarifaVentasFamiliaCachedDataSetBeforePost(DataSet: TDataSet);
begin
     If   ValueIsEmpty( TarifaVentasFamiliaCachedDatasetPrecio.Value ) and
          ValueIsEmpty( TarifaVentasFamiliaCachedDatasetDescuento.Value )
     then begin
          If   ExisteTarifa
          then TarifaVentasTable.Delete;
          end
     else With TarifaVentasFields do
            begin

            With TarifaVentasTable do
              If   ExisteTarifa
              then Edit
              else Append;

            Tipo.Value := rtvTarifaFamilia;
            CodigoTarifa.Value := CodigoTarifaTableCodigo.Value;
            CodigoArticulo.Value := TarifaVentasFamiliaCachedDatasetCodigo.Value;
            Precio.Value := TarifaVentasFamiliaCachedDatasetPrecio.Value;
            Descuento.Value := TarifaVentasFamiliaCachedDatasetDescuento.Value;

            FOnTarifaBeforePost.Invoke( Dataset );

            TarifaVentasTable.Post;

            end;

end;

procedure TMntTvfForm.CodigoTarifaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosTarifa( [ Sender.EditingValue ] );
end;

procedure TMntTvfForm.CodigoTarifaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosTarifa( Sender, qgsLinked );
end;

procedure TMntTvfForm.CodigoTarifaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoTarifa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

function TMntTvfForm.FormManagerDeleteButton: Boolean;
begin
     If   ShowNotification( ntQuestionWarning, RsTarifaMsg1, RsTarifaMsg2 )=mrYes
     then begin
          // Tipo;CodigoTarifa;CodigoArticulo
          With TarifaVentasTable do
            try
              SetRange( [ rtvTarifaFamilia, CodigoTarifaTableCodigo.Value, DataFamiliaInicial.Value ], [ rtvTarifaFamilia, CodigoTarifaTableCodigo.Value, DataFamiliaFinal.Value ] );
              DeleteRecords;
            finally
              CancelRange;
              CodigoTarifaTable.Cancel;
              end;
          end;
     Abort;
end;

function TMntTvfForm.FormManagerGetAccessLevel: SmallInt;
begin
     With DataModule00.DmUsuarioFields do
       If   ProgramNumber=pnTPV
       then Result := acCAFicheros.Value
       else Result := CheckAccessLevel( [ acVEFicheros.Value, acVETarifas.Value ] );
end;

procedure TMntTvfForm.UpdateQuery;

const TodasLasFamiliasQuery = 'SELECT Familia.Codigo, Familia.Descripcion, TarifaVentas.CodigoArticulo, TarifaVentas.Precio, TarifaVentas.Descuento ' +
                              'FROM   Familia ' +
                              'LEFT JOIN TarifaVentas ON ( TarifaVentas.Tipo=2 AND TarifaVentas.CodigoTarifa=:CodigoTarifa AND TarifaVentas.CodigoArticulo=Familia.Codigo ) ' +
                              'WHERE  Familia.Codigo BETWEEN :FamiliaInicial AND :FamiliaFinal ' +
                              'ORDER BY Familia.Codigo';

      FamiliasConTarifaQuery = 'SELECT Familia.Codigo, Familia.Descripcion, TarifaVentas.CodigoArticulo, TarifaVentas.Precio, TarifaVentas.Descuento ' +
                               'FROM   TarifaVentas ' +
                               '       LEFT JOIN Familia ON ( Familia.Codigo=TarifaVentas.CodigoArticulo ) ' +
                               'WHERE  TarifaVentas.Tipo=2 AND TarifaVentas.CodigoTarifa=:CodigoTarifa AND TarifaVentas.CodigoArticulo BETWEEN :FamiliaInicial AND :FamiliaFinal';

var   DataSourceEnabled : Boolean;

begin
     With TarifaVentasFamiliaCachedDataset do
       If   FormManager.FormInitialized
       then begin
            DataSourceEnabled := CodigoTarifaTable.State in [ dsBrowse, dsEdit ];
            If   DataSourceEnabled
            then begin
                 If   FTarifaTableChanged or Data.Modified
                 then begin
                      Close;

                      With TarifaVentasFamiliaQuery do
                        begin

                        If   SoloFamiliasConTarifaCtrl.Checked
                        then SQL.Text := FamiliasConTarifaQuery
                        else SQL.Text := TodasLasFamiliasQuery;

                        Params.ParamByName( 'CodigoTarifa' ).Value := CodigoTarifaTableCodigo.Value;
                        Params.ParamByName( 'FamiliaInicial' ).Value := DataFamiliaInicial.Value;
                        Params.ParamByName( 'FamiliaFinal' ).Value := DataFamiliaFinal.Value;

                        end;

                      Open;

                      Data.Modified := False;
                      FTarifaTableChanged := False;
                      TarifaVentasFamiliaDataSource.Enabled := True;
                      end;
                 end
            else TarifaVentasFamiliaDataSource.Enabled := False;
            end;
end;

end.

