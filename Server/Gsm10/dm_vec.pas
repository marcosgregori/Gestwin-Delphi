
unit dm_vec;

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

  dmi_vec,
  dmi_ast,
  dmi_fac;

type
    TVerificacionContabilidadService = class( TSessionModule, IVerificacionContabilidadService )

      protected

      procedure AssignSession( const SessionID : Integer ); override;

      public

      procedure Verificacion( ComprobarRegistrosFactura : Boolean = False );

    end;

  TVerificacionContabilidadModule = class(TServerDataModule)
    ApunteTable: TnxeTable;
    AsientoAuxTable: TnxeTable;
    RemesaPagoTable: TnxeTable;
    EfectoCobrarTable: TnxeTable;
    EfectoPagarTable: TnxeTable;
    RemesaTable: TnxeTable;
    MovimientoCajaTable: TnxeTable;
    AsientoTable: TnxeTable;
    FacturaTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

    AsientoFields : TAsientoFields;
    ApunteFields : TApunteFields;

    AsientoAuxFields : TAsientoFields;
    EfectoCobrarFields : TEfectoCobrarFields;
    EfectoPagarFields : TEfectoPagarFields;
    RemesaFields : TRemesaFields;
    RemesaPagoFields : TRemesaPagoFields;
    MovimientoCajaFields : TMovimientoCajaFields;
    FacturaFields : TFacturaFields;

    IdentificadorRegistro : String;

  public

    procedure Verificacion( ComprobarRegistrosFactura : Boolean = False );

  end;


implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses DateUtils,

     nxrbTypes,
     nxrdClass,
     nxsdDataDictionaryStrings,

     AppManager,
     MainData,
     EnterpriseData,

     Gim00Fields,

     SessionData,

     dm_ast,
     dm_fac;

{$R *.DFM}

resourceString
     RsMsg1   = 'Verificación del estado de la contabilidad.';
     RsMsg2   = 'Nº de asiento : ';
     RsMsg3   = 'Buscando apuntes huérfanos ...';
     RsMsg4   = 'Verificando el enlace con documentos asociados ...';
     RsMsg5   = 'Recuperado el asiento nº %d';
     RsMsg7   = 'Proceso realizado satisfactoriamente.';
     RsMsg8   = 'Se han encontrado errores durante el proceso de verificación.';
     RsMsg9   = '¿Desea aplicar las correcciones realizadas?'#13'Si no dispone de una copia de seguridad actualizada de sus datos no debería confirmar este proceso.'#13'Consulte con su técnico de soporte éste extremo.';

     RsMsg10  = 'N/Fra';  // Para identificar el asiento compruebo los conceptos (5 caracteres son suficientes)
     RsMsg11  = 'S/Fra';
     RsMsg12  = 'Cobro';
     RsMsg13  = 'Pago ';

     RsMsg20  = 'El asiento nº %d ha sido convertido en un asiento ordinario.';
     RsMsg21  = 'El efecto a cobrar %s %d/%d ha perdido su vínculo con el asiento nº %d.';
     RsMsg22  = 'El efecto a pagar %s, %s %d/%d ha perdido su vínculo con el asiento nº %d.';
     RsMsg23  = 'El efecto a cobrar %s %d/%d ha sido redireccionado al asiento nº %d.';
     RsMsg24  = 'El efecto a pagar %s, %s %d/%d ha sido redireccionado al asiento nº %d.';
     RsMsg25  = 'No existe la factura rectificativa %s %d. Se ha suprimido el registro auxiliar de la misma.';
     RsMsg26  = 'Los asientos de descuento generados por la remesa nº %d no eran los correctos. Se ha suprimido el asiento nº %d.';
     RsMsg27  = 'El cobro de la remesa nº %d ha sido redireccionado al asiento nº %d.';
     RsMsg30  = 'Se ha reubicado, al menos, un registro de factura. Es posible que necesite realizar de nuevo el proceso por si han quedado huecos.';
     RsMsg31  = 'Se ha producido un error : ';

var VerificacionContabilidadControl : InxClassFactoryControl;

procedure TVerificacionContabilidadModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.VerificacionContabilidadModule := nil;
end;

procedure TVerificacionContabilidadModule.ServerDataModuleCreate(Sender: TObject);
begin
     AsientoFields := TAsientoFields.Create( AsientoTable );
     ApunteFields := TApunteFields.Create( ApunteTable );
     AsientoAuxFields := TAsientoFields.Create( AsientoAuxTable );
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );
     EfectoPagarFields := TEfectoPagarFields.Create( EfectoPagarTable );
     RemesaFields := TRemesaFields.Create( RemesaTable );
     RemesaPagoFields := TRemesaPagoFields.Create( RemesaPagoTable );
     MovimientoCajaFields := TMovimientoCajaFields.Create( MovimientoCajaTable );
     FacturaFields := TFacturaFields.Create( FacturaTable );
end;

{ TVerificacionContabilidadService }

procedure TVerificacionContabilidadService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TVerificacionContabilidadService.Verificacion( ComprobarRegistrosFactura : Boolean = False );
begin
     SessionDataModule.Dm10.VerificacionContabilidadModule.Verificacion( ComprobarRegistrosFactura );
end;

procedure TVerificacionContabilidadModule.Verificacion( ComprobarRegistrosFactura : Boolean = False );

var   ProcesoCancelado,
      ErrorsFound,
      UnLinked,
      RecordFound,
      Ajustado,
      RegistroFacturaReubicado : Boolean;
      SumaDebe,
      SumaHaber,
      ImporteFacturaAsiento,
      TotalIVAAsiento,
      ImporteEfecto,
      ImporteAsiento,
      ImporteIVA,
      ImporteFactura,
      ImporteRemesa,
      ImporteImpagados,
      ImporteCancelados : Decimal;

      SubcuentaRetencion : String;
      BaseRetencion,
      ImporteRetencion : Decimal;
      EjercicioDocumento,
      TipoRetencion : SmallInt;

      ConceptoFactura : String;

      St : String;
      Contador,
      NroAsientoHuerfano : LongInt;

procedure ExtraeDocumento( Concepto     : ShortString;
                           Serie        : TWideStringField;
                           NroDocumento : TIntegerField;
                           NroEfecto    : TSmallintField );

var  Sts,
     Std,
     Ste  : string;
     CLen : SmallInt;
     Posicion : SmallInt;

begin
     try

       Sts := '';
       Std := '';
       Ste := '';
       Posicion := 11;
       CLen := Length( Concepto );

       While ( Posicion<=CLen ) and not ( Concepto[ Posicion ] in [ '0'..'9' ] ) do
         begin
         Sts := Sts + Concepto[ Posicion ];
         Inc( Posicion );
         end;

       Sts := Trim( Sts );

       While ( Posicion<=CLen ) and ( Concepto[ Posicion ] in [ '0'..'9' ] ) do
         begin
         Std := Std + Concepto[ Posicion ];
         inc( Posicion );
         end;

       If   Copy( Concepto, Posicion, 3 )=' / '   // hay un número de efecto a continuación
       then begin
            Inc( Posicion, 3 );
            While ( Posicion<=CLen ) and  ( Concepto[ Posicion ] in [ '0'..'9' ] ) do
              begin
              Ste := Ste + Concepto[ Posicion ];
              inc( Posicion );
              end;
            end
       else Ste := '255';  // Es una factura

       Serie.Value := Sts;
       NroDocumento.Value := StrToInt( Std );
       NroEfecto.Value := StrToInt( Ste );

     except
       end;
end;

function ObtenAsientoRemesa( TipoAsiento     : SmallInt;
                             NroOrdenAsiento : SmallInt = 1 ) : Boolean;

begin
     Result := False;
     With AsientoTable do
       If   FindKey( [ TipoAsiento, SessionDataModule.Ejercicio, '', RemesaFields.NroRemesa.Value, NroOrdenAsiento ] )
       then If   SessionDataModule.EjercicioFecha( AsientoFields.FechaDocumento.Value )=RemesaFields.Ejercicio.Value
            then Result := True
            else begin
                 Next;
                 Result := ( AsientoFields.TipoAsiento.Value=TipoAsiento ) and
                           ( AsientoFields.Ejercicio.Value=SessionDataModule.Ejercicio ) and
                           ( AsientoFields.NroFactura.Value=RemesaFields.NroRemesa.Value ) and
                           ( SessionDataModule.EjercicioFecha( AsientoFields.FechaDocumento.Value )=RemesaFields.Ejercicio.Value );
                 end;
end;

begin

       ErrorsFound := False;
       ProcesoCancelado := False;

       var TransactionTag := SessionDataModule.StartTransaction;

       try

         // Corrigiendo un problema con la creación de valores nulos en las claves de algunas tablas

         With EnterpriseDataModule do
           begin
           ExecSQLCommand( 'UPDATE EfectoCobrar SET EjercicioRemesa=NULL WHERE EjercicioRemesa=0' );
           ExecSQLCommand( 'UPDATE EfectoCobrar SET NroRemesa=NULL WHERE NroRemesa=0' );
           ExecSQLCommand( 'UPDATE EfectoCobrar SET FechaCobro=NULL WHERE FechaCobro = DATE ''1899-12-30''' );
           end;

         // Corrigiendo algunos errores en la tabla de EntidadesFinancieras

         With MainDataModule do
           begin
           ExecSQLCommand( 'DELETE FROM EntidadFinanciera WHERE Codigo IN ( SELECT EntidadFinanciera.Codigo FROM   ( SELECT Codigo, COUNT( * ) FROM EntidadFinanciera ' +
                        'GROUP BY Codigo HAVING COUNT( * ) >1 ) AS Duplicados LEFT JOIN EntidadFinanciera ON ( Duplicados.Codigo=EntidadFinanciera.Codigo ) WHERE Sucursal IS NULL ) AND Sucursal IS NULL' );

           ExecSQLCommand( 'DELETE FROM EntidadFinanciera WHERE Codigo=''3166'' AND Localidad IS NULL' );

           ExecSQLCommand( 'UPDATE EntidadFinanciera SET Sucursal='''' WHERE Sucursal IS NULL' );
           end;

         With EnterpriseDataModule do
           begin
           ExecSQLCommand( 'UPDATE Proveedor SET Obsoleto=False WHERE Obsoleto IS NULL' );
           ExecSQLCommand( 'UPDATE TiposIVA SET CodigoPais='''' WHERE CodigoPais IS NULL' );
           end;

         // Ajustando los valores por defecto erróneas de los registros de facturas del SII

         With EnterpriseDataModule do
           begin
           ExecSQLCommand( 'UPDATE Factura SET TipoFactura=0 WHERE Ejercicio=' + IntToStr( SessionDataModule.Ejercicio ) + ' AND ( TipoFactura<0 OR TipoFactura>11 )' );
           ExecSQLCommand( 'UPDATE Factura SET RegimenOTrascendencia=0 WHERE Ejercicio=' + IntToStr( SessionDataModule.Ejercicio ) + ' AND ( RegimenOTrascendencia<0 OR RegimenOTrascendencia>16 )' );
           end;

         // Un corrector para verificar apuntes huerfanos

         Contador := 0;

         With ApunteTable do
           begin

           ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, RsMsg3 );

           NroAsientoHuerfano := 0;

           SetRange( [ SessionDataModule.Ejercicio, 1, 1 ], [ SessionDataModule.Ejercicio, MaxLongint, MaxSmallInt ] );
           try
              try

                First;
                While not Eof and not ProcesoCancelado do
                  begin

                  // Corrigiendo un extraño error que solo ha ocurrido una vez : cantidades con 4 decimales en lugar de 2.
                  // Posiblemente una actualización desde una versión anterior mal hecha

                  If   ( Decimales( ApunteFields.Debe.Value )>2 ) or
                       ( Decimales( ApunteFields.Haber.Value )>2 ) or
                       ( Decimales( ApunteFields.BaseImponible.Value )>2 ) or
                       ( Decimales( ApunteFields.CuotaIVA.Value )>2 ) or
                       ( Decimales( ApunteFields.CuotaRE.Value )>2 ) or
                       ( Decimales( ApunteFields.ImporteTotal.Value )>2 )
                  then try
                         ApunteTable.Edit;
                         ApunteFields.Debe.Value := Redondea( ApunteFields.Debe.Value );
                         ApunteFields.Haber.Value := Redondea( ApunteFields.Haber.Value );
                         ApunteFields.BaseImponible.Value := Redondea( ApunteFields.BaseImponible.Value );
                         ApunteFields.CuotaIVA.Value := Redondea( ApunteFields.CuotaIVA.Value );
                         ApunteFields.CuotaRE.Value := Redondea( ApunteFields.CuotaRE.Value );
                         ApunteFields.ImporteTotal.Value := Redondea( ApunteFields.ImporteTotal.Value );
                         ApunteTable.Post;
                       except
                         ApunteTable.Cancel;
                         raise;
                         end;

                  If   NroAsientoHuerfano<>ApunteFields.NroAsiento.Value
                  then begin

                       NroAsientoHuerfano := ApunteFields.NroAsiento.Value;

                       If   not AsientoTable.FindKey( [ SessionDataModule.Ejercicio, NroAsientoHuerfano ] )
                       then begin

                            AsientoTable.Append;

                            AsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                            AsientoFields.NroAsiento.Value := NroAsientoHuerfano;
                            AsientoFields.Fecha.Value := ApunteFields.Fecha.Value;
                            AsientoFields.FechaDocumento.Value := ApunteFields.Fecha.Value;

                            St := Copy( ApunteFields.Concepto.Value, 1, 5 );
                            If   St=RsMsg10  // Factura de ventas
                            then begin

                                 AsientoFields.TipoAsiento.Value := taFraEmitida;

                                 ExtraeDocumento( ApunteFields.Concepto.Value, AsientoFields.Serie, AsientoFields.NroFactura, AsientoFields.NroEfecto );

                                 AsientoFields.Propietario.Value := ApunteFields.Subcuenta.Value;
                                 AsientoFields.Nombre.Value := SessionDataModule.Dm10.CuentaModule.Descripcion( ApunteFields.Subcuenta.Value, True, False );
                                 AsientoFields.NroRegistro.Value := SessionDataModule.Dm10.AsientoModule.ProximoNroRegistro( taFraEmitida );

                                 end
                            else If   St=RsMsg11  // Factura de compras
                                 then begin

                                      AsientoFields.TipoAsiento.Value := taFraRecibida;

                                      ExtraeDocumento( ApunteFields.Concepto.Value, AsientoFields.Serie, AsientoFields.NroFactura, AsientoFields.NroEfecto );

                                      AsientoFields.Propietario.Value := ApunteFields.Subcuenta.Value;
                                      AsientoFields.Nombre.Value := SessionDataModule.Dm10.CuentaModule.Descripcion( ApunteFields.Subcuenta.Value, True, False );
                                      AsientoFields.NroRegistro.Value := SessionDataModule.Dm10.AsientoModule.ProximoNroRegistro( taFraRecibida );

                                      end
                                 else begin  // Asiento ordinario ?
                                      AsientoFields.TipoAsiento.Value := taOrdinario;
                                      end;

                            AsientoTable.Post;
                            ProcesoCancelado := SessionDataModule.SendNotification( ntWarning, Format( RsMsg5, [ AsientoFields.NroAsiento.Value ] ) );
                            end;

                       end;

                  IdentificadorRegistro := RsMsg2 + IntToStr( ApunteFields.NroAsiento.Value );

                  If   ( Contador mod 100 )=0
                  then ProcesoCancelado := SessionDataModule.SendNotification( ntRecord, IdentificadorRegistro );
                  Inc( Contador );

                  Next;
                  end;

              except on E : Exception do
                begin
                SessionDataModule.SendNotification( ntError, RsMsg31 + IdentificadorRegistro );
                raise;
                end;
              end;


           finally
             CancelRange;
             end;

           end;

         ProcesoCancelado := SessionDataModule.SendNotification( ntInformation, RsMsg4 );

         // Verificando las relaciones de los documentos

         RegistroFacturaReubicado := False;

         With AsientoTable do
           begin

           IndexFieldNames := 'Ejercicio;NroAsiento';
           SetRange( [ SessionDataModule.Ejercicio, 1 ], [ SessionDataModule.Ejercicio, MaxLongint  ] );
           try

             First;
             While not Eof and not ProcesoCancelado do
               begin

               UnLinked := False;

               With AsientoFields do
                 begin

                 case TipoAsiento.Value of

                   taFraRecibida,
                   taFraEmitida        : SessionDataModule.Dm10.FacturaModule.CompruebaRegistroFacturaAsiento( AsientoFields, RegistroFacturaReubicado, ComprobarRegistrosFactura );

                   taCobro             : begin

                                         // Estoy intentando recuperar la factura que originó el efecto, para obtener la Fecha de libramiento

                                         If   ValueIsEmpty( FechaDocumento.Value )
                                         then With AsientoAuxTable do
                                                begin
                                                IndexFieldNames := 'TipoAsiento;Ejercicio;Serie;NroFactura;NroEfecto';
                                                RecordFound := FindKey( [ taFraEmitida, Ejercicio.Value, Serie.Value, NroFactura.Value, 255 ]  );
                                                If   not RecordFound or
                                                     ( AsientoAuxFields.Propietario.Value<>Propietario.Value ) or
                                                     ( AsientoAuxFields.Fecha.Value>Fecha.Value )
                                                then FindKey( [ taFraEmitida, Ejercicio.Value - 1, Serie.Value, NroFactura.Value, 255 ] );

                                                If   ( AsientoAuxFields.Propietario.Value=Propietario.Value )  and
                                                     ( AsientoAuxFields.Fecha.Value<=Fecha.Value )
                                                then FechaDocumento.Value := AsientoAuxFields.Fecha.Value;
                                                end;

                                         // Me limito a comprobar las anotaciones del cobro del ejercicio activo, comprobando la fecha de cobro.

                                         With EfectoCobrarTable do
                                           If   FindKey( [ SessionDataModule.EjercicioFecha( FechaDocumento.Value ), Serie.Value, NroFactura.Value, NroEfecto.Value ] )
                                           then If   EfectoCobrarFields.FechaCobro.Value=Fecha.Value
                                                then If   ApunteTable.FindKey( [ AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value, 1 ] )
                                                     then begin
                                                          ImporteAsiento := GetSignedValue( ApunteFields.Debe, ApunteFields.Haber );
                                                          ImporteEfecto := EfectoCobrarFields.ImporteCobrado.Value - EfectoCobrarFields.GastosGestion.Value;
                                                          If   Redondea( ImporteAsiento )=Redondea( ImporteEfecto )
                                                          then try
                                                                 Edit;

                                                                 If   ValueIsEmpty( EfectoCobrarFields.FechaLibramiento.Value )
                                                                 then EfectoCobrarFields.FechaLibramiento.Value := FechaDocumento.Value;

                                                                 // En algunas compilaciones erróneas del pasado se podían pasar valores con 4 decimales

                                                                 With EfectoCobrarFields do
                                                                   begin
                                                                   Importe.Value := Redondea( Importe.Value );
                                                                   ImporteCobrado.Value := Redondea( ImporteCobrado.Value );
                                                                   GastosGestion.Value := Redondea( GastosGestion.Value );
                                                                   end;

                                                                 If   EfectoCobrarFields.NroAsientoCobro.Value<>AsientoFields.NroAsiento.Value
                                                                 then begin
                                                                      With EfectoCobrarFields do
                                                                        ProcesoCancelado := SessionDataModule.SendNotification( ntWarning, Format( RsMsg23, [ Serie.Value, NroFactura.Value, NroEfecto.Value, AsientoFields.NroAsiento.Value ] ) );
                                                                      EfectoCobrarFields.NroAsientoCobro.Value := AsientoFields.NroAsiento.Value;
                                                                      end;

                                                                 Post;
                                                               except
                                                                 Cancel;
                                                                 raise;
                                                                 end
                                                          else Unlinked := True;
                                                          end;
                                         end;

                   taPago              : begin

                                         // Estoy intentando recuperar la factura que originó el efecto, para obtener la Fecha de libramiento

                                         If   ValueIsEmpty( FechaDocumento.Value )
                                         then With AsientoAuxTable do
                                                begin
                                                IndexFieldNames := 'TipoAsiento;Ejercicio;Propietario;Serie;NroFactura;NroEfecto';
                                                FindKey( [ taFraRecibida, Ejercicio.Value, Propietario.Value, Serie.Value, NroFactura.Value, 255 ] );
                                                If   Eof or ( AsientoAuxFields.Fecha.Value>Fecha.Value )
                                                then FindKey( [ taFraRecibida, Ejercicio.Value - 1, Propietario.Value, Serie.Value, NroFactura.Value, 255 ] );
                                                If   AsientoAuxFields.Fecha.Value<=Fecha.Value
                                                then FechaDocumento.Value := AsientoAuxFields.Fecha.Value;
                                                end;

                                         // Me limito a comprobar las anotaciones del pago del ejercicio activo, comprobando la fecha de pago.

                                         With EfectoPagarTable do
                                           If   FindKey( [ SessionDataModule.EjercicioFecha( FechaDocumento.Value ), Propietario.Value, Serie.Value, NroFactura.Value, NroEfecto.Value ] )
                                           then If   EfectoPagarFields.FechaPago.Value=Fecha.Value
                                                then If   ApunteTable.FindKey( [ AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value, 1 ] )
                                                     then begin
                                                          ImporteAsiento := GetSignedValue( ApunteFields.Debe, ApunteFields.Haber, True );
                                                          ImporteEfecto := EfectoPagarFields.ImportePagado.Value;
                                                          If   Redondea( ImporteAsiento )=Redondea( ImporteEfecto )
                                                          then begin
                                                               try

                                                                 Edit;

                                                                 If   ValueIsEmpty( EfectoPagarFields.FechaLibramiento.Value )
                                                                 then EfectoPagarFields.FechaLibramiento.Value := FechaDocumento.Value;

                                                                 // En algunas compilaciones erróneas del pasado se podían pasar valores con 4 decimales

                                                                 With EfectoPagarFields do
                                                                   begin
                                                                   Importe.Value := Redondea( Importe.Value );
                                                                   ImportePagado.Value := Redondea( ImportePagado.Value );
                                                                   GastosGestion.Value := Redondea( GastosGestion.Value );
                                                                   end;

                                                                 If   EfectoPagarFields.NroAsiento.Value<>AsientoFields.NroAsiento.Value
                                                                 then begin
                                                                      With EfectoPagarFields do
                                                                        ProcesoCancelado := SessionDataModule.SendNotification( ntWarning, Format( RsMsg24, [ SubcuentaProveedor.Value, Serie.Value, NroFactura.Value, NroEfecto.Value, AsientoFields.NroAsiento.Value ] ) );
                                                                      EfectoPagarFields.NroAsiento.Value := AsientoFields.NroAsiento.Value;
                                                                      end;

                                                                 Post;

                                                               except
                                                                 Cancel;
                                                                 raise;
                                                                 end;
                                                               end
                                                          else Unlinked := True;
                                                          end;

                                         end;

                   taAceptacion       : With RemesaTable do
                                           If   FindKey( [ SessionDataModule.EjercicioFecha( FechaDocumento.Value ), NroFactura.Value ] )
                                           then try
                                                  Edit;
                                                  RemesaFields.NroAsientoAceptacion.Value := AsientoFields.NroAsiento.Value;
                                                  Post;
                                                except
                                                  Cancel;
                                                  raise;
                                                  end
                                           else Unlinked := True;

                   taDescuento         : With RemesaTable do
                                           If   FindKey( [ SessionDataModule.EjercicioFecha( FechaDocumento.Value ), NroFactura.Value ] )
                                           then try
                                                  Edit;
                                                  If   NroEfecto.Value=1
                                                  then RemesaFields.NroAstoDescuento1.Value := AsientoFields.NroAsiento.Value
                                                  else RemesaFields.NroAstoDescuento2.Value := AsientoFields.NroAsiento.Value;
                                                  Post;
                                                except
                                                  Cancel;
                                                  raise;
                                                  end
                                           else Unlinked := True;

                   taCancelacion       : With RemesaTable do
                                           If   FindKey( [ SessionDataModule.EjercicioFecha( FechaDocumento.Value ), NroFactura.Value ] )
                                           then try
                                                  Edit;
                                                  RemesaFields.NroAstoCancelacion.Value := AsientoFields.NroAsiento.Value;
                                                  Post;
                                                except
                                                  Cancel;
                                                  raise;
                                                  end
                                           else Unlinked := True;

                   taCobroRemesa       : With RemesaTable do
                                           begin
                                           EjercicioDocumento := SessionDataModule.EjercicioFecha( FechaDocumento.Value );
                                           If   FindKey( [ EjercicioDocumento, NroFactura.Value ] )
                                           then try
                                                  Edit;
                                                  RemesaFields.NroAsientoCobro.Value := AsientoFields.NroAsiento.Value;
                                                  Post;
                                                except
                                                  Cancel;
                                                  raise;
                                                  end
                                           else begin
                                                Unlinked := True;
                                                If   FindKey( [ EjercicioDocumento - 1, NroFactura.Value ] )
                                                then If   ApunteTable.FindKey( [ AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value, 1 ] )
                                                     then begin
                                                          ImporteAsiento := GetSignedValue( ApunteFields.Debe, ApunteFields.Haber, False );

                                                          SessionDataModule.Dm10.RemesaModule.ImporteRemesa( RemesaFields.Ejercicio.Value, RemesaFields.NroRemesa.Value, ImporteRemesa, ImporteImpagados, ImporteCancelados );

                                                          If   Redondea( ImporteAsiento )=Redondea( ImporteRemesa )
                                                          then begin

                                                               try
                                                                 Edit;  // RemesaTable
                                                                 RemesaFields.FechaCobro.Value := AsientoFields.Fecha.Value;
                                                                 RemesaFields.NroAsientoCobro.Value := AsientoFields.NroAsiento.Value;
                                                                 Post;
                                                               except
                                                                 Cancel;
                                                                 raise;
                                                                 end;

                                                               try
                                                                 AsientoTable.Edit;
                                                                 AsientoFields.FechaDocumento.Value := RemesaFields.Fecha.Value;
                                                                 AsientoTable.Post;
                                                               except
                                                                 AsientoTable.Cancel;
                                                                 raise;
                                                                 end;

                                                               ProcesoCancelado := SessionDataModule.SendNotification( ntWarning, Format( RsMsg27, [ RemesaFields.NroRemesa.Value, AsientoFields.NroAsiento.Value ] ) );

                                                               Unlinked := False;
                                                               end;

                                                          end;
                                                end;

                                           end;

                   taAmortizacion      : ;

                   taCancelacionEfecto : With EfectoCobrarTable do
                                           If   FindKey( [ SessionDataModule.EjercicioFecha( FechaDocumento.Value ), Serie.Value, NroFactura.Value, NroEfecto.Value ] )
                                           then try
                                                  Edit;
                                                  EfectoCobrarFields.NroAstoCancelacion.Value := AsientoFields.NroAsiento.Value;
                                                  Post;
                                                except
                                                  Cancel;
                                                  raise;
                                                  end
                                           else Unlinked := True;

                   taImpagado          : With EfectoCobrarTable do
                                           If   FindKey( [ SessionDataModule.EjercicioFecha( FechaDocumento.Value ), Serie.Value, NroFactura.Value, NroEfecto.Value ] )
                                           then try
                                                  Edit;
                                                  EfectoCobrarFields.NroAsientoImpagado.Value := AsientoFields.NroAsiento.Value;
                                                  Post;
                                                except
                                                  Cancel;
                                                  raise;
                                                  end
                                           else Unlinked := True;

                   taPagoRemesa        : With RemesaPagoTable do
                                           If   FindKey( [ SessionDataModule.EjercicioFecha( FechaDocumento.Value ), NroFactura.Value ] )
                                           then try
                                                  Edit;
                                                  RemesaPagoFields.NroAsientoPago.Value := AsientoFields.NroAsiento.Value;
                                                  Post;
                                                except
                                                  Cancel;
                                                  raise;
                                                  end
                                           else Unlinked := True;

                   taMovimientoCaja    : With MovimientoCajaTable do
                                           If   FindKey( [ SessionDataModule.EjercicioFecha( FechaDocumento.Value ), Serie.Value, NroFactura.Value ] )
                                           then try
                                                  Edit;
                                                  MovimientoCajaFields.NroAsiento.Value := AsientoFields.NroAsiento.Value;
                                                  Post;
                                                except
                                                  Cancel;
                                                  raise;
                                                  end
                                           else Unlinked := True;

                   taCartera           : With EfectoCobrarTable do
                                           If   FindKey( [ SessionDataModule.EjercicioFecha( FechaDocumento.Value ), Serie.Value, NroFactura.Value, NroEfecto.Value ] )
                                           then try
                                                  Edit;
                                                  EfectoCobrarFields.NroAsientoCartera.Value := AsientoFields.NroAsiento.Value;
                                                  Post;
                                                except
                                                  Cancel;
                                                  raise;
                                                  end
                                           else Unlinked := True;

                   end;

                 If   UnLinked
                 then begin
                      ProcesoCancelado := SessionDataModule.SendNotification( ntError, Format( RsMsg20, [ NroAsiento.Value ] ) );

                      Edit;
                      TipoAsiento.Value := taOrdinario;
                      Post;

                      ErrorsFound := True;
                      end;

                 end;

               Next;
               end;

           finally
             CancelRange;
             end;

           end;

         If   RegistroFacturaReubicado
         then SessionDataModule.SendNotification( ntWarning, RsMsg30 );

         // Ahora hago una comprobación inversa, de documento a Asiento

         // Añado la verificación del concepto para corregir un error anterior

         With EfectoCobrarTable do  // Ejercicio;Serie;NroFactura;NroEfecto
           try
             SetRange( [ SessionDataModule.Ejercicio ], [ SessionDataModule.Ejercicio ] );
             First;
             While not Eof do
               begin

               With EfectoCobrarFields do
                 begin

                 If   Concepto.Value='N/Efecto nº '   // Falta el número del efecto
                 then begin
                      Edit;
                      Concepto.Value := SessionDataModule.Dm10.EfectoCobrarModule.TextoConcepto( EfectoCobrarFields );
                      end;

                 If   ( SessionDataModule.EjercicioFecha( FechaCobro.Value )=SessionDataModule.Ejercicio ) and not ValueIsEmpty( NroAsientoCobro.Value )
                 then If   AsientoTable.FindKey( [ SessionDataModule.Ejercicio, NroAsientoCobro.Value ] )
                      then If   ( AsientoFields.TipoAsiento.Value<>taCobro ) or
                                ( AsientoFields.Propietario.Value<>SubcuentaCliente.Value ) or
                                ( AsientoFields.Serie.Value<>Serie.Value ) or
                                ( AsientoFields.NroFactura.Value<>NroFactura.Value ) or
                                ( AsientoFields.NroEfecto.Value<>NroEfecto.Value )
                           then begin
                                ProcesoCancelado := SessionDataModule.SendNotification( ntError, Format( RsMsg21, [ Serie.Value, NroFactura.Value, NroEfecto.Value, NroAsientoCobro.Value ] ) );
                                Edit;
                                EfectoCobrarFields.NroAsientoCobro.Clear;
                                ErrorsFound := True;
                                end;

                 If   ValueIsEmpty( FechaCobro.Value )   // Corrigiendo ceros que deberían ser nulos
                 then begin
                      Edit;
                      FechaCobro.Clear;
                      end;

                 If   Modified
                 then Post;

                 end;

               Next;
               end;

           finally
             CancelRange;
             end;

         With EfectoPagarTable do  // Ejercicio;Proveedor;Serie;NroFactura;NroEfecto
           try
             SetRange( [ SessionDataModule.Ejercicio ], [ SessionDataModule.Ejercicio ] );
             First;
             While not Eof do
               begin

               With EfectoPagarFields do
                 begin

                 If   Concepto.Value='S/Efecto nº '   // Falta el número del efecto
                 then begin
                      Edit;
                      Concepto.Value := SessionDataModule.Dm10.EfectoPagarModule.TextoConcepto( EfectoPagarFields );
                      end;

                 If   ( SessionDataModule.EjercicioFecha( FechaPago.Value )=SessionDataModule.Ejercicio ) and not ValueIsEmpty( NroAsiento.Value )
                 then If   AsientoTable.FindKey( [ SessionDataModule.Ejercicio, NroAsiento.Value ] )
                      then If   ( AsientoFields.TipoAsiento.Value<>taPago ) or
                                ( AsientoFields.Propietario.Value<>SubcuentaProveedor.Value ) or
                                ( AsientoFields.Serie.Value<>Serie.Value ) or
                                ( AsientoFields.NroFactura.Value<>NroFactura.Value ) or
                                ( AsientoFields.NroEfecto.Value<>NroEfecto.Value )
                           then begin
                                ProcesoCancelado := SessionDataModule.SendNotification( ntError, Format( RsMsg22, [ SubcuentaProveedor.Value, Serie.Value, NroFactura.Value, NroEfecto.Value, NroAsiento.Value ] ) );
                                Edit;
                                NroAsiento.Clear;
                                ErrorsFound := True;
                                end;

                 If   Modified
                 then Post;

                 end;

               Next;
               end;

           finally
             CancelRange;
             end;

         TransactionTag.Commit;

       except on E : Exception do
         begin
         TransactionTag.Rollback;
         SessionDataModule.SendNotification( ntError, RsProcesoInterrumpido );
         end;
       end;


end;

initialization
    TnxClassFactory.RegisterClass( CLSID_VerificacionContabilidadService, TVerificacionContabilidadService, VerificacionContabilidadControl );

end.
