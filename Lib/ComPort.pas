unit ComPort;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TComPort = class(TObject)
  private
    ComID, ComError: Integer;
    DcbOld: TDCB;
    CommTimeoutsOld: TCommTimeouts;
  protected
  public
    function Open(PortNo: integer): boolean;
    procedure Close;
    function Config(Baudrate: DWORD; ByteSize, StopBits, Parity: Byte): boolean;
    function ReadBlock(var Ch: array of char; BlockSize: dword): integer;
    function ReadChar(var Ch: char): boolean;
    function WriteBlock( Ch: array of char ): boolean;
    function WriteChar(Ch: char): boolean;
    procedure Purge;
    function Error: integer;
    constructor Create;
  published
  end;

const
  cpReadError = 1;
  cpWriteError = 2;
  cpOpenError = 3;

implementation

constructor TComPort.Create;
begin
  inherited Create;
  ComID := -1;
end;

function TComPort.Open(PortNo: integer): boolean;
var
  CommTimeouts: TCommTimeouts;
  Port: string;
begin
  Port := 'COM' + IntToStr(PortNo);
  ComID := CreateFile(pChar(Port), GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_EXISTING, 0, 0);
  if ComID <> -1 then
  begin
    GetCommState(ComID, DcbOld);
    GetCommTimeouts(ComID, CommTimeoutsOld);
    CommTimeouts.ReadIntervalTimeout := 1;
    CommTimeouts.ReadTotalTimeoutMultiplier := 1;
    CommTimeouts.ReadTotalTimeoutConstant := 1;
    CommTimeouts.WriteTotalTimeoutMultiplier := 10;
    CommTimeouts.WriteTotalTimeoutConstant := 10;
    SetCommTimeouts(ComID, CommTimeouts);
    ComError := 0;
  end
  else
    ComError := cpOpenError;
  Result := (ComID <> -1)
end;

procedure TComPort.Close;
begin
  if ComID <> -1 then
  begin
    SetCommState(ComID, DcbOld);
    SetCommTimeouts(ComID, CommTimeoutsOld);
    CloseHandle(ComID);
  end;
  ComID := -1;
end;

function TComPort.Config(Baudrate: DWORD; ByteSize, StopBits, Parity: Byte): boolean;
var
  Dcb: TDCB;
begin
  if ComID <> -1 then
  begin
    GetCommState(ComID, Dcb);
    Dcb.Baudrate := Baudrate;
    Dcb.ByteSize := ByteSize;
    Dcb.StopBits := StopBits;
    Dcb.Parity := Parity;
    SetCommState(ComID, Dcb);
  end
  else
    ComError := cpOpenError;
  Result := (ComID <> -1)
end;

function TComPort.ReadBlock(var Ch: array of char; BlockSize: dword): integer;
var
  rdBlockSize: dword;
begin
  Result := 0;
  if ComID <> -1 then
  begin
    rdBlockSize := BlockSize;
    if not ReadFile(ComID, Ch, BlockSize, rdBlockSize, nil) then
    begin
      GetLastError;
      ComError := cpReadError;
    end
    else
      Result := rdBlockSize;
  end
  else
    ComError := cpOpenError;
end;

function TComPort.ReadChar(var Ch: char): boolean;
var
  BlockSize: dword;
begin
  Result := False;
  if ComID <> -1 then
  begin
    if not ReadFile(ComID, Ch, 1, BlockSize, nil) then
    begin
      GetLastError;
      ComError := cpReadError;
    end
    else
      Result := (BlockSize = 1);
  end
  else
    ComError := cpOpenError;
end;

function TComPort.WriteBlock( Ch: array of char ): boolean;
var
  W: dword;
begin
  Result := False;
  if ComID <> -1 then
  begin
    if not WriteFile(ComID, Ch, SizeOf( Ch ), W, nil) then
    begin
      GetLastError;
      ComError := cpWriteError;
    end
    else
      Result := (SizeOf( Ch ) = W)
  end
  else
    ComError := cpOpenError;
end;

function TComPort.WriteChar(Ch: char): boolean;
var
  W: dword;
begin
  Result := False;
  if ComID <> -1 then
  begin
    if not WriteFile(ComID, Ch, 1, W, nil) then
    begin
      GetLastError;
      ComError := cpWriteError;
    end
    else
      Result := (W = 1)
  end
  else
    ComError := cpOpenError;
end;

procedure TComPort.Purge;
begin
  if ComID <> -1 then
  begin
    PurgeComm(ComID, Purge_TXABORT);
    PurgeComm(ComID, Purge_RXABORT);
    PurgeComm(ComID, Purge_TXCLEAR);
    PurgeComm(ComID, Purge_RXCLEAR);
  end
  else
    ComError := cpOpenError;
end;

function TComPort.Error: integer;
begin
  Result := ComError;
  ComError := 0;
end;

end.
