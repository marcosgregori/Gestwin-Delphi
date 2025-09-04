
unit b_emv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask, 

  AppContainer,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxPC, cxControls, cxGraphics, nxdb, cxGroupBox,
  cxRadioGroup, cxDBEdit, cxMaskEdit, cxDropDownEdit, cxIndexedComboBox,
  cxContainer, cxEdit, cxTextEdit, cxCalendar,
  dxSkinsCore, dxSkinsDefaultPainters, cxLookAndFeels, cxLabel, cxCheckBox,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,

  dmi_iex,
  dmi_mov, dxUIAClasses;

type
  TBoxEmvForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    ClienteTable: TnxeTable;
    FormManager: TgxFormManager;
    MovimientoTable: TnxeTable;
    LineaMovimientoTable: TnxeTable;
    PathCtrl: TcxDBTextEdit;
    ExaminarButton: TgBitBtn;
    FormatoCtrl: TcxDBIndexedComboBox;
    ExternClienteTable: TnxeTable;
    ExternMovimientoTable: TnxeTable;
    ExternLineaMovimientoTable: TnxeTable;
    ExternFacturaVentasTable: TnxeTable;
    FacturaVentasTable: TnxeTable;
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
    Shape1: TShape;
    DataSituacion: TSmallintField;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataReferenciasPedidos: TBooleanField;
    MovimientoAuxTable: TnxeTable;
    TipoMovimientoCtrl: TcxDBRadioGroup;
    DataTipoMovimiento: TSmallintField;
    DataTodasLasSeries: TBooleanField;
    DataSerie: TWideStringField;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label8: TcxLabel;
    destinoOrigenLabel: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label7: TcxLabel;
    GrupoLineaMovimientoTable: TnxeTable;
    ExternGrupoLineaMovimientoTable: TnxeTable;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    OpcionesExportacionPanel: TcxGroupBox;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    ReferenciasPedidosCtrl: TcxDBCheckBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    SituacionCtrl: TcxDBIndexedComboBox;
    SerieCtrl: TcxDBTextEdit;
    TodasLasSeriesCtrl: TcxDBCheckBox;
    DocInicialLabel: TcxLabel;
    Label1: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    CaptionSerieLabel: TcxLabel;
    DescSerieLabel: TcxLabel;
    RenumerarDocumentosCtrl: TcxDBCheckBox;
    DataRenumerarDocumentos: TBooleanField;
    cxGroupBox1: TcxGroupBox;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure ExaminarButtonClick(Sender: TObject);
    procedure PathCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure DestinoOrigenCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure DireccionCorreoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure DireccionCorreoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure DireccionCorreoCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SituacionCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure TodasLasSeriesCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FechalCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TipoExportacionValuePosted(Sender: TObject);
    procedure TipoMovimientoCtrlPropertiesValuePosted(Sender: TObject);

  private

    ClienteFields : TClienteFields;
    MovimientoFields,
    MovimientoAuxFields : TMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;
    GrupoLineaMovimientoFields : TGrupoLineaMovimientoFields;
    FacturaVentasFields : TFacturaVentasFields;
    EfectoFields : TEfectoFields;
    ArticuloFields : TArticuloFields;

    DsSerieFacturacionFields : TSerieFacturacionFields;
    DsTiposIVAFields : TTiposIVAFields;
    DsDireccionCorreoFields : TDireccionCorreoFields;

    ExternClienteFields : TClienteFields;
    ExternMovimientoFields : TMovimientoFields;
    ExternLineaMovimientoFields : TLineaMovimientoFields;
    ExternGrupoLineaMovimientoFields : TGrupoLineaMovimientoFields;
    ExternFacturaVentasFields : TFacturaVentasFields;
    ExternEfectoFields : TEfectoFields;
    ExternArticuloFields : TArticuloFields;

    MovimientoText,
    GrupoLineaMovimientoText,
    LineaMovimientoText : Text;

    StrDataPath  : string;
    SaveDecimalSeparator : Char;

    procedure ActualizaEstadoComponentes;

  protected
    class var
    TiposMovimientoVenta : TTiposMovimientoVenta;

  public

    procedure ExecuteProcess;
    procedure AbreFicherosExternos( Exportar : Boolean );
    procedure CierraFicherosExternos( Exportar : Boolean );
    procedure ImportaDatos;
    procedure DoOnAcceptMessage;
  end;

var  BoxEmvForm: TBoxEmvForm = nil;

procedure ExportImportMovimientosVenta( TiposMovimientoVenta : TTiposMovimientoVenta );

implementation

{$R *.DFM}

uses   Variants,
       Files,
       FileCtrl,
       DateUtils,
       LibUtils,
       AppManager,

       DataAccess,
       EnterpriseDataAccess,
       SessionDataAccess,

       Gdm00Dm,

       Gdm30Frm,

       dm_mov,
       dm_sto,
       dm_iex,
       dm_ddc,
       dm_cli,
       dm_sdf,
       dm_art,
       dm_fdv,

       a_ddc,

       b_msg,
       b_pro,
       b_dir,

       cx_sdf,
       cx_ddc,
       cx_cli,

       f_prg;

resourceString
  RsMsg1   = 'Error creando los ficheros de exportación.';
  RsMsg2   = 'Exportación de movimientos de venta';
  RsMsg3   = 'Grabando datos en los ficheros ...';
  RsMsg4   = 'Copiando datos en [%s].';
  RsMsg5   = 'Importación de movimientos de venta';
  RsMsg6   = 'Leyendo datos desde [%s].';
  RsMsg7   = 'Importando datos desde los ficheros ...';
  RsMsg8   = '¿Desea conservar los ficheros que acaba de importar?';
  RsMsg9   = 'Los ficheros no pertenecen al mismo ejercicio.';
  RsMsg10  = 'Se cancela el proceso de importación.';
  RsMsg11  = 'Se ha interrumpido el proceso de exportacion/importación.';
  RsMsg12  = 'Es conveniente que revise el contenido de sus ficheros.';
  RsMsg13  = 'Suprimiendo ficheros ...';
  RsMsg14  = 'El documento %s %d del cliente %s, ya existe. No puede ser importado.';
  RsMsg15  = 'Indique si desea cancelar ahora el proceso de importación.' + #13 + 'Si finaliza el proceso no se registrará ningún cambio en sus ficheros.';
  RsMsg16  = 'El documento %s %d del cliente %s, ya existe. No ha sido importado.';
  RsMsg17  = 'Se cancela el proceso.';
  RsMsg18  = 'Fecha %s';
  RsMsg20  = 'albarán';
  RsMsg21  = 'factura';
  RsMsg22  = 'Destino';
  RsMsg23  = 'Origen';
  RsMsg24  = 'El albarán %s %d del cliente %s, no tiene lineas.';
  RsMsg25  = 'El albarán %s %d del cliente %s, no es del tipo esperado (venta).';
  RsMsg26  = 'presupuesto';
  RsMsg27  = 'pedido';
  RsMsg28  = 'No puede realizar este tipo de selección cuando se exporta en formato texto.';
  RsMsg29  = 'El documento %s %d del cliente %s, consta como facturado. No puede ser importado porque no se pueden renumerar albaranes ya facturados.';

const
  ListaFicherosTexto  : TStringArray = [ 'Movimiento.txt',
                                         'GrupoLineaMovimiento.txt',
                                         'LineaMovimiento.txt' ];

  // No intentar simplificar utilizando arrays dinámicos. Se producen errores de memoria difíciles de corregir.
  //** 20.02.2023 Lo intento de nuevo

  ListaFicherosAlbaran : TStringArray = [ 'Cliente.nx1',
                                          'Articulo.nx1',
                                          'Movimiento.nx1',
                                          'GrupoLineaMovimiento.nx1',
                                          'LineaMovimiento.nx1',
                                          'FacturaVentas.nx1',
                                          'Efecto.nx1' ];

  // Vale para pedidos y presupuestos

  ListaFicherosPedidoPresupuesto : TStringArray = [ 'Cliente.nx1',
                                                    'Articulo.nx1',
                                                    'Movimiento.nx1',
                                                    'GrupoLineaMovimiento.nx1',
                                                    'LineaMovimiento.nx1' ];

procedure ExportImportMovimientosVenta( TiposMovimientoVenta : TTiposMovimientoVenta );
begin
     TBoxEmvForm.TiposMovimientoVenta := TiposMovimientoVenta;
     CreateEditForm( TBoxEmvForm, BoxEmvForm, TGds30Frm.VentasSection, True );
end;

procedure TBoxEmvForm.FechalCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                    var DisplayValue : Variant;
                                                    var ErrorText    : TCaption;
                                                    var Error        : Boolean  );
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TBoxEmvForm.FormManagerInitializeForm;
begin

     CloseWindowWhenFocusLost := True;

     ClienteFields := TClienteFields.Create( ClienteTable );
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     MovimientoAuxFields := TMovimientoFields.Create( MovimientoAuxTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
     GrupoLineaMovimientoFields := TGrupoLineaMovimientoFields.Create( GrupoLineaMovimientoTable );
     ArticuloFields := TArticuloFields.Create( ArticuloTable );
     FacturaVentasFields := TFacturaVentasFields.Create( FacturaVentasTable );
     EfectoFields := TEfectoFields.Create( EfectoTable );

     DsSerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     DsTiposIVAFields := TTiposIVAFields.Create( Self );
     DsDireccionCorreoFields := TDireccionCorreoFields.Create( Self );

     If   TiposMovimientoVenta<>[]
     then With TipoMovimientoCtrl.Properties do
            begin
            Items[ 0 ].Enabled := tmPresupuesto in TiposMovimientoVenta;
            Items[ 1 ].Enabled := tmPedidoVenta in TiposMovimientoVenta;
            Items[ 2 ].Enabled := tmVenta in TiposMovimientoVenta;
            end;

     DataFormato.Value := 0;
     DataProceso.Value := 0;
     DataDestinoOrigen.Value := 0;
     DataTipoMovimiento.Value := tmVenta;
     DataSituacion.Value := 0;
     DataFechaInicial.Value := ApplicationContainer.FirstDayOfYearDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataClienteFinal.Value := HighStrCode;
     DataReferenciasPedidos.Value := False;

     ActualizaEstadoComponentes;
end;

procedure TBoxEmvForm.FormManagerOkButton;

var  HeaderMsg : String;

begin
     case DataProceso.Value of
         0 : HeaderMsg := RsMsg2;
         1 : HeaderMsg := RsMsg5;
         end;
     CreateProcessForm( ExecuteProcess, HeaderMsg );
end;

procedure TBoxEmvForm.ExaminarButtonClick(Sender: TObject);
begin
     SelectDirectory( DataPath );
end;

procedure TBoxEmvForm.AbreFicherosExternos( Exportar : Boolean );
begin

     With ExportImport do
       case DataFormato.Value of
         0 : begin
             AbreFicherosExternos( [ ExternClienteTable,
                                     ExternMovimientoTable,
                                     ExternGrupoLineaMovimientoTable,
                                     ExternLineaMovimientoTable,
                                     ExternArticuloTable ], Exportar );

             ExternClienteFields := TClienteFields.Create( ExternClienteTable );
             ExternMovimientoFields := TMovimientoFields.Create( ExternMovimientoTable );
             ExternLineaMovimientoFields := TLineaMovimientoFields.Create( ExternLineaMovimientoTable );
             ExternGrupoLineaMovimientoFields := TGrupoLineaMovimientoFields.Create( ExternGrupoLineaMovimientoTable );
             ExternArticuloFields := TArticuloFields.Create( ExternArticuloTable );

             If   DataTipoMovimiento.Value=tmVenta
             then begin
                  AbreFicherosExternos( [ ExternFacturaVentasTable, ExternEfectoTable ], Exportar );

                  ExternFacturaVentasFields := TFacturaVentasFields.Create( ExternFacturaVentasTable );
                  ExternEfectoFields := TEfectoFields.Create( ExternEfectoTable );
                  end;

             end;
         1 : begin
             AbreFicheroTextoExterno( MovimientoText, AddPathDelim( DataPath.Value ) + 'Movimiento.txt', Exportar );
             AbreFicheroTextoExterno( GrupoLineaMovimientoText, AddPathDelim( DataPath.Value ) + 'GrupoLineaMovimiento.txt', Exportar );
             AbreFicheroTextoExterno( LineaMovimientoText, AddPathDelim( DataPath.Value ) + 'LineaMovimiento.txt', Exportar );
             end;
         end;
end;

procedure TBoxEmvForm.CierraFicherosExternos( Exportar : Boolean );
begin
     With ExportImport do
       case DataFormato.Value of
         0 : begin
             ExternClienteTable.Close;
             ExternMovimientoTable.Close;
             ExternGrupoLineaMovimientoTable.Close;
             ExternLineaMovimientoTable.Close;
             ExternArticuloTable.Close;
             If   DataTipoMovimiento.Value=tmVenta
             then begin
                  ExternFacturaVentasTable.Close;
                  ExternEfectoTable.Close;
                  end;
             DataAccessModule.CloseInactiveLocalSessionResources;
             end;

         1 : begin
             CloseFile( MovimientoText  );
             CloseFile( GrupoLineaMovimientoText );
             CloseFile( LineaMovimientoText );
             end;
         end;
end;

procedure TBoxEmvForm.ExecuteProcess;

function ObtenTipoDatosExportados( TipoMovimiento : TTipoMovimientoVenta ) : TTipoDatosExportados;
begin
     case DataTipoMovimiento.Value of
       tmPresupuesto :
         Result := tdPresupuesto;
       tmPedidoVenta :
         Result := tdPedidoVentas;
       tmVenta :
         Result := tdAlbaranVentas
       end;
end;

procedure ExportarMovimientos;

var  Procesar : Boolean;
     SerieInicial,
     SerieFinal : String;

procedure ProcesaFactura;
begin

     ExternFacturaVentasTable.CopyAndAppendRecord( FacturaVentasTable, False );

     If   ClienteTable.FindKey( [ FacturaVentasFields.CodigoCliente.Value ] )
     then ExternClienteTable.CopyAndAppendRecord( ClienteTable, False );

     With EfectoTable do
       begin

       With FacturaVentasFields do
         SetRange( [ Ejercicio.Value, scVentas, CodigoCliente.Value, Serie.Value, NroFactura.Value, 0 ],
                   [ Ejercicio.Value, scVentas, CodigoCliente.Value, Serie.Value, NroFactura.Value, MaxSmallint ] );

       First;
       While not Eof do
         begin
         ExternEfectoTable.CopyAndAppendRecord( EfectoTable );
         Next;
         end;

       end;

     With MovimientoAuxTable do
       begin

       With FacturaVentasFields do
         SetRange( [ tmVenta, Ejercicio.Value, CodigoCliente.Value, Serie.Value, NroFactura.Value ],
                   [ tmVenta, Ejercicio.Value, CodigoCliente.Value, Serie.Value, NroFactura.Value ] );
       First;
       While not Eof do
         begin

         ExternMovimientoTable.CopyAndAppendRecord( MovimientoAuxTable );

         ProcessFrame.AddRecordMsg( StrFormatDate( ExternMovimientoFields.Fecha.Value, dfDefault ) + ' , ' +
                                    ExternMovimientoFields.Serie.Value + ' ' +
                                    StrInt( ExternMovimientoFields.NroOperacion.Value ) );

         //* 06.09.2010  Trato de evitar que la existencia de grupos de línea determine la selección de líneas, por eso los exporto aparte.

         With GrupoLineaMovimientoTable do
           begin
           With MovimientoAuxFields do
             SetRange( [ Ejercicio.Value, NroOperacion.Value, 0 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint ] );

           First;
           While not Eof do
             begin
             ExternGrupoLineaMovimientoTable.Append;
             ExternGrupoLineaMovimientoTable.CopyFields( GrupoLineaMovimientoTable );
             ExternGrupoLineaMovimientoTable.Post;

             Next;
             end;

           end;

         With LineaMovimientoTable do
           begin

           With MovimientoAuxFields do
             SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

           First;
           While not Eof do
             begin

             If   ArticuloTable.FindKey( [ LineaMovimientoFields.CodigoArticulo.Value ] )
             then ExternArticuloTable.CopyAndAppendRecord( ArticuloTable, False );

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
     If   ( MovimientoFields.TipoMovimiento.Value=tmVenta ) and  not ValueIsEmpty( MovimientoFields.NroFactura.Value )
     then With FacturaVentasTable, MovimientoFields do
            begin
            IndexFieldNames := 'Ejercicio;Serie;NroFactura';
            If   not  ExternFacturaVentasTable.FindKey( [ Ejercicio.Value, SerieFactura.Value, NroFactura.Value ] )
            then If   FindKey( [ Ejercicio.Value, SerieFactura.Value, NroFactura.Value ] )
                 then ProcesaFactura;
            Exit;
            end;

     If   ClienteTable.FindKey( [ MovimientoFields.Propietario.Value ] )
     then ExternClienteTable.CopyAndAppendRecord( ClienteTable, False );

     ExternMovimientoTable.CopyAndAppendRecord( MovimientoTable );

     ProcessFrame.AddRecordMsg( StrFormatDate( ExternMovimientoFields.Fecha.Value, dfDefault ) + ' , ' +
                                ExternMovimientoFields.Serie.Value + ' ' +
                                StrInt( ExternMovimientoFields.NroOperacion.Value ) );

     With GrupoLineaMovimientoTable do
       begin

       With MovimientoFields do
         SetRange( [ Ejercicio.Value, NroOperacion.Value, 0 ],  [ Ejercicio.Value, NroOperacion.Value, MaxSmallint ] );

       ExternGrupoLineaMovimientoTable.Append;
       ExternGrupoLineaMovimientoTable.CopyFields( GrupoLineaMovimientoTable );
       ExternGrupoLineaMovimientoTable.Post;

       Next;
       end;

     With LineaMovimientoTable do
       begin

       With MovimientoFields do
         SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ],  [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

       First;
       While not Eof do
         begin

         If   ArticuloTable.FindKey( [ LineaMovimientoFields.CodigoArticulo.Value ] )
         then ExternArticuloTable.CopyAndAppendRecord( ArticuloTable, False );

         ExternLineaMovimientoTable.Append;

         ExternLineaMovimientoTable.CopyFields( LineaMovimientoTable );

         If   ( MovimientoFields.TipoMovimiento.Value=tmVenta ) and not DataReferenciasPedidos.Value
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


     ExportImport.RecordProcessed := True;
end;

procedure ProcesaMovimientoTexto;
begin

     WriteLn( MovimientoText, ExportImport.ExportRecordToText( MovimientoTable ) );

     With GrupoLineaMovimientoTable do
       begin

       With MovimientoFields do
         SetRange( [ Ejercicio.Value, NroOperacion.Value, 0 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint ] );

       First;
       While not Eof do
         begin
         WriteLn( GrupoLineaMovimientoText, ExportImport.ExportRecordToText( GrupoLineaMovimientoTable ) );
         Next;
         end;

       end;

     With LineaMovimientoTable do
       begin

       With MovimientoFields do
         SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

       First;
       While not Eof do
         begin

         try
           If   ( MovimientoFields.TipoMovimiento.Value=tmVenta ) and not DataReferenciasPedidos.Value
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
       HeaderList.Values[ RsTodasLasSeries ] := StrBoolean( TodasLasSeriesCtrl.Checked );
       HeaderList.Values[ RsSerie ] := SerieCtrl.EditValue;
       HeaderList.Values[ RsFechaInicial ] := StrFormatDate( FechaInicialCtrl.EditValue );
       HeaderList.Values[ RsFechaFinal ] := StrFormatDate( FechaFinalCtrl.EditValue );
       HeaderList.Values[ RsCodigoClienteInicial ] := ClienteInicialCtrl.EditValue;
       HeaderList.Values[ RsCodigoClienteFinal ] := ClienteFinalCtrl.EditValue;
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

           If   DataTodasLasSeries.Value
           then begin
                SerieInicial := '';
                SerieFinal := HighStrCode;
                end
           else begin
                SerieInicial := DataSerie.Value;
                SerieFinal := DataSerie.Value;
                end;

           If   ( DataTipoMovimiento.Value=tmVenta ) and ( DataSituacion.Value in [ 5..7 ] )
           then With FacturaVentasTable do
                  begin

                  IndexFieldNames := 'Serie;CodigoCliente;Fecha';

                  SetRange( [ SerieInicial, DataClienteInicial.Value, DataFechaInicial.Value ],
                            [ SerieFinal, DataClienteFinal.Value, DataFechaFinal.Value ] );

                  First;
                  While not Eof and not Canceled do
                    begin

                    case DataSituacion.Value of
                         5 : Procesar := True;
                         6 : Procesar := not FacturaVentasFields.Traspasada.Value;
                         7 : Procesar := FacturaVentasFields.Traspasada.Value;
                      end;

                    If   Procesar
                    then ProcesaFactura;

                    Next;
                    end;

                  end
           else  With MovimientoTable do
                   begin

                   IndexFieldNames := 'TipoMovimiento;Propietario;Fecha';
                   FacturaVentasTable.IndexFieldNames := 'Ejercicio;Serie;NroFactura';

                   SetRange( [ DataTipoMovimiento.Value, DataClienteInicial.Value, DataFechaInicial.Value ],
                             [ DataTipoMovimiento.Value, DataClienteFinal.Value, DataFechaFinal.Value ] );
                   First;
                   While not Eof and not Canceled do
                     begin

                     With MovimientoFields do
                       begin

                       Procesar := DataTodasLasSeries.Value or ( DataSerie.Value=Serie.Value );

                       If   Procesar
                       then case DataTipoMovimiento.Value of
                              tmPresupuesto : case DataSituacion.Value of
                                                 1 : Procesar := not Revisado.Value;
                                                 2 : Procesar := Revisado.Value;
                                                 end;

                              tmPedidoVenta : case DataSituacion.Value of
                                                 1 : Procesar := Situacion.Value=0;
                                                 2 : Procesar := Situacion.Value in [ 0, 1 ];
                                                 3 : Procesar := Situacion.Value=1;
                                                 4 : Procesar := Situacion.Value=2;
                                                 end;

                              // "<Todos>","No facturables","Facturables","Pendientes de facturar (todos)","Pendientes de facturar (facturables)","Facturados","Pendientes de contabilizar","Contabilizados"'

                              tmVenta       : case DataSituacion.Value of
                                                 1 : Procesar := NoFacturar.Value;
                                                 2 : Procesar := not NoFacturar.Value;
                                                 3 : Procesar := not Facturado.Value;
                                                 4 : Procesar := not Facturado.Value and not NoFacturar.Value;
                                                 5 : Procesar := Facturado.Value;
                                                 6 : Procesar := not Traspasado.Value;
                                                 7 : Procesar := Traspasado.Value;
                                                 end;
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
                           If   DataTipoMovimiento.Value=tmVenta
                           then CompressAndCopyFiles( ListaFicherosAlbaran, SessionDataModule.ExportsDatabase.Path, StrDataPath, True )
                           else CompressAndCopyFiles( ListaFicherosPedidoPresupuesto, SessionDataModule.ExportsDatabase.Path, StrDataPath, True );
                           SetBackupInfo( StrDataPath, tdAlbaranVentas, True );
                           end;

                  1 : begin

                      InsertaParametros;

                      If   DataFormato.Value=0
                      then begin
                           If   DataTipoMovimiento.Value=tmVenta
                           then CompressedFile := SMTPCompressFiles( ListaFicherosAlbaran, [], SessionDataModule.ExportsDatabase.Path )
                           else CompressedFile := SMTPCompressFiles( ListaFicherosPedidoPresupuesto, [], SessionDataModule.ExportsDatabase.Path );;
                           end
                      else CompressedFile := SMTPCompressFiles( ListaFicherosTexto, [], DataPath.Value );

                      SMTPInitDataPacket( ObtenTipoDatosExportados( DataTipoMovimiento.Value ), DsDireccionCorreoFields, [ CompressedFile ], True );


                      SMTPSend;
                      end;
                  end;

                end;

       except on E : Exception do
         AddMsg( ntError, E.Message + #13 + RsMsg11 + #13 + RsMsg12 );
         end;

       end;

end;

procedure ImportarMovimientos;
begin

     With ProcessFrame, ExportImport do
       begin

       try

         case DataDestinoOrigen.Value of
           0 : begin
               If   DataFormato.Value=0
               then begin
                    CompruebaDisco( StrDataPath, 0, True );
                    If   SetBackupInfo( StrDataPath, tdAlbaranVentas, False )
                    then begin
                         If   DataTipoMovimiento.Value=tmVenta
                         then DeCompressAndCopyFiles( StrDataPath, ListaFicherosAlbaran )
                         else DeCompressAndCopyFiles( StrDataPath, ListaFicherosPedidoPresupuesto );                         ;
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

procedure TBoxEmvForm.ImportaDatos;

var  AvisoCancelacion : Boolean;

procedure ProcesaMovimiento;

var  NroOperacionExterna : LongInt;

begin

     NroOperacionExterna := ExternMovimientoFields.NroOperacion.Value;

     If   ExternClienteTable.FindKey( [ ExternMovimientoFields.Propietario.Value ] )
     then ClienteTable.CopyAndAppendRecord( ExternClienteTable, False );

     With ExternMovimientoFields do
       If   not DataRenumerarDocumentos.Value and
            MovimientoTable.FindKey( [ DataTipoMovimiento.Value, Ejercicio.Value, Serie.Value, NroDocumento.Value ] )
       then begin
            If   not AvisoCancelacion
            then begin
                 If   ShowNotification( ntAcceptCancel, Format( RsMsg14, [ Serie.Value,  NroDocumento.Value, Propietario.Value ] ), RsMsg15 )=mrCancel
                 then begin
                      ProcessFrame.Canceled := True;
                      Abort;
                      end;
                 AvisoCancelacion := True;
                 end;
            ProcessFrame.AddMsg( ntWarning, Format( RsMsg16, [ Serie.Value, NroDocumento.Value, Propietario.Value ] ) );
            end
       else begin

            MovimientoTable.Append;
            MovimientoTable.CopyFields( ExternMovimientoTable );
            MovimientoFields.NroOperacion.Value := Movimiento.ProximaOperacion( MovimientoFields.Ejercicio.Value );
            If   DataRenumerarDocumentos.Value
            then MovimientoFields.NroDocumento.Value := Movimiento.ProximoDocumento( MovimientoFields );
            MovimientoTable.Post;

            If   ( DataTipoMovimiento.Value=tmVenta ) and not ValueIsEmpty( MovimientoFields.NroFactura.Value )
            then If   ExternFacturaVentasTable.FindKey( [  EjercicioFactura.Value, SerieFactura.Value, NroFactura.Value ] )
                 then begin

                      CompruebaEjercicio( ExternFacturaVentasFields.Fecha.Value );

                      FacturaVentasTable.CopyAndAppendRecord( ExternFacturaVentasTable, False );

                      With ExternEfectoTable do
                        begin
                        With FacturaVentasFields do
                          SetRange( [ Ejercicio.Value, scVentas, CodigoCliente.Value, Serie.Value, NroFactura.Value, 0 ],
                                    [ Ejercicio.Value, scVentas, CodigoCliente.Value, Serie.Value, NroFactura.Value, MaxSmallint ] );
                        First;
                        While not Eof do
                          begin
                          EfectoTable.CopyAndAppendRecord( ExternEfectoTable, False );
                          Next;
                          end;

                        end;

                      end;

            With ExternGrupoLineaMovimientoTable do
              begin

              SetRange( [ MovimientoFields.Ejercicio.Value, NroOperacionExterna, 0 ], [ MovimientoFields.Ejercicio.Value, NroOperacionExterna, MaxSmallint ] );

              First;
              While not Eof do
                begin

                GrupoLineaMovimientoTable.Append;

                GrupoLineaMovimientoTable.CopyFields( ExternGrupoLineaMovimientoTable );
                GrupoLineaMovimientoFields.NroOperacion.Value := MovimientoFields.NroOperacion.Value;

                GrupoLineaMovimientoTable.Post;

                Next;
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
                If   LineaMovimientoFields.UIDArticulo.Value=''
                then LineaMovimientoFields.UIDArticulo.AsGuid := Articulo.Identificador;
                LineaMovimientoFields.NroRegistro.Clear;

                StockAlmacen.ActualizaStock( MovimientoFields, LineaMovimientoFields, False );

                LineaMovimientoTable.Post;

                Next;
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
     GrupoLineaDelProximoMovimiento,
     LineaDelProximoMovimiento : Boolean;
     ImporteNetoAlbaran : Decimal;
     NroOperacionOriginal : LongInt;

     TotalImporteBruto,
     TotalDescuentosArticulos,
     TotalImporteNeto : Decimal;

begin

     GrupoLineaDelProximoMovimiento := False;
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
                        ProcessFrame.AddMsg( ntError, Format( RsMsg25, [ Serie.Value, NroDocumento.Value, Propietario.Value ] ) );
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

              If   DataRenumerarDocumentos.Value
              then NroDocumento.Value := Movimiento.ProximoDocumento( MovimientoFields );

              If   MovimientoAuxTable.FindKey( [ DataTipoMovimiento.Value, Ejercicio.Value, Serie.Value, NroDocumento.Value ] )
              then begin
                   ShowNotification( ntError, Format( RsMsg14, [ Serie.Value, NroDocumento.Value, Propietario.Value ] ), RsMsg17 );
                   Abort;
                   end
              else begin

                   NroOperacion.Value := Movimiento.ProximaOperacion;

                   Cliente.Obten( MovimientoFields.Propietario.Value, '', ClienteFields );
                   SerieFacturacion.Obten( MovimientoFields.Serie.Value, DsSerieFacturacionFields );

                   TieneLineas := False;

                   // Grupos de lineas

                   repeat

                     If   not GrupoLineaDelProximoMovimiento
                     then ExportImport.ImportRecordFromText( GrupoLineaMovimientoText, GrupoLineaMovimientoTable );

                     GrupoLineaDelProximoMovimiento := False;

                     If   ( GrupoLineaMovimientoFields.Ejercicio.Value=MovimientoFields.Ejercicio.Value ) and
                          ( GrupoLineaMovimientoFields.NroOperacion.Value=NroOperacionOriginal )
                     then begin
                          GrupoLineaMovimientoFields.NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                          GrupoLineaMovimientoTable.Post;
                          end
                     else GrupoLineaDelProximoMovimiento := True;

                   until Eof( GrupoLineaMovimientoText ) or GrupoLineaDelProximoMovimiento;

                   // Lineas

                   repeat

                     If   not LineaDelProximoMovimiento
                     then ExportImport.ImportRecordFromText( LineaMovimientoText, LineaMovimientoTable );

                     LineaDelProximoMovimiento := False;

                     If   ( LineaMovimientoFields.Ejercicio.Value=MovimientoFields.Ejercicio.Value ) and
                          ( LineaMovimientoFields.NroOperacion.Value=NroOperacionOriginal )
                     then begin
                          TieneLineas := True;
                          LineaMovimientoFields.NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                          If   LineaMovimientoFields.UIDArticulo.Value=''
                          then LineaMovimientoFields.UIDArticulo.AsGuid := Articulo.Identificador;
                          LineaMovimientoFields.NroRegistro.Clear;

                          Articulo.Obten( LineaMovimientoFields.CodigoArticulo.Value, ArticuloFields );

                          If   MovimientoFields.TipoMovimiento.Value=tmVenta
                          then LineaMovimientoFields.CantidadAjustada.Value := -LineaMovimientoFields.Cantidad.Value
                          else LineaMovimientoFields.CantidadAjustada.Value := LineaMovimientoFields.Cantidad.Value;

                          FacturaVentas.CalculaImportesIVA( MovimientoFields, LineaMovimientoFields, ClienteFields, ArticuloFields, DsSerieFacturacionFields, DsTiposIVAFields );

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
                          ProcessFrame.AddMsg( ntError, Format( RsMsg24, [ Serie.Value, NroDocumento.Value, Propietario.Value ] ) );
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
                                                  GrupoLineaMovimientoTable,
                                                  LineaMovimientoTable ] );

         // Los stocks no están incluidos en la transacción por estar en el servidor. Se pueden producir inconsistencias en el fichero de stocks si se produce un error durante la importación.


         AddMsg( ntInformation, RsMsg7 );

         AvisoCancelacion := False;

         MovimientoTable.IndexFieldNames := 'TipoMovimiento;Ejercicio;Serie;NroDocumento';
         MovimientoAuxTable.IndexFieldNames := 'TipoMovimiento;Ejercicio;Serie;NroDocumento';

         If   DataFormato.Value=0
         then With ExternMovimientoTable do
                begin
                First;
                If  not Eof
                then begin

                     //**23.10.2008  Los albaranes facturados pueden pertenecer al ejercicio anterior
                     //**12.03.2012  Ahora permito renumerar los documentos, por lo que tengo que evitar que los albaranes
                     //              facturados sean importados (¡las facturas no se tocan... no.. se.. tocan!)

                     If   DataTipoMovimiento.Value=tmVenta
                     then If   not ExternMovimientoFields.Facturado.Value
                          then CompruebaEjercicio( ExternMovimientoFields.Fecha.Value )
                          else If   DataRenumerarDocumentos.Value
                               then begin
                                    With ExternMovimientoFields do
                                      ShowNotification( ntError, Format( RsMsg29, [ Serie.Value, NroDocumento.Value, Propietario.Value ] ) );
                                    Abort;
                                    end;


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
                                  ProcessFrame.AddMsg( ntError, RsgMsg120 );
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
                            else EraseListOfFiles( StrDataPath, [ BackupFileName, BackupInfoFileName, ListaFicherosPedidoPresupuesto[ 0 ], ListaFicherosPedidoPresupuesto[ 1 ], ListaFicherosPedidoPresupuesto[ 2 ], ListaFicherosPedidoPresupuesto[ 3 ] ], False );
                        1 : EraseListOfFiles( StrDataPath, ListaFicherosTexto, False );
                        end;
                      end;
       end;

end;

procedure TBoxEmvForm.DoOnAcceptMessage;
begin
     With ExportImport do
       If   DataTipoMovimiento.Value=tmVenta
       then DeCompressFiles( SessionDataModule.GetImportDirectory, ListaFicherosAlbaran )
       else DeCompressFiles( SessionDataModule.GetImportDirectory, ListaFicherosPedidoPresupuesto );
     ImportaDatos;
end;

procedure TBoxEmvForm.PathCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ValueIsEmpty( DisplayValue )
     then If   not DirectoryExists( DisplayValue )
          then begin
               Error := True;
               ErrorText := JoinMessage( rsgMsg394, rsgMsg395 );
               end;
end;

procedure TBoxEmvForm.TipoExportacionValuePosted(Sender: TObject);
begin
     ActualizaEstadoComponentes;
end;

procedure TBoxEmvForm.TipoMovimientoCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaEstadoComponentes;
end;

procedure TBoxEmvForm.ActualizaEstadoComponentes;
begin
     SituacionCtrl.Enabled := ( DataProceso.Value=0 ) and ( DataFormato.Value=0 );
     TodasLasSeriesCtrl.Enabled := DataProceso.Value=0;
     SerieCtrl.Enabled := DataProceso.Value=0;
     FechaInicialCtrl.Enabled := DataProceso.Value=0;
     FechaFinalCtrl.Enabled := DataProceso.Value=0;
     ClienteInicialCtrl.Enabled := DataProceso.Value=0;
     ClienteFinalCtrl.Enabled := DataProceso.Value=0;
     ReferenciasPedidosCtrl.Enabled := DataProceso.Value=0;
     RenumerarDocumentosCtrl.Enabled := DataProceso.Value=1;

     If   DataFormato.Value=1
     then DataDestinoOrigen.Value := 0;  // Solo fichero
     DestinoOrigenCtrl.Enabled := DataFormato.Value=0;

     With DestinoOrigenLabel do
      case DataProceso.Value of
        0 : Caption := RsMsg22;
        1 : Caption := RsMsg23;
        end;

     DireccionCorreoCtrl.Enabled := ( DataProceso.Value=0 ) and ( DataDestinoOrigen.Value=1 );

     If   not VarIsNull( DataTipoMovimiento.Value )
     then begin
          With SituacionCtrl.Properties.Items do
            case DataTipoMovimiento.Value of
              tmPresupuesto : CommaText := RsMsgSituacionPresupuestos;
              tmPedidoVenta : CommaText := RsMsgSituacionPedidosVenta;
              tmVenta       : If   DataFormato.Value=0
                              then CommaText := RsMsgSituacionAlbaranes       // '"<Todos>","No facturables","Facturables","Pendientes de facturar (todos)","Pendientes de facturar (facturables)","Facturados","Pendientes de contabilizar","Contabilizados"'
                              else CommaText := RsMsgSituacionAlbaranesB;     // '"<Todos>","No facturables","Pendientes de facturar"'
              end;
          DataSituacion.Value := 0;
          ReferenciasPedidosCtrl.Enabled := ( DataProceso.Value=0 )  and ( DataTipoMovimiento.Value=tmVenta );
          RenumerarDocumentosCtrl.Enabled := DataProceso.Value=1;
          TodasLasSeriesCtrl.Enabled := ( DataProceso.Value=0 ) and Movimiento.SeriesEnDocumentosVenta( DataTipoMovimiento.Value  );
          If   not TodasLasSeriesCtrl.Enabled
          then DataTodasLasSeries.Value := True;
          SerieCtrl.Enabled := not DataTodasLasSeries.Value and TodasLasSeriesCtrl.Enabled;
          end;
end;

procedure TBoxEmvForm.ClienteCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TBoxEmvForm.ClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TBoxEmvForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxEmvForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxEmvForm.SituacionCtrlPropertiesEditValueChanged(Sender: TObject);

var  StrDoc : String;

begin
     With TipoMovimientoCtrl do
       If   not ValueIsEmpty( EditValue )
       then begin
            case EditValue of
              tmPresupuesto : StrDoc := RsMsg26;
              tmPedidoVenta : StrDoc := RsMsg27;
              tmVenta       : If   ( DataFormato.Value=1 ) or ( SituacionCtrl.EditValue<=4  )
                              then StrDoc := RsMsg20
                              else StrDoc := RsMsg21;
              end;
            DocInicialLabel.Caption := Format( RsMsg18, [ StrDoc ] );
            end;
end;

procedure TBoxEmvForm.TodasLasSeriesCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     SerieCtrl.Enabled := not TodasLasSeriesCtrl.Checked;
end;

procedure TBoxEmvForm.DestinoOrigenCtrlPropertiesEditValueChanged( Sender: TObject);
begin
     With DestinoOrigenCtrl do
       begin
       PathCtrl.Enabled := EditValue=0;
       ExaminarButton.Enabled := EditValue=0;
       DireccionCorreoCtrl.Enabled := ( DataProceso.Value=0 ) and ( EditValue=1 );
       end;
end;

procedure TBoxEmvForm.DireccionCorreoCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntDireccionesCorreo( [ Sender.EditingValue ] );
end;

procedure TBoxEmvForm.DireccionCorreoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaDireccionesCorreo( Sender );
end;

procedure TBoxEmvForm.DireccionCorreoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     DireccionCorreo.Valida( Sender, tdAmbos, DisplayValue, ErrorText, Error, DsDireccionCorreoFields );
end;

end.

