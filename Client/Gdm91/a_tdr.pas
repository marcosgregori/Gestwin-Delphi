unit a_tdr;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes, Graphics,

  AppContainer,

  DataManager,
  ExtCtrls,
  Menus,
  cxLookAndFeelPainters,
  cxButtons, cxStyles, cxGraphics, DB, nxdb, cxSpinEdit, cxDBEdit,
  cxMaskEdit, cxDropDownEdit, cxIndexedComboBox, cxGrid, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridLevel,

  cxCalendar, cxPC, cxGroupBox, cxRadioGroup, cxLabel, cxDBLabel,
  cxMemo, cxRichEdit, cxDBRichEdit,

  dxSkinsCore, dxSkinscxPCPainter, cxCheckListBox,
  cxDBCheckListBox, cxLookAndFeels, dxSkinsDefaultPainters, cxPCdxBarPopupMenu,
  cxNavigator, dxBarBuiltInMenu, cxCustomListBox, dxDateRanges,

  Gim10Fields,
  Gim30Fields,
  Gim90Fields,

  AppForms,
  GridTableViewController, cxCheckBox, dxScrollbarAnnotations, cxScrollBox;

type
  TMntTdrForm = class(TgxForm)
    FormManager: TgxFormManager;
    KeyScreen: TgxEditPanel;
    NroRegistroCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    TarjetaRegistroTable: TnxeTable;
    LineaTarjetaRegistroTable: TnxeTable;
    Grid: TcxGrid;
    Panel1: TcxGroupBox;
    AplicacionCtrl: TcxDBIndexedComboBox;
    VersionCtrl: TcxDBSpinEdit;
    ReleaseCtrl: TcxDBSpinEdit;
    NroUsuariosCtrl: TcxDBSpinEdit;
    GridLevel: TcxGridLevel;
    GridView: TcxGridDBTableView;
    TarjetaRegistroDataSource: TDataSource;
    LineaTarjetaRegistroDataSource: TDataSource;
    LineaTarjetaRegistroTableNroRegistro: TIntegerField;
    LineaTarjetaRegistroTableNroLinea: TSmallintField;
    LineaTarjetaRegistroTableFecha: TDateField;
    LineaTarjetaRegistroTableVersion: TSmallintField;
    LineaTarjetaRegistroTableRelease: TSmallintField;
    LineaTarjetaRegistroTableNroUsuarios: TSmallintField;
    LineaTarjetaRegistroTableObservaciones: TWideStringField;
    GridViewFecha: TcxGridDBColumn;
    GridViewNroSerie: TcxGridDBColumn;
    GridViewVersion: TcxGridDBColumn;
    GridViewRelease: TcxGridDBColumn;
    GridViewNroUsuarios: TcxGridDBColumn;
    GridViewObservaciones: TcxGridDBColumn;
    TableViewManager: TGridTableViewController;
    LineaTarjetaRegistroTableClaveActivacion: TIntegerField;
    GridViewClaveActivacion: TcxGridDBColumn;
    LineaTarjetaRegistroTableNroSerie: TLargeintField;
    NombreCtrl: TcxDBTextEdit;
    DomicilioCtrl: TcxDBTextEdit;
    LocalidadCtrl: TcxDBTextEdit;
    CodigoProveedorCtrl: TcxDBTextEdit;
    CodigoPaisCtrl: TcxDBTextEdit;
    CodigoProvinciaCtrl: TcxDBTextEdit;
    CodigoPostalCtrl: TcxDBTextEdit;
    TipoContratoCtrl: TcxDBRadioGroup;
    CodigoGestionCtrl: TcxDBTextEdit;
    NroSerieCtrl: TcxDBTextEdit;
    FechaInstalacionCtrl: TcxDBDateEdit;
    GridViewFechaCaducidad: TcxGridDBColumn;
    LineaTarjetaRegistroTableFechaCaducidad: TDateField;
    FechaCaducidadCtrl: TcxDBDateEdit;
    ModulosOpcionalesCtrl: TcxCheckListBox;
    codigoCtrlCaption: TcxLabel;
    Label8: TcxLabel;
    Label11: TcxLabel;
    Label12: TcxLabel;
    Label10: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    NombreLabel: TcxLabel;
    Label9: TcxLabel;
    Label5: TcxLabel;
    Label18: TcxLabel;
    Label19: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label7: TcxLabel;
    proveedorLabel: TcxLabel;
    Label4: TcxLabel;
    descPaisLabel: TcxLabel;
    Label15: TcxLabel;
    descCPLabel: TcxLabel;
    Label6: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    NroRegistroBox: TcxLabel;
    NroUsuariosBox: TcxLabel;
    ClaveActivacionBox: TcxLabel;
    ScrollBox: TcxScrollBox;
    GridPanel: TcxGroupBox;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    procedure LineaTarjetaRegistroTableCalcFields(DataSet: TDataSet);
    procedure NroRegistroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoGestionCtrlPropertiesValuePosted(Sender: TObject);
    procedure CodigoPaisCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoPaisCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure CodigoPaisCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoPaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoProvinciaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProvinciaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoPostalCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ClienteCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure TarjetaRegistroTableNewRecord(DataSet: TDataSet);
    procedure TarjetaRegistroTableUpdateState(DataSet: TDataSet);
    procedure NroUsuariosCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure EditarButtonClick(Sender: TObject);
    procedure TarjetaRegistroTableBeforePost(DataSet: TDataSet);
    procedure TarjetaRegistroTableBeforeDelete(DataSet: TDataSet);
    procedure TarjetaRegistroTableRecordChanged(DataSet: TDataSet);
    procedure gBitBtn1Click(Sender: TObject);
    procedure TarjetaRegistroTableGetRecord(DataSet: TDataSet);
    procedure ModulosOpcionalesCtrlEditValueChanged(Sender: TObject);
    procedure gFormResize(Sender: TObject);
    procedure CodigoProvinciaCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure NroSerieCtrlPropertiesValuePosted(Sender: TObject);
  private

  public

    TarjetaRegistroFields : TTarjetaRegistroFields;
    LineaTarjetaRegistroFields : TLineaTarjetaRegistroFields;
    ClienteFields : TClienteFields;
    ArticuloFields : TArticuloFields;

    procedure ActualizaClaveActivacion;
    procedure CalculaValorModulosOpcionales;
  end;

var MntTdrForm: TMntTdrForm = nil;

procedure MntTarjetasRegistro( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       DateUtils,
       
       AppManager,
       LibUtils,
       Math,
       SuscriptionConsts,
       EnterpriseDataAccess,

       Gdm00Dm,

       dmi_iex,

       dm_pai,
       dm_prv,
       dm_cli,
       dm_cop,
       dm_tdr,
       dm_art,
       dm_iex,

       a_cli,
       a_prv,
       a_pai,
       a_cop,
       a_vpe,

       cx_pai,
       cx_tdr,
       cx_cli,
       cx_prv,
       cx_cop,

       l_tdr;

resourceString
       RsMsg1 = 'No se ha podido crear el registro de venta periódica.';
       RsMsg2 = 'Debe darlo de alta de forma manual.';
       RsMsg3 = 'No se ha indicado la dirección de correo en la ficha del cliente.';
       RsMsg4 = 'Se ha enviado el mensaje a la dirección de correo del cliente.';

procedure MntTarjetasRegistro( KeyValues : array of const );
begin
     CreateEditForm( TMntTdrForm, MntTdrForm, KeyValues );
end;

procedure TMntTdrForm.FormManagerInitializeForm;
begin
     TarjetaRegistroFields := TTarjetaRegistroFields.Create( TarjetaRegistroTable );
     LineaTarjetaRegistroFields := TLineaTarjetaRegistroFields.Create( LineaTarjetaRegistroTable );

     ClienteFields := TClienteFields.Create( Self );
     ArticuloFields := TArticuloFields.Create( Self );

     With TarjetaRegistroFields.NroSerie do
       begin
       DisplayFormat := '#';
       EditFormat := '#';
       end;
end;

procedure TMntTdrForm.FormManagerReportRequest;
begin
     ListadoTarjetasRegistro;
end;

procedure TMntTdrForm.gBitBtn1Click(Sender: TObject);

const SubjectText : String = 'Su suscripción a GESTWIN. Datos de acceso.';
      BodyText    : String = 'Estimado cliente :' + CR + CR +
                             'En primer lugar, gracias por haber adquirido una suscripción a uno de nuestros productos de la línea GESTWIN.' + CR +
                             'A continuación aparecen sus datos de registro. Utilícelos en el centro de control de GESTWIN para instalar o actualizar la aplicación.' + CR + CR +
                             'Producto           : GESTWIN %s' + CR + CR +
                             'Código de usuario  : %s' + CR +
                             'Número de registro : %d' + CR +
                             'Nombre             : %s' + CR + CR +
                             'Reciba un cordial saludo,' + CR + CR +
                             'Departamento de ventas.' + CR +
                             'Winstation, S.L.';


begin
     If   ValueIsEmpty( ClienteFields.EMail.Value )
     then ShowNotification( ntStop, RsMsg3, '' )
     else With ExportImport do
            begin

            SMTPInit( tdSuscripcion,
                      [ ClienteFields.Nombre.Value, ClienteFields.EMail.Value ],
                      SubjectText,
                      Format( BodyText, [ Copy( AplicacionCtrl.Text, 4, MaxInt ),
                                          TarjetaRegistroFields.CodigoGestion.Value,
                                          TarjetaRegistroFields.NroRegistro.Value,
                                          ClienteFields.Nombre.Value ] ) );
            SMTPSend;

            ShowNotification( ntInformation, RsMsg4, '' )
            end;

end;

procedure TMntTdrForm.gFormResize(Sender: TObject);
begin
     If   Width>1500
     then ModulosOpcionalesCtrl.Columns := 3
     else ModulosOpcionalesCtrl.Columns := 2;
end;

procedure TMntTdrForm.LineaTarjetaRegistroTableCalcFields(DataSet: TDataSet);
begin
     If   Assigned( LineaTarjetaRegistroFields )
     then With LineaTarjetaRegistroFields do
            If   ValueIsEmpty( Version.Value )
            then LineaTarjetaRegistroTableClaveActivacion.Value := 0
            else LineaTarjetaRegistroTableClaveActivacion.Value := MakeActivationKey( NroSerie.Value +
                                                                                      TarjetaRegistroFields.NroRegistro.Value   +
                                                                                      TarjetaRegistroFields.Aplicacion.Value    +
                                                                                      Version.Value  +
                                                                                      Release.Value  +
                                                                                      NroUsuarios.Value +
                                                                                      TarjetaRegistroFields.ModulosOpcionales.Value );
end;

procedure TMntTdrForm.ModulosOpcionalesCtrlEditValueChanged(Sender: TObject);
begin

     With ModulosOpcionalesCtrl do
       Items[ 6 ].Checked := Items[ 0 ].Checked;

     If   TarjetaRegistroTable.Editing
     then begin
          CalculaValorModulosOpcionales;
          ActualizaClaveActivacion;
          LineaTarjetaRegistroTable.Refresh;
          end;
end;

procedure TMntTdrForm.ActualizaClaveActivacion;
begin
     With TarjetaRegistroFields do
       If   Version.Value=0
       then begin
            NroRegistroBox.Caption := '';
            NroUsuariosBox.Caption := '';
            ClaveActivacionBox.Caption := '';
            end
       else begin
            NroRegistroBox.Caption := IntToStr( NroRegistro.Value );
            NroUsuariosBox.Caption := IntToStr( NroUsuarios.Value );
            ClaveActivacionBox.Caption := IntToStr( MakeActivationKey( NroSerie.Value    +
                                                                       NroRegistro.Value +
                                                                       Aplicacion.Value  +
                                                                       Version.Value     +
                                                                       Release.Value     +
                                                                       NroUsuarios.Value +
                                                                       ModulosOpcionales.Value ) );
            end;
end;

procedure TMntTdrForm.TarjetaRegistroTableBeforeDelete(DataSet: TDataSet);
begin
     {
     With TarjetaRegistroFields do
       If   ( TipoContrato.Value=1 ) and not ValueIsNull( NroFichaVentaPeriodica.Value )
       then If   TarjetaRegistroTable.FindKey( NroFichaVentaPeriodica.Value
     }
end;

procedure TMntTdrForm.CalculaValorModulosOpcionales;

var  I : SmallInt;

begin
     With TarjetaRegistroFields do
       begin
       ModulosOpcionales.Value := 0;
       With ModulosOpcionalesCtrl do
          For I := 0 to Items.Count - 1 do
            If   Items[ I ].Checked
            then ModulosOpcionales.Value := ModulosOpcionales.Value + Trunc( Power( 2, I + 1 ) );
       end;
end;

procedure TMntTdrForm.TarjetaRegistroTableBeforePost(DataSet: TDataSet);
begin

     CalculaValorModulosOpcionales;

     If   ( TarjetaRegistroFields.TipoContrato.Value=1 ) and ( TarjetaRegistroTable.State=dsInsert )
     then try

            try

              EnterpriseDataModule.StartTransaction( [ TarjetaRegistro.VentaPeriodicaTable,
                                                       TarjetaRegistro.LineaVentaPeriodicaTable ] );

              // Doy de alta la venta periódica

              With TarjetaRegistro.VentaPeriodicaTable do
                NewAutoIncRecord;

              With TarjetaRegistro.VentaPeriodicaFields do
                begin
                CodigoCliente.Value := TarjetaRegistroFields.CodigoGestion.Value;
                Periodicidad.Value := 0;  // Anual
                MesPago.Value := MonthOf( TarjetaRegistroFields.FechaInstalacion.Value );
                NoAplicar.Value := False;
                Serie.Value := 'S';       // Suscripciones
                end;

              TarjetaRegistro.LineaVentaPeriodicaTable.Append;

              With TarjetaRegistro.LineaVentaPeriodicaFields do
                begin

                Articulo.Obten( CodigoArticulo.Value, ArticuloFields );

                NroFicha.Value := TarjetaRegistro.VentaPeriodicaFields.NroFicha.Value;
                NroRegistro.Value := 1;
                CodigoArticulo.Value := ListaCodigosArticulo[ TarjetaRegistroFields.Aplicacion.Value ];
                NumeroSerie.Value := IntToStr( TarjetaRegistroFields.NroRegistro.Value );
                Descripcion.Value := ArticuloFields.Descripcion.Value;
                Cantidad.Value := 1;
                Precio.Value := ArticuloFields.Precio_Venta.Value;
                end;

              TarjetaRegistroFields.NroFichaVentaPeriodica.Value := TarjetaRegistro.VentaPeriodicaFields.NroFicha.Value;

              TarjetaRegistro.LineaVentaPeriodicaTable.Post;
              TarjetaRegistro.VentaPeriodicaTable.Post;

              EnterpriseDataModule.Commit;

            finally

              // Por si se queda abierto por un error

              TarjetaRegistro.LineaVentaPeriodicaTable.Cancel;
              TarjetaRegistro.VentaPeriodicaTable.Cancel;
              end;

          except
            EnterpriseDataModule.RollBack;
            ShowNotification( ntWarning, RsMsg1, RsMsg2 );
            end;
end;

procedure TMntTdrForm.TarjetaRegistroTableGetRecord(DataSet: TDataSet);

var  I : SmallInt;

begin
     With ModulosOpcionalesCtrl do
        For I := 0 to Items.Count - 1 do
          Items[ I ].Checked :=  ( TarjetaRegistroFields.ModulosOpcionales.Value and Trunc( Power( 2, I + 1 ) ) )<>0;
end;

procedure TMntTdrForm.TarjetaRegistroTableNewRecord(DataSet: TDataSet);
begin
     With TarjetaRegistroFields do
       begin
       Aplicacion.Value := 3;    // Por defecto GESTWIN Comercial
       Version.Value := 11;
       Release.Value := 0;
       NroUsuarios.Value := 3;
       TipoContrato.Value := 0;
       FechaInstalacion.Value := ApplicationContainer.TodayDate; 
       end;
end;

procedure TMntTdrForm.TarjetaRegistroTableRecordChanged(DataSet: TDataSet);
begin
     If   Assigned( TarjetaRegistroFields )
     then case TarjetaRegistroFields.TipoContrato.Value of
            0 : ActualizaClaveActivacion;
            1 : ;
            2 : ;
            end;
end;

procedure TMntTdrForm.TarjetaRegistroTableUpdateState(DataSet: TDataSet);
begin
     LineaTarjetaRegistroDataSource.Enabled := TarjetaRegistroTable.State<>dsSetKey;     
end;

procedure TMntTdrForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TMntTdrForm.ClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, ClienteFields );
end;

procedure TMntTdrForm.ClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] ) ;
end;

procedure TMntTdrForm.CodigoGestionCtrlPropertiesValuePosted(Sender: TObject);
begin
     With CodigoGestionCtrl do
       If   Editing and not ValueIsEmpty( EditValue ) and ( TarjetaRegistroTable.State=dsInsert )
       then With TarjetaRegistroFields do
            begin
            Nombre.Value := ClienteFields.Nombre.Value;
            Domicilio.Value := ClienteFields.Domicilio.Value;
            Localidad.Value := ClienteFields.Localidad.Value;
            CodigoPais.Value := ClienteFields.CodigoPais.Value;
            CodigoProvincia.Value := ClienteFields.CodigoProvincia.Value;
            CodigoPostal.Value := ClienteFields.CodigoPostal.Value;
            end;
end;

procedure TMntTdrForm.CodigoPaisCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntPaises( [ Sender.EditingValue ] );
end;

procedure TMntTdrForm.CodigoPaisCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With CodigoPaisCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := CodigoEspaña;
end;

procedure TMntTdrForm.CodigoPaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TMntTdrForm.CodigoPaisCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTdrForm.CodigoPostalCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     With TarjetaRegistroFields do
       MntCodigosPostales( [ CodigoPais.Value, CodigoProvincia.Value, Sender.EditingValue ] );
end;

procedure TMntTdrForm.CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With TarjetaRegistroFields do
       ConsultaCodigosPostales( CodigoPais.Value, CodigoProvincia.Value, Sender );
end;

procedure TMntTdrForm.CodigoPostalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( TarjetaRegistroFields.CodigoPais.Value, TarjetaRegistroFields.CodigoProvincia.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTdrForm.CodigoProvinciaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With TarjetaRegistroFields do
       MntProvincias( [ CodigoPais.Value, Sender.EditingValue ] );
end;

procedure TMntTdrForm.CodigoProvinciaCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   CodigoProvinciaCtrl.Editing
     then CodigoPostalCtrl.PostEditValue( '' );    
end;

procedure TMntTdrForm.CodigoProvinciaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProvincias( TarjetaRegistroFields.CodigoPais.Value, Sender );
end;

procedure TMntTdrForm.CodigoProvinciaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( TarjetaRegistroFields.CodigoPais.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTdrForm.EditarButtonClick(Sender: TObject);
begin
     MntVentasPeriodicas( [ TarjetaRegistroFields.NroFichaVentaPeriodica.Value ] );
end;

procedure TMntTdrForm.NroRegistroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTarjetasRegistro( Sender, qgsLinked );
end;

procedure TMntTdrForm.NroSerieCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaClaveActivacion;
end;

procedure TMntTdrForm.NroUsuariosCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With NroUsuariosCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := 1;
end;

initialization

end.
