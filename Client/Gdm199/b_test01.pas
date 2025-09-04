unit b_test01;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,
  mask, ComCtrls, menus,
  cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  dxmdaset, cxGraphics, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxDBEdit, cxIndexedComboBox,

  cxGroupBox, cxRadioGroup, cxLabel, cxSpinEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxButtonEdit, cxCheckBox, cxListBox,
  cxLookAndFeels, cxScrollBar, cxCalendar, dxUIAClasses,

  AppContainer,

  Gim10Fields,
  Gim30Fields,

  dmi_mov,

  Gdm10Dm,
  Gdm30Dm;


type
    TboxTest01Form = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    AsientoTable: TnxeTable;
    Label2: TLabel;
    ProgressBar: TProgressBar;
    CancelarButton: TgBitBtn;
    IniciarButton: TgBitBtn;
    ContinuarButton: TgBitBtn;
    ApunteTable: TnxeTable;
    processLabel: TLabel;
    InfoLabel: TLabel;
    counterLabel: TLabel;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataPrueba: TSmallintField;
    MovimientoTable: TnxeTable;
    LineaMovimientoTable: TnxeTable;
    ArticuloTable: TnxeTable;
    ClienteTable: TnxeTable;
    ProveedorTable: TnxeTable;
    PruebaCtrl: TcxDBRadioGroup;
    DataTodos: TBooleanField;
    DataTexto: TWideStringField;
    TipoMovimientoCtrl: TcxDBIndexedComboBox;
    NroLineasCtrl: TcxSpinEdit;
    cxLabel1: TcxLabel;
    GrupoLineaMovimientoTable: TnxeTable;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    CloseButton: TgBitBtn;
    CargaTable: TnxeTable;
    DocumentoControlMercanciasTable: TnxeTable;
    DocumentoControlMercanciasTableEjercicio: TSmallintField;
    DocumentoControlMercanciasTableNroOperacion: TIntegerField;
    DocumentoControlMercanciasTableCodigoNaviera: TWideStringField;
    DocumentoControlMercanciasTableFechaCarga: TDateField;
    CargaTableEjercicio: TSmallintField;
    CargaTableNroOperacion: TIntegerField;
    CargaTableNroLinea: TSmallintField;
    CargaTableCodigoFabrica: TWideStringField;
    CargaTableReferencia: TWideStringField;
    CargaTableHora: TTimeField;
    DataFacturar: TBooleanField;
    FacturarCtrl: TcxDBCheckBox;
    PasoApasoCtrl: TcxDBCheckBox;
    DataPasoApaso: TBooleanField;
    DataTipoMovimiento: TSmallintField;
    FechaCtrl: TcxDBDateEdit;
    NroRegistroCtrl: TcxDBSpinEdit;
    TestButton: TgBitBtn;
    ResultadoLabel: TLabel;
    DataFecha: TDateField;
    DataNroRegistro: TIntegerField;
    TiposIVATable: TnxeTable;
    TiposIVATableFechaAplicacion: TDateField;
    TiposIVATableCodigo: TSmallintField;
    TiposIVATableDescripcion: TWideStringField;
    TiposIVATableIVASoportado: TBCDField;
    TiposIVATableCtaSoportado: TWideStringField;
    TiposIVATableIVAREpercutido: TBCDField;
    TiposIVATableRERepercutido: TBCDField;
    TiposIVATableCtaRepercutido: TWideStringField;
    TiposIVATableLiquidable: TBooleanField;
    TiposIVATableSobreTotal: TBooleanField;
    cxDBCheckBox1: TcxDBCheckBox;
    DataSQL: TBooleanField;
    TiposIVATableCodigoPais: TWideStringField;
    procedure InitializeForm;
    procedure CancelarButtonClick(Sender: TObject);
    procedure IniciarButtonClick(Sender: TObject);
    procedure FormManagerCloseButton;
    procedure cxDBRadioGroup1PropertiesEditValueChanged(Sender: TObject);
    procedure gBitBtn3Click(Sender: TObject);
    procedure TipoMovimientoCtrlClick(Sender: TObject);
    procedure TestButtonClick(Sender: TObject);
    private
      AsientoFields : TAsientoFields;
      ApunteFields : TApunteFields;
      MovimientoFields : TMovimientoFields;      
      LineaMovimientoFields : TLineaMovimientoFields;
      GrupoLineaMovimientoFields : TGrupoLineaMovimientoFields;
      ArticuloFields : TArticuloFields;
      ClienteFields : TClienteFields;
      ProveedorFields : TProveedorFields;
      SerieFacturacionFields : TSerieFacturacionFields;
      TiposIVAFields : TTiposIVAFields;
      
    protected
      FRange,
      Canceled : Boolean;
      Test : Variant;
    class procedure TestsContabilidad( Sender : TObject );

    public

      procedure incProgressBar;
    published
      property Range : Boolean read FRange Write FRange;
    end;

var
  boxTest01Form: TboxTest01Form;

implementation

uses   dxBar,

       LibUtils,
       TypInfo,
       EnterpriseDataAccess,
       AppManager,

       ParametrosFacturacionIntf,

       Gdm10Frm,

       dmi_ast,
       dmi_sal,

       b_msg,

       dm_ast,
       dm_sal,
       dm_mov,
       dm_tma,
       dm_sto,
       dm_art,
       dm_sdf,
       dm_fdc,
       dm_fdv;

{$R *.DFM}

{
Modificación de asientos
Inserción de asientos
Inserción de movimientos de almacén
Validación de tarjetas de registro
}

procedure TboxTest01Form.TestButtonClick(Sender: TObject);
begin

     var StartTime := DateTimeToTimeStamp( GetTime ).Time;
     var Encontrado := False;

     InfoLabel.Caption := 'Iniciado';

     If   DataSQL.Value
     then TiposIVATable.IndexFieldNames := 'Id'
     else TiposIVATable.IndexFieldNames := 'FechaAplicacion;CodigoPais;Codigo';

     For var Index := 0 to 1000 do
       begin

       If   DataSQL.Value
       then begin

            var Value := EnterpriseDataModule.ExecQuery( SQLFieldsFormat( 'SELECT TOP 1 Id FROM TiposIVA WHERE FechaAplicacion<=? AND Codigo=? ORDER BY FechaAplicacion DESC', [ DataFecha, DataNroregistro ] ) );
            Encontrado := TiposIVATable.FindKey( [ Value ] );
            end
       else begin
            TiposIVATable.SetRange( [ EncodeDate( 1900, 1, 1 ), '', 1 ], [ DataFecha.Value, '', MaxSmallint ] );
            TiposIVATable.Last;
            If   TiposIVATable.Found
            then Encontrado := TiposIVATable.FindKey( [ TiposIVATableFechaAplicacion.Value, '', DataNroRegistro.Value ] );
            end;

       end;

     {
     var Encontrado := False;

     TiposIVATable.SetRange( [ EncodeDate( 1900, 1, 1 ), 1 ], [ DataFecha.Value, MaxSmallint ] );

     TiposIVATable.Last;
     If   TiposIVATable.Found
     then Encontrado := TiposIVATable.FindKey( [ TiposIVATableFechaAplicacion.Value, DataNroRegistro.Value ] );

     If   Encontrado
     then ResultadoLabel.Caption := StrFormatDate( TiposIVATableFechaAplicacion.Value ) + ' - ' + IntToStr( TiposIVATableCodigo.Value )
     else ResultadoLabel.Caption := 'No encontrado';

     TiposIVATable.CancelRange;
     }

     If   Encontrado
     then ResultadoLabel.Caption := StrFormatDate( TiposIVATableFechaAplicacion.Value ) + ' - ' + IntToStr( TiposIVATableCodigo.Value )
     else ResultadoLabel.Caption := 'No encontrado';

     var LeapTime := DateTimeToTimeStamp( GetTime ).Time - StartTime;

     InfoLabel.Caption := IntToStr( LeapTime  );
end;

class procedure TboxTest01Form.TestsContabilidad( Sender : TObject );
begin
     CreateEditForm( TBoxTest01Form, BoxTest01Form, Gds10Frm.ContableSection, True );
end;

procedure TboxTest01Form.TipoMovimientoCtrlClick(Sender: TObject);
begin
     FacturarCtrl.Enabled := TipoMovimientoCtrl.ItemIndex=5;
     PasoAPasoCtrl.Enabled := TipoMovimientoCtrl.ItemIndex=5;
end;

procedure TboxTest01Form.InitializeForm;

var
  Count, Loop: Integer;
  List: PPropList;
  TestVariant : Variant;

begin
     AsientoFields := TAsientoFields.Create( AsientoTable );
     ApunteFields := TApunteFields.Create( ApunteTable );

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     GrupoLineaMovimientoFields := TGrupoLineaMovimientoFields.Create( GrupoLineaMovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
     ArticuloFields := TArticuloFields.Create( ArticuloTable );
     ClienteFields := TClienteFields.Create( ClienteTable );
     ProveedorFields := TProveedorFields.Create( ProveedorTable );

     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     TiposIVAFields := TTiposIVAFields.Create( Self );

     DataPrueba.Value := 0;
     DataTipoMovimiento.Value := 5;  //Albarán de venta
     DataFacturar.Value := True;

     {
     Count := GetPropList( TypeInfo( TboxTest01Form ), tkAny, nil );
     GetMem( List, Count * SizeOf( PPropInfo ) );
     try
       GetPropList( TypeInfo( TboxTest01Form ), tkAny, List );
       cxListbox1.Items.BeginUpdate;
       for Loop := 0 to Pred(Count) do
         cxListbox1.Items.Add( List^[ Loop ]^.Name);
       cxListbox1.Items.EndUpdate;
     finally
      FreeMem(List, Count * SizeOf(PPropInfo))
      end;
     }

     // TestVariant := GetVariantProp( Self,'Test' );

end;

procedure TboxTest01Form.CancelarButtonClick(Sender: TObject);
begin
     Canceled := True;
end;

procedure TboxTest01Form.incProgressBar;
begin
     With ProgressBar do
       begin
       If   Position=100
       then Position := 1
       else Position := Position + 1;
       end;
end;

procedure TboxTest01Form.IniciarButtonClick(Sender: TObject);

var  PageIndex,
     LineIndex,
     Index,
     NumOfPages : SmallInt;
     ImporteApunte : Double;
     NroLineas,
     NroRegistros : Integer;
     StartTime,
     LeapTime : Integer;

     VarTipoMovimiento,
     VarEjercicio : SmallInt;
     VarSerie : String;
     VarNroDocumento : LongInt;
     TipoMovimientoPrueba : TTipoMovimiento;
     ParametrosFacturacion : IParametrosFacturacion;
     
     CodigoPropietario : String;
     NroProximoDocumento : Integer;

     Guid : TGuid;

function ClaveAleatoriaArticulo : String;

var  Index : SmallInt;
     Codigo : String;

begin
     With ArticuloTable do
       repeat

         Codigo := '';
         For Index := 0 to Random( 6 ) do
           Codigo := Codigo + Chr( Ord( '0' ) + Random( 74 ) );

         FindNearest( [ Codigo ] );
         If   Found
         then Result := ArticuloFields.Codigo.Value;

       until Found;
end;

function ClaveAleatoriaPropietario : String;

var  Index : SmallInt;
     Codigo : String;
     Table : TnxTable;

begin
     If   TipoMovimientoPrueba=tmVenta
     then Table := ClienteTable
     else Table := ProveedorTable;

     With Table do
       repeat

         Codigo := '00';
         For Index := 1 to 3 do
           Codigo := Codigo + Chr( Ord( '0' ) + Random( 9 ) );

         FindNearest( [ Codigo ] );
         If   Found
         then If   TipoMovimientoPrueba=tmVenta
              then Result := ClienteFields.Codigo.Value
              else Result := ProveedorFields.Codigo.Value;

       until Found;
end;

var  SumasySaldos : ISumasySaldos;

begin

     (*
     VarTipoMovimiento := 0;
     VarEjercicio := 0;
     VarSerie := '';
     VarNroDocumento := 0;

     With MovimientoTable do
       begin
       IndexFieldNames := 'TipoMovimiento;Ejercicio;Serie;NroDocumento';
       First;
       While not Eof do
         begin

         With MovimientoFields do
           If   ( VarTipoMovimiento=TipoMovimiento.Value ) and
                ( VarEjercicio=Ejercicio.Value ) and
                ( VarSerie=Serie.value ) and
                ( VarNroDocumento=NroDocumento.value )
           then begin
                If   VarEjercicio>2005
                then Index := 1;
                Delete;
                end
           else begin
                VarTipoMovimiento := TipoMovimiento.Value;
                VarEjercicio := Ejercicio.value;
                VarSerie := Serie.Value;
                VarNroDocumento := NroDocumento.Value;
                Next;
                end;
         end;
       end;

     Exit;
     *)
     (*
     Canceled := False;

     IniciarButton.Enabled := False;
     ContinuarButton.Enabled := DataPasoAPaso.Value;
     CancelarButton.Enabled := not DataPasoAPaso.Value;
     CloseButton.Enabled := False;
     
     try

         
         If   Sender=IniciarButton
         then begin
              NroRegistros := 0;
              StartTime := DateTimeToTimeStamp( GetTime ).Time;
              end;
              
         Case DataPrueba.Value of
           0, 1 : While not Canceled do
                    try

                      AsientoTable.Cancel;
                      ApunteTable.Cancel;

                      AsientoTable.Append;

                      With AsientoFields do
                        begin
                        Ejercicio.Value := ApplicationContainer.Ejercicio;
                        NroAsiento.Value := Asiento.ProximoNroAsiento;
                        TipoAsiento.Value  := taOrdinario;
                        fecha.Value  := ApplicationContainer.TodayDate;
                        end;

                      AsientoTable.Post;

                      Asiento.RetiraNroAsiento( AsientoFields, False );

                      ProcessLabel.Caption := intToStr( AsientoFields.NroAsiento.Value );
                      Application.processMessages;

                      For Index := 0 to 1 do // Random( 50 ) + 2 do
                        begin

                        ImporteApunte := Redondea( Random( 1000 ) + 10, DecimalesMoneda );

                        With ApunteFields do
                          begin

                          ApunteTable.Append;

                          Ejercicio.Value := AsientoFields.Ejercicio.Value;
                          NroAsiento.Value := AsientoFields.NroAsiento.Value;
                          NroApunte.Value := ( Index * 2 ) + 1;
                          Fecha.Value := AsientoFields.Fecha.Value;
                          Subcuenta.Value := '572000000';
                          Contrapartida.Value := '430000000';
                          Concepto.Value := 'Un ingreso';
                          Debe.Value := ImporteApunte;
                          Haber.Value := 0.0;

                          Saldos.ActualizaSaldos( AsientoFields.TipoAsiento.Value, ApunteFields, False );

                          ApunteTable.Post;

                          // Contrapartida

                          ApunteTable.Append;

                          Ejercicio.Value := AsientoFields.Ejercicio.Value;
                          NroAsiento.Value := AsientoFields.NroAsiento.Value;
                          NroApunte.Value := ( Index * 2 ) + 2;
                          Fecha.Value := AsientoFields.Fecha.Value;
                          Subcuenta.Value := '430000000';
                          Contrapartida.Value := '572000000';
                          Concepto.Value := 'Un ingreso';
                          Debe.Value := 0.0;
                          Haber.Value := ImporteApunte;

                          Saldos.ActualizaSaldos( AsientoFields.TipoAsiento.Value, ApunteFields, False );

                          ApunteTable.Post;

                          end;

                        // counterLabel.Caption := IntToStr( Saldos.dmSaldosCursor.fTopRetryCount  );
                        end;

                      Inc( NroRegistros );

                      leapTime := DateTimeToTimeStamp( GetTime ).Time - StartTime;

                      InfoLabel.Caption := IntToStr( LeapTime div NroRegistros );
                      Application.processMessages;

                      IncProgressBar;
                      Application.processMessages;

                    except
                      ShowNotification( ntStop, 'Asiento : ' + IntToStr( AsientoFields.NroAsiento.Value ) );
                      end;

           2   : begin

                 TipoMovimientoPrueba := TipoMovimientoCtrl.ItemIndex + 10;  // tmOferta..tmVenta

                 SerieFacturacion.Obten( '', SerieFacturacionFields );

                 While not Canceled do
                    begin

                    MovimientoTable.Cancel;
                    GrupoLineaMovimientoTable.Cancel;
                    LineaMovimientoTable.Cancel;

                    EnterpriseDataModule.StartTransaction( [ MovimientoTable, GrupoLineaMovimientoTable, LineaMovimientoTable ] );

                    try

                      MovimientoTable.Append;

                      With MovimientoFields do
                        begin
                        Ejercicio.Value := ApplicationContainer.Ejercicio;
                        TipoMovimiento.Value := TipoMovimientoPrueba;
                        Serie.Value := '';
                        CodigoPropietario := ClaveAleatoriaPropietario;
                        Propietario.Value := CodigoPropietario;
                        NroOperacion.Value := Movimiento.ProximaOperacion;
                        NroProximoDocumento := Movimiento.ProximoDocumento( MovimientoFields );
                        NroDocumento.Value := NroProximoDocumento;

                        Fecha.Value := ApplicationContainer.TodayDate;
                        end;

                      {
                      If   TipoMovimientoPrueba=tmVenta
                      then NumOfPages := Random( 10 )
                      else NumOfPages := 0;
                      }

                      NumOfPages := 0;

                      For PageIndex := 0 to NumOfPages do
                        begin

                        If   TipoMovimientoPrueba in [ tmPresupuesto..tmVenta ]
                        then With GrupoLineaMovimientoFields do
                               begin
                               GrupoLineaMovimientoTable.Append;

                               Ejercicio.Value  := MovimientoFields.Ejercicio.Value;
                               NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                               NroPagina.Value := PageIndex;
                               Descripcion.Value := Format( 'Página nº %d', [ PageIndex ] );

                               GrupoLineaMovimientoTable.Post;
                               end;

                        For LineIndex := 1 to Random( NroLineasCtrl.Value ) + 2 do
                          begin

                          With LineaMovimientoFields do
                            begin

                            LineaMovimientoTable.Append;

                            Ejercicio.Value  := MovimientoFields.Ejercicio.Value;
                            NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                            NroPagina.Value := PageIndex;
                            NroLinea.Value := LineIndex;
                            Fecha.Value := MovimientoFields.Fecha.Value;
                            CodigoArticulo.Value := ClaveAleatoriaArticulo;
                            Descripcion.Value := Articulo.Descripcion( CodigoArticulo.Value, False );

                            Cantidad.Value := ( 1 + Random( 10 ) ) + Random;

                            If   TipoMovimientoPrueba in [ tmPresupuesto..tmVenta ]
                            then Cantidad.Value := -Cantidad.Value;

                            If   Random<0.1
                            then Cantidad.Value := -Cantidad.Value;

                            Precio.Value := 10 + Random( 100 ) + Random;

                            If   TipoMovimientoPrueba in [ tmPresupuesto..tmVenta ]
                            then begin
                                 FacturaVentas.ObtenTipoIVAArticulo( MovimientoFields.Fecha.Value, ArticuloFields, TiposIVAFields, SerieFacturacionFields, ClienteFields );
                                 Movimiento.ActualizaCamposCalculadosLineaVenta( MovimientoFields, LineaMovimientoFields, ClienteFields, ArticuloFields, SerieFacturacionFields, TiposIVAFields );
                                 end
                            else begin
                                 FacturaCompras.ObtenTipoIVAArticulo( MovimientoFields.Fecha.Value, ArticuloFields, ProveedorFields, TiposIVAFields );
                                 Movimiento.ActualizaCamposCalculadosLineaCompra( MovimientoFields, LineaMovimientoFields, ProveedorFields, ArticuloFields, TiposIVAFields );
                                 end;


                            LineaMovimientoTable.Post;

                            StockAlmacen.ActualizaStock( MovimientoFields, LineaMovimientoFields, False );

                            end;

                          end;

                        end;

                      MovimientoTable.Post;

                      If   ( TipoMovimientoPrueba=tmVenta ) and DataFacturar.Value
                      then begin

                           ParametrosFacturacion := TParametrosFacturacion.Create;

                           With ParametrosFacturacion do
                             begin
                             TipoSeleccion := tsDocumento;   // sólo el albaran actual
                             Serie := MovimientoFields.Serie.Value;
                             NroDocumento := MovimientoFields.NroDocumento.Value;
                             FechaFacturacion := ApplicationContainer.TodayDate;
                             CopiaPropietario := True;
                             end;

                           ParametrosFacturacion := FacturaVentas.GeneraFacturas( ParametrosFacturacion );

                           end;
                           
                      Movimiento.RetiraDocumento( MovimientoFields, False );

                      ProcessLabel.Caption := IntToStr( MovimientoFields.NroOperacion.Value );
                      Application.ProcessMessages;

                      Inc( NroRegistros );

                      LeapTime := DateTimeToTimeStamp( GetTime ).Time - StartTime;

                      InfoLabel.Caption := IntToStr( LeapTime div NroRegistros );
                      Application.ProcessMessages;

                      IncProgressBar;
                      Application.ProcessMessages;

                      {
                      If   ( ( NroRegistros mod 100 )=0 ) or Canceled
                      then begin
                           InfoLabel.Caption := 'Actualizando transacción.';
                           Application.processMessages;
                           EnterpriseDataModule.Commit;
                           If   not Canceled
                           then EnterpriseDataModule.StartTransaction;
                           end;
                      }

                      EnterpriseDataModule.Commit;

                      If   DataPasoAPaso.Value
                      then Break;

                    except on E : Exception do
                      begin
                      Canceled := True;
                      With MovimientoFields do
                        ShowNotification( ntStop, 'Movimiento de almacén : ' + IntToStr( NroOperacion.Value ) + ' Nº documento : ' + IntToStr( NroDocumento.Value ), E.Message );
                      EnterpriseDataModule.RollBack;
                      end;
                    end;

                    end;
                 end;

           3 : While not Canceled do
                 begin

                 DocumentoControlMercanciasTable.Append;

                 DocumentoControlMercanciasTableEjercicio.Value := ApplicationContainer.Ejercicio;
                 DocumentoControlMercanciasTableNroOperacion.Value := DocumentoControlMercancias.ProximoNroOperacion;
                 DocumentoControlMercanciasTableCodigoNaviera.Value := 'N' + IntToStr( Random( 3 ) + 1 );
                 DocumentoControlMercanciasTableFechaCarga.Value := Now -  Random( 200 );

                 DocumentoControlMercanciasTable.Post;

                 NroLineas := Random( 10 );
                 For Index := 0 to NroLineas do
                   begin

                   CargaTable.Append;

                   CargaTableEjercicio.Value := ApplicationContainer.Ejercicio;
                   CargaTableNroOperacion.Value := DocumentoControlMercanciasTableNroOperacion.Value;
                   CargaTableNroLinea.Value := Index + 1;
                   CargaTableCodigoFabrica.Value := 'F' + IntToStr( Random( 3 ) + 1 );
                   CreateGuid( Guid );
                   CargaTablereferencia.Value := Guid.ToString;
                   CargaTableHora.Value := Now - Random( 1000);

                   CargaTable.Post;
                   end;

                 IncProgressBar;
                 Application.ProcessMessages;
                 end;

           4 : begin

               var StId1 := EnterpriseDataModule.StartTransaction( [ MovimientoTable ] );
               try
                   MovimientoTable.Edit;

                   var StId2 := EnterpriseDataModule.StartTransaction( [ LineaMovimientoTable ] );
                   try
                       LineaMovimientoTable.Last;
                       LineaMovimientoTable.Edit;

                       LineaMovimientoFields.Cantidad.Value := LineaMovimientoFields.Cantidad.Value + 1;

                       LineaMovimientoTable.Post;

                       EnterpriseDataModule.Commit( StId2 );
                   except
                     EnterpriseDataModule.Rollback( StId2 );
                     raise;
                     end;

                   Abort;

                   MovimientoTable.Post;

                   EnterpriseDataModule.Commit( StId1 );

               except
                 EnterpriseDataModule.Rollback( StId1 );
                 raise;
                 end;
               end;

           end;

     finally
       Enabled := True;
       CloseButton.Enabled := True;
       IniciarButton.Enabled := True;
       CancelarButton.Enabled := False;
       end;

     *)

     Saldos.Sumas( EncodeDate( 2024, 6, 23 ), SumasySaldos );

end;

procedure TboxTest01Form.GBitBtn3Click(Sender: TObject);
begin
end;

//

procedure SetupTestSection;

var  MenuItem : TMenuItem;

begin
     With Gds10Frm do
       begin
       PruebasCargaItem.Visible := ivAlways;
       PruebasCargaItem.OnClick := TboxTest01Form.TestsContabilidad;
       end;
end;

procedure TboxTest01Form.cxDBRadioGroup1PropertiesEditValueChanged(Sender: TObject);
begin
     TipoMovimientoCtrl.Enabled := PruebaCtrl.EditValue=2;
end;

procedure TboxTest01Form.FormManagerCloseButton;
begin
     Canceled := True;
end;

initialization
  AddProcedure( imStartUp, 0, SetupTestSection );

end.
