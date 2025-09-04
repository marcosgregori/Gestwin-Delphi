unit dm_efi;

interface

uses
  Windows, Messages,
  Generics.Defaults,
  Generics.Collections,
  Classes, Graphics, Controls, Forms, Dialogs,
  cxEdit,

  fs_ipascal,
  fs_iinterpreter,
  fs_iinirtti,

  AppContainer,
  AppForms,
  nxsdDataDictionary, DB, nxdb, nxsdTypes,

  DataManager,
  AppManager,
  Gim00Fields;

type
  TTipoFicheroEstructura = ( feCuenta, feProveedor, feCliente, feArticulo, feTarifaCompras );

  TExternField = class
    public
    Field  : TField;
    Incluir : Boolean;
    Inicio,
    Longitud,
    Decimales : SmallInt;
    Constante : String;
    end;

  TOnLineProcessedEvent = procedure ( ValidRecord, Modified : Boolean; DataLine : String ) of object;

  TEstructuraFicheroModule = class(TDataModule)
    DmEstructuraFicheroTable: TnxeTable;
    DmLineaEstructFicheroTable: TnxeTable;
    FsScript: TfsScript;
    FsPascal: TfsPascal;
    fsIniRTTI: TfsIniRTTI;
    procedure DmLineaEstructFicheroTableAfterOpen(DataSet: TDataSet);
    procedure DmEstructuraFicheroTableAfterOpen(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

    FFieldList : TList<TExternField>;
    FListaParametros : TStringList;
    FExternFile : TextFile;
    FExternFileOpened : Boolean;
    FCharSep : Char;

    DmEstructuraFicheroFields : TEstructuraFicheroFields;
    DmLineaEstructFicheroFields : TLineaEstructFicheroFields;

    function ObtenLineaMuestra( FilePath : String = '' ) : String;

  public

    procedure Valida( EditControl : TcxCustomEdit; TipoFichero : SmallInt; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False; SoloCSV : Boolean = False  ); overload;
    function  Descripcion( tipoFichero : SmallInt; codigo : SmallInt; notificaSiNoExiste : boolean ) : String;
    // function CompilarExpresion( Formula : String ) : Bboolean;
    procedure AsignaVariables( Dataset : TDataset );
    procedure CreaVariable( FieldName : String; FieldType : TFieldType; Valor : Variant );
    function CalcularExpresion( Valor : String ) : String;
    function ObtenValorVariable( FieldName  : String ) : Variant;
    function Ejecuta( Script : String ) : Boolean;
    function TextToVariant( Value : String; DataType : TFieldType ) : Variant;
    function VariantToText( Value : Variant; DataType : TFieldType ) : String;
    function FieldExists( FieldName : String; out ExternField : TExternField ) : Boolean;
    function CheckRequiredFields( Table : TnxeTable ) : Boolean;

    function ObtenNombreTabla( TipoFichero : SmallInt ) : String;
    procedure ObtenListaFicheros( Lista : TStrings );
    function  InicializaEstructuraDatos( TargetTable : TnxeTable; TargetFields : TnxeDatasetFields = nil; FilePath : String = '' ) : Boolean;
    procedure ImportaDatos( PathFicheroExterno : String; TargetTable : TnxeTable; InitDataStruct, InsertData, UpdateData : Boolean; OnValidRecord : TQueryEvent; BeforeMoveExternData, BeforePostRecord : TSimpleEvent; OnLineProcessed : TOnLineProcessedEvent );
    procedure ExportaDatos( PathFicheroExterno : String; SourceTable : TnxeTable; SourceFields : TnxeDatasetFields; OnValidRecord : TQueryEvent; BeforeMoveRecordData : TSimpleEvent; BeforePostData : TSimpleEvent = nil; OnLineProcessed : TOnLineProcessedEvent = nil );

    property FieldList : TList<TExternField> read FFieldList;

  end;

var  EstructuraFicheroModule: TEstructuraFicheroModule = nil;


function  EstructuraFichero : TEstructuraFicheroModule;


implementation

uses Variants,
     SysUtils,
     LibUtils,

     EnterpriseDataAccess,

     dmi_pga,

     dm_pga,
     dm_iex,

     b_pro, f_prg;

{$R *.DFM}

resourceString
      RsMsg1  = 'El nombre de campo [%s] no existe en esta tabla.';
      RsMsg2  = 'Revise la estructura del fichero externo y reintente el proceso.';
      RsMsg3  = 'No ha incluido en la estructura la clave primaria del fichero.';
      RsMsg4  = 'Las claves primarias se muestran de color verde en la estructura del fichero externo.';
      RsMsg5  = 'No he conseguido abrir el fichero externo.';
      RsMsg6  = 'Compruebe que está en la ubicación indicada y que no está siendo utilizado por otro usuario.';
      RsMsg7  = 'Registro %u de %u.';
      RsMsg8  = 'Esta tabla no existe en su aplicación.';
      RsMsg9  = 'El tipo de dato del campo [%s] no es correcto : [%s].';
      RsMsg10 = 'Realizando el proceso de %s';
      RsMsg11 = 'Se ha producido un error al compilar la expresión asociada al registro.';
      RsMsg12 = 'Se ha producido un error al crear el registro.';
      RsMsg13 = 'No se puede asignar el valor [%s] al campo %s.';
      RsMsg14 = 'Solo se pueden utilizar estructuras en formato CSV.';
      RsMsg15 = 'El campo [%s] es obligatorio y no ha sido incluido en la estructura del fichero externo.';

var   AlfaSet   : set of AnsiChar = [ 'A'..'Z', '-', '/', '+', '*', ',', '.', '-' ];
      DigitoSet : set of AnsiChar = [ '0'..'9' ];

const NombreFichero : array[ 0..Ord( feTarifaCompras ) ] of String = ( 'Cuenta', 'Proveedor', 'Cliente', 'Articulo', 'TarifaCompras' );

function estructuraFichero : TEstructuraFicheroModule;
begin
     CreateDataModule( TestructuraFicheroModule, EstructuraFicheroModule );
     Result := EstructuraFicheroModule;
end;

procedure TEstructuraFicheroModule.DataModuleCreate(Sender: TObject);
begin
     FFieldList := TLIst<TExternField>.Create;
     FListaParametros := TStringList.Create;
end;

procedure TEstructuraFicheroModule.DataModuleDestroy(Sender: TObject);
begin
     FListaParametros.Free;
     FFieldList.Free;
     FsScript.ClearRTTI;
     EstructuraFicheroModule := nil;
end;

procedure TEstructuraFicheroModule.Valida(     EditControl    : TcxCustomEdit;
                                               TipoFichero   : SmallInt;
                                           var DisplayValue  : Variant;
                                           var ErrorText     : TCaption;
                                           var Error         : Boolean;
                                               IsInfoControl : Boolean = False;
                                               SoloCSV       : Boolean = False );
begin
     ValidateRelation( EditControl, DmEstructuraFicheroTable, [ TipoFichero, DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
     If   not Error
     then If  SoloCSV and ( DmEstructuraFicheroFields.Formato.Value<>1 )
          then begin
               Error := True;
               ErrorText := RsMsg14;
               end;
end;

function TEstructuraFicheroModule.Descripcion( TipoFichero        : SmallInt;
                                               Codigo             : SmallInt;
                                               NotificaSiNoExiste : Boolean ) : String;
begin
     GetRelationDescription( DmEstructuraFicheroTable, [ TipoFichero, Codigo ], Result, NotificaSiNoExiste, RsDescripcion );
end;

procedure TEstructuraFicheroModule.DmEstructuraFicheroTableAfterOpen(DataSet: TDataSet);
begin
     DmEstructuraFicheroFields := TEstructuraFicheroFields.Create( DmEstructuraFicheroTable );
end;

procedure TEstructuraFicheroModule.DmLineaEstructFicheroTableAfterOpen(DataSet: TDataSet);
begin
     DmLineaEstructFicheroFields := TLineaEstructFicheroFields.Create( DmLineaEstructFicheroTable );
end;

function TEstructuraFicheroModule.CalcularExpresion( Valor : String ) : String;
begin
     try
       Result := FsScript.Evaluate( Valor );
     except on E : Exception do
       Result := E.Message;
       end;
end;

function TEstructuraFicheroModule.TextToVariant( Value : String; DataType : TFieldType ) : Variant;

var  SaveDecimalSeparator : Char;

begin
     try
       case DataType of
         ftSmallint,
         ftInteger,
         ftWord          : Result := StrToIntDef( Value, 0 );

         ftBoolean       : Result := SysUtils.StrToBoolDef( Value, False );

         ftFloat,
         ftBCD,
         ftCurrency      : try
                             SaveDecimalSeparator := FormatSettings.DecimalSeparator;
                             FormatSettings.DecimalSeparator := '.';
                             Value := StrChangeChar( Value, ',', '.' );  // Por si el usuario ha utilizado la coma en ficheros de ancho fijo
                             Result := StrToFloatDef( Value, 0.0 );
                           finally
                             FormatSettings.DecimalSeparator := SaveDecimalSeparator;
                             end;
         ftDate,
         ftDateTime      : If   Value=''
                           then Result := null
                           else Result := SysUtils.StrToDate( Value );

         ftTime          : If   Value=''
                           then Result := null
                           else Result := SysUtils.StrToTime( Value );

         else              Result := Value;  // Incluido ftWideString
         end;
     except
       Result := Value;
       end;
end;

function TEstructuraFicheroModule.VariantToText( Value : Variant; DataType : TFieldType ) : String;

var  FieldString : String;

begin
     try
       case DataType of
         ftSmallint,
         ftInteger,
         ftWord          : Result := IntToStr( Value );

         ftBoolean       : Result := BoolToStr( Value );

         ftFloat,
         ftBCD,
         ftCurrency      : Result := StrChangeChar( FloatToStr( Value ), ',', '.' );

         ftDate,
         ftDateTime      : Result := StrFormatDate( Value );

         ftTime          : Result := StrFormatTime( Value );

         else              begin
                           FieldString := VarToStr( Value );
                           FieldString := StrChangeChar( FieldString, '''', '´' );
                           FieldString := StrRemoveChars( FieldString, [ #0, #10, #13 ] );
                           Result := QuotedStr( FieldString );
                           end;
         end;
     except
       Result := Value;
       end;
end;

procedure TEstructuraFicheroModule.CreaVariable( FieldName : String;
                                                 FieldType : TFieldType;
                                                 Valor     : Variant );

var  Dtn : String;
     Vt : TfsVarType;
     V : TfsVariable;
begin
     With FsScript do
       begin

       case FieldType of
         ftString,
         ftWideString    : begin
                           Dtn := 'String';
                           Vt := fvtString;
                           end;
         ftSmallint,
         ftInteger,
         ftWord          : begin
                           Dtn := 'Integer';
                           Vt := fvtInt;
                           end;
         ftBoolean       : begin
                           Dtn := 'Boolean';
                           Vt := fvtBool;
                           end;

         ftBCD,
         ftFloat,
         ftCurrency      : begin
                           Dtn := 'Extended';
                           Vt := fvtFloat;
                           end;

         ftArray         : begin
                           Dtn := 'Array';
                           Vt := fvtArray;
                           end

         else              begin
                           Dtn := 'Variant';
                           Vt := fvtVariant;
                           end;
         end;


       V := TfsVariable.Create( FieldName, Vt, Dtn );
       V.Value := Valor;
       Add( V.Name, V );

       end;

end;

function TEstructuraFicheroModule.Ejecuta( Script : String ) : Boolean;
begin
     Result := False;
     With FsScript do
       begin
       AddRTTI;
       Lines.Clear;
       Lines.Add( 'begin ' + Script + ' end.' );
       If   Compile
       then begin
            Execute;
            Result := True;
            end;
       end;
end;

function TEstructuraFicheroModule.ObtenValorVariable( FieldName  : String ) : Variant;
begin
     Result := FsScript.Variables[ FieldName ];
end;

procedure TEstructuraFicheroModule.AsignaVariables( Dataset : TDataset );

var  Index  : SmallInt;

begin
     FsScript.Clear;
     With Dataset do
       For Index := 0 to FieldCount - 1 do
         With Fields[ Index ] do
           FsScript.AddVariable( FieldName, 'Variant', Value );
end;

procedure TEstructuraFicheroModule.ObtenListaFicheros( Lista : TStrings );

var   Index  : SmallInt;

begin
     With Lista do
       begin
       Clear;
       For Index := Ord( feCuenta ) to Ord( feCliente ) do
         Add( NombreFichero[ Index ] );
       If   ProgramNumber in [ 0, pnTPV, pnComercial, pnContableComercial,  pnPrevision, pnPreventa ]   // TPV, Gestión comercial, producción y previsión
       then begin
	   	      Add( NombreFichero[ Ord( feArticulo ) ] );
			      Add( NombreFichero[ Ord( feTarifaCompras ) ] );
			      end;
       end;
end;

// ProcessForm debe estar activo

function TEstructuraFicheroModule.InicializaEstructuraDatos( TargetTable  : TnxeTable;
                                                             TargetFields : TnxeDatasetFields = nil;
                                                             FilePath     : String = '' ) : Boolean;

var  KeyExists : Boolean;
     TargetField : TField;
     ExternField : TExternField;
     ScriptText : String;
     ProgramBlockDefined : Boolean;
     Index,
     BeginPos : SmallInt;

begin

     try

       Result := False;

       FsScript.Clear;
       FsScript.Lines.Clear;
       FsScript.AddRTTI;

       ScriptText := DmEstructuraFicheroFields.Script.AsString;
       ProgramBlockDefined := Pos( 'END.', UpperCase( ScriptText ) )<>0;

       {  Si en el script se incluye un bloque begin end. entonces no hace falta incluirlo.
          Además es necesario si se quieren definir variables al principio del mismo.

          var Test : String
          begin
             ...
          end.
       }

       If   ProgramBlockDefined
       then begin
            BeginPos := Pos( 'BEGIN', UpperCase( ScriptText ) );
            If   BeginPos>0
            then begin
                 FsScript.Lines.Add( Copy( ScriptText, 1, BeginPos + 5 ) );
                 ScriptText := Copy( ScriptText, BeginPos + 5, MaxInt );
                 end;
            end
       else FsScript.Lines.Add( 'begin' );

       KeyExists := False;


       // Asigno los valores de las variables de las columnas

       If   DmEstructuraFicheroFields.Formato.Value=1
       then begin
            ExportImport.ExtraeParametros( ObtenLineaMuestra( FilePath ), FListaParametros, FCharSep );
            With FListaParametros do
              For Index := 0 to Count - 1 do
                EstructuraFichero.CreaVariable( 'Columna' + IntToStr( Index + 1 ), ftString, Strings[ Index ] );
            end;

       If   Assigned( TargetFields )
       then TargetFields.Clear( TargetTable );   // Esto crea la lista de campos si TargetFields es estático y limpia el registro

       // DmEstructuraFicheroFields debe haberse leido con anterioridad

       With DmLineaEstructFicheroTable do
         try

           With DmEstructuraFicheroFields do
             SetRange( [ Fichero.Value, NroRegistro.Value, 1 ], [ Fichero.Value, NroRegistro.Value, MaxSmallint ] );

           First;

           While not Eof do
             begin


             //* 12.12.2009 Incluyo todos los campos. Con la inclusión del Script puede ser necesario poder acceder a todos ellos.

             If   Assigned( TargetFields )
             then TargetField := TargetFields.FindField( DmLineaEstructFicheroFields.Campo.Value )
             else TargetField := TargetTable.FindField( DmLineaEstructFicheroFields.Campo.Value );

             If   Assigned( TargetField )
             then begin

                  With TargetField do
                    CreaVariable( FieldName, DataType, Null );

                  If   DmLineaEstructFicheroFields.Incluir.Value or ( DmLineaEstructFicheroFields.Inicio.Value>0 ) or not ValueIsEmpty( Trim( DmLineaEstructFicheroFields.Constante.Value ) )
                  then begin

                       ExternField := TExternField.Create;
                       If   Assigned( ExternField )
                       then begin

                            ExternField.Field := TargetField;
                            ExternField.Incluir := DmLineaEstructFicheroFields.Incluir.Value;
                            ExternField.Inicio := DmLineaEstructFicheroFields.Inicio.Value;
                            ExternField.Longitud := DmLineaEstructFicheroFields.Longitud.Value;
                            ExternField.Decimales := DmLineaEstructFicheroFields.Decimales.Value;
                            ExternField.Constante := DmLineaEstructFicheroFields.Constante.Value;

                            Self.FieldList.Add( ExternField );

                            // De momento solo permito importar a ficheros con claves primarias simples

                            If   not KeyExists
                            then KeyExists:= TargetTable.IsIndexField( TargetField ) and DmLineaEstructFicheroFields.Incluir.Value;

                            If   not ValueIsEmpty( Trim( DmLineaEstructFicheroFields.Constante.Value ) )
                            then FsScript.Lines.Add( TargetField.FieldName + ' := ' + Trim( DmLineaEstructFicheroFields.Constante.Value ) + ';' );

                            end
                       else With ProcessFrame do
                              begin
                              AddMsg( ntError, Format( RsMsg1, [ DmLineaEstructFicheroFields.Campo.Value ] ) );
                              AddMsg( ntError, RsMsg2 );
                              Exit;
                              end;

                       end;

                  end;

             Next;
             end;

         finally
           CancelRange;
           end;

         FsScript.Lines.Add( ScriptText );

         If   not ProgramBlockDefined
         then FsScript.Lines.Add( 'end.' );

         If   not FsScript.Compile
         then begin
              ProcessFrame.AddMsg( ntError, FsScript.ErrorMsg + '. Posicion : ' + FsScript.ErrorPos );
              ProcessFrame.AddMsg( ntError, RsMsg11 );
              Abort;
              end
         else If   KeyExists
              then Result := True
              else With ProcessFrame do
                     begin
                     AddMsg( ntError, RsMsg3 );
                     AddMsg( ntError, RsMsg4 );
                     Abort;
                     end;

     except on E : Exception do
       begin
       If   not ( E is EAbort )
       then ProcessFrame.AddMsg( ntError, E.Message );
       raise;
       end;
     end;
end;

function TEstructuraFicheroModule.CheckRequiredFields( Table : TnxeTable ) : Boolean;

var  ExternField : TExternField;
     Field : TField;
     Correct : Boolean;

begin
     Result := False;
     For Field in Table.Fields do
       If   Field.Required
       then begin
            Correct := False;
            If   FieldExists( Field.FieldName, ExternField )
            then Correct := ExternField.Incluir;
            If   not Correct
            then begin
                 ShowNotification( ntError, Format( RsMsg15, [ Field.FieldName ] ) );
                 Exit;
                 end;
              end;
     Result := True;
end;

function TEstructuraFicheroModule.ObtenLineaMuestra( FilePath : String = '' ) : String;
begin
     If   FilePath=''
     then FilePath := DmEstructuraFicheroFields.FicheroExterno.Value;
     try
       AssignFile( FExternFile, FilePath );
       Reset( FExternFile );
       FExternFileOpened := True;
       Readln( FExternFile, Result );
       CloseFile( FExternFile );
       FExternFileOpened := False;
     except
       With ProcessFrame do
         begin
         AddMsg( ntError, RsMsg5 );
         AddMsg( ntError, RsMsg6 );
         end;
       Abort;
       end;

end;

procedure TEstructuraFicheroModule.ImportaDatos( PathFicheroExterno    : String;
                                                 TargetTable           : TnxeTable;
                                                 InitDataStruct,
                                                 InsertData,
                                                 UpdateData            : Boolean;
                                                 OnValidRecord         : TQueryEvent;
                                                 BeforeMoveExternData,
                                                 BeforePostRecord      : TSimpleEvent;
                                                 OnLineProcessed       : TOnLineProcessedEvent );

var  Modified,
     Correct,
     ValidRecord : Boolean;
     RecCount,
     MaxRecCount : LongInt;
     StrDataLine : String;

{
procedure CopiarDato( Field : TField; St : String );

var  BoolValue : Boolean;

begin
     try

        St := Trim( St );

        With Field do
          begin
          case DataType of
            ftBoolean    : begin
                           If   Length( St )>0
                           then BoolValue := CharInSet( UpCase( St[ 1 ] ), [ 'S', 'Y', 'T' ] )
                           else BoolValue := False;
                           Field.Value := BoolValue;
                           Exit;
                           end;
            ftCurrency,
            ftBCD,
            ftFloat      : St := StrChangeChar( St, '.', ',' );
            end;

          AsString := St;
          end;

     except
       ProcessFrame.AddMsg( ntError, Format( RsMsg9, [ Field.FieldName, St ] ) );
       Abort;
       end;

end;
}

function MoveExternDataToRecord( OnlyIndexFields : Boolean ) : Boolean;

var  StIndex,
     FxIndex,
     Index : SmallInt;
     St : String;
     Value : Variant;
     ExternField : TExternField;

begin

     If   not OnlyIndexFields and Assigned( BeforeMoveExternData )
     then BeforeMoveExternData;

     // Paso 0. Los valores de las columnas (tal cual y solo para ficheros CSV)

     If   DmEstructuraFicheroFields.Formato.Value=1
     then begin
          ExportImport.ExtraeParametros( StrDataLine, FListaParametros, FCharSep );
          With FListaParametros do
            For Index := 0 to Count - 1 do
              EstructuraFichero.FsScript.Variables[ 'Columna' + IntToStr( Index + 1 ) ] := Strings[ Index ];
          end;

     // Paso 1. Los valores directos

     StIndex := 0;
     With FieldList do
       begin

       For Index := 0 to Count - 1 do
         begin
         ExternField := TExternField( Items[ Index ] );
         If   not OnlyIndexFields or ExternField.Field.IsIndexField
         then If   ( ( DmEstructuraFicheroFields.Formato.Value=0 ) and ( ExternField.Inicio>0 ) ) or
                   ( ( DmEstructuraFicheroFields.Formato.Value=1 ) and ExternField.Incluir )
              then begin

                   case DmEstructuraFicheroFields.Formato.Value of
                     0 : begin
                         St := Copy( StrDataLine, ExternField.Inicio, ExternField.Longitud );
                         // Incluyendo el decimal implícito
                         If   ( ExternField.Field.DataType in [ ftFloat, ftBCD, ftCurrency ] )
                         then If   DmEstructuraFicheroFields.DecimalImplicito.Value and ( ExternField.Decimales>0 )
                              then System.Insert( ',', St, ExternField.Longitud - ExternField.Decimales );
                         end;
                     1 : begin
                         // Cuando se utilizan ficheros CSV el campo Inicio puede indicar la Columna (es opcional)
                         If   ExternField.Inicio=0
                         then FxIndex := StIndex
                         else FxIndex := ExternField.Inicio - 1;  // Numeradas a partir de 1
                         If   FxIndex<FListaParametros.Count
                         then St := FListaParametros.Strings[ FxIndex ];
                         Inc( StIndex );
                         end;
                     end;

                   try
                     Value := TextToVariant( St, TFieldType( ExternField.Field.DataType ) );
                     FsScript.Variables[ ExternField.Field.FieldName ] := Value;
                     // Asigno los valores a los campos para que estén disponibles cuando se ejecute el script
                     If   ExternField.Constante=''    // Si hay un valor constante no intento asignar el de la línea
                     then ExternField.Field.Value := Value;
                   except on E : Exception do
                     begin
                     E.Message := Format( RsMsg13, [ St, ExternField.Field.FieldName ] );
                     raise;
                     end;
                   end;

                   end
              else If   ( DmEstructuraFicheroFields.Formato.Value=1 ) and ExternField.Incluir
                   then Inc( StIndex );
         end;

       // Paso 3. El Script.

       FsScript.Execute;

       // Paso 4. El resultado en las variables

       For Index := 0 to Count - 1 do
         With TExternField( Items[ Index ] ) do
           If   not OnlyIndexFields or Field.IsIndexField
           then If   not ValueIsEmpty( Trim( Constante ) ) or
                     ( ( DmEstructuraFicheroFields.Formato.Value=0 ) and ( Inicio>0 ) ) or
                     ( ( DmEstructuraFicheroFields.Formato.Value=1 ) and Incluir )
           then Field.Value := FsScript.Variables[ Field.FieldName ];

       end;

     If   not OnlyIndexFields and Assigned( OnValidRecord )
     then Result := OnValidRecord
     else Result := True;

end;

procedure PostData;
begin
     If   MoveExternDataToRecord( False )
     then begin
          If   Assigned( BeforePostRecord )
          then BeforePostRecord;
          TargetTable.Post;
          Modified := True;
          end
     else TargetTable.Cancel;
end;

begin

     With ProcessFrame do
       begin

       MaxRecCount := 0;
       RecCount := 0;
       FExternFileOpened := False;

       AddMsg( ntHeader, Format( RsMsg10, [ 'importación' ] ) );

       If   TargetTable.IndexFieldNames=''
       then TargetTable.IndexName := '';  // Fijando el índice por defecto

       try

         try

           EnterpriseDataModule.StartTransaction( [ TargetTable ] );

           FCharSep := ',';
           With DmEstructuraFicheroFields do
             If   Formato.Value=1
             then If   Length( Separador.Value )=1
                  then FCharSep := Separador.Value[ 1 ];

           // Contamos el número de líneas/registros del fichero de texto externo

           If   PathFicheroExterno=''
           then PathFicheroExterno := DmEstructuraFicheroFields.FicheroExterno.Value;

           try
             AssignFile( FExternFile, PathFicheroExterno );
             Reset( FExternFile );
             FExternFileOpened := True;
             While not Eof( FExternFile ) do
               begin
               Inc( MaxRecCount );
               Readln( FExternFile, StrDataLine );
               end;
             CloseFile( FExternFile );
             FExternFileOpened := False;
           except
             AddMsg( ntError, RsMsg5 );
             AddMsg( ntError, RsMsg6 );
             Exit;
             end;

           ProgressBar.Properties.Max := MaxRecCount;

           If   InitDataStruct
           then begin
                FieldList.Clear;
                Correct := InicializaEstructuraDatos( TargetTable );
                end
           else Correct := True;

           If   Correct and InsertData
           then Correct := CheckRequiredFields( TargetTable );

           If   Correct
           then begin

                Reset( FExternFile );
                FExternFileOpened := True;
                While not Eof( FExternFile ) and not Canceled do
                  begin

                  ValidRecord := False;

                  Readln( FExternFile, StrDataLine );

                  Inc( RecCount );
                  AddRecordMsg( Format( RsMsg7, [ RecCount, MaxRecCount ] ) );

                  try

                    TargetTable.SetKey;

                    If   MoveExternDataToRecord( True )
                    then begin

                         Modified := False;
                         ValidRecord := False;

                         With TargetTable do
                           If   GotoKey
                           then begin
                                ValidRecord := True;
                                If   UpdateData
                                then begin
                                     Edit;
                                     PostData;
                                     end;
                                end
                           else If   InsertData
                                then begin
                                     ValidRecord := True;
                                     Append;
                                     PostData;
                                     end;
                         end
                    else TargetTable.Cancel;

                  except
                    TargetTable.Cancel;
                    raise;
                    end;

                  If   Assigned( OnLineProcessed )
                  then OnLineProcessed( ValidRecord, Modified, StrDataLine );

                  end;

                end;

             EnterpriseDataModule.Commit;

           except on E : Exception do
             begin
             EnterpriseDataModule.RollBack;
             ShowNotification( ntStop, RsMsg12, E.Message );
             raise;
             end;
           end;

       finally
         If   FExternFileOpened
         then CloseFile( FExternFile );
         FieldList.Clear;
         FListaParametros.Clear;
         end;
       end;
end;

procedure TEstructuraFicheroModule.ExportaDatos( PathFicheroExterno    : String;
                                                 SourceTable           : TnxeTable;
                                                 SourceFields          : TnxeDatasetFields;
                                                 OnValidRecord         : TQueryEvent;
                                                 BeforeMoveRecordData  : TSimpleEvent;
                                                 BeforePostData        : TSimpleEvent = nil;
                                                 OnLineProcessed       : TOnLineProcessedEvent = nil );

var  Modified,
     Correct,
     ValidRecord : Boolean;
     RecCount,
     MaxRecCount : LongInt;
     StrDataLine : String;

function GetRecordData( var StrDataLine : String ) : Boolean;

var  ExternField : TExternField;
     FirstField : Boolean;

begin

     // Paso 0. Asigno los valores a las variables

     If   Assigned( BeforeMoveRecordData )
     then BeforeMoveRecordData;

     For ExternField in FFieldList do
       With ExternField do
         FsScript.Variables[ Field.FieldName ] := Field.Value;

     // Paso 1. Ejecuto el script.

     FsScript.Execute;

     // Paso 2. El resultado en las variables

     For ExternField in FFieldList do
       With ExternField do
         If   not ValueIsEmpty( Trim( Constante ) ) or
              ( ( DmEstructuraFicheroFields.Formato.Value=0 ) and ( Inicio>0 ) ) or
              ( ( DmEstructuraFicheroFields.Formato.Value=1 ) and Incluir )
       then Field.Value := FsScript.Variables[ Field.FieldName ];

     // Paso 3. La inclusión

     If   Assigned( OnValidRecord )
     then Result := OnValidRecord
     else Result := True;

     If   Result
     then begin

          FirstField := True;
          With FieldList do
            begin

            // En la exportación solo se soporta el formato CSV

            For ExternField in FFieldList do
              With ExternField do
                If   Incluir
                then begin
                     If   FirstField
                     then FirstField := False
                     else StrAdd( StrDataLine, FCharSep );
                     StrAdd( StrDataLine, VariantToText( Field.AsVariant, Field.DataType ) );
                     end;

            end;

          end;

end;

begin

     With ProcessFrame do
       If   DmEstructuraFicheroFields.Formato.Value=1   // La exportación solo soporta el formato CSV
       then begin

            MaxRecCount :=  SourceTable.RecordCount;
            RecCount := 0;
            FExternFileOpened := False;

            AddMsg( ntHeader, Format( RsMsg10, [ 'exportación' ] ) );

            FieldList.Sort( TComparer< TExternField >.Construct( function ( Const L, R : TExternField ) : Integer begin Result := L.Inicio - R.Inicio; end ) ) ;

            try

              try

                FCharSep := ',';
                With DmEstructuraFicheroFields do
                  If   Length( Separador.Value )=1
                  then FCharSep := Separador.Value[ 1 ];

                ProgressBar.Properties.Max := MaxRecCount;

                FieldList.Clear;
                Correct := InicializaEstructuraDatos( SourceTable, SourceFields );

                If   Correct
                then begin

                     AssignFile( FExternFile, PathFicheroExterno );
                     Rewrite( FExternFile );

                     FExternFileOpened := True;

                     SourceTable.First;
                     While not SourceTable.Eof and not Canceled do
                       begin

                       ValidRecord := False;
                       SourceFields.Update( SourceTable );

                       Inc( RecCount );
                       AddRecordMsg( Format( RsMsg7, [ RecCount, MaxRecCount ] ) );

                       StrDataLine := '';
                       If   GetRecordData( StrDataLine )
                       then begin
                            If   Assigned( BeforePostData )
                            then BeforePostData;
                            ValidRecord := True;
                            WriteLn( FExternFile, StrDataLine );
                            end;

                       If   Assigned( OnLineProcessed )
                       then OnLineProcessed( ValidRecord, Modified, StrDataLine );

                       SourceTable.Next;
                       end;

                     end;

              except on E : Exception do
                begin
                ShowNotification( ntStop, RsMsg12, E.Message );
                raise;
                end;
              end;

            finally
              If   FExternFileOpened
              then CloseFile( FExternFile );
              FieldList.Clear;
              FListaParametros.Clear;
            end;

            end;

end;

function TEstructuraFicheroModule.ObtenNombreTabla( TipoFichero : SmallInt ) : String;
begin
     Result := NombreFichero[ Ord( TipoFichero ) ];
end;

function TEstructuraFicheroModule.FieldExists(     FieldName   : String;
                                               out ExternField : TExternField ) : Boolean;

var   Index  : SmallInt;

begin
     Result := False;
     For Index := 0 to FFieldList.Count - 1 do
       If   UpperCase( FFieldList.Items[ Index ].Field.FieldName )=UpperCase( FieldName )
       then begin
            ExternField := FFieldList.Items[ Index ];
            Result := True;
            Break;
            end;
end;

end.

