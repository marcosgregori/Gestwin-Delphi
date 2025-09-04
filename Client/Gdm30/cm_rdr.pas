unit cm_rdr;

interface

uses SysUtils,
     Classes,

     LibUtils,
     AppContainer,
     AppForms,
     DB, nxdb, DataManager,

     Gim10Fields,
     Gim30Fields;

const NroMaximoRegistrosAmpliacion = 6;

type
  TCmdRdrModule = class(TDataModule)
    DmLineaMovimientoTable: TnxeTable;
    DmFacturaVentasTable: TnxeTable;
    DmMovimientoQuery: TnxeQuery;
    Procedure DataModuleCreate(Sender: TObject);
    Procedure DataModuleDestroy(Sender: TObject);
  private

    type
      TLineaMovimientoRecord = record
        Descripcion : String;
        Cantidad : Decimal;
        Precio : Double;
        Descuento,
        CuotaIVA,
        Importe,
        ImporteIVAIncluido : Decimal;
        end;

    var

    DmMovimientoFields  : TMovimientoFields;
    DmLineaMovimientoFields : TLineaMovimientoFields;
    DmFacturaVentasFields : TFacturaVentasFields;
    DmClienteFields : TClienteFields;

    ParametroAmpliacion : array[ 1.. NroMaximoRegistrosAmpliacion * 3 ] of String;
    NroSegmentosAmpliacion : SmallInt;
    LineasMovimiento : array[ 1..6 ] of TLineaMovimientoRecord;

    FTextoAmpliacion : String;

    procedure LeeFicheroConfiguracion;

  public

    function AmpliacionConcepto( const Process : TAmpliacionProcess ) : String;

    property TextoAmpliacion : String read FTextoAmpliacion;
  end;

var CmdRdrModule : TCmdRdrModule = nil;

implementation

{$R *.dfm}

uses  AppManager,

      EnterpriseDataAccess,
      ReportManager,
      Files,

      Gdm00Dm,

      dmi_mov,

      dm_prv,
      dm_cli,
      dm_mov,
      dm_fdv,
      dm_art,
      dm_sdf,
      dm_rac,

      i_rdr,

      b_msg;

resourceString
      RsMsg1  = 'No consigo abrir el fichero de configuración de los conceptos del efecto.';
      RsMsg2  = 'Por algún motivo el fichero %s no es accesible.'#13'Revise su instalación';

const NroMaximoLineasMovimiento = 6;   // Número máximo de líneas del movimiento que se pueden incluir

Procedure SetupModule;
begin
     If   Assigned( RptRdrForm )
     then begin
          CreateDataModule( TCmdRdrModule, CmdRdrModule, RptRdrForm );
          If   Assigned( CmdRdrModule)
          then RptRdrForm.OnAmpliacionConcepto.Add( CmdRdrModule.AmpliacionConcepto );
          end;
end;

procedure TCmdRdrModule.LeeFicheroConfiguracion;

Var Fichero : Text;
    Nombrefichero,
    Path,
    Linea : String;
    Index : SmallInt;
    
begin

     Path := ReportManagerDataModule.GetReportLocation( 'rdr.rcf', CodigoEmpresaActual, dtReportSchema );

     AssignFile( Fichero, Path );
     Reset( Fichero );
     If   IOResult<>0
     then begin
          ShowNotification( ntError, RsMsg1, Format( RsMsg2, [ Path ] ) );
          Abort;
          end;

     Index := 1;
     While ( not Eof( Fichero ) and ( Index<NroMaximoRegistrosAmpliacion * 3 ) ) do
       begin
       ReadLine( Fichero, Linea );
       ParametroAmpliacion[ Index ] := Linea;
       Inc( Index );
       end;

     NroSegmentosAmpliacion := Index - 1;

     CloseFile( Fichero );
end;

function TCmdRdrModule.AmpliacionConcepto( const Process : TAmpliacionProcess ) : String;

var   I,
      NroRegistrosAmpliacion,
      NroSegmentoAmpliacion,
      NroTotalLineas : SmallInt;
      SegmentoAmpliacion : array[ 0..2 ] of String;

procedure GuardaRegistro;
begin
     With RptRdrForm do
       StrAdd( FTextoAmpliacion,
               Trim( SegmentoAmpliacion[ 0 ] ) + ' ' +
               Trim( SegmentoAmpliacion[ 1 ] ) + ' ' +
               Trim( SegmentoAmpliacion[ 2 ] ) );

end;

procedure LimpiaRegistro;

var Index : SmallInt;

begin
     For Index := 0 to 2 do
       SegmentoAmpliacion[ Index ] := '';
     NroSegmentoAmpliacion := 0;
end;

procedure CompruebaRegistroCompleto( Forzar : Boolean = False );

begin
     If   ( Forzar and ( NroSegmentoAmpliacion<>0 ) ) or ( NroSegmentoAmpliacion>2 )
     then begin
          GuardaRegistro;
          LimpiaRegistro;
          end;
end;

function ObtenLineaAmpliacion( NroLinea : SmallInt ) : String;

const  NumOfCommands = 20;
       Commands : array[ 1..NumOfCommands ] of String = ( 'CLIENTE.NOMBRE',
                                                          'CLIENTE.DOMICILIO',
                                                          'CLIENTE.LOCALIDAD',
                                                          'CLIENTE.CP',
                                                          'CLIENTE.PROVINCIA',
                                                          'CLIENTE.NIF',
                                                          'AUXILIAR',
                                                          'DESCRIPCION',
                                                          'CANTIDAD',
                                                          'PRECIO',
                                                          'DESCUENTO',
                                                          'CUOTAIVA',
                                                          'IMPORTE',
                                                          'IMPORTEIVAINCLUIDO',
                                                          'SERIE',
                                                          'NROFACTURA',
                                                          'FECHAFACTURA',
                                                          'NETOFACTURA',
                                                          'CUOTAIVAFACTURA',
                                                          'TOTALFACTURA' );
var  DataLine,
     DataCommand : String;
     I, Cp, Cw, Ln, Rp : SmallInt;
     Co : SmallInt;
     Rc : Char;

begin
     Result := '';
     If   NroSegmentoAmpliacion<=NroSegmentosAmpliacion
     then begin
          DataLine := ParametroAmpliacion[ NroLinea ];
          For I := 1 to NumOfCommands do
            begin
            Rp := 0;
            repeat
              Cp := Pos( '<' + Commands[ I ], UpperCase( DataLine ) );
              If   Cp<>0
              then begin
                   Cw := Length( Commands[ I ] );
                   Rc := DataLine[ Cp + Cw + 1 ];
                   If   CharInSet( Rc, [ '1'..'9' ] )
                   then begin
                        Co := StrToInt( Rc );
                        Inc( Cw );
                        end
                   else Co := 0;
                   If   Copy( DataLine, Cp + Cw + 1, 1 )='>'  // La última comprobación
                   then begin
                        Cw := Cw + 2;  // Lo utilizo en la función StrFormatFloat
                        Delete( DataLine, Cp, Cw );
                        DataCommand := '';
                        If   ( ( I in [ 1..6, 15..20 ] ) and ( Co=0 ) ) or
                             ( ( I=7) and ( Co in [ 1..8 ] ) ) or
                             ( ( I in [ 8..14 ] ) and ( Co in [ 1..NroMaximoLineasMovimiento ] ) )
                        then case I of
                               1 : DataCommand := DmClienteFields.Nombre.Value;
                               2 : DataCommand := DmClienteFields.Domicilio.Value;
                               3 : DataCommand := DmClienteFields.Localidad.Value;
                               4 : DataCommand := DmClienteFields.CodigoProvincia.Value + DmClienteFields.CodigoPostal.Value;
                               5 : DataCommand := Provincia.Descripcion( DmClienteFields.CodigoPais.Value, DmClienteFields.CodigoProvincia.Value );
                               6 : DataCommand := DmClienteFields.NIF.Value;
                               7 : DataCommand := Trim( AuxiliarCliente.AuxiliarClienteFields.Campo[ Co ].Value );
                               8 : DataCommand := LineasMovimiento[ Co ].Descripcion;
                               9 : DataCommand := StrFormat( LineasMovimiento[ Co ].Cantidad, DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value );
                              10 : DataCommand := StrFormat( LineasMovimiento[ Co ].Precio, DataModule00.DmEmpresaFields.Ventas_DecPrecio.Value );
                              11 : DataCommand := StrFormat( LineasMovimiento[ Co ].Descuento, DataModule00.DmEmpresaFields.Ventas_DecDto.Value );
                              12 : DataCommand := StrFormat( LineasMovimiento[ Co ].CuotaIVA, DecimalesMoneda );
                              13 : DataCommand := StrFormat( LineasMovimiento[ Co ].Importe, DecimalesMoneda );
                              14 : DataCommand := StrFormat( LineasMovimiento[ Co ].ImporteIVAIncluido, DecimalesMoneda );
                              15 : DataCommand := DmFacturaVentasFields.Serie.Value;
                              16 : DataCommand := IntToStr( DmFacturaVentasFields.NroFactura.Value );
                              17 : DataCommand := StrFormatDate( DmFacturaVentasFields.Fecha.Value );
                              18 : DataCommand := StrFormat( DmFacturaVentasFields.NetoFactura.Value, DecimalesMoneda );
                              19 : DataCommand := StrFormat( DmFacturaVentasFields.CuotaIVA.Value, DecimalesMoneda );
                              20 : DataCommand := StrFormat( DmFacturaVentasFields.TotalFactura.Value, DecimalesMoneda );
                              end;
                        System.Insert( DataCommand, DataLine, Cp );
                        end;

                   end;
                Inc( Rp );
              until ( Cp=0 ) or ( Rp=5 ); // Esto evita tanto que se incluyan más de 6 veces la misma variable en una línea
                                          // como que se produzca un bucle porque el contenido de una variable coincide con el nombre de la variable.
            end;
          Result := DataLine;
          end;
end;

begin
     Result := '';
     If   Process=amInitialize
     then LeeFicheroConfiguracion
     else With RptRdrForm do
            begin

            FTextoAmpliacion := '';

            // La ampliacion del concepto se obtiene del primer albaran incluido en la factura
            // y del registro auxiliar de Cliente asociado al mismo (si existe)

            With DmMovimientoQuery do
              begin

              Close;

              // SerieFacturacion.Obten( EfectoCobrarFields.Serie.Value, True );

              NroRegistrosAmpliacion := 0;
              LimpiaRegistro;

              SQL.Text := SQLFormat( 'SELECT * FROM Movimiento '+
                                     'WHERE TipoMovimiento=%d AND EjercicioFactura=%s AND SerieFactura=%s AND NroFactura=%s AND Facturado',
                                     [ tmVenta,
                                       EfectoCobrarFields.Ejercicio,
                                       EfectoCobrarFields.Serie,
                                       EfectoCobrarFields.NroFactura ] );

              try

                Open;

                DmMovimientoFields := TMovimientoFields.Create( DmMovimientoQuery );

                First;
                If   not Eof
                then begin

                     With DmMovimientoFields do
                       begin
                       Cliente.Obten( Propietario.Value, '', DmClienteFields );
                       AuxiliarCliente.Obten( Propietario.Value, RegistroAuxiliar.Value, False );
                       DmFacturaVentasTable.FindKey( [ Ejercicio.Value, Serie.Value, NroFactura.Value ] );
                       end;

                     NroTotalLineas := 1;

                     FillChar( LineasMovimiento, SizeOf( LineasMovimiento ), #0 );

                     While not Eof and ( NroTotalLineas<=NroMaximoLineasMovimiento ) do
                       begin

                       With DmLineaMovimientoTable, DmMovimientoFields do
                         begin
                         SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );
                         First;
                         While not Eof and ( NroTotalLineas<=NroMaximoLineasMovimiento ) do
                           begin

                           With LineasMovimiento[ NroTotalLineas ] do
                             begin
                             Descripcion := DmLineaMovimientoFields.Descripcion.Value;
                             Cantidad := -DmLineaMovimientoFields.Cantidad.Value;
                             Precio := DmLineaMovimientoFields.Precio.Value;
                             Descuento := DmLineaMovimientoFields.Descuento.Value;
                             Importe := DmLineaMovimientoFields.ImporteNeto.Value;
                             CuotaIVA := DmLineaMovimientoFields.CuotaIVA.Value;
                             ImporteIVAIncluido := DmLineaMovimientoFields.ImporteTotal.Value;
                             end;

                           Inc( NroTotalLineas );

                           Next;
                           end;

                         end;

                       Next;
                       end;

                     LimpiaRegistro;
                     For I := 1 to NroSegmentosAmpliacion do
                       begin
                       SegmentoAmpliacion[ NroSegmentoAmpliacion ] := ObtenLineaAmpliacion( I );
                       Inc( NroSegmentoAmpliacion );
                       CompruebaRegistroCompleto;
                       end;

                     CompruebaRegistroCompleto( True );
                     end;

              finally
                Close;
                end;

              end;

            Result := TextoAmpliacion;
            end;
end;

Procedure TCmdRdrModule.DataModuleCreate(Sender: TObject);
begin
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );
     DmFacturaVentasFields := TFacturaVentasFields.Create( DmFacturaVentasTable );
     DmClienteFields := TClienteFields.Create( Self );
end;

Procedure TCmdRdrModule.DataModuleDestroy(Sender: TObject);
begin
     CmdRdrModule := nil;
end;

initialization
     AddProcedure( imOnCreateComponent, idRptRdrForm, SetupModule );
end.
