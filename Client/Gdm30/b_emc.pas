
unit b_emc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask,

  AppContainer,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxPC, cxControls, cxGraphics, nxdb, cxGroupBox,
  cxRadioGroup, cxDBEdit, cxMaskEdit, cxDropDownEdit, cxIndexedComboBox,
  cxContainer, cxEdit, cxTextEdit, cxCalendar,

  cxCheckBox, dxSkinsCore, cxLookAndFeels, dxSkinsDefaultPainters, cxLabel,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields, dxUIAClasses;

type
  TBoxEmcForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    ProveedorTable: TnxeTable;
    FormManager: TgxFormManager;
    MovimientoTable: TnxeTable;
    LineaMovimientoTable: TnxeTable;
    PathCtrl: TcxDBTextEdit;
    ExaminarButton: TgBitBtn;
    FormatoCtrl: TcxDBIndexedComboBox;
    ExternProveedorTable: TnxeTable;
    ExternMovimientoTable: TnxeTable;
    ExternLineaMovimientoTable: TnxeTable;
    ExternFacturaComprasTable: TnxeTable;
    FacturaComprasTable: TnxeTable;
    EfectoTable: TnxeTable;
    ExternEfectoTable: TnxeTable;
    ArticuloTable: TnxeTable;
    ExternArticuloTable: TnxeTable;
    DestinoOrigenCtrl: TcxDBRadioGroup;
    DireccionCorreoCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataProceso: TSmallintField;
    DataPath: TWideStringField;
    DataFormato: TSmallintField;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataDestinoOrigen: TSmallintField;
    DataDireccionCorreo: TWideStringField;
    ProcesoCtrl: TcxDBIndexedComboBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    ProveedorInicialCtrl: TcxDBTextEdit;
    ProveedorFinalCtrl: TcxDBTextEdit;
    ReferenciasPedidosCtrl: TcxDBCheckBox;
    SituacionCtrl: TcxDBIndexedComboBox;
    Shape1: TShape;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    DataSituacion: TSmallintField;
    DataProveedorInicial: TWideStringField;
    DataProveedorFinal: TWideStringField;
    DataReferenciasPedidos: TBooleanField;
    MovimientoAuxTable: TnxeTable;
    TipoMovimientoCtrl: TcxDBRadioGroup;
    DataTipoMovimiento: TSmallintField;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label8: TcxLabel;
    destinoOrigenLabel: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    DocInicialLabel: TcxLabel;
    Label1: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    MovimientoOrigenTable: TnxeTable;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure ExaminarButtonClick(Sender: TObject);
    procedure PathCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ProcesoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure DestinoOrigenCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure DireccionCorreoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure DireccionCorreoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure DireccionCorreoCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure FormatoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SituacionCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure TipoMovimientoCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);

  private

    MovimientoFields,
    MovimientoAuxFields,
    MovimientoOrigenFields : TMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;
    FacturaComprasFields : TFacturaComprasFields;
    EfectoFields : TEfectoFields;
    ArticuloFields : TArticuloFields;
    DsDireccionCorreoFields : TDireccionCorreoFields;

    ExternProveedorFields : TProveedorFields;
    ExternMovimientoFields : TMovimientoFields;
    ExternLineaMovimientoFields : TLineaMovimientoFields;
    ExternFacturaComprasFields : TFacturaComprasFields;
    ExternEfectoFields : TEfectoFields;
    ExternArticuloFields : TArticuloFields;

    MovimientoText,
    LineaMovimientoText : Text;

    StrDataPath  : string;
    SaveDecimalSeparator : Char;

    procedure ActualizaEstadoComponentes;

  public
    procedure ExecuteProcess;
    procedure AbreFicherosExternos( Exportar : Boolean );
    procedure CierraFicherosExternos( Exportar : Boolean );
    procedure ImportaDatos;
    procedure DoOnAcceptMessage;
  end;

var  BoxEmcForm: TBoxEmcForm = nil;

procedure ExportImportMovimientosCompra;

implementation

{$R *.DFM}

uses   Variants,
       Files,
       FileCtrl,
       DateUtils,
       LibUtils,
       AppManager,

       EnterpriseDataAccess,
       SessionDataAccess,

       Gdm30Frm,

       dmi_iex,
       dmi_mov,

       dm_iex,
       dm_sto,
       dm_mov,
       dm_ddc,
       dm_art,
       dm_pro,
       dm_fdc,

       a_ddc,

       b_msg,
       b_pro,
       b_dir,

       cx_ddc,
       cx_pro,

       f_prg;

resourceString
  RsMsg1   = 'Error creando los ficheros de exportación.';
  RsMsg2   = 'Exportación de movimientos de compra';
  RsMsg3   = 'Grabando datos en los ficheros ...';
  RsMsg4   = 'Copiando datos en [%s].';
  RsMsg5   = 'Importación de movimientos de compra';
  RsMsg6   = 'Leyendo datos desde [%s].';
  RsMsg7   = 'Importando datos desde los ficheros ...';
  RsMsg8   = '¿Desea conservar los ficheros que acaba de importar?';
  RsMsg9   = 'Los ficheros no pertenecen al mismo ejercicio.';
  RsMsg10  = 'Se cancela el proceso de importación.';
  RsMsg11  = 'Se ha interrumpido el proceso de exportacion/importación.';
  RsMsg12  = 'Es conveniente que revise el contenido de sus ficheros.';
  RsMsg13  = 'Suprimiendo ficheros ...';
  RsMsg14  = 'El documento %s %s %d ya existe. No puede ser importado.';
  RsMsg15  = 'Indique si desea cancelar ahora el proceso de importación.' + #13 + 'Si finaliza el proceso no se registrará ningún cambio en sus ficheros.';
  RsMsg16  = 'El documento %s %s %d ya existe. No ha sido importado.';
  RsMsg17  = 'Se cancela el proceso.';
  RsMsg18  = 'Fecha %s';
  RsMsg20  = 'albarán';
  RsMsg21  = 'factura';
  RsMsg22  = 'Destino';
  RsMsg23  = 'Origen';
  RsMsg24  = 'El albarán % s %s %d no tiene lineas.';
  RsMsg25  = 'El albarán % s %s %d no es del tipo esperado (Compra).';
  RsMsg26  = 'oferta';
  RsMsg27  = 'pedido';

const

  ListaFicherosTexto  : TStringArray = [ 'Movimiento.txt',
                                         'LineaMovimiento.txt' ];

  // No intentar simplificar utilizando arrays dinámicos. Se producen errores de memoria difíciles de corregir.

  ListaFicherosAlbaran : TStringArray = [ 'Proveedor.nx1',
                                          'Articulo.nx1',
                                          'Movimiento.nx1',
                                          'LineaMovimiento.nx1',
                                          'FacturaCompras.nx1',
                                          'Efecto.nx1' ];

  // Vale para pedidos y ofertas

  ListaFicherosPedidoOferta : TStringArray = [ 'Proveedor.nx1',
                                               'Articulo.nx1',
                                               'Movimiento.nx1',
                                               'LineaMovimiento.nx1' ];

procedure ExportImportMovimientosCompra;
begin
     CreateEditForm( TBoxEmcForm, BoxEmcForm, TGds30Frm.ComprasSection, True );
end;

procedure TBoxEmcForm.FechaCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                   var DisplayValue : Variant;
                                                   var ErrorText    : TCaption;
                                                   var Error        : Boolean );
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TBoxEmcForm.FormatoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With FormatoCtrl do
       begin
       If   ItemIndex=1
       then DataDestinoOrigen.Value := 0;  // Solo fichero
       ActualizaEstadoComponentes;
       end;
end;

procedure TBoxEmcForm.FormManagerInitializeForm;
begin

     CloseWindowWhenFocusLost := True;

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     MovimientoAuxFields := TMovimientoFields.Create( MovimientoAuxTable );
     MovimientoOrigenFields := TMovimientoFields.Create( MovimientoOrigenTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
     ArticuloFields := TArticuloFields.Create( ArticuloTable );
     FacturaComprasFields := TFacturaComprasFields.Create( FacturaComprasTable );
     EfectoFields := TEfectoFields.Create( EfectoTable );

     DsDireccionCorreoFields := TDireccionCorreoFields.Create( Self );

     DataFormato.Value := 0;
     DataProceso.Value := 0;
     DataDestinoOrigen.Value := 0;
     DataTipoMovimiento.Value := tmCompra;
     DataSituacion.Value := 0;
     DataFechaInicial.Value := ApplicationContainer.FirstDayOfYearDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataProveedorFinal.Value := HighStrCode;
     DataReferenciasPedidos.Value := False;

end;

procedure TBoxEmcForm.FormManagerOkButton;

var  HeaderMsg : String;

begin
     case DataProceso.Value of
         0 : HeaderMsg := RsMsg2;
         1 : HeaderMsg := RsMsg5;
         end;
     CreateProcessForm( ExecuteProcess, HeaderMsg );
end;

procedure TBoxEmcForm.ExaminarButtonClick(Sender: TObject);
begin
     SelectDirectory( DataPath );
end;

procedure TBoxEmcForm.AbreFicherosExternos( Exportar : Boolean );
begin

     With ExportImport do
       case DataFormato.Value of
         0 : begin
             AbreFicherosExternos( [ ExternProveedorTable,
                                     ExternMovimientoTable,
                                     ExternLineaMovimientoTable,
                                     ExternArticuloTable ], Exportar );

             ExternProveedorFields := TProveedorFields.Create( ExternProveedorTable );
             ExternMovimientoFields := TMovimientoFields.Create( ExternMovimientoTable );
             ExternLineaMovimientoFields := TLineaMovimientoFields.Create( ExternLineaMovimientoTable );
             ExternArticuloFields := TArticuloFields.Create( ExternArticuloTable );

             If   DataTipoMovimiento.Value=tmCompra
             then begin
                  AbreFicherosExternos( [ ExternFacturaComprasTable, ExternEfectoTable ], Exportar );

                  ExternFacturaComprasFields := TFacturaComprasFields.Create( ExternFacturaComprasTable );
                  ExternEfectoFields := TEfectoFields.Create( ExternEfectoTable );
                  end;

             end;
         1 : begin
             AbreFicheroTextoExterno( MovimientoText, AddPathDelim( DataPath.Value ) + 'Movimiento.txt', Exportar );
             AbreFicheroTextoExterno( LineaMovimientoText, AddPathDelim( DataPath.Value ) + 'LineaMovimiento.txt', Exportar );
             end;
         end;
end;

procedure TBoxEmcForm.CierraFicherosExternos( Exportar : Boolean );
begin
     With ExportImport do
       case DataFormato.Value of
         0 : begin
             ExternProveedorTable.Close;
             ExternMovimientoTable.Close;
             ExternLineaMovimientoTable.Close;
             ExternArticuloTable.Close;
             If   DataTipoMovimiento.Value=tmCompra
             then begin
                  ExternFacturaComprasTable.Close;
                  ExternEfectoTable.Close;
                  end;
             end;

         1 : begin
             CloseFile( MovimientoText  );
             CloseFile( LineaMovimientoText );
             end;
         end;
end;

procedure TBoxEmcForm.ExecuteProcess;

function ObtenTipoDatosExportados( TipoMovimiento : TTipoMovimientoCompra ) : TTipoDatosExportados;
begin
     case DataTipoMovimiento.Value of
       tmOferta :
         Result := tdOferta;
       tmPedidoCompra :
         Result := tdPedidoCompras;
       tmCompra :
         Result := tdAlbaranCompras
       end;
end;

procedure ExportarMovimientos;

var  Procesar : Boolean;

procedure ProcesaFactura;
begin

     ExternFacturaComprasTable.CopyAndAppendRecord( FacturaComprasTable );

     If   ProveedorTable.FindKey( [ FacturaComprasFields.Proveedor.Value ] )
     then ExternProveedorTable.CopyAndAppendRecord( ProveedorTable, False );

     With EfectoTable do
       begin

       With FacturaComprasFields do
         SetRange( [ Ejercicio.Value, scCompras, Proveedor.Value, SerieNroFactura.Value, 0, 0 ],
                   [ Ejercicio.Value, scCompras, Proveedor.Value, SerieNroFactura.Value, 0, MaxSmallint ] );
       First;
       While not Eof do
         begin
         ExternEfectoTable.CopyAndAppendRecord( EfectoTable );
         Next;
         end;

       end;

     With MovimientoAuxTable do
       begin

       With FacturaComprasFields do
         SetRange( [ tmCompra, Ejercicio.Value, Proveedor.Value, SerieNroFactura.Value, 0 ],
                   [ tmCompra, Ejercicio.Value, Proveedor.Value, SerieNroFactura.Value, 0 ] );
       First;
       While not Eof do
         begin

         ExternMovimientoTable.CopyAndAppendRecord( MovimientoAuxTable );

         With LineaMovimientoTable do
           begin

           With MovimientoAuxFields do
             SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

           First;
           While not Eof do
             begin

             If   ArticuloTable.FindKey( [ LineaMovimientoFields.CodigoArticulo.Value ] )
             then ExternArticuloTable.CopyAndAppendRecord( ArticuloTable, False );

             ProcessFrame.AddRecordMsg( StrFormatDate( MovimientoAuxFields.Fecha.Value, dfDefault ) + ' , ' +
                                        StrInt( MovimientoAuxFields.NroOperacion.Value ) + ' , ' +
                                        StrInt( LineaMovimientoFields.NroRegistro.Value ) );

             ExternLineaMovimientoTable.Append;

             ExternLineaMovimientoTable.CopyFields( LineaMovimientoTable );

             If   not DataReferenciasPedidos.Value
             then With ExternLineaMovimientoFields do
                    begin
                    TipoMovimientoOrigen.Clear;
                    EjercicioOrigen.Clear;
                    NroOperacionOrigen.Clear;
                    NroRegistroOrigen.Clear;
                    end;

             ExternLineaMovimientoTable.Post;

             Next;
             end;

           end;

         Next;
         end;

       end;

     ExportImport.RecordProcessed := True;
end;

procedure ProcesaMovimiento;
begin
     If   ( MovimientoFields.TipoMovimiento.Value=tmCompra ) and  not ValueIsEmpty( MovimientoFields.NroFactura.Value )
     then With FacturaComprasTable, MovimientoFields do
            begin
            IndexFieldNames := 'Ejercicio;Proveedor;SerieNroFactura';
            If   not  ExternFacturaComprasTable.FindKey( [ Ejercicio.Value, Propietario.Value, SerieFactura.Value ] )
            then If   FindKey( [ Ejercicio.Value, Propietario.Value, SerieFactura.Value ] )
                 then ProcesaFactura;
            Exit;
            end;

     If   ProveedorTable.FindKey( [ MovimientoFields.Propietario.Value ] )
     then ExternProveedorTable.CopyAndAppendRecord( ProveedorTable, False );

     ExternMovimientoTable.CopyAndAppendRecord( MovimientoTable );

     With LineaMovimientoTable do
       begin

       With MovimientoFields do
         SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ],  [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

       First;
       While not Eof do
         begin

         If   ArticuloTable.FindKey( [ LineaMovimientoFields.CodigoArticulo.Value ] )
         then ExternArticuloTable.CopyAndAppendRecord( ArticuloTable, False );

         ProcessFrame.AddRecordMsg( StrFormatDate( MovimientoFields.Fecha.Value, dfDefault ) + ' , ' +
                                    StrInt( MovimientoFields.NroOperacion.Value ) + ' , ' +
                                    StrInt( LineaMovimientoFields.NroRegistro.Value ) );

         ExternLineaMovimientoTable.Append;

         ExternLineaMovimientoTable.CopyFields( LineaMovimientoTable );

         //** 29.11.2016  Coloco en los campos libres algunos datos del documento origen

         case MovimientoFields.TipoMovimiento.Value of
           tmPedidoCompra  : If   LineaMovimientoFields.NroOperacionOrigen.Value<>0
                             then If   MovimientoOrigenTable.FindKey( [ LineaMovimientoFields.EjercicioOrigen.Value, LineaMovimientoFields.NroOperacionOrigen.Value ] )
                                  then begin
                                       ExternLineaMovimientoFields.CampoLibre1.Value := MovimientoOrigenFields.Propietario.Value;
                                       ExternLineaMovimientoFields.CampoLibre3.Value := MovimientoOrigenFields.FechaAplicacion.Value;
                                       end;

           tmCompra         : If   not DataReferenciasPedidos.Value
                              then With ExternLineaMovimientoFields do
                                     begin
                                     TipoMovimientoOrigen.Clear;
                                     EjercicioOrigen.Clear;
                                     NroOperacionOrigen.Clear;
                                     NroRegistroOrigen.Clear;
                                     end;
           end;

         ExternLineaMovimientoTable.Post;

         Next;
         end;

       end;


     ExportImport.RecordProcessed := True;
end;

procedure ProcesaMovimientoTexto;
begin

     WriteLn( MovimientoText, ExportImport.ExportRecordToText( MovimientoTable ) );

     With LineaMovimientoTable do
       begin

       With MovimientoFields do
         SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

       First;
       While not Eof do
         begin

         try
           If   ( MovimientoFields.TipoMovimiento.Value=tmCompra ) and not DataReferenciasPedidos.Value
           then begin
                LineaMovimientoTable.Edit;
                With LineaMovimientoFields do
                  begin
                  TipoMovimientoOrigen.Clear;
                  EjercicioOrigen.Clear;
                  NroOperacionOrigen.Clear;
                  NroRegistroOrigen.Clear;
                  end;
                end;

           WriteLn( LineaMovimientoText, ExportImport.ExportRecordToText( LineaMovimientoTable ) );

         finally
           LineaMovimientoTable.Cancel;
           end;

         ProcessFrame.AddRecordMsg( StrFormatDate( MovimientoFields.Fecha.Value, dfDefault ) + ' , ' +
                                   StrInt( MovimientoFields.NroOperacion.Value ) + ' , ' +
                                   StrInt( LineaMovimientoFields.NroRegistro.Value ) );


         Next;
         end;

       end;

     ExportImport.RecordProcessed := True;

end;

procedure InsertaParametros;
begin
     With ExportImport do
       begin
       HeaderList.Values[ RsCodigoEmpresa ] := CodigoEmpresaActual;
       HeaderList.Values[ RsNombreEmpresa ] := ApplicationContainer.Empresa_Nombre;
       HeaderList.Values[ RsTipoDeDatos ] := Movimiento.TextoTipoMovimiento( DataTipoMovimiento.Value, True, True );
       HeaderList.Values[ RsFormato ] := FormatoCtrl.Text;
       HeaderList.Values[ RsSituacion ] := SituacionCtrl.Text;
       HeaderList.Values[ RsFechaInicial ] := StrFormatDate( FechaInicialCtrl.EditValue );
       HeaderList.Values[ RsFechaFinal ] := StrFormatDate( FechaFinalCtrl.EditValue );
       HeaderList.Values[ RsCodigoProveedorInicial ] := ProveedorInicialCtrl.EditValue;
       HeaderList.Values[ RsCodigoProveedorFinal ] := ProveedorFinalCtrl.EditValue;
       If   ReferenciasPedidosCtrl.Enabled
       then HeaderList.Values[ RsMantenerReferenciasAPedidos ] := StrBoolean( ReferenciasPedidosCtrl.Checked );
       end;
end;

var  CompressedFile : String;

begin

     With ProcessFrame do
       begin

       try

         ExportImport.CleanExportDir;

         AbreFicherosExternos( True );

         try

           AddMsg( ntInformation, RsMsg3 );

           // Albaranes
           // Gestwin  : <Todos>,No facturables,Facturables,Pendientes de facturar (todos),Pendientes de facturar (facturables),Facturados,Pendientes de contabilizar,Contabilizados
           // Texto    : <Todos>,No facturables,Pendientes de facturar

           If   ( DataTipoMovimiento.Value=tmCompra ) and ( DataSituacion.Value in [ 5..7 ] )  // 5 = Facturados, 6 = Pendientes de contabilizar, 7 = Contabilizados
           then With FacturaComprasTable do
                  begin

                  IndexFieldNames := 'Proveedor;Fecha';

                  SetRange( [ DataProveedorInicial.Value, DataFechaInicial.Value ],
                            [ DataProveedorFinal.Value, DataFechaFinal.Value ] );

                  First;
                  While not Eof and not Canceled do
                    begin

                    case DataSituacion.Value of
                      5 : Procesar := True;
                      6 : Procesar := not FacturaComprasFields.Traspasada.Value;
                      7 : Procesar := FacturaComprasFields.Traspasada.Value;
                      end;

                    If   Procesar
                    then ProcesaFactura;

                    Next;
                    end;

                  end
           else  With MovimientoTable do
                   begin

                   IndexFieldNames := 'TipoMovimiento;Propietario;Fecha';
                   FacturaComprasTable.IndexFieldNames := 'Ejercicio;Proveedor;SerieNroFactura';

                   SetRange( [ DataTipoMovimiento.Value, DataProveedorInicial.Value, DataFechaInicial.Value ],
                             [ DataTipoMovimiento.Value, DataProveedorFinal.Value, DataFechaFinal.Value ] );
                   First;
                   While not Eof and not Canceled do
                     begin

                     Procesar := True;

                     With MovimientoFields do
                       case DataTipoMovimiento.Value of
                       tmOferta       : case DataSituacion.Value of
                                          1 : Procesar := not Revisado.Value;
                                          2 : Procesar := Revisado.Value;
                                          end;

                       tmPedidoCompra : case DataSituacion.Value of
                                          1 : Procesar := Situacion.Value=0;
                                          2 : Procesar := Situacion.Value in [ 0, 1 ];
                                          3 : Procesar := Situacion.Value=1;
                                          4 : Procesar := Situacion.Value=2;
                                          end;

                       tmCompra       : case DataSituacion.Value of
                                          1 : Procesar := NoFacturar.Value;
                                          2 : Procesar := not NoFacturar.Value;
                                          3 : Procesar := not Facturado.Value;
                                          4 : Procesar := not Facturado.Value and not NoFacturar.Value;
                                          5 : Procesar := Facturado.Value;
                                          6 : Procesar := not Traspasado.Value;
                                          7 : Procesar := Traspasado.Value;
                                          end;
                       end;

                     If   Procesar
                     then If   DataFormato.Value=0
                          then ProcesaMovimiento
                          else ProcesaMovimientoTexto;

                     Next;
                     end;

                   end;


         finally
           CierraFicherosExternos( True );
           end;

         If   not Canceled
         then With ExportImport do
                begin

                case DataDestinoOrigen.Value of
                  0 : If   DataFormato.Value=0
                      then begin
                           If   DataTipoMovimiento.Value=tmCompra
                           then CompressAndCopyFiles( ListaFicherosAlbaran, SessionDataModule.ExportsDatabase.Path, StrDataPath, True )
                           else CompressAndCopyFiles( ListaFicherosPedidoOferta, SessionDataModule.ExportsDatabase.Path, StrDataPath, True );
                           SetBackupInfo( StrDataPath, tdAlbaranCompras, True );
                           end;

                  1 : begin

                      InsertaParametros;

                      If   DataFormato.Value=0
                      then begin
                           If   DataTipoMovimiento.Value=tmCompra
                           then CompressedFile := SMTPCompressFiles( ListaFicherosAlbaran, [], SessionDataModule.ExportsDatabase.Path )
                           else CompressedFile := SMTPCompressFiles( ListaFicherosPedidoOferta, [], SessionDataModule.ExportsDatabase.Path );
                           end
                      else CompressedFile := SMTPCompressFiles( ListaFicherosTexto, [], DataPath.Value );

                      SMTPInitDataPacket( ObtenTipoDatosExportados( DataTipoMovimiento.Value ), DsDireccionCorreoFields, [ CompressedFile ], True );
                      SMTPSend;

                      end;
                  end;

                end;

       except on E : Exception do
         AddMsg( ntError, RsMsg11 + #13 + RsMsg12 );
         end;

       end;

end;

procedure ImportarMovimientos;
begin

     With ProcessFrame, ExportImport do
       begin

       try

         ExportImport.CleanImportDir;

         case DataDestinoOrigen.Value of
           0 : begin
               If   DataFormato.Value=0
               then begin
                    CompruebaDisco( StrDataPath, 0, True );
                    If   SetBackupInfo( StrDataPath, tdAlbaranCompras, False )
                    then begin
                         If   DataTipoMovimiento.Value=tmCompra
                         then DeCompressAndCopyFiles( StrDataPath, ListaFicherosAlbaran )
                         else DeCompressAndCopyFiles( StrDataPath, ListaFicherosPedidoOferta );
                         end
                    else Exit;
                    end;
               ImportaDatos;
               end;

           1 : POP3Init( ObtenTipoDatosExportados( DataTipoMovimiento.Value ), 0, DoOnAcceptMessage );
           end;

       except on E : Exception do
         AddMsg( ntError, RsMsg11 + #13 + RsMsg12 );
         end;

       end;

end;

begin
     StrDataPath := AddPathDelim( DataPath.Value );

     try
       SaveDecimalSeparator := FormatSettings.DecimalSeparator;
       If   DataFormato.Value=1
       then FormatSettings.DecimalSeparator := '.';

       case DataProceso.Value of
         0 : ExportarMovimientos;
         1 : ImportarMovimientos;
         end;

     finally
       FormatSettings.DecimalSeparator := SaveDecimalSeparator;
       end;
end;

procedure TBoxEmcForm.ImportaDatos;

var  AvisoCancelacion : Boolean;

procedure ProcesaMovimiento;

var  NroOperacionExterna : LongInt;

begin

     NroOperacionExterna := ExternMovimientoFields.NroOperacion.Value;

     With MovimientoTable do
       begin

       If   ExternProveedorTable.FindKey( [ ExternMovimientoFields.Propietario.Value ] )
       then ProveedorTable.CopyAndAppendRecord( ExternProveedorTable, False );

       With ExternMovimientoFields do
         If   FindKey( [ DataTipoMovimiento.Value, Ejercicio.Value, Propietario.Value, Serie.Value, NroDocumento.Value ] )
         then begin
              If   not AvisoCancelacion
              then begin
                   If   ShowNotification( ntAcceptCancel, Format( RsMsg14, [ Propietario.Value, Serie.Value, NroDocumento.Value ] ), '' )=mrCancel
                   then begin
                        ProcessFrame.Canceled := True;
                        Abort;
                        end;
                   AvisoCancelacion := True;
                   end;
              ProcessFrame.AddMsg( ntWarning, Format( RsMsg16, [ Propietario.Value, Serie.Value, NroDocumento.Value ] ) );
              end
         else begin

              Append;
              CopyFields( ExternMovimientoTable );
              MovimientoFields.NroOperacion.Value := Movimiento.ProximaOperacion;
              Post;

              If   ( DataTipoMovimiento.Value=tmCompra ) and not ValueIsEmpty( MovimientoFields.NroFactura.Value )
              then If   ExternFacturaComprasTable.FindKey( [ Ejercicio.Value, Propietario.Value, SerieFactura.Value, NroFactura.Value ] )
                   then begin

                        CompruebaEjercicio( ExternFacturaComprasFields.Fecha.Value );

                        FacturaComprasTable.CopyAndAppendRecord( ExternFacturaComprasTable, False );

                        With ExternEfectoTable do
                          begin
                          With FacturaComprasFields do
                            SetRange( [ Ejercicio.Value, scCompras, Proveedor.Value, Serie.Value, NroFactura.Value, 0 ],
                                      [ Ejercicio.Value, scCompras, Proveedor.Value, Serie.Value, NroFactura.Value, MaxSmallint ] );
                          First;
                          While not Eof do
                            begin
                            EfectoTable.CopyAndAppendRecord( ExternEfectoTable, False );
                            Next;
                            end;

                          end;

                        end;

              With ExternLineaMovimientoTable do
                begin

                SetRange( [ MovimientoFields.Ejercicio.Value, NroOperacionExterna, 0, 1 ], [ MovimientoFields.Ejercicio.Value, NroOperacionExterna, MaxSmallint, MaxSmallint ] );

                First;
                While not Eof do
                  begin

                  If   ExternArticuloTable.FindKey( [ ExternLineaMovimientoFields.CodigoArticulo.Value ] )
                  then ArticuloTable.CopyAndAppendRecord( ExternArticuloTable, False );

                  ProcessFrame.AddRecordMsg( StrFormatDate( MovimientoFields.Fecha.Value, dfDefault ) + ' , ' +
                                            StrInt( MovimientoFields.NroOperacion.Value ) + ' , ' +
                                            StrInt( LineaMovimientoFields.NroRegistro.Value ) );

                  LineaMovimientoTable.Append;
                  LineaMovimientoTable.CopyFields( ExternLineaMovimientoTable );
                  LineaMovimientoFields.NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                  LineaMovimientoFields.NroRegistro.Clear;

                  StockAlmacen.ActualizaStock( MovimientoFields, LineaMovimientoFields, False );

                  LineaMovimientoTable.Post;

                  Next;
                  end;

                end;

              end;
       end;

end;

procedure CompruebaEjercicio( Fecha : TDateTime );
begin
     If   not EjercicioActual( Fecha )
     then begin
          ProcessFrame.AddMsg( ntError, RsMsg9 + #13 + RsMsg10 );
          Abort;
          end;
end;

procedure ImportaMovimientosTexto;

var  TieneLineas,
     LineaDelProximoMovimiento : Boolean;
     ImporteNetoAlbaran : Decimal;
     NroOperacionOriginal : LongInt;

     TotalImporteBruto,
     TotalDescuentosArticulos,
     TotalImporteNeto : Decimal;

begin

     LineaDelProximoMovimiento := False;

     While not Eof( MovimientoText ) and not ProcessFrame.Canceled do
       begin

       If   ExportImport.ImportRecordFromText( MovimientoText, MovimientoTable )
       then begin

            If   EjercicioActual( MovimientoFields.Ejercicio.Value )
            then begin
                 ProcessFrame.AddMsg( ntError, RsMsg9 );
                 Abort;
                 end
            else If   MovimientoFields.TipoMovimiento.Value<>DataTipoMovimiento.Value
                 then begin
                      With MovimientoFields do
                        ProcessFrame.AddMsg( ntError, Format( RsMsg25, [ Serie.Value, NroDocumento.Value ] ) );
                      Abort;
                      end;

            With MovimientoFields do
              begin

              NroOperacionOriginal := NroOperacion.Value;
              EjercicioFactura.Clear;
              PropietarioFactura.Clear;
              SerieFactura.Clear;
              NroFactura.Clear;
              Facturado.Value := False;
              Traspasado.Value := False;
              Origen.Value := omManual;

              If   MovimientoAuxTable.FindKey( [ DataTipoMovimiento.Value, Ejercicio.Value, Propietario.Value, Serie.Value, NroDocumento.Value ] )
              then begin
                   ShowNotification( ntError, Format( RsMsg14, [ Propietario.Value, Serie.Value, NroDocumento.Value ] ), RsMsg17 );
                   ProcessFrame.AddMsg( ntError, Format( RsMsg14, [ Propietario.Value, Serie.Value, NroDocumento.Value ] ) );
                   Abort;
                   end
              else begin

                   NroOperacion.Value := Movimiento.ProximaOperacion;

                   TieneLineas := False;

                   repeat

                     If   not LineaDelProximoMovimiento
                     then ExportImport.ImportRecordFromText( LineaMovimientoText, LineaMovimientoTable );

                     LineaDelProximoMovimiento := False;

                     If   ( LineaMovimientoFields.Ejercicio.Value=MovimientoFields.Ejercicio.Value ) and
                          ( LineaMovimientoFields.NroOperacion.Value=NroOperacionOriginal )
                     then begin
                          TieneLineas := True;
                          LineaMovimientoFields.NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                          LineaMovimientoFields.NroRegistro.Clear;

                          Articulo.Obten( LineaMovimientoFields.CodigoArticulo.Value, ArticuloFields );

                          FacturaCompras.CalculaImportes( LineaMovimientoFields, ArticuloFields );

                          StockAlmacen.ActualizaStock( MovimientoFields, LineaMovimientoFields, False );

                          LineaMovimientoTable.Post;

                          ProcessFrame.AddRecordMsg( StrFormatDate( MovimientoFields.Fecha.Value, dfDefault ) + ' , ' +
                                                    StrInt( MovimientoFields.NroOperacion.Value ) + ' , ' +
                                                    StrInt( LineaMovimientoFields.NroRegistro.Value ) );
                          end
                     else LineaDelProximoMovimiento := True;

                   until Eof( LineaMovimientoText ) or LineaDelProximoMovimiento;

                   If   TieneLineas
                   then With MovimientoFields do
                          begin
                          Movimiento.ObtenImporteMovimiento( Ejercicio.Value,
                                                             NroOperacion.Value,
                                                             TotalImporteBruto,
                                                             TotalDescuentosArticulos,
                                                             TotalImporteNeto );
                          ImporteNetoAlbaran := TotalImporteNeto;
                          MovimientoTable.Post;
                          end
                   else begin
                        With MovimientoFields do
                          ProcessFrame.AddMsg( ntError, Format( RsMsg24, [ Propietario.Value, Serie.Value, NroDocumento.Value ] ) );
                        Abort;
                        end;

                   end;
              end;

            end;

       end;

end;

begin

     AbreFicherosExternos( False );

     With ProcessFrame, ExportImport do
       begin

       try

         EnterpriseDataModule.StartTransaction( [ MovimientoTable,
                                                  LineaMovimientoTable ] );

         // Los stocks no están incluidos en la transacción por estar en el servidor. Se pueden producir inconsistencias en el fichero de stocks si se produce un error durante la importación.


         AddMsg( ntInformation, RsMsg7 );

         MovimientoTable.IndexFieldNames:= 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento';
         MovimientoAuxTable.IndexFieldNames:= 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento';

         If   DataFormato.Value=0
         then With ExternMovimientoTable do
                begin
                First;
                If   not Eof
                then begin

                     // Los albaranes facturados pueden pertenecer a otro ejercicio

                     If   not ExternMovimientoFields.Facturado.Value
                     then CompruebaEjercicio( ExternMovimientoFields.Fecha.Value );

                     While not Eof and not Canceled do
                       begin
                       ProcesaMovimiento;
                       Next;
                       end;
                     end;
                end
         else ImportaMovimientosTexto;

         If   Canceled
         then Abort
         else EnterpriseDataModule.Commit;

       except on e : Exception do begin
                                  EnterpriseDataModule.RollBack;
                                  ShowException( E, Self );
                                  ProcessFrame.AddMsg( ntError, rsgMsg120 );
                                  end;
         end;

       CierraFicherosExternos( False );

       If   not Canceled and not Error
       then If   DataDestinoOrigen.Value=0
            then If   ShowNotification( ntQuestion, RsMsg8, '' )=mrNo
                 then begin
                      AddMsg( ntInformation, RsMsg13 );
                      case DataFormato.Value of
                        0 : If   DataTipoMovimiento.Value=tmVenta
                            then EraseListOfFiles( StrDataPath, [ BackupFileName, BackupInfoFileName, ListaFicherosAlbaran[ 0 ], ListaFicherosAlbaran[ 1 ], ListaFicherosAlbaran[ 2 ], ListaFicherosAlbaran[ 3 ], ListaFicherosAlbaran[ 4 ], ListaFicherosAlbaran[ 5 ] ], False )
                            else EraseListOfFiles( StrDataPath, [ BackupFileName, BackupInfoFileName, ListaFicherosPedidoOferta[ 0 ], ListaFicherosPedidoOferta[ 1 ], ListaFicherosPedidoOferta[ 2 ], ListaFicherosPedidoOferta[ 3 ] ], False );
                        1 : EraseListOfFiles( StrDataPath, ListaFicherosTexto, False );
                        end;
                      end;
       end;

end;

procedure TBoxEmcForm.DoOnAcceptMessage;
begin
     With ExportImport do
       If   DataTipoMovimiento.Value=tmCompra
       then DeCompressFiles( SessionDataModule.GetImportDirectory, ListaFicherosAlbaran )
       else DeCompressFiles( SessionDataModule.GetImportDirectory, ListaFicherosPedidoOferta );
     ImportaDatos;
end;

procedure TBoxEmcForm.PathCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ValueIsEmpty( DisplayValue )
     then If   not DirectoryExists( DisplayValue )
          then begin
               Error := True;
               ErrorText := JoinMessage( rsgMsg394, rsgMsg395 );
               end;
end;

procedure TBoxEmcForm.ProcesoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ActualizaEstadoComponentes;
end;

procedure TBoxEmcForm.ActualizaEstadoComponentes;
begin
     With ProcesoCtrl do
      begin

      SituacionCtrl.Enabled := ( ItemIndex=0 ) and ( DataFormato.Value=0 );
      FechaInicialCtrl.Enabled := ItemIndex=0;
      FechaFinalCtrl.Enabled := ItemIndex=0;
      ProveedorInicialCtrl.Enabled := ItemIndex=0;
      ProveedorFinalCtrl.Enabled := ItemIndex=0;

      With DestinoOrigenLabel do
       case ItemIndex of
         0 : Caption := RsMsg22;
         1 : Caption := RsMsg23;
         end;

      DestinoOrigenCtrl.Enabled := FormatoCtrl.ItemIndex=0;

      DireccionCorreoCtrl.Enabled := ( ItemIndex=0 ) and ( DataDestinoOrigen.Value=1 );
      end;

     If   not VarIsNull( TipoMovimientoCtrl.EditValue )
     then begin
          With SituacionCtrl.Properties.Items do
            case TipoMovimientoCtrl.EditValue of
              tmOferta       : CommaText := RsMsgSituacionOfertas;
              tmPedidoCompra : CommaText := RsMsgSituacionPedidosCompra;
              tmCompra       : If   DataFormato.Value=0
                               then CommaText := RsMsgSituacionAlbaranes
                               else CommaText := RsMsgSituacionAlbaranesB;
              end;
          SituacionCtrl.PostEditValue( 0 );
          ReferenciasPedidosCtrl.Enabled := ( ProcesoCtrl.EditValue=0 ) and ( TipoMovimientoCtrl.EditValue=tmCompra );
          end;

end;

procedure TBoxEmcForm.ProveedorCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TBoxEmcForm.ProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TBoxEmcForm.SituacionCtrlPropertiesEditValueChanged(Sender: TObject);

var  StrDoc : String;

begin
     With TipoMovimientoCtrl do
       If   not ValueIsEmpty( EditValue )
       then begin
            case EditValue of
              tmOferta       : StrDoc := RsMsg26;
              tmPedidoCompra : StrDoc := RsMsg27;
              tmCompra       : case SituacionCtrl.EditValue of
                                 0..2 : StrDoc := RsMsg20;
                                 3..5 : StrDoc := RsMsg21;
                                 end;
              end;
            DocInicialLabel.Caption := Format( RsMsg18, [ StrDoc ] );
            end;
end;

procedure TBoxEmcForm.TipoMovimientoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ActualizaEstadoComponentes;
end;

procedure TBoxEmcForm.DestinoOrigenCtrlPropertiesEditValueChanged( Sender: TObject);
begin
     With DestinoOrigenCtrl do
       begin
       PathCtrl.Enabled := EditValue=0;
       ExaminarButton.Enabled := EditValue=0;
       DireccionCorreoCtrl.Enabled := ( DataProceso.Value=0 ) and ( EditValue=1 );
       end;
end;

procedure TBoxEmcForm.DireccionCorreoCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntDireccionesCorreo( [ Sender.EditingValue ] );
end;

procedure TBoxEmcForm.DireccionCorreoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaDireccionesCorreo( Sender );
end;

procedure TBoxEmcForm.DireccionCorreoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     DireccionCorreo.Valida( Sender, tdAmbos, DisplayValue, ErrorText, Error, DsDireccionCorreoFields );
end;

end.

