{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           ExpressPrinting System                                   }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTING SYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                      }
{   EXECUTABLE PROGRAM ONLY.                                         }
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

unit dxPSRes;

interface

{$I cxVer.inc}

resourcestring
  sdxBtnOK = 'Aceptar';
  sdxBtnOKAccelerated = '&Aceptar';
  sdxBtnCancel = 'Cancelar';
  sdxBtnClose = 'Cerrar';
  sdxBtnApply = '&Aplicar';
  sdxBtnHelp = 'A&yuda';
  sdxBtnFix = '&Fijar';
  sdxBtnNew = '&Nuevo...';
  sdxBtnIgnore = '&Ignorar';
  sdxBtnYes = '&Sí';
  sdxBtnNo = '&No';
  sdxBtnEdit = '&Editar...';
  sdxBtnReset = '&Reiniciar';
  sdxBtnAdd = '&Añadir';
  sdxBtnAddComposition = 'Añadir &composicion';
  sdxBtnDefault = '&Defecto...';
  sdxBtnDelete = '&Borrar...';
  sdxBtnDescription = '&Descripción...';
  sdxBtnCopy = '&Copia...';
  sdxBtnYesToAll = 'Sí a &todo';
  sdxBtnFootnoteProperties = 'Notas al pie...';
  sdxBtnRestoreDefaults = '&Restaurar';
  sdxBtnRestoreOriginal = 'Restaurar &original';
  sdxBtnTitleProperties = 'Título...';
  sdxBtnProperties = 'P&ropiedades...';
  sdxBtnNetwork = '&Red...';
  sdxBtnBrowse = '&Navegar...';
  sdxBtnPageSetup = 'Con&f. página...';
  sdxBtnPrintPreview = '&Vista previa...';
  sdxBtnPreview = '&Vista previa...';
  sdxBtnPrint = 'Imprimir...';
  sdxBtnOptions = '&Opciones...';
  sdxBtnStyleOptions = 'Opciones de estilo...';
  sdxBtnDefinePrintStyles = '&Definir estilos...';
  sdxBtnPrintStyles = 'Imprimir estilos';
  sdxBtnBackground = 'Fondo';
  sdxBtnShowToolBar = 'Mostrar barra de &herramientas';
  sdxBtnDesign = '&Diseño...';
  sdxBtnMoveUp = '&Subir';
  sdxBtnMoveDown = 'Ba&jar';

  sdxBtnMoreColors = '&Mas colores...';
  sdxBtnFillEffects = '&Efectos de relleno...';
  sdxBtnNoFill = '&Sin relleno';
  sdxBtnAutomatic = '&Automatico';
  sdxBtnNone = '&Ninguno';

  sdxBtnOtherTexture = 'Otra te&xtura...';
  sdxBtnInvertColors = 'I&nvertir colores';
  sdxBtnSelectPicture = 'Se&leccionar imágen...';

  sdxEditReports = 'Editar informes';
  sdxComposition = 'Composición';
  sdxReportFootnotesDlgCaption = 'Notas al pie';
  sdxReportTitleDlgCaption = 'Titulo';
  sdxMode = '&Modo:';
  sdxText = '&Texto';
  sdxProperties = '&Propiedades';
  sdxAdjustOnScale = '&Ajustar a escala';

  // Report Title mode
  sdxTitleModeNone = 'Ninguno';
  sdxTitleModeOnEveryTopPage = 'En cada portada';
  sdxTitleModeOnFirstPage = 'En la primera página';

  // Report Footnotes mode
  sdxFootnotesModeNone = 'Ninguno';
  sdxFootnotesModeOnEveryBottomPage = 'En cada contraportada';
  sdxFootnotesModeOnLastPage = 'En la última página';

  sdxEditDescription = 'Editar descripción';
  sdxRename = 'Reno&mbrar';
  sdxSelectAll = '&Seleccionar todo';
  
  sdxAddReport = 'Añadir informe';
  sdxAddAndDesignReport = 'Añadir y d&iseñar informe...';
  sdxNewCompositionCaption = 'Nueva composición';
  sdxName = '&Nombre:';
  sdxCaption = '&Encabezado:';
  sdxAvailableSources = '&Fuente(s) disponible(s)';
  sdxOnlyComponentsInActiveForm = 'Solo componentes en el &formulario activo';
  sdxOnlyComponentsWithoutLinks = 'Solo componentes sin &ReportLinks existentes';
  sdxItemName = 'Nombre';
  sdxItemDescription = 'Descripción';
    
  sdxConfirmDeleteItem = '¿Desea eliminar los siguientes elementos: %s ?';
  sdxAddItemsToComposition = 'Añadir elementos al composición';
  sdxHideAlreadyIncludedItems = 'Ocultar elementos ya &incluidos';
  sdxAvailableItems = 'Elementos &disponibles';
  sdxItems = '&Elementos';
  sdxEnable = '&Activar';
  sdxOptions = 'Opciones';
  sdxGroupImages = 'Images';
  sdxGroupView = 'View';
  sdxShow = 'Mostrar';
  sdxPaintItemsGraphics = '&Pintar elementos gráficos';
  sdxDescription = '&Descripción:';

  sdxNewReport = 'NuevoInforme';
    
  sdxOnlySelected = 'Solo &seleccionado';
  sdxExtendedSelect = '&Selección extendida';
  sdxIncludeFixed = '&Incluir fijados';

  sdxFonts = 'Fuentes';
  sdxBtnFont = '&Fuente...';
  sdxBtnEvenFont = 'Fuente &par...';
  sdxBtnOddFont = 'Fuente &impar...';
  sdxBtnFixedFont = 'Fuenta fi&ja...';
  sdxBtnGroupFont = '&Grupo de fuente...';
  sdxBtnChangeFont = 'Cambiar Fu&ente...';

  sdxFont = 'Fuente';
  sdxOddFont = 'Fuente impar';
  sdxEvenFont = 'Fuente par';
  sdxPreviewFont = 'Fuente vista previa';
  sdxCaptionNodeFont = 'Fuenta nivel cabecera';
  sdxGroupNodeFont = 'Fuenta grupo nodo';
  sdxGroupFooterFont = 'Fuenta grupo pie';
  sdxHeaderFont = 'Fuenta de cabecera';
  sdxFooterFont = 'Fuente del pie';
  sdxBandFont = 'Fuente de banda';

  sdxTransparent = '&Transparente';
  sdxFixedTransparent = 'Transparente fi&jo';
  sdxCaptionTransparent = 'Título transparente';
  sdxGroupTransparent = 'Grupo transparente';

  sdxGraphicAsTextValue = '(GRAPHICO)';
  sdxColors = 'Colores';
  sdxColor = 'Co&lor:';
  sdxOddColor = 'Co&lor impar:';
  sdxEvenColor = 'Color pa&r:';
  sdxPreviewColor = 'Color de pre&visualización:';
  sdxBandColor = 'Color de la &banda:';
  sdxLevelCaptionColor = 'Color del titulo de &nivel:';
  sdxHeaderColor = 'Color de la cab&ecera:';
  sdxGroupNodeColor = 'Color del &nodo de grupo:';
  sdxGroupFooterColor = 'Color del &pie de grupo:';
  sdxFooterColor = 'Color del pi&e:';
  sdxFixedColor = 'Color fi&jo:';
  sdxGroupColor = 'Color del &grupo:';
  sdxCaptionColor = 'Color del &titulo:';
  sdxGridLinesColor = 'Color de las &lineas:';

  sdxBands = '&Bandas';
  sdxLevelCaptions = 'Titulo de &niveles';
  sdxHeaders = '&Cabeceras';
  sdxFooters = '&Pies';
  sdxGroupFooters = 'Pies de &grupo';
  sdxPreview = 'Vista pre&via';
  sdxPreviewLineCount = 'Contador de &lineas:';
  sdxAutoCalcPreviewLineCount = 'Calculo auto&mático de líneas';

  sdxGrid = 'Lineas de la rejilla';
  sdxNodesGrid = 'Lineas del nodo';
  sdxGroupFooterGrid = 'Lineas del pie de grupo';

  sdxStateImages = 'Imágenes de es&tado';
  sdxImages = '&Imágenes';

  sdxTextAlign = 'Alienación de te&xto';
  sdxTextAlignHorz = '&Horizontal';
  sdxTextAlignVert = '&Vertical';
  sdxTextAlignLeft = 'Izquierda';
  sdxTextAlignCenter = 'Centro';
  sdxTextAlignRight = 'Derecha';
  sdxTextAlignTop = 'Superior';
  sdxTextAlignVCenter = 'Centro';
  sdxTextAlignBottom = 'Inferior';
  sdxBorderLines = '&Borde';
  sdxHorzLines = 'Líneas hori&zontales';
  sdxVertLines = 'Líneas &verticales';
  sdxFixedHorzLines = 'Linea horizo&ntales fijas';
  sdxFixedVertLines = 'Lineas ver&ticales fijas';
  sdxFlatCheckMarks = 'Casillas &planas';
  sdxCheckMarksAsText = 'Mostrar casillas como &texto';

  sdxRowAutoHeight = '&Altura de fila autom.';
  sdxEndEllipsis = '&Elipsis final';

  sdxDrawBorder = '&Dibujar borde';
  sdxFullExpand = 'Expansión &completa';
  sdxBorderColor = '&Color del borde:';
  sdxAutoNodesExpand = 'Expansión de &nodos autom.';
  sdxExpandLevel = 'Expandir &nivel:';
  sdxFixedRowOnEveryPage = 'Filas fijas';

  sdxDrawMode = 'Modo de dibu&jo:';
  sdxDrawModeStrict = 'Estricto';
  sdxDrawModeOddEven = 'Modo de filas par/impar';
  sdxDrawModeChess = 'Modo ajedrez';
  sdxDrawModeBorrow = 'Coger de la fuente';

  sdx3DEffects = 'Efectos 3D';
  sdxUse3DEffects = 'Usar efectos &3D';
  sdxSoft3D = '3D &suave';

  sdxBehaviors = 'Comportamientos';
  sdxMiscellaneous = 'Varios';
  sdxOnEveryPage = 'En cada página';
  sdxNodeExpanding = 'Expansión de nodos';
  sdxSelection = 'Selección';
  sdxNodeAutoHeight = 'Altura autom. &nodo';
  sdxTransparentGraphics = '&Gráficos transparentes';
  sdxAutoWidth = 'An&chura automática';

  sdxDisplayGraphicsAsText = 'Mostrar gráficos como &texto';
  sdxTransparentColumnGraphics = '&Gráficos transparentes';
  sdxDisplayTrackBarsAsText = 'Mostrar &barras como texto';

  sdxBandsOnEveryPage = 'Bandas';
  sdxHeadersOnEveryPage = 'Cabeceras';
  sdxFootersOnEveryPage = 'Pies';
  sdxGraphics = '&Gráficos';

  { Common messages }
  
  sdxOutOfResources = 'Sin recursos';
  sdxFileAlreadyExists = 'El fichero "%s" ya existe.';
  sdxConfirmOverWrite = 'El fichero "%s" ya existe. ¿Reemplazar?';
  sdxInvalidFileName = 'Nombre de fichero no válido "%s"';
  sdxRequiredFileName = 'Introduzca el nombre del fichero.';
  sdxOutsideMarginsMessage =
    'Uno o más márgenes estan fijados fuera del área imprimible de la página.' + #13#10 +
    '¿Desea continuar?';
  sdxOutsideMarginsMessage2 =
    'Uno o más márgenes estan fijados fuera del área imprimible de la página.' + #13#10 +
    'Pulse sobre el botón [Fijar] para fijar los margenes apropiados.';
  sdxInvalidMarginsMessage =
    'Uno o más márgenes tienen valores incorrectos.' + #13#10 +
    'Pulse [Fijar] para corregir el problema.' + #13#10 +
    'Pulse [Restaurar] para restaurar los valores originales.';
  sdxInvalidMargins = 'Uno o más márgenes tienen valores no incorrectos';
  sdxOutsideMargins = 'Uno o más márgenes han sido fijados fuera del área imprimible de al página';
  sdxReportCellClassNotRegistered = '%s clase no registrada. ' +
    'Asegúrese de que el enlace al informe correspondiente ha sido añadido a la aplicación';
  sdxThereAreNowItemsForShow = 'No hay elementos en esta vista';

  { Color palette }
  
  sdxPageBackground = ' Fondo de la página';
  sdxPenColor = 'Color del pincel';
  sdxFontColor = 'Color de la fuente';
  sdxBrushColor = 'Color del lienzo';
  sdxHighLight = 'Resaltado';

  { Color names }
  
  sdxColorBlack = 'Negro';
  sdxColorDarkRed = 'Granate';
  sdxColorRed = 'Rojo';
  sdxColorPink = 'Rosa';
  sdxColorRose = 'Rosa claro';
  sdxColorBrown = 'Marrón';
  sdxColorOrange = 'Naranja';
  sdxColorLightOrange = 'Naranja claro';
  sdxColorGold = 'Dorado';
  sdxColorTan = 'Marrón claro';
  sdxColorOliveGreen = 'Verde oliva';
  sdxColorDrakYellow = 'Amarillo oscuro';
  sdxColorLime = 'Lima';
  sdxColorYellow = 'Amarillo';
  sdxColorLightYellow = 'Amarillo claro';
  sdxColorDarkGreen = 'Verde oscuro';
  sdxColorGreen = 'Verde';
  sdxColorSeaGreen = 'Verde mar';
  sdxColorBrighthGreen = 'Verde brillante';
  sdxColorLightGreen = 'Verde luminoso';
  sdxColorDarkTeal = 'Magenta oscuro';
  sdxColorTeal = 'Magenta';
  sdxColorAqua = 'Agua';
  sdxColorTurquoise = 'Turquesa';
  sdxColorLightTurquoise = 'Turquesa claro';
  sdxColorDarkBlue = 'Azul oscuro';
  sdxColorBlue = 'Azul';
  sdxColorLightBlue = 'Azul claro';
  sdxColorSkyBlue = 'Celeste';
  sdxColorPaleBlue = 'Azul pálido';
  sdxColorIndigo = 'Añil';
  sdxColorBlueGray = 'Gris azulado';
  sdxColorViolet = 'Violeta';
  sdxColorPlum = 'Ciruela';
  sdxColorLavender = 'Lavanda';
  sdxColorGray80 = 'Gris-80%';
  sdxColorGray50 = 'Gris-50%';
  sdxColorGray40 = 'Gris-40%';
  sdxColorGray25 = 'Gris-25%';
  sdxColorWhite = 'Blanco';
 
  { FEF Dialog }
  
  sdxTexture = '&Textura';
  sdxPattern = '&Estampado';
  sdxPicture = '&Imagen';
  sdxForeground = '&Superficie';
  sdxBackground = '&Fondo';
  sdxSample = 'Ejemplo:';

  sdxFEFCaption = 'Efectos de relleno';
  sdxPaintMode = 'Modo de &pintado';
  sdxPaintModeCenter = 'Centro';
  sdxPaintModeStretch = 'Estrechar';
  sdxPaintModeTile = 'Embaldosar';
  sdxPaintModeProportional = 'Proporcional';

  { Pattern names }
  
  sdxPatternGray5 = '5%';
  sdxPatternGray10 = '10%';
  sdxPatternGray20 = '20%';
  sdxPatternGray25 = '25%';
  sdxPatternGray30 = '30%';
  sdxPatternGray40 = '40%';
  sdxPatternGray50 = '50%';
  sdxPatternGray60 = '60%';
  sdxPatternGray70 = '70%';
  sdxPatternGray75 = '75%';
  sdxPatternGray80 = '80%';
  sdxPatternGray90 = '90%';
  sdxPatternLightDownwardDiagonal = 'Diagonal hacia abajo ligera';
  sdxPatternLightUpwardDiagonal = 'Diagonal hacia arriba ligera';
  sdxPatternDarkDownwardDiagonal = 'Diagonal hacia abajo';
  sdxPatternDarkUpwardDiagonal = 'Diagonal hacia arriba';
  sdxPatternWideDownwardDiagonal = 'Diagonal hacia abajo gruesa';
  sdxPatternWideUpwardDiagonal = 'Diagonal hacia arriba gruesa';
  sdxPatternLightVertical = 'Vertical ligera';
  sdxPatternLightHorizontal = 'Horizontal ligera';
  sdxPatternNarrowVertical = 'Vertical';
  sdxPatternNarrowHorizontal = 'Horizontal';
  sdxPatternDarkVertical = 'Vertical gruesa';
  sdxPatternDarkHorizontal = 'Horizontal gruesa';
  sdxPatternDashedDownward = 'Discontinua hacia abajo';
  sdxPatternDashedUpward = 'Discontinua hacia arriba';
  sdxPatternDashedVertical = 'Discontinua vertical';
  sdxPatternDashedHorizontal = 'Discontinua horizontal';
  sdxPatternSmallConfetti = 'Confeti pequeño';
  sdxPatternLargeConfetti = 'Confeti grande';
  sdxPatternZigZag = 'Zig zag';
  sdxPatternWave = 'Onda';
  sdxPatternDiagonalBrick = 'Ladrillo diagonal';
  sdxPatternHorizantalBrick = 'Ladrillo horizontal';
  sdxPatternWeave = 'Onda';
  sdxPatternPlaid = 'Escocés';
  sdxPatternDivot = 'Paramecio';
  sdxPatternDottedGrid = 'Punteado';
  sdxPatternDottedDiamond = 'Diamantes';
  sdxPatternShingle = 'Guijarros';
  sdxPatternTrellis = 'Enrejado';
  sdxPatternSphere = 'Esfera';
  sdxPatternSmallGrid = 'Rejilla pequeña';
  sdxPatternLargeGrid = 'Rejilla grande';
  sdxPatternSmallCheckedBoard = 'Puntilla pequeña';
  sdxPatternLargeCheckedBoard = 'Puntilla grande';
  sdxPatternOutlinedDiamond = 'Diamantes esbozados';
  sdxPatternSolidDiamond = 'Diamantes sólidos';

  { Texture names }
  
  sdxTextureNewSprint = 'Papel prensa';
  sdxTextureGreenMarble = 'Mármol verde';
  sdxTextureBlueTissuePaper = 'Papel de seda azul';
  sdxTexturePapyrus = 'Papiro';
  sdxTextureWaterDroplets = 'Gotas de agua';
  sdxTextureCork = 'Corcho';
  sdxTextureRecycledPaper = 'Papel reciclado';
  sdxTextureWhiteMarble = 'Mármol blanco';
  sdxTexturePinkMarble = 'Mármol rosa';
  sdxTextureCanvas = 'Lienzo';
  sdxTexturePaperBag = 'Bolsa de papel';
  sdxTextureWalnut = 'Nuez';
  sdxTextureParchment = 'Pergamino';
  sdxTextureBrownMarble = 'Mármol marrón';
  sdxTexturePurpleMesh = 'Malla púrpura';
  sdxTextureDenim = 'Tela vaquera';
  sdxTextureFishFossil = 'Pez fósil';
  sdxTextureOak = 'Roble';
  sdxTextureStationary = 'Estacionario';
  sdxTextureGranite = 'Granito';
  sdxTextureBouquet = 'Ramo';
  sdxTextureWonenMat = 'Estera';
  sdxTextureSand = 'Arena';
  sdxTextureMediumWood = 'Madera media';

  sdxFSPCaption = 'Vista previa';
  sdxWidth = 'Anchura';
  sdxHeight = 'Altura';

  { Brush Dialog }
  
  sdxBrushDlgCaption = 'Propiedades del pincel';
  sdxStyle = '&Estilo:';

  { Enter New File Name dialog }
  
  sdxENFNCaption = 'Elija nuevo nombre de fichero';
  sdxEnterNewFileName = 'Indique nuevo nombre de fichero';

  { Define styles dialog }
  
  sdxDefinePrintStylesCaption = 'Definir estilos de impresión';
  sdxDefinePrintStylesTitle = 'Estilos de i&mpresión:';
  sdxDefinePrintStylesWarningDelete = '¿Desea eliminar "%s"?';
  sdxDefinePrintStylesWarningClear = '¿Desea eliminar todos los estilos no incorporados?';
  sdxClear = '&Limpiar...';

  { Print device }
  
  sdxCustomSize = 'Tamaño personalizado';
  sdxDefaultTray = 'Bandeja por defecto';
  sdxInvalidPrintDevice = 'La impresora seleccionada no es válida';
  sdxNotPrinting = 'La impresora no está en uso';
  sdxPrinting = 'Impresión en curso';
  sdxDeviceOnPort = '%s de %s';
  sdxPrinterIndexError = 'Índice de impresora fuera de rango';
  sdxNoDefaultPrintDevice = 'No hay una impresora por defecto seleccionada';

  { Edit AutoText Entries Dialog }
  
  sdxAutoTextDialogCaption = 'Editar entradas de auto texto';
  sdxEnterAutoTextEntriesHere = ' Introduzca entradas de auto te&xto: ';

  { Print dialog }
  
  sdxPrintDialogCaption = 'Imprimir';
  sdxPrintDialogPrinter = ' Impresora ';
  sdxPrintDialogName = '&Nombre:';
  sdxPrintDialogStatus = 'Estado:';
  sdxPrintDialogType = 'Tipo:';
  sdxPrintDialogWhere = 'Donde:';
  sdxPrintDialogComment = 'Comentario:';
  sdxPrintDialogPrintToFile = 'Imprimir en &fichero';
  sdxPrintDialogPageRange = ' Rango de páginas ';
  sdxPrintDialogAll = '&Todo';
  sdxPrintDialogCurrentPage = 'Página ac&tual';
  sdxPrintDialogSelection = '&Selección';
  sdxPrintDialogPages = '&Páginas:';
  sdxPrintDialogRangeLegend = 'Introduzca el número de página y/o el rango separado por comas. Por ejemplo : 1,3,5-12.';
  sdxPrintDialogCopies = ' Copias ';
  sdxPrintDialogNumberOfPages = 'N&úmero de páginas:';
  sdxPrintDialogNumberOfCopies = 'Número de &copias:';
  sdxPrintDialogCollateCopies = 'Copias correla&tivas';
  sdxPrintDialogAllPages = 'Todas';
  sdxPrintDialogEvenPages = 'Pares';
  sdxPrintDialogOddPages = 'Impares';
  sdxPrintDialogPrintStyles = ' Esti&los de impresión ';

  { PrintToFile Dialog }
  
  sdxPrintDialogOpenDlgTitle = 'Elija nombre fichero';
  sdxPrintDialogOpenDlgAllFiles = 'Todos los ficheros';
  sdxPrintDialogOpenDlgPrinterFiles = 'Ficheros de impresora';
  sdxPrintDialogPageNumbersOutOfRange = 'Nros. de página fuera de rango (%d - %d)';
  sdxPrintDialogInvalidPageRanges = 'Rango de páginas no válido';
  sdxPrintDialogRequiredPageNumbers = 'Indique los números de página';
  sdxPrintDialogNoPrinters = 
    'No hay impresoras instaladas. Para instalar una impresora, ' +
    'seleccione "Dispositivos e Impresoras"en el menú Inicio de Windows, y luego pulse sobre "Añadir impresora". ' +
    'Siga las intrucciones del asistente.';
  sdxPrintDialogInPrintingState = 'La impresora está ocupada.' + #13#10 +
    'Por favor, espere.';

  { Printer State }
  
  sdxPrintDialogPSPaused = 'En pausa';
  sdxPrintDialogPSPendingDeletion = 'Borrado pendiente';
  sdxPrintDialogPSBusy = 'Ocupado';
  sdxPrintDialogPSDoorOpen = 'Puerta abierta';
  sdxPrintDialogPSError = 'Error';
  sdxPrintDialogPSInitializing = 'Inicializando';
  sdxPrintDialogPSIOActive = 'ES Activo';
  sdxPrintDialogPSManualFeed = 'Alimentación manual';
  sdxPrintDialogPSNoToner = 'Sin toner';
  sdxPrintDialogPSNotAvailable = 'No disponible';
  sdxPrintDialogPSOFFLine = 'Fuera de línea';
  sdxPrintDialogPSOutOfMemory = 'Sin memoria';
  sdxPrintDialogPSOutBinFull = 'Salida llena';
  sdxPrintDialogPSPagePunt = 'Página suelta';
  sdxPrintDialogPSPaperJam = 'Página atascada';
  sdxPrintDialogPSPaperOut = 'Sin papel';
  sdxPrintDialogPSPaperProblem = 'Problema con el papel';
  sdxPrintDialogPSPrinting = 'Imprimiendo';
  sdxPrintDialogPSProcessing = 'Procesando';
  sdxPrintDialogPSTonerLow = 'Tóner bajo';
  sdxPrintDialogPSUserIntervention = 'Intervención del usuario';
  sdxPrintDialogPSWaiting = 'Esperando';
  sdxPrintDialogPSWarningUp = 'Calentando';
  sdxPrintDialogPSReady = 'Lista';
  sdxPrintDialogPSPrintingAndWaiting = 'Imprimiendo: %d documento(s) esperando';

  sdxLeftMargin = 'Margen izquierdo';
  sdxTopMargin = 'Margen superior';
  sdxRightMargin = 'Margen derecho';
  sdxBottomMargin = 'Margen inferior';
  sdxGutterMargin = 'Sangría';
  sdxHeaderMargin = 'Cabecera';
  sdxFooterMargin = 'Pie';

  sdxUnitsInches = 'in';
  sdxUnitsCentimeters = 'cm';
  sdxUnitsMillimeters = 'mm';
  sdxUnitsPoints = 'pt';
  sdxUnitsPicas = 'pi';

  sdxUnitsDefaultName = 'Defecto';
  sdxUnitsInchesName = 'Pulgadas';
  sdxUnitsCentimetersName = 'Centimetros';
  sdxUnitsMillimetersName = 'Milimetros';
  sdxUnitsPointsName = 'Puntos';
  sdxUnitsPicasName = 'Picas';

  sdxPrintPreview = 'Vista previa';
  sdxReportDesignerCaption = 'Formato del informe';
  sdxCompositionDesignerCaption = 'Editor de composición';
  sdxCompositionStartEachItemFromNewPage = '&Iniciar cada elemento desde nueva página';

  sdxComponentNotSupportedByLink = 'Componente "%s" no soportado por TdxComponentPrinter';
  sdxComponentNotSupported = 'Componente "%s" no soportado TdxComponentPrinter';
  sdxPrintDeviceNotReady = 'La impresora no ha sido instalada o no está lista';
  sdxUnableToGenerateReport = 'Incapaz de generar el informe';
  sdxPreviewNotRegistered = 'No hay ventana de vista previa registrada';
  sdxComponentNotAssigned = '%s' + #13#10 + 'Propiedad "Component" no asiganda';
  sdxPrintDeviceIsBusy = 'La impresora está ocupada';
  sdxPrintDeviceError = '!La impresora ha encontrado un error!';
  sdxMissingComponent = 'Propiedad "Component" ausente';
  sdxDataProviderDontPresent = 'No hay enlaces con componente asignado en la composición';
  sdxBuildingReport = 'Creando el informe: %d%% completado';                        // obsolete
  sdxPrintingReport = 'Imprimiendo el informe: %d página(s) completadas. Pulse <Esc> para cancelar'; // obsolete
  sdxDefinePrintStylesMenuItem = 'Definir e&stilos de impresión...';
  sdxAbortPrinting = '¿Abortar la imprsión?';
  sdxStandardStyle = 'Estilo estandar';

  sdxFontStyleBold = 'Negrita';
  sdxFontStyleItalic = 'Italica';
  sdxFontStyleUnderline = 'Subrayado';
  sdxFontStyleStrikeOut = 'Tachado';
  sdxPt = 'pt.';

  sdxPageWidth = 'Anchura de página';
  sdxWholePage = 'Página completa';
  sdxTwoPages = 'Dos páginas';
  sdxFourPages = 'Cuatro páginas';
  sdxWidenToSourceWidth = 'Ampliar a la anchura del original';

  sdxMenuBar = 'Barra de menu';
  sdxStandardBar = 'Estandar';
  sdxHeaderFooterBar = 'Cabecera y pie';
  sdxShortcutMenusBar = 'Menus de atajos';
  sdxAutoTextBar = 'AutoTexto';

  sdxMenuFile = '&Fichero';
  sdxMenuFileDesign = '&Diseño...';
  sdxMenuFilePrint = '&imprimir...';
  sdxMenuFilePrintDialog = 'Ventana de impresión';
  sdxMenuFilePageSetup = 'Config. &página...';
  sdxMenuPrintStyles = 'Estilos de impresión';
  sdxMenuFileExit = '&Cerrar';
  sdxMenuExportToPDF = 'Exportar a PDF';
  sdxMenuFileOptions = 'Opciones';

  sdxMenuEdit = '&Editar';
  sdxMenuEditCut = 'Cor&tar';
  sdxMenuEditCopy = '&Copiar';
  sdxMenuEditPaste = '&Pegar';
  sdxMenuEditDelete = '&Borrar';
  sdxMenuEditFind = '&Buscar...';
  sdxMenuEditFindNext = 'Buscar &siguiente';
  sdxMenuEditReplace = '&Reemplazar...';

  sdxMenuLoad = '&Cargacr...';
  sdxMenuPreview = '&Vista previa...';

  sdxMenuInsert = '&Insertar';
  sdxMenuInsertAutoText = '&AutoTexto';
  sdxMenuInsertEditAutoTextEntries = 'AutoTe&xto....';
  sdxMenuInsertAutoTextEntries = 'Lista de entradas de AutoTexto';
  sdxMenuInsertAutoTextEntriesSubItem = 'In&sertar AutoTexto';
  sdxMenuInsertPageNumber = '&Nro. página';
  sdxMenuInsertTotalPages = '&Nro. de páginas';
  sdxMenuInsertPageOfPages = 'Pá&gina de nro. de páginas';
  sdxMenuInsertDateTime = 'Fecha y hora';
  sdxMenuInsertDate = '&Fecha';
  sdxMenuInsertTime = '&Hora';
  sdxMenuInsertUserName = '&Nombre del usuario';
  sdxMenuInsertMachineName = 'Nombre del e&quipo';

  sdxMenuView = '&Vista';
  sdxMenuViewMargins = '&Márgenes';
  sdxMenuViewFlatToolBarButtons = 'Botones &planos';
  sdxMenuViewLargeToolBarButtons = 'Botones &grandes';
  sdxMenuViewMarginsStatusBar = 'Márneges de la &barra';
  sdxMenuViewPagesStatusBar = 'Barra de e&stado';
  sdxMenuViewToolBars = '&Barra de botones';
  sdxMenuViewPagesHeaders = '&Cabeceras de página';
  sdxMenuViewPagesFooters = 'Pi&es de página';
  sdxMenuViewSwitchToLeftPart = 'Cambiar a la parte izquierda';
  sdxMenuViewSwitchToRightPart = 'Cambiar a la parte derecha';
  sdxMenuViewSwitchToCenterPart = 'Cambiar a la parte central';
  sdxMenuViewHFSwitchHeaderFooter = '&Mostrar cabecera/pie';
  sdxMenuViewSwitchToFooter = 'Pie';
  sdxMenuViewSwitchToHeader = 'Cabecera';
  sdxMenuViewHFClose = 'Ce&rrar';

  sdxMenuZoom = '&Zoom';
  sdxMenuZoomPercent100 = '&100%';
  sdxMenuZoomPageWidth = 'A&nchura de página';
  sdxMenuZoomWholePage = 'Página &completa';
  sdxMenuZoomTwoPages = '&Dos páginas';
  sdxMenuZoomFourPages = '&Cuatro páginas';
  sdxMenuZoomMultiplyPages = '&Varias páginas';
  sdxMenuZoomWidenToSourceWidth = 'Ajustar a la anchura de &origen';
  sdxMenuZoomSetup = '&Configurar...';

  sdxMenuPages = '&Páginas';

  sdxMenuGotoPage = '&Ir';
  sdxMenuGotoPageFirst = '&Primera página';
  sdxMenuGotoPagePrev = '&Página anterior';
  sdxMenuGotoPageNext = '&Próxima página';
  sdxMenuGotoPageLast = '&Última página';
  sdxMenuActivePage = '&Página activa:';

  sdxMenuFormat = 'F&ormato';
  sdxMenuFormatHeaderAndFooter = '&Cabecera y pie';
  sdxMenuFormatAutoTextEntries = '&Eneradas de auto texto...';
  sdxMenuFormatDateTime = 'Fecha y &hora...';
  sdxMenuFormatPageNumbering = 'Nu&meración de páginas...';
  sdxMenuFormatPageBackground = 'Fon&do...';
  sdxMenuFormatShrinkToPage = '&Ajustar a página';
  sdxMenuShowEmptyPages = 'Mostrar páginas &vacías';
  sdxMenuFormatHFBackground = 'Fondo de pie/cabecera...';
  sdxMenuFormatHFClear = 'Limpiar texto';

  sdxMenuTools = '&Herramientas';
  sdxMenuToolsCustomize = '&Personalizar...';
  sdxMenuToolsOptions = '&Opciones...';

  sdxMenuHelp = '&Ayuda';
  sdxMenuHelpTopics = '&Temas de ayuda...';
  sdxMenuHelpAbout = '&Sobre...';

  sdxMenuShortcutPreview = 'Vista previa';
  sdxMenuShortcutAutoText = 'Auto texto';

  sdxMenuBuiltInMenus = 'Menus incorporados';
  sdxMenuShortCutMenus = 'Atajos de menus';
  sdxMenuNewMenu = 'Nuevo menú';

  { Hints }
  
  sdxHintFileDesign = 'Diseñar informe';
  sdxHintFilePrint = 'Imprimir';
  sdxHintFilePrintDialog = 'Ventana de impresión';
  sdxHintFilePageSetup = 'Configuración de página';
  sdxHintFileExit = 'Cerrar la vista previa';
  sdxHintExportToPDF = 'Exportar a PDF';

  sdxHintEditFind = 'Buscar';
  sdxHintEditFindNext = 'Buscar siguiente';
  sdxHintEditReplace = 'Reemplazar';

  sdxHintInsertEditAutoTextEntries = 'Editar entradas de auto etxto';
  sdxHintInsertPageNumber = 'Insertar "número de página"';
  sdxHintInsertTotalPages = 'Insertar "número de páginas"';
  sdxHintInsertPageOfPages = 'Insertar "número de página de páginas"';
  sdxHintInsertDateTime = 'Insertar fecha y hora';
  sdxHintInsertDate = 'Insertar fecha';
  sdxHintInsertTime = 'Insertar hora';
  sdxHintInsertUserName = 'Insertar nombre de usuario';
  sdxHintInsertMachineName = 'Insertar nombre de máquina';

  sdxHintViewMargins = 'Ver márgenes';
  sdxHintViewLargeButtons = 'Ver botones grandes';
  sdxHintViewMarginsStatusBar = 'Ver barra de estado de márgenes';
  sdxHintViewPagesStatusBar = 'Ver barra de estado de página';
  sdxHintViewPagesHeaders = 'Ver cabecera de página';
  sdxHintViewPagesFooters = 'Ver pie de página';
  sdxHintViewSwitchToLeftPart = 'Cambiar cabecera/pie a la parte izquierda ';
  sdxHintViewSwitchToRightPart = 'Cambiar cabecera/pie a la parte derecha';
  sdxHintViewSwitchToCenterPart = 'Cambiar cabecera/pie a la parte central';
  sdxHintViewHFSwitchHeaderFooter = 'Intercambiar cabecera y pie';
  sdxHintViewSwitchToFooter = 'Cambiar al pie';
  sdxHintViewSwitchToHeader = 'Cambiar a la cabecera';
  sdxHintViewHFClose = 'Cerrar';

  sdxHintViewZoom = 'Zoom';
  sdxHintZoomPercent100 = 'Zoom 100%';
  sdxHintZoomPageWidth = 'Zoom Page Width';
  sdxHintZoomWholePage = 'Whole Page';
  sdxHintZoomTwoPages = 'Two Pages';
  sdxHintZoomFourPages = 'Four Pages';
  sdxHintZoomMultiplyPages = 'Multiple Pages';
  sdxHintZoomWidenToSourceWidth = 'Widen To Source Width';
  sdxHintZoomSetup = 'Setup Zoom Factor';

  sdxHintFormatDateTime = 'Format Date and Time';
  sdxHintFormatPageNumbering = 'Format Page Number';
  sdxHintFormatPageBackground = 'Background';
  sdxHintFormatShrinkToPage = 'Fit To Page';
  sdxHintFormatHFBackground = 'Header/Footer Background';
  sdxHintFormatHFClear = 'Clear Header/Footer Text';

  sdxHintGotoPageFirst = 'Primera página';
  sdxHintGotoPagePrev = 'Página anterior';
  sdxHintGotoPageNext = 'Página siguiente';
  sdxHintGotoPageLast = 'Última página';
  sdxHintActivePage = 'Página activa';

  sdxHintToolsCustomize = 'Customize Toolbars';
  sdxHintToolsOptions = 'Opciones';

  sdxHintHelpTopics = 'Help Topics';
  sdxHintHelpAbout = 'About';

  sdxPopupMenuLargeButtons = '&Large Buttons';
  sdxPopupMenuFlatButtons = '&Flat Buttons';

  sdxPaperSize = 'Tamaño';
  sdxStatus = 'Estado';
  sdxStatusReady = 'Listo';
  sdxStatusPrinting = 'Imprimiendo. Completada(s) %d pagina(s)';
  sdxStatusGenerateReport = 'Generando informe. Completado %d%%';

  sdxHintDoubleClickForChangePaperSize = 'Double Click for Change Paper Size';
  sdxHintDoubleClickForChangeMargins = 'Double Click for Change Margins';

  { Date&Time Formats Dialog }
  
  sdxDTFormatsCaption = 'Fecha y hora';
  sdxDTFormatsAvailableDateFormats = '&Formatos de fecha disponibles';
  sdxDTFormatsAvailableTimeFormats = 'Formatos de &hora disponibles';
  sdxDTFormatsAutoUpdate = 'Ac&tualizar automáticamente';
  sdxDTFormatsChangeDefaultFormat =
    '¿Quiere cambiar los formatos por defecto de fecha y hora por "%s"  - "%s" ?';

  { PageNumber Formats Dialog }
  
  sdxPNFormatsCaption = 'Formato del número de página';
  sdxPageNumbering = 'Numeración de páginas';
  sdxPNFormatsNumberFormat = 'Formato de &número';
  sdxPNFormatsContinueFromPrevious = '&Continuar desde la sección anterior';
  sdxPNFormatsStartAt = 'Iniciar &en';
  sdxPNFormatsChangeDefaultFormat =
    '¿Quiere cambiar el formato por defecto de numeración de páginas por "%s" ?';

  { Zoom Dialog }
  
  sdxZoomDlgCaption = 'Zoom';
  sdxZoomDlgZoomTo = ' Zoom a ';
  sdxZoomDlgPageWidth = '&Anchura de página';
  sdxZoomDlgWholePage = 'Página &entera';
  sdxZoomDlgTwoPages = '&Dos páginas';
  sdxZoomDlgFourPages = '&Cuatro páginas';
  sdxZoomDlgManyPages = '&Varias páginas';
  sdxZoomDlgPercent = '&Porcentaje';
  sdxZoomDlgPreview = ' Vista previa ';
  sdxZoomDlgFontPreview = ' 12pt Times New Roman ';
  sdxZoomDlgFontPreviewString = 'AaBbCcDdEeXxYyZz';

  { Select page X x Y }
  
  sdxPages = 'Páginas';
  sdxCancel = 'Cancelar';

  { Preferences dialog }
  
  sdxPreferenceDlgCaption = 'Opciones';
  sdxPreferenceDlgTab1 = '&General';
  sdxPreferenceDlgTab2 = '';
  sdxPreferenceDlgTab3 = '';
  sdxPreferenceDlgTab4 = '';
  sdxPreferenceDlgTab5 = '';
  sdxPreferenceDlgTab6 = '';
  sdxPreferenceDlgTab7 = '';
  sdxPreferenceDlgTab8 = '';
  sdxPreferenceDlgTab9 = '';
  sdxPreferenceDlgTab10 = '';
  sdxPreferenceDlgShow = ' &Mostrar ';
  sdxPreferenceDlgMargins = '&Márgenes ';
  sdxPreferenceDlgMarginsHints = 'Pistas en los &márgenes';
  sdxPreferenceDlgMargingWhileDragging = 'Pistas en los márgenes cuando se a&rrastran';
  sdxPreferenceDlgLargeBtns = 'Botones &grandes en la barra';
  sdxPreferenceDlgFlatBtns = 'Botones &planos en la barra';
  sdxPreferenceDlgMarginsColor = 'Color de los &márgenes:';
  sdxPreferenceDlgMeasurementUnits = '&Unidades de medida:';
  sdxPreferenceDlgSaveForRunTimeToo = '&Guardar también para ejecución';
  sdxPreferenceDlgZoomScroll = '&Zoom cuando se gira la rueda el IntelliMouse';
  sdxPreferenceDlgZoomStep = '&Paso de zoom:';
  
  { Page Setup }
  
  sdxCloneStyleCaptionPrefix = 'Copia (%d) de ';
  sdxInvalideStyleCaption = 'El nombre de estilo "%s" ya existe. Por favor introduzca uno diferente';
  sdxHintMoreHFFunctions = 'Más funciones';

  sdxPageSetupCaption = 'Configuración de la página';
  sdxStyleName = '&Nombre del estilo:';

  sdxAutomatic = 'Automático';
  sdxFitToPageHorizontally = 'Anchura:';
  sdxFitToPageVertically = 'Altura:';
  sdxHeaderFooter = '&Cabecera/Pie';
  sdxMargins = '&Márgenes';
  sdxPage = '&Página';
  sdxPagesSuffix = ' página(s)';
  sdxScaleTo = 'Escala:';
  sdxScaling = '&Ajuste';

  sdxPaper = ' Papel ';
  sdxPaperType = 'T&ipo';
  sdxPaperDimension = 'Dimensión';
  sdxPaperWidth = '&Anchura';
  sdxPaperHeight = 'A&ltura';
  sdxPaperSource = '&Fuente';

  sdxOrientation = ' Orientación ';
  sdxPortrait = 'V&ertical';
  sdxLandscape = '&Horizontal';
  sdxAutoOrientation = 'Au&to';
  sdxPrintOrder = ' Orden de impresión ';
  sdxDownThenOver = 'Por colu&mnas';
  sdxOverThenDown = 'Por &filas';
  sdxShading = ' Sombreado ';
  sdxPrintUsingGrayShading = 'Imprimir usando sombreado &gris';

  sdxCenterOnPage = 'Centrar en la página';
  sdxHorizontally = 'Hori&zontalmente';
  sdxVertically = '&Verticalmente';

  sdxHeader = 'Cabecera ';
  sdxBtnHeaderFont = '&Fuente...';
  sdxBtnHeaderBackground = '&Fondo';
  sdxFooter = 'Pie ';
  sdxBtnFooterFont = 'Fu&ente...';
  sdxBtnFooterBackground = 'F&ondo';

  sdxTop = '&Arriba';
  sdxLeft = '&Izquierda';
  sdxRight = 'De&recha';
  sdxBottom = 'Aba&jo';
  sdxHeader2 = '&Cabecera';
  sdxFooter2 = '&Pie';

  sdxAlignment = 'Alineación';
  sdxVertAlignment = ' Alineación vertical ';
  sdxReverseOnEvenPages = '&Invertir en páginas pares';

  sdxAdjustTo = '&Ajustar a';
  sdxFitTo = '&Encajar en';
  sdxPercentOfNormalSize = '% tamaño normal';
  sdxPagesWideBy = 'página(s) de an&cho por';
  sdxTall = '&alto';

  sdxOf = 'de';
  sdxLastPrinted = 'Última impresión ';
  sdxFileName = 'Nombre del fichero ';
  sdxFileNameAndPath = 'Fichero y directorio ';
  sdxPrintedBy = 'Impreso por ';
  sdxPrintedOn = 'Impreso en ';
  sdxCreatedBy = 'Creado por ';
  sdxCreatedOn = 'Creado en ';
  sdxConfidential = 'Confidencial';

  { HF function }
  
  sdxHFFunctionNameDate = 'Fecha';
  sdxHFFunctionNameDateTime = 'Fecha y hora';
  sdxHFFunctionNameImage = 'Imagen';  
  sdxHFFunctionNameMachineName = 'Nombre del equipo';
  sdxHFFunctionNamePageNumber = 'Número de página';  
  sdxHFFunctionNamePageOfPages = 'Página # de # páginas';    
  sdxHFFunctionNameTime = 'Hora';
  sdxHFFunctionNameTotalPages = 'Páginas totales';
  sdxHFFunctionNameUnknown = 'Desconocido';
  sdxHFFunctionNameUserName = 'Nombre del usuario';

  sdxHFFunctionHintDate = 'Fecha impresa';
  sdxHFFunctionHintDateTime = 'Fecha y hora impresa';
  sdxHFFunctionHintImage = 'Imagen';
  sdxHFFunctionHintMachineName = 'Nombre del equipo';
  sdxHFFunctionHintPageNumber = 'Número de página';
  sdxHFFunctionHintPageOfPages = 'Página # de # páginas';    
  sdxHFFunctionHintTime = 'Hora impresa';
  sdxHFFunctionHintTotalPages = 'Páginas totales';   
  sdxHFFunctionHintUserName = 'Nombre del usuario';

  sdxHFFunctionTemplateDate = 'Fecha impresa';
  sdxHFFunctionTemplateDateTime = 'Fecha y hora impresa';
  sdxHFFunctionTemplateImage = 'Imagen';
  sdxHFFunctionTemplateMachineName = 'Nombre del equipo';
  sdxHFFunctionTemplatePageNumber = 'Página #';
  sdxHFFunctionTemplatePageOfPages = 'Página # de # páginas';    
  sdxHFFunctionTemplateTime = 'Hora impresa';  
  sdxHFFunctionTemplateTotalPages = 'Páginas totales';  
  sdxHFFunctionTemplateUserName = 'Nombre del usuario';

  { PDF Export Dialog }

  sdxPDFDialogAuthor = 'Autor';
  sdxPDFDialogCaption = 'Opciones de exportación a PDF';
  sdxPDFDialogCompressed = 'Comprimido';
  sdxPDFDialogCreator = 'Creador';
  sdxPDFDialogDocumentInfoTabSheet = '&Información';
  sdxPDFDialogEmbedFonts = 'Fuentes embebidas';
  sdxPDFDialogExportSettings = 'Ajustes de exportación';
  sdxPDFDialogExportTabSheet = '&Exportar';
  sdxPDFDialogKeywords = 'Palabras clave';
  sdxPDFDialogMaxCompression = 'Máxima compresión';
  sdxPDFDialogMaxQuality = 'Máxima calidad';
  sdxPDFDialogOpenAfterExport = 'Abrir despues de exportar';
  sdxPDFDialogPageRageTabSheet = '&Páginas';    
  sdxPDFDialogSecurityAllowChanging = 'Permitir modificar el documento';
  sdxPDFDialogSecurityAllowComments = 'Permitir añadir comentarios';
  sdxPDFDialogSecurityAllowCopy = 'Permitir la copia y extracción del documento';
  sdxPDFDialogSecurityAllowDocumentAssemble = 'Permitir el ensamblado del documento';
  sdxPDFDialogSecurityAllowPrint = 'Permitir la impresión';
  sdxPDFDialogSecurityAllowPrintHiResolution = 'Permitir la impresión en alta resolución';
  sdxPDFDialogSecurityEnabled = 'Activo';
  sdxPDFDialogSecurityMethod = 'Método';    
  sdxPDFDialogSecurityOwnerPassword = 'Clave propietario';  
  sdxPDFDialogSecuritySettings = 'Parámetros de seguridad';
  sdxPDFDialogSecurityUserPassword = 'Clave usuario';  
  sdxPDFDialogSignatureContactInfo = 'Información de contacto:';
  sdxPDFDialogSignatureDetails = 'Detalles';
  sdxPDFDialogSignatureDigitalID = 'Certificado (ID digital)';
  sdxPDFDialogSignatureOpenDlgDigitalIDFile = 'ID digital del fichero';
  sdxPDFDialogSignatureOpenDlgTitle = 'Localizar ID digital del fichero';
  sdxPDFDialogSignatureFileName = 'Nombre fichero:';
  sdxPDFDialogSignatureIssuer = 'Editor:';
  sdxPDFDialogSignatureIssuerColumnCaption = 'Editor';
  sdxPDFDialogSignatureExpirationDateColumnCaption = 'Fecha de caducidad';
  sdxPDFDialogSignatureLocation = 'Lugar:';
  sdxPDFDialogSignaturePasswordDialogCaption = 'Clave privada';
  sdxPDFDialogSignatureReason = 'Motivo:';
  sdxPDFDialogSignatureSettings = 'Ajustes de firma';
  sdxPDFDialogSignatureUseCertificateFromFileStore = 'Usar certificado desde fichero';
  sdxPDFDialogSignatureUseCertificateFromSystemStore = 'Usar certificado desde almacén del sistema';
  sdxPDFDialogSignatureViewCertificate = 'Ver certificado...';
  sdxPDFDialogSignatureRequiredDigitalID = 'No se ha especificado el certificado.';
  sdxPDFDialogSignatureRequiredDigitalIDPassword = 'La palabra de paso no es correcta.';
  sdxPDFDialogSubject = 'Asunto';
  sdxPDFDialogTitle = 'Título';
  sdxPDFDialogUseCIDFonts = 'Usar fuentes CID';  
  sdxPDFDialogUseJPEGCompression = 'Usar compresión JPEG para imágenes';
  sdxPDFDialogTabDocInfo = '&Información';
  sdxPDFDialogTabExport = '&Exportar';
  sdxPDFDialogTabPages = '&Páginas';
  sdxPDFDialogTabSecurity = '&Seguridad';
  sdxPDFDialogTabSignature = 'F&irma';

  { Designer strings }
  
  { Months }
  
  sdxJanuary = 'Enero';
  sdxFebruary = 'Febrero';
  sdxMarch = 'Marzo';
  sdxApril = 'Abril';
  sdxMay = 'Mayo';
  sdxJune = 'Junio';
  sdxJuly = 'Julio';
  sdxAugust = 'Agosto';
  sdxSeptember = 'Septiembre';
  sdxOctober = 'Octubre';
  sdxNovember = 'Noviembre';
  sdxDecember = 'Diciembre';

  sdxEast = 'Este';
  sdxWest = 'Oeste';
  sdxSouth = 'Sur';
  sdxNorth = 'Norte';

  sdxTotal = 'Total';

  { dxFlowChart }
  
  sdxPlan = 'Plan';
  sdxSwimmingPool = 'Swimming-pool';
  sdxAdministration = 'Administration';
  sdxPark = 'Park';
  sdxCarParking = 'Car-Parking';

  { dxOrgChart }
  
  sdxCorporateHeadquarters = 'Corporate' + #13#10 + 'Headquarters';
  sdxSalesAndMarketing = 'Sales and' + #13#10 + 'Marketing';
  sdxEngineering = 'Engineering';
  sdxFieldOfficeCanada = 'Field Office:' + #13#10 + 'Canada';

  { dxMasterView }
  
  sdxOrderNoCaption = 'Nº orden';
  sdxNameCaption = 'Nombre';
  sdxCountCaption = 'Cuenta';
  sdxCompanyCaption = 'Compañía';
  sdxAddressCaption = 'Dirección';
  sdxPriceCaption = 'Precio';
  sdxCashCaption = 'Caja';

  sdxName1 = 'Jennie Valentine';
  sdxName2 = 'Sam Hill';
  sdxCompany1 = 'Jennie Inc.';
  sdxCompany2 = 'Daimler-Chrysler AG';
  sdxAddress1 = '123 Home Lane';
  sdxAddress2 = '9333 Holmes Dr.';

  { dxTreeList }
  
  sdxCountIs = 'La cuenta es : %d';
  sdxRegular = 'Regular';
  sdxIrregular = 'Irregular';

  sdxTLBand = 'Datos del elemento';
  sdxTLColumnName = 'Nombre';
  sdxTLColumnAxisymmetric = 'Axisymmetric';
  sdxTLColumnItemShape = 'Forma';

  sdxItemShapeAsText = '(Grafico)';

  sdxItem1Name = 'Cilindro';
  sdxItem2Name = 'Cono';
  sdxItem3Name = 'Pirámide';
  sdxItem4Name = 'Caja';
  sdxItem5Name = 'Superficie libre';

  sdxItem1Description = '';
  sdxItem2Description = 'Figura geométrica con simetría axial';
  sdxItem3Description = 'Figura geométrica con simetría axial';
  sdxItem4Description = 'Figura geomética de ángulos agudos';
  sdxItem5Description = '';
  sdxItem6Description = '';
  sdxItem7Description = 'Superficie extrusionada simple';

  { PS 2.3 }
  
  { Patterns common }
  
  sdxPatternIsNotRegistered = 'El estampado "%s" no está registrado';

  { Excel edge patterns }
  
  sdxSolidEdgePattern = 'Solido';
  sdxThinSolidEdgePattern = 'Semi-sólido';
  sdxMediumSolidEdgePattern = 'Semi-sólido';
  sdxThickSolidEdgePattern = 'Muy sólido';
  sdxDottedEdgePattern = 'Punteado';
  sdxDashedEdgePattern = 'Guionado';
  sdxDashDotDotEdgePattern = 'Guión Punto Punto';
  sdxDashDotEdgePattern = 'Guión Punto';
  sdxSlantedDashDotEdgePattern = 'Corte Guión Punto';
  sdxMediumDashDotDotEdgePattern = 'Linea centrada Punto Punto';
  sdxHairEdgePattern = 'Pelo';
  sdxMediumDashDotEdgePattern = 'Linea centrada Punto';
  sdxMediumDashedEdgePattern = 'Linea centrada';
  sdxDoubleLineEdgePattern = 'Doble línea';

  { Excel fill patterns names} 
   
  sdxSolidFillPattern = 'Sólido';
  sdxGray75FillPattern = '75% gris';
  sdxGray50FillPattern = '50% gris';
  sdxGray25FillPattern = '25% gris';
  sdxGray125FillPattern = '12.5% gris';
  sdxGray625FillPattern = '6.25% gris';
  sdxHorizontalStripeFillPattern = 'Rayas horizontales';
  sdxVerticalStripeFillPattern = 'Rayas verticales';
  sdxReverseDiagonalStripeFillPattern = 'Rayas diagonales invertidas';
  sdxDiagonalStripeFillPattern = 'Rayas diagonales';
  sdxDiagonalCrossHatchFillPattern = 'Cruces en diagonal';
  sdxThickCrossHatchFillPattern = 'Cruces en diagonal gruesas';
  sdxThinHorizontalStripeFillPattern = 'Rayas horizontales finas';
  sdxThinVerticalStripeFillPattern = 'Rayas verticales finas';
  sdxThinReverseDiagonalStripeFillPattern = 'Rayas finas diagonales invertidas';
  sdxThinDiagonalStripeFillPattern = 'Rayas diagonales finas';
  sdxThinHorizontalCrossHatchFillPattern = 'Cruces horizontales finas';
  sdxThinDiagonalCrossHatchFillPattern = 'Cruces en diagonal finas';
  
  { cxSpreadSheet } 
  
  sdxShowRowAndColumnHeadings = '&Cabeceras de fila y columna';
  sdxShowGridLines = 'Lines de rejilla';
  sdxSuppressSourceFormats = '&Suprimir formatos fuente';
  sdxRepeatHeaderRowAtTop = 'Repetir fila de cabecera en la parte superior';
  sdxDataToPrintDoesNotExist = 
    'No se puede activar el enlace del informe porque el sistema de impresión no encuentra nada que imprimir.';
 
  { Designer strings } 
  
  { Short names of month }
  
  sdxJanuaryShort = 'Ene';
  sdxFebruaryShort = 'Feb';
  sdxMarchShort = 'Mar';
  sdxAprilShort = 'Abr';
  sdxMayShort = 'May';    
  sdxJuneShort = 'Jun';
  sdxJulyShort = 'Jul';
  sdxAugustShort = 'Ago';
  sdxSeptemberShort = 'Sep';
  sdxOctoberShort = 'Oct';
  sdxNovemberShort = 'Nov';
  sdxDecemberShort = 'Dic';

  { TreeView }
  
  sdxTechnicalDepartment = 'Departamento técnico';
  sdxSoftwareDepartment = 'Departamento de software';
  sdxSystemProgrammers = 'Desarroladores del núcleo';
  sdxEndUserProgrammers = 'Desarolladores del GUI';
  sdxBetaTesters = 'Comprobadores de versiones beta';
  sdxHumanResourceDepartment = 'Departamento de recursos humanos';

  { misc. }
  
  sdxTreeLines = '&Lineas del arbol';
  sdxTreeLinesColor = '&Color de las líneas del arbol:';
  sdxExpandButtons = 'Botones de e&xpansión';
  sdxCheckMarks = 'Seleccionar marcas';
  sdxTreeEffects = 'Efectos del arbol';
  sdxAppearance = 'Apariencia';

  { Designer previews }
  
  { Localize if you want (they are used inside FormatReport dialog -> ReportPreview) }

  sdxCarLevelCaption = 'Coches';
  
  sdxManufacturerBandCaption = 'Datos del fabricante';
  sdxModelBandCaption = 'Datos del coche';
  
  sdxManufacturerNameColumnCaption = 'Nombre';
  sdxManufacturerLogoColumnCaption = 'Logotipo';
  sdxManufacturerCountryColumnCaption = 'Pais';
  sdxCarModelColumnCaption = 'Modelo';
  sdxCarIsSUVColumnCaption = '4x4';
  sdxCarPhotoColumnCaption = 'Foto';
  sdxCarSpeedCountColumnCaption = 'Contador de velocidad';

  sdxCarManufacturerName1 = 'BMW';
  sdxCarManufacturerName2 = 'Ford';
  sdxCarManufacturerName3 = 'Audi';
  sdxCarManufacturerName4 = 'Land Rover';

  sdxCarManufacturerCountry1 = 'Alemania';
  sdxCarManufacturerCountry2 = 'Estados Unidos';
  sdxCarManufacturerCountry3 = 'Alemania';
  sdxCarManufacturerCountry4 = 'Reino Unido';
  
  sdxCarModel1 = 'X5 4.8is';
  sdxCarModel2 = 'Excursion';
  sdxCarModel3 = 'S8 Quattro';
  sdxCarModel4 = 'G4 Challenge';
  
  sdxTrue = 'True';
  sdxFalse = 'False';  

  { PS 2.4 }
  
  { dxPrnDev.pas }
  
  sdxAuto = 'Auto'; 
  sdxCustom = 'Personalizado';
  sdxEnv = 'Env'; 

  { Grid 4 }

  sdxLookAndFeelFlat = 'Plano';
  sdxLookAndFeelStandard = 'Estandar';
  sdxLookAndFeelUltraFlat = 'Ultraplano';

  sdxViewTab = 'Vista';
  sdxBehaviorsTab = 'Comportamientos';
  sdxPreviewTab = 'Vista previa';
  sdxCardsTab = 'Fichas';

  sdxFormatting = 'Formato';
  sdxLookAndFeel = 'Apariencia';
  sdxLevelCaption = '&Encabezamiento';
  sdxFilterBar = '&Barra de filtro';
  sdxRefinements = 'Refinamientos';
  sdxProcessSelection = 'Proceso de &selección';
  sdxProcessExactSelection = 'Proceso e&xacto de selección';
  sdxExpanding = 'Expandiendo';
  sdxGroups = '&Grupos';
  sdxDetails = '&Detalles';
  sdxStartFromActiveDetails = 'Empezar desde detalles activos';
  sdxOnlyActiveDetails = 'Solo detalles activos';
  sdxVisible = '&Visible';
  sdxPreviewAutoHeight = 'A&ltura automática';
  sdxPreviewMaxLineCount = 'Lineas &totales: ';
  sdxSizes = 'Tamaños';
  sdxKeepSameWidth = '&Igualar anchuras';
  sdxKeepSameHeight = 'Igualar al&turas';
  sdxFraming = 'Encuadre';
  sdxSpacing = 'Espaciado';
  sdxShadow = 'Sombra';
  sdxDepth = '&Profundidad:';
  sdxPosition = '&Posición';
  sdxPositioning = 'Posicionado';
  sdxHorizontal = 'H&orizontal:';
  sdxVertical = 'V&ertical:';

  sdxSummaryFormat = 'Contador = 0';

  sdxCannotUseOnEveryPageMode =
    'No se puede usar el modo En cada página. Debe : ' + #13#10 +
    '  - Colapsar todos los registros maestros' + #13#10 +
    '  - Desactivar la opción Expandir las pestañas en la pestaña Comportamientos';

  sdxIncorrectBandHeadersState = 
    'No se pueden usar cabeceras de banda en en la sección En cada página. Debe :' + #13#10 +
    '  - Activar Encabezamiento en la sección En cada página' + #13#10 +
    '  - Desactivar la opción Cabeceras en la sección Mostrar';
  sdxIncorrectHeadersState = 
    'No se pueden usar cabeceras en el modo En cada página. Debe :' + #13#10 +
    '  - Activar Encabezamiento y Bandas en la sección En cada página' + #13#10 +
    '  - Desactivar Encabezamiento y Bandas en la sección Mostrar';
  sdxIncorrectFootersState = 
   'No se pueden usar pies en la sección En cada página". Debe :' + #13#10 +
    '  - Activar Barra de filtro en la sección En cada página' + #13#10 +
    '  - Desactivar Barra de filtro en la sección Mostrar';

  sdxCharts = 'Gráficas';
  
  { PS 3 }

  sdxTPicture = 'TPicture';
  sdxCopy = '&Copia';
  sdxSave = '&Guardar...';
  sdxBaseStyle = 'Estilo base';
  
  sdxComponentAlreadyExists = 'El componente "%s" ya existe';
  sdxInvalidComponentName = '"%s" no es un nombre de componente válido';
  
  { shapes } 
 
  sdxRectangle = 'Rectángulo';
  sdxSquare = 'Cuadrado';
  sdxEllipse = 'Elipse';
  sdxCircle = 'Círculo';
  sdxRoundRect = 'Rect. redon.';
  sdxRoundSquare = 'Cuad. redon.';

  { standard pattern names}
    
  sdxHorizontalFillPattern = 'Horizontal';
  sdxVerticalFillPattern = 'Vertical';
  sdxFDiagonalFillPattern = 'FDiagonal';
  sdxBDiagonalFillPattern = 'BDiagonal';
  sdxCrossFillPattern = 'Cross';
  sdxDiagCrossFillPattern = 'DiagCros';
  
  { explorer }
                                                             
  sdxCyclicIDReferences = 'Referencias de ID cíclico %s y %s';
  sdxLoadReportDataToFileTitle = 'Cargar informe';
  sdxSaveReportDataToFileTitle = 'Guardar informe como';
  sdxInvalidExternalStorage = 'Almacenamineto externo no válido';
  sdxLinkIsNotIncludedInUsesClause = 
    'El fichero contiene un enlace a la unidad "%0:s"' + #13#10 +
    'del informe con declaración "%0:s" que debe ser incluida en la intrucción "uses"';
  sdxInvalidStorageVersion = 'Versión de almacenamineto no válido: %d';
  sdxPSReportFiles = 'Ficheros de informe';
  sdxReportFileLoadError = 
    'No se puede cargar el fichero de informe "%s".' + #13#10 +
    'El fichero está dañado o está siendo bloquedado por otro usuario o aplicación.' + #13#10 +
    #13#10 +
    'El informe original será restaurado.';
  
  sdxNone = '(Ninguno)';
  sdxReportDocumentIsCorrupted = '(El fichero no es un informe o está dañado)';
  
  sdxCloseExplorerHint = 'Cerrar el explorador';
  sdxExplorerCaption = 'Explorador';
  sdxExplorerRootFolderCaption = 'Raiz';
  sdxNewExplorerFolderItem = 'Nueva carpeta';
  sdxCopyOfItem = 'Copia de ';
  sdxReportExplorer = 'Explorador de informes';
                                
  sdxDataLoadErrorText = 'No se pueden cargar los datos del informe';
  sdxDBBasedExplorerItemDataLoadError = 
    'No se pueden cargar los datos del informe.' + #13#10 +
    'Los datos están dañados o bloqueados';
  sdxFileBasedExplorerItemDataLoadError = 
    'No se pueden cargar los datos del informe.' + #13#10 +
    'El fichero está dañado o está siendo bloqueado por otro usuario o aplicación';
  sdxDeleteNonEmptyFolderMessageText = 'La carpeta "%s" no está vacía. ¿Borrar de todas formas?';
  sdxDeleteFolderMessageText = '¿Borrar a carpeta "%s" ?';
  sdxDeleteItemMessageText = 'Borrar el elemento "%s" ?';
  sdxCannotRenameFolderText = 'No se puede renombrar la carpeta "%s". Ya existe una carpeta con el nombre "%s". Introduzca un nombre diferente.';
  sdxCannotRenameItemText = 'No se puede renombrar el elemento "%s". Ya existe un elemento con el nombre "%s". Introduzca un nombre diferente.';
  sdxOverwriteFolderMessageText = 
    'La carpeta "%s" ya contiene una carpeta denominada "%s".' + #13#10 +
    #13#10 + 
    'Si los elementos en la carpeta tienen el mismo nombre que los elementos' + #13#10 +
    'de la carpeta que está moviendo o copiando, serán sustituidos. ¿Aún así desea' + #13#10 +
    'mover o copiar la carpeta?';
  sdxOverwriteItemMessageText = 
    'La carpeta "%s" ya contiene un elemento denominado "%s".' + #13#10 +
    #13#10 + 
    '¿Desea reemplazar el elemento existente?';
  sdxSelectNewRoot = 'Seleccione un nuevo directorio raiz donde los informes serán almacenados';
  sdxInvalidFolderName = 'Nombre de carpeta no válido "%s"';
  sdxInvalidReportName = 'Nombre de informe no válido "%s"';
  
  sdxExplorerBar = 'Explorador';

  sdxMenuFileSave = '&Guardar';
  sdxMenuFileSaveAs = 'G&uardar como...';
  sdxMenuFileLoad = '&Cargar';
  sdxMenuFileClose = 'Descar&gar';
  sdxHintFileSave = 'Guardar informe';
  sdxHintFileSaveAs = 'Guardar informe como';
  sdxHintFileLoad = 'Cargar informe';
  sdxHintFileClose = 'Descargar informe';
  
  sdxMenuExplorer = 'E&xplorador';
  sdxMenuExplorerCreateFolder = 'Crear car&peta';
  sdxMenuExplorerDelete = '&Borrar...';
  sdxMenuExplorerRename = 'Reno&mbar';
  sdxMenuExplorerProperties = '&Propiedades...';
  sdxMenuExplorerRefresh = 'Actualizar';
  sdxMenuExplorerChangeRootPath = 'Cambiar raiz...';
  sdxMenuExplorerSetAsRoot = 'Fijar como raiz';
  sdxMenuExplorerGoToUpOneLevel = 'Subir un nivel';

  sdxHintExplorerCreateFolder = 'Creae nueva carpeta';
  sdxHintExplorerDelete = 'Borrar';
  sdxHintExplorerRename = 'Renombrar';
  sdxHintExplorerProperties = 'Propiedades';
  sdxHintExplorerRefresh = 'Actualizar';
  sdxHintExplorerChangeRootPath = 'Cambiar raiz';
  sdxHintExplorerSetAsRoot = 'Fijar carpeta actual como raiz';
  sdxHintExplorerGoToUpOneLevel = 'Subir un nivel';
  
  sdxMenuViewExplorer = 'E&xplorador';
  sdxHintViewExplorer = 'Mostrar explorador';

  sdxSummary = 'Sumario';
  sdxCreator = 'Creado&r';
  sdxCreationDate = 'Crea&do';
 
  sdxMenuViewThumbnails = '&Miniaturas';
  sdxMenuThumbnailsLarge = 'Miniaturas &grandes';
  sdxMenuThumbnailsSmall = 'Miniaturas &pequeñas';
  
  sdxHintViewThumbnails = 'Mostrar miniaturas';
  sdxHintThumbnailsLarge = 'Cambiar a miniaturas grandes';
  sdxHintThumbnailsSmall = 'Cambiar a miniaturas pequeñas';
    
  sdxMenuFormatTitle = 'T&ítulo...';
  sdxHintFormatTitle = 'Format Report Title';
  sdxMenuFormatFootnotes = 'Foot&notes...';
  sdxHintFormatFootnotes = 'Format Report Footnotes...';

  sdxHalf = 'Half';
  sdxPredefinedFunctions = ' Funciones predefinidas '; // dxPgsDlg.pas
  sdxZoomParameters = ' &Parámetros del zoom ';          // dxPSPrvwOpt.pas

  sdxWrapData = '&Wrap Data';

  sdxMenuShortcutExplorer = 'Explorador';
  sdxExplorerToolBar = 'Explorador';

  sdxMenuShortcutThumbnails = 'Thumbnails';

  { Ribbon Print Preview Window }

  sdxRibbonPrintPreviewClosePrintPreview = 'Cerrar vista previa';
  sdxRibbonPrintPreviewGroupFormat = 'Formato';
  sdxRibbonPrintPreviewGroupInsertName = 'Nombre';
  sdxRibbonPrintPreviewGroupInsertPageNumber = 'Nro. página';
  sdxRibbonPrintPreviewGroupNavigation = 'Navigación';
  sdxRibbonPrintPreviewGroupOutput = 'Salida';
  sdxRibbonPrintPreviewGroupParts = 'Partes';
  sdxRibbonPrintPreviewGroupReport = 'Informe';
  sdxRibbonPrintPreviewGroupScaleToFit = 'Escalar para que encaje';
  sdxRibbonPrintPreviewGroupZoom = 'Zoom';
  sdxRibbonPrintPreviewPagesSubItem = 'Páginas';

  { TreeView New}
  
  sdxButtons = 'Botones';
  
  { ListView }

  sdxBtnHeadersFont = 'Fuente de &cabeceras...';
  sdxHeadersTransparent = 'cabeceras &transparentes';
  sdxHintListViewDesignerMessage = ' La mayoría de las opciones se están tomando en cuenta sólo en la visión detallada';
  sdxColumnHeaders = 'Cabeceras de &columna';
  
  { Group LookAndFeel Names }

  sdxReportGroupNullLookAndFeel = 'Nulo';
  sdxReportGroupStandardLookAndFeel = 'Estandard';
  sdxReportGroupOfficeLookAndFeel = 'Office';  
  sdxReportGroupWebLookAndFeel = 'Web';

  { Layout }

  sdxLayoutGroupDefaultCaption = 'Grupo de diseño';
  sdxLayoutItemDefaultCaption = 'Elemento de diseño';
  sdxTabs = 'Pestañas';
  sdxUnwrapTabs = '&Expandir las pestañas';
  sdxActiveTabToTop = 'Mostrar la pestaña activo encima';
  sdxBehaviorsGroups = 'Grupos';
  sdxSkipEmptyGroups = 'Saltarse los grupos vacíos';
  sdxExpandedGroups = 'Expandir grupos';

  { Designer Previews}

  { Localize if you want (they are used inside FormatReport dialog -> ReportPreview) }
    
  sdxCarManufacturerName5 = 'DaimlerChrysler AG';
  sdxCarManufacturerCountry5 = 'Alemania';
  sdxCarModel5 = 'Maybach 62';

  sdxLuxurySedans = 'Sedán de lujo';
  sdxCarManufacturer = 'Fabricante';
  sdxCarModel = 'Modelo';
  sdxCarEngine = 'Motor';
  sdxCarTransmission = 'Transmisión';
  sdxCarTires = 'Neumáticos';
  sdx760V12Manufacturer = 'BMW';
  sdx760V12Model = '760Li V12';
  sdx760V12Engine = '6.0L DOHC V12 438 HP 48V DI Motor de 12 cilindros Valvetronic con 6.0 litros de desplazamiento, válvulas con doble árbol de levas';
  sdx760V12Transmission = 'Elec 6-Veloc. Automatico con Steptronic';
  sdx760V12Tires = 'P245/45R19 Fr - P275/40R19 Rr rendimiento. Neumáticos de perfil bajo con 245mm de anchura, llanta de 19.0"';
      
  { Styles }

  sdxBandBackgroundStyle = 'Banda de fondo';
  sdxBandHeaderStyle = 'Banda de cabecera';
  sdxCaptionStyle = 'Título';
  sdxCardCaptionRowStyle = 'Titulo tarjeta';
  sdxCardRowCaptionStyle = 'Titulo fila de tarjeta';
  sdxCategoryStyle = 'Categoría';
  sdxContentStyle = 'Contenido';
  sdxContentEvenStyle = 'Contenido filas pares';
  sdxContentOddStyle = 'Contenido filas impares';
  sdxFilterBarStyle = 'Barra de filtro';
  sdxFooterStyle = 'Pie';
  sdxFooterRowStyle = 'Pie de fila';
  sdxGroupStyle = 'Grupo';
  sdxHeaderStyle = 'Cabecera';
  sdxIndentStyle = 'Indentación';
  sdxPreviewStyle = 'Vista previa';
  sdxSelectionStyle = 'Selección';

  sdxStyles = 'Estilos';
  sdxStyleSheets = 'Hojas de estilo';
  sdxBtnTexture = '&Textura...';
  sdxBtnTextureClear = '&Limpiar';
  sdxBtnColor = 'Co&lor...';
  sdxBtnSaveAs = '&Guardar como...';
  sdxBtnRename = '&Renombrar...';
  
  sdxLoadBitmapDlgTitle = 'Cargar textura';
  
  sdxDeleteStyleSheet = 'Borrar hoja de estilo de nombre "%s"?';
  sdxUnnamedStyleSheet = 'Sin nombre';
  sdxCreateNewStyleQueryNamePrompt = 'Indicar el nombre de la nueva hoja de estilo: ';
  sdxStyleSheetNameAlreadyExists = 'La hoja de estilo "%s" ya existe';

  sdxCannotLoadImage = 'No se puede cargar la imgen "%s"';
  sdxUseNativeStyles = '&Usar estilos nativos';
  sdxSuppressBackgroundBitmaps = '&Suprimir texturas de fondo';
  sdxConsumeSelectionStyle = 'Seleccionar estilo';
  
  { Grid4 new }

  sdxSize = 'Tamaño';
  sdxLevels = 'Niveles';
  sdxUnwrap = '&Desempaquetar';
  sdxUnwrapTopLevel = 'Des&empaquetar nivel superior';
  sdxRiseActiveToTop = 'Elevar el nivel activo hasta el tope';
  sdxCannotUseOnEveryPageModeInAggregatedState = 
    'No se puede usar el modo "En cada página"'+ #13#10 +
    'mientras se está en estado de agregación';

  sdxPagination = 'Paginación';
  sdxByBands = 'Por bandas';
  sdxByColumns = 'Por columnas';
  sdxByRows = 'Por &filas';
  sdxByTopLevelGroups = 'Por grupos de nivel superior';
  sdxOneGroupPerPage = 'Un grupo por página';

  sdxSkipEmptyViews = 'Saltar vistas vacías';

  {* For those who will translate *}
  {* You should also check "sdxCannotUseOnEveryPageMode" resource string - see above *}
  {* It was changed to "- Toggle "Unwrap" Option off on "Behaviors" Tab"*}
   
  { TL 4 }
  sdxBorders = 'Bordes';
  sdxExplicitlyExpandNodes = 'Expandir nodos explícitamente';
  sdxNodes = '&Nodos';
  sdxSeparators = 'Separadores';
  sdxThickness = 'Grosor';
  sdxTLIncorrectHeadersState = 
    'No sep ueden usar cabaceceras en el modo "En cada página"' + #13#10 +
    #13#10 +
    'Debe:' + #13#10 +
    '  - Fijar la opción "En cada página" de la banda' + #13#10 +
    '  - Desmarcar la opción "Visible" de la banda';

  { cxVerticalGrid }

  sdxRows = '&Filas';

  sdxMultipleRecords = '&Múltiples registros';
  sdxBestFit = '&Mejor encaje';
  sdxKeepSameRecordWidths = '&Mantener anchuras de registros';
  sdxWrapRecords = '&Empaquetar registros';

  sdxByWrapping = 'Por &contenedor';
  sdxOneWrappingPerPage = '&Un contenedor por página';

  {new in 3.01}
  sdxCurrentRecord = 'Registro atual';
  sdxLoadedRecords = 'Registros cargados';
  sdxAllRecords = 'Todos los registros';
  
  { Container Designer }
  
  sdxPaginateByControlDetails = 'Detalles del control';
  sdxPaginateByControls = 'Controles';
  sdxPaginateByGroups = 'Grupos';
  sdxPaginateByItems = 'Elementos';
  
  sdxControlsPlace = 'Ubicación de los controles';
  sdxExpandHeight = 'Expandir altura';
  sdxExpandWidth = 'Expandir anchura';
  sdxShrinkHeight = 'Comprimir altura';
  sdxShrinkWidth = 'Comprimir anchura';
  
  sdxCheckAll = 'Comprobar &todo';
  sdxCheckAllChildren = 'Comprobar todos los &hijos';
  sdxControlsTab = 'Controles';
  sdxExpandAll = 'E&xpandir todo';
  sdxHiddenControlsTab = 'Ocultar controles';
  sdxReportLinksTab = 'Diseñadores agregados';
  sdxAvailableLinks = '&Enlaces disponibles:';
  sdxAggregatedLinks = 'Enlaces a&gregados:';
  sdxTransparents = 'Transparentes';
  sdxUncheckAllChildren = 'Des&marcar todos los hijos';
  
  sdxRoot = '&Raíz';
  sdxRootBorders = 'Bordes de &raíz';
  sdxControls = '&Controles';
  sdxContainers = 'C&ontenedores';

  sdxHideCustomContainers = '&Ocultar contenedores personalizados';

  { General }
  
  // FileSize abbreviation

  sdxBytes = 'Bytes';
  sdxKiloBytes = 'KB';
  sdxMegaBytes = 'MB';
  sdxGigaBytes = 'GB';

  // Misc.

  sdxThereIsNoPictureToDisplay = 'No hay imágen que mostrar';
  sdxInvalidRootDirectory = 'El directorio "%s" no existe. ¿Continuar la selección?';
  sdxPressEscToCancel = 'Pulse <Esc> para cancelar';
  sdxMenuFileRebuild = '&Reconstruir';
  sdxBuildingReportStatusText = 'Contruyendo informe - Pulse <Esc> para cancelar';
  sdxPrintingReportStatusText = 'Imprimiendo informe - Pulse <Esc> para cancelar';
  
  sdxBuiltIn = '[Incorporado]';
  sdxUserDefined = '[Personalizado]';
  sdxNewStyleRepositoryWasCreated = 'Un nuevo almacén de estilos "%s" ha sido creado y asignado';

  { new in PS 3.1}
  sdxLineSpacing = '&Espaciondo de líneas:';
  sdxTextAlignJustified = 'Justificado';
  sdxSampleText = 'Texto de ejemplo Texto de ejemplo';
  
  sdxCardsRows = '&Tarjetas';
  sdxTransparentRichEdits = 'Contenido &RTF transparente';

  sdxIncorrectFilterBarState = 
    'No se puede usar el modo "En cada página" en la barra de filtro ' + #13#10 +
    #13#10 +
    'Debe:' + #13#10 +
    '  - Activar "En cada página" en el título' + #13#10 +
    '  - Desactivar "Visible" en el título';
  sdxIncorrectBandHeadersState2 = 
    'No puede usar el modo "En cada página" en las bandas de cabecera' + #13#10 +
    #13#10 +
    'Debe:' + #13#10 +
    '  - Activar "En cada pagina" en el título y barra de filtro' + #13#10 +
    '  - Desactivar "Visible" en el título y barra de filtro';
  sdxIncorrectHeadersState2 = 
    'No puede usar el modo "En cada página" en la cabecera' + #13#10 +
    #13#10 +
    'Debe:' + #13#10 +
    '  - Activar "En cada página" en el título, barra de filtro y banda' + #13#10 +
    '  - Desactivar "Visible" en el título, banda de filtro y banda';

 { new in PS 3.2}   
  sdxAvailableReportLinks = 'Enlaces a informes disponibles';
  sdxBtnRemoveInconsistents = 'Suprimidos los innecesarios';
  sdxColumnHeadersOnEveryPage = 'Cabeceras de &columna';
  sdxRowHeadersOnEveryPage = 'Cabecaras de &fila';

 { Scheduler }   

  sdxNotes = 'Notas';
  sdxTaskPad = 'Panel de tareas';
  sdxPrimaryTimeZone = 'Primario';
  sdxSecondaryTimeZone = 'Secundario';

  sdxDay = 'Día';
  sdxWeek = 'Semana';
  sdxMonth = 'Mes';

  sdxSchedulerSchedulerHeader = 'Cabecera del planificador';
  sdxSchedulerContent = 'Contenido';
  sdxSchedulerDateNavigatorContent = 'Contenido del navegador de fechas';
  sdxSchedulerDateNavigatorHeader = 'Cabecera del navegador de fechas';
  sdxSchedulerDayHeader = 'Cabecera día';
  sdxSchedulerEvent = 'Evento';
  sdxSchedulerResourceHeader = 'Cabecera de tarea';
  sdxSchedulerNotesAreaBlank = 'Área de notas Area (Vacía)';
  sdxSchedulerNotesAreaLined = 'Área de notas (Rayada)';
  sdxSchedulerTaskPad = 'Panel de tareas';
  sdxSchedulerTimeRuler = 'Regla temporal';
  
  sdxPrintStyleNameDaily = 'Diariamente';
  sdxPrintStyleNameWeekly = 'Semanalmente';
  sdxPrintStyleNameMonthly = 'Mensualmente';
  sdxPrintStyleNameDetails = 'Detalles';
  sdxPrintStyleNameMemo = 'Memo';
  sdxPrintStyleNameTrifold = 'Tres paneles';
  
  sdxPrintStyleCaptionAgenda = 'Estilo de la agenda';
  sdxPrintStyleCaptionDaily = 'Diario';
  sdxPrintStyleCaptionWeekly = 'Semanal';
  sdxPrintStyleCaptionMonthly = 'Mensual';
  sdxPrintStyleCaptionDetails = 'Detalles del calendario';
  sdxPrintStyleCaptionMemo = 'Memoria';
  sdxPrintStyleCaptionTimeLine = 'Linea temporal';
  sdxPrintStyleCaptionTrifold = 'Tres paneles';
  sdxPrintStyleCaptionYearly = 'Anual';
  sdxPrintStyleShowEventImages = 'Mostrar imágenes de eventos';
  sdxPrintStyleShowResourceImages = 'Mostrar imágenes de recursos';

  sdxTabPrintStyles = 'Estilos de impresión';

  sdxPrintStyleDontPrintWeekEnds = 'No imprimir &fines de semana';
  sdxPrintStyleWorkTimeOnly = '&Solo horas de trabajo';

  sdxPrintStyleInclude = 'Incluir';
  sdxPrintStyleIncludeTaskPad = '&Panel de tareas';
  sdxPrintStyleIncludeNotesAreaBlank = 'Área de notas Area (&Vacía)';
  sdxPrintStyleIncludeNotesAreaLined = 'Área de notas (&Rayada)';
  sdxPrintStyleLayout = '&Diseño';
  sdxPrintStylePrintFrom = 'Imprimir &desde';
  sdxPrintStylePrintTo = 'Imprimir &hasta';

  sdxPrintStyleDailyLayout1PPD = '1 página/día';
  sdxPrintStyleDailyLayout2PPD = '2 páginas/día';

  sdxPrintStyleWeeklyArrange = '&Organizar';
  sdxPrintStyleWeeklyArrangeT2B = 'De arriba a abajo';
  sdxPrintStyleWeeklyArrangeL2R = 'De izquierda a derecha';
  sdxPrintStyleWeeklyLayout1PPW = '1 página/semana';
  sdxPrintStyleWeeklyLayout2PPW = '2 páginas/semana';
  sdxPrintStyleWeeklyDaysLayout   = '&Diseño de días';
  sdxPrintStyleWeeklyDaysLayoutTC = 'Dos columnas';
  sdxPrintStyleWeeklyDaysLayoutOC = 'Una columna';

  sdxPrintStyleMemoStartEachItemOnNewPage = 'Iniciar cada elemento en nueva página';
  sdxPrintStyleMemoPrintOnlySelectedEvents = 'Imprimir solo los eventos seleccionados';

  sdxPrintStyleMonthlyLayout1PPM = '1 página/mes';
  sdxPrintStyleMonthlyLayout2PPM = '2 páginas/mes';
  sdxPrintStyleMonthlyPrintExactly1MPP = 'Imprimir un &mes por página';

  sdxPrintStyleTrifoldSectionModeDailyCalendar = 'Calendario diario';
  sdxPrintStyleTrifoldSectionModeWeeklyCalendar = 'Calendario semanal';
  sdxPrintStyleTrifoldSectionModeMonthlyCalendar = 'Calendario mensual';
  sdxPrintStyleTrifoldSectionModeTaskPad = 'Panel de tareas';
  sdxPrintStyleTrifoldSectionModeNotesBlank = 'Notas (Vacío)';
  sdxPrintStyleTrifoldSectionModeNotesLined = 'Notas (Rayado)';
  sdxPrintStyleTrifoldSectionLeft = 'Sección &izquierda';
  sdxPrintStyleTrifoldSectionMiddle = 'Sección &media';
  sdxPrintStyleTrifoldSectionRight = 'Sección &derecha:';

  sdxPrintStyleMonthPerPage = '&Meses/página:';
  sdxPrintStyleYearly1MPP  = '1 mes/página';
  sdxPrintStyleYearly2MPP  = '2 meses/página';
  sdxPrintStyleYearly3MPP  = '3 meses/página';
  sdxPrintStyleYearly4MPP  = '4 meses/página';
  sdxPrintStyleYearly6MPP  = '6 meses/página';
  sdxPrintStyleYearly12MPP = '12 meses/página';

  sdxPrintStylePrimaryPageScalesOnly = 'Solo escalas de página primaria';
  sdxPrintStylePrimaryPageHeadersOnly = 'Solo cabeceras de página primaria';

  sdxPrintStyleDetailsStartNewPageEach = 'Iniciar una nueva página cada';

  sdxSuppressContentColoration = 'Suprimir co&loración del contenido';
  sdxOneResourcePerPage = 'Un &recurso por página';

  sdxPrintRanges = 'Rangos de impresión';
  sdxPrintRangeStart = '&Inicio';
  sdxPrintRangeEnd = '&Fin';
  sdxHideDetailsOfPrivateAppointments = '&Ocultar detalles de citas privadas';
  sdxResourceCountPerPage = '&Recursos/página';

  sdxSubjectLabelCaption = 'Asunto';
  sdxLocationLabelCaption = 'Ubicación';
  sdxStartLabelCaption = 'Inicio';
  sdxFinishLabelCaption = 'Fin';
  sdxShowTimeAsLabelCaption = 'Mostrar horas como';
  sdxRecurrenceLabelCaption = 'Recurrencia';
  sdxRecurrencePatternLabelCaption = 'Patrón de recurrencia';

  //messages
  sdxSeeAboveMessage = 'Por favor, vea más abajo';
  sdxAllDayMessage = 'Todo el día';
  sdxContinuedMessage = 'Seguido';
  sdxShowTimeAsFreeMessage = 'Libre';
  sdxShowTimeAsTentativeMessage = 'Tentativa';
  sdxShowTimeAsOutOfOfficeMessage = 'Fuera de la oficina';

  sdxRecurrenceNoneMessage = '(ninguna)';
  scxRecurrenceDailyMessage = 'Diariamente';
  scxRecurrenceWeeklyMessage = 'Semanalmente';
  scxRecurrenceMonthlyMessage = 'Mensualmente';
  scxRecurrenceYearlyMessage = 'Anualmente';

  //error messages
  sdxInconsistentTrifoldStyle = 'El estilo de tres paneles requiere al menos una sección de calendario. ' +
    'Seleccione calendario diario, semanal o mensual para una de las secciones situadas en "Opciones".';
  sdxBadTimePrintRange = 'Las horas a imprimir no son válidas. La hora de inicio debe preceder a la hora final.';
  sdxBadDatePrintRange = 'La fecha en la casilla "Fin" no puede ser anterior a la introducida en "Inicio".';
  sdxCannotPrintNoSelectedItems = 'No se puede imprimir hasta que no seleccione un elemento. Selecciónelo e intente la impresión de nuevo.';
  sdxCannotPrintNoItemsAvailable = 'Ningún elemento disponible en el rango de impresión especificado.';

  { PivotGrid }

  sdxColumnFields = '&Campos de columna';
  sdxDataFields   = 'Campos de &datos';
  sdxFiterFields  = 'Campos de &filtro';
  sdxPrefilter = '&Filtro previo';
  sdxRowFields    = '&Campos de fila';

  sdxAutoColumnsExpand = 'Expandir &columnas autom.';
  sdxAutoRowsExpand = 'Expandir &filas autom.';

  // styles
  sdxPivotGridColumnHeader = 'Cabecera de columna';
  sdxPivotGridContent = 'Contenido';
  sdxPivotGridFieldHeader  = 'Campo de cabecera';
  sdxPivotGridHeaderBackground = 'Fondo de cabecera';
  sdxPivotGridRowHeader = 'Fila de cabecera';
  sdxPivotGridPrefilter = 'Filtro previo';

  // PivotPreview fields
  sdxUnitPrice = 'Precio unitario';
  sdxCarName = 'Nombre del coche';
  sdxQuantity = 'Cantidad';
  sdxPaymentAmount = 'Importe del pago';
  sdxPurchaseQuarter = 'Trimestre de compra';
  sdxPurchaseMonth = 'Mes de compra';
  sdxPaymentType   = 'Tipo de pago';
  sdxCompanyName   = 'Empresa';

implementation

uses
  dxCore;

const
  dxThisUnitName = 'dxPSRes';

procedure AddResourceStringsPart1(AProduct: TdxProductResourceStrings);
begin
  AProduct.Add('sdxBtnOK', @sdxBtnOK);
  AProduct.Add('sdxBtnOKAccelerated', @sdxBtnOKAccelerated);
  AProduct.Add('sdxBtnCancel', @sdxBtnCancel);
  AProduct.Add('sdxBtnClose', @sdxBtnClose);
  AProduct.Add('sdxBtnApply', @sdxBtnApply);
  AProduct.Add('sdxBtnHelp', @sdxBtnHelp);
  AProduct.Add('sdxBtnFix', @sdxBtnFix);
  AProduct.Add('sdxBtnNew', @sdxBtnNew);
  AProduct.Add('sdxBtnIgnore', @sdxBtnIgnore);
  AProduct.Add('sdxBtnYes', @sdxBtnYes);
  AProduct.Add('sdxBtnNo', @sdxBtnNo);
  AProduct.Add('sdxBtnEdit', @sdxBtnEdit);
  AProduct.Add('sdxBtnReset', @sdxBtnReset);
  AProduct.Add('sdxBtnAdd', @sdxBtnAdd);
  AProduct.Add('sdxBtnAddComposition', @sdxBtnAddComposition);
  AProduct.Add('sdxBtnDefault', @sdxBtnDefault);
  AProduct.Add('sdxBtnDelete', @sdxBtnDelete);
  AProduct.Add('sdxBtnDescription', @sdxBtnDescription);
  AProduct.Add('sdxBtnCopy', @sdxBtnCopy);
  AProduct.Add('sdxBtnYesToAll', @sdxBtnYesToAll);
  AProduct.Add('sdxBtnRestoreDefaults', @sdxBtnRestoreDefaults);
  AProduct.Add('sdxBtnRestoreOriginal', @sdxBtnRestoreOriginal);
  AProduct.Add('sdxBtnTitleProperties', @sdxBtnTitleProperties);
  AProduct.Add('sdxBtnFootnoteProperties', @sdxBtnFootnoteProperties);
  AProduct.Add('sdxBtnProperties', @sdxBtnProperties);
  AProduct.Add('sdxBtnNetwork', @sdxBtnNetwork);
  AProduct.Add('sdxBtnBrowse', @sdxBtnBrowse);
  AProduct.Add('sdxBtnPageSetup', @sdxBtnPageSetup);
  AProduct.Add('sdxBtnPrintPreview', @sdxBtnPrintPreview);
  AProduct.Add('sdxBtnPreview', @sdxBtnPreview);
  AProduct.Add('sdxBtnPrint', @sdxBtnPrint);
  AProduct.Add('sdxBtnOptions', @sdxBtnOptions);
  AProduct.Add('sdxBtnStyleOptions', @sdxBtnStyleOptions);
  AProduct.Add('sdxBtnDefinePrintStyles', @sdxBtnDefinePrintStyles);
  AProduct.Add('sdxBtnPrintStyles', @sdxBtnPrintStyles);
  AProduct.Add('sdxBtnBackground', @sdxBtnBackground);
  AProduct.Add('sdxBtnShowToolBar', @sdxBtnShowToolBar);
  AProduct.Add('sdxBtnDesign', @sdxBtnDesign);
  AProduct.Add('sdxBtnMoveUp', @sdxBtnMoveUp);
  AProduct.Add('sdxBtnMoveDown', @sdxBtnMoveDown);
  AProduct.Add('sdxBtnMoreColors', @sdxBtnMoreColors);
  AProduct.Add('sdxBtnFillEffects', @sdxBtnFillEffects);
  AProduct.Add('sdxBtnNoFill', @sdxBtnNoFill);
  AProduct.Add('sdxBtnAutomatic', @sdxBtnAutomatic);
  AProduct.Add('sdxBtnNone', @sdxBtnNone);
  AProduct.Add('sdxBtnOtherTexture', @sdxBtnOtherTexture);
  AProduct.Add('sdxBtnInvertColors', @sdxBtnInvertColors);
  AProduct.Add('sdxBtnSelectPicture', @sdxBtnSelectPicture);
  AProduct.Add('sdxEditReports', @sdxEditReports);
  AProduct.Add('sdxComposition', @sdxComposition);
  AProduct.Add('sdxReportTitleDlgCaption', @sdxReportTitleDlgCaption);
  AProduct.Add('sdxReportFootnotesDlgCaption', @sdxReportFootnotesDlgCaption);
  AProduct.Add('sdxMode', @sdxMode);
  AProduct.Add('sdxText', @sdxText);
  AProduct.Add('sdxProperties', @sdxProperties);
  AProduct.Add('sdxAdjustOnScale', @sdxAdjustOnScale);
  AProduct.Add('sdxTitleModeNone', @sdxTitleModeNone);
  AProduct.Add('sdxTitleModeOnEveryTopPage', @sdxTitleModeOnEveryTopPage);
  AProduct.Add('sdxTitleModeOnFirstPage', @sdxTitleModeOnFirstPage);
  AProduct.Add('sdxFootnotesModeNone', @sdxFootnotesModeNone);
  AProduct.Add('sdxFootnotesModeOnEveryBottomPage', @sdxFootnotesModeOnEveryBottomPage);
  AProduct.Add('sdxFootnotesModeOnLastPage', @sdxFootnotesModeOnLastPage);
  AProduct.Add('sdxEditDescription', @sdxEditDescription);
  AProduct.Add('sdxRename', @sdxRename);
  AProduct.Add('sdxSelectAll', @sdxSelectAll);
  AProduct.Add('sdxAddReport', @sdxAddReport);
  AProduct.Add('sdxAddAndDesignReport', @sdxAddAndDesignReport);
  AProduct.Add('sdxNewCompositionCaption', @sdxNewCompositionCaption);
  AProduct.Add('sdxName', @sdxName);
  AProduct.Add('sdxCaption', @sdxCaption);
  AProduct.Add('sdxAvailableSources', @sdxAvailableSources);
  AProduct.Add('sdxOnlyComponentsInActiveForm', @sdxOnlyComponentsInActiveForm);
  AProduct.Add('sdxOnlyComponentsWithoutLinks', @sdxOnlyComponentsWithoutLinks);
  AProduct.Add('sdxItemName', @sdxItemName);
  AProduct.Add('sdxItemDescription', @sdxItemDescription);
  AProduct.Add('sdxConfirmDeleteItem', @sdxConfirmDeleteItem);
  AProduct.Add('sdxAddItemsToComposition', @sdxAddItemsToComposition);
  AProduct.Add('sdxHideAlreadyIncludedItems', @sdxHideAlreadyIncludedItems);
  AProduct.Add('sdxAvailableItems', @sdxAvailableItems);
  AProduct.Add('sdxItems', @sdxItems);
  AProduct.Add('sdxEnable', @sdxEnable);
  AProduct.Add('sdxGroupImages', @sdxGroupImages);
  AProduct.Add('sdxGroupView', @sdxGroupView);
  AProduct.Add('sdxOptions', @sdxOptions);
  AProduct.Add('sdxShow', @sdxShow);
  AProduct.Add('sdxPaintItemsGraphics', @sdxPaintItemsGraphics);
  AProduct.Add('sdxDescription', @sdxDescription);
  AProduct.Add('sdxNewReport', @sdxNewReport);
  AProduct.Add('sdxOnlySelected', @sdxOnlySelected);
  AProduct.Add('sdxExtendedSelect', @sdxExtendedSelect);
  AProduct.Add('sdxIncludeFixed', @sdxIncludeFixed);
  AProduct.Add('sdxFonts', @sdxFonts);
  AProduct.Add('sdxBtnFont', @sdxBtnFont);
  AProduct.Add('sdxBtnEvenFont', @sdxBtnEvenFont);
  AProduct.Add('sdxBtnOddFont', @sdxBtnOddFont);
  AProduct.Add('sdxBtnFixedFont', @sdxBtnFixedFont);
  AProduct.Add('sdxBtnGroupFont', @sdxBtnGroupFont);
  AProduct.Add('sdxBtnChangeFont', @sdxBtnChangeFont);
  AProduct.Add('sdxFont', @sdxFont);
  AProduct.Add('sdxOddFont', @sdxOddFont);
  AProduct.Add('sdxEvenFont', @sdxEvenFont);
  AProduct.Add('sdxPreviewFont', @sdxPreviewFont);
  AProduct.Add('sdxCaptionNodeFont', @sdxCaptionNodeFont);
  AProduct.Add('sdxGroupNodeFont', @sdxGroupNodeFont);
  AProduct.Add('sdxGroupFooterFont', @sdxGroupFooterFont);
  AProduct.Add('sdxHeaderFont', @sdxHeaderFont);
  AProduct.Add('sdxFooterFont', @sdxFooterFont);
  AProduct.Add('sdxBandFont', @sdxBandFont);
  AProduct.Add('sdxTransparent', @sdxTransparent);
  AProduct.Add('sdxFixedTransparent', @sdxFixedTransparent);
  AProduct.Add('sdxCaptionTransparent', @sdxCaptionTransparent);
  AProduct.Add('sdxGroupTransparent', @sdxGroupTransparent);
  AProduct.Add('sdxGraphicAsTextValue', @sdxGraphicAsTextValue);
  AProduct.Add('sdxColors', @sdxColors);
  AProduct.Add('sdxColor', @sdxColor);
  AProduct.Add('sdxOddColor', @sdxOddColor);
  AProduct.Add('sdxEvenColor', @sdxEvenColor);
  AProduct.Add('sdxPreviewColor', @sdxPreviewColor);
  AProduct.Add('sdxBandColor', @sdxBandColor);
  AProduct.Add('sdxLevelCaptionColor', @sdxLevelCaptionColor);
  AProduct.Add('sdxHeaderColor', @sdxHeaderColor);
  AProduct.Add('sdxGroupNodeColor', @sdxGroupNodeColor);
  AProduct.Add('sdxGroupFooterColor', @sdxGroupFooterColor);
  AProduct.Add('sdxFooterColor', @sdxFooterColor);
  AProduct.Add('sdxFixedColor', @sdxFixedColor);
  AProduct.Add('sdxGroupColor', @sdxGroupColor);
  AProduct.Add('sdxCaptionColor', @sdxCaptionColor);
  AProduct.Add('sdxGridLinesColor', @sdxGridLinesColor);
  AProduct.Add('sdxBands', @sdxBands);
  AProduct.Add('sdxLevelCaptions', @sdxLevelCaptions);
  AProduct.Add('sdxHeaders', @sdxHeaders);
  AProduct.Add('sdxFooters', @sdxFooters);
  AProduct.Add('sdxGroupFooters', @sdxGroupFooters);
  AProduct.Add('sdxPreview', @sdxPreview);
  AProduct.Add('sdxPreviewLineCount', @sdxPreviewLineCount);
  AProduct.Add('sdxAutoCalcPreviewLineCount', @sdxAutoCalcPreviewLineCount);
  AProduct.Add('sdxGrid', @sdxGrid);
  AProduct.Add('sdxNodesGrid', @sdxNodesGrid);
  AProduct.Add('sdxGroupFooterGrid', @sdxGroupFooterGrid);
  AProduct.Add('sdxStateImages', @sdxStateImages);
  AProduct.Add('sdxImages', @sdxImages);
  AProduct.Add('sdxTextAlign', @sdxTextAlign);
  AProduct.Add('sdxTextAlignHorz', @sdxTextAlignHorz);
  AProduct.Add('sdxTextAlignVert', @sdxTextAlignVert);
  AProduct.Add('sdxTextAlignLeft', @sdxTextAlignLeft);
  AProduct.Add('sdxTextAlignCenter', @sdxTextAlignCenter);
  AProduct.Add('sdxTextAlignRight', @sdxTextAlignRight);
  AProduct.Add('sdxTextAlignTop', @sdxTextAlignTop);
  AProduct.Add('sdxTextAlignVCenter', @sdxTextAlignVCenter);
  AProduct.Add('sdxTextAlignBottom', @sdxTextAlignBottom);
  AProduct.Add('sdxBorderLines', @sdxBorderLines);
  AProduct.Add('sdxHorzLines', @sdxHorzLines);
  AProduct.Add('sdxVertLines', @sdxVertLines);
  AProduct.Add('sdxFixedHorzLines', @sdxFixedHorzLines);
  AProduct.Add('sdxFixedVertLines', @sdxFixedVertLines);
  AProduct.Add('sdxFlatCheckMarks', @sdxFlatCheckMarks);
  AProduct.Add('sdxCheckMarksAsText', @sdxCheckMarksAsText);
  AProduct.Add('sdxRowAutoHeight', @sdxRowAutoHeight);
  AProduct.Add('sdxEndEllipsis', @sdxEndEllipsis);
  AProduct.Add('sdxDrawBorder', @sdxDrawBorder);
  AProduct.Add('sdxFullExpand', @sdxFullExpand);
  AProduct.Add('sdxBorderColor', @sdxBorderColor);
  AProduct.Add('sdxAutoNodesExpand', @sdxAutoNodesExpand);
  AProduct.Add('sdxExpandLevel', @sdxExpandLevel);
  AProduct.Add('sdxFixedRowOnEveryPage', @sdxFixedRowOnEveryPage);
  AProduct.Add('sdxDrawMode', @sdxDrawMode);
  AProduct.Add('sdxDrawModeStrict', @sdxDrawModeStrict);
  AProduct.Add('sdxDrawModeOddEven', @sdxDrawModeOddEven);
  AProduct.Add('sdxDrawModeChess', @sdxDrawModeChess);
  AProduct.Add('sdxDrawModeBorrow', @sdxDrawModeBorrow);
  AProduct.Add('sdx3DEffects', @sdx3DEffects);
  AProduct.Add('sdxUse3DEffects', @sdxUse3DEffects);
  AProduct.Add('sdxSoft3D', @sdxSoft3D);
  AProduct.Add('sdxBehaviors', @sdxBehaviors);
  AProduct.Add('sdxMiscellaneous', @sdxMiscellaneous);
  AProduct.Add('sdxOnEveryPage', @sdxOnEveryPage);
  AProduct.Add('sdxNodeExpanding', @sdxNodeExpanding);
  AProduct.Add('sdxSelection', @sdxSelection);
  AProduct.Add('sdxNodeAutoHeight', @sdxNodeAutoHeight);
  AProduct.Add('sdxTransparentGraphics', @sdxTransparentGraphics);
  AProduct.Add('sdxAutoWidth', @sdxAutoWidth);
  AProduct.Add('sdxDisplayGraphicsAsText', @sdxDisplayGraphicsAsText);
  AProduct.Add('sdxDisplayTrackBarsAsText', @sdxDisplayTrackBarsAsText);
  AProduct.Add('sdxTransparentColumnGraphics', @sdxTransparentColumnGraphics);
  AProduct.Add('sdxBandsOnEveryPage', @sdxBandsOnEveryPage);
  AProduct.Add('sdxHeadersOnEveryPage', @sdxHeadersOnEveryPage);
  AProduct.Add('sdxFootersOnEveryPage', @sdxFootersOnEveryPage);
  AProduct.Add('sdxGraphics', @sdxGraphics);
  AProduct.Add('sdxOutOfResources', @sdxOutOfResources);
  AProduct.Add('sdxFileAlreadyExists', @sdxFileAlreadyExists);
  AProduct.Add('sdxConfirmOverWrite', @sdxConfirmOverWrite);
  AProduct.Add('sdxInvalidFileName', @sdxInvalidFileName);
  AProduct.Add('sdxRequiredFileName', @sdxRequiredFileName);
  AProduct.Add('sdxOutsideMarginsMessage', @sdxOutsideMarginsMessage);
  AProduct.Add('sdxOutsideMarginsMessage2', @sdxOutsideMarginsMessage2);
  AProduct.Add('sdxInvalidMarginsMessage', @sdxInvalidMarginsMessage);
  AProduct.Add('sdxInvalidMargins', @sdxInvalidMargins);
  AProduct.Add('sdxOutsideMargins', @sdxOutsideMargins);
  AProduct.Add('sdxThereAreNowItemsForShow', @sdxThereAreNowItemsForShow);
  AProduct.Add('sdxReportCellClassNotRegistered', @sdxReportCellClassNotRegistered);
  AProduct.Add('sdxPageBackground', @sdxPageBackground);
  AProduct.Add('sdxPenColor', @sdxPenColor);
  AProduct.Add('sdxFontColor', @sdxFontColor);
  AProduct.Add('sdxBrushColor', @sdxBrushColor);
  AProduct.Add('sdxHighLight', @sdxHighLight);
  AProduct.Add('sdxTexture', @sdxTexture);
  AProduct.Add('sdxPattern', @sdxPattern);
  AProduct.Add('sdxPicture', @sdxPicture);
  AProduct.Add('sdxForeground', @sdxForeground);
  AProduct.Add('sdxBackground', @sdxBackground);
  AProduct.Add('sdxSample', @sdxSample);
  AProduct.Add('sdxFEFCaption', @sdxFEFCaption);
  AProduct.Add('sdxPaintMode', @sdxPaintMode);
  AProduct.Add('sdxPaintModeCenter', @sdxPaintModeCenter);
  AProduct.Add('sdxPaintModeStretch', @sdxPaintModeStretch);
  AProduct.Add('sdxPaintModeTile', @sdxPaintModeTile);
  AProduct.Add('sdxPaintModeProportional', @sdxPaintModeProportional);
  AProduct.Add('sdxPatternGray5', @sdxPatternGray5);
  AProduct.Add('sdxPatternGray10', @sdxPatternGray10);
  AProduct.Add('sdxPatternGray20', @sdxPatternGray20);
  AProduct.Add('sdxPatternGray25', @sdxPatternGray25);
  AProduct.Add('sdxPatternGray30', @sdxPatternGray30);
  AProduct.Add('sdxPatternGray40', @sdxPatternGray40);
  AProduct.Add('sdxPatternGray50', @sdxPatternGray50);
  AProduct.Add('sdxPatternGray60', @sdxPatternGray60);
  AProduct.Add('sdxPatternGray70', @sdxPatternGray70);
  AProduct.Add('sdxPatternGray75', @sdxPatternGray75);
  AProduct.Add('sdxPatternGray80', @sdxPatternGray80);
  AProduct.Add('sdxPatternGray90', @sdxPatternGray90);
  AProduct.Add('sdxPatternLightDownwardDiagonal', @sdxPatternLightDownwardDiagonal);
  AProduct.Add('sdxPatternLightUpwardDiagonal', @sdxPatternLightUpwardDiagonal);
  AProduct.Add('sdxPatternDarkDownwardDiagonal', @sdxPatternDarkDownwardDiagonal);
  AProduct.Add('sdxPatternDarkUpwardDiagonal', @sdxPatternDarkUpwardDiagonal);
  AProduct.Add('sdxPatternWideDownwardDiagonal', @sdxPatternWideDownwardDiagonal);
  AProduct.Add('sdxPatternWideUpwardDiagonal', @sdxPatternWideUpwardDiagonal);
  AProduct.Add('sdxPatternLightVertical', @sdxPatternLightVertical);
  AProduct.Add('sdxPatternLightHorizontal', @sdxPatternLightHorizontal);
  AProduct.Add('sdxPatternNarrowVertical', @sdxPatternNarrowVertical);
  AProduct.Add('sdxPatternNarrowHorizontal', @sdxPatternNarrowHorizontal);
  AProduct.Add('sdxPatternDarkVertical', @sdxPatternDarkVertical);
  AProduct.Add('sdxPatternDarkHorizontal', @sdxPatternDarkHorizontal);
  AProduct.Add('sdxPatternDashedDownward', @sdxPatternDashedDownward);
  AProduct.Add('sdxPatternDashedUpward', @sdxPatternDashedUpward);
  AProduct.Add('sdxPatternDashedVertical', @sdxPatternDashedVertical);
  AProduct.Add('sdxPatternDashedHorizontal', @sdxPatternDashedHorizontal);
  AProduct.Add('sdxPatternSmallConfetti', @sdxPatternSmallConfetti);
  AProduct.Add('sdxPatternLargeConfetti', @sdxPatternLargeConfetti);
  AProduct.Add('sdxPatternZigZag', @sdxPatternZigZag);
  AProduct.Add('sdxPatternWave', @sdxPatternWave);
  AProduct.Add('sdxPatternDiagonalBrick', @sdxPatternDiagonalBrick);
  AProduct.Add('sdxPatternHorizantalBrick', @sdxPatternHorizantalBrick);
  AProduct.Add('sdxPatternWeave', @sdxPatternWeave);
  AProduct.Add('sdxPatternPlaid', @sdxPatternPlaid);
  AProduct.Add('sdxPatternDivot', @sdxPatternDivot);
  AProduct.Add('sdxPatternDottedGrid', @sdxPatternDottedGrid);
  AProduct.Add('sdxPatternDottedDiamond', @sdxPatternDottedDiamond);
  AProduct.Add('sdxPatternShingle', @sdxPatternShingle);
  AProduct.Add('sdxPatternTrellis', @sdxPatternTrellis);
  AProduct.Add('sdxPatternSphere', @sdxPatternSphere);
  AProduct.Add('sdxPatternSmallGrid', @sdxPatternSmallGrid);
  AProduct.Add('sdxPatternLargeGrid', @sdxPatternLargeGrid);
  AProduct.Add('sdxPatternSmallCheckedBoard', @sdxPatternSmallCheckedBoard);
  AProduct.Add('sdxPatternLargeCheckedBoard', @sdxPatternLargeCheckedBoard);
  AProduct.Add('sdxPatternOutlinedDiamond', @sdxPatternOutlinedDiamond);
  AProduct.Add('sdxPatternSolidDiamond', @sdxPatternSolidDiamond);
  AProduct.Add('sdxTextureNewSprint', @sdxTextureNewSprint);
  AProduct.Add('sdxTextureGreenMarble', @sdxTextureGreenMarble);
  AProduct.Add('sdxTextureBlueTissuePaper', @sdxTextureBlueTissuePaper);
  AProduct.Add('sdxTexturePapyrus', @sdxTexturePapyrus);
  AProduct.Add('sdxTextureWaterDroplets', @sdxTextureWaterDroplets);
  AProduct.Add('sdxTextureCork', @sdxTextureCork);
  AProduct.Add('sdxTextureRecycledPaper', @sdxTextureRecycledPaper);
  AProduct.Add('sdxTextureWhiteMarble', @sdxTextureWhiteMarble);
  AProduct.Add('sdxTexturePinkMarble', @sdxTexturePinkMarble);
  AProduct.Add('sdxTextureCanvas', @sdxTextureCanvas);
  AProduct.Add('sdxTexturePaperBag', @sdxTexturePaperBag);
  AProduct.Add('sdxTextureWalnut', @sdxTextureWalnut);
  AProduct.Add('sdxTextureParchment', @sdxTextureParchment);
  AProduct.Add('sdxTextureBrownMarble', @sdxTextureBrownMarble);
  AProduct.Add('sdxTexturePurpleMesh', @sdxTexturePurpleMesh);
  AProduct.Add('sdxTextureDenim', @sdxTextureDenim);
  AProduct.Add('sdxTextureFishFossil', @sdxTextureFishFossil);
  AProduct.Add('sdxTextureOak', @sdxTextureOak);
  AProduct.Add('sdxTextureStationary', @sdxTextureStationary);
  AProduct.Add('sdxTextureGranite', @sdxTextureGranite);
  AProduct.Add('sdxTextureBouquet', @sdxTextureBouquet);
  AProduct.Add('sdxTextureWonenMat', @sdxTextureWonenMat);
  AProduct.Add('sdxTextureSand', @sdxTextureSand);
  AProduct.Add('sdxTextureMediumWood', @sdxTextureMediumWood);
  AProduct.Add('sdxFSPCaption', @sdxFSPCaption);
  AProduct.Add('sdxWidth', @sdxWidth);
  AProduct.Add('sdxHeight', @sdxHeight);
  AProduct.Add('sdxBrushDlgCaption', @sdxBrushDlgCaption);
  AProduct.Add('sdxStyle', @sdxStyle);
  AProduct.Add('sdxENFNCaption', @sdxENFNCaption);
  AProduct.Add('sdxEnterNewFileName', @sdxEnterNewFileName);
  AProduct.Add('sdxDefinePrintStylesCaption', @sdxDefinePrintStylesCaption);
  AProduct.Add('sdxDefinePrintStylesTitle', @sdxDefinePrintStylesTitle);
  AProduct.Add('sdxDefinePrintStylesWarningDelete', @sdxDefinePrintStylesWarningDelete);
  AProduct.Add('sdxDefinePrintStylesWarningClear', @sdxDefinePrintStylesWarningClear);
  AProduct.Add('sdxClear', @sdxClear);
  AProduct.Add('sdxCustomSize', @sdxCustomSize);
  AProduct.Add('sdxDefaultTray', @sdxDefaultTray);
  AProduct.Add('sdxInvalidPrintDevice', @sdxInvalidPrintDevice);
  AProduct.Add('sdxNotPrinting', @sdxNotPrinting);
  AProduct.Add('sdxPrinting', @sdxPrinting);
  AProduct.Add('sdxDeviceOnPort', @sdxDeviceOnPort);
  AProduct.Add('sdxPrinterIndexError', @sdxPrinterIndexError);
  AProduct.Add('sdxNoDefaultPrintDevice', @sdxNoDefaultPrintDevice);
  AProduct.Add('sdxAutoTextDialogCaption', @sdxAutoTextDialogCaption);
  AProduct.Add('sdxEnterAutoTextEntriesHere', @sdxEnterAutoTextEntriesHere);
  AProduct.Add('sdxPrintDialogCaption', @sdxPrintDialogCaption);
  AProduct.Add('sdxPrintDialogPrinter', @sdxPrintDialogPrinter);
  AProduct.Add('sdxPrintDialogName', @sdxPrintDialogName);
  AProduct.Add('sdxPrintDialogStatus', @sdxPrintDialogStatus);
  AProduct.Add('sdxPrintDialogType', @sdxPrintDialogType);
  AProduct.Add('sdxPrintDialogWhere', @sdxPrintDialogWhere);
  AProduct.Add('sdxPrintDialogComment', @sdxPrintDialogComment);
  AProduct.Add('sdxPrintDialogPrintToFile', @sdxPrintDialogPrintToFile);
  AProduct.Add('sdxPrintDialogPageRange', @sdxPrintDialogPageRange);
  AProduct.Add('sdxPrintDialogCopies', @sdxPrintDialogCopies);
  AProduct.Add('sdxPrintDialogNumberOfPages', @sdxPrintDialogNumberOfPages);
  AProduct.Add('sdxPrintDialogNumberOfCopies', @sdxPrintDialogNumberOfCopies);
  AProduct.Add('sdxPrintDialogCollateCopies', @sdxPrintDialogCollateCopies);
  AProduct.Add('sdxPrintDialogAllPages', @sdxPrintDialogAllPages);
  AProduct.Add('sdxPrintDialogEvenPages', @sdxPrintDialogEvenPages);
  AProduct.Add('sdxPrintDialogOddPages', @sdxPrintDialogOddPages);
  AProduct.Add('sdxPrintDialogPrintStyles', @sdxPrintDialogPrintStyles);
  AProduct.Add('sdxPrintDialogOpenDlgTitle', @sdxPrintDialogOpenDlgTitle);
  AProduct.Add('sdxPrintDialogOpenDlgAllFiles', @sdxPrintDialogOpenDlgAllFiles);
  AProduct.Add('sdxPrintDialogOpenDlgPrinterFiles', @sdxPrintDialogOpenDlgPrinterFiles);
  AProduct.Add('sdxPrintDialogRequiredPageNumbers', @sdxPrintDialogRequiredPageNumbers);
  AProduct.Add('sdxPrintDialogNoPrinters', @sdxPrintDialogNoPrinters);
  AProduct.Add('sdxPrintDialogInPrintingState', @sdxPrintDialogInPrintingState);
  AProduct.Add('sdxPrintDialogPSPaused', @sdxPrintDialogPSPaused);
  AProduct.Add('sdxPrintDialogPSPendingDeletion', @sdxPrintDialogPSPendingDeletion);
  AProduct.Add('sdxPrintDialogPSBusy', @sdxPrintDialogPSBusy);
  AProduct.Add('sdxPrintDialogPSDoorOpen', @sdxPrintDialogPSDoorOpen);
  AProduct.Add('sdxPrintDialogPSError', @sdxPrintDialogPSError);
  AProduct.Add('sdxPrintDialogPSInitializing', @sdxPrintDialogPSInitializing);
  AProduct.Add('sdxPrintDialogPSIOActive', @sdxPrintDialogPSIOActive);
  AProduct.Add('sdxPrintDialogPSManualFeed', @sdxPrintDialogPSManualFeed);
  AProduct.Add('sdxPrintDialogPSNoToner', @sdxPrintDialogPSNoToner);
  AProduct.Add('sdxPrintDialogPSNotAvailable', @sdxPrintDialogPSNotAvailable);
  AProduct.Add('sdxPrintDialogPSOFFLine', @sdxPrintDialogPSOFFLine);
  AProduct.Add('sdxPrintDialogPSOutOfMemory', @sdxPrintDialogPSOutOfMemory);
  AProduct.Add('sdxPrintDialogPSOutBinFull', @sdxPrintDialogPSOutBinFull);
  AProduct.Add('sdxPrintDialogPSPagePunt', @sdxPrintDialogPSPagePunt);
  AProduct.Add('sdxPrintDialogPSPaperJam', @sdxPrintDialogPSPaperJam);
  AProduct.Add('sdxPrintDialogPSPaperOut', @sdxPrintDialogPSPaperOut);
  AProduct.Add('sdxPrintDialogPSPaperProblem', @sdxPrintDialogPSPaperProblem);
  AProduct.Add('sdxPrintDialogPSPrinting', @sdxPrintDialogPSPrinting);
  AProduct.Add('sdxPrintDialogPSProcessing', @sdxPrintDialogPSProcessing);
  AProduct.Add('sdxPrintDialogPSTonerLow', @sdxPrintDialogPSTonerLow);
  AProduct.Add('sdxPrintDialogPSUserIntervention', @sdxPrintDialogPSUserIntervention);
  AProduct.Add('sdxPrintDialogPSWaiting', @sdxPrintDialogPSWaiting);
  AProduct.Add('sdxPrintDialogPSWarningUp', @sdxPrintDialogPSWarningUp);
  AProduct.Add('sdxPrintDialogPSReady', @sdxPrintDialogPSReady);
  AProduct.Add('sdxPrintDialogPSPrintingAndWaiting', @sdxPrintDialogPSPrintingAndWaiting);
  AProduct.Add('sdxLeftMargin', @sdxLeftMargin);
  AProduct.Add('sdxTopMargin', @sdxTopMargin);
  AProduct.Add('sdxRightMargin', @sdxRightMargin);
  AProduct.Add('sdxBottomMargin', @sdxBottomMargin);
  AProduct.Add('sdxGutterMargin', @sdxGutterMargin);
  AProduct.Add('sdxHeaderMargin', @sdxHeaderMargin);
  AProduct.Add('sdxFooterMargin', @sdxFooterMargin);
  AProduct.Add('sdxUnitsInches', @sdxUnitsInches);
  AProduct.Add('sdxUnitsCentimeters', @sdxUnitsCentimeters);
  AProduct.Add('sdxUnitsMillimeters', @sdxUnitsMillimeters);
  AProduct.Add('sdxUnitsPoints', @sdxUnitsPoints);
  AProduct.Add('sdxUnitsPicas', @sdxUnitsPicas);
  AProduct.Add('sdxUnitsDefaultName', @sdxUnitsDefaultName);
  AProduct.Add('sdxUnitsInchesName', @sdxUnitsInchesName);
  AProduct.Add('sdxUnitsCentimetersName', @sdxUnitsCentimetersName);
  AProduct.Add('sdxUnitsMillimetersName', @sdxUnitsMillimetersName);
  AProduct.Add('sdxUnitsPointsName', @sdxUnitsPointsName);
  AProduct.Add('sdxUnitsPicasName', @sdxUnitsPicasName);
  AProduct.Add('sdxPrintPreview', @sdxPrintPreview);
  AProduct.Add('sdxReportDesignerCaption', @sdxReportDesignerCaption);
  AProduct.Add('sdxCompositionDesignerCaption', @sdxCompositionDesignerCaption);
  AProduct.Add('sdxCompositionStartEachItemFromNewPage', @sdxCompositionStartEachItemFromNewPage);
  AProduct.Add('sdxComponentNotSupportedByLink', @sdxComponentNotSupportedByLink);
end;

procedure AddResourceStringsPart2(AProduct: TdxProductResourceStrings);
begin
  AProduct.Add('sdxComponentNotSupported', @sdxComponentNotSupported);
  AProduct.Add('sdxPrintDeviceNotReady', @sdxPrintDeviceNotReady);
  AProduct.Add('sdxUnableToGenerateReport', @sdxUnableToGenerateReport);
  AProduct.Add('sdxPreviewNotRegistered', @sdxPreviewNotRegistered);
  AProduct.Add('sdxComponentNotAssigned', @sdxComponentNotAssigned);
  AProduct.Add('sdxPrintDeviceIsBusy', @sdxPrintDeviceIsBusy);
  AProduct.Add('sdxPrintDeviceError', @sdxPrintDeviceError);
  AProduct.Add('sdxMissingComponent', @sdxMissingComponent);
  AProduct.Add('sdxDataProviderDontPresent', @sdxDataProviderDontPresent);
  AProduct.Add('sdxBuildingReport', @sdxBuildingReport);
  AProduct.Add('sdxPrintingReport', @sdxPrintingReport);
  AProduct.Add('sdxDefinePrintStylesMenuItem', @sdxDefinePrintStylesMenuItem);
  AProduct.Add('sdxAbortPrinting', @sdxAbortPrinting);
  AProduct.Add('sdxStandardStyle', @sdxStandardStyle);
  AProduct.Add('sdxFontStyleBold', @sdxFontStyleBold);
  AProduct.Add('sdxFontStyleItalic', @sdxFontStyleItalic);
  AProduct.Add('sdxFontStyleUnderline', @sdxFontStyleUnderline);
  AProduct.Add('sdxFontStyleStrikeOut', @sdxFontStyleStrikeOut);
  AProduct.Add('sdxPt', @sdxPt);
  AProduct.Add('sdxPagesSuffix', @sdxPagesSuffix);
  AProduct.Add('sdxPageWidth', @sdxPageWidth);
  AProduct.Add('sdxWholePage', @sdxWholePage);
  AProduct.Add('sdxTwoPages', @sdxTwoPages);
  AProduct.Add('sdxFourPages', @sdxFourPages);
  AProduct.Add('sdxWidenToSourceWidth', @sdxWidenToSourceWidth);
  AProduct.Add('sdxMenuBar', @sdxMenuBar);
  AProduct.Add('sdxStandardBar', @sdxStandardBar);
  AProduct.Add('sdxHeaderFooterBar', @sdxHeaderFooterBar);
  AProduct.Add('sdxShortcutMenusBar', @sdxShortcutMenusBar);
  AProduct.Add('sdxAutoTextBar', @sdxAutoTextBar);
  AProduct.Add('sdxMenuFile', @sdxMenuFile);
  AProduct.Add('sdxMenuFileDesign', @sdxMenuFileDesign);
  AProduct.Add('sdxMenuFilePrint', @sdxMenuFilePrint);
  AProduct.Add('sdxMenuFilePrintDialog', @sdxMenuFilePrintDialog);
  AProduct.Add('sdxMenuFilePageSetup', @sdxMenuFilePageSetup);
  AProduct.Add('sdxMenuPrintStyles', @sdxMenuPrintStyles);
  AProduct.Add('sdxMenuFileExit', @sdxMenuFileExit);
  AProduct.Add('sdxMenuExportToPDF', @sdxMenuExportToPDF);
  AProduct.Add('sdxMenuFileOptions', @sdxMenuFileOptions);
  AProduct.Add('sdxMenuEdit', @sdxMenuEdit);
  AProduct.Add('sdxMenuEditCut', @sdxMenuEditCut);
  AProduct.Add('sdxMenuEditCopy', @sdxMenuEditCopy);
  AProduct.Add('sdxMenuEditPaste', @sdxMenuEditPaste);
  AProduct.Add('sdxMenuEditDelete', @sdxMenuEditDelete);
  AProduct.Add('sdxMenuEditFind', @sdxMenuEditFind);
  AProduct.Add('sdxMenuEditFindNext', @sdxMenuEditFindNext);
  AProduct.Add('sdxMenuEditReplace', @sdxMenuEditReplace);
  AProduct.Add('sdxMenuLoad', @sdxMenuLoad);
  AProduct.Add('sdxMenuPreview', @sdxMenuPreview);
  AProduct.Add('sdxMenuInsert', @sdxMenuInsert);
  AProduct.Add('sdxMenuInsertAutoText', @sdxMenuInsertAutoText);
  AProduct.Add('sdxMenuInsertEditAutoTextEntries', @sdxMenuInsertEditAutoTextEntries);
  AProduct.Add('sdxMenuInsertAutoTextEntries', @sdxMenuInsertAutoTextEntries);
  AProduct.Add('sdxMenuInsertAutoTextEntriesSubItem', @sdxMenuInsertAutoTextEntriesSubItem);
  AProduct.Add('sdxMenuInsertPageNumber', @sdxMenuInsertPageNumber);
  AProduct.Add('sdxMenuInsertTotalPages', @sdxMenuInsertTotalPages);
  AProduct.Add('sdxMenuInsertPageOfPages', @sdxMenuInsertPageOfPages);
  AProduct.Add('sdxMenuInsertDateTime', @sdxMenuInsertDateTime);
  AProduct.Add('sdxMenuInsertDate', @sdxMenuInsertDate);
  AProduct.Add('sdxMenuInsertTime', @sdxMenuInsertTime);
  AProduct.Add('sdxMenuInsertUserName', @sdxMenuInsertUserName);
  AProduct.Add('sdxMenuInsertMachineName', @sdxMenuInsertMachineName);
  AProduct.Add('sdxMenuView', @sdxMenuView);
  AProduct.Add('sdxMenuViewMargins', @sdxMenuViewMargins);
  AProduct.Add('sdxMenuViewFlatToolBarButtons', @sdxMenuViewFlatToolBarButtons);
  AProduct.Add('sdxMenuViewLargeToolBarButtons', @sdxMenuViewLargeToolBarButtons);
  AProduct.Add('sdxMenuViewMarginsStatusBar', @sdxMenuViewMarginsStatusBar);
  AProduct.Add('sdxMenuViewPagesStatusBar', @sdxMenuViewPagesStatusBar);
  AProduct.Add('sdxMenuViewToolBars', @sdxMenuViewToolBars);
  AProduct.Add('sdxMenuViewPagesHeaders', @sdxMenuViewPagesHeaders);
  AProduct.Add('sdxMenuViewPagesFooters', @sdxMenuViewPagesFooters);
  AProduct.Add('sdxMenuViewSwitchToLeftPart', @sdxMenuViewSwitchToLeftPart);
  AProduct.Add('sdxMenuViewSwitchToRightPart', @sdxMenuViewSwitchToRightPart);
  AProduct.Add('sdxMenuViewSwitchToCenterPart', @sdxMenuViewSwitchToCenterPart);
  AProduct.Add('sdxMenuViewHFSwitchHeaderFooter', @sdxMenuViewHFSwitchHeaderFooter);
  AProduct.Add('sdxMenuViewSwitchToFooter', @sdxMenuViewSwitchToFooter);
  AProduct.Add('sdxMenuViewSwitchToHeader', @sdxMenuViewSwitchToHeader);
  AProduct.Add('sdxMenuViewHFClose', @sdxMenuViewHFClose);
  AProduct.Add('sdxMenuZoom', @sdxMenuZoom);
  AProduct.Add('sdxMenuZoomPercent100', @sdxMenuZoomPercent100);
  AProduct.Add('sdxMenuZoomPageWidth', @sdxMenuZoomPageWidth);
  AProduct.Add('sdxMenuZoomWholePage', @sdxMenuZoomWholePage);
  AProduct.Add('sdxMenuZoomTwoPages', @sdxMenuZoomTwoPages);
  AProduct.Add('sdxMenuZoomFourPages', @sdxMenuZoomFourPages);
  AProduct.Add('sdxMenuZoomMultiplyPages', @sdxMenuZoomMultiplyPages);
  AProduct.Add('sdxMenuZoomWidenToSourceWidth', @sdxMenuZoomWidenToSourceWidth);
  AProduct.Add('sdxMenuZoomSetup', @sdxMenuZoomSetup);
  AProduct.Add('sdxMenuPages', @sdxMenuPages);
  AProduct.Add('sdxMenuGotoPage', @sdxMenuGotoPage);
  AProduct.Add('sdxMenuGotoPageFirst', @sdxMenuGotoPageFirst);
  AProduct.Add('sdxMenuGotoPagePrev', @sdxMenuGotoPagePrev);
  AProduct.Add('sdxMenuGotoPageNext', @sdxMenuGotoPageNext);
  AProduct.Add('sdxMenuGotoPageLast', @sdxMenuGotoPageLast);
  AProduct.Add('sdxMenuActivePage', @sdxMenuActivePage);
  AProduct.Add('sdxMenuFormat', @sdxMenuFormat);
  AProduct.Add('sdxMenuFormatHeaderAndFooter', @sdxMenuFormatHeaderAndFooter);
  AProduct.Add('sdxMenuFormatAutoTextEntries', @sdxMenuFormatAutoTextEntries);
  AProduct.Add('sdxMenuFormatDateTime', @sdxMenuFormatDateTime);
  AProduct.Add('sdxMenuFormatPageNumbering', @sdxMenuFormatPageNumbering);
  AProduct.Add('sdxMenuFormatPageBackground', @sdxMenuFormatPageBackground);
  AProduct.Add('sdxMenuFormatShrinkToPage', @sdxMenuFormatShrinkToPage);
  AProduct.Add('sdxMenuFormatHFBackground', @sdxMenuFormatHFBackground);
  AProduct.Add('sdxMenuFormatHFClear', @sdxMenuFormatHFClear);
  AProduct.Add('sdxMenuTools', @sdxMenuTools);
  AProduct.Add('sdxMenuToolsCustomize', @sdxMenuToolsCustomize);
  AProduct.Add('sdxMenuToolsOptions', @sdxMenuToolsOptions);
  AProduct.Add('sdxMenuHelp', @sdxMenuHelp);
  AProduct.Add('sdxMenuHelpTopics', @sdxMenuHelpTopics);
  AProduct.Add('sdxMenuHelpAbout', @sdxMenuHelpAbout);
  AProduct.Add('sdxMenuShortcutPreview', @sdxMenuShortcutPreview);
  AProduct.Add('sdxMenuShortcutAutoText', @sdxMenuShortcutAutoText);
  AProduct.Add('sdxMenuBuiltInMenus', @sdxMenuBuiltInMenus);
  AProduct.Add('sdxMenuShortCutMenus', @sdxMenuShortCutMenus);
  AProduct.Add('sdxMenuNewMenu', @sdxMenuNewMenu);
  AProduct.Add('sdxHintFileDesign', @sdxHintFileDesign);
  AProduct.Add('sdxHintFilePrint', @sdxHintFilePrint);
  AProduct.Add('sdxHintFilePrintDialog', @sdxHintFilePrintDialog);
  AProduct.Add('sdxHintFilePageSetup', @sdxHintFilePageSetup);
  AProduct.Add('sdxHintFileExit', @sdxHintFileExit);
  AProduct.Add('sdxHintExportToPDF', @sdxHintExportToPDF);
  AProduct.Add('sdxHintEditFind', @sdxHintEditFind);
  AProduct.Add('sdxHintEditFindNext', @sdxHintEditFindNext);
  AProduct.Add('sdxHintEditReplace', @sdxHintEditReplace);
  AProduct.Add('sdxHintInsertEditAutoTextEntries', @sdxHintInsertEditAutoTextEntries);
  AProduct.Add('sdxHintInsertPageNumber', @sdxHintInsertPageNumber);
  AProduct.Add('sdxHintInsertTotalPages', @sdxHintInsertTotalPages);
  AProduct.Add('sdxHintInsertPageOfPages', @sdxHintInsertPageOfPages);
  AProduct.Add('sdxHintInsertDateTime', @sdxHintInsertDateTime);
  AProduct.Add('sdxHintInsertDate', @sdxHintInsertDate);
  AProduct.Add('sdxHintInsertTime', @sdxHintInsertTime);
  AProduct.Add('sdxHintInsertUserName', @sdxHintInsertUserName);
  AProduct.Add('sdxHintInsertMachineName', @sdxHintInsertMachineName);
  AProduct.Add('sdxHintViewMargins', @sdxHintViewMargins);
  AProduct.Add('sdxHintViewLargeButtons', @sdxHintViewLargeButtons);
  AProduct.Add('sdxHintViewMarginsStatusBar', @sdxHintViewMarginsStatusBar);
  AProduct.Add('sdxHintViewPagesStatusBar', @sdxHintViewPagesStatusBar);
  AProduct.Add('sdxHintViewPagesHeaders', @sdxHintViewPagesHeaders);
  AProduct.Add('sdxHintViewPagesFooters', @sdxHintViewPagesFooters);
  AProduct.Add('sdxHintViewSwitchToLeftPart', @sdxHintViewSwitchToLeftPart);
  AProduct.Add('sdxHintViewSwitchToRightPart', @sdxHintViewSwitchToRightPart);
  AProduct.Add('sdxHintViewSwitchToCenterPart', @sdxHintViewSwitchToCenterPart);
  AProduct.Add('sdxHintViewHFSwitchHeaderFooter', @sdxHintViewHFSwitchHeaderFooter);
  AProduct.Add('sdxHintViewSwitchToHeader', @sdxHintViewSwitchToHeader);
  AProduct.Add('sdxHintViewSwitchToFooter', @sdxHintViewSwitchToFooter);
  AProduct.Add('sdxHintViewHFClose', @sdxHintViewHFClose);
  AProduct.Add('sdxHintViewZoom', @sdxHintViewZoom);
  AProduct.Add('sdxHintZoomPercent100', @sdxHintZoomPercent100);
  AProduct.Add('sdxHintZoomPageWidth', @sdxHintZoomPageWidth);
  AProduct.Add('sdxHintZoomWholePage', @sdxHintZoomWholePage);
  AProduct.Add('sdxHintZoomTwoPages', @sdxHintZoomTwoPages);
  AProduct.Add('sdxHintZoomFourPages', @sdxHintZoomFourPages);
  AProduct.Add('sdxHintZoomMultiplyPages', @sdxHintZoomMultiplyPages);
  AProduct.Add('sdxHintZoomWidenToSourceWidth', @sdxHintZoomWidenToSourceWidth);
  AProduct.Add('sdxHintZoomSetup', @sdxHintZoomSetup);
  AProduct.Add('sdxHintFormatDateTime', @sdxHintFormatDateTime);
  AProduct.Add('sdxHintFormatPageNumbering', @sdxHintFormatPageNumbering);
  AProduct.Add('sdxHintFormatPageBackground', @sdxHintFormatPageBackground);
  AProduct.Add('sdxHintFormatShrinkToPage', @sdxHintFormatShrinkToPage);
  AProduct.Add('sdxHintFormatHFBackground', @sdxHintFormatHFBackground);
  AProduct.Add('sdxHintFormatHFClear', @sdxHintFormatHFClear);
  AProduct.Add('sdxHintGotoPageFirst', @sdxHintGotoPageFirst);
  AProduct.Add('sdxHintGotoPagePrev', @sdxHintGotoPagePrev);
  AProduct.Add('sdxHintGotoPageNext', @sdxHintGotoPageNext);
  AProduct.Add('sdxHintGotoPageLast', @sdxHintGotoPageLast);
  AProduct.Add('sdxHintActivePage', @sdxHintActivePage);
  AProduct.Add('sdxHintToolsCustomize', @sdxHintToolsCustomize);
  AProduct.Add('sdxHintToolsOptions', @sdxHintToolsOptions);
  AProduct.Add('sdxHintHelpTopics', @sdxHintHelpTopics);
  AProduct.Add('sdxHintHelpAbout', @sdxHintHelpAbout);
  AProduct.Add('sdxPopupMenuLargeButtons', @sdxPopupMenuLargeButtons);
  AProduct.Add('sdxPopupMenuFlatButtons', @sdxPopupMenuFlatButtons);
  AProduct.Add('sdxPaperSize', @sdxPaperSize);
  AProduct.Add('sdxStatus', @sdxStatus);
  AProduct.Add('sdxStatusReady', @sdxStatusReady);
  AProduct.Add('sdxStatusPrinting', @sdxStatusPrinting);
  AProduct.Add('sdxStatusGenerateReport', @sdxStatusGenerateReport);
  AProduct.Add('sdxHintDoubleClickForChangePaperSize', @sdxHintDoubleClickForChangePaperSize);
  AProduct.Add('sdxHintDoubleClickForChangeMargins', @sdxHintDoubleClickForChangeMargins);
  AProduct.Add('sdxDTFormatsCaption', @sdxDTFormatsCaption);
  AProduct.Add('sdxDTFormatsAvailableDateFormats', @sdxDTFormatsAvailableDateFormats);
  AProduct.Add('sdxDTFormatsAvailableTimeFormats', @sdxDTFormatsAvailableTimeFormats);
  AProduct.Add('sdxDTFormatsAutoUpdate', @sdxDTFormatsAutoUpdate);
  AProduct.Add('sdxDTFormatsChangeDefaultFormat', @sdxDTFormatsChangeDefaultFormat);
  AProduct.Add('sdxPNFormatsCaption', @sdxPNFormatsCaption);
  AProduct.Add('sdxPageNumbering', @sdxPageNumbering);
  AProduct.Add('sdxPNFormatsNumberFormat', @sdxPNFormatsNumberFormat);
  AProduct.Add('sdxPNFormatsContinueFromPrevious', @sdxPNFormatsContinueFromPrevious);
  AProduct.Add('sdxPNFormatsStartAt', @sdxPNFormatsStartAt);
  AProduct.Add('sdxPNFormatsChangeDefaultFormat', @sdxPNFormatsChangeDefaultFormat);
  AProduct.Add('sdxZoomDlgCaption', @sdxZoomDlgCaption);
  AProduct.Add('sdxZoomDlgZoomTo', @sdxZoomDlgZoomTo);
  AProduct.Add('sdxZoomDlgPageWidth', @sdxZoomDlgPageWidth);
  AProduct.Add('sdxZoomDlgWholePage', @sdxZoomDlgWholePage);
  AProduct.Add('sdxZoomDlgTwoPages', @sdxZoomDlgTwoPages);
  AProduct.Add('sdxZoomDlgFourPages', @sdxZoomDlgFourPages);
  AProduct.Add('sdxZoomDlgManyPages', @sdxZoomDlgManyPages);
  AProduct.Add('sdxZoomDlgPercent', @sdxZoomDlgPercent);
  AProduct.Add('sdxZoomDlgPreview', @sdxZoomDlgPreview);
  AProduct.Add('sdxZoomDlgFontPreview', @sdxZoomDlgFontPreview);
  AProduct.Add('sdxZoomDlgFontPreviewString', @sdxZoomDlgFontPreviewString);
  AProduct.Add('sdxPages', @sdxPages);
  AProduct.Add('sdxCancel', @sdxCancel);
  AProduct.Add('sdxPreferenceDlgCaption', @sdxPreferenceDlgCaption);
  AProduct.Add('sdxPreferenceDlgTab1', @sdxPreferenceDlgTab1);
  AProduct.Add('sdxPreferenceDlgTab2', @sdxPreferenceDlgTab2);
  AProduct.Add('sdxPreferenceDlgTab3', @sdxPreferenceDlgTab3);
  AProduct.Add('sdxPreferenceDlgTab4', @sdxPreferenceDlgTab4);
  AProduct.Add('sdxPreferenceDlgTab5', @sdxPreferenceDlgTab5);
  AProduct.Add('sdxPreferenceDlgTab6', @sdxPreferenceDlgTab6);
  AProduct.Add('sdxPreferenceDlgTab7', @sdxPreferenceDlgTab7);
  AProduct.Add('sdxPreferenceDlgTab8', @sdxPreferenceDlgTab8);
  AProduct.Add('sdxPreferenceDlgTab9', @sdxPreferenceDlgTab9);
  AProduct.Add('sdxPreferenceDlgTab10', @sdxPreferenceDlgTab10);
  AProduct.Add('sdxPreferenceDlgShow', @sdxPreferenceDlgShow);
  AProduct.Add('sdxPreferenceDlgMargins', @sdxPreferenceDlgMargins);
  AProduct.Add('sdxPreferenceDlgMarginsHints', @sdxPreferenceDlgMarginsHints);
  AProduct.Add('sdxPreferenceDlgMargingWhileDragging', @sdxPreferenceDlgMargingWhileDragging);
  AProduct.Add('sdxPreferenceDlgLargeBtns', @sdxPreferenceDlgLargeBtns);
  AProduct.Add('sdxPreferenceDlgFlatBtns', @sdxPreferenceDlgFlatBtns);
  AProduct.Add('sdxPreferenceDlgMarginsColor', @sdxPreferenceDlgMarginsColor);
  AProduct.Add('sdxPreferenceDlgMeasurementUnits', @sdxPreferenceDlgMeasurementUnits);
  AProduct.Add('sdxPreferenceDlgSaveForRunTimeToo', @sdxPreferenceDlgSaveForRunTimeToo);
  AProduct.Add('sdxPreferenceDlgZoomScroll', @sdxPreferenceDlgZoomScroll);
  AProduct.Add('sdxPreferenceDlgZoomStep', @sdxPreferenceDlgZoomStep);
  AProduct.Add('sdxCloneStyleCaptionPrefix', @sdxCloneStyleCaptionPrefix);
  AProduct.Add('sdxInvalideStyleCaption', @sdxInvalideStyleCaption);
  AProduct.Add('sdxHintMoreHFFunctions', @sdxHintMoreHFFunctions);
  AProduct.Add('sdxPageSetupCaption', @sdxPageSetupCaption);
  AProduct.Add('sdxStyleName', @sdxStyleName);
  AProduct.Add('sdxPage', @sdxPage);
  AProduct.Add('sdxMargins', @sdxMargins);
  AProduct.Add('sdxHeaderFooter', @sdxHeaderFooter);
  AProduct.Add('sdxScaling', @sdxScaling);
  AProduct.Add('sdxScaleTo', @sdxScaleTo);
  AProduct.Add('sdxAutomatic', @sdxAutomatic);
  AProduct.Add('sdxFitToPageHorizontally', @sdxFitToPageHorizontally);
  AProduct.Add('sdxFitToPageVertically', @sdxFitToPageVertically);
  AProduct.Add('sdxPaper', @sdxPaper);
  AProduct.Add('sdxPaperType', @sdxPaperType);
  AProduct.Add('sdxPaperDimension', @sdxPaperDimension);
  AProduct.Add('sdxPaperWidth', @sdxPaperWidth);
  AProduct.Add('sdxPaperHeight', @sdxPaperHeight);
  AProduct.Add('sdxPaperSource', @sdxPaperSource);
  AProduct.Add('sdxOrientation', @sdxOrientation);
  AProduct.Add('sdxPortrait', @sdxPortrait);
  AProduct.Add('sdxLandscape', @sdxLandscape);
  AProduct.Add('sdxAutoOrientation', @sdxAutoOrientation);
  AProduct.Add('sdxPrintOrder', @sdxPrintOrder);
  AProduct.Add('sdxDownThenOver', @sdxDownThenOver);
  AProduct.Add('sdxOverThenDown', @sdxOverThenDown);
  AProduct.Add('sdxShading', @sdxShading);
  AProduct.Add('sdxPrintUsingGrayShading', @sdxPrintUsingGrayShading);
  AProduct.Add('sdxCenterOnPage', @sdxCenterOnPage);
  AProduct.Add('sdxHorizontally', @sdxHorizontally);
  AProduct.Add('sdxVertically', @sdxVertically);
  AProduct.Add('sdxHeader', @sdxHeader);
  AProduct.Add('sdxBtnHeaderFont', @sdxBtnHeaderFont);
  AProduct.Add('sdxBtnHeaderBackground', @sdxBtnHeaderBackground);
  AProduct.Add('sdxFooter', @sdxFooter);
  AProduct.Add('sdxBtnFooterFont', @sdxBtnFooterFont);
  AProduct.Add('sdxBtnFooterBackground', @sdxBtnFooterBackground);
  AProduct.Add('sdxTop', @sdxTop);
  AProduct.Add('sdxLeft', @sdxLeft);
  AProduct.Add('sdxRight', @sdxRight);
  AProduct.Add('sdxBottom', @sdxBottom);
  AProduct.Add('sdxHeader2', @sdxHeader2);
  AProduct.Add('sdxFooter2', @sdxFooter2);
  AProduct.Add('sdxAlignment', @sdxAlignment);
  AProduct.Add('sdxVertAlignment', @sdxVertAlignment);
  AProduct.Add('sdxReverseOnEvenPages', @sdxReverseOnEvenPages);
  AProduct.Add('sdxAdjustTo', @sdxAdjustTo);
  AProduct.Add('sdxFitTo', @sdxFitTo);
  AProduct.Add('sdxPercentOfNormalSize', @sdxPercentOfNormalSize);
  AProduct.Add('sdxPagesWideBy', @sdxPagesWideBy);
  AProduct.Add('sdxTall', @sdxTall);
  AProduct.Add('sdxOf', @sdxOf);
  AProduct.Add('sdxLastPrinted', @sdxLastPrinted);
  AProduct.Add('sdxFileName', @sdxFileName);
  AProduct.Add('sdxFileNameAndPath', @sdxFileNameAndPath);
  AProduct.Add('sdxPrintedBy', @sdxPrintedBy);
  AProduct.Add('sdxPrintedOn', @sdxPrintedOn);
  AProduct.Add('sdxCreatedBy', @sdxCreatedBy);
  AProduct.Add('sdxCreatedOn', @sdxCreatedOn);
  AProduct.Add('sdxConfidential', @sdxConfidential);
  AProduct.Add('sdxHFFunctionNameUnknown', @sdxHFFunctionNameUnknown);
  AProduct.Add('sdxHFFunctionNamePageNumber', @sdxHFFunctionNamePageNumber);
  AProduct.Add('sdxHFFunctionNameTotalPages', @sdxHFFunctionNameTotalPages);
  AProduct.Add('sdxHFFunctionNamePageOfPages', @sdxHFFunctionNamePageOfPages);
  AProduct.Add('sdxHFFunctionNameDateTime', @sdxHFFunctionNameDateTime);
  AProduct.Add('sdxHFFunctionNameImage', @sdxHFFunctionNameImage);
  AProduct.Add('sdxHFFunctionNameDate', @sdxHFFunctionNameDate);
  AProduct.Add('sdxHFFunctionNameTime', @sdxHFFunctionNameTime);
  AProduct.Add('sdxHFFunctionNameUserName', @sdxHFFunctionNameUserName);
  AProduct.Add('sdxHFFunctionNameMachineName', @sdxHFFunctionNameMachineName);
  AProduct.Add('sdxHFFunctionHintPageNumber', @sdxHFFunctionHintPageNumber);
  AProduct.Add('sdxHFFunctionHintTotalPages', @sdxHFFunctionHintTotalPages);
  AProduct.Add('sdxHFFunctionHintPageOfPages', @sdxHFFunctionHintPageOfPages);
  AProduct.Add('sdxHFFunctionHintDateTime', @sdxHFFunctionHintDateTime);
  AProduct.Add('sdxHFFunctionHintImage', @sdxHFFunctionHintImage);
  AProduct.Add('sdxHFFunctionHintDate', @sdxHFFunctionHintDate);
  AProduct.Add('sdxHFFunctionHintTime', @sdxHFFunctionHintTime);
  AProduct.Add('sdxHFFunctionHintUserName', @sdxHFFunctionHintUserName);
  AProduct.Add('sdxHFFunctionHintMachineName', @sdxHFFunctionHintMachineName);
  AProduct.Add('sdxHFFunctionTemplatePageNumber', @sdxHFFunctionTemplatePageNumber);
  AProduct.Add('sdxHFFunctionTemplateTotalPages', @sdxHFFunctionTemplateTotalPages);
  AProduct.Add('sdxHFFunctionTemplatePageOfPages', @sdxHFFunctionTemplatePageOfPages);
  AProduct.Add('sdxHFFunctionTemplateDateTime', @sdxHFFunctionTemplateDateTime);
  AProduct.Add('sdxHFFunctionTemplateImage', @sdxHFFunctionTemplateImage);
  AProduct.Add('sdxHFFunctionTemplateDate', @sdxHFFunctionTemplateDate);
  AProduct.Add('sdxHFFunctionTemplateTime', @sdxHFFunctionTemplateTime);
  AProduct.Add('sdxHFFunctionTemplateUserName', @sdxHFFunctionTemplateUserName);
  AProduct.Add('sdxHFFunctionTemplateMachineName', @sdxHFFunctionTemplateMachineName);
  AProduct.Add('sdxJanuary', @sdxJanuary);
  AProduct.Add('sdxFebruary', @sdxFebruary);
  AProduct.Add('sdxMarch', @sdxMarch);
  AProduct.Add('sdxApril', @sdxApril);
  AProduct.Add('sdxMay', @sdxMay);
  AProduct.Add('sdxJune', @sdxJune);
  AProduct.Add('sdxJuly', @sdxJuly);
  AProduct.Add('sdxAugust', @sdxAugust);
  AProduct.Add('sdxSeptember', @sdxSeptember);
  AProduct.Add('sdxOctober', @sdxOctober);
  AProduct.Add('sdxNovember', @sdxNovember);
  AProduct.Add('sdxDecember', @sdxDecember);
  AProduct.Add('sdxEast', @sdxEast);
  AProduct.Add('sdxWest', @sdxWest);
  AProduct.Add('sdxSouth', @sdxSouth);
  AProduct.Add('sdxNorth', @sdxNorth);
  AProduct.Add('sdxTotal', @sdxTotal);
  AProduct.Add('sdxPlan', @sdxPlan);
  AProduct.Add('sdxSwimmingPool', @sdxSwimmingPool);
  AProduct.Add('sdxAdministration', @sdxAdministration);
  AProduct.Add('sdxPark', @sdxPark);
  AProduct.Add('sdxCarParking', @sdxCarParking);
  AProduct.Add('sdxCorporateHeadquarters', @sdxCorporateHeadquarters);
  AProduct.Add('sdxSalesAndMarketing', @sdxSalesAndMarketing);
  AProduct.Add('sdxEngineering', @sdxEngineering);
  AProduct.Add('sdxFieldOfficeCanada', @sdxFieldOfficeCanada);
  AProduct.Add('sdxOrderNoCaption', @sdxOrderNoCaption);
  AProduct.Add('sdxNameCaption', @sdxNameCaption);
  AProduct.Add('sdxCountCaption', @sdxCountCaption);
  AProduct.Add('sdxCompanyCaption', @sdxCompanyCaption);
  AProduct.Add('sdxAddressCaption', @sdxAddressCaption);
  AProduct.Add('sdxPriceCaption', @sdxPriceCaption);
  AProduct.Add('sdxCashCaption', @sdxCashCaption);
  AProduct.Add('sdxName1', @sdxName1);
  AProduct.Add('sdxName2', @sdxName2);
  AProduct.Add('sdxCompany1', @sdxCompany1);
  AProduct.Add('sdxCompany2', @sdxCompany2);
  AProduct.Add('sdxAddress1', @sdxAddress1);
  AProduct.Add('sdxAddress2', @sdxAddress2);
  AProduct.Add('sdxCountIs', @sdxCountIs);
  AProduct.Add('sdxRegular', @sdxRegular);
  AProduct.Add('sdxIrregular', @sdxIrregular);
  AProduct.Add('sdxTLBand', @sdxTLBand);
  AProduct.Add('sdxTLColumnName', @sdxTLColumnName);
  AProduct.Add('sdxTLColumnAxisymmetric', @sdxTLColumnAxisymmetric);
  AProduct.Add('sdxTLColumnItemShape', @sdxTLColumnItemShape);
  AProduct.Add('sdxItemShapeAsText', @sdxItemShapeAsText);
  AProduct.Add('sdxItem1Name', @sdxItem1Name);
  AProduct.Add('sdxItem2Name', @sdxItem2Name);
  AProduct.Add('sdxItem3Name', @sdxItem3Name);
  AProduct.Add('sdxItem4Name', @sdxItem4Name);
  AProduct.Add('sdxItem5Name', @sdxItem5Name);
  AProduct.Add('sdxItem1Description', @sdxItem1Description);
  AProduct.Add('sdxItem2Description', @sdxItem2Description);
  AProduct.Add('sdxItem3Description', @sdxItem3Description);
  AProduct.Add('sdxItem4Description', @sdxItem4Description);
  AProduct.Add('sdxItem5Description', @sdxItem5Description);
  AProduct.Add('sdxItem6Description', @sdxItem6Description);
  AProduct.Add('sdxItem7Description', @sdxItem7Description);
  AProduct.Add('sdxPatternIsNotRegistered', @sdxPatternIsNotRegistered);
  AProduct.Add('sdxSolidEdgePattern', @sdxSolidEdgePattern);
  AProduct.Add('sdxThinSolidEdgePattern', @sdxThinSolidEdgePattern);
  AProduct.Add('sdxMediumSolidEdgePattern', @sdxMediumSolidEdgePattern);
  AProduct.Add('sdxThickSolidEdgePattern', @sdxThickSolidEdgePattern);
  AProduct.Add('sdxDottedEdgePattern', @sdxDottedEdgePattern);
  AProduct.Add('sdxDashedEdgePattern', @sdxDashedEdgePattern);
  AProduct.Add('sdxDashDotDotEdgePattern', @sdxDashDotDotEdgePattern);
  AProduct.Add('sdxDashDotEdgePattern', @sdxDashDotEdgePattern);
  AProduct.Add('sdxSlantedDashDotEdgePattern', @sdxSlantedDashDotEdgePattern);
  AProduct.Add('sdxMediumDashDotDotEdgePattern', @sdxMediumDashDotDotEdgePattern);
  AProduct.Add('sdxHairEdgePattern', @sdxHairEdgePattern);
  AProduct.Add('sdxMediumDashDotEdgePattern', @sdxMediumDashDotEdgePattern);
  AProduct.Add('sdxMediumDashedEdgePattern', @sdxMediumDashedEdgePattern);
  AProduct.Add('sdxDoubleLineEdgePattern', @sdxDoubleLineEdgePattern);
  AProduct.Add('sdxSolidFillPattern', @sdxSolidFillPattern);
  AProduct.Add('sdxGray75FillPattern', @sdxGray75FillPattern);
  AProduct.Add('sdxGray50FillPattern', @sdxGray50FillPattern);
  AProduct.Add('sdxGray25FillPattern', @sdxGray25FillPattern);
  AProduct.Add('sdxGray125FillPattern', @sdxGray125FillPattern);
  AProduct.Add('sdxGray625FillPattern', @sdxGray625FillPattern);
  AProduct.Add('sdxHorizontalStripeFillPattern', @sdxHorizontalStripeFillPattern);
  AProduct.Add('sdxVerticalStripeFillPattern', @sdxVerticalStripeFillPattern);
  AProduct.Add('sdxReverseDiagonalStripeFillPattern', @sdxReverseDiagonalStripeFillPattern);
  AProduct.Add('sdxDiagonalStripeFillPattern', @sdxDiagonalStripeFillPattern);
  AProduct.Add('sdxDiagonalCrossHatchFillPattern', @sdxDiagonalCrossHatchFillPattern);
  AProduct.Add('sdxThickCrossHatchFillPattern', @sdxThickCrossHatchFillPattern);
  AProduct.Add('sdxThinHorizontalStripeFillPattern', @sdxThinHorizontalStripeFillPattern);
  AProduct.Add('sdxThinVerticalStripeFillPattern', @sdxThinVerticalStripeFillPattern);
  AProduct.Add('sdxThinReverseDiagonalStripeFillPattern', @sdxThinReverseDiagonalStripeFillPattern);
  AProduct.Add('sdxThinDiagonalStripeFillPattern', @sdxThinDiagonalStripeFillPattern);
  AProduct.Add('sdxThinHorizontalCrossHatchFillPattern', @sdxThinHorizontalCrossHatchFillPattern);
  AProduct.Add('sdxThinDiagonalCrossHatchFillPattern', @sdxThinDiagonalCrossHatchFillPattern);
  AProduct.Add('sdxShowRowAndColumnHeadings', @sdxShowRowAndColumnHeadings);
  AProduct.Add('sdxShowGridLines', @sdxShowGridLines);
  AProduct.Add('sdxSuppressSourceFormats', @sdxSuppressSourceFormats);
  AProduct.Add('sdxRepeatHeaderRowAtTop', @sdxRepeatHeaderRowAtTop);
  AProduct.Add('sdxDataToPrintDoesNotExist', @sdxDataToPrintDoesNotExist);
  AProduct.Add('sdxJanuaryShort', @sdxJanuaryShort);
  AProduct.Add('sdxFebruaryShort', @sdxFebruaryShort);
  AProduct.Add('sdxMarchShort', @sdxMarchShort);
  AProduct.Add('sdxAprilShort', @sdxAprilShort);
  AProduct.Add('sdxMayShort', @sdxMayShort);
  AProduct.Add('sdxJuneShort', @sdxJuneShort);
  AProduct.Add('sdxJulyShort', @sdxJulyShort);
  AProduct.Add('sdxAugustShort', @sdxAugustShort);
  AProduct.Add('sdxSeptemberShort', @sdxSeptemberShort);
  AProduct.Add('sdxOctoberShort', @sdxOctoberShort);
  AProduct.Add('sdxNovemberShort', @sdxNovemberShort);
  AProduct.Add('sdxDecemberShort', @sdxDecemberShort);
  AProduct.Add('sdxTechnicalDepartment', @sdxTechnicalDepartment);
  AProduct.Add('sdxSoftwareDepartment', @sdxSoftwareDepartment);
  AProduct.Add('sdxSystemProgrammers', @sdxSystemProgrammers);
  AProduct.Add('sdxEndUserProgrammers', @sdxEndUserProgrammers);
  AProduct.Add('sdxBetaTesters', @sdxBetaTesters);
  AProduct.Add('sdxHumanResourceDepartment', @sdxHumanResourceDepartment);
  AProduct.Add('sdxTreeLines', @sdxTreeLines);
  AProduct.Add('sdxTreeLinesColor', @sdxTreeLinesColor);
  AProduct.Add('sdxExpandButtons', @sdxExpandButtons);
  AProduct.Add('sdxCheckMarks', @sdxCheckMarks);
  AProduct.Add('sdxTreeEffects', @sdxTreeEffects);
  AProduct.Add('sdxAppearance', @sdxAppearance);
  AProduct.Add('sdxCarLevelCaption', @sdxCarLevelCaption);
  AProduct.Add('sdxManufacturerBandCaption', @sdxManufacturerBandCaption);
  AProduct.Add('sdxModelBandCaption', @sdxModelBandCaption);
  AProduct.Add('sdxManufacturerNameColumnCaption', @sdxManufacturerNameColumnCaption);
  AProduct.Add('sdxManufacturerLogoColumnCaption', @sdxManufacturerLogoColumnCaption);
  AProduct.Add('sdxManufacturerCountryColumnCaption', @sdxManufacturerCountryColumnCaption);
  AProduct.Add('sdxCarModelColumnCaption', @sdxCarModelColumnCaption);
  AProduct.Add('sdxCarIsSUVColumnCaption', @sdxCarIsSUVColumnCaption);
  AProduct.Add('sdxCarPhotoColumnCaption', @sdxCarPhotoColumnCaption);
  AProduct.Add('sdxCarManufacturerName1', @sdxCarManufacturerName1);
  AProduct.Add('sdxCarManufacturerName2', @sdxCarManufacturerName2);
  AProduct.Add('sdxCarManufacturerName3', @sdxCarManufacturerName3);
  AProduct.Add('sdxCarManufacturerName4', @sdxCarManufacturerName4);
  AProduct.Add('sdxCarManufacturerCountry1', @sdxCarManufacturerCountry1);
  AProduct.Add('sdxCarManufacturerCountry2', @sdxCarManufacturerCountry2);
  AProduct.Add('sdxCarManufacturerCountry3', @sdxCarManufacturerCountry3);
  AProduct.Add('sdxCarManufacturerCountry4', @sdxCarManufacturerCountry4);
  AProduct.Add('sdxCarModel1', @sdxCarModel1);
  AProduct.Add('sdxCarModel2', @sdxCarModel2);
  AProduct.Add('sdxCarModel3', @sdxCarModel3);
  AProduct.Add('sdxCarModel4', @sdxCarModel4);
  AProduct.Add('sdxTrue', @sdxTrue);
  AProduct.Add('sdxFalse', @sdxFalse);
  AProduct.Add('sdxAuto', @sdxAuto);
  AProduct.Add('sdxCustom', @sdxCustom);
  AProduct.Add('sdxEnv', @sdxEnv);
  AProduct.Add('sdxLookAndFeelFlat', @sdxLookAndFeelFlat);
  AProduct.Add('sdxLookAndFeelStandard', @sdxLookAndFeelStandard);
  AProduct.Add('sdxLookAndFeelUltraFlat', @sdxLookAndFeelUltraFlat);
  AProduct.Add('sdxViewTab', @sdxViewTab);
  AProduct.Add('sdxBehaviorsTab', @sdxBehaviorsTab);
  AProduct.Add('sdxPreviewTab', @sdxPreviewTab);
  AProduct.Add('sdxCardsTab', @sdxCardsTab);
  AProduct.Add('sdxFormatting', @sdxFormatting);
  AProduct.Add('sdxLookAndFeel', @sdxLookAndFeel);
  AProduct.Add('sdxLevelCaption', @sdxLevelCaption);
  AProduct.Add('sdxFilterBar', @sdxFilterBar);
  AProduct.Add('sdxRefinements', @sdxRefinements);
  AProduct.Add('sdxProcessSelection', @sdxProcessSelection);
  AProduct.Add('sdxProcessExactSelection', @sdxProcessExactSelection);
  AProduct.Add('sdxExpanding', @sdxExpanding);
  AProduct.Add('sdxGroups', @sdxGroups);
  AProduct.Add('sdxDetails', @sdxDetails);
  AProduct.Add('sdxStartFromActiveDetails', @sdxStartFromActiveDetails);
  AProduct.Add('sdxOnlyActiveDetails', @sdxOnlyActiveDetails);
  AProduct.Add('sdxVisible', @sdxVisible);
  AProduct.Add('sdxPreviewAutoHeight', @sdxPreviewAutoHeight);
  AProduct.Add('sdxPreviewMaxLineCount', @sdxPreviewMaxLineCount);
  AProduct.Add('sdxSizes', @sdxSizes);
  AProduct.Add('sdxKeepSameWidth', @sdxKeepSameWidth);
  AProduct.Add('sdxKeepSameHeight', @sdxKeepSameHeight);
  AProduct.Add('sdxFraming', @sdxFraming);
  AProduct.Add('sdxSpacing', @sdxSpacing);
  AProduct.Add('sdxShadow', @sdxShadow);
  AProduct.Add('sdxDepth', @sdxDepth);
  AProduct.Add('sdxPosition', @sdxPosition);
  AProduct.Add('sdxPositioning', @sdxPositioning);
  AProduct.Add('sdxHorizontal', @sdxHorizontal);
  AProduct.Add('sdxVertical', @sdxVertical);
  AProduct.Add('sdxSummaryFormat', @sdxSummaryFormat);
  AProduct.Add('sdxCannotUseOnEveryPageMode', @sdxCannotUseOnEveryPageMode);
  AProduct.Add('sdxIncorrectBandHeadersState', @sdxIncorrectBandHeadersState);
  AProduct.Add('sdxIncorrectHeadersState', @sdxIncorrectHeadersState);
  AProduct.Add('sdxIncorrectFootersState', @sdxIncorrectFootersState);
  AProduct.Add('sdxCharts', @sdxCharts);
  AProduct.Add('sdxTPicture', @sdxTPicture);
  AProduct.Add('sdxCopy', @sdxCopy);
  AProduct.Add('sdxSave', @sdxSave);
  AProduct.Add('sdxBaseStyle', @sdxBaseStyle);
  AProduct.Add('sdxCarSpeedCountColumnCaption', @sdxCarSpeedCountColumnCaption);
end;

procedure AddResourceStringsPart3(AProduct: TdxProductResourceStrings);
begin
  AProduct.Add('sdxComponentAlreadyExists', @sdxComponentAlreadyExists);
  AProduct.Add('sdxInvalidComponentName', @sdxInvalidComponentName);
  AProduct.Add('sdxRectangle', @sdxRectangle);
  AProduct.Add('sdxSquare', @sdxSquare);
  AProduct.Add('sdxEllipse', @sdxEllipse);
  AProduct.Add('sdxCircle', @sdxCircle);
  AProduct.Add('sdxRoundRect', @sdxRoundRect);
  AProduct.Add('sdxRoundSquare', @sdxRoundSquare);
  AProduct.Add('sdxHorizontalFillPattern', @sdxHorizontalFillPattern);
  AProduct.Add('sdxVerticalFillPattern', @sdxVerticalFillPattern);
  AProduct.Add('sdxFDiagonalFillPattern', @sdxFDiagonalFillPattern);
  AProduct.Add('sdxBDiagonalFillPattern', @sdxBDiagonalFillPattern);
  AProduct.Add('sdxCrossFillPattern', @sdxCrossFillPattern);
  AProduct.Add('sdxDiagCrossFillPattern', @sdxDiagCrossFillPattern);
  AProduct.Add('sdxCyclicIDReferences', @sdxCyclicIDReferences);
  AProduct.Add('sdxLoadReportDataToFileTitle', @sdxLoadReportDataToFileTitle);
  AProduct.Add('sdxSaveReportDataToFileTitle', @sdxSaveReportDataToFileTitle);
  AProduct.Add('sdxInvalidExternalStorage', @sdxInvalidExternalStorage);
  AProduct.Add('sdxLinkIsNotIncludedInUsesClause', @sdxLinkIsNotIncludedInUsesClause);
  AProduct.Add('sdxInvalidStorageVersion', @sdxInvalidStorageVersion);
  AProduct.Add('sdxPSReportFiles', @sdxPSReportFiles);
  AProduct.Add('sdxReportFileLoadError', @sdxReportFileLoadError);
  AProduct.Add('sdxNone', @sdxNone);
  AProduct.Add('sdxReportDocumentIsCorrupted', @sdxReportDocumentIsCorrupted);
  AProduct.Add('sdxCloseExplorerHint', @sdxCloseExplorerHint);
  AProduct.Add('sdxExplorerCaption', @sdxExplorerCaption);
  AProduct.Add('sdxExplorerRootFolderCaption', @sdxExplorerRootFolderCaption);
  AProduct.Add('sdxNewExplorerFolderItem', @sdxNewExplorerFolderItem);
  AProduct.Add('sdxCopyOfItem', @sdxCopyOfItem);
  AProduct.Add('sdxReportExplorer', @sdxReportExplorer);
  AProduct.Add('sdxDataLoadErrorText', @sdxDataLoadErrorText);
  AProduct.Add('sdxDBBasedExplorerItemDataLoadError', @sdxDBBasedExplorerItemDataLoadError);
  AProduct.Add('sdxFileBasedExplorerItemDataLoadError', @sdxFileBasedExplorerItemDataLoadError);
  AProduct.Add('sdxDeleteNonEmptyFolderMessageText', @sdxDeleteNonEmptyFolderMessageText);
  AProduct.Add('sdxDeleteFolderMessageText', @sdxDeleteFolderMessageText);
  AProduct.Add('sdxDeleteItemMessageText', @sdxDeleteItemMessageText);
  AProduct.Add('sdxCannotRenameFolderText', @sdxCannotRenameFolderText);
  AProduct.Add('sdxCannotRenameItemText', @sdxCannotRenameItemText);
  AProduct.Add('sdxOverwriteFolderMessageText', @sdxOverwriteFolderMessageText);
  AProduct.Add('sdxOverwriteItemMessageText', @sdxOverwriteItemMessageText);
  AProduct.Add('sdxSelectNewRoot', @sdxSelectNewRoot);
  AProduct.Add('sdxInvalidFolderName', @sdxInvalidFolderName);
  AProduct.Add('sdxInvalidReportName', @sdxInvalidReportName);
  AProduct.Add('sdxExplorerBar', @sdxExplorerBar);
  AProduct.Add('sdxMenuFileSave', @sdxMenuFileSave);
  AProduct.Add('sdxMenuFileSaveAs', @sdxMenuFileSaveAs);
  AProduct.Add('sdxMenuFileLoad', @sdxMenuFileLoad);
  AProduct.Add('sdxMenuFileClose', @sdxMenuFileClose);
  AProduct.Add('sdxHintFileSave', @sdxHintFileSave);
  AProduct.Add('sdxHintFileSaveAs', @sdxHintFileSaveAs);
  AProduct.Add('sdxHintFileLoad', @sdxHintFileLoad);
  AProduct.Add('sdxHintFileClose', @sdxHintFileClose);
  AProduct.Add('sdxMenuExplorer', @sdxMenuExplorer);
  AProduct.Add('sdxMenuExplorerCreateFolder', @sdxMenuExplorerCreateFolder);
  AProduct.Add('sdxMenuExplorerDelete', @sdxMenuExplorerDelete);
  AProduct.Add('sdxMenuExplorerRename', @sdxMenuExplorerRename);
  AProduct.Add('sdxMenuExplorerProperties', @sdxMenuExplorerProperties);
  AProduct.Add('sdxMenuExplorerRefresh', @sdxMenuExplorerRefresh);
  AProduct.Add('sdxMenuExplorerChangeRootPath', @sdxMenuExplorerChangeRootPath);
  AProduct.Add('sdxMenuExplorerSetAsRoot', @sdxMenuExplorerSetAsRoot);
  AProduct.Add('sdxMenuExplorerGoToUpOneLevel', @sdxMenuExplorerGoToUpOneLevel);
  AProduct.Add('sdxHintExplorerCreateFolder', @sdxHintExplorerCreateFolder);
  AProduct.Add('sdxHintExplorerDelete', @sdxHintExplorerDelete);
  AProduct.Add('sdxHintExplorerRename', @sdxHintExplorerRename);
  AProduct.Add('sdxHintExplorerProperties', @sdxHintExplorerProperties);
  AProduct.Add('sdxHintExplorerRefresh', @sdxHintExplorerRefresh);
  AProduct.Add('sdxHintExplorerChangeRootPath', @sdxHintExplorerChangeRootPath);
  AProduct.Add('sdxHintExplorerSetAsRoot', @sdxHintExplorerSetAsRoot);
  AProduct.Add('sdxHintExplorerGoToUpOneLevel', @sdxHintExplorerGoToUpOneLevel);
  AProduct.Add('sdxMenuViewExplorer', @sdxMenuViewExplorer);
  AProduct.Add('sdxHintViewExplorer', @sdxHintViewExplorer);
  AProduct.Add('sdxSummary', @sdxSummary);
  AProduct.Add('sdxCreator', @sdxCreator);
  AProduct.Add('sdxCreationDate', @sdxCreationDate);
  AProduct.Add('sdxMenuViewThumbnails', @sdxMenuViewThumbnails);
  AProduct.Add('sdxMenuThumbnailsLarge', @sdxMenuThumbnailsLarge);
  AProduct.Add('sdxMenuThumbnailsSmall', @sdxMenuThumbnailsSmall);
  AProduct.Add('sdxHintViewThumbnails', @sdxHintViewThumbnails);
  AProduct.Add('sdxHintThumbnailsLarge', @sdxHintThumbnailsLarge);
  AProduct.Add('sdxHintThumbnailsSmall', @sdxHintThumbnailsSmall);
  AProduct.Add('sdxMenuFormatTitle', @sdxMenuFormatTitle);
  AProduct.Add('sdxHintFormatTitle', @sdxHintFormatTitle);
  AProduct.Add('sdxMenuFormatFootnotes', @sdxMenuFormatFootnotes);
  AProduct.Add('sdxHintFormatFootnotes', @sdxHintFormatFootnotes);
  AProduct.Add('sdxHalf', @sdxHalf);
  AProduct.Add('sdxPredefinedFunctions', @sdxPredefinedFunctions);
  AProduct.Add('sdxZoomParameters', @sdxZoomParameters);
  AProduct.Add('sdxWrapData', @sdxWrapData);
  AProduct.Add('sdxMenuShortcutExplorer', @sdxMenuShortcutExplorer);
  AProduct.Add('sdxExplorerToolBar', @sdxExplorerToolBar);
  AProduct.Add('sdxMenuShortcutThumbnails', @sdxMenuShortcutThumbnails);
  AProduct.Add('sdxButtons', @sdxButtons);
  AProduct.Add('sdxBtnHeadersFont', @sdxBtnHeadersFont);
  AProduct.Add('sdxHeadersTransparent', @sdxHeadersTransparent);
  AProduct.Add('sdxHintListViewDesignerMessage', @sdxHintListViewDesignerMessage);
  AProduct.Add('sdxColumnHeaders', @sdxColumnHeaders);
  AProduct.Add('sdxReportGroupNullLookAndFeel', @sdxReportGroupNullLookAndFeel);
  AProduct.Add('sdxReportGroupStandardLookAndFeel', @sdxReportGroupStandardLookAndFeel);
  AProduct.Add('sdxReportGroupOfficeLookAndFeel', @sdxReportGroupOfficeLookAndFeel);
  AProduct.Add('sdxReportGroupWebLookAndFeel', @sdxReportGroupWebLookAndFeel);
  AProduct.Add('sdxLayoutGroupDefaultCaption', @sdxLayoutGroupDefaultCaption);
  AProduct.Add('sdxLayoutItemDefaultCaption', @sdxLayoutItemDefaultCaption);
  AProduct.Add('sdxTabs', @sdxTabs);
  AProduct.Add('sdxUnwrapTabs', @sdxUnwrapTabs);
  AProduct.Add('sdxActiveTabToTop', @sdxActiveTabToTop);
  AProduct.Add('sdxBehaviorsGroups', @sdxBehaviorsGroups);
  AProduct.Add('sdxSkipEmptyGroups', @sdxSkipEmptyGroups);
  AProduct.Add('sdxExpandedGroups', @sdxExpandedGroups);
  AProduct.Add('sdxCarManufacturerName5', @sdxCarManufacturerName5);
  AProduct.Add('sdxCarManufacturerCountry5', @sdxCarManufacturerCountry5);
  AProduct.Add('sdxCarModel5', @sdxCarModel5);
  AProduct.Add('sdxLuxurySedans', @sdxLuxurySedans);
  AProduct.Add('sdxCarManufacturer', @sdxCarManufacturer);
  AProduct.Add('sdxCarModel', @sdxCarModel);
  AProduct.Add('sdxCarEngine', @sdxCarEngine);
  AProduct.Add('sdxCarTransmission', @sdxCarTransmission);
  AProduct.Add('sdxCarTires', @sdxCarTires);
  AProduct.Add('sdx760V12Manufacturer', @sdx760V12Manufacturer);
  AProduct.Add('sdx760V12Model', @sdx760V12Model);
  AProduct.Add('sdx760V12Engine', @sdx760V12Engine);
  AProduct.Add('sdx760V12Transmission', @sdx760V12Transmission);
  AProduct.Add('sdx760V12Tires', @sdx760V12Tires);
  AProduct.Add('sdxBandBackgroundStyle', @sdxBandBackgroundStyle);
  AProduct.Add('sdxBandHeaderStyle', @sdxBandHeaderStyle);
  AProduct.Add('sdxCaptionStyle', @sdxCaptionStyle);
  AProduct.Add('sdxCardCaptionRowStyle', @sdxCardCaptionRowStyle);
  AProduct.Add('sdxCardRowCaptionStyle', @sdxCardRowCaptionStyle);
  AProduct.Add('sdxCategoryStyle', @sdxCategoryStyle);
  AProduct.Add('sdxContentStyle', @sdxContentStyle);
  AProduct.Add('sdxContentEvenStyle', @sdxContentEvenStyle);
  AProduct.Add('sdxContentOddStyle', @sdxContentOddStyle);
  AProduct.Add('sdxFilterBarStyle', @sdxFilterBarStyle);
  AProduct.Add('sdxFooterStyle', @sdxFooterStyle);
  AProduct.Add('sdxFooterRowStyle', @sdxFooterRowStyle);
  AProduct.Add('sdxGroupStyle', @sdxGroupStyle);
  AProduct.Add('sdxHeaderStyle', @sdxHeaderStyle);
  AProduct.Add('sdxIndentStyle', @sdxIndentStyle);
  AProduct.Add('sdxPreviewStyle', @sdxPreviewStyle);
  AProduct.Add('sdxSelectionStyle', @sdxSelectionStyle);
  AProduct.Add('sdxStyles', @sdxStyles);
  AProduct.Add('sdxStyleSheets', @sdxStyleSheets);
  AProduct.Add('sdxBtnTexture', @sdxBtnTexture);
  AProduct.Add('sdxBtnTextureClear', @sdxBtnTextureClear);
  AProduct.Add('sdxBtnColor', @sdxBtnColor);
  AProduct.Add('sdxBtnSaveAs', @sdxBtnSaveAs);
  AProduct.Add('sdxBtnRename', @sdxBtnRename);
  AProduct.Add('sdxLoadBitmapDlgTitle', @sdxLoadBitmapDlgTitle);
  AProduct.Add('sdxDeleteStyleSheet', @sdxDeleteStyleSheet);
  AProduct.Add('sdxUnnamedStyleSheet', @sdxUnnamedStyleSheet);
  AProduct.Add('sdxCreateNewStyleQueryNamePrompt', @sdxCreateNewStyleQueryNamePrompt);
  AProduct.Add('sdxStyleSheetNameAlreadyExists', @sdxStyleSheetNameAlreadyExists);
  AProduct.Add('sdxCannotLoadImage', @sdxCannotLoadImage);
  AProduct.Add('sdxUseNativeStyles', @sdxUseNativeStyles);
  AProduct.Add('sdxSuppressBackgroundBitmaps', @sdxSuppressBackgroundBitmaps);
  AProduct.Add('sdxConsumeSelectionStyle', @sdxConsumeSelectionStyle);
  AProduct.Add('sdxSize', @sdxSize);
  AProduct.Add('sdxLevels', @sdxLevels);
  AProduct.Add('sdxUnwrap', @sdxUnwrap);
  AProduct.Add('sdxUnwrapTopLevel', @sdxUnwrapTopLevel);
  AProduct.Add('sdxRiseActiveToTop', @sdxRiseActiveToTop);
  AProduct.Add('sdxCannotUseOnEveryPageModeInAggregatedState', @sdxCannotUseOnEveryPageModeInAggregatedState);
  AProduct.Add('sdxPagination', @sdxPagination);
  AProduct.Add('sdxByBands', @sdxByBands);
  AProduct.Add('sdxByColumns', @sdxByColumns);
  AProduct.Add('sdxByRows', @sdxByRows);
  AProduct.Add('sdxByTopLevelGroups', @sdxByTopLevelGroups);
  AProduct.Add('sdxOneGroupPerPage', @sdxOneGroupPerPage);
  AProduct.Add('sdxSkipEmptyViews', @sdxSkipEmptyViews);
  AProduct.Add('sdxBorders', @sdxBorders);
  AProduct.Add('sdxExplicitlyExpandNodes', @sdxExplicitlyExpandNodes);
  AProduct.Add('sdxNodes', @sdxNodes);
  AProduct.Add('sdxSeparators', @sdxSeparators);
  AProduct.Add('sdxThickness', @sdxThickness);
  AProduct.Add('sdxTLIncorrectHeadersState', @sdxTLIncorrectHeadersState);
  AProduct.Add('sdxRows', @sdxRows);
  AProduct.Add('sdxMultipleRecords', @sdxMultipleRecords);
  AProduct.Add('sdxBestFit', @sdxBestFit);
  AProduct.Add('sdxKeepSameRecordWidths', @sdxKeepSameRecordWidths);
  AProduct.Add('sdxWrapRecords', @sdxWrapRecords);
  AProduct.Add('sdxByWrapping', @sdxByWrapping);
  AProduct.Add('sdxOneWrappingPerPage', @sdxOneWrappingPerPage);
  AProduct.Add('sdxCurrentRecord', @sdxCurrentRecord);
  AProduct.Add('sdxLoadedRecords', @sdxLoadedRecords);
  AProduct.Add('sdxAllRecords', @sdxAllRecords);
  AProduct.Add('sdxPaginateByControlDetails', @sdxPaginateByControlDetails);
  AProduct.Add('sdxPaginateByControls', @sdxPaginateByControls);
  AProduct.Add('sdxPaginateByGroups', @sdxPaginateByGroups);
  AProduct.Add('sdxPaginateByItems', @sdxPaginateByItems);
  AProduct.Add('sdxControlsPlace', @sdxControlsPlace);
  AProduct.Add('sdxExpandHeight', @sdxExpandHeight);
  AProduct.Add('sdxExpandWidth', @sdxExpandWidth);
  AProduct.Add('sdxShrinkHeight', @sdxShrinkHeight);
  AProduct.Add('sdxShrinkWidth', @sdxShrinkWidth);
  AProduct.Add('sdxCheckAll', @sdxCheckAll);
  AProduct.Add('sdxCheckAllChildren', @sdxCheckAllChildren);
  AProduct.Add('sdxControlsTab', @sdxControlsTab);
  AProduct.Add('sdxExpandAll', @sdxExpandAll);
  AProduct.Add('sdxHiddenControlsTab', @sdxHiddenControlsTab);
  AProduct.Add('sdxReportLinksTab', @sdxReportLinksTab);
  AProduct.Add('sdxAvailableLinks', @sdxAvailableLinks);
  AProduct.Add('sdxAggregatedLinks', @sdxAggregatedLinks);
  AProduct.Add('sdxTransparents', @sdxTransparents);
  AProduct.Add('sdxUncheckAllChildren', @sdxUncheckAllChildren);
  AProduct.Add('sdxRoot', @sdxRoot);
  AProduct.Add('sdxRootBorders', @sdxRootBorders);
  AProduct.Add('sdxControls', @sdxControls);
  AProduct.Add('sdxContainers', @sdxContainers);
  AProduct.Add('sdxHideCustomContainers', @sdxHideCustomContainers);
  AProduct.Add('sdxBytes', @sdxBytes);
  AProduct.Add('sdxKiloBytes', @sdxKiloBytes);
  AProduct.Add('sdxMegaBytes', @sdxMegaBytes);
  AProduct.Add('sdxGigaBytes', @sdxGigaBytes);
  AProduct.Add('sdxThereIsNoPictureToDisplay', @sdxThereIsNoPictureToDisplay);
  AProduct.Add('sdxInvalidRootDirectory', @sdxInvalidRootDirectory);
  AProduct.Add('sdxPressEscToCancel', @sdxPressEscToCancel);
  AProduct.Add('sdxMenuFileRebuild', @sdxMenuFileRebuild);
  AProduct.Add('sdxBuildingReportStatusText', @sdxBuildingReportStatusText);
  AProduct.Add('sdxPrintingReportStatusText', @sdxPrintingReportStatusText);
  AProduct.Add('sdxBuiltIn', @sdxBuiltIn);
  AProduct.Add('sdxUserDefined', @sdxUserDefined);
  AProduct.Add('sdxNewStyleRepositoryWasCreated', @sdxNewStyleRepositoryWasCreated);
  AProduct.Add('sdxLineSpacing', @sdxLineSpacing);
  AProduct.Add('sdxTextAlignJustified', @sdxTextAlignJustified);
  AProduct.Add('sdxSampleText', @sdxSampleText);
  AProduct.Add('sdxCardsRows', @sdxCardsRows);
  AProduct.Add('sdxTransparentRichEdits', @sdxTransparentRichEdits);
  AProduct.Add('sdxIncorrectFilterBarState', @sdxIncorrectFilterBarState);
  AProduct.Add('sdxIncorrectBandHeadersState2', @sdxIncorrectBandHeadersState2);
  AProduct.Add('sdxIncorrectHeadersState2', @sdxIncorrectHeadersState2);
  AProduct.Add('sdxAvailableReportLinks', @sdxAvailableReportLinks);
  AProduct.Add('sdxBtnRemoveInconsistents', @sdxBtnRemoveInconsistents);
  AProduct.Add('sdxRowHeadersOnEveryPage', @sdxRowHeadersOnEveryPage);
  AProduct.Add('sdxColumnHeadersOnEveryPage', @sdxColumnHeadersOnEveryPage);
  AProduct.Add('sdxNotes', @sdxNotes);
  AProduct.Add('sdxTaskPad', @sdxTaskPad);
  AProduct.Add('sdxPrimaryTimeZone', @sdxPrimaryTimeZone);
  AProduct.Add('sdxSecondaryTimeZone', @sdxSecondaryTimeZone);
  AProduct.Add('sdxDay', @sdxDay);
  AProduct.Add('sdxWeek', @sdxWeek);
  AProduct.Add('sdxMonth', @sdxMonth);
  AProduct.Add('sdxSchedulerSchedulerHeader', @sdxSchedulerSchedulerHeader);
  AProduct.Add('sdxSchedulerContent', @sdxSchedulerContent);
  AProduct.Add('sdxSchedulerDateNavigatorContent', @sdxSchedulerDateNavigatorContent);
  AProduct.Add('sdxSchedulerDateNavigatorHeader', @sdxSchedulerDateNavigatorHeader);
  AProduct.Add('sdxSchedulerDayHeader', @sdxSchedulerDayHeader);
  AProduct.Add('sdxSchedulerEvent', @sdxSchedulerEvent);
  AProduct.Add('sdxSchedulerResourceHeader', @sdxSchedulerResourceHeader);
  AProduct.Add('sdxSchedulerNotesAreaBlank', @sdxSchedulerNotesAreaBlank);
  AProduct.Add('sdxSchedulerNotesAreaLined', @sdxSchedulerNotesAreaLined);
  AProduct.Add('sdxSchedulerTaskPad', @sdxSchedulerTaskPad);
  AProduct.Add('sdxSchedulerTimeRuler', @sdxSchedulerTimeRuler);
  AProduct.Add('sdxPrintStyleNameDaily', @sdxPrintStyleNameDaily);
  AProduct.Add('sdxPrintStyleNameWeekly', @sdxPrintStyleNameWeekly);
  AProduct.Add('sdxPrintStyleNameMonthly', @sdxPrintStyleNameMonthly);
  AProduct.Add('sdxPrintStyleNameDetails', @sdxPrintStyleNameDetails);
  AProduct.Add('sdxPrintStyleNameMemo', @sdxPrintStyleNameMemo);
  AProduct.Add('sdxPrintStyleNameTrifold', @sdxPrintStyleNameTrifold);
  AProduct.Add('sdxPrintStyleCaptionAgenda', @sdxPrintStyleCaptionAgenda);
  AProduct.Add('sdxPrintStyleCaptionDaily', @sdxPrintStyleCaptionDaily);
  AProduct.Add('sdxPrintStyleCaptionWeekly', @sdxPrintStyleCaptionWeekly);
  AProduct.Add('sdxPrintStyleCaptionMonthly', @sdxPrintStyleCaptionMonthly);
  AProduct.Add('sdxPrintStyleCaptionDetails', @sdxPrintStyleCaptionDetails);
  AProduct.Add('sdxPrintStyleCaptionMemo', @sdxPrintStyleCaptionMemo);
  AProduct.Add('sdxPrintStyleCaptionTimeLine', @sdxPrintStyleCaptionTimeLine);
  AProduct.Add('sdxPrintStyleCaptionTrifold', @sdxPrintStyleCaptionTrifold);
  AProduct.Add('sdxPrintStyleCaptionYearly', @sdxPrintStyleCaptionYearly);
  AProduct.Add('sdxPrintStyleShowEventImages', @sdxPrintStyleShowEventImages);
  AProduct.Add('sdxPrintStyleShowResourceImages', @sdxPrintStyleShowResourceImages);
  AProduct.Add('sdxTabPrintStyles', @sdxTabPrintStyles);
  AProduct.Add('sdxPrintStyleDontPrintWeekEnds', @sdxPrintStyleDontPrintWeekEnds);
  AProduct.Add('sdxPrintStyleWorkTimeOnly', @sdxPrintStyleWorkTimeOnly);
  AProduct.Add('sdxPrintStyleInclude', @sdxPrintStyleInclude);
  AProduct.Add('sdxPrintStyleIncludeTaskPad', @sdxPrintStyleIncludeTaskPad);
  AProduct.Add('sdxPrintStyleIncludeNotesAreaBlank', @sdxPrintStyleIncludeNotesAreaBlank);
  AProduct.Add('sdxPrintStyleIncludeNotesAreaLined', @sdxPrintStyleIncludeNotesAreaLined);
  AProduct.Add('sdxPrintStyleLayout', @sdxPrintStyleLayout);
  AProduct.Add('sdxPrintStylePrintFrom', @sdxPrintStylePrintFrom);
  AProduct.Add('sdxPrintStylePrintTo', @sdxPrintStylePrintTo);
  AProduct.Add('sdxPrintStyleDailyLayout1PPD', @sdxPrintStyleDailyLayout1PPD);
  AProduct.Add('sdxPrintStyleDailyLayout2PPD', @sdxPrintStyleDailyLayout2PPD);
  AProduct.Add('sdxPrintStyleWeeklyArrange', @sdxPrintStyleWeeklyArrange);
  AProduct.Add('sdxPrintStyleWeeklyArrangeT2B', @sdxPrintStyleWeeklyArrangeT2B);
  AProduct.Add('sdxPrintStyleWeeklyArrangeL2R', @sdxPrintStyleWeeklyArrangeL2R);
  AProduct.Add('sdxPrintStyleWeeklyLayout1PPW', @sdxPrintStyleWeeklyLayout1PPW);
  AProduct.Add('sdxPrintStyleWeeklyLayout2PPW', @sdxPrintStyleWeeklyLayout2PPW);
  AProduct.Add('sdxPrintStyleWeeklyDaysLayout', @sdxPrintStyleWeeklyDaysLayout);
  AProduct.Add('sdxPrintStyleWeeklyDaysLayoutTC', @sdxPrintStyleWeeklyDaysLayoutTC);
  AProduct.Add('sdxPrintStyleWeeklyDaysLayoutOC', @sdxPrintStyleWeeklyDaysLayoutOC);
  AProduct.Add('sdxPrintStyleMemoStartEachItemOnNewPage', @sdxPrintStyleMemoStartEachItemOnNewPage);
  AProduct.Add('sdxPrintStyleMemoPrintOnlySelectedEvents', @sdxPrintStyleMemoPrintOnlySelectedEvents);
  AProduct.Add('sdxPrintStyleMonthlyLayout1PPM', @sdxPrintStyleMonthlyLayout1PPM);
  AProduct.Add('sdxPrintStyleMonthlyLayout2PPM', @sdxPrintStyleMonthlyLayout2PPM);
  AProduct.Add('sdxPrintStyleMonthlyPrintExactly1MPP', @sdxPrintStyleMonthlyPrintExactly1MPP);
  AProduct.Add('sdxPrintStyleTrifoldSectionModeDailyCalendar', @sdxPrintStyleTrifoldSectionModeDailyCalendar);
  AProduct.Add('sdxPrintStyleTrifoldSectionModeWeeklyCalendar', @sdxPrintStyleTrifoldSectionModeWeeklyCalendar);
  AProduct.Add('sdxPrintStyleTrifoldSectionModeMonthlyCalendar', @sdxPrintStyleTrifoldSectionModeMonthlyCalendar);
  AProduct.Add('sdxPrintStyleTrifoldSectionModeTaskPad', @sdxPrintStyleTrifoldSectionModeTaskPad);
  AProduct.Add('sdxPrintStyleTrifoldSectionModeNotesBlank', @sdxPrintStyleTrifoldSectionModeNotesBlank);
  AProduct.Add('sdxPrintStyleTrifoldSectionModeNotesLined', @sdxPrintStyleTrifoldSectionModeNotesLined);
  AProduct.Add('sdxPrintStyleTrifoldSectionLeft', @sdxPrintStyleTrifoldSectionLeft);
  AProduct.Add('sdxPrintStyleTrifoldSectionMiddle', @sdxPrintStyleTrifoldSectionMiddle);
  AProduct.Add('sdxPrintStyleTrifoldSectionRight', @sdxPrintStyleTrifoldSectionRight);
  AProduct.Add('sdxPrintStyleMonthPerPage', @sdxPrintStyleMonthPerPage);
  AProduct.Add('sdxPrintStyleYearly1MPP', @sdxPrintStyleYearly1MPP);
  AProduct.Add('sdxPrintStyleYearly2MPP', @sdxPrintStyleYearly2MPP);
  AProduct.Add('sdxPrintStyleYearly3MPP', @sdxPrintStyleYearly3MPP);
  AProduct.Add('sdxPrintStyleYearly4MPP', @sdxPrintStyleYearly4MPP);
  AProduct.Add('sdxPrintStyleYearly6MPP', @sdxPrintStyleYearly6MPP);
  AProduct.Add('sdxPrintStyleYearly12MPP', @sdxPrintStyleYearly12MPP);
  AProduct.Add('sdxPrintStylePrimaryPageScalesOnly', @sdxPrintStylePrimaryPageScalesOnly);
  AProduct.Add('sdxPrintStylePrimaryPageHeadersOnly', @sdxPrintStylePrimaryPageHeadersOnly);
  AProduct.Add('sdxPrintStyleDetailsStartNewPageEach', @sdxPrintStyleDetailsStartNewPageEach);
  AProduct.Add('sdxSuppressContentColoration', @sdxSuppressContentColoration);
  AProduct.Add('sdxOneResourcePerPage', @sdxOneResourcePerPage);
  AProduct.Add('sdxPrintRanges', @sdxPrintRanges);
  AProduct.Add('sdxPrintRangeStart', @sdxPrintRangeStart);
  AProduct.Add('sdxPrintRangeEnd', @sdxPrintRangeEnd);
  AProduct.Add('sdxHideDetailsOfPrivateAppointments', @sdxHideDetailsOfPrivateAppointments);
  AProduct.Add('sdxResourceCountPerPage', @sdxResourceCountPerPage);
  AProduct.Add('sdxSubjectLabelCaption', @sdxSubjectLabelCaption);
  AProduct.Add('sdxLocationLabelCaption', @sdxLocationLabelCaption);
  AProduct.Add('sdxStartLabelCaption', @sdxStartLabelCaption);
  AProduct.Add('sdxFinishLabelCaption', @sdxFinishLabelCaption);
  AProduct.Add('sdxShowTimeAsLabelCaption', @sdxShowTimeAsLabelCaption);
  AProduct.Add('sdxRecurrenceLabelCaption', @sdxRecurrenceLabelCaption);
  AProduct.Add('sdxRecurrencePatternLabelCaption', @sdxRecurrencePatternLabelCaption);
  AProduct.Add('sdxSeeAboveMessage', @sdxSeeAboveMessage);
  AProduct.Add('sdxAllDayMessage', @sdxAllDayMessage);
  AProduct.Add('sdxContinuedMessage', @sdxContinuedMessage);
  AProduct.Add('sdxShowTimeAsFreeMessage', @sdxShowTimeAsFreeMessage);
  AProduct.Add('sdxShowTimeAsTentativeMessage', @sdxShowTimeAsTentativeMessage);
  AProduct.Add('sdxShowTimeAsOutOfOfficeMessage', @sdxShowTimeAsOutOfOfficeMessage);
  AProduct.Add('sdxRecurrenceNoneMessage', @sdxRecurrenceNoneMessage);
  AProduct.Add('scxRecurrenceDailyMessage', @scxRecurrenceDailyMessage);
  AProduct.Add('scxRecurrenceWeeklyMessage', @scxRecurrenceWeeklyMessage);
  AProduct.Add('scxRecurrenceMonthlyMessage', @scxRecurrenceMonthlyMessage);
  AProduct.Add('scxRecurrenceYearlyMessage', @scxRecurrenceYearlyMessage);
  AProduct.Add('sdxInconsistentTrifoldStyle', @sdxInconsistentTrifoldStyle);
  AProduct.Add('sdxBadTimePrintRange', @sdxBadTimePrintRange);
  AProduct.Add('sdxBadDatePrintRange', @sdxBadDatePrintRange);
  AProduct.Add('sdxCannotPrintNoSelectedItems', @sdxCannotPrintNoSelectedItems);
  AProduct.Add('sdxCannotPrintNoItemsAvailable', @sdxCannotPrintNoItemsAvailable);
  AProduct.Add('sdxColumnFields', @sdxColumnFields);
  AProduct.Add('sdxDataFields', @sdxDataFields);
  AProduct.Add('sdxFiterFields', @sdxFiterFields);
  AProduct.Add('sdxPrefilter', @sdxPrefilter);
  AProduct.Add('sdxRowFields', @sdxRowFields);
  AProduct.Add('sdxAutoColumnsExpand', @sdxAutoColumnsExpand);
  AProduct.Add('sdxAutoRowsExpand', @sdxAutoRowsExpand);
  AProduct.Add('sdxPivotGridColumnHeader', @sdxPivotGridColumnHeader);
  AProduct.Add('sdxPivotGridContent', @sdxPivotGridContent);
  AProduct.Add('sdxPivotGridFieldHeader', @sdxPivotGridFieldHeader);
  AProduct.Add('sdxPivotGridHeaderBackground', @sdxPivotGridHeaderBackground);
  AProduct.Add('sdxPivotGridRowHeader', @sdxPivotGridRowHeader);
  AProduct.Add('sdxPivotGridPrefilter', @sdxPivotGridPrefilter);
  AProduct.Add('sdxUnitPrice', @sdxUnitPrice);
  AProduct.Add('sdxCarName', @sdxCarName);
  AProduct.Add('sdxQuantity', @sdxQuantity);
  AProduct.Add('sdxPaymentAmount', @sdxPaymentAmount);
  AProduct.Add('sdxPurchaseQuarter', @sdxPurchaseQuarter);
  AProduct.Add('sdxPurchaseMonth', @sdxPurchaseMonth);
  AProduct.Add('sdxPaymentType', @sdxPaymentType);
  AProduct.Add('sdxCompanyName', @sdxCompanyName);
end;

procedure AddResourceStringsForPDFDialog(AProduct: TdxProductResourceStrings);
begin
  AProduct.Add('sdxPDFDialogAuthor', @sdxPDFDialogAuthor);
  AProduct.Add('sdxPDFDialogCaption', @sdxPDFDialogCaption);
  AProduct.Add('sdxPDFDialogCompressed', @sdxPDFDialogCompressed);
  AProduct.Add('sdxPDFDialogCreator', @sdxPDFDialogCreator);
  AProduct.Add('sdxPDFDialogDocumentInfoTabSheet', @sdxPDFDialogDocumentInfoTabSheet);
  AProduct.Add('sdxPDFDialogEmbedFonts', @sdxPDFDialogEmbedFonts);
  AProduct.Add('sdxPDFDialogExportSettings', @sdxPDFDialogExportSettings);
  AProduct.Add('sdxPDFDialogExportTabSheet', @sdxPDFDialogExportTabSheet);
  AProduct.Add('sdxPDFDialogKeywords', @sdxPDFDialogKeywords);
  AProduct.Add('sdxPDFDialogMaxCompression', @sdxPDFDialogMaxCompression);
  AProduct.Add('sdxPDFDialogMaxQuality', @sdxPDFDialogMaxQuality);
  AProduct.Add('sdxPDFDialogOpenAfterExport', @sdxPDFDialogOpenAfterExport);
  AProduct.Add('sdxPDFDialogPageRageTabSheet', @sdxPDFDialogPageRageTabSheet);
  AProduct.Add('sdxPDFDialogSecurityAllowChanging', @sdxPDFDialogSecurityAllowChanging);
  AProduct.Add('sdxPDFDialogSecurityAllowComments', @sdxPDFDialogSecurityAllowComments);
  AProduct.Add('sdxPDFDialogSecurityAllowCopy', @sdxPDFDialogSecurityAllowCopy);
  AProduct.Add('sdxPDFDialogSecurityAllowDocumentAssemble', @sdxPDFDialogSecurityAllowDocumentAssemble);
  AProduct.Add('sdxPDFDialogSecurityAllowPrint', @sdxPDFDialogSecurityAllowPrint);
  AProduct.Add('sdxPDFDialogSecurityAllowPrintHiResolution', @sdxPDFDialogSecurityAllowPrintHiResolution);
  AProduct.Add('sdxPDFDialogSecurityEnabled', @sdxPDFDialogSecurityEnabled);
  AProduct.Add('sdxPDFDialogSecurityMethod', @sdxPDFDialogSecurityMethod);
  AProduct.Add('sdxPDFDialogSecurityOwnerPassword', @sdxPDFDialogSecurityOwnerPassword);
  AProduct.Add('sdxPDFDialogSecuritySettings', @sdxPDFDialogSecuritySettings);
  AProduct.Add('sdxPDFDialogSecurityUserPassword', @sdxPDFDialogSecurityUserPassword);
  AProduct.Add('sdxPDFDialogSignatureViewCertificate', @sdxPDFDialogSignatureViewCertificate);
  AProduct.Add('sdxPDFDialogSignatureRequiredDigitalID', @sdxPDFDialogSignatureRequiredDigitalID);
  AProduct.Add('sdxPDFDialogSignatureRequiredDigitalIDPassword', @sdxPDFDialogSignatureRequiredDigitalIDPassword);
  AProduct.Add('sdxPDFDialogSignatureContactInfo', @sdxPDFDialogSignatureContactInfo);
  AProduct.Add('sdxPDFDialogSignatureDetails', @sdxPDFDialogSignatureDetails);
  AProduct.Add('sdxPDFDialogSignatureDigitalID', @sdxPDFDialogSignatureDigitalID);
  AProduct.Add('sdxPDFDialogSignatureOpenDlgDigitalIDFile', @sdxPDFDialogSignatureOpenDlgDigitalIDFile);
  AProduct.Add('sdxPDFDialogSignatureOpenDlgTitle', @sdxPDFDialogSignatureOpenDlgTitle);
  AProduct.Add('sdxPDFDialogSignatureFileName', @sdxPDFDialogSignatureFileName);
  AProduct.Add('sdxPDFDialogSignatureIssuer', @sdxPDFDialogSignatureIssuer);
  AProduct.Add('sdxPDFDialogSignatureIssuerColumnCaption', @sdxPDFDialogSignatureIssuerColumnCaption);
  AProduct.Add('sdxPDFDialogSignatureExpirationDateColumnCaption', @sdxPDFDialogSignatureExpirationDateColumnCaption);
  AProduct.Add('sdxPDFDialogSignatureLocation', @sdxPDFDialogSignatureLocation);
  AProduct.Add('sdxPDFDialogSignatureReason', @sdxPDFDialogSignatureReason);
  AProduct.Add('sdxPDFDialogSignaturePasswordDialogCaption', @sdxPDFDialogSignaturePasswordDialogCaption);
  AProduct.Add('sdxPDFDialogSignatureSettings', @sdxPDFDialogSignatureSettings);
  AProduct.Add('sdxPDFDialogSignatureUseCertificateFromFileStore', @sdxPDFDialogSignatureUseCertificateFromFileStore);
  AProduct.Add('sdxPDFDialogSignatureUseCertificateFromSystemStore', @sdxPDFDialogSignatureUseCertificateFromSystemStore);
  AProduct.Add('sdxPDFDialogSubject', @sdxPDFDialogSubject);
  AProduct.Add('sdxPDFDialogTabDocInfo', @sdxPDFDialogTabDocInfo);
  AProduct.Add('sdxPDFDialogTabExport', @sdxPDFDialogTabExport);
  AProduct.Add('sdxPDFDialogTabPages', @sdxPDFDialogTabPages);
  AProduct.Add('sdxPDFDialogTabSecurity', @sdxPDFDialogTabSecurity);
  AProduct.Add('sdxPDFDialogTabSignature', @sdxPDFDialogTabSignature);
  AProduct.Add('sdxPDFDialogTitle', @sdxPDFDialogTitle);
  AProduct.Add('sdxPDFDialogUseCIDFonts', @sdxPDFDialogUseCIDFonts);
  AProduct.Add('sdxPDFDialogUseJPEGCompression', @sdxPDFDialogUseJPEGCompression);
end;

procedure AddResourceStringsForRibbonPreview(AProduct: TdxProductResourceStrings);
begin
  AProduct.Add('sdxRibbonPrintPreviewClosePrintPreview', @sdxRibbonPrintPreviewClosePrintPreview);
  AProduct.Add('sdxRibbonPrintPreviewGroupFormat', @sdxRibbonPrintPreviewGroupFormat);
  AProduct.Add('sdxRibbonPrintPreviewGroupInsertName', @sdxRibbonPrintPreviewGroupInsertName);
  AProduct.Add('sdxRibbonPrintPreviewGroupInsertPageNumber', @sdxRibbonPrintPreviewGroupInsertPageNumber);
  AProduct.Add('sdxRibbonPrintPreviewGroupNavigation', @sdxRibbonPrintPreviewGroupNavigation);
  AProduct.Add('sdxRibbonPrintPreviewGroupOutput', @sdxRibbonPrintPreviewGroupOutput);
  AProduct.Add('sdxRibbonPrintPreviewGroupParts', @sdxRibbonPrintPreviewGroupParts);
  AProduct.Add('sdxRibbonPrintPreviewGroupReport', @sdxRibbonPrintPreviewGroupReport);
  AProduct.Add('sdxRibbonPrintPreviewGroupScaleToFit', @sdxRibbonPrintPreviewGroupScaleToFit);
  AProduct.Add('sdxRibbonPrintPreviewGroupZoom', @sdxRibbonPrintPreviewGroupZoom);
  AProduct.Add('sdxRibbonPrintPreviewPagesSubItem', @sdxRibbonPrintPreviewPagesSubItem);
end;

procedure AddExpressPrintingSystemResourceStringNames(AProduct: TdxProductResourceStrings);
begin
  // Split into parts because D12 compiler error
  AddResourceStringsPart1(AProduct);
  AddResourceStringsPart2(AProduct);
  AddResourceStringsPart3(AProduct);
  AddResourceStringsForPDFDialog(AProduct);
  AddResourceStringsForRibbonPreview(AProduct);
end;


initialization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.RegisterProduct('ExpressPrinting System', @AddExpressPrintingSystemResourceStringNames);
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
finalization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.UnRegisterProduct('ExpressPrinting System');
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
end.

