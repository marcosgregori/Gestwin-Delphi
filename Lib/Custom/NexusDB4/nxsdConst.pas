{##############################################################################}
{# NexusDB: nxsdConst.pas 4.7516                                             #}
{# Copyright (c) UnSquashable Pty. Ltd. 2003-2025                             #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB: database specific constants shared between client and server      #}
{##############################################################################}

{$I nxDefine.inc}

unit nxsdConst;

interface

uses
  nxllMemoryManager,
  nxllTypes,
  nxsdTypes;

const
  { The default timeout for setting filters in ms. }
  nxDefaultFilterTimeout = 500;

  _Log2BlockSizes : array[TnxBlockSize] of Byte = (
    12,
    13,
    14,
    15,
    16);

  {file extensions (must NOT include period)}
  nxc_ExtForTrans  : string = 'n$2'; {extension for Transaction file}
  nxc_ExtForSQL    : string = 'sql'; {extension for SQL text files}

  { Default engine names }
  nx1xDefault = 'nx1xDefault';

{===NexusDB Limits===}   {  ***DO NOT ALTER***  }
const
  nxcl_MaxIndexes = 256;             {maximum number of indexes per table}
  {nxcl_MaxIndexFlds = 16; no such limit}      {maximum count of fields in a composite key}
  nxcl_FixedBookmarkSize = 24;       {size of fixed part of a bookmark (ie, without key value)}

  FieldDataTypes   : array[TnxFieldType] of string = (
                     'Boolean',
                     'Char',
                     'Wide Char',
                     'Byte',
                     'Word16',
                     'Word32',
                     'Int8',
                     'Int16',
                     'Int32',
                     'Int64',
                     'AutoInc',
                     'Single',
                     'Double',
                     'Extended',
                     'Currency',
                     'Date',
                     'Time',
                     'DateTime',
                     'Interval',
                     'BLOB',
                     'BLOB Memo',
                     'BLOB Graphic',
                     'Byte Array',
                     'ShortString',
                     'NullString',
                     'WideString',
                     'RecRev',
                     'GUID',
                     'BCD',
                     'BLOB Wide Memo',
                     'Formatted BCD',
                     'RefNr');

  nxCompatibleFields: array[TnxFieldType, TnxFieldType] of Boolean =
    {                  Boolean, Char,  WideChar, Byte,  Word16, Word32, Int8,  Int16, Int32, Int64, AutoInc, Single, Double, Extended, Currency, Date,  Time,  DateTime, Interval, Blob,  Memo,  Graphic, ByteArray, ShStr, NlStr, WiStr, RecRev, GUID,  Bcd,   WideMemo, FmtBcd    RefNr }
    {Boolean}        ((True,    False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, False, False,   False,     False, False, False, False,  False, False, False,    False,    False),
    {Char}            (False,   True,  False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, False, False,   False,     False, False, False, False,  False, False, False,    False,    False),
    {Wide Char}       (False,   False, True,     False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, False, False,   False,     False, False, False, False,  False, False, False,    False,    False),
    {Byte}            (False,   False, False,    True,  False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, False, False,   False,     False, False, False, False,  False, False, False,    False,    False),
    {Word16}          (False,   False, False,    False, True,   False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, False, False,   False,     False, False, False, False,  False, False, False,    False,    False),
    {Word32}          (False,   False, False,    False, False,  True,   False, False, False, False, True,    False,  False,  False,    False,    False, False, False,    False,    False, False, False,   False,     False, False, False, True ,  False, False, False,    False,    False),
    {Int8}            (False,   False, False,    False, False,  False,  True,  False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, False, False,   False,     False, False, False, False,  False, False, False,    False,    False),
    {Int16}           (False,   False, False,    False, False,  False,  False, True,  False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, False, False,   False,     False, False, False, False,  False, False, False,    False,    False),
    {Int32}           (False,   False, False,    False, False,  False,  False, False, True,  False, False,   False,  False,  False,    False,    False, False, False,    False,    False, False, False,   False,     False, False, False, False,  False, False, False,    False,    False),
    {Int64}           (False,   False, False,    False, False,  False,  False, False, False, True,  False,   False,  False,  False,    False,    False, False, False,    False,    False, False, False,   False,     False, False, False, False,  False, False, False,    False,    True ),
    {AutoInc}         (False,   False, False,    False, False,  True,   False, False, False, False, True,    False,  False,  False,    False,    False, False, False,    False,    False, False, False,   False,     False, False, False, True ,  False, False, False,    False,    False),
    {Single}          (False,   False, False,    False, False,  False,  False, False, False, False, False,   True,   False,  False,    False,    False, False, False,    False,    False, False, False,   False,     False, False, False, False,  False, False, False,    False,    False),
    {Double}          (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  True,   False,    False,    False, False, False,    False,    False, False, False,   False,     False, False, False, False,  False, False, False,    False,    False),
    {Extended}        (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  True,     False,    False, False, False,    False,    False, False, False,   False,     False, False, False, False,  False, False, False,    False,    False),
    {Currency}        (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    True,     False, False, False,    False,    False, False, False,   False,     False, False, False, False,  False, True , False,    True ,    False),
    {Date}            (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    True,  False, False,    False,    False, False, False,   False,     False, False, False, False,  False, False, False,    False,    False),
    {Time}            (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, True,  False,    False,    False, False, False,   False,     False, False, False, False,  False, False, False,    False,    False),
    {DateTime}        (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, True,     True,     False, False, False,   False,     False, False, False, False,  False, False, False,    False,    False),
    {Interval}        (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, True,     True,     False, False, False,   False,     False, False, False, False,  False, False, False,    False,    False),
    {BLOB}            (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    True,  True,  True,    False,     False, False, False, False,  False, False, True ,    False,    False),
    {BLOB Memo}       (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    True,  True,  True,    False,     False, False, False, False,  False, False, True ,    False,    False),
    {BLOB Graphic}    (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    True,  True,  True,    False,     False, False, False, False,  False, False, True ,    False,    False),
    {Byte Array}      (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, False, False,   True,      False, False, False, False,  False, False, False,    False,    False),
    {ShortString}     (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, False, False,   False,     True,  False, False, False,  False, False, False,    False,    False),
    {NullString}      (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, False, False,   False,     False, True,  False, False,  False, False, False,    False,    False),
    {WideString}      (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, False, False,   False,     False, False, True,  False,  False, False, False,    False,    False),
    {RecRev}          (False,   False, False,    False, False,  True,   False, False, False, False, True,    False,  False,  False,    False,    False, False, False,    False,    False, False, False,   False,     False, False, False, True ,  False, False, False,    False,    False),
    {GUID}            (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, False, False,   False,     False, False, False, False,  True , False, False,    False,    False),
    {Bcd}             (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    True,     False, False, False,    False,    False, False, False,   False,     False, False, False, False,  False, True,  False,    True ,    False),
    {BLOB Wide Memo}  (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    True,  True,  True,    False,     False, False, False, False,  False, False, True ,    False,    False),
    {FmtBcd}          (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    True,     False, False, False,    False,    False, False, False,   False,     False, False, False, False,  False, True,  False,    True ,    False),
    {RefNr}           (False,   False, False,    False, False,  False,  False, False, False, True,  False,   False,  False,  False,    True,     False, False, False,    False,    False, False, False,   False,     False, False, False, False,  False, False, False,    False,    True ));

  {fields that can be combined in expressions. The result type is defined by the table following this one}
  nxSqlCompatibleFields: array[TnxFieldType, TnxFieldType] of Boolean =
    {                  Boolean, Char,  WideChar, Byte,  Word16, Word32, Int8,  Int16, Int32, Int64, AutoInc, Single, Double, Extended, Currency, Date,  Time,  DateTime, Interval, Blob,  Memo,  Graphic, ByteArray, ShStr, NlStr, WiStr, RecRev, GUID,  Bcd,   WideMemo, FmtBcd    RefNr}
    {Boolean}        ((True,    False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, False, False,   False,     False, False, False, False,  False, False, False,    False,    False),
    {Char}            (False,   True,  True,     False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, True,  False,   False,     True,  True,  True,  False,  False, False, True,     False,    False),
    {Wide Char}       (False,   False, True,     False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, False, False,   False,     False, False, False, False,  False, False, False,    False,    False),
    {Byte}            (False,   False, False,    True,  True,   True,   True,  True,  True,  True,  True,    True,   True,   True,     True,     False, False, False,    False,    False, False, False,   False,     False, False, False, True,   False, True,  False,    True ,    False),
    {Word16}          (False,   False, False,    True,  True,   True,   True,  True,  True,  True,  True,    True,   True,   True,     True,     False, False, False,    False,    False, False, False,   False,     False, False, False, True,   False, True,  False,    True ,    False),
    {Word32}          (False,   False, False,    True,  True,   True,   True,  True,  True,  True,  True,    True,   True,   True,     True,     False, False, False,    False,    False, False, False,   False,     False, False, False, True,   False, True,  False,    True ,    False),
    {Int8}            (False,   False, False,    True,  True,   True,   True,  True,  True,  True,  True,    True,   True,   True,     True,     False, False, False,    False,    False, False, False,   False,     False, False, False, True,   False, True,  False,    True ,    False),
    {Int16}           (False,   False, False,    True,  True,   True,   True,  True,  True,  True,  True,    True,   True,   True,     True,     False, False, False,    False,    False, False, False,   False,     False, False, False, True,   False, True,  False,    True ,    False),
    {Int32}           (False,   False, False,    True,  True,   True,   True,  True,  True,  True,  True,    True,   True,   True,     True,     False, False, False,    False,    False, False, False,   False,     False, False, False, True,   False, True,  False,    True ,    False),
    {Int64}           (False,   False, False,    True,  True,   True,   True,  True,  True,  True,  True,    True,   True,   True,     True,     False, False, False,    False,    False, False, False,   False,     False, False, False, True,   False, True,  False,    True ,    False),
    {AutoInc}         (False,   False, False,    True,  True,   True,   True,  True,  True,  True,  True,    True,   True,   True,     True,     False, False, False,    False,    False, False, False,   False,     False, False, False, True,   False, True,  False,    True ,    False),
    {Single}          (False,   False, False,    True,  True,   True,   True,  True,  True,  True,  True,    True,   True,   True,     True,     False, False, False,    False,    False, False, False,   False,     False, False, False, True,   False, True,  False,    True ,    False),
    {Double}          (False,   False, False,    True,  True,   True,   True,  True,  True,  True,  True,    True,   True,   True,     True,     False, False, False,    False,    False, False, False,   False,     False, False, False, True,   False, True,  False,    True ,    False),
    {Extended}        (False,   False, False,    True,  True,   True,   True,  True,  True,  True,  True,    True,   True,   True,     True,     False, False, False,    False,    False, False, False,   False,     False, False, False, True,   False, True,  False,    True ,    False),
    {Currency}        (False,   False, False,    True,  True,   True,   True,  True,  True,  True,  True,    True,   True,   True,     True,     False, False, False,    False,    False, False, False,   False,     False, False, False, True,   False, True,  False,    True ,    False),
    {Date}            (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    True,  False, False,    False,    False, False, False,   False,     False, False, False, False,  False, False, False,    False,    False),
    {Time}            (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, True,  False,    False,    False, False, False,   False,     False, False, False, False,  False, False, False,    False,    False),
    {DateTime}        (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, True,     False,    False, False, False,   False,     False, False, False, False,  False, False, False,    False,    False),
    {Interval}        (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, True,     True,     False, False, False,   False,     False, False, False, False,  False, False, False,    False,    False),
    {BLOB}            (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    True,  False, True,    False,     False, False, False, False,  False, False, False,    False,    False),
    {BLOB Memo}       (False,   True,  True,     False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, True,  False,   False,     True,  True,  True,  False,  False, False, True,     False,    False),
    {BLOB Graphic}    (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    True,  False, True,    False,     False, False, False, False,  False, False, False,    False,    False),
    {Byte Array}      (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, False, False,   True,      False, False, False, False,  False, False, False,    False,    False),
    {ShortString}     (False,   True,  True,     False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, True,  False,   False,     True,  True,  True,  False,  False, False, True,     False,    False),
    {NullString}      (False,   True,  True,     False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, True,  False,   False,     True,  True,  True,  False,  False, False, True,     False,    False),
    {WideString}      (False,   True,  True,     False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, True,  False,   False,     True,  True,  True,  False,  False, False, True,     False,    False),
    {RecRev}          (False,   False, False,    True,  True,   True,   True,  True,  True,  True,  True,    True,   True,   True,     True,     False, False, False,    False,    False, False, False,   False,     False, False, False, True,   False, True,  False,    True ,    False),
    {GUID}            (False,   False, False,    False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, False, False,   False,     False, False, False, False,  True , False, False,    False,    False),
    {Bcd}             (False,   False, False,    True,  True,   True,   True,  True,  True,  True,  True,    True,   True,   True,     True,     False, False, False,    False,    False, False, False,   False,     False, False, False, True,   False, True,  False,    True ,    False),
    {BLOB Wide Memo}  (False,   True,  True,     False, False,  False,  False, False, False, False, False,   False,  False,  False,    False,    False, False, False,    False,    False, True,  False,   False,     True,  True,  True,  False,  False, False, True,     False,    False),
    {FmtBcd}          (False,   False, False,    True,  True,   True,   True,  True,  True,  True,  True,    True,   True,   True,     True,     False, False, False,    False,    False, False, False,   False,     False, False, False, True,   False, True,  False,    True ,    False),
    {RefNr}           (False,   False, False,    False, False,  False,  False, False, False, True,  False,   False,  False,  False,    False,    False, False, False,    False,    False, False, False,   False,     False, False, False, False,  False, False, False,    False,    True ));

  nxCommonType: array[TnxFieldType, TnxFieldType] of TnxFieldType =
                      {Boolean         Char            WideChar        Byte            Word16          Word32          Int8            Int16           Int32           Int64           AutoInc         Single          Double          Extended        Currency        Date            Time            DateTime        Interval        Blob            BlobMemo        BlobGraphic     ByteArray       ShortString     NullString      WideString      RecRev          Guid            Bcd             WideBlobMemo     FmtBcd           RefNr          }
    {Boolean}        ((nxtBoolean,     nxtChar,        nxtWideChar,    nxtByte,        nxtWord16,      nxtWord32,      nxtInt8,        nxtInt16,       nxtInt32,       nxtInt64,       nxtAutoInc,     nxtSingle,      nxtDouble,      nxtExtended,    nxtCurrency,    nxtDate,        nxtTime,        nxtDateTime,    nxtInterval,    nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtRecRev,      nxtGuid,        nxtBcd,         nxtBlobWideMemo, nxtFmtBcd      , nxtInt64       ),
    {Char}            (nxtChar,        nxtChar,        nxtWideChar,    nxtByte,        nxtWord16,      nxtWord32,      nxtInt8,        nxtInt16,       nxtInt32,       nxtInt64,       nxtAutoInc,     nxtSingle,      nxtDouble,      nxtExtended,    nxtCurrency,    nxtDate,        nxtTime,        nxtDateTime,    nxtInterval,    nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtRecRev,      nxtGuid,        nxtBcd,         nxtBlobWideMemo, nxtFmtBcd      , nxtInt64       ),
    {Wide Char}       (nxtWideChar,    nxtWideChar,    nxtWideChar,    nxtWord16,      nxtWord32,      nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtSingle,      nxtDouble,      nxtExtended,    nxtCurrency,    nxtDate,        nxtTime,        nxtDateTime,    nxtInterval,    nxtBlob,        nxtBlobMemo,    nxtBlobMemo,    nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtRecRev,      nxtGuid,        nxtBcd,         nxtBlobWideMemo, nxtFmtBcd      , nxtInt64       ),
    {Byte}            (nxtByte,        nxtByte,        nxtWideChar,    nxtWord16,      nxtWord16,      nxtWord32,      nxtInt16,       nxtInt16,       nxtInt32,       nxtInt64,       nxtWord32,      nxtSingle,      nxtDouble,      nxtExtended,    nxtCurrency,    nxtDate,        nxtTime,        nxtDateTime,    nxtInterval,    nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtRecRev,      nxtGuid,        nxtBcd,         nxtBlobWideMemo, nxtFmtBcd      , nxtInt64       ),
    {Word16}          (nxtWord16,      nxtWord16,      nxtWideChar,    nxtWord16,      nxtWord16,      nxtWord32,      nxtInt32,       nxtInt32,       nxtInt32,       nxtInt64,       nxtWord32,      nxtSingle,      nxtDouble,      nxtExtended,    nxtCurrency,    nxtDate,        nxtTime,        nxtDateTime,    nxtInterval,    nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtRecRev,      nxtGuid,        nxtBcd,         nxtBlobWideMemo, nxtFmtBcd      , nxtInt64       ),
    {Word32}          (nxtWord32,      nxtWord32,      nxtWord32,      nxtWord32,      nxtWord32,      nxtWord32,      nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtWord32,      nxtSingle,      nxtDouble,      nxtExtended,    nxtCurrency,    nxtDate,        nxtTime,        nxtDateTime,    nxtInterval,    nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtRecRev,      nxtGuid,        nxtBcd,         nxtBlobWideMemo, nxtFmtBcd      , nxtInt64       ),
    {Int8}            (nxtInt32,       nxtInt32,       nxtInt32,       nxtInt32,       nxtInt32,       nxtInt64,       nxtInt8,        nxtInt16,       nxtInt32,       nxtInt64,       nxtInt64,       nxtSingle,      nxtDouble,      nxtExtended,    nxtCurrency,    nxtDate,        nxtTime,        nxtDateTime,    nxtInterval,    nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtRecRev,      nxtGuid,        nxtBcd,         nxtBlobWideMemo, nxtFmtBcd      , nxtInt64       ),
    {Int16}           (nxtInt32,       nxtInt32,       nxtInt32,       nxtInt32,       nxtInt32,       nxtInt64,       nxtInt16,       nxtInt16,       nxtInt32,       nxtInt64,       nxtInt64,       nxtSingle,      nxtDouble,      nxtExtended,    nxtCurrency,    nxtDate,        nxtTime,        nxtDateTime,    nxtInterval,    nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtRecRev,      nxtGuid,        nxtBcd,         nxtBlobWideMemo, nxtFmtBcd      , nxtInt64       ),
    {Int32}           (nxtInt32,       nxtInt32,       nxtInt32,       nxtInt32,       nxtInt32,       nxtInt64,       nxtInt32,       nxtInt32,       nxtInt32,       nxtInt64,       nxtInt64,       nxtSingle,      nxtDouble,      nxtExtended,    nxtCurrency,    nxtDate,        nxtTime,        nxtDateTime,    nxtInterval,    nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtRecRev,      nxtGuid,        nxtBcd,         nxtBlobWideMemo, nxtFmtBcd      , nxtInt64       ),
    {Int64}           (nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtDouble,      nxtDouble,      nxtExtended,    nxtCurrency,    nxtDate,        nxtTime,        nxtDateTime,    nxtInterval,    nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtRecRev,      nxtGuid,        nxtBcd,         nxtBlobWideMemo, nxtFmtBcd      , nxtInt64       ),
    {AutoInc}         (nxtWord32,      nxtWord32,      nxtWord32,      nxtWord32,      nxtWord32,      nxtWord32,      nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtWord32,      nxtDouble,      nxtDouble,      nxtExtended,    nxtCurrency,    nxtDate,        nxtTime,        nxtDateTime,    nxtInterval,    nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtRecRev,      nxtGuid,        nxtBcd,         nxtBlobWideMemo, nxtFmtBcd      , nxtInt64       ),
    {Single}          (nxtSingle,      nxtSingle,      nxtSingle,      nxtSingle,      nxtSingle,      nxtSingle,      nxtSingle,      nxtSingle,      nxtSingle,      nxtSingle,      nxtSingle,      nxtSingle,      nxtDouble,      nxtExtended,    nxtCurrency,    nxtDate,        nxtTime,        nxtDateTime,    nxtInterval,    nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtRecRev,      nxtGuid,        nxtDouble,      nxtBlobWideMemo, nxtDouble      , nxtInt64       ),
    {Double}          (nxtDouble,      nxtDouble,      nxtDouble,      nxtDouble,      nxtDouble,      nxtDouble,      nxtDouble,      nxtDouble,      nxtDouble,      nxtDouble,      nxtDouble,      nxtDouble,      nxtDouble,      nxtExtended,    nxtCurrency,    nxtDate,        nxtTime,        nxtDateTime,    nxtInterval,    nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtRecRev,      nxtGuid,        nxtDouble,      nxtBlobWideMemo, nxtDouble      , nxtInt64       ),
    {Extended}        (nxtExtended,    nxtExtended,    nxtExtended,    nxtExtended,    nxtExtended,    nxtExtended,    nxtExtended,    nxtExtended,    nxtExtended,    nxtExtended,    nxtExtended,    nxtExtended,    nxtExtended,    nxtExtended,    nxtCurrency,    nxtDate,        nxtTime,        nxtDateTime,    nxtInterval,    nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtRecRev,      nxtGuid,        nxtExtended,    nxtBlobWideMemo, nxtExtended    , nxtInt64       ),
    {Currency}        (nxtCurrency,    nxtCurrency,    nxtCurrency,    nxtCurrency,    nxtCurrency,    nxtCurrency,    nxtCurrency,    nxtCurrency,    nxtCurrency,    nxtCurrency,    nxtCurrency,    nxtCurrency,    nxtCurrency,    nxtCurrency,    nxtCurrency,    nxtDate,        nxtTime,        nxtDateTime,    nxtInterval,    nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtRecRev,      nxtGuid,        nxtBcd,         nxtBlobWideMemo, nxtFmtBcd      , nxtInt64       ),
    {Date}            (nxtDate,        nxtDate,        nxtDate,        nxtDate,        nxtDate,        nxtDate,        nxtDate,        nxtDate,        nxtDate,        nxtDate,        nxtDate,        nxtDate,        nxtDouble,      nxtExtended,    nxtCurrency,    nxtDate,        nxtDateTime,    nxtDateTime,    nxtDate,        nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtRecRev,      nxtGuid,        nxtBcd,         nxtBlobWideMemo, nxtFmtBcd      , nxtInt64       ),
    {Time}            (nxtTime,        nxtTime,        nxtTime,        nxtTime,        nxtTime,        nxtTime,        nxtTime,        nxtTime,        nxtTime,        nxtTime,        nxtTime,        nxtTime,        nxtDouble,      nxtExtended,    nxtCurrency,    nxtDateTime,    nxtTime,        nxtDateTime,    nxtTime,        nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtRecRev,      nxtGuid,        nxtBcd,         nxtBlobWideMemo, nxtFmtBcd      , nxtInt64       ),
    {DateTime}        (nxtDateTime,    nxtDateTime,    nxtDateTime,    nxtDateTime,    nxtDateTime,    nxtDateTime,    nxtDateTime,    nxtDateTime,    nxtDateTime,    nxtDateTime,    nxtDateTime,    nxtDateTime,    nxtDouble,      nxtExtended,    nxtCurrency,    nxtDateTime,    nxtDateTime,    nxtDateTime,    nxtDateTime,    nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtRecRev,      nxtGuid,        nxtBcd,         nxtBlobWideMemo, nxtFmtBcd      , nxtInt64       ),
    {Interval}        (nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtInterval,    nxtGuid,        nxtBcd,         nxtInterval,     nxtFmtBcd      , nxtInt64       ),
    {BLOB}            (nxtBlob,        nxtBlob,        nxtBlob,        nxtBlob,        nxtBlob,        nxtBlob,        nxtBlob,        nxtBlob,        nxtBlob,        nxtBlob,        nxtBlob,        nxtBlob,        nxtBlob,        nxtBlob,        nxtBlob,        nxtBlob,        nxtBlob,        nxtBlob,        nxtBlob,        nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtBlob,        nxtBlob,        nxtBlob,        nxtBlob,        nxtBlob,        nxtBlob,        nxtBlobWideMemo, nxtBlob        , nxtInt64       ),
    {BLOB Memo}       (nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobMemo,    nxtBlobWideMemo, nxtBlobMemo    , nxtInt64       ),
    {BLOB Graphic}    (nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic, nxtBlobGraphic,  nxtBlobGraphic , nxtInt64       ),
    {Byte Array}      (nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,   nxtByteArray,    nxtByteArray   , nxtInt64       ),
    {ShortString}     (nxtShortString, nxtShortString, nxtShortString, nxtShortString, nxtShortString, nxtShortString, nxtShortString, nxtShortString, nxtShortString, nxtShortString, nxtShortString, nxtShortString, nxtShortString, nxtShortString, nxtShortString, nxtShortString, nxtShortString, nxtShortString, nxtShortString, nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtShortString, nxtShortString, nxtShortString, nxtBlobWideMemo, nxtShortString , nxtInt64       ),
    {NullString}      (nxtNullString,  nxtNullString,  nxtNullString,  nxtNullString,  nxtNullString,  nxtNullString,  nxtNullString,  nxtNullString,  nxtNullString,  nxtNullString,  nxtNullString,  nxtNullString,  nxtNullString,  nxtNullString,  nxtNullString,  nxtNullString,  nxtNullString,  nxtNullString,  nxtNullString,  nxtNullString,  nxtBlobMemo,    nxtBlobMemo,    nxtBlobGraphic, nxtNullString,  nxtNullString,  nxtWideString,  nxtNullString,  nxtNullString,  nxtNullString,  nxtBlobWideMemo, nxtNullString  , nxtInt64       ),
    {WideString}      (nxtWideString,  nxtWideString,  nxtWideString,  nxtWideString,  nxtWideString,  nxtWideString,  nxtWideString,  nxtWideString,  nxtWideString,  nxtWideString,  nxtWideString,  nxtWideString,  nxtWideString,  nxtWideString,  nxtWideString,  nxtWideString,  nxtWideString,  nxtWideString,  nxtWideString,  nxtWideString,  nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobGraphic, nxtByteArray,   nxtWideString,  nxtWideString,  nxtWideString,  nxtWideString,  nxtWideString,  nxtBlobWideMemo, nxtWideString  , nxtInt64       ),
    {RecRev}          (nxtWord32,      nxtWord32,      nxtWord32,      nxtWord32,      nxtWord32,      nxtWord32,      nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtSingle,      nxtDouble,      nxtExtended,    nxtCurrency,    nxtDate,        nxtTime,        nxtDateTime,    nxtInterval,    nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtRecRev,      nxtGuid,        nxtBcd,         nxtBlobWideMemo, nxtFmtBcd      , nxtInt64       ),
    {GUID}            (nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,        nxtGuid,         nxtGuid        , nxtInt64       ),
    {Bcd}             (nxtBcd,         nxtBcd,         nxtBcd,         nxtBcd,         nxtBcd,         nxtBcd,         nxtBcd,         nxtBcd,         nxtBcd,         nxtBcd,         nxtBcd,         nxtDouble,      nxtDouble,      nxtExtended,    nxtBcd,         nxtDate,        nxtTime,        nxtDateTime,    nxtInterval,    nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtRecRev,      nxtGuid,        nxtBcd,         nxtBlobWideMemo, nxtFmtBcd      , nxtInt64       ),
    {BLOB Wide Memo}  (nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo,nxtBlobWideMemo, nxtBlobWideMemo, nxtInt64       ),
    {FmtBcd}          (nxtFmtBcd,      nxtFmtBcd,      nxtFmtBcd,      nxtFmtBcd,      nxtFmtBcd,      nxtFmtBcd,      nxtFmtBcd,      nxtFmtBcd,      nxtFmtBcd,      nxtFmtBcd,      nxtFmtBcd,      nxtFmtBcd,      nxtFmtBcd,      nxtFmtBcd,      nxtFmtBcd,      nxtDate,        nxtTime,        nxtDateTime,    nxtInterval,    nxtBlob,        nxtBlobMemo,    nxtBlobGraphic, nxtByteArray,   nxtShortString, nxtNullString,  nxtWideString,  nxtRecRev,      nxtGuid,        nxtFmtBcd,      nxtBlobWideMemo, nxtFmtBcd      , nxtInt64       ),
    {RefNr}           (nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,       nxtInt64,        nxtInt64       , nxtRefNr       ));

  nxc_W32NoValue = $FFFFFFFF;

  lrGranted = [lrGrantedNew, lrGrantedExisting];
  lrFailed = [Low(TnxLockResult)..High(TnxLockResult)] - lrGranted;
  lrConflictCursor = [lrConflictCursorWriteLock..lrConflictCursorRecordLockMultiple];
  lrMultiple = [lrConflictCursorReadLockMultiple, lrConflictCursorRecordLockMultiple];

  nxLockResultToLockConflictType: array[TnxLockResult] of TnxLockConflictType = (
    lctUnknown,
    lctUnknown,
    lctUnknown,
    lctWriteLock,
    lctReadLock,
    lctReadLock,
    lctRecordLock,
    lctRecordLock,
    lctTransaction
  );

  nxLockConflictTypeNames: array[TnxLockConflictType] of string = (
    'desconocido',  //..
    'bloqueo de registro',
    'bloqueo de lectura',
    'bloqueo de escritura',
    'transacción'
  );

  nxLockRequestTypeNames: array[TnxLockRequestType] of string = (
    'bloqueo de registro',
    'bloqueo de lectura',
    'bloqueo de escritura'
  );


type
  TFieldDataTypeNames = (fdtnNexus, fdtnSqlFixed, fdtnSqlVariable);
const
  FieldDataTypeNames   : array[TnxFieldType, TFieldDataTypeNames] of string = (
  ('nxtBoolean'     , 'BOOLEAN'                        , 'BOOLEAN'),
  ('nxtChar'        , 'SINGLECHAR'                     , 'SINGLECHAR'),
  ('nxtWideChar'    , 'NSINGLECHAR'                    , 'NSINGLECHAR'),
  ('nxtByte'        , 'BYTE'                           , 'BYTE'),
  ('nxtWord16'      , 'WORD'                           , 'WORD'),
  ('nxtWord32'      , 'DWORD'                          , 'DWORD'),
  ('nxtInt8'        , 'SHORTINT'                       , 'SHORTINT'),
  ('nxtInt16'       , 'SMALLINT'                       , 'SMALLINT'),
  ('nxtInt32'       , 'INTEGER'                        , 'INTEGER'),
  ('nxtInt64'       , 'BIGINT'                         , 'BIGINT'),
  ('nxtAutoInc'     , 'AUTOINC'                        , 'AUTOINC'),
  ('nxtSingle'      , 'FLOAT'                          , 'FLOAT'),
  ('nxtDouble'      , 'DOUBLE PRECISION'               , 'DOUBLE PRECISION'),
  ('nxtExtended'    , 'EXTENDED'                       , 'EXTENDED'),
  ('nxtCurrency'    , 'MONEY'                          , 'MONEY'),
  ('nxtDate'        , 'DATE'                           , 'DATE'),
  ('nxtTime'        , 'TIME'                           , 'TIME'),
  ('nxtDateTime'    , 'TIMESTAMP'                      , 'TIMESTAMP'),
  ('nxtInterval'    , ''                               , ''), // can't be represented directly
  ('nxtBLOB'        , 'BINARY LARGE OBJECT'            , 'BINARY LARGE OBJECT'),
  ('nxtBLOBMemo'    , 'CHARACTER LARGE OBJECT'         , 'CHARACTER LARGE OBJECT'),
  ('nxtBLOBGraphic' , 'IMAGE'                          , 'IMAGE'),
  ('nxtByteArray'   , 'BYTEARRAY'                      , 'BYTEARRAY'),
  ('nxtShortString' , 'SHORTSTRING'                    , 'SHORTSTRING'),
  ('nxtNullString'  , 'CHARACTER'                      , 'CHARACTER VARYING'),
  ('nxtWideString'  , 'NATIONAL CHARACTER'             , 'NATIONAL CHARACTER VARYING'),
  ('nxtRecRev'      , 'RECREV'                         , 'RECREV'),
  ('nxtGUID'        , 'GUID'                           , 'GUID'),
  ('nxtBCD'         , 'DECIMAL'                        , 'DECIMAL'),
  ('nxtBLOBWideMemo', 'NATIONAL CHARACTER LARGE OBJECT', 'NATIONAL CHARACTER LARGE OBJECT'),
  ('nxtFmtBCD'      , 'DECIMAL'                        , 'DECIMAL'),
  ('nxtRefNr'       , 'REFNR'                          , 'REFNR'));

//DOM-IGNORE-BEGIN
const
  SecurityTokenStrings : array[TnxSecurityToken] of String = (
    'A',
    'R',
    'W');
//DOM-IGNORE-END

function FieldDataTypesMap(const s : string)
                                   : TnxFieldType;
function FieldDataTypesMapSQL(const s : string)
                                      : TnxFieldType;

const
  ParamTypeNames : array[TnxParamType] of string = (
    '',
    'IN',
    'OUT',
    'INOUT',
    'RESULT'
  );

function nxStrToParamType(const s : string)
                                  : TnxParamType;

implementation

uses
  SysUtils,
  Classes,
  nxllBde,
  nxllException;

var
  _FieldDataTypesMap : TStringList;
  _FieldDataTypesMapSQL: TStringList;

function FieldDataTypesMap(const s : string)
                                   : TnxFieldType;
var
  i: Integer;
begin
  with _FieldDataTypesMap do
    if Find(s, i) then
      Result := TnxFieldType(Integer(Objects[i]))
    else
      raise EnxBaseException.nxCreate(DBIERR_OBJNOTFOUND);
end;

function FieldDataTypesMapSQL(const s : string)
                                      : TnxFieldType;
var
  i: Integer;
begin
  with _FieldDataTypesMapSQL do
    if Find(s, i) then
      Result := TnxFieldType(Integer(Objects[i]))
    else
      raise EnxBaseException.nxCreate(DBIERR_OBJNOTFOUND);
end;

procedure InitFieldDataTypesMap;
var
  i: TnxFieldType;
begin
  _FieldDataTypesMap := TStringList.Create;

  for i := Low(i) to High(i) do
    _FieldDataTypesMap.AddObject(FieldDataTypes[i], TObject(Ord(i)));

  _FieldDataTypesMap.Sorted := True;

  _FieldDataTypesMapSQL := TStringList.Create;

  _FieldDataTypesMapSQL.Sorted := True;

  for i := Low(i) to High(i) do begin
    _FieldDataTypesMapSQL.AddObject(FieldDataTypeNames[i, fdtnSqlFixed], TObject(Ord(i)));
    if _FieldDataTypesMapSQL.IndexOf(FieldDataTypeNames[i, fdtnSqlVariable]) = -1 then
      _FieldDataTypesMapSQL.AddObject(FieldDataTypeNames[i, fdtnSqlVariable], TObject(Ord(i)));
  end;

end;

function nxStrToParamType(const s : string)
                                  : TnxParamType;
begin
  for Result := Low(ParamTypeNames) to High(ParamTypeNames) do
    if SameText(ParamTypeNames[Result], s) then
      Exit;
  Result := nxptUnknown;
end;

initialization
  {$IFDEF NX_PUBLICBETA}
  {$I PublicBeta\nxPublicBeta1.inc}
  {$ENDIF}
  InitFieldDataTypesMap;
finalization
  nxFreeAndNil(_FieldDataTypesMap);
  nxFreeAndNil(_FieldDataTypesMapSQL);
end.


