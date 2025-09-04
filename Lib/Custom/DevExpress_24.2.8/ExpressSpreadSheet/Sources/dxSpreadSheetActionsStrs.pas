{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           ExpressSpreadSheet                                       }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSSPREADSHEET CONTROL AND ALL    }
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

unit dxSpreadSheetActionsStrs;

{$I cxVer.Inc}

interface

resourcestring
  // Clipboard
  sdxSpreadSheetActionCopySelectionCaption = 'Copiar';
  sdxSpreadSheetActionCopySelectionHint = 'Copiar';
  sdxSpreadSheetActionCutSelectionCaption = 'Cortar';
  sdxSpreadSheetActionCutSelectionHint = 'Cortar';
  sdxSpreadSheetActionPasteSelectionCaption = 'Pegar';
  sdxSpreadSheetActionPasteSelectionHint = 'Pegar';
  // Font
  sdxSpreadSheetActionChangeFillColorCaption = 'Color de relleno';
  sdxSpreadSheetActionChangeFillColorHint = 'Color de relleno';
  sdxSpreadSheetActionChangeFontColorCaption = 'Color de la fuente';
  sdxSpreadSheetActionChangeFontColorHint = 'Color de la fuente';
  sdxSpreadSheetActionChangeFontNameCaption = 'Nombre de la fuente';
  sdxSpreadSheetActionChangeFontNameHint = 'Nombre de la fuente';
  sdxSpreadSheetActionChangeFontSizeCaption = 'Tamaño de la fuente';
  sdxSpreadSheetActionChangeFontSizeHint = 'Tamaño de la fuente';
  sdxSpreadSheetActionDecreaseFontSizeCaption = 'Reducir tamaño fuente';
  sdxSpreadSheetActionDecreaseFontSizeHint = 'Reducir tamaño fuente';
  sdxSpreadSheetActionIncreaseFontSizeCaption = 'Incrementar tamaño fuente';
  sdxSpreadSheetActionIncreaseFontSizeHint = 'Incrementar tamaño fuente';
  sdxSpreadSheetActionToggleFontBoldCaption = '&Negrita';
  sdxSpreadSheetActionToggleFontBoldHint = 'Negrita';
  sdxSpreadSheetActionToggleFontItalicCaption = '&Italica';
  sdxSpreadSheetActionToggleFontItalicHint = 'Italica';
  sdxSpreadSheetActionToggleFontStrikeoutCaption = 'Tachado';
  sdxSpreadSheetActionToggleFontStrikeoutHint = 'tachado';
  sdxSpreadSheetActionToggleFontUnderlineCaption = '&Subrayado';
  sdxSpreadSheetActionToggleFontUnderlineHint = 'Subrayado';
  // Borders
  sdxSpreadSheetActionBordersAllCaption = 'Todos los bordes';
  sdxSpreadSheetActionBordersAllHint = 'Todos los bordes';
  sdxSpreadSheetActionBordersBottomCaption = 'Borde inferior';
  sdxSpreadSheetActionBordersBottomHint = 'Borde inferior';
  sdxSpreadSheetActionBordersBottomDoubleCaption = 'Borde inferior doble';
  sdxSpreadSheetActionBordersBottomDoubleHint = 'Borde inferior doble';
  sdxSpreadSheetActionBordersBottomThickCaption = 'Borde inferior grueso';
  sdxSpreadSheetActionBordersBottomThickHint = 'Borde inferior grueso';
  sdxSpreadSheetActionBordersLeftCaption = 'Borde izquierdo';
  sdxSpreadSheetActionBordersLeftHint = 'Borde izquierdo';
  sdxSpreadSheetActionBordersMoreCaption = 'Mas..';
  sdxSpreadSheetActionBordersMoreHint = 'Mas..';
  sdxSpreadSheetActionBordersNoneCaption = 'Sin borde';
  sdxSpreadSheetActionBordersNoneHint = 'Sin borde';
  sdxSpreadSheetActionBordersOutsideCaption = 'Bordes externos';
  sdxSpreadSheetActionBordersOutsideHint = 'Bordes externos';
  sdxSpreadSheetActionBordersOutsideThickCaption = 'Borde caja grueso';
  sdxSpreadSheetActionBordersOutsideThickHint = 'Borde caja grueso';
  sdxSpreadSheetActionBordersRightCaption = 'Borde derecho';
  sdxSpreadSheetActionBordersRightHint = 'Borde derecho';
  sdxSpreadSheetActionBordersTopAndBottomCaption = 'Bordes superior e inferior';
  sdxSpreadSheetActionBordersTopAndBottomHint = 'Bordes superior e inferior';
  sdxSpreadSheetActionBordersTopAndBottomDoubleCaption = 'Borde superior e inferior doble';
  sdxSpreadSheetActionBordersTopAndBottomDoubleHint = 'Borde superior e inferior doble';
  sdxSpreadSheetActionBordersTopAndBottomThickCaption = 'Borde superior e inferior grueso';
  sdxSpreadSheetActionBordersTopAndBottomThickHint = 'Borde superior e inferior grueso';
  sdxSpreadSheetActionBordersTopCaption = 'Borde superior';
  sdxSpreadSheetActionBordersTopHint = 'Borde superior';
  // Alignment
  sdxSpreadSheetActionAlignHorizontalCenterCaption = 'Texto centrado';
  sdxSpreadSheetActionAlignHorizontalCenterHint = 'Texto centrado';
  sdxSpreadSheetActionAlignHorizontalLeftCaption = 'Alinear a la izquierda';
  sdxSpreadSheetActionAlignHorizontalLeftHint = 'Alinear a la izquierda';
  sdxSpreadSheetActionAlignHorizontalRightCaption = 'Alinear a la dercha';
  sdxSpreadSheetActionAlignHorizontalRightHint = 'Alinear a la derecha';
  sdxSpreadSheetActionAlignVerticalBottomCaption = 'Alinear abajo';
  sdxSpreadSheetActionAlignVerticalBottomHint = 'Alinear abajo';
  sdxSpreadSheetActionAlignVerticalCenterCaption = 'Alinear al centro';
  sdxSpreadSheetActionAlignVerticalCenterHint = 'Alinear al centro';
  sdxSpreadSheetActionAlignVerticalTopCaption = 'Alinear arriba';
  sdxSpreadSheetActionAlignVerticalTopHint = 'Alinear arriba';
  // Text
  sdxSpreadSheetActionTextIndentDecreaseCaption = 'Reducir indentación';
  sdxSpreadSheetActionTextIndentDecreaseHint = 'Reducir indentación';
  sdxSpreadSheetActionTextIndentIncreaseCaption = 'Incrementar indentación';
  sdxSpreadSheetActionTextIndentIncreaseHint = 'Incrementar indentación';
  sdxSpreadSheetActionTextWrapCaption = 'Texto envolvente';
  sdxSpreadSheetActionTextWrapHint = 'Texto envolvente';
  // Merge Cells
  sdxSpreadSheetActionMergeCellsCaption = 'Mezclar celdas';
  sdxSpreadSheetActionMergeCellsHint = 'Mezclar celdas';
  sdxSpreadSheetActionMergeCellsAcrossCaption = 'Mezclar a través';
  sdxSpreadSheetActionMergeCellsAcrossHint = 'Mezclar a través';
  sdxSpreadSheetActionMergeCellsAndCenterCaption = 'Mezclar y centrar';
  sdxSpreadSheetActionMergeCellsAndCenterHint = 'Merge and Center';
  sdxSpreadSheetActionUnmergeCellsCaption = 'Desunir celdas';
  sdxSpreadSheetActionUnmergeCellsHint = 'Desunir celdas';
  // Insert Cells
  sdxSpreadSheetActionInsertColumnsCaption = 'Insertar columnas de hoja';
  sdxSpreadSheetActionInsertColumnsHint = 'Insertar columnas de hoja';
  sdxSpreadSheetActionInsertRowsCaption = 'Insertar filas de hoja';
  sdxSpreadSheetActionInsertRowsHint = 'Insertar filas de hoja';
  sdxSpreadSheetActionInsertSheetCaption = 'Insertar hoja';
  sdxSpreadSheetActionInsertSheetHint = 'Insertar hoja';
  // Delete Cells
  sdxSpreadSheetActionDeleteColumnsCaption = 'Suprimir columnas de hoja';
  sdxSpreadSheetActionDeleteColumnsHint = 'Suprimir columnas de hoja';
  sdxSpreadSheetActionDeleteRowsCaption = 'Suprimir filas de hoja';
  sdxSpreadSheetActionDeleteRowsHint = 'Suprimir filas de hoja';
  sdxSpreadSheetActionDeleteSheetCaption = 'Suprimir hoja';
  sdxSpreadSheetActionDeleteSheetHint = 'Suprimir hoja';
  // Format Cells
  sdxSpreadSheetActionAutoFitColumnWidthCaption = 'Autoajustar ancho de columna';
  sdxSpreadSheetActionAutoFitColumnWidthHint = 'Autoajustar ancho de columna';
  sdxSpreadSheetActionAutoFitRowHeightCaption = 'Autoajustar alto de fila';
  sdxSpreadSheetActionAutoFitRowHeightHint = 'Autoajustar alto de fila';
  sdxSpreadSheetActionHideColumnsCaption = 'Ocultar columnas';
  sdxSpreadSheetActionHideColumnsHint = 'Ocultar columnas';
  sdxSpreadSheetActionHideRowsCaption = 'Ocultar filas';
  sdxSpreadSheetActionHideRowsHint = 'Ocultar filas';
  sdxSpreadSheetActionHideSheetCaption = 'Ocultar hoja';
  sdxSpreadSheetActionHideSheetHint = 'Ocultar hoja';
  sdxSpreadSheetActionUnhideColumnsCaption = 'Mostrar columnas';
  sdxSpreadSheetActionUnhideColumnsHint = 'Mostrar columnas';
  sdxSpreadSheetActionUnhideRowsCaption = 'Mostrar filas';
  sdxSpreadSheetActionUnhideRowsHint = 'Mostrar filas';
  sdxSpreadSheetActionUnhideSheetCaption = 'Mostrar hoja';
  sdxSpreadSheetActionUnhideSheetHint = 'Mostrar hoja';
  // Clear
  sdxSpreadSheetActionClearAllCaption = 'Limpiar todo';
  sdxSpreadSheetActionClearAllHint = 'Limpiar todo';
  sdxSpreadSheetActionClearContentsCaption = 'Limpiar contenido';
  sdxSpreadSheetActionClearContentsHint = 'Limpiar contenido';
  sdxSpreadSheetActionClearFormatsCaption = 'Limpiar formatos';
  sdxSpreadSheetActionClearFormatsHint = 'Limpiar formatos';
  // Sort Filter
  sdxSpreadSheetActionSortAscendingCaption = 'Ordenar A a Z';
  sdxSpreadSheetActionSortAscendingHint = 'Ordenar A a Z';
  sdxSpreadSheetActionSortDescendingCaption = 'Ordenar Z a A';
  sdxSpreadSheetActionSortDescendingHint = 'Ordenar Z a A';
  // Grouping
  sdxSpreadSheetActionGroupColumnsCaption = 'Agrupar columnas';
  sdxSpreadSheetActionGroupColumnsHint = 'Agrupar columnas';
  sdxSpreadSheetActionGroupRowsCaption = 'Agrupar filas';
  sdxSpreadSheetActionGroupRowsHint = 'Agrupar filas';
  sdxSpreadSheetActionUngroupColumnsCaption = 'Des-agrupar columnas';
  sdxSpreadSheetActionUngroupColumnsHint = 'Des-agrupar columnas';
  sdxSpreadSheetActionUngroupRowsCaption = 'Des-agrupar filas';
  sdxSpreadSheetActionUngroupRowsHint = 'Des-agrupar filas';
  // Comments
  sdxSpreadSheetActionDeleteCommentsCaption = 'Eliminar comentarios';
  sdxSpreadSheetActionDeleteCommentsHint = 'Eliminar comentarios';
  sdxSpreadSheetActionEditCommentCaption = 'Editar comentario';
  sdxSpreadSheetActionEditCommentHint = 'Editar comentario';
  sdxSpreadSheetActionNewCommentCaption = 'Nuevo comentario';
  sdxSpreadSheetActionNewCommentHint = 'Nuevo comentario';
  sdxSpreadSheetActionNextCommentCaption = 'Próximo comentario';
  sdxSpreadSheetActionNextCommentHint = 'Próximo comentario';
  sdxSpreadSheetActionPreviousCommentCaption = 'Comentario anterior';
  sdxSpreadSheetActionPreviousCommentHint = 'Comentario anterior';
  sdxSpreadSheetActionShowHideCommentsCaption = 'Mostrar / Ocultar comentarios';
  sdxSpreadSheetActionShowHideCommentsHint = 'Mostrar / Ocultar comentarios';
  // Zoom
  sdxSpreadSheetActionZoomDefaultCaption = '100%';
  sdxSpreadSheetActionZoomDefaultHint = '100%';
  sdxSpreadSheetActionZoomInCaption = 'Aumentar Zoom';
  sdxSpreadSheetActionZoomInHint = 'Aumentar Zoom';
  sdxSpreadSheetActionZoomOutCaption = 'Reducir Zoom';
  sdxSpreadSheetActionZoomOutHint = 'Reducir Zoom';
  // Freeze
  sdxSpreadSheetActionFreezeFirstColumnCaption = 'Bloquear primera columna';
  sdxSpreadSheetActionFreezeFirstColumnHint = 'Bloquear primera columna';
  sdxSpreadSheetActionFreezePanesCaption = 'Bloquear paneles';
  sdxSpreadSheetActionFreezePanesHint = 'Bloquear paneles';
  sdxSpreadSheetActionFreezeTopRowCaption = 'Bloquear fila superior';
  sdxSpreadSheetActionFreezeTopRowHint = 'Bloquear fila superior';
  sdxSpreadSheetActionUnfreezePanesCaption = 'Des-bloquear paneles';
  sdxSpreadSheetActionUnfreezePanesHint = 'Des-bloquear paneles';
  // Print
  sdxSpreadSheetActionPageSetupCaption = 'Configuración de página';
  sdxSpreadSheetActionPageSetupHint = 'Configuración de página';
  sdxSpreadSheetActionPrintCaption = 'Im&primir';
  sdxSpreadSheetActionPrintHint = 'Imprimir';
  sdxSpreadSheetActionPrintPreviewCaption = 'Imprimir &vista previa';
  sdxSpreadSheetActionPrintPreviewHint = 'Imprimir vista previa';
  // History
  sdxSpreadSheetActionRedoCaption = 'Rehacer';
  sdxSpreadSheetActionRedoHint = 'Rehacer';
  sdxSpreadSheetActionUndoCaption = 'Deshacer';
  sdxSpreadSheetActionUndoHint = 'Deshacer';
  // Common
  sdxSpreadSheetActionNewDocumentCaption = '&Nuevo';
  sdxSpreadSheetActionNewDocumentHint = 'Nuevo';
  sdxSpreadSheetActionOpenDocumentCaption = '&Abrir';
  sdxSpreadSheetActionOpenDocumentHint = 'Abrir';
  sdxSpreadSheetActionSaveDocumentAsCaption = '&Guardar como';
  sdxSpreadSheetActionSaveDocumentAsHint = 'Guardar como';
  // Find And Replace
  sdxSpreadSheetActionFindAndReplaceCaption = 'Buscar y &reemplazar';
  sdxSpreadSheetActionFindAndReplaceHint = 'Buscar y reemplazar';
  // PageSetup
  sdxSpreadSheetActionClearPrintAreaCaption = '&Clear Print Area';
  sdxSpreadSheetActionClearPrintAreaHint = 'Clear Print Area';
  sdxSpreadSheetActionSetPrintAreaCaption = '&Set Print Area';
  sdxSpreadSheetActionSetPrintAreaHint = 'Set Print Area';
  sdxSpreadSheetActionInsertPageBreakCaption = '&Insert Page Break';
  sdxSpreadSheetActionInsertPageBreakHint = 'Insert Page Break';
  sdxSpreadSheetActionRemovePageBreakCaption = '&Remove Page Break';
  sdxSpreadSheetActionRemovePageBreakHint = 'Remove Page Break';
  sdxSpreadSheetActionResetAllPageBreaksCaption = 'Reset &All Page Breaks';
  sdxSpreadSheetActionResetAllPageBreaksHint = 'Reset All Page Breaks';
  sdxSpreadSheetActionPrintTitlesCaption = '&Print Titles';
  sdxSpreadSheetActionPrintTitlesHint = 'Specify rows and columns to repeat on each printed page.';
  sdxSpreadSheetActionPageOrientationGalleryCaption = 'Orientation';
  sdxSpreadSheetActionSetLandscapePageOrientationCaption = 'Landscape';
  sdxSpreadSheetActionSetPortraitPageOrientationCaption = 'Portrait';
  sdxSpreadSheetActionPaperSizeGalleryCaption = 'Size';
  sdxSpreadSheetActionMorePaperSizesCaption = '&More Paper Sizes...';
  sdxSpreadSheetActionPageMarginsGalleryCaption = 'Margins';
  sdxSpreadSheetActionPageMarginsGalleryNormalMarginsCaption = 'Normal';
  sdxSpreadSheetActionPageMarginsGalleryWideMarginsCaption = 'Wide';
  sdxSpreadSheetActionPageMarginsGalleryNarrowMarginsCaption = 'Narrow';
  sdxSpreadSheetActionPageMarginsGalleryTopPartCaption = 'Top';
  sdxSpreadSheetActionPageMarginsGalleryBottomPartCaption = 'Bottom';
  sdxSpreadSheetActionPageMarginsGalleryLeftPartCaption = 'Left';
  sdxSpreadSheetActionPageMarginsGalleryRightPartCaption = 'Right';
  sdxSpreadSheetActionPageMarginsGalleryHeaderPartCaption = 'Header';
  sdxSpreadSheetActionPageMarginsGalleryFooterPartCaption = 'Footer';
  sdxSpreadSheetActionMorePageMarginsCaption = 'More Page M&argins...';
  // Links
  sdxSpreadSheetActionShowHyperlinkEditorCaption = 'Hyperlink';
  sdxSpreadSheetActionShowHyperlinkEditorHint = 'Hyperlink';
  // Picture
  sdxSpreadSheetActionInsertPictureCaption = 'Picture';
  sdxSpreadSheetActionInsertPictureHint = 'Picture';
  // Conditional Formatting
  sdxSpreadSheetActionShowConditionalFormattingRulesManagerCaption = 'Manage Rules...';
  sdxSpreadSheetActionShowConditionalFormattingRulesManagerHint = 'Manage Rules...';
  sdxSpreadSheetActionConditionalFormattingTopBottomRulesGalleryCaption = 'Top/Bottom Rules';
  sdxSpreadSheetActionConditionalFormattingTopBottomRulesGalleryTop10ItemsCaption = 'Top 10 Items';
  sdxSpreadSheetActionConditionalFormattingTopBottomRulesGalleryTop10PercentsCaption = 'Top 10%';
  sdxSpreadSheetActionConditionalFormattingTopBottomRulesGalleryBottom10ItemsCaption = 'Bottom 10 Items';
  sdxSpreadSheetActionConditionalFormattingTopBottomRulesGalleryBottom10PercentsCaption = 'Bottom 10%';
  sdxSpreadSheetActionConditionalFormattingTopBottomRulesGalleryAboveAverageCaption = 'Above Average';
  sdxSpreadSheetActionConditionalFormattingTopBottomRulesGalleryBelowAverageCaption = 'Below Average';
  sdxSpreadSheetActionConditionalFormattingColorScalesGalleryCaption = 'Color Scales';
  sdxSpreadSheetActionConditionalFormattingDataBarsGalleryCaption = 'Data Bars';
  sdxSpreadSheetActionConditionalFormattingDataBarsGalleryGradientFillGroupCaption = 'Gradient Fill';
  sdxSpreadSheetActionConditionalFormattingDataBarsGallerySolidFillGroupCaption = 'Solid Fill';
  sdxSpreadSheetActionConditionalFormattingIconSetsGalleryCaption = 'Icon Sets';
  sdxSpreadSheetActionConditionalFormattingIconSetsGalleryDirectionalGroupCaption = 'Directional';
  sdxSpreadSheetActionConditionalFormattingIconSetsGalleryShapesGroupCaption = 'Shapes';
  sdxSpreadSheetActionConditionalFormattingIconSetsGalleryIndicatorsGroupCaption = 'Indicators';
  sdxSpreadSheetActionConditionalFormattingIconSetsGalleryRatingsGroupCaption = 'Ratings';
  sdxSpreadSheetActionConditionalFormattingMoreRulesCaption = 'More Rules...';
  sdxSpreadSheetActionConditionalFormattingMoreRulesHint = 'More Rules...';
  sdxSpreadSheetActionConditionalFormattingNewRuleCaption = 'New Rule...';
  sdxSpreadSheetActionConditionalFormattingNewRuleHint = 'New Rule...';
  sdxSpreadSheetActionConditionalFormattingClearRulesFromSelectedCellsCaption = 'Clear Rules From Selected Cells';
  sdxSpreadSheetActionConditionalFormattingClearRulesFromSelectedCellsHint = 'Clear Rules From Selected Cells';
  sdxSpreadSheetActionConditionalFormattingClearRulesFromEntireSheetCaption = 'Clear Rules From Entire Sheet';
  sdxSpreadSheetActionConditionalFormattingClearRulesFromEntireSheetHint = 'Clear Rules From Entire Sheet';
  // Protection
  sdxSpreadSheetActionProtectSheetCaption = 'Protect Sheet';
  sdxSpreadSheetActionProtectSheetHint = 'Prevent unwanted changes from others by limiting their ability to edit.';
  sdxSpreadSheetActionProtectWorkbookCaption = 'Protect Workbook';
  sdxSpreadSheetActionProtectWorkbookHint = 'Keep others from making structural changes to your workbook, such as moving, deleting or adding sheets.';
  // Formulas
  sdxSpreadSheetActionAutoSumGalleryCaption = 'AutoSum';
  sdxSpreadSheetActionAutoSumGallerySumCaption = 'Sum';
  sdxSpreadSheetActionAutoSumGalleryAverageCaption = 'Average';
  sdxSpreadSheetActionAutoSumGalleryCountNumbersCaption = 'Count Numbers';
  sdxSpreadSheetActionAutoSumGalleryMaxCaption = 'Max';
  sdxSpreadSheetActionAutoSumGalleryMinCaption = 'Min';
  // DefinedNames
  sdxSpreadSheetActionCreateDefinedNameCaption = 'Define Name';
  sdxSpreadSheetActionCreateDefinedNamesFromSelectionCaption = 'Create from Selection';
  sdxSpreadSheetActionShowDefinedNameManagerCaption = 'Name Manager';
  sdxSpreadSheetActionUseDefinedNameInFormulaCaption = 'Use in Formula';
  // Other
  sdxSpreadSheetActionInsertPictureDialogTitle = 'Insertar imagen';

implementation

uses
  dxCore;

const
  dxThisUnitName = 'dxSpreadSheetActionsStrs';

procedure AddSpreadSheetActionsResourceStringNames(AProduct: TdxProductResourceStrings);
begin
  // Clipboard
  AProduct.Add('sdxSpreadSheetActionCopySelectionCaption', @sdxSpreadSheetActionCopySelectionCaption);
  AProduct.Add('sdxSpreadSheetActionCopySelectionHint', @sdxSpreadSheetActionCopySelectionHint);
  AProduct.Add('sdxSpreadSheetActionCutSelectionCaption', @sdxSpreadSheetActionCutSelectionCaption);
  AProduct.Add('sdxSpreadSheetActionCutSelectionHint', @sdxSpreadSheetActionCutSelectionHint);
  AProduct.Add('sdxSpreadSheetActionPasteSelectionCaption', @sdxSpreadSheetActionPasteSelectionCaption);
  AProduct.Add('sdxSpreadSheetActionPasteSelectionHint', @sdxSpreadSheetActionPasteSelectionHint);
  // Font
  AProduct.Add('sdxSpreadSheetActionChangeFillColorCaption', @sdxSpreadSheetActionChangeFillColorCaption);
  AProduct.Add('sdxSpreadSheetActionChangeFillColorHint', @sdxSpreadSheetActionChangeFillColorHint);
  AProduct.Add('sdxSpreadSheetActionChangeFontColorCaption', @sdxSpreadSheetActionChangeFontColorCaption);
  AProduct.Add('sdxSpreadSheetActionChangeFontColorHint', @sdxSpreadSheetActionChangeFontColorHint);
  AProduct.Add('sdxSpreadSheetActionChangeFontNameCaption', @sdxSpreadSheetActionChangeFontNameCaption);
  AProduct.Add('sdxSpreadSheetActionChangeFontNameHint', @sdxSpreadSheetActionChangeFontNameHint);
  AProduct.Add('sdxSpreadSheetActionChangeFontSizeCaption', @sdxSpreadSheetActionChangeFontSizeCaption);
  AProduct.Add('sdxSpreadSheetActionChangeFontSizeHint', @sdxSpreadSheetActionChangeFontSizeHint);
  AProduct.Add('sdxSpreadSheetActionDecreaseFontSizeCaption', @sdxSpreadSheetActionDecreaseFontSizeCaption);
  AProduct.Add('sdxSpreadSheetActionDecreaseFontSizeHint', @sdxSpreadSheetActionDecreaseFontSizeHint);
  AProduct.Add('sdxSpreadSheetActionIncreaseFontSizeCaption', @sdxSpreadSheetActionIncreaseFontSizeCaption);
  AProduct.Add('sdxSpreadSheetActionIncreaseFontSizeHint', @sdxSpreadSheetActionIncreaseFontSizeHint);
  AProduct.Add('sdxSpreadSheetActionToggleFontBoldCaption', @sdxSpreadSheetActionToggleFontBoldCaption);
  AProduct.Add('sdxSpreadSheetActionToggleFontBoldHint', @sdxSpreadSheetActionToggleFontBoldHint);
  AProduct.Add('sdxSpreadSheetActionToggleFontItalicCaption', @sdxSpreadSheetActionToggleFontItalicCaption);
  AProduct.Add('sdxSpreadSheetActionToggleFontItalicHint', @sdxSpreadSheetActionToggleFontItalicHint);
  AProduct.Add('sdxSpreadSheetActionToggleFontStrikeoutCaption', @sdxSpreadSheetActionToggleFontStrikeoutCaption);
  AProduct.Add('sdxSpreadSheetActionToggleFontStrikeoutHint', @sdxSpreadSheetActionToggleFontStrikeoutHint);
  AProduct.Add('sdxSpreadSheetActionToggleFontUnderlineCaption', @sdxSpreadSheetActionToggleFontUnderlineCaption);
  AProduct.Add('sdxSpreadSheetActionToggleFontUnderlineHint', @sdxSpreadSheetActionToggleFontUnderlineHint);
  // Borders
  AProduct.Add('sdxSpreadSheetActionBordersAllCaption', @sdxSpreadSheetActionBordersAllCaption);
  AProduct.Add('sdxSpreadSheetActionBordersAllHint', @sdxSpreadSheetActionBordersAllHint);
  AProduct.Add('sdxSpreadSheetActionBordersBottomCaption', @sdxSpreadSheetActionBordersBottomCaption);
  AProduct.Add('sdxSpreadSheetActionBordersBottomHint', @sdxSpreadSheetActionBordersBottomHint);
  AProduct.Add('sdxSpreadSheetActionBordersBottomDoubleCaption', @sdxSpreadSheetActionBordersBottomDoubleCaption);
  AProduct.Add('sdxSpreadSheetActionBordersBottomDoubleHint', @sdxSpreadSheetActionBordersBottomDoubleHint);
  AProduct.Add('sdxSpreadSheetActionBordersBottomThickCaption', @sdxSpreadSheetActionBordersBottomThickCaption);
  AProduct.Add('sdxSpreadSheetActionBordersBottomThickHint', @sdxSpreadSheetActionBordersBottomThickHint);
  AProduct.Add('sdxSpreadSheetActionBordersLeftCaption', @sdxSpreadSheetActionBordersLeftCaption);
  AProduct.Add('sdxSpreadSheetActionBordersLeftHint', @sdxSpreadSheetActionBordersLeftHint);
  AProduct.Add('sdxSpreadSheetActionBordersMoreCaption', @sdxSpreadSheetActionBordersMoreCaption);
  AProduct.Add('sdxSpreadSheetActionBordersMoreHint', @sdxSpreadSheetActionBordersMoreHint);
  AProduct.Add('sdxSpreadSheetActionBordersNoneCaption', @sdxSpreadSheetActionBordersNoneCaption);
  AProduct.Add('sdxSpreadSheetActionBordersNoneHint', @sdxSpreadSheetActionBordersNoneHint);
  AProduct.Add('sdxSpreadSheetActionBordersOutsideCaption', @sdxSpreadSheetActionBordersOutsideCaption);
  AProduct.Add('sdxSpreadSheetActionBordersOutsideHint', @sdxSpreadSheetActionBordersOutsideHint);
  AProduct.Add('sdxSpreadSheetActionBordersOutsideThickCaption', @sdxSpreadSheetActionBordersOutsideThickCaption);
  AProduct.Add('sdxSpreadSheetActionBordersOutsideThickHint', @sdxSpreadSheetActionBordersOutsideThickHint);
  AProduct.Add('sdxSpreadSheetActionBordersRightCaption', @sdxSpreadSheetActionBordersRightCaption);
  AProduct.Add('sdxSpreadSheetActionBordersRightHint', @sdxSpreadSheetActionBordersRightHint);
  AProduct.Add('sdxSpreadSheetActionBordersTopAndBottomCaption', @sdxSpreadSheetActionBordersTopAndBottomCaption);
  AProduct.Add('sdxSpreadSheetActionBordersTopAndBottomHint', @sdxSpreadSheetActionBordersTopAndBottomHint);
  AProduct.Add('sdxSpreadSheetActionBordersTopAndBottomDoubleCaption', @sdxSpreadSheetActionBordersTopAndBottomDoubleCaption);
  AProduct.Add('sdxSpreadSheetActionBordersTopAndBottomDoubleHint', @sdxSpreadSheetActionBordersTopAndBottomDoubleHint);
  AProduct.Add('sdxSpreadSheetActionBordersTopAndBottomThickCaption', @sdxSpreadSheetActionBordersTopAndBottomThickCaption);
  AProduct.Add('sdxSpreadSheetActionBordersTopAndBottomThickHint', @sdxSpreadSheetActionBordersTopAndBottomThickHint);
  AProduct.Add('sdxSpreadSheetActionBordersTopCaption', @sdxSpreadSheetActionBordersTopCaption);
  AProduct.Add('sdxSpreadSheetActionBordersTopHint', @sdxSpreadSheetActionBordersTopHint);
  // Alignment
  AProduct.Add('sdxSpreadSheetActionAlignHorizontalCenterCaption', @sdxSpreadSheetActionAlignHorizontalCenterCaption);
  AProduct.Add('sdxSpreadSheetActionAlignHorizontalCenterHint', @sdxSpreadSheetActionAlignHorizontalCenterHint);
  AProduct.Add('sdxSpreadSheetActionAlignHorizontalLeftCaption', @sdxSpreadSheetActionAlignHorizontalLeftCaption);
  AProduct.Add('sdxSpreadSheetActionAlignHorizontalLeftHint', @sdxSpreadSheetActionAlignHorizontalLeftHint);
  AProduct.Add('sdxSpreadSheetActionAlignHorizontalRightCaption', @sdxSpreadSheetActionAlignHorizontalRightCaption);
  AProduct.Add('sdxSpreadSheetActionAlignHorizontalRightHint', @sdxSpreadSheetActionAlignHorizontalRightHint);
  AProduct.Add('sdxSpreadSheetActionAlignVerticalBottomCaption', @sdxSpreadSheetActionAlignVerticalBottomCaption);
  AProduct.Add('sdxSpreadSheetActionAlignVerticalBottomHint', @sdxSpreadSheetActionAlignVerticalBottomHint);
  AProduct.Add('sdxSpreadSheetActionAlignVerticalCenterCaption', @sdxSpreadSheetActionAlignVerticalCenterCaption);
  AProduct.Add('sdxSpreadSheetActionAlignVerticalCenterHint', @sdxSpreadSheetActionAlignVerticalCenterHint);
  AProduct.Add('sdxSpreadSheetActionAlignVerticalTopCaption', @sdxSpreadSheetActionAlignVerticalTopCaption);
  AProduct.Add('sdxSpreadSheetActionAlignVerticalTopHint', @sdxSpreadSheetActionAlignVerticalTopHint);
  // Text
  AProduct.Add('sdxSpreadSheetActionTextIndentDecreaseCaption', @sdxSpreadSheetActionTextIndentDecreaseCaption);
  AProduct.Add('sdxSpreadSheetActionTextIndentDecreaseHint', @sdxSpreadSheetActionTextIndentDecreaseHint);
  AProduct.Add('sdxSpreadSheetActionTextIndentIncreaseCaption', @sdxSpreadSheetActionTextIndentIncreaseCaption);
  AProduct.Add('sdxSpreadSheetActionTextIndentIncreaseHint', @sdxSpreadSheetActionTextIndentIncreaseHint);
  AProduct.Add('sdxSpreadSheetActionTextWrapCaption', @sdxSpreadSheetActionTextWrapCaption);
  AProduct.Add('sdxSpreadSheetActionTextWrapHint', @sdxSpreadSheetActionTextWrapHint);
  // Merge Cells
  AProduct.Add('sdxSpreadSheetActionMergeCellsCaption', @sdxSpreadSheetActionMergeCellsCaption);
  AProduct.Add('sdxSpreadSheetActionMergeCellsHint', @sdxSpreadSheetActionMergeCellsHint);
  AProduct.Add('sdxSpreadSheetActionMergeCellsAcrossCaption', @sdxSpreadSheetActionMergeCellsAcrossCaption);
  AProduct.Add('sdxSpreadSheetActionMergeCellsAcrossHint', @sdxSpreadSheetActionMergeCellsAcrossHint);
  AProduct.Add('sdxSpreadSheetActionMergeCellsAndCenterCaption', @sdxSpreadSheetActionMergeCellsAndCenterCaption);
  AProduct.Add('sdxSpreadSheetActionMergeCellsAndCenterHint', @sdxSpreadSheetActionMergeCellsAndCenterHint);
  AProduct.Add('sdxSpreadSheetActionUnmergeCellsCaption', @sdxSpreadSheetActionUnmergeCellsCaption);
  AProduct.Add('sdxSpreadSheetActionUnmergeCellsHint', @sdxSpreadSheetActionUnmergeCellsHint);
  // Insert Cells
  AProduct.Add('sdxSpreadSheetActionInsertColumnsCaption', @sdxSpreadSheetActionInsertColumnsCaption);
  AProduct.Add('sdxSpreadSheetActionInsertColumnsHint', @sdxSpreadSheetActionInsertColumnsHint);
  AProduct.Add('sdxSpreadSheetActionInsertRowsCaption', @sdxSpreadSheetActionInsertRowsCaption);
  AProduct.Add('sdxSpreadSheetActionInsertRowsHint', @sdxSpreadSheetActionInsertRowsHint);
  AProduct.Add('sdxSpreadSheetActionInsertSheetCaption', @sdxSpreadSheetActionInsertSheetCaption);
  AProduct.Add('sdxSpreadSheetActionInsertSheetHint', @sdxSpreadSheetActionInsertSheetHint);
  // Delete Cells
  AProduct.Add('sdxSpreadSheetActionDeleteColumnsCaption', @sdxSpreadSheetActionDeleteColumnsCaption);
  AProduct.Add('sdxSpreadSheetActionDeleteColumnsHint', @sdxSpreadSheetActionDeleteColumnsHint);
  AProduct.Add('sdxSpreadSheetActionDeleteRowsCaption', @sdxSpreadSheetActionDeleteRowsCaption);
  AProduct.Add('sdxSpreadSheetActionDeleteRowsHint', @sdxSpreadSheetActionDeleteRowsHint);
  AProduct.Add('sdxSpreadSheetActionDeleteSheetCaption', @sdxSpreadSheetActionDeleteSheetCaption);
  AProduct.Add('sdxSpreadSheetActionDeleteSheetHint', @sdxSpreadSheetActionDeleteSheetHint);
  // Format Cells
  AProduct.Add('sdxSpreadSheetActionAutoFitColumnWidthCaption', @sdxSpreadSheetActionAutoFitColumnWidthCaption);
  AProduct.Add('sdxSpreadSheetActionAutoFitColumnWidthHint', @sdxSpreadSheetActionAutoFitColumnWidthHint);
  AProduct.Add('sdxSpreadSheetActionAutoFitRowHeightCaption', @sdxSpreadSheetActionAutoFitRowHeightCaption);
  AProduct.Add('sdxSpreadSheetActionAutoFitRowHeightHint', @sdxSpreadSheetActionAutoFitRowHeightHint);
  AProduct.Add('sdxSpreadSheetActionHideColumnsCaption', @sdxSpreadSheetActionHideColumnsCaption);
  AProduct.Add('sdxSpreadSheetActionHideColumnsHint', @sdxSpreadSheetActionHideColumnsHint);
  AProduct.Add('sdxSpreadSheetActionHideRowsCaption', @sdxSpreadSheetActionHideRowsCaption);
  AProduct.Add('sdxSpreadSheetActionHideRowsHint', @sdxSpreadSheetActionHideRowsHint);
  AProduct.Add('sdxSpreadSheetActionHideSheetCaption', @sdxSpreadSheetActionHideSheetCaption);
  AProduct.Add('sdxSpreadSheetActionHideSheetHint', @sdxSpreadSheetActionHideSheetHint);
  AProduct.Add('sdxSpreadSheetActionUnhideColumnsCaption', @sdxSpreadSheetActionUnhideColumnsCaption);
  AProduct.Add('sdxSpreadSheetActionUnhideColumnsHint', @sdxSpreadSheetActionUnhideColumnsHint);
  AProduct.Add('sdxSpreadSheetActionUnhideRowsCaption', @sdxSpreadSheetActionUnhideRowsCaption);
  AProduct.Add('sdxSpreadSheetActionUnhideRowsHint', @sdxSpreadSheetActionUnhideRowsHint);
  AProduct.Add('sdxSpreadSheetActionUnhideSheetCaption', @sdxSpreadSheetActionUnhideSheetCaption);
  AProduct.Add('sdxSpreadSheetActionUnhideSheetHint', @sdxSpreadSheetActionUnhideSheetHint);
  // Clear
  AProduct.Add('sdxSpreadSheetActionClearAllCaption', @sdxSpreadSheetActionClearAllCaption);
  AProduct.Add('sdxSpreadSheetActionClearAllHint', @sdxSpreadSheetActionClearAllHint);
  AProduct.Add('sdxSpreadSheetActionClearContentsCaption', @sdxSpreadSheetActionClearContentsCaption);
  AProduct.Add('sdxSpreadSheetActionClearContentsHint', @sdxSpreadSheetActionClearContentsHint);
  AProduct.Add('sdxSpreadSheetActionClearFormatsCaption', @sdxSpreadSheetActionClearFormatsCaption);
  AProduct.Add('sdxSpreadSheetActionClearFormatsHint', @sdxSpreadSheetActionClearFormatsHint);
  // Sort Filter
  AProduct.Add('sdxSpreadSheetActionSortAscendingCaption', @sdxSpreadSheetActionSortAscendingCaption);
  AProduct.Add('sdxSpreadSheetActionSortAscendingHint', @sdxSpreadSheetActionSortAscendingHint);
  AProduct.Add('sdxSpreadSheetActionSortDescendingCaption', @sdxSpreadSheetActionSortDescendingCaption);
  AProduct.Add('sdxSpreadSheetActionSortDescendingHint', @sdxSpreadSheetActionSortDescendingHint);
  // Grouping
  AProduct.Add('sdxSpreadSheetActionGroupColumnsCaption', @sdxSpreadSheetActionGroupColumnsCaption);
  AProduct.Add('sdxSpreadSheetActionGroupColumnsHint', @sdxSpreadSheetActionGroupColumnsHint);
  AProduct.Add('sdxSpreadSheetActionGroupRowsCaption', @sdxSpreadSheetActionGroupRowsCaption);
  AProduct.Add('sdxSpreadSheetActionGroupRowsHint', @sdxSpreadSheetActionGroupRowsHint);
  AProduct.Add('sdxSpreadSheetActionUngroupColumnsCaption', @sdxSpreadSheetActionUngroupColumnsCaption);
  AProduct.Add('sdxSpreadSheetActionUngroupColumnsHint', @sdxSpreadSheetActionUngroupColumnsHint);
  AProduct.Add('sdxSpreadSheetActionUngroupRowsCaption', @sdxSpreadSheetActionUngroupRowsCaption);
  AProduct.Add('sdxSpreadSheetActionUngroupRowsHint', @sdxSpreadSheetActionUngroupRowsHint);
  // Comments
  AProduct.Add('sdxSpreadSheetActionDeleteCommentsCaption', @sdxSpreadSheetActionDeleteCommentsCaption);
  AProduct.Add('sdxSpreadSheetActionDeleteCommentsHint', @sdxSpreadSheetActionDeleteCommentsHint);
  AProduct.Add('sdxSpreadSheetActionEditCommentCaption', @sdxSpreadSheetActionEditCommentCaption);
  AProduct.Add('sdxSpreadSheetActionEditCommentHint', @sdxSpreadSheetActionEditCommentHint);
  AProduct.Add('sdxSpreadSheetActionNewCommentCaption', @sdxSpreadSheetActionNewCommentCaption);
  AProduct.Add('sdxSpreadSheetActionNewCommentHint', @sdxSpreadSheetActionNewCommentHint);
  AProduct.Add('sdxSpreadSheetActionNextCommentCaption', @sdxSpreadSheetActionNextCommentCaption);
  AProduct.Add('sdxSpreadSheetActionNextCommentHint', @sdxSpreadSheetActionNextCommentHint);
  AProduct.Add('sdxSpreadSheetActionPreviousCommentCaption', @sdxSpreadSheetActionPreviousCommentCaption);
  AProduct.Add('sdxSpreadSheetActionPreviousCommentHint', @sdxSpreadSheetActionPreviousCommentHint);
  AProduct.Add('sdxSpreadSheetActionShowHideCommentsCaption', @sdxSpreadSheetActionShowHideCommentsCaption);
  AProduct.Add('sdxSpreadSheetActionShowHideCommentsHint', @sdxSpreadSheetActionShowHideCommentsHint);
  // Zoom
  AProduct.Add('sdxSpreadSheetActionZoomDefaultCaption', @sdxSpreadSheetActionZoomDefaultCaption);
  AProduct.Add('sdxSpreadSheetActionZoomDefaultHint', @sdxSpreadSheetActionZoomDefaultHint);
  AProduct.Add('sdxSpreadSheetActionZoomInCaption', @sdxSpreadSheetActionZoomInCaption);
  AProduct.Add('sdxSpreadSheetActionZoomInHint', @sdxSpreadSheetActionZoomInHint);
  AProduct.Add('sdxSpreadSheetActionZoomOutCaption', @sdxSpreadSheetActionZoomOutCaption);
  AProduct.Add('sdxSpreadSheetActionZoomOutHint', @sdxSpreadSheetActionZoomOutHint);
  // Freeze
  AProduct.Add('sdxSpreadSheetActionFreezeFirstColumnCaption', @sdxSpreadSheetActionFreezeFirstColumnCaption);
  AProduct.Add('sdxSpreadSheetActionFreezeFirstColumnHint', @sdxSpreadSheetActionFreezeFirstColumnHint);
  AProduct.Add('sdxSpreadSheetActionFreezePanesCaption', @sdxSpreadSheetActionFreezePanesCaption);
  AProduct.Add('sdxSpreadSheetActionFreezePanesHint', @sdxSpreadSheetActionFreezePanesHint);
  AProduct.Add('sdxSpreadSheetActionFreezeTopRowCaption', @sdxSpreadSheetActionFreezeTopRowCaption);
  AProduct.Add('sdxSpreadSheetActionFreezeTopRowHint', @sdxSpreadSheetActionFreezeTopRowHint);
  AProduct.Add('sdxSpreadSheetActionUnfreezePanesCaption', @sdxSpreadSheetActionUnfreezePanesCaption);
  AProduct.Add('sdxSpreadSheetActionUnfreezePanesHint', @sdxSpreadSheetActionUnfreezePanesHint);
  // Print
  AProduct.Add('sdxSpreadSheetActionPageSetupCaption', @sdxSpreadSheetActionPageSetupCaption);
  AProduct.Add('sdxSpreadSheetActionPageSetupHint', @sdxSpreadSheetActionPageSetupHint);
  AProduct.Add('sdxSpreadSheetActionPrintCaption', @sdxSpreadSheetActionPrintCaption);
  AProduct.Add('sdxSpreadSheetActionPrintHint', @sdxSpreadSheetActionPrintHint);
  AProduct.Add('sdxSpreadSheetActionPrintPreviewCaption', @sdxSpreadSheetActionPrintPreviewCaption);
  AProduct.Add('sdxSpreadSheetActionPrintPreviewHint', @sdxSpreadSheetActionPrintPreviewHint);
  // History
  AProduct.Add('sdxSpreadSheetActionRedoCaption', @sdxSpreadSheetActionRedoCaption);
  AProduct.Add('sdxSpreadSheetActionRedoHint', @sdxSpreadSheetActionRedoHint);
  AProduct.Add('sdxSpreadSheetActionUndoCaption', @sdxSpreadSheetActionUndoCaption);
  AProduct.Add('sdxSpreadSheetActionUndoHint', @sdxSpreadSheetActionUndoHint);
  // Common
  AProduct.Add('sdxSpreadSheetActionNewDocumentCaption', @sdxSpreadSheetActionNewDocumentCaption);
  AProduct.Add('sdxSpreadSheetActionNewDocumentHint', @sdxSpreadSheetActionNewDocumentHint);
  AProduct.Add('sdxSpreadSheetActionOpenDocumentCaption', @sdxSpreadSheetActionOpenDocumentCaption);
  AProduct.Add('sdxSpreadSheetActionOpenDocumentHint', @sdxSpreadSheetActionOpenDocumentHint);
  AProduct.Add('sdxSpreadSheetActionSaveDocumentAsCaption', @sdxSpreadSheetActionSaveDocumentAsCaption);
  AProduct.Add('sdxSpreadSheetActionSaveDocumentAsHint', @sdxSpreadSheetActionSaveDocumentAsHint);
  // Find And Replace
  AProduct.Add('sdxSpreadSheetActionFindAndReplaceCaption', @sdxSpreadSheetActionFindAndReplaceCaption);
  AProduct.Add('sdxSpreadSheetActionFindAndReplaceHint', @sdxSpreadSheetActionFindAndReplaceHint);
  // Page Layout
  AProduct.Add('sdxSpreadSheetActionClearPrintAreaCaption', @sdxSpreadSheetActionClearPrintAreaCaption);
  AProduct.Add('sdxSpreadSheetActionClearPrintAreaHint', @sdxSpreadSheetActionClearPrintAreaHint);
  AProduct.Add('sdxSpreadSheetActionSetPrintAreaCaption', @sdxSpreadSheetActionSetPrintAreaCaption);
  AProduct.Add('sdxSpreadSheetActionSetPrintAreaHint', @sdxSpreadSheetActionSetPrintAreaHint);
  AProduct.Add('sdxSpreadSheetActionInsertPageBreakCaption', @sdxSpreadSheetActionInsertPageBreakCaption);
  AProduct.Add('sdxSpreadSheetActionInsertPageBreakHint', @sdxSpreadSheetActionInsertPageBreakHint);
  AProduct.Add('sdxSpreadSheetActionRemovePageBreakCaption', @sdxSpreadSheetActionRemovePageBreakCaption);
  AProduct.Add('sdxSpreadSheetActionRemovePageBreakHint', @sdxSpreadSheetActionRemovePageBreakHint);
  AProduct.Add('sdxSpreadSheetActionResetAllPageBreaksCaption', @sdxSpreadSheetActionResetAllPageBreaksCaption);
  AProduct.Add('sdxSpreadSheetActionResetAllPageBreaksHint', @sdxSpreadSheetActionResetAllPageBreaksHint);
  AProduct.Add('sdxSpreadSheetActionPrintTitlesCaption', @sdxSpreadSheetActionPrintTitlesCaption);
  AProduct.Add('sdxSpreadSheetActionPrintTitlesHint', @sdxSpreadSheetActionPrintTitlesHint);
  AProduct.Add('sdxSpreadSheetActionPageOrientationGalleryCaption', @sdxSpreadSheetActionPageOrientationGalleryCaption);
  AProduct.Add('sdxSpreadSheetActionSetLandscapePageOrientationCaption', @sdxSpreadSheetActionSetLandscapePageOrientationCaption);
  AProduct.Add('sdxSpreadSheetActionSetPortraitPageOrientationCaption', @sdxSpreadSheetActionSetPortraitPageOrientationCaption);
  AProduct.Add('sdxSpreadSheetActionPaperSizeGalleryCaption', @sdxSpreadSheetActionPaperSizeGalleryCaption);
  AProduct.Add('sdxSpreadSheetActionMorePaperSizesCaption', @sdxSpreadSheetActionMorePaperSizesCaption);
  AProduct.Add('sdxSpreadSheetActionPageMarginsGalleryCaption', @sdxSpreadSheetActionPageMarginsGalleryCaption);
  AProduct.Add('sdxSpreadSheetActionPageMarginsGalleryNormalMarginsCaption', @sdxSpreadSheetActionPageMarginsGalleryNormalMarginsCaption);
  AProduct.Add('sdxSpreadSheetActionPageMarginsGalleryWideMarginsCaption', @sdxSpreadSheetActionPageMarginsGalleryWideMarginsCaption);
  AProduct.Add('sdxSpreadSheetActionPageMarginsGalleryNarrowMarginsCaption', @sdxSpreadSheetActionPageMarginsGalleryNarrowMarginsCaption);
  AProduct.Add('sdxSpreadSheetActionPageMarginsGalleryTopPartCaption', @sdxSpreadSheetActionPageMarginsGalleryTopPartCaption);
  AProduct.Add('sdxSpreadSheetActionPageMarginsGalleryBottomPartCaption', @sdxSpreadSheetActionPageMarginsGalleryBottomPartCaption);
  AProduct.Add('sdxSpreadSheetActionPageMarginsGalleryLeftPartCaption', @sdxSpreadSheetActionPageMarginsGalleryLeftPartCaption);
  AProduct.Add('sdxSpreadSheetActionPageMarginsGalleryRightPartCaption', @sdxSpreadSheetActionPageMarginsGalleryRightPartCaption);
  AProduct.Add('sdxSpreadSheetActionPageMarginsGalleryHeaderPartCaption', @sdxSpreadSheetActionPageMarginsGalleryHeaderPartCaption);
  AProduct.Add('sdxSpreadSheetActionPageMarginsGalleryFooterPartCaption', @sdxSpreadSheetActionPageMarginsGalleryFooterPartCaption);
  AProduct.Add('sdxSpreadSheetActionMorePageMarginsCaption', @sdxSpreadSheetActionMorePageMarginsCaption);
  // Links
  AProduct.Add('sdxSpreadSheetActionShowHyperlinkEditorCaption', @sdxSpreadSheetActionShowHyperlinkEditorCaption);
  AProduct.Add('sdxSpreadSheetActionShowHyperlinkEditorHint', @sdxSpreadSheetActionShowHyperlinkEditorHint);
  // Picture
  AProduct.Add('sdxSpreadSheetActionInsertPictureCaption', @sdxSpreadSheetActionInsertPictureCaption);
  AProduct.Add('sdxSpreadSheetActionInsertPictureHint', @sdxSpreadSheetActionInsertPictureHint);
  // Conditional Formatting
  AProduct.Add('sdxSpreadSheetActionShowConditionalFormattingRulesManagerCaption', @sdxSpreadSheetActionShowConditionalFormattingRulesManagerCaption);
  AProduct.Add('sdxSpreadSheetActionShowConditionalFormattingRulesManagerHint', @sdxSpreadSheetActionShowConditionalFormattingRulesManagerHint);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingTopBottomRulesGalleryCaption', @sdxSpreadSheetActionConditionalFormattingTopBottomRulesGalleryCaption);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingTopBottomRulesGalleryTop10ItemsCaption', @sdxSpreadSheetActionConditionalFormattingTopBottomRulesGalleryTop10ItemsCaption);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingTopBottomRulesGalleryTop10PercentsCaption', @sdxSpreadSheetActionConditionalFormattingTopBottomRulesGalleryTop10PercentsCaption);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingTopBottomRulesGalleryBottom10ItemsCaption', @sdxSpreadSheetActionConditionalFormattingTopBottomRulesGalleryBottom10ItemsCaption);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingTopBottomRulesGalleryBottom10PercentsCaption', @sdxSpreadSheetActionConditionalFormattingTopBottomRulesGalleryBottom10PercentsCaption);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingTopBottomRulesGalleryAboveAverageCaption', @sdxSpreadSheetActionConditionalFormattingTopBottomRulesGalleryAboveAverageCaption);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingTopBottomRulesGalleryBelowAverageCaption', @sdxSpreadSheetActionConditionalFormattingTopBottomRulesGalleryBelowAverageCaption);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingColorScalesGalleryCaption', @sdxSpreadSheetActionConditionalFormattingColorScalesGalleryCaption);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingDataBarsGalleryCaption', @sdxSpreadSheetActionConditionalFormattingDataBarsGalleryCaption);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingDataBarsGalleryGradientFillGroupCaption', @sdxSpreadSheetActionConditionalFormattingDataBarsGalleryGradientFillGroupCaption);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingDataBarsGallerySolidFillGroupCaption', @sdxSpreadSheetActionConditionalFormattingDataBarsGallerySolidFillGroupCaption);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingIconSetsGalleryCaption', @sdxSpreadSheetActionConditionalFormattingIconSetsGalleryCaption);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingIconSetsGalleryDirectionalGroupCaption', @sdxSpreadSheetActionConditionalFormattingIconSetsGalleryDirectionalGroupCaption);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingIconSetsGalleryShapesGroupCaption', @sdxSpreadSheetActionConditionalFormattingIconSetsGalleryShapesGroupCaption);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingIconSetsGalleryIndicatorsGroupCaption', @sdxSpreadSheetActionConditionalFormattingIconSetsGalleryIndicatorsGroupCaption);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingIconSetsGalleryRatingsGroupCaption', @sdxSpreadSheetActionConditionalFormattingIconSetsGalleryRatingsGroupCaption);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingMoreRulesCaption', @sdxSpreadSheetActionConditionalFormattingMoreRulesCaption);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingMoreRulesHint', @sdxSpreadSheetActionConditionalFormattingMoreRulesHint);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingNewRuleCaption', @sdxSpreadSheetActionConditionalFormattingNewRuleCaption);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingNewRuleHint', @sdxSpreadSheetActionConditionalFormattingNewRuleHint);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingClearRulesFromSelectedCellsCaption', @sdxSpreadSheetActionConditionalFormattingClearRulesFromSelectedCellsCaption);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingClearRulesFromSelectedCellsHint', @sdxSpreadSheetActionConditionalFormattingClearRulesFromSelectedCellsHint);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingClearRulesFromEntireSheetCaption', @sdxSpreadSheetActionConditionalFormattingClearRulesFromEntireSheetCaption);
  AProduct.Add('sdxSpreadSheetActionConditionalFormattingClearRulesFromEntireSheetHint', @sdxSpreadSheetActionConditionalFormattingClearRulesFromEntireSheetHint);
  // Protection
  AProduct.Add('sdxSpreadSheetActionProtectSheetCaption', @sdxSpreadSheetActionProtectSheetCaption);
  AProduct.Add('sdxSpreadSheetActionProtectSheetHint', @sdxSpreadSheetActionProtectSheetHint);
  AProduct.Add('sdxSpreadSheetActionProtectWorkbookCaption', @sdxSpreadSheetActionProtectWorkbookCaption);
  AProduct.Add('sdxSpreadSheetActionProtectWorkbookHint', @sdxSpreadSheetActionProtectWorkbookHint);
  // Formulas
  AProduct.Add('sdxSpreadSheetActionAutoSumGalleryCaption', @sdxSpreadSheetActionAutoSumGalleryCaption);
  AProduct.Add('sdxSpreadSheetActionAutoSumGallerySumCaption', @sdxSpreadSheetActionAutoSumGallerySumCaption);
  AProduct.Add('sdxSpreadSheetActionAutoSumGalleryAverageCaption', @sdxSpreadSheetActionAutoSumGalleryAverageCaption);
  AProduct.Add('sdxSpreadSheetActionAutoSumGalleryCountNumbersCaption', @sdxSpreadSheetActionAutoSumGalleryCountNumbersCaption);
  AProduct.Add('sdxSpreadSheetActionAutoSumGalleryMaxCaption', @sdxSpreadSheetActionAutoSumGalleryMaxCaption);
  AProduct.Add('sdxSpreadSheetActionAutoSumGalleryMinCaption', @sdxSpreadSheetActionAutoSumGalleryMinCaption);
  // DefinedNames
  AProduct.Add('sdxSpreadSheetActionCreateDefinedNameCaption', @sdxSpreadSheetActionCreateDefinedNameCaption);
  AProduct.Add('sdxSpreadSheetActionCreateDefinedNamesFromSelectionCaption', @sdxSpreadSheetActionCreateDefinedNamesFromSelectionCaption);
  AProduct.Add('sdxSpreadSheetActionShowDefinedNameManagerCaption', @sdxSpreadSheetActionShowDefinedNameManagerCaption);
  AProduct.Add('sdxSpreadSheetActionUseDefinedNameInFormulaCaption', @sdxSpreadSheetActionUseDefinedNameInFormulaCaption);
  // Other
  AProduct.Add('sdxSpreadSheetActionInsertPictureDialogTitle', @sdxSpreadSheetActionInsertPictureDialogTitle);
end;


initialization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.RegisterProduct('ExpressSpreadSheet 2', @AddSpreadSheetActionsResourceStringNames);
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
finalization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.UnRegisterProduct('ExpressSpreadSheet 2', @AddSpreadSheetActionsResourceStringNames);
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
end.
