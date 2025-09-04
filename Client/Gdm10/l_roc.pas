unit l_roc;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,

  Menus, cxLookAndFeelPainters, cxButtons, cxGraphics,
  cxCheckBox, cxDBEdit, cxDropDownEdit, cxCurrencyEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxCalendar, DB, nxdb,
  DataManager, ReportManager, dxmdaset,

  cxIndexedComboBox, dxSkinsCore, dxSkinsDefaultPainters,
  cxLookAndFeels, cxLabel, cxGroupBox, EditSelector, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,

  Gim00Fields,
  Gim10Fields,

  dmi_iex;

type
    TRptRocForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    FormManager: TgxFormManager;
    ImporteMinimoCtrl: TcxDBCurrencyEdit;
    AsientoTable: TnxeTable;
    ApunteTable: TnxeTable;
    TipoCtrl: TcxDBIndexedComboBox;
    ClientesRetencionCtrl: TcxDBCheckBox;
    gxRangeBox2: TgxRangeBox;
    Data: TgxMemData;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataImporteMinimo: TBCDField;
    DataTipoDocumento: TSmallintField;
    DataClientesRetencion: TBooleanField;
    CartaReport: TgxReportManager;
    OrdenarPorNIFCtrl: TcxDBCheckBox;
    DataOrdenarPorNIF: TBooleanField;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label5: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    AgruparPorNIFCtrl: TcxDBCheckBox;
    DataAgruparPorNIF: TBooleanField;
    EnviarPorCorreoCtrl: TcxDBCheckBox;
    DataEnviarPorCorreo: TBooleanField;
    ExcluirClientesCorreoCtrl: TcxDBCheckBox;
    DataExcluirClientesCorreo: TBooleanField;
    CuentaRangeBox: TgxRangeBox;
    SubcuentaInicialCtrl: TcxDBTextEdit;
    SubcuentaFinalCtrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    Label7: TcxLabel;
    Label9: TcxLabel;
    EditSelector: TgxEditSelector;
    DataSubcuentaInicial: TStringField;
    DataSubcuentaFinal: TStringField;
    cxGridViewRepository1: TcxGridViewRepository;
    CuentasTableView: TcxGridDBTableView;
    CuentasTableViewCodigo: TcxGridDBColumn;
    CuentasTableViewDescripcion: TcxGridDBColumn;
    CuentasDataSource: TDataSource;
    CuentasTable: TnxeTable;
    CuentasTableNroRegistro: TSmallintField;
    CuentasTableCodigo: TStringField;
    CuentasTableDescripcion: TStringField;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure AgruparPorNIFCtrlPropertiesChange(Sender: TObject);
    procedure TipoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EnviarPorCorreoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SubcuentaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SubcuentaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CuentasTableViewCodigoPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CuentasTableViewCodigoPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure CuentasTableViewCodigoPropertiesEnter(Sender: TcxCustomEdit);
    private
      AsientoFields : TAsientoFields;
      ApunteFields : TApunteFields;
      DsClienteFields : TClienteFields;
      DsTiposIVAFields : TTiposIVAFields;

      RptDocumentoTable : TnxeTable;
      RptDocumentoFields : TDocumentoFields;

      ActiveReport : TgxReportManager;

      procedure SeleccionaRegistros( SubcuentaCliente : String = '' );
      procedure ActualizaEstadoComponentes;
      procedure EnviaDocumentosPorCorreo;

    public


    end;

var  RptRocForm: TRptRocForm = nil;

procedure RelacionOperacionesClientes;


implementation

uses   Files,
       FileCtrl,

       LibUtils,
       DateUtils,
       AppManager,

       SessionDataAccess,
       EnterpriseDataAccess,

       Gdm10Dm,

       dmi_ast,

       dm_ast,
       dm_cli,
       dm_iex,
       dm_sub,
       dm_prv,
       dm_ban,
       dm_pai,
       dm_iva,
       dm_fac,

       cx_sub,

       f_prg,

       b_pro,
       b_msg,
       b_dir;

{$R *.DFM}

resourceString
       RsMsg1  = '*** Sin ficha de cliente asociada ***';
       RsMsg2  = 'Enviado los documentos por correo';
       RsMsg3  = 'Exportando en la carpeta : %s.';
       RsMsg4  = 'Creado el fichero [URL=%s]%s[/URL].';
       RsMsg5  = 'No se ha podido crear o copiar el fichero al almacén de documentos.';
       RsMsg6  = 'Se cancela la generación y envío documentos.'#13'Verifique que tiene acceso al directorio de documentos [B]%s[/B] y reintente el proceso.';
       RsMsg7  = 'Comunicado a clientes (carta de operaciones realizadas)';
       RsMsg8  = 'Ha ocurrido un problema al enviar el impreso por E-mail.';
       RsMsg9  = 'Revise la configuración del correo y/o la conexión a Internet y reintente el proceso.';
       RsMsg10 = 'La subcuenta %s no tiene asociada una ficha de cliente o no dispone de dirección de correo.';

const  StDocumento = 'Documento';

procedure RelacionOperacionesClientes;
begin
     CreateReportForm( TRptRocForm, RptRocForm );
end;

procedure TRptRocForm.initializeForm;
begin

     AsientoFields := TAsientoFields.Create( AsientoTable );
     ApunteFields := TApunteFields.Create( ApunteTable );

     DsClienteFields := TClienteFields.Create( Self );
     DsTiposIVAFields := TTiposIVAFields.Create( Self );

     SetEditControlDecimals( ImporteMinimoCtrl );

     DataFechaInicial.Value := ApplicationContainer.FirstDayOfYearDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataSubcuentaInicial.Value := '430000000';
     DataSubcuentaFinal.Value := '439999999';
     DataImporteMinimo.Value := 3005.06;
     DataTipoDocumento.Value := 0;

end;

procedure TRptRocForm.SeleccionaRegistros( SubcuentaCliente : String = '' );

var   CodigoAgrupacion : String;
      PropietarioConFicha : Boolean;
      ImporteFactura : Decimal;
      IndiceTrimestre,
      NroTrimestre : SmallInt;
      ImporteTrimestre : array[ 1..4 ] of Decimal;

begin

     If   DataAgruparPorNIF.Value
     then RptDocumentoTable.IndexFieldNames := 'NIF'
     else RptDocumentoTable.IndexFieldNames := 'CodigoSubcuenta';

     With AsientoTable do
       begin

       SetRange( [ taFraEmitida, DataFechaInicial.Value ], [ taFraEmitida, DataFechaFinal.Value ] );

       ApplicationContainer.StartProgression( RecordCount );
       try

         First;
         While not Eof  do
           begin

           ImporteFactura := 0.0;
           NroTrimestre := ( ( MonthOf( AsientoFields.Fecha.Value ) - 1 ) div 3 ) + 1;

           ApplicationContainer.ShowProgression;
           With ApunteTable do
             begin

             SetRange( [ AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value, 1 ],
                       [ AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value, MaxSmallint ] );

             First;
             While not Eof do
               begin

               If   ApunteFields.NroApunte.Value=1  // El apunte del propietario
               then begin

                    If   Factura.ObtenCodigoAgrupacionDeudor( ApunteFields.Subcuenta.Value, DataAgruparPorNIF.Value, PropietarioConFicha, CodigoAgrupacion, DsClienteFields )
                    then If   EditSelector.ValidValue( { SubcuentaPropietario } ApunteFields.Subcuenta.Value )
                         then begin

                              If   RptDocumentoTable.FindKey( [ CodigoAgrupacion ] )
                              then RptDocumentoTable.Edit
                              else begin

                                   If   not PropietarioConFicha or
                                        ( PropietarioConFicha and ( ( DsClienteFields.CodigoPais.Value=CodigoEspaña ) and
                                          ( ( DsClienteFields.Factura_TipoRet.Value=0 ) or ( DataClientesRetencion.Value ) ) ) )
                                   then  With RptDocumentoFields do
                                           begin

                                           RptDocumentoTable.Append;

                                           CodigoSubcuenta.Value := ApunteFields.Subcuenta.Value;
                                           // Los pongo a cero para evitar que contengan nulos
                                           Importe.Value := 0.0;
                                           For IndiceTrimestre := 1 to 4 do
                                             ImporteTrimestre[ IndiceTrimestre ].Value := 0.0;
                                           ImporteEfectivo.Value := Asiento.ImporteCobrosEfectivo( CodigoSubcuenta.Value, DataFechaInicial.Value, DataFechaFinal.Value, False );

                                           If   PropietarioConFicha
                                           then begin
                                                Codigo.Value := DsClienteFields.Codigo.Value;
                                                Nombre.Value := DsClienteFields.Nombre.Value;
                                                Domicilio.Value := DsClienteFields.Domicilio.Value;
                                                Localidad.Value := DsClienteFields.Localidad.Value;
                                                CodigoPostal.Value := DsClienteFields.CodigoProvincia.Value + DsClienteFields.CodigoPostal.Value;
                                                Provincia.Value := dm_prv.Provincia.Descripcion( DsClienteFields.CodigoPais.Value, DsClienteFields.CodigoProvincia.Value, True );
                                                NIF.Value := DsClienteFields.NIF.Value;
                                                end
                                           else begin
                                                Nombre.Value := Cuenta.Descripcion( CodigoSubcuenta.Value, True, False );
                                                Domicilio.Value := RsMsg1;
                                                end;
                                         end;
                                   end;
                              end;
                   end
              else If   ApunteFields.TipoApunte.Value=tapManual
                   then begin

                        //* 25.02.2009   Excluyendo los suplidos

                        Tasa.TipoIVA( ApunteFields.Fecha.Value, ApunteFields.Tipo.Value, DsTiposIVAFields );
                        If   not ( DsTiposIVAFields.SobreTotal.Value )  // Suplido
                        then DecAdd( ImporteFactura, ApunteFields.ImporteTotal.Value );

                        end;

               Next;
               end;

             end;

           If   RptDocumentoTable.Editing
           then begin
                RptDocumentoFields.Importe.Value := RptDocumentoFields.Importe.Value + ImporteFactura;
                RptDocumentoFields.ImporteTrimestre[ NroTrimestre ].Value := RptDocumentoFields.ImporteTrimestre[ NroTrimestre ].Value + ImporteFactura;
                RptDocumentoTable.Post;
                end;

           Next;
           end;

         // Suprimiendo los registros que no superan el importe minimo

         With RptDocumentoTable do
           begin
           First;
           While not Eof do
             begin
             ApplicationContainer.ShowProgression;
             If   Abs( RptDocumentoFields.Importe.Value )<DataImporteMinimo.Value
             then Delete
             else Next;
             end;
           end;

       finally
          ApplicationContainer.EndProgression;
          end;

       end;

end;

procedure TRptRocForm.SubcuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, False );
end;

procedure TRptRocForm.SubcuentaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptRocForm.TipoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ActualizaEstadoComponentes;
end;

procedure TRptRocForm.AgruparPorNIFCtrlPropertiesChange(Sender: TObject);
begin
     OrdenarPorNIFCtrl.Enabled := not AgruparPorNIFCtrl.Checked;
end;

procedure TRptRocForm.CuentasTableViewCodigoPropertiesEnter(Sender: TcxCustomEdit);
begin
     With CuentasTableViewCodigo do
       If   ValueIsEmpty( EditValue )
       then EditValue := '43';
end;

procedure TRptRocForm.CuentasTableViewCodigoPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender );
end;

procedure TRptRocForm.CuentasTableViewCodigoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     var Descripcion := Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, False );
     If   not Error and CuentasTable.Editing
     then CuentasTableDescripcion.Value := Descripcion;
end;

procedure TRptRocForm.EnviarPorCorreoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ActualizaEstadoComponentes;
end;

procedure TRptRocForm.ActualizaEstadoComponentes;
begin
     EnviarPorCorreoCtrl.Enabled := TipoCtrl.ItemIndex=1;
     ExcluirClientesCorreoCtrl.Enabled := ( TipoCtrl.ItemIndex=1 ) and not EnviarPorCorreoCtrl.Checked;
end;

procedure TRptRocForm.EnviaDocumentosPorCorreo;

var   AlmacenDocumentosPath,
      PathFicheroAlmacen,
      ExportFileName,
      CodigoGrupo,
      CodigoGrupoActual,
      SubjectText : String;

procedure EnviaDocumento;

var  CartaDocumentoTable : TnxeTable;

procedure InsertaParametros;
begin
     With ExportImport do
       begin
       HeaderList.Values[ RsCodigoEmpresa ] := CodigoEmpresaActual;
       HeaderList.Values[ RsNombreEmpresa ] := ApplicationContainer.Empresa_Nombre;
       HeaderList.Values[ RsCodigoPropietario ] := RptDocumentoFields.CodigoSubcuenta.Value;
       HeaderList.Values[ RsNombrePropietario ] := RptDocumentoFields.Nombre.Value;
       end;
end;

begin
     ExportFileName := 'roc' + IntToStr( ApplicationContainer.Ejercicio ) + '_' + CodigoGrupo;
     With ActiveReport do
       try
         Load;

         If   SubjectText=''
         then SubjectText := FrxReport.ReportOptions.Description.GetText;

         CartaDocumentoTable := CreateEmptyTable( StDocumento, DataModule10.SQLSet );
         try

           CartaDocumentoTable.Append;  // Un solo registro por documento
           CartaDocumentoTable.CopyFields( RptDocumentoTable );
           CartaDocumentoTable.Post;

           ExportFileName := ExportToPDF( ExportFileName + '.pdf' );

           PathFicheroAlmacen := AlmacenDocumentosPath + ExtractFileName( ExportFileName );
           If   not CopyFile( ExportFileName, PathFicheroAlmacen )
           then begin
                ShowNotification( ntError, RsMsg5, Format( RsMsg6, [ AlmacenDocumentosPath ] ) );
                Abort;
                end;

           ProcessFrame.AddMsg( ntLinkInformation, Format( RsMsg4, [ PathFicheroAlmacen, ExtractFileName( ExportFileName ) ] ) );

           If   Cliente.ObtenPorSubcuenta( RptDocumentoFields.CodigoSubcuenta.Value, DsClienteFields ) and
                ( DsClienteFields.EMail.Value<>'' )
           then With ExportImport do
                  try

                    InsertaParametros;

                    SMTPInit( tdCartaOperacionesClientes,
                              [ RptDocumentoFields.Nombre.Value, DsClienteFields.EMail.Value ],
                              RsMsg7,
                              SubjectText,
                              [ ExportFileName ] );

                    SMTPSend;

                    EraseFile( ExportFileName, False );

                  except on E : Exception do
                    begin
                    ShowNotification( ntExceptionError, RsMsg8, RsMsg9 + #13 + E.Message );
                    end;
                  end
           else ProcessFrame.AddMsg( ntWarning, Format( RsMsg10, [ RptDocumentoFields.CodigoSubcuenta.Value ] ) );

         finally
           Reset;
           end;

       except on E : Exception do
         Cancel( E );
         end;
end;

begin

     If   DataOrdenarPorNIF.Value
     then RptDocumentoTable.IndexFieldNames := 'NIF';

     AlmacenDocumentosPath := ApplicationPath + 'doc_' + CodigoEmpresaActual  + '\Relacion operaciones con clientes\' + IntToStr( ApplicationContainer.Ejercicio ) + '\PDF\';
     CreateDirPath( AlmacenDocumentosPath );
     ProcessFrame.AddMsg( ntInformation, Format( RsMsg3, [ AlmacenDocumentosPath ] ) );

     CodigoGrupoActual := '';
     SubjectText := '';

     With RptDocumentoTable do
       begin
       First;
       While not Eof do
         begin

         If   DataOrdenarPorNIF.Value
         then CodigoGrupo := RptDocumentoFields.NIF.Value
         else CodigoGrupo := RptDocumentoFields.CodigoSubcuenta.Value;

         If   CodigoGrupo<>CodigoGrupoActual
         then begin
              CodigoGrupoActual := CodigoGrupo;
              EnviaDocumento;
              end;

         Next;
         end;
       end;

end;

procedure TRptRocForm.FormManagerOkButton;
begin

     If   DataTipoDocumento.Value=0
     then ActiveReport := Report
     else begin
          ActiveReport := CartaReport;
          If   DataEnviarPorCorreo.Value
          then begin
               RptDocumentoTable := SessionDataModule.CreateEmptyTable( nil, StDocumento, DataModule10.SQLSet.GetSQLText( StDocumento ) );   // No asociado al report
               try
                 RptDocumentoFields := TDocumentoFields.Create( RptDocumentoTable );
                 SeleccionaRegistros;
                 CreateProcessForm( EnviaDocumentosPorCorreo, RsMsg2 );
               finally
                 FreeAndNil( RptDocumentoTable );
                 end;

               Exit;
               end;
          end;

     With ActiveReport do
       try
         Load;
         RptDocumentoTable := CreateEmptyTable( 'Documento', DataModule10.SQLSet );
         RptDocumentoFields := TDocumentoFields.Create( RptDocumentoTable );
         SeleccionaRegistros;
         If   DataOrdenarPorNIF.Value
         then RptDocumentoTable.IndexFieldNames := 'NIF';
         MainDataset := RptDocumentoTable;  // Es solo para que avise si el fichero está vacío
         Start;
       except on E : Exception do
         Cancel( E );
         end;

end;

end.

