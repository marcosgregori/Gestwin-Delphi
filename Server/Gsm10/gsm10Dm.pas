{$TYPEINFO ON}   // Rtti

unit Gsm10Dm;

interface

uses
  Windows, Messages, SysUtils, Classes,

  nxllComponent,
  nxsdTableMapperDescriptor,
  nxsdRecordMapperDescriptor,
  nxsdDataDictionary,
  nxdb,
  DataManager,
  DB,
  Sqlset,
  MainData,
  LibUtils,
  ServerDataModule,
  BaseSessionData,

  Gim10Fields,

  dm_sub,
  dm_iva,
  dm_sdf,
  dm_pro,
  dm_cli,
  dm_ast,
  dm_sal,
  dm_ban,
  dm_mdc,
  dm_ecc,
  dm_fac,
  dm_ecp,
  dm_rem,
  dm_rdp,
  dm_rdi,
  dm_fco,
  dm_fpa,
  dm_rpf,

  dm_rda,
  dm_sds,
  dm_ccn,
  dm_vec,
  dm_gaa,
  dm_ric,
  dm_cde;

type
  TDataModule10 = class(TServerDataModule)
    Dictionary: TnxeDatabaseDictionary;
    SQLSet: TgxSQLSet;
    SourceTable: TnxeTable;
    TargetTable: TnxeTable;
    MasterSourceTable: TnxeTable;
    RelacionIdsTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure DictionaryAfterUpdate;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure DictionaryBeforeUpdate;

  private

    FCuentaModule : TCuentaModule;
    FTasaModule : TTasaModule;
    FAsientoModule : TAsientoModule;
    FSaldosModule : TSaldosModule;
    FSerieFacturacionModule : TSerieFacturacionModule;
    FProveedorModule : TProveedorModule;
    FClienteModule : TClienteModule;
    FEfectoCobrarModule : TEfectoCobrarModule;
    FEfectoPagarModule : TEfectoPagarModule;
    FFacturaModule : TFacturaModule;
    FRemesaModule : TRemesaModule;
    FRemesaPagoModule : TRemesaPagoModule;
    FBancoModule : TBancoModule;
    FRegistroPresentacionModule : TRegistroPresentacionModule;
    FMovimientoCajaModule : TMovimientoCajaModule;
    FRelacionesDivisaModule : TRelacionesDivisaModule;
    FFormaCobroModule : TFormaCobroModule;
    FFormaPagoModule : TFormaPagoModule;
    FSustitucionSubcuentasModule : TSustitucionSubcuentasModule;
    FCierreContableModule : TCierreContableModule;
    FRenumeracionAsientosModule : TRenumeracionAsientosModule;
    FVerificacionContabilidadModule : TVerificacionContabilidadModule;
    FGeneracionAmortizacionesModule : TGeneracionAmortizacionesModule;
    FRegularizacionIVAModule : TRegularizacionIVAModule;
    FConsolidacionEmpresasModule : TConsolidacionEmpresasModule;

    function GetCuentaModule : TCuentaModule;
    function GetAsientoModule : TAsientoModule;
    function GetSaldosModule : TSaldosModule;
    function GetTasaModule : TTasaModule;
    function GetSerieFacturacionModule : TSerieFacturacionModule;
    function GetProveedorModule : TProveedorModule;
    function GetClienteModule : TClienteModule;
    function GetEfectoCobrarModule : TEfectoCobrarModule;
    function GetEfectoPagarModule : TEfectoPagarModule;
    function GetFacturaModule : TFacturaModule;
    function GetRemesaModule : TRemesaModule;
    function GetRemesaPagoModule : TRemesaPagoModule;
    function GetBancoModule : TBancoModule;
    function GetRegistroPresentacionModule : TRegistroPresentacionModule;
    function GetMovimientoCajaModule : TMovimientoCajaModule;
    function GetRelacionesDivisaModule : TRelacionesDivisaModule;
    function GetFormaCobroModule : TFormaCobroModule;
    function GetFormaPagoModule : TFormaPagoModule;
    function GetSustitucionSubcuentasModule : TSustitucionSubcuentasModule;
    function GetCierreContableModule : TCierreContableModule;
    function GetRenumeracionAsientosModule : TRenumeracionAsientosModule;
    function GetVerificacionContabilidadModule : TVerificacionContabilidadModule;
    function GetGeneracionAmortizacionesModule : TGeneracionAmortizacionesModule;
    function GetRegularizacionIVAModule : TRegularizacionIVAModule;
    function GetConsolidacionEmpresasModule : TConsolidacionEmpresasModule;

    procedure DoReestructureFacturaTable( EventType : TReestructureEventType; var ReestructureData : TReestructureData );

    procedure AjustesPrevios110036;
    procedure AjustesPrevios110083;
    procedure Ajustes110040;

    procedure SetRegistroPresentacionModule( const Value : TRegistroPresentacionModule );

  protected

  public
    function GetSQL( Title : string ) : string;

    procedure FreeAsientoModule;
    procedure FreeBancoModule;
    procedure FreeRegistroPresentacionModule;
    procedure FreeCierreContableModule;
    procedure FreeClienteModule;
    procedure FreeConsolidacionEmpresasModule;
    procedure FreeCuentaModule;
    procedure FreeEfectoCobrarModule;
    procedure FreeEfectoPagarModule;
    procedure FreeFacturaModule;
    procedure FreeFormaCobroModule;
    procedure FreeFormaPagoModule;
    procedure FreeGeneracionAmortizacionesModule;
    procedure FreeRegularizacionIVAModule;
    procedure FreeMovimientoCajaModule;
    procedure FreeProveedorModule;
    procedure FreeRelacionesDivisaModule;
    procedure FreeRemesaModule;
    procedure FreeRemesaPagoModule;
    procedure FreeRenumeracionAsientosModule;
    procedure FreeSaldosModule;
    procedure FreeSerieFacturacionModule;
    procedure FreeSustitucionSubcuentasModule;
    procedure FreeTasaModule;
    procedure FreeVerificacionContabilidadModule;

    procedure FreeAllDataModules;

    property CuentaModule : TCuentaModule read GetCuentaModule write FCuentaModule;
    property AsientoModule : TAsientoModule read GetAsientoModule write FAsientoModule;
    property SaldosModule : TSaldosModule read GetSaldosModule write FSaldosModule;
    property TasaModule : TTasaModule read GetTasaModule write FTasaModule;
    property SerieFacturacionModule : TSerieFacturacionModule read GetSerieFacturacionModule write FSerieFacturacionModule;
    property ProveedorModule : TProveedorModule read GetProveedorModule write FProveedorModule;
    property ClienteModule : TClienteModule read GetClienteModule write FClienteModule;
    property EfectoCobrarModule : TEfectoCobrarModule read GetEfectoCobrarModule write FEfectoCobrarModule;
    property EfectoPagarModule : TEfectoPagarModule read GetEfectoPagarModule write FEfectoPagarModule;
    property FacturaModule : TFacturaModule read GetFacturaModule write FFacturaModule;
    property RemesaModule : TRemesaModule read GetRemesaModule write FRemesaModule;
    property RemesaPagoModule : TRemesaPagoModule read GetRemesaPagoModule write FRemesaPagoModule;
    property BancoModule : TBancoModule read GetBancoModule write FBancoModule;
    property RegistroPresentacionModule : TRegistroPresentacionModule read GetRegistroPresentacionModule write SetRegistroPresentacionModule;
    property MovimientoCajaModule : TMovimientoCajaModule read GetMovimientoCajaModule write FMovimientoCajaModule;
    property RelacionesDivisaModule : TRelacionesDivisaModule read GetRelacionesDivisaModule write FRelacionesDivisaModule;
    property FormaCobroModule : TFormaCobroModule read GetFormaCobroModule write FFormaCobroModule;
    property FormaPagoModule : TFormaPagoModule read GetFormaPagoModule write FFormaPagoModule;
    property SustitucionSubcuentasModule : TSustitucionSubcuentasModule read GetSustitucionSubcuentasModule write FSustitucionSubcuentasModule;
    property CierreContableModule : TCierreContableModule read GetCierreContableModule write FCierreContableModule;
    property RenumeracionAsientosModule : TRenumeracionAsientosModule read GetRenumeracionAsientosModule write FRenumeracionAsientosModule;
    property VerificacionContabilidadModule : TVerificacionContabilidadModule read GetVerificacionContabilidadModule write FVerificacionContabilidadModule;
    property GeneracionAmortizacionesModule : TGeneracionAmortizacionesModule read GetGeneracionAmortizacionesModule write FGeneracionAmortizacionesModule;
    property RegularizacionIVAModule : TRegularizacionIVAModule read GetRegularizacionIVAModule write FRegularizacionIVAModule;
    property ConsolidacionEmpresasModule : TConsolidacionEmpresasModule read GetConsolidacionEmpresasModule write FConsolidacionEmpresasModule;

  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses  DateUtils,
      Variants,
      Files,

      nxdbBase,
      nxllBde,
      nxsdTypes,
      nxsdFieldMapperDescriptor,
      nxsdDataDictionaryStrings,

      AppManager,
      EnterpriseData,
      SessionData,

      Gsm00Dm,

      dmi_ast,
      dmi_iva,
      dmi_fac;

{$R *.dfm}

resourceString
        RsMsg1 = 'Realizando ajustes adicionales';
        RsMsg2 = 'No se ha podido renombrar la tabla "FacturaRectificativa" como "Factura".';
        RsMsg3 = 'Se continúa con el proceso de actualización.'#13'Debe revisar sus datos una vez finalizado el proceso.';

procedure TDataModule10.ServerDataModuleCreate(Sender: TObject);
begin

     With SessionDataModule do
       begin
       SetupDatabaseDictionary( Dictionary, EnterpriseDataModule.Database );

       AddReestructureNotification( 'Factura', DoReestructureFacturaTable );
       end;

end;

procedure TDataModule10.ServerDataModuleDestroy(Sender: TObject);
begin
     FSessionDataModule.DictionaryList.Remove( Dictionary );
     SessionDataModule.Dm10 := nil;
end;

procedure TDataModule10.SetRegistroPresentacionModule( const Value : TRegistroPresentacionModule );
begin
     FRegistroPresentacionModule := Value;
end;

procedure TDataModule10.AjustesPrevios110036;
begin
     try
       If   EnterpriseDataModule.Database.TableExists( 'FacturaRectificativa', '' )
       then begin
            If   not EnterpriseDataModule.Database.TableExists( 'Factura', '' )
            then EnterpriseDataModule.Database.RenameTable( 'FacturaRectificativa', 'Factura', '' );
            Dictionary.DeleteTable( 'FacturaRectificativa', '' );  // Y la quito del diccionario, porque si no, se vuelve a crear a continuación
            end;
     except
       SessionDataModule.SendNotification( ntError, RsMsg2, RsMsg3 );
       end;
end;

procedure TDataModule10.Ajustes110040;

var  AsientoFields : TAsientoFields;
     FacturaFields : TFacturaFields;
     NroTotalRegistros,
     NroRegistro : LongInt;
     Percent,
     LastPercent : SmallInt;

procedure CompruebaPrimerSemestre;
begin
     If   ( AsientoFields.Fecha.Value>=EncodeDate( 2017, 1, 1 ) ) and
          ( AsientoFields.Fecha.Value<=EncodeDate( 2017, 6, 30 ) )
     then begin
          TargetTable.Edit;
          If   AsientoFields.TipoAsiento.Value=taFraEmitida
          then FacturaFields.RegimenOTrascendencia.Value := 15     // Primer semestre 2017.
          else FacturaFields.RegimenOTrascendencia.Value := 11;
          end;
end;

begin
     try

       SourceTable.TableName := 'Asiento';
       SourceTable.IndexFieldNames := 'Ejercicio;NroAsiento';
       SourceTable.Open;

       TargetTable.TableName := 'Factura';
       TargetTable.IndexFieldNames := 'Tipo;Ejercicio;Propietario;SerieFactura;NroRegistro';
       TargetTable.Open;

       AsientoFields := TAsientoFields.Create( SourceTable );
       FacturaFields := TFacturaFields.Create( TargetTable );

       NroTotalRegistros := SourceTable.RecordCount;
       NroRegistro := 0;
       LastPercent := -1;

       SourceTable.First;
       While not SourceTable.Eof do
         begin

         If   AsientoFields.TipoAsiento.Value in [ taFraEmitida, taFraRecibida ]
         then If   TargetTable.FindKey( [ tfAsiento, AsientoFields.Ejercicio.Value, '', '', AsientoFields.NroAsiento.Value ] )
              then begin
                   If   ( AsientoFields.TipoAsiento.Value=taFraEmitida ) and
                        ( FacturaFields.EjercicioFraRectificada.Value<>0 )
                   then begin
                        TargetTable.Edit;
                        FacturaFields.TipoFactura.Value := 5; // Factura Rectificativa (Resto)
                        end;
                   try
                     CompruebaPrimerSemestre;
                     If   TargetTable.State=dsEdit
                     then TargetTable.Post;
                   except
                     TargetTable.Cancel;
                     raise;
                     end;

                   end
              else try
                     TargetTable.Append;

                     FacturaFields.Tipo.Value := tfAsiento;
                     FacturaFields.Ejercicio.Value := AsientoFields.Ejercicio.Value;
                     FacturaFields.Propietario.Value := '';
                     FacturaFields.SerieFactura.Value := '';
                     FacturaFields.NroRegistro.Value := AsientoFields.NroAsiento.Value;

                     CompruebaPrimerSemestre;

                     TargetTable.Post;

                   except
                     TargetTable.Cancel;
                     raise;
                     end;

         Percent := Trunc( ( NroRegistro * 100 ) / NroTotalRegistros );
         If   Percent<>LastPercent
         then begin
              SessionDataModule.SendProgress( RsMsg1, 0, Percent );
              LastPercent := Percent;
              end;

         Inc( NroRegistro );

         SourceTable.Next;
         end;

       finally
         TargetTable.Close;
         SourceTable.Close;
       end;

     EnterpriseDataModule.ExecSQLCommand( 'UPDATE Asiento SET Serie=Serie + CASE WHEN Serie='''' THEN '''' ELSE ''-'' END + TOSTRING( NroFactura ), NroFactura=0 WHERE TipoAsiento IN ( 6, 8 ) AND NroFactura<>0', True, True, HighSQLTimeout );
     EnterpriseDataModule.ExecSQLCommand( 'UPDATE EfectoPagar SET Serie=Serie + CASE WHEN Serie='''' THEN '''' ELSE ''-'' END + TOSTRING( NroFactura ), NroFactura=0 WHERE NroFactura<>0', True, True, HighSQLTimeout );
     EnterpriseDataModule.ExecSQLCommand( 'UPDATE Inmovilizado SET Serie=Serie + CASE WHEN Serie='''' THEN '''' ELSE ''-'' END + TOSTRING( NroFactura ), NroFactura=0 WHERE NroFactura<>0', True, True, HighSQLTimeout );

end;

procedure TDataModule10.AjustesPrevios110083;

const
     ncrPeriodoCambioImpositivo   = 'PeriodoCambioImpositivo';

var  FechaAplicacionField : TDateField;
     CodigoField,
     EjercicioField,
     PeriodoField  : TSmallIntField;
     FechaAplicacion : TDate;
     Ejercicio,
     Codigo,
     Periodo,
     Mes : SmallInt;
     PeriodosList : TStringList;
     Fecha : TDate;
     Bm : TBookmark;

begin

     If   not FieldExists( SessionDataModule.EnterpriseDataModule.Database, SourceTable, 'TiposIVA', 'FechaAplicacion' )
     then try

            PeriodosList := TStringList.Create;
            SessionDataModule.Dm00.RegistroModule.ObtenListaDeClaves( ncrPeriodoCambioImpositivo, PeriodosList );

            EnterpriseDataModule.ExecSQLCommand( 'ALTER TABLE TiposIVA ADD COLUMN FechaAplicacion DATE;', { RaiseError } True, { Notify } True, HighSQLTimeout );

            SourceTable.TableName := 'TiposIVA';
            SourceTable.Open;

            FechaAplicacionField := TDateField( SourceTable.FindField( 'FechaAplicacion' ) );
            EjercicioField := TSmallIntField( SourceTable.FindField( 'Ejercicio' ) );

            CodigoField := TSmallIntField( SourceTable.FindField( 'Codigo' ) );
            PeriodoField := TSmallIntField( SourceTable.FindField( 'Periodo' ) );

            SourceTable.IndexFieldNames := 'Ejercicio;Periodo;Codigo';

            SourceTable.First;
            While not SourceTable.Eof do
              begin

              try

                Ejercicio := EjercicioField.Value;
                If   Ejercicio<>0  // Si el ejercicio es cero es un registro especial de relaciones contables
                then If   ( Ejercicio>1990 ) and ( Ejercicio<=SessionDataModule.Ejercicio )  // Solo por los posibles registros erróneos
                     then begin

                          If   CodigoField.Value>=rgRelaciones       // No deberían tener ejercicio. Solo existen por error al copiar registros de ejercicios anteriores.
                          then begin
                               SourceTable.Delete;
                               Continue;
                               end;

                          Mes := 1;
                          If   PeriodoField.Value=1
                          then Mes := StrToInt( PeriodosList.Values[ IntToStr( Ejercicio ) ] );
                          Fecha := EncodeDate( Ejercicio, Mes, 1 );

                          try
                            SourceTable.Edit;
                            FechaAplicacionField.Value := Fecha;
                            SourceTable.Post;
                          except
                            SourceTable.Cancel;
                            raise;
                            end;

                          // Inserto los registros que servirán de cabecera en los nuevos mantenimientos

                          If   ( CodigoField.Value=rgTiposIVA + 1 ) or  { 1 }
                               ( CodigoField.Value=rgRetenciones + 1 )  { 501 }
                          then begin
                               Bm := SourceTable.GetBookMark;

                               Codigo := CodigoField.Value - 1;
                               Periodo := PeriodoField.Value;

                               SourceTable.Append;
                               FechaAplicacionField.Value := Fecha;
                               CodigoField.Value := Codigo;

                               // Pongo el ejercicio y el periodo solo para evitar duplicidades (el viejo indice todavía existe).
                               // Los valores se perderán en la re-estructuración posterior

                               EjercicioField.Value := Ejercicio;
                               PeriodoField.Value := Periodo;

                               SourceTable.Post;

                               SourceTable.GotoBookMark( Bm );
                               end;


                          end
                     else begin
                          SourceTable.Delete;
                          Continue;
                          end;

              except
                SourceTable.Cancel;
                end;

              SourceTable.Next;
              end;

          finally
            SourceTable.Close;
            PeriodosList.Free;
            end;


end;

procedure TDataModule10.DictionaryBeforeUpdate;
begin
     With SessionDataModule.EnterpriseDataModule do
       begin
       CheckVersionAndExecute( 11, 0, 36, AjustesPrevios110036 );
       CheckVersionAndExecute( 11, 0, 83, AjustesPrevios110083 );
       end;
end;

procedure TDataModule10.DictionaryAfterUpdate;
begin
     With SessionDataModule.EnterpriseDataModule do
       CheckVersionAndExecute( 11, 0, 40, Ajustes110040 );

     SessionDataModule.EnterpriseDataModule.ComparableVersion
end;

function TDataModule10.GetCuentaModule : TCuentaModule;
begin
     Result := TCuentaModule( CheckServerDataModule( EnterpriseDataModule, TCuentaModule, FCuentaModule ) );
end;

procedure TDataModule10.FreeCuentaModule;
begin
     If   Assigned( FCuentaModule )
     then FCuentaModule.Free;
     FCuentaModule := nil;
end;

function TDataModule10.GetSaldosModule : TSaldosModule;
begin
     Result := TSaldosModule( CheckServerDataModule( EnterpriseDataModule, TSaldosModule, FSaldosModule ) );
end;

procedure TDataModule10.FreeSaldosModule;
begin
     If   Assigned( FSaldosModule )
     then FSaldosModule.Free;
     FSaldosModule := nil;
end;

function TDataModule10.GetTasaModule : TTasaModule;
begin
     Result := TTasaModule( CheckServerDataModule( EnterpriseDataModule, TTasaModule, FTasaModule ) );
end;

procedure TDataModule10.FreeTasaModule;
begin
     If   Assigned( FTasaModule )
     then FTasaModule.Free;
     FTasaModule := nil;
end;

function TDataModule10.GetVerificacionContabilidadModule : TVerificacionContabilidadModule;
begin
     Result := TVerificacionContabilidadModule( CheckServerDataModule( EnterpriseDataModule, TVerificacionContabilidadModule, FVerificacionContabilidadModule ) );
end;

procedure TDataModule10.FreeVerificacionContabilidadModule;
begin
     If   Assigned( FVerificacionContabilidadModule )
     then FVerificacionContabilidadModule.Free;
     FVerificacionContabilidadModule := nil;
end;

function TDataModule10.GetGeneracionAmortizacionesModule : TGeneracionAmortizacionesModule;
begin
     Result := TGeneracionAmortizacionesModule( CheckServerDataModule( EnterpriseDataModule, TGeneracionAmortizacionesModule, FGeneracionAmortizacionesModule ) );
end;

procedure TDataModule10.FreeGeneracionAmortizacionesModule;
begin
     If   Assigned( FGeneracionAmortizacionesModule )
     then FGeneracionAmortizacionesModule.Free;
     FGeneracionAmortizacionesModule := nil;
end;

function TDataModule10.GetRegularizacionIVAModule : TRegularizacionIVAModule;
begin
     Result := TRegularizacionIVAModule( CheckServerDataModule( EnterpriseDataModule, TRegularizacionIVAModule, FRegularizacionIVAModule ) );
end;

procedure TDataModule10.FreeRegularizacionIVAModule;
begin
     If   Assigned( FRegularizacionIVAModule )
     then FRegularizacionIVAModule.Free;
     FRegularizacionIVAModule := nil;
end;

function TDataModule10.GetConsolidacionEmpresasModule : TConsolidacionEmpresasModule;
begin
     Result := TConsolidacionEmpresasModule( CheckServerDataModule( EnterpriseDataModule, TConsolidacionEmpresasModule, FConsolidacionEmpresasModule ) );
end;

procedure TDataModule10.FreeConsolidacionEmpresasModule;
begin
     If   Assigned( FConsolidacionEmpresasModule )
     then FConsolidacionEmpresasModule.Free;
     FConsolidacionEmpresasModule := nil;
end;

function TDataModule10.GetSerieFacturacionModule : TSerieFacturacionModule;
begin
     Result := TSerieFacturacionModule( CheckServerDataModule( EnterpriseDataModule, TSerieFacturacionModule, FSerieFacturacionModule ) );
end;

procedure TDataModule10.FreeSerieFacturacionModule;
begin
     If   Assigned( FSerieFacturacionModule )
     then FSerieFacturacionModule.Free;
     FSerieFacturacionModule := nil;
end;

function TDataModule10.GetSustitucionSubcuentasModule : TSustitucionSubcuentasModule;
begin
     Result := TSustitucionSubcuentasModule( CheckServerDataModule( EnterpriseDataModule, TSustitucionSubcuentasModule, FSustitucionSubcuentasModule ) );
end;

procedure TDataModule10.FreeSustitucionSubcuentasModule;
begin
     If   Assigned( FSustitucionSubcuentasModule )
     then FSustitucionSubcuentasModule.Free;
     FSustitucionSubcuentasModule := nil;
end;

function TDataModule10.GetProveedorModule : TProveedorModule;
begin
     Result := TProveedorModule( CheckServerDataModule( EnterpriseDataModule, TProveedorModule, FProveedorModule ) );
end;

procedure TDataModule10.FreeProveedorModule;
begin
     If   Assigned( FProveedorModule )
     then FProveedorModule.Free;
     FProveedorModule := nil;
end;

function TDataModule10.GetRelacionesDivisaModule: TRelacionesDivisaModule;
begin
     Result := TRelacionesDivisaModule( CheckServerDataModule( EnterpriseDataModule, TRelacionesDivisaModule, FRelacionesDivisaModule ) );
end;

procedure TDataModule10.FreeRelacionesDivisaModule;
begin
     If   Assigned( FRelacionesDivisaModule )
     then FRelacionesDivisaModule.Free;
     FRelacionesDivisaModule:= nil;
end;

function TDataModule10.GetFacturaModule: TFacturaModule;
begin
     Result := TFacturaModule( CheckServerDataModule( EnterpriseDataModule, TFacturaModule, FFacturaModule ) );
end;

procedure TDataModule10.FreeFacturaModule;
begin
     If   Assigned( FFacturaModule )
     then FFacturaModule.Free;
     FFacturaModule := nil;
end;

function TDataModule10.GetRemesaModule: TRemesaModule;
begin
     Result := TRemesaModule( CheckServerDataModule( EnterpriseDataModule, TRemesaModule, FRemesaModule ) );
end;

procedure TDataModule10.FreeRemesaModule;
begin
     If   Assigned( FRemesaModule )
     then FRemesaModule.Free;
     FRemesaModule := nil;
end;

function TDataModule10.GetRemesaPagoModule: TRemesaPagoModule;
begin
     Result := TRemesaPagoModule( CheckServerDataModule( EnterpriseDataModule, TRemesaPagoModule, FRemesaPagoModule ) );
end;

procedure TDataModule10.FreeRemesaPagoModule;
begin
     If   Assigned( FRemesaPagoModule )
     then FRemesaPagoModule.Free;
     FRemesaPagoModule := nil;
end;

function TDataModule10.GetRenumeracionAsientosModule : TRenumeracionAsientosModule;
begin
     Result := TRenumeracionAsientosModule( CheckServerDataModule( EnterpriseDataModule, TRenumeracionAsientosModule, FRenumeracionAsientosModule ) );
end;

procedure TDataModule10.FreeRenumeracionAsientosModule;
begin
     If   Assigned( FRenumeracionAsientosModule )
     then FRenumeracionAsientosModule.Free;
     FRenumeracionAsientosModule := nil;
end;

function TDataModule10.GetAsientoModule : TAsientoModule;
begin
     Result := TAsientoModule( CheckServerDataModule( EnterpriseDataModule, TAsientoModule, FAsientoModule ) );
end;

procedure TDataModule10.FreeAllDataModules;
begin
     FreeAsientoModule;
     FreeBancoModule;
     FreeRegistroPresentacionModule;
     FreeCierreContableModule;
     FreeClienteModule;
     FreeConsolidacionEmpresasModule;
     FreeCuentaModule;
     FreeEfectoCobrarModule;
     FreeEfectoPagarModule;
     FreeFacturaModule;
     FreeFormaCobroModule;
     FreeFormaPagoModule;
     FreeGeneracionAmortizacionesModule;
     FreeRegularizacionIVAModule;
     FreeMovimientoCajaModule;
     FreeProveedorModule;
     FreeRelacionesDivisaModule;
     FreeRemesaModule;
     FreeRemesaPagoModule;
     FreeRenumeracionAsientosModule;
     FreeSaldosModule;
     FreeSerieFacturacionModule;
     FreeSustitucionSubcuentasModule;
     FreeTasaModule;
     FreeVerificacionContabilidadModule;
end;

procedure TDataModule10.FreeAsientoModule;
begin
     If   Assigned( FAsientoModule )
     then FAsientoModule.Free;
     FAsientoModule := nil;
end;

function TDataModule10.GetBancoModule : TBancoModule;
begin
     Result := TBancoModule( CheckServerDataModule( EnterpriseDataModule, TBancoModule, FBancoModule ) );
end;

procedure TDataModule10.FreeBancoModule;
begin
     If   Assigned( FBancoModule )
     then FBancoModule.Free;
     FBancoModule := nil;
end;

function TDataModule10.GetRegistroPresentacionModule : TRegistroPresentacionModule;
begin
     Result := TRegistroPresentacionModule( CheckServerDataModule( EnterpriseDataModule, TRegistroPresentacionModule, FRegistroPresentacionModule ) );
end;

procedure TDataModule10.FreeRegistroPresentacionModule;
begin
     If   Assigned( FRegistroPresentacionModule )
     then FRegistroPresentacionModule.Free;
     FRegistroPresentacionModule := nil;
end;

function TDataModule10.GetMovimientoCajaModule : TMovimientoCajaModule;
begin
     Result := TMovimientoCajaModule( CheckServerDataModule( EnterpriseDataModule, TMovimientoCajaModule, FMovimientoCajaModule ) );
end;

procedure TDataModule10.FreeMovimientoCajaModule;
begin
     If   Assigned( FMovimientoCajaModule )
     then FMovimientoCajaModule.Free;
     FMovimientoCajaModule := nil;
end;

function TDataModule10.GetCierreContableModule : TCierreContableModule;
begin
     Result := TCierreContableModule( CheckServerDataModule( EnterpriseDataModule, TCierreContableModule, FCierreContableModule ) );
end;

procedure TDataModule10.FreeCierreContableModule;
begin
     If   Assigned( FCierreContableModule )
     then FCierreContableModule .Free;
     FCierreContableModule := nil;
end;

function TDataModule10.GetClienteModule : TClienteModule;
begin
     Result := TClienteModule( CheckServerDataModule( EnterpriseDataModule, TClienteModule, FClienteModule ) );
end;

procedure TDataModule10.FreeClienteModule;
begin
     If   Assigned( FClienteModule )
     then FClienteModule.Free;
     FClienteModule := nil;
end;

function TDataModule10.GetEfectoCobrarModule : TEfectoCobrarModule;
begin
     Result := TEfectoCobrarModule( CheckServerDataModule( EnterpriseDataModule, TEfectoCobrarModule, FEfectoCobrarModule ) );
end;

procedure TDataModule10.FreeEfectoCobrarModule;
begin
     If   Assigned( FEfectoCobrarModule )
     then FEfectoCobrarModule.Free;
     FEfectoCobrarModule := nil;
end;

function TDataModule10.GetEfectoPagarModule: TEfectoPagarModule;
begin
     Result := TEfectoPagarModule( CheckServerDataModule( EnterpriseDataModule, TEfectoPagarModule, FEfectoPagarModule ) );
end;

procedure TDataModule10.FreeEfectoPagarModule;
begin
     If   Assigned( FEfectoPagarModule )
     then FEfectoPagarModule.Free;
     FEfectoPagarModule := nil;
end;

function TDataModule10.GetFormaCobroModule : TFormaCobroModule;
begin
     Result := TFormaCobroModule( CheckServerDataModule( EnterpriseDataModule, TFormaCobroModule, FFormaCobroModule ) );
end;

procedure TDataModule10.FreeFormaCobroModule;
begin
     If   Assigned( FFormaCobroModule )
     then FFormaCobroModule.Free;
     FFormaCobroModule := nil;
end;

function TDataModule10.GetFormaPagoModule : TFormaPagoModule;
begin
     Result := TFormaPagoModule( CheckServerDataModule( EnterpriseDataModule, TFormaPagoModule, FFormaPagoModule ) );
end;

procedure TDataModule10.FreeFormaPagoModule;
begin
     If   Assigned( FFormaPagoModule )
     then FFormaPagoModule.Free;
     FFormaPagoModule := nil;
end;

function TDataModule10.GetSQL( Title : string ) : string;
begin
     Result := SQLSet.GetSQLText( Title );
end;

procedure TDataModule10.DoReestructureFacturaTable(     EventType        : TReestructureEventType;
                                                    var ReestructureData : TReestructureData );
begin

     With ReestructureData do
       case EventType of
         reCheck   : ;
         reBefore  : If   DatabaseComparableVersion<'11000036'
                     then begin
                          RecordMapper.AddMapping( 'EjercicioFactura', 'EjercicioFraRectificada', dlaBestFit );
                          RecordMapper.AddMapping( 'Serie', 'SerieFraRectificada', dlaBestFit );
                          RecordMapper.AddMapping( 'NroFactura', 'NroFacturaRectificada', dlaBestFit );
                          DontCheckRecordMapping := True;
                          end
                     else If   DatabaseComparableVersion<'11000040'
                          then begin
                               RecordMapper.AddMapping( 'Serie', 'SerieFactura', dlaBestFit );
                               DontCheckRecordMapping := True;
                               end;
         reAfter   : ;
         end;

end;


initialization


end.
