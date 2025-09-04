unit dm_cri116;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, System.Generics.Collections,

  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,

  Menus,
  cxLookAndFeelPainters,
  cxButtons,

  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  AppForms, nxdb, DataManager, cxCurrencyEdit, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxGroupBox, cxLookAndFeels,
  cxNavigator, cxCheckBox, cxVGrid, cxDBVGrid, cxInplaceContainer, cxLabel,
  cxCheckGroup, cxDBCheckGroup, cxCheckComboBox, cxDBCheckComboBox,

  LibUtils,
  AppContainer,

  Gim10Fields,
  Gim30Fields,
  Gim116Fields,

  dmi_cri116;

type
  TDecimalArray = Array of Decimal;

  TCristaleria116Module = class(TDataModule)
    DmTarifaVentasTable: TnxeTable;
    DmCodigoTarifaTable: TnxeTable;
    DmLineaValoracionManufacturaTable: TnxeTable;
    procedure GridViewCodigoVendedorPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoVendedorPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

    Cristaleria116Service : ICristaleria116Service;

    DmCodigoTarifaFields : TCodigoTarifaFields;
    DmTarifaVentasFields : TTarifaVentasFields;
    DmLineaValoracionManufacturaFields : TLineaValoracionManufacturaFields;

    DsArticuloFields : TArticuloFields;

    FOnCodigoArticuloValuePosted : TNotifyEvent;
    FOnDescripcionValuePosted : TNotifyEvent;

    FUltimoNroRegistro : LongWord;
    FUltimaCantidad : Decimal;

    procedure CodigoArticuloValuePosted( Sender : TObject );
    procedure DescripcionValuePosted( Sender : TObject );
    procedure DoOnSelectLines( Sender : TObject );

    procedure DoCalculaImportes(  LineaMovimientoFields : TLineaMovimientoFields;
                                  ArticuloFields        : TArticuloFields );

    procedure DoOnActualizaCamposCalculadosLineaVenta( MovimientoFields       : TMovimientoFields;
                                                       LineaMovimientoFields  : TLineaMovimientoFields;
                                                       ClienteFields          : TClienteFields;
                                                       ArticuloFields         : TArticuloFields;
                                                       SerieFacturacionFields : TSerieFacturacionFields;
                                                       TiposIVAFields         : TTiposIVAFields );

    procedure DoOnEnterManufactura( Sender : TcxCustomEdit );
    // procedure DoOnExtendedFunctionManufactura( Sender : TcxCustomEdit );

    procedure DoOnUpdateButtonsState;
    procedure DoOnUpdateLines( MovimientoOrigenFields : TMovimientoFields; CopiarDatosCabecera, NoVincularDocumentos  : Boolean; LineArray : TLongIntArray );

  protected

     procedure DoOnSetReportName;

  public

    function ParametroChecked( Value, ParamIndex : SmallInt ) : Boolean;
    function ObtenPreciosManufactura( CodigoTarifa, CodigoArticulo : String ) : TDecimalArray;
    procedure CalculaImporteManufactura( LineaMovimientoFields            : TLineaMovimientoFields;
                                         LineaValoracionManufacturaFields : TLineaValoracionManufacturaFields;
                                         ArticuloFields                   : TArticuloFields;
                                         ClienteFields                    : TClienteFields );

  end;

var Cristaleria116Module : TCristaleria116Module = nil;

const
    UltimoNroParametro = 13;

function Cristaleria116 : TCristaleria116Module;

procedure SetupParametrosGroupBox( CheckGroup : TcxDBCheckGroup);
procedure SetupParametrosGridView( GridViewParametros: TcxGridDBColumn );

implementation

uses Math,
     EnterpriseDataAccess,
     AppManager,
     Files,
     NexusRpcData,
     MsgFrame,

     Gdm00Dm,
     Gdm10Dm,
     Gdm30Dm,

     Gdm30Frm,

     dmi_mov,

     dm_ven,
     dm_mov,
     dm_reg,
     dm_cli,
     dm_art,
     dm_fdv,

     cx_ven,

     f_cli,

     a_art,
     a_mve,
     a_tva,

     b_mve,
     b_vmc,
     b_rld,

     l_cps,
     q_cps;

{$R *.dfm}

resourceString
    RsMsg1 = 'Se ha producido un error durante el proceso de generación del fichero.';
    RsMsg2 = 'Error : %s.';
    RsMsg3 = 'Se ha generado correctamente el fichero para Opti-Way';
    RsMsg4 = 'Fichero : [URL=file:///%0:s]%0:s[/URL].';
    RsMsg5 = 'Pulse [F11] para acceder al mantenimiento de valoración de la manufactura.';
    RsMsg6 = 'No puede modificar directamente este campo.';
    RsMsg7 = 'Si desea editar el valor, acceda a la ventana de valoración de manufactura usando el botón correspondiente de la rejilla, [Alt]+[M] o pulsando la tecla [F11] si está en el campo Manufactura.';

const
    ListaParametros : Array[ 0..UltimoNroParametro ] of String = ( 'Canto Pulido', 'Bisel', 'Bilateral2', 'Bilateral4', 'Taladro', 'Figura', 'Master', 'Especial', 'Templado', 'Estrías', 'Pintado', 'Embalaje', 'IDV', 'Corte' );

function Cristaleria116 : TCristaleria116Module;
begin
     CreateDataModule( TCristaleria116Module, Cristaleria116Module );
     Result := Cristaleria116Module;
end;

procedure SetupParametrosGroupBox( CheckGroup : TcxDBCheckGroup);

var I : SmallInt;
    CheckGroupItem : TcxCheckGroupItem;

begin
     CheckGroup.Visible := True;

     With CheckGroup do
     For I := 0 to UltimoNroParametro do
       begin
       CheckGroupItem := Properties.Items.Add;
       CheckGroupItem.Caption := ListaParametros[ I ];
       end;

end;

procedure SetupParametrosGridView( GridViewParametros: TcxGridDBColumn );

var I : SmallInt;
    CheckComboBoxItem : TcxCheckComboBoxItem;

begin
     For I := 0 to UltimoNroParametro do
       begin
       CheckComboBoxItem := TcxCheckComboBoxProperties( GridViewParametros.Properties ).Items.Add;
       CheckComboBoxItem.Description := ListaParametros[ I ];
       end;
     GridViewParametros.Visible := True;
end;

procedure SetupMntArtForm;
begin
     If   Assigned( MntArtForm )
     then With MntArtForm do
            begin

            FabricacionTabSheet.TabVisible := True;
            FabricacionGroupBox.Visible := False;
            ParametrosGroupBox.Visible := True;

            SetupParametrosGroupBox( ParametrosCtrl );
            end;
end;

procedure SetupMntMveForm;
begin

     If   Assigned( Cristaleria116Module ) and
          Assigned( MntMveForm[ tmPedidoVenta ] ) and
          ( TipoMovimientoCreado=tmPedidoVenta )   // Si no se comprueba se podría inicializar al crear un albarán o un presupuesto
     then With MntMveForm[ tmPedidoVenta ] do
            begin

            SetupParametrosGridView( GridViewParametros );

            With Cristaleria116Module do
              begin
              FOnCodigoArticuloValuePosted := GridViewCodigoArticulo.Properties.OnValuePosted;
              GridViewCodigoArticulo.Properties.OnValuePosted := CodigoArticuloValuePosted;
              FOnDescripcionValuePosted := GridViewDescripcion.Properties.OnValuePosted;
              GridViewDescripcion.Properties.OnValuePosted := DescripcionValuePosted;
              end;

            GridViewImporteRecargo.Caption := 'Manufactura';
            // GridViewImporteRecargo.Index := GridViewImporteTotal.Index - 1;
            GridViewImporteRecargo.Width := 100;
            GridViewImporteRecargo.Visible := True;

            GridViewImporteRecargo.Options.Editing := False;
            GridViewImporteRecargo.Options.Focusing := False;

            GridViewImporteRecargo.Properties.OnEnter := Cristaleria116Module.DoOnEnterManufactura;
            // GridViewImporteRecargo.Properties.OnExtendedFunction := Cristaleria116Module.DoOnExtendedFunctionManufactura;

            SetColumnDecimals( GridViewImporteRecargo );

            FirmarButton.GlyphBitmap := gmGears;
            FirmarButton.Caption := 'Opti-Way';
            FirmarButton.Visible := True;
            FirmarButton.OnClick := Cristaleria116Module.DoOnSelectLines;

            OnUpdateButtonsState.Add( Cristaleria116Module.DoOnUpdateButtonsState );

            ButtonContainerPanel.Width := ButtonContainerPanel.Width + FirmarButton.Width + 2;
            CenterInParent( ButtonContainerPanel );

            AltoTotalPanel.Visible := True;
            AltoLabel.Caption := 'Piezas';

            end;
end;

procedure SetupMntTvaForm;

type  TColumnArray = Array of TcxGridColumn;

const CaptionArray : Array of String = [ 'Cantos', 'Taladro', 'Escots', 'Puntas', 'Varios', 'Embalaje' ];

begin
     If   Assigned( Cristaleria116Module ) and
          Assigned( MntTvaForm )
     then With MntTvaForm do
            begin

            var ColumnArray := TColumnArray.Create( GridViewPrecioParametro1,
                                                    GridViewPrecioParametro2,
                                                    GridViewPrecioParametro3,
                                                    GridViewPrecioParametro4,
                                                    GridViewPrecioParametro5,
                                                    GridViewPrecioParametro6 );

            For var Column in ColumnArray do
              begin
              Column.Visible := True;
              Column.Width := 60;
              Column.Caption := CaptionArray[ Column.Index - 6 ];
              end;

            SetColumnsDecimals( ColumnArray, DataModule00.DmEmpresaFields.Ventas_DecPrecio.Value );

            GridHeader.Visible := True;

            Width := 1100;

            PlaceForm( MntTvaForm );

            end;
end;

procedure SetupRptCpsForm;
begin
     If   Assigned( Cristaleria116Module ) and
          Assigned( RptCpsForm )
     then With RptCpsForm do
            begin
            SetupParametrosGroupBox( ParametrosCtrl );
            ParametrosGroupBox.Visible := True;
            AjustaAlturaVentana;
            Report.OnSetReportName := Cristaleria116Module.DoOnSetReportName;
            end;
end;

procedure SetupGridCpsForm;
begin
     If   Assigned( GridCpsForm )
     then With GridCpsForm do
            begin
            With ParametrosColumn do
              begin
              PropertiesClass := TcxCheckComboBoxProperties;
              With TcxCheckComboBoxProperties( Properties ) do
                begin
                Alignment.Horz := taLeftJustify;
                EmptySelectionText := ChSp;
                ReadOnly := True;
                end;
              end;
            SetupParametrosGridView( ParametrosColumn );
            ParametrosColumn.Visible := True;
            end;
end;

procedure SetupBrwRlvForm;
begin
     If   Assigned( BrwRlvForm ) and
          Assigned( MntMveForm[ tmPedidoVenta ] )
     then With BrwRlvForm do
            begin
            var Pendientes := MntMveForm[ tmPedidoVenta ].LineaMovimientoFields.Alto.Value - VarToDecimal( TableView.DataController.Summary.FooterSummaryValues[ 0 ] );
            AltoPanelLabel.Caption := FormatFloat( TcxCurrencyEditProperties( TableViewAlto.Properties ).DisplayFormat , Pendientes );
            GridTableViewPanel.Visible := True;
            end;

end;

procedure SetupFacturaVentasModule;
begin
     If   Assigned( FacturaVentasModule ) and
          Assigned( Cristaleria116Module )
     then FacturaVentasModule.OnCalculaImportes.Add( Cristaleria116Module.DoCalculaImportes );
end;

procedure SetupMovimientoModule;
begin
     If   Assigned( MovimientoModule ) and
          Assigned( Cristaleria116Module )
     then MovimientoModule.OnActualizaCamposCalculadosLineaVenta.Add( Cristaleria116Module.DoOnActualizaCamposCalculadosLineaVenta );
end;

// TCristaleria116Module

procedure TCristaleria116Module.CodigoArticuloValuePosted(Sender: TObject);
begin
     If   Assigned( FOnCodigoArticuloValuePosted )
     then FOnCodigoArticuloValuePosted( Sender );

     If   Assigned( MntMveForm[ tmPedidoVenta ] )
     then With MntMveForm[ tmPedidoVenta ] do
            LineaMovimientoFields.Parametros.Value := ArticuloFields.Parametros.Value;
end;

procedure TCristaleria116Module.DataModuleCreate(Sender: TObject);
begin

     DmCodigoTarifaFields := TCodigoTarifaFields.Create( DmCodigoTarifaTable );
     DmTarifaVentasFields := TTarifaVentasFields.Create( DmTarifaVentasTable );
     DmLineaValoracionManufacturaFields := TLineaValoracionManufacturaFields.Create( DmLineaValoracionManufacturaTable );

     DsArticuloFields := TArticuloFields.Create( Self );

     NexusRpc.CreateRemoteInstance( CLSID_Cristaleria116Service, ICristaleria116Service, Cristaleria116Service );

     Cristaleria116Service.Inicializa; // Inicializando el módulo en el servidor
end;

procedure TCristaleria116Module.DataModuleDestroy(Sender: TObject);
begin
     Cristaleria116Module := nil;
end;

procedure TCristaleria116Module.DescripcionValuePosted(Sender: TObject);

// ( 'Canto Pulido', 'Bisel', 'Bilateral2', 'Bilateral4', 'Taladro', 'Figura', 'Master', 'Especial', 'Templado', 'Estrías', 'Pintado', 'Embalaje' );

const Abreviaciones : Array[ 0..UltimoNroParametro ] of String = ( 'CP', 'BIS', '', '', 'TAL', '', '', '', 'TEMP', 'ESTR', '', 'EMB', '', '' );

var I : SmallInt;
    Descripcion : String;

begin
     If   Assigned( MntMveForm[ tmPedidoVenta ] )
     then With MntMveForm[ tmPedidoVenta ] do
             If   LineaMovimientoTable.State=dsInsert
             then begin
                  Descripcion := UpperCase( LineaMovimientoFields.Descripcion.Value );
                  For I := 0 to UltimoNroParametro do
                    begin
                    If   Pos( Abreviaciones[ I ], Descripcion )<>0
                    then LineaMovimientoFields.Parametros.Value := LineaMovimientoFields.Parametros.Value or Trunc( Power( 2, I ) );
                    end;
                  end;
end;

function TCristaleria116Module.ParametroChecked( Value, ParamIndex : SmallInt ) : Boolean;
begin
     Result := ( Value and Trunc( Power( 2, ParamIndex ) ) )<>0;
end;

procedure TCristaleria116Module.DoOnUpdateButtonsState;
begin
     With MntMveForm[ tmPedidoVenta ] do
       FirmarButton.Enabled := MovimientoTable.State=dsEdit;
end;

procedure TCristaleria116Module.DoOnEnterManufactura(Sender: TcxCustomEdit);
begin
     Sender.Hint := RsMsg5;
end;

{
procedure TCristaleria116Module.DoOnExtendedFunctionManufactura( Sender : TcxCustomEdit );
begin
     With MntMveForm[ tmPedidoVenta ] do
       If   LineaMovimientoTable.Editing
       then LineaMovimientoTable.Post;
     TBoxVmcForm.EditaValoracionManufactura( Sender );
end;
}

procedure TCristaleria116Module.DoOnSelectLines(Sender: TObject);
begin
     With MntMveForm[ tmPedidoVenta ] do
       SeleccionaLineasDocumentoVenta( tmPedidoVenta,
                                       MovimientoFields.Ejercicio.Value,
                                       MovimientoFields.NroOperacion.Value,
                                       tmNoDefinido,
                                       DoOnUpdateLines,
                                       nil,
                                       nil,
                                       True,
                                       True );
     If   Assigned( BoxMveForm )
     then With BoxMveForm do
            begin
            SetupParametrosGridView( LinesViewParametros );
            LinesViewParametros.Visible := True;
            end;
end;

procedure TCristaleria116Module.DoOnSetReportName;
begin
     If   Assigned( RptCpsForm )
     then With RptCpsForm do
            If   not Report.ReportFromList and
                 DesglosarCtrl.Checked and
                 ( AgrupacionCtrl.ItemIndex=0 )
            then Report.FileName := 'dm116\l_cps1';
end;

procedure TCristaleria116Module.DoOnUpdateLines( MovimientoOrigenFields : TMovimientoFields;
                                                 CopiarDatosCabecera,
                                                 NoVincularDocumentos   : Boolean;
                                                 LineArray              : TLongIntArray );

var  I : SmallInt;
     NroRegistroLinea : LongInt;
     Fichero : TextFile;
     CantidadTotal : Decimal;
     FileName : String;
     NumeroPiezas : Integer;

begin
     With BoxMveForm do
       try
         try

           FileName := AddPathDelim( DataPath.AsString ) + 'Manufactura_V4.ASC';
           AssignFile( Fichero, FileName );
           Rewrite( Fichero );
           IoCheck( IoResult );

           With LineaMovimientoOrigenFields.Table do
             begin
             DisableControls;
             MasterSource := nil;
             IndexFieldNames := 'NroRegistro';
             end;

           CantidadTotal := 0.0;
           For I := 0 to LineList.Count - 1 do
             begin
             NroRegistroLinea := LongInt( LineList.Items[ I ] );
             If   LineaMovimientoOrigenTable.FindKey( [ NroRegistroLinea ] )
             then DecAdd( CantidadTotal, LineaMovimientoOrigenFields.Cantidad.Value );
             end;

           WriteLn( Fichero, RightPad( 'Planes Ped. Pegados ' + MovimientoOrigenFields.Serie.Value + IntToStr( MovimientoOrigenFields.NroDocumento.Value ), 32 ) +
                             StrFormatDate( ApplicationContainer.TodayDate, dfCompact2 ) +
                             StrConst( 8 ) +
                             LeftPad( StrDecimal( CantidadTotal, 0 ), 8, ChSp ) +
                             'V4' );

           WriteLn( Fichero, LeftPad( IntToStr( LineList.Count ), 8, ChSp ) );

           For I := 0 to LineList.Count - 1 do
             begin

             NroRegistroLinea := LongInt( LineList.Items[ I ] );

             If   LineaMovimientoOrigenFields.Alto.Value=0.0
             then NumeroPiezas := Trunc( LineaMovimientoOrigenFields.Cantidad.Value )
             else NumeroPiezas := Trunc( LineaMovimientoOrigenFields.Alto.Value );

             If   LineaMovimientoOrigenTable.FindKey( [ NroRegistroLinea ] )
             then begin
                  Articulo.Obten( LineaMovimientoOrigenFields.CodigoArticulo.Value, DsArticuloFields );
                  WriteLn( Fichero, RightPad( DsArticuloFields.CampoLibre4.Value, 16 ) +                                          // MATERIAL ID CODE (1)
                                    LeftPad( IntToStr( I + 1 ), 5, ChSp ) +                                                       // POSITION NUMBER
                                    RightPad( Cliente.Descripcion( MovimientoOrigenFields.Propietario.Value ), 12 ) +             // CUSTOMER
                                    RightPad( MovimientoOrigenFields.Serie.Value + ChSp +                                         // ORDER
                                              IntToStr( MovimientoOrigenFields.NroDocumento.Value ), 12 ) +
                                    StrConst( 8 ) +                                                                               // SHAPE ID (2
                                    StrConst( 8 ) +                                                                               // GRINDING VALUE (DIMENSION) (3) (6)
                                    StrConst( 3 ) +                                                                               // PRIORITY OF THE PIECE
                                    ChSp +                                                                                        // ROTATION FLAG
                                    LeftPad( IntToStr( NumeroPiezas ), 8, ChSp ) +                                                // NUMBER OF CUTTING PIECES
                                    StrConst( 8 ) +                                                                               // FIXED TEXT CODE (for bending machine
                                    Format( '%8.1f', [ LineaMovimientoOrigenFields.Largo.Value ] ) +                              // X-SIZE OF THE PIECE (3)
                                    Format( '%8.1f', [ LineaMovimientoOrigenFields.Ancho.Value ] ) +                              // Y-SIZE OF THE PIECE (3)
                                    StrConst( 8 ) +                                                                               // SPACER (3) (4)
                                    StrConst( 32 ) +                                                                              // ADDITIONAL NOTES
                                    StrConst( 5 ) +                                                                               // NUMBER OF LABELS
                                    StrConst( 5 ) +                                                                               // EXCEDED PIECES
                                    StrConst( 5 ) +                                                                               // PREFERENCE VALUE
                                    StrConst( 961 ) +                                                                             // PADDING
                                    RightPad( Articulo.Descripcion( LineaMovimientoOrigenFields.CodigoArticulo.Value ), 48 ) +    // MATERIAL DESCRIPTION
                                    StrConst( 144 ) );                                                                            // PADDING
                  end;

             end;

         finally
             CloseFile( Fichero );
             end;

         ShowNotification( ntInformation, RsMsg3, Format( RsMsg4, [ FileName ] ) );

       except on E : Exception do
         ShowNotification( ntStop, RsMsg1, Format( RsMsg2, [ E.Message ] ) );
         end;
end;

procedure TCristaleria116Module.GridViewCodigoVendedorPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TCristaleria116Module.GridViewCodigoVendedorPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

function TCristaleria116Module.ObtenPreciosManufactura( CodigoTarifa,
                                                        CodigoArticulo : String ) : TDecimalArray;
begin

     var  PreciosArray := TDecimalArray.Create( 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 );  // El indice 0 no se utiliza

     If   DmCodigoTarifaTable.FindKey( [ CodigoTarifa ] )
     then For var Inx := ppCantos to ppEmbalaje do
            PreciosArray[ Inx ] := DmCodigoTarifaFields.PrecioParametro[ Inx ].Value;

     If   DmTarifaVentasTable.FindKey( [ rtvTarifaArticulo, CodigoTarifa, CodigoArticulo ] )
     then For var Inx := ppCantos to ppEmbalaje do
            If   DmTarifaVentasFields.PrecioParametro[ Inx ].Value<>0.0
            then PreciosArray[ Inx ] := DmTarifaVentasFields.PrecioParametro[ Inx ].Value;

     Result := PreciosArray;
end;

procedure TCristaleria116Module.CalculaImporteManufactura( LineaMovimientoFields            : TLineaMovimientoFields;
                                                           LineaValoracionManufacturaFields : TLineaValoracionManufacturaFields;
                                                           ArticuloFields                   : TArticuloFields;
                                                           ClienteFields                    : TClienteFields );
begin
     With LineaValoracionManufacturaFields do
       try

         LineaValoracionManufacturaFields.Dataset.DisableControls;

         MetrosLineales.Value := ( ( SuperficieLargo.Value * Largo.Value ) + ( SuperficieAncho.Value * Corto.Value ) ) / 100.0;

         If   ParametroChecked( LineaMovimientoFields.Parametros.Value, pinCantoPulido )
         then SubtotalCantos.Value := MetrosLineales.Value * PrecioParametro[ ppCantos ].Value
         else SubtotalCantos.Value := 0.0;

         If   ParametroChecked( LineaMovimientoFields.Parametros.Value, pinTaladro )
         then SubtotalTaladro.Value := ( ( CantidadParametro[ ppTaladros ].Value * PrecioParametro[ ppTaladros ].Value ) +
                                         ( CantidadParametro[ ppEscots ].Value * PrecioParametro[ ppEscots ].Value ) +
                                         ( CantidadParametro[ ppPuntas ].Value * PrecioParametro[ ppPuntas ].Value ) )
         else SubtotalTaladro.Value := 0.0;

         MetrosCuadrados.Value := ( EmbalajeLargo.Value * EmbalajeAncho.Value ) / 10000.0;  // El largo y ancho se introducen en cm

         If   ParametroChecked( LineaMovimientoFields.Parametros.Value, pinEmbalaje )
         then SubtotalEmbalaje.Value := MetrosCuadrados.Value * PrecioParametro[ ppEmbalaje ].Value
         else SubtotalEmbalaje.Value := 0.0;

         // El campo Alto es el número de piezas

         TotalManufactura.Value := Redondea( LineaMovimientoFields.Alto.Value *
                                             ( SubtotalCantos.Value + SubtotalTaladro.Value + SubtotalEmbalaje.Value +
                                             ( CantidadParametro[ ppVarios].Value * PrecioParametro[ ppVarios ].Value ) ) );

         Incremento.Value := Redondea( ( ( LineaMovimientoFields.ImporteBruto.Value + TotalManufactura.Value ) * PorcentajeIncremento.Value ) / 100.0 );

         // El importe neto de la línea se calcula cuando se guarda, en DoCalculaImportes

         ImporteNeto.Value := LineaMovimientoFields.ImporteBruto.Value -
                              LineaMovimientoFields.ImporteDescuento.Value +
                              TotalManufactura.Value +  // ImporteRecargo
                              Incremento.Value;

         FUltimoNroRegistro := 0;   // Para que se actualice la línea

       finally
         LineaValoracionManufacturaFields.Dataset.EnableControls;
         end;

end;

procedure TCristaleria116Module.DoCalculaImportes( LineaMovimientoFields : TLineaMovimientoFields;
                                                   ArticuloFields        : TArticuloFields );
begin

     var Incremento := Redondea( ( ( LineaMovimientoFields.ImporteBruto.Value + LineaMovimientoFields.ImporteRecargo.Value ) * LineaMovimientoFields.PorcentajeRecargo.Value ) / 100.0 );

     LineaMovimientoFields.ImporteNeto.Value := LineaMovimientoFields.ImporteBruto.Value -
                                                LineaMovimientoFields.ImporteDescuento.Value +
                                                LineaMovimientoFields.ImporteRecargo.Value +  // TotalManufactura
                                                Incremento;
end;

procedure TCristaleria116Module.DoOnActualizaCamposCalculadosLineaVenta( MovimientoFields       : TMovimientoFields;
                                                                         LineaMovimientoFields  : TLineaMovimientoFields;
                                                                         ClienteFields          : TClienteFields;
                                                                         ArticuloFields         : TArticuloFields;
                                                                         SerieFacturacionFields : TSerieFacturacionFields;
                                                                         TiposIVAFields         : TTiposIVAFields );
begin

       // Compruebo el número de registro de la línea y la cantidad para evitar realizar el cálculo cuando no es necesario

       If   ( MovimientoFields.TipoMovimiento.Value=tmPedidoVenta ) and
            ( ( FUltimoNroRegistro<>LineaMovimientoFields.NroRegistro.Value ) or ( FUltimaCantidad<>LineaMovimientoFields.Cantidad.Value ) )
       then If   DmLineaValoracionManufacturaTable.FindKey( [ LineaMovimientoFields.NroRegistro.Value ] )
            then try

                   FUltimoNroRegistro := LineaMovimientoFields.NroRegistro.Value;
                   FUltimaCantidad := LineaMovimientoFields.Cantidad.Value;

                   DmLineaValoracionManufacturaTable.Edit;
                   CalculaImporteManufactura( LineaMovimientoFields, DmLineaValoracionManufacturaFields, ArticuloFields, ClienteFields );
                   DmLineaValoracionManufacturaTable.Post;

                   LineaMovimientoFields.Cantidad.Value := Movimiento.CalculoEspecial( scventas,
                                                                                       DmLineaValoracionManufacturaFields.SuperficieLargo.Value,
                                                                                       DmLineaValoracionManufacturaFields.SuperficieAncho.Value,
                                                                                       LineaMovimientoFields.Alto.Value );
                   LineaMovimientoFields.CantidadAjustada.Value := LineaMovimientoFields.Cantidad.Value;

                   LineaMovimientoFields.ImporteRecargo.Value := DmLineaValoracionManufacturaFields.Totalmanufactura.Value;
                   LineaMovimientoFields.PorcentajeRecargo.Value := DmLineaValoracionManufacturaFields.PorcentajeIncremento.Value;

                 finally
                   DmLineaValoracionManufacturaTable.Cancel;
                   end;
end;

procedure InitializeModule;
begin     
     Cristaleria116;
end;

initialization

   AddProcedure( imOptionalSectionModule, 116 );

   AddProcedure( imOnEnterpriseAccess, 0, InitializeModule );

   AddProcedure( imOnCreateComponent, idMntArtForm, SetupMntArtForm );
   AddProcedure( imOnCreateComponent, idMntMveForm, SetupMntMveForm );
   AddProcedure( imOnCreateComponent, idMntTvaForm, SetupMntTvaForm );

   AddProcedure( imOnCreateComponent, idRptCpsForm, SetupRptCpsForm );
   AddProcedure( imOnCreateComponent, idGridCpsForm, SetupGridCpsForm );
   AddProcedure( imOnCreateComponent, idBrwRlvForm, SetupBrwRlvForm );

   AddProcedure( imOnCreateComponent, idFacturaVentasModule, SetupFacturaVentasModule );
   AddProcedure( imOnCreateComponent, idMovimientoModule, SetupMovimientoModule );

end.
