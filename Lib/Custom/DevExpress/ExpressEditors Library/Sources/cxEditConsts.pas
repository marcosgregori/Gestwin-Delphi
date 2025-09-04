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

unit cxEditConsts;

{$I cxVer.inc}

interface

uses
  cxLibraryConsts;

resourcestring
  // Common
  cxSEditButtonCancel = 'Cancelar';
  cxSEditButtonOK = 'Aceptar';
  cxSEditDateConvertError = 'No lo puedo convertir en una fecha';
  cxSEditInvalidRepositoryItem = 'El elemento del repositorio no es aceptable';
  cxSEditNumericValueConvertError = 'No lo puedo convertir en valor numérico';
  cxSEditPopupCircularReferencingError = 'Las referencias circulares no están permitidas';
  cxSEditPostError = 'Ha ocurrido un error al guardar el valor editado';
  cxSEditTimeConvertError = 'No lo puedo convertir en un valor de tiempo';
  cxSEditDurationConvertError = 'No lo puedo convertir en un valor de duración';  //..
  cxSEditValidateErrorText = 'Valor introducido incorrecto. Pulse la tecla <b>&lt;Esc&gt;</b> para deshacer los cambios';
  cxSEditValueOutOfBounds = 'Valor fuera de límites';
  cxSEditIntegerValueOutOfBounds = 'Valor fuera de límites|El valor debe estar comprendido entre %.0f y %.0f.';
  //..
  cxSEditDecimalsValidateError = 'Este valor numérico debe tener como máximo %d dígitos y %d decimales.';
  cxSEditValueRequired = 'Dato necesario. Debe introducir algún valor.|La información contenida en este campo es indispensable.';
  //..

  cxSEditCheckBoxChecked             = 'True';
  cxSEditCheckBoxGrayed              = '';
  cxSEditCheckBoxUnchecked           = 'False';
  cxSRadioGroupDefaultCaption        = '';

  cxSTextTrue                        = 'True';
  cxSTextFalse                       = 'False';

  // Combo
  cxSNoMatchesFound                  = 'No hay coincidencias';
  // Blob
  cxSBlobButtonOK                    = '&Aceptar';
  cxSBlobButtonCancel                = '&Cancelar';
  cxSBlobButtonClose                 = '&Cerrar';
  cxSBlobMemo                        = '(MEMO)';
  cxSBlobMemoEmpty                   = '(memo)';
  cxSBlobPicture                     = '(IMAGEN)';
  cxSBlobPictureEmpty                = '(imagen)';

  // popup menu items
  cxSMenuItemCaptionCut              = 'Cor&tar';
  cxSMenuItemCaptionCopy             = '&Copiar';
  cxSMenuItemCaptionPaste            = '&Pegar';
  cxSMenuItemCaptionDelete           = '&Borrar';
  cxSMenuItemCaptionLoad             = 'Car&gar...';
  cxSMenuItemCaptionSave             = '&Guardar como...';
  cxSMenuItemCaptionAssignFromWebCam = 'Asignar desde la cá&mara...';
  cxSMenuItemCaptionEdit             = '&Editar...';

  // Date
  cxSDatePopupClear                  = 'Limpiar';
  cxSDatePopupNow                    = 'Ahora';
  cxSDatePopupOK                     = 'Aceptar';
  cxSDatePopupToday                  = 'Hoy';
  cxSDatePopupCancel                 = 'Cancelar';
  cxSDateError                       = 'Fecha incorrecta';

  // Calculator
  scxSCalcError                      = 'Error';

  // HyperLink
  scxSHyperLinkPrefix                = 'http://';
  scxSHyperLinkDoubleSlash           = '//';

  // Navigator
  cxNavigatorHint_First = 'Primer registro';
  cxNavigatorHint_Prior = 'Registro anterior';
  cxNavigatorHint_PriorPage = 'Página anterior';
  cxNavigatorHint_Next = 'Próximo registro';
  cxNavigatorHint_NextPage = 'Próxima página';
  cxNavigatorHint_Last = 'Último registro';
  cxNavigatorHint_Insert = 'Insertar registro';
  cxNavigatorHint_Append = 'Añadir registro';
  cxNavigatorHint_Delete = 'Suprimir registro';
  cxNavigatorHint_Edit = 'Editar registro';
  cxNavigatorHint_Post = 'Guardar cambios';
  cxNavigatorHint_Cancel = 'Cancelar edición';
  cxNavigatorHint_Refresh = 'Refrescar datos';
  cxNavigatorHint_SaveBookmark = 'Guardar marcador';
  cxNavigatorHint_GotoBookmark = 'Ir a marcador';
  cxNavigatorHint_Filter = 'Filtrar datos';
  cxNavigator_DeleteRecordQuestion = '¿Suprimir registro?';
  cxNavigatorInfoPanelDefaultDisplayMask = '[RecordIndex] de [RecordCount]';

  // BreadcrumbEdit
  sdxBreadcrumbEditInvalidPath = 'No puedo encontrar "%s". Revise la ortografía e inténtelo de nuevo.';
  sdxBreadcrumbEditInvalidStreamVersion = 'Versión de datos no válida : %d';

  // Edit Repository
  scxSEditRepositoryBlobItem         = 'BlobEdit|Represents an editor of BLOB (Binary Large OBject) data';
  scxSEditRepositoryButtonItem       = 'ButtonEdit|Represents an editor with embedded buttons';
  scxSEditRepositoryCalcItem         = 'CalcEdit|Represents an editor with a dropdown calculator window';
  scxSEditRepositoryCheckBoxItem     = 'CheckBox|Represents a check box control that allows selecting an option';
  scxSEditRepositoryComboBoxItem     = 'ComboBox|Represents the combo box editor';
  scxSEditRepositoryCurrencyItem     = 'CurrencyEdit|Represents an editor enabling editing currency data';
  scxSEditRepositoryIntegerItem      = 'IntegerEdit|Represents an editor enabling editing integer data'; //..
  scxSEditRepositoryDateItem         = 'DateEdit|Represents an editor with a dropdown calendar';
  scxSEditRepositoryHyperLinkItem    = 'HyperLink|Represents a text editor with hyperlink functionality';
  scxSEditRepositoryImageComboBoxItem = 'ImageComboBox|Represents an editor displaying the list of images and text strings within the dropdown window';
  scxSEditRepositoryImageItem        = 'Image|Represents an image editor';
  scxSEditRepositoryLookupComboBoxItem = 'LookupComboBox|Represents a lookup combo box control';
  scxSEditRepositoryMaskItem         = 'MaskEdit|Represents a generic masked editor.';
  scxSEditRepositoryMemoItem         = 'Memo|Represents an editor that allows editing memo data';
  scxSEditRepositoryMRUItem          = 'MRUEdit|Represents a text editor displaying the list of most recently used items (MRU) within a dropdown window';
  scxSEditRepositoryPopupItem        = 'PopupEdit|Represents an editor with a dropdown list';
  scxSEditRepositorySpinItem         = 'SpinEdit|Represents a spin editor';
  scxSEditRepositoryRadioGroupItem   = 'RadioGroup|Represents a group of radio buttons';
  scxSEditRepositoryTextItem         = 'TextEdit|Represents a single line text editor';
  scxSEditRepositoryTimeItem         = 'TimeEdit|Represents an editor displaying time values';
  scxSEditRepositoryToggleSwitchItem = 'ToggleSwitch|Represents a toggle switch editor that allows selecting an option';
  scxSEditRepositoryDateTimeWheelPickerItem = 'DateTimeWheelPicker|Represents an editor that allows the selection of a date-time value using a wheel picker';
  scxSEditRepositorySparklineItem    = 'Sparkline|Represents a sparkline editor';
  scxSEditRepositoryLookupSparklineItem = 'LookupSparkline|Represents a lookup sparkline editor';
  scxSEditRepositoryNumericWheelPickerItem = 'NumericWheelPicker|Represents an editor that allows the selection of a numeric value using a wheel picker';
  scxSEditRepositoryBarCodeItem    = 'BarCode|Represents a barcode editor';
  scxSEditRepositoryTokenItem      = 'TokenEdit|Represents an editor that visualizes text list items as simpler tokens';
  scxSEditRepositoryFormattedLabelItem = 'FormattedLabel|Represents a label that displays text formatted using BBCode-inspired markup tags';

  // Regular Expressions
  scxRegExprLine = 'Linea';
  scxRegExprChar = 'Caracter';
  scxRegExprNotAssignedSourceStream = 'The source stream is not assigned';
  scxRegExprEmptySourceStream = 'The source stream is empty';
  scxRegExprCantUsePlusQuantifier = 'The ''+'' quantifier cannot be applied here';
  scxRegExprCantUseStarQuantifier = 'The ''*'' quantifier cannot be applied here';
  scxRegExprCantCreateEmptyAlt = 'The alternative should not be empty';
  scxRegExprCantCreateEmptyBlock = 'The block should not be empty';
  scxRegExprIllegalSymbol = 'Illegal ''%s''';
  scxRegExprIllegalQuantifier = 'Illegal quantifier ''%s''';
  scxRegExprNotSupportQuantifier = 'The parameter quantifiers are not supported';
  scxRegExprIllegalIntegerValue = 'Illegal integer value';
  scxRegExprTooBigReferenceNumber = 'Too big reference number';
  scxRegExprCantCreateEmptyEnum = 'Can''t create empty enumeration';
  scxRegExprSubrangeOrder = 'The starting character of the subrange must be less than the finishing one';
  scxRegExprHexNumberExpected0 = 'Hexadecimal number expected';
  scxRegExprHexNumberExpected = 'Hexadecimal number expected but ''%s'' found';
  scxRegExprMissing = 'Missing ''%s''';
  scxRegExprUnnecessary = 'Unnecessary ''%s''';
  scxRegExprIncorrectSpace = 'The space character is not allowed after ''\''';
  scxRegExprNotCompiled = 'Regular expression is not compiled';
  scxRegExprIncorrectParameterQuantifier = 'Incorrect parameter quantifier';
  scxRegExprCantUseParameterQuantifier = 'The parameter quantifier cannot be applied here';

  // MaskEdit
  scxMaskEditRegExprError = 'Errores de la expresión regular:';
  scxMaskEditInvalidEditValue = 'El valor editado no es válido';
  scxMaskEditNoMask = 'Ninguno';
  scxMaskEditIllegalFileFormat = 'Formato de fichero no válido';
  scxMaskEditEmptyMaskCollectionFile = 'The mask collection file is empty';
  scxMaskEditMaskCollectionFiles = 'Mask collection files';
  // SpinEdit
  cxSSpinEditInvalidNumericValue = 'Valor numérico no válido';
  sdxSpinEditForwardButtonUIAName = 'Incrementar';
  sdxSpinEditBackwardButtonUIAName = 'Decrementar';
  sdxSpinEditFastForwardButtonUIAName = 'Incremento largo';
  sdxSpinEditFastBackwardButtonUIAName = 'Decremento largo';

  // DateEdit
  sdxDateEditSelectMonthButtonUIAName = 'Seleccionar';
  sdxDateEditSelectYearButtonUIAName = 'Seleccionar';
  sdxDateEditSelectPreviousDecadeButtonUIAName = 'Seleccior década previa';
  sdxDateEditSelectNextDecadeButtonUIAName = 'Seleccionar próxima década';
  sdxDateEditSelectPreviousCenturyButtonUIAName = 'Seleccionar siglo anterior';
  sdxDateEditSelectNextCenturyButtonUIAName = 'Seleccionar próximo siglo';

  // AlertWindow
  sdxAlertWindowNavigationPanelDefaultDisplayMask = '[MessageIndex] de [MessageCount]';
  sdxAlertWindowPreviousMessage = 'Mensaje anterior';
  sdxAlertWindowNextMessage = 'Mensaje siguiente';
  sdxAlertWindowPin = 'Sujetar';
  sdxAlertWindowClose = 'Cerrar';
  sdxAlertWindowDropdown = 'Mostrar el menú desplegable';

 // DropDown
  sdxDropDownButtonUIANameOpen = 'Abrir';
  sdxDropDownButtonUIANameClose = 'Cerrar';

  // ColorComboBox
  sdxColorComboBoxSelectColorButtonUIAName = 'Abrir diálogo color';
  // ColorGallery
  sdxColorGalleryThemeColors = 'Colores del tema';
  sdxColorGalleryStandardColors = 'Colores estandar';

  // ColorDialog
  sdxColorDialogAddToCustomColors = '&Add to Custom Colors';
  sdxColorDialogApply = '&OK';
  sdxColorDialogCancel = '&Cancel';
  sdxColorDialogDefineCustomColor = '&Define Custom Colors >>';
  sdxColorDialogBasicColors = 'Basic Colors';
  sdxColorDialogCaption = 'Color Editor';
  sdxColorDialogCustomColors = 'Custom Colors';

  // ColorPicker
  sdxColorPickerAlphaLabel = 'A:';
  sdxColorPickerBlueLabel = 'B:';
  sdxColorPickerGreenLabel = 'G:';
  sdxColorPickerHexCodeLabel = '#';
  sdxColorPickerHueLabel = 'H:';
  sdxColorPickerLightnessLabel = 'L:';
  sdxColorPickerRedLabel = 'R:';
  sdxColorPickerSaturationLabel = 'S:';

  // ShellBrowser
  scxShellBrowserDlgCaption = 'Browse for Folder';
  scxShellBrowserDlgCurrentFolderCaption = 'Current Folder';

  // CameraControl
  sdxCameraDialogAssign = '&Assign';
  sdxCameraDialogCancel = '&Cancel';
  sdxCameraDialogPause = '&Pause';
  sdxCameraDialogPlay = '&Play';
  sdxCameraDialogCaption = 'Camera Preview';
  sdxCameraInactive = 'Inactive';
  sdxCameraRunning = 'Running';
  sdxCameraPaused = 'Paused';
  sdxCameraNotDetected = 'No camera detected';
  sdxCameraInitializing = 'Initializing...';
  sdxCameraIsBusy = 'Camera is inaccessible.'#13#10'Try closing other programs that might be using your camera';
  sdxCameraControlSettingsFormSettings = 'Settings';
  sdxCameraControlSettingsFormDevice = 'Device';
  sdxCameraControlSettingsFormDevices = 'Devices';
  sdxCameraControlSettingsFormResolution = 'Resolution';
  sdxCameraControlSettingsFormResolutions = 'Resolutions';

  // ImageEditor
  sdxImageEditorDialogCaption = 'Image editor';
  sdxImageEditorDialogCloseCaption = 'Close Editor';
  sdxImageEditorDialogCloseConfirmation = 'Do you want to save the changes';
  sdxImageEditorDialogBtnSave = 'Save';
  sdxImageEditorDialogBtnActionDone = 'Done';
  sdxImageEditorDialogBtnActionCancel = 'Cancel';
  sdxImageEditorDialogCropAspectRatio = 'Aspect Ratio:';
  sdxImageEditorDialogCropAspectRatioManual = 'Manual';
  sdxImageEditorDialogCropAspectRatioOriginal = 'Original';
  sdxImageEditorDialogCropAspectRatioSquare = 'Square';
  sdxImageEditorDialogCropWidth = 'Width:';
  sdxImageEditorDialogCropHeight = 'Height:';
  sdxImageEditorDialogAdjustColorContrast = 'Contrast:';
  sdxImageEditorDialogAdjustColorBrightness = 'Brightness:';
  sdxImageEditorDialogAdjustColorSaturation = 'Saturation:';
  sdxImageEditorDialogActionRotateCounterclockwise =  'Rotate Counterclockwise';
  sdxImageEditorDialogActionRotateClockwise =         'Rotate Clockwise';
  sdxImageEditorDialogActionCrop = 'Crop';
  sdxImageEditorDialogActionDesaturate = 'Desaturate';
  sdxImageEditorDialogActionAdjustColors = 'Adjust Colors';
  sdxImageEditorDialogActionMirror = 'Mirror';
  sdxImageEditorDialogActionUndo = 'Undo';
  sdxImageEditorDialogActionRedo = 'Redo';
  // ToggleSwitch
  sdxDefaultToggleSwitchOffText = 'No';
  sdxDefaultToggleSwitchOnText = 'Sí';
  // DateTimeWheelPicker
  sdxDateTimeWheelPickerHours = 'Horas';
  sdxDateTimeWheelPickerMinutes = 'Minutos';
  sdxDateTimeWheelPickerSeconds = 'Segundos';

  // Sparkline
  sdxSparklineNoData = '<Sin datos>';

  // BarCode
  sdxBarCodeInvalidCharactersError = 'Caracteres no válidos en e texto';
  sdxBarCodeInvalidTextFormatError = 'Formato de texto incorrecto';
  sdxBarCodeControlTooNarrowError = 'El control es demasiado estrecho para mostrar el código de barras';

  // TokenEdit
  sdxTokenEditMoreTokensCaption = '...';
  sdxTokenEditMoreTokensHint = '%d fichas ocultas(s):'#13#10'(%s)';

  // RangeControl
  sdxRangeControlRangeIsEmpty = 'Rango vacío';

  // UIAdorners
  sdxUIAdornerManagerBadOwner = 'TdxUIAdornerManager should have TWinControl as its Owner';

  //ExcelFilterValueContainer
  sdxExcelFilterFromValueText = 'Desde';
  sdxExcelFilterToValueText = 'Hasta';
  sdxExcelFilterTopNBottomNValueLabel = 'Valor';
  sdxExcelFilterTopNBottomNTypeLabel = 'Tipo';
  sdxExcelFilterCustomFilterAndOperatorLabel = 'Y';
  sdxExcelFilterCustomFilterOrOperatorLabel = 'O';
  sdxExcelFilterCustomFilterFirstConditionLabel = 'Primero';
  sdxExcelFilterCustomFilterSecondConditionLabel = 'Segundo';
  sdxExcelFilterValuesTabCaption = 'Valores';
  sdxExcelFilterDateFiltersTabCaption = 'Filtros de fecha';
  sdxExcelFilterTextFiltersTabCaption = 'Filtros de texto';
  sdxExcelFilterTimeFiltersTabCaption = 'Filtros de hora';
  sdxExcelFilterNumericFiltersTabCaption = 'Filtros numéricos';
  sdxExcelFilterSelectValueHintText = 'Seleccione un valor...';
  sdxExcelFilterSelectDateHintText = 'Seleccione una fecha...';
  sdxExcelFilterEnterValueHintText = 'Introduzca un valor...';
  sdxExcelFilterSpecificDatePeriodsConditionText = 'Especifique periodos de fecha';
  sdxExcelFilterEqualsConditionText = 'Igual';
  sdxExcelFilterDoesNotEqualConditionText = 'Distinto';
  sdxExcelFilterBeginsWithConditionText = 'Empieza con';
  sdxExcelFilterEndsWithConditionText = 'Acaba con';
  sdxExcelFilterContainsConditionText = 'Contiene';
  sdxExcelFilterDoesNotContainConditionText = 'No contiene';
  sdxExcelFilterIsBlankConditionText = 'Está vacío';
  sdxExcelFilterIsNotBlankConditionText = 'No está vacío';
  sdxExcelFilterBetweenConditionText = 'Entre';
  sdxExcelFilterGreaterThanConditionText = 'Mayor que';
  sdxExcelFilterGreaterThanOrEqualToConditionText = 'Mayor o igual que';
  sdxExcelFilterLessThanConditionText = 'Menor que';
  sdxExcelFilterLessEqualThanOrEqualToConditionText = 'Menor o igual que';
  sdxExcelFilterTopNConditionText = 'N primeros';
  sdxExcelFilterBottomNConditionText = 'N últimos';
  sdxExcelFilterAboveAverageConditionText = 'Por encima de la media';
  sdxExcelFilterBelowAverageConditionText = 'Por debajo de la media';
  sdxExcelFilterBeforeConditionText = 'Antes';
  sdxExcelFilterAfterConditionText = 'Después';
  sdxExcelFilterYesterdayConditionText = 'Ayer';
  sdxExcelFilterTodayConditionTypeText = 'Hoy';
  sdxExcelFilterTomorrowConditionText = 'Mañana';
  sdxExcelFilterLastWeekConditionText = 'Última semana';
  sdxExcelFilterThisWeekConditionText = 'Esta semana';
  sdxExcelFilterNextWeekConditionText = 'Próxima semana';
  sdxExcelFilterLastMonthConditionText = 'Últmo mes';
  sdxExcelFilterThisMonthConditionText = 'Este mes';
  sdxExcelFilterNextMonthConditionText = 'Próximo mes';
  sdxExcelFilterLastYearConditionText = 'Último año';
  sdxExcelFilterThisYearConditionText = 'Este año';
  sdxExcelFilterNextYearConditionText = 'Próximo año';
  sdxExcelFilterCustomFilterConditionText = 'Filtro personalizado';
  sdxExcelFilterPredefinedFiltersConditionText = 'Predefined Filters';
  sdxExcelFilterTopNBottomNItemsText = 'Elementos';
  sdxExcelFilterTopNBottomNPercentText = 'Porcentaje';


  // EditPopupWindow
  sdxEditPopupWindowUIAName = 'Popup';

  // DateEditPopupWindow
  sdxDateEditPopupWindowUIAName = ' Popup calendario';
  //FilterPopupWindow
  sdxFilterPopupWindowClearButtonCaption = 'Limpiar filtro';
  sdxFilterPopupWindowCloseButtonCaption = 'Cerrar';
  sdxFilterPopupWindowCancelButtonCaption = 'Cancelar';
  sdxFilterPopupWindowOKButtonCaption = 'Aceptar';
  //dxShellDialogs
  sdxFileDialogFileNotExistWarning = #13+#10+'Fichero no encontrado.'+#13+#10+'Compruebe el nombre del fichero y reinténtelo.';

  sdxFileDialogBackDisabledHint = 'Volver';
  sdxFileDialogBackEnabledHint = 'Volver a %s (Alt+Izq)';
  sdxFileDialogFileNameCaption = 'Nombre del fichero:';
  sdxFileDialogFilePreviewHidePaneHint = 'Hide the preview pane.';
  sdxFileDialogFilePreviewShowPaneHint = 'Show the preview pane.';
  sdxFileDialogForwardDisabledHint = 'Adelante';
  sdxFileDialogForwardEnabledHint = 'Adelante hasta %s (Alt+Derecha)';
  sdxFileDialogHistoryHint = 'Páginas recientes';
  sdxFileDialogNewFolderCaption = 'Nueva carpeta';
  sdxFileDialogNewFolderHint = 'Crear una nueva carpeta vacía.';
  sdxFileDialogSearchNullstring = 'Buscar...';
   sdxFileDialogUpHint = 'Arriba';
  sdxFileDialogViewsHint = 'Cambiar la vista.';

  sdxShellViewsCaption = 'Vista';
  sdxShellExtraLargeIconsCaption = 'Iconos extra grandes';
  sdxShellLargeIconsCaption = 'Iconos grandes';
  sdxShellMediumIconsCaption = 'Iconos medianos';
  sdxShellSmallIconsCaption = 'Iconos pequeños';
  sdxShellIconsCaption = 'Iconos';
  sdxShellListCaption = 'Lista';
  sdxShellDetailsCaption = 'Detalles';

  sdxOpenFileDialogOkCaption = 'Abrir';
  sdxOpenFileDialogDefaultTitle = 'Abrir';

  sdxSaveFileDialogOkCaption = 'Guardar';
  sdxSaveFileDialogDefaultTitle = 'Guardar';
  sdxShellListViewMenuItemPaste = 'Pegar';
  sdxShellListViewMenuItemRefresh = 'Refrescar';
  sdxShellListViewMenuItemSort = 'Ordenar por';
  sdxShellListViewMenuItemSortAscending = 'Ascendente';
  sdxShellListViewMenuItemSortDescending = 'Descendente';
  sdxShellListViewWorkingOnIt = 'Working on it...';
  sdxShellListViewNoItemsMatch = 'No items match your search.';

  //dxShellColumnsCustomization
  sdxDetails = 'Detalles:';
  sdxColumnWidthCaption = 'Anchura de la columna seleccionada (en pixels):';
  sdxSelectDetailsCaption = 'Selecione los detalles que quiere mostrar en los elementos de esta carpeta.';
  sdxChooseDetails = 'Elegir detalles';
  sdxMoveUp = 'Subir';
  sdxMoveDown = 'Bajar';
  sdxHide = 'Ocultar';
  sdxShow = 'Mostrar';

  //dxShellFilePreview
  sdxFilePreviewPanePreviewMessageEmpty = 'No preview available.';
  sdxFilePreviewPanePreviewMessageNoFile = 'Select a file to preview.';

  // LayoutControl
  sdxLayoutControlGroupCaptionCheckBoxUIAName = 'enable or disable all items in the current group';

implementation

uses
  dxCore, Vcl.Consts;

const
  dxThisUnitName = 'cxEditConsts';

procedure AddEditorsResourceStringNames(AProduct: TdxProductResourceStrings);

  procedure InternalAdd(const AResourceStringName: string; AAddress: Pointer);
  begin
    AProduct.Add(AResourceStringName, AAddress);
  end;

begin
  InternalAdd('cxSEditButtonCancel', @cxSEditButtonCancel);
  InternalAdd('cxSEditButtonOK', @cxSEditButtonOK);
  InternalAdd('cxSEditDateConvertError', @cxSEditDateConvertError);
  InternalAdd('cxSEditInvalidRepositoryItem', @cxSEditInvalidRepositoryItem);
  InternalAdd('cxSEditNumericValueConvertError', @cxSEditNumericValueConvertError);
  InternalAdd('cxSEditPopupCircularReferencingError', @cxSEditPopupCircularReferencingError);
  InternalAdd('cxSEditPostError', @cxSEditPostError);
  InternalAdd('cxSEditTimeConvertError', @cxSEditTimeConvertError);
  InternalAdd('cxSEditValidateErrorText', @cxSEditValidateErrorText);
  InternalAdd('cxSEditValueOutOfBounds', @cxSEditValueOutOfBounds);
  InternalAdd('cxSEditCheckBoxChecked', @cxSEditCheckBoxChecked);
  InternalAdd('cxSEditCheckBoxGrayed', @cxSEditCheckBoxGrayed);
  InternalAdd('cxSEditCheckBoxUnchecked', @cxSEditCheckBoxUnchecked);
  InternalAdd('cxSRadioGroupDefaultCaption', @cxSRadioGroupDefaultCaption);
  InternalAdd('cxSTextTrue', @cxSTextTrue);
  InternalAdd('cxSTextFalse', @cxSTextFalse);
  InternalAdd('cxSNoMatchesFound', @cxSNoMatchesFound);
  InternalAdd('cxSBlobButtonOK', @cxSBlobButtonOK);
  InternalAdd('cxSBlobButtonCancel', @cxSBlobButtonCancel);
  InternalAdd('cxSBlobButtonClose', @cxSBlobButtonClose);
  InternalAdd('cxSBlobMemo', @cxSBlobMemo);
  InternalAdd('cxSBlobMemoEmpty', @cxSBlobMemoEmpty);
  InternalAdd('cxSBlobPicture', @cxSBlobPicture);
  InternalAdd('cxSBlobPictureEmpty', @cxSBlobPictureEmpty);
  InternalAdd('cxSMenuItemCaptionCut', @cxSMenuItemCaptionCut);
  InternalAdd('cxSMenuItemCaptionCopy', @cxSMenuItemCaptionCopy);
  InternalAdd('cxSMenuItemCaptionPaste', @cxSMenuItemCaptionPaste);
  InternalAdd('cxSMenuItemCaptionDelete', @cxSMenuItemCaptionDelete);
  InternalAdd('cxSMenuItemCaptionLoad', @cxSMenuItemCaptionLoad);
  InternalAdd('cxSMenuItemCaptionSave', @cxSMenuItemCaptionSave);
  InternalAdd('cxSMenuItemCaptionAssignFromWebCam', @cxSMenuItemCaptionAssignFromWebCam);
  InternalAdd('cxSMenuItemCaptionEdit', @cxSMenuItemCaptionEdit);
  InternalAdd('cxSDatePopupClear', @cxSDatePopupClear);
  InternalAdd('cxSDatePopupNow', @cxSDatePopupNow);
  InternalAdd('cxSDatePopupOK', @cxSDatePopupOK);
  InternalAdd('cxSDatePopupToday', @cxSDatePopupToday);
  InternalAdd('cxSDatePopupCancel', @cxSDatePopupCancel);
  InternalAdd('cxSDateError', @cxSDateError);
  InternalAdd('scxSCalcError', @scxSCalcError);
  InternalAdd('scxSHyperLinkPrefix', @scxSHyperLinkPrefix);
  InternalAdd('scxSHyperLinkDoubleSlash', @scxSHyperLinkDoubleSlash);
  InternalAdd('cxNavigatorHint_First', @cxNavigatorHint_First);
  InternalAdd('cxNavigatorHint_Prior', @cxNavigatorHint_Prior);
  InternalAdd('cxNavigatorHint_PriorPage', @cxNavigatorHint_PriorPage);
  InternalAdd('cxNavigatorHint_Next', @cxNavigatorHint_Next);
  InternalAdd('cxNavigatorHint_NextPage', @cxNavigatorHint_NextPage);
  InternalAdd('cxNavigatorHint_Last', @cxNavigatorHint_Last);
  InternalAdd('cxNavigatorHint_Insert', @cxNavigatorHint_Insert);
  InternalAdd('cxNavigatorHint_Append', @cxNavigatorHint_Append);
  InternalAdd('cxNavigatorHint_Delete', @cxNavigatorHint_Delete);
  InternalAdd('cxNavigatorHint_Edit', @cxNavigatorHint_Edit);
  InternalAdd('cxNavigatorHint_Post', @cxNavigatorHint_Post);
  InternalAdd('cxNavigatorHint_Cancel', @cxNavigatorHint_Cancel);
  InternalAdd('cxNavigatorHint_Refresh', @cxNavigatorHint_Refresh);
  InternalAdd('cxNavigatorHint_SaveBookmark', @cxNavigatorHint_SaveBookmark);
  InternalAdd('cxNavigatorHint_GotoBookmark', @cxNavigatorHint_GotoBookmark);
  InternalAdd('cxNavigatorHint_Filter', @cxNavigatorHint_Filter);
  InternalAdd('cxNavigator_DeleteRecordQuestion', @cxNavigator_DeleteRecordQuestion);
  InternalAdd('cxNavigatorInfoPanelDefaultDisplayMask', @cxNavigatorInfoPanelDefaultDisplayMask);
  InternalAdd('scxSEditRepositoryBlobItem', @scxSEditRepositoryBlobItem);
  InternalAdd('scxSEditRepositoryButtonItem', @scxSEditRepositoryButtonItem);
  InternalAdd('scxSEditRepositoryCalcItem', @scxSEditRepositoryCalcItem);
  InternalAdd('scxSEditRepositoryCheckBoxItem', @scxSEditRepositoryCheckBoxItem);
  InternalAdd('scxSEditRepositoryComboBoxItem', @scxSEditRepositoryComboBoxItem);
  InternalAdd('scxSEditRepositoryCurrencyItem', @scxSEditRepositoryCurrencyItem);
  InternalAdd('scxSEditRepositoryIntegerItem', @scxSEditRepositoryIntegerItem);  //..
  InternalAdd('scxSEditRepositoryDateItem', @scxSEditRepositoryDateItem);
  InternalAdd('scxSEditRepositoryHyperLinkItem', @scxSEditRepositoryHyperLinkItem);
  InternalAdd('scxSEditRepositoryImageComboBoxItem', @scxSEditRepositoryImageComboBoxItem);
  InternalAdd('scxSEditRepositoryImageItem', @scxSEditRepositoryImageItem);
  InternalAdd('scxSEditRepositoryLookupComboBoxItem', @scxSEditRepositoryLookupComboBoxItem);
  InternalAdd('scxSEditRepositoryMaskItem', @scxSEditRepositoryMaskItem);
  InternalAdd('scxSEditRepositoryMemoItem', @scxSEditRepositoryMemoItem);
  InternalAdd('scxSEditRepositoryMRUItem', @scxSEditRepositoryMRUItem);
  InternalAdd('scxSEditRepositoryPopupItem', @scxSEditRepositoryPopupItem);
  InternalAdd('scxSEditRepositorySpinItem', @scxSEditRepositorySpinItem);
  InternalAdd('scxSEditRepositoryRadioGroupItem', @scxSEditRepositoryRadioGroupItem);
  InternalAdd('scxSEditRepositoryTextItem', @scxSEditRepositoryTextItem);
  InternalAdd('scxSEditRepositoryTimeItem', @scxSEditRepositoryTimeItem);
  InternalAdd('scxSEditRepositoryToggleSwitchItem', @scxSEditRepositoryToggleSwitchItem);
  InternalAdd('scxSEditRepositoryDateTimeWheelPickerItem', @scxSEditRepositoryDateTimeWheelPickerItem);
  InternalAdd('scxSEditRepositorySparklineItem', @scxSEditRepositorySparklineItem);
  InternalAdd('scxSEditRepositoryLookupSparklineItem', @scxSEditRepositoryLookupSparklineItem);
  InternalAdd('scxSEditRepositoryBarCodeItem', @scxSEditRepositoryBarCodeItem);
  InternalAdd('scxSEditRepositoryTokenItem', @scxSEditRepositoryTokenItem);
  InternalAdd('scxSEditRepositoryNumericWheelPickerItem', @scxSEditRepositoryNumericWheelPickerItem);
  InternalAdd('scxSEditRepositoryFormattedLabelItem', @scxSEditRepositoryFormattedLabelItem);
  InternalAdd('scxRegExprLine', @scxRegExprLine);
  InternalAdd('scxRegExprChar', @scxRegExprChar);
  InternalAdd('scxRegExprNotAssignedSourceStream', @scxRegExprNotAssignedSourceStream);
  InternalAdd('scxRegExprEmptySourceStream', @scxRegExprEmptySourceStream);
  InternalAdd('scxRegExprCantUsePlusQuantifier', @scxRegExprCantUsePlusQuantifier);
  InternalAdd('scxRegExprCantUseStarQuantifier', @scxRegExprCantUseStarQuantifier);
  InternalAdd('scxRegExprCantCreateEmptyAlt', @scxRegExprCantCreateEmptyAlt);
  InternalAdd('scxRegExprCantCreateEmptyBlock', @scxRegExprCantCreateEmptyBlock);
  InternalAdd('scxRegExprIllegalSymbol', @scxRegExprIllegalSymbol);
  InternalAdd('scxRegExprIllegalQuantifier', @scxRegExprIllegalQuantifier);
  InternalAdd('scxRegExprNotSupportQuantifier', @scxRegExprNotSupportQuantifier);
  InternalAdd('scxRegExprIllegalIntegerValue', @scxRegExprIllegalIntegerValue);
  InternalAdd('scxRegExprTooBigReferenceNumber', @scxRegExprTooBigReferenceNumber);
  InternalAdd('scxRegExprCantCreateEmptyEnum', @scxRegExprCantCreateEmptyEnum);
  InternalAdd('scxRegExprSubrangeOrder', @scxRegExprSubrangeOrder);
  InternalAdd('scxRegExprHexNumberExpected0', @scxRegExprHexNumberExpected0);
  InternalAdd('scxRegExprHexNumberExpected', @scxRegExprHexNumberExpected);
  InternalAdd('scxRegExprMissing', @scxRegExprMissing);
  InternalAdd('scxRegExprUnnecessary', @scxRegExprUnnecessary);
  InternalAdd('scxRegExprIncorrectSpace', @scxRegExprIncorrectSpace);
  InternalAdd('scxRegExprNotCompiled', @scxRegExprNotCompiled);
  InternalAdd('scxRegExprIncorrectParameterQuantifier', @scxRegExprIncorrectParameterQuantifier);
  InternalAdd('scxRegExprCantUseParameterQuantifier', @scxRegExprCantUseParameterQuantifier);
  InternalAdd('scxMaskEditRegExprError', @scxMaskEditRegExprError);
  InternalAdd('scxMaskEditInvalidEditValue', @scxMaskEditInvalidEditValue);
  InternalAdd('scxMaskEditNoMask', @scxMaskEditNoMask);
  InternalAdd('scxMaskEditIllegalFileFormat', @scxMaskEditIllegalFileFormat);
  InternalAdd('scxMaskEditEmptyMaskCollectionFile', @scxMaskEditEmptyMaskCollectionFile);
  InternalAdd('scxMaskEditMaskCollectionFiles', @scxMaskEditMaskCollectionFiles);
  InternalAdd('cxSSpinEditInvalidNumericValue', @cxSSpinEditInvalidNumericValue);
  InternalAdd('sdxSpinEditForwardButtonUIAName', @sdxSpinEditForwardButtonUIAName);
  InternalAdd('sdxSpinEditBackwardButtonUIAName', @sdxSpinEditBackwardButtonUIAName);
  InternalAdd('sdxSpinEditFastForwardButtonUIAName', @sdxSpinEditFastForwardButtonUIAName);
  InternalAdd('sdxSpinEditFastBackwardButtonUIAName', @sdxSpinEditFastBackwardButtonUIAName);
  InternalAdd('sdxDateEditSelectMonthButtonUIAName', @sdxDateEditSelectMonthButtonUIAName);
  InternalAdd('sdxDateEditSelectYearButtonUIAName', @sdxDateEditSelectYearButtonUIAName);
  InternalAdd('sdxDateEditSelectPreviousDecadeButtonUIAName', @sdxDateEditSelectPreviousDecadeButtonUIAName);
  InternalAdd('sdxDateEditSelectNextDecadeButtonUIAName', @sdxDateEditSelectNextDecadeButtonUIAName);
  InternalAdd('sdxDateEditSelectPreviousCenturyButtonUIAName', @sdxDateEditSelectPreviousCenturyButtonUIAName);
  InternalAdd('sdxDateEditSelectNextCenturyButtonUIAName', @sdxDateEditSelectNextCenturyButtonUIAName);

  InternalAdd('sdxAlertWindowNavigationPanelDefaultDisplayMask', @sdxAlertWindowNavigationPanelDefaultDisplayMask);
  InternalAdd('sdxAlertWindowPreviousMessage', @sdxAlertWindowPreviousMessage);
  InternalAdd('sdxAlertWindowNextMessage', @sdxAlertWindowNextMessage);
  InternalAdd('sdxAlertWindowPin', @sdxAlertWindowPin);
  InternalAdd('sdxAlertWindowClose', @sdxAlertWindowClose);
  InternalAdd('sdxAlertWindowDropdown', @sdxAlertWindowDropdown);
  InternalAdd('sdxBreadcrumbEditInvalidPath', @sdxBreadcrumbEditInvalidPath);
  InternalAdd('sdxBreadcrumbEditInvalidStreamVersion', @sdxBreadcrumbEditInvalidStreamVersion);
  InternalAdd('sdxDropDownButtonUIANameOpen', @sdxDropDownButtonUIANameOpen);
  InternalAdd('sdxDropDownButtonUIANameClose', @sdxDropDownButtonUIANameClose);
  InternalAdd('sdxColorComboBoxSelectColorButtonUIAName', @sdxColorComboBoxSelectColorButtonUIAName);
  InternalAdd('sdxColorGalleryThemeColors', @sdxColorGalleryThemeColors);
  InternalAdd('sdxColorGalleryStandardColors', @sdxColorGalleryStandardColors);
  InternalAdd('sdxColorDialogAddToCustomColors', @sdxColorDialogAddToCustomColors);
  InternalAdd('sdxColorDialogApply', @sdxColorDialogApply);
  InternalAdd('sdxColorDialogCancel', @sdxColorDialogCancel);
  InternalAdd('sdxColorDialogDefineCustomColor', @sdxColorDialogDefineCustomColor);
  InternalAdd('sdxColorDialogBasicColors', @sdxColorDialogBasicColors);
  InternalAdd('sdxColorDialogCustomColors', @sdxColorDialogCustomColors);
  InternalAdd('sdxColorDialogCaption', @sdxColorDialogCaption);
  InternalAdd('scxShellBrowserDlgCaption', @scxShellBrowserDlgCaption);
  InternalAdd('scxShellBrowserDlgCurrentFolderCaption', @scxShellBrowserDlgCurrentFolderCaption);
  InternalAdd('sdxColorPickerAlphaLabel', @sdxColorPickerAlphaLabel);
  InternalAdd('sdxColorPickerBlueLabel', @sdxColorPickerBlueLabel);
  InternalAdd('sdxColorPickerGreenLabel', @sdxColorPickerGreenLabel);
  InternalAdd('sdxColorPickerHexCodeLabel', @sdxColorPickerHexCodeLabel);
  InternalAdd('sdxColorPickerHueLabel', @sdxColorPickerHueLabel);
  InternalAdd('sdxColorPickerLightnessLabel', @sdxColorPickerLightnessLabel);
  InternalAdd('sdxColorPickerRedLabel', @sdxColorPickerRedLabel);
  InternalAdd('sdxColorPickerSaturationLabel', @sdxColorPickerSaturationLabel);
  InternalAdd('sdxCameraDialogAssign', @sdxCameraDialogAssign);
  InternalAdd('sdxCameraDialogCancel', @sdxCameraDialogCancel);
  InternalAdd('sdxCameraDialogPause', @sdxCameraDialogPause);
  InternalAdd('sdxCameraDialogPlay', @sdxCameraDialogPlay);
  InternalAdd('sdxCameraDialogCaption', @sdxCameraDialogCaption);
  InternalAdd('sdxCameraInactive', @sdxCameraInactive);
  InternalAdd('sdxCameraRunning', @sdxCameraRunning);
  InternalAdd('sdxCameraPaused', @sdxCameraPaused);
  InternalAdd('sdxCameraNotDetected', @sdxCameraNotDetected);
  InternalAdd('sdxCameraInitializing', @sdxCameraInitializing);
  InternalAdd('sdxCameraIsBusy', @sdxCameraIsBusy);
  InternalAdd('sdxCameraControlSettingsFormSettings', @sdxCameraControlSettingsFormSettings);
  InternalAdd('sdxCameraControlSettingsFormDevice', @sdxCameraControlSettingsFormDevice);
  InternalAdd('sdxCameraControlSettingsFormDevices', @sdxCameraControlSettingsFormDevices);
  InternalAdd('sdxCameraControlSettingsFormResolution', @sdxCameraControlSettingsFormResolution);
  InternalAdd('sdxCameraControlSettingsFormResolutions', @sdxCameraControlSettingsFormResolutions);
  InternalAdd('sdxDefaultToggleSwitchOffText', @sdxDefaultToggleSwitchOffText);
  InternalAdd('sdxDefaultToggleSwitchOnText', @sdxDefaultToggleSwitchOnText);
  InternalAdd('sdxDateTimeWheelPickerHours', @sdxDateTimeWheelPickerHours);
  InternalAdd('sdxDateTimeWheelPickerMinutes', @sdxDateTimeWheelPickerMinutes);
  InternalAdd('sdxDateTimeWheelPickerSeconds', @sdxDateTimeWheelPickerSeconds);
  InternalAdd('sdxSparklineNoData', @sdxSparklineNoData);
  InternalAdd('sdxImageEditorDialogCaption', @sdxImageEditorDialogCaption);
  InternalAdd('sdxImageEditorDialogCloseCaption', @sdxImageEditorDialogCloseCaption);
  InternalAdd('sdxImageEditorDialogCloseConfirmation', @sdxImageEditorDialogCloseConfirmation);
  InternalAdd('sdxImageEditorDialogBtnSave', @sdxImageEditorDialogBtnSave);
  InternalAdd('sdxImageEditorDialogBtnActionDone', @sdxImageEditorDialogBtnActionDone);
  InternalAdd('sdxImageEditorDialogBtnActionCancel', @sdxImageEditorDialogBtnActionCancel);
  InternalAdd('sdxImageEditorDialogCropAspectRatio', @sdxImageEditorDialogCropAspectRatio);
  InternalAdd('sdxImageEditorDialogCropAspectRatioManual', @sdxImageEditorDialogCropAspectRatioManual);
  InternalAdd('sdxImageEditorDialogCropAspectRatioOriginal', @sdxImageEditorDialogCropAspectRatioOriginal);
  InternalAdd('sdxImageEditorDialogCropAspectRatioSquare', @sdxImageEditorDialogCropAspectRatioSquare);
  InternalAdd('sdxImageEditorDialogCropWidth', @sdxImageEditorDialogCropWidth);
  InternalAdd('sdxImageEditorDialogCropHeight', @sdxImageEditorDialogCropHeight);
  InternalAdd('sdxImageEditorDialogAdjustColorContrast', @sdxImageEditorDialogAdjustColorContrast);
  InternalAdd('sdxImageEditorDialogAdjustColorBrightness', @sdxImageEditorDialogAdjustColorBrightness);
  InternalAdd('sdxImageEditorDialogAdjustColorSaturation', @sdxImageEditorDialogAdjustColorSaturation);
  InternalAdd('sdxImageEditorDialogActionRotateClockwise', @sdxImageEditorDialogActionRotateClockwise);
  InternalAdd('sdxImageEditorDialogActionRotateCounterclockwise', @sdxImageEditorDialogActionRotateCounterclockwise);
  InternalAdd('sdxImageEditorDialogActionCrop', @sdxImageEditorDialogActionCrop);
  InternalAdd('sdxImageEditorDialogActionDesaturate', @sdxImageEditorDialogActionDesaturate);
  InternalAdd('sdxImageEditorDialogActionAdjustColors', @sdxImageEditorDialogActionAdjustColors);
  InternalAdd('sdxImageEditorDialogActionMirror', @sdxImageEditorDialogActionMirror);
  InternalAdd('sdxImageEditorDialogActionUndo', @sdxImageEditorDialogActionUndo);
  InternalAdd('sdxImageEditorDialogActionRedo', @sdxImageEditorDialogActionRedo);

  InternalAdd('sdxBarCodeInvalidCharactersError', @sdxBarCodeInvalidCharactersError);
  InternalAdd('sdxBarCodeInvalidTextFormatError', @sdxBarCodeInvalidTextFormatError);
  InternalAdd('sdxBarCodeControlTooNarrowError', @sdxBarCodeControlTooNarrowError);

  InternalAdd('sdxTokenEditMoreTokensCaption', @sdxTokenEditMoreTokensCaption);
  InternalAdd('sdxTokenEditMoreTokensHint', @sdxTokenEditMoreTokensHint);
  InternalAdd('sdxRangeControlRangeIsEmpty', @sdxRangeControlRangeIsEmpty);

  InternalAdd('sdxExcelFilterFromValueText', @sdxExcelFilterFromValueText);
  InternalAdd('sdxExcelFilterToValueText', @sdxExcelFilterToValueText);
  InternalAdd('sdxExcelFilterTopNBottomNValueLabel', @sdxExcelFilterTopNBottomNValueLabel);
  InternalAdd('sdxExcelFilterTopNBottomNTypeLabel', @sdxExcelFilterTopNBottomNTypeLabel);
  InternalAdd('sdxExcelFilterCustomFilterAndOperatorLabel', @sdxExcelFilterCustomFilterAndOperatorLabel);
  InternalAdd('sdxExcelFilterCustomFilterOrOperatorLabel', @sdxExcelFilterCustomFilterOrOperatorLabel);
  InternalAdd('sdxExcelFilterCustomFilterFirstConditionLabel', @sdxExcelFilterCustomFilterFirstConditionLabel);
  InternalAdd('sdxExcelFilterCustomFilterSecondConditionLabel', @sdxExcelFilterCustomFilterSecondConditionLabel);
  InternalAdd('sdxExcelFilterValuesTabCaption', @sdxExcelFilterValuesTabCaption);
  InternalAdd('sdxExcelFilterDateFiltersTabCaption', @sdxExcelFilterDateFiltersTabCaption);
  InternalAdd('sdxExcelFilterTextFiltersTabCaption', @sdxExcelFilterTextFiltersTabCaption);
  InternalAdd('sdxExcelFilterTimeFiltersTabCaption', @sdxExcelFilterTimeFiltersTabCaption);
  InternalAdd('sdxExcelFilterNumericFiltersTabCaption', @sdxExcelFilterNumericFiltersTabCaption);
  InternalAdd('sdxExcelFilterSelectValueHintText', @sdxExcelFilterSelectValueHintText);
  InternalAdd('sdxExcelFilterSelectDateHintText', @sdxExcelFilterSelectDateHintText);
  InternalAdd('sdxExcelFilterEnterValueHintText', @sdxExcelFilterEnterValueHintText);
  InternalAdd('sdxExcelFilterSpecificDatePeriodsConditionText', @sdxExcelFilterSpecificDatePeriodsConditionText);
  InternalAdd('sdxExcelFilterEqualsConditionText', @sdxExcelFilterEqualsConditionText);
  InternalAdd('sdxExcelFilterDoesNotEqualConditionText', @sdxExcelFilterDoesNotEqualConditionText);
  InternalAdd('sdxExcelFilterBeginsWithConditionText', @sdxExcelFilterBeginsWithConditionText);
  InternalAdd('sdxExcelFilterEndsWithConditionText', @sdxExcelFilterEndsWithConditionText);
  InternalAdd('sdxExcelFilterContainsConditionText', @sdxExcelFilterContainsConditionText);
  InternalAdd('sdxExcelFilterDoesNotContainConditionText', @sdxExcelFilterDoesNotContainConditionText);
  InternalAdd('sdxExcelFilterIsBlankConditionText', @sdxExcelFilterIsBlankConditionText);
  InternalAdd('sdxExcelFilterIsNotBlankConditionText', @sdxExcelFilterIsNotBlankConditionText);
  InternalAdd('sdxExcelFilterBetweenConditionText', @sdxExcelFilterBetweenConditionText);
  InternalAdd('sdxExcelFilterGreaterThanConditionText', @sdxExcelFilterGreaterThanConditionText);
  InternalAdd('sdxExcelFilterGreaterThanOrEqualToConditionText', @sdxExcelFilterGreaterThanOrEqualToConditionText);
  InternalAdd('sdxExcelFilterLessThanConditionText', @sdxExcelFilterLessThanConditionText);
  InternalAdd('sdxExcelFilterLessEqualThanOrEqualToConditionText', @sdxExcelFilterLessEqualThanOrEqualToConditionText);
  InternalAdd('sdxExcelFilterTopNConditionText', @sdxExcelFilterTopNConditionText);
  InternalAdd('sdxExcelFilterBottomNConditionText', @sdxExcelFilterBottomNConditionText);
  InternalAdd('sdxExcelFilterAboveAverageConditionText', @sdxExcelFilterAboveAverageConditionText);
  InternalAdd('sdxExcelFilterBelowAverageConditionText', @sdxExcelFilterBelowAverageConditionText);
  InternalAdd('sdxExcelFilterBeforeConditionText', @sdxExcelFilterBeforeConditionText);
  InternalAdd('sdxExcelFilterAfterConditionText', @sdxExcelFilterAfterConditionText);
  InternalAdd('sdxExcelFilterYesterdayConditionText', @sdxExcelFilterYesterdayConditionText);
  InternalAdd('sdxExcelFilterTodayConditionTypeText', @sdxExcelFilterTodayConditionTypeText);
  InternalAdd('sdxExcelFilterTomorrowConditionText', @sdxExcelFilterTomorrowConditionText);
  InternalAdd('sdxExcelFilterLastWeekConditionText', @sdxExcelFilterLastWeekConditionText);
  InternalAdd('sdxExcelFilterThisWeekConditionText', @sdxExcelFilterThisWeekConditionText);
  InternalAdd('sdxExcelFilterNextWeekConditionText', @sdxExcelFilterNextWeekConditionText);
  InternalAdd('sdxExcelFilterLastMonthConditionText', @sdxExcelFilterLastMonthConditionText);
  InternalAdd('sdxExcelFilterThisMonthConditionText', @sdxExcelFilterThisMonthConditionText);
  InternalAdd('sdxExcelFilterNextMonthConditionText', @sdxExcelFilterNextMonthConditionText);
  InternalAdd('sdxExcelFilterLastYearConditionText', @sdxExcelFilterLastYearConditionText);
  InternalAdd('sdxExcelFilterThisYearConditionText', @sdxExcelFilterThisYearConditionText);
  InternalAdd('sdxExcelFilterNextYearConditionText', @sdxExcelFilterNextYearConditionText);
  InternalAdd('sdxExcelFilterCustomFilterConditionText', @sdxExcelFilterCustomFilterConditionText);
  InternalAdd('sdxExcelFilterPredefinedFiltersConditionText', @sdxExcelFilterPredefinedFiltersConditionText);
  InternalAdd('sdxExcelFilterTopNBottomNItemsText', @sdxExcelFilterTopNBottomNItemsText);
  InternalAdd('sdxExcelFilterTopNBottomNPercentText', @sdxExcelFilterTopNBottomNPercentText);

  InternalAdd('sdxEditPopupWindowUIAName', @sdxEditPopupWindowUIAName);
  InternalAdd('sdxDateEditPopupWindowUIAName', @sdxDateEditPopupWindowUIAName);
  InternalAdd('sdxFilterPopupWindowClearButtonCaption', @sdxFilterPopupWindowClearButtonCaption);
  InternalAdd('sdxFilterPopupWindowCloseButtonCaption', @sdxFilterPopupWindowCloseButtonCaption);
  InternalAdd('sdxFilterPopupWindowCancelButtonCaption', @sdxFilterPopupWindowCancelButtonCaption);
  InternalAdd('sdxFilterPopupWindowOKButtonCaption', @sdxFilterPopupWindowOKButtonCaption);

  InternalAdd('sdxFileDialogFileNotExistWarning', @sdxFileDialogFileNotExistWarning);
  InternalAdd('sdxFileDialogBackDisabledHint', @sdxFileDialogBackDisabledHint);
  InternalAdd('sdxFileDialogBackEnabledHint', @sdxFileDialogBackEnabledHint);
  InternalAdd('sdxFileDialogFileNameCaption', @sdxFileDialogFileNameCaption);
  InternalAdd('sdxFileDialogFilePreviewHidePaneHint', @sdxFileDialogFilePreviewHidePaneHint);
  InternalAdd('sdxFileDialogFilePreviewShowPaneHint', @sdxFileDialogFilePreviewShowPaneHint);
  InternalAdd('sdxFileDialogForwardDisabledHint', @sdxFileDialogForwardDisabledHint);
  InternalAdd('sdxFileDialogForwardEnabledHint', @sdxFileDialogForwardEnabledHint);
  InternalAdd('sdxFileDialogHistoryHint', @sdxFileDialogHistoryHint);
  InternalAdd('sdxFileDialogNewFolderCaption', @sdxFileDialogNewFolderCaption);
  InternalAdd('sdxFileDialogNewFolderHint', @sdxFileDialogNewFolderHint);
  InternalAdd('sdxFileDialogSearchNullstring', @sdxFileDialogSearchNullstring);
  InternalAdd('sdxFileDialogUpHint', @sdxFileDialogUpHint);
  InternalAdd('sdxFileDialogViewsHint', @sdxFileDialogViewsHint);
  InternalAdd('sdxShellViewsCaption', @sdxShellViewsCaption);
  InternalAdd('sdxShellExtraLargeIconsCaption', @sdxShellExtraLargeIconsCaption);
  InternalAdd('sdxShellLargeIconsCaption', @sdxShellLargeIconsCaption);
  InternalAdd('sdxShellMediumIconsCaption', @sdxShellMediumIconsCaption);
  InternalAdd('sdxShellSmallIconsCaption', @sdxShellSmallIconsCaption);
  InternalAdd('sdxShellIconsCaption', @sdxShellIconsCaption);
  InternalAdd('sdxShellListCaption', @sdxShellListCaption);
  InternalAdd('sdxShellDetailsCaption', @sdxShellDetailsCaption);
  InternalAdd('sdxOpenFileDialogOkCaption', @sdxOpenFileDialogOkCaption);
  InternalAdd('sdxOpenFileDialogDefaultTitle', @sdxOpenFileDialogDefaultTitle);
  InternalAdd('sdxSaveFileDialogOkCaption', @sdxSaveFileDialogOkCaption);
  InternalAdd('sdxSaveFileDialogDefaultTitle', @sdxSaveFileDialogDefaultTitle);
  InternalAdd('sdxShellListViewMenuItemPaste', @sdxShellListViewMenuItemPaste);
  InternalAdd('sdxShellListViewMenuItemRefresh', @sdxShellListViewMenuItemRefresh);
  InternalAdd('sdxShellListViewMenuItemSort', @sdxShellListViewMenuItemSort);
  InternalAdd('sdxShellListViewMenuItemSortAscending', @sdxShellListViewMenuItemSortAscending);
  InternalAdd('sdxShellListViewMenuItemSortDescending', @sdxShellListViewMenuItemSortDescending);
  InternalAdd('sdxShellListViewWorkingOnIt', @sdxShellListViewWorkingOnIt);
  InternalAdd('sdxShellListViewNoItemsMatch', @sdxShellListViewNoItemsMatch);
  InternalAdd('sdxDetails', @sdxDetails);
  InternalAdd('sdxColumnWidthCaption', @sdxColumnWidthCaption);
  InternalAdd('sdxSelectDetailsCaption', @sdxSelectDetailsCaption);
  InternalAdd('sdxChooseDetails', @sdxChooseDetails);
  InternalAdd('sdxMoveUp', @sdxMoveUp);
  InternalAdd('sdxMoveDown', @sdxMoveDown);
  InternalAdd('sdxHide', @sdxHide);
  InternalAdd('sdxShow', @sdxShow);
  InternalAdd('sdxFilePreviewPanePreviewMessageEmpty', @sdxFilePreviewPanePreviewMessageEmpty);
  InternalAdd('sdxFilePreviewPanePreviewMessageNoFile', @sdxFilePreviewPanePreviewMessageNoFile);

  // LayoutControl
  InternalAdd('sdxLayoutControlGroupCaptionCheckBoxUIAName', @sdxLayoutControlGroupCaptionCheckBoxUIAName);

  // Message Dialogs
  InternalAdd('SMsgDlgAbort', @SMsgDlgAbort);
  InternalAdd('SMsgDlgAll', @SMsgDlgAll);
  InternalAdd('SMsgDlgCancel', @SMsgDlgCancel);
  InternalAdd('SMsgDlgClose', @SMsgDlgClose);
  InternalAdd('SMsgDlgConfirm', @SMsgDlgConfirm);
  InternalAdd('SMsgDlgError', @SMsgDlgError);
  InternalAdd('SMsgDlgHelp', @SMsgDlgHelp);
  InternalAdd('SMsgDlgIgnore', @SMsgDlgIgnore);
  InternalAdd('SMsgDlgInformation', @SMsgDlgInformation);
  InternalAdd('SMsgDlgNo', @SMsgDlgNo);
  InternalAdd('SMsgDlgNoToAll', @SMsgDlgNoToAll);
  InternalAdd('SMsgDlgOK', @SMsgDlgOK);
  InternalAdd('SMsgDlgRetry', @SMsgDlgRetry);
  InternalAdd('SMsgDlgWarning', @SMsgDlgWarning);
  InternalAdd('SMsgDlgYes', @SMsgDlgYes);
  InternalAdd('SMsgDlgYesToAll', @SMsgDlgYesToAll);
end;


initialization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.RegisterProduct('ExpressEditors Library', @AddEditorsResourceStringNames);
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
finalization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.UnRegisterProduct('ExpressEditors Library');
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
end.
