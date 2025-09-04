

unit a_acc;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  DataManager,
  DataAccess,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxPC, cxControls, DB,
  nxdb, cxContainer, cxEdit, cxGroupBox, cxRadioGroup, cxDBEdit,
  cxHeader, cxTextEdit, cxLabel, cxDBLabel, cxCheckBox, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxGraphics, cxLookAndFeels,
  cxPCdxBarPopupMenu, cxStyles, cxTrackBar, cxVGrid, cxInplaceContainer,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData,
  dxBarBuiltInMenu, cxDBVGrid, dxScrollbarAnnotations,

  Gim00Fields, dxUIAClasses;

type
  TMntAccForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    Panel1: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    PageControl: TcxPageControl;
    ts10: TcxTabSheet;
    ts30: TcxTabSheet;
    ts00: TcxTabSheet;
    ts40: TcxTabSheet;
    ts20: TcxTabSheet;
    ts31: TcxTabSheet;
    UsuarioTable: TnxeTable;
    DataSource: TDataSource;
    Panel4: TcxGroupBox;
    codigoCtrlCaption: TcxLabel;
    DescUsuarioLabel: TcxLabel;
    Label69: TcxLabel;
    cxHeader1: TcxHeader;
    ContableGroupBox: TcxGroupBox;
    TPVGroupBox: TcxGroupBox;
    ComercialGroupBox: TcxGroupBox;
    AlmacenGroupBox: TcxGroupBox;
    ProduccionGroupBox: TcxGroupBox;
    TodasGroupBox: TcxGroupBox;
    ComercialVG: TcxDBVerticalGrid;
    AcCOFicherosCtrl: TcxDBEditorRow;
    AcCOProveedoresCtrl: TcxDBEditorRow;
    AcCOCtrl: TcxDBEditorRow;
    AcCOTarifasCtrl: TcxDBEditorRow;
    AcCOFormasPagoCtrl: TcxDBEditorRow;
    AcCORelacionesCtrl: TcxDBEditorRow;
    AcCOMovimientosCtrl: TcxDBEditorRow;
    AcCOOfertasCtrl: TcxDBEditorRow;
    AcCOPedidosCtrl: TcxDBEditorRow;
    AcCOAlbaranesCtrl: TcxDBEditorRow;
    AcCOProcesosCtrl: TcxDBEditorRow;
    AcVECtrl: TcxDBEditorRow;
    AcVEFicherosCtrl: TcxDBEditorRow;
    AcVEClientesCtrl: TcxDBEditorRow;
    AcVEVendedoresCtrl: TcxDBEditorRow;
    AcVESeriesCtrl: TcxDBEditorRow;
    AcRECtrl: TcxDBEditorRow;
    AcVEProcesosCtrl: TcxDBEditorRow;
    AcVERelacionesCtrl: TcxDBEditorRow;
    AcVEFormasCobroCtrl: TcxDBEditorRow;
    AcVETarifasCtrl: TcxDBEditorRow;
    AcVEModificacionDescuentosCtrl: TcxDBEditorRow;
    AcVEModificacionPrecios: TcxDBEditorRow;
    AcVEModificacionDocumentosCtrl: TcxDBEditorRow;
    cxGroupBox5: TcxGroupBox;
    cxLabel4: TcxLabel;
    GestorCreditoCtrl: TcxDBCheckBox;
    ContableVG: TcxDBVerticalGrid;
    AcGCCtrl: TcxDBEditorRow;
    AcGCFicherosCtrl: TcxDBEditorRow;
    AcGCAsientosCtrl: TcxDBEditorRow;
    AcGCListadosCtrl: TcxDBEditorRow;
    AcGCProcesosCtrl: TcxDBEditorRow;
    AcLICtrl: TcxDBEditorRow;
    AcLIFicherosCtrl: TcxDBEditorRow;
    AcPCCtrl: TcxDBEditorRow;
    AcPCFicherosCtrl: TcxDBEditorRow;
    AcEICtrl: TcxDBEditorRow;
    AcEIFicherosCtrl: TcxDBEditorRow;
    cxDBVerticalGrid1: TcxDBVerticalGrid;
    AcCACtrl: TcxDBEditorRow;
    AcCAFicherosCtrl: TcxDBEditorRow;
    AcCACajaCtrl: TcxDBEditorRow;
    AcCAArqueoCtrl: TcxDBEditorRow;
    AcCAListadosCtrl: TcxDBEditorRow;
    AcCAProcesosCtrl: TcxDBEditorRow;
    cxDBVerticalGrid2: TcxDBVerticalGrid;
    AcALCtrl: TcxDBEditorRow;
    AcALFicherosCtrl: TcxDBEditorRow;
    AcALArticulosCtrl: TcxDBEditorRow;
    AcALListasMaterialesCtrl: TcxDBEditorRow;
    AcALAlmacenesCtrl: TcxDBEditorRow;
    AcALTiposMovimientoCtrl: TcxDBEditorRow;
    AcALProcesosCtrl: TcxDBEditorRow;
    cxDBVerticalGrid3: TcxDBVerticalGrid;
    AcGPCtrl: TcxDBEditorRow;
    AcGPFicherosCtrl: TcxDBEditorRow;
    AcGPRelacionesCtrl: TcxDBEditorRow;
    AcGPOperariosCtrl: TcxDBEditorRow;
    AcGPMaquinasCtrl: TcxDBEditorRow;
    AcGPOperacionesCtrl: TcxDBEditorRow;
    AcGPTurnosCtrl: TcxDBEditorRow;
    AcGPPrevisionCtrl: TcxDBEditorRow;
    AcGPLanzamientoCtrl: TcxDBEditorRow;
    AcGPSeguimientoCtrl: TcxDBEditorRow;
    AcGPNotificacionesCtrl: TcxDBEditorRow;
    AcGPProcesosCtrl: TcxDBEditorRow;
    cxGroupBox1: TcxGroupBox;
    cxDBCheckBox1: TcxDBCheckBox;
    Label49: TcxLabel;
    cxDBCheckBox2: TcxDBCheckBox;
    cxDBVerticalGrid4: TcxDBVerticalGrid;
    AcProcesosCriticosCtrl: TcxDBEditorRow;
    AcInformesCtrl: TcxDBEditorRow;
    AcModificacionInformesCtrl: TcxDBEditorRow;
    AcEdicionInformesCtrl: TcxDBEditorRow;
    AcALCambioPreciosCtrl: TcxDBEditorRow;
    AcVETiendaVirtualCtrl: TcxDBEditorRow;
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure UsuarioTableAfterOpen(DataSet: TDataSet);
    procedure UsuarioTableBeforeInsert(DataSet: TDataSet);
    procedure FormManagerInitializeForm;
    procedure DataInitialize;
    procedure ComercialVGEditorRow1PropertiesEditPropertiesChange(Sender: TObject);
    procedure ComercialVGDBEditorRow9PropertiesEditPropertiesChange(Sender: TObject);
    procedure AcVEFicherosCtrlPropertiesEditPropertiesChange(Sender: TObject);
    procedure AcCOCtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
    procedure AcCOMovimientosCtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
    procedure AcEICtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
    procedure AcGCCtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
    procedure AcLICtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
    procedure AcPCCtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
    procedure UsuarioTableBeforePost(DataSet: TDataSet);
    procedure AcALFicherosCtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
    procedure AcALCtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
    procedure AcGPCtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
    procedure AcGPFicherosCtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
    procedure AcCACtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
    procedure UsuarioTableGetRecord(DataSet: TDataSet);
    procedure AcVEProcesosCtrlPropertiesEditPropertiesChange(
      Sender: TObject);
  private
    UsuarioFields : TUsuarioFields;

    EditValue : SmallInt;

  public

  end;

var
  MntAccForm: TMntAccForm = nil;

procedure ControlAccesos;

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,

       AppManager,

       Gdm00Dm,
       Gdm00Frm,

       dmi_pga,

       dm_usr,
       dm_pga,

       b_msg,

       a_usr,

       cx_usr;

resourceString
       RsMsg1  = 'Para poder fijar los accesos de un usuario debe darlo antes de alta.';
       RsMsg2  = 'No se puede limitar el acceso al "Usuario maestro"';

procedure ControlAccesos;
begin
     CreateEditForm( TMntAccForm, MntAccForm, nil, True );
end;

procedure TMntAccForm.FormManagerInitializeForm;
begin

     UsuarioFields := TUsuarioFields.Create( UsuarioTable );

     {$IFNDEF DEBUG}
     With ApplicationContainer do
       begin
       Ts10.TabVisible := IsModuleActive( [ 10 ] );
       Ts20.TabVisible := IsModuleActive( [ 20 ] );
       Ts30.TabVisible := IsModuleActive( [ 30 ] );
       Ts31.TabVisible := IsModuleActive( [ 20, 30 ] );
       Ts40.TabVisible := IsModuleActive( [ 40 ]);
       end;
     {$ENDIF}

     With PageControl do
       ActivePage := FindNextPage( nil, True, True );

end;

procedure TMntAccForm.CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntUsuarios( [ Sender.EditingValue ] );
end;

procedure TMntAccForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaUsuarios( Sender, qgsLinked );
end;

procedure TMntAccForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ValueIsEmpty( DisplayValue )
     then begin
          Usuario.Valida( Sender, DisplayValue, ErrorText, Error );
          If   not Error and ( DisplayValue='00' )
          then begin
               Error := True;
               ErrorText := RsMsg2;
               end;
          end;
end;

procedure TMntAccForm.AcALCtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
begin
     With AcALCtrl do
       begin

       EditValue := Properties.Value;

       If   Focused and UsuarioTable.Editing
       then begin
            UsuarioFields.AcALFicheros.Value := EditValue;
            UsuarioFields.AcALProcesos.Value := EditValue;
            end;

       AcALFicherosCtrl.Visible := EditValue<>0;
       AcALProcesosCtrl.Visible := EditValue<>0;
       end;
end;

procedure TMntAccForm.AcALFicherosCtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
begin
     With AcALFicherosCtrl do
       begin

       EditValue := Properties.Value;

       If   Focused and UsuarioTable.Editing
       then begin
            UsuarioFields.AcALArticulos.Value := EditValue;
            UsuarioFields.AcALListasMateriales.Value := EditValue;
            UsuarioFields.AcALAlmacenes.Value := EditValue;
            UsuarioFields.AcALTiposMovimiento.Value := EditValue;
            end;

       AcALArticulosCtrl.Visible := EditValue<>0;
       AcALListasMaterialesCtrl.Visible := EditValue<>0;
       AcALAlmacenesCtrl.Visible := EditValue<>0;
       AcALTiposMovimientoCtrl.Visible := EditValue<>0;
       end;
end;

procedure TMntAccForm.AcGCCtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
begin
     With AcGCCtrl do
       begin

       EditValue := Properties.Value;

       If   Focused and UsuarioTable.Editing
       then begin
            UsuarioFields.AcGCFicheros.Value := EditValue;
            UsuarioFields.AcGCAsientos.Value := EditValue;
            UsuarioFields.AcGCListados.Value := EditValue;
            UsuarioFields.AcGCProcesos.Value := EditValue;
            end;

       AcGCFicherosCtrl.Visible := EditValue<>0;
       AcGCAsientosCtrl.Visible := EditValue<>0;
       AcGCListadosCtrl.Visible := EditValue<>0;
       AcGCProcesosCtrl.Visible := EditValue<>0;
       end;

end;

procedure TMntAccForm.AcGPCtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
begin
     With AcGPCtrl do
       begin
       EditValue := Properties.Value;
       If   Focused and UsuarioTable.Editing
       then UsuarioFields.AcGPFicheros.Value := EditValue;
       AcGPFicherosCtrl.Visible := EditValue<>0;
       AcGPPrevisionCtrl.Visible := EditValue<>0;
       AcGPLanzamientoCtrl.Visible := EditValue<>0;
       AcGPSeguimientoCtrl.Visible := EditValue<>0;
       AcGPNotificacionesCtrl.Visible := EditValue<>0;
       AcGPProcesosCtrl.Visible := EditValue<>0;
       end;
end;

procedure TMntAccForm.AcGPFicherosCtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
begin
With AcGPFicherosCtrl do
       begin

       EditValue := Properties.Value;

       If   Focused and UsuarioTable.Editing
       then begin
            UsuarioFields.AcGPRelaciones.Value := EditValue;
            UsuarioFields.AcGPOperarios.Value := EditValue;
            UsuarioFields.AcGPMaquinas.Value := EditValue;
            UsuarioFields.AcGPOperaciones.Value := EditValue;
            UsuarioFields.AcGPTurnos.Value := EditValue;
            end;

       AcGPRelacionesCtrl.Visible := EditValue<>0;
       AcGPOperariosCtrl.Visible := EditValue<>0;
       AcGPMaquinasCtrl.Visible := EditValue<>0;
       AcGPOperacionesCtrl.Visible := EditValue<>0;
       AcGPTurnosCtrl.Visible := EditValue<>0;
       end;
end;

procedure TMntAccForm.AcLICtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
begin
     With AcLICtrl do
       begin
       EditValue := Properties.Value;
       If   Focused and UsuarioTable.Editing
       then UsuarioFields.AcLIFicheros.Value := EditValue;
       AcLIFicherosCtrl.Visible := EditValue<>0;
       end;
end;

procedure TMntAccForm.AcPCCtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
begin
      With AcPCCtrl do
       begin

       EditValue := Properties.Value;

       If   Focused and UsuarioTable.Editing
       then UsuarioFields.AcPCFicheros.Value := EditValue;

       AcPCFicherosCtrl.Visible:= EditValue<>0;
       end;
end;

procedure TMntAccForm.AcVEFicherosCtrlPropertiesEditPropertiesChange(Sender: TObject);

var   EditValue : SmallInt;

begin
     With AcVEFicherosCtrl do
       begin

       EditValue := Properties.Value;

       If   Focused and UsuarioTable.Editing
       then begin
            UsuarioFields.AcVEClientes.Value := EditValue;
            UsuarioFields.AcVEVendedores.Value := EditValue;
            UsuarioFields.AcVESeries.Value := EditValue;
            UsuarioFields.AcVETarifas.Value := EditValue;
            UsuarioFields.AcVEFormasCobro.Value := EditValue;
            UsuarioFields.AcVERelaciones.Value := EditValue;
            end;

       AcVEClientesCtrl.Visible := EditValue<>0;
       AcVEVendedoresCtrl.Visible := EditValue<>0;
       AcVESeriesCtrl.Visible := EditValue<>0;
       AcVETarifasCtrl.Visible := EditValue<>0;
       AcVEFormasCobroCtrl.Visible := EditValue<>0;
       AcVERelacionesCtrl.Visible := EditValue<>0;
       end;
end;

procedure TMntAccForm.AcVEProcesosCtrlPropertiesEditPropertiesChange(Sender: TObject);
begin
     If   AcVEProcesosCtrl.Focused and UsuarioTable.Editing
     then UsuarioFields.AcVETiendaVirtual.Value := AcVEProcesosCtrl.Properties.Value;
end;

procedure TMntAccForm.ComercialVGDBEditorRow9PropertiesEditPropertiesChange(Sender: TObject);
begin
     With AcVECtrl do
       begin

       EditValue := Properties.Value;

       If   Focused and UsuarioTable.Editing
       then begin
            UsuarioFields.AcVEFicheros.Value := EditValue;
            UsuarioFields.AcVEProcesos.Value := EditValue;
            UsuarioFields.AcVETiendaVirtual.Value := EditValue;
            end;

       AcVEFicherosCtrl.Visible := EditValue<>0;
       AcVETiendaVirtualCtrl.Visible := EditValue<>0;
       AcVEProcesosCtrl.Visible := EditValue<>0;

       end;
end;

procedure TMntAccForm.ComercialVGEditorRow1PropertiesEditPropertiesChange(Sender: TObject);
begin
     With AcCOFicherosCtrl do
       begin

       EditValue := AcCOFicherosCtrl.Properties.Value;

       If   Focused and UsuarioTable.Editing
       then begin
            UsuarioFields.AcCOProveedores.Value := EditValue;
            UsuarioFields.AcCOTarifas.Value := EditValue;
            UsuarioFields.AcCOFormasPago.Value := EditValue;
            UsuarioFields.AcCORelaciones.Value := EditValue;
            end;

       AcCOProveedoresCtrl.Visible := EditValue<>0;
       AcCOTarifasCtrl.Visible := EditValue<>0;
       AcCOFormasPagoCtrl.Visible:= EditValue<>0;
       AcCORelacionesCtrl.Visible := EditValue<>0;
       end;
end;

procedure TMntAccForm.AcCACtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
begin
     With AcCACtrl do
       begin

       EditValue := Properties.Value;

       If   Focused and UsuarioTable.Editing
       then begin
            UsuarioFields.AcCAFicheros.Value:= EditValue;
            UsuarioFields.AcCACaja.Value:= EditValue;
            UsuarioFields.AcCAArqueo.Value:= EditValue;
            UsuarioFields.AcCAListados.Value:= EditValue;
            UsuarioFields.AcCAProcesos.Value:= EditValue;
            end;

       AcCAFicherosCtrl.Visible := EditValue<>0;
       AcCACajaCtrl.Visible     := EditValue<>0;
       AcCAArqueoCtrl.Visible   := EditValue<>0;
       AcCAListadosCtrl.Visible := EditValue<>0;
       AcCAProcesosCtrl.Visible := EditValue<>0;
       end;
end;

procedure TMntAccForm.AcCOCtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
begin
     With AcCOCtrl do
       begin

       EditValue := Properties.Value;

       If   Focused and UsuarioTable.Editing
       then begin
            UsuarioFields.AcCOFicheros.Value := EditValue;
            UsuarioFields.AcCOMovimientos.Value := EditValue;
            UsuarioFields.AcCOProcesos.Value := EditValue;
            end;

       AcCOFicherosCtrl.Visible := EditValue<>0;
       AcCOMovimientosCtrl.Visible := EditValue<>0;
       AcCOProcesosCtrl.Visible := EditValue<>0;
       end;
end;

procedure TMntAccForm.AcCOMovimientosCtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
begin
     With AcCOMovimientosCtrl do
       begin

       EditValue := Properties.Value;

       If   Focused and UsuarioTable.Editing
       then begin
            UsuarioFields.AcCOOfertas.Value := EditValue;
            UsuarioFields.AcCOPedidos.Value := EditValue;
            UsuarioFields.AcCOAlbaranes.Value := EditValue;
            end;

       AcCOOfertasCtrl.Visible := EditValue<>0;
       AcCOPedidosCtrl.Visible := EditValue<>0;
       AcCOAlbaranesCtrl.Visible := EditValue<>0;
       end;
end;

procedure TMntAccForm.AcEICtrlPropertiesEditPropertiesEditValueChanged(Sender: TObject);
begin
     With AcEICtrl do
       begin
       EditValue := Properties.Value;
       If   Focused and UsuarioTable.Editing
       then UsuarioFields.AcEIFicheros.Value := EditValue;
       AcEIFicherosCtrl.Visible := EditValue<>0;
       end;
end;

procedure TMntAccForm.UsuarioTableAfterOpen(DataSet: TDataSet);
begin
     // UsuarioFields..SetRange( [ '01' ], [ HighStrCode ] );  // No incluye a '00'
end;

procedure TMntAccForm.UsuarioTableBeforeInsert(DataSet: TDataSet);
begin
     ShowNotification( ntStop, RsMsg1 );
     UsuarioTable.Cancel;
     Abort;
end;

procedure TMntAccForm.UsuarioTableBeforePost(DataSet: TDataSet);
begin
     ApplicationContainer.ProcessRecordChangesLog( UsuarioTable, frdUsuario );
end;

procedure TMntAccForm.UsuarioTableGetRecord(DataSet: TDataSet);

var  I : SmallInt;
     DBEditorRow : TcxDBEditorRow;
     EditProperties : TcxCustomEditProperties;

begin

     // Los TcxDBEditorRow no emiten un OnEditValueChanged cuando el valor es asignado desde el dataset, por eso
     // hay que hacerlo manualmente (hasta que encuentre un método mejor)

     For I := 0 to ComponentCount - 1 do
       If   Components[ I ] is TcxDBEditorRow
       then begin
            DBEditorRow := TcxDBEditorRow( Components[ I ] );
            If   Assigned( DBEditorRow.Properties ) and
                 ( DBEditorRow.Properties is TcxDBEditorRowProperties )
            then try
                   EditProperties := TcxDBEditorRowProperties( DBEditorRow.Properties ).EditProperties;
                   If   Assigned( EditProperties ) and
                        Assigned( EditProperties.OnEditValueChanged )
                   then EditProperties.OnEditValueChanged( Self );
                 except on E : Exception do
                   end;
            end;

end;

procedure TMntAccForm.DataInitialize;
begin
     AcInformesCtrl.Visible:= Configuracion.ParametrosGlbRec.EditorInformes;
     AcModificacionInformesCtrl.Visible:= Configuracion.ParametrosGlbRec.EditorInformes;
     AcEdicionInformesCtrl.Visible := Configuracion.ParametrosGlbRec.EditorInformes;
end;

initialization
     ApplicationContainer.AddFormReference( TMntAccForm, fmEdit, ControlAccesos );

end.
