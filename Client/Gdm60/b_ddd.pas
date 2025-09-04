
unit b_ddd;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB,
  DataManager, cxCheckBox, cxDBEdit, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxGroupBox, cxRadioGroup, cxMaskEdit, cxDropDownEdit,
  cxCalendar, nxdb, dxUIAClasses, dxSkinsCore, dxSkinsDefaultPainters,
  cxGraphics, cxLookAndFeels,cxLabel, dxmdaset,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,

  dmi_iex;


type
    TboxDddForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    FechaCtrl: TcxDBDateEdit;
    EnviarPorCorreoCtrl: TcxDBCheckBox;
    DireccionCorreoCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataFecha: TDateField;
    DataEnviarPorCorreo: TBooleanField;
    DataDireccionCorreo: TWideStringField;
    DataSource: TDataSource;
    DatosAEnviarCtrl: TcxDBRadioGroup;
    DataDatosAEnviar: TSmallintField;
    MovimientoTable: TnxeTable;
    LineaMovimientoTable: TnxeTable;
    ExportMovimientoTable: TnxeTable;
    ExportLineaMovimientoTable: TnxeTable;
    FacturaVentasTable: TnxeTable;
    ExportFacturaVentasTable: TnxeTable;
    EfectoTable: TnxeTable;
    ExportEfectoTable: TnxeTable;
    EfectoCobrarTable: TnxeTable;
    ExportEfectoCobrarTable: TnxeTable;
    EfectoCobrarAuxTable: TnxeTable;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    Label4: TcxLabel;
    Label6: TcxLabel;
    Label5: TcxLabel;
    Label7: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure FormManagerInitializeForm;
    procedure DataAfterInsert(DataSet: TDataSet);
    procedure DireccionCorreoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure DireccionCorreoCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure EnviarPorCorreoCtrlPropertiesChange(Sender: TObject);
    procedure DireccionCorreoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerOkButton;
    private

      MovimientoFields,
      ExportMovimientoFields : TMovimientoFields;
      LineaMovimientoFields,
      ExportLineaMovimientoFields : TLineaMovimientoFields;
      FacturaVentasFields,
      ExportFacturaVentasFields : TFacturaVentasFields;
      EfectoFields,
      ExportEfectoFields : TEfectoFields;
      EfectoCobrarFields,
      ExportEfectoCobrarFields : TEfectoCobrarFields;

      DsDireccionCorreoFields : TDireccionCorreoFields;

    public
      procedure DoProcess;
    end;

var  boxDddForm : TboxDddForm = nil;

procedure DescargaDatos;


implementation

uses   AppForm,
       Files,
       LibUtils,

       EnterpriseDataAccess,
       SessionDataAccess,
       AppManager,

       Gdm60Frm,

       dmi_mov,

       nxsdConst,

       dm_iex,
       dm_ddc,
       dm_rde,
       dm_mov,
       dm_pga,
       dm_pve,
       dm_eqm,

       a_pg60,
       a_ddc,

       b_msg,
       b_pro,

       cx_ddc,
       f_prg;

{$R *.DFM}

resourceString
       RsMsg1   = 'Los datos se han subido perfectamente.';
       RsMsg2   = 'No se ha podido crear el directorio de descarga en el equipo principal.'#13'Path : %s.';
       RsMsg3   = 'Los datos no han podido ser copiados o enviados.';
       RsMsg4   = 'Revise la configuración del correo y/o la conexión con el equipo principal.';
       RsMsg5   = 'Copiando datos a : %s.';
       RsMsg6   = 'Copiando el documento nº %s %d.';
       RsMsg7   = 'No se ha seleccionado ningún registro. Verifique los criterios de selección he inténtelo de nuevo.';
       RsMsg8   = 'Copiando el efecto cobrado nº %s %d/%d.';

procedure DescargaDatos;
begin
     CompruebaParametros;
     CreateEditForm( TBoxDddForm, BoxDddForm, TGds60Frm.PreventaSection, True );
end;

procedure TboxDddForm.FormManagerInitializeForm;
begin
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     ExportMovimientoFields := TMovimientoFields.Create( ExportMovimientoTable );

     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
     ExportLineaMovimientoFields := TLineaMovimientoFields.Create( ExportLineaMovimientoTable );

     FacturaVentasFields := TFacturaVentasFields.Create( FacturaVentasTable );
     ExportFacturaVentasFields := TFacturaVentasFields.Create( ExportFacturaVentasTable );

     EfectoFields := TEfectoFields.Create( EfectoTable );
     ExportEfectoFields := TEfectoFields.Create( ExportEfectoTable );

     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );
     ExportEfectoCobrarFields := TEfectoCobrarFields.Create( ExportEfectoCobrarTable );

     DsDireccionCorreoFields := TDireccionCorreoFields.Create( Self );
end;

procedure TboxDddForm.FormManagerOkButton;
begin
     CreateProcessForm( DoProcess, Caption );
end;

procedure TboxDddForm.DataAfterInsert(DataSet: TDataSet);
begin
     DataFecha.Value := ApplicationContainer.TodayDate;
     DataEnviarPorCorreo.Value := False;
     DataDatosAEnviar.Value := 0;
end;

procedure TboxDddForm.DoProcess;


const TargetTableNames : TStringArray = [ 'Movimiento.nx1',
                                          'LineaMovimiento.nx1',
                                          'EfectoCobrar.nx1',
                                          'FacturaVentas.nx1',
                                          'Efecto.nx1' ];

var   PreventaDir,
      FileName : String;
      Index : SmallInt;
      TextoPreventa : String;
      YaEnviado : Boolean;
      SourceTableNames : TStringArray;
      CompressedTableName : String;
      EnvioVacio : Boolean;

function IncluirRegistro : Boolean;
begin
     Result := ( ( DataDatosAEnviar.Value=0 ) and  not YaEnviado ) or
               ( ( DataDatosAEnviar.Value=1 ) and  YaEnviado ) or
               ( DataDatosAEnviar.Value=2 )
end;

begin

     With ProcessFrame do
       try

         AddMsg( ntHeader, Self.Caption );

         EnvioVacio := True;

         try

           ExportImport.CleanExportDir;

           SessionDataModule.ExportsDatabase.Open;

           SessionDataModule.ExportsDatabase.StartTransaction;  // Solo para acelerar el proceso de copia

           //** 02.08.2009  Suprimo el contenido de los ficheros de exportación por si el usuario repite el proceso

           ExportMovimientoTable.DeleteRecords;
           ExportLineaMovimientoTable.DeleteRecords;
           ExportFacturaVentasTable.DeleteRecords;
           ExportEfectoCobrarTable.DeleteRecords;
           ExportEfectoTable.DeleteRecords;

           With MovimientoTable, MovimientoFields do
             begin
             SetRange( [ tmPedidoVenta, DataFecha.Value ], [ tmVenta, DataFecha.Value ] );
             First;
             While not Eof do
               begin

               YaEnviado := RegistroExportacion.ExisteRegistro( tdrMovimiento, Ejercicio.Value, '', NroOperacion.Value, 0 );

               If   IncluirRegistro
               then With ExportMovimientoTable  do
                      begin

                      AddRecordMsg( Format( RsMsg6, [ Serie.Value, NroDocumento.Value ] ) );
                      EnvioVacio := False;

                      Append;
                      CopyFields( MovimientoTable );

                      RegistroExportacion.InsertaRegistro( tdrMovimiento, Ejercicio.Value, '', NroOperacion.Value, 0 );

                      With LineaMovimientoTable do
                        begin

                        SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

                        First;
                        While not Eof do
                          begin

                          With ExportLineaMovimientoTable do
                            begin
                            Append;
                            CopyFields( LineaMovimientoTable );

                            // Suprimo las posibles relaciones, que es evidente que no existirán en el servidor

                            With ExportLineaMovimientoFields do
                              begin
                              AsignacionOrigen.Clear;
                              TipoMovimientoOrigen.Clear;
                              EjercicioOrigen.Clear;
                              NroOperacionOrigen.Clear;
                              NroRegistroOrigen.Clear;
                              end;

                            Post;
                            end;

                          Next;
                          end;

                        end;

                      If   ( TipoMovimiento.Value=tmVenta ) and Facturado.Value
                      then If   not ExportFacturaVentasTable.FindKey( [ EjercicioFactura.Value, SerieFactura.Value, NroFactura.Value ] )
                           then If   FacturaVentasTable.FindKey( [ EjercicioFactura.Value, SerieFactura.Value, NroFactura.Value ] )
                                then begin

                                     With ExportFacturaVentasTable do
                                       begin
                                       Append;
                                       CopyFields( FacturaVentasTable );
                                       Post;
                                       end;

                                     With EfectoTable do
                                       begin

                                       With FacturaVentasFields do
                                         SetRange( [ Ejercicio.Value, scVentas, CodigoCliente.Value, Serie.Value, NroFactura.Value, 0 ],
                                                   [ Ejercicio.Value, scVentas, CodigoCliente.Value, Serie.Value, NroFactura.Value, MaxSmallint ] );

                                       First;
                                       While not Eof do
                                         begin

                                         With ExportEfectoTable do
                                           begin
                                           Append;
                                           CopyFields( EfectoTable );
                                           Post;
                                           end;

                                         Next;
                                         end;

                                       end;

                                     end;

                      Post;
                      end;

               Next;
               end;

             end;

           With EfectoCobrarTable, EfectoCobrarFields do
             begin
             SetRange( [ ApplicationContainer.Ejercicio, '', 1, 0 ], [ ApplicationContainer.Ejercicio, HighStrCode, MaxLongint, MaxSmallint ] );
             First;
             While not Eof do
               begin

               YaEnviado := RegistroExportacion.ExisteRegistro( tdrEfectoCobrar, Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfecto.Value );

               If   IncluirRegistro
               then With ExportEfectoCobrarTable do
                      begin

                      If   FechaCobro.Value=DataFecha.Value
                      then begin

                           Append;
                           CopyFields( EfectoCobrarTable );
                           Post;
                           RegistroExportacion.InsertaRegistro( tdrEfectoCobrar, Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfecto.Value );

                           EnvioVacio := False;
                           AddRecordMsg( Format( RsMsg8, [ Serie.Value, NroFactura.Value, NroEfecto.Value ] ) );
                           
                           //* 24.11.2009 Añadidos los posibles efectos reemitidos en el equipo móvil

                           If   not ValueIsEmpty( NroEfectoDiferencia.Value )
                           then If   EfectoCobrarAuxTable.FindKey( [ Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfectoDiferencia.Value ] )
                                then begin
                                     Append;
                                     CopyFields( EfectoCobrarAuxTable );
                                     Post;
                                     RegistroExportacion.InsertaRegistro( tdrEfectoCobrar, Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfectoDiferencia.Value );
                                     end;

                           end;
                      end;

               Next;
               end;

             end;


           finally
             SessionDataModule.ExportsDatabase.Commit;

             ExportMovimientoTable.Close;
             ExportLineaMovimientoTable.Close;
             ExportFacturaVentasTable.Close;
             ExportEfectoCobrarTable.Close;
             ExportEfectoTable.Close;

             SessionDataModule.ExportsDatabase.Session.CloseInactiveTables;
             end;

         If   EnvioVacio
         then AddMsg( ntError, RsMsg7 )
         else begin

              // En el mismo orden que TargetTableNames

              SourceTableNames := [ ExportMovimientoTable.TableName + '.nx1',
                                    ExportLineaMovimientoTable.TableName + '.nx1',
                                    ExportEfectoCobrarTable.TableName + '.nx1',
                                    ExportFacturaVentasTable.TableName + '.nx1',
                                    ExportEfectoTable.TableName + '.nx1' ];

              If   DataEnviarPorCorreo.Value
              then begin

                   With ExportImport do
                     begin

                     // TextoPreventa := ParametrosPreventaRec.CodigoEquipoMovil + '-' + FormatDateTime( 'dd/mm/yyyy', DataFecha.Value );

                     //* 22.03.2010 Los parámetros de preventa van ahora en las cabeceras opcionales

                     HeaderList.Values[ RsCodigoEmpresa ] := CodigoEmpresaActual;
                     HeaderList.Values[ RsNombreEmpresa ] := ApplicationContainer.Empresa_Nombre;
                     HeaderList.Values[ RsCodigoEquipoMovil ] := ParametrosPreventaRec.CodigoEquipoMovil;
                     HeaderList.Values[ RsNombreEquipoMovil ] := EquipoMovil.Descripcion( ParametrosPreventaRec.CodigoEquipoMovil, False );
                     HeaderList.Values[ RsFechaDescarga ] := FormatDateTime( 'dd/mm/yyyy', DataFecha.Value );

                     var CompressedFile := SMTPCompressFiles( SourceTableNames, TargetTableNames, SessionDataModule.ExportsDatabase.Path );

                     SMTPInitDataPacket( tdPreventa, DsDireccionCorreoFields, [ CompressedFile ], False );
                     SMTPSend;
                     end;

                   end
              else begin

                   // Los ficheros no se comprimen

                   With Configuracion.ParametrosGlbRec do
                     If   ( HostFTP<>'' ) and AccesoFTP
                     then begin
                          ExportImport.FTPInit;
                          Preventa.FijaDirectorioTrabajo( ParametrosPreventaRec.CodigoEquipoMovil, DataFecha.Value );
                          AddMsg( ntInformation, Format( RsMsg5, [ Preventa.DirectorioRemotoFTP ] ) );
                          For Index := 0 to High( SourceTableNames ) do
                            ExportImport.FTPPutFile( AddPathDelim( SessionDataModule.ExportsDatabase.Path ) + SourceTableNames[ Index ],
                                                     AddPathDelim( Preventa.DirectorioRemotoFTP, '/' ) + TargetTableNames[ Index ] );
                          end
                     else begin
                          Preventa.FijaDirectorioTrabajo( ParametrosPreventaRec.CodigoEquipoMovil, DataFecha.Value );
                          AddMsg( ntInformation, Format( RsMsg5, [ Preventa.DirectorioServidor ] ) );
                          For Index := 0 to High( SourceTableNames ) do
                            CopyFile( AddPathDelim( SessionDataModule.ExportsDatabase.Path ) + SourceTableNames[ Index ],
                                      AddPathDelim( Preventa.DirectorioServidor ) + TargetTableNames[ Index ] );

                          end;

                   AddMsg( ntInformation, RsMsg1 );
                   end;

              end;

       except on E : Exception do
         begin
         AddMsg( ntError, RsMsg3 );
         AddMsg( ntError, RsMsg4 );
         Abort;
         end;
       end;
end;

procedure TboxDddForm.EnviarPorCorreoCtrlPropertiesChange(Sender: TObject);
begin
     DireccionCorreoCtrl.Enabled:= EnviarPorCorreoCtrl.Checked;
end;

procedure TboxDddForm.DireccionCorreoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntDireccionesCorreo( [ Sender.EditingValue ] );
end;

procedure TboxDddForm.DireccionCorreoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaDireccionesCorreo( Sender, tdAmbos );
end;

procedure TboxDddForm.DireccionCorreoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     DireccionCorreo.Valida( Sender, tdAmbos, DisplayValue, ErrorText, Error, DsDireccionCorreoFields );
end;

end.

