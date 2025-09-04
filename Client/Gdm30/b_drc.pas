
unit b_drc;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,


  Mask,
  ComCtrls,
  CheckLst,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxCheckBox, cxDBEdit, cxCheckListBox, cxControls,
  cxContainer, cxEdit, cxTextEdit, nxdb,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox, nxllComponent, nxdbBackupController, cxCustomListBox,
  dxUIAClasses;


type
    TboxDrcForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    CodigoInicialCtrl: TcxDBTextEdit;
    CodigoFinalCtrl: TcxDBTextEdit;
    RutaTable: TnxeTable;
    EquipoMovilTable: TnxeTable;
    ConsumosClienteTable: TnxeTable;
    LineaRutaTable: TnxeTable;
    EfectoCobrarTable: TnxeTable;
    CheckListBox: TcxCheckListBox;
    ModificarListaCtrl: TcxDBCheckBox;
    VendedorTable: TnxeTable;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCodigoInicial: TWideStringField;
    DataCodigoFinal: TWideStringField;
    DataModificarLista: TBooleanField;
    gxRangeBox2: TgxRangeBox;
    Label7: TcxLabel;
    FicherosLabel: TcxLabel;
    Label2: TcxLabel;
    Label3: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    BackupController: TnxBackupController;
    BackupDatabase: TnxDatabase;
    RutasEquipoMovilTable: TnxeTable;
    procedure ModificarListaCtrlPropertiesChange(Sender: TObject);
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure BackupControllerIncludeTable(aSender: TnxBackupController; const aTableName: string; var aUseTable: Boolean);
    procedure BackupControllerTableProgress(aSender: TnxBackupController; aPercentDone: Integer);
    private

      ParametrosRec : TParametrosLWRec;
      FileList : TStringList;

    public

      RutaFields : TRutaFields;
      LineaRutaFields : TlineaRutaFields;
      ConsumosClienteFields : TConsumosClienteFields;
      EquipoMovilFields : TEquipoMovilFields;
      RutasEquipoMovilFields : TRutasEquipoMovilFields;
      EfectoCobrarFields : TEfectoCobrarFields;
      VendedorFields : TVendedorFields;
      ClienteFields : TClienteFields;
      ArticuloFields : TArticuloFields;

    procedure Descarga;
    end;

var  boxDrcForm : TboxDrcForm = nil;

procedure DescargaRutasyConsumos;


implementation

uses   LibUtils,

       AppManager,
       EnterpriseDataAccess,
       SessionDataAccess,
       DataAccess,

       Files,
       DateUtils,

       nxsdConst,

       Gdm30Frm,

       dmi_mov,

       dm_cli,
       dm_art,
       dm_iva,
       dm_mov,
       dm_ecc,
       dm_pve,
       dm_iex,
       dm_pga,
       dm_eqm,

       b_msg,
       b_pro,

       cx_eqm,

       f_prg;

{$R *.DFM}

resourceString
       RsMsg2  = 'La ruta incluida en el equipo móvil [%s] no existe.';
       RsMsg3  = 'El proceso NO se ha realizado correctamente.';
       RsMsg4  = 'Corrija el error y repita el proceso.' + #13 + 'NO UTILICE los ficheros que se acaban de generar, pues contienen información incompleta.';
       RsMsg5  = 'Ruta %s, cliente %s.';
       RsMsg6  = 'Ahora puede utilizar los equipos móviles para actualizar los datos sobre rutas y consumos de clientes.';
       RsMsg7  = 'Equipo móvil %s.';
       RsMsg8  = 'El cliente de código %s ha sido dado de baja.';
       RsMsg9  = 'Datos comunes a todos los equipos.';
       RsMsg10 = 'Los datos se han copiado en %s.';

const  NombreTablaArticulos = 'Articulo';

procedure DescargaRutasyConsumos;
begin
     CreateEditForm( TBoxDrcForm, BoxDrcForm, TGds30Frm.VentasSection, True );
end;

procedure TboxDrcForm.FormManagerOkButton;
begin
     CreateProcessForm( Descarga, Caption );
     ExportImport.GuardaRelacionFicheros( ctRelFichPreventa, CheckListBox, ParametrosRec );
end;

procedure TboxDrcForm.ModificarListaCtrlPropertiesChange(Sender: TObject);
begin
     FicherosLabel.Enabled := ModificarListaCtrl.Checked;
     CheckListBox.Enabled  := ModificarListaCtrl.Checked;
end;

procedure TboxDrcForm.Descarga;

var   Index : SmallInt;
      RutaActual : String;
      Correct,
      EsUnaOferta : Boolean;
      Precio : Double;
      Dummy,
      ImporteBruto,
      DescuentoArticulo,
      ImporteNeto  : Decimal;
      PrecioTarifaCliente : Double;
      PrecioIVA,
      ImporteTotal : Decimal;

      FechaInicial,
      FechaFinal : TDateTime;

procedure CopiaFicheroFTP( TableName : string );
begin
     ExportImport.FTPPutFile( AddPathDelim( Preventa.DirectorioDirectoExportacion ) + TableName + '.nx1',
                              AddPathDelim( Preventa.DirectorioRemotoFTP, '/' ) + TableName + '.nx1' )
end;

procedure CopiaFichero( TableName : string );
begin
     CopyFile( AddPathDelim( Preventa.DirectorioDirectoExportacion ) + TableName + '.nx1',
               AddPathDelim( Preventa.DirectorioServidor ) + TableName + '.nx1' );
end;

begin

     With ProcessFrame do
       try

         try

           With Configuracion.ParametrosGlbRec do
             If   ( HostFTP<>'' ) and AccesoFTP
             then ExportImport.FTPInit;

          // Exportando ficheros comunes

          AddMsg( ntInformation, RsMsg9 );

          Preventa.FijaDirectorioTrabajo;

          // Limpio el directorio de exportación

          EraseFile( AddPathDelim( Preventa.DirectorioExportacion ) + '*.*' );

          FileList := TStringList.Create;
          try

            ExportImport.ObtenRelacionFicheros( CheckListBox, FileList );  // Solo los nombres de tabla
            If   FileList.IndexOf( NombreTablaArticulos )=-1
            then FileList.Add( NombreTablaArticulos );

            BackupDatabase.Session := DataAccessModule.AppDatabase.Session;
            BackupDatabase.AliasPath := AddPathDelim( Preventa.DirectorioExportacion );

            With BackupController do
              try
                Active := False;
                OriginalDatabase := EnterpriseDataModule.UserDatabase;
                CloneDatabase := BackupDatabase;
                Backup;
              finally
                Active := False;
                BackupDatabase.Active := False;
                end;

            With Configuracion.ParametrosGlbRec do
              If   AccesoFTP and ( HostFTP<>'' )
              then begin
                   With FileList do
                     For Index := 0 to Count - 1 do
                       CopiaFicheroFTP( Strings[ Index ] );
                   AddMsg( ntInformation, Format( RsMsg10, [ Preventa.DirectorioRemotoFTP ] ) );
                   end
              else begin
                   With FileList do
                     For Index := 0 to Count - 1 do
                       CopiaFichero( Strings[ Index ] );
                   AddMsg( ntInformation, Format( RsMsg10, [ Preventa.DirectorioServidor ] ) );
                   end;

          finally
            FileList.Free;
            end;

          With EquipoMovilTable do
            begin
            SetRange( [ DataCodigoInicial.Value ], [ DataCodigoFinal.Value ] );
            First;
            While not Eof and not Canceled do
              begin

              Preventa.FijaDirectorioTrabajo( EquipoMovilFields.Codigo.Value );

              EraseFile( AddPathDelim( Preventa.DirectorioDirectoExportacion ) + '*.*' );

              AddMsg( ntInformation, Format( RsMsg7, [ Preventa.EquipoMovilActual ] ) );

              // Abro y creo los ficheros de exportación de datos

              Preventa.AbreFicherosExportacion;

              Correct := False;

              try

                  With Preventa do
                    begin

                    InsertaRegistro( [ EquipoMovilActual ], ExpEquipoMovilTable, EquipoMovilTable );

                    If   VendedorTable.FindKey( [ EquipoMovilFields.CodigoVendedor ] )
                    then InsertaRegistro( [ EquipoMovilFields.CodigoVendedor.Value ], ExpVendedorTable, VendedorTable );
                    end;

                  RutasEquipoMovilTable.SetRange( [ Preventa.EquipoMovilActual ] );  // CodigoEquipoMovil;NroOrden;CodigoRuta
                  RutasEquipoMovilTable.First;
                  While not RutasEquipoMovilTable.Eof do
                    begin
                    RutaActual := RutasEquipoMovilFields.CodigoRuta.Value;
                    If   RutaActual<>''
                    then If   RutaTable.FindKey( [ RutaActual ] )
                         then begin

                              With Preventa do
                                InsertaRegistro( [ RutaActual ], ExpRutaTable, RutaTable );

                              With LineaRutaTable do
                                begin
                                SetRange( [ RutaFields.Codigo.Value, 1 ], [ RutaFields.Codigo.Value, MaxSmallint ] );
                                First;
                                While not Eof do
                                  begin

                                  With LineaRutaFields do
                                    begin

                                    With LineaRutaFields, Preventa do
                                      InsertaRegistro( [ CodigoRuta.Value, NroOrden.Value ], ExpLineaRutaTable, LineaRutaTable );

                                    With Cliente do
                                      If   DmClienteTable.FindKey( [ CodigoCliente.Value ] )
                                      then With Preventa do
                                             InsertaRegistro( [ CodigoCliente.Value ], ExpClienteTable, DmClienteTable )
                                      else begin
                                           ShowNotification( ntStop, Format( RsMsg8, [ CodigoCliente.Value ] ), '' );
                                           Abort;
                                           end;

                                    // Exportando los consumos

                                    With ConsumosClienteTable do
                                      begin
                                      SetRange( [ CodigoCliente.Value, 0 ], [ CodigoCliente.Value, MaxSmallint ] );
                                      First;

                                      While not Eof and not Canceled do
                                        begin

                                        AddRecordMsg( Format( RsMsg5, [ RutaFields.Codigo.Value, CodigoCliente.Value ] ) );

                                        PrecioTarifaCliente := 0.0;
                                        Dummy := 0.0;
                                        EsUnaOferta := False;

                                        Articulo.ObtenPrecioyDtoVenta( tmNoDefinido,
                                                                       CodigoCliente.Value,
                                                                       ConsumosClienteFields.CodigoArticulo.Value,
                                                                       '',
                                                                       '',
                                                                       '',
                                                                       Dummy,
                                                                       PrecioTarifaCliente,
                                                                       Dummy,
                                                                       Dummy,
                                                                       Dummy,
                                                                       EsUnaOferta,
                                                                       '',
                                                                       False,
                                                                       ApplicationContainer.TodayDate );

                                        With ConsumosClienteFields, Preventa do
                                          Preventa.InsertaRegistro( [ CodigoCliente.Value, NroOrden.Value ], ExpConsumosClienteTable, ConsumosClienteTable );

                                        Next;
                                        end;

                                      end;

                                    // Y ahora los efectos pendientes de cobrar

                                    Cliente.Obten( CodigoCliente.Value, '', ClienteFields );

                                    FechaInicial := IncYear( ApplicationContainer.TodayDate, -3 );   //* 20.10.2010  Ampliado a 3 ejercicios (la  crisis, ya se sabe)
                                    FechaFinal := ApplicationContainer.TodayDate;

                                    With EfectoCobrarTable do
                                      begin
                                      SetRange( [ ClienteFields.Subcuenta.Value, FechaInicial ], [ ClienteFields.Subcuenta.Value, FechaFinal ] );
                                      First;
                                      While not Eof and not Canceled do
                                        begin

                                        If   EfectoCobrar.EfectoPendiente( EfectoCobrarFields )
                                        then With Preventa, EfectoCobrarFields do
                                               InsertaRegistro( [ Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfecto.Value ], ExpEfectoCobrarTable, EfectoCobrarTable );

                                        Next;
                                        end;

                                      end;

                                    end;

                                  Next;
                                  end;

                                end;

                              end
                         else AddMsg( ntError, Format( RsMsg2, [ RutaActual ] ) );

                    If   Canceled
                    then Abort;

                    RutasEquipoMovilTable.Next;
                    end;

                  Correct := True;

              finally
                Preventa.CierraFicherosExportacion( Correct );
                end;

              Next;
              end;

            end;

            AddMsg( ntInformation, RsgMsg435 );
            AddMsg( ntInformation, RsMsg6 );

          except on E : Exception do begin
                                     ShowException( E, Self );
                                     AddMsg( ntError, RsMsg3 );
                                     AddMsg( ntError, RsMsg4 );
                                     end;
                end;

      finally

        With Configuracion.ParametrosGlbRec do
           If   ( HostFTP<>'' ) and AccesoFTP
           then ExportImport.FTPClient.Close;

        end;

end;

procedure TboxDrcForm.FormManagerInitializeForm;
begin
     RutaFields := TRutaFields.Create( RutaTable );
     LineaRutaFields := TLineaRutaFields.Create( LineaRutaTable );
     ConsumosClienteFields := TConsumosClienteFields.Create( ConsumosClienteTable );
     EquipoMovilFields := TEquipoMovilFields.Create( EquipoMovilTable );
     RutasEquipoMovilFields := TRutasEquipoMovilFields.Create( RutasEquipoMovilTable );
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );
     VendedorFields := TVendedorFields.Create( VendedorTable );

     ClienteFields := TClienteFields.Create( Self );
     ArticuloFields := TArticuloFields.Create( Self );

     DataCodigoFinal.Value := HighStrCode;
     DataModificarLista.Value := False;

     ExportImport.CargaRelacionFicheros( ctRelFichPreventa, CheckListBox, ParametrosRec );
    
end;

procedure TboxDrcForm.BackupControllerIncludeTable(       ASender    : TnxBackupController;
                                                    const ATableName : string;
                                                    var   AUseTable  : Boolean );
begin
     AUseTable := FileList.IndexOf( ATableName)<>-1;
     If   AUseTable
     then ProcessFrame.AddMsg( ntInformation, ATableName );
end;

procedure TboxDrcForm.BackupControllerTableProgress(aSender: TnxBackupController; aPercentDone: Integer);
begin
     Application.ProcessMessages;
     If   ProcessFrame.Canceled
     then Abort;
end;

procedure TboxDrcForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEquiposMoviles( Sender );
end;

procedure TboxDrcForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     EquipoMovil.Valida( Sender, DisplayValue, Errortext, Error, True );
end;

end.
