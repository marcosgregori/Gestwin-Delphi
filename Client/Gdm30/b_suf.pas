unit b_suf;

interface

uses
  Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, Buttons, Mask, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxDBEdit, nxdb, dxSkinsCore, cxGraphics, cxLookAndFeels, dxSkinsDefaultPainters,cxLabel, cxGroupBox, dxUIAClasses,
  cxMemo, cxCheckBox, cxRadioGroup, dxBarBuiltInMenu, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxPC,
  cxIndexedComboBox, cxIntegerEdit, dxBar, dxGDIPlusClasses, cxImage, dxDateRanges, cxDataControllerConditionalFormattingRulesManagerDialog, dxScrollbarAnnotations,

  LibUtils,
  AppContainer,
  AppForms,
  GridTableViewController,

  Gim10Fields,

  dm_rpf,

  dm_sal;

type
    TBoxSufForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    AsientoTable: TnxeTable;
    ApunteTable: TnxeTable;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataSource: TDataSource;
    RelacionFacturasQuery: TnxeQuery;
    RelacionFacturasDataSource: TDataSource;
    RelacionFacturasCacheDataset: TnxeCachedDataSet;
    RelacionFacturasCacheDatasetEjercicio: TSmallintField;
    RelacionFacturasCacheDatasetFecha: TDateField;
    RelacionFacturasCacheDatasetSerie: TWideStringField;
    RelacionFacturasCacheDatasetNroFactura: TIntegerField;
    RelacionFacturasCacheDatasetDescripcion: TWideStringField;
    RelacionFacturasCacheDatasetEstadoPresentacion: TSmallintField;
    RelacionFacturasCacheDatasetCodigoErrorRegistro: TLargeintField;
    RelacionFacturasCacheDatasetDescripcionErrorRegistro: TWideStringField;
    FacturasPanel: TcxGroupBox;
    GridTableViewController1: TGridTableViewController;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewSeleccionada: TcxGridDBColumn;
    GridViewFecha: TcxGridDBColumn;
    GridViewSerie: TcxGridDBColumn;
    GridViewNroFactura: TcxGridDBColumn;
    GridViewNombrte: TcxGridDBColumn;
    GridViewTotalFactura: TcxGridDBColumn;
    GridViewEstado: TcxGridDBColumn;
    GridViewDescripcionErrorRegistro: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    DataSerieInicial: TStringField;
    DataSerieFinal: TStringField;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    RelacionFacturasCacheDatasetPresentacion: TDateField;
    GridViewPresentacion: TcxGridDBColumn;
    RelacionFacturasCacheDatasetEstadoRegistro: TSmallintField;
    RelacionFacturasCacheDatasetSerieNroFactura: TStringField;
    RegistroPresentacionTable: TnxeTable;
    RelacionFacturasCacheDatasetPropietario: TWideStringField;
    dxBarManager1: TdxBarManager;
    FacturasPopupMenu: TdxBarPopupMenu;
    EditarFacturaItem: TdxBarButton;
    SuprimirRegistroItem: TdxBarButton;
    AltasCtrl: TcxRadioButton;
    ConsultaCtrl: TcxRadioButton;
    DescOperacionLabel: TcxLabel;
    EntornoPruebasLabel: TcxLabel;
    GridViewCodigoCliente: TcxGridDBColumn;
    FacturaEmitidaGroupBox: TcxGroupBox;
    gxRangeBox2: TgxRangeBox;
    SerieInicialCtrl: TcxDBTextEdit;
    SerieFinalCtrl: TcxDBTextEdit;
    cxLabel2: TcxLabel;
    DescSerieInicialLabel: TcxLabel;
    DescSerieFinalLabel: TcxLabel;
    RelacionFacturasCacheDatasetSeleccionada: TBooleanField;
    SeleccionarTodoCtrl: TcxCheckBox;
    RelacionFacturasCacheDatasetTotalFactura: TBCDField;
    Image1: TcxImage;
    WebButton: TgBitBtn;
    cxRadioButton1: TcxRadioButton;
    GridViewEstadoRegistro: TcxGridDBColumn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure GridTableViewController1UserSelection(Sender: TObject; var AHandled: Boolean);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure EditarFacturaItemClick(Sender: TObject);
    procedure ControlPropertiesValuePosted(Sender: TObject);
    procedure GridViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure RelacionFacturasCacheDatasetCalcFields(DataSet: TDataSet);
    procedure SuprimirRegistroItemClick(Sender: TObject);
    function FormManagerRefreshCurrentRecord: Boolean;
    procedure OperacionCtrlClick(Sender: TObject);
    procedure FormManagerPreparedForm;
    procedure FechaPresentacionCtrlPropertiesValuePosted(Sender: TObject);
    procedure GridViewSeleccionadaHeaderClick(Sender: TObject);
    procedure SeleccionarTodoCtrlClick(Sender: TObject);
    procedure WebButtonClick(Sender: TObject);
    procedure SerieCtrlPropertiesValuePosted(Sender: TObject);
    private

    procedure ExecuteProcess;
    procedure ActualizaListaFacturas;

    private

    RelacionFacturasFields : TRelacionFacturasPresentacionFields;

    EjercicioPresentacion : SmallInt;

    Operacion : SmallInt;
    FechaInicioPresentacion : TDate;
    procedure ActualizaComponentes;

    protected

    public

    end;

var BoxSufForm : TBoxSufForm = nil;

procedure SuministroFacturasVerifactu;

implementation

uses   WinAPI.ShellAPI,
       SysUtils,
       DateUtils,
       Generics.Collections,
       Variants,

       cxGridDBDataDefinitions,

       DataAccess,
       AppManager,
       WebBrowser,

       Gdm00Dm,
       Gdm30Frm,

       dm_sdf,
       dm_fac,
       dm_suf,

       a_fdv,

       cx_sdf,
       cx_fdv,

       b_pro;

{$R *.DFM}

resourceString

       RsMsg1  = '¿Está seguro de que desea RE-ENVIAR las facturas seleccionadas?';
       RsMsg2  = 'Haga <doble-click> o pulse la barra espaciadora para marcar o desmarcar la línea.';
       RsMsg3  = 'Haga <doble-click> o pulse la barra espaciadora para editar la factura seleccionada.';
       RsMsg4  = 'emitidas';
       RsMsg5  = 'recibidas';
       RsMsg6  = 'La fecha no pertenece al periodo de presentación';
       RsMsg7  = 'Todo el periodo.';
       RsMsg8  = 'Se ha producido un error.';
       RsMsg9  = 'Revise el estado de presentación de las facturas y reintente el proceso cuando lo considere oportuno.';
       RsMsg10 = 'Se supone que ha corregido los motivos que provocaron que fueran [B]aceptadas con errores[/B] y que desea volver a intentar su presentación.';

       RsMsg12 = 'No ha seleccionado ningún registro.';
       RsMsg13 = 'Seleccione, al menos, una factura y reintente el proceso.';
       RsMsg14 = 'No hay facturas pendientes de presentación.';

       RsDescOperacionAlta = 'Utilice esta opción para subir facturas nuevas pendientes de presentación.';
       // RsDescOperacionAnulacion = 'Seleccione las facturas previamente presentadas que dese ANULAR.';
       RsDescOperacionAceptadasConErrores = 'Las facturas aceptadas con errores se pueden volver a presentar cuando se haya corregido el motivo del error.';
       // RsDescOperacionAnuladas = 'Muestra una relación de las facturas anuladas en los últimos 30 días. Es simplemente informativo.';
       RsDescOperacionRegistro = 'Muestra el registro de las facturas presentadas hasta este momento.';

       RsPortalVerifactuPruebas = 'https://prewww1.aeat.es/wlpl/OVCT-CXEW/DialogoRepresentacion?ref=%2Fwlpl%2FTIKE-CONT%2FSvTikeEmitidasQuery';
       RsPortalVerifactu = '';  // Aún no existe
       RsTituloPortalVerifactu = 'Consulta registros facturacion Verifactu';

procedure SuministroFacturasVerifactu;
begin
     CreateEditForm( TBoxSufForm, BoxSufForm, [ True ], TGds30Frm.VentasSection, { Exclusive } True );
end;

procedure TBoxSufForm.InitializeForm;
begin

     EntornoPruebasLabel.Visible := EntornoPruebasVerifactu;

     DataSerieInicial.Value := '';
     DataSerieFinal.Value := HighStrCode;

     SetColumnDecimals( GridViewTotalFactura);

     EjercicioPresentacion := YearOf( ApplicationContainer.TodayDate );
     FechaInicioPresentacion := EncodeDate( 2017, 7, 1 );
     Operacion := 0;
          
end;

procedure TBoxSufForm.ControlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaListaFacturas;
end;

procedure TBoxSufForm.RelacionFacturasCacheDatasetCalcFields(DataSet: TDataSet);
begin
     RelacionFacturasCacheDatasetSerieNroFactura.Value := Factura.TextoSerieNroFactura( RelacionFacturasCacheDatasetSerie.Value, RelacionFacturasCacheDatasetNroFactura.Value );
end;

procedure TBoxSufForm.SeleccionarTodoCtrlClick(Sender: TObject);
begin
     With RelacionFacturasCacheDataset do
       If   not ControlsDisabled  // Para evitar la recursión al cambiar el estado de SeleccionarTodoCtrl
       then try
              DisableControls;
              First;
              While not Eof do
                begin
                RelacionFacturasCacheDataset.Edit;
                RelacionFacturasFields.Seleccionada.Value := SeleccionarTodoCtrl.Checked;
                RelacionFacturasCacheDataset.Post;
                Next;
                end;
          finally
            // SeleccionarTodoCtrl.Checked := not SeleccionarTodoCtrl.Checked;
            EnableControls;
          end;
end;

procedure TBoxSufForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxSufForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TBoxSufForm.SerieCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaListaFacturas;
end;

procedure TBoxSufForm.SuprimirRegistroItemClick(Sender: TObject);

var  TipoRegistro : SmallInt;

begin
     If   GridView.Controller.SelectedRowCount=1
     then begin
         
          // Tipo;Ejercicio;Serie;NroFactura;NroEfecto

          With RelacionFacturasFields do
            If   RegistroPresentacionTable.FindKey( [ Ord( rpFacturaEmitidaVerifactu ), ApplicationContainer.Ejercicio, Serie.Value, NroFactura.Value ] )
            then begin
                 RegistroPresentacionTable.Delete;
                 ActualizaListaFacturas;
                 end;
          end;
end;

procedure TBoxSufForm.WebButtonClick(Sender: TObject);

var  PortalVerifactu : String;

begin
     If   EntornoPruebasVerifactu
     then PortalVerifactu := RsPortalVerifactuPruebas
     else PortalVerifactu := RsPortalVerifactu;
     ShellExecute( 0, 'OPEN', PChar( PortalVerifactu ), '', '', SW_SHOWNORMAL );
end;

procedure TBoxSufForm.FechaPresentacionCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaListaFacturas;
end;

procedure TBoxSufForm.FormManagerOkButton;
begin

     Case Operacion of

       0 : begin
           If   RelacionFacturasCacheDataset.RecordCount=0
           then begin
                ShowNotification( ntStop, RsMsg14 );
                Exit;
                end;
           end;

       1 : begin

           var Existe := False;

           For var RecordIndex := 0 to GridView.DataController.RecordCount - 1 do
             If   GridView.DataController.Values[ RecordIndex, GridViewSeleccionada.Index ]=True
             then begin
                  Existe := True;
                  Break;
                  end;

           If   not Existe
           then begin
                ShowNotification( ntStop, RsMsg12, RsMsg13 );
                Exit;
                end;

           If   ShowNotification( ntQuestionWarning, RsMsg1, RsMsg10 )<>mrYes
           then Exit;

           end;
       2 : ;
       end;


     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxSufForm.FormManagerPreparedForm;
begin
     ActualizaComponentes;
end;

function TBoxSufForm.FormManagerRefreshCurrentRecord: Boolean;
begin
     ActualizaListaFacturas;
end;

procedure TBoxSufForm.GridTableViewController1UserSelection(Sender: TObject; var AHandled: Boolean);
begin
     If   Operacion=1
     then begin
          RelacionFacturasCacheDataset.Edit;
          RelacionFacturasFields.Seleccionada.Value := not RelacionFacturasFields.Seleccionada.Value;
          RelacionFacturasCacheDataset.Post;
          end
     else EditarFacturaItemClick( nil );
end;

procedure TBoxSufForm.GridViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin

     With AViewInfo.GridRecord do

       If   not ( ViewInfo.Selected and ViewInfo.Focused )
       then try

              var Estado := VarToInteger( Values[ GridViewEstado.Index ] );
              var EstadoRegistro := VarToInteger( Values[ GridViewEstadoRegistro.Index ] );

              If   ( EstadoRegistro=Ord( ervAceptadoConErrores ) ) and ( TcxGridItemDBDataBinding( AViewInfo.Item.DataBinding ).FieldName='DescripcionErrorRegistro' )
              then begin
                   ACanvas.Font.Color := clIconOrange;
                   // ACanvas.Brush.Color := clLightGray;
                   end
              {
              else If   Estado=Ord( epvAnulado )
                   then begin
                        ACanvas.Font.Color := clBlack;
                        ACanvas.Brush.Color := clLightGray;
                        end;
              }
            except
              end;
end;

procedure TBoxSufForm.GridViewSeleccionadaHeaderClick(Sender: TObject);
begin
     With RelacionFacturasCacheDataset do
       try
         DisableControls;
         First;
         While not Eof do
           begin
           RelacionFacturasCacheDataset.Edit;
           RelacionFacturasFields.Seleccionada.Value := not RelacionFacturasFields.Seleccionada.Value;
           RelacionFacturasCacheDataset.Post;
           Next;
           end;
     finally
       EnableControls;
     end;
end;

procedure TBoxSufForm.EditarFacturaItemClick(Sender: TObject);
begin
     With RelacionFacturasFields do
       MntFacturasVenta( [ Ejercicio.Value, Serie.Value, NroFactura.Value ] );
end;

procedure TBoxSufForm.ExecuteProcess;
begin
    try

      RelacionFacturasCacheDataset.DisableControls;

      try

        SuministroFacturas.SuministroInformacion( { trfAlta, } RelacionFacturasCacheDataset );

      except on E : Exception do
        begin
        ShowException( E, nil );
        ShowNotification( ntError, RsMsg8, RsMsg9 );
        Abort;
        end;
      end;

    finally
      RelacionFacturasCacheDataset.EnableControls;
      ActualizaListaFacturas;
      end;
end;

procedure TBoxSufForm.ActualizaListaFacturas;

var  Mes : SmallInt;
     SerieInicial,
     SerieFinal : String;
     FechaInicial,
     FechaFinal : TDate;
     AcreedorInicial,
     AcreedorFinal,
     SQLFiltro : String;
     TipoAsiento : SmallInt;
     PrimerDiaVerifactu : TDate;

function TextoEstadoPresentacion( EstadoPresentacion : TEstadoPresentacionVerifactu ) : String;
begin
     Result := IntToStr( Ord( EstadoPresentacion ) );
end;

function TextoEstadoRegistro( EstadoRegistro : TEstadoregistroVerifactu ) : String;
begin
     Result := IntToStr( Ord( EstadoRegistro ) );
end;

begin

     RelacionFacturasCacheDataset.DisableControls;

     try

       RelacionFacturasQuery.Close;

       SerieInicial := DataSerieInicial.Value;
       SerieFinal := DataSerieFinal.Value;

       FechaInicial := IncDay( ApplicationContainer.TodayDate, -30 );

       If   EntornoPruebasVerifactu
       then PrimerDiaVerifactu := EncodeDate( 2024, 10, 22 )
       else PrimerDiaVerifactu := EncodeDate( 2026, 1, 1 );

       If   FechaInicial<PrimerDiaVerifactu
       then FechaInicial := PrimerDiaVerifactu;

       FechaFinal := ApplicationContainer.TodayDate;

       Grid.Hint := RsMsg2;

       case Operacion of
         0 : begin
             SQLFiltro := 'EstadoPresentacion=' + TextoEstadoPresentacion( epvPendiente ) + ' OR EstadoPresentacion IS NULL';
             Grid.Hint := RsMsg3;
             end;

         1 : SQLFiltro := 'EstadoRegistro=' + TextoEstadoRegistro( ervAceptadoConErrores );
         2 : SQLFiltro := 'EstadoPresentacion IN (' + TextoEstadoPresentacion( epvPresentado ) + ' , '+ TextoEstadoPresentacion( epvAnulado ) + ') ';
         end;

       // La selección de facturas puede que necesite ajustarse. No sé si se pueden seleccionar por fecha y serie o simplemente todas las que no han sido presentadas y punto. Veremos.

       RelacionFacturasQuery.SQL.Text := 'SELECT TOP 1000 * FROM ( '+
                                         'SELECT False AS Seleccionada, ' +
                                         '       FacturaVentas.Ejercicio, ' +
                                         '       FacturaVentas.Serie, ' +
                                         '       FacturaVentas.NroFactura, ' +
                                         '       FacturaVentas.Fecha, ' +
                                         '       FacturaVentas.CodigoCliente, ' +
                                         '       FacturaVentas.TotalFactura, ' +
                                         '       Cliente.Nombre, ' +
                                         '       RegistroPresentacion.Tipo, ' +
                                         '       RegistroPresentacion.Propietario, ' +
                                         '       RegistroPresentacion.FechaPresentacion, ' +
                                         '       RegistroPresentacion.EstadoPresentacion, ' +
                                         '       RegistroPresentacion.EstadoRegistro, ' +
                                         '       RegistroPresentacion.CodigoErrorRegistro, ' +
                                         '       RegistroPresentacion.DescripcionErrorRegistro ' +
                                         'FROM   FacturaVentas ' +
                                         '       LEFT JOIN Cliente ON ( Cliente.Codigo=FacturaVentas.CodigoCliente ) ' +
                                         '       LEFT JOIN RegistroPresentacion ON ( RegistroPresentacion.Tipo=' + IntToStr( Ord( rpFacturaEmitidaVerifactu ) ) + ' AND ' +
                                         '                                           FacturaVentas.Ejercicio=RegistroPresentacion.Ejercicio AND ' +
                                         '                                           FacturaVentas.Serie=RegistroPresentacion.Serie AND ' +
                                         '                                           FacturaVentas.NroFactura=RegistroPresentacion.NroFactura ) ' +
                                         'WHERE  ( FacturaVentas.Serie BETWEEN :SerieInicial AND :SerieFinal ) AND ' +
                                         '       ( FacturaVentas.Fecha BETWEEN :FechaInicial AND :FechaFinal ) ) AS Result ' +
                                         'WHERE ' + SQLFiltro + ' ' +
                                         'ORDER BY Serie, NroFactura ';

       RelacionFacturasQuery.SetParamValues( [ SerieInicial, SerieFinal, FechaInicial, FechaFinal ] );

       RelacionFacturasQuery.Open;

       RelacionFacturasCacheDataset.Close;
       RelacionFacturasCacheDataset.Open;

       RelacionFacturasFields := TRelacionFacturasPresentacionFields.Create( RelacionFacturasCacheDataset );

       RelacionFacturasCacheDataset.Last;

     finally
       RelacionFacturasCacheDataset.EnableControls;
       end;

end;

procedure TBoxSufForm.OperacionCtrlClick(Sender: TObject);
begin
     Operacion := ( Sender as TcxRadioButton ).TabOrder;
     ActualizaComponentes;
end;

procedure TBoxSufForm.ActualizaComponentes;
begin
     RelacionFacturasCacheDataset.Close;

     SeleccionarTodoCtrl.Visible := Operacion=1;
     GridViewSeleccionada.Visible := SeleccionarTodoCtrl.Visible;
     GridViewPresentacion.Visible := SeleccionarTodoCtrl.Visible;

     case Operacion of
       0 : DescOperacionLabel.Caption := RsDescOperacionAlta;
       1 : DescOperacionLabel.Caption := RsDescOperacionAceptadasConErrores;
       2 : DescOperacionLabel.Caption := RsDescOperacionRegistro;
       end;

     OkButton.Enabled := Operacion<>2;

     ActualizaListaFacturas;
end;

initialization


end.
