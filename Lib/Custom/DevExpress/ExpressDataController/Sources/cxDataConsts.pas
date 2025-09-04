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

unit cxDataConsts;

{$I cxVer.inc}

interface

resourcestring
  // Data
  cxSDataReadError = 'Error de lectura';
  cxSDataWriteError = 'Error de escritura';
  cxSDataItemExistError = 'El elemento ya existe';
  cxSDataRecordIndexError = 'Indice de registro fuera de rango';
  cxSDataItemIndexError = 'Indice de elemento fuera de rango';
  cxSDataProviderModeError = 'Esta operación no está soportada en modo proveedor';
  cxSDataInvalidStreamFormat = 'Formato no válido';
  cxSDataRowIndexError = 'Indice de fila fuera de rango';
//  cxSDataRelationItemExistError = 'Relation Item already exists'; 
//  cxSDataRelationCircularReference = 'Circular Reference on Detail DataController';
//  cxSDataRelationMultiReferenceError = 'Reference on Detail DataController already exists';
  cxSDataCustomDataSourceInvalidCompare = '"GetInfoForCompare" no implementado';
  // DB
//  cxSDBDataSetNil = 'DataSet is nil';
  cxSDBDetailFilterControllerNotFound = '"DetailFilterController" no encontrado';
  cxSDBNotInGridMode = 'El controlador de datos no está en modo rejilla';
  cxSDBKeyFieldNotFound = 'Campo clave no encontrado';
  cxSDataSumSummaryKind = 'SUM';
  cxSDataMinSummaryKind = 'MIN';
  cxSDataMaxSummaryKind = 'MAX';
  cxSDataCountSummaryKind = 'COUNT';
  cxSDataAvgSummaryKind = 'AVG';

implementation                               

uses
  dxCore;

const
  dxThisUnitName = 'cxDataConsts';

procedure AddExpressDataControllerResourceStringNames(AProduct: TdxProductResourceStrings);

  procedure InternalAdd(const AResourceStringName: string; AAddress: Pointer);
  begin
    AProduct.Add(AResourceStringName, AAddress);
  end;

begin
  InternalAdd('cxSDataReadError', @cxSDataReadError);
  InternalAdd('cxSDataWriteError', @cxSDataWriteError);
  InternalAdd('cxSDataItemExistError', @cxSDataItemExistError);
  InternalAdd('cxSDataRecordIndexError', @cxSDataRecordIndexError);
  InternalAdd('cxSDataItemIndexError', @cxSDataItemIndexError);
  InternalAdd('cxSDataProviderModeError', @cxSDataProviderModeError);
  InternalAdd('cxSDataInvalidStreamFormat', @cxSDataInvalidStreamFormat);
  InternalAdd('cxSDataRowIndexError', @cxSDataRowIndexError);
  InternalAdd('cxSDataCustomDataSourceInvalidCompare', @cxSDataCustomDataSourceInvalidCompare);
  InternalAdd('cxSDBDetailFilterControllerNotFound', @cxSDBDetailFilterControllerNotFound);
  InternalAdd('cxSDBNotInGridMode', @cxSDBNotInGridMode);
  InternalAdd('cxSDBKeyFieldNotFound', @cxSDBKeyFieldNotFound);
  InternalAdd('cxSDataSumSummaryKind', @cxSDataSumSummaryKind);
  InternalAdd('cxSDataMinSummaryKind', @cxSDataMinSummaryKind);
  InternalAdd('cxSDataMaxSummaryKind', @cxSDataMaxSummaryKind);
  InternalAdd('cxSDataCountSummaryKind', @cxSDataCountSummaryKind);
  InternalAdd('cxSDataAvgSummaryKind', @cxSDataAvgSummaryKind);
end;


initialization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.RegisterProduct('ExpressDataController', @AddExpressDataControllerResourceStringNames);
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
finalization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.UnRegisterProduct('ExpressDataController');
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
end.
