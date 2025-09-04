{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           ExpressQuantumGrid                                       }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL            }
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

unit cxGridStrs;

{$I cxVer.inc}

interface

resourcestring
  scxGridRecursiveLevels = 'No puede crear niveles recursivos';

  scxGridDeletingConfirmationCaption = 'Confirme';
  scxGridDeletingFocusedConfirmationText = '¿Suprimir el registro?';
  scxGridDeletingSelectedConfirmationText = '¿Suprimir todos los registros seleccionados?';

  scxGridNoDataInfoText = '<No hay datos que mostrar>';

  scxGridFilterRowInfoText = 'Haga <Click> aquí para definir un filtro';
  scxGridNewItemRowInfoText = 'Haga <Click> aquí para añadir una nueva fila';

  scxGridFindPanelClearButtonCaption = 'Limpiar';
  scxGridFindPanelFindButtonCaption = 'Buscar';
  scxGridFindPanelNextButtonCaption = 'Siguiente';
  scxGridFindPanelPreviousButtonCaption = 'Anterior';
  scxGridFindPanelInfoText = 'Introduzca el texto a buscar...';

  scxGridFilterIsEmpty = '<El filtro está vacío>';

  scxGridCustomizationFormCaption = 'Personalización';
  scxGridCustomizationFormColumnsPageCaption = 'Columnas';
  scxGridGroupByBoxCaption = 'Arrastre una columna aquí para agrupar por ella';
  scxGridFilterApplyButtonCaption = 'Aplicar filtro'; 
  scxGridFilterCustomizeButtonCaption = 'Personalizar...';
  scxGridColumnsQuickCustomizationHint = 'Haga <Click> aquí para seleccionar las columnas visibles';

  scxGridCustomizationFormBandsPageCaption = 'Bandas';
  scxGridBandsQuickCustomizationHint = 'Haga <Click> aquí para seleccionar las bandas visibles';

  scxGridCustomizationFormRowsPageCaption = 'Filas';

  scxGridConverterIntermediaryMissing = '¡Falta un componente intermedio!'#13#10'Por favor, añada un componente %s al formulario.';
  scxGridConverterNotExistGrid = 'cxGrid no existe';
  scxGridConverterNotExistComponent = 'El componente no existe';
  scxImportErrorCaption = 'Error de importación';

  scxNotExistGridView = 'La vista no existe';

  cxSEditRepositoryExtLookupComboBoxItem = 'ExtLookupComboBox|Es un componente avanzado que utiliza QuantumGrid como su control de consulta';

  // date ranges

  scxGridYesterday = 'Ayer';
  scxGridToday = 'Hoy';
  scxGridTomorrow = 'Mañana';
  scxGridLast30Days = 'Últimos 30 dias';
  scxGridLast14Days = 'Últimos 14 días';
  scxGridLast7Days = 'Últimos 7 días';
  scxGridNext7Days = 'Próximos 7 días';
  scxGridNext14Days = 'Próximos 14 días';
  scxGridNext30Days = 'Próximos 30 días';
  scxGridLastTwoWeeks = 'Últimas dos semanas';
  scxGridLastWeek = 'Última semana';
  scxGridThisWeek = 'Esta semana';
  scxGridNextWeek = 'Próxima semana';
  scxGridNextTwoWeeks = 'Próximas dos semanas';
  scxGridLastMonth = 'Último mes';
  scxGridThisMonth = 'Este mes';
  scxGridNextMonth = 'Próximo mes';
  scxGridLastYear = 'Último año';
  scxGridThisYear = 'Este año';
  scxGridNextYear = 'Próximo año';
  scxGridPast = 'Pasado';
  scxGridFuture = 'Futuro';

  scxGridMonthFormat = 'mmmm yyyy';
  scxGridYearFormat = 'yyyy';

  // ChartView
  
  scxGridChartCategoriesDisplayText = 'Datos';

  scxGridChartValueHintFormat = '%s %s = %s';  // series display text, category, value
  scxGridChartPercentValueTickMarkLabelFormat = '0%';

  scxGridChartToolBoxDataLevels = 'Niveles de datos:';
  scxGridChartToolBoxDataLevelSelectValue = 'selecione valor';
  scxGridChartToolBoxCustomizeButtonCaption = 'Personalizar Gráfica';

  scxGridChartNoneDiagramDisplayText = 'Sin diagrama';
  scxGridChartColumnDiagramDisplayText = 'Diagrama de columna';
  scxGridChartBarDiagramDisplayText = 'Diagrama de barras';
  scxGridChartLineDiagramDisplayText = 'Diagrama de líneas';
  scxGridChartAreaDiagramDisplayText = 'Diagrama de áreas';
  scxGridChartPieDiagramDisplayText = 'Diagrama de pastel';
  scxGridChartStackedBarDiagramDisplayText = 'Diagrama de barras apiladas';
  scxGridChartStackedColumnDiagramDisplayText = 'Diagrama de columnas apiladas';
  scxGridChartStackedAreaDiagramDisplayText = 'Diagrama de áreas apiladas';

  scxGridChartCustomizationFormSeriesPageCaption = 'Series';
  scxGridChartCustomizationFormSortBySeries = 'Ordenar por:';
  scxGridChartCustomizationFormNoSortedSeries = '<Ninguna serie>';
  scxGridChartCustomizationFormDataGroupsPageCaption = 'Grupos de datos';
  scxGridChartCustomizationFormOptionsPageCaption = 'Opciones';

  scxGridChartLegend = 'Leyenda';
  scxGridChartLegendKeyBorder = 'Cuadro explicativo';
  scxGridChartPosition = 'Posición';
  scxGridChartPositionDefault = 'Defecto';
  scxGridChartPositionNone = 'Ninguno';
  scxGridChartPositionLeft = 'Izquierda';
  scxGridChartPositionTop = 'Arriba';
  scxGridChartPositionRight = 'Derecha';
  scxGridChartPositionBottom = 'Abajo';
  scxGridChartAlignment = 'Alineación';
  scxGridChartAlignmentDefault = 'Defecto';
  scxGridChartAlignmentStart = 'Inicio';
  scxGridChartAlignmentCenter = 'Centro';
  scxGridChartAlignmentEnd = 'Fin';
  scxGridChartOrientation = 'Orientación';
  scxGridChartOrientationDefault = 'Defecto';
  scxGridChartOrientationHorizontal = 'Horizontal';
  scxGridChartOrientationVertical = 'Vertical';
  scxGridChartBorder = 'Borde';
  scxGridChartTitle = 'Título';
  scxGridChartToolBox = 'Herramientas';
  scxGridChartDiagramSelector = 'Selector de diagrama';
  scxGridChartOther = 'Otro';
  scxGridChartValueHints = 'Mostrar valores';

  scxGridLayoutViewCustomizeFormOk = 'Aceptar';
  scxGridLayoutViewCustomizeFormCancel = 'Cancelar';
  scxGridLayoutViewCustomizeFormApply = 'Aplicar';
  scxGridLayoutViewCustomizeWarningDialogCaption = 'Aviso';
  scxGridLayoutViewCustomizeWarningDialogMessage = 'La disposición ha cambiado. ¿Quiere guardar los cambios?';
  scxGridLayoutViewCustomizeLayoutButtonCaption = 'Editor de disposición';
  scxGridLayoutViewCustomizeFormTemplateCard = 'Plantilla';
  scxGridLayoutViewCustomizeFormViewLayout = 'Vista de disposición';
  scxGridLayoutViewRecordCaptionDefaultMask = '[RecordIndex] de [RecordCount]';

  scxGridLockedStateImageText = 'Por favor, espere...';

  scxGridInplaceEditFormButtonCancel = 'Cancelar';
  scxGridInplaceEditFormButtonClose = 'Cerrar';
  scxGridInplaceEditFormButtonUpdate = 'Actualizar';
  scxGridInplaceEditFormSaveChangesQuery = 'A modificado los datos. ¿Desea guardar los cambios?';

  scxGridDataRowFixingPopupCommandUnfix = 'Unfix';
  scxGridDataRowFixingPopupCommandFixToTop = 'Fix to Top';
  scxGridDataRowFixingPopupCommandFixToBottom = 'Fix to Bottom';

implementation

uses
  dxCore;

const
  dxThisUnitName = 'cxGridStrs';

procedure AddcxGridResourceStringNames(AProduct: TdxProductResourceStrings);

  procedure InternalAdd(const AResourceStringName: string; AAddress: Pointer);
  begin
    AProduct.Add(AResourceStringName, AAddress);
  end;

begin
  InternalAdd('scxGridRecursiveLevels', @scxGridRecursiveLevels);
  InternalAdd('scxGridDeletingFocusedConfirmationText', @scxGridDeletingFocusedConfirmationText);
  InternalAdd('scxGridDeletingSelectedConfirmationText', @scxGridDeletingSelectedConfirmationText);
  InternalAdd('scxGridNoDataInfoText', @scxGridNoDataInfoText);
  InternalAdd('scxGridFilterRowInfoText', @scxGridFilterRowInfoText);
  InternalAdd('scxGridNewItemRowInfoText', @scxGridNewItemRowInfoText);
  InternalAdd('scxGridFindPanelClearButtonCaption', @scxGridFindPanelClearButtonCaption);
  InternalAdd('scxGridFindPanelFindButtonCaption', @scxGridFindPanelFindButtonCaption);
  InternalAdd('scxGridFindPanelNextButtonCaption', @scxGridFindPanelNextButtonCaption);
  InternalAdd('scxGridFindPanelPreviousButtonCaption', @scxGridFindPanelPreviousButtonCaption);
  InternalAdd('scxGridFindPanelInfoText', @scxGridFindPanelInfoText);
  InternalAdd('scxGridFilterIsEmpty', @scxGridFilterIsEmpty);
  InternalAdd('scxGridCustomizationFormCaption', @scxGridCustomizationFormCaption);
  InternalAdd('scxGridCustomizationFormColumnsPageCaption', @scxGridCustomizationFormColumnsPageCaption);
  InternalAdd('scxGridGroupByBoxCaption', @scxGridGroupByBoxCaption);
  InternalAdd('scxGridFilterApplyButtonCaption', @scxGridFilterApplyButtonCaption);
  InternalAdd('scxGridFilterCustomizeButtonCaption', @scxGridFilterCustomizeButtonCaption);
  InternalAdd('scxGridColumnsQuickCustomizationHint', @scxGridColumnsQuickCustomizationHint);
  InternalAdd('scxGridCustomizationFormBandsPageCaption', @scxGridCustomizationFormBandsPageCaption);
  InternalAdd('scxGridBandsQuickCustomizationHint', @scxGridBandsQuickCustomizationHint);
  InternalAdd('scxGridCustomizationFormRowsPageCaption', @scxGridCustomizationFormRowsPageCaption);
  InternalAdd('scxGridConverterIntermediaryMissing', @scxGridConverterIntermediaryMissing);
  InternalAdd('scxGridConverterNotExistGrid', @scxGridConverterNotExistGrid);
  InternalAdd('scxGridConverterNotExistComponent', @scxGridConverterNotExistComponent);
  InternalAdd('scxImportErrorCaption', @scxImportErrorCaption);
  InternalAdd('scxNotExistGridView', @scxNotExistGridView);
  InternalAdd('cxSEditRepositoryExtLookupComboBoxItem', @cxSEditRepositoryExtLookupComboBoxItem);
  InternalAdd('scxGridYesterday', @scxGridYesterday);
  InternalAdd('scxGridToday', @scxGridToday);
  InternalAdd('scxGridTomorrow', @scxGridTomorrow);
  InternalAdd('scxGridLast30Days', @scxGridLast30Days);
  InternalAdd('scxGridLast14Days', @scxGridLast14Days);
  InternalAdd('scxGridLast7Days', @scxGridLast7Days);
  InternalAdd('scxGridNext7Days', @scxGridNext7Days);
  InternalAdd('scxGridNext14Days', @scxGridNext14Days);
  InternalAdd('scxGridNext30Days', @scxGridNext30Days);
  InternalAdd('scxGridLastTwoWeeks', @scxGridLastTwoWeeks);
  InternalAdd('scxGridLastWeek', @scxGridLastWeek);
  InternalAdd('scxGridThisWeek', @scxGridThisWeek);
  InternalAdd('scxGridNextWeek', @scxGridNextWeek);
  InternalAdd('scxGridNextTwoWeeks', @scxGridNextTwoWeeks);
  InternalAdd('scxGridLastMonth', @scxGridLastMonth);
  InternalAdd('scxGridThisMonth', @scxGridThisMonth);
  InternalAdd('scxGridNextMonth', @scxGridNextMonth);
  InternalAdd('scxGridLastYear', @scxGridLastYear);
  InternalAdd('scxGridThisYear', @scxGridThisYear);
  InternalAdd('scxGridNextYear', @scxGridNextYear);
  InternalAdd('scxGridPast', @scxGridPast);
  InternalAdd('scxGridFuture', @scxGridFuture);
  InternalAdd('scxGridMonthFormat', @scxGridMonthFormat);
  InternalAdd('scxGridYearFormat', @scxGridYearFormat);
  InternalAdd('scxGridChartCategoriesDisplayText', @scxGridChartCategoriesDisplayText);
  InternalAdd('scxGridChartValueHintFormat', @scxGridChartValueHintFormat);
  InternalAdd('scxGridChartPercentValueTickMarkLabelFormat', @scxGridChartPercentValueTickMarkLabelFormat);
  InternalAdd('scxGridChartToolBoxDataLevels', @scxGridChartToolBoxDataLevels);
  InternalAdd('scxGridChartToolBoxDataLevelSelectValue', @scxGridChartToolBoxDataLevelSelectValue);
  InternalAdd('scxGridChartToolBoxCustomizeButtonCaption', @scxGridChartToolBoxCustomizeButtonCaption);
  InternalAdd('scxGridChartNoneDiagramDisplayText', @scxGridChartNoneDiagramDisplayText);
  InternalAdd('scxGridChartColumnDiagramDisplayText', @scxGridChartColumnDiagramDisplayText);
  InternalAdd('scxGridChartBarDiagramDisplayText', @scxGridChartBarDiagramDisplayText);
  InternalAdd('scxGridChartLineDiagramDisplayText', @scxGridChartLineDiagramDisplayText);
  InternalAdd('scxGridChartAreaDiagramDisplayText', @scxGridChartAreaDiagramDisplayText);
  InternalAdd('scxGridChartPieDiagramDisplayText', @scxGridChartPieDiagramDisplayText);
  InternalAdd('scxGridChartStackedBarDiagramDisplayText', @scxGridChartStackedBarDiagramDisplayText);
  InternalAdd('scxGridChartStackedColumnDiagramDisplayText', @scxGridChartStackedColumnDiagramDisplayText);
  InternalAdd('scxGridChartStackedAreaDiagramDisplayText', @scxGridChartStackedAreaDiagramDisplayText);
  InternalAdd('scxGridChartCustomizationFormSeriesPageCaption', @scxGridChartCustomizationFormSeriesPageCaption);
  InternalAdd('scxGridChartCustomizationFormSortBySeries', @scxGridChartCustomizationFormSortBySeries);
  InternalAdd('scxGridChartCustomizationFormNoSortedSeries', @scxGridChartCustomizationFormNoSortedSeries);
  InternalAdd('scxGridChartCustomizationFormDataGroupsPageCaption', @scxGridChartCustomizationFormDataGroupsPageCaption);
  InternalAdd('scxGridChartCustomizationFormOptionsPageCaption', @scxGridChartCustomizationFormOptionsPageCaption);
  InternalAdd('scxGridChartLegend', @scxGridChartLegend);
  InternalAdd('scxGridChartLegendKeyBorder', @scxGridChartLegendKeyBorder);
  InternalAdd('scxGridChartPosition', @scxGridChartPosition);
  InternalAdd('scxGridChartPositionDefault', @scxGridChartPositionDefault);
  InternalAdd('scxGridChartPositionNone', @scxGridChartPositionNone);
  InternalAdd('scxGridChartPositionLeft', @scxGridChartPositionLeft);
  InternalAdd('scxGridChartPositionTop', @scxGridChartPositionTop);
  InternalAdd('scxGridChartPositionRight', @scxGridChartPositionRight);
  InternalAdd('scxGridChartPositionBottom', @scxGridChartPositionBottom);
  InternalAdd('scxGridChartAlignment', @scxGridChartAlignment);
  InternalAdd('scxGridChartAlignmentDefault', @scxGridChartAlignmentDefault);
  InternalAdd('scxGridChartAlignmentStart', @scxGridChartAlignmentStart);
  InternalAdd('scxGridChartAlignmentCenter', @scxGridChartAlignmentCenter);
  InternalAdd('scxGridChartAlignmentEnd', @scxGridChartAlignmentEnd);
  InternalAdd('scxGridChartOrientation', @scxGridChartOrientation);
  InternalAdd('scxGridChartOrientationDefault', @scxGridChartOrientationDefault);
  InternalAdd('scxGridChartOrientationHorizontal', @scxGridChartOrientationHorizontal);
  InternalAdd('scxGridChartOrientationVertical', @scxGridChartOrientationVertical);
  InternalAdd('scxGridChartBorder', @scxGridChartBorder);
  InternalAdd('scxGridChartTitle', @scxGridChartTitle);
  InternalAdd('scxGridChartToolBox', @scxGridChartToolBox);
  InternalAdd('scxGridChartDiagramSelector', @scxGridChartDiagramSelector);
  InternalAdd('scxGridChartOther', @scxGridChartOther);
  InternalAdd('scxGridChartValueHints', @scxGridChartValueHints);

  InternalAdd('scxGridLayoutViewCustomizeFormOk', @scxGridLayoutViewCustomizeFormOk);
  InternalAdd('scxGridLayoutViewCustomizeFormCancel', @scxGridLayoutViewCustomizeFormCancel);
  InternalAdd('scxGridLayoutViewCustomizeFormApply', @scxGridLayoutViewCustomizeFormApply);
  InternalAdd('scxGridLayoutViewCustomizeWarningDialogCaption', @scxGridLayoutViewCustomizeWarningDialogCaption);
  InternalAdd('scxGridLayoutViewCustomizeWarningDialogMessage', @scxGridLayoutViewCustomizeWarningDialogMessage);
  InternalAdd('scxGridLayoutViewCustomizeLayoutButtonCaption', @scxGridLayoutViewCustomizeLayoutButtonCaption);
  InternalAdd('scxGridLayoutViewCustomizeFormTemplateCard', @scxGridLayoutViewCustomizeFormTemplateCard);
  InternalAdd('scxGridLayoutViewCustomizeFormViewLayout', @scxGridLayoutViewCustomizeFormViewLayout);
  InternalAdd('scxGridLayoutViewRecordCaptionDefaultMask', @scxGridLayoutViewRecordCaptionDefaultMask);

  InternalAdd('scxGridLockedStateImageText', @scxGridLockedStateImageText);

  InternalAdd('scxGridInplaceEditFormButtonClose', @scxGridInplaceEditFormButtonClose);
  InternalAdd('scxGridInplaceEditFormButtonCancel', @scxGridInplaceEditFormButtonCancel);
  InternalAdd('scxGridInplaceEditFormButtonUpdate', @scxGridInplaceEditFormButtonUpdate);
  InternalAdd('scxGridInplaceEditFormSaveChangesQuery', @scxGridInplaceEditFormSaveChangesQuery);

  InternalAdd('scxGridDataRowFixingPopupCommandUnfix', @scxGridDataRowFixingPopupCommandUnfix);
  InternalAdd('scxGridDataRowFixingPopupCommandFixToTop', @scxGridDataRowFixingPopupCommandFixToTop);
  InternalAdd('scxGridDataRowFixingPopupCommandFixToBottom', @scxGridDataRowFixingPopupCommandFixToBottom);
end;


initialization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.RegisterProduct('ExpressQuantumGrid', @AddcxGridResourceStringNames);
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
finalization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.UnRegisterProduct('ExpressQuantumGrid');
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
end.
