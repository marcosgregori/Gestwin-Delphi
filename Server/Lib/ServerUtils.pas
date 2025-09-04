unit ServerUtils;

interface

uses  sgcJSON {,
      SynCommons} ;

// sgcWebSockets

function GetNodeValue( Root : IsgcJSON; Name : String; DefValue : Variant ) : Variant;
function GetNodeObject( Root : IsgcJSON; Name : String ) : IsgcJSON;
function NodeExists( Root : IsgcJSON; Name : String; var Node : IsgcObjectJSON ) : Boolean; overload;
function NodeExists( Root : IsgcJSON; Name : String; var Node : IsgcJSON ) : Boolean; overload;

function GetListFromJSONArray( StringArray : IsgcJSON; JSONType : TsgcJSONtype = sgcJSONString ) : String;

{

// Mormot

function GetValueOrDef( Data : Variant; Name : String; Default : Variant ) : Variant;
function GetDocOrNull( Data : Variant ) : PDocVariantData;

const    NULL_VAL = 'NULL';
         DEF_JSON_OPTIONS = [ dvoNameCaseSensitive, dvoReturnNullForUnknownProperty ];
}

implementation

uses Variants,
     SysUtils,
     TypInfo,

     LibUtils;

function GetNodeValue( Root     : IsgcJSON;
                       Name     : String;
                       DefValue : Variant ) : Variant;

var  Node : IsgcObjectJSON;

begin
     Result := DefValue;
     Node := Root.Node[ Name ];
     If   Assigned( Node )
     then If   ( Node.Value='undefined' ) or
               ( Node.Value='null' )
          then case VarType( DefValue ) of
                 varSmallint, varInteger, varShortInt, varInt64 :
                   Result := -1;
                 else
                   Result := '';  // Luego puedo contemplar mas tipos
                 end
          else Result := Node.Value;
end;

function GetNodeObject( Root : IsgcJSON;
                        Name : String ) : IsgcJSON;

var  Node : IsgcObjectJSON;

begin
     Result := nil;
     Node := Root.Node[ Name ];
     If   Assigned( Node )
     then Result := Node.JSONObject;
end;

function NodeExists(     Root : IsgcJSON;
                         Name : String;
                     var Node : IsgcObjectJSON ) : Boolean;
begin
     Node := Root.Node[ Name ];
     Result := Assigned( Node );
end;

function NodeExists(     Root : IsgcJSON;
                         Name : String;
                     var Node : IsgcJSON ) : Boolean;

var  ObjectNode : IsgcObjectJSON;

begin
     ObjectNode := Root.Node[ Name ];
     Result := Assigned( ObjectNode );
     If   Result
     then Node := ObjectNode.JSONObject;
end;


function GetListFromJSONArray( StringArray : IsgcJSON;
                               JSONType    : TsgcJSONtype = sgcJSONString ) : String;

var Value : String;

begin

     var FieldList := '';
     For var Index : SmallInt := 0 to StringArray.Count - 1 do
       begin
       If   FieldList<>''
       then StrAdd( FieldList, ', ' );
       Value := StringArray.Item[ Index ].Value;
       If   JSONType=sgcJSONString
       then Value := QuotedStr( Value );
       StrAdd( FieldList, Value );
       end;
     Result := FieldList;
end;


{  // Mormot

function GetValueOrDef( Data    : Variant;
                        Name    : String;
                        Default : Variant ) : Variant;
begin
     // Result := _Safe( Data )^.GetValueOrDefault( Name, Default );
     Result := _Safe( Data )^.GetValueOrNull( Name );
     If   VarIsNull( Result )
     then Result := Default;
end;

function GetDocOrNull( Data : Variant ) : PDocVariantData;
begin
     If   VarIsNull( Data )
     then Result := nil
     else Result := DocVariantData( Data );
end;
}
{
procedure GoAllProperties( Other : TObject );

var Properties: PPropList;
    nProperties: Integer;
    Info: PPropInfo;
    Obj: TObject;
    Intf: IMyInterface;
    Unk: IUnknown;

begin
     // Get a list of all the object's published properties
     nProperties := GetPropList( Other.ClassInfo, Properties );
     If   nProperties > 0
     then try

            // Optional: sort the list

            SortPropList( Properties, nProperties );

            For var I := 0 to Pred( nProperties ) do
              begin
              Info := Properties^[ i ];
              // Skip write-only properties
              If   not Assigned( Info.GetProc )
              then Continue;

              // Check what type the property holds
              case Info.PropType^^.Kind of
                tkClass :
                  begin
                  // Get the object reference from the property
                  Obj := GetObjectProp( Other, Info );
                  // Check whether it implements IMyInterface
                  If   Supports( Obj, IMyInterface, Intf )
                  then Intf.Go;
                  end;

                tkInterface :
                  begin
                  // Get the interface reference from the property
                  Unk := GetInterfaceProp( Obj, Info );
                  // Check whether it implements IMyInterface
                  If   Supports( Unk, IMyInterface, Intf )
                  then Intf.Go;
                  end;

              end;
            end;

          finally
            FreeMem( Properties );
            end;

end;

 [TableName('Record')]
  TMyrecord = class(TPersistent)
  private
    FRecno: TIntEx;
    FName: TStringEx;
  protected
  public
    constructor Create();
    destructor Destoy();
    function GetSqlInsert(): string;
    [SqlFieldName('recno')]
    property Recno: TIntEx read FRecno write FRecno;
    [SqlFieldName('Name')]
    property Name: TStringEx read FName write FName;
  end;

function TMyrecord.GetSqlInsert(): string;

var vCtx: TRttiContext;
    vType: TRttiType;
    vProp: TRttiProperty;
    vAttr: TCustomAttribute;
    vRecord: TValue;
    M : TRttiMethod;
begin
     vType := vCtx.GetType(ClassType);
     For vProp in vType.GetProperties do
       For vAttr in vProp.GetAttributes do
         If vAttr is SqlFieldNameAttribute
         then If   ( vProp.IsReadable ) and
                   ( vProp.IsWritable ) and
                   ( vProp.PropertyType.TypeKind=tkRecord )
              then begin
                   vRecord := vProp.GetValue( Self );
                   M := vProp.PropertyType.GetMethod('GetValue');
                   If   Assigned( M )
                   then begin
                        Result := M.Invoke( vRecord, [] ).ToString;
                        Exit;
                        end;
                   end;
     Result := '';
end;
}

function StringToNumber( Str : String ) : Variant;
begin
     If   Pos( FormatSettings.DecimalSeparator, Str )=0
     then Result := StrToInt( Str )
     else Result := StrToFloat( Str );
end;

(*
public static function EscapeExpressionValues($mySql, &$expression = NULL) {
        if (isset($expression)) {
            if (is_string($expression)) {
                $expression = $mySql->real_escape_string($expression);
            }
            else if (is_array($expression)) {
                foreach ($expression as &$arr_value) {
                    self::EscapeExpressionValues($mySql, $arr_value);
                }
                unset($arr_value);
            }
            else if (gettype($expression) === "object") {
                foreach ($expression as $prop => $value) {
                    self::EscapeExpressionValues($mySql, $expression->$prop);
                }
            }
        }
    }

 function QuoteStringValue( Value : Variant; IsFieldName : Boolean = True ) : String;
 begin
        If   not IsFieldName
           Value := self::_ConvertDateTimeToMySQLValue($value);

        $resultPattern = $isFieldName ? "`%s`" : (is_bool($value) || is_null($value) ? "%s" : "'%s'");
        $stringValue = is_bool($value) ? ($value ? "1" : "0") : (is_null($value) ? self::$NULL_VAL : strval($value));
        $result = sprintf($resultPattern, $stringValue);
        return $result;
    }

 *)

end.
