{##############################################################################}
{# NexusDB: nxllConvertException.pas 4.5009                                  #}
{# Copyright (c) Nexus Database 2003-2018                                     #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB: Exception conversion to TnxResult                                 #}
{##############################################################################}

{$I nxDefine.inc}

unit nxllConvertException;

interface

uses
  nxllBde,
  SysUtils,
  nxllTypes,
  nxllFastMove,
  nxllComponent;

type
  TnxConvertExceptionFunction = function(aException : Exception;
                                     out aErrorCode : TnxResult;
                                     out aMsg       : string)
                                                    : Boolean;

function ConvertException(E : Exception; aLog : TnxBaseLog; aSource: TObject; aVersion: Integer) : TnxResult;

procedure RegisterConverter(aFunction : TnxConvertExceptionFunction);
procedure UnRegisterConverter(aFunction : TnxConvertExceptionFunction);

implementation

uses
  System.Classes,

  nxllConst,
  nxllException,

  JclDebug;  //..

var
  Converters : array of Pointer;

{==============================================================================}
function ConvertException(E : Exception; aLog : TnxBaseLog; aSource: TObject; aVersion: Integer) : TnxResult;
var
  Handled                : Boolean;
  Msg                    : string;
  i                      : Integer;
  nxException            : InxException;
  nxExceptionData        : InxExceptionData;
  ExceptionDataContainer : InxExceptionDataContainer;
  ExceptionData          : string;
  ErrorCategories        : TnxResult;
  Priority               : TnxLogPriority;
  UseNewMarkers          : Boolean;

begin
     try

       If   AVersion=0
       then AVersion := nxGetCurrentThreadNxMinVersion;

       UseNewMarkers := AVersion >= nxVersion41200;

       Msg := '';
       ExceptionData := '';

       //..

       var StackStrings := TStringList.Create;
       var StackMsg := '';
       try
         JclLastExceptStackListToStrings( StackStrings, False, True, True, False);
         StackMsg :=StackStrings.Text;
       finally
         StackStrings.Free;
         end;

       //..

       Handled := False;
       For i := Low(Converters) to High(Converters) do
         begin
         Handled := TnxConvertExceptionFunction(Converters[i])(E, Result, Msg);
         If   Handled
         then Break;
         end;

       If   not Handled
       then If   Supports( E, InxException, nxException)
            then begin
                 If   nxException.ErrorCode = DBIERR_NONE
                 then begin
                 Result := DBIERR_NX_Unknown;
                 Msg := E.Message;
                 end
            else begin
                 Result := nxException.ErrorCode;

                 try    //..
                   var ExceptionHookInfo := nxGetExceptionHookInfo;
                   If   Assigned( ExceptionHookInfo )
                   then Msg := Msg + ' Usuario : ' + ExceptionHookInfo.ehiUserName +
                                     ' Desde : ' + ExceptionHookInfo.ehiConnectedFrom +
                                     ' Cliente : ' + ExceptionHookInfo.ehiClient + ' ';
                 except
                   end;  //..

                 With nxException do
                   If   ExtendedMsg
                   then begin
                        Msg := ErrorString;
                        For i := 0 to Pred( CustomInfos.Count ) do
                          If   UseNewMarkers
                          then Msg := Msg + nxcNewCustomInfoMarkerStart + CustomInfos[i] + nxcNewCustomInfoMarkerEnd
                          else Msg := Msg + nxcOldCustomInfoMarkerStart + CustomInfos[i] + nxcOldCustomInfoMarkerEnd;
                        end;
                 end;

            end
       else If   E is EOSError
            then begin
                 Result := DBIERR_OSUNKNOWN;
                 Msg := E.Message +
                        nxeCustomInfo('OSError', IntToStr(Int64(EOSError(E).ErrorCode))) +
                        nxeCustomInfo('Exception.Class', E.ClassName) +
                        nxeCustomInfo('Exception.Message', E.Message);
                 end
            else If   E is EOutOfMemory
                 then Result := DBIERR_NOMEMORY
                 else begin
                      Result := DBIERR_NX_UnknownExcp;
                      Msg := Format('Excepción inesperada lanzada por el objeto: [%s] %s', [E.ClassName, E.Message]) +
                             nxeCustomInfo('Exception.Class', E.ClassName) +
                             nxeCustomInfo('Exception.Message', E.Message);
                      end;

       If   Supports( aSource, InxExceptionData, nxExceptionData)
       then begin
            ExceptionDataContainer := nxCreateExceptionDataContainer('ExceptionData');
            nxExceptionData.GetExceptionData(ExceptionDataContainer);
            end;

       If   Assigned( ExceptionDataContainer ) and ( ExceptionDataContainer.ValueCount > 0)
       then begin
            If   Msg = ''
            then If   UseNewMarkers
                 then Msg := nxcNewOrgMessageMarker
            else Msg := nxcOldOrgMessageMarker;

            Msg := Msg + nxeCustomInfo('$ExceptionData$', ExceptionDataContainer.Encode(AVersion));
            ExceptionData := ExceptionDataContainer.ToString;
            end;

       EnxBaseException.SetLastConvertedException(Result, Msg);

       Msg := E.Message;
       If   ExceptionData <> ''
       then Msg := Msg + sLineBreak + ExceptionData;

       ErrorCategories := Result AND $FF00;
       Priority := lpWarn;

       case ErrorCategories of
         ERRBASE_OS:
           Priority := lpFatal;
         ERRBASE_DATACORRUPT,
         ERRBASE_VERSION:
           Priority :=  lpError;
         ERRBASE_LOCKCONFLICT:
           Priority := lpInfo;
         ERRBASE_NEXUS:
           case Result of
             DBIERR_NX_GENERALTIMEOUT,
             DBIERR_NX_SQLSIGNAL:
               Priority := lpInfo;
             DBIERR_NX_UNKNOWN,
             DBIERR_NX_UNKNOWNEXCP,
             DBIERR_NX_UNKNOWNMSG:
               Priority := lpError;
           end;
         end;

       Msg := Msg + StackMsg; //..

       If   Assigned( ALog )
       then ALog.WriteString( Format( 'Excepción (Extendida) : %s', [Msg]), Result, Priority);

     except
       end;

end;
{==============================================================================}


{==============================================================================}
procedure RegisterConverter(aFunction : TnxConvertExceptionFunction);
var
  i: Integer;
begin
  for i := Low(Converters) to High(Converters) do
    if Converters[i] = Pointer(@aFunction) then
      Exit;
  SetLength(Converters, Succ(Length(Converters)));
  Converters[High(Converters)] := Pointer(@aFunction);
end;
{==============================================================================}
procedure UnRegisterConverter(aFunction : TnxConvertExceptionFunction);
var
  i: Integer;
begin
  for i := Low(Converters) to High(Converters) do
    if Converters[i] = Pointer(@aFunction) then begin
      if i < High(Converters) then
        nxMove(Converters[i], Converters[i + 1], Pred(High(Converters) - i) * SizeOf(TnxConvertExceptionFunction));
      SetLength(Converters, Pred(Length(Converters)));
      Exit;
    end;
end;
{==============================================================================}

initialization

  // Enable raw mode (default mode uses stack frames which aren't always generated by the compiler)
  Include(JclStackTrackingOptions, stRawMode);
  // Disable stack tracking in dynamically loaded modules (it makes stack tracking code a bit faster)
  Include(JclStackTrackingOptions, stStaticModuleList);
  // Initialize Exception tracking

  JclStartExceptionTracking;

finalization
  JclStopExceptionTracking;

end.


