{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           ExpressFilterControl                                     }
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

unit cxFilterControlStrs;

{$I cxVer.inc}

interface

resourcestring
  // cxFilterBoolOperator
  cxSFilterBoolOperatorAnd = 'Y';        // all
  cxSFilterBoolOperatorOr = 'O';          // any
  cxSFilterBoolOperatorNotAnd = 'Y NO'; // not all
  cxSFilterBoolOperatorNotOr = 'O NO';   // not any
  //
  cxSFilterRootButtonCaption = 'Filtro';
  cxSFilterAddCondition = 'Añadir &Condición';
  cxSFilterAddGroup = 'Añadir &Grupo';
  cxSFilterRemoveRow = '&Quitar Fila';
  cxSFilterClearAll = 'Limpiar &Todo';
  cxSFilterFooterAddCondition = 'Pulse este botón para añadir una nueva condición';

  cxSFilterGroupCaption = 'se aplica a las siguientes condiciones';
  cxSFilterRootGroupCaption = '<raiz>';
  cxSFilterControlNullString = '<vacío>';

  cxSFilterErrorBuilding = 'No puedo construir el filtro desde esta fuente';

  //FilterDialog
  cxSFilterDialogCaption = 'Filtro personalizado';
  cxSFilterDialogInvalidValue = 'Valor incorrecto';
  cxSFilterDialogUse = 'Use';
  cxSFilterDialogSingleCharacter = ' para representar cualquier carácter';
  cxSFilterDialogCharactersSeries = ' para representar cualquier serie de caracteres';
  cxSFilterDialogOperationAnd = 'Y';
  cxSFilterDialogOperationOr = 'O';
  cxSFilterDialogRows = 'Mostrar filas donde:';

  // FilterControlDialog
  cxSFilterControlDialogCaption = 'Diseñador de filtros';
  cxSFilterControlDialogNewFile = 'sintitulo.flt';
  cxSFilterControlDialogOpenDialogCaption = 'Abrir un filtro existente';
  cxSFilterControlDialogSaveDialogCaption = 'Guardar el filtro activo en un fichero';
  cxSFilterControlDialogActionSaveCaption = '&Guardar...';
  cxSFilterControlDialogActionSaveHint = 'Guardar como|Guarda el filtro activo con un nuevo nombre';  
  cxSFilterControlDialogActionOpenCaption = '&Abrir...';
cxSFilterControlDialogActionOpenHint = 'Abrir|Abre un filtro existente';
  cxSFilterControlDialogActionApplyCaption = '&Aplicar';
  cxSFilterControlDialogActionOkCaption = 'Aceptar';
  cxSFilterControlDialogActionCancelCaption = 'Cancelar';
  cxSFilterControlDialogFileExt = 'flt';
  cxSFilterControlDialogFileFilter = 'Filtros (*.flt)|*.flt';

implementation

uses
  dxCore;

const
  dxThisUnitName = 'cxFilterControlStrs';

procedure AddExpressFilterControlResourceStringNames(AProduct: TdxProductResourceStrings);

  procedure InternalAdd(const AResourceStringName: string; AAddress: Pointer);
  begin
    AProduct.Add(AResourceStringName, AAddress);
  end;

begin
  InternalAdd('cxSFilterBoolOperatorAnd', @cxSFilterBoolOperatorAnd);
  InternalAdd('cxSFilterBoolOperatorOr', @cxSFilterBoolOperatorOr);
  InternalAdd('cxSFilterBoolOperatorNotAnd', @cxSFilterBoolOperatorNotAnd);
  InternalAdd('cxSFilterBoolOperatorNotOr', @cxSFilterBoolOperatorNotOr);
  InternalAdd('cxSFilterRootButtonCaption', @cxSFilterRootButtonCaption);
  InternalAdd('cxSFilterAddCondition', @cxSFilterAddCondition);
  InternalAdd('cxSFilterAddGroup', @cxSFilterAddGroup);
  InternalAdd('cxSFilterRemoveRow', @cxSFilterRemoveRow);
  InternalAdd('cxSFilterClearAll', @cxSFilterClearAll);
  InternalAdd('cxSFilterFooterAddCondition', @cxSFilterFooterAddCondition);
  InternalAdd('cxSFilterGroupCaption', @cxSFilterGroupCaption);
  InternalAdd('cxSFilterRootGroupCaption', @cxSFilterRootGroupCaption);
  InternalAdd('cxSFilterControlNullString', @cxSFilterControlNullString);
  InternalAdd('cxSFilterErrorBuilding', @cxSFilterErrorBuilding);
  InternalAdd('cxSFilterDialogCaption', @cxSFilterDialogCaption);
  InternalAdd('cxSFilterDialogInvalidValue', @cxSFilterDialogInvalidValue);
  InternalAdd('cxSFilterDialogUse', @cxSFilterDialogUse);
  InternalAdd('cxSFilterDialogSingleCharacter', @cxSFilterDialogSingleCharacter);
  InternalAdd('cxSFilterDialogCharactersSeries', @cxSFilterDialogCharactersSeries);
  InternalAdd('cxSFilterDialogOperationAnd', @cxSFilterDialogOperationAnd);
  InternalAdd('cxSFilterDialogOperationOr', @cxSFilterDialogOperationOr);
  InternalAdd('cxSFilterDialogRows', @cxSFilterDialogRows);
  InternalAdd('cxSFilterControlDialogCaption', @cxSFilterControlDialogCaption);
  InternalAdd('cxSFilterControlDialogNewFile', @cxSFilterControlDialogNewFile);
  InternalAdd('cxSFilterControlDialogOpenDialogCaption', @cxSFilterControlDialogOpenDialogCaption);
  InternalAdd('cxSFilterControlDialogSaveDialogCaption', @cxSFilterControlDialogSaveDialogCaption);
  InternalAdd('cxSFilterControlDialogActionSaveCaption', @cxSFilterControlDialogActionSaveCaption);
  InternalAdd('cxSFilterControlDialogActionSaveHint', @cxSFilterControlDialogActionSaveHint);
  InternalAdd('cxSFilterControlDialogActionOpenCaption', @cxSFilterControlDialogActionOpenCaption);
  InternalAdd('cxSFilterControlDialogActionOpenHint', @cxSFilterControlDialogActionOpenHint);
  InternalAdd('cxSFilterControlDialogActionApplyCaption', @cxSFilterControlDialogActionApplyCaption);
  InternalAdd('cxSFilterControlDialogActionOkCaption', @cxSFilterControlDialogActionOkCaption);
  InternalAdd('cxSFilterControlDialogActionCancelCaption', @cxSFilterControlDialogActionCancelCaption);
  InternalAdd('cxSFilterControlDialogFileExt', @cxSFilterControlDialogFileExt);
  InternalAdd('cxSFilterControlDialogFileFilter', @cxSFilterControlDialogFileFilter);
end;


initialization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.RegisterProduct('ExpressFilterControl', @AddExpressFilterControlResourceStringNames);
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
finalization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.UnRegisterProduct('ExpressFilterControl');
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
end.
