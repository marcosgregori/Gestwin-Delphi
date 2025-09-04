{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           ExpressEditors                                           }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSEDITORS AND ALL                }
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

unit cxGridPopupMenuConsts;

{$I cxVer.inc}

interface

uses
  cxClasses, cxCustomData, dxCore;

resourcestring
  cxSGridNone = 'Ninguno';

  // Header popup menu item captions

  cxSGridSortColumnAsc = 'Ascendente';
  cxSGridSortColumnDesc = 'Descendente';
  cxSGridClearSorting = 'Quitar Ordenación';
  cxSGridGroupByThisField = 'Agrupar por este campo';
  cxSGridRemoveThisGroupItem = 'Quitar de la agrupación';
  cxSGridGroupByBox = 'Agrupar por';
  cxSGridAlignmentSubMenu = 'Alineación';
  cxSGridAlignLeft = 'Alinear por la izquierda';
  cxSGridAlignRight = 'Alinear por la derecha';
  cxSGridAlignCenter = 'Alinear por el centro';
  cxSGridRemoveColumn = 'Quitar esta columna';
  cxSGridFieldChooser = 'selector de campos';
  cxSGridBestFit = 'Mejor distribución';
  cxSGridBestFitAllColumns = 'Mejor distribución (todas las columnas)';
  cxSGridShowFooter = 'Pie';
  cxSGridShowGroupFooter = 'Pies de grupo';
  cxSGridShowFindPanel = 'Encuentra panel';
  cxSGridShowExpressionEditor = 'Edtor de expresiones...';
  cxSGridFullExpand = 'Expandir';
  cxSGridFullCollapse = 'Colapsar';
  cxSGridClearGrouping = 'Limpiar agrupación';
  cxSGridHideGroupByBox = 'Ocultar caja agrupación';

  // Footer popup menu item captions

  cxSGridNoneMenuItem = 'Ninguno';
  cxSGridSumMenuItem = 'Suma';
  cxSGridMinMenuItem = 'Minimo';
  cxSGridMaxMenuItem = 'Maximo';
  cxSGridCountMenuItem = 'Contador';
  cxSGridAvgMenuItem = 'Media';

  // Group row popup menu item captions

  cxSGridSortByGroupValues = 'Ordenar por valor del grupo';
  cxSGridSortBySummaryCaption = 'Ordenar por sumario del grupo:';
  cxSGridSortBySummary = '%s para %s';

function GetSummaryName(ASummaryKind: TcxSummaryKind): TcxResourceStringID;

implementation

const
  dxThisUnitName = 'cxGridPopupMenuConsts';

function GetSummaryName(ASummaryKind: TcxSummaryKind): TcxResourceStringID;
const
  SummaryNames: array[TcxSummaryKind] of TcxResourceStringID = (
    @cxSGridNoneMenuItem,
    @cxSGridSumMenuItem,
    @cxSGridMinMenuItem,
    @cxSGridMaxMenuItem,
    @cxSGridCountMenuItem,
    @cxSGridAvgMenuItem);
begin
  Result := SummaryNames[ASummaryKind];
end;

procedure AddcxGridPopupMenuResourceStringNames(AProduct: TdxProductResourceStrings);

  procedure InternalAdd(const AResourceStringName: string; AAddress: Pointer);
  begin
    AProduct.Add(AResourceStringName, AAddress);
  end;

begin
  InternalAdd('cxSGridNone', @cxSGridNone);
  InternalAdd('cxSGridSortColumnAsc', @cxSGridSortColumnAsc);
  InternalAdd('cxSGridSortColumnDesc', @cxSGridSortColumnDesc);
  InternalAdd('cxSGridClearSorting', @cxSGridClearSorting);
  InternalAdd('cxSGridGroupByThisField', @cxSGridGroupByThisField);
  InternalAdd('cxSGridRemoveThisGroupItem', @cxSGridRemoveThisGroupItem);
  InternalAdd('cxSGridGroupByBox', @cxSGridGroupByBox);
  InternalAdd('cxSGridAlignmentSubMenu', @cxSGridAlignmentSubMenu);
  InternalAdd('cxSGridAlignLeft', @cxSGridAlignLeft);
  InternalAdd('cxSGridAlignRight', @cxSGridAlignRight);
  InternalAdd('cxSGridAlignCenter', @cxSGridAlignCenter);
  InternalAdd('cxSGridRemoveColumn', @cxSGridRemoveColumn);
  InternalAdd('cxSGridFieldChooser', @cxSGridFieldChooser);
  InternalAdd('cxSGridBestFit', @cxSGridBestFit);
  InternalAdd('cxSGridBestFitAllColumns', @cxSGridBestFitAllColumns);
  InternalAdd('cxSGridShowFooter', @cxSGridShowFooter);
  InternalAdd('cxSGridShowGroupFooter', @cxSGridShowGroupFooter);
  InternalAdd('cxSGridShowFindPanel', @cxSGridShowFindPanel);
  InternalAdd('cxSGridShowExpressionEditor', @cxSGridShowExpressionEditor);
  InternalAdd('cxSGridFullExpand', @cxSGridFullExpand);
  InternalAdd('cxSGridFullCollapse', @cxSGridFullCollapse);
  InternalAdd('cxSGridClearGrouping', @cxSGridClearGrouping);
  InternalAdd('cxSGridHideGroupByBox', @cxSGridHideGroupByBox);
  InternalAdd('cxSGridNoneMenuItem', @cxSGridNoneMenuItem);
  InternalAdd('cxSGridSumMenuItem', @cxSGridSumMenuItem);
  InternalAdd('cxSGridMinMenuItem', @cxSGridMinMenuItem);
  InternalAdd('cxSGridMaxMenuItem', @cxSGridMaxMenuItem);
  InternalAdd('cxSGridCountMenuItem', @cxSGridCountMenuItem);
  InternalAdd('cxSGridAvgMenuItem', @cxSGridAvgMenuItem);
  InternalAdd('cxSGridSortByGroupValues', @cxSGridSortByGroupValues);
  InternalAdd('cxSGridSortBySummaryCaption', @cxSGridSortBySummaryCaption);
  InternalAdd('cxSGridSortBySummary', @cxSGridSortBySummary);
end;


initialization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.RegisterProduct('cxGridPopupMenu', @AddcxGridPopupMenuResourceStringNames);
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
finalization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.UnRegisterProduct('cxGridPopupMenu');
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
end.
