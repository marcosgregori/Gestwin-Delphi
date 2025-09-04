
unit b_ema;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask,

  AppContainer,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxPC, cxControls, cxGraphics, nxdb, cxGroupBox,
  cxRadioGroup, cxDBEdit, cxMaskEdit, cxDropDownEdit, cxIndexedComboBox,
  cxContainer, cxEdit, cxTextEdit, cxCalendar,

  cxCheckBox,

  cxSpinEdit, dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxPCdxBarPopupMenu, dxBarBuiltInMenu,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,

  dmi_iex, dxUIAClasses;

type
  TBoxEmaForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    MovimientoTable: TnxeTable;
    LineaMovimientoTable: TnxeTable;
    PathCtrl: TcxDBTextEdit;
    ExaminarButton: TgBitBtn;
    FormatoCtrl: TcxDBIndexedComboBox;
    ExternMovimientoTable: TnxeTable;
    ExternLineaMovimientoTable: TnxeTable;
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
    MovimientoAuxTable: TnxeTable;
    DataTipoMovimiento: TSmallintField;
    TodosLosTiposCtrl: TcxDBCheckBox;
    TipoMovimientoCtrl : TcxDBSpinEdit;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    NroOperacionInicialCtrl: TcxDBSpinEdit;
    NroOperacionFinalCtrl: TcxDBSpinEdit;
    TabSheet2: TcxTabSheet;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    ValoracionInventarioCtrl: TcxDBIndexedComboBox;
    ValorarInventariosCtrl: TcxDBCheckBox;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    DataTodosLosTipos: TBooleanField;
    DataValorarInventarios: TBooleanField;
    DataNroOperacionInicial: TIntegerField;
    DataNroOperacionFinal: TIntegerField;
    DataPrecioCoste: TSmallintField;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label8: TcxLabel;
    destinoOrigenLabel: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label19: TcxLabel;
    Label20: TcxLabel;
    Label1: TcxLabel;
    Label7: TcxLabel;
    Label4: TcxLabel;
    docInicialLabel: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    RenumerarDocumentosCtrl: TcxDBCheckBox;
    DataRenumerarDocumentos: TBooleanField;
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
    procedure TodosLosTiposCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure TipoMovimientoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TipoMovimientoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ValorarInventariosCtrlPropertiesEditValueChanged(
      Sender: TObject);

  private

    MovimientoFields,
    MovimientoAuxFields : TMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;
    ArticuloFields : TArticuloFields;

    ExternMovimientoFields : TMovimientoFields;
    ExternLineaMovimientoFields : TLineaMovimientoFields;
    ExternArticuloFields : TArticuloFields;

    DsDireccionCorreoFields : TDireccionCorreoFields;

    MovimientoText,
    LineaMovimientoText : Text;

    StrDataPath  : string;
    SaveDecimalSeparator : Char;

    procedure ValorarInventarios;

  public
    procedure ExecuteProcess;
    procedure AbreFicherosExternos( Exportar : Boolean );
    procedure CierraFicherosExternos( Exportar : Boolean );
    procedure ImportaDatos;
    procedure DoOnAcceptMessage;
  end;

var  BoxEmaForm: TBoxEmaForm = nil;

procedure ExportImportMovAlmacen;

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

       Gdm30Frm,

       dmi_mov,
       dmi_sto,

       dm_sto,
       dm_iex,
       dm_mov,
       dm_ddc,
       dm_art,
       dm_fdc,
       dm_tma,

       a_ddc,

       b_msg,
       b_pro,
       b_dir,

       cx_ddc,
       cx_pro,
       cx_tma,

       f_prg;

resourceString
  RsMsg1   = 'Error creando los ficheros de exportación.';
  RsMsg2   = 'Exportación de movimientos de almacén';
  RsMsg3   = 'Grabando datos en los ficheros ...';
  RsMsg4   = 'Copiando datos en [%s].';
  RsMsg5   = 'Importación de movimientos de almacén';
  RsMsg6   = 'Leyendo datos desde [%s].';
  RsMsg7   = 'Importando datos desde los ficheros ...';
  RsMsg8   = '¿Desea conservar los ficheros que acaba de importar?';
  RsMsg9   = 'Los ficheros no pertenecen al mismo Ejercicio.';
  RsMsg10  = 'Se cancela el proceso de importación.';
  RsMsg11  = 'Se ha interrumpido el proceso de exportacion/importación.';
  RsMsg12  = 'Es conveniente que revise el contenido de sus ficheros.';
  RsMsg13  = 'Suprimiendo ficheros ...';
  RsMsg14  = 'El documento %s %s %d ya existe. No puede ser importado.';
  RsMsg15  = 'Indique si desea cancelar ahora el proceso de importación.' + #13 + 'Si finaliza el proceso no se registrará ningún cambio en sus ficheros.';
  RsMsg16  = 'El documento %s %s %d no ha sido importado.';
  RsMsg17  = 'Se cancela el proceso.';
  RsMsg18  = 'Fecha %s';
  RsMsg22  = 'Destino';
  RsMsg23  = 'Origen';
  RsMsg24  = 'El albarán % s %s %d no tiene lineas.';
  RsMsg25  = 'Los tipos de movimiento permitidos son 1, 4, 5 y de 20 a 99.';

const

  ListaFicherosTexto  : TStringArray = [ 'Movimiento.txt',
                                         'LineaMovimiento.txt' ];

  TiposMovimientoExportacion : set of Byte = [ tmInventario,
                                               tmEntrada,
                                               tmSalida,
                                               tmMinimoUsuario..tmMaximoUsuario ];

  ListaFicheros : TStringArray = [ 'Articulo.nx1',
                                   'Movimiento.nx1',
                                   'LineaMovimiento.nx1' ];

procedure ExportImportMovAlmacen;
begin
     CreateEditForm( TBoxEmaForm, BoxEmaForm, TGds30Frm.AlmacenSection, True );
end;

procedure TBoxEmaForm.FormatoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With FormatoCtrl do
       begin
       If   EditValue=1
       then DataDestinoOrigen.Value := 0;  // Solo fichero
       DestinoOrigenCtrl.Enabled := EditValue=0;
       end;
end;

procedure TBoxEmaForm.FormManagerInitializeForm;
begin

     CloseWindowWhenFocusLost := True;

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     MovimientoAuxFields := TMovimientoFields.Create( MovimientoAuxTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
     ArticuloFields := TArticuloFields.Create( ArticuloTable );

     DsDireccionCorreoFields := TDireccionCorreoFields.Create( Self );

     DataFormato.Value := 0;
     DataProceso.Value := 0;
     DataDestinoOrigen.Value := 0;
     DataTodosLosTipos.Value := True;
     DataValorarInventarios.Value := False;
     DataPrecioCoste.Value := 0;
     DataFechaInicial.Value := ApplicationContainer.FirstDayOfYearDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataNroOperacionInicial.Value := 1;
     DataNroOperacionFinal.Value := 99999999;

end;

procedure TBoxEmaForm.FormManagerOkButton;

var  HeaderMsg : String;

begin
      case DataProceso.Value of
         0 : HeaderMsg := RsMsg2;
         1 : HeaderMsg := RsMsg5;
         end;
     CreateProcessForm( ExecuteProcess, HeaderMsg );
end;

procedure TBoxEmaForm.ExaminarButtonClick(Sender: TObject);
begin
     SelectDirectory( DataPath );
end;

procedure TBoxEmaForm.AbreFicherosExternos( Exportar : Boolean );
begin

     With ExportImport do
       case DataFormato.Value of
         0 : begin
             AbreFicherosExternos( [ ExternMovimientoTable,
                                     ExternLineaMovimientoTable,
                                     ExternArticuloTable ], Exportar );

             ExternMovimientoFields := TMovimientoFields.Create( ExternMovimientoTable );
             ExternLineaMovimientoFields := TLineaMovimientoFields.Create( ExternLineaMovimientoTable );
             ExternArticuloFields := TArticuloFields.Create( ExternArticuloTable );
             end;
         1 : begin
             AbreFicheroTextoExterno( MovimientoText, AddPathDelim( DataPath.Value ) + 'Movimiento.txt', Exportar );
             AbreFicheroTextoExterno( LineaMovimientoText, AddPathDelim( DataPath.Value ) + 'LineaMovimiento.txt', Exportar );
             end;
         end;
end;

procedure TBoxEmaForm.CierraFicherosExternos( Exportar : Boolean );
begin
     With ExportImport do
       case DataFormato.Value of
         0 : begin
             ExternMovimientoTable.Close;
             ExternLineaMovimientoTable.Close;
             ExternArticuloTable.Close;
             DataAccessModule.CloseInactiveLocalSessionResources;
             end;

         1 : begin
             CloseFile( MovimientoText  );
             CloseFile( LineaMovimientoText );
             end;
         end;
end;

procedure TBoxEmaForm.ExecuteProcess;

procedure ExportarMovimientos;

var  Procesar : Boolean;

procedure ProcesaMovimiento;
begin

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
         ExternLineaMovimientoTable.Post;

         Next;
         end;

       end;


     ExportImport.RecordProcessed := True;
end;

procedure ProcesaMovimientoTexto;
begin

     Writeln( MovimientoText, ExportImport.ExportRecordToText( MovimientoTable ) );

     With LineaMovimientoTable do
       begin

       With MovimientoFields do
         SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

       First;
       While not Eof do
         begin

         try
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
       HeaderList.Values[ RsTodosLosTipos ] := StrBoolean( TodosLosTiposCtrl.Checked );
       HeaderList.Values[ RsTipoMovimiento ] := TipoMovimientoCtrl.EditValue;
       If   PageControl.ActivePageIndex=0
       then begin
            HeaderList.Values[ RsNroOperacionInicial ] := IntToStr( NroOperacionInicialCtrl.EditValue );
            HeaderList.Values[ RsNroOperacionFinal ] := IntToStr( NroOperacionFinalCtrl.EditValue );
            end
       else begin
            HeaderList.Values[ RsFechaInicial ] := StrFormatDate( FechaInicialCtrl.EditValue );
            HeaderList.Values[ RsFechaFinal ] := StrFormatDate( FechaFinalCtrl.EditValue );
            end;
       If   ValorarInventariosCtrl.Enabled
       then begin
            HeaderList.Values[ RsValorarInventarios ] := StrBoolean( ValorarInventariosCtrl.Checked );
            HeaderList.Values[ RsValoracionInventario ] := ValoracionInventarioCtrl.Text;
            end;
       end;
end;

var CompressedFileName : String;

begin

     With ProcessFrame do
       begin

       try

         ExportImport.CleanExportDir;

         AbreFicherosExternos( True );

         try

           AddMsg( ntInformation, RsMsg3 );

           With MovimientoTable do
             begin

             If   PageControl.ActivePageIndex=0
             then begin
                  IndexFieldNames := 'Ejercicio;NroOperacion';
                  SetRange( [ ApplicationContainer.Ejercicio, DataNroOperacionInicial.Value ],
                            [ ApplicationContainer.Ejercicio, DataNroOperacionFinal.Value   ] );
                  end
             else begin
                  IndexFieldNames := 'Fecha';
                  SetRange( [ DataFechaInicial.Value ], [ DataFechaFinal.Value ] );
                  end;


             First;
             While not Eof and not Canceled do
               begin

               If   ( MovimientoFields.TipoMovimiento.Value in TiposMovimientoExportacion ) and
                    ( ( DataTodosLosTipos.Value ) or ( DataTipoMovimiento.Value=MovimientoFields.TipoMovimiento.Value ) )
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
                           CompressAndCopyFiles( ListaFicheros, SessionDataModule.ExportsDatabase.Path, StrDataPath, True );
                           SetBackupInfo( StrDataPath, tdAlbaranCompras, True );
                           end;

                  1 : begin

                      InsertaParametros;

                      If   DataFormato.Value=0
                      then CompressedFileName := SMTPCompressFiles( ListaFicheros, [], SessionDataModule.ExportsDatabase.Path )
                      else CompressedFileName := SMTPCompressFiles( ListaFicherosTexto, [], DataPath.Value );

                      SMTPInitDataPacket( tdAlbaranCompras, DsDireccionCorreoFields,  [ CompressedFileName ], True );
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
                    then DeCompressAndCopyFiles( StrDataPath, ListaFicheros );
                    end;
               ImportaDatos;
               end;

           1 : POP3Init( tdAlbaranCompras, 0, doOnAcceptMessage );
           end;

       except on e : exception do
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

procedure TBoxEmaForm.ValorarInventarios;

var  ExistenciasArticulo : IExistenciasArticulo;

begin

     //* Valorando los inventarios a importar

     If   DataValorarInventarios.Value and ( MovimientoFields.TipoMovimiento.Value=tmInventario )
     then With LineaMovimientoFields do
            If   CodigoArticulo.Value<>ArticuloManual
            then begin
                 ExistenciasArticulo := StockAlmacen.ObtenStock( CodigoArticulo.Value,
                                                                 False,
                                                                 CodigoClaseA.Value,
                                                                 CodigoClaseB.Value,
                                                                 CodigoClaseC.Value,
                                                                 True,
                                                                 '',
                                                                 True,
                                                                 '',
                                                                 True,
                                                                 '',
                                                                 True,
                                                                 MovimientoFields.Ejercicio.Value,
                                                                 0,
                                                                 MonthOf( MovimientoFields.Fecha.Value ) );

                 case DataPrecioCoste.Value of
                   0 : Precio.Value := ExistenciasArticulo.Coste;
                   1 : Precio.Value := ExistenciasArticulo.CosteMedio;
                   2 : Precio.Value := ExistenciasArticulo.CosteUltEntrada;
                   3 : Precio.Value := ArticuloFields.Precio_Compra.Value;
                   end;

                 end;

end;

procedure TBoxEmaForm.ImportaDatos;

var  AvisoCancelacion : Boolean;

procedure ProcesaMovimiento;

var  NroOperacionExterna : LongInt;

begin

     NroOperacionExterna := ExternMovimientoFields.NroOperacion.Value;

     With MovimientoTable do
       begin

       With ExternMovimientoFields do
         If   not DataRenumerarDocumentos.Value and
              FindKey( [ DataTipoMovimiento.Value, Ejercicio.Value, Propietario.Value, Serie.Value, NroDocumento.Value ] )
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
              If   DataRenumerarDocumentos.Value
              then MovimientoFields.NroDocumento.Value := Movimiento.ProximoDocumento( MovimientoFields );
              Post;

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

                  Articulo.Obten( LineaMovimientoFields.CodigoArticulo.Value, ArticuloFields );

                  ValorarInventarios;

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

                          LineaMovimientoFields.AsignacionOrigen.Clear;
                          LineaMovimientoFields.TipoMovimientoOrigen.Clear;
                          LineaMovimientoFields.EjercicioOrigen.Clear;
                          LineaMovimientoFields.NroOperacionOrigen.Clear;
                          LineaMovimientoFields.NroRegistroOrigen.Clear;
                          LineaMovimientoFields.UIDArticulo.AsGUID := Articulo.Identificador;
                          
                          LineaMovimientoFields.NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                          LineaMovimientoFields.NroRegistro.Clear;

                          Articulo.Obten( LineaMovimientoFields.CodigoArticulo.Value, ArticuloFields );

                          ValorarInventarios;

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
                     CompruebaEjercicio( ExternMovimientoFields.Fecha.Value );
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
                        0 : EraseListOfFiles( StrDataPath, [ BackupFileName, BackupInfoFileName, ListaFicheros[ 0 ], ListaFicheros[ 1 ], ListaFicheros[ 2 ] ], False );
                        1 : EraseListOfFiles( StrDataPath, ListaFicherosTexto, False );
                        end;
                      end;
       end;

end;

procedure TBoxEmaForm.DoOnAcceptMessage;
begin
     With ExportImport do
       DeCompressFiles( SessionDataModule.GetImportDirectory, ListaFicheros );
     ImportaDatos;
end;

procedure TBoxEmaForm.PathCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ValueIsEmpty( DisplayValue )
     then If   not DirectoryExists( DisplayValue )
          then begin
               Error := True;
               ErrorText := JoinMessage( rsgMsg394, rsgMsg395 );
               end;
end;

procedure TBoxEmaForm.ProcesoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With ProcesoCtrl do
      begin

      PageControl.Enabled := EditValue=0;
      TodosLosTiposCtrl.Enabled := EditValue=0;
      TipoMovimientoCtrl.Enabled:= ( EditValue=0 ) and not DataTodosLosTipos.Value;
      ValorarInventariosCtrl.Enabled := EditValue=1;
      ValoracionInventarioCtrl.Enabled := ( EditValue=1 ) and ( DataValorarInventarios.Value );

      With DestinoOrigenLabel do
       case ItemIndex of
         0 : Caption := RsMsg22;
         1 : Caption := RsMsg23;
         end;
      DireccionCorreoCtrl.Enabled := ( EditValue=0 ) and ( DataDestinoOrigen.Value=1 );
      RenumerarDocumentosCtrl.Enabled := EditValue=1;
      end;
end;

procedure TBoxEmaForm.ProveedorCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TBoxEmaForm.TipoMovimientoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposMovimientoAlmacen( Sender, True );
end;

procedure TBoxEmaForm.TipoMovimientoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  TipoMovimiento : SmallInt;

begin
     TipoMovimiento := VarToSmallInt( DisplayValue );
     If   TipoMovimiento in TiposMovimientoExportacion
     then TipoMovAlmacen.Valida( Sender, DisplayValue, ErrorText, Error )
     else begin
          Error := True;
          ErrorText := RsMsg25;
          end;
end;

procedure TBoxEmaForm.TodosLosTiposCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     TipoMovimientoCtrl.Enabled := not TodosLosTiposCtrl.Checked;
end;

procedure TBoxEmaForm.ValorarInventariosCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ValoracionInventarioCtrl.Enabled := ValorarInventariosCtrl.Checked;
end;

procedure TBoxEmaForm.DestinoOrigenCtrlPropertiesEditValueChanged( Sender: TObject);
begin
     With DestinoOrigenCtrl do
       begin
       PathCtrl.Enabled := EditValue=0;
       ExaminarButton.Enabled := EditValue=0;
       DireccionCorreoCtrl.Enabled := ( DataProceso.Value=0 ) and ( EditValue=1 );
       end;
end;

procedure TBoxEmaForm.DireccionCorreoCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntDireccionesCorreo( [ Sender.EditingValue ] );
end;

procedure TBoxEmaForm.DireccionCorreoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaDireccionesCorreo( Sender );
end;

procedure TBoxEmaForm.DireccionCorreoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     DireccionCorreo.Valida( Sender, tdAmbos, DisplayValue, ErrorText, Error, DsDireccionCorreoFields );
end;

end.
