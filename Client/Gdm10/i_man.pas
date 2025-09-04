
unit i_man;

interface

uses

    Windows, StdCtrls, Mask, ExtCtrls, Buttons,
    Controls, Classes, Forms, ComCtrls, DB, nxdb,
    Menus, cxLookAndFeelPainters, cxButtons, dxmdaset,
    cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
    cxEdit, cxDBData, cxGridCustomTableView, cxGridTableView,
    cxGridDBTableView, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
    cxGrid, cxPC, cxDBEdit, cxContainer, cxTextEdit, cxMaskEdit, cxSpinEdit,
    cxCheckBox,

    dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
    cxLookAndFeels, cxLabel, cxGroupBox, cxPCdxBarPopupMenu, cxNavigator,
    cxRadioGroup, dxBarBuiltInMenu, dxDateRanges, GridTableViewController,
    dxScrollbarAnnotations,

    AppForms,
    AppContainer,
    ReportManager,
    DataManager,

    Gim10Fields,
    dmi_iex, dxUIAClasses;

type
    TFrpManForm = class(TgxForm)
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
    DataGrupoInicial: TWideStringField;
    DataGrupoFinal: TWideStringField;
    DataCodigoPostalInicial: TWideStringField;
    DataCodigoPostalFinal: TWideStringField;
    DataProvinciaInicial: TWideStringField;
    DataProvinciaFinal: TWideStringField;
    DataCodigoPais: TWideStringField;
    DataFormaCobroInicial: TWideStringField;
    DataFormaCobroFinal: TWideStringField;
    ClienteQueryCodigo: TWideStringField;
    ClienteTable: TnxeTable;
    DataEnviarPorCorreo: TBooleanField;
    GridDataEMail: TBooleanField;
    GridViewEMail: TcxGridDBColumn;
    DataExcluirClientesCorreo: TBooleanField;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
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
    Label8: TcxLabel;
    ReglaImpresoCtrl: TcxDBRadioGroup;
    DataReglaImpreso: TSmallintField;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoClientePropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridDataCalcFields(DataSet: TDataSet);
    procedure CodigoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerPreparedForm;
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
    procedure ReglaImpresoCtrlPropertiesChange(Sender: TObject);
    procedure ReportBeforeStart;
    procedure ProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure ProvinciaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ProvinciaFinalCtrlPropertiesEditValueChanged(Sender: TObject);
    private
       procedure ActualizaRejilla;
       procedure EnviarPorCorreo;
       procedure InsertaRegistro;
    procedure FijaValoresAcreedor;
    procedure SeleccionaRegistros;
    protected
    class var
      CodigoCliente : String;
    public

      RptOrdenDomiciliacionTable : TnxeTable;

      RptOrdenDomiciliacionFields : TOrdenDomiciliacionFields;
      ClienteFields : TClienteFields;

    end;

var
  FrpManForm: TFrpManForm = nil;

procedure ImpresionMandatos( CodigoCliente : String );


implementation

uses   Variants,
       SysUtils,
       LibUtils,
       Files,

       AppManager,
       
       SessionDataAccess,
       EnterpriseDataAccess,

       Gim00Fields,
       Gdm00Dm,
       Gdm10Dm,

       a_cli,
       a_imp,

       b_msg,
       b_pro,

       dm_pai,
       dm_prv,
       dm_cop,
       dm_cli,
       dm_fco,
       dm_ddc,
       dm_iex,
       dm_enf,
       dm_ban,

       cx_imp,
       cx_cli,
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
       RsMsg9  = 'No se ha podido crear o copiar el fichero al almacén de documentos.';
       RsMsg10 = 'Se cancela la generación y firma de documentos.'#13'Verifique que tiene acceso al directorio de documento[B]b>%s[/B] y reintente el proceso.';
       RsMsg11 = 'Error en el servicio SMTP. El servidor ha devuelto el siguiente mensaje : %s';
       RsMsg12 = 'Orden de domiciliación de adeudo directo';

procedure ImpresionMandatos( CodigoCliente : String );
begin
     TFrpManForm.CodigoCliente := CodigoCliente;
     CreateEditForm( TFrpManForm, FrpManForm );
end;

procedure TFrpManForm.InitializeForm;
begin

     ID := idFrpManForm;

     ClienteFields := TClienteFields.Create( ClienteTable );

     DataClienteInicial.Value := CodigoCliente;
     DataClienteFinal.Value := CodigoCliente;
     DataGrupoFinal.Value := HighStrCode;
     DataCodigoPais.Value := CodigoEspaña;
     DataProvinciaFinal.Value := HighStrCode;
     DataCodigoPostalFinal.Value := HighStrCode;
     DataFormaCobroFinal.Value := HighStrCode;
     DataReglaImpreso.Value := 0;  // CORE
end;

procedure TFrpManForm.NroCopiasCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaRejilla;
end;

procedure TFrpManForm.GridDataCalcFields(DataSet: TDataSet);
begin
     Cliente.Obten( GridDataCodigo.Value, '', ClienteFields );
     GridDataNombre.Value := ClienteFields.Nombre.Value;
     GridDataEMail.Value := DireccionCorreo.DireccionValida( ClienteFields.EMail.Value );
end;

procedure TFrpManForm.CodigoClientePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TFrpManForm.CodigoPaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TFrpManForm.CodigoPaisCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TFrpManForm.CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( DataCodigoPais.Value, DataProvinciaInicial.Value, Sender );
end;

procedure TFrpManForm.CodigoPostalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( DataCodigoPais.Value, DataProvinciaInicial.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TFrpManForm.GridViewCodigoPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TFrpManForm.GridViewCodigoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TFrpManForm.FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

procedure TFrpManForm.FormaCobroCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TFrpManForm.FijaValoresAcreedor;

var   PaisAcreedor,
      IdentificadorAcreedor : String;
begin

     // Utilizo un sufijo genérico (000) para no involucrar a la entidad financiera en la generación del identificador

     With Report, DataModule00 do
       begin
       PaisAcreedor := Pais.CodigoISO2( DmEmpresaFields.CodigoPais.Value );
       IdentificadorAcreedor := IdentificadorAT02( PaisAcreedor, DmEmpresaFields.NIF.Value, '000' );
       SetValue( RsIdentificadorAcreedor, IdentificadorAcreedor );
       end;

end;

procedure TFrpManForm.EnviarPorCorreo;

var  FileName,
     MessageTitle,
     MessageDescription,
     ErrorMsg,
     ExportFileName,
     AlmacenDocumentosPath,
     PathFicheroAlmacen : String;
     ErrorText : TCaption;
     Error : Boolean;

procedure InsertaParametros;
begin
     With ExportImport do
       begin
       HeaderList.Values[ RsCodigoEmpresa ] := CodigoEmpresaActual;
       HeaderList.Values[ RsNombreEmpresa ] := ApplicationContainer.Empresa_Nombre;
       HeaderList.Values[ RsCodigoCliente ] := ClienteFields.Codigo.Value;
       HeaderList.Values[ RsNombreCliente ] := ClienteFields.Nombre.Value;
       end;
end;

begin

     With GridData do
       try

         try

           ExportImport.SetupSMTP;

           ApplicationContainer.StartProgression( RecordCount );
           GridData.DisableControls;

           AlmacenDocumentosPath := ApplicationPath + 'doc_' + CodigoEmpresaActual  + '\Mandatos\' + IntToStr( ApplicationContainer.Ejercicio ) + '\PDF\';
           CreateDirPath( AlmacenDocumentosPath );

           First;
           While not Eof do
             begin

             ProcessFrame.CheckCanceled;

             If   ClienteTable.FindKey( [ GridDataCodigo.Value ] ) and
                  DireccionCorreo.DireccionValida( ClienteFields.EMail.Value )
             then begin

                  With Report do
                    try

                      With ClienteFields do
                        ProcessFrame.AddMsg( ntInformation, Codigo.Value + ' - ' + Nombre.Value );

                      ProcessFrame.AddRecordMsg( RsMsg4 );

                      Load;

                      MessageTitle := RsMsg12;
                      MessageDescription := Report.FrxReport.ReportOptions.Description.Text;

                      try
                        MessageDescription := Format( MessageDescription, [ ApplicationContainer.Empresa_Nombre ] )
                      except;
                        end;

                      Title := MessageTitle;

                      RptOrdenDomiciliacionTable := CreateEmptyTable( 'OrdenDomiciliacion', DataModule10.SQLSet );
                      RptOrdenDomiciliacionFields := TOrdenDomiciliacionFields.Create( RptOrdenDomiciliacionTable );
                      MainDataSet := RptOrdenDomiciliacionTable;

                      OpenReportTables;
                      InsertaRegistro;

                      FijaValoresAcreedor;

                      ExportFileName := ExportToPDF( 'Mandato-' + ClienteFields.Codigo.Value + '.pdf' );
                      PathFicheroAlmacen := AlmacenDocumentosPath + ExtractFileName( ExportFileName );
                      If   not CopyFile( ExportFileName, PathFicheroAlmacen )
                      then begin
                           ShowNotification( ntError, RsMsg9, Format( RsMsg10, [ AlmacenDocumentosPath ] ) );
                           Abort;
                           end;

                      ProcessFrame.AddRecordMsg( RsMsg3 );

                      With ExportImport do
                          try
                            InsertaParametros;
                            SMTPInit( tdMandato,
                                      [ ClienteFields.Nombre.Value, ClienteFields.EMail.Value ],
                                      MessageTitle,
                                      MessageDescription,
                                      [ ExportFileName ] );
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
         end;

end;

procedure TFrpManForm.EnviarPorCorreoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With ExcluirClientesCorreoCtrl do
       begin
       Enabled := not EnviarPorCorreoCtrl.Checked;
       If   not Enabled
       then DataExcluirClientesCorreo.Value := False;
       end;
end;

procedure TFrpManForm.InsertaRegistro;

var   Index,
      NroCopias : Integer;
      CodigoIBANDeudor : String;

begin

     With RptOrdenDomiciliacionFields do
       begin

       RptOrdenDomiciliacionTable.Append;

       Codigo.Value := ClienteFields.Codigo.Value;

       Nombre.Value := ClienteFields.Nombre.Value;
       Domicilio.Value := ClienteFields.Domicilio.Value;
       localidad.Value := ClienteFields.Localidad.Value;
       CodigoPais.Value := ClienteFields.CodigoPais.Value;
       NombrePais.Value := Pais.Descripcion( ClienteFields.CodigoPais.Value, true );
       CP.Value := ClienteFields.CodigoProvincia.Value + ClienteFields.CodigoPostal.Value;
       Provincia.Value := dm_prv.Provincia.Descripcion( ClienteFields.CodigoPais.Value, ClienteFields.CodigoProvincia.Value, False );
       ReferenciaMandato.Value := ClienteFields.Cobro_ReferenciaMandato.Value;

       If   ClienteFields.CodigoPais.Value='011'
       then begin
            SwiftBIC.Value :=  EntidadFinanciera.ObtenBIC( ClienteFields.Cobro_CodigoEntidad.Value, ClienteFields.Cobro_CodigoSucursal.Value );
            CodigoIBANDeudor := Pais.CodigoISO2( ClienteFields.CodigoPais.Value ) +
                                                 '00' +
                                                 ClienteFields.Cobro_CodigoEntidad.Value +
                                                 ClienteFields.Cobro_CodigoSucursal.Value +
                                                 ClienteFields.Cobro_DC.Value +
                                                 ClienteFields.Cobro_Cuenta.Value;
            CalculaDCIBAN( CodigoIBANDeudor );
            IBAN.Value :=  CodigoIBANDeudor;
            end
       else begin
            SwiftBIC.Value := ClienteFields.Cobro_BIC.Value;
            IBAN.Value := ClienteFields.Cobro_IBAN.Value;
            end;

       RptOrdenDomiciliacionTable.Post;

       ApplicationContainer.ShowProgression;

       end;

end;

procedure TFrpManForm.SeleccionaRegistros;

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

procedure TFrpManForm.FormManagerOkButton;

var  ExportFileName,
     SubjectLine,
     SubjectText : String;
     SubjectFile : TextFile;

begin
     If   DataEnviarPorCorreo.Value
     then CreateProcessForm( EnviarPorCorreo, RsMsg1 )
     else Report.Launch;
end;

procedure TFrpManForm.ActualizaRejilla;

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
         2 : StrAdd( SQLText, SQLFormat( 'CodigoPais=%s and ( CodigoProvincia Between %s and %s ) and ( CodigoPostal Between %s and %s ) ',
                                         [ DataCodigoPais,
                                           DataProvinciaInicial, DataProvinciaFinal,
                                           DataCodigoPostalInicial, DataCodigoPostalFinal ] ) +
                                         'Order By CodigoPais, CodigoProvincia, CodigoPostal' );
         3 : StrAdd( SQLText, SQLFormat( 'Cobro_FormaCobro Between %s and %s', [ DataFormaCobroInicial, DataFormaCobroFinal ] ) + ' Order By Cobro_FormaCobro, Codigo' );
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

procedure TFrpManForm.FormManagerPreparedForm;
begin
     ActualizaRejilla;
end;

procedure TFrpManForm.PageControlChange(Sender: TObject);
begin
     PageControl.ActivePage.SetFocus;
     SelectNextControl;
end;

procedure TFrpManForm.PageControlExit(Sender: TObject);
begin
     If   Assigned( ActiveControl )
     then ActualizaRejilla;
end;

procedure TFrpManForm.CodigoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TFrpManForm.ReglaImpresoCtrlPropertiesChange(Sender: TObject);
begin
     If   ReglaImpresoCtrl.ItemIndex=0
     then Report.FileName := 'fmcore'
     else Report.FileName := 'fmb2b';
end;

procedure TFrpManForm.ReportBeforeStart;
begin
     RptOrdenDomiciliacionTable  := Report.CreateEmptyTable( 'OrdenDomiciliacion', DataModule10.SQLSet );
     RptOrdenDomiciliacionFields := TOrdenDomiciliacionFields.Create( RptOrdenDomiciliacionTable );
     FijaValoresAcreedor;
     SeleccionaRegistros;
end;

procedure TFrpManForm.ProvinciaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProvincias( DataCodigoPais.Value, Sender );
end;

procedure TFrpManForm.ProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( DataCodigoPais.Value, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TFrpManForm.ProvinciaFinalCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ProvinciaFinalCtrl.Editing
     then CodigoPostalFinalCtrl.PostEditValue( '' );
end;

procedure TFrpManForm.ProvinciaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ProvinciaInicialCtrl.Editing
     then CodigoPostalInicialCtrl.PostEditValue( '' );
end;

end.

