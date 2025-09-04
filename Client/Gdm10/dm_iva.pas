unit dm_iva;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  AppForms,
  DB,
  nxdb,
  DataManager,
  
  LibUtils,
  frxNXRTTI,

  Gim00Fields,
  Gim10Fields,

  dmi_iva;

type

  TTasaModule = class(TDataModule)
    DmTiposIVATable: TnxeTable;
    DmRelacionesTiposIVATable: TnxeTable;
    procedure TasaModuleCreate(Sender: TObject);
    procedure TasaModuleDestroy(Sender: TObject);

  private

    DmTiposIVAFields,
    DmRelacionesTiposIVAFields : TTiposIVAFields;

    TasaService : ITasaService;

    function  TextoTasa( FormatoSeccionIVA : TFormatoSeccionIVA ) : String;
    function  TextoRetencion : String;
    function  DescripcionTasaIVA( Modelo, NroRegistro : Integer; Fecha : TDate; CodigoPais  : String = CodigoEspaña ) : String;  // Solo se usa desde frxNxRTTI

    function ObtenRegistro( Fecha : TDate; CodigoPais: String; NroRegistro : SmallInt; Retencion : Boolean = False ) : Boolean;

    function ObtenTipoIVA( Fecha : TDate; CodigoPais : String; NroRegistro : SmallInt ) : Boolean;
    function ObtenTipoRetencion( Fecha : TDate; NroRegistro : SmallInt ) : Boolean;

  public

    function TipoIVA( Fecha : TDate; NroRegistro : SmallInt; TiposIVAFields : TTiposIVAFields = nil ) : Boolean; overload;
    function TipoIVA( Fecha : TDate; CodigoPais : String; NroRegistro : SmallInt; TiposIVAFields : TTiposIVAFields = nil ) : Boolean; overload;

    procedure GuardaTipoIVAGlobal( FechaAplicacion : TDate; CodigoPais : String; TipoIVAGlobal : SmallInt; TipoIVA : SmallInt );
    function TipoIVAGlobal( Fecha : TDate; TipoIVA : SmallInt  ) : SmallInt; overload;
    function TipoIVAGlobal( Fecha : TDate; CodigoPais : String; TipoIVA : SmallInt  ) : SmallInt; overload;
    function SuprimeTipoIVAGlobal( Fecha : TDate; CodigoPais : String; TipoIVA : SmallInt  ) : SmallInt;
    function TipoRetencion( Fecha : TDate; NroRegistro : SmallInt; TiposIVAFields : TTiposIVAFields = nil ) : Boolean;
    procedure GuardaRelacion( SubcuentaRelacion : TSubcuentaRelacion; Codigo : String );
    function  ObtenRelacion( SubcuentaRelacion : TSubcuentaRelacion ) : String;
    function UltimaFechaAplicacion( Fecha : TDate = 0; Retencion : Boolean = False; CodigoPais : String = CodigoEspaña ) : TDate;
    function CopiaRegistros( FechaAplicacion, Fecha : TDate; TipoRegistro : SmallInt = rgTiposIVA; CodigoPais : String = CodigoEspaña ) : Boolean;

	   function DescripcionTipoIVAPorcentaje( Fecha : TDate; CodigoPais : String; TipoPorcentaje : TTipoPorcentaje; Porcentaje : Decimal ) : String;
    function  DescripcionTasa( FormatoSeccionIVA : TFormatoSeccionIVA; CodigoPais : String; NroRegistro : SmallInt; Fecha : TDate = 0 ) : String;
    procedure ValidaTasa(     EditControl     : TcxCustomEdit;
                          var DisplayValue   : Variant;
                          var ResultText     : TCaption;
                          var Error          : Boolean;
                              SeccionIVA     : TSeccionIVA;
                              Fecha          : TDateTime;
                              CodigoPais     : String = CodigoEspaña;
                              TiposIVAFields : TTiposIVAFields = nil;
                              IsInfoControl  : Boolean = False );
    procedure ValidaRetencion( Fecha : TDateTime; EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean; TiposIVAFields : TTiposIVAFields = nil; IsInfoControl : Boolean = False );

    function  DescripcionRetencion( Fecha : TDate; NroRegistro : SmallInt ) : String;
    procedure CompruebaPeriodoImpositivo( FechaInicial, FechaFinal : TDateTime; CodigoPais : String = CodigoEspaña  );
    procedure CompruebaCambioTipoImpositivo( SeccionIVA : TSeccionIVA; var DisplayValue : Variant; FechaAnterior : TDateTime; var ErrorText  : TCaption; var Error : Boolean );

    {$IFNDEF TOUCHAPP} procedure ObtenSubcuentasIVA( Fecha : TDate; NroRegistro : SmallInt; var SubcuentaIVASoportado : String; var SubcuentaIVARepercutido : String; CodigoPais : String = CodigoEspaña ); {$ENDIF}
    function TextoRazonRectificacion( Valor : SmallInt ) : String;
    function TextoMetodoRectificacion( Valor : SmallInt ) : String;  

    function ConsultaTipoIVA( TipoConsulta : TTipoConsultaTipoIVA; Fecha : TDate; CodigoPais : String; NroRegistro : Integer ) : Decimal;   // Se utiliza desde los informes (frxNxRTTI)

  end;

function Tasa : TTasaModule;
function TextoAjustado( Value : String; Len : SmallInt ) : String;

implementation

uses Variants,
     Math,
     cxDateUtils,
     dxCalendarUtils,

     EnterpriseDataAccess,
     AppManager,
     DateUtils,
     AppContainer,
     NexusRpcData,

     Gdm00Dm,

     {$IFNDEF TOUCHAPP}
     dm_sub,
     {$ENDIF}

     dm_pai,

     b_msg;

{$R *.DFM}

resourceString
     RsMsg1   = 'Exento/Nulo';
     RsMsg2   = 'Las fechas no pertenecen al mismo periodo impositivo.';
     RsMsg3   = 'En el periodo indicado no deben haber cambios de ejercicio fiscal o cambios en el tipo de tasas aplicadas (periodos con tipos de I.V.A. diferentes).';
     RsMsg4   = 'La fecha pertenece a un periodo impositivo distinto y existen diferencias en los tipos aplicados.';
     RsMsg5   = 'Si quiere trasladar la factura de un periodo a otro tendrá que suprimirla y volverla a generar para que se reajusten los importes afectados por el cambio en los tipos.';
     RsMsg6   = 'No definido';

     rsIVAManual = 'Manual';
     rsIVAPortes = 'Portes';

var TasaModule : TTasaModule = nil;

// Funciones

function TextoAjustado( Value : String;
                        Len   : SmallInt ) : String;

var  Index : SmallInt;

begin

     Value := AnsiUpperCase( StrRemoveChars( Value, [ '!'..'/', ':'..'?', '['..'`' ] ) );

     // Sustituyendo cualquier vocal acentuada o con cualquier otro tipo de diéresis, tilde o gorrito, por la vocal simple y llana

     For Index := 1 to Length( Value ) do
       If   Ord( Value[ Index ] ) in [ $C0..$C5 ]
       then Value[ Index ] := 'A'
       else If   Ord( Value[ Index ] ) in [ $C8..$CB ]
            then Value[ Index ] := 'E'
            else If   Ord( Value[ Index ] ) in [ $CC..$CF ]
                 then Value[ Index ] := 'I'
                 else If   Ord( Value[ Index ] ) in [ $D2..$D6 ]
                      then Value[ Index ] := 'O'
                      else If   Ord( Value[ Index ] ) in [ $D9..$DC ]
                           then Value[ Index ] := 'U';

     Result := RightPad( Copy( Value, 1, Len ), Len );
end;

function Tasa : TTasaModule;
begin
     CreateDataModule( TTasaModule, TasaModule );
     Result := TasaModule;
end;

procedure TTasaModule.TasaModuleCreate(Sender: TObject);
begin

     NexusRpc.CreateRemoteInstance( CLSID_TasaService, ITasaService, TasaService );

     DmTiposIVAFields := TTiposIVAFields.Create( DmTiposIVATable );
     DmRelacionesTiposIVAFields := TTiposIVAFields.Create( DmRelacionesTiposIVATable );

     ConsultaTipoIVAEvent := ConsultaTipoIVA;
     DescripcionTasaEvent := DescripcionTasaIVA;

end;

procedure TTasaModule.TasaModuleDestroy(Sender: TObject);
begin
     ConsultaTipoIVAEvent := nil;
     DescripcionTasaEvent := nil;
     TasaModule := nil;
end;

function TTasaModule.ConsultaTipoIVA( TipoConsulta : TTipoConsultaTipoIVA;
                                      Fecha        : TDate;
                                      CodigoPais   : String;
                                      NroRegistro  : Integer ) : Decimal;
begin
     Result := 0.0;
     If   TipoConsulta=tcRetencion
     then begin
          If   ObtenTipoRetencion( Fecha, NroRegistro )
          then Result := DmTiposIVAFields.Retencion.Value;
          end
     else If   ObtenTipoIVA( Fecha, CodigoPais, NroRegistro )
          then case TipoConsulta of
                 tcIVASoportado   : Result := DmTiposIVAFields.IVASoportado.Value;
                 tcIVARepercutido : Result := DmTiposIVAFields.IVARepercutido.Value;
                 tcRE             : Result := DmTiposIVAFields.RERepercutido.Value;
                 end;
end;

procedure TTasaModule.ValidaTasa(     EditControl     : TcxCustomEdit;
                                  var DisplayValue   : Variant;
                                  var ResultText     : TCaption;
                                  var Error          : Boolean;
                                      SeccionIVA     : TSeccionIVA;
                                      Fecha          : TDateTime;
                                      CodigoPais     : String = CodigoEspaña;
                                      TiposIVAFields : TTiposIVAFields = nil;
                                      IsInfoControl  : Boolean = False );

var  Ejercicio,
     NroRegistro : SmallInt;

begin
     If   ValueIsEmpty( DisplayValue, varSmallInt )
     then begin
          With DmTiposIVATable do
            try
              Append;
              DmTiposIVAFields.Descripcion.Value := RsMsg1;
            finally
              Browse;
              end;
          ResultText := RsMsg1;
          end
     else With DmTiposIVATable do
            begin
            NroRegistro := VarToSmallInt( DisplayValue );
            If   ObtenTipoIVA( Fecha, CodigoPais, NroRegistro )
            then ResultText := TextoTasa( SeccionIVA )
            else begin
                 Error := True;
                 ResultText := JoinMessage( RsgMsg311, RsgMsg312 );
                 end;

            end;

     If   Assigned( EditControl ) and not Error
     then EditControl.Description := ResultText;

     If   Assigned( TiposIVAFields )
     then TiposIVAFields.Update( DmTiposIVATable );

end;

procedure TTasaModule.ValidaRetencion(     Fecha          : TDateTime;
                                           EditControl    : TcxCustomEdit;
                                       var DisplayValue   : Variant;
                                       var ErrorText      : TCaption;
                                       var Error          : Boolean;
                                           TiposIVAFields : TTiposIVAFields = nil;
                                           IsInfoControl  : Boolean = False );

var  St : String;
     Ejercicio,
     NroRegistro : SmallInt;

begin
     St := '';
     If   not ValueIsEmpty( DisplayValue, varSmallInt )
     then With DmTiposIVATable do
            begin
            NroRegistro := VarToSmallInt( DisplayValue );
            If   ObtenTipoRetencion( Fecha, NroRegistro )
            then St := TextoRetencion
            else begin
                 Error := True;
                 ErrorText := JoinMessage( RsgMsg311, RsgMsg312 );
                 end;

            end;

     If   Assigned( EditControl )
     then EditControl.Description := St;

     If   Assigned( TiposIVAFields )
     then TiposIVAFields.Update( DmTiposIVATable );
end;

procedure TTasaModule.CompruebaPeriodoImpositivo( FechaInicial,
                                                  FechaFinal : TDateTime;
                                                  CodigoPais : String = CodigoEspaña );
begin
     If   UltimaFechaAplicacion( FechaInicial )<>UltimaFechaAplicacion( FechaFinal )
     then begin
          ShowNotification( ntStop, RsMsg2, RsMsg3 );
          Abort;
          end;
end;

procedure TTasaModule.CompruebaCambioTipoImpositivo(     SeccionIVA    : TSeccionIVA;
                                                     var DisplayValue  : Variant;
                                                         FechaAnterior : TDateTime;
                                                     var ErrorText     : TCaption;
                                                     var Error         : Boolean );

var  FechaActual : TDateTime;

begin
     If   TextToDateEx( DisplayValue, FechaActual )
     then If   UltimaFechaAplicacion( FechaActual )<>UltimaFechaAplicacion( FechaAnterior )
          then begin
               Error := True;
               ErrorText := JoinMessage( RsMsg4, RsMsg5 );
               end;
end;

function TTasaModule.TextoTasa( FormatoSeccionIVA  : TFormatoSeccionIVA ) : String;
begin

     // Para poder utilizar esta función hay que llamar antes a TipoIVA

     With DmTiposIVAFields do
       begin
       Result := Descripcion.Value;
       case FormatoSeccionIVA of
         fsiSoportado        : Result := Result + '. ' + StrFormat( IVASoportado.Value, DecimalesTasas ) + ' %.';
         fsiRepercutido      : Result := Result + '. ' + StrFormat( IVARepercutido.Value, DecimalesTasas ) + ' % / ' + StrFormat( RERepercutido.Value, DecimalesTasas ) + ' %.';
         fsiAmbos            : Result := Result + '. ' + StrFormat( IVASoportado.Value, DecimalesTasas ) + ' / ' + StrFormat( IVARepercutido.Value, DecimalesTasas ) + ' %.';
         fsiSoportadoCorto   : Result := StrFormat( IVASoportado.Value, DecimalesTasas ) + ' %.';
         fsiRepercutidoCorto : Result := StrFormat( IVARepercutido.Value, DecimalesTasas ) + ' % / ' + StrFormat( RERepercutido.Value, DecimalesTasas ) + ' %.';
         fsiAmbosCorto       : Result := StrFormat( IVASoportado.Value, DecimalesTasas ) + ' / ' + StrFormat( IVARepercutido.Value, DecimalesTasas ) + ' %.';
         fsiSoloDescripcion  : ;
         end;
       end;
end;

function  TTasaModule.DescripcionTasa( FormatoSeccionIVA : TFormatoSeccionIVA;
                                       CodigoPais        : String;
                                       NroRegistro       : SmallInt;
                                       Fecha             : TDate = 0 ) : String;
begin
     If   Fecha=0
     then Fecha := ApplicationContainer.TodayDate;
     If   ObtenTipoIVA( Fecha, CodigoPais, NroRegistro )
     then Result := TextoTasa( FormatoSeccionIVA )
     else Result := RsRegistroInexistente;
end;

// Esta función no utiliza TFormatoSeccionIVA porque se llama desde frxNRTTI para resolver la descripción a partir de un smallint
// En PascalScript no existen los SmallInt

function  TTasaModule.DescripcionTasaIVA( Modelo,
                                          NroRegistro : Integer;
                                          Fecha       : TDate;
                                          CodigoPais  : String = CodigoEspaña ) : String;
begin
     If   Modelo in [ fsiSoportado..fsiSoloDescripcion ]
     then Result := DescripcionTasa( TSeccionIVA( Modelo ), CodigoPais, NroRegistro, Fecha )
     else Result := '';
end;

function TTasaModule.TextoRetencion : String;
begin
     With DmTiposIVAFields do
       If   Retencion.Value=0
       then Result := ''
       else Result := Descripcion.Value + ' ' + StrFormat( Retencion.Value, DecimalesTasas ) + '%.';
end;

function TTasaModule.DescripcionRetencion( Fecha       : TDate;
                                           NroRegistro : SmallInt ) : String;
begin
     TipoRetencion( Fecha, NroRegistro );
     Result := TextoRetencion;
end;

function TTasaModule.DescripcionTipoIVAPorcentaje( Fecha          : TDate;
                                                   CodigoPais     : String;
                                                   TipoPorcentaje : TTipoPorcentaje;
                                                   Porcentaje     : Decimal ) : String;

var  NroEjercicio : SmallInt;

function ObtenDescripcion( FechaAplicacion : TDate ) : String;
begin
     Result := '';

     If   CodigoPais=''
     then CodigoPais := CodigoEspaña;

     DmTiposIVATable.SetRange( [ FechaAplicacion, CodigoPais, rgTiposIVA + 1 ], [ FechaAplicacion, CodigoPais, rgTiposIVA + NroMaximoTiposTasas ] );

     DmTiposIVATable.First;
     While not DmTiposIVATable.Eof do
       begin
       If   ( ( TipoPorcentaje=tpIVASoportado ) and  ( DmTiposIVAFields.IVASoportado.Value=Porcentaje ) ) or
            ( ( TipoPorcentaje=tpIVARepercutido ) and ( DmTiposIVAFields.IVARepercutido.Value=Porcentaje ) ) or
            ( ( TipoPorcentaje=tpRERepercutido ) and  ( DmTiposIVAFields.RERepercutido.Value=Porcentaje ) )
       then begin
            Result := DmTiposIVAFields.Descripcion.Value;
            Exit;
            end;
       DmTiposIVATable.Next;
       end;
end;

begin
     If   Porcentaje=0.0
     then Result := RsMsg1
     else try

            var FechaAplicacion := UltimaFechaAplicacion( Fecha );
            Result := ObtenDescripcion( FechaAplicacion );
            If   Result=''
            then begin
                 FechaAplicacion := UltimaFechaAplicacion( IncDay( FechaAplicacion, -1 ) );  // Si no lo encuentro en la última tabla lo busco an la inmediatamente anterior
                 Result := ObtenDescripcion( FechaAplicacion );
                 end;

            If   Result=''
            then Result := RsMsg6;
          finally
            DmTiposIVATable.CancelRange;
            end;
end;

function TTasaModule.TextoRazonRectificacion( Valor : SmallInt ) : String;
begin
     If   Valor in [ 1..16 ]
     then Result := TextoRazonRectificacion1a16[ Valor ]
     else If   Valor in [ 80..85 ]
          then Result := TextoRazonRectificacion80a85[ Valor ]
          else Result := 'Otros';
end;

function TTasaModule.TextoMetodoRectificacion( Valor : SmallInt ) : String;
begin
     If   Valor in [ 1..4 ]
     then Result := TextoMetodoRectificacion1a4[ Valor ]
     else Result := 'Otros';
end;


function TTasaModule.SuprimeTipoIVAGlobal( Fecha      : TDate;
                                           CodigoPais : String;
                                           TipoIVA    : SmallInt ) : SmallInt;

var  FechaAplicacion : TDate;

begin
     FechaAplicacion := UltimaFechaAplicacion( Fecha );
     With DmTiposIVATable do
       If   FindKey( [ FechaAplicacion, CodigoPais, TipoIVA ] )
       then Delete;
end;

function TTasaModule.ObtenTipoRetencion( Fecha       : TDate;
                                         NroRegistro : SmallInt ) : Boolean;
begin
     Result := False;
     With DmTiposIVATable do
       If   NroRegistro=0
       then try
              Append;
              Result := True;
            finally
              Browse;
              end
       else Result := ObtenRegistro( Fecha, '', NroRegistro, { Retencion } True );
end;

function TTasaModule.TipoRetencion( Fecha          : TDate;
                                    NroRegistro    : SmallInt;
                                    TiposIVAFields : TTiposIVAFields = nil ) : Boolean;
begin
     Result := ObtenTipoRetencion( Fecha, NroRegistro );
     If   Assigned( TiposIVAFields )
     then TiposIVAFields.Update( DmTiposIVATable );
end;

function TTasaModule.ObtenRegistro( Fecha        : TDate;
                                    CodigoPais   : String;
                                    NroRegistro  : SmallInt;
                                    Retencion    : Boolean = False ) : Boolean;

var  NroRegistroBase : SmallInt;

begin
     Result := False;

     If   NroRegistro in [ 1..NroMaximoTiposTasas ]
     then begin

          If   Retencion
          then NroRegistroBase := rgRetenciones
          else NroRegistroBase := rgTiposIVA;

          If   CodigoPais=''
          then CodigoPais := CodigoEspaña;

          DmTiposIVATable.SetRange( [ LowestDateTime, CodigoPais, NroRegistroBase + 1 ], [ Fecha, CodigoPais, NroRegistroBase + NroMaximoTiposTasas + 1 ] );
          try
            DmTiposIVATable.Last;
            If   DmTiposIVATable.Found
            then Result := DmTiposIVATable.FindKey( [ DmTiposIVAFields.FechaAplicacion.Value, CodigoPais, NroRegistroBase + NroRegistro ] );
          finally
            DmTiposIVATable.CancelRange;
            end;

          end;
end;

function TTasaModule.CopiaRegistros( FechaAplicacion,
                                     Fecha        : TDate;
                                     TipoRegistro : SmallInt = rgTiposIVA;
                                     CodigoPais   : String = CodigoEspaña ) : Boolean;
begin
     Result := TasaService.CopiaRegistros( FechaAplicacion, Fecha, TipoRegistro, CodigoPais );
end;

function TTasaModule.UltimaFechaAplicacion( Fecha      : TDate = 0;
                                            Retencion  : Boolean = False;
                                            CodigoPais : String = CodigoEspaña ) : TDate;
begin
     If   Fecha=0
     then Fecha := ApplicationContainer.TodayDate;
     If   ObtenRegistro( Fecha, CodigoPais, 1, Retencion  ) // Basta con que exista el primer tipo
     then Result := DmTiposIVAFields.FechaAplicacion.Value
     else Result := 0;  // No existe
end;

function TTasaModule.ObtenTipoIVA( Fecha       : TDate;
                                   CodigoPais  : String;
                                   NroRegistro : SmallInt ) : Boolean;
begin
     Result := False;
     If   NroRegistro=0
     then try
            DmTiposIVATable.Append;
            DmTiposIVAFields.Descripcion.Value := RsMsg1;
            Result := True;
          finally
            DmTiposIVATable.Browse;
            end
     else Result := ObtenRegistro( Fecha, CodigoPais, NroRegistro );
end;

function TTasaModule.TipoIVA( Fecha          : TDate;
                              NroRegistro    : SmallInt;
                              TiposIVAFields : TTiposIVAFields = nil ) : Boolean;
begin
     Result := TipoIVA( Fecha, CodigoEspaña, NroRegistro, TiposIVAFields );
end;

function TTasaModule.TipoIVA( Fecha          : TDate;
                              CodigoPais     : String;
                              NroRegistro    : SmallInt;
                              TiposIVAFields : TTiposIVAFields = nil ) : Boolean;
begin
     Result := ObtenTipoIVA( Fecha, CodigoPais, NroRegistro );
     If   Assigned( TiposIVAFields )
     then TiposIVAFields.Update( DmTiposIVATable );
end;

procedure TTasaModule.GuardaTipoIVAGlobal( FechaAplicacion : TDate;
                                           CodigoPais      : String;
                                           TipoIVAGlobal   : SmallInt;  { rgTipoIVAManual, rgTipoIVAPortes, etc.. }
                                           TipoIVA         : SmallInt );
begin
     With DmTiposIVATable do
       try
         If   FindKey( [ FechaAplicacion, CodigoPais, TipoIVAGlobal ] )
         then Edit
         else begin
              Append;
              DmTiposIVAFields.FechaAplicacion.Value := FechaAplicacion;
              DmTiposIVAFields.CodigoPais.Value := CodigoPais;
              DmTiposIVAFields.Codigo.Value := TipoIVAGlobal;
              end;
         If   not ( TipoIVA in [ 1..NroMaximoTiposTasas ] )
         then TipoIVA := 1;
         DmTiposIVAFields.IVASoportado.Value := TipoIVA;   // Un lugar de conveniencia
         Post;
       except
         Cancel;
         raise;
         end;
end;


function TTasaModule.TipoIVAGlobal( Fecha   : TDate;
                                    TipoIVA : SmallInt  ) : SmallInt;
begin
     Result := TipoIVAGlobal( Fecha, CodigoEspaña, TipoIVA );
end;

function TTasaModule.TipoIVAGlobal( Fecha       : TDate;
                                    CodigoPais  : String;
                                    TipoIVA     : SmallInt  ) : SmallInt;

var  FechaAplicacion : TDate;

begin
     FechaAplicacion := UltimaFechaAplicacion( Fecha, { Retencion } False, CodigoPais );
     With DmTiposIVATable do
       If   FindKey( [ FechaAplicacion, CodigoPais, TipoIVA ] )
       then Result := Trunc( DmTiposIVAFields.IVASoportado.Value )  // En el campo IVASoportado está el tipo de IVA global
       else Result := 1;     { valor por defecto }
end;

procedure TTasaModule.GuardaRelacion( SubcuentaRelacion : TSubcuentaRelacion;
                                      Codigo            : String );
begin
     With DmRelacionesTiposIVATable do
       try
         If   FindKey( [ '', rgRelaciones + Ord( SubcuentaRelacion ) ] )
         then Edit
         else begin
              Append;
              DmRelacionesTiposIVAFields.CodigoPais.Value := '';
              DmRelacionesTiposIVAFields.Codigo.Value := rgRelaciones + Ord( SubcuentaRelacion );
              end;
         DmRelacionesTiposIVAFields.CtaSoportado.Value := Codigo;  // Un lugar de conveniencia
         Post;
       except
         Cancel;
         raise;
         end;
end;

function  TTasaModule.ObtenRelacion( SubcuentaRelacion : TSubcuentaRelacion ) : String;
begin
     If   DmRelacionesTiposIVATable.FindKey( [ '', rgRelaciones + Ord( SubcuentaRelacion ) ] )
     then Result := DmRelacionesTiposIVAFields.CtaSoportado.Value
     else Result := '';
end;

{$IFNDEF TOUCHAPP}
procedure TTasaModule.ObtenSubcuentasIVA(     Fecha                   : TDate;                                              
                                              NroRegistro             : SmallInt;
                                          var SubcuentaIVASoportado   : String;
                                          var SubcuentaIVARepercutido : String;
  										                                  CodigoPais              : String = CodigoEspaña );
begin
     ObtenTipoIVA( Fecha, CodigoPais, NroRegistro );

     If   DmTiposIVAFields.CtaSoportado.Value=''
     then SubcuentaIVASoportado := CodigoCuentaDefecto( cpCtaIVASoportado )
     else SubcuentaIVASoportado := DmTiposIVAFields.CtaSoportado.Value;

     If   DmTiposIVAFields.CtaRepercutido.Value=''
     then SubcuentaIVARepercutido := CodigoCuentaDefecto( cpCtaIVARepercutido )
     else SubcuentaIVARepercutido := DmTiposIVAFields.CtaRepercutido.Value;

end;
{$ENDIF}

procedure InicializaModuloTasas;
begin
     If   not UpdatingDictionaries and ( CodigoUsuarioActual<>'' )
     then Tasa;
end;

initialization
  AddProcedure( imOnEnterpriseAccess, 0, InicializaModuloTasas );

end.



