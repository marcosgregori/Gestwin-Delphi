unit a_arq;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes, Windows,
  ExtCtrls, Grids, Graphics, ComCtrls, cxEdit,

  LibUtils,
  AppContainer,
  DataManager,
  Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxCheckBox, cxDBEdit, cxCurrencyEdit, cxContainer, cxTextEdit,

  Gim00Fields,
  Gim10Fields,
  Gdm20Dm,
  Gim30Fields, cxMaskEdit, cxDropDownEdit, cxCalendar, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels, cxLabel,
  cxGroupBox, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  dxUIAClasses;

type
  TmntArqForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    SerieCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    FechaCtrl: TcxDBDateEdit;
    SaldoInicialCtrl: TcxDBCurrencyEdit;
    actualizarButton: TgBitBtn;
    CerradoCtrl: TcxDBCheckBox;
    ImporteRetiradoCtrl: TcxDBCurrencyEdit;
    ArqueoTable: TnxeTable;
    ProgressBar: TProgressBar;
    FacturaVentasTable: TnxeTable;
    LineaArqueoTable: TnxeTable;
    VentasDiaQuery: TnxeQuery;
    MovimientoCajaTable: TnxeTable;
    BrowseArqueoTable: TnxeTable;
    LineaMovimientoTable: TnxeTable;
    MovimientoTable: TnxeTable;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    Grid1: TcxGrid;
    Grid1View: TcxGridDBTableView;
    Grid1Level: TcxGridLevel;
    Grid2: TcxGrid;
    Grid2View: TcxGridDBTableView;
    Grid2Level: TcxGridLevel;
    ArqueoDataSource: TDataSource;
    LockRangeButton: TgxLockRangeButton;
    VentasDiaDataSource: TDataSource;
    Grid1ViewFormaCobro: TcxGridDBColumn;
    Grid1ViewImporte: TcxGridDBColumn;
    Grid1ViewImporteEnEfectivo: TcxGridDBColumn;
    Grid1ViewDescripcion: TcxGridDBColumn;
    MovimientosCajaDataSource: TDataSource;
    Grid2ViewTextoTipoOperacion: TcxGridDBColumn;
    Grid2ViewImporte: TcxGridDBColumn;
    Grid2ViewImporteEnEfectivo: TcxGridDBColumn;
    MovimientosCajaQuery: TnxeQuery;
    MovimientosCajaQuerySerie: TWideStringField;
    MovimientosCajaQueryFecha: TDateField;
    MovimientosCajaQueryTipoOperacion: TSmallintField;
    MovimientosCajaQueryFormaCobro: TWideStringField;
    MovimientosCajaQueryImporte: TBCDField;
    MovimientosCajaQueryImporteEnEfectivo: TBCDField;
    MovimientosCajaQueryDescripcion: TWideStringField;
    ArqueoTableSerie: TWideStringField;
    ArqueoTableFecha: TDateField;
    ArqueoTableSaldoInicial: TBCDField;
    ArqueoTableImporteVentas: TBCDField;
    ArqueoTableImpVentasEfectivo: TBCDField;
    ArqueoTableImporteMovimCaja: TBCDField;
    ArqueoTableImpMovimCajaEfectivo: TBCDField;
    ArqueoTableImporteRetirado: TBCDField;
    ArqueoTableCerrado: TBooleanField;
    VentasDiaQuerySerie: TWideStringField;
    VentasDiaQueryFecha: TDateField;
    VentasDiaQueryTipoOperacion: TSmallintField;
    VentasDiaQueryFormaCobro: TWideStringField;
    VentasDiaQueryImporte: TBCDField;
    VentasDiaQueryImporteEnEfectivo: TBCDField;
    VentasDiaQueryDescripcion: TWideStringField;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label11: TcxLabel;
    SaldoEfectivoBox: TcxLabel;
    SaldoFinalCajaBox: TcxLabel;
    SaldoBox: TcxLabel;
    procedure FormManagerInitializeForm;
    procedure actualizarButtonClick(Sender: TObject);
    function FormManagerDeleteButton: Boolean;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure ArqueoTableAfterInsert(DataSet: TDataSet);
    procedure ArqueoTableAfterEdit(DataSet: TDataSet);
    procedure ArqueoTableUpdateState(DataSet: TDataSet);
    procedure LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
    procedure MovimientosCajaQueryCalcFields(DataSet: TDataSet);
    procedure SaldoInicialCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ImporteRetiradoCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure SerieCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ArqueoTableRecordChanged(DataSet: TDataSet);
    procedure ArqueoTableBeforeDelete(DataSet: TDataSet);
    procedure ArqueoTableSetKey(DataSet: TDataSet);
    procedure Grid1ViewDescripcionGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
  private

    FacturaVentasFields : TFacturaVentasFields;
    MovimientoFields : TMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;

    ArqueoFields,
    BrowseArqueoFields : TArqueoFields;
    LineaArqueoFields : TLineaArqueoFields;
    MovimientoCajaFields : TMovimientoCajaFields;
    SerieFacturacionFields : TSerieFacturacionFields;
    ClienteFields : TClienteFields;
    FormaCobroFields : TFormaCobroFields;

    SaldoDia,
    SaldoDiaEfectivo,
    SaldoFinal : Decimal;

  public
    procedure CalculaRegistro;
    procedure MuestraDatosFicha;
  end;

var  mntArqForm: TmntArqForm = nil;

procedure ArqueoCaja;

implementation

{$R *.DFM}

uses   SysUtils,
       Variants,
       EnterpriseDataAccess,
       AppManager,
       DateUtils,

       Gdm00Dm,
       Gdm30Dm,
       Gdm20Frm,

       dmi_mov,

       a_pde_tpv,

       b_msg,

       dm_sdf,
       dm_tma,
       dm_mov,
       dm_fco,
       dm_mdc,
       dm_pga,
       dm_cli,
       dm_art,
       dm_iva,

       a_sdf,

       cx_sdf,

       l_arq;

const  oaIngreso = 0;
       oaPago    = 1;
       oaVenta   = 10;

resourceString
       RsMsg1  = 'Este registro ha sido cerrado.';
       RsMsg2  = 'Solo el usuario maestro puede acceder a registros de arqueo previamente cerrados.';
       RsMsg3  = 'Solo el usuario maestro puede suprimir registros de arqueo.';
       RsMsg4  = 'No puede realizar modificaciones en los registros de arqueo.';
       RsMsg5  = 'Entregas a cuenta en pedidos';

procedure ArqueoCaja;
begin
     CreateEditForm( TMntArqForm, MntArqForm, Gds20Frm.TPVSection );
end;

procedure TmntArqForm.CalculaRegistro;

var  EnEfectivo : Boolean;
     ImporteDocumento,
     ImporteEfectivo : Decimal;

     TotalAlbaran : Decimal;

     // CalcularIVA : Boolean;

     SeriePedido : String;

procedure ShowProgressBar;
begin
     With ProgressBar do
       If   Position=Max
       then Position := 0
       else Position := Position + 1;
     Application.ProcessMessages;
end;

function Efectivo( CodigoFormaCobro : String ) : Boolean;
begin
     FormaCobro.Obten( CodigoFormaCobro, FormaCobroFields, True );
     Result := FormaCobroFields.Plazos.Value=0;
end;

procedure AcumulaImporteArqueo( UnaSerie             : String;
                                UnaFecha             : TDate;
                                UnTipoOperacion      : SmallInt;
                                UnCodigoFormaCobro   : String;
                                UnImporteDocumento,
                                UnImporteEnEfectivo  : Decimal;
                                MovimientoCaja       : Boolean = False );
begin

     If   LineaArqueoTable.FindKey( [ UnaSerie, UnaFecha, UnTipoOperacion, UnCodigoFormaCobro ] )
     then begin

          LineaArqueoTable.Edit;

          With LineaArqueoFields do
            begin
            Importe.Value := Importe.Value + UnImporteDocumento;
            ImporteEnEfectivo.Value := ImporteEnEfectivo.Value + UnImporteEnEfectivo;
            end;

          end
     else begin

          LineaArqueoTable.Append;

          With LineaArqueoFields do
            begin
            Serie.Value := UnaSerie;
            Fecha.Value := UnaFecha;
            TipoOperacion.Value := UnTipoOperacion;    // El tipo reservado para las ventas. 0=Ingresos, 1=Pagos y 2..9 = Uso futuro
            FormaCobro.Value := UnCodigoFormaCobro;
            Importe.Value := UnImporteDocumento;
            ImporteEnEfectivo.Value := UnImporteEnEfectivo;
            end;

          end;

     LineaArqueoTable.Post;

     With ArqueoFields do
       If   MovimientoCaja
       then begin
            ImporteMovimCaja.Value := ImporteMovimCaja.Value + UnImporteDocumento;
            ImpMovimCajaEfectivo.Value := ImpMovimCajaEfectivo.Value + UnImporteEnEfectivo;
            end
       else begin
            ImporteVentas.Value := ImporteVentas.Value + UnImporteDocumento;
            ImpVentasEfectivo.Value := ImpVentasEfectivo.Value + UnImporteEnEfectivo;
            end;

end;

begin

     try

       try

       EnterpriseDataModule.StartTransaction( [ ArqueoTable,
                                                LineaArqueoTable ] );

       With ProgressBar do
         begin
         Visible := True;
         Position := 0;
         end;

       With ArqueoFields do
         begin

         Serie.Value := VarToStr( SerieCtrl.EditValue );
         Fecha.Value := FechaCtrl.EditValue;

         ImpVentasEfectivo.Value := 0.0;
         ImporteVentas.Value := 0.0;
         ImporteMovimCaja.Value := 0.0;
         ImpMovimCajaEfectivo.Value := 0.0;

         // Si no hay saldo inicial cojo el saldo final del día anterior
         // 25.01.2002  Excepto si el saldo inicial es fijo

         If   SaldoInicial.Value=0.0
         then If   ParametrosTPVRec.SaldoInicialCaja<>0.0
              then SaldoInicial.Value := ParametrosTPVRec.saldoInicialCaja
              else If   BrowseArqueoTable.FindSmallerOrEqual( [ Serie.Value, IncDay( Fecha.Value, -1 ) ] )
                   then If   BrowseArqueoFields.Serie.Value=Serie.Value
                        then SaldoInicial.Value := BrowseArqueoFields.SaldoInicial.Value +
                                                   BrowseArqueoFields.ImpVentasEfectivo.Value +
                                                   BrowseArqueoFields.ImpMovimCajaEfectivo.Value -
                                                   BrowseArqueoFields.ImporteRetirado.Value;

         ArqueoTableBeforeDelete( nil );

         // Primero acumulo las ventas del día

         If   ParametrosTPVRec.DocumentoArqueo=0 // Sobre facturas
         then begin

              With FacturaVentasTable do
                begin

                SetRange( [ Serie.Value, Fecha.Value, 1 ], [ Serie.Value, Fecha.Value, MaxLongint ] );

                First;

                While not Eof do
                  begin

                  With FacturaVentasFields do
                    begin

                    //* 10.12.2001 Las operaciones cuya forma de pago no sea Efectivo pueden
                    //             serlo en parte, al considerar las entregas a cuenta como
                    //             entregas en Efectivo.

                    EnEfectivo := Efectivo( CodigoFormaCobro.Value );

                    ImporteDocumento := TotalFactura.Value;
                    If   EnEfectivo
                    then ImporteEfectivo := ImporteDocumento
                    else ImporteEfectivo := TotalACuenta.Value;

                    AcumulaImporteArqueo( Serie.Value, Fecha.Value, oaVenta, CodigoFormaCobro.Value, ImporteDocumento, ImporteEfectivo );

                    end;

                ShowProgressBar;
                Next;
                end;

                end;

              end
         else begin

              With MovimientoTable do
                begin

                // Empiezo buscando entregas a cuenta en los pedidos

                If   Movimiento.SeriesEnDocumentosVenta( tmPedidoVenta )
                then SeriePedido := Serie.Value
                else SeriePedido := '';

                SetRange( [ tmPedidoVenta, SeriePedido, Fecha.Value, 1 ], [ tmPedidoVenta, SeriePedido, Fecha.Value, MaxLongint ] );
                First;
                While not Eof do
                 begin
                 If    MovimientoFields.EntregaACuenta.Value<>0.0
                 then  AcumulaImporteArqueo( Serie.Value, Fecha.Value, oaVenta, '', 0.0, MovimientoFields.EntregaACuenta.Value );
                 Next;
                 end;

                // Y luego proceso los albaranes del día

                SetRange( [ tmVenta, Serie.Value, Fecha.Value, 1 ], [ tmVenta, Serie.Value, Fecha.Value, MaxLongint ] );
                First;

                While not Eof do
                 begin

                 With MovimientoFields do
                   begin

                   Cliente.Obten( MovimientoFields.Propietario.Value, '', ClienteFields );
                   SerieFacturacion.Obten( MovimientoFields.Serie.Value, SerieFacturacionFields );

                   If   ValueIsEmpty( MovimientoFields.CodigoFormaCobro.Value )
                   then EnEfectivo := True
                   else EnEfectivo := Efectivo( MovimientoFields.CodigoFormaCobro.Value );

                   {
                   CalcularIVA := not ( ValueIsEmpty( ClienteFields.Factura_ModeloIVA.Value ) or
                                      ( not ValueIsEmpty( MovimientoFields.Serie.Value ) and not ( SerieFacturacionFields.Contabilizar.Value ) ) );
                   }

                   With LineaMovimientoTable do
                     begin

                     TotalAlbaran := 0.0;

                     SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

                     First;
                     While not Eof do
                       begin
                       TotalAlbaran := TotalAlbaran + LineaMovimientoFields.ImporteTotal.Value;
                       Next;
                       end;

                     end;

                   ImporteDocumento := TotalAlbaran;
                   If   EnEfectivo
                   then ImporteEfectivo := ImporteDocumento
                   else ImporteEfectivo := MovimientoFields.EntregaACuenta.Value;

                   AcumulaImporteArqueo( Serie.Value, Fecha.Value, oaVenta, CodigoFormaCobro.Value, ImporteDocumento, ImporteEfectivo );

                   end;

                 ShowProgressBar;
                 Next;
                 end;

                end;

              end;

         // y, a continuación, los movimientos de caja

         With MovimientoCajaTable do
           begin

           SetRange( [ Serie.Value, Fecha.Value ], [ Serie.Value, Fecha.Value ] );
           First;
           While not Eof do
             begin

             With MovimientoCajaFields do
               begin

               If   TipoOperacion.Value=oaIngreso
               then EnEfectivo := Efectivo( FormaCobro.Value )
               else EnEfectivo := True;   // Los pagos por caja son -evidentemente- siempre en Efectivo

               ImporteDocumento := DecSign( MovimientoCajaFields.Importe.Value, TipoOperacion.Value=oaIngreso );
               If   EnEfectivo
               then ImporteEfectivo := ImporteDocumento
               else ImporteEfectivo := 0.0;

               AcumulaImporteArqueo( Serie.Value, Fecha.Value, TipoOperacion.Value, '', ImporteDocumento, ImporteEfectivo, True );

               end;

             ShowProgressBar;
             Next;
             end;

           end;

         end;

       EnterpriseDataModule.Commit;

       except
         EnterpriseDataModule.RollBack;
         raise;
         end;

     finally
       ProgressBar.Visible := False;
       end;

end;

procedure TmntArqForm.FormManagerInitializeForm;
begin
     FacturaVentasFields := TFacturaVentasFields.Create( FacturaVentasTable );
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );

     ArqueoFields := TArqueoFields.Create( ArqueoTable );
     BrowseArqueoFields := TArqueoFields.Create( BrowseArqueoTable );
     LineaArqueoFields := TLineaArqueoFields.Create( LineaArqueoTable );
     MovimientoCajaFields := TMovimientoCajaFields.Create( MovimientoCajaTable );
     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     ClienteFields := TClienteFields.Create( Self );
     FormaCobroFields := TFormaCobroFields.Create( Self );

     SetColumnsDecimals( [ Grid1ViewImporte, Grid1ViewImporteEnEfectivo, Grid2ViewImporte, Grid2ViewImporteEnEfectivo ] );
     SetEditControlsDecimals( [ SaldoInicialCtrl, ImporteRetiradoCtrl ] );

     LockRangeButton.Down := True;
end;

procedure TmntArqForm.MovimientosCajaQueryCalcFields(DataSet: TDataSet);
begin
     MovimientosCajaQueryDescripcion.Value := MovimientoCaja.DescripcionTipoOperacion( TTipoOperacionCaja( MovimientosCajaQueryTipoOperacion.Value ) );
end;

procedure TmntArqForm.MuestraDatosFicha;
begin
     With ArqueoFields do
       begin

       SaldoDia := SaldoInicial.Value + ImporteVentas.Value + ImporteMovimCaja.Value;
       SaldoDiaEfectivo := SaldoInicial.Value + ImpVentasEfectivo.Value + ImpMovimCajaEfectivo.Value;
       SaldoFinal := SaldoDiaEfectivo - ImporteRetirado.Value;

       SaldoBox.Caption := StrFormat( SaldoDia, DecimalesMoneda );
       SaldoEfectivoBox.Caption := StrFormat( SaldoDiaEfectivo, DecimalesMoneda );
       SaldoFinalCajaBox.Caption := StrFormat( SaldoFinal, DecimalesMoneda );
       end;
end;

procedure TmntArqForm.SaldoInicialCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   SaldoInicialCtrl.Editing
     then MuestraDatosFicha;
end;

procedure TmntArqForm.SerieCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     SerieFacturacion.FijaSeriePorDefecto( SerieCtrl );
end;

procedure TmntArqForm.SerieCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TmntArqForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntArqForm.ActualizarButtonClick(Sender: TObject);
begin
     With ArqueoTable do
       begin
       Edit;
       CalculaRegistro;
       Post;
       end;
     FormManager.SelectFirstKeyControl;
     ActualizarButton.Enabled := False;
end;

function TmntArqForm.FormManagerDeleteButton: Boolean;
begin
     Result := True;
     If   not UsuarioMaestro
     then begin
          ShowNotification( ntStop, RsMsg3 );
          Abort;
          end;
end;

procedure TmntArqForm.FormManagerReportRequest;
begin
     ListadoArqueo;
end;

procedure TmntArqForm.Grid1ViewDescripcionGetDisplayText(     Sender   : TcxCustomGridTableItem;
                                                              ARecord  : TcxCustomGridRecord;
                                                          var AText    : string);
begin
     If   ARecord.Values[ Grid1ViewFormaCobro.Index ]=''   // Es una entrega a cuenta en un pedido
     then AText := RsMsg5;
end;

procedure TmntArqForm.ImporteRetiradoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ImporteRetiradoCtrl.Editing
     then MuestraDatosFicha;
end;

procedure TmntArqForm.LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
begin
     With ArqueoTable do
       begin
       // KeyValues : Serie;Fecha
       If   not LockRangeButton.Down
       then KeyValues[ 0 ] := UnAssigned; // Serie
       KeyValues[ 1 ] := UnAssigned; // Fecha
       end;
end;

function TmntArqForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.acCAArqueo.Value;
end;

procedure TmntArqForm.ArqueoTableAfterEdit(DataSet: TDataSet);
begin
     If   not UsuarioMaestro and ( ArqueoFields.Cerrado.Value )
     then begin
          ShowNotification( ntStop, RsMsg1, RsMsg2 );
          Abort;
          end
     else If   DataModule00.DmUsuarioFields.AcCAArqueo.Value=3   // No puede realizar modificaciones
          then begin
               ShowNotification( ntStop, RsMsg4 );
               Abort;
               end;
end;

procedure TmntArqForm.ArqueoTableAfterInsert(DataSet: TDataSet);
begin
     If   ArqueoTable.State=dsInsert  // puede ser dsSetKey
     then CalculaRegistro;
end;

procedure TmntArqForm.ArqueoTableBeforeDelete(DataSet: TDataSet);
begin
     EnterpriseDataModule.ExecQuery( SQLFieldsFormat( 'DELETE FROM LineaArqueo WHERE Serie=? AND Fecha=?', [ ArqueoFields.Serie, ArqueoFields.Fecha ] ) );
end;

procedure TmntArqForm.ArqueoTableRecordChanged(DataSet: TDataSet);
begin
     MuestraDatosFicha;
end;

procedure TmntArqForm.ArqueoTableSetKey(DataSet: TDataSet);
begin
     If   LockRangeButton.SettingDefaultRange
     then SerieFacturacion.FijaSeriePorDefecto( ArqueoFields.Serie );
end;

procedure TmntArqForm.ArqueoTableUpdateState(DataSet: TDataSet);
begin
     ActualizarButton.Enabled := ArqueoTable.State in [ dsEdit, dsInsert ];
end;

end.


