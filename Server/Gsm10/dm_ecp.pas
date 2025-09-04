
unit dm_ecp;

interface

uses
  Windows, Messages, SysUtils, Classes,
  LibUtils,
  DB,
  nxdb,
  nxsdTypes,

  DataManager,
  ServerDataModule,
  SessionIntf,

  Gim10Fields,

  dmi_ecp,

  EfectoPagarIntf;

type
  TTipoEfectos = ( srEnCartera = 0, srDescontados = 1, srAceptados = 2, srImpagados = 5 );

    TEfectoPagarService = class( TSessionModule, IEfectoPagarService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    procedure ActualizaEfectoPagar( EfectoPagar : IEfectoPagar );
    procedure SuprimeEfectoPagar( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; SubcuentaProveedor : String; SerieNroFactura : String; NroEfecto : SmallInt );

    procedure ActualizaAnotacionPago( EfectoPagar: IEfectoPagar );
    procedure SuprimeAnotacionPago( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; SubcuentaProveedor : String; SerieNroFactura : String; NroEfecto : SmallInt );

    function GeneraEfectos( NroAsiento : LongInt; SubcuentaProveedor, CodigoFormaPago : String; Importe : Decimal ) : Boolean;
    procedure CopiaFacturaRecibida( Ejercicio : SmallInt; NroAsiento : LongInt; PropietarioDestino : String; SerieNroFacturaDestino : String; BorrarFacturaOrigen : Boolean = False );
    function  EfectoPendiente( Ejercicio : SmallInt; SubcuentaProveedor : String; SerieNroFactura : String; NroEfecto : SmallInt ) : Boolean;
    function  ImportePendienteFactura( Ejercicio : SmallInt; Propietario : String; SerieNroFactura : String; var ImporteEfectos, ImportePendiente : Decimal ) : Boolean;
    procedure SuprimeEfectosFactura( Ejercicio : SmallInt; SubcuentaProveedor : String; SerieNroFactura : String );
    function CompruebaEfectos( Ejercicio : SmallInt; SubcuentaProveedor : String; SerieNroFactura : String; SuprimirEfectos : Boolean = False ) : Boolean;
    end;

  TEfectoPagarModule = class(TServerDataModule)
    DmAsientoTable: TnxeTable;
    DmApunteTable: TnxeTable;
    DmEfectoPagarTable: TnxeTable;
    DmFormaPagoTable: TnxeTable;
    DmEfectoPagarAuxTable: TnxeTable;
    DmApunteAuxTable: TnxeTable;
    DmAsientoDocTable: TnxeTable;
    DmApunteDocTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure TablesBeforeOpen(DataSet: TDataSet);
  private

    DmEfectoPagarFields,
    DmEfectoPagarAuxFields : TEfectoPagarFields;
    DmAsientoFields,
    DmAsientoDocFields,
    DmAsientoFacFields : TAsientoFields;
    DmApunteFields,
    DmApunteAuxFields,
    DmApunteDocFields : TApunteFields;
    DmFormaPagoFields : TFormaPagoFields;
    DmRemesaPagoFields : TRemesaPagoFields;
    DmProveedorFields : TProveedorFields;
    DmRelacionesDivisaFields : TRelacionesDivisaFields;

    DmRelacionEfectos  : TRelacionEfectos;

    function ObtenTextoConcepto(TextoConcepto: String; EfectoPagarFields: TEfectoPagarFields; IncluirFechaVencimiento: Boolean=False): String;

  public

    function TextoConcepto( EfectoPagarFields : TEfectoPagarFields; IncluirFechaVencimiento : Boolean = False ) : String;

    function CompruebaEfectos( Ejercicio : SmallInt; SubcuentaProveedor : String; SerieNroFactura : String; SuprimirEfectos : Boolean = False ) : Boolean;
    function  EfectoPendiente( EfectoPagarFields : TEfectoPagarFields ) : Boolean; overload;
    function  EfectoPendiente( Ejercicio : SmallInt; SubcuentaProveedor : String; SerieNroFactura : String; NroEfecto : SmallInt ) : Boolean; overload;
    function  ExistenEfectos( Ejercicio : SmallInt; SubcuentaProveedor : String; SerieNroFactura : String ) : Boolean;

    procedure ActualizaEfectoPagar( EfectoPagar : IEfectoPagar ); overload;
    procedure ActualizaEfectoPagar( EfectoPagarFields : TEfectoPagarFields ); overload;
    procedure SuprimeEfectoPagar( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; SubcuentaProveedor : String; SerieNroFactura : String; NroEfecto : SmallInt ); overload;
    procedure SuprimeEfectoPagar( EfectoPagarFields : TEfectoPagarFields ); overload;

    procedure ActualizaAnotacionPago( EfectoPagar: IEfectoPagar ); overload;
    procedure ActualizaAnotacionPago( EfectoPagarFields : TEfectoPagarFields ); overload;
    procedure SuprimeAnotacionPago( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; SubcuentaProveedor : String; SerieNroFactura : String; NroEfecto : SmallInt ); overload;
    procedure SuprimeAnotacionPago( EfectoPagarFields : TEfectoPagarFields ); overload;

    function  ImportePendienteFactura( Ejercicio : SmallInt; Propietario : String; SerieNroFactura : String; var ImporteEfectos, ImportePendiente : Decimal ) : Boolean;
    procedure CopiaFacturaRecibida( Ejercicio : SmallInt; NroAsiento : LongInt; PropietarioDestino : String; SerieNroFacturaDestino : String; BorrarFacturaOrigen : Boolean = False );

    function  ObtenCanalPreferente( ProveedorFields : TProveedorFields; CodigoFormaPago : String = '' ) : String;
    function  TextoConceptoPago( EfectoPagarFields : TEfectoPagarFields; IncluirFechaVencimiento : Boolean = False ) : String;

    function GeneraEfectos( NroAsiento : LongInt; SubcuentaProveedor, CodigoFormaPago : String; Importe : Decimal ) : Boolean;

    procedure SuprimeEfectosFactura( Ejercicio : SmallInt; SubcuentaProveedor : String; SerieNroFactura : String );

  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses DateUtils,
     nxrbTypes,
     nxrdClass,
     nxsrServerEngine,
     nxllBDE,

     AppManager,
     EnterpriseData,

     Gim00Fields,
     SessionData,

     dmi_iva,
     dmi_ast,
     dmi_fac,
     dmi_rdp,

     dm_sub,
     dm_pga,
     dm_pro,
     dm_iva,
     dm_rdp,
     dm_sal,
     dm_ast,
     dm_ecc;

{$R *.DFM}

resourceString
     RsMsg1  = 'El efecto nº %s ya ha sido pagado.';
     RsMsg2  = 'Si desea modificar el estado de esta factura debe [B]suprimir los asientos de pago de todos los efectos[/B].';
     RsMsg3  = 'El efecto nº %s está incluido en la remesa de pago nº %d.';
     RsMsg4  = 'Si desea modificar el estado de esta factura debe excluir todos los efectos de cualquier remesa.';
     RsMsg5  = 'La subcuenta %s no tiene asociada una ficha de proveedor.';
     RsMsg6  = 'Antes de intentar generar efectos de forma automática debe crear una ficha de proveedor que utilice esta subcuenta.';
     RsMsg7  = 'S/Efecto nº ';
     RsMsg8  = 'Ningún efecto generado. Las condiciones impuestas en la forma de pago no permiten generar efectos.';
     RsMsg9  = 'Pagado.';
     RsMsg10 = 'Pago S/Ef. nº ';
     RsMsg11 = 'Remesado. Remesa de pago nº %d.';
     RsMsg12 = 'Pagado. Asiento nº %d.';
     RsMsg13 = 'Pendiente de pago.';
     RsMsg14 = 'Se ha producido un error durante el proceso de generación de efectos.';
     RsMsg15 = 'Abono S/Ef. nº ';
     RsMsg16 = 'Se ha producido un error durante la copia de la factura.';
     RsMsg17 = 'La forma de pago de código [%s] no existe.';

     RsMsg21 = 'No se ha podido leer el asiento nº %d.';
     RsMsg22 = 'La generación de efectos a pagarsolicitada no se ha realizado.';

     RsMsg24 = 'No se ha podido crear el efecto con la diferencia en el importe pagado.';

procedure TEfectoPagarModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.EfectoPagarModule := nil;
end;

procedure TEfectoPagarModule.TablesBeforeOpen(DataSet: TDataSet);
begin
     EnterpriseDataModule.CheckUserAuxDatabase( Dataset );
end;

procedure TEfectoPagarModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmEfectoPagarFields := TEfectoPagarFields.Create( DmEfectoPagarTable );
     DmEfectoPagarAuxFields := TEfectoPagarFields.Create( DmEfectoPagarAuxTable );
     DmAsientoFields := TAsientoFields.Create( DmAsientoTable );
     DmAsientoDocFields := TAsientoFields.Create( DmAsientoDocTable );
     DmApunteFields := TApunteFields.Create( DmApunteTable );
     DmApunteAuxFields := TApunteFields.Create( DmApunteAuxTable );
     DmApunteDocFields := TApunteFields.Create( DmApunteDocTable );
     DmFormaPagoFields := TFormaPagoFields.Create( DmFormaPagoTable );

     DmAsientoFacFields := TAsientoFields.Create( Self );
     DmRemesaPagoFields := TRemesaPagoFields.Create( Self );
     DmProveedorFields := TProveedorFields.Create( Self );
     DmRelacionesDivisaFields := TRelacionesDivisaFields.Create( Self );
end;

function TEfectoPagarModule.ExistenEfectos( Ejercicio          : SmallInt;
                                            SubcuentaProveedor : String;
                                            SerieNroFactura    : String ) : Boolean;
begin
     Result := DmEfectoPagarTable.FindEqualFirst( [ Ejercicio, SubcuentaProveedor, SerieNroFactura, 0 ] );
end;

function TEfectoPagarModule.CompruebaEfectos( Ejercicio          : SmallInt;
                                              SubcuentaProveedor : String;
                                              SerieNroFactura    : String;
                                              SuprimirEfectos    : Boolean = False ) : Boolean;

var  TextoError : String;

begin
     Result := False;
     With DmEfectoPagarTable do
       try
         SetRange( [ Ejercicio, SubcuentaProveedor, SerieNroFactura, 0, 0 ], [ Ejercicio, SubcuentaProveedor, SerieNroFactura, 0, MaxSmallInt ] );
         First;
         While not Eof do
           If   not ValueIsEmpty( DmEfectoPagarFields.NroAsiento.Value )
           then begin
                TextoError := Format( RsMsg1, [ SubcuentaProveedor + ',' + SerieNroFactura + ' / ' + IntToStr( DmEfectoPagarFields.NroEfecto.Value ) ] );
                SessionDataModule.SendNotification( ntStop, TextoError, RsMsg2 );
                Exit;
                end
           else If   not ValueIsEmpty( DmEfectoPagarFields.NroRemesa.Value )
                then begin
                     TextoError := Format( RsMsg3, [ SubcuentaProveedor + ',' + SerieNroFactura + ' / ' + IntToStr( DmEfectoPagarFields.NroEfecto.Value ), DmEfectoPagarFields.NroRemesa.Value ] );
                     SessionDataModule.SendNotification( ntStop, TextoError, RsMsg4 );
                     Exit;
                     end
                else Next;
       finally
         CancelRange;
         end;

     If   SuprimirEfectos
     then SuprimeEfectosFactura( Ejercicio, SubcuentaProveedor, SerieNroFactura );

     Result := True;
end;

procedure TEfectoPagarModule.SuprimeEfectoPagar( EfectoPagarFields : TEfectoPagarFields );
begin
     try
       EfectoPagarFields.Dataset.Delete;
     except
       raise;
       end;
end;

procedure TEfectoPagarModule.SuprimeEfectosFactura( Ejercicio          : SmallInt;
                                                    SubcuentaProveedor : String;
                                                    SerieNroFactura    : String );
begin
     With DmEfectoPagarTable do
       begin

       var TransactionTag := SessionDataModule.StartTransactionWith( [ DmEfectoPagarTable ] );

       try

         try
           SetRange( [ Ejercicio, SubcuentaProveedor, SerieNroFactura, 0, 0 ],
                     [ Ejercicio, SubcuentaProveedor, SerieNroFactura, 0, MaxSmallInt ] );
           First;
           While not Eof do
             Delete;
         finally
           CancelRange;
           end;
         TransactionTag.Commit;
       except
         TransactionTag.Rollback;
         raise;
         end;
       end;
end;

function TEfectoPagarModule.EfectoPendiente( Ejercicio          : SmallInt;
                                             SubcuentaProveedor : String;
                                             SerieNroFactura    : String;
                                             NroEfecto          : SmallInt ) : Boolean;
begin
     Result := False;
     With DmEfectoPagarTable do
       If   FindKey( [ Ejercicio, SubcuentaProveedor, SerieNroFactura, 0, NroEfecto ] )
       then Result := EfectoPendiente( DmEfectoPagarFields );
end;

function TEfectoPagarModule.EfectoPendiente( EfectoPagarFields : TEfectoPagarFields ) : Boolean;
begin
     If   ValueIsEmpty( EfectoPagarFields.NroRemesa.Value )
     then Result := ValueIsEmpty( EfectoPagarFields.FechaPago.Value )
     else If   SessionDataModule.Dm10.RemesaPagoModule.Obten( EfectoPagarFields.EjercicioRemesa.Value, EfectoPagarFields.NroRemesa.Value, DmRemesaPagoFields )
          then Result := DmRemesaPagoFields.Estado.Value=erpPendiente
          else Result := True;
end;

function TEfectoPagarModule.ImportePendienteFactura(      Ejercicio           : SmallInt;
                                                          Propietario         : String;
                                                          SerieNroFactura     : String;
                                                      var ImporteEfectos,
                                                          ImportePendiente   : Decimal ) : Boolean;

var  ImporteFactura : Decimal;

begin
     Result := False;
     ImporteEfectos := 0.0;
     ImportePendiente := 0.0;

     If   DmAsientoDocTable.FindKey( [ taFraRecibida, Ejercicio, Propietario, SerieNroFactura, 0, 255 ] )
     then If   DmApunteDocTable.FindKey( [ DmAsientoDocFields.Ejercicio.Value, DmAsientoDocFields.NroAsiento.Value, 1 ] )
          then begin
               ImporteFactura := GetSignedValue( DmApunteDocFields.Haber, DmApunteDocFields.Debe );
               If   ImporteFactura<>0.0
               then With DmEfectoPagarTable do
                      begin
                      try
                        SetRange( [ Ejercicio, Propietario, SerieNroFactura, 0, 0 ], [ Ejercicio, Propietario, SerieNroFactura, 0, MaxSmallInt ] );
                        First;
                        While not Eof do
                          begin
                          DecAdd( ImporteEfectos, DmEfectoPagarFields.Importe.Value );
                          If   not EfectoPendiente( DmEfectoPagarFields )
                          then If   ValueIsEmpty( DmEfectoPagarFields.NroRemesa.Value )
                               then DecAdd( ImporteFactura, -DmEfectoPagarFields.ImportePagado.Value )
                               else DecAdd( ImporteFactura, -DmEfectoPagarFields.Importe.Value );
                          Next;
                          end;
                      finally
                        CancelRange;
                        end;
                      ImportePendiente := ImporteFactura;
                      Result := ImporteFactura>0.0;
                      end;
               end;
end;

function TEfectoPagarModule.GeneraEfectos( NroAsiento          : LongInt;
                                           SubcuentaProveedor,
                                           CodigoFormaPago     : String;
                                           Importe             : Decimal ) : Boolean;

var   Index : SmallInt;

begin
     Result := False;
     If   DmAsientoTable.FindKey( [ SessionDataModule.Ejercicio, NroAsiento ] )
     then With SessionDataModule.Dm10 do
            begin

            If   not ProveedorModule.ObtenPorSubcuenta( SubcuentaProveedor, DmProveedorFields )
            then begin
                 SessionDataModule.SendNotification( ntStop, Format( RsMsg5, [ SubcuentaProveedor ] ), RsMsg6 );
                 Exit;
                 end;

            If  not DmFormaPagoTable.FindKey( [ CodigoFormaPago ] )
            then begin
                 SessionDataModule.SendNotification( ntStop, Format( RsMsg17, [ CodigoFormaPago ] ) );
                 Abort;
                 end;

            If   CompruebaEfectos( DmAsientoFields.Ejercicio.Value, DmAsientoFields.Propietario.Value, DmAsientoFields.Serie.Value )
            then begin

                 var TransactionTag := SessionDataModule.StartTransactionWith( [ DmEfectoPagarTable ] );

                 try

                   SuprimeEfectosFactura( DmAsientoFields.Ejercicio.Value, DmAsientoFields.Propietario.Value, DmAsientoFields.Serie.Value );

                   If   DesgloseVencimientos( DmAsientoFields.FechaDocumento.Value,
                                              DmFormaPagoFields.Plazos.Value,
                                              DmFormaPagoFields.PrimerVencimiento.Value,
                                              DmFormaPagoFields.Intervalo.Value,
                                              DmProveedorFields.Pago_DiaPago1.Value,
                                              DmProveedorFields.Pago_DiaPago2.Value,
                                              DmProveedorFields.Pago_MesNopago.Value,
                                              False,   // Meses de 30 días
                                              Importe,
                                              DmRelacionEfectos )=0
                   then begin
                        SessionDataModule.SendNotification( ntStop, RsMsg8 );
                        Abort;
                        end;

                   With DmEfectoPagarTable do
                     For Index := 0 to DmRelacionEfectos.NroEfectos do
                       If   DmRelacionEfectos.Importe[ Index ]<>0.0
                       then begin

                            Append;

                            DmEfectoPagarFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                            DmEfectoPagarFields.NroEfecto.Value := Index;
                            DmEfectoPagarFields.SubcuentaProveedor.Value := DmAsientoFields.Propietario.Value;
                            DmEfectoPagarFields.Serie.Value := DmAsientoFields.Serie.Value;
                            DmEfectoPagarFields.NroFactura.Value := 0;
                            DmEfectoPagarFields.FormaDePago.Value  := CodigoFormaPago;
                            DmEfectoPagarFields.SubcuentaEntidad.Value := ObtenCanalPreferente( DmProveedorFields );
                            DmEfectoPagarFields.FechaVencimiento.Value := DmRelacionEfectos.FechaVencimiento[ Index ];
                            DmEfectoPagarFields.FechaLibramiento.Value := DmAsientoFields.FechaDocumento.Value;
                            DmEfectoPagarFields.Concepto.Value := TextoConcepto( DmEfectoPagarFields );
                            DmEfectoPagarFields.Importe.Value := DmRelacionEfectos.Importe[ Index ];

                            If   Index=0
                            then begin
                                 DmEfectoPagarFields.ImportePagado.Value := DmEfectoPagarFields.Importe.Value;
                                 DmEfectoPagarFields.FechaPago.Value := DmEfectoPagarFields.FechaVencimiento.Value;
                                 DmEfectoPagarFields.ConceptoPago.Value := TextoConceptoPago( DmEfectoPagarFields );
                                 SessionDataModule.Dm10.EfectoPagarModule.ActualizaAnotacionPago( DmEfectoPagarFields ); // Hace el Post del efecto
                                 end
                            else Post;

                            end;

                   TransactionTag.Commit;

                   Result := True;

                 except on E : Exception do
                   begin
                   DmEfectoPagarTable.Cancel;
                   TransactionTag.Rollback;
                   If   not ( E is EAbort )
                   then SessionDataModule.SendNotification( ntStop, RsMsg14, RsProcesoInterrumpido );
                   end;
                 end;

                 end;

          end
     else SessionDataModule.SendNotification( ntError, Format( RsMsg21, [ NroAsiento ] ), RsMsg22 );

end;

function TEfectoPagarModule.ObtenCanalPreferente( ProveedorFields : TProveedorFields;
                                                  CodigoFormaPago : String = '' ) : String;
begin
     Result := ProveedorFields.Pago_Subcuenta.Value;
     If   CodigoFormaPago=''
     then CodigoFormaPago := ProveedorFields.Pago_FormaPago.Value;
     With SessionDataModule.Dm10.FormaPagoModule do
       If   Obten( CodigoFormaPago, DmFormaPagoFields )
       then If   DmFormaPagoFields.CanalPreferente.Value<>''
            then Result := DmFormaPagoFields.CanalPreferente.Value;
end;

function  TEfectoPagarModule.ObtenTextoConcepto( TextoConcepto           : String;
                                                 EfectoPagarFields       : TEfectoPagarFields;
                                                 IncluirFechaVencimiento : Boolean = False ) : String;
begin
     With EfectoPagarFields do
        begin
        Result := Serie.Value + ' - ' + StrInt( NroEfecto.Value );
        If   IncluirFechaVencimiento
        then Result := Result + ' ' + StrFormatDate( FechaVencimiento.Value, dfDefault );
        Result := TextoConcepto + Result;
        end;
end;

function  TEfectoPagarModule.TextoConcepto( EfectoPagarFields       : TEfectoPagarFields;
                                            IncluirFechaVencimiento : Boolean = False ) : String;
begin
     Result := ObtenTextoConcepto( RsMsg7, EfectoPagarFields, IncluirFechaVencimiento );
end;

function  TEfectoPagarModule.TextoConceptoPago( EfectoPagarFields       : TEfectoPagarFields;
                                                IncluirFechaVencimiento : Boolean = False ) : String;

var  TextoConcepto : String;

begin
     If   EfectoPagarFields.ImportePagado.Value>=0.0
     then TextoConcepto := RsMsg10
     else TextoConcepto := RsMsg15;
     Result := ObtenTextoConcepto( TextoConcepto, EfectoPagarFields, IncluirFechaVencimiento );
end;

procedure TEfectoPagarModule.ActualizaAnotacionPago( EfectoPagar : IEfectoPagar );

var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( EfectoPagar.RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmEfectoPagarTable.FindKey( [ EfectoPagar.Ejercicio, EfectoPagar.SubcuentaProveedor, EfectoPagar.Serie, 0, EfectoPagar.NroEfecto ] )
          then begin
               TableCursor.RecordLockRelease( False );
               EfectoPagar.ToDataset( DmEfectoPagarFields );
               ActualizaAnotacionPago( DmEfectoPagarFields );
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TEfectoPagarModule.ActualizaAnotacionPago( EfectoPagarFields : TEfectoPagarFields );

var   GeneraAsiento,
      ExisteFichaProveedor : Boolean;
      CuentaDifCambio : string;
      CentroCoste : String;
      ApunteFieldValues : TFieldValuesArray;
      NroApunteActual : SmallInt;
      CuotasIVAFactura,
      ImporteTotalFactura,
      ImporteEfecto,
      Diferencia,
      CuotaIVAProporcional : Decimal;
      ExisteAsientoFac : Boolean;
      ProximoNroEfecto : SmallInt;

begin

     With SessionDataModule do
       begin

       var TransactionTag := SessionDataModule.StartTransactionWith( [ DmAsientoTable, DmApunteTable, EfectoPagarFields.Table ] );

       try

         If   not ValueIsEmpty( EfectoPagarFields.FechaPago.Value )
         then begin

              // Primero compruebo si hay que generar un nuevo efecto por la diferencia

              With EfectoPagarFields do
                 Diferencia := Redondea( Importe.Value - ImportePagado.Value + DiferenciaCambio.Value );

              If   Diferencia<>0.0
              then If   EfectoPagarFields.GenerarEfectoDiferencia.Value and
                        ( EfectoPagarFields.GenerarEfectoDiferencia.OldValue<>EfectoPagarFields.GenerarEfectoDiferencia.Value )
                   then try

                          If   DmEfectoPagarAuxTable.FindEqualLast( [ EfectoPagarFields.Ejercicio.Value,
                                                                      EfectoPagarFields.SubcuentaProveedor.Value,
                                                                      EfectoPagarFields.Serie.Value,
                                                                      0 ] )
                          then begin

                               ProximoNroEfecto := DmEfectoPagarAuxFields.NroEfecto.Value + 1;

                               DmEfectoPagarAuxTable.Append;
                               DmEfectoPagarAuxTable.CopyFields( EfectoPagarFields.Table );

                               DmEfectoPagarAuxFields.NroEfecto.Value := ProximoNroEfecto;

                               DmEfectoPagarAuxFields.Concepto.Value := TextoConcepto( DmEfectoPagarAuxFields );
                               DmEfectoPagarAuxFields.FechaPago.Clear;
                               DmEfectoPagarAuxFields.Importe.Value := Diferencia;

                               DmEfectoPagarAuxFields.DiferenciaCambio.Clear;
                               DmEfectoPagarAuxFields.ImportePagado.Clear;
                               DmEfectoPagarAuxFields.ConceptoPago.Clear;
                               DmEfectoPagarAuxFields.GenerarEfectoDiferencia.Clear;
                               DmEfectoPagarAuxFields.SubcuentaDiferencia.Clear;
                               DmEfectoPagarAuxFields.GastosGestion.Clear;
                               DmEfectoPagarAuxFields.SubcuentaGastos.Clear;
                               DmEfectoPagarAuxFields.NroAsiento.Clear;

                               ActualizaEfectoPagar( DmEfectoPagarAuxFields );
                               end
                          else Abort;

                          except
                            SessionDataModule.SendNotification( ntStop, RsMsg24, '' );
                            raise;
                            end;

              CentroCoste := '';
              CuotasIVAFactura := 0.0;
              ImporteTotalFactura := 0.0;

              GeneraAsiento := True;

              If   not ValueIsEmpty( EfectoPagarFields.FormaDePago.Value )
              then If   Dm10.FormaPagoModule.Obten( EfectoPagarFields.FormaDePago.Value, DmFormaPagoFields )
                   then If   DmFormaPagoFields.NoContabilizar.Value
                        then GeneraAsiento := False;

              If   GeneraAsiento
              then begin

                   ExisteAsientoFac := SessionDataModule.Dm10.AsientoModule.ObtenDocumento( taFraRecibida,
                                                                                            EjercicioFecha( EfectoPagarFields.FechaLibramiento.Value ),
                                                                                            EfectoPagarFields.SubcuentaProveedor.Value,
                                                                                            EfectoPagarFields.Serie.Value,
                                                                                            0,
                                                                                            255,
                                                                                            DmAsientoFacFields );

                   ExisteFichaProveedor := Dm10.ProveedorModule.Obten( EfectoPagarFields.CodigoProveedor.Value, EfectoPagarFields.SubcuentaProveedor.Value, DmProveedorFields );

                   CentroCoste := '';
                   If   EmpresaFields.Contable_CtrosCoste.Value and ExisteAsientoFac
                   then If   DmApunteTable.FindKey( [ DmAsientoFacFields.Ejercicio.Value, DmAsientoFacFields.NroAsiento.Value, 2 ] )
                        then CentroCoste := DmApunteFields.CentroCoste.Value;

                   DmAsientoTable.CancelRange;

                   If   not ValueIsEmpty( EfectoPagarFields.NroAsiento.Value ) and
                        DmAsientoTable.FindKey( [ SessionDataModule.Ejercicio, EfectoPagarFields.NroAsiento.Value ] )
                   then begin
                        SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( DmAsientoFields,
                                                                             taPago,
                                                                             EfectoPagarFields.FechaLibramiento.Value,
                                                                             EfectoPagarFields.SubcuentaProveedor.Value,
                                                                             EfectoPagarFields.Serie.Value,
                                                                             0,
                                                                             EfectoPagarFields.NroEfecto.Value,
                                                                             True );
                        DmAsientoTable.Edit;
                        end
                   else begin
                        DmAsientoTable.Append;

                        DmAsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                        DmAsientoFields.NroAsiento.Value := SessionDataModule.Dm10.AsientoModule.ProximoNroAsiento;
                        DmAsientoFields.TipoAsiento.Value := taPago;
                        DmAsientoFields.Propietario.Value := EfectoPagarFields.SubcuentaProveedor.Value;
                        DmAsientoFields.Serie.Value := EfectoPagarFields.Serie.Value;
                        DmAsientoFields.NroFactura.Value := 0;
                        DmAsientoFields.NroEfecto.Value := EfectoPagarFields.NroEfecto.Value;
                        DmAsientoFields.FechaDocumento.Value := EfectoPagarFields.FechaLibramiento.Value;
                        DmAsientoFields.NroRegistro.Value := SessionDataModule.Dm10.AsientoModule.ProximoNroRegistro( taPago );
                        DmAsientoFields.Nombre.Value := Dm10.CuentaModule.Descripcion( EfectoPagarFields.SubcuentaProveedor.Value, True, False );
                        end;

                   DmAsientoFields.Fecha.Value := EfectoPagarFields.FechaPago.Value;

                   DmAsientoTable.Post;

                   EfectoPagarFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;

                   NroApunteActual := 1;

                   With DmApunteTable do
                     begin

                     CancelRange;

                     Append;

                     DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
                     DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
                     DmApunteFields.NroApunte.Value := NroApunteActual;
                     DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;
                     DmApunteFields.Subcuenta.Value := EfectoPagarFields.SubcuentaEntidad.Value;
                     DmApunteFields.Contrapartida.Value := EfectoPagarFields.SubcuentaProveedor.Value;
                     DmApunteFields.Concepto.Value := EfectoPagarFields.ConceptoPago.Value;
                     DmApunteFields.TipoApunte.Value := tapManual;

                     SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, EfectoPagarFields.ImportePagado.Value + EfectoPagarFields.GastosGestion.Value, True );

                     ApunteFieldValues := GetFieldValues;

                     Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

                     Post;

                     If   EfectoPagarFields.GenerarEfectoDiferencia.Value
                     then ImporteEfecto := EfectoPagarFields.ImportePagado.Value - EfectoPagarFields.DiferenciaCambio.Value
                     else ImporteEfecto := EfectoPagarFields.Importe.Value;
                     Diferencia := EfectoPagarFields.Importe.Value - EfectoPagarFields.ImportePagado.Value + EfectoPagarFields.DiferenciaCambio.Value;

                     Inc( NroApunteActual );

                     Append;
                     SetFieldValues( ApunteFieldValues );

                     DmApunteFields.NroApunte.Value := NroApunteActual;
                     DmApunteFields.Subcuenta.Value := EfectoPagarFields.SubcuentaProveedor.Value;
                     DmApunteFields.Contrapartida.Value := EfectoPagarFields.SubcuentaEntidad.Value;

                     SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, ImporteEfecto, False );

                     Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

                     Post;

                     Inc( NroApunteActual );

                     If   ( ExisteFichaProveedor and  ExisteAsientoFac and ( DmAsientoFacFields.Origen.Value=ofrSujetoPasivo ) and ( DmProveedorFields.Factura_ModeloIVA.Value=mipNormal ) ) and
                          ( ( EmpresaFields.RegimenEspecialCriterioCaja.Value or ( Dm10.AsientoModule.EjercicioTransicionCriterioCaja and ( YearOf( DmAsientoFacFields.Fecha.Value )<SessionDataModule.Ejercicio ) ) ) or DmProveedorFields.Factura_RegimenEspecialCC.Value  ) and
                          ( ( SessionDataModule.Ejercicio - YearOf( DmAsientoFacFields.Fecha.Value ) )<=2 )   // Los efectos de facturas de más de 2 ejercicios ya deben haber sido liquidadas y, por lo tanto, ya no se debe contabilizar el traspaso del I.V.A.
                     then SessionDataModule.Dm10.AsientoModule.CreaApuntesIVADevengado( DmAsientoFields,
                                                                                        DmApunteFields,
                                                                                        DmAsientoFacFields,
                                                                                        EfectoPagarFields.NroEfecto.Value,
                                                                                        EfectoPagarFields.ImportePagado.Value,
                                                                                        DmApunteFields.Concepto.Value,
                                                                                        NroApunteActual );

                     Diferencia := EfectoPagarFields.Importe.Value - EfectoPagarFields.ImportePagado.Value  + EfectoPagarFields.DiferenciaCambio.Value;

                     If   ( Diferencia<>0.0 ) and not EfectoPagarFields.GenerarEfectoDiferencia.Value
                     then begin

                          Append;

                          SetFieldValues( ApunteFieldValues );

                          DmApunteFields.NroApunte.Value := NroApunteActual;

                          DmApunteFields.Subcuenta.Value := EfectoPagarFields.SubcuentaDiferencia.Value;
                          DmApunteFields.CentroCoste.Value := CentroCoste;
                          DmApunteFields.Contrapartida.Value := EfectoPagarFields.SubcuentaProveedor.Value;

                          SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, Diferencia, True );

                          Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

                          Post;

                          Inc( NroApunteActual );
                          end;

                     If   EfectoPagarFields.GastosGestion.Value<>0.0
                     then begin

                          Append;

                          SetFieldValues( ApunteFieldValues );

                          DmApunteFields.NroApunte.Value := NroApunteActual;

                          DmApunteFields.Subcuenta.Value := EfectoPagarFields.SubcuentaGastos.Value;
                          DmApunteFields.CentroCoste.Value := CentroCoste;
                          DmApunteFields.Contrapartida.Value := EfectoPagarFields.SubcuentaEntidad.Value;

                          SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, EfectoPagarFields.GastosGestion.Value, False );

                          Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

                          Post;

                          Inc( NroApunteActual );
                          end;

                     If   EfectoPagarFields.DiferenciaCambio.Value<>0.0
                     then begin

                          CuentaDifCambio  := '';
                          If   ExisteFichaProveedor
                          then If   Dm10.RelacionesDivisaModule.Obten( DmProveedorFields.CodigoDivisa.Value, DmRelacionesDivisaFields )
                               then If   EfectoPagarFields.DiferenciaCambio.Value<0.0
                                    then CuentaDifCambio := DmRelacionesDivisaFields.DifPositivasCambio.Value
                                    else CuentaDifCambio := DmRelacionesDivisaFields.DifNegativasCambio.Value;

                          If   CuentaDifCambio=''
                          then If   EfectoPagarFields.DiferenciaCambio.Value<0.0
                               then begin
                                    CuentaDifCambio := Dm10.CuentaModule.CodigoCuentaDefecto( cpCtaDifPositivasCambio );
                                    Dm10.CuentaModule.InsertaSubcuenta( CuentaDifCambio, Dm10.CuentaModule.DescripcionCuentaDefecto( cpCtaDifPositivasCambio ) );
                                    end
                               else begin
                                    CuentaDifCambio := Dm10.CuentaModule.CodigoCuentaDefecto( cpCtaDifNegativasCambio );
                                    Dm10.CuentaModule.InsertaSubcuenta( CuentaDifCambio, Dm10.CuentaModule.DescripcionCuentaDefecto( cpCtaDifNegativasCambio ) );
                                    end;

                          Append;

                          SetFieldValues( ApunteFieldValues );

                          DmApunteFields.NroApunte.Value := NroApunteActual;
                          DmApunteFields.Subcuenta.Value := CuentaDifCambio;
                          DmApunteFields.CentroCoste.Value := CentroCoste;
                          DmApunteFields.Contrapartida.Value := EfectoPagarFields.SubcuentaEntidad.Value;

                          SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, EfectoPagarFields.DiferenciaCambio.Value, False );

                          Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, False );

                          Post;
                          end;
                     end;

                   end
              else With EfectoPagarFields do
                     begin
                     If   not ValueIsEmpty( NroAsiento.Value )
                     then SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( SessionDataModule.Ejercicio,
                                                                               NroAsiento.Value,  // Este campo es el número de asiento de pago
                                                                               taPago,
                                                                               FechaLibramiento.Value,
                                                                               SubcuentaProveedor.Value,
                                                                               Serie.Value,
                                                                               0,
                                                                               NroEfecto.Value );
                     NroAsiento.Clear;
                     end;

              Dm10.AsientoModule.RetiraNroAsiento( DmAsientoFields, False );
              end;

         EfectoPagarFields.Table.Post;

         TransactionTag.Commit;

       except on E : Exception do
         begin
         DmApunteTable.Cancel;
         DmAsientoTable.Cancel;
         EfectoPagarFields.Table.Cancel;
         TransactionTag.Rollback;
         raise;
         end;
       end;

       end;

end;

procedure TEfectoPagarModule.ActualizaEfectoPagar( EfectoPagar : IEfectoPagar );
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( EfectoPagar.RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   EfectoPagar.State=dsEdit
          then If   DmEfectoPagarTable.FindKey( [ EfectoPagar.Ejercicio, EfectoPagar.SubcuentaProveedor, EfectoPagar.Serie, 0, EfectoPagar.NroEfecto ] )
               then TableCursor.RecordLockRelease( False )
               else RaiseRecordNotFoundException;
          EfectoPagar.ToDataset( DmEfectoPagarFields );
          ActualizaEfectoPagar( DmEfectoPagarFields );
          end
     else RaiseNoCurrentRecordException;
end;

procedure TEfectoPagarModule.SuprimeEfectoPagar( RemoteCursorID       : TnxCursorID;
                                                 Ejercicio            : SmallInt;
                                                 SubcuentaProveedor,
                                                 SerieNroFactura      : String;
                                                 NroEfecto            : SmallInt );
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmEfectoPagarTable.FindKey( [ Ejercicio, SubcuentaProveedor, SerieNroFactura, 0, NroEfecto ] )
          then begin
               TableCursor.RecordLockRelease( False );
               SuprimeEfectoPagar( DmEfectoPagarFields );
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TEfectoPagarModule.ActualizaEfectoPagar( EfectoPagarFields : TEfectoPagarFields );
begin
     try
       EfectoPagarFields.Dataset.Post;
     except on E : Exception do
       begin
       EfectoPagarFields.Dataset.Cancel;
       raise;
       end;
     end;
end;

procedure TEfectoPagarModule.SuprimeAnotacionPago( RemoteCursorID     : TnxCursorID;
                                                   Ejercicio          : SmallInt;
                                                   SubcuentaProveedor : String;
                                                   SerieNroFactura    : String;
                                                   NroEfecto          : SmallInt);
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          If   DmEfectoPagarTable.FindKey( [ Ejercicio, SubcuentaProveedor, SerieNroFactura, 0, NroEfecto ] )
          then begin
               TableCursor.RecordLockRelease( False );
               SuprimeAnotacionPago( DmEfectoPagarFields );
               end
          else RaiseRecordNotFoundException;
          end
     else RaiseNoCurrentRecordException;
end;

procedure TEfectoPagarModule.SuprimeAnotacionPago( EfectoPagarFields : TEfectoPagarFields );
begin
     var TransactionTag := SessionDataModule.StartTransactionWith( [ EfectoPagarFields.Table ] );

     try

       With EfectoPagarFields do
         If   not ValueIsEmpty( NroAsiento.Value )
         then SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( SessionDataModule.Ejercicio,
                                                                   NroAsiento.Value,
                                                                   taPago,
                                                                   FechaLibramiento.Value,
                                                                   SubcuentaProveedor.Value,
                                                                   Serie.Value,
                                                                   0,
                                                                   NroEfecto.Value );

       EfectoPagarFields.Table.Edit;

       EfectoPagarFields.NroAsiento.Clear;
       EfectoPagarFields.FechaPago.Clear;
       EfectoPagarFields.ImportePagado.Clear;
       EfectoPagarFields.DiferenciaCambio.Clear;
       EfectoPagarFields.SubcuentaDiferencia.Clear;
       EfectoPagarFields.GastosGestion.Clear;
       EfectoPagarFields.SubcuentaGastos.Clear;
       EfectoPagarFields.ConceptoPago.Clear;

       EfectoPagarFields.Table.Post;

       TransactionTag.Commit;

     except
       TransactionTag.Rollback;
       raise;
       end;

end;

procedure TEfectoPagarModule.CopiaFacturaRecibida( Ejercicio              : SmallInt;
                                                   NroAsiento             : LongInt;
                                                   PropietarioDestino     : String;
                                                   SerieNroFacturaDestino : String;
                                                   BorrarFacturaOrigen    : Boolean = False );
begin
     If   DmAsientoTable.FindKey( [ Ejercicio, NroAsiento ] )
     then begin

          var TransactionTag := SessionDataModule.StartTransactionWith( [ DmAsientoDocTable, DmApunteDocTable, DmEfectoPagarTable ] );

          try

            DmAsientoDocTable.Append;

            DmAsientoDocFields.Ejercicio.Value := SessionDataModule.Ejercicio;
            DmAsientoDocFields.NroAsiento.Value := SessionDataModule.Dm10.AsientoModule.ProximoNroAsiento;

            DmAsientoDocFields.Fecha.Value := DmAsientoFields.Fecha.Value;
            DmAsientoDocFields.TipoAsiento.Value := taFraRecibida;
            DmAsientoDocFields.Serie.Value := SerieNroFacturaDestino;
            DmAsientoDocFields.Propietario.Value := PropietarioDestino;
            DmAsientoDocFields.NroFactura.Value := 0;
            DmAsientoDocFields.NroEfecto.Value := 255;
            DmAsientoDocFields.FechaDocumento.Value := DmAsientoFields.FechaDocumento.Value;
            DmAsientoDocFields.NroRegistro.Value := DmAsientoFields.NroRegistro.Value;
            DmAsientoDocFields.Origen.Value := DmAsientoFields.Origen.Value;
            DmAsientoDocFields.Nombre.Value := SessionDataModule.Dm10.CuentaModule.Descripcion( PropietarioDestino, True, False );
            DmAsientoDocFields.Anotacion.Value := DmAsientoFields.Anotacion.Value;

            If   not BorrarFacturaOrigen or not SessionDataModule.IsValidYear( DmAsientoDocFields.Fecha.Value )
            then DmAsientoDocFields.Fecha.Value := SessionDataModule.FechaHoy;

            With DmApunteTable do
              try

                SetRange( [ Ejercicio, NroAsiento, 1 ], [ Ejercicio, NroAsiento, MaxSmallInt ] );

                First;
                While not Eof do
                  begin

                  DmApunteDocTable.Append;

                  DmApunteDocTable.CopyFields( DmApunteTable );

                  DmApunteDocFields.Ejercicio.Value := DmAsientoDocFields.Ejercicio.Value;
                  DmApunteDocFields.Fecha.Value := DmAsientoDocFields.Fecha.Value;
                  DmApunteDocFields.NroAsiento.Value := DmAsientoDocFields.NroAsiento.Value;

                  If   DmApunteDocFields.Subcuenta.Value=DmAsientoFields.Propietario.Value
                  then DmApunteDocFields.Subcuenta.Value := PropietarioDestino;

                  If   DmApunteDocFields.Contrapartida.Value=DmAsientoFields.Propietario.Value
                  then DmApunteDocFields.Contrapartida.Value := PropietarioDestino;

                  SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoDocFields.TipoAsiento.Value, DmApunteDocFields );

                  DmApunteDocTable.Post;

                  Next;
                  end;

              finally
                CancelRange;
                end;

            With DmAsientoFields do
              SessionDataModule.Dm10.FacturaModule.ClonaRegistroAsiento( DmAsientoFields.NroAsiento.Value, DmAsientoDocFields.NroAsiento.Value, BorrarFacturaOrigen );

            DmAsientoDocTable.Post;

            SessionDataModule.Dm10.AsientoModule.RetiraNroAsiento( DmAsientoDocFields, False );

            If   BorrarFacturaOrigen
            then With DmAsientoFields do
                   begin
                   SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( Ejercicio.Value, NroAsiento.Value, taFraRecibida, FechaDocumento.Value, Propietario.Value, Serie.Value, 0, 255 );
                   If   not CompruebaEfectos( Ejercicio.Value, Propietario.Value, Serie.Value )
                   then Abort;
                   end;

            With DmEfectoPagarAuxTable do
              try

                // Ejercicio;SubcuentaProveedor;Serie;NroFactura;NroEfecto

                With DmAsientoFields do
                  SetRange( [ Ejercicio.Value, Propietario.Value, Serie.Value, 0 ] );

                First;
                While not Eof do
                  begin

                  With DmEfectoPagarTable do
                    begin
                    Append;

                    CopyFields( DmEfectoPagarAuxTable );

                    DmEfectoPagarFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                    DmEfectoPagarFields.SubcuentaProveedor.Value := PropietarioDestino;
                    DmEfectoPagarFields.Serie.Value := SerieNroFacturaDestino;
                    DmEfectoPagarFields.NroFactura.Value := 0;

                    // Si no se borran la factura original y sus efectos, esto es tan solo una copia de los efectos originales.

                    DmEfectoPagarFields.FechaPago.Clear;
                    DmEfectoPagarFields.ImportePagado.Clear;
                    DmEfectoPagarFields.ConceptoPago.Clear;
                    DmEfectoPagarFields.FechaEmision.Clear;
                    DmEfectoPagarFields.DiferenciaCambio.Clear;
                    DmEfectoPagarFields.SubcuentaDiferencia.Clear;
                    DmEfectoPagarFields.NroAsiento.Clear;
                    DmEfectoPagarFields.NroRemesa.Clear;
                    DmEfectoPagarFields.Revisado.Value := False;

                    Post;
                    end;

                  Next;
                  end;

              finally
                CancelRange;
                end;

            If   BorrarFacturaOrigen
            then SuprimeEfectosFactura( DmAsientoFields.Ejercicio.Value, DmAsientoFields.Propietario.Value, DmAsientoFields.Serie.Value );

            TransactionTag.Commit;

          except
            TransactionTag.Rollback;
            SessionDataModule.SendNotification( ntStop, RsMsg16, RsProcesoInterrumpido );
            end;

          end;

end;

{ TEfectoPagarService }

procedure TEfectoPagarService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

function TEfectoPagarService.CompruebaEfectos( Ejercicio : SmallInt; SubcuentaProveedor, SerieNroFactura : String; SuprimirEfectos: Boolean ) : Boolean;
begin
     Result := SessionDataModule.Dm10.EfectoPagarModule.CompruebaEfectos( Ejercicio, SubcuentaProveedor, SerieNroFactura, SuprimirEfectos );
end;

procedure TEfectoPagarService.CopiaFacturaRecibida( Ejercicio              : SmallInt;
                                                    NroAsiento             : Integer;
                                                    PropietarioDestino,
                                                    SerieNroFacturaDestino : String;
                                                    BorrarFacturaOrigen    : Boolean);
begin
     SessionDataModule.Dm10.EfectoPagarModule.CopiaFacturaRecibida( Ejercicio, NroAsiento, PropietarioDestino, SerieNroFacturaDestino, BorrarFacturaOrigen );
end;

procedure TEfectoPagarService.ActualizaEfectoPagar( EfectoPagar : IEfectoPagar );
begin
     SessionDataModule.Dm10.EfectoPagarModule.ActualizaEfectoPagar( EfectoPagar );
end;

procedure TEfectoPagarService.SuprimeEfectoPagar( RemoteCursorID : TnxCursorID; Ejercicio: SmallInt; SubcuentaProveedor, SerieNroFactura : String; NroEfecto: SmallInt);
begin
     SessionDataModule.Dm10.EfectoPagarModule.SuprimeEfectoPagar( RemoteCursorID, Ejercicio, SubcuentaProveedor, SerieNroFactura, NroEfecto );
end;

function TEfectoPagarService.EfectoPendiente( Ejercicio : SmallInt; SubcuentaProveedor, SerieNroFactura : String; NroEfecto : SmallInt ) : Boolean;
begin
     Result := SessionDataModule.Dm10.EfectoPagarModule.EfectoPendiente( Ejercicio, SubcuentaProveedor, SerieNroFactura, NroEfecto );
end;

function TEfectoPagarService.GeneraEfectos( NroAsiento: Integer; SubcuentaProveedor, CodigoFormaPago: String; Importe : Decimal ) : Boolean;
begin
     Result := SessionDataModule.Dm10.EfectoPagarModule.GeneraEfectos( NroAsiento, SubcuentaProveedor, CodigoFormaPago, Importe );
end;

function TEfectoPagarService.ImportePendienteFactura( Ejercicio: SmallInt; Propietario, SerieNroFactura : String; var ImporteEfectos, ImportePendiente: Decimal ) : Boolean;
begin
     Result := SessionDataModule.Dm10.EfectoPagarModule.ImportePendienteFactura( Ejercicio, Propietario, SerieNroFactura, ImporteEfectos, ImportePendiente );
end;

procedure TEfectoPagarService.ActualizaAnotacionPago( EfectoPagar: IEfectoPagar );
begin
     SessionDataModule.Dm10.EfectoPagarModule.ActualizaAnotacionPago( EfectoPagar );
end;

procedure TEfectoPagarService.SuprimeAnotacionPago( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; SubcuentaProveedor : String; SerieNroFactura : String; NroEfecto : SmallInt );
begin
     SessionDataModule.Dm10.EfectoPagarModule.SuprimeAnotacionPago( RemoteCursorID, Ejercicio, SubcuentaProveedor, SerieNroFactura, NroEfecto );
end;

procedure TEfectoPagarService.SuprimeEfectosFactura( Ejercicio : SmallInt; SubcuentaProveedor, SerieNroFactura : String );
begin
     SessionDataModule.Dm10.EfectoPagarModule.SuprimeEfectosFactura( Ejercicio, SubcuentaProveedor, SerieNroFactura );
end;

var EfectoPagarControl : InxClassFactoryControl;

initialization
    TnxClassFactory.RegisterClass( CLSID_EfectoPagarService, TEfectoPagarService, EfectoPagarControl );

end.
