
unit a_pde207;

interface

uses Forms, StdCtrls, Buttons, Mask,
  Controls, Classes, ExtCtrls, printers,

  AppContainer,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxGroupBox,
  cxRadioGroup, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, DB,
  DataManager, nxdb,

  dxSkinsCore, cxGraphics, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxHeader,
  dxmdaset, cxMaskEdit, cxSpinEdit, cxImage, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData, cxIndexedComboBox,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, dxGDIPlusClasses, cxCheckBox,
  cxDropDownEdit, dxBarBuiltInMenu, cxPC, dxSVGImage, dxDateRanges, AppForms,
  GridTableViewController, dxScrollbarAnnotations, cxButtonEdit,
  System.ImageList, Vcl.ImgList, cxImageList, dxUIAClasses;

type
  TMntPde207Form = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    DataSource: TDataSource;
    Data: TgxMemData;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox1: TcxGroupBox;
    cxLabel3: TcxLabel;
    HostCtrl: TcxDBTextEdit;
    DataHost: TStringField;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    DirectorioImagenesCtrl: TcxDBTextEdit;
    ExaminarButton: TgBitBtn;
    DataDirectorioImagenes: TStringField;
    cxImage1: TcxImage;
    cxLabel6: TcxLabel;
    ImagenesExternasCtrl: TcxDBCheckBox;
    DataImagenesExternas: TBooleanField;
    GrupoClienteDataSource: TDataSource;
    GrupoClienteData: TnxeTable;
    GrupoClienteDataNroLinea: TSmallintField;
    GrupoClienteDataCodigoTarifa: TWideStringField;
    cxGroupBox15: TcxGroupBox;
    TarifasGrid: TcxGrid;
    TarifasTableView: TcxGridDBTableView;
    TarifasGridLevel: TcxGridLevel;
    GridTableViewController: TGridTableViewController;
    GrupoClienteDataDescripcion: TWideStringField;
    TarifasTableViewCodigoTarifa: TcxGridDBColumn;
    TarifasTableViewDescripcion: TcxGridDBColumn;
    cxLabel7: TcxLabel;
    DataFormatoImagenes: TStringField;
    FormatoImagenesCtrl: TcxDBComboBox;
    ReiniciarButton: TgBitBtn;
    Label21: TcxLabel;
    CodigoFormaCobroCtrl: TcxDBTextEdit;
    DescFormaCobroLabel: TcxLabel;
    DataCodigoFormaCobro: TStringField;
    SeleccionAlmacenCtrl: TcxDBRadioGroup;
    CodigoAlmacenCtrl: TcxDBTextEdit;
    Label1: TcxLabel;
    DescAlmacenLabel: TcxLabel;
    DataSeleccionAlmacen: TSmallintField;
    DataCodigoAlmacen: TStringField;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    GrupoClienteDataConIVAIncluido: TBooleanField;
    TarifasTableViewModeloImpositivo: TcxGridDBColumn;
    TarifasTableViewIVAIncluido: TcxGridDBColumn;
    cxLabel9: TcxLabel;
    PlantillaCodigoClienteCtrl: TcxDBTextEdit;
    DataPlantillaCodigoCliente: TStringField;
    GrupoClienteDataNombre: TStringField;
    TarifasTableViewNombre: TcxGridDBColumn;
    DataNombreCategoriaRaiz: TStringField;
    NombreCategoriaRaizCtrl: TcxDBTextEdit;
    NoPublicarArticulosSinImagenCtrl: TcxDBCheckBox;
    DataNoPublicarArticulosSinImagen: TBooleanField;
    CamposLibresComoAtributosCtrl: TcxDBCheckBox;
    DataCamposLibresComoAtributos: TBooleanField;
    DataNombreAtributo1: TStringField;
    DataPreciosConIVAIncluido: TBooleanField;
    PreciosConIVAIncluidoCtrl: TcxDBCheckBox;
    NoPublicarArticulosSinPrecioCtrl: TcxDBCheckBox;
    DataNoPublicarArticulosSinPrecio: TBooleanField;
    PublicarArticulosAlmacenSeleccionadoCtrl: TcxDBCheckBox;
    DataPublicarArticulosAlmacenSeleccionado: TBooleanField;
    UnidadesSonCajasCtrl: TcxDBCheckBox;
    DataUnidadesSonCajas: TBooleanField;
    cxTabSheet3: TcxTabSheet;
    AplicarPreciosyDtosCtrl: TcxDBCheckBox;
    cxLabel1: TcxLabel;
    DataAplicarPreciosyDtos: TBooleanField;
    cxLabel2: TcxLabel;
    EstadoPedidosADescargarCtrl: TcxDBTextEdit;
    DataEstadoPedidosADescargar: TStringField;
    TarifasTableViewExentoIVA: TcxGridDBColumn;
    GrupoClienteDataModeloImpositivo: TSmallintField;
    GrupoClienteDataSerieFacturacion: TWideStringField;
    TarifasTableViewSerieFacturacion: TcxGridDBColumn;
    cxLabel10: TcxLabel;
    EstadoPedidosEnviadosCtrl: TcxDBTextEdit;
    cxLabel11: TcxLabel;
    DataEstadoPedidosEnviados: TStringField;
    PreciosConDescuentoPrevioCtrl: TcxDBCheckBox;
    DataPreciosConDescuentoPrevio: TBooleanField;
    cxLabel12: TcxLabel;
    PreciosPorClienteCtrl: TcxDBCheckBox;
    cxLabel13: TcxLabel;
    DataPreciosPorCliente: TBooleanField;
    PublicarClasesComoConfiguracionesCtrl: TcxDBCheckBox;
    DataPublicarClasesComoConfiguraciones: TBooleanField;
    ArticulosPorGrupoClienteCtrl: TcxDBCheckBox;
    DataArticulosPorGrupoCliente: TBooleanField;
    PublicarArticulosSinExistenciasCtrl: TcxDBCheckBox;
    DataPublicarArticulosSinExistencias: TBooleanField;
    cxGroupBox2: TcxGroupBox;
    NoIncluirPendienteRecibirCtrl: TcxDBCheckBox;
    DataNoIncluirPendienteRecibir: TBooleanField;
    cxGroupBox3: TcxGroupBox;
    cxGroupBox4: TcxGroupBox;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure ExaminarButtonClick(Sender: TObject);
    procedure ImagenesExternasCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure CodigoTarifaQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoTarifaValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GrupoClienteDataCalcFields(DataSet: TDataSet);
    procedure DirectorioImagenesCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure ReiniciarButtonClick(Sender: TObject);
    procedure Cobro_FormaCobroCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Cobro_FormaCobroCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Cobro_FormaCobroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SeleccionAlmacenCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure CodigoAlmacenCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoAlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TarifasTableViewIVAIncluidoPropertiesValuePosted(
      Sender: TObject);
    procedure TarifasTableViewREPropertiesValuePosted(Sender: TObject);
    procedure GrupoClienteDataNewRecord(DataSet: TDataSet);
    procedure TarifasTableViewSerieFacturacionPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure TarifasTableViewSerieFacturacionPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TarifasTableViewSerieFacturacionPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure TarifasTableViewNombrePropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure GrupoClienteDataAfterPost(DataSet: TDataSet);
    procedure PublicarClasesComoConfiguracionesCtrlPropertiesEditValueChanged(Sender: TObject);
  private


  protected

  public

  end;

var   MntPde207Form : TMntPde207Form = nil;

procedure MntConfiguracionTiendaVirtual;

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,

       AppManager,

       Gdm00Dm,

       Gim30Fields,

       Gdm00Frm,

       f_cnf207,

       dmi_iva,
       dmi_sdt,

       dm_pga,
       dm_reg,
       dm_rea207,
       dm_sdt207,
       dm_cdt,
       dm_fco,
       dm_alm,
       dm_ptv,
       dm_sdf,

       a_fco,
       a_sdf,

       cx_cdt,
       cx_fco,
       cx_alm,
       cx_sdf,

       b_rra,
       b_dir;

resourceString
     RsSinTarifaAsignada = '<Sin tarifa asignada>';
     RsNombreGrupoDuplicado = 'No pueden haber dos grupos de cliente con el mismo nombre';
     RsHaModificadoLaConfiguración = 'Ha modificado la configuración de la tienda.';
     RsEsNecesarioReiniciar = 'Es necesario invalidar la configuración global de la tienda para evitar inconsistencias.'#13 +
                              '¿Está seguro de que desea guardar los cambios?';


procedure MntConfiguracionTiendaVirtual;
begin
     CreateEditForm( TMntPde207Form, MntPde207Form, Gds00Frm.ConfigurationSection, True );
end;

procedure TMntPde207Form.FormManagerOkButton;

var  I : SmallInt;

begin

     If   Data.Modified
     then If   ShowNotification( ntQuestionWarning, RsHaModificadoLaConfiguración, RsEsNecesarioReiniciar )<>mrYes
          then Abort;

     With Registro do
       begin
       ClavePadre := CodigoEmpresaActual + '.' + ncrParametrosTiendaVirtual;
       GuardaValor( ncrHost, DataHost.Value );

       // Articulos

       GuardaValor( ncrImagenesExternas, BoolToStr( DataImagenesExternas.Value ) );
       GuardaValor( ncrNombreCategoriaRaiz, DataNombreCategoriaRaiz.Value );
       GuardaValor( ncrDirectorioImagenes, DataDirectorioImagenes.Value );
       GuardaValor( ncrFormatoImagenes, DataFormatoImagenes.Value );
       GuardaValor( ncrSeleccionAlmacen, DataSeleccionAlmacen.AsString );
       GuardaValor( ncrCodigoAlmacen, DataCodigoAlmacen.Value );
       GuardaValor( ncrNoPublicarArticulosSinImagen, BoolToStr( DataNoPublicarArticulosSinImagen.Value ) );
       GuardaValor( ncrNoPublicarArticulosSinPrecio, BoolToStr( DataNoPublicarArticulosSinPrecio.Value ) );
       GuardaValor( ncrPublicarArticulosSinExistencias, BoolToStr( DataPublicarArticulosSinExistencias.Value ) );
       GuardaValor( ncrNoIncluirPendienteRecibir, BoolToStr( DataNoIncluirPendienteRecibir.Value ) );
       GuardaValor( ncrPreciosConDescuentoPrevio, BoolToStr( DataPreciosConDescuentoPrevio.Value ) );
       GuardaValor( ncrCamposLibresComoAtributos, BoolToStr( DataCamposLibresComoAtributos.Value ) );
       GuardaValor( ncrNombreAtributo1, DataNombreAtributo1.Value );
       GuardaValor( ncrPreciosConIVAIncluido, BoolToStr( DataPreciosConIVAIncluido.Value ) );
       GuardaValor( ncrPublicarArticulosAlmacenSeleccionado, BoolToStr( DataPublicarArticulosAlmacenSeleccionado.Value ) );
       GuardaValor( ncrPublicarClasesComoConfiguraciones, BoolToStr( DataPublicarClasesComoConfiguraciones.Value ) );
       GuardaValor( ncrUnidadesSonCajas, BoolToStr( DataUnidadesSonCajas.Value ) );

       // Clientes

       ParametrosTiendaVirtual.SuprimeRegistrosGruposClientes;

       I := 0;
       With GrupoClienteData do
         begin
         First;
         While not Eof do
           begin
           GuardaValor( ncrGrupoNombre + IntToStr( I ), GrupoClienteDataNombre.Value );
           GuardaValor( ncrGrupoCodigoTarifa + IntToStr( I ), GrupoClienteDataCodigoTarifa.Value );
           GuardaValor( ncrGrupoModeloImpositivo + IntToStr( I ), IntToStr( GrupoClienteDataModeloImpositivo.Value ) );
           GuardaValor( ncrGrupoConIVAIncluido + IntToStr( I ), BoolToStr( GrupoClienteDataConIVAIncluido.Value ) );
           GuardaValor( ncrGrupoSerie + IntToStr( I ), GrupoClienteDataSerieFacturacion.Value );
           Inc( I );
           Next;
           end;
         end;

       GuardaValor( ncrCodigoFormaCobro, DataCodigoFormaCobro.Value );
       GuardaValor( ncrPlantillaCodigoCliente, DataPlantillaCodigoCliente.Value );
       GuardaValor( ncrArticulosPorGrupoCliente, BoolToStr( DataArticulosPorGrupoCliente.Value ) );
       GuardaValor( ncrPreciosPorCliente, BoolToStr( DataPreciosPorCliente.Value ) );

       // Pedidos

       GuardaValor( ncrAplicarPreciosyDtos, BoolToStr( DataAplicarPreciosyDtos.Value ) );
       GuardaValor( ncrEstadoPedidosADescargar, DataEstadoPedidosADescargar.Value );
       GuardaValor( ncrEstadoPedidosEnviados, DataEstadoPedidosEnviados.Value );

       end;

     ActualizaParametrosTiendaVirtual;

     If   Data.Modified
     then RegistroActualizacionTienda.Modificado( rgaGlobal, CodigoConfiguracion );

     FormManager.CloseWindow := True;
end;

procedure TMntPde207Form.FormManagerInitializeForm;

var  I : SmallInt;
     IdGrupoValue : String;

begin

     CloseWindowWhenFocusLost := True;

     With GrupoClienteDataNroLinea do
       begin
       MinValue := 1;
       MaxValue := LastCustomerGroupIndex + 1;
       end;

     SeleccionAlmacenCtrl.Enabled := DataModule00.DmEmpresaFields.Stock_MultiAlmacen.Value;
     PublicarClasesComoConfiguracionesCtrl.Enabled := DataModule00.DmEmpresaFields.Articulo_ExisteClase[ 1 ].Value;
     UnidadesSonCajasCtrl.Enabled := DataModule00.DmEmpresaFields.Articulo_Cajas.Value;

     DataHost.Value := ParametrosTiendaVirtual.Host;

     // Artículos

     DataNombreCategoriaRaiz.Value := ParametrosTiendaVirtual.NombreCategoriaRaiz;
     DataImagenesExternas.Value := ParametrosTiendaVirtual.ImagenesExternas;
     DataDirectorioImagenes.Value := ParametrosTiendaVirtual.DirectorioImagenes;
     DataFormatoImagenes.Value := ParametrosTiendaVirtual.FormatoImagenes;
     DataSeleccionAlmacen.Value := ParametrosTiendaVirtual.SeleccionAlmacen;
     DataCodigoAlmacen.Value := ParametrosTiendaVirtual.CodigoAlmacen;
     DataNoPublicarArticulosSinImagen.Value := ParametrosTiendaVirtual.NoPublicarArticulosSinImagen;
     DataNoPublicarArticulosSinPrecio.Value := ParametrosTiendaVirtual.NoPublicarArticulosSinPrecio;
     DataPublicarArticulosSinExistencias.Value := ParametrosTiendaVirtual.PublicarArticulosSinExistencias;
     DataNoIncluirPendienteRecibir.Value := ParametrosTiendaVirtual.NoIncluirPendienteRecibir;
     DataPreciosConDescuentoPrevio.Value := ParametrosTiendaVirtual.PreciosConDescuentoPrevio;
     DataCamposLibresComoAtributos.Value := ParametrosTiendaVirtual.CamposLibresComoAtributos;
     DataNombreAtributo1.Value := ParametrosTiendaVirtual.NombreAtributo1;
     DataPreciosConIVAIncluido.Value := ParametrosTiendaVirtual.PreciosConIVAIncluido;
     DataPublicarArticulosAlmacenSeleccionado.Value := ParametrosTiendaVirtual.PublicarArticulosAlmacenSeleccionado;
     DataPublicarClasesComoConfiguraciones.Value := ParametrosTiendaVirtual.PublicarClasesComoConfiguraciones;
     DataUnidadesSonCajas.Value := ParametrosTiendaVirtual.UnidadesSonCajas;

     // Clientes

     For I := 0 to LastCustomerGroupIndex do
       If   ParametrosTiendaVirtual.GrupoNombre[ I ]<>''
       then With GrupoClienteData do
              begin
              Append;
              GrupoClienteDataNroLinea.Value := I + 1;
              GrupoClienteDataNombre.Value := ParametrosTiendaVirtual.GrupoNombre[ I ];
              GrupoClienteDataCodigoTarifa.Value := ParametrosTiendaVirtual.GrupoCodigoTarifa[ I ];
              If   ParametrosTiendaVirtual.GrupoModeloImpositivo[ I ] in [ 0..3 ]
              then GrupoClienteDataModeloImpositivo.Value := ParametrosTiendaVirtual.GrupoModeloImpositivo[ I ];
              GrupoClienteDataConIVAIncluido.Value := ParametrosTiendaVirtual.GrupoConIVAIncluido[ I ];
              GrupoClienteDataSerieFacturacion.Value := ParametrosTiendaVirtual.GrupoSerie[ I ];
              Post;
              end
       else Break;

     DataCodigoFormaCobro.Value := ParametrosTiendaVirtual.CodigoFormaCobro;
     If   DataPlantillaCodigoCliente.Value=''
     then DataPlantillaCodigoCliente.Value := '#####';
     DataPlantillaCodigoCliente.Value := ParametrosTiendaVirtual.PlantillaCodigoCliente;
     DataPreciosPorCliente.Value := ParametrosTiendaVirtual.PreciosPorCliente;
     DataArticulosPorGrupoCliente.Value := ParametrosTiendaVirtual.ArticulosPorGrupoCliente;
     DataAplicarPreciosyDtos.Value := ParametrosTiendaVirtual.AplicarPreciosyDtos;
     DataEstadoPedidosADescargar.Value := ParametrosTiendaVirtual.EstadoPedidosADescargar;
     DataEstadoPedidosEnviados.Value := ParametrosTiendaVirtual.EstadoPedidosEnviados;

     Data.Modified := False;
end;

procedure TMntPde207Form.ImagenesExternasCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     DirectorioImagenesCtrl.Enabled := ImagenesExternasCtrl.Checked;
     FormatoImagenesCtrl.Enabled := ImagenesExternasCtrl.Checked;
     ExaminarButton.Enabled := ImagenesExternasCtrl.Checked;
end;

procedure TMntPde207Form.PublicarClasesComoConfiguracionesCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ArticulosPorGrupoClienteCtrl.Enabled := PublicarClasesComoConfiguracionesCtrl.Checked;
end;

procedure TMntPde207Form.ReiniciarButtonClick(Sender: TObject);
begin
     ModificaRegistroActualizacion;
end;

procedure TMntPde207Form.SeleccionAlmacenCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     CodigoAlmacenCtrl.Enabled := DataSeleccionAlmacen.Value=1;
     PublicarArticulosAlmacenSeleccionadoCtrl.Enabled := DataSeleccionAlmacen.Value in [ 1, 2 ];

     If   DataSeleccionAlmacen.Value<>1
     then begin
          DataCodigoAlmacen.Clear;
          DataPublicarArticulosAlmacenSeleccionado.Clear;
          CodigoAlmacenCtrl.ClearDescription;
          end;
end;

procedure TMntPde207Form.TarifasTableViewIVAIncluidoPropertiesValuePosted(Sender: TObject);
begin
     {
     If   GrupoClienteDataConIVAIncluido.Value
     then GrupoClienteDataConRE.Value := False;
     }
end;

procedure TMntPde207Form.TarifasTableViewNombrePropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
       For Var Inx := 0 to TarifasTableView.DataController.RowCount -1 do
         If   ( Inx<>TarifasTableView.Controller.FocusedRowIndex ) and ( TarifasTableView.DataController.Values[ Inx, TarifasTableViewNombre.Index ]=DisplayValue )
         then begin
              Error := True;
              ErrorText := RsNombreGrupoDuplicado;
              Exit;
              end;
end;

procedure TMntPde207Form.TarifasTableViewREPropertiesValuePosted(Sender: TObject);
begin
     {
     If  GrupoClienteDataConRE.Value
     then GrupoClienteDataConIVAIncluido.Value := False;
     }
end;

procedure TMntPde207Form.TarifasTableViewSerieFacturacionPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [ Sender.EditingValue ] )
end;

procedure TMntPde207Form.TarifasTableViewSerieFacturacionPropertiesQueryRequest( Sender: TcxCustomEdit );
begin
     ConsultaSeriesfacturacion( Sender );
end;

procedure TMntPde207Form.TarifasTableViewSerieFacturacionPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean );
begin
     If   not ValueIsEmpty( DisplayValue )
     then SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntPde207Form.GrupoClienteDataAfterPost(DataSet: TDataSet);
begin
     Data.Modified := True;
end;

procedure TMntPde207Form.GrupoClienteDataCalcFields(DataSet: TDataSet);
begin
     If   GrupoClienteDataCodigoTarifa.Value=''
     then GrupoClienteDataDescripcion.Value := RsSinTarifaAsignada
     else GrupoClienteDataDescripcion.Value := CodigoTarifa.Descripcion( GrupoClienteDataCodigoTarifa.Value, False );
end;

procedure TMntPde207Form.GrupoClienteDataNewRecord(DataSet: TDataSet);
begin
     GrupoClienteDataModeloImpositivo.Value := micSinRE;
end;

procedure TMntPde207Form.CodigoTarifaValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ValueIsEmpty( DisplayValue )
     then CodigoTarifa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntPde207Form.DirectorioImagenesCtrlPropertiesValidate(  Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   DirectorioImagenesCtrl.UserValidateAction or FormManager.ValidatingFormData
     then If   not ValueIsEmpty( DisplayValue )
          then If   not DirectoryExists( DisplayValue )
               then begin
                    Error := True;
                    ErrorText := JoinMessage( RsgMsg394, RsgMsg395 );
                    end;
end;

procedure TMntPde207Form.Cobro_FormaCobroCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntFormasCobro( [ Sender.EditingValue ] );
end;

procedure TMntPde207Form.Cobro_FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

procedure TMntPde207Form.Cobro_FormaCobroCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntPde207Form.CodigoAlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TMntPde207Form.CodigoAlmacenCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scAmbas, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntPde207Form.CodigoTarifaQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaCodigosTarifa( Sender );
end;

procedure TMntPde207Form.ExaminarButtonClick(Sender: TObject);
begin
     SelectDirectory( DataDirectorioImagenes );
end;

end.

