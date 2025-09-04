{##############################################################################}
{# NexusDB: nxsdFieldMapper.pas 4.7516                                       #}
{# Copyright (c) UnSquashable Pty. Ltd. 2003-2025                             #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB: Field Mappers                                                     #}
{##############################################################################}

{$I nxDefine.inc}

unit nxsdFieldMapper;
{!!! todo: check AnsiChar type vs 1 byte dependency!!!}
{!!! todo: check that nxtInterval is used alongside nxtDateTime!!!}
interface

uses
  SysUtils,
  nxsdTypes,
  nxllTypes,
  nxllFastMove,
  nxllFastFillChar,
  nxsdFmtBcd,
  nxsdDataDictionary,
  nxsdFieldMapperDescriptor,
  nxsdFieldMapperBase,
  nxsdServerEngine;

type
  TnxBooleanMapper = class(TnxBaseFieldMapper)
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    class function ToBoolean(const aSource; var aTarget): TnxResult;

    class function ToInt8(const aSource; var aTarget): TnxResult;
    class function ToInt16(const aSource; var aTarget): TnxResult;
    class function ToInt32(const aSource; var aTarget): TnxResult;
    class function ToInt64(const aSource; var aTarget): TnxResult;

    class function ToByte8(const aSource; var aTarget): TnxResult;
    class function ToWord16(const aSource; var aTarget): TnxResult;
    class function ToWord32(const aSource; var aTarget): TnxResult;

    class function ToSingle(const aSource; var aTarget): TnxResult;
    class function ToDouble(const aSource; var aTarget): TnxResult;
    class function ToExtended(const aSource; var aTarget): TnxResult;

    class function ToCurrency(const aSource; var aTarget): TnxResult;

    class function ToByteArray(const aSource; var aTarget): TnxResult;

    class function ToAnsiChar(const aSource; var aTarget): TnxResult;
    class function ToWideChar(const aSource; var aTarget): TnxResult;

    class function ToNullString(const aSource; var aTarget): TnxResult;
    class function ToShortString(const aSource; var aTarget): TnxResult;
    class function ToWideString(const aSource; var aTarget): TnxResult;
  end;

  TnxInt8Mapper = class(TnxBaseFieldMapper)
  protected {private}
    i8mTargetLength   : Integer;
    i8mTargetUnits    : Integer;
    i8mTargetDecPl    : Integer;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;


    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);

    class function ToBoolean(const aSource; var aTarget): TnxResult;
    class function ToBooleanCheck(const aSource; var aTarget): TnxResult;

    class function ToInt8(const aSource; var aTarget): TnxResult;
    class function ToInt16(const aSource; var aTarget): TnxResult;
    class function ToInt32(const aSource; var aTarget): TnxResult;
    class function ToInt64(const aSource; var aTarget): TnxResult;

    class function ToByte8(const aSource; var aTarget): TnxResult;
    class function ToByteCheck(const aSource; var aTarget): TnxResult;
    class function ToWord16(const aSource; var aTarget): TnxResult;
    class function ToWord16Check(const aSource; var aTarget): TnxResult;
    class function ToWord32(const aSource; var aTarget): TnxResult;
    class function ToWord32Check(const aSource; var aTarget): TnxResult;

    class function ToSingle(const aSource; var aTarget): TnxResult;
    class function ToDouble(const aSource; var aTarget): TnxResult;
    class function ToExtended(const aSource; var aTarget): TnxResult;

    class function ToCurrency(const aSource; var aTarget): TnxResult;
    function ToBcd(const aSource; var aTarget): TnxResult;
    function ToBcdTrunc(const aSource; var aTarget): TnxResult;
    function ToBcdCheck(const aSource; var aTarget): TnxResult;

    class function ToByteArray(const aSource; var aTarget): TnxResult;

    class function ToAnsiChar(const aSource; var aTarget): TnxResult;
    function ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
    function ToWideChar(const aSource; var aTarget): TnxResult;
    function ToWideCharCheck(const aSource; var aTarget): TnxResult;

    function ToNullString(const aSource; var aTarget): TnxResult;
    function ToNullStringCheck(const aSource; var aTarget): TnxResult;
    function ToShortString(const aSource; var aTarget): TnxResult;
    function ToShortStringCheck(const aSource; var aTarget): TnxResult;
    function ToWideString(const aSource; var aTarget): TnxResult;
    function ToWideStringCheck(const aSource; var aTarget): TnxResult;
  end;

  TnxInt16Mapper = class(TnxBaseFieldMapper)
  protected {private}
    i16mTargetLength   : Integer;
    i16mTargetUnits    : Integer;
    i16mTargetDecPl    : Integer;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);

    class function ToBoolean(const aSource; var aTarget): TnxResult;
    class function ToBooleanCheck(const aSource; var aTarget): TnxResult;

    class function ToInt8(const aSource; var aTarget): TnxResult;
    class function ToInt8Check(const aSource; var aTarget): TnxResult;
    class function ToInt16(const aSource; var aTarget): TnxResult;
    class function ToInt32(const aSource; var aTarget): TnxResult;
    class function ToInt64(const aSource; var aTarget): TnxResult;

    class function ToByte8(const aSource; var aTarget): TnxResult;
    class function ToByteCheck(const aSource; var aTarget): TnxResult;
    class function ToWord16(const aSource; var aTarget): TnxResult;
    class function ToWord16Check(const aSource; var aTarget): TnxResult;
    class function ToWord32(const aSource; var aTarget): TnxResult;
    class function ToWord32Check(const aSource; var aTarget): TnxResult;

    class function ToSingle(const aSource; var aTarget): TnxResult;
    class function ToDouble(const aSource; var aTarget): TnxResult;
    class function ToExtended(const aSource; var aTarget): TnxResult;

    class function ToCurrency(const aSource; var aTarget): TnxResult;
    function ToBcd(const aSource; var aTarget): TnxResult;
    function ToBcdTrunc(const aSource; var aTarget): TnxResult;
    function ToBcdCheck(const aSource; var aTarget): TnxResult;

    class function ToByteArray(const aSource; var aTarget): TnxResult;

    function ToAnsiChar(const aSource; var aTarget): TnxResult;
    function ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
    function ToWideChar(const aSource; var aTarget): TnxResult;
    function ToWideCharCheck(const aSource; var aTarget): TnxResult;

    function ToNullString(const aSource; var aTarget): TnxResult;
    function ToNullStringCheck(const aSource; var aTarget): TnxResult;
    function ToShortString(const aSource; var aTarget): TnxResult;
    function ToShortStringCheck(const aSource; var aTarget): TnxResult;
    function ToWideString(const aSource; var aTarget): TnxResult;
    function ToWideStringCheck(const aSource; var aTarget): TnxResult;
  end;

  TnxInt32Mapper = class(TnxBaseFieldMapper)
  protected {private}
    i32mTargetLength   : Integer;
    i32mTargetUnits    : Integer;
    i32mTargetDecPl    : Integer;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);

    class function ToBoolean(const aSource; var aTarget): TnxResult;
    class function ToBooleanCheck(const aSource; var aTarget): TnxResult;

    class function ToInt8(const aSource; var aTarget): TnxResult;
    class function ToInt8Check(const aSource; var aTarget): TnxResult;
    class function ToInt16(const aSource; var aTarget): TnxResult;
    class function ToInt16Check(const aSource; var aTarget): TnxResult;
    class function ToInt32(const aSource; var aTarget): TnxResult;
    class function ToInt64(const aSource; var aTarget): TnxResult;

    class function ToByte8(const aSource; var aTarget): TnxResult;
    class function ToByteCheck(const aSource; var aTarget): TnxResult;
    class function ToWord16(const aSource; var aTarget): TnxResult;
    class function ToWord16Check(const aSource; var aTarget): TnxResult;
    class function ToWord32(const aSource; var aTarget): TnxResult;
    class function ToWord32Check(const aSource; var aTarget): TnxResult;

    class function ToSingle(const aSource; var aTarget): TnxResult;
    class function ToDouble(const aSource; var aTarget): TnxResult;
    class function ToExtended(const aSource; var aTarget): TnxResult;

    class function ToCurrency(const aSource; var aTarget): TnxResult;
    function ToBcd(const aSource; var aTarget): TnxResult;
    function ToBcdTrunc(const aSource; var aTarget): TnxResult;
    function ToBcdCheck(const aSource; var aTarget): TnxResult;

    class function ToByteArray(const aSource; var aTarget): TnxResult;

    function ToAnsiChar(const aSource; var aTarget): TnxResult;
    function ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
    function ToWideChar(const aSource; var aTarget): TnxResult;
    function ToWideCharCheck(const aSource; var aTarget): TnxResult;

    function ToNullString(const aSource; var aTarget): TnxResult;
    function ToNullStringCheck(const aSource; var aTarget): TnxResult;
    function ToShortString(const aSource; var aTarget): TnxResult;
    function ToShortStringCheck(const aSource; var aTarget): TnxResult;
    function ToWideString(const aSource; var aTarget): TnxResult;
    function ToWideStringCheck(const aSource; var aTarget): TnxResult;
    class function ToDateTime(const aSource; var aTarget): TnxResult; //..
  end;

  TnxInt64Mapper = class(TnxBaseFieldMapper)
  protected {private}
    i64mTargetLength   : Integer;
    i64mTargetUnits    : Integer;
    i64mTargetDecPl    : Integer;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);

    class function ToBoolean(const aSource; var aTarget): TnxResult;
    class function ToBooleanCheck(const aSource; var aTarget): TnxResult;

    class function ToInt8(const aSource; var aTarget): TnxResult;
    class function ToInt8Check(const aSource; var aTarget): TnxResult;
    class function ToInt16(const aSource; var aTarget): TnxResult;
    class function ToInt16Check(const aSource; var aTarget): TnxResult;
    class function ToInt32(const aSource; var aTarget): TnxResult;
    class function ToInt32Check(const aSource; var aTarget): TnxResult;
    class function ToInt64(const aSource; var aTarget): TnxResult;

    class function ToByte8(const aSource; var aTarget): TnxResult;
    class function ToByteCheck(const aSource; var aTarget): TnxResult;
    class function ToWord16(const aSource; var aTarget): TnxResult;
    class function ToWord16Check(const aSource; var aTarget): TnxResult;
    class function ToWord32(const aSource; var aTarget): TnxResult;
    class function ToWord32Check(const aSource; var aTarget): TnxResult;

    class function ToSingle(const aSource; var aTarget): TnxResult;
    class function ToDouble(const aSource; var aTarget): TnxResult;
    class function ToExtended(const aSource; var aTarget): TnxResult;

    class function ToCurrency(const aSource; var aTarget): TnxResult;
    class function ToCurrencyCheck(const aSource; var aTarget): TnxResult;
    function ToBcdTrunc(const aSource; var aTarget): TnxResult;
    function ToBcdCheck(const aSource; var aTarget): TnxResult;

    class function ToByteArray(const aSource; var aTarget): TnxResult;

    function ToAnsiChar(const aSource; var aTarget): TnxResult;
    function ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
    function ToWideChar(const aSource; var aTarget): TnxResult;
    function ToWideCharCheck(const aSource; var aTarget): TnxResult;

    function ToNullString(const aSource; var aTarget): TnxResult;
    function ToNullStringCheck(const aSource; var aTarget): TnxResult;
    function ToShortString(const aSource; var aTarget): TnxResult;
    function ToShortStringCheck(const aSource; var aTarget): TnxResult;
    function ToWideString(const aSource; var aTarget): TnxResult;
    function ToWideStringCheck(const aSource; var aTarget): TnxResult;
  end;

  TnxByte8Mapper = class(TnxBaseFieldMapper)
  protected {private}
    b8mTargetLength   : Integer;
    b8mTargetUnits    : Integer;
    b8mTargetDecPl    : Integer;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);

    class function ToBoolean(const aSource; var aTarget): TnxResult;
    class function ToBooleanCheck(const aSource; var aTarget): TnxResult;

    class function ToInt8(const aSource; var aTarget): TnxResult;
    class function ToInt8Check(const aSource; var aTarget): TnxResult;
    class function ToInt16(const aSource; var aTarget): TnxResult;
    class function ToInt32(const aSource; var aTarget): TnxResult;
    class function ToInt64(const aSource; var aTarget): TnxResult;

    class function ToByte8(const aSource; var aTarget): TnxResult;
    class function ToWord16(const aSource; var aTarget): TnxResult;
    class function ToWord32(const aSource; var aTarget): TnxResult;

    class function ToSingle(const aSource; var aTarget): TnxResult;
    class function ToDouble(const aSource; var aTarget): TnxResult;
    class function ToExtended(const aSource; var aTarget): TnxResult;

    class function ToCurrency(const aSource; var aTarget): TnxResult;
    function ToBcd(const aSource; var aTarget): TnxResult;
    function ToBcdTrunc(const aSource; var aTarget): TnxResult;
    function ToBcdCheck(const aSource; var aTarget): TnxResult;

    class function ToByteArray(const aSource; var aTarget): TnxResult;

    function ToAnsiChar(const aSource; var aTarget): TnxResult;
    function ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
    function ToWideChar(const aSource; var aTarget): TnxResult;
    function ToWideCharCheck(const aSource; var aTarget): TnxResult;

    function ToNullString(const aSource; var aTarget): TnxResult;
    function ToNullStringCheck(const aSource; var aTarget): TnxResult;
    function ToShortString(const aSource; var aTarget): TnxResult;
    function ToShortStringCheck(const aSource; var aTarget): TnxResult;
    function ToWideString(const aSource; var aTarget): TnxResult;
    function ToWideStringCheck(const aSource; var aTarget): TnxResult;
  end;

  TnxWord16Mapper = class(TnxBaseFieldMapper)
  protected {private}
    w16mTargetLength   : Integer;
    w16mTargetUnits    : Integer;
    w16mTargetDecPl    : Integer;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);

    class function ToBoolean(const aSource; var aTarget): TnxResult;
    class function ToBooleanCheck(const aSource; var aTarget): TnxResult;

    class function ToInt8(const aSource; var aTarget): TnxResult;
    class function ToInt8Check(const aSource; var aTarget): TnxResult;
    class function ToInt16(const aSource; var aTarget): TnxResult;
    class function ToInt16Check(const aSource; var aTarget): TnxResult;
    class function ToInt32(const aSource; var aTarget): TnxResult;
    class function ToInt64(const aSource; var aTarget): TnxResult;

    class function ToByte8(const aSource; var aTarget): TnxResult;
    class function ToByteCheck(const aSource; var aTarget): TnxResult;
    class function ToWord16(const aSource; var aTarget): TnxResult;
    class function ToWord32(const aSource; var aTarget): TnxResult;

    class function ToSingle(const aSource; var aTarget): TnxResult;
    class function ToDouble(const aSource; var aTarget): TnxResult;
    class function ToExtended(const aSource; var aTarget): TnxResult;

    class function ToCurrency(const aSource; var aTarget): TnxResult;
    function ToBcd(const aSource; var aTarget): TnxResult;
    function ToBcdTrunc(const aSource; var aTarget): TnxResult;
    function ToBcdCheck(const aSource; var aTarget): TnxResult;

    class function ToByteArray(const aSource; var aTarget): TnxResult;

    function ToAnsiChar(const aSource; var aTarget): TnxResult;
    function ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
    function ToWideChar(const aSource; var aTarget): TnxResult;
    function ToWideCharCheck(const aSource; var aTarget): TnxResult;

    function ToNullString(const aSource; var aTarget): TnxResult;
    function ToNullStringCheck(const aSource; var aTarget): TnxResult;
    function ToShortString(const aSource; var aTarget): TnxResult;
    function ToShortStringCheck(const aSource; var aTarget): TnxResult;
    function ToWideString(const aSource; var aTarget): TnxResult;
    function ToWideStringCheck(const aSource; var aTarget): TnxResult;
  end;

  TnxWord32Mapper = class(TnxBaseFieldMapper)
  protected {private}
    w32mTargetLength   : Integer;
    w32mTargetUnits    : Integer;
    w32mTargetDecPl    : Integer;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);

    class function ToBoolean(const aSource; var aTarget): TnxResult;
    class function ToBooleanCheck(const aSource; var aTarget): TnxResult;

    class function ToInt8(const aSource; var aTarget): TnxResult;
    class function ToInt8Check(const aSource; var aTarget): TnxResult;
    class function ToInt16(const aSource; var aTarget): TnxResult;
    class function ToInt16Check(const aSource; var aTarget): TnxResult;
    class function ToInt32(const aSource; var aTarget): TnxResult;
    class function ToInt32Check(const aSource; var aTarget): TnxResult;
    class function ToInt64(const aSource; var aTarget): TnxResult;

    class function ToByte8(const aSource; var aTarget): TnxResult;
    class function ToByteCheck(const aSource; var aTarget): TnxResult;
    class function ToWord16(const aSource; var aTarget): TnxResult;
    class function ToWord16Check(const aSource; var aTarget): TnxResult;
    class function ToWord32(const aSource; var aTarget): TnxResult;

    class function ToSingle(const aSource; var aTarget): TnxResult;
    class function ToDouble(const aSource; var aTarget): TnxResult;
    class function ToExtended(const aSource; var aTarget): TnxResult;

    class function ToCurrency(const aSource; var aTarget): TnxResult;
    function ToBcd(const aSource; var aTarget): TnxResult;
    function ToBcdTrunc(const aSource; var aTarget): TnxResult;
    function ToBcdCheck(const aSource; var aTarget): TnxResult;

    class function ToTime(const aSource; var aTarget): TnxResult;  //..

    class function ToByteArray(const aSource; var aTarget): TnxResult;

    function ToAnsiChar(const aSource; var aTarget): TnxResult;
    function ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
    function ToWideChar(const aSource; var aTarget): TnxResult;
    function ToWideCharCheck(const aSource; var aTarget): TnxResult;

    function ToNullString(const aSource; var aTarget): TnxResult;
    function ToNullStringCheck(const aSource; var aTarget): TnxResult;
    function ToShortString(const aSource; var aTarget): TnxResult;
    function ToShortStringCheck(const aSource; var aTarget): TnxResult;
    function ToWideString(const aSource; var aTarget): TnxResult;
    function ToWideStringCheck(const aSource; var aTarget): TnxResult;
  end;

  TnxSingleMapper = class(TnxBaseFieldMapper)
  protected
    smFormatSettings   : TFormatSettings;
    smTargetLength     : Integer;
    smTargetUnits      : Integer;
    smTargetDecPl      : Integer;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);

    class function ToBoolean(const aSource; var aTarget): TnxResult;
    class function ToBooleanCheck(const aSource; var aTarget): TnxResult;

    class function ToInt8(const aSource; var aTarget): TnxResult;
    class function ToInt8Check(const aSource; var aTarget): TnxResult;
    class function ToInt16(const aSource; var aTarget): TnxResult;
    class function ToInt16Check(const aSource; var aTarget): TnxResult;
    class function ToInt32(const aSource; var aTarget): TnxResult;
    class function ToInt32Check(const aSource; var aTarget): TnxResult;
    class function ToInt64(const aSource; var aTarget): TnxResult;
    class function ToInt64Check(const aSource; var aTarget): TnxResult;

    class function ToByte8(const aSource; var aTarget): TnxResult;
    class function ToByteCheck(const aSource; var aTarget): TnxResult;
    class function ToWord16(const aSource; var aTarget): TnxResult;
    class function ToWord16Check(const aSource; var aTarget): TnxResult;
    class function ToWord32(const aSource; var aTarget): TnxResult;
    class function ToWord32Check(const aSource; var aTarget): TnxResult;

    class function ToSingle(const aSource; var aTarget): TnxResult;
    class function ToDouble(const aSource; var aTarget): TnxResult;
    class function ToExtended(const aSource; var aTarget): TnxResult;

    class function ToCurrency(const aSource; var aTarget): TnxResult;
    class function ToCurrencyCheck(const aSource; var aTarget): TnxResult;
    function ToBcdTrunc(const aSource; var aTarget): TnxResult;
    function ToBcdCheck(const aSource; var aTarget): TnxResult;

    class function ToByteArray(const aSource; var aTarget): TnxResult;

    function ToAnsiChar(const aSource; var aTarget): TnxResult;
    function ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
    function ToWideChar(const aSource; var aTarget): TnxResult;
    function ToWideCharCheck(const aSource; var aTarget): TnxResult;

    function ToNullString(const aSource; var aTarget): TnxResult;
    function ToNullStringCheck(const aSource; var aTarget): TnxResult;
    function ToShortString(const aSource; var aTarget): TnxResult;
    function ToShortStringCheck(const aSource; var aTarget): TnxResult;
    function ToWideString(const aSource; var aTarget): TnxResult;
    function ToWideStringCheck(const aSource; var aTarget): TnxResult;
  end;

  TnxDoubleMapper = class(TnxBaseFieldMapper)
  protected
    dmTargetLength     : Integer;
    dmFormatSettings   : TFormatSettings;
    dmTargetUnits      : Integer;
    dmTargetDecPl      : Integer;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);

    class function ToBoolean(const aSource; var aTarget): TnxResult;
    class function ToBooleanCheck(const aSource; var aTarget): TnxResult;

    class function ToInt8(const aSource; var aTarget): TnxResult;
    class function ToInt8Check(const aSource; var aTarget): TnxResult;
    class function ToInt16(const aSource; var aTarget): TnxResult;
    class function ToInt16Check(const aSource; var aTarget): TnxResult;
    class function ToInt32(const aSource; var aTarget): TnxResult;
    class function ToInt32Check(const aSource; var aTarget): TnxResult;
    class function ToInt64(const aSource; var aTarget): TnxResult;
    class function ToInt64Check(const aSource; var aTarget): TnxResult;

    class function ToByte8(const aSource; var aTarget): TnxResult;
    class function ToByteCheck(const aSource; var aTarget): TnxResult;
    class function ToWord16(const aSource; var aTarget): TnxResult;
    class function ToWord16Check(const aSource; var aTarget): TnxResult;
    class function ToWord32(const aSource; var aTarget): TnxResult;
    class function ToWord32Check(const aSource; var aTarget): TnxResult;

    class function ToSingle(const aSource; var aTarget): TnxResult;
    class function ToSingleCheck(const aSource; var aTarget): TnxResult;
    class function ToDouble(const aSource; var aTarget): TnxResult;
    class function ToExtended(const aSource; var aTarget): TnxResult;

    class function ToCurrency(const aSource; var aTarget): TnxResult;
    class function ToCurrencyCheck(const aSource; var aTarget): TnxResult;
    function ToBcdTrunc(const aSource; var aTarget): TnxResult;
    function ToBcdCheck(const aSource; var aTarget): TnxResult;

    class function ToByteArray(const aSource; var aTarget): TnxResult;

    class function ToDateTime(const aSource; var aTarget): TnxResult;

    function ToAnsiChar(const aSource; var aTarget): TnxResult;
    function ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
    function ToWideChar(const aSource; var aTarget): TnxResult;
    function ToWideCharCheck(const aSource; var aTarget): TnxResult;

    function ToNullString(const aSource; var aTarget): TnxResult;
    function ToNullStringCheck(const aSource; var aTarget): TnxResult;
    function ToShortString(const aSource; var aTarget): TnxResult;
    function ToShortStringCheck(const aSource; var aTarget): TnxResult;
    function ToWideString(const aSource; var aTarget): TnxResult;
    function ToWideStringCheck(const aSource; var aTarget): TnxResult;
  end;

  TnxExtendedMapper = class(TnxBaseFieldMapper)
  protected
    emTargetLength   : Integer;
    emFormatSettings : TFormatSettings;
    emTargetUnits      : Integer;
    emTargetDecPl      : Integer;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);

    class function ToBoolean(const aSource; var aTarget): TnxResult;
    class function ToBooleanCheck(const aSource; var aTarget): TnxResult;

    class function ToInt8(const aSource; var aTarget): TnxResult;
    class function ToInt8Check(const aSource; var aTarget): TnxResult;
    class function ToInt16(const aSource; var aTarget): TnxResult;
    class function ToInt16Check(const aSource; var aTarget): TnxResult;
    class function ToInt32(const aSource; var aTarget): TnxResult;
    class function ToInt32Check(const aSource; var aTarget): TnxResult;
    class function ToInt64(const aSource; var aTarget): TnxResult;
    class function ToInt64Check(const aSource; var aTarget): TnxResult;

    class function ToByte8(const aSource; var aTarget): TnxResult;
    class function ToByteCheck(const aSource; var aTarget): TnxResult;
    class function ToWord16(const aSource; var aTarget): TnxResult;
    class function ToWord16Check(const aSource; var aTarget): TnxResult;
    class function ToWord32(const aSource; var aTarget): TnxResult;
    class function ToWord32Check(const aSource; var aTarget): TnxResult;

    class function ToSingle(const aSource; var aTarget): TnxResult;
    class function ToSingleCheck(const aSource; var aTarget): TnxResult;
    class function ToDouble(const aSource; var aTarget): TnxResult;
    class function ToDoubleCheck(const aSource; var aTarget): TnxResult;
    class function ToExtended(const aSource; var aTarget): TnxResult;

    class function ToCurrency(const aSource; var aTarget): TnxResult;
    class function ToCurrencyCheck(const aSource; var aTarget): TnxResult;
    function ToBcdTrunc(const aSource; var aTarget): TnxResult;
    function ToBcdCheck(const aSource; var aTarget): TnxResult;

    class function ToByteArray(const aSource; var aTarget): TnxResult;

    function ToAnsiChar(const aSource; var aTarget): TnxResult;
    function ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
    function ToWideChar(const aSource; var aTarget): TnxResult;
    function ToWideCharCheck(const aSource; var aTarget): TnxResult;

    function ToNullString(const aSource; var aTarget): TnxResult;
    function ToNullStringCheck(const aSource; var aTarget): TnxResult;
    function ToShortString(const aSource; var aTarget): TnxResult;
    function ToShortStringCheck(const aSource; var aTarget): TnxResult;
    function ToWideString(const aSource; var aTarget): TnxResult;
    function ToWideStringCheck(const aSource; var aTarget): TnxResult;
  end;

  TnxCurrencyMapper = class(TnxBaseFieldMapper)
  protected
    cmTargetLength   : Integer;
    cmFormatSettings : TFormatSettings;
    cmTargetUnits    : Integer;
    cmTargetDecPl    : Integer;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);

    class function ToBoolean(const aSource; var aTarget): TnxResult;
    class function ToBooleanCheck(const aSource; var aTarget): TnxResult;

    class function ToInt8(const aSource; var aTarget): TnxResult;
    class function ToInt8Check(const aSource; var aTarget): TnxResult;
    class function ToInt16(const aSource; var aTarget): TnxResult;
    class function ToInt16Check(const aSource; var aTarget): TnxResult;
    class function ToInt32(const aSource; var aTarget): TnxResult;
    class function ToInt32Check(const aSource; var aTarget): TnxResult;
    class function ToInt64(const aSource; var aTarget): TnxResult;
    class function ToInt64Check(const aSource; var aTarget): TnxResult;

    class function ToByte8(const aSource; var aTarget): TnxResult;
    class function ToByteCheck(const aSource; var aTarget): TnxResult;
    class function ToWord16(const aSource; var aTarget): TnxResult;
    class function ToWord16Check(const aSource; var aTarget): TnxResult;
    class function ToWord32(const aSource; var aTarget): TnxResult;
    class function ToWord32Check(const aSource; var aTarget): TnxResult;

    class function ToSingle(const aSource; var aTarget): TnxResult;
    class function ToSingleCheck(const aSource; var aTarget): TnxResult;
    class function ToDouble(const aSource; var aTarget): TnxResult;
    class function ToDoubleCheck(const aSource; var aTarget): TnxResult;
    class function ToExtended(const aSource; var aTarget): TnxResult;
    class function ToExtendedCheck(const aSource; var aTarget): TnxResult;

    class function ToCurrency(const aSource; var aTarget): TnxResult;
    function ToBcdTrunc(const aSource; var aTarget): TnxResult;
    function ToBcdCheck(const aSource; var aTarget): TnxResult;

    class function ToByteArray(const aSource; var aTarget): TnxResult;

    function ToAnsiChar(const aSource; var aTarget): TnxResult;
    function ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
    function ToWideChar(const aSource; var aTarget): TnxResult;
    function ToWideCharCheck(const aSource; var aTarget): TnxResult;

    function ToNullString(const aSource; var aTarget): TnxResult;
    function ToNullStringCheck(const aSource; var aTarget): TnxResult;
    function ToShortString(const aSource; var aTarget): TnxResult;
    function ToShortStringCheck(const aSource; var aTarget): TnxResult;
    function ToWideString(const aSource; var aTarget): TnxResult;
    function ToWideStringCheck(const aSource; var aTarget): TnxResult;
  end;

  TnxFmtBCDMapper = class(TnxBaseFieldMapper)
  protected
    fbmSourceType           : TnxFieldType;
    fbmSourceLength         : Integer;
    fbmSourceUnits          : Integer;
    fbmSourceDecPl          : Integer;
    fbmSourceFormatSettings : TFormatSettings;

    fbmTargetType           : TnxFieldType;
    fbmTargetLength         : Integer;
    fbmTargetUnits          : Integer;
    fbmTargetDecPl          : Integer;
    fbmTargetFormatSettings : TFormatSettings;

    fbmTargetMaxInt         : Int64;
    fbmTargetMinInt         : Int64;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);

    function FromBcdTrunc(const aSource; var aTarget): TnxResult;
    function FromBcdCheck(const aSource; var aTarget): TnxResult;
    function ToBcdTrunc(const aSource; var aTarget): TnxResult;
    function ToBcdCheck(const aSource; var aTarget): TnxResult;

    function FromFloatTrunc(const aSource; var aTarget): TnxResult;
    function FromFloatCheck(const aSource; var aTarget): TnxResult;
    function ToFloatTrunc(const aSource; var aTarget): TnxResult;
    function ToFloatCheck(const aSource; var aTarget): TnxResult;

    function FromIntegerTrunc(const aSource; var aTarget): TnxResult;
    function FromIntegerCheck(const aSource; var aTarget): TnxResult;
    function ToIntegerTrunc(const aSource; var aTarget): TnxResult;
    function ToIntegerCheck(const aSource; var aTarget): TnxResult;

    function ToFmtBcdCopy(const aSource; var aTarget): TnxResult;
    function ToFmtBcdTrunc(const aSource; var aTarget): TnxResult;
    function ToFmtBcdCheck(const aSource; var aTarget): TnxResult;
  end;


  TnxTimeMapper = class(TnxBaseFieldMapper)
  protected
    tmSourceType      : TnxFieldType;
    tmTargetLength    : Integer;
    tmTargetField     : TnxFieldDescriptor;
    tmFormatSettings  : TFormatSettings;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);

    function ToDate(const aSource; var aTarget): TnxResult;

    class function ToTime(const aSource; var aTarget): TnxResult;

    function ToDateTime(const aSource; var aTarget): TnxResult;

    class function ToByteArray(const aSource; var aTarget): TnxResult;

    function ToNullString(const aSource; var aTarget): TnxResult;
    function ToNullStringCheck(const aSource; var aTarget): TnxResult;
    function ToShortString(const aSource; var aTarget): TnxResult;
    function ToShortStringCheck(const aSource; var aTarget): TnxResult;
    function ToWideString(const aSource; var aTarget): TnxResult;
    function ToWideStringCheck(const aSource; var aTarget): TnxResult;
    class function ToWord32(const aSource; var aTarget): TnxResult; //..
  end;

  TnxDateMapper = class(TnxBaseFieldMapper)
  protected
    dmSourceType      : TnxFieldType;
    dmTargetLength    : Integer;
    dmTargetField     : TnxFieldDescriptor;
    dmFormatSettings  : TFormatSettings;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);

    class function ToDate(const aSource; var aTarget): TnxResult;

    function ToTime(const aSource; var aTarget): TnxResult;

    class function ToDateTime(const aSource; var aTarget): TnxResult;

    class function ToByteArray(const aSource; var aTarget): TnxResult;

    function ToNullString(const aSource; var aTarget): TnxResult;
    function ToNullStringCheck(const aSource; var aTarget): TnxResult;
    function ToShortString(const aSource; var aTarget): TnxResult;
    function ToShortStringCheck(const aSource; var aTarget): TnxResult;
    function ToWideString(const aSource; var aTarget): TnxResult;
    function ToWideStringCheck(const aSource; var aTarget): TnxResult;
  end;

  TnxDateTimeMapper = class(TnxBaseFieldMapper)
  protected
    dtmSourceType     : TnxFieldType;
    dtmTargetLength   : Integer;
    dtmFormatSettings : TFormatSettings;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);

    class function ToDate(const aSource; var aTarget): TnxResult;
    class function ToDateCheck(const aSource; var aTarget): TnxResult;

    class function ToTime(const aSource; var aTarget): TnxResult;
    class function ToTimeCheck(const aSource; var aTarget): TnxResult;

    class function ToDateTime(const aSource; var aTarget): TnxResult;

    class function ToDouble(const aSource; var aTarget): TnxResult;

    class function ToByteArray(const aSource; var aTarget): TnxResult;

    function ToNullString(const aSource; var aTarget): TnxResult;
    function ToNullStringCheck(const aSource; var aTarget): TnxResult;
    function ToShortString(const aSource; var aTarget): TnxResult;
    function ToShortStringCheck(const aSource; var aTarget): TnxResult;
    function ToWideString(const aSource; var aTarget): TnxResult;
    function ToWideStringCheck(const aSource; var aTarget): TnxResult;
  end;

  TnxGuidMapper = class(TnxBaseFieldMapper)
  protected
    gmTargetLength   : Integer;
    gmFormatSettings : TFormatSettings;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    class function ToGuid(const aSource; var aTarget): TnxResult;
    class function ToByteArray(const aSource; var aTarget): TnxResult;

    class function ToNullString(const aSource; var aTarget): TnxResult;
    class function ToShortString(const aSource; var aTarget): TnxResult;
    class function ToWideString(const aSource; var aTarget): TnxResult;
  end;


  TnxShortStringToShortStringMapper = class(TnxBaseFieldMapper)
  protected {private}
    stsTargetLength   : Integer;

    stsSourceCodepage : Word;
    stsTargetCodepage : Word;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    function ToShortStringExpand(const aSource; var aTarget): TnxResult;
    {-- target has same or higher number of characters/bytes and same codepage}
    function ToShortStringTrunc(const aSource; var aTarget): TnxResult;
    {-- target has lower number of characters and same SBCS codepage}
    function ToShortStringTruncCheck(const aSource; var aTarget): TnxResult;
    {-- target has lower number of characters and same codepage}

    function ToShortStringConvert(const aSource; var aTarget): TnxResult;
    {-- target requires codepage translation or truncation of the same MBCS}
    function ToShortStringConvertCheck(const aSource; var aTarget): TnxResult;
    {-- target requires codepage translation}

    function ToShortStringExpandPadding(const aSource; var aTarget): TnxResult;
    {-- target has same or higher number of characters/bytes and same codepage, removes padding}
    function ToShortStringTruncPadding(const aSource; var aTarget): TnxResult;
    {-- target has lower number of characters and same SBCS codepage, removes padding}
    function ToShortStringTruncCheckPadding(const aSource; var aTarget): TnxResult;
    {-- target has lower number of characters and same codepage, removes padding}

    function ToShortStringConvertPadding(const aSource; var aTarget): TnxResult;
    {-- target requires codepage translation or truncation of the same MBCS, removes padding}
    function ToShortStringConvertCheckPadding(const aSource; var aTarget): TnxResult;
    {-- target requires codepage translation, removes padding}
  public
    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);
  end;

  TnxShortStringToNullStringMapper = class(TnxBaseFieldMapper)
  protected {private}
    stnTargetLength   : Integer;

    stnSourceCodepage : Word;
    stnTargetCodepage : Word;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);

    function ToNullString(const aSource; var aTarget): TnxResult;
    {-- target has same codepage}
    function ToNullStringTruncCheck(const aSource; var aTarget): TnxResult;
    {-- target has lower number of characters and same codepage}

    function ToNullStringConvert(const aSource; var aTarget): TnxResult;
    {-- target requires codepage translation or truncation of the same MBCS}
    function ToNullStringConvertCheck(const aSource; var aTarget): TnxResult;
    {-- target requires codepage translation}

    function ToNullStringPadding(const aSource; var aTarget): TnxResult;
    {-- target has same codepage, removes padding}
    function ToNullStringTruncCheckPadding(const aSource; var aTarget): TnxResult;
    {-- target has lower number of characters and same codepage, removes padding}

    function ToNullStringConvertPadding(const aSource; var aTarget): TnxResult;
    {-- target requires codepage translation or truncation of the same MBCS, removes padding}
    function ToNullStringConvertCheckPadding(const aSource; var aTarget): TnxResult;
    {-- target requires codepage translation, removes padding}
  end;

  TnxNullStringToNullStringMapper = class(TnxBaseFieldMapper)
  protected {private}
    ntnTargetLength   : Integer;

    ntnSourceCodepage : Word;
    ntnTargetCodepage : Word;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    function ToNullString(const aSource; var aTarget): TnxResult;
    {-- target has same codepage}
    function ToNullStringTruncCheck(const aSource; var aTarget): TnxResult;
    {-- target has lower number of characters and same codepage}

    function ToNullStringConvert(const aSource; var aTarget): TnxResult;
    {-- target requires codepage translation or truncation of the same MBCS}
    function ToNullStringConvertCheck(const aSource; var aTarget): TnxResult;
    {-- target requires codepage translation}

    function ToNullStringPadding(const aSource; var aTarget): TnxResult;
    {-- target has same codepage, removes padding}
    function ToNullStringTruncCheckPadding(const aSource; var aTarget): TnxResult;
    {-- target has lower number of characters and same codepage, removes padding}

    function ToNullStringConvertPadding(const aSource; var aTarget): TnxResult;
    {-- target requires codepage translation or truncation of the same MBCS, removes padding}
    function ToNullStringConvertCheckPadding(const aSource; var aTarget): TnxResult;
    {-- target requires codepage translation, removes padding}

  public  
    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);

  end;

  TnxNullStringToShortStringMapper = class(TnxBaseFieldMapper)
  protected {private}
    ntsTargetLength   : Integer;

    ntsSourceCodepage : Word;
    ntsTargetCodepage : Word;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);

    function ToShortString(const aSource; var aTarget): TnxResult;
    {-- target has same codepage}
    function ToShortStringTruncCheck(const aSource; var aTarget): TnxResult;
    {-- target has lower number of characters and same codepage}

    function ToShortStringConvert(const aSource; var aTarget): TnxResult;
    {-- target requires codepage translation or truncation of the same MBCS}
    function ToShortStringConvertCheck(const aSource; var aTarget): TnxResult;
    {-- target requires codepage translation}

    function ToShortStringPadding(const aSource; var aTarget): TnxResult;
    {-- target has same codepage, removes padding}
    function ToShortStringTruncCheckPadding(const aSource; var aTarget): TnxResult;
    {-- target has lower number of characters and same codepage, removes padding}

    function ToShortStringConvertPadding(const aSource; var aTarget): TnxResult;
    {-- target requires codepage translation or truncation of the same MBCS, removes padding}
    function ToShortStringConvertCheckPadding(const aSource; var aTarget): TnxResult;
    {-- target requires codepage translation, removes padding}
  end;

  TnxWideStringToAnsiStringMapper = class(TnxBaseFieldMapper)
  protected {private}
    wtaTargetLength   : Integer;
    wtaTargetCodepage : Word;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    function ToShortStringConvert(const aSource; var aTarget): TnxResult;
    function ToShortStringConvertCheck(const aSource; var aTarget): TnxResult;

    function ToNullStringConvert(const aSource; var aTarget): TnxResult;
    function ToNullStringConvertCheck(const aSource; var aTarget): TnxResult;

    function ToShortStringConvertPadding(const aSource; var aTarget): TnxResult;
    function ToShortStringConvertCheckPadding(const aSource; var aTarget): TnxResult;

    function ToNullStringConvertPadding(const aSource; var aTarget): TnxResult;
    function ToNullStringConvertCheckPadding(const aSource; var aTarget): TnxResult;
  public
    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);
  end;

  TnxAnsiStringToWideStringMapper = class(TnxBaseFieldMapper)
  protected {private}
    atwTargetLength   : Integer;
    atwSourceCodepage : Word;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    function FromShortStringConvert(const aSource; var aTarget): TnxResult;
    function FromShortStringConvertCheck(const aSource; var aTarget): TnxResult;

    function FromNullStringConvert(const aSource; var aTarget): TnxResult;
    function FromNullStringConvertCheck(const aSource; var aTarget): TnxResult;

    function FromShortStringConvertPadding(const aSource; var aTarget): TnxResult;
    function FromShortStringConvertCheckPadding(const aSource; var aTarget): TnxResult;

    function FromNullStringConvertPadding(const aSource; var aTarget): TnxResult;
    function FromNullStringConvertCheckPadding(const aSource; var aTarget): TnxResult;

  public
    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);
  end;

  TnxWideStringToWideStringMapper = class(TnxBaseFieldMapper)
  protected {private}
    wtwTargetLength   : Integer;
    wtwTargetUnits    : Integer;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    class function ToWideString(const aSource; var aTarget): TnxResult;
    function ToWideStringCheck(const aSource; var aTarget): TnxResult;
    function ToWideStringTrunc(const aSource; var aTarget): TnxResult;

    class function ToWideStringPadding(const aSource; var aTarget): TnxResult;
    function ToWideStringCheckPadding(const aSource; var aTarget): TnxResult;
    function ToWideStringTruncPadding(const aSource; var aTarget): TnxResult;
  public
    constructor Create(aSourceField : TnxFieldDescriptor;
                       aTargetField : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper      : TnxMappingMethod);
  end;

  TnxCharMapper = class(TnxBaseFieldMapper)
  protected {private}
    ccTargetLength       : Integer;

    ccSourceCodepage     : Word;
    ccTargetCodepage     : Word;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField  : TnxFieldDescriptor;
                       aTargetField  : TnxFieldDescriptor;
                       aMapperDesc   : TnxFieldMapperDescriptor;
                   out aMapper       : TnxMappingMethod);

    class function ToBoolean(const aSource; var aTarget): TnxResult;
    class function ToBooleanCheck(const aSource; var aTarget): TnxResult;

    class function ToInt8(const aSource; var aTarget): TnxResult;
    class function ToInt8Check(const aSource; var aTarget): TnxResult;
    class function ToInt16(const aSource; var aTarget): TnxResult;
    class function ToInt16Check(const aSource; var aTarget): TnxResult;
    class function ToInt32(const aSource; var aTarget): TnxResult;
    class function ToInt32Check(const aSource; var aTarget): TnxResult;
    class function ToInt64(const aSource; var aTarget): TnxResult;
    class function ToInt64Check(const aSource; var aTarget): TnxResult;

    class function ToByte8(const aSource; var aTarget): TnxResult;
    class function ToByteCheck(const aSource; var aTarget): TnxResult;
    class function ToWord16(const aSource; var aTarget): TnxResult;
    class function ToWord16Check(const aSource; var aTarget): TnxResult;
    class function ToWord32(const aSource; var aTarget): TnxResult;
    class function ToWord32Check(const aSource; var aTarget): TnxResult;

    class function ToSingle(const aSource; var aTarget): TnxResult;
    class function ToSingleCheck(const aSource; var aTarget): TnxResult;
    class function ToDouble(const aSource; var aTarget): TnxResult;
    class function ToDoubleCheck(const aSource; var aTarget): TnxResult;
    class function ToExtended(const aSource; var aTarget): TnxResult;
    class function ToExtendedCheck(const aSource; var aTarget): TnxResult;

    class function ToCurrency(const aSource; var aTarget): TnxResult;
    class function ToCurrencyCheck(const aSource; var aTarget): TnxResult;

    class function ToByteArray(const aSource; var aTarget): TnxResult;

    class function ToAnsiChar(const aSource; var aTarget): TnxResult;
    function ToAnsiCharConvert(const aSource; var aTarget): TnxResult;
    function ToWideCharConvert(const aSource; var aTarget): TnxResult;
    function ToWideCharConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToShortString(const aSource; var aTarget): TnxResult;
    function ToShortStringConvert(const aSource; var aTarget): TnxResult;
    function ToShortStringConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToNullString(const aSource; var aTarget): TnxResult;
    function ToNullStringConvert(const aSource; var aTarget): TnxResult;
    function ToNullStringConvertCheck(const aSource; var aTarget): TnxResult;

    function ToWideStringConvert(const aSource; var aTarget): TnxResult;
    function ToWideStringConvertCheck(const aSource; var aTarget): TnxResult;
  end;

  TnxWideCharMapper = class(TnxBaseFieldMapper)
  protected {private}
    wccTargetLength       : Integer;

    wccSourceCodepage     : Word;
    wccTargetCodepage     : Word;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField  : TnxFieldDescriptor;
                       aTargetField  : TnxFieldDescriptor;
                       aMapperDesc  : TnxFieldMapperDescriptor;
                   out aMapper       : TnxMappingMethod);

    class function ToBoolean(const aSource; var aTarget): TnxResult;
    class function ToBooleanCheck(const aSource; var aTarget): TnxResult;

    class function ToInt8(const aSource; var aTarget): TnxResult;
    class function ToInt8Check(const aSource; var aTarget): TnxResult;
    class function ToInt16(const aSource; var aTarget): TnxResult;
    class function ToInt16Check(const aSource; var aTarget): TnxResult;
    class function ToInt32(const aSource; var aTarget): TnxResult;
    class function ToInt32Check(const aSource; var aTarget): TnxResult;
    class function ToInt64(const aSource; var aTarget): TnxResult;
    class function ToInt64Check(const aSource; var aTarget): TnxResult;

    class function ToByte8(const aSource; var aTarget): TnxResult;
    class function ToByteCheck(const aSource; var aTarget): TnxResult;
    class function ToWord16(const aSource; var aTarget): TnxResult;
    class function ToWord16Check(const aSource; var aTarget): TnxResult;
    class function ToWord32(const aSource; var aTarget): TnxResult;
    class function ToWord32Check(const aSource; var aTarget): TnxResult;

    class function ToSingle(const aSource; var aTarget): TnxResult;
    class function ToSingleCheck(const aSource; var aTarget): TnxResult;
    class function ToDouble(const aSource; var aTarget): TnxResult;
    class function ToDoubleCheck(const aSource; var aTarget): TnxResult;
    class function ToExtended(const aSource; var aTarget): TnxResult;
    class function ToExtendedCheck(const aSource; var aTarget): TnxResult;

    class function ToCurrency(const aSource; var aTarget): TnxResult;
    class function ToCurrencyCheck(const aSource; var aTarget): TnxResult;

    class function ToByteArray(const aSource; var aTarget): TnxResult;

    function ToAnsiCharConvert(const aSource; var aTarget): TnxResult;
    class function ToWideChar(const aSource; var aTarget): TnxResult;

    function ToShortStringConvert(const aSource; var aTarget): TnxResult;
    function ToShortStringConvertCheck(const aSource; var aTarget): TnxResult;

    function ToNullStringConvert(const aSource; var aTarget): TnxResult;
    function ToNullStringConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToWideString(const aSource; var aTarget): TnxResult;
  end;

  TnxShortStringMapper = class(TnxBaseFieldMapper)
  protected {private}
    ssmFormatSettings    : TFormatSettings;
    ssmSourceLength      : Integer;
    ssmTargetLength      : Integer;
    ssmSourceCodepage    : Word;
    ssmTargetCodepage    : Word;
    ssmTargetUnits       : Integer;
    ssmTargetDecPl       : Integer;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField  : TnxFieldDescriptor;
                       aTargetField  : TnxFieldDescriptor;
                       aMapperDesc   : TnxFieldMapperDescriptor;
                   out aMapper       : TnxMappingMethod);

    class function ToBoolean(const aSource; var aTarget): TnxResult;
    class function ToBooleanCheck(const aSource; var aTarget): TnxResult;
    function ToBooleanConvert(const aSource; var aTarget): TnxResult;
    function ToBooleanConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToInt8(const aSource; var aTarget): TnxResult;
    class function ToInt8Check(const aSource; var aTarget): TnxResult;
    function ToInt8Convert(const aSource; var aTarget): TnxResult;
    function ToInt8ConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToInt16(const aSource; var aTarget): TnxResult;
    class function ToInt16Check(const aSource; var aTarget): TnxResult;
    function ToInt16Convert(const aSource; var aTarget): TnxResult;
    function ToInt16ConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToInt32(const aSource; var aTarget): TnxResult;
    class function ToInt32Check(const aSource; var aTarget): TnxResult;
    function ToInt32Convert(const aSource; var aTarget): TnxResult;
    function ToInt32ConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToInt64(const aSource; var aTarget): TnxResult;
    class function ToInt64Check(const aSource; var aTarget): TnxResult;
    function ToInt64Convert(const aSource; var aTarget): TnxResult;
    function ToInt64ConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToByte8(const aSource; var aTarget): TnxResult;
    class function ToByteCheck(const aSource; var aTarget): TnxResult;
    function ToByteConvert(const aSource; var aTarget): TnxResult;
    function ToByteConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToWord16(const aSource; var aTarget): TnxResult;
    class function ToWord16Check(const aSource; var aTarget): TnxResult;
    function ToWord16Convert(const aSource; var aTarget): TnxResult;
    function ToWord16ConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToWord32(const aSource; var aTarget): TnxResult;
    class function ToWord32Check(const aSource; var aTarget): TnxResult;
    function ToWord32Convert(const aSource; var aTarget): TnxResult;
    function ToWord32ConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToSingle(const aSource; var aTarget): TnxResult;
    class function ToSingleCheck(const aSource; var aTarget): TnxResult;
    function ToSingleConvert(const aSource; var aTarget): TnxResult;
    function ToSingleConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToDouble(const aSource; var aTarget): TnxResult;
    class function ToDoubleCheck(const aSource; var aTarget): TnxResult;
    function ToDoubleConvert(const aSource; var aTarget): TnxResult;
    function ToDoubleConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToExtended(const aSource; var aTarget): TnxResult;
    class function ToExtendedCheck(const aSource; var aTarget): TnxResult;
    function ToExtendedConvert(const aSource; var aTarget): TnxResult;
    function ToExtendedConvertCheck(const aSource; var aTarget): TnxResult;

    function ToCurrency(const aSource; var aTarget): TnxResult;
    function ToCurrencyCheck(const aSource; var aTarget): TnxResult;
    function ToCurrencyConvert(const aSource; var aTarget): TnxResult;
    function ToCurrencyConvertCheck(const aSource; var aTarget): TnxResult;

    function ToBcd(const aSource; var aTarget): TnxResult;
    function ToBcdCheck(const aSource; var aTarget): TnxResult;
    function ToBcdConvert(const aSource; var aTarget): TnxResult;
    function ToBcdConvertCheck(const aSource; var aTarget): TnxResult;

    function ToDate(const aSource; var aTarget): TnxResult;
    function ToDateCheck(const aSource; var aTarget): TnxResult;
    function ToDateConvert(const aSource; var aTarget): TnxResult;
    function ToDateConvertCheck(const aSource; var aTarget): TnxResult;

    function ToTime(const aSource; var aTarget): TnxResult;
    function ToTimeCheck(const aSource; var aTarget): TnxResult;
    function ToTimeConvert(const aSource; var aTarget): TnxResult;
    function ToTimeConvertCheck(const aSource; var aTarget): TnxResult;

    function ToDateTime(const aSource; var aTarget): TnxResult;
    function ToDateTimeCheck(const aSource; var aTarget): TnxResult;
    function ToDateTimeConvert(const aSource; var aTarget): TnxResult;
    function ToDateTimeConvertCheck(const aSource; var aTarget): TnxResult;

    function ToByteArray(const aSource; var aTarget): TnxResult;
    function ToByteArrayCheck(const aSource; var aTarget): TnxResult;

    class function ToGuid(const aSource; var aTarget): TnxResult;
    class function ToGuidCheck(const aSource; var aTarget): TnxResult;
    function ToGuidConvert(const aSource; var aTarget): TnxResult;
    function ToGuidConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToAnsiChar(const aSource; var aTarget): TnxResult;
    function ToAnsiCharConvert(const aSource; var aTarget): TnxResult;

    function ToWideCharConvert(const aSource; var aTarget): TnxResult;
  end;

  TnxNullStringMapper = class(TnxBaseFieldMapper)
  protected {private}
    nsmFormatSettings    : TFormatSettings;
    nsmSourceLength      : Integer;
    nsmTargetLength      : Integer;
    nsmSourceCodepage    : Word;
    nsmTargetCodepage    : Word;
    nsmTargetUnits       : Integer;
    nsmTargetDecPl       : Integer;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField  : TnxFieldDescriptor;
                       aTargetField  : TnxFieldDescriptor;
                       aMapperDesc   : TnxFieldMapperDescriptor;
                   out aMapper       : TnxMappingMethod);

    class function ToBoolean(const aSource; var aTarget): TnxResult;
    class function ToBooleanCheck(const aSource; var aTarget): TnxResult;
    function ToBooleanConvert(const aSource; var aTarget): TnxResult;
    function ToBooleanConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToInt8(const aSource; var aTarget): TnxResult;
    class function ToInt8Check(const aSource; var aTarget): TnxResult;
    function ToInt8Convert(const aSource; var aTarget): TnxResult;
    function ToInt8ConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToInt16(const aSource; var aTarget): TnxResult;
    class function ToInt16Check(const aSource; var aTarget): TnxResult;
    function ToInt16Convert(const aSource; var aTarget): TnxResult;
    function ToInt16ConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToInt32(const aSource; var aTarget): TnxResult;
    class function ToInt32Check(const aSource; var aTarget): TnxResult;
    function ToInt32Convert(const aSource; var aTarget): TnxResult;
    function ToInt32ConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToInt64(const aSource; var aTarget): TnxResult;
    class function ToInt64Check(const aSource; var aTarget): TnxResult;
    function ToInt64Convert(const aSource; var aTarget): TnxResult;
    function ToInt64ConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToByte8(const aSource; var aTarget): TnxResult;
    class function ToByteCheck(const aSource; var aTarget): TnxResult;
    function ToByteConvert(const aSource; var aTarget): TnxResult;
    function ToByteConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToWord16(const aSource; var aTarget): TnxResult;
    class function ToWord16Check(const aSource; var aTarget): TnxResult;
    function ToWord16Convert(const aSource; var aTarget): TnxResult;
    function ToWord16ConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToWord32(const aSource; var aTarget): TnxResult;
    class function ToWord32Check(const aSource; var aTarget): TnxResult;
    function ToWord32Convert(const aSource; var aTarget): TnxResult;
    function ToWord32ConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToSingle(const aSource; var aTarget): TnxResult;
    class function ToSingleCheck(const aSource; var aTarget): TnxResult;
    function ToSingleConvert(const aSource; var aTarget): TnxResult;
    function ToSingleConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToDouble(const aSource; var aTarget): TnxResult;
    class function ToDoubleCheck(const aSource; var aTarget): TnxResult;
    function ToDoubleConvert(const aSource; var aTarget): TnxResult;
    function ToDoubleConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToExtended(const aSource; var aTarget): TnxResult;
    class function ToExtendedCheck(const aSource; var aTarget): TnxResult;
    function ToExtendedConvert(const aSource; var aTarget): TnxResult;
    function ToExtendedConvertCheck(const aSource; var aTarget): TnxResult;

    function ToCurrency(const aSource; var aTarget): TnxResult;
    function ToCurrencyCheck(const aSource; var aTarget): TnxResult;
    function ToCurrencyConvert(const aSource; var aTarget): TnxResult;
    function ToCurrencyConvertCheck(const aSource; var aTarget): TnxResult;

    function ToBcd(const aSource; var aTarget): TnxResult;
    function ToBcdCheck(const aSource; var aTarget): TnxResult;
    function ToBcdConvert(const aSource; var aTarget): TnxResult;
    function ToBcdConvertCheck(const aSource; var aTarget): TnxResult;

    function ToDate(const aSource; var aTarget): TnxResult;
    function ToDateCheck(const aSource; var aTarget): TnxResult;
    function ToDateConvert(const aSource; var aTarget): TnxResult;
    function ToDateConvertCheck(const aSource; var aTarget): TnxResult;

    function ToTime(const aSource; var aTarget): TnxResult;
    function ToTimeCheck(const aSource; var aTarget): TnxResult;
    function ToTimeConvert(const aSource; var aTarget): TnxResult;
    function ToTimeConvertCheck(const aSource; var aTarget): TnxResult;

    function ToDateTime(const aSource; var aTarget): TnxResult;
    function ToDateTimeCheck(const aSource; var aTarget): TnxResult;
    function ToDateTimeConvert(const aSource; var aTarget): TnxResult;
    function ToDateTimeConvertCheck(const aSource; var aTarget): TnxResult;

    function ToByteArray(const aSource; var aTarget): TnxResult;
    function ToByteArrayCheck(const aSource; var aTarget): TnxResult;

    class function ToGuid(const aSource; var aTarget): TnxResult;
    class function ToGuidCheck(const aSource; var aTarget): TnxResult;
    function ToGuidConvert(const aSource; var aTarget): TnxResult;
    function ToGuidConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToAnsiChar(const aSource; var aTarget): TnxResult;
    function ToAnsiCharConvert(const aSource; var aTarget): TnxResult;

    function ToWideCharConvert(const aSource; var aTarget): TnxResult;
  end;

  TnxWideStringMapper = class(TnxBaseFieldMapper)
  protected {private}
    wsmFormatSettings    : TFormatSettings;
    wsmSourceLength      : Integer;
    wsmTargetLength      : Integer;
    wsmTargetCodepage    : Word;
    wsmMaxCharSize       : Integer;
    wsmTargetUnits       : Integer;
    wsmTargetDecPl       : Integer;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField  : TnxFieldDescriptor;
                       aTargetField  : TnxFieldDescriptor;
                       aMapperDesc   : TnxFieldMapperDescriptor;
                   out aMapper       : TnxMappingMethod);

    class function ToBoolean(const aSource; var aTarget): TnxResult;
    class function ToBooleanCheck(const aSource; var aTarget): TnxResult;

    class function ToInt8(const aSource; var aTarget): TnxResult;
    class function ToInt8Check(const aSource; var aTarget): TnxResult;

    class function ToInt16(const aSource; var aTarget): TnxResult;
    class function ToInt16Check(const aSource; var aTarget): TnxResult;

    class function ToInt32(const aSource; var aTarget): TnxResult;
    class function ToInt32Check(const aSource; var aTarget): TnxResult;

    class function ToInt64(const aSource; var aTarget): TnxResult;
    class function ToInt64Check(const aSource; var aTarget): TnxResult;

    class function ToByte8(const aSource; var aTarget): TnxResult;
    class function ToByteCheck(const aSource; var aTarget): TnxResult;

    class function ToWord16(const aSource; var aTarget): TnxResult;
    class function ToWord16Check(const aSource; var aTarget): TnxResult;

    class function ToWord32(const aSource; var aTarget): TnxResult;
    class function ToWord32Check(const aSource; var aTarget): TnxResult;

    class function ToSingle(const aSource; var aTarget): TnxResult;
    class function ToSingleCheck(const aSource; var aTarget): TnxResult;

    class function ToDouble(const aSource; var aTarget): TnxResult;
    class function ToDoubleCheck(const aSource; var aTarget): TnxResult;

    class function ToExtended(const aSource; var aTarget): TnxResult;
    class function ToExtendedCheck(const aSource; var aTarget): TnxResult;

    class function ToCurrency(const aSource; var aTarget): TnxResult;
    class function ToCurrencyCheck(const aSource; var aTarget): TnxResult;

    function ToBcd(const aSource; var aTarget): TnxResult;
    function ToBcdCheck(const aSource; var aTarget): TnxResult;

    function ToDate(const aSource; var aTarget): TnxResult;
    function ToDateCheck(const aSource; var aTarget): TnxResult;

    function ToTime(const aSource; var aTarget): TnxResult;
    function ToTimeCheck(const aSource; var aTarget): TnxResult;

    function ToDateTime(const aSource; var aTarget): TnxResult;
    function ToDateTimeCheck(const aSource; var aTarget): TnxResult;

    function ToByteArray(const aSource; var aTarget): TnxResult;
    function ToByteArrayCheck(const aSource; var aTarget): TnxResult;

    class function ToGuid(const aSource; var aTarget): TnxResult;
    class function ToGuidCheck(const aSource; var aTarget): TnxResult;

    function ToAnsiChar(const aSource; var aTarget): TnxResult;
    function ToAnsiCharConvert(const aSource; var aTarget): TnxResult;
    function ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
    function ToAnsiCharConvertCheck(const aSource; var aTarget): TnxResult;

    class function ToWideChar(const aSource; var aTarget): TnxResult;
    class function ToWideCharCheck(const aSource; var aTarget): TnxResult;
  end;

  TnxByteArrayMapper = class(TnxBaseFieldMapper)
  protected {private}
    bamFormatSettings    : TFormatSettings;
    bamSourceLength      : Integer;
    bamTargetLength      : Integer;
    bamSourceCodepage    : Word;
    bamTargetCodepage    : Word;
  protected
    class function InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                        aSourceCursor : TnxAbstractCursor;
                                        aTargetField  : TnxFieldDescriptor;
                                        aTargetCursor : TnxAbstractCursor;
                                        aMapperDesc   : TnxFieldMapperDescriptor;
                                    out aMapper       : TnxMappingMethod)
                                                      : TnxBaseFieldMapper; override;

    constructor Create(aSourceField  : TnxFieldDescriptor;
                       aTargetField  : TnxFieldDescriptor;
                       aMapperDesc   : TnxFieldMapperDescriptor;
                   out aMapper       : TnxMappingMethod);

    function ToByteArray(const aSource; var aTarget): TnxResult;

    function ToGuid(const aSource; var aTarget): TnxResult;

    function ToNullString(const aSource; var aTarget): TnxResult;
    {-- target has same codepage}

    function ToNullStringConvert(const aSource; var aTarget): TnxResult;
    {-- target requires codepage translation or truncation of the same MBCS}
    function ToNullStringConvertCheck(const aSource; var aTarget): TnxResult;
    {-- target requires codepage translation}

    function ToShortString(const aSource; var aTarget): TnxResult;
    {-- target has same codepage}

    function ToShortStringConvert(const aSource; var aTarget): TnxResult;
    {-- target requires codepage translation or truncation of the same MBCS}
    function ToShortStringConvertCheck(const aSource; var aTarget): TnxResult;
    {-- target requires codepage translation}

    function ToWideString(const aSource; var aTarget): TnxResult;
    function ToWideStringCheck(const aSource; var aTarget): TnxResult;
  end;

implementation

uses
  Windows,
  ActiveX, // must be above Variants!!!
  FmtBCD,
  Math,
  nxllConst,
  nxllBde,
  nxllUtils;


function CLSIDFromString(psz: PWideChar; out clsid: TGUID): HResult; stdcall;
  external 'ole32.dll' name 'CLSIDFromString';

const
  LowCurrency64         = -922337203685477;
  HighCurrency64        =  922337203685477;

{===TnxBooleanMapper===========================================================}
class function TnxBooleanMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                                     aSourceCursor : TnxAbstractCursor;
                                                     aTargetField  : TnxFieldDescriptor;
                                                     aTargetCursor : TnxAbstractCursor;
                                                     aMapperDesc   : TnxFieldMapperDescriptor;
                                                 out aMapper       : TnxMappingMethod)
                                                                   : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  if (aSourceField.fdType = nxtBoolean) and
     (aTargetField.fdLength>=1) then
    case aTargetField.fdType of
      nxtBoolean     : aMapper := ToBoolean;
      nxtInt8        : aMapper := ToInt8;
      nxtInt16       : aMapper := ToInt16;
      nxtInt32       : aMapper := ToInt32;
      nxtInt64       : aMapper := ToInt64;
      nxtByte        : aMapper := ToByte8;
      nxtWord16      : aMapper := ToWord16;
      nxtWord32,
      nxtAutoInc,
      nxtRecRev      : aMapper := ToWord32;
      nxtSingle      : aMapper := ToSingle;
      nxtDouble      : aMapper := ToDouble;
      nxtExtended    : aMapper := ToExtended;
      nxtCurrency,
      nxtBCD         : aMapper := ToCurrency;
      nxtByteArray   : aMapper := ToByteArray;
      nxtChar        : aMapper := ToAnsiChar;
      nxtWideChar    : aMapper := ToWideChar;
      nxtNullString  : aMapper := ToNullString;
      nxtShortString : aMapper := ToShortString;
      nxtWideString  : aMapper := ToWideString;
    end;
end;
{------------------------------------------------------------------------------}
class function TnxBooleanMapper.ToBoolean(const aSource; var aTarget): TnxResult;
begin
  TnxBoolean(aTarget) := TnxBoolean(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxBooleanMapper.ToByte8(const aSource; var aTarget): TnxResult;
begin
  TnxByte8(aTarget) := Ord(Boolean(TnxBoolean(aSource)));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxBooleanMapper.ToByteArray(const aSource; var aTarget): TnxResult;
begin
  TnxBoolean(aTarget) := Boolean(TnxBoolean(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxBooleanMapper.ToAnsiChar(const aSource; var aTarget): TnxResult;
begin
  if TnxBoolean(aSource) then
    TnxAnsiChar(aTarget) := '1'
  else
    TnxAnsiChar(aTarget) := '0';
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxBooleanMapper.ToCurrency(const aSource; var aTarget): TnxResult;
begin
  TnxCurrency(aTarget) := Ord(Boolean(TnxBoolean(aSource)));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxBooleanMapper.ToDouble(const aSource; var aTarget): TnxResult;
begin
  TnxDouble(aTarget) := Ord(Boolean(TnxBoolean(aSource)));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxBooleanMapper.ToExtended(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  TnxExtended(aTarget) := Ord(Boolean(TnxBoolean(aSource))){$IFDEF FPC}){$ENDIF};
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxBooleanMapper.ToInt16(const aSource; var aTarget): TnxResult;
begin
  If   Boolean(TnxBoolean(aSource))  //..
  then TnxInt16(aTarget) := 1
  else TnxInt16(aTarget) := 0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxBooleanMapper.ToInt32(const aSource; var aTarget): TnxResult;
begin
  TnxInt32(aTarget) := Ord(Boolean(TnxBoolean(aSource)));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxBooleanMapper.ToInt64(const aSource; var aTarget): TnxResult;
begin
  TnxInt64(aTarget) := Ord(Boolean(TnxBoolean(aSource)));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxBooleanMapper.ToInt8(const aSource; var aTarget): TnxResult;
begin
  TnxInt8(aTarget) := Ord(Boolean(TnxBoolean(aSource)));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxBooleanMapper.ToNullString(const aSource; var aTarget): TnxResult;
begin
  if TnxBoolean(aSource) then
    PAnsiChar(@aTarget)[0] := '1'
  else
    PAnsiChar(@aTarget)[0] := '0';
  PAnsiChar(@aTarget)[1] := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxBooleanMapper.ToShortString(const aSource; var aTarget): TnxResult;
begin
  if TnxBoolean(aSource) then
    TnxShStr(aTarget) := '1'
  else
    TnxShStr(aTarget) := '0';
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxBooleanMapper.ToSingle(const aSource; var aTarget): TnxResult;
begin
  TnxSingle(aTarget) := Ord(Boolean(TnxBoolean(aSource)));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxBooleanMapper.ToWideChar(const aSource; var aTarget): TnxResult;
begin
  if TnxBoolean(aSource) then
    TnxWideChar(aTarget) := '1'
  else
    TnxWideChar(aTarget) := '0';
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxBooleanMapper.ToWideString(const aSource; var aTarget): TnxResult;
begin
  if TnxBoolean(aSource) then
    PWideChar(@aTarget)[0] := '1'
  else
    PWideChar(@aTarget)[0] := '0';
  PWideChar(@aTarget)[1] := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxBooleanMapper.ToWord16(const aSource; var aTarget): TnxResult;
begin
  TnxWord16(aTarget) := Abs(Ord(Boolean(TnxBoolean(aSource))));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxBooleanMapper.ToWord32(const aSource; var aTarget): TnxResult;
begin
  TnxWord32(aTarget) := Abs(Ord(Boolean(TnxBoolean(aSource))));
  Result := DBIERR_NONE;
end;
{==============================================================================}



{==============================================================================}
constructor TnxInt8Mapper.Create(aSourceField : TnxFieldDescriptor;
                                 aTargetField : TnxFieldDescriptor;
                                 aMapperDesc  : TnxFieldMapperDescriptor;
                             out aMapper      : TnxMappingMethod);
begin
  inherited Create;

  i8mTargetLength := aTargetField.fdLength;
  i8mTargetUnits := aTargetField.fdUnits;
  i8mTargetDecPl := aTargetField.fdDecPl;

  case aTargetField.fdType of
    nxtBcd:
      if i8mTargetUnits - i8mTargetDecPl >= 3 then
        aMapper := ToBcd
      else if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToBcdTrunc
      else
        aMapper := ToBcdCheck;
    nxtChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToAnsiChar
      else
        aMapper := ToAnsiCharCheck;
    nxtWideChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToWideChar
      else
        aMapper := ToWideCharCheck;
    nxtNullString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (i8mTargetLength > Length(nxIntToAnsiStr(Low(TnxInt8))))  then
        aMapper := ToNullString
      else
        aMapper := ToNullStringCheck;
    nxtShortString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (i8mTargetLength > Length(nxIntToAnsiStr(Low(TnxInt8))))  then
        aMapper := ToShortString
      else
        aMapper := ToShortStringCheck;
    nxtWideString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (i8mTargetLength div SizeOf(WideChar) > Length(nxIntToAnsiStr(Low(TnxInt8))))  then
        aMapper := ToWideString
      else
        aMapper := ToWideStringCheck;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxInt8Mapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                             aSourceCursor : TnxAbstractCursor;
                                             aTargetField  : TnxFieldDescriptor;
                                             aTargetCursor : TnxAbstractCursor;
                                             aMapperDesc  : TnxFieldMapperDescriptor;
                                         out aMapper       : TnxMappingMethod)
                                                           : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  if aSourceField.fdType = nxtInt8 then
    case aTargetField.fdType of
      nxtBoolean:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToBoolean
        else
          aMapper := ToBooleanCheck;
      nxtInt8 : aMapper := ToInt8;
      nxtInt16: aMapper := ToInt16;
      nxtInt32: aMapper := ToInt32;
      nxtInt64: aMapper := ToInt64;
      nxtByte:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToByte8
        else
          aMapper := ToByteCheck;
      nxtWord16:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToWord16
        else
          aMapper := ToWord16Check;
      nxtWord32, nxtAutoInc, nxtRecRev:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToWord32
        else
          aMapper := ToWord32Check;
      nxtSingle   : aMapper := ToSingle;
      nxtDouble   : aMapper := ToDouble;
      nxtExtended : aMapper := ToExtended;

      nxtCurrency : aMapper := ToCurrency;
      nxtBCD      : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);

      nxtByteArray: aMapper := ToByteArray;

      nxtChar,
      nxtWideChar,
      nxtNullString,
      nxtShortString,
      nxtWideString   : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
    end;
end;
{------------------------------------------------------------------------------}
function TnxInt8Mapper.ToBcd(const aSource; var aTarget): TnxResult;
begin
  TnxCurrency(aTarget) := TnxInt8(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt8Mapper.ToBcdCheck(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
  if nxCurrencyToFmtBcd(TnxInt8(aSource), Bcd, i8mTargetUnits, i8mTargetDecPl) = [] then begin
    nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
    Result := DBIERR_NONE;
  end else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxInt8Mapper.ToBcdTrunc(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
  nxCurrencyToFmtBcd(TnxInt8(aSource), Bcd, i8mTargetUnits, i8mTargetDecPl);
  nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt8Mapper.ToBoolean(const aSource; var aTarget): TnxResult;
begin
  TnxBoolean(aTarget) := TnxInt8(aSource) <> 0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt8Mapper.ToBooleanCheck(const aSource; var aTarget): TnxResult;
begin
  case TnxInt8(aSource) of
    0: TnxBoolean(aTarget) := False;
    1: TnxBoolean(aTarget) := True;
  else
    Result := DBIERR_INVALIDFLDXFORM;
    Exit;
  end;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt8Mapper.ToByte8(const aSource; var aTarget): TnxResult;
begin
  if TnxInt8(aSource) >= 0 then
    TnxByte8(aTarget) := TnxInt8(aSource)
  else
    TnxByte8(aTarget) := 0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt8Mapper.ToByteCheck(const aSource; var aTarget): TnxResult;
begin
  if TnxInt8(aSource) >= 0 then begin
    TnxByte8(aTarget) := TnxInt8(aSource);
    Result := DBIERR_NONE;
  end else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxInt8Mapper.ToByteArray(const aSource; var aTarget): TnxResult;
begin
  TnxInt8(aTarget) := TnxInt8(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt8Mapper.ToAnsiChar(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxIntToAnsiStr(TnxInt8(aSource));
  if Length(s) > 0 then
    TnxAnsiChar(aTarget) := s[1]
  else
    TnxAnsiChar(aTarget) := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt8Mapper.ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  if (TnxInt8(aSource) < 0) or (TnxInt8(aSource) > 9) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxIntToAnsiStr(TnxInt8(aSource));
    TnxAnsiChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxInt8Mapper.ToCurrency(const aSource; var aTarget): TnxResult;
begin
  TnxCurrency(aTarget) := TnxInt8(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt8Mapper.ToDouble(const aSource; var aTarget): TnxResult;
begin
  TnxDouble(aTarget) := TnxInt8(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt8Mapper.ToExtended(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  TnxExtended(aTarget) := TnxInt8(aSource);
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxInt8Mapper.ToInt16(const aSource; var aTarget): TnxResult;
begin
  TnxInt16(aTarget) := TnxInt8(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt8Mapper.ToInt32(const aSource; var aTarget): TnxResult;
begin
  TnxInt32(aTarget) := TnxInt8(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt8Mapper.ToInt64(const aSource; var aTarget): TnxResult;
begin
  TnxInt64(aTarget) := TnxInt8(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt8Mapper.ToInt8(const aSource; var aTarget): TnxResult;
begin
  TnxInt8(aTarget) := TnxInt8(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt8Mapper.ToNullString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxIntToAnsiStr(TnxInt8(aSource));
  StrPCopy(PAnsiChar(@aTarget), Copy(s, 1, nxMinI32(Length(s), Pred(i8mTargetLength))));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt8Mapper.ToNullStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxIntToAnsiStr(TnxInt8(aSource));
  if Length(s) < i8mTargetLength then
    StrPCopy(PAnsiChar(@aTarget), s)
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxInt8Mapper.ToShortString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxIntToAnsiStr(TnxInt8(aSource));
  TnxShStr(aTarget) := Copy(s, 1, nxMinI32(Length(s), i8mTargetLength - 1));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt8Mapper.ToShortStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxIntToAnsiStr(TnxInt8(aSource));
  if Length(s) < i8mTargetLength then
    TnxShStr(aTarget) := Copy(s, 1, nxMinI32(Length(s), i8mTargetLength - 1))
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxInt8Mapper.ToSingle(const aSource; var aTarget): TnxResult;
begin
  TnxSingle(aTarget) := TnxInt8(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt8Mapper.ToWideChar(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  s := nxIntToWideStr(TnxInt8(aSource));
  if Length(s) > 0 then
    TnxWideChar(aTarget) := s[1]
  else
    TnxWideChar(aTarget) := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt8Mapper.ToWideCharCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  if not (TnxInt8(aSource) in [0..9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxIntToWideStr(TnxInt8(aSource));
    TnxWideChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxInt8Mapper.ToWideString(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  s := nxIntToWideStr(TnxInt8(aSource));
  nxStringToWideChar(s, @aTarget, Pred(i8mTargetLength div SizeOf(WideChar)));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt8Mapper.ToWideStringCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  s := nxIntToWideStr(TnxInt8(aSource));
  if Length(s) >= (i8mTargetLength div SizeOf(WideChar)) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    nxStringToWideChar(s, @aTarget, Pred(i8mTargetLength div SizeOf(WideChar)));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxInt8Mapper.ToWord16(const aSource; var aTarget): TnxResult;
begin
  if TnxInt8(aSource) >= 0 then
    TnxWord16(aTarget) := TnxInt8(aSource)
  else
    TnxWord16(aTarget) := 0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt8Mapper.ToWord16Check(const aSource; var aTarget): TnxResult;
begin
  if TnxInt8(aSource) >= 0 then begin
    TnxWord16(aTarget) := TnxInt8(aSource);
    Result := DBIERR_NONE;
  end else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxInt8Mapper.ToWord32(const aSource; var aTarget): TnxResult;
begin
  if TnxInt8(aSource) >= 0 then
    TnxWord32(aTarget) := TnxInt8(aSource)
  else
    TnxWord32(aTarget) := 0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt8Mapper.ToWord32Check(const aSource; var aTarget): TnxResult;
begin
  if TnxInt8(aSource) >= 0 then begin
    TnxWord32(aTarget) := TnxInt8(aSource);
    Result := DBIERR_NONE;
  end else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{==============================================================================}



{==============================================================================}
constructor TnxInt16Mapper.Create(aSourceField : TnxFieldDescriptor;
                                  aTargetField : TnxFieldDescriptor;
                                  aMapperDesc  : TnxFieldMapperDescriptor;
                              out aMapper      : TnxMappingMethod);
begin
  inherited Create;

  i16mTargetLength := aTargetField.fdLength;
  i16mTargetUnits := aTargetField.fdUnits;
  i16mTargetDecPl := aTargetField.fdDecPl;

  case aTargetField.fdType of
    nxtBcd:
      if i16mTargetUnits - i16mTargetDecPl >= 5 then
        aMapper := ToBcd
      else if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToBcdTrunc
      else
        aMapper := ToBcdCheck;
    nxtChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToAnsiChar
      else
        aMapper := ToAnsiCharCheck;
    nxtWideChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToWideChar
      else
        aMapper := ToWideCharCheck;
    nxtNullString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (i16mTargetLength > Length(nxIntToAnsiStr(Low(TnxInt16))))  then
        aMapper := ToNullString
      else
        aMapper := ToNullStringCheck;
    nxtShortString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (i16mTargetLength > Length(nxIntToAnsiStr(Low(TnxInt16))))  then
        aMapper := ToShortString
      else
        aMapper := ToShortStringCheck;
    nxtWideString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (i16mTargetLength div SizeOf(WideChar) > Length(nxIntToAnsiStr(Low(TnxInt16))))  then
        aMapper := ToWideString
      else
        aMapper := ToWideStringCheck;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxInt16Mapper.InternalCreateMapper(aSourceField : TnxFieldDescriptor;
                                                  aSourceCursor : TnxAbstractCursor;
                                                  aTargetField  : TnxFieldDescriptor;
                                                  aTargetCursor : TnxAbstractCursor;
                                                  aMapperDesc   : TnxFieldMapperDescriptor;
                                              out aMapper       : TnxMappingMethod)
                                                                : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  if aSourceField.fdType = nxtInt16 then
    case aTargetField.fdType of
      nxtBoolean:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToBoolean
        else
          aMapper := ToBooleanCheck;
      nxtInt8 :
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt8
        else
          aMapper := ToInt8Check;
      nxtInt16: aMapper := ToInt16;
      nxtInt32: aMapper := ToInt32;
      nxtInt64: aMapper := ToInt64;
      nxtByte:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToByte8
        else
          aMapper := ToByteCheck;
      nxtWord16:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToWord16
        else
          aMapper := ToWord16Check;
      nxtWord32, nxtAutoInc, nxtRecRev:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToWord32
        else
          aMapper := ToWord32Check;
      nxtSingle   : aMapper := ToSingle;
      nxtDouble   : aMapper := ToDouble;
      nxtExtended : aMapper := ToExtended;

      nxtCurrency : aMapper := ToCurrency;
      nxtBCD      : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);

      nxtByteArray:
        if aTargetField.fdUnits >= SizeOf(TnxInt16) then
          aMapper := ToByteArray;

      nxtChar,
      nxtWideChar,
      nxtNullString,
      nxtShortString,
      nxtWideString   : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
    end;
end;
{------------------------------------------------------------------------------}
function TnxInt16Mapper.ToBcd(const aSource; var aTarget): TnxResult;
begin
  TnxCurrency(aTarget) := TnxInt16(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt16Mapper.ToBcdCheck(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
  if nxCurrencyToFmtBcd(TnxInt16(aSource), Bcd, i16mTargetUnits, i16mTargetDecPl) = [] then begin
    nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
    Result := DBIERR_NONE;
  end else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxInt16Mapper.ToBcdTrunc(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
  nxCurrencyToFmtBcd(TnxInt16(aSource), Bcd, i16mTargetUnits, i16mTargetDecPl);
  nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt16Mapper.ToBoolean(const aSource; var aTarget): TnxResult;
begin
  TnxBoolean(aTarget) := TnxInt16(aSource) <> 0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt16Mapper.ToBooleanCheck(const aSource; var aTarget): TnxResult;
begin
  case TnxInt16(aSource) of
    0: TnxBoolean(aTarget) := False;
    1: TnxBoolean(aTarget) := True;
  else
    Result := DBIERR_INVALIDFLDXFORM;
    Exit;
  end;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt16Mapper.ToByte8(const aSource; var aTarget): TnxResult;
begin
  if TnxInt16(aSource) < Low(TnxByte8) then
    TnxByte8(aTarget) := Low(TnxByte8)
  else if TnxInt16(aSource) > High(TnxByte8) then
    TnxByte8(aTarget) := High(TnxByte8)
  else
    TnxByte8(aTarget) := TnxInt16(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt16Mapper.ToByteCheck(const aSource; var aTarget): TnxResult;
begin
  if (TnxInt16(aSource) < Low(TnxByte8)) or (TnxInt16(aSource) > High(TnxByte8)) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxByte8(aTarget) := TnxInt16(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxInt16Mapper.ToByteArray(const aSource; var aTarget): TnxResult;
begin
  TnxInt16(aTarget) := TnxInt16(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt16Mapper.ToAnsiChar(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxIntToAnsiStr(TnxInt16(aSource));
  if Length(s) > 0 then
    TnxAnsiChar(aTarget) := s[1]
  else
    TnxAnsiChar(aTarget) := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt16Mapper.ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  if (TnxInt16(aSource) < 0) or (TnxInt16(aSource) > 9) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxIntToAnsiStr(TnxInt16(aSource));
    TnxAnsiChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxInt16Mapper.ToCurrency(const aSource; var aTarget): TnxResult;
begin
  TnxCurrency(aTarget) := TnxInt16(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt16Mapper.ToDouble(const aSource; var aTarget): TnxResult;
begin
  TnxDouble(aTarget) := TnxInt16(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt16Mapper.ToExtended(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  TnxExtended(aTarget) := TnxInt16(aSource);
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxInt16Mapper.ToInt16(const aSource; var aTarget): TnxResult;
begin
  TnxInt16(aTarget) := TnxInt16(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt16Mapper.ToInt32(const aSource; var aTarget): TnxResult;
begin
  TnxInt32(aTarget) := TnxInt16(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt16Mapper.ToInt64(const aSource; var aTarget): TnxResult;
begin
  TnxInt64(aTarget) := TnxInt16(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt16Mapper.ToInt8(const aSource; var aTarget): TnxResult;
begin
  if TnxInt16(aSource) < Low(TnxInt8) then
    TnxInt8(aTarget) := Low(TnxInt8)
  else if TnxInt16(aSource) > High(TnxInt8) then
    TnxInt8(aTarget) := High(TnxInt8)
  else
    TnxInt8(aTarget) := TnxInt16(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt16Mapper.ToInt8Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxInt16(aSource) < Low(TnxInt8)) or (TnxInt16(aSource) > High(TnxInt8)) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt8(aTarget) := TnxInt16(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxInt16Mapper.ToNullString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxIntToAnsiStr(TnxInt16(aSource));
  StrPCopy(PAnsiChar(@aTarget), Copy(s, 1, nxMinI32(Length(s), Pred(i16mTargetLength))));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt16Mapper.ToNullStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxIntToAnsiStr(TnxInt16(aSource));
  if Length(s) < i16mTargetLength then
    StrPCopy(PAnsiChar(@aTarget), s)
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxInt16Mapper.ToShortString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxIntToAnsiStr(TnxInt16(aSource));
  TnxShStr(aTarget) := Copy(s, 1, nxMinI32(Length(s), i16mTargetLength - 1));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt16Mapper.ToShortStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxIntToAnsiStr(TnxInt16(aSource));
  if Length(s) < i16mTargetLength then
    TnxShStr(aTarget) := s
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxInt16Mapper.ToSingle(const aSource; var aTarget): TnxResult;
begin
  TnxSingle(aTarget) := TnxInt16(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt16Mapper.ToWideChar(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  s := nxIntToWideStr(TnxInt16(aSource));
  if Length(s) > 0 then
    TnxWideChar(aTarget) := s[1]
  else
    TnxWideChar(aTarget) := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt16Mapper.ToWideCharCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  if not (TnxInt16(aSource) in [0..9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxIntToWideStr(TnxInt16(aSource));
    TnxWideChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxInt16Mapper.ToWideString(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  s := nxIntToWideStr(TnxInt16(aSource));
  nxStringToWideChar(s, @aTarget, Pred(i16mTargetLength div SizeOf(WideChar)));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt16Mapper.ToWideStringCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  Result := DBIERR_NONE;
  s := nxIntToWideStr(TnxInt16(aSource));
  if Length(s) < i16mTargetLength then
    nxStringToWideChar(s, @aTarget, Pred(i16mTargetLength div SizeOf(WideChar)))
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxInt16Mapper.ToWord16(const aSource; var aTarget): TnxResult;
begin
  if TnxInt16(aSource) >= 0 then
    TnxWord16(aTarget) := TnxInt16(aSource)
  else
    TnxWord16(aTarget) := 0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt16Mapper.ToWord16Check(const aSource; var aTarget): TnxResult;
begin
  if TnxInt16(aSource) >= 0 then begin
    TnxWord16(aTarget) := TnxInt16(aSource);
    Result := DBIERR_NONE;
  end else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxInt16Mapper.ToWord32(const aSource;
  var aTarget): TnxResult;
begin
  if TnxInt16(aSource) >= 0 then
    TnxWord32(aTarget) := TnxInt16(aSource)
  else
    TnxWord32(aTarget) := 0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt16Mapper.ToWord32Check(const aSource; var aTarget): TnxResult;
begin
  if TnxInt16(aSource) >= 0 then begin
    TnxWord32(aTarget) := TnxInt16(aSource);
    Result := DBIERR_NONE;
  end else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{==============================================================================}



{==============================================================================}
constructor TnxInt32Mapper.Create(aSourceField : TnxFieldDescriptor;
                                  aTargetField : TnxFieldDescriptor;
                                  aMapperDesc  : TnxFieldMapperDescriptor;
                              out aMapper      : TnxMappingMethod);
begin
  inherited Create;

  i32mTargetLength := aTargetField.fdLength;
  i32mTargetUnits := aTargetField.fdUnits;
  i32mTargetDecPl := aTargetField.fdDecPl;

  case aTargetField.fdType of
    nxtBcd:
      if i32mTargetUnits - i32mTargetDecPl >= 10 then
        aMapper := ToBcd
      else if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToBcdTrunc
      else
        aMapper := ToBcdCheck;
    nxtChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToAnsiChar
      else
        aMapper := ToAnsiCharCheck;
    nxtWideChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToWideChar
      else
        aMapper := ToWideCharCheck;
    nxtNullString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (i32mTargetLength > Length(nxIntToAnsiStr(Low(TnxInt32))))  then
        aMapper := ToNullString
      else
        aMapper := ToNullStringCheck;
    nxtShortString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (i32mTargetLength > Length(nxIntToAnsiStr(Low(TnxInt32))))  then
        aMapper := ToShortString
      else
        aMapper := ToShortStringCheck;
    nxtWideString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (i32mTargetLength div SizeOf(WideChar) > Length(nxIntToAnsiStr(Low(TnxInt32))))  then
        aMapper := ToWideString
      else
        aMapper := ToWideStringCheck;
    nxtDateTime: aMapper := ToDateTime; //..
  end;
end;
{------------------------------------------------------------------------------}
class function TnxInt32Mapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                             aSourceCursor : TnxAbstractCursor;
                                             aTargetField  : TnxFieldDescriptor;
                                             aTargetCursor : TnxAbstractCursor;
                                             aMapperDesc  : TnxFieldMapperDescriptor;
                                         out aMapper       : TnxMappingMethod)
                                                           : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  if aSourceField.fdType = nxtInt32 then
    case aTargetField.fdType of
      nxtBoolean:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToBoolean
        else
          aMapper := ToBooleanCheck;
      nxtInt8 :
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt8
        else
          aMapper := ToInt8Check;
      nxtInt16:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt16
        else
          aMapper := ToInt16Check;
      nxtInt32: aMapper := ToInt32;
      nxtInt64: aMapper := ToInt64;
      nxtByte:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToByte8
        else
          aMapper := ToByteCheck;
      nxtWord16:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToWord16
        else
          aMapper := ToWord16Check;
      nxtWord32, nxtAutoInc, nxtRecRev:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToWord32
        else
          aMapper := ToWord32Check;
      nxtSingle   : aMapper := ToSingle;
      nxtDouble   : aMapper := ToDouble;
      nxtExtended : aMapper := ToExtended;

      nxtCurrency : aMapper := ToCurrency;
      nxtBCD      : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);

      nxtByteArray:
        if aTargetField.fdUnits >= SizeOf(TnxInt32) then
          aMapper := ToByteArray;

      nxtChar,
      nxtWideChar,
      nxtNullString,
      nxtShortString,
      nxtWideString   : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
      nxtDateTime: aMapper := ToDateTime; //..
    end;
end;
{------------------------------------------------------------------------------}
function TnxInt32Mapper.ToBcd(const aSource; var aTarget): TnxResult;
begin
  TnxCurrency(aTarget) := TnxInt32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt32Mapper.ToBcdCheck(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
  if nxCurrencyToFmtBcd(TnxInt32(aSource), Bcd, i32mTargetUnits, i32mTargetDecPl) = [] then begin
    nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
    Result := DBIERR_NONE;
  end else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxInt32Mapper.ToBcdTrunc(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
  nxCurrencyToFmtBcd(TnxInt32(aSource), Bcd, i32mTargetUnits, i32mTargetDecPl);
  nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt32Mapper.ToBoolean(const aSource; var aTarget): TnxResult;
begin
  TnxBoolean(aTarget) := TnxInt32(aSource) <> 0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt32Mapper.ToBooleanCheck(const aSource; var aTarget): TnxResult;
begin
  case TnxInt32(aSource) of
    0: TnxBoolean(aTarget) := False;
    1: TnxBoolean(aTarget) := True;
  else
    Result := DBIERR_INVALIDFLDXFORM;
    Exit;
  end;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt32Mapper.ToByte8(const aSource; var aTarget): TnxResult;
begin
  if TnxInt32(aSource) < Low(TnxByte8) then
    TnxByte8(aTarget) := Low(TnxByte8)
  else if TnxInt32(aSource) > High(TnxByte8) then
    TnxByte8(aTarget) := High(TnxByte8)
  else
    TnxByte8(aTarget) := TnxInt32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt32Mapper.ToByteCheck(const aSource; var aTarget): TnxResult;
begin
  if (TnxInt32(aSource) < Low(TnxByte8)) or (TnxInt32(aSource) > High(TnxByte8)) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxByte8(aTarget) := TnxInt32(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxInt32Mapper.ToByteArray(const aSource; var aTarget): TnxResult;
begin
  TnxInt32(aTarget) := TnxInt32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt32Mapper.ToAnsiChar(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxIntToAnsiStr(TnxInt32(aSource));
  if Length(s) > 0 then
    TnxAnsiChar(aTarget) := s[1]
  else
    TnxAnsiChar(aTarget) := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt32Mapper.ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  if (TnxInt32(aSource) < 0) or (TnxInt32(aSource) > 9) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxIntToAnsiStr(TnxInt32(aSource));
    TnxAnsiChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxInt32Mapper.ToCurrency(const aSource; var aTarget): TnxResult;
begin
  TnxCurrency(aTarget) := TnxInt32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt32Mapper.ToDouble(const aSource; var aTarget): TnxResult;
begin
  TnxDouble(aTarget) := TnxInt32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt32Mapper.ToExtended(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  TnxExtended(aTarget) := TnxInt32(aSource);
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxInt32Mapper.ToDateTime(const aSource; var aTarget): TnxResult; //..
var
  TimeStamp : TTimeStamp;
  Value : Double;
begin
  Value := TnxInt32(aSource);
  TimeStamp := DateTimeToTimeStamp(TDateTime(Value));
  TnxDateTime(aTarget) := TimeStampToMSecs(TimeStamp);
  Result := DBIERR_NONE;
end;
class function TnxInt32Mapper.ToInt16(const aSource; var aTarget): TnxResult;
begin
  if TnxInt32(aSource) < Low(TnxInt16) then
    TnxInt16(aTarget) := Low(TnxInt16)
  else if TnxInt32(aSource) > High(TnxInt16) then
    TnxInt16(aTarget) := High(TnxInt16)
  else
    TnxInt16(aTarget) := TnxInt32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt32Mapper.ToInt16Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxInt32(aSource) < Low(TnxInt16)) or (TnxInt32(aSource) > High(TnxInt16)) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt16(aTarget) := TnxInt32(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxInt32Mapper.ToInt32(const aSource; var aTarget): TnxResult;
begin
  TnxInt32(aTarget) := TnxInt32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt32Mapper.ToInt64(const aSource; var aTarget): TnxResult;
begin
  TnxInt64(aTarget) := TnxInt32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt32Mapper.ToInt8(const aSource; var aTarget): TnxResult;
begin
  if TnxInt32(aSource) < Low(TnxInt8) then
    TnxInt8(aTarget) := Low(TnxInt8)
  else if TnxInt32(aSource) > High(TnxInt8) then
    TnxInt8(aTarget) := High(TnxInt8)
  else
    TnxInt8(aTarget) := TnxInt32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt32Mapper.ToInt8Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxInt32(aSource) < Low(TnxInt8)) or (TnxInt32(aSource) > High(TnxInt8)) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt8(aTarget) := TnxInt32(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxInt32Mapper.ToNullString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxIntToAnsiStr(TnxInt32(aSource));
  StrPCopy(PAnsiChar(@aTarget), Copy(s, 1, nxMinI32(Length(s), Pred(i32mTargetLength))));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt32Mapper.ToNullStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxIntToAnsiStr(TnxInt32(aSource));
  if Length(s) < i32mTargetLength then
    StrPCopy(PAnsiChar(@aTarget), s)
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxInt32Mapper.ToShortString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxIntToAnsiStr(TnxInt32(aSource));
  TnxShStr(aTarget) := Copy(s, 1, nxMinI32(Length(s), i32mTargetLength - 1));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt32Mapper.ToShortStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxIntToAnsiStr(TnxInt32(aSource));
  if Length(s) < i32mTargetLength then
    TnxShStr(aTarget) := s
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxInt32Mapper.ToSingle(const aSource; var aTarget): TnxResult;
begin
  TnxSingle(aTarget) := TnxInt32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt32Mapper.ToWideChar(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  s := nxIntToWideStr(TnxInt32(aSource));
  if Length(s) > 0 then
    TnxWideChar(aTarget) := s[1]
  else
    TnxWideChar(aTarget) := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt32Mapper.ToWideCharCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  if not (TnxInt32(aSource) in [0..9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxIntToWideStr(TnxInt32(aSource));
    TnxWideChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxInt32Mapper.ToWideString(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  s := nxIntToWideStr(TnxInt32(aSource));
  nxStringToWideChar(s, @aTarget, Pred(i32mTargetLength div SizeOf(WideChar)));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt32Mapper.ToWideStringCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  Result := DBIERR_NONE;
  s := nxIntToWideStr(TnxInt32(aSource));
  if Length(s) < i32mTargetLength then
    nxStringToWideChar(s, @aTarget, Pred(i32mTargetLength div SizeOf(WideChar)))
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxInt32Mapper.ToWord16(const aSource; var aTarget): TnxResult;
begin
  if TnxInt32(aSource) < Low(TnxWord16) then
    TnxWord16(aTarget) := Low(TnxWord16)
  else if TnxInt32(aSource) > High(TnxWord16) then
    TnxWord16(aTarget) := High(TnxWord16)
  else
    TnxWord16(aTarget) := TnxInt32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt32Mapper.ToWord16Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxInt32(aSource) < Low(TnxWord16)) or (TnxInt32(aSource) > High(TnxWord16)) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxWord16(aTarget) := TnxInt32(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxInt32Mapper.ToWord32(const aSource;
  var aTarget): TnxResult;
begin
  if TnxInt32(aSource) >= 0 then
    TnxWord32(aTarget) := TnxInt32(aSource)
  else
    TnxWord32(aTarget) := 0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt32Mapper.ToWord32Check(const aSource; var aTarget): TnxResult;
begin
  if TnxInt32(aSource) >= 0 then begin
    TnxWord32(aTarget) := TnxInt32(aSource);
    Result := DBIERR_NONE;
  end else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{==============================================================================}



{==============================================================================}
constructor TnxInt64Mapper.Create(aSourceField : TnxFieldDescriptor;
                                  aTargetField : TnxFieldDescriptor;
                                  aMapperDesc  : TnxFieldMapperDescriptor;
                              out aMapper      : TnxMappingMethod);
begin
  inherited Create;

  i64mTargetLength := aTargetField.fdLength;
  i64mTargetUnits := aTargetField.fdUnits;
  i64mTargetDecPl := aTargetField.fdDecPl;

  case aTargetField.fdType of
    nxtBcd:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToBcdTrunc
      else
        aMapper := ToBcdCheck;
    nxtChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToAnsiChar
      else
        aMapper := ToAnsiCharCheck;
    nxtWideChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToWideChar
      else
        aMapper := ToWideCharCheck;
    nxtNullString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (i64mTargetLength > Length(nxIntToAnsiStr(Low(TnxInt64))))  then
        aMapper := ToNullString
      else
        aMapper := ToNullStringCheck;
    nxtShortString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (i64mTargetLength > Length(nxIntToAnsiStr(Low(TnxInt64))))  then
        aMapper := ToShortString
      else
        aMapper := ToShortStringCheck;
    nxtWideString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (i64mTargetLength div SizeOf(WideChar) > Length(nxIntToAnsiStr(Low(TnxInt64))))  then
        aMapper := ToWideString
      else
        aMapper := ToWideStringCheck;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                             aSourceCursor : TnxAbstractCursor;
                                             aTargetField  : TnxFieldDescriptor;
                                             aTargetCursor : TnxAbstractCursor;
                                             aMapperDesc  : TnxFieldMapperDescriptor;
                                         out aMapper       : TnxMappingMethod)
                                                           : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  case aSourceField.fdType of
    nxtInt64: case aTargetField.fdType of
      nxtBoolean:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToBoolean
        else
          aMapper := ToBooleanCheck;
      nxtInt8 :
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt8
        else
          aMapper := ToInt8Check;
      nxtInt16:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt16
        else
          aMapper := ToInt16Check;
      nxtInt32:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt32
        else
          aMapper := ToInt32Check;
      nxtInt64: aMapper := ToInt64;
      nxtByte:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToByte8
        else
          aMapper := ToByteCheck;
      nxtWord16:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToWord16
        else
          aMapper := ToWord16Check;
      nxtWord32, nxtAutoInc, nxtRecRev:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToWord32
        else
          aMapper := ToWord32Check;
      nxtSingle   : aMapper := ToSingle;
      nxtDouble   : aMapper := ToDouble;
      nxtExtended : aMapper := ToExtended;

      nxtCurrency : aMapper := ToCurrency;
      nxtBCD      : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);

      nxtByteArray:
        if aTargetField.fdUnits >= SizeOf(TnxInt64) then
          aMapper := ToByteArray;

      nxtChar,
      nxtWideChar,
      nxtNullString,
      nxtShortString,
      nxtWideString   : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
    end;
    nxtRefNr: case aTargetField.fdType of
      nxtInt64, nxtRefNr: aMapper := ToInt64;

      nxtNullString,
      nxtShortString,
      nxtWideString   : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxInt64Mapper.ToBcdCheck(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
  Result := DBIERR_NONE;
  if (TnxInt64(aSource) < LowCurrency64) or (TnxInt64(aSource) > HighCurrency64) then begin
    if nxNormalizeBcd(nxStrToFmtBcd(nxIntToAnsiStr(TnxInt64(aSource))), Bcd, i64mTargetUnits, i64mTargetDecPl) <> [] then
      Result := DBIERR_INVALIDFLDXFORM;
  end else
    if nxCurrencyToFmtBcd(TnxInt64(aSource), Bcd, i64mTargetUnits, i64mTargetDecPl) <> [] then
      Result := DBIERR_INVALIDFLDXFORM;

  if Result = DBIERR_NONE then
    nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
end;
{------------------------------------------------------------------------------}
function TnxInt64Mapper.ToBcdTrunc(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
  if (TnxInt64(aSource) < LowCurrency64) or (TnxInt64(aSource) > HighCurrency64) then begin
    nxNormalizeBcd(nxStrToFmtBcd(nxIntToAnsiStr(TnxInt64(aSource))), Bcd, i64mTargetUnits, i64mTargetDecPl)
  end else
    nxCurrencyToFmtBcd(TnxInt64(aSource), Bcd, i64mTargetUnits, i64mTargetDecPl);

  nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.ToBoolean(const aSource; var aTarget): TnxResult;
begin
  TnxBoolean(aTarget) := TnxInt64(aSource) <> 0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.ToBooleanCheck(const aSource; var aTarget): TnxResult;
begin
  case TnxInt64(aSource) of
    0: TnxBoolean(aTarget) := False;
    1: TnxBoolean(aTarget) := True;
  else
    Result := DBIERR_INVALIDFLDXFORM;
    Exit;
  end;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.ToByte8(const aSource; var aTarget): TnxResult;
begin
  if TnxInt64(aSource) < Low(TnxByte8) then
    TnxByte8(aTarget) := Low(TnxByte8)
  else if TnxInt64(aSource) > High(TnxByte8) then
    TnxByte8(aTarget) := High(TnxByte8)
  else
    TnxByte8(aTarget) := TnxInt64(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.ToByteCheck(const aSource; var aTarget): TnxResult;
begin
  if (TnxInt64(aSource) < Low(TnxByte8)) or (TnxInt64(aSource) > High(TnxByte8)) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxByte8(aTarget) := TnxInt64(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.ToByteArray(const aSource; var aTarget): TnxResult;
begin
  TnxInt64(aTarget) := TnxInt64(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt64Mapper.ToAnsiChar(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxIntToAnsiStr(TnxInt64(aSource));
  if Length(s) > 0 then
    TnxAnsiChar(aTarget) := s[1]
  else
    TnxAnsiChar(aTarget) := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt64Mapper.ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  if (TnxInt64(aSource) < 0) or (TnxInt64(aSource) > 9) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxIntToAnsiStr(TnxInt64(aSource));
    TnxAnsiChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.ToCurrency(const aSource; var aTarget): TnxResult;
begin
  if TnxInt64(aSource) < LowCurrency64 then
    TnxCurrency(aTarget) := LowCurrency64
  else if TnxInt64(aSource) > HighCurrency64 then
    TnxCurrency(aTarget) := HighCurrency64
  else
    TnxCurrency(aTarget) := TnxInt64(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.ToCurrencyCheck(const aSource; var aTarget): TnxResult;
begin
  if (TnxInt64(aSource) < LowCurrency64) or (TnxInt64(aSource) > HighCurrency64) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxCurrency(aTarget) := TnxInt64(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.ToDouble(const aSource; var aTarget): TnxResult;
begin
  TnxDouble(aTarget) := TnxInt64(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.ToExtended(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  TnxExtended(aTarget) := TnxInt64(aSource);
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.ToInt16(const aSource; var aTarget): TnxResult;
begin
  if TnxInt64(aSource) < Low(TnxInt16) then
    TnxInt16(aTarget) := Low(TnxInt16)
  else if TnxInt64(aSource) > High(TnxInt16) then
    TnxInt16(aTarget) := High(TnxInt16)
  else
    TnxInt16(aTarget) := TnxInt64(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.ToInt16Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxInt64(aSource) < Low(TnxInt16)) or (TnxInt64(aSource) > High(TnxInt16)) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt16(aTarget) := TnxInt64(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.ToInt32(const aSource; var aTarget): TnxResult;
begin
  if TnxInt64(aSource) < Low(TnxInt32) then
    TnxInt32(aTarget) := Low(TnxInt32)
  else if TnxInt64(aSource) > High(TnxInt32) then
    TnxInt32(aTarget) := High(TnxInt32)
  else
    TnxInt32(aTarget) := TnxInt64(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.ToInt32Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxInt64(aSource) < Low(TnxInt32)) or (TnxInt64(aSource) > High(TnxInt32)) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt32(aTarget) := TnxInt64(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.ToInt64(const aSource; var aTarget): TnxResult;
begin
  TnxInt64(aTarget) := TnxInt64(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.ToInt8(const aSource; var aTarget): TnxResult;
begin
  if TnxInt64(aSource) < Low(TnxInt8) then
    TnxInt8(aTarget) := Low(TnxInt8)
  else if TnxInt64(aSource) > High(TnxInt8) then
    TnxInt8(aTarget) := High(TnxInt8)
  else
    TnxInt8(aTarget) := TnxInt64(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.ToInt8Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxInt64(aSource) < Low(TnxInt8)) or (TnxInt64(aSource) > High(TnxInt8)) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt8(aTarget) := TnxInt64(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxInt64Mapper.ToNullString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxIntToAnsiStr(TnxInt64(aSource));
  StrPCopy(PAnsiChar(@aTarget), Copy(s, 1, nxMinI32(Length(s), Pred(i64mTargetLength))));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt64Mapper.ToNullStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxIntToAnsiStr(TnxInt64(aSource));
  if Length(s) < i64mTargetLength then
    StrPCopy(PAnsiChar(@aTarget), s)
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxInt64Mapper.ToShortString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxIntToAnsiStr(TnxInt64(aSource));
  TnxShStr(aTarget) := Copy(s, 1, nxMinI32(Length(s), i64mTargetLength - 1));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt64Mapper.ToShortStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxIntToAnsiStr(TnxInt64(aSource));
  if Length(s) < i64mTargetLength then
    TnxShStr(aTarget) := s
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.ToSingle(const aSource; var aTarget): TnxResult;
begin
  TnxSingle(aTarget) := TnxInt64(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt64Mapper.ToWideChar(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  s := nxIntToWideStr(TnxInt64(aSource));
  if Length(s) > 0 then
    TnxWideChar(aTarget) := s[1]
  else
    TnxWideChar(aTarget) := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt64Mapper.ToWideCharCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  if not (TnxInt64(aSource) in [0..9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxIntToWideStr(TnxInt64(aSource));
    TnxWideChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxInt64Mapper.ToWideString(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  s := nxIntToWideStr(TnxInt64(aSource));
  nxStringToWideChar(s, @aTarget, Pred(i64mTargetLength div SizeOf(WideChar)));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxInt64Mapper.ToWideStringCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  Result := DBIERR_NONE;
  s := nxIntToWideStr(TnxInt64(aSource));
  if Length(s) < i64mTargetLength then
    nxStringToWideChar(s, @aTarget, Pred(i64mTargetLength div SizeOf(WideChar)))
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.ToWord16(const aSource; var aTarget): TnxResult;
begin
  if TnxInt64(aSource) < Low(TnxWord16) then
    TnxWord16(aTarget) := Low(TnxWord16)
  else if TnxInt64(aSource) > High(TnxWord16) then
    TnxWord16(aTarget) := High(TnxWord16)
  else
    TnxWord16(aTarget) := TnxInt64(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.ToWord16Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxInt64(aSource) < Low(TnxWord16)) or (TnxInt64(aSource) > High(TnxWord16)) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxWord16(aTarget) := TnxInt64(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.ToWord32(const aSource; var aTarget): TnxResult;
begin
  if TnxInt64(aSource) < Low(TnxWord32) then
    TnxWord32(aTarget) := Low(TnxWord32)
  else if TnxInt64(aSource) > High(TnxWord32) then
    TnxWord32(aTarget) := High(TnxWord32)
  else
    TnxWord32(aTarget) := TnxInt64(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxInt64Mapper.ToWord32Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxInt64(aSource) < Low(TnxWord32)) or (TnxInt64(aSource) > High(TnxWord32)) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxWord32(aTarget) := TnxInt64(aSource);
    Result := DBIERR_NONE;
  end;
end;
{==============================================================================}



{==============================================================================}
constructor TnxByte8Mapper.Create(aSourceField : TnxFieldDescriptor;
                                  aTargetField : TnxFieldDescriptor;
                                  aMapperDesc  : TnxFieldMapperDescriptor;
                              out aMapper      : TnxMappingMethod);
begin
  inherited Create;

  b8mTargetLength := aTargetField.fdLength;
  b8mTargetUnits := aTargetField.fdUnits;
  b8mTargetDecPl := aTargetField.fdDecPl;

  case aTargetField.fdType of
    nxtBcd:
      if b8mTargetUnits - b8mTargetDecPl >= 3 then
        aMapper := ToBcd
      else if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToBcdTrunc
      else
        aMapper := ToBcdCheck;
    nxtChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToAnsiChar
      else
        aMapper := ToAnsiCharCheck;
    nxtWideChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToWideChar
      else
        aMapper := ToWideCharCheck;
    nxtNullString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (b8mTargetLength > Length(nxIntToAnsiStr(High(TnxByte8))))  then
        aMapper := ToNullString
      else
        aMapper := ToNullStringCheck;
    nxtShortString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (b8mTargetLength > Length(nxIntToAnsiStr(High(TnxByte8))))  then
        aMapper := ToShortString
      else
        aMapper := ToShortStringCheck;
    nxtWideString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (b8mTargetLength div SizeOf(WideChar) > Length(nxIntToAnsiStr(High(TnxByte8))))  then
        aMapper := ToWideString
      else
        aMapper := ToWideStringCheck;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxByte8Mapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                              aSourceCursor : TnxAbstractCursor;
                                              aTargetField  : TnxFieldDescriptor;
                                              aTargetCursor : TnxAbstractCursor;
                                              aMapperDesc  : TnxFieldMapperDescriptor;
                                          out aMapper       : TnxMappingMethod)
                                                            : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  if aSourceField.fdType = nxtByte then
    case aTargetField.fdType of
      nxtBoolean:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToBoolean
        else
          aMapper := ToBooleanCheck;
      nxtInt8 :
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt8
        else
          aMapper := ToInt8Check;
      nxtInt16: aMapper := ToInt16;
      nxtInt32: aMapper := ToInt32;
      nxtInt64: aMapper := ToInt64;
      nxtByte: aMapper := ToByte8;
      nxtWord16: aMapper := ToWord16;
      nxtWord32, nxtAutoInc, nxtRecRev: aMapper := ToWord32;
      nxtSingle   : aMapper := ToSingle;
      nxtDouble   : aMapper := ToDouble;
      nxtExtended : aMapper := ToExtended;

      nxtCurrency : aMapper := ToCurrency;
      nxtBCD      : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);

      nxtByteArray:
        if aTargetField.fdUnits >= SizeOf(TnxByte8) then
          aMapper := ToByteArray;

      nxtChar,
      nxtWideChar,
      nxtNullString,
      nxtShortString,
      nxtWideString   : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
    end;
end;
{------------------------------------------------------------------------------}
function TnxByte8Mapper.ToBcd(const aSource; var aTarget): TnxResult;
begin
  TnxCurrency(aTarget) := TnxByte8(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxByte8Mapper.ToBcdCheck(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
  if nxCurrencyToFmtBcd(TnxByte8(aSource), Bcd, b8mTargetUnits, b8mTargetDecPl) = [] then begin
    nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
    Result := DBIERR_NONE;
  end else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxByte8Mapper.ToBcdTrunc(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
  nxCurrencyToFmtBcd(TnxByte8(aSource), Bcd, b8mTargetUnits, b8mTargetDecPl);
  nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxByte8Mapper.ToBoolean(const aSource; var aTarget): TnxResult;
begin
  TnxBoolean(aTarget) := TnxByte8(aSource) <> 0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxByte8Mapper.ToBooleanCheck(const aSource; var aTarget): TnxResult;
begin
  case TnxByte8(aSource) of
    0: TnxBoolean(aTarget) := False;
    1: TnxBoolean(aTarget) := True;
  else
    Result := DBIERR_INVALIDFLDXFORM;
    Exit;
  end;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxByte8Mapper.ToByte8(const aSource; var aTarget): TnxResult;
begin
  TnxByte8(aTarget) := TnxByte8(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxByte8Mapper.ToByteArray(const aSource; var aTarget): TnxResult;
begin
  TnxByte8(aTarget) := TnxByte8(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxByte8Mapper.ToAnsiChar(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxIntToAnsiStr(TnxByte8(aSource));
  if Length(s) > 0 then
    TnxAnsiChar(aTarget) := s[1]
  else
    TnxAnsiChar(aTarget) := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxByte8Mapper.ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  if TnxByte8(aSource) > 9 then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxIntToAnsiStr(TnxByte8(aSource));
    TnxAnsiChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxByte8Mapper.ToCurrency(const aSource; var aTarget): TnxResult;
begin
  TnxCurrency(aTarget) := TnxByte8(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxByte8Mapper.ToDouble(const aSource; var aTarget): TnxResult;
begin
  TnxDouble(aTarget) := TnxByte8(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxByte8Mapper.ToExtended(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  TnxExtended(aTarget) := TnxByte8(aSource);
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxByte8Mapper.ToInt16(const aSource; var aTarget): TnxResult;
begin
  TnxInt16(aTarget) := TnxByte8(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxByte8Mapper.ToInt32(const aSource; var aTarget): TnxResult;
begin
  TnxInt32(aTarget) := TnxByte8(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxByte8Mapper.ToInt64(const aSource; var aTarget): TnxResult;
begin
  TnxInt64(aTarget) := TnxByte8(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxByte8Mapper.ToInt8(const aSource; var aTarget): TnxResult;
begin
  if TnxByte8(aSource) > TnxByte8(High(TnxInt8)) then
    TnxInt8(aTarget) := High(TnxInt8)
  else
    TnxInt8(aTarget) := TnxByte8(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxByte8Mapper.ToInt8Check(const aSource; var aTarget): TnxResult;
begin
  if TnxByte8(aSource) > TnxByte8(High(TnxInt8)) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt8(aTarget) := TnxByte8(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxByte8Mapper.ToNullString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxIntToAnsiStr(TnxByte8(aSource));
  StrPCopy(PAnsiChar(@aTarget), Copy(s, 1, nxMinI32(Length(s), Pred(b8mTargetLength))));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxByte8Mapper.ToNullStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxIntToAnsiStr(TnxByte8(aSource));
  if Length(s) < b8mTargetLength then
    StrPCopy(PAnsiChar(@aTarget), s)
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxByte8Mapper.ToShortString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxIntToAnsiStr(TnxByte8(aSource));
  TnxShStr(aTarget) := Copy(s, 1, nxMinI32(Length(s), b8mTargetLength - 1));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxByte8Mapper.ToShortStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxIntToAnsiStr(TnxByte8(aSource));
  if Length(s) < b8mTargetLength then
    TnxShStr(aTarget) := s
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxByte8Mapper.ToSingle(const aSource; var aTarget): TnxResult;
begin
  TnxSingle(aTarget) := TnxByte8(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxByte8Mapper.ToWideChar(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  s := nxIntToWideStr(TnxByte8(aSource));
  if Length(s) > 0 then
    TnxWideChar(aTarget) := s[1]
  else
    TnxWideChar(aTarget) := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxByte8Mapper.ToWideCharCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  if not (TnxByte8(aSource) in [0..9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxIntToWideStr(TnxByte8(aSource));
    TnxWideChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxByte8Mapper.ToWideString(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  s := nxIntToWideStr(TnxByte8(aSource));
  nxStringToWideChar(s, @aTarget, Pred(b8mTargetLength div SizeOf(WideChar)));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxByte8Mapper.ToWideStringCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  Result := DBIERR_NONE;
  s := nxIntToWideStr(TnxByte8(aSource));
  if Length(s) < b8mTargetLength then
    nxStringToWideChar(s, @aTarget, Pred(b8mTargetLength div SizeOf(WideChar)))
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxByte8Mapper.ToWord16(const aSource; var aTarget): TnxResult;
begin
  TnxWord16(aTarget) := TnxByte8(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxByte8Mapper.ToWord32(const aSource; var aTarget): TnxResult;
begin
  TnxWord32(aTarget) := TnxByte8(aSource);
  Result := DBIERR_NONE;
end;
{==============================================================================}



{==============================================================================}
constructor TnxWord16Mapper.Create(aSourceField : TnxFieldDescriptor;
                                   aTargetField : TnxFieldDescriptor;
                                   aMapperDesc  : TnxFieldMapperDescriptor;
                               out aMapper      : TnxMappingMethod);
begin
  inherited Create;

  w16mTargetLength := aTargetField.fdLength;
  w16mTargetUnits := aTargetField.fdUnits;
  w16mTargetDecPl := aTargetField.fdDecPl;

  case aTargetField.fdType of
    nxtBcd:
      if w16mTargetUnits - w16mTargetDecPl >= 5 then
        aMapper := ToBcd
      else if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToBcdTrunc
      else
        aMapper := ToBcdCheck;
    nxtChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToAnsiChar
      else
        aMapper := ToAnsiCharCheck;
    nxtWideChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToWideChar
      else
        aMapper := ToWideCharCheck;
    nxtNullString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (w16mTargetLength > Length(nxIntToAnsiStr(High(TnxWord16))))  then
        aMapper := ToNullString
      else
        aMapper := ToNullStringCheck;
    nxtShortString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (w16mTargetLength > Length(nxIntToAnsiStr(High(TnxWord16))))  then
        aMapper := ToShortString
      else
        aMapper := ToShortStringCheck;
    nxtWideString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (w16mTargetLength div SizeOf(WideChar) > Length(nxIntToAnsiStr(High(TnxWord16))))  then
        aMapper := ToWideString
      else
        aMapper := ToWideStringCheck;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxWord16Mapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                              aSourceCursor : TnxAbstractCursor;
                                              aTargetField  : TnxFieldDescriptor;
                                              aTargetCursor : TnxAbstractCursor;
                                              aMapperDesc  : TnxFieldMapperDescriptor;
                                          out aMapper       : TnxMappingMethod)
                                                            : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  if aSourceField.fdType = nxtWord16 then
    case aTargetField.fdType of
      nxtBoolean:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToBoolean
        else
          aMapper := ToBooleanCheck;
      nxtInt8 :
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt8
        else
          aMapper := ToInt8Check;
      nxtInt16:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt16
        else
          aMapper := ToInt16Check;
      nxtInt32: aMapper := ToInt32;
      nxtInt64: aMapper := ToInt64;
      nxtByte:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToByte8
        else
          aMapper := ToByteCheck;
      nxtWord16: aMapper := ToWord16;
      nxtWord32, nxtAutoInc, nxtRecRev: aMapper := ToWord32;
      nxtSingle   : aMapper := ToSingle;
      nxtDouble   : aMapper := ToDouble;
      nxtExtended : aMapper := ToExtended;

      nxtCurrency : aMapper := ToCurrency;
      nxtBCD      : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);

      nxtByteArray:
        if aTargetField.fdUnits >= SizeOf(TnxWord16) then
          aMapper := ToByteArray;

      nxtChar,
      nxtWideChar,
      nxtNullString,
      nxtShortString,
      nxtWideString   : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
    end;
end;
{------------------------------------------------------------------------------}
function TnxWord16Mapper.ToBcd(const aSource; var aTarget): TnxResult;
begin
  TnxCurrency(aTarget) := TnxWord16(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxWord16Mapper.ToBcdCheck(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
  if nxCurrencyToFmtBcd(TnxWord16(aSource), Bcd, w16mTargetUnits, w16mTargetDecPl) = [] then begin
    nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
    Result := DBIERR_NONE;
  end else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxWord16Mapper.ToBcdTrunc(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
  nxCurrencyToFmtBcd(TnxWord16(aSource), Bcd, w16mTargetUnits, w16mTargetDecPl);
  nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord16Mapper.ToBoolean(const aSource; var aTarget): TnxResult;
begin
  TnxBoolean(aTarget) := TnxWord16(aSource) <> 0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord16Mapper.ToBooleanCheck(const aSource; var aTarget): TnxResult;
begin
  case TnxWord16(aSource) of
    0: TnxBoolean(aTarget) := False;
    1: TnxBoolean(aTarget) := True;
  else
    Result := DBIERR_INVALIDFLDXFORM;
    Exit;
  end;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord16Mapper.ToByte8(const aSource; var aTarget): TnxResult;
begin
  if TnxWord16(aSource) > High(TnxByte8) then
    TnxByte8(aTarget) := High(TnxByte8)
  else
    TnxByte8(aTarget) := TnxWord16(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord16Mapper.ToByteCheck(const aSource; var aTarget): TnxResult;
begin
  if TnxWord16(aSource) > High(TnxByte8) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxByte8(aTarget) := TnxWord16(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxWord16Mapper.ToByteArray(const aSource; var aTarget): TnxResult;
begin
  TnxWord16(aTarget) := TnxWord16(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxWord16Mapper.ToAnsiChar(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxIntToAnsiStr(TnxWord16(aSource));
  if Length(s) > 0 then
    TnxAnsiChar(aTarget) := s[1]
  else
    TnxAnsiChar(aTarget) := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxWord16Mapper.ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  if TnxWord16(aSource) > 9 then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxIntToAnsiStr(TnxWord16(aSource));
    TnxAnsiChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxWord16Mapper.ToCurrency(const aSource; var aTarget): TnxResult;
begin
  TnxCurrency(aTarget) := TnxWord16(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord16Mapper.ToDouble(const aSource; var aTarget): TnxResult;
begin
  TnxDouble(aTarget) := TnxWord16(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord16Mapper.ToExtended(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  TnxExtended(aTarget) := TnxWord16(aSource);
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxWord16Mapper.ToInt16(const aSource; var aTarget): TnxResult;
begin
  if TnxWord16(aSource) > TnxWord16(High(TnxInt16)) then
    TnxInt16(aTarget) := High(TnxInt16)
  else
    TnxInt16(aTarget) := TnxWord16(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord16Mapper.ToInt16Check(const aSource; var aTarget): TnxResult;
begin
  if TnxWord16(aSource) > TnxWord16(High(TnxInt16)) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt16(aTarget) := TnxWord16(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxWord16Mapper.ToInt32(const aSource; var aTarget): TnxResult;
begin
  TnxInt32(aTarget) := TnxWord16(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord16Mapper.ToInt64(const aSource; var aTarget): TnxResult;
begin
  TnxInt64(aTarget) := TnxWord16(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord16Mapper.ToInt8(const aSource; var aTarget): TnxResult;
begin
  if TnxWord16(aSource) > TnxWord16(High(TnxInt8)) then
    TnxInt8(aTarget) := High(TnxInt8)
  else
    TnxInt8(aTarget) := TnxWord16(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord16Mapper.ToInt8Check(const aSource; var aTarget): TnxResult;
begin
  if TnxWord16(aSource) > TnxWord16(High(TnxInt8)) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt8(aTarget) := TnxWord16(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxWord16Mapper.ToNullString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxIntToAnsiStr(TnxWord16(aSource));
  StrPCopy(PAnsiChar(@aTarget), Copy(s, 1, nxMinI32(Length(s), Pred(w16mTargetLength))));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxWord16Mapper.ToNullStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxIntToAnsiStr(TnxWord16(aSource));
  if Length(s) < w16mTargetLength then
    StrPCopy(PAnsiChar(@aTarget), s)
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxWord16Mapper.ToShortString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxIntToAnsiStr(TnxWord16(aSource));
  TnxShStr(aTarget) := Copy(s, 1, nxMinI32(Length(s), w16mTargetLength - 1));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxWord16Mapper.ToShortStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxIntToAnsiStr(TnxWord16(aSource));
  if Length(s) < w16mTargetLength then
    TnxShStr(aTarget) := s
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxWord16Mapper.ToSingle(const aSource; var aTarget): TnxResult;
begin
  TnxSingle(aTarget) := TnxWord16(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxWord16Mapper.ToWideChar(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  s := nxIntToWideStr(TnxWord16(aSource));
  if Length(s) > 0 then
    TnxWideChar(aTarget) := s[1]
  else
    TnxWideChar(aTarget) := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxWord16Mapper.ToWideCharCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  if not (TnxWord16(aSource) in [0..9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxIntToWideStr(TnxWord16(aSource));
    TnxWideChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxWord16Mapper.ToWideString(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  s := nxIntToWideStr(TnxWord16(aSource));
  nxStringToWideChar(s, @aTarget, Pred(w16mTargetLength div SizeOf(WideChar)));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxWord16Mapper.ToWideStringCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  Result := DBIERR_NONE;
  s := nxIntToWideStr(TnxWord16(aSource));
  if Length(s) < w16mTargetLength then
    nxStringToWideChar(s, @aTarget, Pred(w16mTargetLength div SizeOf(WideChar)))
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxWord16Mapper.ToWord16(const aSource; var aTarget): TnxResult;
begin
  TnxWord16(aTarget) := TnxWord16(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord16Mapper.ToWord32(const aSource; var aTarget): TnxResult;
begin
  TnxWord32(aTarget) := TnxWord16(aSource);
  Result := DBIERR_NONE;
end;
{==============================================================================}



{==============================================================================}
constructor TnxWord32Mapper.Create(aSourceField : TnxFieldDescriptor;
                                   aTargetField : TnxFieldDescriptor;
                                   aMapperDesc  : TnxFieldMapperDescriptor;
                               out aMapper      : TnxMappingMethod);
begin
  inherited Create;

  w32mTargetLength := aTargetField.fdLength;
  w32mTargetUnits := aTargetField.fdUnits;
  w32mTargetDecPl := aTargetField.fdDecPl;

  case aTargetField.fdType of
    nxtBcd:
      if w32mTargetUnits - w32mTargetDecPl >= 10 then
        aMapper := ToBcd
      else if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToBcdTrunc
      else
        aMapper := ToBcdCheck;
    nxtChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToAnsiChar
      else
        aMapper := ToAnsiCharCheck;
    nxtWideChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToWideChar
      else
        aMapper := ToWideCharCheck;
    nxtNullString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (w32mTargetLength > Length(nxIntToAnsiStr(High(TnxWord32))))  then
        aMapper := ToNullString
      else
        aMapper := ToNullStringCheck;
    nxtShortString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (w32mTargetLength > Length(nxIntToAnsiStr(High(TnxWord32))))  then
        aMapper := ToShortString
      else
        aMapper := ToShortStringCheck;
    nxtWideString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (w32mTargetLength div SizeOf(WideChar) > Length(nxIntToAnsiStr(High(TnxWord32))))  then
        aMapper := ToWideString
      else
        aMapper := ToWideStringCheck;
    nxtTime:
      aMapper := ToTime;  //..
  end;
end;
{------------------------------------------------------------------------------}
class function TnxWord32Mapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                              aSourceCursor : TnxAbstractCursor;
                                              aTargetField  : TnxFieldDescriptor;
                                              aTargetCursor : TnxAbstractCursor;
                                              aMapperDesc  : TnxFieldMapperDescriptor;
                                          out aMapper       : TnxMappingMethod)
                                                            : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  if aSourceField.fdType in [nxtWord32, nxtAutoInc, nxtRecRev] then
    case aTargetField.fdType of
      nxtBoolean:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToBoolean
        else
          aMapper := ToBooleanCheck;
      nxtInt8 :
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt8
        else
          aMapper := ToInt8Check;
      nxtInt16:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt16
        else
          aMapper := ToInt16Check;
      nxtInt32:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt32
        else
          aMapper := ToInt32Check;
      nxtInt64: aMapper := ToInt64;
      nxtByte:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToByte8
        else
          aMapper := ToByteCheck;
      nxtWord16:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToWord16
        else
          aMapper := ToWord16Check;
      nxtWord32, nxtAutoInc, nxtRecRev: aMapper := ToWord32;
      nxtSingle   : aMapper := ToSingle;
      nxtDouble   : aMapper := ToDouble;
      nxtExtended : aMapper := ToExtended;

      nxtCurrency : aMapper := ToCurrency;
      nxtBCD      : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);

      nxtByteArray:
        if aTargetField.fdUnits >= SizeOf(TnxWord32) then
          aMapper := ToByteArray;

      nxtChar,
      nxtWideChar,
      nxtNullString,
      nxtShortString,
      nxtWideString   : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
      nxtTime : aMapper := ToTime;  //..
    end;
end;
{------------------------------------------------------------------------------}
function TnxWord32Mapper.ToBcd(const aSource; var aTarget): TnxResult;
begin
  TnxCurrency(aTarget) := TnxWord32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxWord32Mapper.ToBcdCheck(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
  if nxCurrencyToFmtBcd(TnxWord32(aSource), Bcd, w32mTargetUnits, w32mTargetDecPl) = [] then begin
    nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
    Result := DBIERR_NONE;
  end else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxWord32Mapper.ToBcdTrunc(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
  nxCurrencyToFmtBcd(TnxWord32(aSource), Bcd, w32mTargetUnits, w32mTargetDecPl);
  nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord32Mapper.ToBoolean(const aSource; var aTarget): TnxResult;
begin
  TnxBoolean(aTarget) := TnxWord32(aSource) <> 0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord32Mapper.ToBooleanCheck(const aSource; var aTarget): TnxResult;
begin
  case TnxWord32(aSource) of
    0: TnxBoolean(aTarget) := False;
    1: TnxBoolean(aTarget) := True;
  else
    Result := DBIERR_INVALIDFLDXFORM;
    Exit;
  end;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord32Mapper.ToByte8(const aSource; var aTarget): TnxResult;
begin
  if TnxWord32(aSource) > High(TnxByte8) then
    TnxByte8(aTarget) := High(TnxByte8)
  else
    TnxByte8(aTarget) := TnxWord32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord32Mapper.ToByteCheck(const aSource; var aTarget): TnxResult;
begin
  if TnxWord32(aSource) > High(TnxByte8) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxByte8(aTarget) := TnxWord32(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxWord32Mapper.ToTime(const aSource; var aTarget): TnxResult; //..
begin
  TnxTime(aTarget) := TnxWord32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord32Mapper.ToByteArray(const aSource; var aTarget): TnxResult;
begin
  TnxWord32(aTarget) := TnxWord32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxWord32Mapper.ToAnsiChar(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxIntToAnsiStr(TnxWord32(aSource));
  if Length(s) > 0 then
    TnxAnsiChar(aTarget) := s[1]
  else
    TnxAnsiChar(aTarget) := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxWord32Mapper.ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  if TnxWord32(aSource) > 9 then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxIntToAnsiStr(TnxWord32(aSource));
    TnxAnsiChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxWord32Mapper.ToCurrency(const aSource; var aTarget): TnxResult;
begin
  TnxCurrency(aTarget) := TnxWord32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord32Mapper.ToDouble(const aSource; var aTarget): TnxResult;
begin
  TnxDouble(aTarget) := TnxWord32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord32Mapper.ToExtended(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  TnxExtended(aTarget) := TnxWord32(aSource);
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxWord32Mapper.ToInt16(const aSource; var aTarget): TnxResult;
begin
  if TnxWord32(aSource) > TnxWord32(High(TnxInt16)) then
    TnxInt16(aTarget) := High(TnxInt16)
  else
    TnxInt16(aTarget) := TnxWord32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord32Mapper.ToInt16Check(const aSource; var aTarget): TnxResult;
begin
  if TnxWord32(aSource) > TnxWord32(High(TnxInt16)) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt16(aTarget) := TnxWord32(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxWord32Mapper.ToInt32(const aSource; var aTarget): TnxResult;
begin
  if TnxWord32(aSource) > TnxWord32(High(TnxInt32)) then
    TnxInt32(aTarget) := High(TnxInt32)
  else
    TnxInt32(aTarget) := TnxWord32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord32Mapper.ToInt32Check(const aSource; var aTarget): TnxResult;
begin
  if TnxWord32(aSource) > TnxWord32(High(TnxInt32)) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt32(aTarget) := TnxWord32(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxWord32Mapper.ToInt64(const aSource; var aTarget): TnxResult;
begin
  TnxInt64(aTarget) := TnxWord32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord32Mapper.ToInt8(const aSource; var aTarget): TnxResult;
begin
  if TnxWord32(aSource) > TnxWord32(High(TnxInt8)) then
    TnxInt8(aTarget) := High(TnxInt8)
  else
    TnxInt8(aTarget) := TnxWord32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord32Mapper.ToInt8Check(const aSource; var aTarget): TnxResult;
begin
  if TnxWord32(aSource) > TnxWord32(High(TnxInt8)) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt8(aTarget) := TnxWord32(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxWord32Mapper.ToNullString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxIntToAnsiStr(TnxWord32(aSource));
  StrPCopy(PAnsiChar(@aTarget), Copy(s, 1, nxMinI32(Length(s), Pred(w32mTargetLength))));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxWord32Mapper.ToNullStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxIntToAnsiStr(TnxWord32(aSource));
  if Length(s) < w32mTargetLength then
    StrPCopy(PAnsiChar(@aTarget), s)
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxWord32Mapper.ToShortString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxIntToAnsiStr(TnxWord32(aSource));
  TnxShStr(aTarget) := Copy(s, 1, nxMinI32(Length(s), w32mTargetLength - 1));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxWord32Mapper.ToShortStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxIntToAnsiStr(TnxWord32(aSource));
  if Length(s) < w32mTargetLength then
    TnxShStr(aTarget) := s
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxWord32Mapper.ToSingle(const aSource; var aTarget): TnxResult;
begin
  TnxSingle(aTarget) := TnxWord32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxWord32Mapper.ToWideChar(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  s := nxIntToWideStr(TnxWord32(aSource));
  if Length(s) > 0 then
    TnxWideChar(aTarget) := s[1]
  else
    TnxWideChar(aTarget) := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxWord32Mapper.ToWideCharCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  if not (TnxWord32(aSource) in [0..9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxIntToWideStr(TnxWord32(aSource));
    TnxWideChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxWord32Mapper.ToWideString(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  s := nxIntToWideStr(TnxWord32(aSource));
  nxStringToWideChar(s, @aTarget, Pred(w32mTargetLength div SizeOf(WideChar)));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxWord32Mapper.ToWideStringCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  Result := DBIERR_NONE;
  s := nxIntToWideStr(TnxWord32(aSource));
  if Length(s) < w32mTargetLength then
    nxStringToWideChar(s, @aTarget, Pred(w32mTargetLength div SizeOf(WideChar)))
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxWord32Mapper.ToWord16(const aSource; var aTarget): TnxResult;
begin
  if TnxWord32(aSource) > High(TnxWord16) then
    TnxWord16(aTarget) := High(TnxWord16)
  else
    TnxWord16(aTarget) := TnxWord32(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWord32Mapper.ToWord16Check(const aSource; var aTarget): TnxResult;
begin
  if TnxWord32(aSource) > High(TnxWord16) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxWord16(aTarget) := TnxWord32(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxWord32Mapper.ToWord32(const aSource; var aTarget): TnxResult;
begin
  TnxWord32(aTarget) := TnxWord32(aSource);
  Result := DBIERR_NONE;
end;
{==============================================================================}


{==============================================================================}
constructor TnxSingleMapper.Create(aSourceField : TnxFieldDescriptor;
                                   aTargetField : TnxFieldDescriptor;
                                   aMapperDesc  : TnxFieldMapperDescriptor;
                               out aMapper      : TnxMappingMethod);
const
  MaxNegSingle = -3.4E38;
begin
  inherited Create;

  if Assigned(aTargetField.UsedLocaleDescriptor) then
    GetLocaleFormatSettings(aTargetField.UsedLocaleDescriptor.Locale, smFormatSettings)
  else
    GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, smFormatSettings);

  smTargetLength := aTargetField.fdLength;
  smTargetUnits := aTargetField.fdUnits;
  smTargetDecPl := aTargetField.fdDecPl;

  case aTargetField.fdType of
    nxtBcd:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToBcdTrunc
      else
        aMapper := ToBcdCheck;
    nxtChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToAnsiChar
      else
        aMapper := ToAnsiCharCheck;
    nxtWideChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToWideChar
      else
        aMapper := ToWideCharCheck;
    nxtNullString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (smTargetLength > Length(nxFloatToAnsiStr(MaxNegSingle, smFormatSettings)))  then
        aMapper := ToNullString
      else
        aMapper := ToNullStringCheck;
    nxtShortString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (smTargetLength > Length(nxFloatToAnsiStr(MaxNegSingle, smFormatSettings)))  then
        aMapper := ToShortString
      else
        aMapper := ToShortStringCheck;
    nxtWideString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (smTargetLength div SizeOf(WideChar) > Length(nxFloatToAnsiStr(MaxNegSingle, smFormatSettings)))  then
        aMapper := ToWideString
      else
        aMapper := ToWideStringCheck;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                               aSourceCursor : TnxAbstractCursor;
                                               aTargetField  : TnxFieldDescriptor;
                                               aTargetCursor : TnxAbstractCursor;
                                               aMapperDesc  : TnxFieldMapperDescriptor;
                                           out aMapper       : TnxMappingMethod)
                                                             : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  if aSourceField.fdType = nxtSingle then
    case aTargetField.fdType of
      nxtBoolean:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToBoolean
        else
          aMapper := ToBooleanCheck;
      nxtInt8 :
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt8
        else
          aMapper := ToInt8Check;
      nxtInt16:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt16
        else
          aMapper := ToInt16Check;
      nxtInt32:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt32
        else
          aMapper := ToInt32Check;
      nxtInt64:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt64
        else
          aMapper := ToInt64Check;
      nxtByte:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToByte8
        else
          aMapper := ToByteCheck;
      nxtWord16:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToWord16
        else
          aMapper := ToWord16Check;
      nxtWord32, nxtAutoInc, nxtRecRev:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToWord32
        else
          aMapper := ToWord32Check;
      nxtSingle   : aMapper := ToSingle;
      nxtDouble   : aMapper := ToDouble;
      nxtExtended : aMapper := ToExtended;

      nxtCurrency :
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToCurrency
        else
          aMapper := ToCurrencyCheck;
      nxtBCD      : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);

      nxtByteArray:
        if aTargetField.fdUnits >= SizeOf(TnxSingle) then
          aMapper := ToByteArray;

      nxtChar,
      nxtWideChar,
      nxtNullString,
      nxtShortString,
      nxtWideString   : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
    end;
end;
{------------------------------------------------------------------------------}
function TnxSingleMapper.ToBcdCheck(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
  if nxNormalizeBcd(nxDoubleToFmtBcd(TnxSingle(aSource)), Bcd, smTargetUnits, smTargetDecPl) <> [] then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxSingleMapper.ToBcdTrunc(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
  nxNormalizeBcd(nxDoubleToFmtBcd(TnxSingle(aSource)), Bcd, smTargetUnits, smTargetDecPl);
  nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToBoolean(const aSource; var aTarget): TnxResult;
begin
  TnxBoolean(aTarget) := not SameValue(TnxSingle(aSource), 0);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToBooleanCheck(const aSource; var aTarget): TnxResult;
begin
  TnxBoolean(aTarget) := not SameValue(TnxSingle(aSource), 0);
  if TnxBoolean(aTarget) and (not SameValue(TnxSingle(aSource), 1)) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToByte8(const aSource; var aTarget): TnxResult;
begin
  if TnxSingle(aSource) < Low(TnxByte8) then
    TnxByte8(aTarget) := Low(TnxByte8)
  else if TnxSingle(aSource) > High(TnxByte8) then
    TnxByte8(aTarget) := High(TnxByte8)
  else
    TnxByte8(aTarget) := Round(TnxSingle(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToByteCheck(const aSource; var aTarget): TnxResult;
begin
  if (TnxSingle(aSource) < Low(TnxByte8)) or
    (TnxSingle(aSource) > High(TnxByte8)) or
    not SameValue(Frac(TnxSingle(aSource)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxByte8(aTarget) := Round(TnxSingle(aSource));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToByteArray(const aSource; var aTarget): TnxResult;
begin
  TnxSingle(aTarget) := TnxSingle(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxSingleMapper.ToAnsiChar(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxFloatToAnsiStr(TnxSingle(aSource), smFormatSettings);
  if Length(s) > 0 then
    TnxAnsiChar(aTarget) := s[1]
  else
    TnxAnsiChar(aTarget) := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxSingleMapper.ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  if (TnxSingle(aSource) < 0) or (TnxSingle(aSource) > 9) or (Frac(TnxSingle(aSource)) <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxFloatToAnsiStr(TnxSingle(aSource), smFormatSettings);
    TnxAnsiChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToCurrency(const aSource; var aTarget): TnxResult;
begin
  if TnxSingle(aSource) < MinCurrency then
    TnxCurrency(aTarget) := MinCurrency
  else if TnxSingle(aSource) > MaxCurrency then
    TnxCurrency(aTarget) := MaxCurrency
  else
    TnxCurrency(aTarget) := TnxSingle(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToCurrencyCheck(const aSource; var aTarget): TnxResult;
begin
  if (TnxSingle(aSource) < MinCurrency) or
    (TnxSingle(aSource) > MaxCurrency) or
    not SameValue(Frac(TnxSingle(aSource) * 10000), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxCurrency(aTarget) := TnxSingle(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToDouble(const aSource; var aTarget): TnxResult;
begin
  TnxDouble(aTarget) := TnxSingle(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToExtended(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  TnxExtended(aTarget) := TnxSingle(aSource);
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToInt16(const aSource; var aTarget): TnxResult;
begin
  if TnxSingle(aSource) < Low(TnxInt16) then
    TnxInt16(aTarget) := Low(TnxInt16)
  else if TnxSingle(aSource) > High(TnxInt16) then
    TnxInt16(aTarget) := High(TnxInt16)
  else
    TnxInt16(aTarget) := Round(TnxSingle(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToInt16Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxSingle(aSource) < Low(TnxInt16)) or
    (TnxSingle(aSource) > High(TnxInt16)) or
    not SameValue(Frac(TnxSingle(aSource)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt16(aTarget) := Round(TnxSingle(aSource));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToInt32(const aSource; var aTarget): TnxResult;
begin
  if TnxSingle(aSource) < Low(TnxInt32) then
    TnxInt32(aTarget) := Low(TnxInt32)
  else if TnxSingle(aSource) > High(TnxInt32) then
    TnxInt32(aTarget) := High(TnxInt32)
  else
    TnxInt32(aTarget) := Round(TnxSingle(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToInt32Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxSingle(aSource) < Low(TnxInt32)) or
    (TnxSingle(aSource) > High(TnxInt32)) or
    not SameValue(Frac(TnxSingle(aSource)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt32(aTarget) := Round(TnxSingle(aSource));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToInt64(const aSource; var aTarget): TnxResult;
begin
  if TnxSingle(aSource) < Low(TnxInt64) then
    TnxInt64(aTarget) := Low(TnxInt64)
  else if TnxSingle(aSource) > High(TnxInt64) then
    TnxInt64(aTarget) := High(TnxInt64)
  else
    TnxInt64(aTarget) := Round(TnxSingle(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToInt64Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxSingle(aSource) < Low(TnxInt64)) or
    (TnxSingle(aSource) > High(TnxInt64)) or
    not SameValue(Frac(TnxSingle(aSource)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt64(aTarget) := Round(TnxSingle(aSource));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToInt8(const aSource; var aTarget): TnxResult;
begin
  if TnxSingle(aSource) < Low(TnxInt8) then
    TnxInt8(aTarget) := Low(TnxInt8)
  else if TnxSingle(aSource) > High(TnxInt8) then
    TnxInt8(aTarget) := High(TnxInt8)
  else
    TnxInt8(aTarget) := Round(TnxSingle(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToInt8Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxSingle(aSource) < Low(TnxInt8)) or
    (TnxSingle(aSource) > High(TnxInt8)) or
    not SameValue(Frac(TnxSingle(aSource)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt8(aTarget) := Round(TnxSingle(aSource));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxSingleMapper.ToNullString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxFloatToAnsiStr(TnxSingle(aSource), smFormatSettings);
  StrPCopy(PAnsiChar(@aTarget), Copy(s, 1, nxMinI32(Length(s), Pred(smTargetLength))));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxSingleMapper.ToNullStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxFloatToAnsiStr(TnxSingle(aSource), smFormatSettings);
  if Length(s) < smTargetLength then
    StrPCopy(PAnsiChar(@aTarget), s)
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxSingleMapper.ToShortString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxFloatToAnsiStr(TnxSingle(aSource), smFormatSettings);
  TnxShStr(aTarget) := Copy(s, 1, nxMinI32(Length(s), smTargetLength - 1));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxSingleMapper.ToShortStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxFloatToAnsiStr(TnxSingle(aSource), smFormatSettings);
  if Length(s) < smTargetLength then
    TnxShStr(aTarget) := s
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToSingle(const aSource; var aTarget): TnxResult;
begin
  TnxSingle(aTarget) := TnxSingle(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxSingleMapper.ToWideChar(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  s := nxFloatToWideStr(TnxSingle(aSource), smFormatSettings);
  if Length(s) > 0 then
    TnxWideChar(aTarget) := s[1]
  else
    TnxWideChar(aTarget) := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxSingleMapper.ToWideCharCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  if (TnxSingle(aSource) < 0) or (TnxSingle(aSource) > 9) or (Frac(TnxSingle(aSource)) <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxFloatToWideStr(Trunc(TnxSingle(aSource)), smFormatSettings);
    TnxWideChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxSingleMapper.ToWideString(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  s := nxFloatToWideStr(TnxSingle(aSource), smFormatSettings);
  nxStringToWideChar(s, @aTarget, Pred(smTargetLength div SizeOf(WideChar)));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxSingleMapper.ToWideStringCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  Result := DBIERR_NONE;
  s := nxFloatToWideStr(TnxSingle(aSource), smFormatSettings);
  if Length(s) < smTargetLength then
    nxStringToWideChar(s, @aTarget, Pred(smTargetLength div SizeOf(WideChar)))
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToWord16(const aSource; var aTarget): TnxResult;
begin
  if TnxSingle(aSource) < Low(TnxWord16) then
    TnxWord16(aTarget) := Low(TnxWord16)
  else if TnxSingle(aSource) > High(TnxWord16) then
    TnxWord16(aTarget) := High(TnxWord16)
  else
    TnxWord16(aTarget) := Round(TnxSingle(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToWord16Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxSingle(aSource) < Low(TnxWord16)) or
    (TnxSingle(aSource) > High(TnxWord16)) or
    not SameValue(Frac(TnxSingle(aSource)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxWord16(aTarget) := Round(TnxSingle(aSource));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToWord32(const aSource; var aTarget): TnxResult;
begin
  if TnxSingle(aSource) < Low(TnxWord32) then
    TnxWord32(aTarget) := Low(TnxWord32)
  else if TnxSingle(aSource) > High(TnxWord32) then
    TnxWord32(aTarget) := High(TnxWord32)
  else
    TnxWord32(aTarget) := Round(TnxSingle(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxSingleMapper.ToWord32Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxSingle(aSource) < Low(TnxWord32)) or
    (TnxSingle(aSource) > High(TnxWord32)) or
    not SameValue(Frac(TnxSingle(aSource)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxWord32(aTarget) := Round(TnxSingle(aSource));
    Result := DBIERR_NONE;
  end;
end;
{==============================================================================}



{==============================================================================}
constructor TnxDoubleMapper.Create(aSourceField : TnxFieldDescriptor;
                                   aTargetField : TnxFieldDescriptor;
                                   aMapperDesc  : TnxFieldMapperDescriptor;
                               out aMapper      : TnxMappingMethod);
const
  MaxNegDouble = -1.7E308;
begin
  inherited Create;

  if Assigned(aTargetField.UsedLocaleDescriptor) then
    GetLocaleFormatSettings(aTargetField.UsedLocaleDescriptor.Locale, dmFormatSettings)
  else
    GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, dmFormatSettings);

  dmTargetLength := aTargetField.fdLength;
  dmTargetUnits := aTargetField.fdUnits;
  dmTargetDecPl := aTargetField.fdDecPl;

  case aTargetField.fdType of
    nxtBcd:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToBcdTrunc
      else
        aMapper := ToBcdCheck;
    nxtChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToAnsiChar
      else
        aMapper := ToAnsiCharCheck;
    nxtWideChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToWideChar
      else
        aMapper := ToWideCharCheck;
    nxtNullString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (dmTargetLength > Length(nxFloatToAnsiStr(MaxNegDouble, dmFormatSettings)))  then
        aMapper := ToNullString
      else
        aMapper := ToNullStringCheck;
    nxtShortString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (dmTargetLength > Length(nxFloatToAnsiStr(MaxNegDouble, dmFormatSettings)))  then
        aMapper := ToShortString
      else
        aMapper := ToShortStringCheck;
    nxtWideString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (dmTargetLength div SizeOf(WideChar) > Length(nxFloatToAnsiStr(MaxNegDouble, dmFormatSettings)))  then
        aMapper := ToWideString
      else
        aMapper := ToWideStringCheck;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                               aSourceCursor : TnxAbstractCursor;
                                               aTargetField  : TnxFieldDescriptor;
                                               aTargetCursor : TnxAbstractCursor;
                                               aMapperDesc  : TnxFieldMapperDescriptor;
                                           out aMapper       : TnxMappingMethod)
                                                             : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  if aSourceField.fdType = nxtDouble then
    case aTargetField.fdType of
      nxtBoolean:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToBoolean
        else
          aMapper := ToBooleanCheck;
      nxtInt8 :
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt8
        else
          aMapper := ToInt8Check;
      nxtInt16:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt16
        else
          aMapper := ToInt16Check;
      nxtInt32:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt32
        else
          aMapper := ToInt32Check;
      nxtInt64:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt64
        else
          aMapper := ToInt64Check;
      nxtByte:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToByte8
        else
          aMapper := ToByteCheck;
      nxtWord16:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToWord16
        else
          aMapper := ToWord16Check;
      nxtWord32, nxtAutoInc, nxtRecRev:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToWord32
        else
          aMapper := ToWord32Check;
      nxtSingle   :
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToSingle
        else
          aMapper := ToSingleCheck;
      nxtDouble   : aMapper := ToDouble;
      nxtExtended : aMapper := ToExtended;

      nxtDateTime : aMapper := ToDateTime;

      nxtCurrency :
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToCurrency
        else
          aMapper := ToCurrencyCheck;
      nxtBCD      : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);

      nxtByteArray:
        if aTargetField.fdUnits >= SizeOf(TnxDouble) then
          aMapper := ToByteArray;

      nxtChar,
      nxtWideChar,
      nxtNullString,
      nxtShortString,
      nxtWideString   : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
    end;
end;
{------------------------------------------------------------------------------}
function TnxDoubleMapper.ToBcdCheck(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
  if nxNormalizeBcd(nxDoubleToFmtBcd(TnxDouble(aSource)), Bcd, dmTargetUnits, dmTargetDecPl) <> [] then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDoubleMapper.ToBcdTrunc(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
     try  //..
       nxNormalizeBcd(nxDoubleToFmtBcd(TnxDouble(aSource)), Bcd, dmTargetUnits, dmTargetDecPl);
       nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
     except
       TnxCurrency(aTarget) := 0.0;
     end;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToBoolean(const aSource; var aTarget): TnxResult;
begin
  TnxBoolean(aTarget) := not SameValue(TnxDouble(aSource), 0);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToBooleanCheck(const aSource; var aTarget): TnxResult;
begin
  TnxBoolean(aTarget) := not SameValue(TnxDouble(aSource), 0);
  if TnxBoolean(aTarget) and (not SameValue(TnxDouble(aSource), 1)) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToByte8(const aSource; var aTarget): TnxResult;
begin
  if TnxDouble(aSource) < Low(TnxByte8) then
    TnxByte8(aTarget) := Low(TnxByte8)
  else if TnxDouble(aSource) > High(TnxByte8) then
    TnxByte8(aTarget) := High(TnxByte8)
  else
    TnxByte8(aTarget) := Round(TnxDouble(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToByteCheck(const aSource; var aTarget): TnxResult;
begin
  if (TnxDouble(aSource) < Low(TnxByte8)) or
    (TnxDouble(aSource) > High(TnxByte8)) or
    not SameValue(Frac(TnxDouble(aSource)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxByte8(aTarget) := Round(TnxDouble(aSource));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToByteArray(const aSource; var aTarget): TnxResult;
begin
  TnxDouble(aTarget) := TnxDouble(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxDoubleMapper.ToAnsiChar(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxFloatToAnsiStr(TnxDouble(aSource), dmFormatSettings);
  if Length(s) > 0 then
    TnxAnsiChar(aTarget) := s[1]
  else
    TnxAnsiChar(aTarget) := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxDoubleMapper.ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  if (TnxDouble(aSource) < 0) or (TnxDouble(aSource) > 9) or (Frac(TnxDouble(aSource)) <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxFloatToAnsiStr(TnxDouble(aSource), dmFormatSettings);
    TnxAnsiChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToCurrency(const aSource; var aTarget): TnxResult;
begin
  try  //..
    If   TnxDouble(aSource) < MinCurrency
    then TnxCurrency(aTarget) := MinCurrency
    else If   TnxDouble(aSource) > MaxCurrency
         then TnxCurrency(aTarget) := MaxCurrency
         else TnxCurrency(aTarget) := TnxDouble(aSource);
  except
    TnxCurrency(aTarget) := 0.0;
  end; //..
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToCurrencyCheck(const aSource; var aTarget): TnxResult;
begin
  if (TnxDouble(aSource) < MinCurrency) or
    (TnxDouble(aSource) > MaxCurrency) or
    not SameValue(Frac(TnxDouble(aSource) * 10000), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxCurrency(aTarget) := TnxDouble(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToDateTime(const aSource; var aTarget): TnxResult;
var
  TimeStamp : TTimeStamp;
begin
  TimeStamp := DateTimeToTimeStamp(TDateTime(aSource));
  TnxDateTime(aTarget) := TimeStampToMSecs(TimeStamp);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToDouble(const aSource; var aTarget): TnxResult;
begin
  TnxDouble(aTarget) := TnxDouble(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToExtended(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  TnxExtended(aTarget) := TnxDouble(aSource);
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToInt16(const aSource; var aTarget): TnxResult;
begin
  if TnxDouble(aSource) < Low(TnxInt16) then
    TnxInt16(aTarget) := Low(TnxInt16)
  else if TnxDouble(aSource) > High(TnxInt16) then
    TnxInt16(aTarget) := High(TnxInt16)
  else
    TnxInt16(aTarget) := Round(TnxDouble(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToInt16Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxDouble(aSource) < Low(TnxInt16)) or
    (TnxDouble(aSource) > High(TnxInt16)) or
    not SameValue(Frac(TnxDouble(aSource)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt16(aTarget) := Round(TnxDouble(aSource));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToInt32(const aSource; var aTarget): TnxResult;
begin
  if TnxDouble(aSource) < Low(TnxInt32) then
    TnxInt32(aTarget) := Low(TnxInt32)
  else if TnxDouble(aSource) > High(TnxInt32) then
    TnxInt32(aTarget) := High(TnxInt32)
  else
    TnxInt32(aTarget) := Round(TnxDouble(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToInt32Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxDouble(aSource) < Low(TnxInt32)) or
    (TnxDouble(aSource) > High(TnxInt32)) or
    not SameValue(Frac(TnxDouble(aSource)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt32(aTarget) := Round(TnxDouble(aSource));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToInt64(const aSource; var aTarget): TnxResult;
begin
  if TnxDouble(aSource) < Low(TnxInt64) then
    TnxInt64(aTarget) := Low(TnxInt64)
  else if TnxDouble(aSource) > High(TnxInt64) then
    TnxInt64(aTarget) := High(TnxInt64)
  else
    TnxInt64(aTarget) := Round(TnxDouble(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToInt64Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxDouble(aSource) < Low(TnxInt64)) or
    (TnxDouble(aSource) > High(TnxInt64)) or
    not SameValue(Frac(TnxDouble(aSource)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt64(aTarget) := Round(TnxDouble(aSource));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToInt8(const aSource; var aTarget): TnxResult;
begin
  if TnxDouble(aSource) < Low(TnxInt8) then
    TnxInt8(aTarget) := Low(TnxInt8)
  else if TnxDouble(aSource) > High(TnxInt8) then
    TnxInt8(aTarget) := High(TnxInt8)
  else
    TnxInt8(aTarget) := Round(TnxDouble(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToInt8Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxDouble(aSource) < Low(TnxInt8)) or
    (TnxDouble(aSource) > High(TnxInt8)) or
    not SameValue(Frac(TnxDouble(aSource)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt8(aTarget) := Round(TnxDouble(aSource));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDoubleMapper.ToNullString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxFloatToAnsiStr(TnxDouble(aSource), dmFormatSettings);
  StrPCopy(PAnsiChar(@aTarget), Copy(s, 1, nxMinI32(Length(s), Pred(dmTargetLength))));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxDoubleMapper.ToNullStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxFloatToAnsiStr(TnxDouble(aSource), dmFormatSettings);
  if Length(s) < dmTargetLength then
    StrPCopy(PAnsiChar(@aTarget), s)
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxDoubleMapper.ToShortString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxFloatToAnsiStr(TnxDouble(aSource), dmFormatSettings);
  TnxShStr(aTarget) := Copy(s, 1, nxMinI32(Length(s), dmTargetLength - 1));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxDoubleMapper.ToShortStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxFloatToAnsiStr(TnxDouble(aSource), dmFormatSettings);
  if Length(s) < dmTargetLength then
    TnxShStr(aTarget) := s
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToSingle(const aSource; var aTarget): TnxResult;
begin
  if Abs(TnxDouble(aSource)) > MaxSingle then
    TnxSingle(aTarget) := MaxSingle
  else
    TnxSingle(aTarget) := TnxDouble(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToSingleCheck(const aSource; var aTarget): TnxResult;
begin
  if ((TnxDouble(aSource) <> 0) and
      (Abs(TnxDouble(aSource)) < MinSingle)) or
     (Abs(TnxDouble(aSource)) > MaxSingle) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxSingle(aTarget) := TnxDouble(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDoubleMapper.ToWideChar(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  s := nxFloatToWideStr(TnxDouble(aSource), dmFormatSettings);
  if Length(s) > 0 then
    TnxWideChar(aTarget) := s[1]
  else
    TnxWideChar(aTarget) := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxDoubleMapper.ToWideCharCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  if (TnxDouble(aSource) < 0) or (TnxDouble(aSource) > 9) or (Frac(TnxDouble(aSource)) <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxFloatToWideStr(Trunc(TnxDouble(aSource)), dmFormatSettings);
    TnxWideChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDoubleMapper.ToWideString(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  s := nxFloatToWideStr(TnxDouble(aSource), dmFormatSettings);
  nxStringToWideChar(s, @aTarget, Pred(dmTargetLength div SizeOf(WideChar)));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxDoubleMapper.ToWideStringCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  Result := DBIERR_NONE;
  s := nxFloatToWideStr(TnxDouble(aSource), dmFormatSettings);
  if Length(s) < dmTargetLength then
    nxStringToWideChar(s, @aTarget, Pred(dmTargetLength div SizeOf(WideChar)))
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToWord16(const aSource; var aTarget): TnxResult;
begin
  if TnxDouble(aSource) < Low(TnxWord16) then
    TnxWord16(aTarget) := Low(TnxWord16)
  else if TnxDouble(aSource) > High(TnxWord16) then
    TnxWord16(aTarget) := High(TnxWord16)
  else
    TnxWord16(aTarget) := Round(TnxDouble(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToWord16Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxDouble(aSource) < Low(TnxWord16)) or
    (TnxDouble(aSource) > High(TnxWord16)) or
    not SameValue(Frac(TnxDouble(aSource)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxWord16(aTarget) := Round(TnxDouble(aSource));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToWord32(const aSource; var aTarget): TnxResult;
begin
  if TnxDouble(aSource) < Low(TnxWord32) then
    TnxWord32(aTarget) := Low(TnxWord32)
  else if TnxDouble(aSource) > High(TnxWord32) then
    TnxWord32(aTarget) := High(TnxWord32)
  else
    TnxWord32(aTarget) := Round(TnxDouble(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxDoubleMapper.ToWord32Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxDouble(aSource) < Low(TnxWord32)) or
    (TnxDouble(aSource) > High(TnxWord32)) or
    not SameValue(Frac(TnxDouble(aSource)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxWord32(aTarget) := Round(TnxDouble(aSource));
    Result := DBIERR_NONE;
  end;
end;
{==============================================================================}



{==============================================================================}
constructor TnxExtendedMapper.Create(aSourceField : TnxFieldDescriptor;
                                     aTargetField : TnxFieldDescriptor;
                                     aMapperDesc  : TnxFieldMapperDescriptor;
                                 out aMapper      : TnxMappingMethod);
const
  MaxNegExtended = -1.7E308;
begin
  inherited Create;

  if Assigned(aTargetField.UsedLocaleDescriptor) then
    GetLocaleFormatSettings(aTargetField.UsedLocaleDescriptor.Locale, emFormatSettings)
  else
    GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, emFormatSettings);

  emTargetLength := aTargetField.fdLength;
  emTargetUnits := aTargetField.fdUnits;
  emTargetDecPl := aTargetField.fdDecPl;

  case aTargetField.fdType of
    nxtBcd:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToBcdTrunc
      else
        aMapper := ToBcdCheck;
    nxtChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToAnsiChar
      else
        aMapper := ToAnsiCharCheck;
    nxtWideChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToWideChar
      else
        aMapper := ToWideCharCheck;
    nxtNullString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (emTargetLength > Length(nxFloatToAnsiStr(MaxNegExtended, emFormatSettings)))  then
        aMapper := ToNullString
      else
        aMapper := ToNullStringCheck;
    nxtShortString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (emTargetLength > Length(nxFloatToAnsiStr(MaxNegExtended, emFormatSettings)))  then
        aMapper := ToShortString
      else
        aMapper := ToShortStringCheck;
    nxtWideString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (emTargetLength div SizeOf(WideChar) > Length(nxFloatToAnsiStr(MaxNegExtended, emFormatSettings)))  then
        aMapper := ToWideString
      else
        aMapper := ToWideStringCheck;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                                      aSourceCursor : TnxAbstractCursor;
                                                      aTargetField  : TnxFieldDescriptor;
                                                      aTargetCursor : TnxAbstractCursor;
                                                      aMapperDesc   : TnxFieldMapperDescriptor;
                                                  out aMapper       : TnxMappingMethod)
                                                                    : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  if aSourceField.fdType = nxtExtended then
    case aTargetField.fdType of
      nxtBoolean:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToBoolean
        else
          aMapper := ToBooleanCheck;
      nxtInt8 :
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt8
        else
          aMapper := ToInt8Check;
      nxtInt16:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt16
        else
          aMapper := ToInt16Check;
      nxtInt32:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt32
        else
          aMapper := ToInt32Check;
      nxtInt64:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt64
        else
          aMapper := ToInt64Check;
      nxtByte:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToByte8
        else
          aMapper := ToByteCheck;
      nxtWord16:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToWord16
        else
          aMapper := ToWord16Check;
      nxtWord32, nxtAutoInc, nxtRecRev:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToWord32
        else
          aMapper := ToWord32Check;
      nxtSingle   :
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToSingle
        else
          aMapper := ToSingleCheck;
      nxtDouble   :
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToDouble
        else
          aMapper := ToDoubleCheck;
      nxtExtended : aMapper := ToExtended;

      nxtCurrency :
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToCurrency
        else
          aMapper := ToCurrencyCheck;
      nxtBCD      : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);

      nxtByteArray:
        if aTargetField.fdUnits >= SizeOf(TnxExtended) then
          aMapper := ToByteArray;

      nxtChar,
      nxtWideChar,
      nxtNullString,
      nxtShortString,
      nxtWideString   : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
    end;
end;
{------------------------------------------------------------------------------}
function TnxExtendedMapper.ToBcdCheck(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
  {$IFNDEF FPC}
  if nxNormalizeBcd(nxDoubleToFmtBcd(TnxExtended(aSource)), Bcd, emTargetUnits, emTargetDecPl) <> [] then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
    Result := DBIERR_NONE;
  end;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxExtendedMapper.ToBcdTrunc(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
  {$IFNDEF FPC}
  nxNormalizeBcd(nxDoubleToFmtBcd(TnxExtended(aSource)), Bcd, emTargetUnits, emTargetDecPl);
  nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToBoolean(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  TnxBoolean(aTarget) := not SameValue(TnxExtended(aSource), 0);
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToBooleanCheck(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  TnxBoolean(aTarget) := not SameValue(TnxExtended(aSource), 0);
  if TnxBoolean(aTarget) and (not SameValue(TnxExtended(aSource), 1)) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToByte8(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if TnxExtended(aSource) < Low(TnxByte8) then
    TnxByte8(aTarget) := Low(TnxByte8)
  else if TnxExtended(aSource) > High(TnxByte8) then
    TnxByte8(aTarget) := High(TnxByte8)
  else
    TnxByte8(aTarget) := Round(TnxExtended(aSource));
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToByteCheck(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if (TnxExtended(aSource) < Low(TnxByte8)) or
    (TnxExtended(aSource) > High(TnxByte8)) or
    not SameValue(Frac(TnxExtended(aSource)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxByte8(aTarget) := Round(TnxExtended(aSource));
    Result := DBIERR_NONE;
  end;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToByteArray(const aSource; var aTarget): TnxResult;
begin
  TnxExtended(aTarget) := TnxExtended(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxExtendedMapper.ToAnsiChar(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  {$IFNDEF FPC}
  s := nxFloatToAnsiStr(TnxExtended(aSource), emFormatSettings);
  if Length(s) > 0 then
    TnxAnsiChar(aTarget) := s[1]
  else
    TnxAnsiChar(aTarget) := #0;
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxExtendedMapper.ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  {$IFNDEF FPC}
  if (TnxExtended(aSource) < 0) or (TnxExtended(aSource) > 9) or (Frac(TnxExtended(aSource)) <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxFloatToAnsiStr(TnxExtended(aSource), emFormatSettings);
    TnxAnsiChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToCurrency(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if TnxExtended(aSource) < MinCurrency then
    TnxCurrency(aTarget) := MinCurrency
  else if TnxExtended(aSource) > MaxCurrency then
    TnxCurrency(aTarget) := MaxCurrency
  else
    TnxCurrency(aTarget) := TnxExtended(aSource);
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToCurrencyCheck(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if (TnxExtended(aSource) < MinCurrency) or
    (TnxExtended(aSource) > MaxCurrency) or
    not SameValue(Frac(TnxExtended(aSource) * 10000), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxCurrency(aTarget) := TnxExtended(aSource);
    Result := DBIERR_NONE;
  end;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToDouble(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if Abs(TnxExtended(aSource)) > MaxDouble then
    TnxDouble(aTarget) := MaxDouble
  else
    TnxDouble(aTarget) := TnxExtended(aSource);
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToDoubleCheck(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if ((TnxExtended(aSource) <> 0) and
      (Abs(TnxExtended(aSource)) < MinDouble)) or
     (Abs(TnxExtended(aSource)) > MaxDouble) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxDouble(aTarget) := TnxExtended(aSource);
    Result := DBIERR_NONE;
  end;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToExtended(const aSource; var aTarget): TnxResult;
begin
  TnxExtended(aTarget) := TnxExtended(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToInt16(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if TnxExtended(aSource) < Low(TnxInt16) then
    TnxInt16(aTarget) := Low(TnxInt16)
  else if TnxExtended(aSource) > High(TnxInt16) then
    TnxInt16(aTarget) := High(TnxInt16)
  else
    TnxInt16(aTarget) := Round(TnxExtended(aSource));
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToInt16Check(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if (TnxExtended(aSource) < Low(TnxInt16)) or
    (TnxExtended(aSource) > High(TnxInt16)) or
    not SameValue(Frac(TnxExtended(aSource)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt16(aTarget) := Round(TnxExtended(aSource));
    Result := DBIERR_NONE;
  end;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToInt32(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if TnxExtended(aSource) < Low(TnxInt32) then
    TnxInt32(aTarget) := Low(TnxInt32)
  else if TnxExtended(aSource) > High(TnxInt32) then
    TnxInt32(aTarget) := High(TnxInt32)
  else
    TnxInt32(aTarget) := Round(TnxExtended(aSource));
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToInt32Check(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if (TnxExtended(aSource) < Low(TnxInt32)) or
    (TnxExtended(aSource) > High(TnxInt32)) or
    not SameValue(Frac(TnxExtended(aSource)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt32(aTarget) := Round(TnxExtended(aSource));
    Result := DBIERR_NONE;
  end;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToInt64(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if TnxExtended(aSource) < Low(TnxInt64) then
    TnxInt64(aTarget) := Low(TnxInt64)
  else if TnxExtended(aSource) > High(TnxInt64) then
    TnxInt64(aTarget) := High(TnxInt64)
  else
    TnxInt64(aTarget) := Round(TnxExtended(aSource));
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToInt64Check(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if (TnxExtended(aSource) < Low(TnxInt64)) or
    (TnxExtended(aSource) > High(TnxInt64)) or
    not SameValue(Frac(TnxExtended(aSource)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt64(aTarget) := Round(TnxExtended(aSource));
    Result := DBIERR_NONE;
  end;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToInt8(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if TnxExtended(aSource) < Low(TnxInt8) then
    TnxInt8(aTarget) := Low(TnxInt8)
  else if TnxExtended(aSource) > High(TnxInt8) then
    TnxInt8(aTarget) := High(TnxInt8)
  else
    TnxInt8(aTarget) := Round(TnxExtended(aSource));
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToInt8Check(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if (TnxExtended(aSource) < Low(TnxInt8)) or
    (TnxExtended(aSource) > High(TnxInt8)) or
    not SameValue(Frac(TnxExtended(aSource)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt8(aTarget) := Round(TnxExtended(aSource));
    Result := DBIERR_NONE;
  end;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxExtendedMapper.ToNullString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  {$IFNDEF FPC}
  s := nxFloatToAnsiStr(TnxExtended(aSource), emFormatSettings);
  StrPCopy(PAnsiChar(@aTarget), Copy(s, 1, nxMinI32(Length(s), Pred(emTargetLength))));
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxExtendedMapper.ToNullStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  {$IFNDEF FPC}
  Result := DBIERR_NONE;
  s := nxFloatToAnsiStr(TnxExtended(aSource), emFormatSettings);
  if Length(s) < emTargetLength then
    StrPCopy(PAnsiChar(@aTarget), s)
  else
    Result := DBIERR_INVALIDFLDXFORM;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxExtendedMapper.ToShortString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  {$IFNDEF FPC}
  s := nxFloatToAnsiStr(TnxExtended(aSource), emFormatSettings);
  TnxShStr(aTarget) := Copy(s, 1, nxMinI32(Length(s), emTargetLength - 1));
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxExtendedMapper.ToShortStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  {$IFNDEF FPC}
  Result := DBIERR_NONE;
  s := nxFloatToAnsiStr(TnxExtended(aSource), emFormatSettings);
  if Length(s) < emTargetLength then
    TnxShStr(aTarget) := s
  else
    Result := DBIERR_INVALIDFLDXFORM;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToSingle(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if Abs(TnxExtended(aSource)) > MaxSingle then
    TnxSingle(aTarget) := MaxSingle
  else
    TnxSingle(aTarget) := TnxExtended(aSource);
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToSingleCheck(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if ((TnxExtended(aSource) <> 0) and
      (Abs(TnxExtended(aSource)) < MinSingle)) or
    (Abs(TnxExtended(aSource)) > MaxSingle) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxSingle(aTarget) := TnxExtended(aSource);
    Result := DBIERR_NONE;
  end;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxExtendedMapper.ToWideChar(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  {$IFNDEF FPC}
  s := nxFloatToWideStr(TnxExtended(aSource), emFormatSettings);
  if Length(s) > 0 then
    TnxWideChar(aTarget) := s[1]
  else
    TnxWideChar(aTarget) := #0;
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxExtendedMapper.ToWideCharCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  {$IFNDEF FPC}
  if (TnxExtended(aSource) < 0) or (TnxExtended(aSource) > 9) or (Frac(TnxExtended(aSource)) <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxFloatToWideStr(Trunc(TnxExtended(aSource)), emFormatSettings);
    TnxWideChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxExtendedMapper.ToWideString(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  {$IFNDEF FPC}
  s := nxFloatToWideStr(TnxExtended(aSource), emFormatSettings);
  nxStringToWideChar(s, @aTarget, Pred(emTargetLength div SizeOf(WideChar)));
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxExtendedMapper.ToWideStringCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  {$IFNDEF FPC}
  s := nxFloatToWideStr(TnxExtended(aSource), emFormatSettings);
  nxStringToWideChar(s, @aTarget, Pred(emTargetLength div SizeOf(WideChar)));
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToWord16(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if TnxExtended(aSource) < Low(TnxWord16) then
    TnxWord16(aTarget) := Low(TnxWord16)
  else if TnxExtended(aSource) > High(TnxWord16) then
    TnxWord16(aTarget) := High(TnxWord16)
  else
    TnxWord16(aTarget) := Round(TnxExtended(aSource));
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToWord16Check(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if (TnxExtended(aSource) < Low(TnxWord16)) or
    (TnxExtended(aSource) > High(TnxWord16)) or
    not SameValue(Frac(TnxExtended(aSource)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxWord16(aTarget) := Round(TnxExtended(aSource));
    Result := DBIERR_NONE;
  end;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToWord32(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if TnxExtended(aSource) < Low(TnxWord32) then
    TnxWord32(aTarget) := Low(TnxWord32)
  else if TnxExtended(aSource) > High(TnxWord32) then
    TnxWord32(aTarget) := High(TnxWord32)
  else
    TnxWord32(aTarget) := Round(TnxExtended(aSource));
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxExtendedMapper.ToWord32Check(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if (TnxExtended(aSource) < Low(TnxWord32)) or
    (TnxExtended(aSource) > High(TnxWord32)) or
    not SameValue(Frac(TnxExtended(aSource)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxWord32(aTarget) := Round(TnxExtended(aSource));
    Result := DBIERR_NONE;
  end;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{==============================================================================}



{==============================================================================}
constructor TnxCurrencyMapper.Create(aSourceField : TnxFieldDescriptor;
                                     aTargetField : TnxFieldDescriptor;
                                     aMapperDesc  : TnxFieldMapperDescriptor;
                                 out aMapper      : TnxMappingMethod);
begin
  inherited Create;

  if Assigned(aTargetField.UsedLocaleDescriptor) then
    GetLocaleFormatSettings(aTargetField.UsedLocaleDescriptor.Locale, cmFormatSettings)
  else
    GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, cmFormatSettings);

  cmTargetLength := aTargetField.fdLength;
  cmTargetUnits := aTargetField.fdUnits;
  cmTargetDecPl := aTargetField.fdDecPl;

  case aTargetField.fdType of
    nxtBcd:
      if aTargetField.fdUnits = 20 then
        aMapper := ToCurrency
      else if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToBcdTrunc
      else
        aMapper := ToBcdCheck;
    nxtChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToAnsiChar
      else
        aMapper := ToAnsiCharCheck;
    nxtWideChar:
      if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := ToWideChar
      else
        aMapper := ToWideCharCheck;
    nxtNullString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (cmTargetLength > Length(nxFloatToAnsiStr(MinCurrency, cmFormatSettings)))  then
        aMapper := ToNullString
      else
        aMapper := ToNullStringCheck;
    nxtShortString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (cmTargetLength > Length(nxFloatToAnsiStr(MinCurrency, cmFormatSettings)))  then
        aMapper := ToShortString
      else
        aMapper := ToShortStringCheck;
    nxtWideString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (cmTargetLength div SizeOf(WideChar) > Length(nxFloatToAnsiStr(MinCurrency, cmFormatSettings)))  then
        aMapper := ToWideString
      else
        aMapper := ToWideStringCheck;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.InternalCreateMapper(aSourceField : TnxFieldDescriptor;
                                                aSourceCursor : TnxAbstractCursor;
                                                aTargetField  : TnxFieldDescriptor;
                                                aTargetCursor : TnxAbstractCursor;
                                                aMapperDesc  : TnxFieldMapperDescriptor;
                                            out aMapper       : TnxMappingMethod)
                                                              : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  if aSourceField.fdType in [nxtCurrency, nxtBCD] then
    case aTargetField.fdType of
      nxtBoolean:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToBoolean
        else
          aMapper := ToBooleanCheck;
      nxtInt8 :
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt8
        else
          aMapper := ToInt8Check;
      nxtInt16:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt16
        else
          aMapper := ToInt16Check;
      nxtInt32:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt32
        else
          aMapper := ToInt32Check;
      nxtInt64:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToInt64
        else
          aMapper := ToInt64Check;
      nxtByte:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToByte8
        else
          aMapper := ToByteCheck;
      nxtWord16:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToWord16
        else
          aMapper := ToWord16Check;
      nxtWord32, nxtAutoInc, nxtRecRev:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToWord32
        else
          aMapper := ToWord32Check;
      nxtSingle   :
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToSingle
        else
          aMapper := ToSingleCheck;
      nxtDouble   :
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToDouble
        else
          aMapper := ToDoubleCheck;
      nxtExtended :
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToExtended
        else
          aMapper := ToExtendedCheck;

      nxtCurrency : aMapper := ToCurrency;
      nxtBCD      : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);

      nxtByteArray:
        if aTargetField.fdUnits >= SizeOf(TnxCurrency) then
          aMapper := ToByteArray;

      nxtChar,
      nxtWideChar,
      nxtNullString,
      nxtShortString,
      nxtWideString   : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
    end;
end;
{------------------------------------------------------------------------------}
function TnxCurrencyMapper.ToBcdCheck(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
  if nxCurrencyToFmtBcd(TnxCurrency(aSource), Bcd, cmTargetUnits, cmTargetDecPl) <> [] then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxCurrencyMapper.ToBcdTrunc(const aSource; var aTarget): TnxResult;
var
  Bcd : TnxFmtBcd;
begin
  nxCurrencyToFmtBcd(TnxCurrency(aSource), Bcd, cmTargetUnits, cmTargetDecPl);
  nxFmtBcdToCurrency(Bcd, TnxCurrency(aTarget));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToBoolean(const aSource; var aTarget): TnxResult;
begin
  TnxBoolean(aTarget) := TnxCurrency(aSource) <> 0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToBooleanCheck(const aSource; var aTarget): TnxResult;
begin
  TnxBoolean(aTarget) := TnxCurrency(aSource) <> 0;
  if TnxBoolean(aTarget) and (TnxCurrency(aSource) <> 1) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToByte8(const aSource; var aTarget): TnxResult;
begin
  if TnxCurrency(aSource) < Low(TnxByte8) then
    TnxByte8(aTarget) := Low(TnxByte8)
  else if TnxCurrency(aSource) > High(TnxByte8) then
    TnxByte8(aTarget) := High(TnxByte8)
  else
    TnxByte8(aTarget) := Round(TnxCurrency(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToByteCheck(const aSource; var aTarget): TnxResult;
begin
  if (TnxCurrency(aSource) < Low(TnxByte8)) or
    (TnxCurrency(aSource) > High(TnxByte8)) or
    not (Frac(TnxCurrency(aSource)) = 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxByte8(aTarget) := Round(TnxCurrency(aSource));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToByteArray(const aSource; var aTarget): TnxResult;
begin
  TnxCurrency(aTarget) := TnxCurrency(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxCurrencyMapper.ToAnsiChar(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxFloatToAnsiStr(TnxCurrency(aSource), cmFormatSettings);
  if Length(s) > 0 then
    TnxAnsiChar(aTarget) := s[1]
  else
    TnxAnsiChar(aTarget) := #0;
  Result := DBIERR_NONE;
end;
function TnxCurrencyMapper.ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  if (TnxCurrency(aSource) < 0) or (TnxCurrency(aSource) > 9) or (Frac(TnxCurrency(aSource)) <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxFloatToAnsiStr(TnxCurrency(aSource), cmFormatSettings);
    TnxAnsiChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToCurrency(const aSource; var aTarget): TnxResult;
begin
  if TnxCurrency(aSource) < MinCurrency then
    TnxCurrency(aTarget) := MinCurrency
  else if TnxCurrency(aSource) > MaxCurrency then
    TnxCurrency(aTarget) := MaxCurrency
  else
    TnxCurrency(aTarget) := TnxCurrency(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToDouble(const aSource; var aTarget): TnxResult;
begin
  if Abs(TnxCurrency(aSource)) > MaxDouble then
    TnxDouble(aTarget) := MaxDouble
  else
    TnxDouble(aTarget) := TnxCurrency(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToDoubleCheck(const aSource; var aTarget): TnxResult;
begin
  if Abs(TnxCurrency(aSource)) > MaxDouble then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxDouble(aTarget) := TnxCurrency(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToExtended(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if Abs(TnxCurrency(aSource)) > MaxExtended then
    TnxExtended(aTarget) := MaxExtended
  else
    TnxExtended(aTarget) := TnxCurrency(aSource);
  Result := DBIERR_NONE;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToExtendedCheck(const aSource; var aTarget): TnxResult;
begin
  {$IFNDEF FPC}
  if Abs(TnxCurrency(aSource)) > MaxExtended then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxExtended(aTarget) := TnxCurrency(aSource);
    Result := DBIERR_NONE;
  end;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToInt16(const aSource; var aTarget): TnxResult;
begin
  if TnxCurrency(aSource) < Low(TnxInt16) then
    TnxInt16(aTarget) := Low(TnxInt16)
  else if TnxCurrency(aSource) > High(TnxInt16) then
    TnxInt16(aTarget) := High(TnxInt16)
  else
    TnxInt16(aTarget) := Round(TnxCurrency(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToInt16Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxCurrency(aSource) < Low(TnxInt16)) or
    (TnxCurrency(aSource) > High(TnxInt16)) or
    not (Frac(TnxCurrency(aSource)) = 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt16(aTarget) := Round(TnxCurrency(aSource));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToInt32(const aSource; var aTarget): TnxResult;
begin
  if TnxCurrency(aSource) < Low(TnxInt32) then
    TnxInt32(aTarget) := Low(TnxInt32)
  else if TnxCurrency(aSource) > High(TnxInt32) then
    TnxInt32(aTarget) := High(TnxInt32)
  else
    TnxInt32(aTarget) := Round(TnxCurrency(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToInt32Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxCurrency(aSource) < Low(TnxInt32)) or
    (TnxCurrency(aSource) > High(TnxInt32)) or
    not (Frac(TnxCurrency(aSource)) = 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt32(aTarget) := Round(TnxCurrency(aSource));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToInt64(const aSource; var aTarget): TnxResult;
begin
  TnxInt64(aTarget) := Round(TnxCurrency(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToInt64Check(const aSource; var aTarget): TnxResult;
begin
  if not (Frac(TnxCurrency(aSource)) = 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt64(aTarget) := Round(TnxCurrency(aSource));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToInt8(const aSource; var aTarget): TnxResult;
begin
  if TnxCurrency(aSource) < Low(TnxInt8) then
    TnxInt8(aTarget) := Low(TnxInt8)
  else if TnxCurrency(aSource) > High(TnxInt8) then
    TnxInt8(aTarget) := High(TnxInt8)
  else
    TnxInt8(aTarget) := Round(TnxCurrency(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToInt8Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxCurrency(aSource) < Low(TnxInt8)) or
    (TnxCurrency(aSource) > High(TnxInt8)) or
    not (Frac(TnxCurrency(aSource)) = 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxInt8(aTarget) := Round(TnxCurrency(aSource));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxCurrencyMapper.ToNullString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxFloatToAnsiStr(TnxCurrency(aSource), cmFormatSettings);
  StrPCopy(PAnsiChar(@aTarget), Copy(s, 1, nxMinI32(Length(s), Pred(cmTargetLength))));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxCurrencyMapper.ToNullStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxFloatToAnsiStr(TnxCurrency(aSource), cmFormatSettings);
  if Length(s) < cmTargetLength then
    StrPCopy(PAnsiChar(@aTarget), s)
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxCurrencyMapper.ToShortString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxFloatToAnsiStr(TnxCurrency(aSource), cmFormatSettings);
  TnxShStr(aTarget) := Copy(s, 1, nxMinI32(Length(s), cmTargetLength - 1));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxCurrencyMapper.ToShortStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxFloatToAnsiStr(TnxCurrency(aSource), cmFormatSettings);
  if Length(s) < cmTargetLength then
    TnxShStr(aTarget) := s
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToSingle(const aSource; var aTarget): TnxResult;
begin
  if Abs(TnxCurrency(aSource)) > MaxSingle then
    TnxSingle(aTarget) := MaxSingle
  else
    TnxSingle(aTarget) := TnxCurrency(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToSingleCheck(const aSource; var aTarget): TnxResult;
begin
  if Abs(TnxCurrency(aSource)) > MaxSingle then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxSingle(aTarget) := TnxCurrency(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxCurrencyMapper.ToWideChar(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  s := nxFloatToWideStr(TnxCurrency(aSource), cmFormatSettings);
  if Length(s) > 0 then
    TnxWideChar(aTarget) := s[1]
  else
    TnxWideChar(aTarget) := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxCurrencyMapper.ToWideCharCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  if (TnxCurrency(aSource) < 0) or (TnxCurrency(aSource) > 9) or (Frac(TnxCurrency(aSource)) <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    s := nxFloatToWideStr(Trunc(TnxCurrency(aSource)), cmFormatSettings);
    TnxWideChar(aTarget) := s[1];
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxCurrencyMapper.ToWideString(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  s := nxFloatToWideStr(TnxCurrency(aSource), cmFormatSettings);
  nxStringToWideChar(s, @aTarget, Pred(cmTargetLength div SizeOf(WideChar)));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxCurrencyMapper.ToWideStringCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  Result := DBIERR_NONE;
  s := nxFloatToWideStr(TnxCurrency(aSource), cmFormatSettings);
  if Length(s) < cmTargetLength then
    nxStringToWideChar(s, @aTarget, Pred(cmTargetLength div SizeOf(WideChar)))
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToWord16(const aSource; var aTarget): TnxResult;
begin
  if TnxCurrency(aSource) < Low(TnxWord16) then
    TnxWord16(aTarget) := Low(TnxWord16)
  else if TnxCurrency(aSource) > High(TnxWord16) then
    TnxWord16(aTarget) := High(TnxWord16)
  else
    TnxWord16(aTarget) := Round(TnxCurrency(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToWord16Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxCurrency(aSource) < Low(TnxWord16)) or
    (TnxCurrency(aSource) > High(TnxWord16)) or
    not (Frac(TnxCurrency(aSource)) = 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxWord16(aTarget) := Round(TnxCurrency(aSource));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToWord32(const aSource; var aTarget): TnxResult;
begin
  if TnxCurrency(aSource) < Low(TnxWord32) then
    TnxWord32(aTarget) := Low(TnxWord32)
  else if TnxCurrency(aSource) > High(TnxWord32) then
    TnxWord32(aTarget) := High(TnxWord32)
  else
    TnxWord32(aTarget) := Round(TnxCurrency(aSource));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxCurrencyMapper.ToWord32Check(const aSource; var aTarget): TnxResult;
begin
  if (TnxCurrency(aSource) < Low(TnxWord32)) or
    (TnxCurrency(aSource) > High(TnxWord32)) or
    not (Frac(TnxCurrency(aSource)) = 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxWord32(aTarget) := Round(TnxCurrency(aSource));
    Result := DBIERR_NONE;
  end;
end;
{==============================================================================}



{==============================================================================}
constructor TnxTimeMapper.Create(aSourceField : TnxFieldDescriptor;
                                 aTargetField : TnxFieldDescriptor;
                                 aMapperDesc  : TnxFieldMapperDescriptor;
                             out aMapper      : TnxMappingMethod);
begin
  inherited Create;

  if Assigned(aTargetField.UsedLocaleDescriptor) then
    GetLocaleFormatSettings(aTargetField.UsedLocaleDescriptor.Locale, tmFormatSettings)
  else
    GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, tmFormatSettings);

  tmTargetLength := aTargetField.fdLength;
  tmTargetField := aTargetField;

  case aTargetField.fdType of
    nxtDate: aMapper := ToDate;

    nxtDateTime,
    nxtInterval: aMapper := ToDateTime;

    nxtNullString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (tmTargetLength > Length(nxTimeToAnsiStr(Time, tmFormatSettings)))  then
        aMapper := ToNullString
      else
        aMapper := ToNullStringCheck;

    nxtShortString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (tmTargetLength > Length(nxTimeToAnsiStr(Time, tmFormatSettings)))  then
        aMapper := ToShortString
      else
        aMapper := ToShortStringCheck;

    nxtWideString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (tmTargetLength div SizeOf(WideChar) > Length(nxTimeToAnsiStr(Time, tmFormatSettings)))  then
        aMapper := ToWideString
      else
        aMapper := ToWideStringCheck;

    nxtWord32:
      aMapper := ToWord32;  //..
  end;
end;
{------------------------------------------------------------------------------}
class function TnxTimeMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                                  aSourceCursor : TnxAbstractCursor;
                                                  aTargetField  : TnxFieldDescriptor;
                                                  aTargetCursor : TnxAbstractCursor;
                                                  aMapperDesc   : TnxFieldMapperDescriptor;
                                              out aMapper       : TnxMappingMethod)
                                                                    : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  if aSourceField.fdType in [nxtTime] then
    case aTargetField.fdType of
      nxtDate,
      nxtDateTime,
      nxtInterval:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);

      nxtTime:
        aMapper := ToTime;

      nxtByteArray:
        if aTargetField.fdUnits >= SizeOf(TnxDateTime) then
          aMapper := ToByteArray;

      nxtNullString,
      nxtShortString,
      nxtWideString   :
        Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);

      nxtWord32:
        aMapper := ToWord32; //..
    end;
end;
{------------------------------------------------------------------------------}
class function TnxTimeMapper.ToByteArray(const aSource; var aTarget): TnxResult;
begin
  TnxTime(aTarget) := TnxTime(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxTimeMapper.ToDate(const aSource; var aTarget): TnxResult;
begin
  //!!!tmTargetField.ParentDataDictionary.SetRecordFieldNull(tmTargetField.Number, @aTarget, True);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxTimeMapper.ToDateTime(const aSource; var aTarget): TnxResult;
begin
  //!!!tmTargetField.ParentDataDictionary.SetRecordFieldNull(tmTargetField.Number, @aTarget, True);
  Result := DBIERR_NONE;
end;

class function TnxTimeMapper.ToWord32(const aSource; var aTarget): TnxResult; //..
begin
     TnxTime(aTarget) := TnxWord32(aSource);
     Result := DBIERR_NONE;
end;

{------------------------------------------------------------------------------}
function TnxTimeMapper.ToNullString(const aSource; var aTarget): TnxResult;
var
  s   : AnsiString;
begin
  s := nxTimeToAnsiStr(TimestampToDatetime(nxMakeTimeStamp(DateDelta, TnxTime(aSource))), tmFormatSettings);

  StrPCopy(PAnsiChar(@aTarget), Copy(s, 1, nxMinI32(Length(s), Pred(tmTargetLength))));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxTimeMapper.ToNullStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxTimeToAnsiStr(TimestampToDatetime(nxMakeTimeStamp(DateDelta, TnxTime(aSource))), tmFormatSettings);

  if Length(s) < tmTargetLength then
    StrPCopy(PAnsiChar(@aTarget), s)
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxTimeMapper.ToShortString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxTimeToAnsiStr(TimestampToDatetime(nxMakeTimeStamp(DateDelta, TnxTime(aSource))), tmFormatSettings);

  TnxShStr(aTarget) := Copy(s, 1, nxMinI32(Length(s), tmTargetLength - 1));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxTimeMapper.ToShortStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxTimeToAnsiStr(TimestampToDatetime(nxMakeTimeStamp(DateDelta, TnxTime(aSource))), tmFormatSettings);

  if Length(s) < tmTargetLength then
    TnxShStr(aTarget) := s
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxTimeMapper.ToTime(const aSource; var aTarget): TnxResult;
begin
  TnxTime(aTarget) := TnxTime(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxTimeMapper.ToWideString(const aSource; var aTarget): TnxResult;
begin
  nxStringToWideChar(nxTimeToWideStr(TimestampToDatetime(nxMakeTimeStamp(DateDelta, TnxTime(aSource))), tmFormatSettings), @aTarget, Pred(tmTargetLength div SizeOf(WideChar)));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxTimeMapper.ToWideStringCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  Result := DBIERR_NONE;
  s := nxTimeToWideStr(TimestampToDatetime(nxMakeTimeStamp(DateDelta, TnxTime(aSource))), tmFormatSettings);

  if Length(s) < tmTargetLength then
    nxStringToWideChar(s, @aTarget, Pred(tmTargetLength div SizeOf(WideChar)))
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{==============================================================================}



{==============================================================================}
constructor TnxDateMapper.Create(aSourceField : TnxFieldDescriptor;
                                 aTargetField : TnxFieldDescriptor;
                                 aMapperDesc  : TnxFieldMapperDescriptor;
                             out aMapper      : TnxMappingMethod);
begin
  inherited Create;

  if Assigned(aTargetField.UsedLocaleDescriptor) then
    GetLocaleFormatSettings(aTargetField.UsedLocaleDescriptor.Locale, dmFormatSettings)
  else
    GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, dmFormatSettings);

  dmTargetLength := aTargetField.fdLength;
  dmTargetField := aTargetField;

  case aTargetField.fdType of
    nxtTime: aMapper := ToTime;

    nxtNullString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (dmTargetLength > Length(nxDateToAnsiStr(SysUtils.Date, dmFormatSettings)))  then
        aMapper := ToNullString
      else
        aMapper := ToNullStringCheck;

    nxtShortString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (dmTargetLength > Length(nxDateToAnsiStr(SysUtils.Date, dmFormatSettings)))  then
        aMapper := ToShortString
      else
        aMapper := ToShortStringCheck;

    nxtWideString:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
         (dmTargetLength div SizeOf(WideChar) > Length(nxDateToAnsiStr(SysUtils.Date, dmFormatSettings)))  then
        aMapper := ToWideString
      else
        aMapper := ToWideStringCheck;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxDateMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                                  aSourceCursor : TnxAbstractCursor;
                                                  aTargetField  : TnxFieldDescriptor;
                                                  aTargetCursor : TnxAbstractCursor;
                                                  aMapperDesc   : TnxFieldMapperDescriptor;
                                              out aMapper       : TnxMappingMethod)
                                                                : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  if aSourceField.fdType = nxtDate then
    case aTargetField.fdType of
      nxtDate: aMapper := ToDate;

      nxtTime:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);

      nxtDateTime,
      nxtInterval:
        aMapper := ToDateTime;

      nxtByteArray:
        if aTargetField.fdUnits >= SizeOf(TnxDateTime) then
          aMapper := ToByteArray;

      nxtNullString,
      nxtShortString,
      nxtWideString   : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
    end;
end;
{------------------------------------------------------------------------------}
class function TnxDateMapper.ToByteArray(const aSource; var aTarget): TnxResult;
begin
  TnxDate(aTarget) := TnxDate(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxDateMapper.ToDate(const aSource; var aTarget): TnxResult;
begin
  TnxDate(aTarget) := TnxDate(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxDateMapper.ToDateTime(const aSource; var aTarget): TnxResult;
begin
  TnxDateTime(aTarget) := TnxDate(aSource) * Int64(MSecsPerDay);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxDateMapper.ToNullString(const aSource; var aTarget): TnxResult;
var
  s   : AnsiString;
begin
  s := nxDateToAnsiStr(TimestampToDatetime(nxMakeTimeStamp(TnxDate(aSource), 0)), dmFormatSettings);

  StrPCopy(PAnsiChar(@aTarget), Copy(s, 1, nxMinI32(Length(s), Pred(dmTargetLength))));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxDateMapper.ToNullStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxDateToAnsiStr(TimestampToDatetime(nxMakeTimeStamp(TnxDate(aSource), 0)), dmFormatSettings);

  if Length(s) < dmTargetLength then
    StrPCopy(PAnsiChar(@aTarget), s)
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxDateMapper.ToShortString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  s := nxDateToAnsiStr(TimestampToDatetime(nxMakeTimeStamp(TnxDate(aSource), 0)), dmFormatSettings);

  TnxShStr(aTarget) := Copy(s, 1, nxMinI32(Length(s), dmTargetLength - 1));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxDateMapper.ToShortStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  s := nxDateToAnsiStr(TimestampToDatetime(nxMakeTimeStamp(TnxDate(aSource), 0)), dmFormatSettings);

  if Length(s) < dmTargetLength then
    TnxShStr(aTarget) := s
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxDateMapper.ToTime(const aSource; var aTarget): TnxResult;
begin
  //!!!dmTargetField.ParentDataDictionary.SetRecordFieldNull(dmTargetField.Number, @aTarget, True);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxDateMapper.ToWideString(const aSource; var aTarget): TnxResult;
begin
  nxStringToWideChar(nxDateToWideStr(TimestampToDatetime(nxMakeTimeStamp(TnxDate(aSource), 0)), dmFormatSettings), @aTarget, Pred(dmTargetLength div SizeOf(WideChar)));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxDateMapper.ToWideStringCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  Result := DBIERR_NONE;
  s := nxDateToWideStr(TimestampToDatetime(nxMakeTimeStamp(TnxDate(aSource), 0)), dmFormatSettings);

  if Length(s) < dmTargetLength then
    nxStringToWideChar(s, @aTarget, Pred(dmTargetLength div SizeOf(WideChar)))
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{==============================================================================}



{==============================================================================}
constructor TnxDateTimeMapper.Create(aSourceField : TnxFieldDescriptor;
                                     aTargetField : TnxFieldDescriptor;
                                     aMapperDesc  : TnxFieldMapperDescriptor;
                                 out aMapper      : TnxMappingMethod);
begin
  inherited Create;

  if Assigned(aTargetField.UsedLocaleDescriptor) then
    GetLocaleFormatSettings(aTargetField.UsedLocaleDescriptor.Locale, dtmFormatSettings)
  else
    GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, dtmFormatSettings);

  dtmTargetLength := aTargetField.fdLength;

  case aTargetField.fdType of
    nxtNullString:
      case aSourceField.fdType of
        nxtDate:
          if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
             (dtmTargetLength > Length(nxDateToAnsiStr(SysUtils.Date, dtmFormatSettings)))  then
            aMapper := ToNullString
          else
            aMapper := ToNullStringCheck;

        nxtTime:
          if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
             (dtmTargetLength > Length(nxTimeToAnsiStr(Time, dtmFormatSettings)))  then
            aMapper := ToNullString
          else
            aMapper := ToNullStringCheck;

        nxtDateTime:
          if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
             (dtmTargetLength > Length(nxDateTimeToAnsiStr(Now, dtmFormatSettings)))  then
            aMapper := ToNullString
          else
            aMapper := ToNullStringCheck;
      end;

    nxtShortString:
      case aSourceField.fdType of
        nxtDate:
          if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
             (dtmTargetLength > Length(nxDateToAnsiStr(SysUtils.Date, dtmFormatSettings)))  then
            aMapper := ToShortString
          else
            aMapper := ToShortStringCheck;

        nxtTime:
          if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
             (dtmTargetLength > Length(nxTimeToAnsiStr(Time, dtmFormatSettings)))  then
            aMapper := ToShortString
          else
            aMapper := ToShortStringCheck;

        nxtDateTime:
          if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
             (dtmTargetLength > Length(nxDateTimeToAnsiStr(Now, dtmFormatSettings)))  then
            aMapper := ToShortString
          else
            aMapper := ToShortStringCheck;
      end;

    nxtWideString:
      case aSourceField.fdType of
        nxtDate:
          if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
             (dtmTargetLength div SizeOf(WideChar) > Length(nxDateToAnsiStr(SysUtils.Date, dtmFormatSettings)))  then
            aMapper := ToWideString
          else
            aMapper := ToWideStringCheck;

        nxtTime:
          if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
             (dtmTargetLength div SizeOf(WideChar) > Length(nxTimeToAnsiStr(Time, dtmFormatSettings)))  then
            aMapper := ToWideString
          else
            aMapper := ToWideStringCheck;

        nxtDateTime:
          if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
             (dtmTargetLength div SizeOf(WideChar) > Length(nxDateTimeToAnsiStr(Now, dtmFormatSettings)))  then
            aMapper := ToWideString
          else
            aMapper := ToWideStringCheck;
      end;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxDateTimeMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                                      aSourceCursor : TnxAbstractCursor;
                                                      aTargetField  : TnxFieldDescriptor;
                                                      aTargetCursor : TnxAbstractCursor;
                                                      aMapperDesc   : TnxFieldMapperDescriptor;
                                                  out aMapper       : TnxMappingMethod)
                                                                    : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  if aSourceField.fdType in [nxtDateTime, nxtInterval] then
    case aTargetField.fdType of
      nxtDate:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToDate
        else
          aMapper := ToDateCheck;
      nxtTime:
        if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
          aMapper := ToTime
        else
          aMapper := ToTimeCheck;
      nxtDateTime,
      nxtInterval: aMapper := ToDateTime;

      nxtDouble: aMapper := ToDouble;

      nxtByteArray:
        if aTargetField.fdUnits >= SizeOf(TnxDateTime) then
          aMapper := ToByteArray;

      nxtNullString,
      nxtShortString,
      nxtWideString   : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
    end;
end;
{------------------------------------------------------------------------------}
class function TnxDateTimeMapper.ToByteArray(const aSource; var aTarget): TnxResult;
begin
  TnxDateTime(aTarget) := TnxDateTime(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxDateTimeMapper.ToDate(const aSource; var aTarget): TnxResult;
begin
  TnxDate(aTarget) := Trunc(TnxDateTime(aSource) / MSecsPerDay);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxDateTimeMapper.ToDateCheck(const aSource; var aTarget): TnxResult;
var
  DT : TnxDateTime;
begin
  DT := TnxDateTime(aSource) / MSecsPerDay;
  if not SameValue(Frac(DT), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxDate(aTarget) := Trunc(DT);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxDateTimeMapper.ToDateTime(const aSource; var aTarget): TnxResult;
begin
  TnxDateTime(aTarget) := TnxDateTime(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxDateTimeMapper.ToDouble(const aSource; var aTarget): TnxResult;
begin
  Double(aTarget) :=
    TimestampToDatetime(nxMakeTimeStamp(Trunc(TnxDateTime(aSource) / MSecsPerDay),
                                        Trunc(TnxDateTime(aSource) - Trunc(TnxDateTime(aSource) / MSecsPerDay) * Int64(MSecsPerDay))));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxDateTimeMapper.ToNullString(const aSource; var aTarget): TnxResult;
var
  s   : AnsiString;
begin
  case dtmSourceType of
    nxtDate: s := nxDateToAnsiStr(TimestampToDatetime(nxMakeTimeStamp(TnxDate(aSource), 0)), dtmFormatSettings);
    nxtTime: s := nxTimeToAnsiStr(TimestampToDatetime(nxMakeTimeStamp(DateDelta, TnxTime(aSource))), dtmFormatSettings);
    nxtDateTime: s := nxDateTimeToAnsiStr(TimestampToDatetime(nxMakeTimeStamp(Trunc(TnxDateTime(aSource) / MSecsPerDay),
                                    Trunc(TnxDateTime(aSource) - Trunc(TnxDateTime(aSource) / MSecsPerDay) * Int64(MSecsPerDay)))), dtmFormatSettings);
  end;

  StrPCopy(PAnsiChar(@aTarget), Copy(s, 1, nxMinI32(Length(s), Pred(dtmTargetLength))));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxDateTimeMapper.ToNullStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  case dtmSourceType of
    nxtDate: s := nxDateToAnsiStr(TimestampToDatetime(nxMakeTimeStamp(TnxDate(aSource), 0)), dtmFormatSettings);
    nxtTime: s := nxTimeToAnsiStr(TimestampToDatetime(nxMakeTimeStamp(DateDelta, TnxTime(aSource))), dtmFormatSettings);
    nxtDateTime: s := nxDateTimeToAnsiStr(TimestampToDatetime(nxMakeTimeStamp(Trunc(TnxDateTime(aSource) / MSecsPerDay),
                                    Trunc(TnxDateTime(aSource) - Trunc(TnxDateTime(aSource) / MSecsPerDay) * Int64(MSecsPerDay)))), dtmFormatSettings);
  end;

  if Length(s) < dtmTargetLength then
    StrPCopy(PAnsiChar(@aTarget), s)
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxDateTimeMapper.ToShortString(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  case dtmSourceType of
    nxtDate: s := nxDateToAnsiStr(TimestampToDatetime(nxMakeTimeStamp(TnxDate(aSource), 0)), dtmFormatSettings);
    nxtTime: s := nxTimeToAnsiStr(TimestampToDatetime(nxMakeTimeStamp(DateDelta, TnxTime(aSource))), dtmFormatSettings);
    nxtDateTime: s := nxDateTimeToAnsiStr(TimestampToDatetime(nxMakeTimeStamp(Trunc(TnxDateTime(aSource) / MSecsPerDay),
                                    Trunc(TnxDateTime(aSource) - Trunc(TnxDateTime(aSource) / MSecsPerDay) * Int64(MSecsPerDay)))), dtmFormatSettings);
  end;

  TnxShStr(aTarget) := Copy(s, 1, nxMinI32(Length(s), dtmTargetLength - 1));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxDateTimeMapper.ToShortStringCheck(const aSource; var aTarget): TnxResult;
var
  s : AnsiString;
begin
  Result := DBIERR_NONE;
  case dtmSourceType of
    nxtDate: s := nxDateToAnsiStr(TimestampToDatetime(nxMakeTimeStamp(TnxDate(aSource), 0)), dtmFormatSettings);
    nxtTime: s := nxTimeToAnsiStr(TimestampToDatetime(nxMakeTimeStamp(DateDelta, TnxTime(aSource))), dtmFormatSettings);
    nxtDateTime: s := nxDateTimeToAnsiStr(TimestampToDatetime(nxMakeTimeStamp(Trunc(TnxDateTime(aSource) / MSecsPerDay),
                                    Trunc(TnxDateTime(aSource) - Trunc(TnxDateTime(aSource) / MSecsPerDay) * Int64(MSecsPerDay)))), dtmFormatSettings);
  end;

  if Length(s) < dtmTargetLength then
    TnxShStr(aTarget) := s
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxDateTimeMapper.ToTime(const aSource; var aTarget): TnxResult;
begin
  TnxTime(aTarget) := Trunc(Frac(TnxDateTime(aSource) / MSecsPerDay) * MSecsPerDay * 1.0);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxDateTimeMapper.ToTimeCheck(const aSource; var aTarget): TnxResult;
var
  DT: TnxDateTime;
begin
  DT := TnxDateTime(aSource) / MSecsPerDay;
  if not SameValue(Abs(DT) - Abs(Frac(DT)), 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxTime(aTarget) := Trunc(Frac(DT) * MSecsPerDay);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDateTimeMapper.ToWideString(const aSource; var aTarget): TnxResult;
begin
  case dtmSourceType of
    nxtDate: nxStringToWideChar(nxDateToWideStr(TimestampToDatetime(nxMakeTimeStamp(TnxDate(aSource), 0)), dtmFormatSettings), @aTarget, Pred(dtmTargetLength div SizeOf(WideChar)));
    nxtTime: nxStringToWideChar(nxTimeToWideStr(TimestampToDatetime(nxMakeTimeStamp(DateDelta, TnxTime(aSource))), dtmFormatSettings), @aTarget, Pred(dtmTargetLength div SizeOf(WideChar)));
    nxtDateTime: nxStringToWideChar(nxDateTimeToWideStr(TimestampToDatetime(nxMakeTimeStamp(Trunc(TnxDateTime(aSource) / MSecsPerDay),
                                  Trunc(TnxDateTime(aSource) - Trunc(TnxDateTime(aSource) / MSecsPerDay) * Int64(MSecsPerDay)))), dtmFormatSettings), @aTarget, Pred(dtmTargetLength div SizeOf(WideChar)));
  end;
  Result := DBIERR_NONE;        
end;
{------------------------------------------------------------------------------}
function TnxDateTimeMapper.ToWideStringCheck(const aSource; var aTarget): TnxResult;
var
  s : UnicodeString;
begin
  Result := DBIERR_NONE;
  case dtmSourceType of
    nxtDate: s := nxDateToWideStr(TimestampToDatetime(nxMakeTimeStamp(TnxDate(aSource), 0)), dtmFormatSettings);
    nxtTime: s := nxTimeToWideStr(TimestampToDatetime(nxMakeTimeStamp(DateDelta, TnxTime(aSource))), dtmFormatSettings);
    nxtDateTime: s := nxDateTimeToWideStr(TimestampToDatetime(nxMakeTimeStamp(Trunc(TnxDateTime(aSource) / MSecsPerDay),
                                    Trunc(TnxDateTime(aSource) - Trunc(TnxDateTime(aSource) / MSecsPerDay) * Int64(MSecsPerDay)))), dtmFormatSettings);
  end;

  if Length(s) < dtmTargetLength then
    nxStringToWideChar(s, @aTarget, Pred(dtmTargetLength div SizeOf(WideChar)))
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{==============================================================================}



{===TnxGuidMapper==============================================================}
class function TnxGuidMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                                  aSourceCursor : TnxAbstractCursor;
                                                  aTargetField  : TnxFieldDescriptor;
                                                  aTargetCursor : TnxAbstractCursor;
                                                  aMapperDesc   : TnxFieldMapperDescriptor;
                                              out aMapper       : TnxMappingMethod)
                                                                : TnxBaseFieldMapper;
var
  G : TGuid;
begin
  aMapper := nil;
  Result := nil;
  if aSourceField.fdType = nxtGuid then
    case aTargetField.fdType of
      nxtGuid: aMapper := ToGuid;

      nxtByteArray:
        if aTargetField.fdUnits >= SizeOf(TnxGuid) then
          aMapper := ToByteArray;

      nxtNullString:
        if (CoCreateGuid(G) = S_OK) and (aTargetField.fdUnits > Length(GuidToString(G))) then
          aMapper := ToNullString;
      nxtShortString:
        if (CoCreateGuid(G) = S_OK) and (aTargetField.fdUnits > Length(GuidToString(G))) then
          aMapper := ToShortString;
      nxtWideString:
        if (CoCreateGuid(G) = S_OK) and ((aTargetField.fdUnits div SizeOf(WideChar)) > Length(GuidToString(G))) then
          aMapper := ToWideString;
    end;
end;
{------------------------------------------------------------------------------}
class function TnxGuidMapper.ToByteArray(const aSource; var aTarget): TnxResult;
begin
  TnxGuid(aTarget) := TnxGuid(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxGuidMapper.ToGuid(const aSource; var aTarget): TnxResult;
begin
  TnxGuid(aTarget) := TnxGuid(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxGuidMapper.ToNullString(const aSource; var aTarget): TnxResult;
begin
  StrPCopy(PAnsiChar(@aTarget), nxGuidToAnsiString(TnxGuid(aSource)));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxGuidMapper.ToShortString(const aSource; var aTarget): TnxResult;
begin
  TnxShStr(aTarget) := nxGuidToAnsiString(TnxGuid(aSource));
  Result := DBIERR_NONE;
end;                                           
{------------------------------------------------------------------------------}
class function TnxGuidMapper.ToWideString(const aSource; var aTarget): TnxResult;
var
  ws: UnicodeString;
begin
  ws := nxGuidToWideString(TnxGuid(aSource));
  nxMove(ws[1], aTarget, Succ(Length(ws)));
  Result := DBIERR_NONE;
end;
{==============================================================================}



{==============================================================================}
constructor TnxShortStringToShortStringMapper.Create(aSourceField : TnxFieldDescriptor;
                                                     aTargetField : TnxFieldDescriptor;
                                                     aMapperDesc  : TnxFieldMapperDescriptor;
                                                 out aMapper      : TnxMappingMethod);
var
  LocaleDescriptor   : TnxLocaleDescriptor;
  CPInfo             : TCPInfo;
  SourceLength       : Integer;
  TargetIsMultiByte  : Boolean;
  RequiresConversion : Boolean;
  RemovePadding      : Boolean;
begin
  inherited Create;

  LocaleDescriptor := aSourceField.UsedLocaleDescriptor;
  if Assigned(LocaleDescriptor) then
    stsSourceCodepage := LocaleDescriptor.StorageCodepage;

  LocaleDescriptor := aTargetField.UsedLocaleDescriptor;
  if Assigned(LocaleDescriptor) then
    stsTargetCodepage := LocaleDescriptor.StorageCodepage;

  SourceLength := aSourceField.fdLength;
  stsTargetLength := aTargetField.fdLength;

  if stsTargetCodepage <> 0 then begin
    Win32Check(GetCPInfo(stsTargetCodepage, CPInfo));
    TargetIsMultiByte := CPInfo.MaxCharSize > 1;
  end else
    TargetIsMultiByte := False;

  RequiresConversion := (stsSourceCodepage <> stsTargetCodepage) or
    (TargetIsMultiByte and (stsTargetLength < SourceLength));

  RemovePadding := (aSourceField.fdDecPl = 0) and (aTargetField.fdDecPl > 0);

  if stsSourceCodepage = 0 then
    RequiresConversion := False
  else if stsTargetCodepage = 0 then
    RequiresConversion := False;

  if RequiresConversion then
    if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
      if RemovePadding then
        aMapper := ToShortStringConvertPadding
      else
        aMapper := ToShortStringConvert
    else
      if RemovePadding then
        aMapper := ToShortStringConvertCheckPadding
      else
        aMapper := ToShortStringConvertCheck
  else
    if stsTargetLength >= SourceLength then
      if RemovePadding then
        aMapper := ToShortStringExpandPadding
      else
        aMapper := ToShortStringExpand
    else
      if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
        if RemovePadding then
          aMapper := ToShortStringTruncPadding
        else
          aMapper := ToShortStringTrunc
      else
        if RemovePadding then
          aMapper := ToShortStringTruncCheckPadding
        else
          aMapper := ToShortStringTruncCheck;
end;
{------------------------------------------------------------------------------}
class function TnxShortStringToShortStringMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                                                         aSourceCursor : TnxAbstractCursor;
                                                                         aTargetField  : TnxFieldDescriptor;
                                                                         aTargetCursor : TnxAbstractCursor;
                                                                         aMapperDesc  : TnxFieldMapperDescriptor;
                                                                     out aMapper       : TnxMappingMethod)
                                                                                       : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  if aSourceField.fdType = nxtShortString then
    if aTargetField.fdType = nxtShortString then
      Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
end;
{------------------------------------------------------------------------------}
function TnxShortStringToShortStringMapper.ToShortStringConvert(const aSource; var aTarget): TnxResult;
var
  Buffer    : array[Byte] of WideChar;
  CharsUsed : Integer;
  i         : Integer;
begin
  Result := DBIERR_NONE;

  if TnxShStr(aSource)[0] = #0 then begin
    TnxShStr(aTarget)[0] := AnsiChar(0);
  end else begin

    CharsUsed := MultiByteToWideChar(stsSourceCodepage, 0,
      @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]),
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    if CharsUsed = 0 then
      nxRaiseLastOSError('TnxShortStringToShortStringMapper'+'.'+'ToShortStringConvert'+'/'+'MultiByteToWideChar');

    if CharsUsed >= stsTargetLength then
      CharsUsed := Pred(stsTargetLength);

    i := WideCharToMultiByte(stsTargetCodepage, 0,
      @Buffer, CharsUsed,
      @TnxShStr(aTarget)[1], Pred(stsTargetLength),
      nil, nil);

    while i = 0 do
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then begin

        Dec(CharsUsed);
        if CharsUsed = 0 then
          break;

        i := WideCharToMultiByte(stsTargetCodepage, 0,
          @Buffer, CharsUsed,
          @TnxShStr(aTarget)[1], Pred(stsTargetLength),
          nil, nil);

      end else
        nxRaiseLastOSError('TnxShortStringToShortStringMapper'+'.'+'ToShortStringConvert'+'/'+'WideCharToMultiByte');

    TnxShStr(aTarget)[0] := AnsiChar(i);
  end;
end;
{------------------------------------------------------------------------------}
function TnxShortStringToShortStringMapper.ToShortStringConvertCheck(const aSource; var aTarget): TnxResult;
var
  Buffer    : array[Byte] of WideChar;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if TnxShStr(aSource)[0] = #0 then begin
    TnxShStr(aTarget)[0] := AnsiChar(0);
  end else begin

    CharsUsed := MultiByteToWideChar(stsSourceCodepage, 0,
      @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]),
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    if CharsUsed = 0 then
      nxRaiseLastOSError('TnxShortStringToShortStringMapper'+'.'+'ToShortStringConvertCheck'+'/'+'MultiByteToWideChar');

    CharsUsed := WideCharToMultiByte(stsTargetCodepage, 0,
      @Buffer, CharsUsed,
      @TnxShStr(aTarget)[1], Pred(stsTargetLength),
      nil, nil);

    if CharsUsed = 0 then
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then
        Result := DBIERR_INVALIDFLDXFORM
      else
        nxRaiseLastOSError('TnxShortStringToShortStringMapper'+'.'+'ToShortStringConvertCheck'+'/'+'WideCharToMultiByte');

    TnxShStr(aTarget)[0] := AnsiChar(CharsUsed);
  end;
end;
{------------------------------------------------------------------------------}
function TnxShortStringToShortStringMapper.ToShortStringConvertCheckPadding(const aSource; var aTarget): TnxResult;
var
  Buffer    : array[Byte] of WideChar;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if TnxShStr(aSource)[0] = #0 then begin
    TnxShStr(aTarget)[0] := AnsiChar(0);
  end else begin

    CharsUsed := MultiByteToWideChar(stsSourceCodepage, 0,
      @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]),
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    if CharsUsed = 0 then
      nxRaiseLastOSError('TnxShortStringToShortStringMapper'+'.'+'ToShortStringConvertCheck'+'/'+'MultiByteToWideChar');

    while (CharsUsed > 0) and (Buffer[Pred(CharsUsed)] = ' ') do
      Dec(CharsUsed);

    if CharsUsed > 0 then begin
      CharsUsed := WideCharToMultiByte(stsTargetCodepage, 0,
        @Buffer, CharsUsed,
        @TnxShStr(aTarget)[1], Pred(stsTargetLength),
        nil, nil);

      if CharsUsed = 0 then
        if GetLastError = ERROR_INSUFFICIENT_BUFFER then
          Result := DBIERR_INVALIDFLDXFORM
        else
          nxRaiseLastOSError('TnxShortStringToShortStringMapper'+'.'+'ToShortStringConvertCheck'+'/'+'WideCharToMultiByte');
    end;

    TnxShStr(aTarget)[0] := AnsiChar(CharsUsed);
  end;
end;
{------------------------------------------------------------------------------}
function TnxShortStringToShortStringMapper.ToShortStringConvertPadding(const aSource; var aTarget): TnxResult;
var
  Buffer    : array[Byte] of WideChar;
  CharsUsed : Integer;
  i         : Integer;
begin
  Result := DBIERR_NONE;

  if TnxShStr(aSource)[0] = #0 then begin
    TnxShStr(aTarget)[0] := AnsiChar(0);
  end else begin

    CharsUsed := MultiByteToWideChar(stsSourceCodepage, 0,
      @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]),
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    if CharsUsed = 0 then
      nxRaiseLastOSError('TnxShortStringToShortStringMapper'+'.'+'ToShortStringConvert'+'/'+'MultiByteToWideChar');

    if CharsUsed >= stsTargetLength then
      CharsUsed := Pred(stsTargetLength);

    while (CharsUsed > 0) and (Buffer[Pred(CharsUsed)] = ' ') do
      Dec(CharsUsed);

    if CharsUsed > 0 then begin
      i := WideCharToMultiByte(stsTargetCodepage, 0,
        @Buffer, CharsUsed,
        @TnxShStr(aTarget)[1], Pred(stsTargetLength),
        nil, nil);

      while i = 0 do
        if GetLastError = ERROR_INSUFFICIENT_BUFFER then begin

          Dec(CharsUsed);
          if CharsUsed = 0 then
            break;

          i := WideCharToMultiByte(stsTargetCodepage, 0,
            @Buffer, CharsUsed,
            @TnxShStr(aTarget)[1], Pred(stsTargetLength),
            nil, nil);

        end else
          nxRaiseLastOSError('TnxShortStringToShortStringMapper'+'.'+'ToShortStringConvert'+'/'+'WideCharToMultiByte');
    end else
      i := 0;

    TnxShStr(aTarget)[0] := AnsiChar(i);
  end;
end;
{------------------------------------------------------------------------------}
function TnxShortStringToShortStringMapper.ToShortStringExpand(const aSource; var aTarget): TnxResult;
begin
  TnxShStr(aTarget) := TnxShStr(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxShortStringToShortStringMapper.ToShortStringExpandPadding(const aSource; var aTarget): TnxResult;
begin
  TnxShStr(aTarget) := TnxShStr(aSource);
  while (Byte(aTarget) > 0) and (TnxShStr(aTarget)[Byte(aTarget)] = ' ') do
    Dec(Byte(aTarget));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxShortStringToShortStringMapper.ToShortStringTrunc(const aSource;
                                                                var aTarget)
                                                                           : TnxResult;
var
  LenToUse : Integer;
begin
  LenToUse := nxMinI32(Ord(TnxShStr(aSource)[0]), Pred(stsTargetLength));
  if LenToUse > 0 then
    nxMove(TnxShStr(aSource)[1], TnxShStr(aTarget)[1], LenToUse);
  TnxShStr(aTarget)[0] := AnsiChar(LenToUse);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxShortStringToShortStringMapper.ToShortStringTruncCheck(const aSource;
                                                                     var aTarget)
                                                                                : TnxResult;
begin
  if Ord(TnxShStr(aSource)[0]) > stsTargetLength then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    TnxShStr(aTarget) := TnxShStr(aSource);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxShortStringToShortStringMapper.ToShortStringTruncCheckPadding(const aSource; var aTarget): TnxResult;
var
  LenToUse : Integer;
begin
  LenToUse := Ord(TnxShStr(aSource)[0]);
  while (LenToUse > 0) and (TnxShStr(aSource)[LenToUse] = ' ') do
    Dec(LenToUse);

  if LenToUse > stsTargetLength then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    nxMove(aSource, aTarget, Succ(LenToUse));
    TnxShStr(aTarget)[0] := AnsiChar(LenToUse);
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxShortStringToShortStringMapper.ToShortStringTruncPadding(const aSource; var aTarget): TnxResult;
var
  LenToUse : Integer;
begin
  LenToUse := nxMinI32(Ord(TnxShStr(aSource)[0]), Pred(stsTargetLength));
  while (LenToUse > 0) and (TnxShStr(aSource)[LenToUse] = ' ') do
    Dec(LenToUse);
  if LenToUse > 0 then
    nxMove(TnxShStr(aSource)[1], TnxShStr(aTarget)[1], LenToUse);
  TnxShStr(aTarget)[0] := AnsiChar(LenToUse);
  Result := DBIERR_NONE;
end;
{==============================================================================}



{==============================================================================}
constructor TnxShortStringToNullStringMapper.Create(aSourceField : TnxFieldDescriptor;
                                                        aTargetField : TnxFieldDescriptor;
                                                        aMapperDesc : TnxFieldMapperDescriptor;
                                                    out aMapper      : TnxMappingMethod);
var
  LocaleDescriptor   : TnxLocaleDescriptor;
  CPInfo             : TCPInfo;
  SourceLength       : Integer;
  TargetIsMultiByte  : Boolean;
  RequiresConversion : Boolean;
  RemovePadding      : Boolean;
begin
  inherited Create;

  LocaleDescriptor := aSourceField.UsedLocaleDescriptor;
  if Assigned(LocaleDescriptor) then
    stnSourceCodepage := LocaleDescriptor.StorageCodepage;

  LocaleDescriptor := aTargetField.UsedLocaleDescriptor;
  if Assigned(LocaleDescriptor) then
    stnTargetCodepage := LocaleDescriptor.StorageCodepage;

  SourceLength := aSourceField.fdLength;
  stnTargetLength := aTargetField.fdLength;

  if stnTargetCodepage <> 0 then begin
    Win32Check(GetCPInfo(stnTargetCodepage, CPInfo));
    TargetIsMultiByte := CPInfo.MaxCharSize > 1;
  end else
    TargetIsMultiByte := False;

  RequiresConversion := (stnSourceCodepage <> stnTargetCodepage) or
    (TargetIsMultiByte and (stnTargetLength < SourceLength));

  RemovePadding := (aSourceField.fdDecPl = 0) and (aTargetField.fdDecPl > 0);

  if stnSourceCodepage = 0 then
    RequiresConversion := False
  else if stnTargetCodepage = 0 then
    RequiresConversion := False;

  if RequiresConversion then
    if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
      if RemovePadding then
        aMapper := ToNullStringConvertPadding
      else
        aMapper := ToNullStringConvert
    else
      if RemovePadding then
        aMapper := ToNullStringConvertCheckPadding
      else
        aMapper := ToNullStringConvertCheck
  else
    if stnTargetLength >= SourceLength then
      if RemovePadding then
        aMapper := ToNullStringPadding
      else
        aMapper := ToNullString
    else
      if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
        if RemovePadding then
          aMapper := ToNullStringPadding
        else
          aMapper := ToNullString
      else
        if RemovePadding then
          aMapper := ToNullStringTruncCheckPadding
        else
          aMapper := ToNullStringTruncCheck;
end;
{------------------------------------------------------------------------------}
class function TnxShortStringToNullStringMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                                                         aSourceCursor : TnxAbstractCursor;
                                                                         aTargetField  : TnxFieldDescriptor;
                                                                         aTargetCursor : TnxAbstractCursor;
                                                                         aMapperDesc  : TnxFieldMapperDescriptor;
                                                                     out aMapper       : TnxMappingMethod)
                                                                                       : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  if aSourceField.fdType = nxtShortString then
    if aTargetField.fdType = nxtNullString then
      Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
end;
{------------------------------------------------------------------------------}
function TnxShortStringToNullStringMapper.ToNullStringConvert(const aSource; var aTarget): TnxResult;
var
  Buffer    : array[Byte] of WideChar;
  CharsUsed : Integer;
  i         : Integer;
begin
  Result := DBIERR_NONE;

  if TnxShStr(aSource)[0] = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin

    CharsUsed := MultiByteToWideChar(stnSourceCodepage, 0,
      @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]),
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    if CharsUsed = 0 then
      nxRaiseLastOSError('TnxShortStringToNullStringMapper'+'.'+'ToNullStringConvertCheck'+'/'+'MultiByteToWideChar');

    if CharsUsed >= stnTargetLength then
      CharsUsed := Pred(stnTargetLength);

    i := WideCharToMultiByte(stnTargetCodepage, 0,
      @Buffer, CharsUsed,
      @aTarget, Pred(stnTargetLength),
      nil, nil);

    while i = 0 do
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then begin

        Dec(CharsUsed);
        if CharsUsed = 0 then
          break;

        i := WideCharToMultiByte(stnTargetCodepage, 0,
          @Buffer, CharsUsed,
          @aTarget, Pred(stnTargetLength),
          nil, nil);

      end else
        nxRaiseLastOSError('TnxShortStringToNullStringMapper'+'.'+'ToNullStringConvertCheck'+'/'+'WideCharToMultiByte');

    PAnsiChar(@aTarget)[i] := #0;
  end;
end;
{------------------------------------------------------------------------------}
function TnxShortStringToNullStringMapper.ToNullStringConvertCheck(const aSource; var aTarget): TnxResult;
var
  Buffer    : array[Byte] of WideChar;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if TnxShStr(aSource)[0] = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin

    CharsUsed := MultiByteToWideChar(stnSourceCodepage, 0,
      @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]),
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    if CharsUsed = 0 then
      nxRaiseLastOSError('TnxShortStringToNullStringMapper'+'.'+'ToNullStringConvertCheck'+'/'+'MultiByteToWideChar');

    CharsUsed := WideCharToMultiByte(stnTargetCodepage, 0,
      @Buffer, CharsUsed,
      @aTarget, Pred(stnTargetLength),
      nil, nil);

    if CharsUsed = 0 then
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then
        Result := DBIERR_INVALIDFLDXFORM
      else
        nxRaiseLastOSError('TnxShortStringToNullStringMapper'+'.'+'ToNullStringConvertCheck'+'/'+'WideCharToMultiByte');

    PAnsiChar(@aTarget)[CharsUsed] := #0;
  end;
end;
{------------------------------------------------------------------------------}
function TnxShortStringToNullStringMapper.ToNullString(const aSource;
                                                         var aTarget)
                                                                    : TnxResult;
var
  LenToUse : Integer;
begin
  LenToUse := nxMinI32(Ord(TnxShStr(aSource)[0]), Pred(stnTargetLength));
  if LenToUse > 0 then
    nxMove(TnxShStr(aSource)[1], aTarget, LenToUse);
  PAnsiChar(@aTarget)[LenToUse] := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxShortStringToNullStringMapper.ToNullStringTruncCheck(const aSource;
                                                                      var aTarget)
                                                                                 : TnxResult;
var
  LenToUse : Integer;
begin
  if Ord(TnxShStr(aSource)[0]) >= stnTargetLength then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    LenToUse := Ord(TnxShStr(aSource)[0]);
    if LenToUse > 0 then
      nxMove(TnxShStr(aSource)[1], aTarget, LenToUse);
    PAnsiChar(@aTarget)[LenToUse] := #0;
    Result := DBIERR_NONE;
  end;
end;
{==============================================================================}



{==============================================================================}
constructor TnxNullStringToNullStringMapper.Create(aSourceField : TnxFieldDescriptor;
                                                        aTargetField : TnxFieldDescriptor;
                                                        aMapperDesc : TnxFieldMapperDescriptor;
                                                    out aMapper      : TnxMappingMethod);
var
  LocaleDescriptor   : TnxLocaleDescriptor;
  CPInfo             : TCPInfo;
  SourceLength       : Integer;
  TargetIsMultiByte  : Boolean;
  RequiresConversion : Boolean;
  RemovePadding      : Boolean;
begin
  inherited Create;

  LocaleDescriptor := aSourceField.UsedLocaleDescriptor;
  if Assigned(LocaleDescriptor) then
    ntnSourceCodepage := LocaleDescriptor.StorageCodepage;

  LocaleDescriptor := aTargetField.UsedLocaleDescriptor;
  if Assigned(LocaleDescriptor) then
    ntnTargetCodepage := LocaleDescriptor.StorageCodepage;

  SourceLength := aSourceField.fdLength;
  ntnTargetLength := aTargetField.fdLength;

  if ntnTargetCodepage <> 0 then begin
    Win32Check(GetCPInfo(ntnTargetCodepage, CPInfo));
    TargetIsMultiByte := CPInfo.MaxCharSize > 1;
  end else
    TargetIsMultiByte := False;

  RequiresConversion := (ntnSourceCodepage <> ntnTargetCodepage) or
    (TargetIsMultiByte and (ntnTargetLength < SourceLength));

  RemovePadding := (aSourceField.fdDecPl = 0) and (aTargetField.fdDecPl > 0);

  if ntnSourceCodepage = 0 then
    RequiresConversion := False
  else if ntnTargetCodepage = 0 then
    RequiresConversion := False;

  if RequiresConversion then
    if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
      if RemovePadding then
        aMapper := ToNullStringConvertPadding
      else
        aMapper := ToNullStringConvert
    else
      if RemovePadding then
        aMapper := ToNullStringConvertCheckPadding
      else
        aMapper := ToNullStringConvertCheck
  else
    if ntnTargetLength >= SourceLength then
      if RemovePadding then
        aMapper := ToNullStringPadding
      else
        aMapper := ToNullString
    else
      if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
        if RemovePadding then
          aMapper := ToNullStringPadding
        else
          aMapper := ToNullString
      else
        if RemovePadding then
          aMapper := ToNullStringTruncCheckPadding
        else
          aMapper := ToNullStringTruncCheck;
end;
{------------------------------------------------------------------------------}
class function TnxNullStringToNullStringMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                                                         aSourceCursor : TnxAbstractCursor;
                                                                         aTargetField  : TnxFieldDescriptor;
                                                                         aTargetCursor : TnxAbstractCursor;
                                                                         aMapperDesc  : TnxFieldMapperDescriptor;
                                                                     out aMapper       : TnxMappingMethod)
                                                                                       : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  if aSourceField.fdType = nxtNullString then
    if aTargetField.fdType = nxtNullString then
      Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
end;
{------------------------------------------------------------------------------}
function TnxNullStringToNullStringMapper.ToNullStringConvert(const aSource; var aTarget): TnxResult;
var
  Buffer    : array[Word] of WideChar;
  CharsUsed : Integer;
  i         : Integer;
begin
  Result := DBIERR_NONE;

  if PAnsiChar(@aSource)[0] = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin

    CharsUsed := MultiByteToWideChar(ntnSourceCodepage, 0,
      @aSource, StrLen(PAnsiChar(@aSource)),
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    if CharsUsed = 0 then
      nxRaiseLastOSError('TnxNullStringToNullStringMapper'+'.'+'ToNullStringConvertCheck'+'/'+'MultiByteToWideChar');

    if CharsUsed >= ntnTargetLength then
      CharsUsed := Pred(ntnTargetLength);

    i := WideCharToMultiByte(ntnTargetCodepage, 0,
      @Buffer, CharsUsed,
      @aTarget, Pred(ntnTargetLength),
      nil, nil);

    while i = 0 do
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then begin

        Dec(CharsUsed);
        if CharsUsed = 0 then
          break;

        i := WideCharToMultiByte(ntnTargetCodepage, 0,
          @Buffer, CharsUsed,
          @aTarget, Pred(ntnTargetLength),
          nil, nil);

      end else
        nxRaiseLastOSError('TnxNullStringToNullStringMapper'+'.'+'ToNullStringConvertCheck'+'/'+'WideCharToMultiByte');

    PAnsiChar(@aTarget)[i] := #0;
  end;
end;
{------------------------------------------------------------------------------}
function TnxNullStringToNullStringMapper.ToNullStringConvertCheck(const aSource; var aTarget): TnxResult;
var
  Buffer    : array[Word] of WideChar;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if PAnsiChar(@aSource)[0] = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin

    CharsUsed := MultiByteToWideChar(ntnSourceCodepage, 0,
      @aSource, StrLen(PAnsiChar(@aSource)),
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    if CharsUsed = 0 then
      nxRaiseLastOSError('TnxNullStringToNullStringMapper'+'.'+'ToNullStringConvertCheck'+'/'+'MultiByteToWideChar');

    CharsUsed := WideCharToMultiByte(ntnTargetCodepage, 0,
      @Buffer, CharsUsed,
      @aTarget, Pred(ntnTargetLength),
      nil, nil);

    if CharsUsed = 0 then
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then
        Result := DBIERR_INVALIDFLDXFORM
      else
        nxRaiseLastOSError('TnxNullStringToNullStringMapper'+'.'+'ToNullStringConvertCheck'+'/'+'WideCharToMultiByte');

    PAnsiChar(@aTarget)[CharsUsed] := #0;
  end;
end;
{------------------------------------------------------------------------------}
function TnxNullStringToNullStringMapper.ToNullString(const aSource;
                                                        var aTarget)
                                                                   : TnxResult;
begin
  StrLCopy(PAnsiChar(@aTarget), PAnsiChar(@aSource), Pred(ntnTargetLength));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxNullStringToNullStringMapper.ToNullStringTruncCheck(const aSource;
                                                                  var aTarget)
                                                                             : TnxResult;
var
  LenToUse : Integer;
begin
  LenToUse := StrLen(PAnsiChar(@aSource));
  if LenToUse >= ntnTargetLength then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    if LenToUse > 0 then
      nxMove(aSource, aTarget, LenToUse);
    PAnsiChar(@aTarget)[LenToUse] := #0;
    Result := DBIERR_NONE;
  end;
end;
{==============================================================================}



{==============================================================================}
constructor TnxNullStringToShortStringMapper.Create(aSourceField : TnxFieldDescriptor;
                                                       aTargetField : TnxFieldDescriptor;
                                                       aMapperDesc : TnxFieldMapperDescriptor;
                                                   out aMapper      : TnxMappingMethod);
var
  LocaleDescriptor   : TnxLocaleDescriptor;
  CPInfo             : TCPInfo;
  SourceLength       : Integer;
  TargetIsMultiByte  : Boolean;
  RequiresConversion : Boolean;
  RemovePadding      : Boolean;
begin
  inherited Create;

  LocaleDescriptor := aSourceField.UsedLocaleDescriptor;
  if Assigned(LocaleDescriptor) then
    ntsSourceCodepage := LocaleDescriptor.StorageCodepage;

  LocaleDescriptor := aTargetField.UsedLocaleDescriptor;
  if Assigned(LocaleDescriptor) then
    ntsTargetCodepage := LocaleDescriptor.StorageCodepage;

  SourceLength := aSourceField.fdLength;
  ntsTargetLength := aTargetField.fdLength;

  if ntsTargetCodepage <> 0 then begin
    Win32Check(GetCPInfo(ntsTargetCodepage, CPInfo));
    TargetIsMultiByte := CPInfo.MaxCharSize > 1;
  end else
    TargetIsMultiByte := False;

  RequiresConversion := (ntsSourceCodepage <> ntsTargetCodepage) or
    (TargetIsMultiByte and (ntsTargetLength < SourceLength));

  RemovePadding := (aSourceField.fdDecPl = 0) and (aTargetField.fdDecPl > 0);

  if ntsSourceCodepage = 0 then
    RequiresConversion := False
  else if ntsTargetCodepage = 0 then
    RequiresConversion := False;

  if RequiresConversion then
    if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
      if RemovePadding then
        aMapper := ToShortStringConvertPadding
      else
        aMapper := ToShortStringConvert
    else
      if RemovePadding then
        aMapper := ToShortStringConvertCheckPadding
      else
        aMapper := ToShortStringConvertCheck
  else
    if ntsTargetLength >= SourceLength then
      if RemovePadding then
        aMapper := ToShortStringPadding
      else
        aMapper := ToShortString
    else
      if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
        if RemovePadding then
          aMapper := ToShortStringPadding
        else
          aMapper := ToShortString
      else
        if RemovePadding then
          aMapper := ToShortStringTruncCheckPadding
        else
          aMapper := ToShortStringTruncCheck;
end;
{------------------------------------------------------------------------------}
class function TnxNullStringToShortStringMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                                                         aSourceCursor : TnxAbstractCursor;
                                                                         aTargetField  : TnxFieldDescriptor;
                                                                         aTargetCursor : TnxAbstractCursor;
                                                                         aMapperDesc  : TnxFieldMapperDescriptor;
                                                                     out aMapper       : TnxMappingMethod)
                                                                                       : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  if aSourceField.fdType = nxtNullString then
    if aTargetField.fdType = nxtShortString then
      Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
end;
{------------------------------------------------------------------------------}
function TnxNullStringToShortStringMapper.ToShortStringConvert(const aSource; var aTarget): TnxResult;
var
  Buffer    : array[Word] of WideChar;
  CharsUsed : Integer;
  i         : Integer;
begin
  Result := DBIERR_NONE;

  if PAnsiChar(@aSource)[0] = #0 then begin
    TnxShStr(aTarget)[0] := AnsiChar(0);
  end else begin

    CharsUsed := MultiByteToWideChar(ntsSourceCodepage, 0,
      @aSource, StrLen(PAnsiChar(@aSource)),
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    if CharsUsed = 0 then
      nxRaiseLastOSError('TnxNullStringToShortStringMapper'+'.'+'ToShortStringConvertCheck'+'/'+'MultiByteToWideChar');

    if CharsUsed >= ntsTargetLength then
      CharsUsed := Pred(ntsTargetLength);

    i := WideCharToMultiByte(ntsTargetCodepage, 0,
      @Buffer, CharsUsed,
      @TnxShStr(aTarget)[1], Pred(ntsTargetLength),
      nil, nil);

    while i = 0 do
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then begin

        Dec(CharsUsed);
        if CharsUsed = 0 then
          break;

        i := WideCharToMultiByte(ntsTargetCodepage, 0,
          @Buffer, CharsUsed,
          @TnxShStr(aTarget)[1], Pred(ntsTargetLength),
          nil, nil);

      end else
        nxRaiseLastOSError('TnxNullStringToShortStringMapper'+'.'+'ToShortStringConvertCheck'+'/'+'WideCharToMultiByte');

    TnxShStr(aTarget)[0] := AnsiChar(i);
  end;
end;
{------------------------------------------------------------------------------}
function TnxNullStringToShortStringMapper.ToShortStringConvertCheck(const aSource; var aTarget): TnxResult;
var
  Buffer    : array[Word] of WideChar;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if PAnsiChar(@aSource)[0] = #0 then begin
    TnxShStr(aTarget)[0] := AnsiChar(0);
  end else begin

    CharsUsed := MultiByteToWideChar(ntsSourceCodepage, 0,
      @aSource, StrLen(PAnsiChar(@aSource)),
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    if CharsUsed = 0 then
      nxRaiseLastOSError('TnxNullStringToShortStringMapper'+'.'+'ToShortStringConvertCheck'+'/'+'MultiByteToWideChar');

    CharsUsed := WideCharToMultiByte(ntsTargetCodepage, 0,
      @Buffer, CharsUsed,
      @TnxShStr(aTarget)[1], Pred(ntsTargetLength),
      nil, nil);

    if CharsUsed = 0 then
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then
        Result := DBIERR_INVALIDFLDXFORM
      else
        nxRaiseLastOSError('TnxNullStringToShortStringMapper'+'.'+'ToShortStringConvertCheck'+'/'+'WideCharToMultiByte');

    TnxShStr(aTarget)[0] := AnsiChar(CharsUsed);
  end;
end;
{------------------------------------------------------------------------------}
function TnxNullStringToShortStringMapper.ToShortString(const aSource;
                                                          var aTarget)
                                                                     : TnxResult;

var
  LenToUse : Integer;
begin
  LenToUse := nxMinI32(StrLen(PAnsiChar(@aSource)), Pred(ntsTargetLength));
  if LenToUse > 0 then
    nxMove(aSource, TnxShStr(aTarget)[1], LenToUse);
  TnxShStr(aTarget)[0] := AnsiChar(LenToUse);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxNullStringToShortStringMapper.ToShortStringTruncCheck(const aSource;
                                                                    var aTarget)
                                                                        : TnxResult;
var
  LenToUse : Integer;
begin
  LenToUse := StrLen(PAnsiChar(@aSource));
  if LenToUse >= ntsTargetLength then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    if LenToUse > 0 then
      nxMove(aSource, TnxShStr(aTarget)[1], LenToUse);
    TnxShStr(aTarget)[0] := AnsiChar(LenToUse);
    Result := DBIERR_NONE;
  end;
end;
{==============================================================================}



{==============================================================================}
constructor TnxWideStringToAnsiStringMapper.Create(aSourceField : TnxFieldDescriptor;
                                                   aTargetField : TnxFieldDescriptor;
                                                   aMapperDesc : TnxFieldMapperDescriptor;
                                               out aMapper      : TnxMappingMethod);
var
  LocaleDescriptor   : TnxLocaleDescriptor;
  RemovePadding      : Boolean;
begin
  inherited Create;

  LocaleDescriptor := aTargetField.UsedLocaleDescriptor;
  if Assigned(LocaleDescriptor) then
    wtaTargetCodepage := LocaleDescriptor.StorageCodepage;

  if wtaTargetCodepage = 0 then
    wtaTargetCodepage := CP_ACP;

  wtaTargetLength := aTargetField.fdLength;
  RemovePadding := (aSourceField.fdDecPl = 0) and (aTargetField.fdDecPl > 0);

  case aTargetField.fdType of
    nxtShortString:
      if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
        if RemovePadding then
          aMapper := ToShortStringConvertPadding
        else
          aMapper := ToShortStringConvert
      else
        if RemovePadding then
          aMapper := ToShortStringConvertCheckPadding
        else
          aMapper := ToShortStringConvertCheck;
    nxtNullString:
      if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
        if RemovePadding then
          aMapper := ToNullStringConvertPadding
        else
          aMapper := ToNullStringConvert
      else
        if RemovePadding then
          aMapper := ToNullStringConvertCheckPadding
        else
          aMapper := ToNullStringConvertCheck;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxWideStringToAnsiStringMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                                                    aSourceCursor : TnxAbstractCursor;
                                                                    aTargetField  : TnxFieldDescriptor;
                                                                    aTargetCursor : TnxAbstractCursor;
                                                                    aMapperDesc   : TnxFieldMapperDescriptor;
                                                                out aMapper       : TnxMappingMethod)
                                                                                  : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  if aSourceField.fdType = nxtWideString then
    if aTargetField.fdType in [nxtShortString, nxtNullString] then
      Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
end;
{------------------------------------------------------------------------------}
function TnxWideStringToAnsiStringMapper.ToNullStringConvert(const aSource; var aTarget): TnxResult;
var
  CharsUsed : Integer;
  i         : Integer;
begin
  Result := DBIERR_NONE;

  if PWideChar(@aSource)[0] = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin

    CharsUsed := lstrlenW(@aSource);

    if CharsUsed >= wtaTargetLength then
      CharsUsed := Pred(wtaTargetLength);

    i := WideCharToMultiByte(wtaTargetCodepage, 0,
      @aSource, CharsUsed,
      @aTarget, Pred(wtaTargetLength),
      nil, nil);

    while i = 0 do
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then begin

        Dec(CharsUsed);
        if CharsUsed = 0 then
          break;

        i := WideCharToMultiByte(wtaTargetCodepage, 0,
          @aSource, CharsUsed,
          @aTarget, Pred(wtaTargetLength),
          nil, nil);

      end else
        nxRaiseLastOSError('TnxWideStringToAnsiStringMapper'+'.'+'ToNullStringConvert'+'/'+'WideCharToMultiByte');

    PAnsiChar(@aTarget)[i] := #0;
  end;
end;
{------------------------------------------------------------------------------}
function TnxWideStringToAnsiStringMapper.ToNullStringConvertCheck(const aSource; var aTarget): TnxResult;
var
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if PWideChar(@aSource)[0] = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin

    CharsUsed := lstrlenW(@aSource);

    CharsUsed := WideCharToMultiByte(wtaTargetCodepage, 0,
      @aSource, CharsUsed,
      @aTarget, Pred(wtaTargetLength),
      nil, nil);

    if CharsUsed = 0 then
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then
        Result := DBIERR_INVALIDFLDXFORM
      else
        nxRaiseLastOSError('TnxWideStringToAnsiStringMapper'+'.'+'ToNullStringConvertCheck'+'/'+'WideCharToMultiByte');

    PAnsiChar(@aTarget)[CharsUsed] := #0;
  end;
end;
{------------------------------------------------------------------------------}
function TnxWideStringToAnsiStringMapper.ToNullStringConvertCheckPadding(const aSource; var aTarget): TnxResult;
var
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if PWideChar(@aSource)[0] = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin

    CharsUsed := lstrlenW(@aSource);

    while (CharsUsed > 0) and (PWideChar(@aSource)[Pred(CharsUsed)] = ' ') do
      Dec(CharsUsed);

    if CharsUsed > 0 then begin
      CharsUsed := WideCharToMultiByte(wtaTargetCodepage, 0,
        @aSource, CharsUsed,
        @aTarget, Pred(wtaTargetLength),
        nil, nil);

      if CharsUsed = 0 then
        if GetLastError = ERROR_INSUFFICIENT_BUFFER then
          Result := DBIERR_INVALIDFLDXFORM
        else
          nxRaiseLastOSError('TnxWideStringToAnsiStringMapper'+'.'+'ToNullStringConvertCheck'+'/'+'WideCharToMultiByte');
    end;

    PAnsiChar(@aTarget)[CharsUsed] := #0;
  end;
end;

function TnxWideStringToAnsiStringMapper.ToNullStringConvertPadding(const aSource; var aTarget): TnxResult;
var
  CharsUsed : Integer;
  i         : Integer;
begin
  Result := DBIERR_NONE;

  if PWideChar(@aSource)[0] = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin

    CharsUsed := lstrlenW(@aSource);

    if CharsUsed >= wtaTargetLength then
      CharsUsed := Pred(wtaTargetLength);

    while (CharsUsed > 0) and (PWideChar(@aSource)[Pred(CharsUsed)] = ' ') do
      Dec(CharsUsed);

    if CharsUsed > 0 then begin
      i := WideCharToMultiByte(wtaTargetCodepage, 0,
        @aSource, CharsUsed,
        @aTarget, Pred(wtaTargetLength),
        nil, nil);

      while i = 0 do
        if GetLastError = ERROR_INSUFFICIENT_BUFFER then begin

          Dec(CharsUsed);
          if CharsUsed = 0 then
            break;

          i := WideCharToMultiByte(wtaTargetCodepage, 0,
            @aSource, CharsUsed,
            @aTarget, Pred(wtaTargetLength),
            nil, nil);

        end else
          nxRaiseLastOSError('TnxWideStringToAnsiStringMapper'+'.'+'ToNullStringConvert'+'/'+'WideCharToMultiByte');
    end else
      i := 0;

    PAnsiChar(@aTarget)[i] := #0;
  end;
end;

function TnxWideStringToAnsiStringMapper.ToShortStringConvert(const aSource; var aTarget): TnxResult;
var
  CharsUsed : Integer;
  i         : Integer;
begin
  Result := DBIERR_NONE;

  if PWideChar(@aSource)[0] = #0 then begin
    TnxShStr(aTarget)[0] := AnsiChar(0);
  end else begin

    CharsUsed := lstrlenW(@aSource);

    if CharsUsed >= wtaTargetLength then
      CharsUsed := Pred(wtaTargetLength);

    i := WideCharToMultiByte(wtaTargetCodepage, 0,
      @aSource, CharsUsed,
      @TnxShStr(aTarget)[1], Pred(wtaTargetLength),
      nil, nil);

    while i = 0 do
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then begin

        Dec(CharsUsed);
        if CharsUsed = 0 then
          break;

        i := WideCharToMultiByte(wtaTargetCodepage, 0,
          @aSource, CharsUsed,
          @TnxShStr(aTarget)[1], Pred(wtaTargetLength),
          nil, nil);

      end else
        nxRaiseLastOSError('TnxWideStringToAnsiStringMapper'+'.'+'ToShortStringConvert'+'/'+'WideCharToMultiByte');

    TnxShStr(aTarget)[0] := AnsiChar(i);
  end;
end;
{------------------------------------------------------------------------------}
function TnxWideStringToAnsiStringMapper.ToShortStringConvertCheck(const aSource; var aTarget): TnxResult;
var
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if PWideChar(@aSource)[0] = #0 then begin
    TnxShStr(aTarget)[0] := AnsiChar(0);
  end else begin

    CharsUsed := lstrlenW(@aSource);

    CharsUsed := WideCharToMultiByte(wtaTargetCodepage, 0,
      @aSource, CharsUsed,
      @TnxShStr(aTarget)[1], Pred(wtaTargetLength),
      nil, nil);

    if CharsUsed = 0 then
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then
        Result := DBIERR_INVALIDFLDXFORM
      else
        nxRaiseLastOSError('TnxWideStringToAnsiStringMapper'+'.'+'ToShortStringConvertCheck'+'/'+'WideCharToMultiByte');

    TnxShStr(aTarget)[0] := AnsiChar(CharsUsed);
  end;
end;
{==============================================================================}



{==============================================================================}
constructor TnxAnsiStringToWideStringMapper.Create(aSourceField : TnxFieldDescriptor;
                                                      aTargetField : TnxFieldDescriptor;
                                                      aMapperDesc : TnxFieldMapperDescriptor;
                                                  out aMapper      : TnxMappingMethod);
var
  LocaleDescriptor   : TnxLocaleDescriptor;
  RemovePadding      : Boolean;
begin
  inherited Create;

  LocaleDescriptor := aSourceField.UsedLocaleDescriptor;
  if Assigned(LocaleDescriptor) then
    atwSourceCodepage := LocaleDescriptor.StorageCodepage;

  if atwSourceCodepage = 0 then
    atwSourceCodepage := CP_ACP;

  atwTargetLength := aTargetField.fdLength;

  RemovePadding := (aSourceField.fdDecPl = 0) and (aTargetField.fdDecPl > 0);

  case aSourceField.fdType of
    nxtShortString:
      if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
        if RemovePadding then
          aMapper := FromShortStringConvertPadding
        else
          aMapper := FromShortStringConvert
      else
        if RemovePadding then
          aMapper := FromShortStringConvertCheckPadding
        else
          aMapper := FromShortStringConvertCheck;
    nxtNullString, nxtBlobMemo, nxtBlob:
      if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
        if RemovePadding then
          aMapper := FromNullStringConvertPadding
        else
          aMapper := FromNullStringConvert
      else
        if RemovePadding then
          aMapper := FromNullStringConvertCheckPadding
        else
          aMapper := FromNullStringConvertCheck;
  end;
end;
{------------------------------------------------------------------------------}
function TnxAnsiStringToWideStringMapper.FromNullStringConvert(const aSource;
                                                                    var aTarget)
                                                                               : TnxResult;
var
  Buffer    : array[Word] of WideChar;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if PAnsiChar(@aSource)[0] = #0 then begin
    PWideChar(@aTarget)[0] := #0;
  end else begin
    CharsUsed := MultiByteToWideChar(atwSourceCodepage, 0,
      @aSource, StrLen(PAnsiChar(@aSource)),
      @aTarget, Pred(atwTargetLength div SizeOf(WideChar)));

    if CharsUsed = 0 then
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then begin

        CharsUsed := MultiByteToWideChar(atwSourceCodepage, 0,
          @aSource, StrLen(PAnsiChar(@aSource)),
          @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

        if CharsUsed = 0 then
          nxRaiseLastOSError('TnxAnsiStringToWideStringMapper'+'.'+'FromNullStringConvert'+'/'+'MultiByteToWideChar');

        CharsUsed := nxMinI32(CharsUsed, Pred(atwTargetLength div SizeOf(WideChar)));

        nxMove(Buffer, aTarget, CharsUsed * SizeOf(WideChar));
      end else
        nxRaiseLastOSError('TnxAnsiStringToWideStringMapper'+'.'+'FromNullStringConvert'+'/'+'MultiByteToWideChar');

    PWideChar(@aTarget)[CharsUsed] := #0;
  end;
end;
{------------------------------------------------------------------------------}
function TnxAnsiStringToWideStringMapper.FromNullStringConvertCheck(const aSource;
                                                                         var aTarget)
                                                                                    : TnxResult;
var
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if PAnsiChar(@aSource)[0] = #0 then begin
    PWideChar(@aTarget)[0] := #0;
  end else begin
    CharsUsed := MultiByteToWideChar(atwSourceCodepage, 0,
      @aSource, StrLen(PAnsiChar(@aSource)),
      @aTarget, Pred(atwTargetLength div SizeOf(WideChar)));

    if CharsUsed = 0 then
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then
        Result := DBIERR_INVALIDFLDXFORM
      else
        nxRaiseLastOSError('TnxAnsiStringToWideStringMapper'+'.'+'FromNullStringConvertCheck'+'/'+'MultiByteToWideChar');

    PWideChar(@aTarget)[CharsUsed] := #0;
  end;
end;
{------------------------------------------------------------------------------}
function TnxAnsiStringToWideStringMapper.FromNullStringConvertCheckPadding(const aSource; var aTarget): TnxResult;
var
  LenToUse  : Integer;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if PAnsiChar(@aSource)[0] = #0 then begin
    PWideChar(@aTarget)[0] := #0;
  end else begin
    LenToUse := StrLen(PAnsiChar(@aSource));

    while (LenToUse > 0) and (PAnsiChar(@aSource)[Pred(LenToUse)] = ' ') do
      Dec(LenToUse);

    if LenToUse > 0 then begin
      CharsUsed := MultiByteToWideChar(atwSourceCodepage, 0,
        @aSource, LenToUse,
        @aTarget, Pred(atwTargetLength div SizeOf(WideChar)));

      if CharsUsed = 0 then
        if GetLastError = ERROR_INSUFFICIENT_BUFFER then
          Result := DBIERR_INVALIDFLDXFORM
        else
          nxRaiseLastOSError('TnxAnsiStringToWideStringMapper'+'.'+'FromNullStringConvertCheck'+'/'+'MultiByteToWideChar');
    end else
      CharsUsed := 0;

    PWideChar(@aTarget)[CharsUsed] := #0;
  end;
end;

function TnxAnsiStringToWideStringMapper.FromNullStringConvertPadding(const aSource; var aTarget): TnxResult;
var
  Buffer    : array[Word] of WideChar;
  LenToUse  : Integer;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if PAnsiChar(@aSource)[0] = #0 then begin
    PWideChar(@aTarget)[0] := #0;
  end else begin
    LenToUse := StrLen(PAnsiChar(@aSource));

    while (LenToUse > 0) and (PAnsiChar(@aSource)[Pred(LenToUse)] = ' ') do
      Dec(LenToUse);

    if LenToUse > 0 then begin
      CharsUsed := MultiByteToWideChar(atwSourceCodepage, 0,
        @aSource, LenToUse,
        @aTarget, Pred(atwTargetLength div SizeOf(WideChar)));

      if CharsUsed = 0 then
        if GetLastError = ERROR_INSUFFICIENT_BUFFER then begin

          CharsUsed := MultiByteToWideChar(atwSourceCodepage, 0,
            @aSource, LenToUse,
            @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

          if CharsUsed = 0 then
            nxRaiseLastOSError('TnxAnsiStringToWideStringMapper'+'.'+'FromNullStringConvert'+'/'+'MultiByteToWideChar');

          CharsUsed := nxMinI32(CharsUsed, Pred(atwTargetLength div SizeOf(WideChar)));

          nxMove(Buffer, aTarget, CharsUsed * SizeOf(WideChar));
        end else
          nxRaiseLastOSError('TnxAnsiStringToWideStringMapper'+'.'+'FromNullStringConvert'+'/'+'MultiByteToWideChar');
    end else
      CharsUsed := 0;

    PWideChar(@aTarget)[CharsUsed] := #0;
  end;
end;

function TnxAnsiStringToWideStringMapper.FromShortStringConvert(const aSource;
                                                                  var aTarget)
                                                                    : TnxResult;
var
  Buffer    : array[Byte] of WideChar;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if TnxShStr(aSource)[0] = #0 then begin
    PWideChar(@aTarget)[0] := #0;
  end else begin
    CharsUsed := MultiByteToWideChar(atwSourceCodepage, 0,
      @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]),
      @aTarget, Pred(atwTargetLength div SizeOf(WideChar)));

    if CharsUsed = 0 then
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then begin

        CharsUsed := MultiByteToWideChar(atwSourceCodepage, 0,
          @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]),
          @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

        if CharsUsed = 0 then
          nxRaiseLastOSError('TnxAnsiStringToWideStringMapper'+'.'+'FromShortStringConvert'+'/'+'MultiByteToWideChar');

        CharsUsed := nxMinI32(CharsUsed, Pred(atwTargetLength div SizeOf(WideChar)));

        nxMove(Buffer, aTarget, CharsUsed * SizeOf(WideChar));
      end else
        nxRaiseLastOSError('TnxAnsiStringToWideStringMapper'+'.'+'FromShortStringConvert'+'/'+'MultiByteToWideChar');

    PWideChar(@aTarget)[CharsUsed] := #0;
  end;
end;
{------------------------------------------------------------------------------}
function TnxAnsiStringToWideStringMapper.FromShortStringConvertCheck(const aSource; var aTarget): TnxResult;
var
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if TnxShStr(aSource)[0] = #0 then begin
    PWideChar(@aTarget)[0] := #0;
  end else begin
    CharsUsed := MultiByteToWideChar(atwSourceCodepage, 0,
      @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]),
      @aTarget, Pred(atwTargetLength div SizeOf(WideChar)));

    if CharsUsed = 0 then
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then
        Result := DBIERR_INVALIDFLDXFORM
      else
        nxRaiseLastOSError('TnxAnsiStringToWideStringMapper'+'.'+'FromShortStringConvertCheck'+'/'+'MultiByteToWideChar');

    PWideChar(@aTarget)[CharsUsed] := #0;
  end;
end;
{------------------------------------------------------------------------------}
function TnxAnsiStringToWideStringMapper.FromShortStringConvertCheckPadding(const aSource; var aTarget): TnxResult;
var
  LenToUse  : Integer;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if TnxShStr(aSource)[0] = #0 then begin
    PWideChar(@aTarget)[0] := #0;
  end else begin
    LenToUse := Byte(aSource);

    while (LenToUse > 0) and (TnxShStr(aSource)[LenToUse] = ' ') do
      Dec(LenToUse);

    if LenToUse > 0 then begin
      CharsUsed := MultiByteToWideChar(atwSourceCodepage, 0,
        @TnxShStr(aSource)[1], LenToUse,
        @aTarget, Pred(atwTargetLength div SizeOf(WideChar)));

      if CharsUsed = 0 then
        if GetLastError = ERROR_INSUFFICIENT_BUFFER then
          Result := DBIERR_INVALIDFLDXFORM
        else
          nxRaiseLastOSError('TnxAnsiStringToWideStringMapper'+'.'+'FromShortStringConvertCheck'+'/'+'MultiByteToWideChar');
    end else
      CharsUsed := 0;

    PWideChar(@aTarget)[CharsUsed] := #0;
  end;
end;

function TnxAnsiStringToWideStringMapper.FromShortStringConvertPadding(const aSource; var aTarget): TnxResult;
var
  Buffer    : array[Byte] of WideChar;
  LenToUse  : Integer;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if TnxShStr(aSource)[0] = #0 then begin
    PWideChar(@aTarget)[0] := #0;
  end else begin
    LenToUse := Byte(aSource);

    while (LenToUse > 0) and (TnxShStr(aSource)[LenToUse] = ' ') do
      Dec(LenToUse);

    if LenToUse > 0 then begin
      CharsUsed := MultiByteToWideChar(atwSourceCodepage, 0,
        @TnxShStr(aSource)[1], LenToUse,
        @aTarget, Pred(atwTargetLength div SizeOf(WideChar)));

      if CharsUsed = 0 then
        if GetLastError = ERROR_INSUFFICIENT_BUFFER then begin

          CharsUsed := MultiByteToWideChar(atwSourceCodepage, 0,
            @TnxShStr(aSource)[1], LenToUse,
            @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

          if CharsUsed = 0 then
            nxRaiseLastOSError('TnxAnsiStringToWideStringMapper'+'.'+'FromShortStringConvert'+'/'+'MultiByteToWideChar');

          CharsUsed := nxMinI32(CharsUsed, Pred(atwTargetLength div SizeOf(WideChar)));

          nxMove(Buffer, aTarget, CharsUsed * SizeOf(WideChar));
        end else
          nxRaiseLastOSError('TnxAnsiStringToWideStringMapper'+'.'+'FromShortStringConvert'+'/'+'MultiByteToWideChar');
    end else
      CharsUsed := 0;

    PWideChar(@aTarget)[CharsUsed] := #0;
  end;
end;

class function TnxAnsiStringToWideStringMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                                                    aSourceCursor : TnxAbstractCursor;
                                                                    aTargetField  : TnxFieldDescriptor;
                                                                    aTargetCursor : TnxAbstractCursor;
                                                                    aMapperDesc   : TnxFieldMapperDescriptor;
                                                                out aMapper       : TnxMappingMethod)
                                                                                  : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  if aSourceField.fdType in [nxtShortString, nxtNullString] then
    if aTargetField.fdType = nxtWideString then
      Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
end;
{==============================================================================}



{==============================================================================}
constructor TnxWideStringToWideStringMapper.Create(aSourceField : TnxFieldDescriptor;
                                                   aTargetField : TnxFieldDescriptor;
                                                   aMapperDesc  : TnxFieldMapperDescriptor;
                                               out aMapper      : TnxMappingMethod);
var
  RemovePadding      : Boolean;
begin
  inherited Create;

  with aTargetField do begin
    wtwTargetLength := fdLength;
    wtwTargetUnits := fdUnits;
  end;

  RemovePadding := (aSourceField.fdDecPl = 0) and (aTargetField.fdDecPl > 0);

  if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
    if RemovePadding then
      aMapper := ToWideStringTruncPadding
    else
      aMapper := ToWideStringTrunc
  else
    if RemovePadding then
      aMapper := ToWideStringCheckPadding
    else
      aMapper := ToWideStringCheck;
end;
{------------------------------------------------------------------------------}
class function TnxWideStringToWideStringMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                                                    aSourceCursor : TnxAbstractCursor;
                                                                    aTargetField  : TnxFieldDescriptor;
                                                                    aTargetCursor : TnxAbstractCursor;
                                                                    aMapperDesc   : TnxFieldMapperDescriptor;
                                                                out aMapper       : TnxMappingMethod)
                                                                                  : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  if (aSourceField.fdType = nxtWideString) and
     (aTargetField.fdType = nxtWideString) then
    if (aTargetField.fdLength >= aSourceField.fdLength) then
      if (aSourceField.fdDecPl = 0) and (aTargetField.fdDecPl > 0) then
        aMapper := ToWideStringPadding
      else
        aMapper := ToWideString
    else
      Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
end;
{------------------------------------------------------------------------------}
class function TnxWideStringToWideStringMapper.ToWideString(const aSource; var aTarget): TnxResult;
var
  l : Integer;
begin
  l := lstrlenW(PWideChar(@aSource));
  if l > 0 then
    nxMove(aSource, aTarget, l * SizeOf(WideChar));
  PWideChar(@aTarget)[l] := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxWideStringToWideStringMapper.ToWideStringCheck(const aSource; var aTarget): TnxResult;
var
  Units : Integer;
begin
  Units := lstrlenW(PWideChar(@aSource));
  if Units > wtwTargetUnits then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    if Units > 0 then
      nxMove(aSource, aTarget, Units * SizeOf(WideChar));
    PWideChar(@aTarget)[Units] := #0;
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxWideStringToWideStringMapper.ToWideStringCheckPadding(
  const aSource; var aTarget): TnxResult;
var
  Units : Integer;
begin
  Units := lstrlenW(PWideChar(@aSource));
  while (Units > 0) and (PWideChar(@aSource)[Pred(Units)] = ' ') do
    Dec(Units);

  if Units > wtwTargetUnits then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    if Units > 0 then
      nxMove(aSource, aTarget, Units * SizeOf(WideChar));
    PWideChar(@aTarget)[Units] := #0;
    Result := DBIERR_NONE;
  end;
end;

class function TnxWideStringToWideStringMapper.ToWideStringPadding(
  const aSource; var aTarget): TnxResult;
var
  l : Integer;
begin
  l := lstrlenW(PWideChar(@aSource));
  while (l > 0) and (PWideChar(@aSource)[Pred(l)] = ' ') do
    Dec(l);

  if l > 0 then
    nxMove(aSource, aTarget, l * SizeOf(WideChar));
  PWideChar(@aTarget)[l] := #0;
  Result := DBIERR_NONE;
end;

function TnxWideStringToWideStringMapper.ToWideStringTrunc(const aSource; var aTarget): TnxResult;
var
  Units : Integer;
begin
  Units := nxMinI32(lstrlenW(PWideChar(@aSource)), wtwTargetUnits);
  if Units > 0 then
    nxMove(aSource, aTarget, Units * SizeOf(WideChar));
  PWideChar(@aTarget)[Units] := #0;
  Result := DBIERR_NONE;
end;
{==============================================================================}



{==============================================================================}
constructor TnxCharMapper.Create(aSourceField : TnxFieldDescriptor;
                                 aTargetField : TnxFieldDescriptor;
                                 aMapperDesc  : TnxFieldMapperDescriptor;
                             out aMapper      : TnxMappingMethod);
var
  LocaleDescriptor   : TnxLocaleDescriptor;
  RequiresConversion : Boolean;
begin
  inherited Create;

  LocaleDescriptor := aSourceField.UsedLocaleDescriptor;
  if Assigned(LocaleDescriptor) then
    ccSourceCodepage := LocaleDescriptor.StorageCodepage;

  LocaleDescriptor := aTargetField.UsedLocaleDescriptor;
  if Assigned(LocaleDescriptor) then
    ccTargetCodepage := LocaleDescriptor.StorageCodepage;

  ccTargetLength := aTargetField.fdLength;

  RequiresConversion := (ccSourceCodepage <> ccTargetCodepage);

  if ccSourceCodepage = 0 then
    RequiresConversion := False
  else if ccTargetCodepage = 0 then
    RequiresConversion := False;

  case aTargetField.fdType of
    nxtWideChar    : if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
                       aMapper    := ToWideCharConvert
                     else
                       aMapper    := ToWideCharConvertCheck;
    nxtWideString  : if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
                       aMapper    := ToWideStringConvert
                     else
                       aMapper    := ToWideStringConvertCheck;
  end;

  if RequiresConversion then begin
    case aTargetField.fdType of
      nxtChar        : aMapper    := ToAnsiCharConvert;
      nxtShortString : if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
                         aMapper    := ToShortStringConvert
                       else
                         aMapper    := ToShortStringConvertCheck;
      nxtNullString  : if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
                         aMapper    := ToNullStringConvert;
                       else
                         aMapper    := ToNullStringConvertCheck;
    end;
  end
  else begin
    case aTargetField.fdType of
      nxtChar        : aMapper    := ToAnsiChar;
      nxtShortString : aMapper    := ToShortString;
      nxtNullString  : aMapper    := ToNullString;
    end;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                                  aSourceCursor : TnxAbstractCursor;
                                                  aTargetField  : TnxFieldDescriptor;
                                                  aTargetCursor : TnxAbstractCursor;
                                                  aMapperDesc   : TnxFieldMapperDescriptor;
                                              out aMapper       : TnxMappingMethod)
                                                                : TnxBaseFieldMapper;
begin
  aMapper    := nil;
  Result := nil;
  if (aSourceField.fdType = nxtChar) and
     not (aTargetField.fdType in [nxtBlob, nxtBlobMemo, nxtBlobWideMemo, nxtBlobGraphic, nxtGuid]) then

    if (aTargetField.fdType in [nxtChar, nxtWideChar, nxtWideString, nxtShortString, nxtNullString]) and
       (aTargetField.fdLength > 0) then
      Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper   )
    else
    if Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then begin
      case aTargetField.fdType of
        nxtBoolean     : aMapper := ToBoolean;
        nxtInt8        : aMapper := ToInt8;
        nxtInt16       : aMapper := ToInt16;
        nxtInt32       : aMapper := ToInt32;
        nxtInt64       : aMapper := ToInt64;
        nxtByte        : aMapper := ToByte8;
        nxtWord16      : aMapper := ToWord16;
        nxtWord32,
        nxtAutoInc,
        nxtRecRev      : aMapper := ToWord32;
        nxtSingle      : aMapper := ToSingle;
        nxtDouble      : aMapper := ToDouble;
        nxtExtended    : aMapper := ToExtended;

        nxtCurrency,
        nxtBCD         : aMapper := ToCurrency;

        nxtByteArray   : aMapper := ToByteArray;
      end;
    end
    else begin
      case aTargetField.fdType of
        nxtBoolean     : aMapper := ToBooleanCheck;
        nxtInt8        : aMapper := ToInt8Check;
        nxtInt16       : aMapper := ToInt16Check;
        nxtInt32       : aMapper := ToInt32Check;
        nxtInt64       : aMapper := ToInt64Check;
        nxtByte        : aMapper := ToByteCheck;
        nxtWord16      : aMapper := ToWord16Check;
        nxtWord32,
        nxtAutoInc,
        nxtRecRev      : aMapper := ToWord32Check;
        nxtSingle      : aMapper := ToSingleCheck;
        nxtDouble      : aMapper := ToDoubleCheck;
        nxtExtended    : aMapper := ToExtendedCheck;

        nxtCurrency,
        nxtBCD         : aMapper := ToCurrencyCheck;

        nxtByteArray   : aMapper := ToByteArray;
      end;
    end;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToBoolean(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;
  case TnxAnsiChar(aSource) of
    '0', 'F', 'N': TnxBoolean(aTarget) := False;
  else
    TnxBoolean(aTarget) := True;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToBooleanCheck(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;
  case TnxAnsiChar(aSource) of
    '0', 'F', 'N': TnxBoolean(aTarget) := False;
    '1', 'T', 'Y': TnxBoolean(aTarget) := True;
  else
    Result := DBIERR_INVALIDFLDXFORM;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToByte8(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  TnxByte8(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToByteCheck(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  if (Code<>0) or not (v in [0..9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxByte8(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToByteArray(const aSource; var aTarget): TnxResult;
begin
  TnxAnsiChar(aTarget) := TnxAnsiChar(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToAnsiChar(const aSource; var aTarget): TnxResult;
begin
  TnxAnsiChar(aTarget) := TnxAnsiChar(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxCharMapper.ToAnsiCharConvert(const aSource; var aTarget): TnxResult;
var
  Buffer : WideChar;
  n      : Integer;
begin
  Result := DBIERR_NONE;

  if PAnsiChar(@aSource)[0] = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin
    MultiByteToWideChar(ccSourceCodepage, 0,
      @aSource, 1,
      @Buffer, 1);

    n := WideCharToMultiByte(ccTargetCodepage, 0,
         @Buffer, 1,
         @aTarget, 1, nil, nil);
    if n <> 1 then
      Result := DBIERR_INVALIDFLDXFORM;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToCurrency(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  TnxCurrency(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToCurrencyCheck(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  if (Code<>0) or not (v in [0..9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxCurrency(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToDouble(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  TnxDouble(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToDoubleCheck(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  if (Code<>0) or not (v in [0..9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxDouble(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToExtended(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  {$IFNDEF FPC}
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  TnxExtended(aTarget) := v;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToExtendedCheck(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  {$IFNDEF FPC}
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  if (Code<>0) or not (v in [0..9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxExtended(aTarget) := v;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToInt16(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  TnxInt16(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToInt16Check(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  if (Code<>0) or not (v in [0..9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt16(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToInt32(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  TnxInt32(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToInt32Check(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  if (Code<>0) or not (v in [0..9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt32(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToInt64(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  TnxInt64(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToInt64Check(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  if (Code<>0) or not (v in [0..9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt64(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToInt8(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  TnxInt8(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToInt8Check(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  if (Code<>0) or not (v in [0..9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt8(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToNullString(const aSource; var aTarget): TnxResult;
begin
  nxMove(TnxAnsiChar(aSource), aTarget, 1);
  PAnsiChar(@aTarget)[1] := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxCharMapper.ToNullStringConvert(const aSource; var aTarget): TnxResult;
var
  Buffer     : array[Byte] of WideChar;
  n          : Integer;
begin
  Result := DBIERR_NONE;

  if TnxAnsiChar(aSource) = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin

    MultiByteToWideChar(ccSourceCodepage, 0,
      @TnxAnsiChar(aSource), 1,
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    n := WideCharToMultiByte(ccTargetCodepage, 0,
           @Buffer, 1,
           @aTarget, Pred(ccTargetLength),
           nil, nil);

    PAnsiChar(@aTarget)[n] := #0;
  end;
end;
{------------------------------------------------------------------------------}
function TnxCharMapper.ToNullStringConvertCheck(const aSource; var aTarget): TnxResult;
var
  Buffer    : array[Byte] of WideChar;
  n         : Integer;
begin
  Result := DBIERR_NONE;

  if TnxAnsiChar(aSource) = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin

    MultiByteToWideChar(ccSourceCodepage, 0,
      @TnxAnsiChar(aSource), 1,
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    n := WideCharToMultiByte(ccTargetCodepage, 0,
           @Buffer, 1,
           @aTarget, Pred(ccTargetLength),
           nil, nil);

    if n = 0 then
      nxRaiseLastOSError('TnxCharMapper'+'.'+'ToNullStringConvertCheck'+'/'+'WideCharToMultiByte');

    PAnsiChar(@aTarget)[n] := #0;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToShortString(const aSource; var aTarget): TnxResult;
begin
  TnxShStr(aTarget)[1] := TnxAnsiChar(aSource);
  TnxShStr(aTarget)[0] := #1;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxCharMapper.ToShortStringConvert(const aSource; var aTarget): TnxResult;
var
  Buffer    : array[Byte] of WideChar;
  n         : Integer;
begin
  Result := DBIERR_NONE;

  if TnxAnsiChar(aSource) = #0 then begin
    TnxShStr(aTarget)[0] := #0;
  end else begin

    MultiByteToWideChar(ccSourceCodepage, 0,
      @TnxAnsiChar(aSource), 1,
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    n := WideCharToMultiByte(ccTargetCodepage, 0,
      @Buffer, 1,
      @TnxShStr(aTarget)[1], Pred(ccTargetLength),
      nil, nil);

    TnxShStr(aTarget)[0] := AnsiChar(n);
  end;
end;
{------------------------------------------------------------------------------}
function TnxCharMapper.ToShortStringConvertCheck(const aSource; var aTarget): TnxResult;
var
  Buffer    : array[Byte] of WideChar;
  n         : Integer;
begin
  Result := DBIERR_NONE;

  if TnxAnsiChar(aSource) = #0 then begin
    TnxShStr(aTarget)[0] := #0;
  end else begin

    MultiByteToWideChar(ccSourceCodepage, 0,
      @TnxAnsiChar(aSource), 1,
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    n := WideCharToMultiByte(ccTargetCodepage, 0,
      @Buffer, 1,
      @TnxShStr(aTarget)[1], Pred(ccTargetLength),
      nil, nil);

    if n = 0 then
      nxRaiseLastOSError('TnxCharMapper'+'.'+'ToNullStringConvertCheck'+'/'+'WideCharToMultiByte');

    TnxShStr(aTarget)[0] := AnsiChar(n);
  end;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToSingle(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  TnxSingle(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToSingleCheck(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  if (Code<>0) or not (v in [0..9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxSingle(aTarget) := v;
end;
{------------------------------------------------------------------------------}
function TnxCharMapper.ToWideCharConvert(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;

  if PAnsiChar(@aSource)[0] = #0 then begin
    PWideChar(@aTarget)[0] := #0;
  end else
    MultiByteToWideChar(ccSourceCodepage, 0,
      @aSource, 1,
      @aTarget, 1);
end;
{------------------------------------------------------------------------------}
function TnxCharMapper.ToWideCharConvertCheck(const aSource; var aTarget): TnxResult;
var
  n : Integer;
begin
  Result := DBIERR_NONE;

  if PAnsiChar(@aSource)[0] = #0 then begin
    PWideChar(@aTarget)[0] := #0;
  end else begin
    n := MultiByteToWideChar(ccSourceCodepage, 0,
      @aSource, 1,
      @aTarget, 1);

    if n = 0 then
      nxRaiseLastOSError('TnxWideCharMapper'+'.'+'ToWideCharConvertCheck'+'/'+'MultiByteToWideChar');
  end;
end;
{------------------------------------------------------------------------------}
function TnxCharMapper.ToWideStringConvert(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;

  if PAnsiChar(@aSource)[0] = #0 then begin
    PWideChar(@aTarget)[0] := #0;
  end else begin
    MultiByteToWideChar(ccSourceCodepage, 0,
      @aSource, 1,
      @aTarget, 1);

    PWideChar(@aTarget)[1] := #0;
  end;
end;
{------------------------------------------------------------------------------}
function TnxCharMapper.ToWideStringConvertCheck(const aSource; var aTarget): TnxResult;
var
  n : Integer;
begin
  Result := DBIERR_NONE;

  if PAnsiChar(@aSource)[0] = #0 then begin
    PWideChar(@aTarget)[0] := #0;
  end else begin
    n := MultiByteToWideChar(ccSourceCodepage, 0,
      @aSource, 1,
      @aTarget, 1);

    if n = 0 then
      nxRaiseLastOSError('TnxWideCharMapper'+'.'+'ToWideStringConvertCheck'+'/'+'MultiByteToWideChar');

    PWideChar(@aTarget)[1] := #0;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToWord16(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  TnxWord16(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToWord16Check(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  if (Code<>0) or not (v in [0..9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxWord16(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToWord32(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  TnxWord32(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxCharMapper.ToWord32Check(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : AnsiString;
begin
  Result := DBIERR_NONE;

  s := TnxAnsiChar(aSource);
  Val(string(s), v, Code);
  if (Code<>0) or not (v in [0..9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxWord32(aTarget) := v;
end;
{==============================================================================}



{==============================================================================}
constructor TnxWideCharMapper.Create(aSourceField : TnxFieldDescriptor;
                                     aTargetField : TnxFieldDescriptor;
                                     aMapperDesc : TnxFieldMapperDescriptor;
                                 out aMapper      : TnxMappingMethod);
var
  LocaleDescriptor   : TnxLocaleDescriptor;
begin
  inherited Create;

  LocaleDescriptor := aSourceField.UsedLocaleDescriptor;
  if Assigned(LocaleDescriptor) then
    wccSourceCodepage := LocaleDescriptor.StorageCodepage;

  LocaleDescriptor := aTargetField.UsedLocaleDescriptor;
  if Assigned(LocaleDescriptor) then
    wccTargetCodepage := LocaleDescriptor.StorageCodepage;

  wccTargetLength := aTargetField.fdLength;

  case aTargetField.fdType of
    nxtChar        : aMapper    := ToAnsiCharConvert;
    nxtWideChar    : aMapper    := ToWideChar;
    nxtWideString  : aMapper    := ToWideString;
  end;

  if Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
    case aTargetField.fdType of
      nxtShortString : aMapper    := ToShortStringConvert;
      nxtNullString  : aMapper    := ToNullStringConvert;
    end
  else
    case aTargetField.fdType of
      nxtShortString : aMapper    := ToShortStringConvertCheck;
      nxtNullString  : aMapper    := ToNullStringConvertCheck;
    end;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                                      aSourceCursor : TnxAbstractCursor;
                                                      aTargetField  : TnxFieldDescriptor;
                                                      aTargetCursor : TnxAbstractCursor;
                                                      aMapperDesc   : TnxFieldMapperDescriptor;
                                                  out aMapper       : TnxMappingMethod)
                                                                       : TnxBaseFieldMapper;
begin
  aMapper    := nil;
  Result := nil;
  if (aSourceField.fdType = nxtWideChar) and
     not (aTargetField.fdType in [nxtBlob, nxtBlobMemo, nxtBlobWideMemo, nxtBlobGraphic, nxtGuid]) then

    if aTargetField.fdType in [nxtChar, nxtWideChar, nxtWideString, nxtShortString, nxtNullString] then
      Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper   )
    else
    if Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then begin
      case aTargetField.fdType of
        nxtBoolean     : aMapper := ToBoolean;
        nxtInt8        : aMapper := ToInt8;
        nxtInt16       : aMapper := ToInt16;
        nxtInt32       : aMapper := ToInt32;
        nxtInt64       : aMapper := ToInt64;
        nxtByte        : aMapper := ToByte8;
        nxtWord16      : aMapper := ToWord16;
        nxtWord32,
        nxtAutoInc,
        nxtRecRev      : aMapper := ToWord32;
        nxtSingle      : aMapper := ToSingle;
        nxtDouble      : aMapper := ToDouble;
        nxtExtended    : aMapper := ToExtended;

        nxtCurrency,
        nxtBCD         : aMapper := ToCurrency;

        nxtByteArray   : aMapper := ToByteArray;
      end;
    end
    else begin
      case aTargetField.fdType of
        nxtBoolean     : aMapper := ToBooleanCheck;
        nxtInt8        : aMapper := ToInt8Check;
        nxtInt16       : aMapper := ToInt16Check;
        nxtInt32       : aMapper := ToInt32Check;
        nxtInt64       : aMapper := ToInt64Check;
        nxtByte        : aMapper := ToByteCheck;
        nxtWord16      : aMapper := ToWord16Check;
        nxtWord32,
        nxtAutoInc,
        nxtRecRev      : aMapper := ToWord32Check;
        nxtSingle      : aMapper := ToSingleCheck;
        nxtDouble      : aMapper := ToDoubleCheck;
        nxtExtended    : aMapper := ToExtendedCheck;

        nxtCurrency,
        nxtBCD         : aMapper := ToCurrencyCheck;

        nxtByteArray   : aMapper := ToByteArray;
      end;
    end;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToBoolean(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  TnxBoolean(aTarget) := v<>0;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToBooleanCheck(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  if (Code <> 0) or not (v in [0, 1]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxBoolean(aTarget) := v<>0;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToByte8(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  TnxByte8(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToByteCheck(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  if (Code <> 0) or not (v in [0, 9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxByte8(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToByteArray(const aSource; var aTarget): TnxResult;
begin
  nxMove(aSource, aTarget, SizeOf(WideChar));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxWideCharMapper.ToAnsiCharConvert(const aSource; var aTarget): TnxResult;
var
  Buffer  : Array[Byte] of AnsiChar;
begin
  Result := DBIERR_NONE;

  if PWideChar(@aSource)[0] = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin
    WideCharToMultiByte(wccTargetCodepage, 0,
      @aSource, 1,
      @Buffer, 1,
      nil, nil);

    PAnsiChar(@aTarget)[0] := Buffer[0];
  end;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToCurrency(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  TnxCurrency(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToCurrencyCheck(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  if (Code <> 0) or not (v in [0, 9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxCurrency(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToDouble(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  TnxDouble(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToDoubleCheck(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  if (Code <> 0) or not (v in [0, 9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxDouble(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToExtended(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  {$IFNDEF FPC}
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  TnxExtended(aTarget) := v;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToExtendedCheck(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  {$IFNDEF FPC}
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  if (Code <> 0) or not (v in [0, 9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxExtended(aTarget) := v;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToInt16(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  TnxInt16(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToInt16Check(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  if (Code <> 0) or not (v in [0, 9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt16(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToInt32(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  TnxInt32(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToInt32Check(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  if (Code <> 0) or not (v in [0, 9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt32(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToInt64(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  TnxInt64(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToInt64Check(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  if (Code <> 0) or not (v in [0, 9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt64(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToInt8(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  TnxInt8(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToInt8Check(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  if (Code <> 0) or not (v in [0, 9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt8(aTarget) := v;
end;
{------------------------------------------------------------------------------}
function TnxWideCharMapper.ToNullStringConvert(const aSource; var aTarget): TnxResult;
var
  i         : Integer;
begin
  Result := DBIERR_NONE;

  if PWideChar(@aSource)[0] = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin

    i := WideCharToMultiByte(wccTargetCodepage, 0,
           @aSource, 1,
           @aTarget, Pred(wccTargetLength),
           nil, nil);

    PAnsiChar(@aTarget)[i] := #0;
  end;
end;
{------------------------------------------------------------------------------}
function TnxWideCharMapper.ToNullStringConvertCheck(const aSource; var aTarget): TnxResult;
var
  i         : Integer;
begin
  Result := DBIERR_NONE;

  if PWideChar(@aSource)[0] = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin

    i := WideCharToMultiByte(wccTargetCodepage, 0,
           @aSource, 1,
           @aTarget, Pred(wccTargetLength),
           nil, nil);

    if i = 0 then begin
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then
        Result := DBIERR_INVALIDFLDXFORM
      else
        nxRaiseLastOSError('TnxWideCharMapper'+'.'+'ToNullStringConvertCheck'+'/'+'WideCharToMultiByte');
    end
    else
      PAnsiChar(@aTarget)[i] := #0;
  end;
end;
{------------------------------------------------------------------------------}
function TnxWideCharMapper.ToShortStringConvert(const aSource; var aTarget): TnxResult;
var
  i         : Integer;
begin
  Result := DBIERR_NONE;

  if PWideChar(@aSource)[0] = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin

    i := WideCharToMultiByte(wccTargetCodepage, 0,
           @aSource, 1,
           @TnxShStr(aTarget)[1], Pred(wccTargetLength),
           nil, nil);

    PAnsiChar(@aTarget)[0] := AnsiChar(i);
  end;
end;
{------------------------------------------------------------------------------}
function TnxWideCharMapper.ToShortStringConvertCheck(const aSource; var aTarget): TnxResult;
var
  i         : Integer;
begin
  Result := DBIERR_NONE;

  if PWideChar(@aSource)[0] = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin

    i := WideCharToMultiByte(wccTargetCodepage, 0,
           @aSource, 1,
           @TnxShStr(aTarget)[1], Pred(wccTargetLength),
           nil, nil);

    if i = 0 then begin
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then
        Result := DBIERR_INVALIDFLDXFORM
      else
        nxRaiseLastOSError('TnxWideCharMapper'+'.'+'ToShortStringConvertCheck'+'/'+'WideCharToMultiByte');
    end
    else
      PAnsiChar(@aTarget)[0] := AnsiChar(i);
  end;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToSingle(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  TnxSingle(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToSingleCheck(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  if (Code <> 0) or not (v in [0, 9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxSingle(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToWideChar(const aSource; var aTarget): TnxResult;
begin
  TnxWideChar(aTarget) := TnxWideChar(aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToWideString(const aSource; var aTarget): TnxResult;
begin
  TnxWideChar(aTarget) := TnxWideChar(aSource);
  PAnsiChar(@aTarget)[2] := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToWord16(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  TnxWord16(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToWord16Check(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  if (Code <> 0) or not (v in [0, 9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxWord16(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToWord32(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  TnxWord32(aTarget) := v;
end;
{------------------------------------------------------------------------------}
class function TnxWideCharMapper.ToWord32Check(const aSource; var aTarget): TnxResult;
var
  v,
  Code  : Integer;
  s     : string;
begin
  Result := DBIERR_NONE;

  s := WideCharLenToString(@aSource, 1);
  Val(s, v, Code);
  if (Code <> 0) or not (v in [0, 9]) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxWord32(aTarget) := v;
end;
{==============================================================================}



{==============================================================================}
constructor TnxShortStringMapper.Create(aSourceField : TnxFieldDescriptor;
                                        aTargetField : TnxFieldDescriptor;
                                        aMapperDesc  : TnxFieldMapperDescriptor;
                                    out aMapper      : TnxMappingMethod);
var
  CPInfo             : TCPInfo;
  SourceIsMultiByte  : Boolean;
  RequiresConversion : Boolean;
begin
  inherited Create;

  if Assigned(aSourceField.UsedLocaleDescriptor) then begin
    GetLocaleFormatSettings(aSourceField.UsedLocaleDescriptor.Locale, ssmFormatSettings);
    ssmSourceCodepage := aSourceField.UsedLocaleDescriptor.StorageCodepage;
  end else
    GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, ssmFormatSettings);

  if Assigned(aTargetField.UsedLocaleDescriptor) then
    ssmTargetCodepage := aTargetField.UsedLocaleDescriptor.StorageCodepage;

  ssmSourceLength := aSourceField.fdLength;
  ssmTargetLength := aTargetField.fdLength;

  ssmTargetUnits := aTargetField.fdUnits;
  ssmTargetDecPl := aTargetField.fdDecPl;

  if ssmSourceCodepage <> 0 then begin
    Win32Check(GetCPInfo(ssmSourceCodepage, CPInfo));
    SourceIsMultiByte := CPInfo.MaxCharSize > 1;
  end else
    SourceIsMultiByte := False;

  RequiresConversion := ((aTargetField.fdType in [nxtChar, nxtWideChar]) and
                         (ssmSourceCodepage <> ssmTargetCodepage)) or
                        (SourceIsMultiByte and
                        (ssmTargetLength < ssmSourceLength));

  if ssmSourceCodepage = 0 then
    RequiresConversion := False
  else if ssmTargetCodepage = 0 then
    RequiresConversion := False;

  if RequiresConversion then begin
    if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then begin
      case aTargetField.fdType of
        nxtBoolean: aMapper := ToBooleanConvert;
        nxtInt8: aMapper := ToInt8Convert;
        nxtInt16: aMapper := ToInt16Convert;
        nxtInt32: aMapper := ToInt32Convert;
        nxtInt64: aMapper := ToInt64Convert;
        nxtByte: aMapper := ToByteConvert;
        nxtWord16: aMapper := ToWord16Convert;
        nxtAutoinc,
        nxtRecRev,
        nxtWord32: aMapper := ToWord32Convert;
        nxtSingle: aMapper := ToSingleConvert;
        nxtDouble: aMapper := ToDoubleConvert;
        nxtExtended: aMapper := ToExtendedConvert;
        nxtBcd: aMapper := ToBcdConvert;
        nxtCurrency: aMapper := ToCurrencyConvert;
        nxtDate: aMapper := ToDateConvert;
        nxtTime: aMapper := ToTimeConvert;
        nxtDateTime: aMapper := ToDateTimeConvert;
        nxtByteArray: aMapper := ToByteArray;
        nxtGuid: aMapper := ToGuidConvert;
        nxtChar: aMapper := ToAnsiCharConvert;
        nxtWideChar: aMapper := ToWideCharConvert;
      end;
    end
    else begin
      case aTargetField.fdType of
        nxtBoolean: aMapper := ToBooleanConvertCheck;
        nxtInt8: aMapper := ToInt8ConvertCheck;
        nxtInt16: aMapper := ToInt16ConvertCheck;
        nxtInt32: aMapper := ToInt32ConvertCheck;
        nxtInt64: aMapper := ToInt64ConvertCheck;
        nxtByte: aMapper := ToByteConvertCheck;
        nxtWord16: aMapper := ToWord16ConvertCheck;
        nxtAutoinc,
        nxtRecRev,
        nxtWord32: aMapper := ToWord32ConvertCheck;
        nxtSingle: aMapper := ToSingleConvertCheck;
        nxtDouble: aMapper := ToDoubleConvertCheck;
        nxtExtended: aMapper := ToExtendedConvertCheck;
        nxtBcd: aMapper := ToBcdConvertCheck;
        nxtCurrency: aMapper := ToCurrencyConvertCheck;
        nxtDate: aMapper := ToDateConvertCheck;
        nxtTime: aMapper := ToTimeConvertCheck;
        nxtDateTime: aMapper := ToDateTimeConvertCheck;
        nxtByteArray: aMapper := ToByteArrayCheck;
        nxtGuid: aMapper := ToGuidConvertCheck;
        nxtChar: aMapper := ToAnsiCharConvert;
        nxtWideChar: aMapper := ToWideCharConvert;
      end;
    end;
  end
  else begin
    if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then begin
      case aTargetField.fdType of
        nxtBoolean: aMapper := ToBoolean;
        nxtInt8: aMapper := ToInt8;
        nxtInt16: aMapper := ToInt16;
        nxtInt32: aMapper := ToInt32;
        nxtInt64: aMapper := ToInt64;
        nxtByte: aMapper := ToByte8;
        nxtWord16: aMapper := ToWord16;
        nxtAutoinc,
        nxtRecRev,
        nxtWord32: aMapper := ToWord32;
        nxtSingle: aMapper := ToSingle;
        nxtDouble: aMapper := ToDouble;
        nxtExtended: aMapper := ToExtended;
        nxtBcd: aMapper := ToBcd;
        nxtCurrency: aMapper := ToCurrency;
        nxtDate: aMapper := ToDate;
        nxtTime: aMapper := ToTime;
        nxtDateTime: aMapper := ToDateTime;
        nxtByteArray: aMapper := ToByteArray;
        nxtGuid: aMapper := ToGuid;
        nxtChar: aMapper := ToAnsiChar;
        nxtWideChar: aMapper := ToWideCharConvert;
      end;
    end
    else begin
      case aTargetField.fdType of
        nxtBoolean: aMapper := ToBooleanCheck;
        nxtInt8: aMapper := ToInt8Check;
        nxtInt16: aMapper := ToInt16Check;
        nxtInt32: aMapper := ToInt32Check;
        nxtInt64: aMapper := ToInt64Check;
        nxtByte: aMapper := ToByteCheck;
        nxtWord16: aMapper := ToWord16Check;
        nxtAutoinc,
        nxtRecRev,
        nxtWord32: aMapper := ToWord32Check;
        nxtSingle: aMapper := ToSingleCheck;
        nxtDouble: aMapper := ToDoubleCheck;
        nxtExtended: aMapper := ToExtendedCheck;
        nxtBcd: aMapper := ToBcdCheck;
        nxtCurrency: aMapper := ToCurrencyCheck;
        nxtDate: aMapper := ToDateCheck;
        nxtTime: aMapper := ToTimeCheck;
        nxtDateTime: aMapper := ToDateTimeCheck;
        nxtByteArray: aMapper := ToByteArrayCheck;
        nxtGuid: aMapper := ToGuidCheck;
        nxtChar: aMapper := ToAnsiChar;
        nxtWideChar: aMapper := ToWideCharConvert;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                                         aSourceCursor : TnxAbstractCursor;
                                                         aTargetField  : TnxFieldDescriptor;
                                                         aTargetCursor : TnxAbstractCursor;
                                                         aMapperDesc   : TnxFieldMapperDescriptor;
                                                     out aMapper       : TnxMappingMethod)
                                                                       : TnxBaseFieldMapper;
begin
  Result := nil;
  aMapper := nil;
  if aTargetField.fdType in
    [nxtBoolean, nxtInt8, nxtInt16, nxtInt32, nxtInt64,
     nxtByte, nxtWord16, nxtAutoinc, nxtRecRev, nxtWord32,
     nxtSingle, nxtDouble, nxtExtended, nxtBCD, nxtCurrency,
     nxtDate, nxtTime, nxtDateTime, nxtByteArray, nxtGuid,
     nxtChar, nxtWideChar] then
    Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToBcd(const aSource; var aTarget): TnxResult;
var
  Bcd1, Bcd2 : TnxFmtBcd;
begin
  Result := DBIERR_NONE;

  if nxTryStrToFmtBcd(TnxShStr(aSource), Bcd1) then begin
    nxNormalizeBcd(Bcd1, Bcd2, ssmTargetUnits, ssmTargetDecPl);
    nxFmtBcdToCurrency(Bcd2, TnxCurrency(aTarget));
  end else
    TnxCurrency(aTarget) := 0;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToBcdCheck(const aSource; var aTarget): TnxResult;
var
  Bcd1, Bcd2 : TnxFmtBcd;
begin
  Result := DBIERR_INVALIDFLDXFORM;

  if nxTryStrToFmtBcd(TnxShStr(aSource), Bcd1) and (nxNormalizeBcd(Bcd1, Bcd2, ssmTargetUnits, ssmTargetDecPl) = []) then begin
    nxFmtBcdToCurrency(Bcd2, TnxCurrency(aTarget));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToBcdConvert(const aSource; var aTarget): TnxResult;
var
  ws         : Array[byte] of Widechar;
  s          : Array[byte] of AnsiChar;
  CharsUsed  : Integer;
  Bcd1, Bcd2 : TnxFmtBcd;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToBcdConvert'+'/'+'MultiByteToWideChar');

  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToBcdConvert'+'/'+'WidecharToMultiByte');

  if nxTryStrToFmtBcd(s, Bcd1) then begin
    nxNormalizeBcd(Bcd1, Bcd2, ssmTargetUnits, ssmTargetDecPl);
    nxFmtBcdToCurrency(Bcd2, TnxCurrency(aTarget));
  end else
    TnxCurrency(aTarget) := 0;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToBcdConvertCheck(const aSource; var aTarget): TnxResult;
var
  ws         : Array[byte] of Widechar;
  s          : Array[byte] of AnsiChar;
  CharsUsed  : Integer;
  Bcd1, Bcd2 : TnxFmtBcd;
begin
  Result := DBIERR_INVALIDFLDXFORM;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToBcdConvertCheck'+'/'+'MultiByteToWideChar');

  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToBcdConvertCheck'+'/'+'WidecharToMultiByte');

  if nxTryStrToFmtBcd(s, Bcd1) and (nxNormalizeBcd(Bcd1, Bcd2, ssmTargetUnits, ssmTargetDecPl) = []) then begin
    nxFmtBcdToCurrency(Bcd2, TnxCurrency(aTarget));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToBoolean(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;
  if (TnxShStr(aSource) = '1') or
     (nxCmpShStrUC(TnxShStr(aSource), 'Y') = 0) or
     (nxCmpShStrUC(TnxShStr(aSource), 'Yes') = 0) or
     (nxCmpShStrUC(TnxShStr(aSource), 'T') = 0) or
     (nxCmpShStrUC(TnxShStr(aSource), 'True') = 0) then
    TnxBoolean(aTarget) := True
  else
    TnxBoolean(aTarget) := False;
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToBooleanCheck(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;
  if (TnxShStr(aSource) = '0') or
     (nxCmpShStrUC(TnxShStr(aSource), 'N') = 0) or
     (nxCmpShStrUC(TnxShStr(aSource), 'No') = 0) or
     (nxCmpShStrUC(TnxShStr(aSource), 'F') = 0) or
     (nxCmpShStrUC(TnxShStr(aSource), 'False') = 0) then
    TnxBoolean(aTarget) := False
  else
  if (TnxShStr(aSource) = '1') or
     (nxCmpShStrUC(TnxShStr(aSource), 'Y') = 0) or
     (nxCmpShStrUC(TnxShStr(aSource), 'Yes') = 0) or
     (nxCmpShStrUC(TnxShStr(aSource), 'T') = 0) or
     (nxCmpShStrUC(TnxShStr(aSource), 'True') = 0) then
    TnxBoolean(aTarget) := True
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToBooleanConvert(const aSource; var aTarget): TnxResult;
var
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToBooleanConvert'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  if (StrComp(ws, '1') = 0) or
     (StrIComp(ws, 'Y') = 0) or
     (StrIComp(ws, 'Yes') = 0) or
     (StrIComp(ws, 'T') = 0) or
     (StrIComp(ws, 'True') = 0) then
    TnxBoolean(aTarget) := True
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToBooleanConvert'+'/'+'WidecharToMultiByte');

  if (StrComp(s, '1') = 0) or
     (StrIComp(s, 'Y') = 0) or
     (StrIComp(s, 'Yes') = 0) or
     (StrIComp(s, 'T') = 0) or
     (StrIComp(s, 'True') = 0) then
    TnxBoolean(aTarget) := True
  {$ENDIF}
  else
    TnxBoolean(aTarget) := False;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToBooleanConvertCheck(const aSource; var aTarget): TnxResult;
var
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToBooleanConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  if (StrComp(ws, '0') = 0) or
     (StrIComp(ws, 'N') = 0) or
     (StrIComp(ws, 'No') = 0) or
     (StrIComp(ws, 'F') = 0) or
     (StrIComp(ws, 'False') = 0) then
    TnxBoolean(aTarget) := False
  else if (StrComp(ws, '1') = 0) or
     (StrIComp(ws, 'Y') = 0) or
     (StrIComp(ws, 'Yes') = 0) or
     (StrIComp(ws, 'T') = 0) or
     (StrIComp(ws, 'True') = 0) then
    TnxBoolean(aTarget) := True
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToBooleanConvertCheck'+'/'+'WidecharToMultiByte');

  if (StrComp(s, '0') = 0) or
     (StrIComp(s, 'N') = 0) or
     (StrIComp(s, 'No') = 0) or
     (StrIComp(s, 'F') = 0) or
     (StrIComp(s, 'False') = 0) then
    TnxBoolean(aTarget) := False
  else if (StrComp(s, '1') = 0) or
     (StrIComp(s, 'Y') = 0) or
     (StrIComp(s, 'Yes') = 0) or
     (StrIComp(s, 'T') = 0) or
     (StrIComp(s, 'True') = 0) then
    TnxBoolean(aTarget) := True
  {$ENDIF}
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToByte8(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;
  Byte(aTarget) := nxAnsiStrToIntDef(TnxShStr(aSource), 0);
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToByteCheck(const aSource; var aTarget): TnxResult;
var
  i64 : Int64;
begin
  Result := DBIERR_NONE;
  i64 := nxAnsiStrToIntDef(TnxShStr(aSource), 0);
  if (i64 >= Low(Byte)) and (i64 <= High(Byte)) then
    Byte(aTarget) := i64;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToByteConvert(const aSource; var aTarget): TnxResult;
var
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToByteConvert'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Byte(aTarget) := StrToIntDef(ws, 0);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToByteConvert'+'/'+'WidecharToMultiByte');

  Byte(aTarget) := nxAnsiStrToIntDef(s, 0);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToByteConvertCheck(const aSource; var aTarget): TnxResult;
var
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
  i64       : Int64;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToByteConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  i64 := StrToIntDef(ws, 0);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToByteConvertCheck'+'/'+'WidecharToMultiByte');

  i64 := nxAnsiStrToIntDef(s, 0);
  {$ENDIF}
  if (i64 >= Low(Byte)) and (i64 <= High(Byte)) then
    Byte(aTarget) := i64;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToByteArray(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;
  nxMove(TnxShStr(aSource)[1], aTarget, nxMinI32(ssmTargetLength, Length(TnxShStr(aSource))));
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToByteArrayCheck(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;
  if Length(TnxShStr(aSource)) <= ssmTargetLength then
    nxMove(TnxShStr(aSource)[1], aTarget, Length(TnxShStr(aSource)))
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToAnsiChar(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;
  nxMove(TnxShStr(aSource)[1], aTarget, 1);
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToAnsiCharConvert(const aSource; var aTarget): TnxResult;
var
  ws        : Array[byte] of Widechar;
  s         : Array[byte] of AnsiChar;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToAnsiCharConvert'+'/'+'MultiByteToWideChar');

  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToAnsiCharConvert'+'/'+'WidecharToMultiByte');

  AnsiChar(aTarget) := s[0];
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToCurrency(const aSource; var aTarget): TnxResult;
var
  Code  : Integer;
  D     : Double;
begin
  Result := DBIERR_NONE;
  Val(string(TnxShStr(aSource)), D, Code);
  if Code <> 0 then
    D := 0;
  TnxCurrency(aTarget) := D;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToCurrencyCheck(const aSource; var aTarget): TnxResult;
var
  Code  : Integer;
  D     : Double;
begin
  Result := DBIERR_NONE;
  Val(string(TnxShStr(aSource)), D, Code);
  if (Code <> 0) or (D < MinCurrency) or (D > MaxCurrency) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxCurrency(aTarget) := D;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToCurrencyConvert(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  D         : Double;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToCurrencyConvert'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToCurrencyConvert'+'/'+'WidecharToMultiByte');

  Val(s, D, Code);
  {$ELSE}
  Val(ws, D, Code);
  {$ENDIF}
  if Code <> 0 then
    D := 0;
  TnxCurrency(aTarget) := D;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToCurrencyConvertCheck(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  D         : Double;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToCurrencyConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToCurrencyConvertCheck'+'/'+'WidecharToMultiByte');

  Val(s, D, Code);
  {$ELSE}
  Val(ws, D, Code);
  {$ENDIF}
  if (Code <> 0) or (D < MinCurrency) or (D > MaxCurrency) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxCurrency(aTarget) := D;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToDate(const aSource; var aTarget): TnxResult;
const
  FirstDate : TTimeStamp = (Time : 0; Date : 1);
begin
  Result := DBIERR_NONE;
  TnxDate(aTarget) := DateTimeToTimeStamp(StrToDateDef(string(TnxShStr(aSource)), TimestampToDateTime(FirstDate), ssmFormatSettings{$IFDEF FPC}.DateSeparator{$ENDIF})).Date;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToDateCheck(const aSource; var aTarget): TnxResult;
const
  FirstDate : TTimeStamp = (Time : 0; Date : 1);
var
  TS        : TTimeStamp;
begin
  Result := DBIERR_NONE;
  TS.Date := DateTimeToTimeStamp(StrToDateDef(string(TnxShStr(aSource)), TimestampToDateTime(FirstDate), ssmFormatSettings{$IFDEF FPC}.DateSeparator{$ENDIF})).Date;
  if TS.Date = FirstDate.Date then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxDate(aTarget) := TS.Date;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToDateConvert(const aSource; var aTarget): TnxResult;
const
  FirstDate : TTimeStamp = (Time : 0; Date : 1);
var
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToDateConvert'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToDateConvert'+'/'+'WidecharToMultiByte');

  TnxDate(aTarget) := DateTimeToTimeStamp(StrToDateDef(s, TimestampToDateTime(FirstDate), ssmFormatSettings{$IFDEF FPC}.DateSeparator{$ENDIF})).Date;
  {$ELSE}
  TnxDate(aTarget) := DateTimeToTimeStamp(StrToDateDef(ws, TimestampToDateTime(FirstDate), ssmFormatSettings{$IFDEF FPC}.DateSeparator{$ENDIF})).Date;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToDateConvertCheck(const aSource; var aTarget): TnxResult;
const
  FirstDate : TTimeStamp = (Time : 0; Date : 1);
var
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
  TS        : TTimeStamp;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToDateConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToDateConvertCheck'+'/'+'WidecharToMultiByte');

  TS.Date := DateTimeToTimeStamp(StrToDateDef(s, TimestampToDateTime(FirstDate), ssmFormatSettings{$IFDEF FPC}.DateSeparator{$ENDIF})).Date;
  {$ELSE}
  TS.Date := DateTimeToTimeStamp(StrToDateDef(ws, TimestampToDateTime(FirstDate), ssmFormatSettings{$IFDEF FPC}.DateSeparator{$ENDIF})).Date;
  {$ENDIF}

  if TS.Date = FirstDate.Date then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxDate(aTarget) := TS.Date;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToDateTime(const aSource; var aTarget): TnxResult;
const
  FirstDate : TTimeStamp = (Time : 0; Date : 1);
var
  TS        : TTimeStamp;
begin
  Result := DBIERR_NONE;
  TS := DateTimeToTimeStamp(StrToDateTimeDef(string(TnxShStr(aSource)), TimestampToDateTime(FirstDate), ssmFormatSettings));
  TnxDateTime(aTarget) := TS.Date * Int64(MSecsPerDay) * 1.0 + TS.Time;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToDateTimeCheck(const aSource; var aTarget): TnxResult;
const
  FirstDate : TTimeStamp = (Time : 0; Date : 1);
var
  TS        : TTimeStamp;
begin
  Result := DBIERR_NONE;
  TS := DateTimeToTimeStamp(StrToDateTimeDef(string(TnxShStr(aSource)), TimestampToDateTime(FirstDate), ssmFormatSettings));
  if (TS.Date = FirstDate.Date) and
     (TS.Time = FirstDate.Time) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxDateTime(aTarget) := TS.Date * Int64(MSecsPerDay) * 1.0 + TS.Time;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToDateTimeConvert(const aSource; var aTarget): TnxResult;
const
  FirstDate : TTimeStamp = (Time : 0; Date : 1);
var
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
  TS        : TTimeStamp;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToDateTimeConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToDateTimeConvertCheck'+'/'+'WidecharToMultiByte');

  TS := DateTimeToTimeStamp(StrToDateTimeDef(s, TimestampToDateTime(FirstDate), ssmFormatSettings));
  {$ELSE}
  TS := DateTimeToTimeStamp(StrToDateTimeDef(ws, TimestampToDateTime(FirstDate), ssmFormatSettings));
  {$ENDIF}
  TnxDateTime(aTarget) := TS.Date * Int64(MSecsPerDay) * 1.0 + TS.Time;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToDateTimeConvertCheck(const aSource; var aTarget): TnxResult;
const
  FirstDate : TTimeStamp = (Time : 0; Date : 1);
var
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
  TS        : TTimeStamp;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToDateTimeConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToDateTimeConvertCheck'+'/'+'WidecharToMultiByte');

  TS := DateTimeToTimeStamp(StrToDateTimeDef(s, TimestampToDateTime(FirstDate), ssmFormatSettings));
  {$ELSE}
  TS := DateTimeToTimeStamp(StrToDateTimeDef(ws, TimestampToDateTime(FirstDate), ssmFormatSettings));
  {$ENDIF}
  if (TS.Date = FirstDate.Date) and
     (TS.Time = FirstDate.Time) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxDateTime(aTarget) := TS.Date * Int64(MSecsPerDay) * 1.0 + TS.Time;
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToDouble(const aSource; var aTarget): TnxResult;
var
  Code : Integer;
begin
  Result := DBIERR_NONE;
  Val(string(TnxShStr(aSource)), TnxDouble(aTarget), Code);
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToDoubleCheck(const aSource; var aTarget): TnxResult;
var
  D    : Double;
  Code : Integer;
begin
  Result := DBIERR_NONE;
  Val(string(TnxShStr(aSource)), D, Code);
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxDouble(aTarget) := D;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToDoubleConvert(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToDateTimeConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToDateTimeConvertCheck'+'/'+'WidecharToMultiByte');

  Val(s, TnxDouble(aTarget), Code);
  {$ELSE}
  Val(ws, TnxDouble(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToDoubleConvertCheck(const aSource; var aTarget): TnxResult;
var
  D         : TnxDouble;
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToDateTimeConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToDateTimeConvertCheck'+'/'+'WidecharToMultiByte');

  Val(s, D, Code);
  {$ELSE}
  Val(ws, D, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxDouble(aTarget) := D;
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToExtended(const aSource; var aTarget): TnxResult;
var
  Code : Integer;
begin
  {$IFDEF FPC}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ELSE}
  Result := DBIERR_NONE;
  Val(string(TnxShStr(aSource)), TnxExtended(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToExtendedCheck(const aSource; var aTarget): TnxResult;
var
  E    : TnxExtended;
  Code : Integer;
begin
  {$IFDEF FPC}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ELSE}
  Result := DBIERR_NONE;
  Val(string(TnxShStr(aSource)), E, Code);
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxExtended(aTarget) := E;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToExtendedConvert(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  {$IFDEF FPC}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ELSE}
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToDateTimeConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToDateTimeConvertCheck'+'/'+'WidecharToMultiByte');

  Val(s, TnxExtended(aTarget), Code);
  {$ELSE}
  Val(ws, TnxExtended(aTarget), Code);
  {$ENDIF}
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToExtendedConvertCheck(const aSource; var aTarget): TnxResult;
var
  E         : TnxExtended;
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  {$IFDEF FPC}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ELSE}
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToDateTimeConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToDateTimeConvertCheck'+'/'+'WidecharToMultiByte');

  Val(s, E, Code);
  {$ELSE}
  Val(ws, E, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxExtended(aTarget) := E;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToGuid(const aSource; var aTarget): TnxResult;
var
  ws : UnicodeString;
begin
  Result := DBIERR_NONE;
  ws := string(TnxShStr(aSource));
  TGUID(aTarget) := nxNullGuid;
  CLSIDFromString(PWideChar(ws), TGUID(aTarget));
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToGuidCheck(const aSource; var aTarget): TnxResult;
var
  ws : UnicodeString;
begin
  Result := DBIERR_NONE;
  ws := string(TnxShStr(aSource));
  if not Succeeded(CLSIDFromString(PWideChar(ws), TGuid(aTarget))) then
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToGuidConvert(const aSource; var aTarget): TnxResult;
var
  ws        : Array[byte] of Widechar;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToGuidConvert'+'/'+'MultiByteToWideChar');

  CLSIDFromString(PWideChar(@ws), TGuid(aTarget));
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToGuidConvertCheck(const aSource; var aTarget): TnxResult;
var
  ws        : Array[byte] of Widechar;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToGuidConvert'+'/'+'MultiByteToWideChar');

  if not Succeeded(CLSIDFromString(PWideChar(@ws), TGuid(aTarget))) then
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToInt16(const aSource; var aTarget): TnxResult;
var
  Code : Integer;
begin
  Result := DBIERR_NONE;
  Val(string(TnxShStr(aSource)), TnxInt16(aTarget), Code);
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToInt16Check(const aSource; var aTarget): TnxResult;
var
  I    : TnxInt16;
  Code : Integer;
begin
  Result := DBIERR_NONE;
  Val(string(TnxShStr(aSource)), I, Code);
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt16(aTarget) := I;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToInt16Convert(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToInt16Convert'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToInt16Convert'+'/'+'WidecharToMultiByte');

  Val(s, TnxInt16(aTarget), Code);
  {$ELSE}
  Val(ws, TnxInt16(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToInt16ConvertCheck(const aSource; var aTarget): TnxResult;
var
  I         : TnxInt16;
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToInt16Convert'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToInt16Convert'+'/'+'WidecharToMultiByte');

  Val(s, I, Code);
  {$ELSE}
  Val(ws, I, Code);
  {$ENDIF}
  if Code <> 0 then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt16(aTarget) := I;
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToInt32(const aSource; var aTarget): TnxResult;
var
  Code : Integer;
begin
  Result := DBIERR_NONE;
  Val(string(TnxShStr(aSource)), TnxInt32(aTarget), Code);
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToInt32Check(const aSource; var aTarget): TnxResult;
var
  I    : TnxInt32;
  Code : Integer;
begin
  Result := DBIERR_NONE;
  Val(string(TnxShStr(aSource)), I, Code);
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt32(aTarget) := I;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToInt32Convert(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToInt32Convert'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToInt32Convert'+'/'+'WidecharToMultiByte');

  Val(s, TnxInt32(aTarget), Code);
  {$ELSE}
  Val(ws, TnxInt32(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToInt32ConvertCheck(const aSource; var aTarget): TnxResult;
var
  I         : TnxInt32;
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToInt32ConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToInt32ConvertCheck'+'/'+'WidecharToMultiByte');

  Val(s, I, Code);
  {$ELSE}
  Val(ws, I, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt32(aTarget) := I;
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToInt64(const aSource; var aTarget): TnxResult;
var
  Code : Integer;
begin
  Result := DBIERR_NONE;
  Val(string(TnxShStr(aSource)), TnxInt64(aTarget), Code);
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToInt64Check(const aSource; var aTarget): TnxResult;
var
  I    : TnxInt64;
  Code : Integer;
begin
  Result := DBIERR_NONE;
  Val(string(TnxShStr(aSource)), I, Code);
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt64(aTarget) := I;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToInt64Convert(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToInt64Convert'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToInt64Convert'+'/'+'WidecharToMultiByte');

  Val(s, TnxInt64(aTarget), Code);
  {$ELSE}
  Val(ws, TnxInt64(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToInt64ConvertCheck(const aSource; var aTarget): TnxResult;
var
  I         : TnxInt64;
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToInt64ConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToInt64ConvertCheck'+'/'+'WidecharToMultiByte');

  Val(s, I, Code);
  {$ELSE}
  Val(ws, I, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt64(aTarget) := I;
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToInt8(const aSource; var aTarget): TnxResult;
var
  Code : Integer;
begin
  Result := DBIERR_NONE;
  Val(string(TnxShStr(aSource)), TnxInt8(aTarget), Code);
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToInt8Check(const aSource; var aTarget): TnxResult;
var
  I    : TnxInt8;
  Code : Integer;
begin
  Result := DBIERR_NONE;
  Val(string(TnxShStr(aSource)), I, Code);
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt8(aTarget) := I;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToInt8Convert(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToInt8Convert'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToInt8Convert'+'/'+'WidecharToMultiByte');

  Val(s, TnxInt8(aTarget), Code);
  {$ELSE}
  Val(ws, TnxInt8(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToInt8ConvertCheck(const aSource; var aTarget): TnxResult;
var
  I         : TnxInt8;
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToInt8ConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToInt8ConvertCheck'+'/'+'WidecharToMultiByte');

  Val(s, I, Code);
  {$ELSE}
  Val(ws, I, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt8(aTarget) := I;
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToSingle(const aSource; var aTarget): TnxResult;
var
  Code : Integer;
begin
  Result := DBIERR_NONE;
  Val(string(TnxShStr(aSource)), TnxSingle(aTarget), Code);
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToSingleCheck(const aSource; var aTarget): TnxResult;
var
  I    : TnxSingle;
  Code : Integer;
begin
  Result := DBIERR_NONE;
  Val(string(TnxShStr(aSource)), I, Code);
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxSingle(aTarget) := I;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToSingleConvert(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToSingleConvert'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToSingleConvert'+'/'+'WidecharToMultiByte');

  Val(s, TnxSingle(aTarget), Code);
  {$ELSE}
  Val(ws, TnxSingle(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToSingleConvertCheck(const aSource; var aTarget): TnxResult;
var
  V         : TnxSingle;
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToSingleConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToSingleConvertCheck'+'/'+'WidecharToMultiByte');

  Val(s, V, Code);
  {$ELSE}
  Val(ws, V, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxSingle(aTarget) := V;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToTime(const aSource; var aTarget): TnxResult;
const
  DefTime   : TDateTime = 0.0;
begin
  Result := DBIERR_NONE;
  TnxTime(aTarget) := DateTimeToTimeStamp(SysUtils.Date + StrToTimeDef(string(TnxShStr(aSource)), DefTime, ssmFormatSettings{$IFDEF FPC}.TimeSeparator{$ENDIF})).Time;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToTimeCheck(const aSource; var aTarget): TnxResult;
const
  BadTime   : TDateTime = -1.0;
var
  TempTime  : TDateTime;
begin
  Result := DBIERR_NONE;
  TempTime := StrToTimeDef(string(TnxShStr(aSource)), BadTime, ssmFormatSettings{$IFDEF FPC}.TimeSeparator{$ENDIF});
  if (TempTime >= 0.0) and (TempTime < 1.0) then
    TnxTime(aTarget) := DateTimeToTimeStamp(SysUtils.Date + TempTime).Time
  else
    Result := DBIERR_INVALIDFLDXFORM
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToTimeConvert(const aSource; var aTarget): TnxResult;
const
  DefTime   : TDateTime = 0.0;
var
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToTimeConvert'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToTimeConvert'+'/'+'WidecharToMultiByte');
  {$ENDIF}

  TnxTime(aTarget) := DateTimeToTimeStamp(SysUtils.Date + StrToTimeDef({$IFDEF UNICODE}ws{$ELSE}s{$ENDIF}, DefTime, ssmFormatSettings{$IFDEF FPC}.TimeSeparator{$ENDIF})).Time;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToTimeConvertCheck(const aSource; var aTarget): TnxResult;
const
  BadTime   : TDateTime = -1.0;
var
  TempTime  : TDateTime;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToTimeConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFNDEF UNICODE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToTimeConvertCheck'+'/'+'WidecharToMultiByte');
  {$ENDIF}

  TempTime := StrToTimeDef({$IFDEF UNICODE}ws{$ELSE}s{$ENDIF}, BadTime, ssmFormatSettings{$IFDEF FPC}.TimeSeparator{$ENDIF});
  if (TempTime >= 0.0) and (TempTime < 1.0) then
    TnxTime(aTarget) := DateTimeToTimeStamp(SysUtils.Date + TempTime).Time
  else
    Result := DBIERR_INVALIDFLDXFORM
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToWideCharConvert(const aSource; var aTarget): TnxResult;
var
  ws        : Array[byte] of Widechar;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToWideCharConvert'+'/'+'MultiByteToWideChar');

  TnxWideChar(aTarget) := ws[0];
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToWord16(const aSource; var aTarget): TnxResult;
var
  Code : Integer;
begin
  Result := DBIERR_NONE;
  Val(string(TnxShStr(aSource)), TnxWord16(aTarget), Code);
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToWord16Check(const aSource; var aTarget): TnxResult;
var
  W    : TnxWord16;
  Code : Integer;
begin
  Result := DBIERR_NONE;
  Val(string(TnxShStr(aSource)), W, Code);
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxWord16(aTarget) := W;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToWord16Convert(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToWord16Convert'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, TnxWord16(aTarget), Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToWord16Convert'+'/'+'WidecharToMultiByte');

  Val(s, TnxWord16(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToWord16ConvertCheck(const aSource; var aTarget): TnxResult;
var
  W         : TnxWord16;
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToWord16ConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, W, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToWord16ConvertCheck'+'/'+'WidecharToMultiByte');

  Val(s, W, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxWord16(aTarget) := W;
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToWord32(const aSource; var aTarget): TnxResult;
var
  Code : Integer;
begin
  Result := DBIERR_NONE;
  Val(string(TnxShStr(aSource)), TnxWord32(aTarget), Code);
end;
{------------------------------------------------------------------------------}
class function TnxShortStringMapper.ToWord32Check(const aSource; var aTarget): TnxResult;
var
  W    : TnxWord32;
  Code : Integer;
begin
  Result := DBIERR_NONE;
  Val(string(TnxShStr(aSource)), W, Code);
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxWord32(aTarget) := W;
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToWord32Convert(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToWord32Convert'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, TnxWord32(aTarget), Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToWord32Convert'+'/'+'WidecharToMultiByte');

  Val(s, TnxWord32(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxShortStringMapper.ToWord32ConvertCheck(const aSource; var aTarget): TnxResult;
var
  W         : TnxWord32;
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(ssmSourceCodepage, 0, @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]), @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToWord32ConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, W, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxShortStringMapper'+'.'+'ToWord32ConvertCheck'+'/'+'WidecharToMultiByte');

  Val(s, W, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxWord32(aTarget) := W;
end;
{==============================================================================}


{==============================================================================}
constructor TnxNullStringMapper.Create(aSourceField : TnxFieldDescriptor;
                                        aTargetField : TnxFieldDescriptor;
                                        aMapperDesc  : TnxFieldMapperDescriptor;
                                    out aMapper      : TnxMappingMethod);
var
  CPInfo             : TCPInfo;
  SourceIsMultiByte  : Boolean;
  RequiresConversion : Boolean;
begin
  inherited Create;

  if Assigned(aSourceField.UsedLocaleDescriptor) then begin
    GetLocaleFormatSettings(aSourceField.UsedLocaleDescriptor.Locale, nsmFormatSettings);
    nsmSourceCodepage := aSourceField.UsedLocaleDescriptor.StorageCodepage;
  end else
    GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, nsmFormatSettings);

  if Assigned(aTargetField.UsedLocaleDescriptor) then
    nsmTargetCodepage := aTargetField.UsedLocaleDescriptor.StorageCodepage;

  nsmSourceLength := aSourceField.fdLength;
  nsmTargetLength := aTargetField.fdLength;

  nsmTargetUnits := aTargetField.fdUnits;
  nsmTargetDecPl := aTargetField.fdDecPl;

  if nsmSourceCodepage <> 0 then begin
    Win32Check(GetCPInfo(nsmSourceCodepage, CPInfo));
    SourceIsMultiByte := CPInfo.MaxCharSize > 1;
  end else
    SourceIsMultiByte := False;

  RequiresConversion := ((aTargetField.fdType in [nxtChar, nxtWideChar]) and
                         (nsmSourceCodepage <> nsmTargetCodepage)) or
                        (SourceIsMultiByte and
                        (nsmTargetLength < nsmSourceLength));

  if nsmSourceCodepage = 0 then
    RequiresConversion := False
  else if nsmTargetCodepage = 0 then
    RequiresConversion := False;

  if RequiresConversion then begin
    if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then begin
      case aTargetField.fdType of
        nxtBoolean: aMapper := ToBooleanConvert;
        nxtInt8: aMapper := ToInt8Convert;
        nxtInt16: aMapper := ToInt16Convert;
        nxtInt32: aMapper := ToInt32Convert;
        nxtInt64: aMapper := ToInt64Convert;
        nxtByte: aMapper := ToByteConvert;
        nxtWord16: aMapper := ToWord16Convert;
        nxtAutoinc,
        nxtRecRev,
        nxtWord32: aMapper := ToWord32Convert;
        nxtSingle: aMapper := ToSingleConvert;
        nxtDouble: aMapper := ToDoubleConvert;
        nxtExtended: aMapper := ToExtendedConvert;
        nxtBcd: aMapper := ToBcdConvert;
        nxtCurrency: aMapper := ToCurrencyConvert;
        nxtDate: aMapper := ToDateConvert;
        nxtTime: aMapper := ToTimeConvert;
        nxtDateTime: aMapper := ToDateTimeConvert;
        nxtByteArray: aMapper := ToByteArray;
        nxtGuid: aMapper := ToGuidConvert;
        nxtChar: aMapper := ToAnsiCharConvert;
        nxtWideChar: aMapper := ToWideCharConvert;
      end;
    end
    else begin
      case aTargetField.fdType of
        nxtBoolean: aMapper := ToBooleanConvertCheck;
        nxtInt8: aMapper := ToInt8ConvertCheck;
        nxtInt16: aMapper := ToInt16ConvertCheck;
        nxtInt32: aMapper := ToInt32ConvertCheck;
        nxtInt64: aMapper := ToInt64ConvertCheck;
        nxtByte: aMapper := ToByteConvertCheck;
        nxtWord16: aMapper := ToWord16ConvertCheck;
        nxtAutoinc,
        nxtRecRev,
        nxtWord32: aMapper := ToWord32ConvertCheck;
        nxtSingle: aMapper := ToSingleConvertCheck;
        nxtDouble: aMapper := ToDoubleConvertCheck;
        nxtExtended: aMapper := ToExtendedConvertCheck;
        nxtBcd: aMapper := ToBcdConvertCheck;
        nxtCurrency: aMapper := ToCurrencyConvertCheck;
        nxtDate: aMapper := ToDateConvertCheck;
        nxtTime: aMapper := ToTimeConvertCheck;
        nxtDateTime: aMapper := ToDateTimeConvertCheck;
        nxtByteArray: aMapper := ToByteArrayCheck;
        nxtGuid: aMapper := ToGuidConvertCheck;
        nxtChar: aMapper := ToAnsiCharConvert;
        nxtWideChar: aMapper := ToWideCharConvert;
      end;
    end;
  end
  else begin
    if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then begin
      case aTargetField.fdType of
        nxtBoolean: aMapper := ToBoolean;
        nxtInt8: aMapper := ToInt8;
        nxtInt16: aMapper := ToInt16;
        nxtInt32: aMapper := ToInt32;
        nxtInt64: aMapper := ToInt64;
        nxtByte: aMapper := ToByte8;
        nxtWord16: aMapper := ToWord16;
        nxtAutoinc,
        nxtRecRev,
        nxtWord32: aMapper := ToWord32;
        nxtSingle: aMapper := ToSingle;
        nxtDouble: aMapper := ToDouble;
        nxtExtended: aMapper := ToExtended;
        nxtBcd: aMapper := ToBcd;
        nxtCurrency: aMapper := ToCurrency;
        nxtDate: aMapper := ToDate;
        nxtTime: aMapper := ToTime;
        nxtDateTime: aMapper := ToDateTime;
        nxtByteArray: aMapper := ToByteArray;
        nxtGuid: aMapper := ToGuid;
        nxtChar: aMapper := ToAnsiChar;
        nxtWideChar: aMapper := ToWideCharConvert;
      end;
    end
    else begin
      case aTargetField.fdType of
        nxtBoolean: aMapper := ToBooleanCheck;
        nxtInt8: aMapper := ToInt8Check;
        nxtInt16: aMapper := ToInt16Check;
        nxtInt32: aMapper := ToInt32Check;
        nxtInt64: aMapper := ToInt64Check;
        nxtByte: aMapper := ToByteCheck;
        nxtWord16: aMapper := ToWord16Check;
        nxtAutoinc,
        nxtRecRev,
        nxtWord32: aMapper := ToWord32Check;
        nxtSingle: aMapper := ToSingleCheck;
        nxtDouble: aMapper := ToDoubleCheck;
        nxtExtended: aMapper := ToExtendedCheck;
        nxtBcd: aMapper := ToBcdCheck;
        nxtCurrency: aMapper := ToCurrencyCheck;
        nxtDate: aMapper := ToDateCheck;
        nxtTime: aMapper := ToTimeCheck;
        nxtDateTime: aMapper := ToDateTimeCheck;
        nxtByteArray: aMapper := ToByteArrayCheck;
        nxtGuid: aMapper := ToGuidCheck;
        nxtChar: aMapper := ToAnsiChar;
        nxtWideChar: aMapper := ToWideCharConvert;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                                         aSourceCursor : TnxAbstractCursor;
                                                         aTargetField  : TnxFieldDescriptor;
                                                         aTargetCursor : TnxAbstractCursor;
                                                         aMapperDesc   : TnxFieldMapperDescriptor;
                                                     out aMapper       : TnxMappingMethod)
                                                                       : TnxBaseFieldMapper;
begin
  Result := nil;
  aMapper := nil;
  if aTargetField.fdType in
    [nxtBoolean, nxtInt8, nxtInt16, nxtInt32, nxtInt64,
     nxtByte, nxtWord16, nxtAutoinc, nxtRecRev, nxtWord32,
     nxtSingle, nxtDouble, nxtExtended, nxtBCD, nxtCurrency,
     nxtDate, nxtTime, nxtDateTime, nxtByteArray, nxtGuid,
     nxtChar, nxtWideChar] then
    Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToBcd(const aSource; var aTarget): TnxResult;
var
  Bcd1, Bcd2 : TnxFmtBcd;
begin
  Result := DBIERR_NONE;

  if nxTryStrToFmtBcd(PAnsiChar(@aSource), Bcd1) then begin
    nxNormalizeBcd(Bcd1, Bcd2, nsmTargetUnits, nsmTargetDecPl);
    nxFmtBcdToCurrency(Bcd2, TnxCurrency(aTarget));
  end else
    TnxCurrency(aTarget) := 0;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToBcdCheck(const aSource; var aTarget): TnxResult;
var
  Bcd1, Bcd2 : TnxFmtBcd;
begin
  Result := DBIERR_INVALIDFLDXFORM;

  if nxTryStrToFmtBcd(PAnsiChar(@aSource), Bcd1) and (nxNormalizeBcd(Bcd1, Bcd2, nsmTargetUnits, nsmTargetDecPl) = []) then begin
    nxFmtBcdToCurrency(Bcd2, TnxCurrency(aTarget));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToBcdConvert(const aSource; var aTarget): TnxResult;
var
  ws         : Array[byte] of Widechar;
  s          : Array[byte] of AnsiChar;
  CharsUsed  : Integer;
  Bcd1, Bcd2 : TnxFmtBcd;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToBcdConvert'+'/'+'MultiByteToWideChar');

  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToBcdConvert'+'/'+'WidecharToMultiByte');


  if nxTryStrToFmtBcd(s, Bcd1) then begin
    nxNormalizeBcd(Bcd1, Bcd2, nsmTargetUnits, nsmTargetDecPl);
    nxFmtBcdToCurrency(Bcd2, TnxCurrency(aTarget));
  end else
    TnxCurrency(aTarget) := 0;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToBcdConvertCheck(const aSource; var aTarget): TnxResult;
var
  ws         : Array[byte] of Widechar;
  s          : Array[byte] of AnsiChar;
  CharsUsed  : Integer;
  Bcd1, Bcd2 : TnxFmtBcd;
begin
  Result := DBIERR_INVALIDFLDXFORM;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToBcdConvertCheck'+'/'+'MultiByteToWideChar');

  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToBcdConvertCheck'+'/'+'WidecharToMultiByte');

  if nxTryStrToFmtBcd(s, Bcd1) and (nxNormalizeBcd(Bcd1, Bcd2, nsmTargetUnits, nsmTargetDecPl) = []) then begin
    nxFmtBcdToCurrency(Bcd2, TnxCurrency(aTarget));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToBoolean(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;
  if (StrIComp(PAnsiChar(@aSource), '1') = 0) or
     (StrIComp(PAnsiChar(@aSource), 'Y') = 0) or
     (StrIComp(PAnsiChar(@aSource), 'Yes') = 0) or
     (StrIComp(PAnsiChar(@aSource), 'T') = 0) or
     (StrIComp(PAnsiChar(@aSource), 'True') = 0) then
    TnxBoolean(aTarget) := True
  else
    TnxBoolean(aTarget) := False;
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToBooleanCheck(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;
  if (StrIComp(PAnsiChar(@aSource), '0') = 0) or
     (StrIComp(PAnsiChar(@aSource), 'N') = 0) or
     (StrIComp(PAnsiChar(@aSource), 'No') = 0) or
     (StrIComp(PAnsiChar(@aSource), 'F') = 0) or
     (StrIComp(PAnsiChar(@aSource), 'False') = 0) then
    TnxBoolean(aTarget) := False
  else
  if (StrIComp(PAnsiChar(@aSource), '1') = 0) or
     (StrIComp(PAnsiChar(@aSource), 'Y') = 0) or
     (StrIComp(PAnsiChar(@aSource), 'Yes') = 0) or
     (StrIComp(PAnsiChar(@aSource), 'T') = 0) or
     (StrIComp(PAnsiChar(@aSource), 'True') = 0) then
    TnxBoolean(aTarget) := True
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToBooleanConvert(const aSource; var aTarget): TnxResult;
var
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToBooleanConvert'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  if (StrIComp(ws, '1') = 0) or
     (StrIComp(ws, 'Y') = 0) or
     (StrIComp(ws, 'Yes') = 0) or
     (StrIComp(ws, 'T') = 0) or
     (StrIComp(ws, 'True') = 0) then
    TnxBoolean(aTarget) := True
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToBooleanConvert'+'/'+'WidecharToMultiByte');

  if (StrIComp(s, '1') = 0) or
     (StrIComp(s, 'Y') = 0) or
     (StrIComp(s, 'Yes') = 0) or
     (StrIComp(s, 'T') = 0) or
     (StrIComp(s, 'True') = 0) then
    TnxBoolean(aTarget) := True
  {$ENDIF}
  else
    TnxBoolean(aTarget) := False;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToBooleanConvertCheck(const aSource; var aTarget): TnxResult;
var
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToBooleanConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  if (StrIComp(ws, '0') = 0) or
     (StrIComp(ws, 'N') = 0) or
     (StrIComp(ws, 'No') = 0) or
     (StrIComp(ws, 'F') = 0) or
     (StrIComp(ws, 'False') = 0) then
    TnxBoolean(aTarget) := False
  else
  if (StrIComp(ws, '1') = 0) or
     (StrIComp(ws, 'Y') = 0) or
     (StrIComp(ws, 'Yes') = 0) or
     (StrIComp(ws, 'T') = 0) or
     (StrIComp(ws, 'True') = 0) then
    TnxBoolean(aTarget) := True
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToBooleanConvertCheck'+'/'+'WidecharToMultiByte');

  if (StrIComp(s, '0') = 0) or
     (StrIComp(s, 'N') = 0) or
     (StrIComp(s, 'No') = 0) or
     (StrIComp(s, 'F') = 0) or
     (StrIComp(s, 'False') = 0) then
    TnxBoolean(aTarget) := False
  else
  if (StrIComp(s, '1') = 0) or
     (StrIComp(s, 'Y') = 0) or
     (StrIComp(s, 'Yes') = 0) or
     (StrIComp(s, 'T') = 0) or
     (StrIComp(s, 'True') = 0) then
    TnxBoolean(aTarget) := True
  {$ENDIF}
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToByte8(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;
  Byte(aTarget) := nxAnsiStrToIntDef(PAnsiChar(@aSource), 0);
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToByteCheck(const aSource; var aTarget): TnxResult;
var
  i64 : Int64;
begin
  Result := DBIERR_NONE;
  i64 := nxAnsiStrToIntDef(PAnsiChar(@aSource), 0);
  if (i64 >= Low(Byte)) and (i64 <= High(Byte)) then
    Byte(aTarget) := i64;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToByteConvert(const aSource; var aTarget): TnxResult;
var
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToByteConvert'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Byte(aTarget) := StrToIntDef(ws, 0);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToByteConvert'+'/'+'WidecharToMultiByte');

  Byte(aTarget) := StrToIntDef(s, 0);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToByteConvertCheck(const aSource; var aTarget): TnxResult;
var
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
  i64       : Int64;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToByteConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  i64 := StrToIntDef(ws, 0);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToByteConvertCheck'+'/'+'WidecharToMultiByte');

  i64 := StrToIntDef(s, 0);
  {$ENDIF}
  if (i64 >= Low(Byte)) and (i64 <= High(Byte)) then
    Byte(aTarget) := i64;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToByteArray(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;
  nxMove(aSource, aTarget, nxMinI32(nsmTargetLength, StrLen(PAnsiChar(@aSource))));
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToByteArrayCheck(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;
  if StrLen(PAnsiChar(@aSource)) <= Cardinal(nsmTargetLength) then
    nxMove(aSource, aTarget, StrLen(PAnsiChar(@aSource)))
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToAnsiChar(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;
  nxMove(aSource, aTarget, 1);
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToAnsiCharConvert(const aSource; var aTarget): TnxResult;
var
  ws        : Array[byte] of Widechar;
  s         : Array[byte] of AnsiChar;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToAnsiCharConvert'+'/'+'MultiByteToWideChar');

  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToAnsiCharConvert'+'/'+'WidecharToMultiByte');

  AnsiChar(aTarget) := s[0];
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToCurrency(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  D         : Double;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToCurrency'+'/'+'MultiByteToWideChar');

  Val(ws, D, Code);
  {$ELSE}
  Val(PAnsiChar(@aSource), D, Code);
  {$ENDIF}

  if Code <> 0 then
    D := 0;
  TnxCurrency(aTarget) := D;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToCurrencyCheck(const aSource; var aTarget): TnxResult;
var
  Code  : Integer;
  D     : Double;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToCurrency'+'/'+'MultiByteToWideChar');

  Val(ws, D, Code);
  {$ELSE}
  Val(PAnsiChar(@aSource), D, Code);
  {$ENDIF}

  if (Code <> 0) or (D < MinCurrency) or (D > MaxCurrency) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxCurrency(aTarget) := D;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToCurrencyConvert(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  D         : Double;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToCurrencyConvert'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, D, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToCurrencyConvert'+'/'+'WidecharToMultiByte');

  Val(s, D, Code);
  {$ENDIF}
  if Code <> 0 then
    D := 0;
  TnxCurrency(aTarget) := D;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToCurrencyConvertCheck(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  D         : Double;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToCurrencyConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, D, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToCurrencyConvertCheck'+'/'+'WidecharToMultiByte');

  Val(s, D, Code);
  {$ENDIF}
  if (Code <> 0) or (D < MinCurrency) or (D > MaxCurrency) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxCurrency(aTarget) := D;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToDate(const aSource; var aTarget): TnxResult;
const
  FirstDate : TTimeStamp = (Time : 0; Date : 1);
  {$IFDEF UNICODE}
var
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToDate'+'/'+'MultiByteToWideChar');

  TnxDate(aTarget) := DateTimeToTimeStamp(StrToDateDef(ws, TimestampToDateTime(FirstDate), nsmFormatSettings)).Date;
  {$ELSE}
  TnxDate(aTarget) := DateTimeToTimeStamp(StrToDateDef(PAnsiChar(@aSource), TimestampToDateTime(FirstDate), nsmFormatSettings{$IFDEF FPC}.TimeSeparator{$ENDIF})).Date;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToDateCheck(const aSource; var aTarget): TnxResult;
const
  FirstDate : TTimeStamp = (Time : 0; Date : 1);
var
  TS        : TTimeStamp;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToDateCheck'+'/'+'MultiByteToWideChar');

  TS.Date := DateTimeToTimeStamp(StrToDateDef(ws, TimestampToDateTime(FirstDate), nsmFormatSettings)).Date;
  {$ELSE}
  TS.Date := DateTimeToTimeStamp(StrToDateDef(PAnsiChar(@aSource), TimestampToDateTime(FirstDate), nsmFormatSettings{$IFDEF FPC}.DateSeparator{$ENDIF})).Date;
  {$ENDIF}

  if TS.Date = FirstDate.Date then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxDate(aTarget) := TS.Date;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToDateConvert(const aSource; var aTarget): TnxResult;
const
  FirstDate : TTimeStamp = (Time : 0; Date : 1);
var
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToDateConvert'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  TnxDate(aTarget) := DateTimeToTimeStamp(StrToDateDef(ws, TimestampToDateTime(FirstDate), nsmFormatSettings)).Date;
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToDateConvert'+'/'+'WidecharToMultiByte');

  TnxDate(aTarget) := DateTimeToTimeStamp(StrToDateDef(s, TimestampToDateTime(FirstDate), nsmFormatSettings{$IFDEF FPC}.DateSeparator{$ENDIF})).Date;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToDateConvertCheck(const aSource; var aTarget): TnxResult;
const
  FirstDate : TTimeStamp = (Time : 0; Date : 1);
var
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
  TS        : TTimeStamp;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToDateConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  TS.Date := DateTimeToTimeStamp(StrToDateDef(ws, TimestampToDateTime(FirstDate), nsmFormatSettings)).Date;
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToDateConvertCheck'+'/'+'WidecharToMultiByte');

  TS.Date := DateTimeToTimeStamp(StrToDateDef(s, TimestampToDateTime(FirstDate), nsmFormatSettings{$IFDEF FPC}.DateSeparator{$ENDIF})).Date;
  {$ENDIF}
  if TS.Date = FirstDate.Date then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxDate(aTarget) := TS.Date;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToDateTime(const aSource; var aTarget): TnxResult;
const
  FirstDate : TTimeStamp = (Time : 0; Date : 1);
var
  TS        : TTimeStamp;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToDateTime'+'/'+'MultiByteToWideChar');

  TS := DateTimeToTimeStamp(StrToDateTimeDef(ws, TimestampToDateTime(FirstDate), nsmFormatSettings));
  {$ELSE}
  TS := DateTimeToTimeStamp(StrToDateTimeDef(PAnsiChar(@aSource), TimestampToDateTime(FirstDate), nsmFormatSettings));
  {$ENDIF}

  TnxDateTime(aTarget) := TS.Date * Int64(MSecsPerDay) * 1.0 + TS.Time;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToDateTimeCheck(const aSource; var aTarget): TnxResult;
const
  FirstDate : TTimeStamp = (Time : 0; Date : 1);
var
  TS        : TTimeStamp;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToDateTimeCheck'+'/'+'MultiByteToWideChar');

  TS := DateTimeToTimeStamp(StrToDateTimeDef(ws, TimestampToDateTime(FirstDate), nsmFormatSettings));
  {$ELSE}
  TS := DateTimeToTimeStamp(StrToDateTimeDef(PAnsiChar(@aSource), TimestampToDateTime(FirstDate), nsmFormatSettings));
  {$ENDIF}

  if (TS.Date = FirstDate.Date) and
     (TS.Time = FirstDate.Time) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxDateTime(aTarget) := TS.Date * Int64(MSecsPerDay) * 1.0 + TS.Time;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToDateTimeConvert(const aSource; var aTarget): TnxResult;
const
  FirstDate : TTimeStamp = (Time : 0; Date : 1);
var
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
  TS        : TTimeStamp;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToDateTimeConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  TS := DateTimeToTimeStamp(StrToDateTimeDef(ws, TimestampToDateTime(FirstDate), nsmFormatSettings));
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToDateTimeConvertCheck'+'/'+'WidecharToMultiByte');

  TS := DateTimeToTimeStamp(StrToDateTimeDef(s, TimestampToDateTime(FirstDate), nsmFormatSettings));
  {$ENDIF}
  TnxDateTime(aTarget) := TS.Date * Int64(MSecsPerDay) * 1.0 + TS.Time;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToDateTimeConvertCheck(const aSource; var aTarget): TnxResult;
const
  FirstDate : TTimeStamp = (Time : 0; Date : 1);
var
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
  TS        : TTimeStamp;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToDateTimeConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  TS := DateTimeToTimeStamp(StrToDateTimeDef(ws, TimestampToDateTime(FirstDate), nsmFormatSettings));
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToDateTimeConvertCheck'+'/'+'WidecharToMultiByte');

  TS := DateTimeToTimeStamp(StrToDateTimeDef(s, TimestampToDateTime(FirstDate), nsmFormatSettings));
  {$ENDIF}
  if (TS.Date = FirstDate.Date) and
     (TS.Time = FirstDate.Time) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxDateTime(aTarget) := TS.Date * Int64(MSecsPerDay) * 1.0 + TS.Time;
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToDouble(const aSource; var aTarget): TnxResult;
var
  Code : Integer;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(CP_ACP, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToDouble'+'/'+'MultiByteToWideChar');

  Val(ws, TnxDouble(aTarget), Code);
  {$ELSE}
  Val(PAnsiChar(@aSource), TnxDouble(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToDoubleCheck(const aSource; var aTarget): TnxResult;
var
  D    : Double;
  Code : Integer;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(CP_ACP, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToDoubleCheck'+'/'+'MultiByteToWideChar');

  Val(ws, D, Code);
  {$ELSE}
  Val(PAnsiChar(@aSource), D, Code);
  {$ENDIF}

  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxDouble(aTarget) := D;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToDoubleConvert(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToDoubleConvert'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, TnxDouble(aTarget), Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToDoubleConvert'+'/'+'WidecharToMultiByte');

  Val(s, TnxDouble(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToDoubleConvertCheck(const aSource; var aTarget): TnxResult;
var
  D         : TnxDouble;
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToDoubleConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, D, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToDoubleConvertCheck'+'/'+'WidecharToMultiByte');

  Val(s, D, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxDouble(aTarget) := D;
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToExtended(const aSource; var aTarget): TnxResult;
var
  Code : Integer;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  {$IFNDEF FPC}
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(CP_ACP, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToExtended'+'/'+'MultiByteToWideChar');

  Val(ws, TnxExtended(aTarget), Code);
  {$ELSE}
  Val(PAnsiChar(@aSource), TnxExtended(aTarget), Code);
  {$ENDIF}
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToExtendedCheck(const aSource; var aTarget): TnxResult;
var
  E    : TnxExtended;
  Code : Integer;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  {$IFNDEF FPC}
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(CP_ACP, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToExtendedCheck'+'/'+'MultiByteToWideChar');

  Val(ws, E, Code);
  {$ELSE}
  Val(PAnsiChar(@aSource), E, Code);
  {$ENDIF}

  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxExtended(aTarget) := E;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToExtendedConvert(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  {$IFNDEF FPC}
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToExtendedConvert'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, TnxExtended(aTarget), Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToExtendedConvert'+'/'+'WidecharToMultiByte');

  Val(s, TnxExtended(aTarget), Code);
  {$ENDIF}
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToExtendedConvertCheck(const aSource; var aTarget): TnxResult;
var
  E         : TnxExtended;
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  {$IFNDEF FPC}
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToExtendedConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, E, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToExtendedConvertCheck'+'/'+'WidecharToMultiByte');

  Val(s, E, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxExtended(aTarget) := E;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToGuid(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;
  CLSIDFromString(PWideChar(UnicodeString(PAnsiChar(@aSource))), TGuid(aTarget));
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToGuidCheck(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;
  if not Succeeded(CLSIDFromString(PWideChar(UnicodeString(PAnsiChar(@aSource))), TGuid(aTarget))) then
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToGuidConvert(const aSource; var aTarget): TnxResult;
var
  ws        : Array[byte] of Widechar;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToGuidConvert'+'/'+'MultiByteToWideChar');

  CLSIDFromString(PWideChar(@ws), TGuid(aTarget));
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToGuidConvertCheck(const aSource; var aTarget): TnxResult;
var
  ws        : Array[byte] of Widechar;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToGuidConvertCheck'+'/'+'MultiByteToWideChar');

  if not Succeeded(CLSIDFromString(PWideChar(@ws), TGuid(aTarget))) then
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToInt16(const aSource; var aTarget): TnxResult;
var
  Code : Integer;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(CP_ACP, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt16'+'/'+'MultiByteToWideChar');

  Val(ws, TnxInt16(aTarget), Code);
  {$ELSE}
  Val(PAnsiChar(@aSource), TnxInt16(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToInt16Check(const aSource; var aTarget): TnxResult;
var
  I    : TnxInt16;
  Code : Integer;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(CP_ACP, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt16Check'+'/'+'MultiByteToWideChar');

  Val(ws, I, Code);
  {$ELSE}
  Val(PAnsiChar(@aSource), I, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt16(aTarget) := I;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToInt16Convert(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt16Convert'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, TnxInt16(aTarget), Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt16Convert'+'/'+'WidecharToMultiByte');

  Val(s, TnxInt16(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToInt16ConvertCheck(const aSource; var aTarget): TnxResult;
var
  I         : TnxInt16;
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt16Convert'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, I, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt16Convert'+'/'+'WidecharToMultiByte');

  Val(s, I, Code);
  {$ENDIF}
  if Code <> 0 then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt16(aTarget) := I;
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToInt32(const aSource; var aTarget): TnxResult;
var
  Code : Integer;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(CP_ACP, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt32'+'/'+'MultiByteToWideChar');

  Val(ws, TnxInt32(aTarget), Code);
  {$ELSE}
  Val(PAnsiChar(@aSource), TnxInt32(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToInt32Check(const aSource; var aTarget): TnxResult;
var
  I    : TnxInt32;
  Code : Integer;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(CP_ACP, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt32Check'+'/'+'MultiByteToWideChar');

  Val(ws, I, Code);
  {$ELSE}
  Val(PAnsiChar(@aSource), I, Code);
  {$ENDIF}

  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt32(aTarget) := I;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToInt32Convert(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt32Convert'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, TnxInt32(aTarget), Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt32Convert'+'/'+'WidecharToMultiByte');

  Val(s, TnxInt32(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToInt32ConvertCheck(const aSource; var aTarget): TnxResult;
var
  I         : TnxInt32;
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt32ConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, I, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt32ConvertCheck'+'/'+'WidecharToMultiByte');

  Val(s, I, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt32(aTarget) := I;
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToInt64(const aSource; var aTarget): TnxResult;
var
  Code : Integer;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(CP_ACP, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt64'+'/'+'MultiByteToWideChar');

  Val(ws, TnxInt64(aTarget), Code);
  {$ELSE}
  Val(PAnsiChar(@aSource), TnxInt64(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToInt64Check(const aSource; var aTarget): TnxResult;
var
  I    : TnxInt64;
  Code : Integer;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(CP_ACP, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt64Check'+'/'+'MultiByteToWideChar');

  Val(ws, I, Code);
  {$ELSE}
  Val(PAnsiChar(@aSource), I, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt64(aTarget) := I;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToInt64Convert(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt64Convert'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, TnxInt64(aTarget), Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt64Convert'+'/'+'WidecharToMultiByte');

  Val(s, TnxInt64(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToInt64ConvertCheck(const aSource; var aTarget): TnxResult;
var
  I         : TnxInt64;
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt64ConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, I, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt64ConvertCheck'+'/'+'WidecharToMultiByte');

  Val(s, I, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt64(aTarget) := I;
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToInt8(const aSource; var aTarget): TnxResult;
var
  Code : Integer;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(CP_ACP, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt8'+'/'+'MultiByteToWideChar');

  Val(ws, TnxInt8(aTarget), Code);
  {$ELSE}
  Val(PAnsiChar(@aSource), TnxInt8(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToInt8Check(const aSource; var aTarget): TnxResult;
var
  I    : TnxInt8;
  Code : Integer;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(CP_ACP, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt8Check'+'/'+'MultiByteToWideChar');

  Val(ws, I, Code);
  {$ELSE}
  Val(PAnsiChar(@aSource), I, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt8(aTarget) := I;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToInt8Convert(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt8Convert'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, TnxInt8(aTarget), Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt8Convert'+'/'+'WidecharToMultiByte');

  Val(s, TnxInt8(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToInt8ConvertCheck(const aSource; var aTarget): TnxResult;
var
  I         : TnxInt8;
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt8ConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, I, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToInt8ConvertCheck'+'/'+'WidecharToMultiByte');

  Val(s, I, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt8(aTarget) := I;
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToSingle(const aSource; var aTarget): TnxResult;
var
  Code : Integer;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(CP_ACP, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToSingle'+'/'+'MultiByteToWideChar');

  Val(ws, TnxSingle(aTarget), Code);
  {$ELSE}
  Val(PAnsiChar(@aSource), TnxSingle(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToSingleCheck(const aSource; var aTarget): TnxResult;
var
  I    : TnxSingle;
  Code : Integer;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(CP_ACP, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToSingleCheck'+'/'+'MultiByteToWideChar');

  Val(ws, I, Code);
  {$ELSE}
  Val(PAnsiChar(@aSource), I, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxSingle(aTarget) := I;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToSingleConvert(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToSingleConvert'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, TnxSingle(aTarget), Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToSingleConvert'+'/'+'WidecharToMultiByte');

  Val(s, TnxSingle(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToSingleConvertCheck(const aSource; var aTarget): TnxResult;
var
  V         : TnxSingle;
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToSingleConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, V, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToSingleConvertCheck'+'/'+'WidecharToMultiByte');

  Val(s, V, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxSingle(aTarget) := V;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToTime(const aSource; var aTarget): TnxResult;
const
  DefTime   : TDateTime = 0.0;
  {$IFDEF UNICODE}
var
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToTime'+'/'+'MultiByteToWideChar');

  TnxTime(aTarget) := DateTimeToTimeStamp(SysUtils.Date + StrToTimeDef(ws, DefTime, nsmFormatSettings)).Time;
  {$ELSE}
  TnxTime(aTarget) := DateTimeToTimeStamp(SysUtils.Date + StrToTimeDef(PAnsiChar(@aSource), DefTime, nsmFormatSettings{$IFDEF FPC}.TimeSeparator{$ENDIF})).Time;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToTimeCheck(const aSource; var aTarget): TnxResult;
const
  BadTime   : TDateTime = -1.0;
var
  TempTime  : TDateTime;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToTimeCheck'+'/'+'MultiByteToWideChar');

  TempTime := StrToTimeDef(ws, BadTime, nsmFormatSettings);
  {$ELSE}
  TempTime := StrToTimeDef(PAnsiChar(@aSource), BadTime, nsmFormatSettings{$IFDEF FPC}.TimeSeparator{$ENDIF});
  {$ENDIF}
  if (TempTime >= 0.0) and (TempTime < 1.0) then
    TnxTime(aTarget) := DateTimeToTimeStamp(SysUtils.Date + TempTime).Time
  else
    Result := DBIERR_INVALIDFLDXFORM
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToTimeConvert(const aSource; var aTarget): TnxResult;
const
  DefTime   : TDateTime = 0.0;
var
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToTimeConvert'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  TnxTime(aTarget) := DateTimeToTimeStamp(Date + StrToTimeDef(ws, DefTime, nsmFormatSettings)).Time;
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToTimeConvert'+'/'+'WidecharToMultiByte');

  TnxTime(aTarget) := DateTimeToTimeStamp(SysUtils.Date + StrToTimeDef(s, DefTime, nsmFormatSettings{$IFDEF FPC}.TimeSeparator{$ENDIF})).Time;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToTimeConvertCheck(const aSource; var aTarget): TnxResult;
const
  BadTime   : TDateTime = -1.0;
var
  TempTime  : TDateTime;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToTimeConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  TempTime := StrToTimeDef(ws, BadTime, nsmFormatSettings);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToTimeConvertCheck'+'/'+'WidecharToMultiByte');

  TempTime := StrToTimeDef(s, BadTime, nsmFormatSettings{$IFDEF FPC}.TimeSeparator{$ENDIF});
  {$ENDIF}
  if (TempTime >= 0.0) and (TempTime < 1.0) then
    TnxTime(aTarget) := DateTimeToTimeStamp(SysUtils.Date + TempTime).Time
  else
    Result := DBIERR_INVALIDFLDXFORM
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToWideCharConvert(const aSource; var aTarget): TnxResult;
var
  ws        : Array[byte] of Widechar;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToWideCharConvert'+'/'+'MultiByteToWideChar');

  TnxWideChar(aTarget) := ws[0];
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToWord16(const aSource; var aTarget): TnxResult;
var
  Code : Integer;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(CP_ACP, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToWord16'+'/'+'MultiByteToWideChar');

  Val(ws, TnxWord16(aTarget), Code);
  {$ELSE}
  Val(PAnsiChar(@aSource), TnxWord16(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToWord16Check(const aSource; var aTarget): TnxResult;
var
  W    : TnxWord16;
  Code : Integer;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(CP_ACP, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToWord16Check'+'/'+'MultiByteToWideChar');

  Val(ws, W, Code);
  {$ELSE}
  Val(PAnsiChar(@aSource), W, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxWord16(aTarget) := W;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToWord16Convert(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToWord16Convert'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, TnxWord16(aTarget), Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToWord16Convert'+'/'+'WidecharToMultiByte');

  Val(s, TnxWord16(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToWord16ConvertCheck(const aSource; var aTarget): TnxResult;
var
  W         : TnxWord16;
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToWord16ConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, W, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToWord16ConvertCheck'+'/'+'WidecharToMultiByte');

  Val(s, W, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxWord16(aTarget) := W;
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToWord32(const aSource; var aTarget): TnxResult;
var
  Code : Integer;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(CP_ACP, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToWord32'+'/'+'MultiByteToWideChar');

  Val(ws, TnxWord32(aTarget), Code);
  {$ELSE}
  Val(PAnsiChar(@aSource), TnxWord32(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxNullStringMapper.ToWord32Check(const aSource; var aTarget): TnxResult;
var
  W    : TnxWord32;
  Code : Integer;
  {$IFDEF UNICODE}
  ws        : Array[byte] of WideChar;
  CharsUsed : Integer;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  CharsUsed := MultibyteToWidechar(CP_ACP, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToWord32Check'+'/'+'MultiByteToWideChar');

  Val(ws, W, Code);
  {$ELSE}
  Val(PAnsiChar(@aSource), W, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxWord32(aTarget) := W;
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToWord32Convert(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToWord32Convert'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, TnxWord32(aTarget), Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToWord32Convert'+'/'+'WidecharToMultiByte');

  Val(s, TnxWord32(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxNullStringMapper.ToWord32ConvertCheck(const aSource; var aTarget): TnxResult;
var
  W         : TnxWord32;
  Code      : Integer;
  ws        : Array[byte] of Widechar;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;
  CharsUsed := MultibyteToWidechar(nsmSourceCodepage, 0, PAnsiChar(@aSource), -1, @ws, Pred(SizeOf(ws)) div SizeOf(WideChar));

  if CharsUsed = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToWord32ConvertCheck'+'/'+'MultiByteToWideChar');

  {$IFDEF UNICODE}
  Val(ws, W, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, @ws, CharsUsed, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxNullStringMapper'+'.'+'ToWord32ConvertCheck'+'/'+'WidecharToMultiByte');

  Val(s, W, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxWord32(aTarget) := W;
end;
{==============================================================================}


{==============================================================================}
constructor TnxWideStringMapper.Create(aSourceField : TnxFieldDescriptor;
                                        aTargetField : TnxFieldDescriptor;
                                        aMapperDesc  : TnxFieldMapperDescriptor;
                                    out aMapper      : TnxMappingMethod);
var
  CPInfo             : TCPInfo;
  RequiresConversion : Boolean;
begin
  inherited Create;

  if Assigned(aSourceField.UsedLocaleDescriptor) then
    GetLocaleFormatSettings(aSourceField.UsedLocaleDescriptor.Locale, wsmFormatSettings)
  else
    GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, wsmFormatSettings);

  if Assigned(aTargetField.UsedLocaleDescriptor) then
    wsmTargetCodepage := aTargetField.UsedLocaleDescriptor.StorageCodepage;

  wsmSourceLength := aSourceField.fdLength;
  wsmTargetLength := aTargetField.fdLength;

  wsmTargetUnits := aTargetField.fdUnits;
  wsmTargetDecPl := aTargetField.fdDecPl;

  if wsmTargetCodepage <> 0 then begin
    Win32Check(GetCPInfo(wsmTargetCodepage, CPInfo));
    wsmMaxCharSize := CPInfo.MaxCharSize;
  end;

  RequiresConversion :=  (aTargetField.fdType = nxtChar);

  if wsmTargetCodepage = 0 then begin
    RequiresConversion := False;
    wsmTargetCodePage := CP_ACP;
  end;

  if RequiresConversion then begin
    aMapper := ToAnsiCharConvert;
  end
  else begin
    if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then begin
      case aTargetField.fdType of
        nxtBoolean: aMapper := ToBoolean;
        nxtInt8: aMapper := ToInt8;
        nxtInt16: aMapper := ToInt16;
        nxtInt32: aMapper := ToInt32;
        nxtInt64: aMapper := ToInt64;
        nxtByte: aMapper := ToByte8;
        nxtWord16: aMapper := ToWord16;
        nxtAutoinc,
        nxtRecRev,
        nxtWord32: aMapper := ToWord32;
        nxtSingle: aMapper := ToSingle;
        nxtDouble: aMapper := ToDouble;
        nxtExtended: aMapper := ToExtended;
        nxtBcd: aMapper := ToBcd;
        nxtCurrency: aMapper := ToCurrency;
        nxtDate: aMapper := ToDate;
        nxtTime: aMapper := ToTime;
        nxtDateTime: aMapper := ToDateTime;
        nxtByteArray: aMapper := ToByteArray;
        nxtGuid: aMapper := ToGuid;
        nxtChar: aMapper := ToAnsiChar;
        nxtWideChar: aMapper := ToWideChar;
      end;
    end
    else begin
      case aTargetField.fdType of
        nxtBoolean: aMapper := ToBooleanCheck;
        nxtInt8: aMapper := ToInt8Check;
        nxtInt16: aMapper := ToInt16Check;
        nxtInt32: aMapper := ToInt32Check;
        nxtInt64: aMapper := ToInt64Check;
        nxtByte: aMapper := ToByteCheck;
        nxtWord16: aMapper := ToWord16Check;
        nxtAutoinc,
        nxtRecRev,
        nxtWord32: aMapper := ToWord32Check;
        nxtSingle: aMapper := ToSingleCheck;
        nxtDouble: aMapper := ToDoubleCheck;
        nxtExtended: aMapper := ToExtendedCheck;
        nxtBcd: aMapper := ToBcdCheck;
        nxtCurrency: aMapper := ToCurrencyCheck;
        nxtDate: aMapper := ToDateCheck;
        nxtTime: aMapper := ToTimeCheck;
        nxtDateTime: aMapper := ToDateTimeCheck;
        nxtByteArray: aMapper := ToByteArrayCheck;
        nxtGuid: aMapper := ToGuidCheck;
        nxtChar: aMapper := ToAnsiChar;
        nxtWideChar: aMapper := ToWideCharCheck;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                                         aSourceCursor : TnxAbstractCursor;
                                                         aTargetField  : TnxFieldDescriptor;
                                                         aTargetCursor : TnxAbstractCursor;
                                                         aMapperDesc   : TnxFieldMapperDescriptor;
                                                     out aMapper       : TnxMappingMethod)
                                                                       : TnxBaseFieldMapper;
begin
  Result := nil;
  aMapper := nil;
  if aTargetField.fdType in
    [nxtBoolean, nxtInt8, nxtInt16, nxtInt32, nxtInt64,
     nxtByte, nxtWord16, nxtAutoinc, nxtRecRev, nxtWord32,
     nxtSingle, nxtDouble, nxtExtended, nxtBCD, nxtCurrency,
     nxtDate, nxtTime, nxtDateTime, nxtByteArray, nxtGuid,
     nxtChar, nxtWideChar] then
    Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
end;
{------------------------------------------------------------------------------}
function TnxWideStringMapper.ToBcd(const aSource; var aTarget): TnxResult;
var
  Bcd1, Bcd2 : TnxFmtBcd;
  s          : Array[byte] of AnsiChar;
begin
  Result := DBIERR_NONE;

  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToBcd'+'/'+'WidecharToMultiByte');

  if nxTryStrToFmtBcd(PAnsiChar(@s), Bcd1) then begin
    nxNormalizeBcd(Bcd1, Bcd2, wsmTargetUnits, wsmTargetDecPl);
    nxFmtBcdToCurrency(Bcd2, TnxCurrency(aTarget));
  end else
    TnxCurrency(aTarget) := 0;
end;
{------------------------------------------------------------------------------}
function TnxWideStringMapper.ToBcdCheck(const aSource; var aTarget): TnxResult;
var
  Bcd1, Bcd2 : TnxFmtBcd;
  s          : Array[byte] of AnsiChar;
begin
  Result := DBIERR_INVALIDFLDXFORM;

  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToBcdCheck'+'/'+'WidecharToMultiByte');

  if nxTryStrToFmtBcd(PAnsiChar(@s), Bcd1) and (nxNormalizeBcd(Bcd1, Bcd2, wsmTargetUnits, wsmTargetDecPl) = []) then begin
    nxFmtBcdToCurrency(Bcd2, TnxCurrency(aTarget));
    Result := DBIERR_NONE;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToBoolean(const aSource; var aTarget): TnxResult;
var
  s : Array[Byte] of AnsiChar;
begin
  Result := DBIERR_NONE;

  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToBoolean'+'/'+'WidecharToMultiByte');

  if (StrIComp(PAnsiChar(@s), '1') = 0) or
     (StrIComp(PAnsiChar(@s), 'Y') = 0) or
     (StrIComp(PAnsiChar(@s), 'Yes') = 0) or
     (StrIComp(PAnsiChar(@s), 'T') = 0) or
     (StrIComp(PAnsiChar(@s), 'True') = 0) then
    TnxBoolean(aTarget) := True
  else
    TnxBoolean(aTarget) := False;
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToBooleanCheck(const aSource; var aTarget): TnxResult;
var
  s : Array[Byte] of AnsiChar;
begin
  Result := DBIERR_NONE;

  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToBoolean'+'/'+'WidecharToMultiByte');

  if (StrIComp(PAnsiChar(@s), '0') = 0) or
     (StrIComp(PAnsiChar(@s), 'N') = 0) or
     (StrIComp(PAnsiChar(@s), 'No') = 0) or
     (StrIComp(PAnsiChar(@s), 'F') = 0) or
     (StrIComp(PAnsiChar(@s), 'False') = 0) then
    TnxBoolean(aTarget) := False
  else
  if (StrIComp(PAnsiChar(@s), '1') = 0) or
     (StrIComp(PAnsiChar(@s), 'Y') = 0) or
     (StrIComp(PAnsiChar(@s), 'Yes') = 0) or
     (StrIComp(PAnsiChar(@s), 'T') = 0) or
     (StrIComp(PAnsiChar(@s), 'True') = 0) then
    TnxBoolean(aTarget) := True
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToByte8(const aSource; var aTarget): TnxResult;
var
  s : Array[Byte] of AnsiChar;
begin
  Result := DBIERR_NONE;

  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToByte8'+'/'+'WidecharToMultiByte');

  Byte(aTarget) := nxAnsiStrToIntDef(PAnsiChar(@s), 0);
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToByteCheck(const aSource; var aTarget): TnxResult;
var
  i64 : Int64;
  s   : Array[Byte] of AnsiChar;
begin
  Result := DBIERR_NONE;

  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToByteCheck'+'/'+'WidecharToMultiByte');

  i64 := nxAnsiStrToIntDef(PAnsiChar(@s), 0);
  if (i64 >= Low(Byte)) and (i64 <= High(Byte)) then
    Byte(aTarget) := i64;
end;
{------------------------------------------------------------------------------}
function TnxWideStringMapper.ToByteArray(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;
  nxMove(aSource, aTarget, nxMinI32(wsmTargetLength, lstrlenw(PWideChar(@aSource))) * 2);
end;
{------------------------------------------------------------------------------}
function TnxWideStringMapper.ToByteArrayCheck(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;
  if lstrlenw(PWideChar(@aSource)) * 2 <= wsmTargetLength then
    nxMove(aSource, aTarget, lstrlenw(PWideChar(@aSource)) * 2)
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxWideStringMapper.ToAnsiChar(const aSource; var aTarget): TnxResult;
var
  s         : Array[byte] of AnsiChar;
begin
  Result := DBIERR_NONE;
  if WidecharToMultiByte(wsmTargetCodePage, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToAnsiChar'+'/'+'WidecharToMultiByte');

  AnsiChar(aTarget) := s[0];
end;
{------------------------------------------------------------------------------}
function TnxWideStringMapper.ToAnsiCharCheck(const aSource; var aTarget): TnxResult;
var
  s         : Array[byte] of AnsiChar;
begin
  Result := DBIERR_NONE;
  if WidecharToMultiByte(wsmTargetCodePage, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToAnsiCharCheck'+'/'+'WidecharToMultiByte');

  if StrLen(s) = 1 then
    AnsiChar(aTarget) := s[0]
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
function TnxWideStringMapper.ToAnsiCharConvert(const aSource; var aTarget): TnxResult;
var
  s         : Array[byte] of AnsiChar;
begin
  Result := DBIERR_NONE;
  if WidecharToMultiByte(wsmTargetCodePage, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToAnsiCharConvert'+'/'+'WidecharToMultiByte');

  AnsiChar(aTarget) := s[0];
end;
{------------------------------------------------------------------------------}
function TnxWideStringMapper.ToAnsiCharConvertCheck(const aSource; var aTarget): TnxResult;
var
  s         : Array[byte] of AnsiChar;
begin
  Result := DBIERR_NONE;
  if WidecharToMultiByte(wsmTargetCodePage, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToAnsiCharConvertCheck'+'/'+'WidecharToMultiByte');

  if StrLen(s) = 1 then
    AnsiChar(aTarget) := s[0]
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToCurrency(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  D         : Double;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  Val(PWideChar(@aSource), D, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToCurrency'+'/'+'WidecharToMultiByte');

  Val(PAnsiChar(@s), D, Code);
  {$ENDIF}
  if Code <> 0 then
    D := 0;
  TnxCurrency(aTarget) := D;
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToCurrencyCheck(const aSource; var aTarget): TnxResult;
var
  Code  : Integer;
  D     : Double;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  Val(PWideChar(@aSource), D, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToCurrencyCheck'+'/'+'WidecharToMultiByte');

  Val(PAnsiChar(@s), D, Code);
  {$ENDIF}

  if (Code <> 0) or (D < MinCurrency) or (D > MaxCurrency) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxCurrency(aTarget) := D;
end;
{------------------------------------------------------------------------------}
function TnxWideStringMapper.ToDate(const aSource; var aTarget): TnxResult;
const
  FirstDate : TTimeStamp = (Time : 0; Date : 1);
  {$IFNDEF UNICODE}
var
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  TnxDate(aTarget) := DateTimeToTimeStamp(StrToDateDef(PWideChar(@aSource), TimestampToDateTime(FirstDate), wsmFormatSettings)).Date;
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToDate'+'/'+'WidecharToMultiByte');

  TnxDate(aTarget) := DateTimeToTimeStamp(StrToDateDef(PAnsiChar(@s), TimestampToDateTime(FirstDate), wsmFormatSettings{$IFDEF FPC}.DateSeparator{$ENDIF})).Date;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxWideStringMapper.ToDateCheck(const aSource; var aTarget): TnxResult;
const
  FirstDate : TTimeStamp = (Time : 0; Date : 1);
var
  TS        : TTimeStamp;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  TS.Date := DateTimeToTimeStamp(StrToDateDef(PWideChar(@aSource), TimestampToDateTime(FirstDate), wsmFormatSettings)).Date;
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToDateCheck'+'/'+'WidecharToMultiByte');

  TS.Date := DateTimeToTimeStamp(StrToDateDef(PAnsiChar(@s), TimestampToDateTime(FirstDate), wsmFormatSettings{$IFDEF FPC}.DateSeparator{$ENDIF})).Date;
  {$ENDIF}
  if TS.Date = FirstDate.Date then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxDate(aTarget) := TS.Date;
end;
{------------------------------------------------------------------------------}
function TnxWideStringMapper.ToDateTime(const aSource; var aTarget): TnxResult;
const
  FirstDate : TTimeStamp = (Time : 0; Date : 1);
var
  TS        : TTimeStamp;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  TS := DateTimeToTimeStamp(StrToDateTimeDef(PWideChar(@aSource), TimestampToDateTime(FirstDate), wsmFormatSettings));
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToDateTime'+'/'+'WidecharToMultiByte');

  TS := DateTimeToTimeStamp(StrToDateTimeDef(PAnsiChar(@s), TimestampToDateTime(FirstDate), wsmFormatSettings));
  {$ENDIF}
  TnxDateTime(aTarget) := TS.Date * Int64(MSecsPerDay) * 1.0 + TS.Time;
end;
{------------------------------------------------------------------------------}
function TnxWideStringMapper.ToDateTimeCheck(const aSource; var aTarget): TnxResult;
const
  FirstDate : TTimeStamp = (Time : 0; Date : 1);
var
  TS        : TTimeStamp;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  TS := DateTimeToTimeStamp(StrToDateTimeDef(PWideChar(@aSource), TimestampToDateTime(FirstDate), wsmFormatSettings));
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToDateTimeCheck'+'/'+'WidecharToMultiByte');

  TS := DateTimeToTimeStamp(StrToDateTimeDef(PAnsiChar(@s), TimestampToDateTime(FirstDate), wsmFormatSettings));
  {$ENDIF}
  if (TS.Date = FirstDate.Date) and
     (TS.Time = FirstDate.Time) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxDateTime(aTarget) := TS.Date * Int64(MSecsPerDay) * 1.0 + TS.Time;
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToDouble(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  Val(PWideChar(@aSource), TnxDouble(aTarget), Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToDouble'+'/'+'WidecharToMultiByte');

  Val(PAnsiChar(@s), TnxDouble(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToDoubleCheck(const aSource; var aTarget): TnxResult;
var
  D         : Double;
  Code      : Integer;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  Val(PWideChar(@aSource), D, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToDoubleCheck'+'/'+'WidecharToMultiByte');

  Val(PAnsiChar(@s), D, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxDouble(aTarget) := D;
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToExtended(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  {$IFNDEF FPC}
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  Val(PWideChar(@aSource), TnxExtended(aTarget), Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToExtended'+'/'+'WidecharToMultiByte');

  Val(PAnsiChar(@s), TnxExtended(aTarget), Code);
  {$ENDIF}
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToExtendedCheck(const aSource; var aTarget): TnxResult;
var
  E         : TnxExtended;
  Code      : Integer;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  {$IFNDEF FPC}
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  Val(PWideChar(@aSource), E, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToExtendedCheck'+'/'+'WidecharToMultiByte');

  Val(PAnsiChar(@s), E, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxExtended(aTarget) := E;
  {$ELSE}
  Result := DBIERR_INVALIDFLDXFORM;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToGuid(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;
  CLSIDFromString(PWideChar(@aSource), TGuid(aTarget));
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToGuidCheck(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;
  if not Succeeded(CLSIDFromString(PWideChar(@aSource), TGuid(aTarget))) then
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToInt16(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  Val(PWideChar(@aSource), TnxInt16(aTarget), Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToInt16'+'/'+'WidecharToMultiByte');

  Val(PAnsiChar(@s), TnxInt16(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToInt16Check(const aSource; var aTarget): TnxResult;
var
  I         : TnxInt16;
  Code      : Integer;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  Val(PWideChar(@aSource), I, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToInt16Check'+'/'+'WidecharToMultiByte');

  Val(PAnsiChar(@s), I, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt16(aTarget) := I;
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToInt32(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  Val(PWideChar(@aSource), TnxInt32(aTarget), Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToInt32'+'/'+'WidecharToMultiByte');

  Val(PAnsiChar(@s), TnxInt32(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToInt32Check(const aSource; var aTarget): TnxResult;
var
  I         : TnxInt32;
  Code      : Integer;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  Val(PWideChar(@aSource), I, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToInt32Check'+'/'+'WidecharToMultiByte');

  Val(PAnsiChar(@s), I, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt32(aTarget) := I;
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToInt64(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  Val(PWideChar(@aSource), TnxInt64(aTarget), Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToInt64'+'/'+'WidecharToMultiByte');

  Val(PAnsiChar(@s), TnxInt64(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToInt64Check(const aSource; var aTarget): TnxResult;
var
  I         : TnxInt64;
  Code      : Integer;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  Val(PWideChar(@aSource), I, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToInt64Check'+'/'+'WidecharToMultiByte');

  Val(PAnsiChar(@s), I, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt64(aTarget) := I;
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToInt8(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  Val(PWideChar(@aSource), TnxInt8(aTarget), Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToInt8'+'/'+'WidecharToMultiByte');

  Val(PAnsiChar(@s), TnxInt8(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToInt8Check(const aSource; var aTarget): TnxResult;
var
  I         : TnxInt8;
  Code      : Integer;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  Val(PWideChar(@aSource), I, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToInt8Check'+'/'+'WidecharToMultiByte');

  Val(PAnsiChar(@s), I, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxInt8(aTarget) := I;
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToSingle(const aSource; var aTarget): TnxResult;
var
  Code      : Integer;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  Val(PWideChar(@aSource), TnxSingle(aTarget), Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToSingle'+'/'+'WidecharToMultiByte');

  Val(PAnsiChar(@s), TnxSingle(aTarget), Code);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToSingleCheck(const aSource; var aTarget): TnxResult;
var
  I         : TnxSingle;
  Code      : Integer;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  Val(PWideChar(@aSource), I, Code);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToSingleCheck'+'/'+'WidecharToMultiByte');

  Val(PAnsiChar(@s), I, Code);
  {$ENDIF}
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxSingle(aTarget) := I;
end;
{------------------------------------------------------------------------------}
function TnxWideStringMapper.ToTime(const aSource; var aTarget): TnxResult;
const
  DefTime   : TDateTime = 0.0;
  {$IFNDEF UNICODE}
var
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  TnxTime(aTarget) := DateTimeToTimeStamp(Date + StrToTimeDef(PWideChar(@aSource), DefTime, wsmFormatSettings)).Time;
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToTime'+'/'+'WidecharToMultiByte');

  TnxTime(aTarget) := DateTimeToTimeStamp(SysUtils.Date + StrToTimeDef(PAnsiChar(@s), DefTime, wsmFormatSettings{$IFDEF FPC}.TimeSeparator{$ENDIF})).Time;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxWideStringMapper.ToTimeCheck(const aSource; var aTarget): TnxResult;
const
  BadTime   : TDateTime = -1.0;
var
  TempTime  : TDateTime;
  {$IFNDEF UNICODE}
  s         : Array[byte] of AnsiChar;
  {$ENDIF}
begin
  Result := DBIERR_NONE;

  {$IFDEF UNICODE}
  TempTime := StrToTimeDef(PWideChar(@aSource), BadTime, wsmFormatSettings);
  {$ELSE}
  if WidecharToMultiByte(CP_ACP, 0, PWideChar(@aSource), -1, s, SizeOf(s), nil, nil) = 0 then
    nxRaiseLastOSError('TnxWideStringMapper'+'.'+'ToTimeCheck'+'/'+'WidecharToMultiByte');

  TempTime := StrToTimeDef(PAnsiChar(@s), BadTime, wsmFormatSettings{$IFDEF FPC}.TimeSeparator{$ENDIF});
  {$ENDIF}
  if (TempTime >= 0.0) and (TempTime < 1.0) then
    TnxTime(aTarget) := DateTimeToTimeStamp(SysUtils.Date + TempTime).Time
  else
    Result := DBIERR_INVALIDFLDXFORM
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToWideChar(const aSource; var aTarget): TnxResult;
var
  ws        : Array[byte] of Widechar;
begin
  Result := DBIERR_NONE;
  if PWideChar(@aSource)[0] = #0 then
    PWideChar(@aTarget)[0] := #0
  else
    TnxWideChar(aTarget) := ws[0];
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToWideCharCheck(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;
  if PWideChar(@aSource)[0] = #0 then
    PWideChar(@aTarget)[0] := #0
  else
  if lstrlenw(PWideChar(@aSource)) = 1 then
    TnxWideChar(aTarget) := PWideChar(@aSource)[0]
  else
    Result := DBIERR_INVALIDFLDXFORM;
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToWord16(const aSource; var aTarget): TnxResult;
var
  Code : Integer;
begin
  Result := DBIERR_NONE;
  Val(PWideChar(@aSource), TnxWord16(aTarget), Code);
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToWord16Check(const aSource; var aTarget): TnxResult;
var
  W    : TnxWord16;
  Code : Integer;
begin
  Result := DBIERR_NONE;
  Val(PWideChar(@aSource), W, Code);
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxWord16(aTarget) := W;
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToWord32(const aSource; var aTarget): TnxResult;
var
  Code : Integer;
begin
  Result := DBIERR_NONE;
  Val(PWideChar(@aSource), TnxWord32(aTarget), Code);
end;
{------------------------------------------------------------------------------}
class function TnxWideStringMapper.ToWord32Check(const aSource; var aTarget): TnxResult;
var
  W    : TnxWord32;
  Code : Integer;
begin
  Result := DBIERR_NONE;
  Val(PWideChar(@aSource), W, Code);
  if (Code <> 0) then
    Result := DBIERR_INVALIDFLDXFORM
  else
    TnxWord32(aTarget) := W;
end;
{==============================================================================}



{=== TnxByteArrayMapper =======================================================}
constructor TnxByteArrayMapper.Create(aSourceField,
                                      aTargetField  : TnxFieldDescriptor;
                                      aMapperDesc   : TnxFieldMapperDescriptor;
                                  out aMapper       : TnxMappingMethod);
var
  LocaleDescriptor   : TnxLocaleDescriptor;
  CPInfo             : TCPInfo;
  TargetIsMultiByte  : Boolean;
  RequiresConversion : Boolean;
begin
  inherited Create;

  LocaleDescriptor := aSourceField.UsedLocaleDescriptor;
  if Assigned(LocaleDescriptor) then
    bamSourceCodepage := LocaleDescriptor.StorageCodepage;

  LocaleDescriptor := aTargetField.UsedLocaleDescriptor;
  if Assigned(LocaleDescriptor) then
    bamTargetCodepage := LocaleDescriptor.StorageCodepage;

  bamSourceLength := aSourceField.fdLength;
  bamTargetLength := aTargetField.fdLength;

  if bamTargetCodepage <> 0 then begin
    Win32Check(GetCPInfo(bamTargetCodepage, CPInfo));
    TargetIsMultiByte := CPInfo.MaxCharSize > 1;
  end else
    TargetIsMultiByte := False;

  RequiresConversion := (bamSourceCodepage <> bamTargetCodepage) or
    (TargetIsMultiByte and (bamTargetLength < bamSourceLength));

  if bamSourceCodepage = 0 then
    RequiresConversion := False
  else if bamTargetCodepage = 0 then
    RequiresConversion := False;

  if aTargetField.fdType in [nxtByteArray, nxtGuid] then begin
    if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then begin
      case aTargetField.fdType of
        nxtByteArray: aMapper := ToByteArray;
        nxtGuid: aMapper := ToGuid;
      end;
    end
    else begin
      case aTargetField.fdType of
        nxtByteArray: if bamSourceLength <= bamTargetLength then
                        aMapper := ToByteArray;
        nxtGuid: if bamSourceLength >= SizeOf(TGuid) then
                   aMapper := ToGuid;
      end;
    end;
  end
  else
  if RequiresConversion then begin
    if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then begin
      case aTargetField.fdType of
        nxtNullString : aMapper := ToNullStringConvert;
        nxtShortString : aMapper := ToShortStringConvert;
        nxtWideString : aMapper := ToWideString;
      end;
    end
    else begin
      case aTargetField.fdType of
        nxtNullString : aMapper := ToNullStringConvertCheck;
        nxtShortString : aMapper := ToShortStringConvertCheck;
        nxtWideString : if bamSourceLength < (bamTargetLength div SizeOf(TnxWideChar)) then
                          aMapper := ToWideStringCheck;
      end;
    end;
  end
  else
    if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then begin
      case aTargetField.fdType of
        nxtNullString : aMapper := ToNullString;
        nxtShortString : aMapper := ToShortString;
        nxtWideString : aMapper := ToWideString;
      end;
    end
    else begin
      case aTargetField.fdType of
        nxtNullString : if bamSourceLength < bamTargetLength then
                          aMapper := ToNullString;
        nxtShortString : if bamSourceLength < bamTargetLength then
                           aMapper := ToShortString;
        nxtWideString : if bamSourceLength < (bamTargetLength div SizeOf(TnxWideChar)) then
                          aMapper := ToWideStringCheck;
      end;
    end;

end;
{------------------------------------------------------------------------------}
class function TnxByteArrayMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                                       aSourceCursor : TnxAbstractCursor;
                                                       aTargetField  : TnxFieldDescriptor;
                                                       aTargetCursor : TnxAbstractCursor;
                                                       aMapperDesc   : TnxFieldMapperDescriptor;
                                                   out aMapper       : TnxMappingMethod)
                                                                     : TnxBaseFieldMapper;
begin
  Result := nil;
  aMapper := nil;
  if aTargetField.fdType in
    [nxtByteArray,
     nxtGuid,
     nxtNullString,
     nxtShortString,
     nxtWideString] then
    Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
end;
{------------------------------------------------------------------------------}
function TnxByteArrayMapper.ToByteArray(const aSource;
                                          var aTarget): TnxResult;
begin
  nxMove(aSource, aTarget, Min(bamSourceLength, bamTargetLength));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxByteArrayMapper.ToGuid(const aSource;
                                     var aTarget): TnxResult;
begin
  nxMove(aSource, aTarget, Min(bamSourceLength, bamTargetLength));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxByteArrayMapper.ToNullString(const aSource;
                                           var aTarget): TnxResult;
begin
  nxMove(aSource, aTarget, Min(bamSourceLength, Pred(bamTargetLength)));
  PAnsiChar(@aTarget)[Min(Succ(bamSourceLength), bamTargetLength)] := #0;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxByteArrayMapper.ToNullStringConvert(const aSource;
                                                  var aTarget): TnxResult;
var
  Buffer    : array[Byte] of WideChar;
  CharsUsed : Integer;
  i         : Integer;
begin
  Result := DBIERR_NONE;

  if TnxShStr(aSource)[0] = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin

    CharsUsed := MultiByteToWideChar(bamSourceCodepage, 0,
      @TnxShStr(aSource)[0], bamSourceLength,
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    if CharsUsed = 0 then
      nxRaiseLastOSError('TnxByteArrayMapper'+'.'+'ToNullStringConvert'+'/'+'MultiByteToWideChar');

    if CharsUsed >= bamTargetLength then
      CharsUsed := Pred(bamTargetLength);

    i := WideCharToMultiByte(bamTargetCodepage, 0,
      @Buffer, CharsUsed,
      @aTarget, Pred(bamTargetLength),
      nil, nil);

    while i = 0 do
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then begin

        Dec(CharsUsed);
        if CharsUsed = 0 then
          break;

        i := WideCharToMultiByte(bamTargetCodepage, 0,
          @Buffer, CharsUsed,
          @aTarget, Pred(bamTargetLength),
          nil, nil);

      end else
        nxRaiseLastOSError('TnxByteArrayMapper'+'.'+'ToNullStringConvert'+'/'+'WideCharToMultiByte');

    PAnsiChar(@aTarget)[i] := #0;
  end;
end;
{------------------------------------------------------------------------------}
function TnxByteArrayMapper.ToNullStringConvertCheck(const aSource;
                                                       var aTarget): TnxResult;
var
  Buffer    : array[Byte] of WideChar;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if TnxShStr(aSource)[0] = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin

    CharsUsed := MultiByteToWideChar(bamSourceCodepage, 0,
      @TnxShStr(aSource)[0], bamSourceLength,
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    if CharsUsed = 0 then
      nxRaiseLastOSError('TnxByteArrayMapper'+'.'+'ToNullStringConvertCheck'+'/'+'MultiByteToWideChar');

    CharsUsed := WideCharToMultiByte(bamTargetCodepage, 0,
      @Buffer, CharsUsed,
      @aTarget, Pred(bamTargetLength),
      nil, nil);

    if CharsUsed = 0 then
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then
        Result := DBIERR_INVALIDFLDXFORM
      else
        nxRaiseLastOSError('TnxByteArrayMapper'+'.'+'ToNullStringConvertCheck'+'/'+'WideCharToMultiByte');

    PAnsiChar(@aTarget)[CharsUsed] := #0;
  end;
end;
{------------------------------------------------------------------------------}
function TnxByteArrayMapper.ToShortString(const aSource;
                                            var aTarget): TnxResult;
begin
  nxMove(aSource, TnxShStr(aTarget)[1], Min(bamSourceLength, Pred(bamTargetLength)));
  Byte(aTarget) := Byte(Min(bamSourceLength, Pred(bamTargetLength)));
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxByteArrayMapper.ToShortStringConvert(const aSource;
                                                   var aTarget): TnxResult;
var
  Buffer    : array[Byte] of WideChar;
  CharsUsed : Integer;
  i         : Integer;
begin
  Result := DBIERR_NONE;

  if TnxShStr(aSource)[0] = #0 then begin
    TnxShStr(aTarget)[0] := AnsiChar(0);
  end else begin

    CharsUsed := MultiByteToWideChar(bamSourceCodepage, 0,
      @TnxShStr(aSource)[0], bamSourceLength,
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    if CharsUsed = 0 then
      nxRaiseLastOSError('TnxByteArrayMapper'+'.'+'ToShortStringConvert'+'/'+'MultiByteToWideChar');

    if CharsUsed >= bamTargetLength then
      CharsUsed := Pred(bamTargetLength);

    i := WideCharToMultiByte(bamTargetCodepage, 0,
      @Buffer, CharsUsed,
      @TnxShStr(aTarget)[1], Pred(bamTargetLength),
      nil, nil);

    while i = 0 do
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then begin

        Dec(CharsUsed);
        if CharsUsed = 0 then
          break;

        i := WideCharToMultiByte(bamTargetCodepage, 0,
          @Buffer, CharsUsed,
          @TnxShStr(aTarget)[1], Pred(bamTargetLength),
          nil, nil);

      end else
        nxRaiseLastOSError('TnxByteArrayMapper'+'.'+'ToShortStringConvert'+'/'+'WideCharToMultiByte');

    TnxShStr(aTarget)[0] := AnsiChar(i);
  end;
end;
{------------------------------------------------------------------------------}
function TnxByteArrayMapper.ToShortStringConvertCheck(const aSource;
                                                        var aTarget): TnxResult;
var
  Buffer    : array[Byte] of WideChar;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if TnxShStr(aSource)[0] = #0 then begin
    TnxShStr(aTarget)[0] := AnsiChar(0);
  end else begin

    CharsUsed := MultiByteToWideChar(bamSourceCodepage, 0,
      @TnxShStr(aSource)[0], bamSourceLength,
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    if CharsUsed = 0 then
      nxRaiseLastOSError('TnxByteArrayMapper'+'.'+'ToShortStringConvertCheck'+'/'+'MultiByteToWideChar');

    CharsUsed := WideCharToMultiByte(bamTargetCodepage, 0,
      @Buffer, CharsUsed,
      @TnxShStr(aTarget)[1], Pred(bamTargetLength),
      nil, nil);

    if CharsUsed = 0 then
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then
        Result := DBIERR_INVALIDFLDXFORM
      else
        nxRaiseLastOSError('TnxByteArrayMapper'+'.'+'ToShortStringConvertCheck'+'/'+'WideCharToMultiByte');

    TnxShStr(aTarget)[0] := AnsiChar(CharsUsed);
  end;
end;
{------------------------------------------------------------------------------}
function TnxByteArrayMapper.ToWideString(const aSource;
                                           var aTarget): TnxResult;
var
  Buffer    : array[Word] of WideChar;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if PAnsiChar(@aSource)[0] = #0 then begin
    PWideChar(@aTarget)[0] := #0;
  end else begin
    CharsUsed := MultiByteToWideChar(bamSourceCodepage, 0,
      @aSource, bamSourceLength,
      @aTarget, Pred(bamTargetLength div SizeOf(WideChar)));

    if CharsUsed = 0 then
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then begin

        CharsUsed := MultiByteToWideChar(bamSourceCodepage, 0,
          @aSource, StrLen(PAnsiChar(@aSource)),
          @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

        if CharsUsed = 0 then
          nxRaiseLastOSError('TnxByteArrayMapper'+'.'+'ToWideString'+'/'+'MultiByteToWideChar');

        CharsUsed := nxMinI32(CharsUsed, Pred(bamTargetLength div SizeOf(WideChar)));

        nxMove(Buffer, aTarget, CharsUsed * SizeOf(WideChar));
      end else
        nxRaiseLastOSError('TnxByteArrayMapper'+'.'+'ToWideString'+'/'+'MultiByteToWideChar');

    PWideChar(@aTarget)[CharsUsed] := #0;
  end;
end;
{------------------------------------------------------------------------------}
function TnxByteArrayMapper.ToWideStringCheck(const aSource;
                                                var aTarget): TnxResult;
var
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if PAnsiChar(@aSource)[0] = #0 then begin
    PWideChar(@aTarget)[0] := #0;
  end else begin
    CharsUsed := MultiByteToWideChar(bamSourceCodepage, 0,
      @aSource, bamSourceLength,
      @aTarget, Pred(bamTargetLength div SizeOf(WideChar)));

    if CharsUsed = 0 then
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then
        Result := DBIERR_INVALIDFLDXFORM
      else
        nxRaiseLastOSError('TnxByteArrayMapper'+'.'+'ToWideStringCheck'+'/'+'MultiByteToWideChar');

    PWideChar(@aTarget)[CharsUsed] := #0;
  end;
end;
{==============================================================================}

function TnxShortStringToNullStringMapper.ToNullStringConvertCheckPadding(
  const aSource; var aTarget): TnxResult;
var
  Buffer    : array[Byte] of WideChar;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if TnxShStr(aSource)[0] = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin

    CharsUsed := MultiByteToWideChar(stnSourceCodepage, 0,
      @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]),
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    if CharsUsed = 0 then
      nxRaiseLastOSError('TnxShortStringToNullStringMapper'+'.'+'ToNullStringConvertCheck'+'/'+'MultiByteToWideChar');

    while (CharsUsed > 0) and (Buffer[Pred(CharsUsed)] = ' ') do
      Dec(CharsUsed);

    if CharsUsed > 0 then begin
      CharsUsed := WideCharToMultiByte(stnTargetCodepage, 0,
        @Buffer, CharsUsed,
        @aTarget, Pred(stnTargetLength),
        nil, nil);

      if CharsUsed = 0 then
        if GetLastError = ERROR_INSUFFICIENT_BUFFER then
          Result := DBIERR_INVALIDFLDXFORM
        else
          nxRaiseLastOSError('TnxShortStringToNullStringMapper'+'.'+'ToNullStringConvertCheck'+'/'+'WideCharToMultiByte');
    end else
      CharsUsed := 0;

    PAnsiChar(@aTarget)[CharsUsed] := #0;
  end;
end;

function TnxShortStringToNullStringMapper.ToNullStringConvertPadding(const aSource; var aTarget): TnxResult;
var
  Buffer    : array[Byte] of WideChar;
  CharsUsed : Integer;
  i         : Integer;
begin
  Result := DBIERR_NONE;

  if TnxShStr(aSource)[0] = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin

    CharsUsed := MultiByteToWideChar(stnSourceCodepage, 0,
      @TnxShStr(aSource)[1], Byte(TnxShStr(aSource)[0]),
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    if CharsUsed = 0 then
      nxRaiseLastOSError('TnxShortStringToNullStringMapper'+'.'+'ToNullStringConvertCheck'+'/'+'MultiByteToWideChar');

    if CharsUsed >= stnTargetLength then
      CharsUsed := Pred(stnTargetLength);

    while (CharsUsed > 0) and (Buffer[Pred(CharsUsed)] = ' ') do
      Dec(CharsUsed);

    if CharsUsed > 0 then begin
      i := WideCharToMultiByte(stnTargetCodepage, 0,
        @Buffer, CharsUsed,
        @aTarget, Pred(stnTargetLength),
        nil, nil);

      while i = 0 do
        if GetLastError = ERROR_INSUFFICIENT_BUFFER then begin

          Dec(CharsUsed);
          if CharsUsed = 0 then
            break;

          i := WideCharToMultiByte(stnTargetCodepage, 0,
            @Buffer, CharsUsed,
            @aTarget, Pred(stnTargetLength),
            nil, nil);

        end else
          nxRaiseLastOSError('TnxShortStringToNullStringMapper'+'.'+'ToNullStringConvertCheck'+'/'+'WideCharToMultiByte');
    end else
      i := 0;

    PAnsiChar(@aTarget)[i] := #0;
  end;
end;

function TnxShortStringToNullStringMapper.ToNullStringPadding(const aSource; var aTarget): TnxResult;
var
  LenToUse : Integer;
begin
  LenToUse := nxMinI32(Ord(TnxShStr(aSource)[0]), Pred(stnTargetLength));

  while (LenToUse > 0) and (TnxShStr(aTarget)[LenToUse] = ' ') do
    Dec(LenToUse);

  if LenToUse > 0 then
    nxMove(TnxShStr(aSource)[1], aTarget, LenToUse);

  PAnsiChar(@aTarget)[LenToUse] := #0;
  Result := DBIERR_NONE;
end;

function TnxShortStringToNullStringMapper.ToNullStringTruncCheckPadding(
  const aSource; var aTarget): TnxResult;
var
  LenToUse : Integer;
begin
  LenToUse := Ord(TnxShStr(aSource)[0]);

  while (LenToUse > 0) and (TnxShStr(aTarget)[LenToUse] = ' ') do
    Dec(LenToUse);

  if LenToUse >= stnTargetLength then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    if LenToUse > 0 then
      nxMove(TnxShStr(aSource)[1], aTarget, LenToUse);
    PAnsiChar(@aTarget)[LenToUse] := #0;
    Result := DBIERR_NONE;
  end;
end;

function TnxNullStringToNullStringMapper.ToNullStringConvertCheckPadding(const aSource; var aTarget): TnxResult;
var
  Buffer    : array[Word] of WideChar;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if PAnsiChar(@aSource)[0] = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin

    CharsUsed := MultiByteToWideChar(ntnSourceCodepage, 0,
      @aSource, StrLen(PAnsiChar(@aSource)),
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    if CharsUsed = 0 then
      nxRaiseLastOSError('TnxNullStringToNullStringMapper'+'.'+'ToNullStringConvertCheck'+'/'+'MultiByteToWideChar');

    while (CharsUsed > 0) and (Buffer[Pred(CharsUsed)] = ' ') do
      Dec(CharsUsed);

    if CharsUsed > 0 then begin
      CharsUsed := WideCharToMultiByte(ntnTargetCodepage, 0,
        @Buffer, CharsUsed,
        @aTarget, Pred(ntnTargetLength),
        nil, nil);

      if CharsUsed = 0 then
        if GetLastError = ERROR_INSUFFICIENT_BUFFER then
          Result := DBIERR_INVALIDFLDXFORM
        else
          nxRaiseLastOSError('TnxNullStringToNullStringMapper'+'.'+'ToNullStringConvertCheck'+'/'+'WideCharToMultiByte');
    end;

    PAnsiChar(@aTarget)[CharsUsed] := #0;
  end;
end;

function TnxNullStringToNullStringMapper.ToNullStringConvertPadding(const aSource; var aTarget): TnxResult;
var
  Buffer    : array[Word] of WideChar;
  CharsUsed : Integer;
  i         : Integer;
begin
  Result := DBIERR_NONE;

  if PAnsiChar(@aSource)[0] = #0 then begin
    PAnsiChar(@aTarget)[0] := #0;
  end else begin

    CharsUsed := MultiByteToWideChar(ntnSourceCodepage, 0,
      @aSource, StrLen(PAnsiChar(@aSource)),
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    if CharsUsed = 0 then
      nxRaiseLastOSError('TnxNullStringToNullStringMapper'+'.'+'ToNullStringConvertCheck'+'/'+'MultiByteToWideChar');

    if CharsUsed >= ntnTargetLength then
      CharsUsed := Pred(ntnTargetLength);

    while (CharsUsed > 0) and (Buffer[Pred(CharsUsed)] = ' ') do
      Dec(CharsUsed);

    if CharsUsed > 0 then begin
      i := WideCharToMultiByte(ntnTargetCodepage, 0,
        @Buffer, CharsUsed,
        @aTarget, Pred(ntnTargetLength),
        nil, nil);

      while i = 0 do
        if GetLastError = ERROR_INSUFFICIENT_BUFFER then begin

          Dec(CharsUsed);
          if CharsUsed = 0 then
            break;

          i := WideCharToMultiByte(ntnTargetCodepage, 0,
            @Buffer, CharsUsed,
            @aTarget, Pred(ntnTargetLength),
            nil, nil);

        end else
          nxRaiseLastOSError('TnxNullStringToNullStringMapper'+'.'+'ToNullStringConvertCheck'+'/'+'WideCharToMultiByte');
    end else
      i := 0;

    PAnsiChar(@aTarget)[i] := #0;
  end;
end;

function TnxNullStringToNullStringMapper.ToNullStringPadding(const aSource; var aTarget): TnxResult;
var
  LenToUse : Integer;
begin
  LenToUse := nxMinI32(StrLen(PAnsiChar(@aSource)), Pred(ntnTargetLength));
  while (LenToUse > 0) and (PAnsiChar(@aSource)[Pred(LenToUse)] = ' ') do
    Dec(LenToUse);
  StrLCopy(PAnsiChar(@aTarget), PAnsiChar(@aSource), LenToUse);
  Result := DBIERR_NONE;
end;

function TnxNullStringToNullStringMapper.ToNullStringTruncCheckPadding(const aSource; var aTarget): TnxResult;
var
  LenToUse : Integer;
begin
  LenToUse := StrLen(PAnsiChar(@aSource));
  while (LenToUse > 0) and (PAnsiChar(@aSource)[Pred(LenToUse)] = ' ') do
    Dec(LenToUse);

  if LenToUse >= ntnTargetLength then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    if LenToUse > 0 then
      nxMove(aSource, aTarget, LenToUse);
    PAnsiChar(@aTarget)[LenToUse] := #0;
    Result := DBIERR_NONE;
  end;
end;

function TnxNullStringToShortStringMapper.ToShortStringConvertCheckPadding(
  const aSource; var aTarget): TnxResult;
var
  Buffer    : array[Word] of WideChar;
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if PAnsiChar(@aSource)[0] = #0 then begin
    TnxShStr(aTarget)[0] := AnsiChar(0);
  end else begin

    CharsUsed := MultiByteToWideChar(ntsSourceCodepage, 0,
      @aSource, StrLen(PAnsiChar(@aSource)),
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    if CharsUsed = 0 then
      nxRaiseLastOSError('TnxNullStringToShortStringMapper'+'.'+'ToShortStringConvertCheck'+'/'+'MultiByteToWideChar');

    while (CharsUsed > 0) and (Buffer[Pred(CharsUsed)] = ' ') do
      Dec(CharsUsed);

    if CharsUsed > 0 then begin
      CharsUsed := WideCharToMultiByte(ntsTargetCodepage, 0,
        @Buffer, CharsUsed,
        @TnxShStr(aTarget)[1], Pred(ntsTargetLength),
        nil, nil);

      if CharsUsed = 0 then
        if GetLastError = ERROR_INSUFFICIENT_BUFFER then
          Result := DBIERR_INVALIDFLDXFORM
        else
          nxRaiseLastOSError('TnxNullStringToShortStringMapper'+'.'+'ToShortStringConvertCheck'+'/'+'WideCharToMultiByte');
    end;

    TnxShStr(aTarget)[0] := AnsiChar(CharsUsed);
  end;
end;

function TnxNullStringToShortStringMapper.ToShortStringConvertPadding(
  const aSource; var aTarget): TnxResult;
var
  Buffer    : array[Word] of WideChar;
  CharsUsed : Integer;
  i         : Integer;
begin
  Result := DBIERR_NONE;

  if PAnsiChar(@aSource)[0] = #0 then begin
    TnxShStr(aTarget)[0] := AnsiChar(0);
  end else begin

    CharsUsed := MultiByteToWideChar(ntsSourceCodepage, 0,
      @aSource, StrLen(PAnsiChar(@aSource)),
      @Buffer, SizeOf(Buffer) div SizeOf(WideChar));

    if CharsUsed = 0 then
      nxRaiseLastOSError('TnxNullStringToShortStringMapper'+'.'+'ToShortStringConvertCheck'+'/'+'MultiByteToWideChar');

    if CharsUsed >= ntsTargetLength then
      CharsUsed := Pred(ntsTargetLength);

    while (CharsUsed > 0) and (Buffer[Pred(CharsUsed)] = ' ') do
      Dec(CharsUsed);

    if CharsUsed > 0 then begin
      i := WideCharToMultiByte(ntsTargetCodepage, 0,
        @Buffer, CharsUsed,
        @TnxShStr(aTarget)[1], Pred(ntsTargetLength),
        nil, nil);

      while i = 0 do
        if GetLastError = ERROR_INSUFFICIENT_BUFFER then begin

          Dec(CharsUsed);
          if CharsUsed = 0 then
            break;

          i := WideCharToMultiByte(ntsTargetCodepage, 0,
            @Buffer, CharsUsed,
            @TnxShStr(aTarget)[1], Pred(ntsTargetLength),
            nil, nil);

        end else
          nxRaiseLastOSError('TnxNullStringToShortStringMapper'+'.'+'ToShortStringConvertCheck'+'/'+'WideCharToMultiByte');
    end else
      i := 0;

    TnxShStr(aTarget)[0] := AnsiChar(i);
  end;
end;

function TnxNullStringToShortStringMapper.ToShortStringPadding(const aSource; var aTarget): TnxResult;
var
  LenToUse : Integer;
begin
  LenToUse := nxMinI32(StrLen(PAnsiChar(@aSource)), Pred(ntsTargetLength));
  while (LenToUse > 0) and (PAnsiChar(@aSource)[Pred(LenToUse)] = ' ') do
    Dec(LenToUse);
  if LenToUse > 0 then
    nxMove(aSource, TnxShStr(aTarget)[1], LenToUse);
  TnxShStr(aTarget)[0] := AnsiChar(LenToUse);
  Result := DBIERR_NONE;
end;

function TnxNullStringToShortStringMapper.ToShortStringTruncCheckPadding(
  const aSource; var aTarget): TnxResult;
var
  LenToUse : Integer;
begin
  LenToUse := StrLen(PAnsiChar(@aSource));
  while (LenToUse > 0) and (PAnsiChar(@aSource)[Pred(LenToUse)] = ' ') do
    Dec(LenToUse);
  if LenToUse >= ntsTargetLength then
    Result := DBIERR_INVALIDFLDXFORM
  else begin
    if LenToUse > 0 then
      nxMove(aSource, TnxShStr(aTarget)[1], LenToUse);
    TnxShStr(aTarget)[0] := AnsiChar(LenToUse);
    Result := DBIERR_NONE;
  end;
end;

function TnxWideStringToAnsiStringMapper.ToShortStringConvertCheckPadding(
  const aSource; var aTarget): TnxResult;
var
  CharsUsed : Integer;
begin
  Result := DBIERR_NONE;

  if PWideChar(@aSource)[0] = #0 then begin
    TnxShStr(aTarget)[0] := AnsiChar(0);
  end else begin

    CharsUsed := lstrlenW(@aSource);

    while (CharsUsed > 0) and (PWideChar(@aSource)[Pred(CharsUsed)] = ' ') do
      Dec(CharsUsed);

    CharsUsed := WideCharToMultiByte(wtaTargetCodepage, 0,
      @aSource, CharsUsed,
      @TnxShStr(aTarget)[1], Pred(wtaTargetLength),
      nil, nil);

    if CharsUsed = 0 then
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then
        Result := DBIERR_INVALIDFLDXFORM
      else
        nxRaiseLastOSError('TnxWideStringToAnsiStringMapper'+'.'+'ToShortStringConvertCheck'+'/'+'WideCharToMultiByte');

    TnxShStr(aTarget)[0] := AnsiChar(CharsUsed);
  end;
end;

function TnxWideStringToAnsiStringMapper.ToShortStringConvertPadding(const aSource; var aTarget): TnxResult;
var
  CharsUsed : Integer;
  i         : Integer;
begin
  Result := DBIERR_NONE;

  if PWideChar(@aSource)[0] = #0 then begin
    TnxShStr(aTarget)[0] := AnsiChar(0);
  end else begin

    CharsUsed := lstrlenW(@aSource);

    if CharsUsed >= wtaTargetLength then
      CharsUsed := Pred(wtaTargetLength);

    while (CharsUsed > 0) and (PWideChar(@aSource)[Pred(CharsUsed)] = ' ') do
      Dec(CharsUsed);

    if CharsUsed > 0 then begin
      i := WideCharToMultiByte(wtaTargetCodepage, 0,
        @aSource, CharsUsed,
        @TnxShStr(aTarget)[1], Pred(wtaTargetLength),
        nil, nil);

      while i = 0 do
        if GetLastError = ERROR_INSUFFICIENT_BUFFER then begin

          Dec(CharsUsed);
          if CharsUsed = 0 then
            break;

          i := WideCharToMultiByte(wtaTargetCodepage, 0,
            @aSource, CharsUsed,
            @TnxShStr(aTarget)[1], Pred(wtaTargetLength),
            nil, nil);

        end else
          nxRaiseLastOSError('TnxWideStringToAnsiStringMapper'+'.'+'ToShortStringConvert'+'/'+'WideCharToMultiByte');
    end else
      i := 0;

    TnxShStr(aTarget)[0] := AnsiChar(i);
  end;
end;

function TnxWideStringToWideStringMapper.ToWideStringTruncPadding(
  const aSource; var aTarget): TnxResult;
var
  Units : Integer;
begin
  Units := nxMinI32(lstrlenW(PWideChar(@aSource)), wtwTargetUnits);
  while (Units > 0) and (PWideChar(@aSource)[Pred(Units)] = ' ') do
    Dec(Units);
  if Units > 0 then
    nxMove(aSource, aTarget, Units * SizeOf(WideChar));
  PWideChar(@aTarget)[Units] := #0;
  Result := DBIERR_NONE;
end;

{ TnxFmtBCDMapper }

constructor TnxFmtBCDMapper.Create(aSourceField : TnxFieldDescriptor;
                                   aTargetField : TnxFieldDescriptor;
                                   aMapperDesc  : TnxFieldMapperDescriptor;
                               out aMapper      : TnxMappingMethod);
var
  IsUnchanged : Boolean;
begin
  inherited Create;

  fbmSourceType := aSourceField.fdType;
  fbmSourceLength := aSourceField.fdLength;
  fbmSourceUnits := aSourceField.fdUnits;
  fbmSourceDecPl := aSourceField.fdDecPl;
  if Assigned(aSourceField.UsedLocaleDescriptor) then
    GetLocaleFormatSettings(aSourceField.UsedLocaleDescriptor.Locale, fbmSourceFormatSettings)
  else
    GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, fbmSourceFormatSettings);

  fbmTargetType := aTargetField.fdType;
  fbmTargetLength := aTargetField.fdLength;
  fbmTargetUnits := aTargetField.fdUnits;
  fbmTargetDecPl := aTargetField.fdDecPl;
  if Assigned(aTargetField.UsedLocaleDescriptor) then
    GetLocaleFormatSettings(aTargetField.UsedLocaleDescriptor.Locale, fbmTargetFormatSettings)
  else
    GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, fbmTargetFormatSettings);

  IsUnchanged :=
        (fbmSourceType   = fbmTargetType)
    and (fbmSourceLength = fbmTargetLength)
    and (fbmSourceUnits  = fbmTargetUnits)
    and (fbmSourceDecPl  = fbmTargetDecPl);

  case fbmSourceType of
    nxtCurrency,
    nxtBCD:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := FromBCDTrunc
      else
        aMapper := FromBCDCheck;
    nxtSingle, nxtDouble, nxtExtended: begin
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := FromFloatTrunc
      else
        aMapper := FromFloatCheck;
    end;
    nxtInt8,
    nxtInt16,
    nxtInt32,
    nxtInt64,
    nxtByte,
    nxtWord16,
    nxtAutoinc,
    nxtRecRev,
    nxtWord32:
      if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
        aMapper := FromIntegerTrunc
      else
        aMapper := FromIntegerCheck;
    nxtFmtBCD:
      case fbmTargetType of
        nxtFmtBCD:
          if IsUnchanged then
            aMapper := ToFmtBCDCopy
          else if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
            aMapper := ToFmtBCDTrunc
          else
            aMapper := ToFmtBCDCheck;
        nxtCurrency,
        nxtBCD:
          if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
            aMapper := ToBcdTrunc
          else
            aMapper := ToBcdCheck;
        nxtSingle,
        nxtDouble,
        nxtExtended:
          if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
            aMapper := ToFloatTrunc
          else
            aMapper := ToFloatCheck;
        nxtInt8,
        nxtInt16,
        nxtInt32,
        nxtInt64,
        nxtByte,
        nxtWord16,
        nxtAutoinc,
        nxtRecRev,
        nxtWord32: begin
          case fbmTargetType of
            nxtInt8: begin
              fbmTargetMinInt := Low(TnxInt8);
              fbmTargetMaxInt := High(TnxInt8);
            end;
            nxtInt16: begin
              fbmTargetMinInt := Low(TnxInt16);
              fbmTargetMaxInt := High(TnxInt16);
            end;
            nxtInt32: begin
              fbmTargetMinInt := Low(TnxInt32);
              fbmTargetMaxInt := High(TnxInt32);
            end;
            nxtInt64: begin
              fbmTargetMinInt := Low(TnxInt64);
              fbmTargetMaxInt := High(TnxInt64);
            end;
            nxtByte: begin
              fbmTargetMinInt := Low(TnxByte8);
              fbmTargetMaxInt := High(TnxByte8);
            end;
            nxtWord16: begin
              fbmTargetMinInt := Low(TnxWord16);
              fbmTargetMaxInt := High(TnxWord16);
            end;
            nxtAutoinc, nxtRecRev, nxtWord32: begin
              fbmTargetMinInt := Low(TnxWord32);
              fbmTargetMaxInt := High(TnxWord32);
            end;
          end;
          if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
            aMapper := ToIntegerTrunc
          else
            aMapper := ToIntegerCheck;
        end;
        {nxtBcd:
          if aTargetField.fdUnits = 20 then
            aMapper := ToCurrency
          else if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
            aMapper := ToBcdTrunc
          else
            aMapper := ToBcdCheck;
        nxtChar:
          if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
            aMapper := ToAnsiChar
          else
            aMapper := ToAnsiCharCheck;
        nxtWideChar:
          if (assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) then
            aMapper := ToWideChar
          else
            aMapper := ToWideCharCheck;
        nxtNullString:
          if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
             (cmTargetLength > Length(nxFloatToAnsiStr(MinCurrency, cmFormatSettings)))  then
            aMapper := ToNullString
          else
            aMapper := ToNullStringCheck;
        nxtShortString:
          if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
             (cmTargetLength > Length(nxFloatToAnsiStr(MinCurrency, cmFormatSettings)))  then
            aMapper := ToShortString
          else
            aMapper := ToShortStringCheck;
        nxtWideString:
          if (Assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit)) or
             (cmTargetLength div SizeOf(WideChar) > Length(nxFloatToAnsiStr(MinCurrency, cmFormatSettings)))  then
            aMapper := ToWideString
          else
            aMapper := ToWideStringCheck;}
      end;
  end;
end;

function TnxFmtBCDMapper.FromBcdCheck(const aSource; var aTarget): TnxResult;
var
  Source : TnxFmtBcd;
  Target : TnxFmtBcd;
  Info   : TnxBcdTruncInfos;
begin
  Result := DBIERR_NONE;

  nxFillChar(Source, SizeOf(Source), 0);
  nxFillChar(Target, SizeOf(Target), 0);

  nxCurrencyToFmtBcd(TnxCurrency(aSource), Source);
  Info := nxNormalizeBcd(Source, Target, fbmTargetUnits, fbmTargetDecPl);
  if Info <> nxNoTrunc then
    Result := DBIERR_INVALIDFLDXFORM
  else
    nxMove(Target, aTarget, fbmTargetLength);
end;

function TnxFmtBCDMapper.FromBcdTrunc(const aSource; var aTarget): TnxResult;
var
  Source : TnxFmtBcd;
  Target : TnxFmtBcd;
begin
  Result := DBIERR_NONE;

  nxFillChar(Source, SizeOf(Source), 0);
  nxFillChar(Target, SizeOf(Target), 0);

  nxCurrencyToFmtBcd(TnxCurrency(aSource), Source);
  nxNormalizeBcd(Source, Target, fbmTargetUnits, fbmTargetDecPl);
  nxMove(Target, aTarget, fbmTargetLength);
end;

function TnxFmtBCDMapper.FromFloatCheck(const aSource; var aTarget): TnxResult;
var
  r      : TFloatRec;
  Source : TnxFmtBcd;
  Target : TnxFmtBcd;
  Info   : TnxBcdTruncInfos;
begin
  Result := DBIERR_NONE;

  nxFillChar(Source, SizeOf(Source), 0);
  nxFillChar(Target, SizeOf(Target), 0);

  case fbmSourceType of
    nxtSingle: Source := nxDoubleToFmtBcd(TnxSingle(aSource));
    nxtDouble: Source := nxDoubleToFmtBcd(TnxDouble(aSource));
    nxtExtended: begin
      FloatToDecimal(r, TnxExtended(aSource), fvExtended, 19, 64);
      nxFloatRecToFmtBCD(r, Source);
    end;
  else
    Assert(False);
  end;

  Info := nxNormalizeBcd(Source, Target, fbmTargetUnits, fbmTargetDecPl);
  if Info <> nxNoTrunc then
    Result := DBIERR_INVALIDFLDXFORM
  else
    nxMove(Target, aTarget, fbmTargetLength);
end;

function TnxFmtBCDMapper.FromFloatTrunc(const aSource; var aTarget): TnxResult;
var
  r      : TFloatRec;
  Source : TnxFmtBcd;
  Target : TnxFmtBcd;
begin
  Result := DBIERR_NONE;

  nxFillChar(Source, SizeOf(Source), 0);
  nxFillChar(Target, SizeOf(Target), 0);

  case fbmSourceType of
    nxtSingle: Source := nxDoubleToFmtBcd(TnxSingle(aSource));
    nxtDouble: Source := nxDoubleToFmtBcd(TnxDouble(aSource));
    nxtExtended: begin
      FloatToDecimal(r, TnxExtended(aSource), fvExtended, 19, 64);
      nxFloatRecToFmtBCD(r, Source);
    end;
  else
    Assert(False);
  end;

  nxNormalizeBcd(Source, Target, fbmTargetUnits, fbmTargetDecPl);
  nxMove(Target, aTarget, fbmTargetLength);
end;

function TnxFmtBCDMapper.FromIntegerCheck(const aSource; var aTarget): TnxResult;
var
  i      : Int64;
  Source : TnxFmtBcd;
  Target : TnxFmtBcd;
  Info   : TnxBcdTruncInfos;
begin
  Result := DBIERR_NONE;

  nxFillChar(Source, SizeOf(Source), 0);
  nxFillChar(Target, SizeOf(Target), 0);

  case fbmSourceType of
    nxtInt8: i := TnxInt8(aSource);
    nxtInt16: i := TnxInt16(aSource);
    nxtInt32: i := TnxInt32(aSource);
    nxtInt64: i := TnxInt64(aSource);
    nxtByte: i := TnxByte8(aSource);
    nxtWord16: i := TnxWord16(aSource);
    nxtAutoinc,
    nxtRecRev,
    nxtWord32: i := TnxWord32(aSource);
  else
    Result := DBIERR_INVALIDFLDXFORM;
    Exit;
  end;
  Source := nxStrToFmtBcd(AnsiString(IntToStr(i)));

  Info := nxNormalizeBcd(Source, Target, fbmTargetUnits, fbmTargetDecPl);
  if Info <> nxNoTrunc then
    Result := DBIERR_INVALIDFLDXFORM
  else
    nxMove(Target, aTarget, fbmTargetLength);
end;

function TnxFmtBCDMapper.FromIntegerTrunc(const aSource; var aTarget): TnxResult;
var
  i      : Int64;
  Source : TnxFmtBcd;
  Target : TnxFmtBcd;
begin
  Result := DBIERR_NONE;

  nxFillChar(Source, SizeOf(Source), 0);
  nxFillChar(Target, SizeOf(Target), 0);

  case fbmSourceType of
    nxtInt8: i := TnxInt8(aSource);
    nxtInt16: i := TnxInt16(aSource);
    nxtInt32: i := TnxInt32(aSource);
    nxtInt64: i := TnxInt64(aSource);
    nxtByte: i := TnxByte8(aSource);
    nxtWord16: i := TnxWord16(aSource);
    nxtAutoinc,
    nxtRecRev,
    nxtWord32: i := TnxWord32(aSource);
  else
    Result := DBIERR_INVALIDFLDXFORM;
    Exit;
  end;
  Source := nxStrToFmtBcd(AnsiString(IntToStr(i)));

  nxNormalizeBcd(Source, Target, fbmTargetUnits, fbmTargetDecPl);
  nxMove(Target, aTarget, fbmTargetLength);
end;

class function TnxFmtBCDMapper.InternalCreateMapper(aSourceField  : TnxFieldDescriptor;
                                                    aSourceCursor : TnxAbstractCursor;
                                                    aTargetField  : TnxFieldDescriptor;
                                                    aTargetCursor : TnxAbstractCursor;
                                                    aMapperDesc   : TnxFieldMapperDescriptor;
                                                out aMapper       : TnxMappingMethod)
                                                                  : TnxBaseFieldMapper;
begin
  aMapper := nil;
  Result := nil;
  case aSourceField.fdType of
    nxtCurrency,
    nxtBCD,
    nxtSingle,
    nxtDouble,
    nxtExtended,
    nxtInt8,
    nxtInt16,
    nxtInt32,
    nxtInt64,
    nxtByte,
    nxtWord16,
    nxtAutoinc,
    nxtRecRev,
    nxtWord32: Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
    nxtFmtBCD:
      case aTargetField.fdType of
  {
        nxtBoolean:
          if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
            aMapper := ToBoolean
          else
            aMapper := ToBooleanCheck;
        nxtInt8 :
          if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
            aMapper := ToInt8
          else
            aMapper := ToInt8Check;
        nxtInt16:
          if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
            aMapper := ToInt16
          else
            aMapper := ToInt16Check;
        nxtInt32:
          if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
            aMapper := ToInt32
          else
            aMapper := ToInt32Check;
        nxtInt64:
          if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
            aMapper := ToInt64
          else
            aMapper := ToInt64Check;
        nxtByte:
          if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
            aMapper := ToByte8
          else
            aMapper := ToByteCheck;
        nxtWord16:
          if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
            aMapper := ToWord16
          else
            aMapper := ToWord16Check;
        nxtWord32, nxtAutoInc, nxtRecRev:
          if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
            aMapper := ToWord32
          else
            aMapper := ToWord32Check;
        nxtSingle   :
          if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
            aMapper := ToSingle
          else
            aMapper := ToSingleCheck;
        nxtDouble   :
          if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
            aMapper := ToDouble
          else
            aMapper := ToDoubleCheck;
        nxtExtended :
          if assigned(aMapperDesc) and (aMapperDesc.DataLossAction = dlaBestFit) then
            aMapper := ToExtended
          else
            aMapper := ToExtendedCheck;

        nxtCurrency : aMapper := ToCurrency;
        nxtBCD      : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);

        nxtByteArray:
          if aTargetField.fdUnits >= SizeOf(TnxCurrency) then
            aMapper := ToByteArray;

        nxtChar,
        nxtWideChar,
        nxtNullString,
        nxtShortString,
        nxtWideString   : Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
  }
        nxtCurrency,
        nxtBCD,
        nxtSingle,
        nxtDouble,
        nxtExtended,
        nxtInt8,
        nxtInt16,
        nxtInt32,
        nxtInt64,
        nxtByte,
        nxtWord16,
        nxtAutoinc,
        nxtRecRev,
        nxtWord32,
        nxtFmtBCD: Result := Create(aSourceField, aTargetField, aMapperDesc, aMapper);
      end;
  end;
end;

function TnxFmtBCDMapper.ToBcdCheck(const aSource; var aTarget): TnxResult;
var
  s: string;
  e: Extended;
  c: Currency;
  p: Integer;
begin
  Result := DBIERR_NONE;

  c := 0;
  try
    s := BcdToStr(TBcd(aSource){$IFDEF DCC15OrLater}, nxInvariantFormatSettings{$ENDIF});
    e := StrToFloat(s, nxInvariantFormatSettings);
    if e > MaxCurrency then
      Result := DBIERR_INVALIDFLDXFORM
    else if e < MinCurrency then
      Result := DBIERR_INVALIDFLDXFORM
    else begin
      p := Pos(nxInvariantFormatSettings.DecimalSeparator, s);
      if (p > 0) and ((Length(s) - p) > 4) then
        Result := DBIERR_INVALIDFLDXFORM
      else
        c := StrToCurr(s, nxInvariantFormatSettings);
    end;
  except
    Result := DBIERR_INVALIDFLDXFORM;
  end;
  if Result = DBIERR_NONE then
    TnxCurrency(aTarget) := c;
end;

function TnxFmtBCDMapper.ToBcdTrunc(const aSource; var aTarget): TnxResult;
var
  s: string;
  c: Currency;
begin
  Result := DBIERR_NONE;

  c := 0;
  try
    s := BcdToStr(TBcd(aSource){$IFDEF DCC15OrLater}, nxInvariantFormatSettings{$ENDIF});
    c := StrToCurr(s, nxInvariantFormatSettings);
  except
    Result := DBIERR_INVALIDFLDXFORM;
  end;
  if Result = DBIERR_NONE then
    TnxCurrency(aTarget) := c;
end;

function TnxFmtBCDMapper.ToFloatCheck(const aSource; var aTarget): TnxResult;
var
  s     : string;
  e, e2 : Extended;
begin
  Result := DBIERR_NONE;

  e := 0;
  try
    s := BcdToStr(TBcd(aSource){$IFDEF DCC15OrLater}, nxInvariantFormatSettings{$ENDIF});
    e := StrToFloat(s, nxInvariantFormatSettings);
  except
    Result := DBIERR_INVALIDFLDXFORM;
  end;
  if Result = DBIERR_NONE then
    case fbmTargetType of
      nxtSingle: TnxSingle(aTarget) := e;
      nxtDouble: TnxDouble(aTarget) := e;
      {$IFNDEF FPC}
      nxtExtended: TnxExtended(aTarget) := e;
      {$ENDIF}
    else
      Result := DBIERR_INVALIDFLDXFORM;
    end;
  if Result = DBIERR_NONE then
    case fbmTargetType of
      nxtSingle: begin
        e2 := TnxSingle(aTarget);
        if not IsZero(e - e2, 1E-7) then
          Result := DBIERR_INVALIDFLDXFORM;
      end;
      nxtDouble: begin
        e2 := TnxDouble(aTarget);
        if not IsZero(e - e2, 1E-15) then
          Result := DBIERR_INVALIDFLDXFORM;
      end;
    end;
end;

function TnxFmtBCDMapper.ToFloatTrunc(const aSource; var aTarget): TnxResult;
var
  s: string;
  e: Extended;
begin
  Result := DBIERR_NONE;

  e := 0;
  try
    s := BcdToStr(TBcd(aSource){$IFDEF DCC15OrLater}, nxInvariantFormatSettings{$ENDIF});
    e := StrToFloat(s, nxInvariantFormatSettings);
  except
    Result := DBIERR_INVALIDFLDXFORM;
  end;
  if Result = DBIERR_NONE then
    case fbmTargetType of
      nxtSingle: TnxSingle(aTarget) := e;
      nxtDouble: TnxDouble(aTarget) := e;
      {$IFNDEF FPC}
      nxtExtended: TnxExtended(aTarget) := e;
      {$ENDIF}
    else
      Result := DBIERR_INVALIDFLDXFORM;
    end;
end;

function TnxFmtBCDMapper.ToFmtBcdCheck(const aSource; var aTarget): TnxResult;
var
  Source : TnxFmtBcd;
  Target : TnxFmtBcd;
  Info   : TnxBcdTruncInfos;
begin
  Result := DBIERR_NONE;

  nxFillChar(Source, SizeOf(Source), 0);
  nxFillChar(Target, SizeOf(Target), 0);
  nxMove(aSource, Source, fbmSourceLength);
  Info := nxNormalizeBcd(Source, Target, fbmTargetUnits, fbmTargetDecPl);
  if Info <> nxNoTrunc then
    Result := DBIERR_INVALIDFLDXFORM
  else
    nxMove(Target, aTarget, fbmTargetLength);
end;

function TnxFmtBCDMapper.ToFmtBcdCopy(const aSource; var aTarget): TnxResult;
begin
  Result := DBIERR_NONE;

  nxMove(aSource, aTarget, fbmTargetLength);
end;

function TnxFmtBCDMapper.ToFmtBcdTrunc(const aSource; var aTarget): TnxResult;
var
  Source : TnxFmtBcd;
  Target : TnxFmtBcd;
begin
  Result := DBIERR_NONE;

  nxFillChar(Source, SizeOf(Source), 0);
  nxFillChar(Target, SizeOf(Target), 0);
  nxMove(aSource, Source, fbmSourceLength);
  nxNormalizeBcd(Source, Target, fbmTargetUnits, fbmTargetDecPl);
  nxMove(Target, aTarget, fbmTargetLength);
end;

function TnxFmtBCDMapper.ToIntegerCheck(const aSource; var aTarget): TnxResult;
var
  s: string;
  p: Integer;
  i: Int64;
begin
  Result := DBIERR_NONE;

  i := 0;
  try
    s := BcdToStr(TBcd(aSource){$IFDEF DCC15OrLater}, nxInvariantFormatSettings{$ENDIF});
    p := Pos(nxInvariantFormatSettings.DecimalSeparator, s);
    if p > 0 then
      Result := DBIERR_INVALIDFLDXFORM
    else
      i := StrToInt64(s);
  except
    Result := DBIERR_INVALIDFLDXFORM;
  end;

  if Result = DBIERR_NONE then begin
    if i > fbmTargetMaxInt then
      Result := DBIERR_INVALIDFLDXFORM
    else if i < fbmTargetMinInt then
      Result := DBIERR_INVALIDFLDXFORM
    else case fbmTargetType of
      nxtInt8: TnxInt8(aTarget) := i;
      nxtInt16: TnxInt16(aTarget) := i;
      nxtInt32: TnxInt32(aTarget) := i;
      nxtInt64: TnxInt64(aTarget) := i;
      nxtByte: TnxByte8(aTarget) := i;
      nxtWord16: TnxWord16(aTarget) := i;
      nxtAutoinc,
      nxtRecRev,
      nxtWord32: TnxWord32(aTarget) := i;
    else
      Result := DBIERR_INVALIDFLDXFORM;
    end;
  end;
end;

function TnxFmtBCDMapper.ToIntegerTrunc(const aSource; var aTarget): TnxResult;
var
  s: string;
  p: Integer;
  i: Int64;
begin
  Result := DBIERR_NONE;

  i := 0;
  try
    s := BcdToStr(TBcd(aSource){$IFDEF DCC15OrLater}, nxInvariantFormatSettings{$ENDIF});
    p := Pos(nxInvariantFormatSettings.DecimalSeparator, s);
    if p > 0 then
      Delete(s, p, MaxInt);
    i := StrToInt64(s);
  except
    Result := DBIERR_INVALIDFLDXFORM;
  end;

  if Result = DBIERR_NONE then begin
    if i > fbmTargetMaxInt then
      i := fbmTargetMaxInt;
    if i < fbmTargetMinInt then
      i := fbmTargetMinInt;

    case fbmTargetType of
      nxtInt8: TnxInt8(aTarget) := i;
      nxtInt16: TnxInt16(aTarget) := i;
      nxtInt32: TnxInt32(aTarget) := i;
      nxtInt64: TnxInt64(aTarget) := i;
      nxtByte: TnxByte8(aTarget) := i;
      nxtWord16: TnxWord16(aTarget) := i;
      nxtAutoinc,
      nxtRecRev,
      nxtWord32: TnxWord32(aTarget) := i;
    else
      Result := DBIERR_INVALIDFLDXFORM;
    end;
  end;
end;

initialization
  {$IFDEF NX_PUBLICBETA}
  {$I PublicBeta\nxPublicBeta1.inc}
  {$ENDIF}

  TnxBooleanMapper.Register(nxtBoolean, nxtBoolean);
  TnxBooleanMapper.Register(nxtBoolean, nxtInt8);
  TnxBooleanMapper.Register(nxtBoolean, nxtInt16);
  TnxBooleanMapper.Register(nxtBoolean, nxtInt32);
  TnxBooleanMapper.Register(nxtBoolean, nxtInt64);
  TnxBooleanMapper.Register(nxtBoolean, nxtByte);
  TnxBooleanMapper.Register(nxtBoolean, nxtWord16);
  TnxBooleanMapper.Register(nxtBoolean, nxtWord32);
  TnxBooleanMapper.Register(nxtBoolean, nxtAutoInc);
  TnxBooleanMapper.Register(nxtBoolean, nxtRecRev);
  TnxBooleanMapper.Register(nxtBoolean, nxtSingle);
  TnxBooleanMapper.Register(nxtBoolean, nxtDouble);
  TnxBooleanMapper.Register(nxtBoolean, nxtExtended);
  TnxBooleanMapper.Register(nxtBoolean, nxtCurrency);
  TnxBooleanMapper.Register(nxtBoolean, nxtBCD);
  TnxBooleanMapper.Register(nxtBoolean, nxtByteArray);
  TnxBooleanMapper.Register(nxtBoolean, nxtChar);
  TnxBooleanMapper.Register(nxtBoolean, nxtWideChar);
  TnxBooleanMapper.Register(nxtBoolean, nxtNullString);
  TnxBooleanMapper.Register(nxtBoolean, nxtShortString);
  TnxBooleanMapper.Register(nxtBoolean, nxtWideString);

  TnxInt8Mapper.Register(nxtInt8, nxtBoolean);
  TnxInt8Mapper.Register(nxtInt8, nxtInt8);
  TnxInt8Mapper.Register(nxtInt8, nxtInt16);
  TnxInt8Mapper.Register(nxtInt8, nxtInt32);
  TnxInt8Mapper.Register(nxtInt8, nxtInt64);
  TnxInt8Mapper.Register(nxtInt8, nxtByte);
  TnxInt8Mapper.Register(nxtInt8, nxtWord16);
  TnxInt8Mapper.Register(nxtInt8, nxtWord32);
  TnxInt8Mapper.Register(nxtInt8, nxtAutoInc);
  TnxInt8Mapper.Register(nxtInt8, nxtRecRev);
  TnxInt8Mapper.Register(nxtInt8, nxtSingle);
  TnxInt8Mapper.Register(nxtInt8, nxtDouble);
  TnxInt8Mapper.Register(nxtInt8, nxtExtended);
  TnxInt8Mapper.Register(nxtInt8, nxtCurrency);
  TnxInt8Mapper.Register(nxtInt8, nxtBCD);
  TnxInt8Mapper.Register(nxtInt8, nxtByteArray);
  TnxInt8Mapper.Register(nxtInt8, nxtChar);
  TnxInt8Mapper.Register(nxtInt8, nxtWideChar);
  TnxInt8Mapper.Register(nxtInt8, nxtNullString);
  TnxInt8Mapper.Register(nxtInt8, nxtShortString);
  TnxInt8Mapper.Register(nxtInt8, nxtWideString);

  TnxInt16Mapper.Register(nxtInt16, nxtBoolean);
  TnxInt16Mapper.Register(nxtInt16, nxtInt8);
  TnxInt16Mapper.Register(nxtInt16, nxtInt16);
  TnxInt16Mapper.Register(nxtInt16, nxtInt32);
  TnxInt16Mapper.Register(nxtInt16, nxtInt64);
  TnxInt16Mapper.Register(nxtInt16, nxtByte);
  TnxInt16Mapper.Register(nxtInt16, nxtWord16);
  TnxInt16Mapper.Register(nxtInt16, nxtWord32);
  TnxInt16Mapper.Register(nxtInt16, nxtAutoInc);
  TnxInt16Mapper.Register(nxtInt16, nxtRecRev);
  TnxInt16Mapper.Register(nxtInt16, nxtSingle);
  TnxInt16Mapper.Register(nxtInt16, nxtDouble);
  TnxInt16Mapper.Register(nxtInt16, nxtExtended);
  TnxInt16Mapper.Register(nxtInt16, nxtCurrency);
  TnxInt16Mapper.Register(nxtInt16, nxtBCD);
  TnxInt16Mapper.Register(nxtInt16, nxtByteArray);
  TnxInt16Mapper.Register(nxtInt16, nxtChar);
  TnxInt16Mapper.Register(nxtInt16, nxtWideChar);
  TnxInt16Mapper.Register(nxtInt16, nxtNullString);
  TnxInt16Mapper.Register(nxtInt16, nxtShortString);
  TnxInt16Mapper.Register(nxtInt16, nxtWideString);

  TnxInt32Mapper.Register(nxtInt32, nxtBoolean);
  TnxInt32Mapper.Register(nxtInt32, nxtInt8);
  TnxInt32Mapper.Register(nxtInt32, nxtInt16);
  TnxInt32Mapper.Register(nxtInt32, nxtInt32);
  TnxInt32Mapper.Register(nxtInt32, nxtInt64);
  TnxInt32Mapper.Register(nxtInt32, nxtByte);
  TnxInt32Mapper.Register(nxtInt32, nxtWord16);
  TnxInt32Mapper.Register(nxtInt32, nxtWord32);
  TnxInt32Mapper.Register(nxtInt32, nxtAutoInc);
  TnxInt32Mapper.Register(nxtInt32, nxtRecRev);
  TnxInt32Mapper.Register(nxtInt32, nxtSingle);
  TnxInt32Mapper.Register(nxtInt32, nxtDouble);
  TnxInt32Mapper.Register(nxtInt32, nxtExtended);
  TnxInt32Mapper.Register(nxtInt32, nxtCurrency);
  TnxInt32Mapper.Register(nxtInt32, nxtBCD);
  TnxInt32Mapper.Register(nxtInt32, nxtByteArray);
  TnxInt32Mapper.Register(nxtInt32, nxtChar);
  TnxInt32Mapper.Register(nxtInt32, nxtWideChar);
  TnxInt32Mapper.Register(nxtInt32, nxtNullString);
  TnxInt32Mapper.Register(nxtInt32, nxtShortString);
  TnxInt32Mapper.Register(nxtInt32, nxtWideString);
  TnxInt32Mapper.Register(nxtInt32, nxtDateTime); //..

  TnxInt64Mapper.Register(nxtInt64, nxtBoolean);
  TnxInt64Mapper.Register(nxtInt64, nxtInt8);
  TnxInt64Mapper.Register(nxtInt64, nxtInt16);
  TnxInt64Mapper.Register(nxtInt64, nxtInt32);
  TnxInt64Mapper.Register(nxtInt64, nxtInt64);
  TnxInt64Mapper.Register(nxtInt64, nxtByte);
  TnxInt64Mapper.Register(nxtInt64, nxtWord16);
  TnxInt64Mapper.Register(nxtInt64, nxtWord32);
  TnxInt64Mapper.Register(nxtInt64, nxtAutoInc);
  TnxInt64Mapper.Register(nxtInt64, nxtRecRev);
  TnxInt64Mapper.Register(nxtInt64, nxtSingle);
  TnxInt64Mapper.Register(nxtInt64, nxtDouble);
  TnxInt64Mapper.Register(nxtInt64, nxtExtended);
  TnxInt64Mapper.Register(nxtInt64, nxtCurrency);
  TnxInt64Mapper.Register(nxtInt64, nxtBCD);
  TnxInt64Mapper.Register(nxtInt64, nxtByteArray);
  TnxInt64Mapper.Register(nxtInt64, nxtChar);
  TnxInt64Mapper.Register(nxtInt64, nxtWideChar);
  TnxInt64Mapper.Register(nxtInt64, nxtNullString);
  TnxInt64Mapper.Register(nxtInt64, nxtShortString);
  TnxInt64Mapper.Register(nxtInt64, nxtWideString);

  TnxInt64Mapper.Register(nxtRefNr, nxtRefNr);
  TnxInt64Mapper.Register(nxtRefNr, nxtInt64);
  TnxInt64Mapper.Register(nxtRefNr, nxtNullString);
  TnxInt64Mapper.Register(nxtRefNr, nxtShortString);
  TnxInt64Mapper.Register(nxtRefNr, nxtWideString);

  TnxByte8Mapper.Register(nxtByte, nxtBoolean);
  TnxByte8Mapper.Register(nxtByte, nxtInt8);
  TnxByte8Mapper.Register(nxtByte, nxtInt16);
  TnxByte8Mapper.Register(nxtByte, nxtInt32);
  TnxByte8Mapper.Register(nxtByte, nxtInt64);
  TnxByte8Mapper.Register(nxtByte, nxtByte);
  TnxByte8Mapper.Register(nxtByte, nxtWord16);
  TnxByte8Mapper.Register(nxtByte, nxtWord32);
  TnxByte8Mapper.Register(nxtByte, nxtAutoInc);
  TnxByte8Mapper.Register(nxtByte, nxtRecRev);
  TnxByte8Mapper.Register(nxtByte, nxtSingle);
  TnxByte8Mapper.Register(nxtByte, nxtDouble);
  TnxByte8Mapper.Register(nxtByte, nxtExtended);
  TnxByte8Mapper.Register(nxtByte, nxtCurrency);
  TnxByte8Mapper.Register(nxtByte, nxtBCD);
  TnxByte8Mapper.Register(nxtByte, nxtByteArray);
  TnxByte8Mapper.Register(nxtByte, nxtChar);
  TnxByte8Mapper.Register(nxtByte, nxtWideChar);
  TnxByte8Mapper.Register(nxtByte, nxtNullString);
  TnxByte8Mapper.Register(nxtByte, nxtShortString);
  TnxByte8Mapper.Register(nxtByte, nxtWideString);

  TnxWord16Mapper.Register(nxtWord16, nxtBoolean);
  TnxWord16Mapper.Register(nxtWord16, nxtInt8);
  TnxWord16Mapper.Register(nxtWord16, nxtInt16);
  TnxWord16Mapper.Register(nxtWord16, nxtInt32);
  TnxWord16Mapper.Register(nxtWord16, nxtInt64);
  TnxWord16Mapper.Register(nxtWord16, nxtByte);
  TnxWord16Mapper.Register(nxtWord16, nxtWord16);
  TnxWord16Mapper.Register(nxtWord16, nxtWord32);
  TnxWord16Mapper.Register(nxtWord16, nxtAutoInc);
  TnxWord16Mapper.Register(nxtWord16, nxtRecRev);
  TnxWord16Mapper.Register(nxtWord16, nxtSingle);
  TnxWord16Mapper.Register(nxtWord16, nxtDouble);
  TnxWord16Mapper.Register(nxtWord16, nxtExtended);
  TnxWord16Mapper.Register(nxtWord16, nxtCurrency);
  TnxWord16Mapper.Register(nxtWord16, nxtBCD);
  TnxWord16Mapper.Register(nxtWord16, nxtByteArray);
  TnxWord16Mapper.Register(nxtWord16, nxtChar);
  TnxWord16Mapper.Register(nxtWord16, nxtWideChar);
  TnxWord16Mapper.Register(nxtWord16, nxtNullString);
  TnxWord16Mapper.Register(nxtWord16, nxtShortString);
  TnxWord16Mapper.Register(nxtWord16, nxtWideString);

  TnxWord32Mapper.Register(nxtWord32, nxtBoolean);
  TnxWord32Mapper.Register(nxtWord32, nxtInt8);
  TnxWord32Mapper.Register(nxtWord32, nxtInt16);
  TnxWord32Mapper.Register(nxtWord32, nxtInt32);
  TnxWord32Mapper.Register(nxtWord32, nxtInt64);
  TnxWord32Mapper.Register(nxtWord32, nxtByte);
  TnxWord32Mapper.Register(nxtWord32, nxtWord16);
  TnxWord32Mapper.Register(nxtWord32, nxtWord32);
  TnxWord32Mapper.Register(nxtWord32, nxtAutoInc);
  TnxWord32Mapper.Register(nxtWord32, nxtRecRev);
  TnxWord32Mapper.Register(nxtWord32, nxtTime);  //..
  TnxWord32Mapper.Register(nxtWord32, nxtSingle);
  TnxWord32Mapper.Register(nxtWord32, nxtDouble);
  TnxWord32Mapper.Register(nxtWord32, nxtExtended);
  TnxWord32Mapper.Register(nxtWord32, nxtCurrency);
  TnxWord32Mapper.Register(nxtWord32, nxtBCD);
  TnxWord32Mapper.Register(nxtWord32, nxtByteArray);
  TnxWord32Mapper.Register(nxtWord32, nxtChar);
  TnxWord32Mapper.Register(nxtWord32, nxtWideChar);
  TnxWord32Mapper.Register(nxtWord32, nxtNullString);
  TnxWord32Mapper.Register(nxtWord32, nxtShortString);
  TnxWord32Mapper.Register(nxtWord32, nxtWideString);

  TnxWord32Mapper.Register(nxtAutoInc, nxtBoolean);
  TnxWord32Mapper.Register(nxtAutoInc, nxtInt8);
  TnxWord32Mapper.Register(nxtAutoInc, nxtInt16);
  TnxWord32Mapper.Register(nxtAutoInc, nxtInt32);
  TnxWord32Mapper.Register(nxtAutoInc, nxtInt64);
  TnxWord32Mapper.Register(nxtAutoInc, nxtByte);
  TnxWord32Mapper.Register(nxtAutoInc, nxtWord16);
  TnxWord32Mapper.Register(nxtAutoInc, nxtWord32);
  TnxWord32Mapper.Register(nxtAutoInc, nxtAutoInc);
  TnxWord32Mapper.Register(nxtAutoInc, nxtRecRev);
  TnxWord32Mapper.Register(nxtAutoInc, nxtSingle);
  TnxWord32Mapper.Register(nxtAutoInc, nxtDouble);
  TnxWord32Mapper.Register(nxtAutoInc, nxtExtended);
  TnxWord32Mapper.Register(nxtAutoInc, nxtCurrency);
  TnxWord32Mapper.Register(nxtAutoInc, nxtBCD);
  TnxWord32Mapper.Register(nxtAutoInc, nxtByteArray);
  TnxWord32Mapper.Register(nxtAutoInc, nxtChar);
  TnxWord32Mapper.Register(nxtAutoInc, nxtWideChar);
  TnxWord32Mapper.Register(nxtAutoInc, nxtNullString);
  TnxWord32Mapper.Register(nxtAutoInc, nxtShortString);
  TnxWord32Mapper.Register(nxtAutoInc, nxtWideString);

  TnxWord32Mapper.Register(nxtRecRev, nxtBoolean);
  TnxWord32Mapper.Register(nxtRecRev, nxtInt8);
  TnxWord32Mapper.Register(nxtRecRev, nxtInt16);
  TnxWord32Mapper.Register(nxtRecRev, nxtInt32);
  TnxWord32Mapper.Register(nxtRecRev, nxtInt64);
  TnxWord32Mapper.Register(nxtRecRev, nxtByte);
  TnxWord32Mapper.Register(nxtRecRev, nxtWord16);
  TnxWord32Mapper.Register(nxtRecRev, nxtWord32);
  TnxWord32Mapper.Register(nxtRecRev, nxtAutoInc);
  TnxWord32Mapper.Register(nxtRecRev, nxtRecRev);
  TnxWord32Mapper.Register(nxtRecRev, nxtSingle);
  TnxWord32Mapper.Register(nxtRecRev, nxtDouble);
  TnxWord32Mapper.Register(nxtRecRev, nxtExtended);
  TnxWord32Mapper.Register(nxtRecRev, nxtCurrency);
  TnxWord32Mapper.Register(nxtRecRev, nxtBCD);
  TnxWord32Mapper.Register(nxtRecRev, nxtByteArray);
  TnxWord32Mapper.Register(nxtRecRev, nxtChar);
  TnxWord32Mapper.Register(nxtRecRev, nxtWideChar);
  TnxWord32Mapper.Register(nxtRecRev, nxtNullString);
  TnxWord32Mapper.Register(nxtRecRev, nxtShortString);
  TnxWord32Mapper.Register(nxtRecRev, nxtWideString);

  TnxSingleMapper.Register(nxtSingle, nxtBoolean);
  TnxSingleMapper.Register(nxtSingle, nxtInt8);
  TnxSingleMapper.Register(nxtSingle, nxtInt16);
  TnxSingleMapper.Register(nxtSingle, nxtInt32);
  TnxSingleMapper.Register(nxtSingle, nxtInt64);
  TnxSingleMapper.Register(nxtSingle, nxtByte);
  TnxSingleMapper.Register(nxtSingle, nxtWord16);
  TnxSingleMapper.Register(nxtSingle, nxtWord32);
  TnxSingleMapper.Register(nxtSingle, nxtAutoInc);
  TnxSingleMapper.Register(nxtSingle, nxtRecRev);
  TnxSingleMapper.Register(nxtSingle, nxtSingle);
  TnxSingleMapper.Register(nxtSingle, nxtDouble);
  TnxSingleMapper.Register(nxtSingle, nxtExtended);
  TnxSingleMapper.Register(nxtSingle, nxtCurrency);
  TnxSingleMapper.Register(nxtSingle, nxtBCD);
  TnxSingleMapper.Register(nxtSingle, nxtByteArray);
  TnxSingleMapper.Register(nxtSingle, nxtChar);
  TnxSingleMapper.Register(nxtSingle, nxtWideChar);
  TnxSingleMapper.Register(nxtSingle, nxtNullString);
  TnxSingleMapper.Register(nxtSingle, nxtShortString);
  TnxSingleMapper.Register(nxtSingle, nxtWideString);

  TnxDoubleMapper.Register(nxtDouble, nxtBoolean);
  TnxDoubleMapper.Register(nxtDouble, nxtInt8);
  TnxDoubleMapper.Register(nxtDouble, nxtInt16);
  TnxDoubleMapper.Register(nxtDouble, nxtInt32);
  TnxDoubleMapper.Register(nxtDouble, nxtInt64);
  TnxDoubleMapper.Register(nxtDouble, nxtByte);
  TnxDoubleMapper.Register(nxtDouble, nxtWord16);
  TnxDoubleMapper.Register(nxtDouble, nxtWord32);
  TnxDoubleMapper.Register(nxtDouble, nxtAutoInc);
  TnxDoubleMapper.Register(nxtDouble, nxtRecRev);
  TnxDoubleMapper.Register(nxtDouble, nxtSingle);
  TnxDoubleMapper.Register(nxtDouble, nxtDouble);
  TnxDoubleMapper.Register(nxtDouble, nxtExtended);
  TnxDoubleMapper.Register(nxtDouble, nxtCurrency);
  TnxDoubleMapper.Register(nxtDouble, nxtDateTime);
  TnxDoubleMapper.Register(nxtDouble, nxtBCD);
  TnxDoubleMapper.Register(nxtDouble, nxtByteArray);
  TnxDoubleMapper.Register(nxtDouble, nxtChar);
  TnxDoubleMapper.Register(nxtDouble, nxtWideChar);
  TnxDoubleMapper.Register(nxtDouble, nxtNullString);
  TnxDoubleMapper.Register(nxtDouble, nxtShortString);
  TnxDoubleMapper.Register(nxtDouble, nxtWideString);

  TnxExtendedMapper.Register(nxtExtended, nxtBoolean);
  TnxExtendedMapper.Register(nxtExtended, nxtInt8);
  TnxExtendedMapper.Register(nxtExtended, nxtInt16);
  TnxExtendedMapper.Register(nxtExtended, nxtInt32);
  TnxExtendedMapper.Register(nxtExtended, nxtInt64);
  TnxExtendedMapper.Register(nxtExtended, nxtByte);
  TnxExtendedMapper.Register(nxtExtended, nxtWord16);
  TnxExtendedMapper.Register(nxtExtended, nxtWord32);
  TnxExtendedMapper.Register(nxtExtended, nxtAutoInc);
  TnxExtendedMapper.Register(nxtExtended, nxtRecRev);
  TnxExtendedMapper.Register(nxtExtended, nxtSingle);
  TnxExtendedMapper.Register(nxtExtended, nxtDouble);
  TnxExtendedMapper.Register(nxtExtended, nxtExtended);
  TnxExtendedMapper.Register(nxtExtended, nxtCurrency);
  TnxExtendedMapper.Register(nxtExtended, nxtBCD);
  TnxExtendedMapper.Register(nxtExtended, nxtByteArray);
  TnxExtendedMapper.Register(nxtExtended, nxtChar);
  TnxExtendedMapper.Register(nxtExtended, nxtWideChar);
  TnxExtendedMapper.Register(nxtExtended, nxtNullString);
  TnxExtendedMapper.Register(nxtExtended, nxtShortString);
  TnxExtendedMapper.Register(nxtExtended, nxtWideString);

  TnxCurrencyMapper.Register(nxtCurrency, nxtBoolean);
  TnxCurrencyMapper.Register(nxtCurrency, nxtInt8);
  TnxCurrencyMapper.Register(nxtCurrency, nxtInt16);
  TnxCurrencyMapper.Register(nxtCurrency, nxtInt32);
  TnxCurrencyMapper.Register(nxtCurrency, nxtInt64);
  TnxCurrencyMapper.Register(nxtCurrency, nxtByte);
  TnxCurrencyMapper.Register(nxtCurrency, nxtWord16);
  TnxCurrencyMapper.Register(nxtCurrency, nxtWord32);
  TnxCurrencyMapper.Register(nxtCurrency, nxtAutoInc);
  TnxCurrencyMapper.Register(nxtCurrency, nxtRecRev);
  TnxCurrencyMapper.Register(nxtCurrency, nxtSingle);
  TnxCurrencyMapper.Register(nxtCurrency, nxtDouble);
  TnxCurrencyMapper.Register(nxtCurrency, nxtExtended);
  TnxCurrencyMapper.Register(nxtCurrency, nxtCurrency);
  TnxCurrencyMapper.Register(nxtCurrency, nxtBCD);
  TnxCurrencyMapper.Register(nxtCurrency, nxtByteArray);
  TnxCurrencyMapper.Register(nxtCurrency, nxtChar);
  TnxCurrencyMapper.Register(nxtCurrency, nxtWideChar);
  TnxCurrencyMapper.Register(nxtCurrency, nxtNullString);
  TnxCurrencyMapper.Register(nxtCurrency, nxtShortString);
  TnxCurrencyMapper.Register(nxtCurrency, nxtWideString);

  TnxCurrencyMapper.Register(nxtBCD, nxtBoolean);
  TnxCurrencyMapper.Register(nxtBCD, nxtInt8);
  TnxCurrencyMapper.Register(nxtBCD, nxtInt16);
  TnxCurrencyMapper.Register(nxtBCD, nxtInt32);
  TnxCurrencyMapper.Register(nxtBCD, nxtInt64);
  TnxCurrencyMapper.Register(nxtBCD, nxtByte);
  TnxCurrencyMapper.Register(nxtBCD, nxtWord16);
  TnxCurrencyMapper.Register(nxtBCD, nxtWord32);
  TnxCurrencyMapper.Register(nxtBCD, nxtAutoInc);
  TnxCurrencyMapper.Register(nxtBCD, nxtRecRev);
  TnxCurrencyMapper.Register(nxtBCD, nxtSingle);
  TnxCurrencyMapper.Register(nxtBCD, nxtDouble);
  TnxCurrencyMapper.Register(nxtBCD, nxtExtended);
  TnxCurrencyMapper.Register(nxtBCD, nxtCurrency);
  TnxCurrencyMapper.Register(nxtBCD, nxtBCD);
  TnxCurrencyMapper.Register(nxtBCD, nxtByteArray);
  TnxCurrencyMapper.Register(nxtBCD, nxtChar);
  TnxCurrencyMapper.Register(nxtBCD, nxtWideChar);
  TnxCurrencyMapper.Register(nxtBCD, nxtNullString);
  TnxCurrencyMapper.Register(nxtBCD, nxtShortString);
  TnxCurrencyMapper.Register(nxtBCD, nxtWideString);

  TnxFmtBCDMapper.Register(nxtBCD, nxtFmtBCD);
  TnxFmtBCDMapper.Register(nxtCurrency, nxtFmtBCD);
  TnxFmtBCDMapper.Register(nxtSingle, nxtFmtBCD);
  TnxFmtBCDMapper.Register(nxtDouble, nxtFmtBCD);
  TnxFmtBCDMapper.Register(nxtExtended, nxtFmtBCD);
  TnxFmtBCDMapper.Register(nxtInt8, nxtFmtBCD);
  TnxFmtBCDMapper.Register(nxtInt16, nxtFmtBCD);
  TnxFmtBCDMapper.Register(nxtInt32, nxtFmtBCD);
  TnxFmtBCDMapper.Register(nxtInt64, nxtFmtBCD);
  TnxFmtBCDMapper.Register(nxtByte, nxtFmtBCD);
  TnxFmtBCDMapper.Register(nxtWord16, nxtFmtBCD);
  TnxFmtBCDMapper.Register(nxtAutoinc, nxtFmtBCD);
  TnxFmtBCDMapper.Register(nxtRecRev, nxtFmtBCD);
  TnxFmtBCDMapper.Register(nxtWord32, nxtFmtBCD);

  TnxFmtBCDMapper.Register(nxtFmtBCD, nxtFmtBCD);
  TnxFmtBCDMapper.Register(nxtFmtBCD, nxtBCD);
  TnxFmtBCDMapper.Register(nxtFmtBCD, nxtCurrency);
  TnxFmtBCDMapper.Register(nxtFmtBCD, nxtSingle);
  TnxFmtBCDMapper.Register(nxtFmtBCD, nxtDouble);
  TnxFmtBCDMapper.Register(nxtFmtBCD, nxtExtended);
  TnxFmtBCDMapper.Register(nxtFmtBCD, nxtInt8);
  TnxFmtBCDMapper.Register(nxtFmtBCD, nxtInt16);
  TnxFmtBCDMapper.Register(nxtFmtBCD, nxtInt32);
  TnxFmtBCDMapper.Register(nxtFmtBCD, nxtInt64);
  TnxFmtBCDMapper.Register(nxtFmtBCD, nxtByte);
  TnxFmtBCDMapper.Register(nxtFmtBCD, nxtWord16);
  TnxFmtBCDMapper.Register(nxtFmtBCD, nxtAutoinc);
  TnxFmtBCDMapper.Register(nxtFmtBCD, nxtRecRev);
  TnxFmtBCDMapper.Register(nxtFmtBCD, nxtWord32);

  TnxTimeMapper.Register(nxtTime, nxtDateTime);
  TnxTimeMapper.Register(nxtTime, nxtDate);
  TnxTimeMapper.Register(nxtTime, nxtTime);
  TnxTimeMapper.Register(nxtTime, nxtByteArray);
  TnxTimeMapper.Register(nxtTime, nxtNullString);
  TnxTimeMapper.Register(nxtTime, nxtShortString);
  TnxTimeMapper.Register(nxtTime, nxtWideString);
  TnxTimeMapper.Register(nxtTime, nxtWord32); //..

  TnxDateMapper.Register(nxtDate, nxtDateTime);
  TnxDateMapper.Register(nxtDate, nxtDate);
  TnxDateMapper.Register(nxtDate, nxtTime);
  TnxDateMapper.Register(nxtDate, nxtByteArray);
  TnxDateMapper.Register(nxtDate, nxtNullString);
  TnxDateMapper.Register(nxtDate, nxtShortString);
  TnxDateMapper.Register(nxtDate, nxtWideString);

  TnxDateTimeMapper.Register(nxtDateTime, nxtDateTime);
  TnxDateTimeMapper.Register(nxtDateTime, nxtDate);
  TnxDateTimeMapper.Register(nxtDateTime, nxtTime);
  TnxDateTimeMapper.Register(nxtDateTime, nxtDouble);
  TnxDateTimeMapper.Register(nxtDateTime, nxtByteArray);
  TnxDateTimeMapper.Register(nxtDateTime, nxtNullString);
  TnxDateTimeMapper.Register(nxtDateTime, nxtShortString);
  TnxDateTimeMapper.Register(nxtDateTime, nxtWideString);

  TnxGuidMapper.Register(nxtGuid, nxtGuid);
  TnxGuidMapper.Register(nxtGuid, nxtByteArray);
  TnxGuidMapper.Register(nxtGuid, nxtNullString);
  TnxGuidMapper.Register(nxtGuid, nxtShortString);
  TnxGuidMapper.Register(nxtGuid, nxtWideString);

  TnxShortStringToShortStringMapper.Register(nxtShortString, nxtShortString);
  TnxShortStringToNullStringMapper.Register(nxtShortString, nxtNullString);

  TnxNullStringToNullStringMapper.Register(nxtNullString, nxtNullString);
  TnxNullStringToShortStringMapper.Register(nxtNullString, nxtShortString);

  TnxWideStringToAnsiStringMapper.Register(nxtWideString, nxtNullString);
  TnxWideStringToAnsiStringMapper.Register(nxtWideString, nxtShortString);

  TnxAnsiStringToWideStringMapper.Register(nxtShortString, nxtWideString);
  TnxAnsiStringToWideStringMapper.Register(nxtNullString, nxtWideString);

  TnxWideStringToWideStringMapper.Register(nxtWideString, nxtWideString);

  TnxCharMapper.Register(nxtChar, nxtBoolean);
  TnxCharMapper.Register(nxtChar, nxtChar);
  TnxCharMapper.Register(nxtChar, nxtWideChar);
  TnxCharMapper.Register(nxtChar, nxtInt8);
  TnxCharMapper.Register(nxtChar, nxtInt16);
  TnxCharMapper.Register(nxtChar, nxtInt32);
  TnxCharMapper.Register(nxtChar, nxtInt64);
  TnxCharMapper.Register(nxtChar, nxtByte);
  TnxCharMapper.Register(nxtChar, nxtWord16);
  TnxCharMapper.Register(nxtChar, nxtWord32);
  TnxCharMapper.Register(nxtChar, nxtAutoInc);
  TnxCharMapper.Register(nxtChar, nxtRecRev);
  TnxCharMapper.Register(nxtChar, nxtSingle);
  TnxCharMapper.Register(nxtChar, nxtDouble);
  TnxCharMapper.Register(nxtChar, nxtExtended);
  TnxCharMapper.Register(nxtChar, nxtCurrency);
  TnxCharMapper.Register(nxtChar, nxtBCD);
  TnxCharMapper.Register(nxtChar, nxtByteArray);
  TnxCharMapper.Register(nxtChar, nxtShortString);
  TnxCharMapper.Register(nxtChar, nxtNullString);
  TnxCharMapper.Register(nxtChar, nxtWideString);

  TnxWideCharMapper.Register(nxtWideChar, nxtBoolean);
  TnxWideCharMapper.Register(nxtWideChar, nxtChar);
  TnxWideCharMapper.Register(nxtWideChar, nxtWideChar);
  TnxWideCharMapper.Register(nxtWideChar, nxtInt8);
  TnxWideCharMapper.Register(nxtWideChar, nxtInt16);
  TnxWideCharMapper.Register(nxtWideChar, nxtInt32);
  TnxWideCharMapper.Register(nxtWideChar, nxtInt64);
  TnxWideCharMapper.Register(nxtWideChar, nxtByte);
  TnxWideCharMapper.Register(nxtWideChar, nxtWord16);
  TnxWideCharMapper.Register(nxtWideChar, nxtWord32);
  TnxWideCharMapper.Register(nxtWideChar, nxtAutoInc);
  TnxWideCharMapper.Register(nxtWideChar, nxtRecRev);
  TnxWideCharMapper.Register(nxtWideChar, nxtSingle);
  TnxWideCharMapper.Register(nxtWideChar, nxtDouble);
  TnxWideCharMapper.Register(nxtWideChar, nxtExtended);
  TnxWideCharMapper.Register(nxtWideChar, nxtCurrency);
  TnxWideCharMapper.Register(nxtWideChar, nxtBCD);
  TnxWideCharMapper.Register(nxtWideChar, nxtByteArray);
  TnxWideCharMapper.Register(nxtWideChar, nxtShortString);
  TnxWideCharMapper.Register(nxtWideChar, nxtNullString);
  TnxWideCharMapper.Register(nxtWideChar, nxtWideString);

  TnxShortStringMapper.Register(nxtShortString, nxtBoolean);
  TnxShortStringMapper.Register(nxtShortString, nxtInt8);
  TnxShortStringMapper.Register(nxtShortString, nxtInt16);
  TnxShortStringMapper.Register(nxtShortString, nxtInt32);
  TnxShortStringMapper.Register(nxtShortString, nxtInt64);
  TnxShortStringMapper.Register(nxtShortString, nxtByte);
  TnxShortStringMapper.Register(nxtShortString, nxtWord16);
  TnxShortStringMapper.Register(nxtShortString, nxtAutoinc);
  TnxShortStringMapper.Register(nxtShortString, nxtRecRev);
  TnxShortStringMapper.Register(nxtShortString, nxtWord32);
  TnxShortStringMapper.Register(nxtShortString, nxtSingle);
  TnxShortStringMapper.Register(nxtShortString, nxtDouble);
  TnxShortStringMapper.Register(nxtShortString, nxtExtended);
  TnxShortStringMapper.Register(nxtShortString, nxtBCD);
  TnxShortStringMapper.Register(nxtShortString, nxtCurrency);
  TnxShortStringMapper.Register(nxtShortString, nxtDate);
  TnxShortStringMapper.Register(nxtShortString, nxtTime);
  TnxShortStringMapper.Register(nxtShortString, nxtDateTime);
  TnxShortStringMapper.Register(nxtShortString, nxtByteArray);
  TnxShortStringMapper.Register(nxtShortString, nxtGuid);
  TnxShortStringMapper.Register(nxtShortString, nxtChar);
  TnxShortStringMapper.Register(nxtShortString, nxtWideChar);

  TnxNullStringMapper.Register(nxtNullString, nxtBoolean);
  TnxNullStringMapper.Register(nxtNullString, nxtInt8);
  TnxNullStringMapper.Register(nxtNullString, nxtInt16);
  TnxNullStringMapper.Register(nxtNullString, nxtInt32);
  TnxNullStringMapper.Register(nxtNullString, nxtInt64);
  TnxNullStringMapper.Register(nxtNullString, nxtByte);
  TnxNullStringMapper.Register(nxtNullString, nxtWord16);
  TnxNullStringMapper.Register(nxtNullString, nxtAutoinc);
  TnxNullStringMapper.Register(nxtNullString, nxtRecRev);
  TnxNullStringMapper.Register(nxtNullString, nxtWord32);
  TnxNullStringMapper.Register(nxtNullString, nxtSingle);
  TnxNullStringMapper.Register(nxtNullString, nxtDouble);
  TnxNullStringMapper.Register(nxtNullString, nxtExtended);
  TnxNullStringMapper.Register(nxtNullString, nxtBCD);
  TnxNullStringMapper.Register(nxtNullString, nxtCurrency);
  TnxNullStringMapper.Register(nxtNullString, nxtDate);
  TnxNullStringMapper.Register(nxtNullString, nxtTime);
  TnxNullStringMapper.Register(nxtNullString, nxtDateTime);
  TnxNullStringMapper.Register(nxtNullString, nxtByteArray);
  TnxNullStringMapper.Register(nxtNullString, nxtGuid);
  TnxNullStringMapper.Register(nxtNullString, nxtChar);
  TnxNullStringMapper.Register(nxtNullString, nxtWideChar);

  TnxWideStringMapper.Register(nxtWideString, nxtBoolean);
  TnxWideStringMapper.Register(nxtWideString, nxtInt8);
  TnxWideStringMapper.Register(nxtWideString, nxtInt16);
  TnxWideStringMapper.Register(nxtWideString, nxtInt32);
  TnxWideStringMapper.Register(nxtWideString, nxtInt64);
  TnxWideStringMapper.Register(nxtWideString, nxtByte);
  TnxWideStringMapper.Register(nxtWideString, nxtWord16);
  TnxWideStringMapper.Register(nxtWideString, nxtAutoinc);
  TnxWideStringMapper.Register(nxtWideString, nxtRecRev);
  TnxWideStringMapper.Register(nxtWideString, nxtWord32);
  TnxWideStringMapper.Register(nxtWideString, nxtSingle);
  TnxWideStringMapper.Register(nxtWideString, nxtDouble);
  TnxWideStringMapper.Register(nxtWideString, nxtExtended);
  TnxWideStringMapper.Register(nxtWideString, nxtBCD);
  TnxWideStringMapper.Register(nxtWideString, nxtCurrency);
  TnxWideStringMapper.Register(nxtWideString, nxtDate);
  TnxWideStringMapper.Register(nxtWideString, nxtTime);
  TnxWideStringMapper.Register(nxtWideString, nxtDateTime);
  TnxWideStringMapper.Register(nxtWideString, nxtByteArray);
  TnxWideStringMapper.Register(nxtWideString, nxtGuid);
  TnxWideStringMapper.Register(nxtWideString, nxtChar);
  TnxWideStringMapper.Register(nxtWideString, nxtWideChar);

  TnxByteArrayMapper.Register(nxtByteArray, nxtByteArray);
  TnxByteArrayMapper.Register(nxtByteArray, nxtGuid);
  TnxByteArrayMapper.Register(nxtByteArray, nxtNullString);
  TnxByteArrayMapper.Register(nxtByteArray, nxtShortString);
  TnxByteArrayMapper.Register(nxtByteArray, nxtWideString);

finalization
end.
