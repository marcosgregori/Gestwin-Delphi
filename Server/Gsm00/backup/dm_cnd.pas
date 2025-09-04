unit dm_cnd;

interface

uses
  Windows, Messages, SysUtils, Classes,

  LibUtils,
  DB,
  nxdb,
  DataManager,

  Gim00Fields,

  dmi_cnd,
  SessionIntf,

  ServerDataModule;


type

  TComprobacionRegistroEvent = function( ValorActual : LongInt ) : Boolean of object;

  TContadoresService = class( TSessionModule, IContadoresService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    public

    function LimpiaStack : Integer;
    procedure RetiraValor( UnTipoContador : TTipoContador; UnEjercicio : SmallInt; UnCodigo : String = ''; ValorActual : LongInt = 0 );
    function Incrementa( UnTipoContador : TTipoContador; UnEjercicio : SmallInt; UnCodigo : String = ''; ValorActual : LongInt = 0; ValorInicial : LongInt = 1; ValorMaximo : LongInt = MaxInt ) : LongInt;
    function ExisteValor( UnTipoContador : TTipoContador; UnEjercicio : SmallInt; UnCodigo : String = ''; ValorActual : LongInt = 0 ) : Boolean;
    procedure Fija( UnTipoContador : TTipoContador; UnEjercicio : SmallInt; UnCodigo : String; UnValor : LongInt );

    {

    function CompruebaContador( UnTipoContador : TTipoContador; Forzar : Boolean = False ) : Boolean;
    }
    end;

  TContadoresModule = class(TServerDataModule)
    DmContadoresTable: TnxeTable;
    DmBloqueoContadoresTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private
    DmContadoresFields,
    DmBloqueoContadoresFields : TContadoresFields;
    CodigoRegistro : String;
    ContadorComprobado : array[ TTipoContador ] of Boolean;
    procedure FijaCodigoRegistro( UnTipoContador : TTipoContador );
    procedure ErrorInterno( TablaContadores : TnxeTable );
    function TableFindKey( Table : TnxeTable; const AKeyValues : array of const ) : Boolean;
    procedure TableEdit( Table : TnxeTable; const AKeyValues : array of const );

  public

    function Incrementa( UnTipoContador : TTipoContador; UnEjercicio : SmallInt; UnCodigo : String = ''; ValorActual : LongInt = 0; ValorInicial : LongInt = 1; ValorMaximo : LongInt = MaxInt ) : LongInt;
    procedure Fija( UnTipoContador : TTipoContador; UnEjercicio : SmallInt; UnCodigo : String; UnValor : LongInt );
    function CompruebaContador( UnTipoContador : TTipoContador; Forzar : Boolean = False ) : Boolean;

    function ProximoValor( ExisteRegistro : TComprobacionRegistroEvent; UnTipoContador : TTipoContador; UnEjercicio : SmallInt; UnCodigo : String = ''; ValorActual : LongInt = 0; ValorInicial : LongInt = 1; ValorMaximo : LongInt = MaxInt ) : LongInt;
    function ExisteValor( UnTipoContador : TTipoContador; UnEjercicio : SmallInt; UnCodigo : String = ''; ValorActual : LongInt = 0 ) : Boolean;
    procedure RetiraValor( UnTipoContador : TTipoContador; UnEjercicio : SmallInt; UnCodigo : String = ''; ValorActual : LongInt = 0 );
    procedure CompruebaValorMaximo( Valor : LongInt; ValorMaximo : LongInt = 99999999 );
    function LimpiaStack : Integer;

  end;

procedure CompruebaValorMaximo( Valor : LongInt; ValorMaximo : LongInt = 99999999 );

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses nxllBde,
     nxdbBase,
     nxrdClass,
     nxrbTypes,

     AppManager,
     MainData,
     SessionData,

     dm_pga;

{$R *.DFM}

resourceString
       RsMsg1  = 'Se ha producido un error en el sistema de contadores.';
       RsMsg2  = 'No se ha podido crear el registro.';
       RsMsg3  = 'El registro de control ha sido bloqueado de forma permante.'#13'Si el problema persiste debería abandonar la aplicación y reiniciar el servidor de base de datos.';
       RsMsg4  = 'El número del documento es demasiado alto.';
       RsMsg5  = 'El valor debe ser inferior a %d (%d dígitos).';

// Valores que se incrementan al tipo de contador para determinar el modelo

const  tcnBloqueo = 1000;      // Utilizado para bloquear el acceso al stack a otros procesos mientras éste está en uso
       tcnStack   = 2000;      // Lista de valores en uso con destino pendiente : inserción o cancelación

procedure TContadoresModule.ServerDataModuleCreate(Sender: TObject);
begin

     DmContadoresFields := TContadoresFields.Create( DmContadoresTable );
     DmBloqueoContadoresFields := TContadoresFields.Create( DmBloqueoContadoresTable );

     DmContadoresTable.FailOnError := True;
     DmBloqueoContadoresTable.FailOnError := True;

     DmContadoresTable.Timeout := LockWaitTimeout;
     DmBloqueoContadoresTable.Timeout := LockWaitTimeout;

end;

procedure TContadoresModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm00.ContadoresModule := nil;
end;

function TContadoresModule.CompruebaContador( UnTipoContador : TTipoContador; Forzar : Boolean = False ) : Boolean;
begin
     Result := not ContadorComprobado[ UnTipoContador ] { and MainDataModule.SingleSession } or Forzar;
     ContadorComprobado[ UnTipoContador ] := True;
end;

procedure TContadoresModule.Fija( UnTipoContador  : TTipoContador;
                                  UnEjercicio     : SmallInt;
                                  UnCodigo        : String;
                                  unValor         : LongInt      );

begin

     FijaCodigoRegistro( UnTipoContador );

     With DmContadoresTable do
       If   FindKey( [ CodigoRegistro, Ord( UnTipoContador ), UnEjercicio, UnCodigo ] )
       then begin
            Edit;
            DmContadoresFields.Valor.Value := unValor;
            Post;
            end
       else begin
            Append;
            DmContadoresFields.CodigoEmpresa.Value := CodigoRegistro;
            DmContadoresFields.Tipo.Value := Ord( UnTipoContador );
            DmContadoresFields.Codigo.Value := UnCodigo;
            DmContadoresFields.Valor.Value := UnValor;
            Post;
            end;
end;

function TContadoresModule.TableFindKey(       Table      : TnxeTable;
                                         const AKeyValues : array of const ) : Boolean;

var  Error,
     Retry : Boolean;
     Count : SmallInt;

begin
     Count := 0;
     Error := False;
     Result := False;
     repeat
       Retry := False;
       try
         Result := Table.FindKey( AKeyValues );
       except
         Inc( Count );
         Error := Count>10;
         Retry := True;
         Sleep( 200 + Random( 300 ) );
         end;
     until not Retry or Error;
     If   Error
     then ErrorInterno( Table );
end;

procedure TContadoresModule.TableEdit(       Table      : TnxeTable;
                                       const AKeyValues : array of const );

var  Error,
     Retry : Boolean;
     Count : SmallInt;

begin
     Count := 0;
     Error := False;
     repeat
       Retry := False;
       try
         Table.Edit;
       except
         Sleep( 200 + Random( 300 ) );
         Retry := True;
         Inc( Count );
         Table.Cancel;
         Error := not TableFindKey( Table, AKeyValues ) or ( Count>10 );
         end;
     until not Retry or Error;
     If   Error or ( Table.State<>dsEdit )
     then ErrorInterno( Table );
end;

procedure TContadoresModule.ErrorInterno( TablaContadores : TnxeTable );
begin
     ShowNotification( ntError, RsMsg1, RsMsg3 );
     TablaContadores.UnlockTableAll;
     Abort;
end;

function TContadoresModule.Incrementa( UnTipoContador  : TTipoContador;
                                       UnEjercicio     : SmallInt;
                                       UnCodigo        : String = '';
                                       ValorActual     : LongInt = 0;
                                       ValorInicial    : LongInt = 1;
                                       ValorMaximo     : LongInt = MaxInt ) : LongInt;

var  Error : Boolean;

begin

     FijaCodigoRegistro( UnTipoContador );

     With DmContadoresTable do
       try
         Cancel;
         If   TableFindKey( DmContadoresTable, [ CodigoRegistro, Ord( UnTipoContador ), UnEjercicio, UnCodigo ] )
         then begin

              //* 06.07.2004 Añadida la opción de Valor máximo. Me resulta útil, por ejemplo, para
              //             los contadores que tienen un número máximo de dígitos y que no importa
              //             que se reinicien con el tiempo (nº de pago de la norma CSB 68).

              TableEdit( DmContadoresTable, [ CodigoRegistro, Ord( UnTipoContador ), UnEjercicio, UnCodigo ] );

              If   ( ValorActual<>0 ) and ( ValorActual<>DmContadoresFields.Valor.Value )
              then DmContadoresFields.Valor.Value := ValorActual
              else If   ( DmContadoresFields.Valor.Value=0 ) or ( DmContadoresFields.Valor.Value>=ValorMaximo )
                   then DmContadoresFields.Valor.Value := ValorInicial
                   else DmContadoresFields.Valor.Value := DmContadoresFields.Valor.Value + 1;
              Post;
              end
         else begin
              Append;
              DmContadoresFields.CodigoEmpresa.Value := CodigoRegistro;
              DmContadoresFields.Tipo.Value := Ord( UnTipoContador );
              DmContadoresFields.Ejercicio.Value := UnEjercicio;
              DmContadoresFields.Codigo.Value := UnCodigo;
              If   ( ValorActual<>0 ) and ( ValorActual>ValorInicial )
              then DmContadoresFields.Valor.Value := ValorActual
              else DmContadoresFields.Valor.Value := ValorInicial;
              Post;
              end;
       finally
         Cancel;
         end;

     Result := DmContadoresFields.Valor.Value;
end;

// Esta función utiliza un método distinto para obtener el próximo valor, basado en el uso de un stack compartido de valores pendientes de validar

// El parámetro ValorMaximo lo utilizo, por ejemplo, para los contadores que tienen un número máximo de dígitos
// y que no importa que se reinicien con el tiempo (nº de pago de la norma CSB 68, por ejemplo).

function TContadoresModule.ProximoValor(  ExisteRegistro   : TComprobacionRegistroEvent;
                                          UnTipoContador   : TTipoContador;
                                          UnEjercicio      : SmallInt;
                                          UnCodigo         : String = '';
                                          ValorActual      : LongInt = 0;
                                          ValorInicial     : LongInt = 1;
                                          ValorMaximo      : LongInt = MaxInt ) : LongInt;
var  CodigoBloqueo : Integer;
     Error : Boolean;
     Count : SmallInt;

procedure BloqueaContador;
begin
     CodigoBloqueo := tcnBloqueo + Ord( UnTipoContador );
     With DmBloqueoContadoresTable do
       try
         If   not TableFindKey( DmBloqueoContadoresTable, [ SessionDataModule.CodigoEmpresa, CodigoBloqueo, UnEjercicio, UnCodigo ] )
         then begin

              Append;
              DmBloqueoContadoresFields.CodigoEmpresa.Value := SessionDataModule.CodigoEmpresa;
              DmBloqueoContadoresFields.Tipo.Value := CodigoBloqueo;
              DmBloqueoContadoresFields.Ejercicio.Value := UnEjercicio;
              DmBloqueoContadoresFields.Codigo.Value := UnCodigo;
              Post;

              TableFindKey( DmBloqueoContadoresTable, [ SessionDataModule.CodigoEmpresa, CodigoBloqueo, UnEjercicio, UnCodigo ] );
              end;

         TableEdit( DmBloqueoContadoresTable, [ SessionDataModule.CodigoEmpresa, CodigoBloqueo, UnEjercicio, UnCodigo ] );

       except on E : ENxDatabaseError do
         If   ( E.ErrorCode=DBIERR_LOCKED ) or
              ( E.ErrorCode=DBIERR_LOCKTIMEOUT ) or
              ( E.ErrorCode=DBIERR_DEADLOCK )
         then begin
              // Es evidente que este error no debería producirse nunca (bueno, casi... )
              ErrorInterno( DmBloqueoContadoresTable );
              end;
         end;

end;

procedure DesbloqueaContador;
begin
     DmBloqueoContadoresTable.Cancel;
end;

begin

     try

       BloqueaContador;

       With DmContadoresTable do
         try

            // Compruebo que no exista el valor en el stack

            Count := 0;
            repeat
              Error := False;
              repeat
                Error := False;
                If   TableFindKey( DmContadoresTable, [ SessionDataModule.CodigoEmpresa, tcnStack + Ord( UnTipoContador ), UnEjercicio, UnCodigo, ValorActual ] )
                then begin
                     Inc( ValorActual );
                     If   ValorActual>=ValorMaximo
                     then begin
                          Result := ValorActual;
                          Exit;
                          end;
                     Error := True;
                     end;
              until not Error;

              // Ni en el fichero destino

              Error := False;
              If   ExisteRegistro( ValorActual )
              then begin
                   Inc( ValorActual );
                   Inc( Count );
                   If   Count>10  // Si hay más de 10 concurrencias seguidas, algo raro pasa
                   then ErrorInterno( DmContadoresTable );
                   Error := True;
                   end;

            until not Error;

            // Y ahora genero un registro con el valor obtenido

            Append;
            DmContadoresFields.CodigoEmpresa.Value := SessionDataModule.CodigoEmpresa;
            DmContadoresFields.Tipo.Value := tcnStack + Ord( UnTipoContador );
            DmContadoresFields.Ejercicio.Value := UnEjercicio;
            DmContadoresFields.Codigo.Value := UnCodigo;
            DmContadoresFields.Valor.Value := ValorActual;
            Post;

         finally
           Cancel;
           end;

       finally
         DesbloqueaContador;
         end;

     Result := ValorActual;
end;

function TContadoresModule.ExisteValor( UnTipoContador  : TTipoContador;
                                        UnEjercicio     : SmallInt;
                                        UnCodigo        : String = '';
                                        ValorActual     : LongInt = 0 ) : Boolean;
begin
     Result := TableFindKey( DmContadoresTable, [ SessionDataModule.CodigoEmpresa, tcnStack + Ord( UnTipoContador ), UnEjercicio, UnCodigo, ValorActual ] )
end;

procedure TContadoresModule.RetiraValor( UnTipoContador  : TTipoContador;
                                         UnEjercicio     : SmallInt;
                                         UnCodigo        : String = '';
                                         ValorActual     : LongInt = 0 );
begin
     If   ExisteValor( UnTipoContador, UnEjercicio, UnCodigo, ValorActual )
     then try
            DmContadoresTable.Delete;
          except
            end;
end;

function TContadoresModule.LimpiaStack : Integer;
begin
     Result := SessionDataModule.SessionCount;
     If   Result<=1
     then With DmContadoresTable do
            try
              SetRange( [ SessionDataModule.CodigoEmpresa, tcnStack, 0, '', 0 ], [ SessionDataModule.CodigoEmpresa, tcnStack + 999, MaxSmallint, HighStrCode, MaxLongint ] );
              DeleteRecords;
            finally
              CancelRange;
              end;
end;

procedure TContadoresModule.FijaCodigoRegistro( UnTipoContador : TTipoContador );
begin
     If   UnTipoContador=cnConexiones
     then CodigoRegistro := '@' + StrIntPadded( SessionDataModule.ProgramNumber, 2 )
     else CodigoRegistro := SessionDataModule.CodigoEmpresa;
end;

procedure TContadoresModule.CompruebaValorMaximo( Valor       : LongInt;
                                                  ValorMaximo : LongInt = 99999999 );
begin
     If   Valor>ValorMaximo
     then begin
          SessionDataModule.SendNotification( ntError, RsMsg4, Format( RsMsg5, [ ValorMaximo, Length( IntToStr( ValorMaximo ) ) ] ) );
          Abort;
          end;
end;

{ TContadoresService }

procedure TContadoresService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

function TContadoresService.Incrementa(UnTipoContador: TTipoContador; UnEjercicio: SmallInt; UnCodigo: String; ValorActual, ValorInicial, ValorMaximo: LongInt): LongInt;
begin
     Result := SessionDataModule.Dm00.ContadoresModule.Incrementa( UnTipoContador, UnEjercicio, UnCodigo, ValorActual, ValorInicial, ValorMaximo );
end;

function TContadoresService.LimpiaStack : Integer;
begin
     Result := SessionDataModule.Dm00.ContadoresModule.LimpiaStack;
end;

procedure TContadoresService.RetiraValor( UnTipoContador: TTipoContador; UnEjercicio: SmallInt; UnCodigo: String; ValorActual: LongInt);
begin
     SessionDataModule.Dm00.ContadoresModule.RetiraValor( UnTipoContador, UnEjercicio, UnCodigo, ValorActual );
end;

function TContadoresService.ExisteValor(UnTipoContador: TTipoContador; UnEjercicio: SmallInt; UnCodigo: String; ValorActual: LongInt): Boolean;
begin
     Result := SessionDataModule.Dm00.ContadoresModule.ExisteValor( UnTipoContador, UnEjercicio, UnCodigo, ValorActual );
end;

procedure TContadoresService.Fija( UnTipoContador: TTipoContador; UnEjercicio: SmallInt; UnCodigo: String; UnValor: LongInt);
begin
     SessionDataModule.Dm00.ContadoresModule.Fija( UnTipoContador, UnEjercicio, UnCodigo, UnValor );
end;

// Funciones adicionales

procedure CompruebaValorMaximo( Valor       : LongInt;
                                ValorMaximo : LongInt = 99999999 );
begin
     If   Valor>ValorMaximo
     then begin
          ShowNotification( ntExceptionError, RsMsg4, Format( RsMsg5, [ ValorMaximo, Length( IntToStr( ValorMaximo ) ) ] ) );
          Abort;
          end;
end;

var ContadoresControl : InxClassFactoryControl;

initialization
   TnxClassFactory.RegisterClass( CLSID_ContadoresService, TContadoresService, ContadoresControl );

end.
