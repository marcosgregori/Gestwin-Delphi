unit dm_iva;

interface

uses
  Windows, Messages, SysUtils, Classes, 
  DB,
  nxdb,

  DataManager,

  LibUtils,
  SessionIntf,
  ServerDataModule,
  
  Gim00Fields,
  Gim10Fields,

  dmi_iva;

type

  TTasaService = class( TSessionModule, ITasaService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    function CopiaRegistros( FechaAplicacion, Fecha : TDate; TipoRegistro : SmallInt; CodigoPais : String = CodigoEspaña ) : Boolean;

    end;

  TTasaModule = class(TServerDataModule)
    DmTiposIVATable: TnxeTable;
    DmRelacionesTiposIVATable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);

  private

    DmTiposIVAFields,
    DmRelacionesTiposIVAFields : TTiposIVAFields;


    function ObtenRegistro( Fecha : TDate; CodigoPais : String; NroRegistro  : SmallInt;  Retencion : Boolean = False ) : Boolean;

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
    function ObtenRelacion( SubcuentaRelacion : TSubcuentaRelacion ) : String;
    function UltimaFechaAplicacion( Fecha : TDate = 0; Retencion : Boolean = False; CodigoPais : String = CodigoEspaña ) : TDate;
    function CopiaRegistros( FechaAplicacion, Fecha : TDate; TipoRegistro : SmallInt = rgTiposIVA; CodigoPais : String = CodigoEspaña  ) : Boolean;

    procedure ObtenSubcuentasIVA( Fecha : TDate; NroRegistro : SmallInt; var SubcuentaIVASoportado : String; var SubcuentaIVARepercutido : String; CodigoPais : String = CodigoEspaña );
    function ObtenTipoIVAPorcentaje( Fecha : TDate; CodigoPais : String; TipoPorcentaje : TTipoPorcentaje; Porcentaje : Decimal; TiposIVAFields : TTiposIVAFields ) : Boolean;

  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses Variants,

     AppManager,
     EnterpriseData,
     DateUtils,
     nxrbTypes,
     nxrdClass,

     SessionData,

     Gsm00Dm,

     dm_sub;

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

procedure TTasaModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmTiposIVAFields := TTiposIVAFields.Create( DmTiposIVATable );
     DmRelacionesTiposIVAFields := TTiposIVAFields.Create( DmRelacionesTiposIVATable );
end;

procedure TTasaModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.TasaModule := nil;
end;


function TTasaModule.CopiaRegistros( FechaAplicacion,
                                     Fecha           : TDate;                                     
                                     TipoRegistro    : SmallInt = rgTiposIVA;  { rgTiposIVA o rgRetenciones }
									 CodigoPais      : String = CodigoEspaña ) : Boolean;

var FieldValues : TFieldValuesArray;

begin
     Result := False;
     If   Fecha=0
     then Fecha := SessionDataModule.FechaHoy;
     DmTiposIVATable.CancelRange;
     For var Index := TipoRegistro + 1 to TipoRegistro + NroMaximoTiposTasas do
       If   DmTiposIVATable.FindKey( [ FechaAplicacion, CodigoPais, Index ] )
       then begin
            FieldValues := DmTiposIVATable.GetFieldValues;
            DmTiposIVATable.Append;
            DmTiposIVATable.SetFieldValues( FieldValues );
            DmTiposIVAFields.FechaAplicacion.Value := Fecha;
            DmTiposIVAFields.CodigoPais.Value := CodigoPais;
            DmTiposIVATable.Post;
            Result := True;
            end;

     If   TipoRegistro=rgTiposIVA
     then begin
          GuardaTipoIVAGlobal( Fecha, CodigoPais, rgTipoIVAManual, TipoIVAGlobal( FechaAplicacion, CodigoPais, rgTipoIVAManual ) );
          GuardaTipoIVAGlobal( Fecha, CodigoPais, rgTipoIVAPortes, TipoIVAGlobal( FechaAplicacion, CodigoPais, rgTipoIVAPortes ) );
          end;

end;

function TTasaModule.SuprimeTipoIVAGlobal( Fecha      : TDate;
                                           CodigoPais : String;
                                           TipoIVA    : SmallInt  ) : SmallInt;

var  FechaAplicacion : TDate;

begin
    FechaAplicacion := UltimaFechaAplicacion( Fecha, { Retencion } False, CodigoPais );
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

function TTasaModule.UltimaFechaAplicacion( Fecha      : TDate = 0;                                            
                                            Retencion  : Boolean = False;
											                                 CodigoPais : String = CodigoEspaña ) : TDate;
begin
     If   Fecha=0
     then Fecha := SessionDataModule.FechaHoy;
     If   ObtenRegistro( Fecha, CodigoPais, 1, Retencion )  // Basta con que exista el primer tipo
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

function TTasaModule.TipoIVAGlobal( Fecha      : TDate;
                                    CodigoPais : String;
                                    TipoIVA    : SmallInt  ) : SmallInt;

var  FechaAplicacion : TDate;

begin
     FechaAplicacion := UltimaFechaAplicacion( Fecha, { Retencion } False, CodigoPais );
     With DmTiposIVATable do
       If   FindKey( [ FechaAplicacion, CodigoPais, TipoIVA ] )
       then Result := Trunc( DmTiposIVAFields.IVASoportado.Value )
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

// No soporto -de momento- subcuentas distinta por país

procedure TTasaModule.ObtenSubcuentasIVA(     Fecha                   : TDate;
                                              NroRegistro             : SmallInt;
                                          var SubcuentaIVASoportado   : String;
                                          var SubcuentaIVARepercutido : String;
  										                                  CodigoPais              : String = CodigoEspaña );
begin
     ObtenTipoIVA( Fecha, CodigoPais, NroRegistro );

     If   DmTiposIVAFields.CtaSoportado.Value=''
     then SubcuentaIVASoportado := SessionDataModule.Dm10.CuentaModule.CodigoCuentaDefecto( cpCtaIVASoportado )
     else SubcuentaIVASoportado := DmTiposIVAFields.CtaSoportado.Value;

     If   DmTiposIVAFields.CtaRepercutido.Value=''
     then SubcuentaIVARepercutido := SessionDataModule.Dm10.CuentaModule.CodigoCuentaDefecto( cpCtaIVARepercutido )
     else SubcuentaIVARepercutido := DmTiposIVAFields.CtaRepercutido.Value;

end;

function TTasaModule.ObtenTipoIVAPorcentaje( Fecha          : TDate;
                                             CodigoPais     : String;
                                             TipoPorcentaje : TTipoPorcentaje;
                                             Porcentaje     : Decimal;
                                             TiposIVAFields : TTiposIVAFields ) : Boolean;

var  NroEjercicio : SmallInt;

function ObtenRegistro( FechaAplicacion : TDate ) : Boolean;
begin
     Result := False;

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
            TiposIVAFields.Update( DmTiposIVATable );
            Result := True;
            Exit;
            end;
       DmTiposIVATable.Next;
       end;
end;

begin
     try

       var FechaAplicacion := UltimaFechaAplicacion( Fecha );

       Result := ObtenRegistro( FechaAplicacion );
       If   not Result
       then begin
            FechaAplicacion := UltimaFechaAplicacion( IncDay( FechaAplicacion, -1 ) );  // Si no lo encuentro en la última tabla lo busco an la inmediatamente anterior
            Result := ObtenRegistro( FechaAplicacion );
            end;

     finally
       DmTiposIVATable.CancelRange;
       end;
end;

{ TTasaService }

procedure TTasaService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

var TasaControl : InxClassFactoryControl;

function TTasaService.CopiaRegistros( FechaAplicacion, Fecha: TDate; TipoRegistro : SmallInt; CodigoPais : String = CodigoEspaña ) : Boolean;
begin
     Result := SessionDataModule.Dm10.TasaModule.CopiaRegistros( FechaAplicacion, Fecha, TipoRegistro, CodigoPais  );
end;

initialization
    TnxClassFactory.RegisterClass( CLSID_TasaService, TTasaService, TasaControl );

end.



