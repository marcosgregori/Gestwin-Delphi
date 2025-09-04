unit f_cli;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls, DB, nxDB, DataManager,

  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  cxCheckBox, cxMaskEdit, cxSpinEdit, cxCurrencyEdit,

  AppForms,

  Menus, cxLookAndFeelPainters, cxButtons, dxSkinsCore,
  dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox, cxMemo, cxRichEdit, cxDBRichEdit,
  dxUIAClasses;

type
  TMntCliFrame = class(TFrame)
    VendedorPanel: TcxGroupBox;
    VendedorCtrl: TcxDBTextEdit;
    FacturacionPanel: TcxGroupBox;
    Factura_DtoPPCtrl: TcxDBCurrencyEdit;
    Factura_DtoESCtrl: TcxDBCurrencyEdit;
    Factura_CreditoCtrl: TcxDBCurrencyEdit;
    Factura_AgrupacionCtrl: TcxDBTextEdit;
    Factura_TarifaCtrl: TcxDBTextEdit;
    Factura_ComisionCtrl: TcxDBCurrencyEdit;
    Factura_NroCopiasCtrl: TcxDBSpinEdit;
    Factura_RecFinancCtrl: TcxDBCurrencyEdit;
    Factura_NroCopiasAlbaranCtrl: TcxDBSpinEdit;
    Factura_EnviarPorCorreoCtrl: TcxDBCheckBox;
    datEconButton: TgBitBtn;
    ConsumosButton: TgBitBtn;
    DocumentosButton: TgBitBtn;
    EnviosPanel: TcxGroupBox;
    Envios_NombreCtrl: TcxDBTextEdit;
    Envios_DomicilioCtrl: TcxDBTextEdit;
    Envios_LocalidadCtrl: TcxDBTextEdit;
    Envios_FormaEnvioCtrl: TcxDBTextEdit;
    Envios_CodigoProvCtrl: TcxDBTextEdit;
    Envios_CodigoPostalCtrl: TcxDBTextEdit;
    Envios_TransportistaCtrl: TcxDBTextEdit;
    VendedorCaptionLabel: TcxLabel;
    DescVendedorLabel: TcxLabel;
    Label5: TcxLabel;
    Label12: TcxLabel;
    Label14: TcxLabel;
    capGrupoClienteLabel: TcxLabel;
    DescGrupoClienteLabel: TcxLabel;
    capTarifaLabel: TcxLabel;
    DescTarifaLabel: TcxLabel;
    capComisionLabel: TcxLabel;
    Label15: TcxLabel;
    Label11: TcxLabel;
    Label4: TcxLabel;
    Label34: TcxLabel;
    Label35: TcxLabel;
    Label36: TcxLabel;
    Label41: TcxLabel;
    NombreEnviosLabel: TcxLabel;
    DomicilioEnviosLabel: TcxLabel;
    LocalidadEnviosLabel: TcxLabel;
    TextoEnvioLabel: TcxLabel;
    EnviosProvinciaCaptionLabel: TcxLabel;
    DescProvinciaEnviosLabel: TcxLabel;
    CaptionTransportistaLabel: TcxLabel;
    DescTransportistaLabel: TcxLabel;
    Factura_SinDtosConsumoCtrl: TcxDBCheckBox;
    FormaEnvioLabel: TcxLabel;
    Envios_CodigoFormaEnvioCtrl: TcxDBTextEdit;
    DescFormaEnvioLabel: TcxLabel;
    Factura_CodigoEANCtrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    LocalizarButton: TgBitBtn;
    LocalizacionCaptionLabel: TcxLabel;
    LongitudCtrl: TcxDBTextEdit;
    LatitudCtrl: TcxDBTextEdit;
    cxLabel2: TcxLabel;
    PegarLocalizacionBtn: TgBitBtn;
    BloqueoEnviosPanel: TcxGroupBox;
    Envios_BloqueadoCtrl: TcxDBCheckBox;
    Envios_MotivoBloqueoCtrl: TcxDBRichEdit;
    MotivoLabel: TcxLabel;
    CampoLibre1Panel: TcxGroupBox;
    campo1Label: TcxLabel;
    CampoLibre1Ctrl: TcxDBTextEdit;
    CampoLibre2Panel: TcxGroupBox;
    campo2Label: TcxLabel;
    CampoLibre2Ctrl: TcxDBTextEdit;
    CampoLibre3Panel: TcxGroupBox;
    campo3Label: TcxLabel;
    CampoLibre3Ctrl: TcxDBTextEdit;
    CampoLibre4Panel: TcxGroupBox;
    campo4Label: TcxLabel;
    CampoLibre4Ctrl: TcxDBTextEdit;
    Factura_NoAplicarOfertasCtrl: TcxDBCheckBox;
    procedure VendedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Factura_AgrupacionCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Factura_AgrupacionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Factura_AgrupacionCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Factura_TarifaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Factura_TarifaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Factura_TarifaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Envios_TransportistaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Envios_TransportistaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Envios_TransportistaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Factura_EnviarPorCorreoCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure Envios_CodigoPostalCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Envios_CodigoPostalCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Envios_CodigoPostalCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Envios_CodigoProvCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Envios_CodigoProvCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Envios_CodigoProvCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure DatEconButtonClick(Sender: TObject);
    procedure DocumentosButtonClick(Sender: TObject);
    procedure ConsumosButtonClick(Sender: TObject);
    procedure Envios_CodigoFormaEnvioCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Envios_CodigoFormaEnvioCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Envios_CodigoFormaEnvioCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure LocalizarButtonClick(Sender: TObject);
    procedure PegarLocalizacionBtnClick(Sender: TObject);
    procedure Factura_AgrupacionCtrlPropertiesValuePosted(Sender: TObject);
    procedure Envios_BloqueadoCtrlPropertiesChange(Sender: TObject);
    procedure CoordenadaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
  private

    procedure ClienteTableBeforeDelete(DataSet: TDataSet);
    procedure FormManagerLabelsRequest;
    procedure FormManagerReportRequest;

    procedure DoOnImpresosClientes( Sender : TObject );
    procedure DoOnFocusedAreaChanged;

  protected
  end;

var MntCliFrame : TMntCliFrame;

implementation

uses Vcl.Clipbrd,

     dxBar,

     LibUtils,
     AppManager,
     EnterpriseDataAccess,

     Gdm00Dm,
     Gdm30Dm,

     Gim10Fields,
     Gim30Fields,

     Gdm30Frm,

     a_cli,
     a_prv,
     a_ven,
     a_gdc,
     a_cop,
     a_cdt,
     a_tra,
     a_fde,

     dm_ven,
     dm_sdf,
     dm_prv,
     dm_cop,
     dm_gdc,
     dm_cdt,
     dm_tra,
     dm_rcl,
     dm_fde,

     b_rdc,
     b_rcc,
     b_msg,
     b_lcl,

     cx_sdf,
     cx_ven,
     cx_cop,
     cx_prv,
     cx_gdc,
     cx_cdt,
     cx_tra,
     cx_fde,

     d_cli,
     l_cli,
     i_cli,
     e_cli;

{$R *.dfm}

resourceString

     RsMsg5  = 'El cliente no tiene una dirección de correo válida.';
     RsMsg6  = 'Introduzca primera una dirección de correo y luego marque esta opción.';
     RsMsg7  = 'Impresos de clientes';
     RsMsg8  = 'No se ha podido copiar la localización';
     RsMsg9  = 'Compruebe que el formato es el adecuado (pe."40.726636, 0.787837") y reintente el proceso.<br/>Contenido actual : ';
     RsMsg10 = 'Debe completar el contenido de los campos de localización : latitud y longitud.';

procedure SetupFrame;

var Index : SmallInt;
    MenuItem : TdxBarButton;

procedure FijaCampoLibre( Index          : SmallInt;
                          CampoLibreCtrl : TcxDBTextEdit );

var  Panel : TcxGroupBox;

begin
     With DataModule00.DmEmpresaFields do
       If   not ValueIsEmpty( Cliente_CampoLibre[ Index ].Value )
       then begin
            Panel := CampoLibreCtrl.Parent as TcxGroupBox;
            Panel.Parent := MntCliForm.EnviosScrollBox;
            Panel.Top := MaxSmallint;
            Panel.Align := alTop;
            CampoLibreCtrl.CaptionLabel.EditValue := Cliente_CampoLibre[ Index ].Value;
            CampoLibreCtrl.Properties.Required := Cliente_CampoLibOblig[ Index ].Value;
            end;
end;

begin
     If   Assigned( MntCliForm )
     then begin

          MntCliFrame := TMntCliFrame.Create( MntCliForm );

          With MntCliFrame do
            begin

            MntCliForm.AppSection := TGds30Frm.VentasSection;
            MntCliForm.HelpFile := 'hs30';

            // Colocando los paneles y botones en su posición dentro de la ventana de edición

            VendedorPanel.Parent := MntCliForm.GeneralScrollBox;
            VendedorPanel.Top := ScaledToCurrent( MntCliForm.GeneralTopPanel.Height + 1 );  // Entre 2 paneles
            VendedorPanel.Align := alTop;
            VendedorPanel.TabOrder := 1;

            MntCliForm.Height := MntCliForm.Height + VendedorPanel.Height;

            var BottomPos := ScaledToCurrent( MntCliForm.DatosGeneralesTabSheet.Height );

            MntCliForm.GeneralBottomPanel.Top := BottomPos;
            MntCliForm.TiendaVirtualPanel.Top := BottomPos;

            With MntCliForm.EnviosTabSheet do
              begin
              TabVisible := True;
              Visible := True;
              end;

            EnviosPanel.Parent := MntCliForm.EnviosScrollBox;
            EnviosPanel.Align := alTop;

            If   DataModule00.DmEmpresaFields.Cliente_CamposLibres.Value
            then begin
                 FijaCampoLibre( 1, CampoLibre1Ctrl );
                 FijaCampoLibre( 2, CampoLibre2Ctrl );
                 FijaCampoLibre( 3, CampoLibre3Ctrl );
                 FijaCampoLibre( 4, CampoLibre4Ctrl );
                 end;

            // Solo si existe el m�dulo de gesti�n de bloqueos y el usuario es un 'Credit Manager'

            If   ApplicationContainer.IsModuleActive( [ 118 ] ) and
                 DataModule00.UserIsACreditManager
            then begin
                 BloqueoEnviosPanel.Parent := MntCliForm.EnviosScrollBox;
                 BloqueoEnviosPanel.Top := MaxSmallint;
                 end;

            FacturacionPanel.Parent := MntCliForm.FacturacionTabSheet;
            FacturacionPanel.Top := ScaledToCurrent( MntCliForm.ModeloImpositivoPanel.Height + 1 );
            FacturacionPanel.Align := alClient;

            AddPanelButton( MntCliForm.ButtonsContainerPanel, DocumentosButton );
            AddPanelButton( MntCliForm.ButtonsContainerPanel, ConsumosButton );
            AddPanelButton( MntCliForm.ButtonsContainerPanel, DatEconButton );

            If   ( DataModule00.DmEmpresaFields.Ventas_PreAutoVenta.Value<>0 ) or
                 ( DataModule00.DmEmpresaFields.Cliente_Localizacion.Value )
            then begin
                 AddPanelButton( MntCliForm.ButtonsContainerPanel, LocalizarButton );
                 LocalizacionCaptionLabel.Enabled := True;
                 end;

             With MntCliForm.ButtonsContainerPanel do
                Left := ( Parent.Width - Width ) div 2;

            // Inicializando los componentes

            With DataModule00.DmEmpresaFields do
              begin

              Envios_TransportistaCtrl.Enabled := Ventas_Transportista.Value;
              Envios_CodigoFormaEnvioCtrl.Enabled := Ventas_FormaEnvio.Value;
              Factura_AgrupacionCtrl.Enabled := Cliente_GruposFac.Value;
              Factura_TarifaCtrl.Enabled := Cliente_TarCodigo.Value;
              Factura_ComisionCtrl.Enabled := Vendedor_ComPorCli.Value;

              SetEditControlsDecimals( [ Factura_CreditoCtrl ] );
              SetEditControlsDecimals( [ Factura_DtoPPCtrl, Factura_DtoESCtrl, Factura_RecFinancCtrl, Factura_ComisionCtrl ], 2 );

              // Para el ajuste de los codigos postales

              MntCliForm.Envios_CodigoProvCtrl := Envios_CodigoProvCtrl;
              MntCliForm.Envios_CodigoPostalCtrl := Envios_CodigoPostalCtrl;
              end;

            MntCliForm.ClienteTable.BeforeDelete :=  ClienteTableBeforeDelete;

            MntCliForm.FormManager.OnFocusedAreaChanged := DoOnFocusedAreaChanged;
            MntCliForm.FormManager.OnLabelsRequest := FormManagerLabelsRequest;
            MntCliForm.FormManager.OnReportRequest := FormManagerReportRequest;

            MenuItem := MntCliForm.BarManager.AddButton;
            If   Assigned( MenuItem )
            then begin
                 MenuItem.Caption := RsMsg7;
                 MenuItem.OnClick := DoOnImpresosClientes;
                 MntCliForm.ReportFormsPopupMenu.ItemLinks.Add( MenuItem );
                 end;

            end;

          ExecComponentProcedures( idMntCliFrame, imOnCreateComponent );

          end;
end;

procedure TMntCliFrame.VendedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntVendedores( [ Sender.Editingvalue ] );
end;

procedure TMntCliFrame.VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TMntCliFrame.VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error );
     If   VendedorCtrl.Editing
     then If   not ValueIsEmpty( DisplayValue ) and
               DataModule00.DmEmpresaFields.Vendedor_ComPorCli.Value and
               ValueIsEmpty( MntCliForm.ClienteFields.Factura_Comision.Value ) and
               ( MntCliForm.ClienteTable.State=dsInsert )
          then MntCliForm.ClienteFields.Factura_Comision.Value := Vendedor.DmVendedorFields.Comision.Value;
end;

procedure TMntCliFrame.Factura_AgrupacionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntGruposCliente( [ Sender.EditingValue ] );
end;

procedure TMntCliFrame.Factura_AgrupacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TMntCliFrame.Factura_AgrupacionCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCliFrame.Factura_AgrupacionCtrlPropertiesValuePosted(Sender: TObject);
begin
     If   Factura_TarifaCtrl.Enabled and
          ( MntCliForm.ClienteFields.Factura_Tarifa.Value='' )
     then MntCliForm.ClienteFields.Factura_Tarifa.Value := GrupoCliente.GrupoClienteFields.CodigoTarifa.Value;
end;

procedure TMntCliFrame.Factura_EnviarPorCorreoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With Factura_EnviarPorCorreoCtrl do
       If  Editing
       then If   EditValue
            then If   ValueIsEmpty( MntCliForm.ClienteFields.EMail.Value )
                 then begin
                      PostEditValue( False );
                      ShowNotification( ntWarning, rsMsg5, rsMsg6 );
                      MntCliForm.EMailCtrl.SetFocus;
                      end;
end;

procedure TMntCliFrame.Factura_TarifaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosTarifa( [ Sender.EditingValue ] );
end;

procedure TMntCliFrame.Factura_TarifaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosTarifa( Sender );
end;

procedure TMntCliFrame.Factura_TarifaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoTarifa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCliFrame.Envios_TransportistaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTransportistas( [ Sender.EditingValue ] );
end;

procedure TMntCliFrame.Envios_TransportistaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTransportistas( Sender );
end;

procedure TMntCliFrame.Envios_TransportistaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Transportista.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCliFrame.DatEconButtonClick(Sender: TObject);
begin
     MntCliForm.ClienteTable.Cancel;
     DatosEconomicosClientes( [ MntCliForm.ClienteFields.Codigo.value ] );
end;

procedure TMntCliFrame.DocumentosButtonClick(Sender: TObject);
begin
     MntCliForm.ClienteTable.Cancel;
     RelacionDocumentosClientes( [ MntCliForm.ClienteFields.Codigo.Value ] );
end;

procedure TMntCliFrame.ConsumosButtonClick(Sender: TObject);
begin
     MntCliForm.ClienteTable.Cancel;
     RelacionConsumoClientes( [ MntCliForm.ClienteFields.Codigo.Value ] );
end;

procedure TMntCliFrame.Envios_BloqueadoCtrlPropertiesChange(Sender: TObject);
begin
     Envios_MotivoBloqueoCtrl.Enabled := Envios_BloqueadoCtrl.Checked;
end;

procedure TMntCliFrame.Envios_CodigoFormaEnvioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntFormasEnvio( [ Sender.EditingValue ] );
end;

procedure TMntCliFrame.Envios_CodigoFormaEnvioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasEnvio( Sender );
end;

procedure TMntCliFrame.Envios_CodigoFormaEnvioCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     FormaEnvio.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCliFrame.Envios_CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With MntCliForm.ClienteFields do
       MntCodigosPostales( [ CodigoPais.Value, Envios_CodigoProv.Value, Sender.EditingValue ] );
end;

procedure TMntCliFrame.Envios_CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With MntCliForm.ClienteFields do
       ConsultaCodigosPostales( CodigoPais.Value, Envios_CodigoProv.Value, Sender );
end;

procedure TMntCliFrame.Envios_CodigoPostalCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     With MntCliForm do
       CodigoPostal.Valida( ClienteFields.CodigoPais.Value, ClienteFields.Envios_CodigoProv.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCliFrame.Envios_CodigoProvCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntProvincias( [ MntCliForm.ClienteFields.CodigoPais.Value, Sender.EditingValue ] );
end;

procedure TMntCliFrame.Envios_CodigoProvCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With MntCliForm do
       ConsultaProvincias( ClienteFields.CodigoPais.Value, Sender );
end;

procedure TMntCliFrame.Envios_CodigoProvCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     With MntCliForm do
       Provincia.Valida( ClienteFields.CodigoPais.Value, Sender, DisplayValue, ErrorText, Error );
     If   Sender.ModifiedAfterEnter
     then Envios_CodigoPostalCtrl.EditValue := '';
end;

procedure TMntCliFrame.ClienteTableBeforeDelete(DataSet: TDataSet);
begin
     RelacionesCliente.SuprimeReferencias( MntCliForm.ClienteFields );
end;

procedure TMntCliFrame.FormManagerReportRequest;
begin
     ListadoClientes;
end;

procedure TMntCliFrame.LocalizarButtonClick(Sender: TObject);

var  DireccionCompleta : String;

begin
     With MntCliForm.ClienteFields do
       If   ( Latitud.Value=0.0 ) or ( Longitud.Value=0.0 )
       then begin
            DireccionCompleta := Envios_Domicilio.Value + ' ' +
                                 Envios_CodigoProv.Value + Envios_CodigoPostal.Value + ' ' +
                                 Envios_Localidad.Value;
            LocalizacionCliente( Nombre.Value, DireccionCompleta );
            end
       else LocalizacionCliente( Nombre.Value, Latitud.Value, Longitud.Value );
end;

procedure TMntCliFrame.CoordenadaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CheckNumericValue( DisplayValue, ErrorText, Error );
end;

procedure TMntCliFrame.PegarLocalizacionBtnClick(Sender: TObject);

var  LocText : String;
     Pc : SmallInt;
     Latitud,
     Longitud : Double;

function StructuredToDecimal( Posicion : String ) : Double;

var  Grados,
     Minutos : Integer;     
     Segundos : Decimal;
     SegText : String;
     
begin
     Grados := StrToInt( Copy( Posicion, 1, 2  ) );
     Minutos := StrToInt( Copy( Posicion, 4, 2  ) );
     SegText := Copy( Posicion, 7, 5 ).Replace( '.', ',' );
     Segundos := StrToFloat( SegText );       
     Result := Grados + ( ( ( Minutos * 60 ) + Segundos ) / 100000.0 );
end;
     
begin
     try
       LocText := Clipboard.AsText;
       Pc := Pos( ' ', LocText );
       If   Pc>8
       then begin

            // Formato de Bing   : 40,675530 -1,156445
            // Formato de Google : 40.417164, 0.426488
            //                     17�06'32.36" N  18�12'46.32" E

            If   LocText.Contains( 'N' )
            then begin
                 Latitud := StructuredToDecimal( Copy( LocText, 1, 12 ) );
                 Longitud := StructuredToDecimal( Copy( LocText, 17, 12 ) );
                 end
            else begin
            
                 LocText := StringReplace( LocText, '.', ',' , [ rfReplaceAll ] );

                 If   LocText[ Pc - 1 ]=','
                 then begin
                      Delete( LocText, Pc -1 , 1 );
                      Dec( Pc );
                      end;

                 Latitud := StrToFloat( Copy( LocText, 1, Pc ) );
                 Longitud := StrToFloat( Copy( LocText, Pc + 1, 12 ) );

                 end;
                 
            MntCliForm.ClienteFields.Latitud.Value := Latitud;
            MntCliForm.ClienteFields.Longitud.Value := Longitud;

            end
       else Abort;
     except
       ShowNotification( ntWarning, RsMsg8, RsMsg9 + LocText );
       end;
end;

procedure TMntCliFrame.DoOnFocusedAreaChanged;
begin
     PegarLocalizacionBtn.Enabled := MntCliForm.FormManager.DataAreaFocused;
end;

procedure TMntCliFrame.DoOnImpresosClientes( Sender : TObject );
begin
     ImpresosClientes( MntCliForm.ClienteFields.Codigo.Value );
end;

procedure TMntCliFrame.FormManagerLabelsRequest;
begin
     EtiquetasClientes( MntCliForm.ClienteFields.Codigo.Value );
end;

initialization
  AddProcedure( imOnCreateComponent, idMntCliForm, SetupFrame );

end.

