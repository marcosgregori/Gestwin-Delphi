unit a_tct;

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

  Gim30Fields, dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, cxNavigator, dxDateRanges,
  GridTableViewController, dxScrollbarAnnotations,

  Spring,

  AppForms, dxUIAClasses;

type

  TGetSQLCommandEvent = function ( DataSet : TDataSet ) : String of object;

  TMntTctForm = class(TgxForm)
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    TarifaClaseTable: TnxeTable;
    CodigoClaseACtrl: TcxDBTextEdit;
    CodigoClaseBCtrl: TcxDBTextEdit;
    CodigoArticuloCtrl: TcxDBTextEdit;
    TarifaClaseQuery: TnxeQuery;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewManager: TGridTableViewController;
    TarifaDataSource: TDataSource;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCodigoTarifa: TWideStringField;
    DataCodigoArticulo: TWideStringField;
    DataCodigoClaseA: TWideStringField;
    DataCodigoClaseB: TWideStringField;
    GridViewCodigo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewPrecio: TcxGridDBColumn;
    GridViewDescuento: TcxGridDBColumn;
    TarifaClaseCachedDataset: TnxeCachedDataSet;
    TarifaClaseCachedDatasetNroClase: TSmallintField;
    TarifaClaseCachedDatasetCodigo: TWideStringField;
    TarifaClaseCachedDatasetDescripcion: TWideStringField;
    TarifaClaseCachedDatasetPrecio: TFloatField;
    TarifaClaseCachedDatasetDescuento: TBCDField;
    CapClaseALabel: TcxLabel;
    CapClaseBLabel: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label4: TcxLabel;
    Label3: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Label2: TcxLabel;
    CodigoTarifaCtrl: TcxDBTextEdit;
    DescCodigoTarifaLabel: TcxLabel;
    CopiarButton: TgBitBtn;
    TarifaClaseAuxTable: TnxeTable;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    procedure FormManagerFocusedAreaChanged;
    function FormManagerGetAccessLevel: SmallInt;
    procedure CodigoArticuloCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoClaseACtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClaseACtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoClaseBCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClaseBCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TarifaClaseCachedDatasetBeforePost(DataSet: TDataSet);
    procedure TarifaClaseCachedDatasetBeforeEdit(DataSet: TDataSet);
    procedure CodigoClaseACtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoClaseBCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoTarifaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoTarifaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoTarifaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoTarifaCtrlPropertiesExit(Sender: TcxCustomEdit);
    procedure CodigoTarifaCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure CopiarButtonClick(Sender: TObject);
    procedure KeyCtrlPropertiesChange(Sender: TObject);
  private

    FOnTarifaCodigoTarifaClaseModified : Event<TStringEvent>;
    FOnGetSQLCommand : Event< TGetSQLCommandEvent >;

    procedure DoOnCodigoTarifaSelected( Target : TcxCustomEdit = nil );

  public

    TarifaClaseFields,
    TarifaClaseAuxFields : TTarifaClaseFields;

    DsArticuloFields : TArticuloFields;

    ExisteTarifa : Boolean;
    NroClaseActiva : SmallInt;

    property OnGetSQLCommand : Event<TGetSQLCommandEvent> read FOnGetSQLCommand write FOnGetSQLCommand;
    property OnTarifaCodigoTarifaClaseModified : Event<TStringEvent> read FOnTarifaCodigoTarifaClaseModified write FOnTarifaCodigoTarifaClaseModified;

  end;

var
  MntTctForm: TMntTctForm = nil;

procedure MntTarifasCodigoTarifaClaseVentas;

implementation

{$R *.DFM}

uses   SysUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gim10Fields,
       Gdm30Frm,

       dmi_pga,
       dmi_art,

       b_msg,

       dm_pga,
       dm_art,
       dm_cdt,
       dm_cls,

       a_cdt,
       a_art,
       a_cls,

       cx_art,
       cx_cdt,
       cx_cls1,

       l_tct;

resourceString
    RsMsg1 = 'Todos los clientes.';
    RsMsg2 = '¿Está seguro de que desea copiar la tarifa %s sobre la %s?';
    RsMsg3 = 'Cuidado, este proceso es irreversible.'#13'Si alguna tarifa no existe en el artículo origen pero sí en el destino, esta última no será suprimida.';
    RsMsg4 = 'La copia se ha realizado satisfactoriamente.';
    RsMsg5 = 'Puede obtener un listado de tarifas para verificar los cambios.';

procedure MntTarifasCodigoTarifaClaseVentas;
begin
     CreateEditForm( TMntTctForm, MntTctForm, [], TGds30Frm.VentasSection );
end;

procedure TMntTctForm.FormManagerInitializeForm;
begin

     Id := idMntTctForm;

     TarifaClaseFields := TTarifaClaseFields.Create( TarifaClaseTable );
     TarifaClaseAuxFields := TTarifaClaseFields.Create( TarifaClaseAuxTable );

     DsArticuloFields := TArticuloFields.Create( Self );

     Clase.SetupEditControl( CodigoClaseACtrl, tcClaseA, 0 );
     Clase.SetupEditControl( CodigoClaseBCtrl, tcClaseB, 0 );

     With DataModule00.DmEmpresaFields do
       begin

       CodigoClaseACtrl.Enabled := Articulo_ExisteClase[ tcClaseB ].Value;
       CodigoClaseBCtrl.Enabled := Articulo_ExisteClase[ tcClaseC ].Value;

       SetColumnDecimals( GridViewPrecio, Ventas_DecPrecio.Value );
       SetColumnDecimals( GridViewDescuento, Ventas_DecDto.Value );
       end;
end;

procedure TMntTctForm.FormManagerReportRequest;
begin
     ListadoTarifaClaseVentas;
end;

procedure TMntTctForm.TarifaClaseCachedDatasetBeforeEdit(DataSet: TDataSet);
begin
     ExisteTarifa := False;
     With TarifaClaseTable do
       case NroClaseActiva of
         tcClaseA : ExisteTarifa := FindKey( [ rtclVentasCodigoTarifa, DataCodigoTarifa.Value, DataCodigoArticulo.Value, TarifaClaseCachedDatasetCodigo.Value, '', '' ] );
         tcClaseB : ExisteTarifa := FindKey( [ rtclVentasCodigoTarifa, DataCodigoTarifa.Value, DataCodigoArticulo.Value, DataCodigoClaseA.Value, TarifaClaseCachedDatasetCodigo.Value, '' ] );
         tcClaseC : ExisteTarifa := FindKey( [ rtclVentasCodigoTarifa, DataCodigoTarifa.Value, DataCodigoArticulo.Value, DataCodigoClaseA.Value, DataCodigoClaseB.Value, TarifaClaseCachedDatasetCodigo.Value ] );
         end;
end;

procedure TMntTctForm.TarifaClaseCachedDatasetBeforePost(DataSet: TDataSet);
begin
     If   ValueIsEmpty( TarifaClaseCachedDatasetPrecio.Value ) and ValueIsEmpty( TarifaClaseCachedDatasetDescuento.Value )
     then begin
          If   ExisteTarifa
          then TarifaClaseTable.Delete;
          end
     else With TarifaClaseFields do
            begin

            With TarifaClaseTable do
              If   ExisteTarifa
              then Edit
              else Append;

            Seccion.Value := rtclVentasCodigoTarifa;
            CodigoPropietario.Value := DataCodigoTarifa.Value;
            CodigoArticulo.Value := DataCodigoArticulo.Value;

            case NroClaseActiva of
              tcClaseA : begin
                         ClaseA.Value := TarifaClaseCachedDatasetCodigo.Value;
                         ClaseB.Value := '';
                         ClaseC.Value := '';
                         end;
              tcClaseB : begin
                         ClaseA.Value := DataCodigoClaseA.Value;
                         ClaseB.Value := TarifaClaseCachedDatasetCodigo.Value;
                         ClaseC.Value := '';
                         end;
              tcClaseC : begin
                         ClaseA.Value := DataCodigoClaseA.Value;
                         ClaseB.Value := DataCodigoClaseB.Value;
                         ClaseC.Value := TarifaClaseCachedDatasetCodigo.Value;
                         end;
              end;

            Precio.Value := TarifaClaseCachedDatasetPrecio.Value;
            Descuento.Value := TarifaClaseCachedDatasetDescuento.Value;

            FOnTarifaCodigoTarifaClaseModified.Invoke( CodigoArticulo.Value );

            TarifaClaseTable.Post;
            end;
end;

procedure TMntTctForm.CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TMntTctForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scVentas, False, Sender );
end;

procedure TMntTctForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, DsArticuloFields );
end;

procedure TMntTctForm.CodigoClaseACtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ tcClaseA, Sender.EditingValue ] );
end;

procedure TMntTctForm.CodigoClaseACtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( tcClaseA, Sender );
end;

procedure TMntTctForm.CodigoClaseACtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( tcClaseA, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTctForm.CodigoClaseBCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ tcClaseB, Sender.EditingValue ] );
end;

procedure TMntTctForm.CodigoClaseBCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( tcClaseB, Sender );
end;

procedure TMntTctForm.CodigoClaseBCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( tcClaseB, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTctForm.KeyCtrlPropertiesChange(Sender: TObject);
begin
     If   TarifaDataSource.Enabled
     then TarifaDataSource.Enabled := False;
end;

procedure TMntTctForm.CodigoTarifaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosTarifa( [ Sender.EditingValue ] );
end;

procedure TMntTctForm.CodigoTarifaCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     CopiarButton.Enabled := False;
end;

procedure TMntTctForm.CodigoTarifaCtrlPropertiesExit(Sender: TcxCustomEdit);
begin
     CopiarButton.Enabled := CodigoTarifaCtrl.IsEditValidated;
     If   CopiarButton.Enabled
     then ResetTab;
end;

procedure TMntTctForm.CodigoTarifaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosTarifa( Sender, qgsLinked );
end;

procedure TMntTctForm.CodigoTarifaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean );
begin
     CodigoTarifa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTctForm.CopiarButtonClick(Sender: TObject);
begin
     DataCodigoArticulo.Clear;
     DataCodigoClaseA.Clear;
     DataCodigoClaseB.Clear;

     ConsultaCodigosTarifa( nil, qgsLinked, DoOnCodigoTarifaSelected );
end;

procedure TMntTctForm.DoOnCodigoTarifaSelected( Target : TcxCustomEdit = nil );

var  NuevoCodigoTarifa : String;

begin

     NuevoCodigoTarifa := DataCodigoTarifa.Value;

     If   ShowNotification( ntQuestionWarning, Format( RsMsg2, [ CxCdtForm.QueryCodigo.Value, NuevoCodigoTarifa ] ), RsMsg3 )=mrYes
     then try

            // Seccion;CodigoPropietario;CodigoArticulo;ClaseA;ClaseB;ClaseC

            EnterpriseDataModule.StartTransaction( [ TarifaClaseTable  ] );

            try

              With TarifaClaseTable do
                begin
                SetRange( [ rtclVentasCodigoTarifa, CxCdtForm.QueryCodigo.Value, '', '', '', '' ],
                          [ rtclVentasCodigoTarifa, CxCdtForm.QueryCodigo.Value, HighStrCode, HighStrCode, HighStrCode, HighStrCode ] );

                First;
                While not Eof do
                  begin

                  If   TarifaClaseAuxTable.FindKey( [ rtclVentasCodigoTarifa,
                                                      NuevoCodigoTarifa,
                                                      TarifaClaseFields.CodigoArticulo.Value,
                                                      TarifaClaseFields.ClaseA.Value,
                                                      TarifaClaseFields.ClaseB.Value,
                                                      TarifaClaseFields.ClaseC.Value ] )
                  then TarifaClaseAuxTable.Edit
                  else begin

                       TarifaClaseAuxTable.Append;

                       TarifaClaseAuxFields.Seccion.Value := rtclVentasCodigoTarifa;
                       TarifaClaseAuxFields.CodigoArticulo.Value := TarifaClaseFields.CodigoArticulo.Value;
                       TarifaClaseAuxFields.ClaseA.Value := TarifaClaseFields.ClaseA.Value;
                       TarifaClaseAuxFields.ClaseB.Value := TarifaClaseFields.ClaseB.Value;
                       TarifaClaseAuxFields.ClaseC.Value := TarifaClaseFields.ClaseC.Value;

                       end;

                  TarifaClaseAuxFields.CodigoPropietario.Value := NuevoCodigoTarifa;
                  TarifaClaseAuxFields.Precio.Value := TarifaClaseFields.Precio.Value;
                  TarifaClaseAuxFields.Descuento.Value := TarifaClaseFields.Descuento.Value;

                  TarifaClaseAuxTable.Post;

                  Next;

                  end;

                end;

              EnterpriseDataModule.Commit;

              ShowNotification( ntInformation, RsMsg4, RsMsg5 );

            except
              EnterpriseDataModule.RollBack;
              ShowNotification( ntStop, RsgMsg428, RsgMsg437 );
              end;

          finally
            TarifaClaseTable.CancelRange;
            end;
end;

procedure TMntTctForm.FormManagerFocusedAreaChanged;

var  SQLText : String;

begin
     If   FormManager.DataAreaFocused
     then begin

          If   ValueIsEmpty( DataCodigoClaseA.Value )
          then NroClaseActiva := tcClaseA
          else If   ValueIsEmpty( DataCodigoClaseB.Value )
               then NroClaseActiva := tcClaseB
               else NroClaseActiva := tcClaseC;

          With TarifaClaseCachedDataset do
            begin
            Close;

            If   DsArticuloFields.VisibleTienda.Value and
                 not DsArticuloFields.Tienda_NoPublicarClases.Value
            then SQLText := FOnGetSQLCommand.Invoke( TarifaClaseQuery )
            else With TarifaClaseQuery do
                   case NroClaseActiva of
                     tcClaseA : SQLText := SQLFormat( 'SELECT Clase.Codigo, Clase.NroClase, Clase.Descripcion, TarifaClase.Precio, TarifaClase.Descuento ' +
                                                      'FROM Clase LEFT JOIN TarifaClase ON ( Seccion=3 AND CodigoPropietario=%s AND CodigoArticulo=%s AND TarifaClase.ClaseA=Clase.Codigo AND TarifaClase.ClaseB=' + rsEmptyQuotes + ' AND TarifaClase.ClaseC=' + rsEmptyQuotes + ' ) WHERE NroClase=1 ORDER BY Codigo', [ DataCodigoTarifa, DataCodigoArticulo ] );
                     tcClaseB : SQLText := SQLFormat( 'SELECT Clase.Codigo, Clase.NroClase, Clase.Descripcion, TarifaClase.Precio, TarifaClase.Descuento ' +
                                                      'FROM Clase LEFT JOIN TarifaClase ON ( Seccion=3 AND CodigoPropietario=%s AND CodigoArticulo=%s AND TarifaClase.ClaseA=%s AND TarifaClase.ClaseB=Clase.Codigo AND TarifaClase.ClaseC=' + rsEmptyQuotes + ' ) WHERE NroClase=2 ORDER BY Codigo', [ DataCodigoTarifa, DataCodigoArticulo, DataCodigoClaseA ] );
                     tcClaseC : SQLText := SQLFormat( 'SELECT Clase.Codigo, Clase.NroClase, Clase.Descripcion, TarifaClase.Precio, TarifaClase.Descuento ' +
                                                      'FROM Clase LEFT JOIN TarifaClase ON ( Seccion=3 AND CodigoPropietario=%s AND CodigoArticulo=%s AND TarifaClase.ClaseA=%s AND TarifaClase.ClaseB=%s ' + 'AND TarifaClase.ClaseC=Clase.Codigo ) WHERE NroClase=3 ORDER BY Codigo', [ DataCodigoTarifa, DataCodigoArticulo, DataCodigoClaseA, DataCodigoClaseB ] );
                     end;

            TarifaClaseQuery.SQL.Text := SQLText;

            Open;
            end;

          TarifaDataSource.Enabled := True;
          end;
end;

function TMntTctForm.FormManagerGetAccessLevel: SmallInt;
begin
     With dataModule00.DmUsuarioFields do
       If   ProgramNumber=pnTPV
       then Result := acCAFicheros.Value
       else Result := checkAccessLevel( [ acVEFicheros.Value, acVETarifas.Value ] );
end;

end.
