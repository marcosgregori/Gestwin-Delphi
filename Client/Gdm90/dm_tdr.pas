
unit dm_tdr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,

  AppForms,

  DB, nxdb, DataManager, cxEdit,

  Gim10Fields,
  Gim30Fields,
  Gim90Fields;


type   TLicenciaItem = class
       public
         NroRegistro,
         NroPrograma,
         Version,
         Release,
         NroUsuarios     : Integer;
         NroSerie,
         ClaveActivacion : Int64;
         Estado : Integer
         end;

       TLicenciasList = class( TList )
       protected
         function Get( Index: Integer ): TLicenciaItem;
         procedure Put( Index: Integer; Item : TLicenciaItem );
         procedure Clear; override;
       public
         procedure Add( LicenciaItem : TLicenciaItem );

         property Items[ Index: Integer ] : TLicenciaItem read Get write Put; default;
         end;

  TTarjetaRegistroModule = class(TDataModule)
    MovimientosQuery: TnxeQuery;
    TarjetaRegistroTable: TnxeTable;
    LineaTarjetaRegistroTable: TnxeTable;
    ClienteTable: TnxeTable;
    EfectoCobrarTable: TnxeTable;
    RemesaTable: TnxeTable;
    RegistroAplicacionTable: TnxeTable;
    VentaPeriodicaTable: TnxeTable;
    LineaVentaPeriodicaTable: TnxeTable;
    TarjetaRegistroAuxTable: TnxeTable;
    procedure TarjetaRegistroModuleDestroy(Sender: TObject);
    procedure TarjetaRegistroModuleCreate(Sender: TObject);
  private

  public

    TarjetaRegistroFields,
    TarjetaRegistroAuxFields : TTarjetaRegistroFields;
    LineaTarjetaRegistroFields : TLineaTarjetaRegistroFields;
    ClienteFields : TClienteFields;
    EfectoCobrarFields : TEfectoCobrarFields;
    RemesaFields : TRemesaFields;
    RegistroAplicacionFields : TRegistroAplicacionFields;
    VentaPeriodicaFields : TVentaPeriodicaFields;
    LineaVentaPeriodicaFields : TLineaVentaPeriodicaFields;

    function CompruebaLicencia( const CodigoUsuario   : String;
                                const Nombre          : String;
                                const NroRegistro     : Integer;

                                const NroPrograma     : Integer;
                                const Version         : Integer;
                                const Release         : Integer;

                                const NroSerie        : Int64;
                                out   NroUsuarios     : Integer;
                                out   ClaveActivacion : Int64;
                                      IncluirRegistro : Boolean = False ) : Integer;

    function CompruebaSuscripcion( const CodigoUsuario   : String;
                                   const NroRegistro     : Integer;
                                   const Nombre          : String;
                                     out NroPrograma     : Integer;
                                     out Version         : Integer;
                                     out Release         : Integer;
                                         IncluirRegistro : Boolean = False ) : Integer;

    procedure AddLogRec( Tipo            : SmallInt;
                         CodigoUsuario   : String;
                         Nombre          : String;
                         NroRegistro,
                         NroPrograma,
                         Version,
                         Release,
                         NroUsuarios     : Integer;
                         NroSerie        : Int64;
                         CodigoResultado : Integer );

    procedure ObtenLicencias( const CodigoUsuario : String;
                                    LicenciasList : TLicenciasList );

  end;

var  TarjetaRegistroModule: TTarjetaRegistroModule = nil;

function  TarjetaRegistro : TTarjetaRegistroModule;

implementation

{$R *.DFM}

uses  AppManager,
      SuscriptionConsts,
      EnterpriseDataAccess,

      b_msg;

function TarjetaRegistro : TTarjetaRegistroModule;
begin
     CreateDataModule( TTarjetaRegistroModule, TarjetaRegistroModule );
     Result := TarjetaRegistroModule;
end;

// TLicenciasList

function TLicenciasList.Get( Index: Integer ): TLicenciaItem;
begin
     Result := TLicenciaItem( inherited Get( Index ) );
end;

procedure TLicenciasList.Put( Index: Integer; Item : TLicenciaItem );
begin
     inherited Put( Index, Pointer( Item ) );
end;

procedure TLicenciasList.Add( LicenciaItem : TLicenciaItem );
begin
     inherited Add( Pointer( LicenciaItem ) );
end;

procedure TLicenciasList.Clear;

var  Index  : Integer;

begin
     For Index := 0 to Count - 1 do
       TLicenciaItem( Items[ Index ] ).Free;
     inherited;
end;

procedure TTarjetaRegistroModule.TarjetaRegistroModuleDestroy(Sender: TObject);
begin
     TarjetaRegistroModule := nil;
end;

procedure TTarjetaRegistroModule.TarjetaRegistroModuleCreate(Sender: TObject);
begin
     TarjetaRegistroFields := TTarjetaRegistroFields.Create( TarjetaRegistroTable );
     TarjetaRegistroAuxFields := TTarjetaRegistroFields.Create( TarjetaRegistroAuxTable );
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );
     RegistroAplicacionFields := TRegistroAplicacionFields.Create( RegistroAplicacionTable );
     RemesaFields := TRemesaFields.Create( RemesaTable );
     ClienteFields := TClienteFields.Create( ClienteTable );
     VentaPeriodicaFields := TVentaPeriodicaFields.Create( VentaPeriodicaTable );
     LineaVentaPeriodicaFields := TLineaVentaPeriodicaFields.Create( LineaVentaPeriodicaTable );

     SetFieldRange( VentaPeriodicaFields.NroFicha );
end;

function TTarjetaRegistroModule.CompruebaSuscripcion( const CodigoUsuario   : String;
                                                      const NroRegistro     : Integer;
                                                      const Nombre          : String;
                                                        out NroPrograma     : Integer;
                                                        out Version         : Integer;
                                                        out Release         : Integer;
                                                            IncluirRegistro : Boolean = False ) : Integer;

begin
     try

       Result := CCL_ERROR;

       NroPrograma := 0;
       Version := 0;
       Release := 0;

       try
         If   TarjetaRegistroTable.FindKey( [ NroRegistro ] )
         then If   ( TarjetaRegistroFields.CodigoGestion.Value<>CodigoUsuario)
              then Result := CCL_USUARIOINCORRECTO
              else begin

                   // Prefiero comprobar el nombre del cliente en su ficha que en la tarjeta de registro

                   If   ClienteTable.FindKey( [ CodigoUsuario ] )
                   then If   ( UpperCase( ClienteFields.Nombre.Value )<>UpperCase( Nombre ) )
                        then Result := CCL_USUARIOINCORRECTO
                        else begin

                             NroPrograma := TarjetaRegistroFields.Aplicacion.Value;
                             Version := TarjetaRegistroFields.Version.Value;
                             Release := TarjetaRegistroFields.Release.Value;

                             Result := CCL_CORRECTA;
                             end

                   end;

      except
        end;

     finally

       If   IncluirRegistro
       then AddLogRec( idCompruebaSuscripcion,
                       CodigoUsuario,
                       Nombre,
                       NroRegistro,
                       NroPrograma,
                       Version,
                       Release,
                       0,
                       0,
                       Result );

       end;

end;

procedure TTarjetaRegistroModule.AddLogRec( Tipo            : SmallInt;
                                            CodigoUsuario   : String;
                                            Nombre          : String;
                                            NroRegistro,
                                            NroPrograma,
                                            Version,
                                            Release,
                                            NroUsuarios     : Integer;
                                            NroSerie        : Int64;
                                            CodigoResultado : Integer );

begin
     try
       RegistroAplicacionTable.Append;

       RegistroAplicacionFields.Fecha.Value := Now;
       RegistroAplicacionFields.Tipo.Value := Tipo;
       RegistroAplicacionFields.CodigoUsuario.Value := CodigoUsuario;
       RegistroAplicacionFields.Nombre.Value := Nombre;
       RegistroAplicacionFields.NroRegistroAplicacion.Value  := NroRegistro;
       RegistroAplicacionFields.NroPrograma.Value := NroPrograma;
       RegistroAplicacionFields.Version.Value := Version;
       RegistroAplicacionFields.Release.Value := Release;

       RegistroAplicacionFields.CodigoResultado.Value := CodigoResultado;

       RegistroAplicacionTable.Post;

     except
       end;



end;

function TTarjetaRegistroModule.CompruebaLicencia( const CodigoUsuario   : String;
                                                   const Nombre          : String;
                                                   const NroRegistro     : Integer;

                                                   const NroPrograma     : Integer;
                                                   const Version         : Integer;
                                                   const Release         : Integer;

                                                   const NroSerie        : Int64;
                                                   out   NroUsuarios     : Integer;
                                                   out   ClaveActivacion : Int64;
                                                         IncluirRegistro : Boolean = False ) : Integer;

var    SQLString : String;
       CodigoArticulo : String;
       MovimientoFields : TMovimientoFields;
       LineaMovimientoFields : TLineaMovimientoFields;
       EfectoCobrado,
       EfectoPendiente : Boolean;
       DiasPlazo,
       Count,
       NroEfectoActual : SmallInt;
       FechaFacturacion : TDateTime;

begin

     try

       Result := CCL_ERROR;
       NroUsuarios := 0;

       try
         If   NroPrograma in [ 1..6 ]
         then If   ClienteTable.FindKey( [ CodigoUsuario ] )
              then begin
                   If   ( UpperCase( ClienteFields.Nombre.Value )<>UpperCase( Nombre ) )
                   then Result := CCL_USUARIOINCORRECTO
                   else If   TarjetaRegistroTable.FindKey( [ NroRegistro ] )
                        then If   ( TarjetaRegistroFields.CodigoGestion.Value<>CodigoUsuario) and
                                  ( UpperCase( TarjetaRegistroFields.Nombre.Value )<>UpperCase( Nombre ) )
                             then Result := CCL_USUARIOINCORRECTO
                             else If   TarjetaRegistroFields.Aplicacion.Value<>NroPrograma
                                  then Result := CCL_NROPROGRAMADIFERENTE
                                  else If   ( TarjetaRegistroFields.Version.Value<>Version ) or
                                            ( TarjetaRegistroFields.Release.Value<>Release )
                                       then Result := CCL_VERSIONINCORRECTA
                                       else If   TarjetaRegistroFields.NroSerie.Value<>NroSerie
                                            then Result := CCL_NROSERIEINCORRECTO
                                            else begin

                                                 Result := CCL_NOFACTURADO;
                                                 NroUsuarios := TarjetaRegistroFields.NroUsuarios.Value;

                                                 // Ahora puedo empezar a comprobar si está al día de pago

                                                 CodigoArticulo := ListaCodigosArticulo[ NroPrograma ];

                                                 With MovimientosQuery do
                                                   begin

                                                   Close;  // Por si acaso

                                                   SQLString := 'SELECT * ' +
                                                                'FROM   LineaMovimiento LEFT JOIN Movimiento ON ( Movimiento.Ejercicio=LineaMovimiento.Ejercicio AND Movimiento.NroOperacion=LineaMovimiento.NroOperacion ) ' +
                                                                'WHERE  (CodigoArticulo=' + QuotedStr( CodigoArticulo ) + ' ) AND ' +
                                                                        'NumeroSerie=' + QuotedStr( IntToStr( NroRegistro ) ) + ' AND ' +
                                                                        '( Propietario=' + QuotedStr( CodigoUsuario ) + ' ) ' +
                                                                'ORDER BY Fecha';

                                                   SQL.Text := SQLString;
                                                   Open;
                                                   try

                                                     MovimientoFields := TMovimientoFields.Create( MovimientosQuery );
                                                     LineaMovimientoFields := TLineaMovimientoFields.Create( MovimientosQuery );

                                                     Last;
                                                     If   not Bof
                                                     then With MovimientoFields do
                                                            If   Facturado.Value
                                                            then begin
                                                                 // Ejercicio;Serie;NroFactura;NroEfecto
                                                                 NroEfectoActual := 1; // Siempre recibo domiciliado
                                                                 EfectoCobrado := False;
                                                                 EfectoPendiente := False;
                                                                 FechaFacturacion := LowestDateTime;
                                                                 Count := 0;

                                                                 With EfectoCobrarFields do
                                                                   begin

                                                                   repeat

                                                                      If   EfectoCobrarTable.FindKey( [ EjercicioFactura.Value, SerieFactura.Value, NroFactura.Value, NroEfectoActual ] )
                                                                      then begin

                                                                           If   NroEfectoActual=1
                                                                           then FechaFacturacion := FechaLibramiento.Value;

                                                                           If   ValueIsEmpty( EfectoCobrarFields.FechaCobro.Value )
                                                                           then begin
                                                                                If   Impagado.Value
                                                                                then begin
                                                                                     If   VolverAEmitir.Value and not ValueIsEmpty( NroEfectoReemitido.Value )
                                                                                     then NroEfectoActual := NroEfectoReemitido.Value
                                                                                     else EfectoPendiente := True;
                                                                                     end
                                                                                else If   ValueIsEmpty( NroRemesa.Value )
                                                                                     then EfectoPendiente := True
                                                                                     else begin
                                                                                          If   RemesaTable.FindKey( [ EjercicioRemesa.Value, NroRemesa.Value ] )
                                                                                          then begin

                                                                                               If   RemesaFields.Estado.Value in [ erCobrada, erCancelada ]
                                                                                               then EfectoCobrado := True
                                                                                               else EfectoPendiente := True;

                                                                                               end;
                                                                                          end;
                                                                                end
                                                                           else EfectoCobrado := True;
                                                                           end
                                                                      else EfectoPendiente := True;

                                                                      // No me puedo permitir un bucle cerrado en el servidor de licencias

                                                                      Inc( Count );
                                                                      If   Count>10
                                                                      then begin
                                                                           Result := CCL_ERRORINTERNO;
                                                                           Break;
                                                                           end;

                                                                   until EfectoCobrado or EfectoPendiente;

                                                                   If   EfectoCobrado
                                                                   then Result := CCL_CORRECTA
                                                                   else If   EfectoPendiente
                                                                        then begin
                                                                             DiasPlazo := Trunc( ApplicationContainer.TodayDate - FechaFacturacion );
                                                                             If   DiasPlazo<=NroDiasCobro
                                                                             then Result := CCL_PENDIENTECOBRO
                                                                             else If   DiasPlazo<NroDiasRenovacion
                                                                                  then Result := CCL_CADUCADA
                                                                                  else Result := CCL_EXPIRADA;
                                                                             end;
                                                                   end;

                                                                 end;
                                                     finally
                                                       Close;
                                                       end;

                                                   end;

                                                 end;

                   end
              else Result := CCL_USUARIOINCORRECTO;

      except
        end;

     finally

       If   IncluirRegistro
       then AddLogRec( idCompruebaLicencia,
                       CodigoUsuario,
                       Nombre,
                       NroRegistro,
                       NroPrograma,
                       Version,
                       Release,
                       NroUsuarios,
                       NroSerie,
                       Result );

       end;

end;

procedure TTarjetaRegistroModule.ObtenLicencias( const CodigoUsuario : String;
                                                       LicenciasList : TLicenciasList );

var LicenciaItem : TLicenciaItem;
    NombreUsuario : String;

begin
     If   ClienteTable.FindKey( [ Codigousuario ] )
     then begin

          NombreUsuario := ClienteFields.Nombre.Value;

          With TarjetaRegistroAuxTable do
            begin

            IndexFieldNames := 'CodigoGestion;FechaInstalacion';
            SetRange( [ CodigoUsuario ], [ CodigoUsuario ] );

            First;
            While not Eof do
              begin

              LicenciaItem := TLicenciaItem.Create;
              With LicenciaItem do
                begin

                NroRegistro := TarjetaRegistroAuxFields.NroRegistro.Value;
                NroPrograma := TarjetaRegistroAuxFields.Aplicacion.Value;
                Version := TarjetaRegistroAuxFields.Version.Value;
                Release := TarjetaRegistroAuxFields.Release.Value;
                NroUsuarios := TarjetaRegistroAuxFields.NroUsuarios.Value;
                NroSerie := TarjetaRegistroAuxFields.NroSerie.Value;

                Estado := CompruebaLicencia( CodigoUsuario,
                                             NombreUsuario,
                                             NroRegistro,
                                             NroPrograma,
                                             Version,
                                             Release,
                                             NroSerie,
                                             NroUsuarios,
                                             ClaveActivacion );

                LicenciasList.Add( LicenciaItem );

                end;

              Next;
              end;

            end;

          end;

end;

end.
