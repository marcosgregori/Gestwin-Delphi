{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           ExpressExport                                            }
{                                                                    }
{           Copyright (c) 2001-2025 Developer Express Inc.           }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSEXPORT AND ALL                 }
{   ACCOMPANYING VCL AND CLX CONTROLS AS PART OF AN EXECUTABLE       }
{   PROGRAM ONLY.                                                    }
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

unit cxExportStrs;

{$I cxVer.inc}

interface

resourcestring
  scxUnsupportedExport = 'Tipo de exportación no soportado : %1';
  scxStyleManagerKill = 'El gestor de estilos está actualmente en uso y no puede ser liberado en este momento';
  scxStyleManagerCreate = 'No puedo crear el gestor de estilos';

  scxExportToCSV  = 'Exportar a texto delimitado por comas (*.csv)';
  scxExportToHtml  = 'Exportar a página Web (*.html)';
  scxExportToXml   = 'Exportar a documento XML (*.xml)';
  scxExportToText  = 'Exportar a fichero de texto (*.txt)';

  scxEmptyExportCache = 'La caché de exportación está vacía';
  scxIncorrectUnion = 'Union de celdas incorrecto';
  scxIllegalWidth = 'Anchura de columna ilegal';
  scxInvalidColumnRowCount = 'Numero de columna o fila no válidos';
  scxIllegalHeight = 'Altura de la fila no válida';
  scxInvalidColumnIndex = 'La índice de la columna  %d está fuera de límites';
  scxInvalidRowIndex = 'El índice de la fila %d está fuera de límites';
  scxInvalidStyleIndex = 'Indice %d de estilo incorrecto';

  scxExportToExcel = 'Exportar a MS Excel (*.xls)';
  scxExportToXlsx  = 'Export a MS Excel 2007 (*.xlsx)';
  scxWorkbookWrite = 'Error escribiendo en el fichero XLS';
  scxInvalidCellDimension = 'Dimension de celda no válida';
  scxBoolTrue  = 'Verdadero';
  scxBoolFalse = 'Falso';

  scxDefaultSheetCaption = 'Hoja';


implementation

uses
  dxCore;

const
  dxThisUnitName = 'cxExportStrs';

  procedure AddExpressExportResourceStringNames(AProduct: TdxProductResourceStrings);

  procedure InternalAdd(const AResourceStringName: string; AAddress: Pointer);
  begin
    AProduct.Add(AResourceStringName, AAddress);
  end;

begin
  InternalAdd('scxUnsupportedExport', @scxUnsupportedExport);
  InternalAdd('scxStyleManagerKill', @scxStyleManagerKill);
  InternalAdd('scxStyleManagerCreate', @scxStyleManagerCreate);
  InternalAdd('scxExportToCSV', @scxExportToCSV);
  InternalAdd('scxExportToHtml', @scxExportToHtml);
  InternalAdd('scxExportToXml', @scxExportToXml);
  InternalAdd('scxExportToText', @scxExportToText);
  InternalAdd('scxEmptyExportCache', @scxEmptyExportCache);
  InternalAdd('scxIncorrectUnion', @scxIncorrectUnion);
  InternalAdd('scxIllegalWidth', @scxIllegalWidth);
  InternalAdd('scxInvalidColumnRowCount', @scxInvalidColumnRowCount);
  InternalAdd('scxIllegalHeight', @scxIllegalHeight);
  InternalAdd('scxInvalidColumnIndex', @scxInvalidColumnIndex);
  InternalAdd('scxInvalidRowIndex', @scxInvalidRowIndex);
  InternalAdd('scxInvalidStyleIndex', @scxInvalidStyleIndex);
  InternalAdd('scxExportToExcel', @scxExportToExcel);
  InternalAdd('scxExportToXlsx', @scxExportToXlsx);
  InternalAdd('scxWorkbookWrite', @scxWorkbookWrite);
  InternalAdd('scxInvalidCellDimension', @scxInvalidCellDimension);
  InternalAdd('scxBoolTrue', @scxBoolTrue);
  InternalAdd('scxBoolFalse', @scxBoolFalse);
  InternalAdd('scxDefaultSheetCaption', @scxDefaultSheetCaption);
end;


initialization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.RegisterProduct('ExpressExport', @AddExpressExportResourceStringNames);
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
finalization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.UnRegisterProduct('ExpressExport');
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
end.
