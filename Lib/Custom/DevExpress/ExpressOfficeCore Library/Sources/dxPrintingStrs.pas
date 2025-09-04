{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           ExpressOfficeCore Library classes                        }
{                                                                    }
{           Copyright (c) 2000-2025 Developer Express Inc.           }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSOFFICECORE LIBRARY AND ALL     }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM       }
{   ONLY.                                                            }
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

unit dxPrintingStrs;

interface

{$I cxVer.inc}

resourcestring
  sdxPrintDialogAll = '&Todo';
  sdxPrintDialogCurrentPage = 'P�gina ac&tual';
  sdxPrintDialogInvalidPageRanges = 'Rango no v�lido';
  sdxPrintDialogPageNumbersOutOfRange = 'N�meros de p�gina fuera de rango (%d - %d)';
  sdxPrintDialogPages = '&P�ginas:';
  sdxPrintDialogRangeLegend = 'Introduzca el n�mero de p�gina y/o el rango separado por comas. Por ejemplo: 1,3,5-12.';
  sdxPrintDialogSelection = '&Selecci�n';

implementation

uses
  dxCore;

const
  dxThisUnitName = 'dxPrintingStrs';

procedure AddResourceStringsPart(AProduct: TdxProductResourceStrings);
begin
  AProduct.Add('sdxPrintDialogAll', @sdxPrintDialogAll);
  AProduct.Add('sdxPrintDialogCurrentPage', @sdxPrintDialogCurrentPage);
  AProduct.Add('sdxPrintDialogInvalidPageRanges', @sdxPrintDialogInvalidPageRanges);
  AProduct.Add('sdxPrintDialogPageNumbersOutOfRange', @sdxPrintDialogPageNumbersOutOfRange);
  AProduct.Add('sdxPrintDialogPages', @sdxPrintDialogPages);
  AProduct.Add('sdxPrintDialogRangeLegend', @sdxPrintDialogRangeLegend);
  AProduct.Add('sdxPrintDialogSelection', @sdxPrintDialogSelection);
end;


initialization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.RegisterProduct('ExpressOfficeCore Library', @AddResourceStringsPart);
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
finalization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.UnRegisterProduct('ExpressOfficeCore Library');
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
end.
