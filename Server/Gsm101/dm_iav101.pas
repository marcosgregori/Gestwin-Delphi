
unit dm_iav101;

interface

uses
  Windows, Messages, SysUtils, Classes,
  LibUtils,
  DB,
  Nxdb,
  DataManager,
  ServerDataModule,
  SessionIntf,

  Gim10Fields,
  Gim30Fields,
  Gim101Fields,

  dmi_iav101;

type

    TImportacionAlbaranesVenta101Service = class( TSessionModule, IImportacionAlbaranesVenta101Service )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    public

    procedure EjecutaProceso( SerieDestino, ContenidoFichero : String );
    end;

  TImportacionAlbaranesVenta101Module = class(TServerDataModule)
    LineaMovimientoTable: TnxeTable;
    MovimientoTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

    MovimientoFields,
    ExtMovimientoFields : TMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;
    ClienteFields : TClienteFields;
    ArticuloFields : TArticuloFields;
    SerieFacturacionFields : TSerieFacturacionFields;
    TiposIVAFields : TTiposIVAFields;

    ParametrosHormigonesRec : TParametrosHormigonesRec;

  public

    procedure EjecutaProceso( SerieDestino, ContenidoFichero : String );
    end;


implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses DateUtils,

     nxrbTypes,
     nxrdClass,
     nxsdDataDictionaryStrings,

     AppManager,
     EnterpriseData,

     Gim00Fields,

     SessionData,

     Gsm101Dm,

     dmi_mov,

     dm_sdf,
     dm_mov,
     dm_sto;

{$R *.DFM}

resourceString

  rsMsg1   = 'El Fichero no tiene la estructura esperada. ( Línea numero %d ).';
  rsMsg2   = 'La fecha del documento no pertenece al Ejercicio en curso. ( Línea numero %d ).';
  rsMsg3   = 'El registro debe contener, al menos, un artículo. ( Línea numero %d ).';
  // rsMsg4   = 'El cliente de código [%s] no existe. ( Línea numero %d ).';
  rsMsg5   = 'Importación de albaranes';
  rsMsg6   = 'El fichero no existe.';
  rsMsg7   = 'Seleccione un fichero válido pulsando el botón [Examinar ...].';
  rsMsg8   = 'Albarán %d.';
  rsMsg9   = 'Los ficheros no pertenecen al mismo Ejercicio.';
  rsMsg10  = 'Se cancela el proceso de importación.';
  rsMsg11  = 'Se ha interrumpido el proceso de exportacion/importación.';
  rsMsg12  = 'Es conveniente que revise el contenido de sus ficheros.';
  rsMsg13  = 'Suprimiendo ficheros ...';
  rsMsg14  = 'El albarán %s %d ya existe. No será copiado.';
  rsMsg15  = 'Indique si desea cancelar ahora el proceso de importación.' + #13 + 'Si finaliza el proceso no se registrará ningún cambio en sus ficheros.';
  rsMsg16  = 'El albarán %s %d no ha sido importado.';
  rsMsg18  = 'El albarán %s %d ya existe y no puede ser importado.';

procedure TImportacionAlbaranesVenta101Module.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm101.ImportacionAlbaranesVenta101Module := nil;
end;

procedure TImportacionAlbaranesVenta101Module.EjecutaProceso( SerieDestino, ContenidoFichero : String );

var  DataList : TStringList;
     DataLine : String;

     VarNroAlbaran : LongInt;
     VarCodigoCliente,
     VarCodigoTarifa,
     VarCodigoObra : String;
     VarFechaDocumento : TDateTime;

     VarCodigoArticulo : array[ 1..6 ] of String;
     VarCantidad : array[ 1..6 ] of Double;

     I, J,
     NroLinea : Word;
     SaveDecimalSeparator : Char;
     LineaMovimientoFieldValues : TFieldValuesArray;

     ImporteNetoAlbaran : Decimal;

procedure InsertaLinea;
begin
     With LineaMovimientoFields do
       begin

       //* 18.04.2010  El procedimiento 'ActualizaStock' permite insertar líneas cuyos códigos de artículo
       //              no están dados de alta en el fichero. Esto se hace a instancias de los usuarios del
       //              módulo que, por lo visto, ya venían utilizando esta cualidad desde hace tiempo,
       //              para permitirles importar códigos inexistentes y luego corregirlos en el
       //              mantenimiento del albarán.

       //* 14.05.2013  En la versión 10.5 son necesarios los datos del artículo (tipo de I.V.A., precio, etc..) para calcular
       //              los importes de la línea en el momento de la creación de la misma. Al permitir artículos sin codificar
       //              no queda más remedio que el usuario recalcule manualmente el albarán una vez haya dado de alta las fichas
       //              de los ártículos inexistentes.

       If   SessionDataModule.Dm30.ArticuloModule.Obten( CodigoArticulo.Value, ArticuloFields )
       then begin
            SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoVenta( tmVenta,
                                                                        LineaMovimientoFields,
                                                                        ClienteFields,
                                                                        ArticuloFields,
                                                                        True );
            SessionDataModule.Dm30.FacturaVentasModule.CalculaImportesIVA( LineaMovimientoFields, ClienteFields, ArticuloFields, SerieFacturacionFields, TiposIVAFields, MovimientoFields.IVAIncluido.Value );
            end;

       // MovimientoFields.ImporteNeto.Value := MovimientoFields.ImporteNeto.Value + ImporteNeto.Value;

       ImporteNetoAlbaran := ImporteNetoAlbaran + ImporteNeto.Value;

       SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( MovimientoFields, LineaMovimientoFields, False );

       With LineaMovimientoTable do
         begin
         LineaMovimientoFieldValues := GetFieldValues;
         Post;
         end;

       end;
end;

begin

     With ParametrosHormigonesRec do
       begin

       SessionDataModule.SendNotification( ntHeader, RsMsg5 );

       var TransactionTag := SessionDataModule.StartTransactionWith( [ MovimientoTable, LineaMovimientoTable ] );

       try

          SessionDataModule.Dm00.ConfiguracionModule.ObtenParametros( ctParametrosModulo101, SessionDataModule.CodigoEmpresa, TParametrosRec( ParametrosHormigonesRec ) );

          NroLinea := 0;
          SaveDecimalSeparator := FormatSettings.DecimalSeparator;
          FormatSettings.DecimalSeparator := '.';   // Es una variable global que se utiliza en StrToFloat

          DataList := TStringList.Create;
          DataList.Text := ContenidoFichero;

          try

            For DataLine in DataList do
              begin

              Inc( NroLinea );

              try

                VarNroAlbaran := StrToInt( Copy( DataLine, PosicionCampo[ 1 ], LongitudCampo[ 1 ] ) );

                VarCodigoCliente := Copy( DataLine, PosicionCampo[ 2 ], LongitudCampo[ 2 ] );
                VarCodigoObra := Copy( DataLine, PosicionCampo[ 3 ], LongitudCampo[ 3 ] );

                VarCodigoTarifa := Trim( Copy( DataLine, PosicionCampo[ 4 ], LongitudCampo[ 4 ] ) );

                SessionDataModule.StrToDate( Copy( DataLine, PosicionCampo[ 5 ], LongitudCampo[ 5 ] ), VarFechaDocumento, dfDefault2 );

                I := 1;
                J := 6;
                repeat
                  VarCodigoArticulo[ I ] := Trim( Copy( DataLine, PosicionCampo[ J ], LongitudCampo[ J ] ) );
                  VarCantidad[ I ] := StrToFloat( Copy( DataLine, PosicionCampo[ J + 1 ], LongitudCampo[ J + 1 ] ) );
                  Inc( I );
                  Inc( J, 2 );
                until ( I=7 ) or ( PosicionCampo[ J ]=0 );

              except
                SessionDataModule.SendNotification( ntError, Format( RsMsg1, [ NroLinea ] ) );
                raise;
                end;

              If   YearOf( VarFechaDocumento )<>SessionDataModule.Ejercicio
              then begin
                   SessionDataModule.SendNotification( ntError, Format( RsMsg2, [ NroLinea ] ) );
                   Abort;
                   end;

              If   VarCodigoArticulo[ 1 ]=''
              then begin
                   SessionDataModule.SendNotification( ntError, Format( RsMsg3, [ NroLinea ] ) );
                   Abort;
                   end;

              //* 16.03.2001  Excluidos los registros cuyo cliente no existe

              If   SessionDataModule.Dm10.ClienteModule.Obten( VarCodigoCliente, '', ClienteFields )
              then begin

                   If   VarCodigoTarifa<>''
                   then ClienteFields.Factura_Tarifa.Value := VarCodigoTarifa;

                   If   MovimientoTable.FindKey( [ Ord( tmVenta ), SessionDataModule.Ejercicio, SerieDestino, VarNroAlbaran ] )
                   then begin
                        SessionDataModule.SendNotification( ntWarning, Format( rsMsg18, [ SerieDestino, VarNroAlbaran ] ) );
                        Abort;
                        end;

                   MovimientoTable.Append;

                   ImporteNetoAlbaran := 0.0;

                   With MovimientoFields do
                     begin
                     Ejercicio.Value := SessionDataModule.Ejercicio;
                     TipoMovimiento.Value := tmVenta;
                     NroOperacion.Value := SessionDataModule.Dm30.MovimientoModule.ProximaOperacion;
                     Propietario.Value := VarCodigoCliente;
                     Serie.Value := SerieDestino;
                     NroDocumento.Value := VarNroAlbaran;
                     Fecha.Value := VarFechaDocumento;

                     If   CampoObra=0
                     then RegistroAuxiliar.Value := VarCodigoObra
                     else GrupoFacturacion.Value := VarCodigoObra;

                     SessionDataModule.Dm10.SerieFacturacionModule.Obten( SerieDestino, SerieFacturacionFields );

                     end;

                   SessionDataModule.Dm30.MovimientoModule.CompruebaPrimerNroPagina( MovimientoFields );

                   LineaMovimientoTable.Append;

                   With LineaMovimientoFields do
                     begin

                     Ejercicio.Value := MovimientoFields.Ejercicio.Value;
                     NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                     Fecha.Value := MovimientoFields.Fecha.Value;

                     NroLinea.Value := 1;
                     CodigoArticulo.Value := VarCodigoArticulo[ 1 ];
                     UIDArticulo.AsGUID := SessionDataMOdule.Dm30.ArticuloModule.Identificador;
                     Descripcion.Value := SessionDataMOdule.Dm30.ArticuloModule.Descripcion( CodigoArticulo.Value );

                     CodigoAlmacen.Value := '';
                     Cantidad.Value := -VarCantidad[ 1 ];
                     CantidadAjustada.Value := VarCantidad[ 1 ];

                     InsertaLinea;

                     For I := 2 to 6 do
                       If   VarCodigoArticulo[ I ]<>''
                       then begin

                            With LineaMovimientoTable do
                              begin
                              Append;
                              SetFieldValues( LineaMovimientoFieldValues );
                              end;

                            NroLinea.Value := I;
                            CodigoArticulo.Value := VarCodigoArticulo[ I ];
                            UIDArticulo.AsGUID:= SessionDataMOdule.Dm30.ArticuloModule.Identificador;
                            Descripcion.Value := SessionDataMOdule.Dm30.ArticuloModule.Descripcion( CodigoArticulo.Value );

                            CodigoAlmacen.Value := '';
                            Cantidad.Value := -VarCantidad[ I ];
                            CantidadAjustada.Value := VarCantidad[ I ];

                            InsertaLinea;

                            end
                       else Break;

                     end;

                   // Actualizando el importe pendiente de facturar del cliente

                   SessionDataMOdule.Dm30.RelacionesClienteModule.ActualizaPendiente( MovimientoFields.Ejercicio.Value, MovimientoFields.Propietario.Value, ImporteNetoAlbaran );
                   MovimientoTable.Post;

                   SessionDataModule.SendNotification( ntInformation, Format( RsMsg8, [ VarNroAlbaran ] ) );
                   end;

              end;

          finally
            FormatSettings.DecimalSeparator := SaveDecimalSeparator;
            end;

          TransactionTag.Commit;

       except on E : Exception do
         begin
         TransactionTag.Rollback;
         SessionDataModule.SendException( E, Self );
         If   E is EAbort
         then SessionDataModule.SendNotification( ntError, RsMsg11 )
         else SessionDataModule.SendNotification( ntError, RsMsg11 + #13 + RsMsg12 );
         end;
       end;

       end;

end;

procedure TImportacionAlbaranesVenta101Module.ServerDataModuleCreate(Sender: TObject);
begin
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );

     ClienteFields := TClienteFields.Create( Self );
     ArticuloFields := TArticuloFields.Create( Self );
     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     TiposIVAFields := TTiposIVAFields.Create( Self );
end;

{ TImportacionAlbaranesVenta101Service }

procedure TImportacionAlbaranesVenta101Service.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TImportacionAlbaranesVenta101Service.EjecutaProceso( SerieDestino, ContenidoFichero : String );
begin
     SessionDataModule.Dm101.ImportacionAlbaranesVenta101Module.EjecutaProceso( SerieDestino, ContenidoFichero );
end;

var ImportacionAlbaranesVenta101Control : InxClassFactoryControl;

initialization
    TnxClassFactory.RegisterClass( CLSID_ImportacionAlbaranesVenta101Service, TImportacionAlbaranesVenta101Service, ImportacionAlbaranesVenta101Control );

end.
