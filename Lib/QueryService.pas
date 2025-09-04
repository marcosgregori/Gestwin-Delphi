unit QueryService;

interface

uses kbmMWBinaryStreamFormat,
     kbmMWCustomConnectionPool,
     kbmMWCustomDataset,
     kbmMWNexusDB,
     kbmMWResolvers,
     kbmMWCustomSQLMetaData,
     kbmMWQueryService,
     kbmMWCustomQueryService,
     kbmMWServiceUtils,
     kbmMemTable,
     kbmMWSecurity,

     SysUtils,
     LibUtils,
     FunctionService,
     Classes,
     Generics.Collections;

type
  TFieldValuesStructure = ( fvsAll, fvsFieldNames, fvsValues );

  TQueryService = class( TkbmMWQueryService )
  private

    FFieldExists,
    FWhereExists : Boolean;
    FNroRegistroActual,
    FNroTotalRegistros : LongInt;
    FDBQuery : TkbmMWNexusDBQuery;
    FSQLText : String;

    FFunctionDictionary : TDictionary< String, TServiceFunction >;

  protected

    function ProcessRequest(const Func:string; const ClientIdent:TkbmMWClientIdentity; const Args:array of Variant):Variant; override;

  public

    constructor Create( AOwner : TComponent ); override;
    destructor Destroy; override;

    procedure AddServiceFunction( Name : String; ServiceFunction : TServiceFunction );

    procedure Setup( SQLText : String );
    procedure Next;
    function Open( AReadOnly : Boolean = False ) : Boolean;
    procedure Execute;

    function GetFieldList( Fields : array of Variant; Structure : TFieldValuesStructure = fvsAll; Separator : String = ',' ) : String;

    procedure AddLikeField( Name, Value : String );
    procedure AddFieldList( var SQLText : String; Fields: array of Variant; Structure : TFieldValuesStructure = fvsAll; Separator : String = ',' );

    function CompruebaClave(const Args: array of Variant): Variant;
    function ActualizaRegistroDataset(const Args: array of Variant): Variant;
    function InsertaRegistroDataset( const Args : array of Variant ) : Variant;
    function ObtenRegistro(const Args: array of Variant): Variant;
    function SuprimeRegistro( const Args : array of Variant ) : Variant;
    function ObtenRegistroDataset(const Args: array of Variant): Variant;
    function ObtenListaRegistrosDataset(const Args: array of Variant): Variant;
    function ObtenRelacionDataset(const Args: array of Variant): Variant;
    function ObtenDataset(const Args: array of Variant): Variant;

    // property DBQuery : TkbmMWNexusDBQuery read FDBQuery write FDBQuery;
  end;

implementation

uses  kbmMWAS3Utils,

      Variants;

constructor TQueryService.Create( AOwner : TComponent );
begin
     inherited;

     FDBQUery := Query as TkbmMWNexusDBQuery;

     FFunctionDictionary := TDictionary< String, TServiceFunction >.Create;

     AddServiceFunction( 'CompruebaClave', CompruebaClave );
     AddServiceFunction( 'ObtenDataset', ObtenDataset );
     AddServiceFunction( 'ObtenRegistroDataset', ObtenRegistroDataset );
     AddServiceFunction( 'ObtenListaRegistrosDataset', ObtenListaRegistrosDataset );
     AddServiceFunction( 'ObtenRelacionDataset', ObtenRelacionDataset );
     AddServiceFunction( 'ActualizaRegistroDataset', ActualizaRegistroDataset );
     AddServiceFunction( 'InsertaRegistroDataset', InsertaRegistroDataset );
     AddServiceFunction( 'ObtenRegistro', ObtenRegistro );
     AddServiceFunction( 'SuprimeRegistro', SuprimeRegistro );
end;

destructor TQueryService.Destroy;
begin
     FFunctionDictionary.Free;
     inherited;
end;

procedure TQueryService.AddServiceFunction( Name            : String;
                                            ServiceFunction : TServiceFunction );
begin
     FFunctionDictionary.Add( Name, ServiceFunction );
end;

function TQueryService.ProcessRequest( const Func        : String;
                                       const ClientIdent : TkbmMWClientIdentity;
                                       const Args        : array of Variant ) : Variant;

var  Sf : TServiceFunction;

begin
     FFunctionDictionary.TryGetValue( Func, Sf );
     If   Assigned( Sf )
     then Result := Sf( Args )
     else Result := inherited ProcessRequest( Func, ClientIdent, Args );
end;

procedure TQueryService.Setup( SQLText : String );
begin
     FSQLText := SQLText;
     FNroTotalRegistros := 0;
     FFieldExists := False;
end;

procedure TQueryService.Next;
begin
     FDBQuery.Next;
     Inc( FNroRegistroActual );
end;

function TQueryService.Open( AReadOnly : Boolean = False ) : Boolean;
begin
     With FDBQuery do
       begin
       SQL.Text := FSQLText;
       ReadOnly := AReadOnly;
       Open;
       FNroRegistroActual := 1;
       FNroTotalRegistros := RecordCount;
       Result := FNroTotalRegistros>0;
       end;
end;

procedure TQueryService.Execute;
begin
     With FDBQuery do
       begin
       SQL.Text := FSQLText;
       ExecSQL;
       end;
end;

procedure TQueryService.AddLikeField( Name, Value  : String );

var  StrValue : String;

begin
     // Se puede utilizar el caracter '*' o '%' como comodín

     If   Value<>''
     then begin
          If   FFieldExists
          then FSQLText := FSQLText + ' AND '
          else If   not FWhereExists
               then  FSQLText := FSQLText + ' WHERE ' ;
          FFieldExists := True;
          StrValue := UpperCase( Value );
          If   ( Pos( '*', StrValue )<>0 ) or ( Pos( '%', StrValue )<>0 )
          then StrValue := StringReplace( StrValue, '*', '%', [ rfReplaceAll, rfIgnoreCase ] )
          else StrValue := '%' + StrValue + '%';
          FSQLText := FSQLText + ' UPPER(' + Name + ') LIKE ' + QuotedStr( StrValue ) + ' ';
          end;
end;

{
function TQueryService.ReturnDataset( ADataset  : TkbmCustomMemTable;
                                   SaveDefs  : Boolean = True;
                                   SaveData  : Boolean = True ) : Variant;
begin
     // Setup stream format.
     With FQueryService do
       begin

       With TransportStreamFormat do
         begin
         PrepareForData( True, True );
         If   not SaveDefs
         then sfDef := sfDef - [ sfSaveDef ];
         If   not SaveData
         then sfData := sfData- [ sfSaveData ];
         sfContinue := [];
         end;

       // Put data to result stream.
       ADataset.SaveLimit := -1;
       ADataset.SaveToStreamViaFormat( ResultStream, TransportStreamFormat );

       // Prepare result variant.
       Result := VarArrayCreate( [ 0, 4 ], varVariant );
       Result[ 0 ] := KBMMW_QUERYSERVICE_QUERY_RECORD_VERSION;
       Result[ 1 ] := -1; // Detached
       Result[ 2 ] := '*';
       Result[ 3 ] :='';
       Result[ 4 ] :='';

       end;
end;
}

// ....

function TQueryService.CompruebaClave( const Args : array of Variant ) : Variant;

var I : SmallInt;
    Tabla,
    CampoClave,
    ValorClave,
    CampoResultado : String;

begin

     Result := VarArrayCreate( [ 0, 1 ], varVariant );
     Result [ 0 ] := False;

     try
       Tabla := Args[ 0 ];
       CampoClave := Args[ 1 ];
       ValorClave := Args[ 2 ];
       CampoResultado := Args[ 3 ];
     except
       Exit
       end;

     Setup( 'SELECT ' + CampoResultado + ' FROM ' + Tabla + ' WHERE ' + CampoClave + '=' + QuotedStr( ValorClave ) );
     If   Open
     then With FDBQuery do
            try
              If   FieldCount>0
              then begin
                   Result[ 0 ] := True;
                   Result[ 1 ] := Fields[ 0 ].AsAnsiString;
                   end;
            finally
              Close;
              end;

end;

function TQueryService.ObtenDataset( const Args : array of Variant ) : Variant;

var Tabla,
    CamposResultado : String;

begin
     Result := Unassigned;

     try
       Tabla := Args[ 0 ];
       If   High( Args )=1
       then CamposResultado := Args[ 1 ]
       else CamposResultado := '*';
     except
       Exit
       end;

     With FDBQuery do
       try
         SQL.Text := 'SELECT ' + CamposResultado + ' FROM ' + Tabla + ' WHERE 0>0';
         Open;
         If   FDBQuery.Active
         then Result := ReturnDataset( FDBQuery, True, True, True, '', MaxInt, mwdpsAll );
       finally
         Close;
         end;

end;

{  Fields es un array que contiene arrays con parejas de valores del tipo 'Nombre del campo' / 'valor del campo'.
   Por ejemplo : [ [ 'Serie', 'A1' ], [ 'NroPedido', 1200 ] ]
}

function TQueryService.GetFieldList( Fields    : array of Variant;
                                     Structure : TFieldValuesStructure = fvsAll;
                                     Separator : String = ',' ) : String;
var  I : SmallInt;
     Valor : Variant;
     ValorCampo : AnsiString;
     Vt : TVarType;

function QuotedStr( const S : String ) : String;
var
  I: Integer;
begin
  Result := S;
  for I := Length(Result) downto 1 do
    if Result[I] = '''' then Insert('''', Result, I);
  Result := '''' + Result + '''';
end;

begin
     Result := '';
     For I := 0 to High( Fields ) do
       begin
       If   I<>0
       then StrAdd( Result, ' ' + Separator + ' ' );
       If   ( Structure=fvsAll ) or ( Structure=fvsFieldNames )
       then StrAdd( Result, Fields[ I ][ 0 ] );
       If   ( Structure=fvsAll )
       then StrAdd( Result, '=' );
       If   ( Structure=fvsAll ) or ( Structure=fvsValues )
       then begin
            Valor := Fields[ I ][ 1 ];
            Vt := VarType( Fields[ I ][ 1 ] );
            ValorCampo := '';
            case Vt of
              varInteger   : ValorCampo := IntToStr( Valor );
              varDouble    : ;
              varCurrency  : ;
              varBoolean   : ValorCampo := BoolToStr( Valor, True );
              varShortInt  : ;
              varByte      : ;
              varWord      : ;
              varLongWord  : ;
              varInt64     : ;
              varUInt64    : ;
              varOleStr,
              varString,
              varUString   : ValorCampo := QuotedStr( Valor );
              varArray     : ;
              end;
            StrAdd( Result, ValorCampo );
            end;
       end;
end;

procedure TQueryService.AddFieldList( var SQLText   : String;
                                          Fields    : array of Variant;
                                          Structure : TFieldValuesStructure = fvsAll;
                                          Separator : String = ',' );
begin
     StrAdd( SQLText, GetFieldList( Fields, Structure, Separator ) );
end;

function TQueryService.ObtenRegistroDataset( const Args : array of Variant ) : Variant;

var SQLText,
    Tabla,
    CamposResultado : String;
    Clave : array of Variant;

begin
     Result := Unassigned;

     try
       Tabla := Args[ 0 ];
       Clave := Args[ 1 ];
       CamposResultado := Args[ 2 ];
     except
       Exit
       end;

     try

       SQLText := 'SELECT ' + CamposResultado + ' FROM ' + Tabla + ' WHERE ';
       AddFieldList( SQLText, Clave, fvsAll, 'AND' );
       Setup( SQLText );

       If   Open
       then With FDBQuery do
              If   RecordCount>0
              then Result := ReturnDataset( FDBQuery, True, True, True, '', MaxInt, mwdpsAll );

     finally
       FDBQuery.Close;
       end;

end;

function TQueryService.ObtenListaRegistrosDataset( const Args : array of Variant ) : Variant;

var I : SmallInt;
    ListaCampos : TStringList;
    SQLText,
    Tabla,
    Campos,
    CampoFiltro,
    Orden : String;
    Clave,
    Filtro : array of Variant;

begin

     Result := Unassigned;

     try
       Tabla := Args[ 0 ];
       Clave  := Args[ 1 ];
       Campos := Args[ 2 ];
       If   High( Args )>4
       then Filtro := Args[ 3 ]
       else Filtro := nil;
       If   High( Args )=5
       then Orden := Args[ 4 ]
       else Orden := '';
     except
        Exit;
        end;

     try
       ListaCampos := TStringList.Create;
       try

         ExtractStringList( Campos, ListaCampos );

         If   Orden=''
         then Orden := ListaCampos[ 0 ];

         SQLText := 'SELECT ' + Campos + ' FROM ' + Tabla + ' WHERE ';
         AddFieldList( SQLText, Clave, fvsAll, 'AND' );
         Setup( SQLText );

         If   High( Filtro )>=0
         then For I := 0 to ListaCampos.Count - 1 do
                begin
                CampoFiltro := VarToStr( Filtro[ 0 ][ I ] );
                AddLikeField( ListaCampos[ I ], CampoFiltro );
                end;

         If   Orden<>''
         then StrAdd(  SQLText, ' ORDER BY ' + Orden );

         If   Open( True ) // Read Only
         then If   FDBQuery.RecordCount>0
              then Result := ReturnDataset( FDBQuery, True, True, True, '', MaxInt, mwdpsAll );

       finally
         ListaCampos.Free;
         FDBQuery.Close;
       end;

       except
         end;

end;

function TQueryService.ObtenRegistro( const Args : array of Variant ) : Variant;

var I : SmallInt;
    SQLText,
    Tabla,
    CamposResultado : String;
    Clave : array of Variant;
    Registro : IkbmMWAS3Object;

begin
     Result := Unassigned;

     try
       Tabla := Args[ 0 ];
       Clave := Args[ 1 ];
       CamposResultado := Args[ 2 ];
     except
       Exit
       end;

     try

       SQLText := 'SELECT ' + CamposResultado + ' FROM ' + Tabla + ' WHERE ';
       AddFieldList( SQLText, Clave, fvsAll, 'AND' );
       Setup( SQLText );

       If   Open
       then With FDBQuery do
              If   RecordCount>0
              then begin
                   Registro := TkbmMWAS3Object.Create;
                   For I := 0 to FieldCount - 1 do
                     With Fields[ I ] do
                       Registro.SetValue( FieldName, Value );
                   Result := Registro;
                   end;

     finally
       FDBQuery.Close;
       end;

end;

function TQueryService.SuprimeRegistro( const Args : array of Variant ) : Variant;

var I : SmallInt;
    SQLText,
    Tabla : String;
    Clave : array of Variant;

begin
     Result := 0;

     try
       Tabla := Args[ 0 ];
       Clave := Args[ 1 ];
     except
       Exit
       end;

     try

        try

          SQLText := 'DELETE FROM ' + Tabla + ' WHERE ';
          AddFieldList( SQLText, Clave, fvsAll, 'AND' );
          Setup( SQLText );

          Execute;

        finally
          FDBQuery.Close;
          end;

     except
       Result := -1;
       end;
end;

function TQueryService.InsertaRegistroDataset( const Args : array of Variant ) : Variant;

var  SQLText,
     Tabla : String;
     Clave,
     Datos : array of Variant;

begin
     Result := 0;

     try
       Tabla := Args[ 0 ];
       Clave := Args[ 1 ];
       Datos := Args[ 2 ];
     except
       Exit;
       end;

     // La separación de la clave y los datos puede permitir realizar algún tipo de comprobación en un futuro

     try

        try

          SQLText := 'INSERT INTO '+ Tabla +
                     ' ( ' + GetFieldList( Clave, fvsFieldNames ) + ',' + GetFieldList( Datos, fvsFieldNames ) + ' ) ' +
                     'VALUES ( ' + GetFieldList( Clave, fvsValues ) + ',' + GetFieldList( Datos, fvsValues ) + ' ) ';
          Setup( SQLText );

          Execute;

        finally
          FDBQuery.Close;
          end;

     except on E : Exception do
       Result := -1;
       end;

end;

function TQueryService.ActualizaRegistroDataset( const Args : array of Variant ) : Variant;

var  SQLText,
     Tabla : String;
     Clave,
     Datos : array of Variant;

begin
     Result := 0;

     try
       Tabla := Args[ 0 ];
       Clave := Args[ 1 ];
       Datos := Args[ 2 ];
     except
       Exit
       end;

     try

        try

          SQLText := 'UPDATE '+ Tabla + ' SET ';
          AddFieldList( SQLText, Datos );
          StrAdd( SQLText, ' WHERE ' );
          AddFieldList( SQLText, Clave, fvsAll, 'AND' );
          Setup( SQLText );

          Execute;

        finally
          FDBQuery.Close;
          end;

     except on E : Exception do
       Result := -1;
       end;

end;

{  const Tabla,
   Campos        : String;
   const Filtro  : TStringArray

   Result        : TStringRecordArray;
}

function TQueryService.ObtenRelacionDataset( const Args : array of Variant ) : Variant;

var I : SmallInt;
    ListaCampos : TStringList;
    SQLText,
    Tabla,
    Campos,
    CampoFiltro,
    Orden : String;
    Filtro : array of Variant;

begin

     Result := Unassigned;

     try
       Tabla := Args[ 0 ];
       Campos := Args[ 1 ];
       Filtro := Args[ 2 ];
       If   High( Args )=3
       then Orden := Args[ 3 ]
       else Orden := '';
     except
        Exit;
        end;

     try
       ListaCampos := TStringList.Create;
       try

         ExtractStringList( Campos, ListaCampos );

         If   Orden=''
         then Orden := ListaCampos[ 0 ];

         SQLText := 'SELECT ' + Campos + ' FROM ' + Tabla;

         Setup( SQLText );

         For I := 0 to ListaCampos.Count - 1 do
            begin
            CampoFiltro := VarToStr( Filtro[ 0 ][ I ] );
            AddLikeField( ListaCampos[ I ], CampoFiltro );
            end;

         If   Orden<>''
         then StrAdd(  SQLText, ' ORDER BY ' + Orden );

         If   Open( True ) // Read Only
         then If   FDBQuery.RecordCount>0
              then Result := ReturnDataset( FDBQuery, True, True, True, '', MaxInt, mwdpsAll );
                             // ReturnDataset( FDBQuery, False, True, True, '', MaxInt, mwdpsData );

       finally
         ListaCampos.Free;
         FDBQuery.Close;
       end;

       except
         end;

end;

initialization

finalization

end.

