
unit b_nda;

interface

uses StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     cxStyles,
     cxCustomData,
     cxGraphics,
     cxFilter,
     cxData,
     cxDataStorage,
     cxEdit,
     DB,                                                               
     cxDBData,
     nxdb,

     cxGridLevel,                                                                   
     cxClasses,
     cxControls,
     cxGridCustomView,
     cxGridCustomTableView,
     cxGridTableView,
     cxGridDBTableView,
     cxGrid, DBCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox,

     cxRichEdit, dxmdaset, cxContainer, cxDBEdit, dxSkinsCore,
     dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels, cxLabel,
     cxGroupBox, cxDBLabel, cxTextEdit, cxSplitter, Generics.Collections, cxNavigator, cxCheckComboBox, dxBevel,
     cxMaskEdit, cxDropDownEdit, cxCalendar, cxIntegerEdit, dxBarBuiltInMenu, cxPC, cxRadioGroup, dxDateRanges, dxScrollbarAnnotations, 

     DataManager,
     AppContainer,
     LibUtils,
     ReportManager,
     AppForms,
     GridTableViewController,

     Gim10Fields,
     Gim30Fields,
     Gim40Fields,

     dmi_nda,

     EnterpriseDataAccess,

     dmi_mov,
     dm_mov, dxUIAClasses;

type

  TSelectOperation = ( soCheck, soUncheck, soSwitch );
  TCheckSelect = reference to function( var Select : TSelectOperation ) : Boolean;

  TBoxNdaForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    AprovisionamientoDataSource: TDataSource;
    DataPanel: TgxEditPanel;
    LinesGrid: TcxGrid;
    LinesView: TcxGridDBTableView;
    LinesLevel: TcxGridLevel;
    FooterPanel: TcxGroupBox;
    LinesViewManager: TGridTableViewController;
    Data: TgxMemData;
    DataSource: TDataSource;
    HintLabel: TcxLabel;
    TodoButton: TgBitBtn;
    DataCodigoProveedor: TStringField;
    LineaMovimientoTable: TnxeTable;
    MovimientoTable: TnxeTable;
    Report: TgxReportManager;
    AprovisionamientoTable: TnxeTable;
    DataCodigoAlmacenOrigen: TStringField;
    DataCodigoAlmacenDestino: TStringField;
    AprovisionamientoTableNroRegistro: TUnsignedAutoIncField;
    AprovisionamientoTableCodigoArticulo: TWideStringField;
    AprovisionamientoTableExistenciasOrigen: TBCDField;
    AprovisionamientoTableExistenciasDestino: TBCDField;
    AprovisionamientoTableSeleccionada: TBooleanField;
    LinesViewNroRegistro: TcxGridDBColumn;
    LinesViewCodigoArticulo: TcxGridDBColumn;
    LinesViewExistenciasOrigen: TcxGridDBColumn;
    LinesViewExistenciasDestino: TcxGridDBColumn;
    LinesViewSeleccionada: TcxGridDBColumn;
    LinesViewDescripcion: TcxGridDBColumn;
    KeyPanel: TgxEditPanel;
    AprovisionamientoTableStockMinimoDestino: TBCDField;
    AprovisionamientoTableStockMinimoOrigen: TBCDField;
    AprovisionamientoTableDisponiblesEnOrigen: TBCDField;
    AprovisionamientoTableNoDisponiblesEnOrigen: TBCDField;
    LinesViewStockMinimoDestino: TcxGridDBColumn;
    LinesViewStockMinimoOrigen: TcxGridDBColumn;
    DataProceso: TSmallintField;
    DataFecha: TDateField;
    AprovisionamientoTableReposicion: TBCDField;
    LinesViewDisponibleEnOrigen: TcxGridDBColumn;
    LinesViewNecesidadEnDestino: TcxGridDBColumn;
    LinesViewReposicion: TcxGridDBColumn;
    AprovisionamientoTableDescripcion: TWideStringField;
    PageControl: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    cxLabel8: TcxLabel;
    CodigoAlmacenOrigenCtrl: TcxDBTextEdit;
    DescAlmacenLabel: TcxLabel;
    cxLabel1: TcxLabel;
    CodigoAlmacenDestinoCtrl: TcxDBTextEdit;
    cxLabel7: TcxLabel;
    CodigoProveedorCtrl: TcxDBTextEdit;
    Label3: TcxLabel;
    Label16: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    cxLabel9: TcxLabel;
    FechaCtrl: TcxDBDateEdit;
    cxLabel2: TcxLabel;
    DataCodigoAlmacen: TStringField;
    AprovisionamientoTableCodigoAlmacenOrigen: TWideStringField;
    AprovisionamientoTableCodigoAlmacenDestino: TWideStringField;
    AprovisionamientoTableCabeceraAlmacen: TStringField;
    LinesViewCabeceraAlmacen: TcxGridDBColumn;
    AprovisionamientoTablePendienteRecibir: TBCDField;
    LinesViewPendienteRecibir: TcxGridDBColumn;
    DataExistenciasVirtuales: TBooleanField;
    SeleccionAlmacenCtrl: TcxDBRadioGroup;
    CodigoAlmacenCtrl: TcxDBTextEdit;
    Label1: TcxLabel;
    cxLabel10: TcxLabel;
    DataSeleccionAlmacen: TSmallintField;
    cxLabel3: TcxLabel;
    SerieCtrl: TcxDBTextEdit;
    DataSerie: TStringField;
    ExistenciasVirtualesCtrl: TcxDBCheckBox;
    cxLabel6: TcxLabel;
    AprovisionamientoTablePendienteServir: TBCDField;
    LinesViewPendienteServir: TcxGridDBColumn;
    DataGenerarInformeNoCubierto: TBooleanField;
    GenerarInformeNoCubiertoCtrl: TcxDBCheckBox;
    AprovisionamientoTableNoCubierto: TBooleanField;
    AprovisionamientoTableImporteNeto: TBCDField;
    LinesViewImporteNeto: TcxGridDBColumn;
    procedure LinesViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure AprovisionamientoTableCalcFields(DataSet: TDataSet);
    procedure FormManagerInitializeForm;
    procedure FormManagerCreateForm;
    procedure FormManagerDestroyForm;
    procedure FormManagerOkButton;
    procedure TodoButtonClick(Sender: TObject);
    procedure LinesViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure CodigoProveedorCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoAlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoAlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure SeleccionAlmacenCtrlPropertiesChange(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure FormManagerAfterValidateDataArea(FieldArea: TFieldArea; var ErrorText : TCaption; var ErrorResult : Boolean; NotifyError, UpdateData: Boolean; out InvalidCustomEdit : TcxCustomEdit);
    procedure LinesViewCabeceraAlmacenGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure FormManagerFocusedAreaChanged;
    procedure AprovisionamientoTableBeforePost(DataSet: TDataSet);
    procedure PageControlPageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
    procedure LinesViewDataControllerSummaryDefaultGroupSummaryItemsSummary(
      ASender: TcxDataSummaryItems; Arguments: TcxSummaryEventArguments;
      var OutArguments: TcxSummaryEventOutArguments);
  private

    FTipoSeleccion : TTipoSeleccionBajoMinimos;
    FAllSelected,
    FChangingDataArea : Boolean;
    
    FSeleccionadas : Integer;
    
    procedure UpdateSelection;
    procedure SelectLines( SelectFunction : TCheckSelect );
    procedure DoProcesoGeneracionPedidos;
    procedure DisableDataGrid;
    procedure ReiniciaSeleccion;
    
  protected
    
  public

    AprovisionamientoFields : TAprovisionamientoFields;
    MovimientoFields : TMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;

  end;

var BoxNdaForm: TBoxNdaForm = nil;

procedure GeneracionNecesidadesAprovisionamiento;

implementation

{$R *.DFM}

uses   SysUtils,
       AppManager,
       Variants,
       Math,

       dxBar,
       
       Gdm00Dm,
       Gdm30Dm,
       Gim00Fields,
              
       Gdm40Frm,
       
       dm_cls,
       dm_cli,
       dm_art,
       dm_pro,
       dm_fdv,
       dm_reg,
       dm_alm,
       dm_nda,
       
       a_pro,
       a_mco,
       
       cx_pro,
       cx_alm,
       
       b_msg,
       b_pro,

       f_prg;

resourceString
       RsMsg1  = 'No hay ningun registro que cumpla las condiciones impuestas.';
       RsMsg2  = 'Cambie el criterio de selección y reintente el proceso.';
       RsMsg3  = 'No ha seleccionado ninguna línea.';
       RsMsg4  = 'Relación de necesidades no cubiertas';
       RsMsg5  = 'Creado el pedido nº %s %d del proveedor %s, %s.';
       RsMsg6  = 'Los almacenes origen y destino deben ser distintos';
       RsMsg7  = 'Ha modificado la relación de registros';
       RsMsg8  = '¿Está seguro de que desea volver a generar la lista?';

procedure GeneracionNecesidadesAprovisionamiento;
begin
     CreateEditForm( TBoxNdaForm, BoxNdaForm );
end;

procedure TBoxNdaForm.FormManagerInitializeForm;

var   Decimales : SmallInt;

begin

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );

     With DataModule00.DmEmpresaFields do
       begin

       Decimales := Max( Compras_DecCantidad.Value, Ventas_DecCantidad.Value );

       SetColumnsDecimals( [ LinesViewStockMinimoOrigen, LinesViewExistenciasOrigen,
                             LinesViewStockMinimoDestino,LinesViewExistenciasDestino,
                             LinesViewDisponibleEnOrigen, LinesViewNecesidadEnDestino,
                             LinesViewPendienteRecibir, LinesViewPendienteServir,
                             LinesViewReposicion ], Decimales);
       SetColumnDecimals( LinesViewImporteNeto );

       // LinesView.DataController.Summary.DefaultGroupSummaryItems[ 0 ].Format := FloatDisplayFormat( DecimalesMoneda, True );
       end;

     LinesGrid.Hint := SeleccioneLasLineasHintMsg;
     HintLabel.Caption := RemoveHintTags( SeleccioneLasLineasHintMsg );

     FTipoSeleccion := tsPedidosCompra;

     DataProceso.Value := 0;
     DataSeleccionAlmacen.Value := 0;
     DataFecha.Value := ApplicationContainer.TodayDate;
     DataGenerarInformeNoCubierto.Value := True;

end;

procedure TBoxNdaForm.UpdateSelection;

var  SeleccionProveedor,
     RemoteTableName : String;
     AlmacenOrigen,
     AlmacenDestino : String;
     ExistenciasVirtuales : Boolean;
     
begin
     
     AprovisionamientoDataSource.Enabled := False;
     ModalResult := mrNone;
          
     ReiniciaSeleccion;

     LinesViewStockMinimoOrigen.Visible := FTipoSeleccion=tsTraspasoAlmacenes;
     LinesViewExistenciasOrigen.Visible := LinesViewStockMinimoOrigen.Visible;
     LinesViewDisponibleEnOrigen.Visible := LinesViewStockMinimoOrigen.Visible;     
     LinesViewNecesidadEnDestino.Visible := LinesViewStockMinimoOrigen.Visible;
     
     LinesViewPendienteRecibir.Visible := ( ( FTipoSeleccion=tsTraspasoAlmacenes ) and DataExistenciasVirtuales.Value ) or ( FTipoSeleccion=tsPedidosCompra );
     LinesViewPendienteServir.Visible := LinesViewPendienteRecibir.Visible;
     
     If   ( FTipoSeleccion=tsPedidosCompra ) and ( DataSeleccionAlmacen.Value=0 )  // Todos los almacenes
     then LinesViewCabeceraAlmacen.GroupIndex := 0
     else LinesViewCabeceraAlmacen.GroupIndex := -1;
          
     case FTipoSeleccion of

       tsPedidosCompra :
         begin
         AlmacenOrigen := '';   // No es un traspaso
         AlmacenDestino := DataCodigoAlmacen.Value;
         ExistenciasVirtuales := True;
         end;
         
       tsTraspasoAlmacenes  :
         begin
         AlmacenOrigen := DataCodigoAlmacenOrigen.Value;
         AlmacenDestino := DataCodigoAlmacenDestino.Value;
         ExistenciasVirtuales := DataExistenciasVirtuales.Value
         end;       

       end;
          
     RemoteTableName := Aprovisionamiento.SeleccionaArticulosBajoMinimos( FTipoSeleccion, 
                                                                          AlmacenOrigen, 
                                                                          AlmacenDestino, 
                                                                          ExistenciasVirtuales, 
                                                                          DataCodigoProveedor.Value, 
                                                                          DataSeleccionAlmacen.Value=0 );
     
     If   RemoteTableName<>''
     then With AprovisionamientoTable do
            begin

            Close;
                        
            PreserveTemporalTableName := True;            
            TableName := RemoteTableName;
       
            Open;
            If   RecordCount=0
            then begin
                 Close;
                 ShowNotification( ntWarning, RsMsg1, RsMsg2 );
                 FormManager.SelectFirstKeyControl;
                 end
            else begin

                 AprovisionamientoFields := TAprovisionamientoFields.Create( AprovisionamientoTable );
                 
                 AprovisionamientoDataSource.Enabled := True;
                 LinesView.ViewData.Expand( True );
                 end;
            end;

end;

procedure TBoxNdaForm.CodigoAlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TBoxNdaForm.CodigoAlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scVentas, Sender, DisplayValue, ErrorText, Error );     
end;

procedure TBoxNdaForm.CodigoProveedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProveedores( [ Sender.EditingValue ] );
end;

procedure TBoxNdaForm.CodigoProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TBoxNdaForm.CodigoProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then CodigoProveedorCtrl.Description := RsgMsgTodos
     else Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxNdaForm.DisableDataGrid;
begin
     AprovisionamientoDataSource.Enabled := False;
     ReiniciaSeleccion;
end;

procedure TBoxNdaForm.FormManagerAfterValidateDataArea(FieldArea: TFieldArea; var ErrorText : TCaption; var ErrorResult : Boolean; NotifyError, UpdateData: Boolean; out InvalidCustomEdit : TcxCustomEdit);
begin      
     If   ( FieldArea=faKey ) and ( PageControl.ActivePageIndex=1 )
     then If   DataCodigoAlmacenOrigen.Value=DataCodigoAlmacenDestino.Value
          then begin
               ErrorResult := True;
               ErrorText := RsMsg6;
               InvalidCustomEdit := CodigoAlmacenOrigenCtrl;
               end;
end;

procedure TBoxNdaForm.FormManagerCreateForm;
begin
     //..
end;

procedure TBoxNdaForm.FormManagerDestroyForm;
begin
     //..
end;

procedure TBoxNdaForm.FormManagerFocusedAreaChanged;
begin
     If   not FChangingDataArea
     then try
            FChangingDataArea := True;
            If   FormManager.DataAreaFocused  
            then UpdateSelection                 
            else If   ( ModalResult=mrNone ) and 
                      ( FSeleccionadas>0 ) and 
                      ( ShowNotification( ntQuestionWarning, RsMsg7, RsMsg8 )<>mrYes )
                 then begin
                      LinesGrid.SetFocus;
                      Abort;
                      end
                 else begin
                      {
                      If   Assigned( ActiveControl ) and ( ActiveControl is TcxCustomInnerTextEdit )
                      then TcxCustomInnerTextEdit( ActiveControl ).SelLength := 0;
                      }                      
                      DisableDataGrid;
                      end;
          finally
            FChangingDataArea := False;            
            end;
            
end;

procedure TBoxNdaForm.FormManagerOkButton;

const Msg : Array[ tsPedidosCompra..tsTraspasoAlmacenes ] of String  = ( 'Generación de pedidos de compra', 'Generación del movimiento de salida' );
       
begin
     CreateProcessForm( DoProcesoGeneracionPedidos, Msg[ FTipoSeleccion ] );
end;

procedure TBoxNdaForm.DoProcesoGeneracionPedidos;
begin
     If   FTipoSeleccion=tsPedidosCompra
     then Aprovisionamiento.GeneraPedidosCompra( DataSerie.Value, DataFecha.Value, AprovisionamientoTable.TableName )
     else begin
          Aprovisionamiento.GeneraTraspasoAlmacen( DataFecha.Value, AprovisionamientoTable.TableName );
          If   DataGenerarInformeNoCubierto.Value
          then  With Report do
                  try
                    Load;
                    Title := RsMsg4;
                    AssignTable( 'Aprovisionamiento', AprovisionamientoTable );
                    Start;
                  except on E : Exception do Cancel( E );
                    end;
          end;
end;

procedure TBoxNdaForm.SelectLines( SelectFunction : TCheckSelect );

var  Index : Integer;
     Bm : TBookmark;
     Select : TSelectOperation;

begin

     With AprovisionamientoTable do
       try
         DisableControls;
         Bm := GetBookmark;
         First;
         While not Eof do
           begin
           
           If   AprovisionamientoFields.Reposicion.Value>0.0
           then begin
           
                Edit;

                If   SelectFunction( Select )
                then case Select of
                       soCheck,
                       soUncheck    : AprovisionamientoFields.Seleccionada.Value := Select=soCheck;
                       soSwitch     : AprovisionamientoFields.Seleccionada.Value := not AprovisionamientoFields.Seleccionada.Value;
                       end;

                Post;
           
                end;
           
           Next;
           end;
       finally
         EnableControls;
         GotoBookmark( Bm );         
       end;

end;

procedure TBoxNdaForm.TodoButtonClick(Sender: TObject);
begin
     FAllSelected := not FAllSelected;
     SelectLines( function( var Select : TSelectOperation ) : Boolean
                  begin
                    If   FAllSelected
                    then Select := soCheck
                    else Select := soUncheck;
                    Result := True; // Todas las líneas
                  end );
end;

procedure TBoxNdaForm.SeleccionAlmacenCtrlPropertiesChange(Sender: TObject);
begin
     CodigoAlmacenCtrl.Enabled := SeleccionAlmacenCtrl.ItemIndex=1;
end;

procedure TBoxNdaForm.AprovisionamientoTableBeforePost(DataSet: TDataSet);
begin     
     If   AprovisionamientoTableSeleccionada.Value
     then Inc( FSeleccionadas )
     else Dec( FSeleccionadas );
     OkButton.Enabled := FSeleccionadas>0;
end;

procedure TBoxNdaForm.AprovisionamientoTableCalcFields( DataSet : TDataSet );
begin

     // El texto de la cabecera determina el orden de las líneas

     AprovisionamientoTableCabeceraAlmacen.Value :=  'Almacén ' + AprovisionamientoTableCodigoAlmacenDestino.Value + ', ' + Almacen.Descripcion( AprovisionamientoTableCodigoAlmacenDestino.Value );
     
end;

procedure TBoxNdaForm.PageControlChange(Sender: TObject);
begin
     FTipoSeleccion := TTipoSeleccionBajoMinimos( PageControl.ActivePageIndex );     
     PageControl.ActivePage.SetFocus;
     SelectNextControl;     
end;

procedure TBoxNdaForm.PageControlPageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
begin
     If   FSeleccionadas>0
     then begin
          Beep;
          AllowChange := False;
          end;
end;

procedure TBoxNdaForm.ReiniciaSeleccion;
begin
     FSeleccionadas := 0;
     FAllSelected := False;
     If   OkButton.Focused
     then CloseButton.SetFocus;     
     OkButton.Enabled := False;
end;

procedure TBoxNdaForm.LinesViewCabeceraAlmacenGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
     AText := ARecord.Values[ LinesViewCabeceraAlmacen.Index ];
end;

procedure TBoxNdaForm.LinesViewCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                   ACanvas   : TcxCanvas;
                                                   AViewInfo : TcxGridTableDataCellViewInfo;
                                               var ADone     : Boolean);
begin     
     If   not AViewInfo.Selected
     then With AViewInfo.GridRecord do
            If   VarToDecimal( Values[ LinesViewReposicion.Index ] )=0.0
            then ACanvas.Font.Color := clGray
            else If   not VarIsNull( Values[ LinesViewSeleccionada.Index ] )
                 then If   VarToBoolean( Values[ LinesViewSeleccionada.Index ] )
                      then ACanvas.Brush.Color := clRowHighlight;   
                   
end;

procedure TBoxNdaForm.LinesViewDataControllerSummaryDefaultGroupSummaryItemsSummary(     ASender      : TcxDataSummaryItems;
                                                                                         Arguments    : TcxSummaryEventArguments;
                                                                                     var OutArguments : TcxSummaryEventOutArguments );
begin
     If   Arguments.SummaryItem.Index=0
     then begin
          var Seleccionada := VarToBoolean( LinesView.DataController.GetValue( Arguments.RecordIndex, LinesViewSeleccionada.Index ) );
          If   Seleccionada
          then begin
               var Importe := VarToDecimal( LinesView.DataController.GetValue( Arguments.RecordIndex, LinesViewImporteNeto.Index ) );
               OutArguments.SummaryValue := OutArguments.SummaryValue + Importe;
               end;
          OutArguments.Done := True;
          end;
end;

procedure TBoxNdaForm.LinesViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);

var  ColumnIndex : SmallInt;
     LineCaption : String;

begin     
     try
       AprovisionamientoTable.DisableControls;

       If   LinesView.Controller.FocusedRecord.Expandable
       then begin
            case LinesView.Controller.FocusedRecord.Level of
              0 : ColumnIndex := LinesViewCabeceraAlmacen.Index;
              //..
              end;
            LineCaption := LinesView.Controller.FocusedRecord.Values[ ColumnIndex ];
            SelectLines( function( var Select : TSelectOperation ) : Boolean
                         begin
                            If   ColumnIndex=LinesViewCabeceraAlmacen.Index
                            then Result := AprovisionamientoTableCabeceraAlmacen.Value=LineCaption;
                            If   Result
                            then Select := soSwitch;
                         end );                                 
            end
       else If   AprovisionamientoFields.Reposicion.Value>0.0
            then begin
                 AprovisionamientoTable.Edit;
                 AprovisionamientoFields.Seleccionada.Value := not AprovisionamientoFields.Seleccionada.Value;
                 AprovisionamientoTable.Post;            
                 end;
     finally
       AprovisionamientoTable.EnableControls;
       end;     
end;

procedure SetupModule;
begin
     If   Assigned( Gds40Frm )
     then With Gds40Frm do
            NecesidadaesAprovisionamientoItem.Visible := ivAlways;
end;

initialization
    AddProcedure( imStartUp, 0, SetupModule );

end.


