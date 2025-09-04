unit a_tlf;

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

  Gim30Fields, cxCheckBox, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLabel, cxGroupBox, cxNavigator, dxDateRanges, AppForms,
  GridTableViewController, dxScrollbarAnnotations,

  Spring, dxUIAClasses;

type
  TMntTlfForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    CodigoClienteCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    TarifaVentasTable: TnxeTable;
    TarifaVentasQuery: TnxeQuery;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewManager: TGridTableViewController;
    TarifaDataSource: TDataSource;
    Data: TgxMemData;
    DataSource: TDataSource;
    TarifaVentasCachedDataset: TnxeCachedDataSet;
    Panel1: TcxGroupBox;
    FamiliaInicialCtrl: TcxDBTextEdit;
    gxRangeBox1: TgxRangeBox;
    FamiliaFinalCtrl: TcxDBTextEdit;
    SoloFamiliasConTarifaCtrl: TcxDBCheckBox;
    ClienteTable: TnxeTable;
    ClienteTableCodigo: TWideStringField;
    ClienteTableNombre: TWideStringField;
    ClienteDataSource: TDataSource;
    DataFamiliaInicial: TWideStringField;
    DataFamiliaFinal: TWideStringField;
    DataSoloTarifa: TBooleanField;
    GridViewCodigo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewDescuento: TcxGridDBColumn;
    TarifaVentasCachedDatasetCodigo: TWideStringField;
    TarifaVentasCachedDatasetDescripcion: TWideStringField;
    TarifaVentasCachedDatasetDescuento: TBCDField;
    TarifaVentasAuxTable: TnxeTable;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    Label5: TcxLabel;
    Label2: TcxLabel;
    claseActivaLabel: TcxLabel;
    Label4: TcxLabel;
    Label1: TcxLabel;
    Label3: TcxLabel;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: SmallInt;
    procedure CodigoClienteCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FamiliaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure FamiliaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FamiliaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TarifaVentasCachedDatasetBeforePost(DataSet: TDataSet);
    procedure TarifaVentasCachedDatasetBeforeEdit(DataSet: TDataSet);
    procedure ClienteTableAfterScroll(DataSet: TDataSet);
    procedure RangeValuePosted(Sender: TObject);
    function FormManagerCopyCurrentRecord: Boolean;
    function FormManagerDeleteButton: Boolean;
    procedure ClienteTableGetRecord(DataSet: TDataSet);
    procedure SoloTarifaCtrlPropertiesChange(Sender: TObject);
    procedure ClienteTableRecordChanged(DataSet: TDataSet);
  private

    FClienteTableChanged : Boolean;
    FOnTarifaClienteFamiliaModified : Event<TStringEvent>;

  public

    TarifaVentasFields,
    TarifaVentasAuxFields : TTarifaVentasFields;

    ExisteTarifa : Boolean;
    SQLString : String;

    procedure UpdateQuery;
    procedure DoCopiaTarifa;

    property OnTarifaClienteFamiliaModified : Event<TStringEvent> read FOnTarifaClienteFamiliaModified write FOnTarifaClienteFamiliaModified;
  end;

var
  MntTlfForm: TMntTlfForm = nil;

procedure MntTarifasClienteFamilia( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,
       
       AppManager,
       Variants,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       b_msg,
       b_ctc,

       dmi_pga,

       dm_pga,
       dm_art,
       dm_fam,
       dm_cli,

       a_cli,
       a_fam,

       cx_fam,
       cx_cli,

       l_tlf;

resourceString
    RsMsg1 = 'Todos los clientes.';
    RsMsg2 = '¿Está seguro de que quiere suprimir todas las referencias seleccionadas?';
    RsMsg3 = 'Solo se suprimiran las referencias del cliente incluidas en la selección realizada.';

procedure MntTarifasClienteFamilia( KeyValues : array of const );
begin
     CreateEditForm( TMntTlfForm, MntTlfForm, KeyValues, TGds30Frm.VentasSection );
end;

procedure TMntTlfForm.FormManagerInitializeForm;
begin

     Id := idMntTlfForm;

     TarifaVentasFields := TTarifaVentasFields.Create( TarifaVentasTable );
     TarifaVentasAuxFields := TTarifaVentasFields.Create( TarifaVentasAuxTable );

     With DataModule00.DmEmpresaFields do
       SetColumnDecimals( GridViewDescuento, Ventas_DecDto.Value );

     SQLString := TarifaVentasQuery.SQL.Text;

     With Data do
       begin
       Open;
       Append;
       end;

     DataFamiliaFinal.Value := HighStrCode;
     DataSoloTarifa.Value := True;
end;

procedure TMntTlfForm.FormManagerReportRequest;
begin
     ListadoTarifaClienteFamilia;
end;

procedure TMntTlfForm.SoloTarifaCtrlPropertiesChange(Sender: TObject);
begin
     DeleteButton.Enabled := SoloFamiliasConTarifaCtrl.Checked and FormManager.DataAreaFocused;
     UpdateQuery;
end;

procedure TMntTlfForm.ClienteTableAfterScroll(DataSet: TDataSet);
begin
     UpdateQuery;
end;

procedure TMntTlfForm.ClienteTableGetRecord(DataSet: TDataSet);
begin
     FClienteTableChanged := True;
     DataSoloTarifa.Value := True;
end;

procedure TMntTlfForm.ClienteTableRecordChanged(DataSet: TDataSet);
begin
     FClienteTableChanged := True;
     UpdateQuery;
end;

procedure TMntTlfForm.TarifaVentasCachedDatasetBeforeEdit(DataSet: TDataSet);
begin
     ExisteTarifa := TarifaVentasTable.FindKey( [ rtvClienteFamilia, ClienteTableCodigo.Value, TarifaVentasCachedDatasetCodigo.Value ] );
end;

procedure TMntTlfForm.TarifaVentasCachedDatasetBeforePost(DataSet: TDataSet);
begin
     If   ValueIsEmpty( TarifaVentasCachedDatasetDescuento.Value )
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

            Tipo.Value := rtvClienteFamilia;
            CodigoTarifa.Value := ClienteTableCodigo.Value;
            CodigoArticulo.Value := TarifaVentasCachedDatasetCodigo.Value;
            Descuento.Value := TarifaVentasCachedDatasetDescuento.Value;

            FOnTarifaClienteFamiliaModified.Invoke( ClienteTableCodigo.Value );

            TarifaVentasTable.Post;
            end;
end;

procedure TMntTlfForm.FamiliaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntFamilias( [ Sender.EditingValue ] );
end;

procedure TMntTlfForm.FamiliaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFamilias( Sender );
end;

procedure TMntTlfForm.FamiliaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Familia.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TMntTlfForm.RangeValuePosted(Sender: TObject);
begin
     UpdateQuery;
end;

procedure TMntTlfForm.CodigoClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TMntTlfForm.CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender, qgsLinked );
end;

procedure TMntTlfForm.CodigoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

function TMntTlfForm.FormManagerCopyCurrentRecord: Boolean;
begin
     CopiaTarifaCliente( ClienteTableCodigo.Value, DoCopiaTarifa );
     Result := False;
end;

function TMntTlfForm.FormManagerDeleteButton: Boolean;
begin
     If   ShowNotification( ntQuestionWarning, RsMsg2, RsMsg3 )=mrYes
     then begin
          // Tipo;CodigoTarifa;CodigoArticulo
          With TarifaVentasTable do
            try
              SetRange( [ rtvClienteFamilia, ClienteTableCodigo.Value, DataFamiliaInicial.Value ], [ rtvClienteFamilia, ClienteTableCodigo.Value, DataFamiliaFinal.Value ] );
              DeleteRecords;
            finally
              CancelRange;
              ClienteTable.Cancel;
              end;
          end;
     Abort;
end;

function TMntTlfForm.FormManagerGetAccessLevel: SmallInt;
begin
     With dataModule00.DmUsuarioFields do
       If   ProgramNumber=pnTPV
       then Result := acCAFicheros.Value
       else Result := CheckAccessLevel( [ acVEFicheros.Value, acVETarifas.Value ] );
end;

procedure TMntTlfForm.UpdateQuery;

const TodasLasFamiliasQuery = 'SELECT Familia.Codigo, Familia.Descripcion, TarifaVentas.Descuento ' +
                              'FROM Familia LEFT JOIN TarifaVentas ON ( TarifaVentas.Tipo=3 AND TarifaVentas.CodigoTarifa=:CodigoCliente AND TarifaVentas.CodigoArticulo=Familia.Codigo ) ' +
                              'WHERE Familia.Codigo BETWEEN :FamiliaInicial AND :FamiliaFinal ' +
                              'ORDER BY Codigo';

      FamiliasConTarifaQuery = 'SELECT Familia.Codigo, Familia.Descripcion, TarifaVentas.Descuento ' +
                               'FROM   TarifaVentas ' +
                               '       LEFT JOIN Familia ON ( Familia.Codigo=TarifaVentas.CodigoArticulo ) ' +
                               'WHERE  TarifaVentas.Tipo=3 AND TarifaVentas.CodigoTarifa=:CodigoCliente AND TarifaVentas.CodigoArticulo BETWEEN :FamiliaInicial AND :FamiliaFinal';

var  DataSourceEnabled : Boolean;

begin
     With TarifaVentasCachedDataset do
       begin
       DataSourceEnabled := ClienteTable.State in [ dsBrowse, dsEdit ];
       If   DataSourceEnabled
       then begin
            If   FClienteTableChanged or Data.Modified
            then begin
                 Close;

                 With TarifaVentasQuery do
                   begin

                   If   SoloFamiliasConTarifaCtrl.Checked
                   then SQL.Text := FamiliasConTarifaQuery
                   else SQL.Text := TodasLasFamiliasQuery;

                   Params.ParamByName( 'CodigoCliente' ).Value := ClienteTableCodigo.Value;
                   Params.ParamByName( 'FamiliaInicial' ).Value := DataFamiliaInicial.Value;
                   Params.ParamByName( 'FamiliaFinal' ).Value := DataFamiliaFinal.Value;

                   end;

                 Open;

                 Data.Modified := False;
                 FClienteTableChanged := False;
                 TarifaDataSource.Enabled := True;
                 end;
            end
       else TarifaDataSource.Enabled := False;
       end;

end;

procedure TMntTlfForm.DoCopiaTarifa;

var  CodigoClienteDestino : String;

begin

     With EnterpriseDataModule do
       begin

       try

         StartTransaction( [ TarifaVentasAuxTable ] );

         CodigoClienteDestino := BoxCtcForm.DataCodigoCliente.Value;

         With TarifaVentasTable do
           begin
           SetRange( [ rtvClienteFamilia, ClienteTableCodigo.Value, '' ], [ rtvClienteFamilia, ClienteTableCodigo.Value, HighStrCode ] );
           First;
           While not Eof do
             begin

             If   not ( not BoxCtcForm.DataCopiarReferencias.Value and
                        ValueIsEmpty( TarifaVentasFields.Precio.Value ) and
                        ValueIsEmpty( TarifaVentasFields.Recargo.Value ) and
                        ValueIsEmpty( TarifaVentasFields.Descuento.Value ) )
             then If   not TarifaVentasAuxTable.FindKey( [ rtvClienteFamilia, CodigoClienteDestino, TarifaVentasFields.CodigoArticulo ] )
                  then begin

                       TarifaVentasAuxTable.Append;
                       TarifaVentasAuxTable.CopyFields( TarifaVentasTable );

                       TarifaVentasAuxFields.CodigoTarifa.Value := CodigoClienteDestino;
                       If   not BoxCtcForm.DataCopiarReferencias.Value
                       then TarifaVentasAuxFields.Referencia.Value := '';

                       TarifaVentasAuxTable.Post;
                       end;

             Next;
             end;

           end;

         Commit;

       except
         RollBack;
         ShowNotification( ntStop, RsgMsg428, RsgMsg437 );
         end;

       ClienteTable.FindKey( [ CodigoClienteDestino ] );
       FormManager.SelectFirstKeyControl;

       end;

end;

end.

