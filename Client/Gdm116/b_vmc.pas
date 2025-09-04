unit b_vmc;

interface

uses StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics, Generics.Collections,

     AppContainer,

     Gim10Fields,
     Gim30Fields,
     Gim116Fields,

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
     DataManager,
     EnterpriseDataAccess,
     cxGridLevel,
     cxClasses,
     cxControls,
     cxGridCustomView,
     cxGridBandedTableView,
     cxGridDBBandedTableView,
     cxGrid, DBCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox,

     cxRichEdit, cxContainer, cxDBEdit, dxmdaset, dxSkinsCore,
     dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels, cxLabel,
     cxGroupBox, cxDBLabel, cxNavigator, dxBevel, dxDateRanges,

     dmi_mov,

     dm_mov,

     AppForms,

     dxScrollbarAnnotations,

     cxGridCustomTableView, cxGridTableView, GridTableViewController,
     cxTextEdit, cxCurrencyEdit, dxSVGImage, cxImage, dxGDIPlusClasses,
  dxUIAClasses;

type

  TcxCheckBoxsArray = Array of TcxCheckBox;
  TcxCustomCurrencyEditArray = Array of TcxCustomCurrencyEdit;

  TBoxVmcForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    LineaValoracionManufacturaTable: TnxeTable;
    LineaValoracionManufacturaDataSource: TDataSource;
    DataPanel: TgxEditPanel;
    Label10: TcxLabel;
    ArticuloLabel: TcxLabel;
    DescripcionArticuloLabel: TcxLabel;
    CantoPulidoCtrl: TcxCheckBox;
    LargoCtrl: TcxDBCurrencyEdit;
    Label18: TcxLabel;
    CortoCtrl: TcxDBCurrencyEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    MetrosLinealesCtrl: TcxLabel;
    PrecioCantosCtrl: TcxDBCurrencyEdit;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    SubtotalCantosLabel: TcxLabel;
    BiselCtrl: TcxCheckBox;
    Bilateral2Ctrl: TcxCheckBox;
    Bilateral4Ctrl: TcxCheckBox;
    TaladroCtrl: TcxCheckBox;
    FiguraCtrl: TcxCheckBox;
    MasterCtrl: TcxCheckBox;
    EspecialCtrl: TcxCheckBox;
    TempladoCtrl: TcxCheckBox;
    EstriasCtrl: TcxCheckBox;
    PintadoCtrl: TcxCheckBox;
    EmbalajeCtrl: TcxCheckBox;
    cxLabel7: TcxLabel;
    MetrosCuadradosLabel: TcxLabel;
    PrecioEmbalajeCtrl: TcxDBCurrencyEdit;
    cxLabel9: TcxLabel;
    SubtotalEmbalajeLabel: TcxLabel;
    Shape1: TShape;
    Shape2: TShape;
    cxLabel15: TcxLabel;
    SubtotalTaladroLabel: TcxLabel;
    cxLabel18: TcxLabel;
    TaladrosCtrl: TcxDBCurrencyEdit;
    PrecioTaladrosCtrl: TcxDBCurrencyEdit;
    Shape3: TShape;
    cxLabel12: TcxLabel;
    cxLabel13: TcxLabel;
    EscotsCtrl: TcxDBCurrencyEdit;
    PrecioEscotsCtrl: TcxDBCurrencyEdit;
    cxLabel14: TcxLabel;
    cxLabel19: TcxLabel;
    PuntasCtrl: TcxDBCurrencyEdit;
    PrecioPuntasCtrl: TcxDBCurrencyEdit;
    cxLabel20: TcxLabel;
    cxLabel21: TcxLabel;
    VariosCtrl: TcxDBCurrencyEdit;
    PrecioVariosCtrl: TcxDBCurrencyEdit;
    cxLabel24: TcxLabel;
    cxLabel25: TcxLabel;
    TotalManufacturaLabel: TcxLabel;
    cxLabel27: TcxLabel;
    PorcentajeIncrementoCtrl: TcxDBCurrencyEdit;
    IncrementoLabel: TcxLabel;
    Image1: TcxImage;
    cxLabel6: TcxLabel;
    PiezasLabel: TcxLabel;
    CantosPanel: TcxGroupBox;
    TaladroPanel: TcxGroupBox;
    EmbalajePanel: TcxGroupBox;
    IDVCtrl: TcxCheckBox;
    CorteCtrl: TcxCheckBox;
    SuperficieLargoCtrl: TcxDBCurrencyEdit;
    SuperficieAnchoCtrl: TcxDBCurrencyEdit;
    LineaValoracionManufacturaTableEjercicio: TSmallintField;
    LineaValoracionManufacturaTableNroOperacion: TIntegerField;
    LineaValoracionManufacturaTableNroRegistroLinea: TIntegerField;
    LineaValoracionManufacturaTableSuperficieLargo: TBCDField;
    LineaValoracionManufacturaTableSuperficieAncho: TBCDField;
    LineaValoracionManufacturaTableLargo: TBCDField;
    LineaValoracionManufacturaTableCorto: TBCDField;
    LineaValoracionManufacturaTableMetrosLineales: TBCDField;
    LineaValoracionManufacturaTableMetrosCuadrados: TBCDField;
    LineaValoracionManufacturaTableCantidadParametro1: TBCDField;
    LineaValoracionManufacturaTableCantidadParametro2: TBCDField;
    LineaValoracionManufacturaTableCantidadParametro3: TBCDField;
    LineaValoracionManufacturaTableCantidadParametro4: TBCDField;
    LineaValoracionManufacturaTableCantidadParametro5: TBCDField;
    LineaValoracionManufacturaTableCantidadParametro6: TBCDField;
    LineaValoracionManufacturaTablePrecioParametro1: TFloatField;
    LineaValoracionManufacturaTablePrecioParametro2: TFloatField;
    LineaValoracionManufacturaTablePrecioParametro3: TFloatField;
    LineaValoracionManufacturaTablePrecioParametro4: TFloatField;
    LineaValoracionManufacturaTablePrecioParametro5: TFloatField;
    LineaValoracionManufacturaTablePrecioParametro6: TFloatField;
    LineaValoracionManufacturaTableSubtotalCantos: TBCDField;
    LineaValoracionManufacturaTableSubtotalTaladro: TBCDField;
    LineaValoracionManufacturaTableSubtotalEmbalaje: TBCDField;
    LineaValoracionManufacturaTableTotalManufactura: TBCDField;
    LineaValoracionManufacturaTableIncremento: TBCDField;
    LineaValoracionManufacturaTableCampoCalculado: TIntegerField;
    ImporteNetoLabel: TcxLabel;
    cxLabel8: TcxLabel;
    LineaValoracionManufacturaTablePorcentajeIncremento: TBCDField;
    LineaValoracionManufacturaTableImporteNeto: TBCDField;
    EmbalajeAnchoCtrl: TcxDBCurrencyEdit;
    cxLabel3: TcxLabel;
    cxLabel10: TcxLabel;
    EmbalajeLargoCtrl: TcxDBCurrencyEdit;
    cxLabel11: TcxLabel;
    PrecioLabel: TcxLabel;
    LineaValoracionManufacturaTableEmbalajeAncho: TBCDField;
    LineaValoracionManufacturaTableEmbalajeLargo: TBCDField;
    procedure FormManagerCreateForm;
    procedure FormManagerDestroyForm;
    procedure FormManagerOkButton;
    procedure LineaValoracionManufacturaTableCalcFields(DataSet: TDataSet);
    procedure FormManagerPreparedForm;
  private

    LineaValoracionManufacturaFields : TLineaValoracionManufacturaFields;

    ParametrosCtrls : TcxCheckBoxsArray;
    PreciosCtrls : TcxCustomCurrencyEditArray;

    FPostingRecord,
    FActualizandoCambios : boolean;

    procedure ActualizaCalculos;
    procedure DoOnParametrosChange(Sender: TObject);
    procedure ActualizaValorParametros;

  protected

  class var LineaMovimientoFields : TLineaMovimientoFields;
  class var ArticuloFields : TArticuloFields;
  class var ClienteFields : TClienteFields;

  class procedure DoOnUpdateTableViewManager( Sender : TGridTableViewController );

  public
  class procedure EditaValoracionManufactura( Sender : TObject );

  end;

var BoxVmcForm: TBoxVmcForm = nil;

implementation

{$R *.DFM}

uses   Variants,
       Math,

       SysUtils,
       LibUtils,
       AppManager,

       Gdm00Dm,
       Gim00Fields,

       dm_cli,
       dm_art,
       dm_cri116,


       a_mve,

       b_msg;

{
resourceString
       RsMsg1 = 'Ha hecho modificaciones en la valoración';
       RsMsg2 = '¿Está seguro de que desea cancelar la edición del registro?';
}

class procedure TBoxVmcForm.EditaValoracionManufactura( Sender : TObject );
begin

      With MntMveForm[ tmPedidoVenta ] do
       begin
       TBoxVmcForm.LineaMovimientoFields := LineaMovimientoFields;
       TBoxVmcForm.ClienteFields := ClienteFields;
       TBoxVmcForm.ArticuloFields := ArticuloFields;
       end;

     CreateEditForm( TBoxVmcForm, BoxVmcForm );
end;

class procedure TBoxVmcForm.DoOnUpdateTableViewManager( Sender : TGridTableViewController );
begin
     MntMveForm[ tmPedidoVenta ].OpcionesLineaButton.Enabled := Sender.ShiftUpButton.Enabled;  // Solo si existe la línea y está seleccionada
end;

procedure TBoxVmcForm.FormManagerCreateForm;
begin

     LineaValoracionManufacturaFields := TLineaValoracionManufacturaFields.Create( LineaValoracionManufacturaTable );

     ParametrosCtrls := TcxCheckBoxsArray.Create( CantoPulidoCtrl, BiselCtrl, Bilateral2Ctrl, Bilateral4Ctrl, TaladroCtrl, FiguraCtrl, MasterCtrl,
                                                  EspecialCtrl, TempladoCtrl, EstriasCtrl, PintadoCtrl, EmbalajeCtrl, IDVCtrl, CorteCtrl );

     PreciosCtrls := TcxCustomCurrencyEditArray.Create( PrecioCantosCtrl, PrecioTaladrosCtrl, PrecioEscotsCtrl, PrecioPuntasCtrl, PrecioVariosCtrl, PrecioEmbalajeCtrl );

     With DataModule00.DmEmpresaFields do
       begin
       SetEditControlsDecimals( [ SuperficieLargoCtrl, SuperficieAnchoCtrl, LargoCtrl, CortoCtrl, EmbalajeLargoCtrl, EmbalajeAnchoCtrl ], Ventas_DecCantidad.Value );
       SetEditControlsDecimals( [ TaladrosCtrl, EscotsCtrl, PuntasCtrl, VariosCtrl ], 0 );
       SetEditControlsDecimals( PreciosCtrls, Ventas_DecPrecio.Value );
       SetEditControlsDecimals( [ PorcentajeIncrementoCtrl ], 2 );
       end;

     // NroRegistroLinea

     With LineaMovimientoFields do
       try

         LineaValoracionManufacturaTable.DisableControls;

         If   not LineaValoracionManufacturaTable.FindKey( [ NroRegistro.Value ] )
         then begin
              LineaValoracionManufacturaTable.Append;

              LineaValoracionManufacturaFields.Ejercicio.Value := Ejercicio.Value;
              LineaValoracionManufacturaFields.NroOperacion.Value := NroOperacion.Value;
              LineaValoracionManufacturaFields.NroRegistroLinea.Value := NroRegistro.Value;

              var PreciosArray := Cristaleria116.ObtenPreciosManufactura( MntMveForm[ tmPedidoVenta ].ClienteFields.Factura_Tarifa.Value, CodigoArticulo.Value );

              var Inx := ppCantos;  // Debe variar desde ppCantos = 1 a ppEmbalaje = 6
              For var PrecioCtrl in PreciosCtrls do
                begin
                If   LineaValoracionManufacturaFields.PrecioParametro[ Inx ].IsNull
                then LineaValoracionManufacturaFields.PrecioParametro[ Inx ].Value := PreciosArray[ Inx ];
                Inc( Inx );
                end;

              LineaValoracionManufacturaTable.Post;
              end;

         LineaValoracionManufacturaTable.Edit;

         If   LineaValoracionManufacturaFields.SuperficieLargo.Value=0.0
         then LineaValoracionManufacturaFields.SuperficieLargo.Value := LineaMovimientoFields.Largo.Value;

         If   LineaValoracionManufacturaFields.SuperficieAncho.Value=0.0
         then LineaValoracionManufacturaFields.SuperficieAncho.Value := LineaMovimientoFields.Ancho.Value;

         If   LineaValoracionManufacturaFields.EmbalajeLargo.Value=0.0
         then LineaValoracionManufacturaFields.EmbalajeLargo.Value := LineaMovimientoFields.Largo.Value;

         If   LineaValoracionManufacturaFields.EmbalajeAncho.Value=0.0
         then LineaValoracionManufacturaFields.EmbalajeAncho.Value := LineaMovimientoFields.Ancho.Value;

         LineaMovimientoFields.Dataset.Edit;  // Pongo la línea del pedido en modo edición porque necesito actualizar el campo Parametros

         ArticuloLabel.Caption := CodigoArticulo.Value;
         DescripcionArticuloLabel.Caption := Descripcion.Value;
         PiezasLabel.Caption := StrFormat( Alto.Value );
         PrecioLabel.Caption := StrFormat( Precio.Value );

         For var Inx := 0 to UltimoNroParametro do
           begin
           ParametrosCtrls[ Inx ].EditValue := null;  // Para forzar el evento del cambio
           ParametrosCtrls[ Inx ].Properties.OnChange := DoOnParametrosChange;
           ParametrosCtrls[ Inx ].Checked := ( Parametros.Value and Trunc( Power( 2, Inx ) ) )<>0;
           end;

       finally
         LineaValoracionManufacturaTable.EnableControls;
         end;

end;

procedure TBoxVmcForm.FormManagerDestroyForm;
begin
     LineaValoracionManufacturaTable.Cancel;
end;

procedure TBoxVmcForm.FormManagerOkButton;
begin
     FPostingRecord := True;
     try

       LineaValoracionManufacturaTable.Post;
       ActualizaValorParametros;
       LineaMovimientoFields.ImporteRecargo.Value := LineaValoracionManufacturaFields.Totalmanufactura.Value;
       LineaMovimientoFields.PorcentajeRecargo.Value := LineaValoracionManufacturaFields.PorcentajeIncremento.Value;
       LineaMovimientoFields.Dataset.Post;

     finally
       FPostingRecord := False;
       end;
end;

procedure TBoxVmcForm.ActualizaValorParametros;

var Parametros : SmallInt;

begin
     Parametros := 0;
     For var Inx := 0 to UltimoNroParametro do
       If   ParametrosCtrls[ Inx ].Checked
       then Parametros := Parametros or Trunc( Power( 2, Inx ) );
     LineaMovimientoFields.Parametros.Value := Parametros;
end;

procedure TBoxVmcForm.FormManagerPreparedForm;
begin
     ActualizaCalculos;
end;

procedure TBoxVmcForm.LineaValoracionManufacturaTableCalcFields(DataSet: TDataSet);
begin
     ActualizaCalculos;
end;

procedure TBoxVmcForm.DoOnParametrosChange( Sender : TObject );
begin
     If   not LineaValoracionManufacturaTable.ControlsDisabled
     then begin

          If   Sender=CantoPulidoCtrl
          then begin
               SetGroupBoxControlsEnabled( CantosPanel, CantoPulidoCtrl.Checked, { Force } True );
               If   CantoPulidoCtrl.Focused and CantoPulidoCtrl.Checked
               then LargoCtrl.SetFocus;
               end
          else If   Sender=TaladroCtrl
               then begin
                    SetGroupBoxControlsEnabled( TaladroPanel, TaladroCtrl.Checked, { Force } True );
                    If   TaladroCtrl.Focused and TaladroCtrl.Checked
                    then TaladrosCtrl.SetFocus;
                    end
               else If   Sender=EmbalajeCtrl
                    then begin
                         SetGroupBoxControlsEnabled( EmbalajePanel, EmbalajeCtrl.Checked, { Force } True );
                         If   EmbalajeCtrl.Focused and EmbalajeCtrl.Checked
                         then TaladrosCtrl.SetFocus;
                         end;

          ActualizaValorParametros;
          ActualizaCalculos;

          end;

end;

procedure TBoxVmcForm.ActualizaCalculos;

var  ImporteNeto : Decimal;

begin
     If   not FActualizandoCambios and
          not FPostingRecord and
          FormManager.FormInitialized and
          Assigned( LineaValoracionManufacturaFields )
     then try

            FActualizandoCambios := True;

            // Los cálculos se realizan sobre los registros LineaMovimientoFields y LineaValoracionManufacturaFields

            Cristaleria116.CalculaImporteManufactura( LineaMovimientoFields, LineaValoracionManufacturaFields, ArticuloFields, ClienteFields );

            With LineaValoracionManufacturaFields, DataModule00.DmEmpresaFields do
              begin
              MetrosLinealesCtrl.Caption := StrFormat( MetrosLineales.Value, Ventas_DecCantidad.Value );
              SubtotalCantosLabel.Caption := StrFormat( SubtotalCantos.Value );
              SubtotalTaladroLabel.Caption := StrFormat( SubtotalTaladro.Value );
              MetrosCuadradosLabel.Caption := StrFormat( MetrosCuadrados.Value, Ventas_DecCantidad.Value );
              SubtotalEmbalajeLabel.Caption := StrFormat( SubtotalEmbalaje.Value );
              TotalManufacturaLabel.Caption := StrFormat( TotalManufactura.Value );
              IncrementoLabel.Caption := StrFormat( Incremento.Value );
              ImporteNetoLabel.Caption := StrFormat( ImporteNeto.Value );
              end;

            finally
              FActualizandoCambios := False;
              end;
end;

procedure SetupMntMveForm;
begin

     If   Assigned( MntMveForm[ tmPedidoVenta ] ) and ( TipoMovimientoCreado=tmPedidoVenta )
     then With MntMveForm[ tmPedidoVenta ] do
            begin

            With OpcionesLineaButton do
              begin
              Caption := '&Manufactura';
              Hint := 'Valoración de la manufactura del artículo (Teclas [Alt]+[M])';

              OptionsImage.Glyph.Assign( ApplicationForms.RowGearImage.Picture.Graphic );
              OptionsImage.Glyph.SourceHeight := 28;
              OptionsImage.Glyph.SourceWidth := 28;
              NumGlyphs := 1;

              OnClick := TBoxVmcForm.EditaValoracionManufactura;
              Visible := True;
              end;

            TableViewManager.OnUpdate.Add( TBoxVmcForm.DoOnUpdateTableViewManager );

            end;
end;

initialization

   AddProcedure( imOnCreateComponent, idMntMveForm, SetupMntMveForm );

end.
