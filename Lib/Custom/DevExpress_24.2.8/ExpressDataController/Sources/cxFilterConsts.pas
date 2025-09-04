{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           ExpressDataController                                    }
{                                                                    }
{           Copyright (c) 1998-2025 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSDATACONTROLLER AND ALL         }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxFilterConsts;

{$I cxVer.inc}

interface

resourcestring
  // base operators
  cxSFilterOperatorEqual = 'igual';
  cxSFilterOperatorNotEqual = 'no es igual';
  cxSFilterOperatorLess = 'es menor que';
  cxSFilterOperatorLessEqual = 'es menor o igual que';
  cxSFilterOperatorGreater = 'es mayor que';
  cxSFilterOperatorGreaterEqual = 'es mayor o igual que';
  cxSFilterOperatorLike = 'como';
  cxSFilterOperatorNotLike = 'no como';
  cxSFilterOperatorBetween = 'entre';
  cxSFilterOperatorNotBetween = 'no entre';
  cxSFilterOperatorInList = 'en';
  cxSFilterOperatorNotInList = 'no en';

  cxSFilterOperatorYesterday = 'es ayer';
  cxSFilterOperatorToday = 'es hoy';
  cxSFilterOperatorTomorrow = 'es mañana';

  cxSFilterOperatorLast7Days = 'son los últimos 7 días';
  cxSFilterOperatorLastWeek = 'es la última semana';
  cxSFilterOperatorLast14Days = 'son los últimos 14 días';
  cxSFilterOperatorLastTwoWeeks = 'son las últimas 2 semanas';
  cxSFilterOperatorLast30Days = 'son los últimos 30 días';
  cxSFilterOperatorLastMonth = 'es el último mes';
  cxSFilterOperatorLastYear = 'es el último año';
  cxSFilterOperatorPast = 'es el pasado';

  cxSFilterOperatorThisWeek = 'es esta semana';
  cxSFilterOperatorThisMonth = 'es este mes';
  cxSFilterOperatorThisYear = 'es este año';

  cxSFilterOperatorNext7Days = 'son los próximos 7 días';
  cxSFilterOperatorNextWeek = 'es la próxima semana';
  cxSFilterOperatorNext14Days = 'son los próximos 14 días';
  cxSFilterOperatorNextTwoWeeks = 'son las próximas 2 semanas';
  cxSFilterOperatorNext30Days = 'son los próximos 30 días';
  cxSFilterOperatorNextMonth = 'es el próximo mes';
  cxSFilterOperatorNextYear = 'es el próximo año';
  cxSFilterOperatorFuture = 'es el futuro';

  cxSFilterAndCaption = 'y';
  cxSFilterOrCaption = 'o';
  cxSFilterNotCaption = 'no';
  cxSFilterBlankCaption = 'vacío';

  cxSFilterFromCaption = 'desde';
  cxSFilterToCaption = 'hasta';

  // derived
  cxSFilterOperatorIsNull = 'está vacío';
  cxSFilterOperatorIsNotNull = 'no está vacío';
  cxSFilterOperatorBeginsWith = 'empieza por';
  cxSFilterOperatorDoesNotBeginWith = 'no empieza por';
  cxSFilterOperatorEndsWith = 'acaba por';
  cxSFilterOperatorDoesNotEndWith = 'no acaba por';
  cxSFilterOperatorContains = 'contiene';
  cxSFilterOperatorDoesNotContain = 'no contiene';
  // filter listbox's values
  cxSFilterBoxAllCaption = '(Todo)';
  cxSFilterBoxCustomCaption = '(Personalizado...)';
  cxSFilterBoxBlanksCaption = '(Vacíos)';
  cxSFilterBoxNonBlanksCaption = '(No Vacíos)';

function cxSFilterString(AResString: Pointer): string;

type
  TcxFilterGetResourceStringFunc = function(
    AResString: Pointer): string;

var
  cxFilterGetResourceStringFunc: TcxFilterGetResourceStringFunc;

implementation

uses
  dxCore;

const
  dxThisUnitName = 'cxFilterConsts';

function cxSFilterString(
  AResString: Pointer): string;
begin
  if Assigned(cxFilterGetResourceStringFunc) then
    Result := cxFilterGetResourceStringFunc(AResString)
  else
    Result := LoadResString(AResString);
end;

procedure AddExpressDataFilterResourceStringNames(AProduct: TdxProductResourceStrings);

  procedure InternalAdd(const AResourceStringName: string; AAddress: Pointer);
  begin
    AProduct.Add(AResourceStringName, AAddress);
  end;

begin
  InternalAdd('cxSFilterOperatorEqual', @cxSFilterOperatorEqual);
  InternalAdd('cxSFilterOperatorNotEqual', @cxSFilterOperatorNotEqual);
  InternalAdd('cxSFilterOperatorLess', @cxSFilterOperatorLess);
  InternalAdd('cxSFilterOperatorLessEqual', @cxSFilterOperatorLessEqual);
  InternalAdd('cxSFilterOperatorGreater', @cxSFilterOperatorGreater);
  InternalAdd('cxSFilterOperatorGreaterEqual', @cxSFilterOperatorGreaterEqual);
  InternalAdd('cxSFilterOperatorLike', @cxSFilterOperatorLike);
  InternalAdd('cxSFilterOperatorNotLike', @cxSFilterOperatorNotLike);
  InternalAdd('cxSFilterOperatorBetween', @cxSFilterOperatorBetween);
  InternalAdd('cxSFilterOperatorNotBetween', @cxSFilterOperatorNotBetween);
  InternalAdd('cxSFilterOperatorInList', @cxSFilterOperatorInList);
  InternalAdd('cxSFilterOperatorNotInList', @cxSFilterOperatorNotInList);
  InternalAdd('cxSFilterOperatorYesterday', @cxSFilterOperatorYesterday);
  InternalAdd('cxSFilterOperatorToday', @cxSFilterOperatorToday);
  InternalAdd('cxSFilterOperatorTomorrow', @cxSFilterOperatorTomorrow);
  InternalAdd('cxSFilterOperatorLast7Days', @cxSFilterOperatorLast7Days);
  InternalAdd('cxSFilterOperatorLastWeek', @cxSFilterOperatorLastWeek);
  InternalAdd('cxSFilterOperatorLast14Days', @cxSFilterOperatorLast14Days);
  InternalAdd('cxSFilterOperatorLastTwoWeeks', @cxSFilterOperatorLastTwoWeeks);
  InternalAdd('cxSFilterOperatorLast30Days', @cxSFilterOperatorLast30Days);
  InternalAdd('cxSFilterOperatorLastMonth', @cxSFilterOperatorLastMonth);
  InternalAdd('cxSFilterOperatorLastYear', @cxSFilterOperatorLastYear);
  InternalAdd('cxSFilterOperatorPast', @cxSFilterOperatorPast);
  InternalAdd('cxSFilterOperatorThisWeek', @cxSFilterOperatorThisWeek);
  InternalAdd('cxSFilterOperatorThisMonth', @cxSFilterOperatorThisMonth);
  InternalAdd('cxSFilterOperatorThisYear', @cxSFilterOperatorThisYear);
  InternalAdd('cxSFilterOperatorNext7Days', @cxSFilterOperatorNext7Days);
  InternalAdd('cxSFilterOperatorNextWeek', @cxSFilterOperatorNextWeek);
  InternalAdd('cxSFilterOperatorNext14Days', @cxSFilterOperatorNext14Days);
  InternalAdd('cxSFilterOperatorNextTwoWeeks', @cxSFilterOperatorNextTwoWeeks);
  InternalAdd('cxSFilterOperatorNext30Days', @cxSFilterOperatorNext30Days);
  InternalAdd('cxSFilterOperatorNextMonth', @cxSFilterOperatorNextMonth);
  InternalAdd('cxSFilterOperatorNextYear', @cxSFilterOperatorNextYear);
  InternalAdd('cxSFilterOperatorFuture', @cxSFilterOperatorFuture);
  InternalAdd('cxSFilterAndCaption', @cxSFilterAndCaption);
  InternalAdd('cxSFilterOrCaption', @cxSFilterOrCaption);
  InternalAdd('cxSFilterNotCaption', @cxSFilterNotCaption);
  InternalAdd('cxSFilterBlankCaption', @cxSFilterBlankCaption);
  InternalAdd('cxSFilterFromCaption', @cxSFilterFromCaption);
  InternalAdd('cxSFilterToCaption', @cxSFilterToCaption);
  InternalAdd('cxSFilterOperatorIsNull', @cxSFilterOperatorIsNull);
  InternalAdd('cxSFilterOperatorIsNotNull', @cxSFilterOperatorIsNotNull);
  InternalAdd('cxSFilterOperatorBeginsWith', @cxSFilterOperatorBeginsWith);
  InternalAdd('cxSFilterOperatorDoesNotBeginWith', @cxSFilterOperatorDoesNotBeginWith);
  InternalAdd('cxSFilterOperatorEndsWith', @cxSFilterOperatorEndsWith);
  InternalAdd('cxSFilterOperatorDoesNotEndWith', @cxSFilterOperatorDoesNotEndWith);
  InternalAdd('cxSFilterOperatorContains', @cxSFilterOperatorContains);
  InternalAdd('cxSFilterOperatorDoesNotContain', @cxSFilterOperatorDoesNotContain);
  InternalAdd('cxSFilterBoxAllCaption', @cxSFilterBoxAllCaption);
  InternalAdd('cxSFilterBoxCustomCaption', @cxSFilterBoxCustomCaption);
  InternalAdd('cxSFilterBoxBlanksCaption', @cxSFilterBoxBlanksCaption);
  InternalAdd('cxSFilterBoxNonBlanksCaption', @cxSFilterBoxNonBlanksCaption);
end;


initialization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.RegisterProduct('ExpressDataFilter', @AddExpressDataFilterResourceStringNames);
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
finalization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.UnRegisterProduct('ExpressDataFilter');
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
end.
