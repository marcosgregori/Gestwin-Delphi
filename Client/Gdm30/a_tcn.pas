unit a_tcn;

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
  AppForms, GridTableViewController,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations, dxUIAClasses;

type
  TMntTcnForm = class(TgxForm)
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    TarifaCantidadVentaAuxTable: TnxeTable;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewManager: TGridTableViewController;
    LineaTarifaCantidadDataSource: TDataSource;
    DataSource: TDataSource;
    TarifaCantidadVentaTable: TnxeTable;
    LineaTarifaCantidadVentaTable: TnxeTable;
    LineaTarifaCantidadVentaTableCodigoCliente: TWideStringField;
    LineaTarifaCantidadVentaTableCodigoArticulo: TWideStringField;
    LineaTarifaCantidadVentaTableCodigoClaseA: TWideStringField;
    LineaTarifaCantidadVentaTableCodigoClaseB: TWideStringField;
    LineaTarifaCantidadVentaTableCodigoClaseC: TWideStringField;
    LineaTarifaCantidadVentaTableNroRegistro: TSmallintField;
    LineaTarifaCantidadVentaTableCantidadMinima: TBCDField;
    LineaTarifaCantidadVentaTableCantidadMaxima: TBCDField;
    LineaTarifaCantidadVentaTableDescuento: TBCDField;
    GridViewCantidadMinima: TcxGridDBColumn;
    GridViewCantidadMaxima: TcxGridDBColumn;
    GridViewPrecio: TcxGridDBColumn;
    GridViewDescuento: TcxGridDBColumn;
    GridViewNroRegistro: TcxGridDBColumn;
    claseActivaLabel: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    LineaTarifaCantidadVentaTablePrecio: TFloatField;
    cxGroupBox1: TcxGroupBox;
    CodigoClienteCtrl: TcxDBTextEdit;
    CodigoArticuloCtrl: TcxDBTextEdit;
    Label2: TcxLabel;
    Label1: TcxLabel;
    Label4: TcxLabel;
    Label3: TcxLabel;
    cxGroupBox4: TcxGroupBox;
    capClaseALabel: TcxLabel;
    CodigoClaseACtrl: TcxDBTextEdit;
    DescClaseALabel: TcxLabel;
    cxGroupBox3: TcxGroupBox;
    CodigoClaseBCtrl: TcxDBTextEdit;
    capClaseBLabel: TcxLabel;
    DescClaseBLabel: TcxLabel;
    cxGroupBox5: TcxGroupBox;
    CodigoClaseCCtrl: TcxDBTextEdit;
    capClaseCLabel: TcxLabel;
    DescClaseCLabel: TcxLabel;
    KeyContainer: TcxGroupBox;
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
    procedure CodigoArticuloCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoClaseCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoClaseCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClaseCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormManagerShowForm;
    procedure TarifaCantidadVentaTableNewRecord(DataSet: TDataSet);
    procedure TarifaCantidadVentaTableSetKey(DataSet: TDataSet);
    procedure LineaTarifaCantidadVentaTableFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TableViewManagerDelete(Sender: TObject);
    procedure LineaTarifaCantidadVentaTableNewRecord(DataSet: TDataSet);
    procedure LineaTarifaCantidadVentaTableApplyMasterRange(
      DataSet: TDataSet);
  private

  public

    TarifaCantidadVentaFields,
    TarifaCantidadVentaAuxFields,
    LineaTarifaCantidadVentaFields : TTarifaCantidadVentaFields;

    ExisteTarifa : Boolean;
    NroClaseActiva : SmallInt;

  end;

var
  MntTcnForm: TMntTcnForm = nil;

procedure MntTarifasVentaConsumo( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,
       
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gim10Fields,
       Gdm30Frm,

       b_msg,

       dmi_pga,

       dm_pga,
       dm_art,
       dm_cli,
       dm_cls,

       a_cli,
       a_art,
       a_cls,

       cx_art,
       cx_cli,
       cx_cls1,

       l_tcn;

resourceString
    RsMsg1 = 'Todos los clientes.';
    RsMsg2 = 'Todos los artículos.';
    //..
    RsMsg5 = 'Solo se pueden suprimir líneas del final de la lista.';
    RsMsg6 = 'Esta limitación intenta evitar que se puedan crear, por accidente, rangos inconsistentes.';

procedure MntTarifasVentaConsumo( KeyValues : array of const );
begin
     CreateEditForm( TMntTcnForm, MntTcnForm, KeyValues, TGds30Frm.VentasSection );
end;

procedure TMntTcnForm.FormManagerInitializeForm;
begin
     TarifaCantidadVentaFields := TTarifaCantidadVentaFields.Create( TarifaCantidadVentaTable );
     TarifaCantidadVentaAuxFields := TTarifaCantidadVentaFields.Create( TarifaCantidadVentaAuxTable );
     LineaTarifaCantidadVentaFields := TTarifaCantidadVentaFields.Create( LineaTarifaCantidadVentaTable );

     With DataModule00.DmEmpresaFields do
       begin
       SetColumnDecimals( GridViewCantidadMinima, Ventas_DecCantidad.Value, True );
       SetColumnDecimals( GridViewCantidadMaxima, Ventas_DecCantidad.Value );
       SetColumnDecimals( GridViewPrecio, Ventas_DecPrecio.Value );
       SetColumnDecimals( GridViewDescuento, Ventas_DecDto.Value );
       end;

     Clase.SetupEditControls( CodigoClaseACtrl, CodigoClaseBCtrl, CodigoClaseCCtrl, 0, True );

     KeyPanel.Height := KeyContainer.Height + 4;

     TarifaCantidadVentaTable.SetDefaultRangeValues( [ '', '', '', '', '', 0 ], [ HighStrCode, HighStrCode, HighStrCode, HighStrCode, HighStrCode, 0 ] );
     SetFieldRange( LineaTarifaCantidadVentaTableNroRegistro );
end;

procedure TMntTcnForm.FormManagerReportRequest;
begin
     ListadoTarifaVentaConsumo;
end;

procedure TMntTcnForm.FormManagerShowForm;
begin
     If   Assigned( FormValues )
     then If   FormValues[ 0 ]<>''
          then With TarifaCantidadVentaFields do
                 begin
                 CodigoCliente.Value := FormValues[ 0 ];
                 CodigoArticulo.Value := FormValues[ 1 ];
                 end;
end;                                                  

procedure TMntTcnForm.LineaTarifaCantidadVentaTableApplyMasterRange(DataSet: TDataSet);
begin
     // CodigoCliente;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;NroRegistro
     If   LineaTarifaCantidadVentaTable.Active
     then With TarifaCantidadVentaFields do
            LineaTarifaCantidadVentaTable.SetRange( [ CodigoCliente.Value, CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, 1 ],
                                                    [ CodigoCliente.Value, CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, MaxSmallint ] );
end;

procedure TMntTcnForm.LineaTarifaCantidadVentaTableFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
     Accept := LineaTarifaCantidadVentaTableNroRegistro.Value>0;
end;

procedure TMntTcnForm.LineaTarifaCantidadVentaTableNewRecord(DataSet: TDataSet);
begin
     If   not LineaTarifaCantidadVentaTable.ControlsDisabled
     then With TarifaCantidadVentaAuxTable, LineaTarifaCantidadVentaFields do
            try
              // CodigoCliente;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;NroRegistro
              SetRange( [ CodigoCliente.Value, CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value ],
                        [ CodigoCliente.Value, CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value ] );
              Last;
              CantidadMinima.Value := TarifaCantidadVentaAuxFields.CantidadMaxima.Value + Precision( DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value );
            finally
              CancelRange;
              end;
end;

procedure TMntTcnForm.TableViewManagerDelete(Sender: TObject);
begin
     With GridView.Controller do
       If   Assigned( FocusedRow )
       then If   not FocusedRow.IsLast
            then begin
                 ShowNotification( ntStop, RsMsg5, RsMsg6 );
                 Abort;
                 end;
end;

procedure TMntTcnForm.TarifaCantidadVentaTableNewRecord(DataSet: TDataSet);

var  UsaPlantilla : Boolean;

function CopiaPlantilla( CodigoClientePlantilla : String ) : Boolean;
begin
     Result := False;
     With TarifaCantidadVentaAuxTable do
       begin
         try

           LineaTarifaCantidadVentaTable.DisableControls;

           SetRange( [ CodigoClientePlantilla, '', '', '', '', 1 ], [ CodigoClientePlantilla, '', '', '', '', MaxSmallint ] );
           First;
           While not Eof do
             begin

             LineaTarifaCantidadVentaTable.Append;

             LineaTarifaCantidadVentaTable.CopyFields( TarifaCantidadVentaAuxTable );

             LineaTarifaCantidadVentaFields.CodigoCliente.Value := TarifaCantidadVentaFields.CodigoCliente.Value;
             LineaTarifaCantidadVentaFields.CodigoArticulo.Value := TarifaCantidadVentaFields.CodigoArticulo.Value;
             LineaTarifaCantidadVentaFields.CodigoClaseA.Value := TarifaCantidadVentaFields.CodigoClaseA.Value;
             LineaTarifaCantidadVentaFields.CodigoClaseB.Value := TarifaCantidadVentaFields.CodigoClaseB.Value;
             LineaTarifaCantidadVentaFields.CodigoClaseC.Value := TarifaCantidadVentaFields.CodigoClaseC.Value;

             try
               UsaPlantilla := True;
               Result := True;
               LineaTarifaCantidadVentaTable.Post;   // Si ya existe uno no pasa nada
             except
               end;

             Next;
             end;

         finally
           LineaTarifaCantidadVentaTable.EnableControls;
           end;
         end;
end;

begin
      With TarifaCantidadVentaFields do
       begin

       NroRegistro.Value := 0;
       UsaPlantilla := False;

       If   not ValueIsEmpty( CodigoArticulo.Value )
       then If   not CopiaPlantilla( CodigoCliente.Value )
            then CopiaPlantilla( '' );

       If   UsaPlantilla
       then GridView.DataController.UpdateItems( False );

       end;
end;

procedure TMntTcnForm.TarifaCantidadVentaTableSetKey(DataSet: TDataSet);
begin
     TarifaCantidadVentaFields.NroRegistro.Value := 0;
end;

procedure TMntTcnForm.CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TMntTcnForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scVentas, False, Sender );
end;

procedure TMntTcnForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then begin
          CodigoArticuloCtrl.Description := RsMsg2;
          With CodigoClaseACtrl do
            begin
            Clear;
            Enabled := False;
            end;
          With CodigoClaseBCtrl do
            begin
            Clear;
            Enabled := False;
            end;
          With CodigoClaseCCtrl do
            begin
            Clear;
            Enabled := False;
            end;
          GridViewPrecio.Options.Editing := False;
          GridViewDescuento.Options.Editing := False;
          end
     else begin
          Articulo.Valida( Sender, DisplayValue, ErrorText, Error );
          GridViewPrecio.Options.Editing := True;
          GridViewDescuento.Options.Editing := True;
          end;

     TableViewManager.CheckFixedColumnsStyle;
     
end;

procedure TMntTcnForm.CodigoClaseCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( Sender.Tag ), Sender.EditingValue ] );
end;

procedure TMntTcnForm.CodigoClaseCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( TNroClase( Sender.Tag ), False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTcnForm.CodigoClaseCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( TNroClase( Sender.Tag ), Sender );
end;

procedure TMntTcnForm.CodigoClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TMntTcnForm.CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TMntTcnForm.CodigoClienteCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                           var DisplayValue : Variant;
                                                           var ErrorText    : TCaption;
                                                           var Error        : Boolean );
begin
     If   ValueIsEmpty( DisplayValue )
     then CodigoClienteCtrl.Description := RsMsg1
     else Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

function TMntTcnForm.FormManagerGetAccessLevel: SmallInt;
begin
     With DataModule00.DmUsuarioFields do
       If   ProgramNumber=pnTPV
       then Result := AcCAFicheros.Value
       else Result := CheckAccessLevel( [ AcVEFicheros.Value, AcVETarifas.Value ] );
end;

end.
