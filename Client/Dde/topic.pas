


unit topic;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DataManager,

  AppContainer,

  ExtCtrls,
  StdCtrls,
  nxDB,
  DB,
  SBUtils, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinsDefaultPainters, cxLabel,

  LibUtils,
  AppManager,

  Gim00Fields,
  Gim10Fields;

type TParametro   = array[ 1..50 ] of AnsiString;
     TDateRange   = ( rfPeriodo, rfRangoPeriodos, rfFecha, rfRangoFechas );

     TAcumulado = record
       Debe,
       Haber  : array[ 0..14 ] of Decimal;
       Saldo,
       SumaDebe,
       SumaHaber : Decimal;
       end;

type
  TDDEForm = class(TForm)
    ApunteTable: TnxeTable;
    AsientoTable: TnxeTable;
    CuentaTable: TnxeTable;
    ExistenciaTable: TnxeTable;
    SaldosTable: TnxeTable;
    Label2: TcxLabel;
    Label3: TcxLabel;
    empresaLabel: TcxLabel;
    nombreLabel: TcxLabel;
    ejercicioLabel: TcxLabel;
    Label4: TcxLabel;
    estadoLabel: TcxLabel;
    NotificacionesLabel: TcxLabel;
    cxLabel2: TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private

    FID : Integer;
    FClientHandle : Hwnd;
    FSetup : Boolean;
    FCount : SmallInt;
    FTopic : AnsiString;

    FDatabase : TnxDatabase;

    Count,
    Periodo,
    PeriodoInicial,
    PeriodoFinal : SmallInt;
    CentroCoste : AnsiString;

    CodEmpresa  : AnsiString;
    NroEjercicio : SmallInt;
    EjercicioSt2,                        // El ejercicio como un AnsiString de 2 caracteres
    EjercicioSt4 : AnsiString;           // El ejercicio como un AnsiString de 4 caracteres

    NroParametros,
    NroSelectores      : byte;
    Parametro,
    Selectores         : TParametro;
    SoloSubcuentas     : Boolean;

    CuentaFields : TCuentaFields;
    SaldosFields : TSaldosFields;
    ExistenciaFields : TExistenciaFields;
    AsientoFields : TAsientoFields;
    ApunteFields : TApunteFields;
    EmpresaFields : TEmpresaFields;
    ProvinciaFields : TProvinciaFields;
    
    PrimerMesEjercicio,
    ultimoMesEjercicio : byte;           { el primer y último Mes del ejercicio }

    ErrorMsg : AnsiString;
    DateRange : TDateRange;

    MesInicial,                          { los datos que calcula 'ExtraeParametros'  }
    MesFinal : SmallInt;

    FechaInicial,
    FechaFinal : TDateTime;

    Acumulado : TAcumulado;

    StrItem : AnsiString;
    ZStrItem : array[ 0..255 ] of AnsiChar;
    ZstrData : array[ 0..40 ] of AnsiChar;
    ZStr : array[ 0..40 ] of AnsiChar;
    StrData : String[ 40 ];
    StrComando : String[ 40 ];

    cfFormat,
    AItem : word;
    
    procedure DDETerminate ( var Msg : TMEssage ); message WM_DDE_Terminate;
    procedure DDERequest   ( var Msg : TMEssage ); message WM_DDE_Request;
    procedure DDEAdvise    ( var Msg : TMEssage ); message WM_DDE_Advise;
    procedure DDEUnAdvise  ( var Msg : TMEssage ); message WM_DDE_UnAdvise;

    procedure SetSetup( const value : Boolean );

    function  ExtraeParametros( var AStrItem : AnsiString ) : Boolean;
    procedure ObtenSaldo ( Subcuenta : AnsiString; Centro : AnsiString; NroMesInicial, NroMesFinal : byte );
    procedure CompruebaIniciar( stItem: AnsiString );
  public

    property ID : Integer read FID write FID;
    property Topic : AnsiString read FTopic write FTopic;
    property ClientHandle : Hwnd read FClientHandle write FClientHandle;
    property Setup : Boolean read FSetup write SetSetup;
  end;

var
  DDEForm: TDDEForm;

implementation

{$R *.DFM}

uses  DateUtils,
      Variants,
      Main,

      Files,


      DataAccess,
      EnterpriseDataAccess,

      b_msg;

resourceString
      RsMsg1                   = ' Centro ';
      RsMsg2                   = 'La base de datos no está actualizada.'#13'Antes de proseguir debe verificar su estado desde Gestwin.';

      rsErrorSintaxis          = '#sintaxis';
      rsErrorSoloSubcuentas    = '#Solo subcuentas';
      rsErrorFaltanParametros  = '#Faltan parámetros';
      rsErrorNoExiste          = '#No existe';
      rsErrorDesbordamiento    = '#Desbordamiento';
      rsNoInicializado         = '#No inicializado';
      rsCuentaErronea          = '#Cuenta errónea';



const DDE_FAckReq     = $8000;
      DDE_FDeferUpd   = $4000;
      DDE_FBusy       = $4000;
      DDE_FRelease    = $2000;
      DDE_FRequested  = $1000;

var   GettingData     : Boolean     = False;
      SetupList       : TStringList = nil;

function ValueIsEmpty( Value     : Variant;
                       ValueType : TVarType = varUnknown ) : Boolean;
begin
     Result := VarIsNull( Value ) or VarIsEmpty( Value );
     If   not Result
     then case VarType( Value ) of
            varSmallInt,
            varInteger,
            varInt64,
            varDate       : Result := Value=0;
            varDouble,
            varCurrency   : Result := Value=0.0;

            // Cuando el Variant es un AnsiString puede ser el resultado de la obtención directa del valor desde
            // el TcxCustomEdit. En ese caso puede ser en realidad de cualquier otro tipo. Para poder comprobar
            // estos valores hay que pasar el valor del tipo en VarType y la comprobación se hace directamente
            // comparando el AnsiString con sus valores nulos

            varString     : case ValueType of
                              varUnknown,
                              varString   : Result := Value='';
                              varSmallInt,
                              varInteger,
                              varInt64,
                              varDouble,
                              varCurrency : Result := Value='0';
                              varDate     : Result := Value='0:00:00';
                              end;
            end;
end;

procedure TDDEForm.FormCreate(Sender: TObject);
begin
     FCount := 0;
     // Setup  := False;   { Hasta que no sepa la empresa y el ejercicio }

     EmpresaFields := TEmpresaFields.Create( MainForm.EmpresaTable, True );
     ProvinciaFields := TProvinciaFields.Create( MainForm.ProvinciaTable, True );

end;

procedure TDDEForm.FormDestroy(Sender: TObject);
begin
     // PostMessage( FClientHandle, WM_DDE_terminate, handle, 0 );

     // FDatabase.Free;

     With MainForm do
       If   Data.Locate( 'ID', FID, [] )
       then Data.Delete;

end;

procedure TDDEForm.SetSetup( const value : Boolean );
begin
     FSetup := Value;

     With MainForm do
       If   Data.Locate( 'ID', FID, [] )
       then try
              Data.DisableControls;
              Data.Edit;
              If   FSetup
              then begin
                   DataCodigoEmpresa.Value := EmpresaFields.Codigo.Value;
                   DataNombre.Value:= EmpresaFields.Nombre.Value;
                   DataEjercicio.Value := NroEjercicio;
                   DataEstado.Value := 'Activo';
                   end
              else begin
                   DataCodigoEmpresa.Clear;
                   DataNombre.Clear;
                   DataEjercicio.Clear;
                   DataEstado.Value := 'Inactivo';
                   end;
              Data.Post;
            finally
              Data.Cancel;
              Data.EnableControls;
              TableView.DataController.UpdateData;
              end;

end;

procedure TDDEForm.DDETerminate( var Msg : TMessage );
begin
     Release;
end;

procedure TDDEForm.DDERequest( Var Msg : TMessage );

Var  RequestData : TDDEAdvise;

     ComandoActual,
     Index,
     Parentesis,
     NroMes,
     MesFinalCalculo : SmallInt;
     Debe,
     Haber,
     Saldo : Decimal;
     Len,
     Encontrado,
     Negativo : Boolean;

     TipoAsiento : SmallInt;

     LParam : LongInt;

const NroComandos = 20;
      Comando     : array[ 1..NroComandos ] of String[ 20 ] = ( 'INICIAR',

                                                                'DESCRIPCION',

                                                                'SALDO',
                                                                'DEBE',
                                                                'HABER',

                                                                'SALDOMES',
                                                                'DEBEMES',
                                                                'HABERMES',

                                                                'SALDOEXT',
                                                                'DEBEEXT',
                                                                'HABEREXT',

                                                                'EMPRESA.NOMBRE',
                                                                'EMPRESA.DOMICILIO',
                                                                'EMPRESA.LOCALIDAD',
                                                                'EMPRESA.CP',
                                                                'EMPRESA.PROVINCIA',
                                                                'EMPRESA.NIF',
                                                                'EMPRESA.TELEFONO',

                                                                'EXISTENCIAS',
                                                                'EJERCICIO' );
                                                                

procedure CalculaSaldoExistencias;

Var   Len  : Byte;

begin

     Len := Length( Parametro[ Index ] );

     With ExistenciaTable do
       begin
       FindNearest( [ NroEjercicio, Parametro[ Index ], CentroCoste ] );
       While not Eof and
                 ( ExistenciaFields.Ejercicio.Value=NroEjercicio ) and
                 ( Copy( ExistenciaFields.Codigo.Value, 1, Len )=Parametro[ Index ] ) do
         begin
         If   ( CentroCoste='' ) or ( ExistenciaFields.CentroCoste.Value=CentroCoste )
         then DecAdd( Saldo, ExistenciaFields.Saldo[ MesFinal ].Value );
         Next;
         end;
       end;

end;

procedure CalculaVariacionExistencias;

Const Texto61 : Array[ 0..2 ] of String[ 2 ] = ( '30', '31', '32' );
      Texto71 : Array[ 0..3 ] of String[ 2 ] = ( '33', '34', '35', '36' );

Var   SubgrupoVariacion : AnsiString;
      NroOrden : Byte;
      CodigoExistInicial,
      CodigoExistFinal : AnsiString;
      SaldoExistInicial,
      SaldoExistFinal : Decimal;

begin

     SubgrupoVariacion := Copy( Parametro[ Index ], 1, 2 );

     If   ( SubgrupoVariacion='61' ) or
          ( SubgrupoVariacion='71' )
     then begin

          If   Length( Parametro[ Index ] )=2
          then begin
               If   SubgrupoVariacion='61'
               then begin
                    CodigoExistInicial := '300000000';
                    CodigoExistFinal   := '329999999';
                    end
               else begin
                    CodigoExistInicial := '330000000';
                    CodigoExistFinal   := '369999999';
                    end;
               end
          else begin
               NroOrden := StrToIntDef( Copy( Parametro[ Index ], 3, 1 ), 0 );
               If   SubgrupoVariacion='61'
               then begin
                    If   not NroOrden in [ 0..2 ]
                    then NroOrden := 0;
                    If   Length( Parametro[ Index ] )=3
                    then begin
                         CodigoExistInicial := RightPad( Texto61[ NroOrden ], 9, '0' );
                         CodigoExistFinal := RightPad( Texto61[ NroOrden ], 9, '9' );
                         end
                    else begin
                         CodigoExistInicial := RightPad( Texto61[ NroOrden ] + '0' + Copy( Parametro[ Index ], 4, 6 ), 9, '0' );
                         CodigoExistFinal := RightPad( Texto61[ NroOrden ] + '9' + Copy( Parametro[ Index ], 4, 6 ), 9, '9' );
                         end;
                    end
               else begin
                    If   not NroOrden in [ 0..3 ]
                    then NroOrden := 0;
                    If   Length( Parametro[ Index ] )=3
                    then begin
                         CodigoExistInicial := RightPad( Texto71[ NroOrden ], 9, '0' );
                         CodigoExistFinal := RightPad( Texto71[ NroOrden ], 9, '9' );
                         end
                    else begin
                         CodigoExistInicial := RightPad( Texto71[ NroOrden ] + '0' + Copy( Parametro[ Index ], 4, 6 ), 9, '0' );
                         CodigoExistFinal := RightPad( Texto71[ NroOrden ] + '9' + Copy( Parametro[ Index ], 4, 6 ), 9, '9' );
                         end;
                    end;

               end;

          SaldoExistInicial := 0.0;
          SaldoExistFinal := 0.0;

          With ExistenciaTable do
            begin
            FindNearest( [ NroEjercicio, CodigoExistInicial, CentroCoste ] );
            While not Eof and
                      ( ExistenciaFields.Ejercicio.Value=NroEjercicio ) and
                      ( ExistenciaFields.Codigo.Value<=CodigoExistFinal ) do
              begin
              If   ( CentroCoste='' ) or
                   ( ExistenciaFields.CentroCoste.Value=CentroCoste )
              then begin
                   DecAdd( SaldoExistInicial, ExistenciaFields.Saldo[ MesInicial ].Value );
                   DecAdd( SaldoExistFinal, ExistenciaFields.Saldo[ MesFinal ].Value );
                   end;
              Next;
              end;
            end;

          DecAdd( Saldo, SaldoExistFinal - SaldoExistInicial );
          end;

end;

function Extracto( FechaInicial,
                   FechaFinal     : TDateTime;
                   TipoAsiento    : Byte ) : Boolean;
begin
     With ApunteTable do
       begin
       IndexFieldNames := 'Subcuenta;Fecha';
       AsientoTable.IndexFieldNames := 'Ejercicio;NroAsiento';
       FindNearest( [ Parametro[ Index ], FechaInicial ] );
       While not Eof and
                 ( ApunteFields.Subcuenta.Value=Parametro[ Index ] ) and
                 ( ApunteFields.Fecha.Value<=FechaFinal ) do
         begin

         With AsientoTable do
           begin

             With ApunteFields do
               FindKey( [ Ejercicio.Value, NroAsiento.Value  ] );

             If   not ( Eof ) and
                  not ( ( TipoAsiento=0 )  and ( AsientoFields.TipoAsiento.Value in [ 1, 3, 4 ] ) ) and
                  not ( ( TipoAsiento<>0 ) and ( TipoAsiento<>AsientoFields.TipoAsiento.Value ) )
             then begin
                  Debe := ApunteFields.Debe.Value;
                  Haber := ApunteFields.Haber.Value;
                  case ComandoActual of
                    3, 6,  9 : DecAdd( Saldo, Debe - Haber );
                    4, 7, 10 : DecAdd( Saldo, Debe );
                    5, 8, 11 : DecAdd( Saldo, Haber );
                    end;

                  end;
             end;

           Next;
           end;

         end;
end;

procedure PostData;

var  DataRecord : TDDEData;
     DataSize : SmallInt;
     ItemGlobalAtom : Atom;
     DataGlobalHandle : HGlobal;
     DataGlobalPtr : ^TDDEData;
     LParam : LongInt;

begin
     DataSize := StrLen( ZStrData ) + 1;
     DataGlobalHandle := globalAlloc( { gmem_Moveable or } gmem_DDEShare, SizeOf( TDDEData ) + DataSize + 2 );
     If   DataGlobalHandle<>0
     then begin
          DataGlobalPtr := globalLock( DataGlobalHandle );
          If   DataGlobalPtr=nil
          then GlobalFree( DataGlobalHandle )
          else begin
               DataRecord.cfFormat := cf_Text;
               DataRecord.Flags := DDE_FRequested or DDE_FRelease;
               Move( DataRecord, DataGlobalPtr^, SizeOf( DataRecord ) );
               Move( ZStrData, DataGlobalPtr^.value, DataSize );
               GlobalUnlock( DataGlobalHandle );
               ItemGlobalAtom := GlobalAddAtomA( ZStrItem );
               LParam := PackDDElParam( WM_DDE_Data, DataGlobalHandle, ItemGlobalAtom );
               If   LParam<>0
               then If   not PostMessage( FClientHandle, WM_DDE_Data, handle, LParam )
                    then begin
                         GlobalFree( DataGlobalHandle );
                         GlobalDeleteAtom( ItemGlobalAtom );
                         end;
               end;
          end;
end;

begin

     If   GettingData or ( SetupList.Count<>0 )
     then begin
          AItem  := HiWord( DWord( Msg.LParam ) );
          LParam := PackDDElParam( WM_DDE_ACK, DDE_FBusy, AItem );
          If   LParam<>0
          then PostMessage( FClientHandle, WM_DDE_ACK, handle, LParam );
          exit;
          end;

     try

      GettingData := True;

      try

       cfFormat := LoWord( DWord( Msg.LParam ) );
       AItem    := HiWord( DWord( Msg.LParam ) );

       GlobalGetAtomNameA( AItem, ZStrItem, 255 );
       StrItem := UpperCase( ZStrItem );
       GlobalDeleteAtom( AItem );

       If   Copy( StrItem, 1, 1 )='-'
       then begin
            Delete( StrItem, 1, 1 );
            Negativo := True;
            end
       else Negativo := False;

       ErrorMsg := '';
       ComandoActual := 1;
       Encontrado := False;
       Parentesis := Pos( '(', StrItem );
       If   Parentesis=0
       then StrComando := Trim( StrItem )
       else StrComando := Trim( Copy( StrItem, 1, Parentesis - 1 ) );

       While not Encontrado and ( ComandoActual<=NroComandos ) do
         begin
         If   StrComando=Comando[ ComandoActual ]
         then Encontrado := True
         else Inc( ComandoActual );
         end;

       If   Encontrado
       then begin
            If   Setup
            then begin

                 StrData := ' ';

                 If   Parentesis<>0
                 then begin
                      Delete( StrItem, 1, Parentesis );
                      If   not ExtraeParametros( StrItem )
                      then begin
                           StrPCopy( ZStrData, rsErrorSintaxis );
                           PostData;
                           Exit;
                           end;
                      end;

                 case ComandoActual of

                  // INICIAR

                    1 : If   NroParametros>1
                        then begin
                             StrData := FTopic + ' = ' + Parametro[ 1 ] + '/' + Parametro[ 2 ] +
                                                 ' (' + StrInt( PeriodoInicial ) + '-' + StrInt( PeriodoFinal ) + ')';
                             If   CentroCoste<>''
                             then StrData := StrData + rsMsg1 + CentroCoste ;
                             end;

                  // DESCRIPCION

                    2 : With CuentaTable do
                          If   FindKey( [ Parametro[ 1 ] ] )
                          then If   not ValueIsEmpty( CuentaFields.Descripcion.Value )
                               then StrData := CuentaFields.Descripcion.Value;

                  // SALDO, DEBE, HABER, SALDOMES, DEBEMES y HABERMES

                 3..8 : begin

                        SoloSubcuentas := True;
                        For Index := 1 to NroParametros do
                          SoloSubcuentas := SoloSubcuentas and ( Length( Parametro[ Index ] )=9 );

                        case DateRange of
                          rfPeriodo       : If   ComandoActual in [ 3..5 ]
                                            then begin
                                                 If   MesFinal<>0  // Se está pidiendo un saldo de apertura, por lo que el MesInicial ya está fijado también en 0
                                                 then MesInicial := PeriodoInicial;
                                                 end
                                            else MesInicial := MesFinal;

                          rfRangoPeriodos : If   ComandoActual in [ 3..5 ]
                                            then ErrorMsg := rsErrorSintaxis;

                          rfFecha         : If   SoloSubcuentas
                                            then begin
                                                 MesInicial := PeriodoInicial;
                                                 MesFinal   := Pred( MonthOf( FechaFinal ) );
                                                 end
                                            else ErrorMsg := rsErrorSoloSubcuentas;

                          rfRangoFechas   : If   SoloSubcuentas
                                            then begin
                                                 If   ComandoActual in [ 3..5 ]
                                                 then ErrorMsg := rsErrorSintaxis
                                                 else begin
                                                      MesInicial := MonthOf( FechaInicial );
                                                      MesFinal   := MonthOf( FechaFinal ) - 1;
                                                      end;
                                                 end
                                            else ErrorMsg := rsErrorSoloSubcuentas
                          end;

                        If   ErrorMsg=''
                        then try
                               If   MesFinal=0
                               then MesFinalCalculo := PrimerMesEjercicio
                               else MesFinalCalculo := MesFinal;
                               FechaInicial := EncodeDate( NroEjercicio, MesFinalCalculo, 1 );
                               Saldo := 0.0;
                               For Index := 1 to NroParametros do
                                 begin

                                 ObtenSaldo( Parametro[ Index ], CentroCoste, MesInicial, MesFinal );
                                      Debe   := Acumulado.SumaDebe;
                                      Haber  := Acumulado.SumaHaber;

                                 case ComandoActual of
                                   3, 6 : DecAdd( Saldo, Debe - Haber );
                                   4, 7 : DecAdd( Saldo, Debe );
                                   5, 8 : DecAdd( Saldo, Haber );
                                   end;

                                 If   DateRange in [ rfFecha, rfRangoFechas ]
                                 then Extracto( FechaInicial, FechaFinal, 0 );

                                 end;

                               If   Negativo and ( Saldo<>0.0 )
                               then Saldo := -Saldo;
                               StrData := StrFormat( Saldo, DecimalesMoneda );
                             except
                               StrData := rsErrorNoExiste;
                               end
                        else StrData := ErrorMsg;
                        end;

                  // SALDOEXT, DEBEEXT y HABEREXT

                9..11 : begin

                        If   NroParametros>=1
                        then begin

                             SoloSubcuentas := True;
                             For Index := 1 to NroParametros do
                               SoloSubcuentas := SoloSubcuentas and ( Length( Parametro[ Index ] )=9 );

                             If   SoloSubcuentas
                             then begin
                                  case DateRange of
                                    rfPeriodo,
                                    rfRangoPeriodos : begin
                                                      FechaInicial := EncodeDate( NroEjercicio, MesInicial, 1 );
                                                      FechaFinal   := EncodeDate( NroEjercicio, MesFinal, 31 );
                                                      end;

                                    rfFecha         : begin
                                                      MesInicial := PeriodoInicial;
                                                      MesFinal   := Pred( MonthOf( FechaFinal ) );
                                                      end;

                                    rfRangoFechas   : begin
                                                      MesInicial := MonthOf( FechaInicial );
                                                      MesFinal   := Pred( MonthOf( FechaFinal ) );
                                                      end;
                                    end;
                                  end
                             else ErrorMsg := rsErrorSoloSubcuentas;
                             end
                        else ErrorMsg := rsErrorFaltanParametros;

                        If   ErrorMsg=''
                        then begin

                             FechaInicial := EncodeDate( NroEjercicio, MonthOf( FechaFinal ), 1 );

                             TipoAsiento  := 0;
                             If   NroSelectores=2
                             then TipoAsiento := StrToIntDef( Selectores[ 2 ], 0 );

                             Saldo := 0.0;
                             For Index := 1 to NroParametros do
                               begin

                               If   MesInicial<=MesFinal
                               then begin
                                    ObtenSaldo( Parametro[ Index ], CentroCoste, MesInicial, MesFinal );
                                    Debe   := Acumulado.SumaDebe;
                                    Haber  := Acumulado.SumaHaber;
                                    end
                               else begin
                                    Debe   := 0.0;
                                    Haber  := 0.0;
                                    end;

                               case ComandoActual of
                                 9 : DecAdd( Saldo, Debe - Haber );
                                10 : DecAdd( Saldo, Debe         );
                                11 : DecAdd( Saldo, Haber        );
                                end;

                               Extracto( FechaInicial, FechaFinal, TipoAsiento );
                               end;

                             If   Negativo        and
                                  ( Saldo<>0.0 )
                             then Saldo := -Saldo;
                             StrData := StrFormat( Saldo, DecimalesMoneda );
                             end
                        else StrData := ErrorMsg;
                        end;

                // DATOS DE LA EMPRESA

               12..18 : begin
                        case ComandoActual of
                          12 : StrData := EmpresaFields.Nombre.Value;
                          13 : StrData := EmpresaFields.Domicilio.Value;
                          14 : StrData := EmpresaFields.Localidad.Value;
                          15 : StrData := EmpresaFields.CodigoProvincia.Value + EmpresaFields.CodigoPostal.Value;
                          16 : StrData := ProvinciaFields.Nombre.Value;
                          17 : StrData := EmpresaFields.NIF.Value;
                          18 : StrData := EmpresaFields.Telefono.Value;
                          end;
                        If   StrData=''
                        then StrData := ' ';
                        end;

               // EXISTENCIAS

               19    : begin

                       Saldo := 0.0;
                       For Index := 1 to NroParametros do
                         If   Copy( Parametro[ Index ], 1, 1 )='3'
                         then CalculaSaldoExistencias
                         else If   ( Copy( Parametro[ Index ], 1, 2 )='61' ) or
                                   ( Copy( Parametro[ Index ], 1, 2 )='71' )
                              then CalculaVariacionExistencias
                              else ErrorMsg := rsCuentaErronea;

                       If   ErrorMsg=''
                       then begin
                            If   Negativo and ( Saldo<>0.0 )
                             then Saldo := -Saldo;
                            StrData := StrFormat( Saldo, DecimalesMoneda );
                            end
                       else StrData := ErrorMsg;
                       end;

               20 : StrData := IntToStr( NroEjercicio );
               end;

                  StrPCopy( ZstrData, StrData );
                  PostData;
                  end
             else begin
                  ErrorMsg := rsNoInicializado;
                  strPCopy( ZStrData, ErrorMsg );
                  PostData;
                  end;
             end
        else begin
             ErrorMsg := rsErrorNoExiste;
             StrPCopy( ZStrData, ErrorMsg );
             PostData;
             end;

       except
          end;

     finally
       GettingData := False;
       end;
end;

function TDDEForm.ExtraeParametros( var AStrItem : AnsiString ) : Boolean;

Var  pc,
     Pp,
     Ppc  : SmallInt;
     St : String[ 40 ];
     FinProceso,
     Correcto  : Boolean;

begin

     FillChar( FechaInicial, SizeOf( FechaInicial ), #0 );
     FillChar( FechaFinal, SizeOf( FechaFinal ), #0 );

     NroParametros := 0;
     NroSelectores := 0;
     Correcto := True;
     DateRange := rfPeriodo;
     MesInicial := PeriodoInicial;
     MesFinal := PeriodoFinal;

     AStrItem := Trim( AStrItem );
     Periodo := PeriodoFinal;
     Ppc := Pos( ';', AStrItem );
     If   Ppc<>0
     then begin
          St := Copy( AStrItem, 1, Pred( Ppc ) );
          Pp := Pos( '..', St );
          If   Pos( '/', St )<>0
          then begin
               If   Pp=0
               then begin
                    DateRange := rfFecha;
                    Correcto  := AppContainer.StrToDate( Copy( AStrItem, 1, 2 ) + Copy( AStrItem, 4, 2 )  + EjercicioSt2, FechaFinal, dfCompact );
                    end
               else begin
                    DateRange := rfRangoFechas;
                    Correcto  := AppContainer.StrToDate( Copy( AStrItem, 1, 2 ) + Copy( AStrItem,  4, 2 ) + EjercicioSt2, FechaInicial, dfCompact );
                    Correcto  := AppContainer.StrToDate( Copy( AStrItem, 8, 2 ) + Copy( AStrItem, 11, 2 ) + EjercicioSt2, FechaFinal, dfCompact );
                    end;
               end
          else begin
               If   Pp=0
               then begin
                    DateRange := rfPeriodo;
                    MesFinal := StrToIntDef( St, 12 );
                    If   MesFinal=0
                    then MesInicial := 0;  // Si el periodo final es 0 el inicial no puede ser otro
                    Correcto := ( MesFinal>=0 ) and ( MesFinal<13 );
                    end
               else begin
                    DateRange := rfRangoPeriodos;
                    MesInicial := StrToIntDef( Copy( St, 1, Pred( Pp ) ), 0 );
                    MesFinal := StrToIntDef( Copy( St, Pp + 2, 2 ), 12 );
                    Correcto := ( ( MesInicial>=0 ) and ( MesInicial<13 ) ) and
                                ( ( MesFinal>=0 )   and ( MesFinal<13 )   ) and
                                ( MesFinal>MesInicial );
                    end;
               end;

          // Buscando un segundo selector

          If   Correcto
          then begin
               Inc( NroSelectores );
               Pc := Pos( ',', St );
               If   pc=0
               then Selectores[ 1 ] := St
               else begin
                    Selectores[ 1 ] := Copy( St, 1, Pred( pc ) );
                    Selectores[ 2 ] := Copy( St, succ( pc ), Ppc - pc );
                    Inc( NroSelectores );
                    end;
               end;

          Delete( AStrItem, 1, Ppc );
          end;


     FinProceso    := False;
     repeat
       pc := Pos( ',', AStrItem );
       If   pc=0
       then begin
            pc := Length( AStrItem );
            If   AStrItem[ pc ]<>')'
            then Inc( pc );
            FinProceso := True;
            end;
       Inc( NroParametros );
       Parametro[ NroParametros ] := Copy( AStrItem, 1, Pred( pc ) );
       Delete( AStrItem, 1, pc );
     until ( FinProceso )        or
           ( NroParametros=50 );

     Result := Correcto;
end;

procedure TDDEForm.ObtenSaldo ( Subcuenta        : AnsiString;
                                Centro           : AnsiString;
                                NroMesInicial,
                                NroMesFinal      : Byte );

{
   Los SaldosFields mensuales se acumulan en todos los casos.
   En Saldo, SumaDebe, SumaHaber estan el Saldo y las
   sumas del Periodo seleccionado (MesInicial/MesFinal)
}


Var  Debe,
     Haber : Decimal;

     Indice,
     NroMes : SmallInt;

     Eop,
     Finalizado : Boolean;

     Contador : SmallInt;

function ExisteAsientoApertura : Boolean;
begin
     With AsientoTable do
       try
       IndexFieldNames := 'TipoAsiento;Ejercicio;NroRegistro';
       Result := FindEqualFirst( [ 1 { taApertura}, NroEjercicio ] );
     finally
       IndexFieldNames := 'Ejercicio;NroAsiento';
       end;
end;

begin

     FillChar( Acumulado, SizeOf( Acumulado) , #0 );

     If   ( NroMesInicial=0 ) and ( NroMesFinal=0 ) and ExisteAsientoApertura
     then begin

          With AsientoTable do
            try

              IndexFieldNames := 'TipoAsiento;Ejercicio;NroRegistro';
              SetRange( [ 1 { taApertura }, NroEjercicio, Null ], [ 1 { taApertura }, NroEjercicio, MaxLongint ] );
              First;
              While not Eof do
                begin

                With ApunteTable do
                  try

                  IndexFieldNames := 'Ejercicio;NroAsiento;Subcuenta';

                    With AsientoFields do
                      SetRange( [ Ejercicio.Value, NroAsiento.Value, Subcuenta ],
                                [ Ejercicio.Value, NroAsiento.Value, Subcuenta + HighStrCode ] );
                    First;
                    While not Eof do
                      begin

                      If   ( Centro='' ) or ( ApunteFields.CentroCoste.Value=Centro )
                      then begin
                      DecAdd( Acumulado.Debe[ Indice ], ApunteFields.Debe.Value );
                      DecAdd( Acumulado.Haber[ Indice ], ApunteFields.Haber.Value );

                      DecAdd( Acumulado.SumaDebe, ApunteFields.Debe.Value );
                      DecAdd( Acumulado.SumaHaber, ApunteFields.Haber.Value );
                      end;

                      next;
                      end;

                  finally
                    IndexFieldNames := 'Ejercicio;NroAsiento;NroApunte';
                    end;

                next;
                end;

              finally
                IndexFieldNames := 'Ejercicio;NroAsiento';
                end;

          end
     else With SaldosTable do
            begin
            Finalizado := False;
            FindNearest( [ NroEjercicio, Subcuenta, Centro ] );
            If   not Eof and
                 ( SaldosFields.Codigo.Value=Subcuenta ) and
                 ( ( Centro='' )  or ( ( Centro<>'') and ( SaldosFields.CentroCoste.Value=Centro ) ) )
            then repeat

                   For Indice := 0 to 14 do
                     begin
                     DecAdd( Acumulado.Debe[ Indice ],  SaldosFields.Mes[ Indice, 1 ].Value );
                     DecAdd( Acumulado.Haber[ Indice ], SaldosFields.Mes[ Indice, 2 ].Value );
                     end;

                   NroMes := NroMesInicial;
                   Eop := False;

                   // Tratando de evitar un bucle infinito cuando los rangos no son correctos

                   If   PrimerMesEjercicio=1
                   then begin
                   If   NroMesFinal<NroMesInicial
                   then NroMesFinal := NroMesInicial
                        end
                   else If   not ( ( NroMesInicial=0 ) or ( NroMesFinal in [ 13..14 ] ) )
                        then If   ( NroMesInicial<=UltimoMesEjercicio ) and ( NroMesFinal>UltimoMesEjercicio )  // Solo puede ocurrir en ejercicios partidos
                                  then NroMesFinal := UltimoMesEjercicio;

                   // Otro control adicional : un contador para evitar más de 15 ciclos (por si acaso)

                   Contador := 0;

                   While ( not Eop ) do
                     begin

                     DecAdd( Acumulado.SumaDebe,  SaldosFields.Mes[ NroMes, 1 ].Value );
                     DecAdd( Acumulado.SumaHaber, SaldosFields.Mes[ NroMes, 2 ].Value );

                     Eop := ( NroMesInicial=NroMesFinal ) or ( NroMes=NroMesFinal ) or ( NroMesFinal=0 );

                     If   not Eop
                     then begin
                          If   ( PrimerMesEjercicio<>1 )  and ( NroMes=UltimoMesEjercicio )
                          then begin
                               If   NroMesFinal>12
                               then NroMes := 13;
                               end
                          else begin
                          Inc( NroMes );
                               If   NroMes>14
                               then Eop := True
                               else If   ( PrimerMesEjercicio<>1 ) and ( NroMesFinal<>0 )
                          then begin
                               If   NroMes=13
                               then NroMes := 1
                               else If   NroMes=1
                                    then NroMes := PrimerMesEjercicio;
                               end;
                               end;
                          end;

                     Inc( Contador );
                     If   Contador>15  // No se pueden dar más de 15 (0..14), por lo tanto es un error de bucle infinito por rango incorrecto
                     then Finalizado := True;

                    end;

                   If   Centro=''
                   then Next
                   else Finalizado := True;

                 until Eof or Finalizado or ( SaldosFields.Codigo.Value<>Subcuenta );
            end;

     Acumulado.Saldo := Acumulado.SumaDebe - Acumulado.SumaHaber;

end;

procedure TDDEForm.DDEAdvise( var Msg : TMessage );

Var  DDEAdviseOptions : TDDEAdvise;
     DDEMessage : word;
     LParam : LongInt;
     HOptions,
     AItem : UINT;
     cfFormat : Short;
     ItemIndex : integer;

begin

     If   UnpackDDElParam( WM_DDE_Advise, Msg.LParam, @HOptions, @AItem )
     then try

            FreeDDElParam( WM_DDE_Advise, Msg.LParam );

            GlobalGetAtomNameA( AItem, ZStrItem, 255 );
            StrItem := UpperCase( ZStrItem );

            ErrorMsg := '';
            DDEMessage := DDE_fAckReq;

            If   Copy( StrItem, 1, 8 )='INICIAR('
            then begin
                 Delete( StrItem, 1, 8 );
                 If   GettingData
                 then begin
                      With SetupList do
                        If   IndexOf( StrItem )=-1
                        then add( StrItem );
                      DDEMessage := DDE_fBusy;
                      end
                 else begin
                      CompruebaIniciar( StrItem );
                      With SetupList do
                        begin
                        ItemIndex := IndexOf( StrItem );
                        If   ItemIndex<>-1
                        then Delete( ItemIndex );
                        end;
                      end;
                 end;

            GlobalFree( HOptions );

            // DDEMessage := DDE_fAckReq;

            LParam := PackDDElParam( WM_DDE_Ack, DDEMessage, AItem );
            If   LParam<>0
            then If   not PostMessage( FClientHandle, WM_DDE_Ack, handle, LParam )
                 then If   Setup
                      then begin
                           Setup := False;
                           ErrorMsg := rsErrorDesbordamiento;
                           end;
          except
            end;
end;

procedure TDDEForm.CompruebaIniciar( stItem : AnsiString );
begin



       {
       If   not Setup
       then try
       }
       GettingData := True;
       try
              ExtraeParametros( stItem );

              If   NroParametros>1
              then begin

                   CodEmpresa := Parametro[ 1 ];
                   EjercicioSt4 := Parametro[ 2 ];

                   With MainForm, EmpresaTable, ApplicationContainer, Session do
                     begin

                     If   FindKey( [ CodEmpresa ] )
                     then begin

                          EmpresaFields.Update; // MainForm.EmpresaTable

                          With EmpresaFields do
                            ProvinciaTable.FindKey( [ CodigoPais, CodigoProvincia ] );

                          ProvinciaFields.Update; // MainForm.ProvinciaTable

                          NroEjercicio := StrToIntDef( EjercicioSt4, ApplicationContainer.Ejercicio );

                          CodigoEmpresaActual := CodEmpresa;
                          Ejercicio := NroEjercicio;
                          EjercicioSt2 := Copy( EjercicioSt4, 3, 2 );

                          With EmpresaFields do
                            EnterpriseDataModule.SetUserDataPath( CodigoEmpresaActual, DataPath.Value );

                          If   not Assigned( FDatabase )
                          then begin
                               FDatabase := TnxDatabase.Create( Self );
                               If   Assigned( FDatabase )
                               then try

                                      FDatabase.Session := EnterpriseDataModule.UserDatabase.Session;
                                      FDatabase.AliasPath := EnterpriseDataModule.UserDatabase.AliasPath;
                                      FDatabase.Active := True;

                                      CuentaTable.Database := FDatabase;
                                      SaldosTable.Database := FDatabase;
                                      ExistenciaTable.Database := FDatabase;
                                      AsientoTable.Database := FDatabase;
                                      ApunteTable.Database := FDatabase;

                                      CuentaTable.Open;
                                      SaldosTable.Open;
                                      ExistenciaTable.Open;
                                      AsientoTable.Open;
                                      ApunteTable.Open;

                                      CuentaFields := TCuentaFields.Create( CuentaTable );
                                      SaldosFields := TSaldosFields.Create( SaldosTable );
                                      ExistenciaFields := TExistenciaFields.Create( ExistenciaTable );
                                      AsientoFields := TAsientoFields.Create( AsientoTable );
                                      ApunteFields := TApunteFields.Create( ApunteTable );

                                    except on E : Exception do
                                      begin
                                      If   DatabaseUpdateRequested
                                      then NotificacionesLabel.Caption := RsMsg2
                                      else If   not( E is EAbort )
                                           then NotificacionesLabel.Caption := E.Message;
                                      raise;
                                      end;
                                    end;
                               end;

                          PrimerMesEjercicio := EmpresaFields.Contable_MesInicial.Value;
                          If       ( PrimerMesEjercicio=1 ) or not ( PrimerMesEjercicio in [ 1..12 ] )
                          then begin
                               PrimerMesEjercicio := 1;
                               UltimoMesEjercicio := 12;
                               end
                          else UltimoMesEjercicio := PrimerMesEjercicio - 1;

                          PeriodoInicial := 0;
                          PeriodoFinal := UltimoMesEjercicio;
                          CentroCoste := '';

                          case NroParametros of
                               3 : CentroCoste := Parametro[ 3 ];
                            4, 5 : begin
                                   Periodo := StrToIntDef( Parametro[ 3 ], 0 );
                                   If   Periodo in [ 0..12 ]
                                   then PeriodoInicial := Periodo;
                                   Periodo := StrToIntDef( Parametro[ 4 ], 12 );
                                   If   Periodo in [ 0..12 ]
                                   then PeriodoFinal := Periodo;
                                   If   NroParametros=5
                                   then CentroCoste := Parametro[ 5 ];
                                   end;
                            end;

                          Setup := True;



                          end;
                     end;
                   end;
            finally
              GettingData := False;
              end;

end;

procedure TDDEForm.DDEUnAdvise( var Msg : TMessage );

Var  LParam : LongInt;

begin

     try

       cfFormat := LoWord( DWord( Msg.LParam ) );
       AItem := HiWord( DWord( Msg.LParam ) );

       GlobalGetAtomNameA( AItem, ZStrItem, 255 );
       StrItem := UpperCase( ZStrItem );

       If   Copy( StrItem, 1, 8 )='INICIAR('
       then begin
            {
            If   Setup
            then begin
                 CuentaTable.Close;
                 SaldosTable.Close;
                 ExistenciaTable.Close;
                 AsientoTable.Close;
                 ApunteTable.Close;
                 end;
            Setup := False;
            }
            end;

       LParam := PackDDElParam( WM_DDE_ACK, DDE_fAckReq, AItem );
       If   LParam<>0
       then PostMessage( FClientHandle, WM_DDE_ACK, handle, LParam );

     except
       end;

end;

initialization
   SetupList := TStringList.create;

finalization
   SetupList.Free;
end.


