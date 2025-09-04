
unit i_cli;

interface

uses Windows, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms, ComCtrls, DB, nxdb,
     Menus, cxLookAndFeelPainters, cxButtons, dxmdaset,
     cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
     cxEdit, cxDBData, cxGridCustomTableView, cxGridTableView,
     cxGridDBTableView, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
     cxGrid, cxPC, cxDBEdit, cxContainer, cxTextEdit, cxMaskEdit, cxSpinEdit,
     cxCheckBox,

     dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
     cxLookAndFeels, cxLabel, cxGroupBox, cxPCdxBarPopupMenu, cxNavigator,
     dxBarBuiltInMenu, dxDateRanges, AppForms, GridTableViewController,
     dxScrollbarAnnotations,

     AppContainer,
     DataManager,
     ReportManager,

     Gim00Fields,
     Gim10Fields,
     Gim30Fields,

     dmi_iex, dxUIAClasses;


type
    TFrpCliForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    Report: TgxReportManager;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    ClienteQuery: TnxeQuery;
    DataSource: TDataSource;
    GridData: TnxeTable;
    GridDataSource: TDataSource;
    GridDataCodigo: TWideStringField;
    GridDataNombre: TWideStringField;
    GridDataNroLinea: TSmallintField;
    GridPanel: TcxGroupBox;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewCodigo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    GridTableViewController1: TGridTableViewController;
    Data: TgxMemData;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataOrdenar: TBooleanField;
    DataGrupoInicial: TWideStringField;
    DataGrupoFinal: TWideStringField;
    DataCodigoPostalInicial: TWideStringField;
    DataCodigoPostalFinal: TWideStringField;
    DataProvinciaInicial: TWideStringField;
    DataProvinciaFinal: TWideStringField;
    DataVendedorInicial: TWideStringField;
    DataVendedorFinal: TWideStringField;
    DataCodigoPais: TWideStringField;
    DataFormaCobroInicial: TWideStringField;
    DataFormaCobroFinal: TWideStringField;
    DataNroCopias: TSmallintField;
    DataFormato: TSmallintField;
    DataDireccionEnvios: TBooleanField;
    ClienteQueryCodigo: TWideStringField;
    ClienteTable: TnxeTable;
    DataEnviarPorCorreo: TBooleanField;
    GridDataEMail: TBooleanField;
    GridViewEMail: TcxGridDBColumn;
    DataExcluirClientesCorreo: TBooleanField;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    FormatoCtrl: TcxDBSpinEdit;
    DireccionAdministrativaCtrl: TcxDBCheckBox;
    Label8: TcxLabel;
    FormatoLabel: TcxLabel;
    EnviarPorCorreoCtrl: TcxDBCheckBox;
    ExcluirClientesCorreoCtrl: TcxDBCheckBox;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    gxRangeBox2: TgxRangeBox;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label6: TcxLabel;
    GrupoClienteTabSheet: TcxTabSheet;
    gxRangeBox1: TgxRangeBox;
    GrupoInicialCtrl: TcxDBTextEdit;
    GrupoFinalCtrl: TcxDBTextEdit;
    Label7: TcxLabel;
    Label3: TcxLabel;
    Label12: TcxLabel;
    VendedorTabSheet: TcxTabSheet;
    gxRangeBox3: TgxRangeBox;
    VendedorInicialCtrl: TcxDBTextEdit;
    VendedorFinalCtrl: TcxDBTextEdit;
    Label11: TcxLabel;
    Label15: TcxLabel;
    Label4: TcxLabel;
    TabSheet3: TcxTabSheet;
    gxRangeBox4: TgxRangeBox;
    CodigoPostalInicialCtrl: TcxDBTextEdit;
    CodigoPostalFinalCtrl: TcxDBTextEdit;
    ProvinciaInicialCtrl: TcxDBTextEdit;
    ProvinciaFinalCtrl: TcxDBTextEdit;
    CodigoPaisCtrl: TcxDBTextEdit;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    Label17: TcxLabel;
    cxTabSheet1: TcxTabSheet;
    gxRangeBox5: TgxRangeBox;
    FormaCobroInicialCtrl: TcxDBTextEdit;
    FormaCobroFinalCtrl: TcxDBTextEdit;
    Label18: TcxLabel;
    Label20: TcxLabel;
    Label21: TcxLabel;
    Label5: TcxLabel;
    procedure ReportSetReportName;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ReportSelectPrinter;
    procedure CodigoClientePropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridDataCalcFields(DataSet: TDataSet);
    procedure CodigoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerPreparedForm;
    procedure GrupoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GrupoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure VendedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoPaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoPaisCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ProvinciaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure FormaCobroCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormaCobroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure PageControlExit(Sender: TObject);
    procedure NroCopiasCtrlPropertiesValuePosted(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure GridViewCodigoPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure EnviarPorCorreoCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure ProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure ProvinciaFinalCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ProvinciaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
    private

       DsInformeExternoFields : TInformeExternoFields;

       procedure ActualizaRejilla;
       procedure EnviarPorCorreo;
       procedure InsertaRegistro;
    protected
    class var
      CodigoCliente : String;
    public

      RptEtiquetaPostalTable : TnxeTable;

      RptEtiquetaPostalFields : TEtiquetaPostalFields;
      ClienteFields : TClienteFields;

    end;

var
  FrpCliForm: TFrpCliForm = nil;

procedure ImpresosClientes( CodigoCliente : String );


implementation

uses   Variants,
       SysUtils,
       Math,
       LibUtils,
       Files,
       AppManager,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm30Dm,

       a_cli,
       a_imp,

       b_msg,
       b_pro,

       dm_ine,
       dm_pai,
       dm_prv,
       dm_cop,
       dm_cli,
       dm_gdc,
       dm_ven,
       dm_fco,
       dm_ddc,
       dm_iex,
       dm_dco,

       cx_imp,
       cx_cli,
       cx_gdc,
       cx_ven,
       cx_prv,
       cx_pai,
       cx_cop,
       cx_fco,

       f_prg;

{$R *.DFM}

resourceString
       RsMsg1  = 'Envío de impresos por correo.';
       RsMsg2  = 'Cliente %s.';
       RsMsg3  = 'Realizando el envío del fichero por correo.';
       RsMsg4  = 'Generando el fichero de exportación del impreso.';
       RsMsg5  = 'Ha ocurrido un problema al enviar el impreso por E-mail.';
       RsMsg6  = 'Revise la configuración del correo y/o la conexión a Internet y reintente el proceso.';
       RsMsg7  = 'Se ha producido un error al intentar generar el fichero a exportar.';
       RsMsg8  = 'No se ha podido crear el fichero temporal.';
       RsMsg9  = 'El impreso que ha seleccionado contiene un fichero HTML.';
       RsMsg10 = 'Los fichero de este tipo se utilizan para enviar mensajes de correo con contenido HTML y no se pueden imprimir.';
       RsMsg11 = 'Error en el servicio SMTP. El servidor ha devuelto el siguiente mensaje : %s';

procedure ImpresosClientes( CodigoCliente : String );
begin
     TFrpCliForm.CodigoCliente := CodigoCliente;
     CreateEditForm( TFrpCliForm, FrpCliForm );
end;

procedure TFrpCliForm.InitializeForm;
begin
     ClienteFields := TClienteFields.Create( ClienteTable );

     DsInformeExternoFields := TInformeExternoFields.Create( Self );

     DataNroCopias.Value := 1;
     DataClienteInicial.Value := CodigoCliente;
     DataClienteFinal.Value := CodigoCliente;
     DataGrupoFinal.Value := HighStrCode;
     DataCodigoPais.Value := CodigoEspaña;
     DataVendedorFinal.Value := HighStrCode;
     DataProvinciaFinal.Value := HighStrCode;
     DataCodigoPostalFinal.Value := HighStrCode;
     DataFormaCobroFinal.Value := HighStrCode;
     DataOrdenar.Value := False;
     DataFormato.Value := InformeExterno.ObtenFormatoUsuario( impImpresosClientes );
end;

procedure TFrpCliForm.NroCopiasCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaRejilla;
end;

procedure TFrpCliForm.GridDataCalcFields(DataSet: TDataSet);
begin
     Cliente.Obten( GridDataCodigo.Value, '', ClienteFields );
     GridDataNombre.Value := ClienteFields.Nombre.Value;
     GridDataEMail.Value := DireccionCorreo.DireccionValida( ClienteFields.EMail.Value );
end;

procedure TFrpCliForm.CodigoClientePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TFrpCliForm.CodigoPaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TFrpCliForm.CodigoPaisCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
     If   not Error
     then CodigoPostal.SetupCPControl( DisplayValue, [ ProvinciaInicialCtrl, ProvinciaFinalCtrl ],
                                                     [ CodigoPostalInicialCtrl, CodigoPostalFinalCtrl ] );
end;

procedure TFrpCliForm.CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( DataCodigoPais.Value, DataProvinciaInicial.Value, Sender );
end;

procedure TFrpCliForm.CodigoPostalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( DataCodigoPais.Value, DataProvinciaInicial.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TFrpCliForm.GridViewCodigoPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TFrpCliForm.GridViewCodigoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TFrpCliForm.GrupoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TFrpCliForm.GrupoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TFrpCliForm.FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

procedure TFrpCliForm.FormaCobroCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TFrpCliForm.FormatoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impImpresosClientes ), Sender.EditingValue ] );
end;

procedure TFrpCliForm.FormatoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impImpresosClientes, Sender );
end;

procedure TFrpCliForm.FormatoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impImpresosClientes, Sender, DisplayValue, Errortext, Error, DsInformeExternoFields );
end;

procedure TFrpCliForm.EnviarPorCorreo;

var  FileName,
     MessageTitle,
     TipoContenido,
     ErrorMsg : String;
     ErrorText : TCaption;
     Error : Boolean;
     MessageStream : TStringStream;
     DestinatariosArray : TStringArray;

procedure InsertaParametros;
begin
     With ExportImport do
       begin
       HeaderList.Values[ RsCodigoEmpresa ] := CodigoEmpresaActual;
       HeaderList.Values[ RsNombreEmpresa ] := ApplicationContainer.Empresa_Nombre;
       //.. Ampliar
       end;
end;

begin

     With GridData do
       try

         try

           ExportImport.SetupSMTP;

           ApplicationContainer.StartProgression( RecordCount );
           GridData.DisableControls;
           TipoContenido := 'text/html';
           MessageStream := TStringStream.Create( '', TEncoding.UTF8, False );
           If   DataFormato.Value<>0
           then begin
                MessageTitle := DsInformeExternoFields.Descripcion.Value;
                If   DsInformeExternoFields.TipoFichero.Value<>0  // Fichero HTML
                then begin
                     FileName := ReportManagerDataModule.GetReportLocation( DsInformeExternoFields.Fichero.Value, CodigoEmpresaActual, dtHtmlPage );
                     MessageStream.LoadFromFile( FileName );
                     end;
                end;

           First;
           While not Eof do
             begin

             ProcessFrame.CheckCanceled;

             If   ClienteTable.FindKey( [ GridDataCodigo.Value ] )
             then begin

                  DestinatariosArray := DireccionContacto.ObtenDireccionesCorreo( tdpCliente,
                                                                                  ClienteFields.Codigo.Value,
                                                                                  tdmTodos,
                                                                                  ClienteFields.Nombre.Value,
                                                                                  ClienteFields.EMail.Value );
                  If   High( DestinatariosArray )>0
                  then With Report do
                         try

                           With ClienteFields do
                             ProcessFrame.AddMsg( ntInformation, Codigo.Value + ' - ' + Nombre.Value );

                           ProcessFrame.AddRecordMsg( RsMsg4 );

                           If   ( DataFormato.Value=0 ) or
                                ( DsInformeExternoFields.TipoFichero.Value=0 ) // dtReport
                           then begin

                                Load;

                                If   ( MessageTitle='' ) and Assigned( Report.FrxReport )
                                then begin
                                     MessageTitle := Report.FrxReport.ReportOptions.Name;
                                     Title := MessageTitle;
                                     end;

                                RptEtiquetaPostalTable := CreateEmptyTable( 'EtiquetaPostal', DataModule30.SQLSet );
                                RptEtiquetaPostalFields := TEtiquetaPostalFields.Create( RptEtiquetaPostalTable );
                                MainDataSet := RptEtiquetaPostalTable;

                                OpenReportTables;
                                InsertaRegistro;

                                MessageStream.Clear;
                                ExportToHTML( MessageStream );

                                end;

                           ProcessFrame.AddRecordMsg( RsMsg3 );

                           With ExportImport do
                               try
                                 InsertaParametros;
                                 SMTPInit( tdImpresoCliente, DestinatariosArray, MessageTitle, MessageStream.DataString, [], TipoContenido, 'html' );
                                 SMTPSend;
                               except on E : Exception do
                                 begin
                                 ProcessFrame.AddMsg( ntError, RsMsg5 );
                                 ProcessFrame.AddMsg( ntError, RsMsg6 + HtmlCR + E.Message );
                                 Abort;
                                 end;
                               end;

                         except on E : Exception do
                           begin
                           ProcessFrame.AddMsg( ntError, RsMsg7 );
                           Cancel( E );
                           end;

                         end;

                  end;

             Next;
             end;

         except on E : Exception do begin
             { If   E is EElSmtpError
             then ErrorMsg := Format( RsMsg11, [ E.Message ] )
             else } ErrorMsg := E.Message;
             ProcessFrame.AddMsg( ntError, ErrorMsg );
             raise;
             end;
           end;

       finally
         ApplicationContainer.EndProgression;
         ExportImport.SMTP.Close;
         MessageStream.Free;
         end;

end;

procedure TFrpCliForm.EnviarPorCorreoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With ExcluirClientesCorreoCtrl do
       begin
       Enabled := not EnviarPorCorreoCtrl.Checked;
       If   not Enabled
       then DataExcluirClientesCorreo.Value := False;
       end;
end;

procedure TFrpCliForm.InsertaRegistro;

var   Index,
      NroCopias : Integer;

begin

     With RptEtiquetaPostalFields do
       begin

       RptEtiquetaPostalTable.Append;

       Codigo.Value := ClienteFields.Codigo.Value;

       If   DataDireccionEnvios.Value
       then begin
            Nombre.Value := ClienteFields.Envios_Nombre.Value;
            Domicilio.Value := ClienteFields.Envios_Domicilio.Value;
            localidad.Value := ClienteFields.Envios_localidad.Value;
            CodigoPais.Value := ClienteFields.CodigoPais.Value;
            NombrePais.Value := Pais.Descripcion( ClienteFields.CodigoPais.Value, true );
            CP.Value := ClienteFields.Envios_codigoProv.Value + ClienteFields.Envios_codigoPostal.Value;
            Provincia.Value := dm_prv.Provincia.Descripcion( ClienteFields.CodigoPais.Value, ClienteFields.envios_codigoProv.Value, False );
            end
       else begin
            Nombre.Value := ClienteFields.Nombre.Value;
            Domicilio.Value := ClienteFields.Domicilio.Value;
            localidad.Value := ClienteFields.Localidad.Value;
            CodigoPais.Value := ClienteFields.CodigoPais.Value;
            NombrePais.Value := Pais.Descripcion( ClienteFields.CodigoPais.Value, true );
            CP.Value := ClienteFields.CodigoProvincia.Value + ClienteFields.CodigoPostal.Value;
            Provincia.Value := dm_prv.Provincia.Descripcion( ClienteFields.CodigoPais.Value, ClienteFields.CodigoProvincia.Value, False );
            end;

       RptEtiquetaPostalTable.Post;

       ApplicationContainer.ShowProgression;

       end;

end;

procedure TFrpCliForm.FormManagerOkButton;

var  ExportFileName,
     SubjectLine,
     SubjectText : String;
     SubjectFile : TextFile;

procedure SeleccionaRegistros;

var   Index : Integer;

begin
     With GridData do
       try
         ApplicationContainer.StartProgression( RecordCount );
         GridData.DisableControls;
         First;
         While not Eof do
           begin
           If   ClienteTable.FindKey( [ GridDataCodigo.Value ] )
           then If   not DataExcluirClientesCorreo.Value or
                     ( DataExcluirClientesCorreo.Value and not DireccionCorreo.DireccionValida( ClienteFields.EMail.Value ) )
                then InsertaRegistro;
           Next;
           end;
       finally
         GridData.EnableControls;
         ApplicationContainer.EndProgression;
         end;
end;

begin

     If   DataEnviarPorCorreo.Value
     then CreateProcessForm( EnviarPorCorreo, RsMsg1 )
     else If   DsInformeExternoFields.TipoFichero.Value=0  // dtReport
          then With Report do
                 try
                   Load;
                   RptEtiquetaPostalTable  := CreateEmptyTable( 'EtiquetaPostal', DataModule30.SQLSet );
                   RptEtiquetaPostalFields := TEtiquetaPostalFields.Create( RptEtiquetaPostalTable );
                   SeleccionaRegistros;
                   Start;
                 except on E : Exception do Cancel( E );
                   end
          else begin
               ShowNotification( ntStop, RsMsg9, RsMsg10 );
               Abort;
               end;
end;

procedure TFrpCliForm.ActualizaRejilla;

var   SQLText : String;
      NroLinea : SmallInt;

begin
     With ClienteQuery do
       begin

       Close;

       SQLText := 'Select Codigo From Cliente Where NOT ( Bloqueado OR Obsoleto ) AND ';

       case PageControl.ActivePageIndex of
         0 : StrAdd( SQLText, SQLFormat( 'Codigo Between %s and %s', [ DataClienteInicial, DataClienteFinal ] ) + ' Order By Codigo' );
         1 : StrAdd( SQLText, SQLFormat( 'Factura_Agrupacion Between %s and %s', [ DataGrupoInicial, DataGrupoFinal ] ) + ' Order By Factura_Agrupacion, Codigo' );
         2 : StrAdd( SQLText, SQLFormat( 'Vendedor Between %s and %s', [ DataVendedorInicial, DataVendedorFinal ] ) + ' Order By Vendedor, Codigo' );
         3 : StrAdd( SQLText, SQLFormat( 'CodigoPais=%s and ( CodigoProvincia Between %s and %s ) and ( CodigoPostal Between %s and %s ) ',
                                         [ DataCodigoPais,
                                           DataProvinciaInicial, DataProvinciaFinal,
                                           DataCodigoPostalInicial, DataCodigoPostalFinal ] ) +
                                         'Order By CodigoPais, CodigoProvincia, CodigoPostal' );
         4 : StrAdd( SQLText, SQLFormat( 'Cobro_FormaCobro Between %s and %s', [ DataFormaCobroInicial, DataFormaCobroFinal ] ) + ' Order By Cobro_FormaCobro, Codigo' );
         end;

       ClienteQuery.SQL.Text := SQLText;

       Open;

       First;
       try
         GridData.DisableControls;
         GridData.DeleteRecords;
         NroLinea := 1;
         While not Eof do
           begin

           With GridData do
             begin
             Append;

             GridDataNroLinea.Value := NroLinea;
             GridDataCodigo.Value := ClienteQueryCodigo.Value;

             Post;
             Inc( NroLinea );
             end;

           Next;
           end;

       finally
         GridData.EnableControls;
         end;
       end;
end;

procedure TFrpCliForm.FormManagerPreparedForm;
begin
     ActualizaRejilla;
end;

procedure TFrpCliForm.PageControlChange(Sender: TObject);
begin

     //* 14.01.2009 Con esto trato de evitar que la página activa no reciba el focus cuando se cambia el tab con el ratón estando en otro control del Form

     PageControl.ActivePage.SetFocus;
     SelectNextControl;
end;

procedure TFrpCliForm.PageControlExit(Sender: TObject);
begin
     If   Assigned( ActiveControl )
     then ActualizaRejilla;
end;

procedure TFrpCliForm.CodigoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TFrpCliForm.ReportSelectPrinter;
begin
     Report.ReportPrinter := InformeExterno.Impresora;
end;

procedure TFrpCliForm.ProvinciaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProvincias( DataCodigoPais.Value, Sender );
end;

procedure TFrpCliForm.ProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( DataCodigoPais.Value, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TFrpCliForm.ProvinciaFinalCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ProvinciaFinalCtrl.Editing
     then CodigoPostalFinalCtrl.PostEditValue( '' );
end;

procedure TFrpCliForm.ProvinciaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ProvinciaInicialCtrl.Editing
     then CodigoPostalInicialCtrl.PostEditValue( '' );
end;

procedure TFrpCliForm.ReportSetReportName;
begin
     Report.FileName := InformeExterno.Fichero;
end;

procedure TFrpCliForm.VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TFrpCliForm.VendedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

end.

