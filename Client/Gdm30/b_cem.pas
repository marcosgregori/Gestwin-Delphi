
unit b_cem;

{$I-}

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  Mask, ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxCheckBox, cxDBEdit, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, nxdb, dxSkinsCore,
  dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox,

  AppContainer,
  Gim10Fields,
  Gim30Fields,

  dmi_iex, dxUIAClasses;


type
    TboxCemForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    EquipoMovilInicialCtrl: TcxDBTextEdit;
    EquipoMovilFinalCtrl: TcxDBTextEdit;
    FechaCtrl: TcxDBDateEdit;
    LineaMovimientoTable: TnxeTable;
    MovimientoTable: TnxeTable;
    EfectoCobrarTable: TnxeTable;
    FacturaVentasTable: TnxeTable;
    RenumerarCtrl: TcxDBCheckBox;
    RecibirPorCorreoCtrl: TcxDBCheckBox;
    Data: TgxMemData;
    DataFecha: TDateField;
    DataRecibirPorCorreo: TBooleanField;
    DataSource: TDataSource;
    DataEquipoMovilInicial: TWideStringField;
    DataEquipoMovilFinal: TWideStringField;
    DataRenumerar: TBooleanField;
    gxRangeBox1: TgxRangeBox;
    Label7: TcxLabel;
    Label2: TcxLabel;
    Label6: TcxLabel;
    Label5: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    EfectoTable: TnxeTable;
    EquipoMovilTable: TnxeTable;
    procedure DataNewRecord(DataSet: TDataSet);
    procedure EquipoMovilCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure EquipoMovilCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure RecibirPorCorreoCtrlPropertiesChange(Sender: TObject);
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    private

     EquipoMovilFields : TEquipoMovilFields;

     procedure DoOnAcceptMessage;
     procedure ProcesaEquipoMovil;
    public

      MovimientoFields : TMovimientoFields;
      LineaMovimientoFields : TLineaMovimientoFields;
      EfectoCobrarFields : TEfectoCobrarFields;
      FacturaVentasFields : TFacturaVentasFields;
      EfectoFields : TEfectoFields;
      ClienteFields : TClienteFields;

      CodigoEquipoMovil : String;

      procedure DoProcess;
    end;

var  boxCemForm : TboxCemForm = nil;

procedure CargaEquiposMoviles;


implementation

uses   Variants,
       Files,
       LibUtils,
       AppManager,
       DataAccess,
       EnterpriseDataAccess,
       SessionDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dmi_mov,

       dm_pga,
       dm_reg,
       dm_cli,
       dm_art,
       dm_iva,
       dm_mov,
       dm_sto,
       dm_tma,
       dm_ecc,
       dm_ast,
       dm_sub,
       dm_pve,
       dm_iex,
       dm_eqm,

       b_msg,
       b_pro,

       cx_eqm,
       f_prg;

{$R *.DFM}

resourceString
       RsMsg2  = 'El albarán de venta %s %d está facturado.';
       RsMsg3  = 'No se aceptan albaranes facturados en los procesos de preventa/autoventa cuando está activa la opción de renumeración.'#13'Este albarán y la correspondiente factura serán omitidos.';
       RsMsg5  = 'Procesando el equipo %s.';
       RsMsg6  = 'Puede revisar los documentos importados con las ventanas de mantenimiento correspondientes.';
       RsMsg7  = 'Equipo móvil %s.';
       RsMsg8  = '%8d del cliente %s, %s.';
       RsMsg9  = '%s %8d del cliente %s, %s.';
       RsMsg10 = 'COBROS';
       RsMsg11 = '%s %8d/%2d por un importe de %.2f euros, del cliente %s - %s';
       RsMsg12 = 'El efecto a cobrar %s %d/%d ha sido dado de baja. No se puede anotar el cobro.';
       RsMsg13 = 'Importe total cobrado : %.2f euros.';
       RsMsg14 = 'Anotado el cobro del/los efecto/s :';
       RsMsg15 = 'PEDIDOS';
       RsMsg16 = 'ALBARANES';
       RsMsg17 = 'Ya existe el albarán %s %d.'#13'Si desea que los documentos se renumeren marque la opción correspondiente en la ventana del proceso.';
       RsMsg18 = 'No se han encontrado datos del equipo móvil %s de fecha %s.'#13'El path a los datos utilizado es %s';
       RsMsg19 = 'Reemitido. Se ha creado en el equipo móvil el efecto :';
       RsMsg20 = 'El efecto a cobrar %s %d/%d ya existe. No puedo importarse el efecto generado por la diferencia de cobro en el equipo móvil.';
       RsMsg21 = 'No se ha encontrado la factura %s %d asignada al albarán %s %d.';
       RsMsg22 = 'Se importará el albaran como no facturado.';
       RsMsg23 = 'La factura %s %d asignada al albarán %s %d ya existe.';
       RsMsg24 = 'El formato del fichero a importar no es el adecuado.';
       RsMsg25 = 'Se cancela el proceso de importación.';
       RsMsg26 = 'Se han sumprimido los datos de importación del equipo móvil %s.';
       
       // Parámetros del registro

       ncrRenumDocEquiposMoviles   = 'RenumDocEquiposMoviles';

const ListaFicheros : TStringArray = [ 'Movimiento.nx1',
                                       'LineaMovimiento.nx1',
                                       'EfectoCobrar.nx1',
                                       'FacturaVentas.nx1',
                                       'Efecto.nx1' ];

procedure CargaEquiposMoviles;
begin
     CreateEditForm( TBoxCemForm, BoxCemForm, TGds30Frm.VentasSection, True );
end;

procedure TboxCemForm.FormManagerOkButton;
begin
     Registro.GuardaValorUsuario( ncrRenumDocEquiposMoviles, BoolToStr( DataRenumerar.Value ) );
     CreateProcessForm( DoProcess, Caption );
end;

procedure TboxCemForm.DataNewRecord(DataSet: TDataSet);
begin
     DataRecibirPorCorreo.Value := False;
     DataFecha.Value := ApplicationContainer.TodayDate;
     DataEquipoMovilInicial.Value := '';
     DataEquipoMovilFinal.Value := HighStrCode;
     DataRenumerar.Value := False;
end;

procedure TBoxCemForm.DoOnAcceptMessage;

var  FechaDescarga : TDate;

begin
     With ExportImport do
       try

         // EL texto opcional de Preventa es 01-01/06/2005 : CodigoEquipoMovil-Fecha descarga

         //* 22.03.2010 Los parámetros de preventa van ahora en la cabecera

         CodigoEquipoMovil := HeaderList.Values[ RsCodigoEquipoMovil ];
         If   CodigoEquipoMovil=''
         then If   HeaderList.Count>=3
              then CodigoEquipoMovil := HeaderList.ValueFromIndex[ 2 ]
              else begin
                   ShowNotification( ntStop, RsMsg24, RsMsg25 );
                   Abort;
                   end;

         FechaDescarga := StrToDate( HeaderList.Values[ RsFechaDescarga ] );

         {
         Preventa.FijaDirectorioTrabajo( CodigoEquipoMovil, FechaDescarga );
         CopyFile( AddPathDelim( SessionDataModule.GetImportDirectory ) + BackupFileName,
                   AddPathDelim( SessionDataModule.ImportsDatabase.Path ) + BackupFileName );
         }

         DeCompressFiles( SessionDataModule.ImportsDatabase.Path, ListaFicheros );

         ProcesaEquipoMovil;

       except
         ProcessFrame.Canceled := True;
         end;
end;

procedure TBoxCemForm.ProcesaEquipoMovil;

var   FileName,
      DataPath,
      PathFicheroMovimientos : String;

      TotalImporteCobrado : Decimal;
      MensajeCobros,
      LineaInsertada : Boolean;

      Bm : TBookMark;

procedure LimpiaAlbaranFacturado;
begin
     ShowNotification( ntWarning, RsMsg22 );

     With MovimientoFields do
       begin
       EjercicioFactura.Clear;
       SerieFactura.Clear;
       PropietarioFactura.Clear;
       NroFactura.Clear;
       Facturado.Value := False;
       end;
end;

begin

     ShowNotification( ntInformation, Format( RsMsg7, [ CodigoEquipoMovil ] ) );

     MensajeCobros := False;
     TotalImporteCobrado := 0.0;

     // Abro los ficheros de importacion de datos

     PathFicheroMovimientos := AddPathDelim( SessionDataModule.ImportsDatabase.Path ) + Preventa.ImpMovimientoTable.TableName + '.nx1';

     If   not FileExists( PathFicheroMovimientos )
     then ShowNotification( ntError, Format( RsMsg18, [ CodigoEquipoMovil, StrFormatDate( Preventa.FechaDescarga ), Preventa.DirectorioServidor ] ) )
     else With Preventa do
            begin

            ProcessFrame.Error := False;    // Como estoy obligado a seguir aunque se produzca un error en un equipo anterior, tengo que reiniciar los valores.
            ProcessFrame.Canceled := False;

            AbreFicherosImportacion;

            EnterpriseDataModule.StartTransaction;

            try

              try

                // Pedidos de venta

                ShowNotification( ntInformation, RsMsg15 );

                With ImpMovimientoTable do
                  begin

                  IndexFieldNames := 'TipoMovimiento;Fecha';

                  SetRange( [ tmPedidoVenta ], [ tmPedidoVenta ] );

                  First;
                  While not Eof and not ProcessFrame.Canceled do
                    begin

                    With MovimientoTable, MovimientoFields do
                      begin

                      CompruebaEjercicio( ImpMovimientoFields.Fecha.Value );

                      Append;
                      CopyFields( ImpMovimientoTable );

                      NroDocumento.Value := Movimiento.ProximoDocumento( MovimientoFields );
                      NroOperacion.Value := Movimiento.ProximaOperacion;
                      Origen.Value := omPreventa;

                      //* 05.03.2007 Aplicando estos valores por defecto por si no han sido fijados en el equipo móvil

                      If   Cliente.Obten( Propietario.Value, '', ClienteFields )
                      then SetFieldValueIfEmpty( CodigoFormaCobro, ClienteFields.Cobro_FormaCobro.Value );

                      Post;

                      ShowNotification( ntInformation, Format( RsMsg8, [ NroDocumento.Value, Propietario.Value, Cliente.Descripcion( Propietario.Value, True ) ] ) );
                      end;

                    LineaInsertada := False;

                    With ImpLineaMovimientoTable do
                      begin

                      With ImpMovimientoFields do
                        SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

                      First;
                      While not Eof and not ProcessFrame.Canceled do
                        begin

                        If   ( ImpLineaMovimientoFields.CodigoArticulo.Value=ArticuloManual ) or ( ImpLineaMovimientoFields.Cantidad.Value<>0.0 )
                        then With LineaMovimientoTable do
                               begin

                               Append;
                               CopyFields( ImpLineaMovimientoTable );

                               LineaMovimientoFields.NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                               LineaMovimientoFields.NroRegistro.Clear;

                               Post;
                               LineaInsertada := True;

                               StockAlmacen.ActualizaStock( MovimientoFields, LineaMovimientoFields );

                               end;

                        Next;
                        end;

                      If   LineaInsertada
                      then Movimiento.CompruebaPrimerNroPagina( MovimientoFields )
                      else MovimientoTable.Delete;

                      end;

                    Next;
                    end;

                  end;
                  
                // Albaranes de venta
              
                If   not ProcessFrame.Canceled
                then With ImpMovimientoTable do
                       begin

                       ShowNotification( ntInformation, RsMsg16 );
                       
                       SetRange( [ tmVenta], [ tmVenta ] );
                       First;
                       While not Eof and not ProcessFrame.Canceled do
                         begin

                         CompruebaEjercicio( ImpMovimientoFields.Fecha.Value );

                         With MovimientoTable, MovimientoFields do
                           If   DataRenumerar.Value and ImpMovimientoFields.Facturado.Value
                           then begin
                                With ImpMovimientoFields do
                                  ShowNotification( ntWarning, Format( RsMsg2, [ Serie.Value, NroDocumento.Value ] ) );
                                end
                           else If   not DataRenumerar.Value and MovimientoTable.FindKey( [ ImpMovimientoFields.TipoMovimiento.Value, ImpMovimientoFields.Ejercicio.Value, ImpMovimientoFields.Serie.Value, ImpMovimientoFields.NroDocumento.Value ] )
                                then begin
                                     With ImpMovimientoFields do
                                       ShowNotification( ntStop, Format( RsMsg17, [ Serie.Value, NroDocumento.Value ] ) );
                                     Abort;
                                    end
                               else begin
    
                                    Append;
                                    CopyFields( ImpMovimientoTable );
    
                                    NroOperacion.Value := Movimiento.ProximaOperacion;

                                    If   DataRenumerar.Value
                                    then NroDocumento.Value := Movimiento.ProximoDocumento( MovimientoFields );
    
                                    //* 05.03.2007 Aplicando estos valores por defecto por si no han sido fijados en el equipo móvil
    
                                    If   Cliente.Obten( Propietario.Value, '', ClienteFields )
                                    then begin
                                         SetFieldValueIfEmpty( CodigoFormaCobro, ClienteFields.Cobro_FormaCobro.Value );
                                         SetFieldValueIfEmpty( GrupoFacturacion, ClienteFields.Factura_Agrupacion.Value );
                                         end;
    
                                    ShowNotification( ntInformation, Format( RsMsg9, [ Serie.Value, NroDocumento.Value, Propietario.Value, Cliente.Descripcion( Propietario.Value, True ) ] ) );

                                    LineaInsertada := False;
    
                                    With ImpLineaMovimientoTable do
                                      begin
    
                                      With ImpMovimientoFields do
                                        SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );
    
                                      First;
                                      While not Eof do
                                        begin

                                        With LineaMovimientoTable do
                                          If   ( ImpLineaMovimientoFields.CodigoArticulo.Value=ArticuloManual ) or ( ImpLineaMovimientoFields.Cantidad.Value<>0.0 )
                                          then begin
    
                                               Append;
                                               CopyFields( ImpLineaMovimientoTable );
    
                                               LineaMovimientoFields.NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                                               LineaMovimientoFields.NroRegistro.Clear;

                                               Post;
                                               LineaInsertada := True;
                                               StockAlmacen.ActualizaStock( MovimientoFields, LineaMovimientoFields );
                                               end;

                                        Next;
                                        end;

                                      If   LineaInsertada
                                      then begin

                                           // Comprobando si está facturado

                                           If   Facturado.Value
                                           then If   ImpFacturaVentasTable.FindKey( [ ImpMovimientoFields.EjercicioFactura.Value, ImpMovimientoFields.SerieFactura.Value, ImpMovimientoFields.NroFactura.Value ] )
                                                then With FacturaVentasTable do
                                                       begin
                                                       If   FindKey( [ ImpMovimientoFields.EjercicioFactura.Value, ImpMovimientoFields.SerieFactura.Value, ImpMovimientoFields.NroFactura.Value ] )
                                                       then begin
                                                            With ImpMovimientoFields do
                                                              ShowNotification( ntWarning, Format( RsMsg23, [ SerieFactura.Value, NroFactura.Value, Serie.Value, NroDocumento.Value ] ) );
                                                            LimpiaAlbaranFacturado;
                                                            end
                                                       else begin
                                                            Append;
                                                            CopyFields( ImpFacturaVentasTable );
                                                            Post;

                                                            With ImpEfectoTable do
                                                              begin

                                                              With FacturaVentasFields do
                                                                SetRange( [ Ejercicio.Value, scVentas, CodigoCliente.Value, Serie.Value, NroFactura.Value, 0 ],
                                                                          [ Ejercicio.Value, scVentas, CodigoCliente.Value, Serie.Value, NroFactura.Value, MaxSmallint ] );

                                                              First;
                                                              While not Eof do
                                                                begin

                                                                With EfectoTable do
                                                                  begin
                                                                  Append;
                                                                  CopyFields( ImpEfectoTable );
                                                                  Post;
                                                                  end;

                                                                Next;
                                                                end;

                                                              end;
                                                            end;
                                                       end
                                                else begin
                                                     With ImpMovimientoFields do
                                                       ShowNotification( ntWarning, Format( RsMsg21, [ SerieFactura.Value, NroFactura.Value, Serie.Value, NroDocumento.Value ] ) );
                                                     LimpiaAlbaranFacturado;
                                                     end;

                                           Movimiento.CompruebaPrimerNroPagina( MovimientoFields );
                                           MovimientoTable.Post;
                                           end
                                      else MovimientoTable.Cancel;

                                  end;

                           end;

                         Next;
                         end;

                       end;
                
                // Comprobando si hay algún efecto cobrado

                If   not ProcessFrame.Canceled
                then With ImpEfectoCobrarTable do
                       begin
                       First;
                       While not Eof do
                         begin

                         With ImpEfectoCobrarFields do
                           If   ImporteCobrado.Value<>0.0
                           then If   EfectoCobrarTable.FindKey( [ Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfecto.Value ] )
                                 then begin

                                      If   ValueIsEmpty( EfectoCobrarFields.FechaCobro.Value )  // Solo si consta como pendiente de cobro
                                      then begin

                                           EfectoCobrarTable.Edit;

                                           EfectoCobrarFields.FechaCobro.Value := FechaCobro.Value;
                                           EfectoCobrarFields.ImporteCobrado.Value := ImporteCobrado.Value;
                                           EfectoCobrarFields.ConceptoCobro.Value := ConceptoCobro.Value;

                                           EfectoCobrar.ActualizaAnotacionCobro( EfectoCobrarFields );

                                           DecAdd( TotalImporteCobrado, ImporteCobrado.Value );

                                           If   not MensajeCobros
                                           then begin
                                                ShowNotification( ntInformation, RsMsg10 );
                                                ShowNotification( ntInformation, RsMsg14 );
                                                MensajeCobros := True;
                                                end;

                                           ShowNotification( ntInformation, Format( RsMsg11, [ Serie.Value,
                                                                                               NroFactura.Value,
                                                                                               NroEfecto.Value,
                                                                                               ImporteCobrado.Value,
                                                                                               SubcuentaCliente.Value,
                                                                                               Cuenta.Descripcion( SubcuentaCliente.Value, True, False ) ] ) );

                                          //** 24.11.2009 Gestión de efectos reemitidos

                                          If   not ValueIsEmpty( NroEfectoDiferencia.Value )
                                          then try
                                                 Bm := GetBookMark;

                                                 If   not EfectoCobrarTable.FindKey( [ Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfectoDiferencia.Value ] )
                                                 then begin
                                                      If   FindKey( [ Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfectoDiferencia.Value ] )
                                                      then With EfectoCobrarTable do
                                                             begin

                                                             Append;
                                                             CopyFields( ImpEfectoCobrarTable );
                                                             Post;

                                                             ShowNotification( ntInformation, RsMsg19 );
                                                             ShowNotification( ntWarning, Format( RsMsg11, [ Serie.Value,
                                                                                                             NroFactura.Value,
                                                                                                             NroEfecto.Value,
                                                                                                             Importe.Value,
                                                                                                             SubcuentaCliente.Value,
                                                                                                             Cuenta.Descripcion( SubcuentaCliente.Value, True, False ) ] ) );
                                                             end;
                                                      end
                                                 else ShowNotification( ntWarning, Format( RsMsg20, [ Serie.Value, NroFactura.Value, NroEfectoDiferencia.Value ] ) );

                                               finally
                                                 GotoBookMark( Bm )
                                                 end;

                                           end;

                                      end
                                else ShowNotification( ntWarning, Format( RsMsg12, [ Serie.Value, NroFactura.Value, NroEfecto.Value ] ) );

                         Next;
                         end;

                       end;

                If   MensajeCobros
                then ShowNotification( ntInformation, Format( RsMsg13, [ TotalImporteCobrado ] ) );

              finally
                CierraFicherosImportacion;
                end;

              If   ProcessFrame.Error or ProcessFrame.Canceled
              then Abort
              else EnterpriseDataModule.Commit;

            except on e : exception do
              begin
              EnterpriseDataModule.RollBack;
              If   not ( e is EAbort )
              then ShowNotification( ntExceptionError, E.Message );

              // Si se ha producido un error sigo con el siguiente equipo móvil (no me parece muy bien pero, por lo visto, los clientes lo prefieren)

              If   ProcessFrame.Canceled
              then raise;
              ProcessFrame.Error := False;
              end;

            end;

            end;
     
end;

procedure TboxCemForm.RecibirPorCorreoCtrlPropertiesChange(Sender: TObject);
begin
     EquipoMovilInicialCtrl.Enabled := not RecibirPorCorreoCtrl.Checked;
     EquipoMovilFinalCtrl.Enabled  := not RecibirPorCorreoCtrl.Checked;
end;

procedure TBoxCemForm.DoProcess;

var  Index : SmallInt;
     TargetPath : String;

begin

     try

       ExportImport.CleanImportDir;

       If   DataRecibirPorCorreo.Value
       then ExportImport.POP3Init( tdPreventa, DataFecha.Value, DoOnAcceptMessage )
       else With EquipoMovilTable do
              begin
              SetRange( [ DataEquipoMovilInicial.Value ], [ DataEquipoMovilFinal.Value   ] );
              First;
              While not Eof do
                begin

                CodigoEquipoMovil := EquipoMovilFields.Codigo.Value;

                // Dejo los ficheros directamente en la base de datos de importación, que es siempre local y accesible

                With Configuracion.ParametrosGlbRec do
                  If   AccesoFTP and ( HostFTP<>'' )
                  then begin
                       ExportImport.FTPInit;
                       Preventa.FijaDirectorioTrabajo( CodigoEquipoMovil, DataFecha.Value );  // Tiene que estar la conexión abierta
                       For Index := 0 to High( ListaFicheros ) do
                         ExportImport.FTPGetFile( AddPathDelim( Preventa.DirectorioRemotoFTP, '/' ) + ListaFicheros[ Index ],
                                                  AddPathDelim( SessionDataModule.ImportsDatabase.Path ) + ListaFicheros[ Index ] );
                       end
                  else begin
                       Preventa.FijaDirectorioTrabajo( CodigoEquipoMovil, DataFecha.Value );
                       For Index := 0 to High( ListaFicheros ) do
                         CopyFile( AddPathDelim( Preventa.DirectorioServidor ) + ListaFicheros[ Index ],
                                   AddPathDelim( SessionDataModule.ImportsDatabase.Path ) + ListaFicheros[ Index ],
                                   [ cfOverWrite ] );
                       end;

                ProcesaEquipoMovil;
                 
                //** 18.02.2019 Suprimo los ficheros originales para que no se puedan volver a copiar por error
                 
                If   not ( ProcessFrame.Error or ProcessFrame.Canceled )
                then begin
                     ShowNotification( ntInformation, Format( RsMsg26, [ CodigoEquipoMovil ] ) );
                     EraseDirectory( Preventa.DirectorioServidor );
                     end;
                                    
                Next;
                end;

              end;
                
       ShowNotifications;

     finally
       DeactivateNotifications;
       end;
       
end;

procedure TboxCemForm.EquipoMovilCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEquiposMoviles( Sender );
end;

procedure TboxCemForm.EquipoMovilCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     EquipoMovil.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TboxCemForm.FormManagerInitializeForm;
begin
     EquipoMovilFields := TEquipoMovilFields.Create( EquipoMovilTable );
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );
     EfectoFields := TEfectoFields.Create( EfectoTable );
     FacturaVentasFields := TFacturaVentasFields.Create( FacturaVentasTable );

     ClienteFields := TClienteFields.Create( Self );

     DataRenumerar.Value := Registro.ValorUsuarioActivo( ncrRenumDocEquiposMoviles );
end;

end.
