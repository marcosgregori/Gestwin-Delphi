unit b_sfa;

interface

uses
  Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, Buttons, Mask, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxDBEdit, nxdb, dxSkinsCore, cxGraphics, cxLookAndFeels, dxSkinsDefaultPainters,cxLabel, cxGroupBox,
  cxMemo, cxCheckBox, cxRadioGroup, dxBarBuiltInMenu, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxPC,
  cxIndexedComboBox, cxIntegerEdit, dxBar, dxGDIPlusClasses, cxImage, dxDateRanges, cxDataControllerConditionalFormattingRulesManagerDialog, dxScrollbarAnnotations, dxUIAClasses,

  LibUtils,
  AppContainer,
  AppForms,
  GridTableViewController,

  Gim10Fields,

  dm_sfr,
  dm_sfe,
  dm_rpf,

  dm_sal;

type
    TBoxSfaForm = class(TgxForm)
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
    DataPeriodo: TSmallintField;
    RelacionFacturasCacheDataset: TnxeCachedDataSet;
    RelacionFacturasCacheDatasetSeleccionada: TBooleanField;
    RelacionFacturasCacheDatasetEjercicio: TSmallintField;
    RelacionFacturasCacheDatasetNroAsiento: TIntegerField;
    RelacionFacturasCacheDatasetFecha: TDateField;
    RelacionFacturasCacheDatasetSerie: TWideStringField;
    RelacionFacturasCacheDatasetNroFactura: TIntegerField;
    RelacionFacturasCacheDatasetSubcuenta: TWideStringField;
    RelacionFacturasCacheDatasetDescripcion: TWideStringField;
    RelacionFacturasCacheDatasetImporte: TBCDField;
    RelacionFacturasCacheDatasetImporteRegistro: TBCDField;
    RelacionFacturasCacheDatasetEstadoPresentacion: TSmallintField;
    RelacionFacturasCacheDatasetCodigoErrorRegistro: TLargeintField;
    RelacionFacturasCacheDatasetDescripcionErrorRegistro: TWideStringField;
    TodoButton: TgBitBtn;
    FacturasPanel: TcxGroupBox;
    GridTableViewController1: TGridTableViewController;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewSeleccionada: TcxGridDBColumn;
    GridViewFecha: TcxGridDBColumn;
    GridViewSerie: TcxGridDBColumn;
    GridViewNroFactura: TcxGridDBColumn;
    GridViewSubcuenta: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewImporte: TcxGridDBColumn;
    GridViewNroAsiento: TcxGridDBColumn;
    GridViewEstado: TcxGridDBColumn;
    GridViewDescripcionErrorRegistro: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    DataSerieInicial: TStringField;
    DataSerieFinal: TStringField;
    GridViewImporteRegistro: TcxGridDBColumn;
    DataAcreedorInicial: TStringField;
    DataAcreedorFinal: TStringField;
    cxGroupBox1: TcxGroupBox;
    FacturaEmitidaGroupBox: TcxGroupBox;
    FacturaRecibidaGroupBox: TcxGroupBox;
    cxGroupBox4: TcxGroupBox;
    Label1: TcxLabel;
    PeriodoCtrl: TcxDBIndexedComboBox;
    gxRangeBox1: TgxRangeBox;
    AcreedorInicialCtrl: TcxDBTextEdit;
    AcreedorFinalCtrl: TcxDBTextEdit;
    Label7: TcxLabel;
    Label3: TcxLabel;
    cxLabel3: TcxLabel;
    gxRangeBox2: TgxRangeBox;
    SerieInicialCtrl: TcxDBTextEdit;
    SerieFinalCtrl: TcxDBTextEdit;
    cxLabel2: TcxLabel;
    DescSerieInicialLabel: TcxLabel;
    DescSerieFinalLabel: TcxLabel;
    cxLabel1: TcxLabel;
    RelacionFacturasCacheDatasetPresentacion: TDateField;
    GridViewPresentacion: TcxGridDBColumn;
    EntornoPruebasLabel: TcxLabel;
    RelacionFacturasCacheDatasetEstadoRegistro: TSmallintField;
    RelacionFacturasCacheDatasetSerieNroFactura: TStringField;
    GridViewSerieNroFactura: TcxGridDBColumn;
    cxLabel4: TcxLabel;
    DataFechaPresentacion: TDateField;
    FechaPresentacionCtrl: TcxDBDateEdit;
    RegistroPresentacionTable: TnxeTable;
    RelacionFacturasCacheDatasetTipo: TSmallintField;
    RelacionFacturasCacheDatasetPropietario: TWideStringField;
    RelacionFacturasCacheDatasetContraste: TSmallintField;
    GridViewContraste: TcxGridDBColumn;
    cxGroupBox2: TcxGroupBox;
    WebButton: TgBitBtn;
    cxLabel5: TcxLabel;
    dxBarManager1: TdxBarManager;
    FacturasPopupMenu: TdxBarPopupMenu;
    EditarFacturaItem: TdxBarButton;
    SuprimirRegistroItem: TdxBarButton;
    AltasCtrl: TcxRadioButton;
    ModificacionesCtrl: TcxRadioButton;
    AnulacionesCtrl: TcxRadioButton;
    ConsultaCtrl: TcxRadioButton;
    cxLabel6: TcxLabel;
    Image1: TcxImage;
    DescFechaPresentacionLabel: TcxLabel;
    cxGroupBox3: TcxGroupBox;
    cxGroupBox5: TcxGroupBox;
    cxLabel7: TcxLabel;
    FechaInicialCtrl: TcxDBDateEdit;
    cxLabel8: TcxLabel;
    FechaFinalCtrl: TcxDBDateEdit;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure GridTableViewController1UserSelection(Sender: TObject; var AHandled: Boolean);
    procedure TodoButtonClick(Sender: TObject);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure EditarFacturaItemClick(Sender: TObject);
    procedure ControlPropertiesValuePosted(Sender: TObject);
    procedure GridViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure AcreedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure AcreedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure WebButtonClick(Sender: TObject);
    procedure RelacionFacturasCacheDatasetCalcFields(DataSet: TDataSet);
    procedure GridViewSerieNroFacturaGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure SuprimirRegistroItemClick(Sender: TObject);
    function FormManagerRefreshCurrentRecord: Boolean;
    procedure OperacionCtrlClick(Sender: TObject);
    procedure FormManagerPreparedForm;
    procedure FechaPresentacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure FechaPresentacionCtrlPropertiesValuePosted(Sender: TObject);
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure PeriodoCtrlPropertiesValuePosted(Sender: TObject);
    private

    procedure ExecuteProcess;
    procedure ActualizaListaFacturas;

    private

    RelacionFacturasFields : TRelacionFacturasPresentacionFields;

    SuministroFacturasEmitidas : Boolean;
    EjercicioPresentacion : SmallInt;
    Operacion : SmallInt;
    FechaInicioPresentacion,
    FechaInicialPeriodo,
    FechaFinalPeriodo : TDate;

    procedure ActualizaComponentes;
    procedure ActualizaDescripcionFecha( DisplayValue : Variant );
    procedure ActualizaRangoFechas;

    protected

    public

    class procedure OnFacturasEmitidasMenuClick( Sender : TObject );
    class procedure OnFacturasRecibidasMenuClick( Sender : TObject );

    end;

var BoxSfeForm : TBoxSfaForm = nil;
    BoxSfrForm : TBoxSfaForm = nil;

implementation

uses   WinAPI.ShellAPI,
       SysUtils,
       DateUtils,
       Generics.Collections,
       Variants,

       DataAccess,
       AppManager,
       WebBrowser,

       Gdm00Dm,
       Gdm10Frm,

       dmi_ast,

       dm_sdf,
       dm_sub,
       dm_fac,

       a_fvi,
       a_fcg,

       cx_sdf,
       cx_sub,

       b_pro;

{$R *.DFM}

resourceString
       RsMsg1  = '¿Está seguro de que desea anular la/s factura/s seleccionada/s?';
       RsMsg2  = 'Haga <doble-click> o pulse la barra espaciadora para marcar o desmarcar la línea.';
       RsMsg3  = 'Haga <doble-click> o pulse la barra espaciadora para editar la factura seleccionada.';
       RsMsg4  = 'emitidas';
       RsMsg5  = 'recibidas';
       RsMsg6  = 'La fecha no pertenece al periodo de presentación';
       RsMsg7  = 'Todo el periodo.';
       RsMsg8  = 'Se ha producido un error.';
       RsMsg9  = 'Revise el estado de presentación las facturas y reintente el proceso cuando lo considere oportuno.';
       RsMsg10 = 'La fecha debe pertenecer al periodo de presentación.';

       RsPortalSIIPruebas = 'https://preportal.aeat.es/PRE-Exteriores/Inicio/_menu_/SII___Suministro_Inmediato_de_Informacion/SII___Suministro_Inmediato_de_Informacion.html';
       RsPortalSII = 'https://www.agenciatributaria.gob.es/AEAT.sede/tramitacion/G417.shtml';
       RsTituloPortalSII = 'Portal S.I.I.';

class procedure TBoxSfaForm.OnFacturasEmitidasMenuClick(Sender: TObject);
begin
     CreateEditForm( TBoxSfaForm, BoxSfeForm, [ True ], TGds10Frm.LibrosIVASection, { Exclusive } True );
end;

class procedure TBoxSfaForm.OnFacturasRecibidasMenuClick(Sender: TObject);
begin
     CreateEditForm( TBoxSfaForm, BoxSfrForm, [ False ], TGds10Frm.LibrosIVASection );
end;

procedure TBoxSfaForm.InitializeForm;
begin

     SuministroFacturasEmitidas := FormValues[ 0 ];

     If   SuministroFacturasEmitidas
     then Caption := Caption + RsMsg4
     else Caption := Caption + RsMsg5;

     EntornoPruebasLabel.Visible := DataModule00.DmEmpresaFields.Contable_EntornoPruebasSII.Value;

     DataPeriodo.Value := MonthOf( ApplicationContainer.TodayDate ) - 1;
     DataSerieInicial.Value := '';
     DataSerieFinal.Value := HighStrCode;
     DataAcreedorInicial.Value := '400000000';
     DataAcreedorFinal.Value := '419999999';
     DataFechaPresentacion.Value := ApplicationContainer.TodayDate;
     
     FacturaEmitidaGroupBox.Visible := SuministroFacturasEmitidas;
     FacturaRecibidaGroupBox.Visible := not SuministroFacturasEmitidas;

     SetColumnDecimals( GridViewImporte );

     EjercicioPresentacion := YearOf( ApplicationContainer.TodayDate );
     FechaInicioPresentacion := EncodeDate( 2017, 7, 1 );
     Operacion := 0;
          
end;

procedure TBoxSfaForm.ControlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaListaFacturas;
end;

procedure TBoxSfaForm.RelacionFacturasCacheDatasetCalcFields(DataSet: TDataSet);
begin
     RelacionFacturasCacheDatasetSerieNroFactura.Value := Factura.TextoSerieNroFactura( RelacionFacturasCacheDatasetSerie.Value, RelacionFacturasCacheDatasetNroFactura.Value );
end;

procedure TBoxSfaForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxSfaForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TBoxSfaForm.SuprimirRegistroItemClick(Sender: TObject);

var  TipoRegistro : SmallInt;

begin
     If   GridView.Controller.SelectedRowCount=1
     then begin
         
          // Tipo;Ejercicio;Propietario;Serie;NroFactura;NroEfecto

          With RelacionFacturasFields do
            If   RegistroPresentacionTable.FindKey( [ Tipo.Value, ApplicationContainer.Ejercicio, Propietario.Value, Serie.Value, NroFactura.Value ] )
            then begin
                 RegistroPresentacionTable.Delete;
                 ActualizaListaFacturas;
                 end;
          end;
end;

procedure TBoxSfaForm.TodoButtonClick(Sender: TObject);
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

procedure TBoxSfaForm.WebButtonClick(Sender: TObject);

var  PortalSII : String;

begin
     If   DataModule00.DmEmpresaFields.Contable_EntornoPruebasSII.Value
     then PortalSII := RsPortalSIIPruebas
     else PortalSII := RsPortalSII;
     ShellExecute( 0, 'OPEN', PChar( PortalSII ), '', '', SW_SHOWNORMAL );
end;

procedure TBoxSfaForm.ActualizaDescripcionFecha( DisplayValue : Variant );
begin
     If   ValueIsEmpty( DisplayValue, varDate ) and ( Operacion=3 )
     then DescFechaPresentacionLabel.Caption := RsMsg7
          else DescFechaPresentacionLabel.Caption := '';
end;

procedure TBoxSfaForm.FechaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     var Fecha := VarToDate( DisplayValue );
     If   ( Fecha<FechaInicialPeriodo ) or
          ( Fecha>FechaFinalPeriodo )
     then begin
          Error := True;
          ErrorText := RsMsg10;
          end;
end;

procedure TBoxSfaForm.FechaPresentacionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ValueIsEmpty( DisplayValue, varDate )
     then ValidateYear( DisplayValue, ErrorText, Error );
     ActualizaDescripcionFecha( DisplayValue );
end;

procedure TBoxSfaForm.FechaPresentacionCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaDescripcionFecha( FechaPresentacionCtrl.EditValue );
     ActualizaListaFacturas;
end;

procedure TBoxSfaForm.FormManagerOkButton;
begin
     If   Operacion=2  // Es una baja
     then If   ShowNotification( ntQuestionWarning, RsMsg1 )<>mrYes
          then Exit;
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxSfaForm.FormManagerPreparedForm;
begin
     ActualizaRangoFechas;
     ActualizaComponentes;
end;

function TBoxSfaForm.FormManagerRefreshCurrentRecord: Boolean;
begin
     ActualizaListaFacturas;
end;

procedure TBoxSfaForm.GridTableViewController1UserSelection(Sender: TObject; var AHandled: Boolean);
begin
     If   Operacion in [ 0, 1, 2 ]
     then begin
          RelacionFacturasCacheDataset.Edit;
          RelacionFacturasFields.Seleccionada.Value := not RelacionFacturasFields.Seleccionada.Value;
          RelacionFacturasCacheDataset.Post;
          end
     else EditarFacturaItemClick( nil );
end;

procedure TBoxSfaForm.GridViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);

var   Fecha : TDate;
      PrimerSemestre : Boolean;

begin

     With AViewInfo.GridRecord do
       If   not AViewInfo.Selected
       then try
              Fecha := VarToDate( Values[ GridViewFecha.Index ] );
              PrimerSemestre := Fecha<FechaInicioPresentacion;
              If   VarToInteger( Values[ GridViewEstado.Index ] )=Ord( erpAceptadoConErrores )
              then begin
                   ACanvas.Font.Color := clMaroon;
                   ACanvas.Brush.Color := clLightGray;
                   end
              else If   ( ( VarToInteger( Values[ GridViewEstado.Index ] )=Ord( erpModificado ) ) and ( Operacion<>1 ) )  // Ha sido modificada por el usuario
                   then begin
                        ACanvas.Font.Color := clBlack;
                        ACanvas.Brush.Color := clLightOrange;
                        end
                   else If   not PrimerSemestre and ( ( VarToDecimal( Values[ GridViewImporteRegistro.Index ] )<>0.0 )  and  ( VarToDecimal( Values[ GridViewImporte.Index ] )<>VarToDecimal( Values[ GridViewImporteRegistro.Index ] ) ) )  // Los importes no cuadran
                        then begin
                             ACanvas.Font.Color := clBlack;
                             ACanvas.Brush.Color := clLightRed;
                             end
                        else If   VarToInteger( Values[ GridViewEstado.Index ] )=Ord( erpAnulado )
                             then begin
                                  ACanvas.Font.Color := clBlack;
                                  ACanvas.Brush.Color := clLightGray;
                                  end;
            except
              end;
end;

procedure TBoxSfaForm.GridViewSerieNroFacturaGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
     If   ValueIsEmpty( ARecord.Values[ GridViewNroFactura.Index ] )
     then AProperties := GridViewSerieNroFactura.Properties
     else AProperties := GridViewNroFactura.Properties;
end;

procedure TBoxSfaForm.AcreedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender );
end;

procedure TBoxSfaForm.AcreedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TBoxSfaForm.EditarFacturaItemClick(Sender: TObject);
begin
     With RelacionFacturasFields do
       If   SuministroFacturasEmitidas
	      then MntFacturasEmitidas( [ taFraEmitida, Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfectoRegistroFactura ] )
	      else MntFacturasRecibidas( [ taFraRecibida, Ejercicio.Value, Subcuenta.Value, Serie.Value, NroFactura.Value, NroEfectoRegistroFactura ] );
end;

procedure TBoxSfaForm.ExecuteProcess;
begin
    try
      RelacionFacturasCacheDataset.DisableControls;

      If   SuministroFacturasEmitidas
      then SFEmitidas.SuministroFacturasEmitidas( TOperacionFacturasSII( Operacion ), DataPeriodo.Value, DataFechaPresentacion.Value, RelacionFacturasCacheDataset )
      else SFRecibidas.SuministroFacturasRecibidas( TOperacionFacturasSII( Operacion ), DataPeriodo.Value, DataFechaPresentacion.Value, RelacionFacturasCacheDataset );

    finally
      RelacionFacturasCacheDataset.EnableControls;
      ActualizaListaFacturas;
      end;
end;

procedure TBoxSfaForm.ActualizaRangoFechas;
begin
     var Mes := DataPeriodo.Value + 1;

     FechaInicialPeriodo := EncodeDate( EjercicioPresentacion, Mes, 1 );
     FechaFinalPeriodo := EncodeDate( EjercicioPresentacion, Mes, DaysInAMonth( EjercicioPresentacion, Mes ) );;

     DataFechaInicial.Value := FechaInicialPeriodo;
     DataFechaFinal.Value := FechaFinalPeriodo;
end;

procedure TBoxSfaForm.ActualizaListaFacturas;

var  FechaInicial,
     FechaFinal : TDate;
     SerieInicial,
     SerieFinal,
	    AcreedorInicial,
     AcreedorFinal,
     SQLImporte,
     SQLSeleccion,
     SQLFiltro,
     SQLEnlacePropietario : String;
     TipoAsiento : SmallInt;
     TipoRegistro : TTipoRegistroPresentacion;
     FechaPresentacion : TDate;

function TextoEstado( EstadoPresentacion : TEstadoPresentacionSii ) : String;
begin
     Result := IntToStr( Ord( EstadoPresentacion ) );
end;

begin

     RelacionFacturasCacheDataset.DisableControls;

     try

       RelacionFacturasQuery.Close;

       FechaInicial := DataFechaInicial.Value;
       FechaFinal := DataFechaFinal.Value;
       SerieInicial := DataSerieInicial.Value;
       SerieFinal := DataSerieFinal.Value;
       AcreedorInicial := DataAcreedorInicial.Value;
       AcreedorFinal := DataAcreedorFinal.Value;
       FechaPresentacion := DataFechaPresentacion.Value;

       If   SuministroFacturasEmitidas
       then begin
            TipoRegistro := rpFacturaEmitida;
            TipoAsiento := taFraEmitida;
            SQLImporte := ' ( Apunte.Debe - Apunte.Haber ) AS Importe, ';
            SQLSeleccion := ' ( Asiento.Serie BETWEEN :SerieInicial AND :SerieFinal ) ';
            end
       else begin
            TipoRegistro := rpFacturaRecibida;
            TipoAsiento := taFraRecibida;
            SQLImporte := ' ( Apunte.Haber - Apunte.Debe ) AS Importe, ';
            SQLSeleccion := ' ( Asiento.Propietario BETWEEN :AcreedorInicial AND :AcreedorFinal ) ';
            end;

       case Operacion of
         0 : begin
             SQLFiltro := 'WHERE EstadoPresentacion=' + TextoEstado( erpPendiente ) + '  OR EstadoPresentacion IS NULL';
             Grid.Hint := RsMsg2;
             end;
         1 : begin
             SQLFiltro := 'WHERE EstadoPresentacion in ( ' + TextoEstado( erpModificado ) +  ', ' + TextoEstado( erpAceptadoConErrores ) + ' )';
             Grid.Hint := RsMsg2;
             end;
         2 : begin
             SQLFiltro := 'WHERE EstadoPresentacion in ( ' + TextoEstado( erpPresentado ) +  ', ' + TextoEstado( erpModificado ) + ', ' + TextoEstado( erpAceptadoConErrores ) + ' )';
             Grid.Hint := RsMsg2;
             end;
         3 : begin
             SQLFiltro := '';
             If   FechaPresentacion<>0
             then SQLFiltro := 'WHERE FechaPresentacion=' + SQLDateString( FechaPresentacion );
             Grid.Hint := RsMsg3;
             end;
         end;

       If   SuministroFacturasEmitidas
       then SQLEnlacePropietario := ''
       else SQLEnlacePropietario := ' Asiento.Propietario=RegistroPresentacion.Propietario AND ';

       RelacionFacturasQuery.SQL.Text := 'SELECT * FROM ( ' +
                                                 'SELECT False AS Seleccionada, ' +
                                                 '       Asiento.Ejercicio, ' +
                                                 '       Asiento.NroAsiento, ' +
                                                 '       Asiento.Fecha, ' +
                                                 '       Asiento.Serie, ' +
                                                 '       Asiento.NroFactura, ' +
                                                 '       Apunte.Subcuenta, ' +
                                                 '       Cuenta.Descripcion, ' +
                                                 SQLImporte +
                                                 '       RegistroPresentacion.Tipo, ' +
                                                 '       RegistroPresentacion.Propietario, ' +
                                                 '       RegistroPresentacion.Importe AS ImporteRegistro, ' +
                                                 '       RegistroPresentacion.FechaPresentacion, ' +
                                                 '       RegistroPresentacion.EstadoPresentacion, ' +
                                                 '       RegistroPresentacion.EstadoRegistro, ' +
                                                 '       RegistroPresentacion.CodigoErrorRegistro, ' +
                                                 '       RegistroPresentacion.DescripcionErrorRegistro, ' +
                                                 '       RegistroPresentacion.Contraste ' +
                                                 'FROM   Asiento ' +
                                                 '       LEFT JOIN Apunte ON ( Asiento.Ejercicio=Apunte.Ejercicio AND Asiento.NroAsiento=Apunte.NroAsiento ) ' +
                                                 '       LEFT JOIN Cuenta ON ( Cuenta.Codigo=Apunte.Subcuenta ) ' +
                                                 '       LEFT JOIN RegistroPresentacion ON ( RegistroPresentacion.Tipo=' + IntToStr( Ord( TipoRegistro ) ) + ' AND Asiento.Ejercicio=RegistroPresentacion.Ejercicio AND ' +
                                                 SQLEnlacePropietario +
                                                 '                                           Asiento.Serie=RegistroPresentacion.Serie AND ' +
                                                 '                                           Asiento.NroFactura=RegistroPresentacion.NroFactura AND Asiento.NroEfecto=RegistroPresentacion.NroEfecto ) ' +
                                                 'WHERE  ( Asiento.Fecha BETWEEN :FechaInicial AND :FechaFinal ) AND ' +
                                                 '       ( Asiento.TipoAsiento='+ IntToStr( TipoAsiento ) + ' ) AND ' +
                                                 '       ( Apunte.NroApunte=1 ) AND ' +
                                                 SQLSeleccion +
                                                 '  ) AS Result ' +
                                                 SQLFiltro +
                                                 ' ORDER BY Result.Fecha, Result.NroAsiento';

       If   SuministroFacturasEmitidas
       then RelacionFacturasQuery.SetParamValues( [ FechaInicial, FechaFinal, SerieInicial, SerieFinal ] )
       else RelacionFacturasQuery.SetParamValues( [ FechaInicial, FechaFinal, AcreedorInicial, AcreedorFinal ] );

       RelacionFacturasQuery.Open;

       RelacionFacturasCacheDataset.Close;
       RelacionFacturasCacheDataset.Open;

       RelacionFacturasFields := TRelacionFacturasPresentacionFields.Create( RelacionFacturasCacheDataset );

       RelacionFacturasCacheDataset.Last;

     finally
       RelacionFacturasCacheDataset.EnableControls;
       end;

end;

procedure TBoxSfaForm.OperacionCtrlClick(Sender: TObject);
begin
     Operacion := ( Sender as TcxRadioButton ).TabOrder;
     ActualizaComponentes;
end;

procedure TBoxSfaForm.PeriodoCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaRangoFechas;
     ActualizaComponentes;
end;

procedure TBoxSfaForm.ActualizaComponentes;
begin
     RelacionFacturasCacheDataset.Close;

     GridViewSeleccionada.Visible := Operacion in [ 0, 1, 2 ];
     GridViewPresentacion.Visible := Operacion in [ 1, 2, 3 ];
     GridViewContraste.Visible := Operacion=3;

     TodoButton.Enabled := GridViewSeleccionada.Visible;

     // Reajusto la fecha por si ha sido modificada en la consulta

     DataFechaPresentacion.Value := ApplicationContainer.TodayDate;

     FechaPresentacionCtrl.Enabled := Operacion=3;
     FechaInicialCtrl.Enabled := Operacion<>3;
     FechaFinalCtrl.Enabled := Operacion<>3;

     ActualizaListaFacturas;
end;

initialization


end.
