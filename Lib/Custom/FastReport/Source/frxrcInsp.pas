{******************************************}
{                                          }
{             FastReport v4.0              }
{          Language resource file          }
{                                          }
{         Copyright (c) 1998-2008          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit frxrcInsp;

interface

implementation

uses frxRes;

const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="1252"><StrRes Name="propActive" Text="Especifica si un Dataset está abierto o no"/><StrRes' + 
' Name="propActive.TfrxHighlight" Text="Especifica si el resaltado está activo o no"/><StrRes Name="propAliasName" Text="El nombre del Alias BDE"/><St' + 
'rRes Name="propAlign" Text="Determina la alineación del objeto relativa a la banda o la página"/><StrRes Name="propAlignment" Text="Justifica el tex' + 
'to de un objeto"/><StrRes Name="propAllowAllUp" Text="Especifica si todos los botones de un grupo pueden estar deseleccionados al mismo tiempo"/><StrR' + 
'es Name="propAllowEdit" Text="Determina si el usuario puede editar las páginas del informe"/><StrRes Name="propAllowExpressions" Text="Determina si e' + 
'l texto contiene expresiones"/><StrRes Name="propAllowGrayed" Text="Permitir que las casillas de verificación, tengan el estado indefinido"/><StrRes ' + 
'Name="propAllowHTMLTags" Text="Determina si el texto contiene etiquetas HTML"/><StrRes Name="propAllowSplit" Text="Determina si una banda contiene pá' + 
'ginas cruzadas"/><StrRes Name="propAuthor" Text="El autor del informe"/><StrRes Name="propAutoSize.TfrxPictureView" Text="Determina si la imagen debe ' + 
'redimensionarse automáticamente"/><StrRes Name="propAutoWidth" Text="Determina si el objeto debe redimensionarse a la longitud del texto"/><StrRes Na' + 
'me="propBackPicture" Text="Imagen de fondo para la página"/><StrRes Name="propBarType" Text="Tipo de código de barra"/><StrRes Name="propBevelInner"' + 
' Text="Tipo de biselado"/><StrRes Name="propBevelOuter" Text="Tipo de biselado"/><StrRes Name="propBevelWidth" Text="Grueso del biselado"/><StrRes Nam' + 
'e="propBorder" Text="Determina si se muestra el borde del biselado o no"/><StrRes Name="propBorderStyle" Text="Estilo de ventana"/><StrRes Name="propB' + 
'ottomMargin" Text="Tamaño para el margen de abajo"/><StrRes Name="propBrushStyle" Text="Estilo de brocha que se usará para pintar el fondo del objet' + 
'o"/><StrRes Name="propCalcCheckSum" Text="Determina si el código de barras debe calcular el dígito de control automáticamente"/><StrRes Name="propC' + 
'ancel" Text="Determina si el botón debe activarse cuando se pulse la tecla ESCAPE"/><StrRes Name="propCaption" Text="Título del control"/><StrRes Na' + 
'me="propCellFields" Text="Nombres de campos representados en las celdas"/><StrRes Name="propCellLevels" Text="Número de celdas del nivel"/><StrRes Na' + 
'me="propCenter" Text="Determina si la imagen deberá estar centrada en el control"/><StrRes Name="propCharset" Text="Fuente"/><StrRes Name="propCharSp' + 
'acing" Text="Cantidad de Píxeles entre dos caracteres"/><StrRes Name="propCheckColor" Text="Color de la marca de verificación"/><StrRes Name="propCh' + 
'ecked" Text="Indica si la casilla del control tiene la marca de selección"/><StrRes Name="propCheckStyle" Text="Estilo de marca de selección"/><StrR' + 
'es Name="propChild" Text="Banda hija conectada a esta banda"/><StrRes Name="propClipped" Text="Determina si el texto debería ser recortado dentro de ' + 
'los límites del objeto"/><StrRes Name="propCollate" Text="Opciones predeterminadas de la colación"/><StrRes Name="propColor.TFont" Text="Color del t' + 
'exto"/><StrRes Name="propColor" Text="Color del objeto"/><StrRes Name="propColor.TfrxFrame" Text="Color del marco"/><StrRes Name="propColor.TfrxHighli' + 
'ght" Text="Detrmina si el color resaltado del objeto está activo"/><StrRes Name="propColumnFields" Text="Nombre de campos representados en las column' + 
'as"/><StrRes Name="propColumnGap" Text="Separación entre las columnas de la banda"/><StrRes Name="propColumnLevels" Text="Número de columnas para es' + 
'te nivel"/><StrRes Name="propColumns" Text="Número de columnas en esta banda"/><StrRes Name="propColumnWidth" Text="Ancho de columnas de esta banda"/' + 
'><StrRes Name="propCondition" Text="Condición por la que se agrupará. El grupo de romperá si el valor de esta expresión cambia"/><StrRes Name="pro' + 
'pCondition.TfrxHighlight" Text="Cadena de la expresión. Si esta expresión es verdadera, el resaltado se activará"/><StrRes Name="propConnected" Tex' + 
't="Indica si la conexión con la base de datos está activa"/><StrRes Name="propConvertNulls" Text="Determina si un campo con valor nulo se convertir�' + 
'� a 0 o a la cadena &#38;#34;Vacío&#38;#34;"/><StrRes Name="propCopies" Text="Número de copias por defecto"/><StrRes Name="propCursor" Text="Tipo de' + 
' cursor para este objeto"/><StrRes Name="propDatabaseName" Text="Nombre de la base de datos"/><StrRes Name="propDataField" Text="Especifica el campo d' + 
'el cual el objeto obtendrá los datos"/><StrRes Name="propDataSet" Text="Dataset ligado a este objeto"/><StrRes Name="propDate" Text="Fecha"/><StrRes ' + 
'Name="propDateFormat" Text="Formato para la fecha"/><StrRes Name="propDecimalSeparator" Text="Separador de decimales"/><StrRes Name="propDefault" Text' + 
'="Determina si el botón estará seleccionado por defecto"/><StrRes Name="propDefHeight" Text="Alto por defecto para la fila"/><StrRes Name="propDescr' + 
'iption.TfrxReportOptions" Text="Descripción del informe"/><StrRes Name="propDescription" Text="Descripción de los objetos"/><StrRes Name="propDiagon' + 
'al" Text="Indica si esta línea es diagonal"/><StrRes Name="propDisplayFormat" Text="Formato que se usará para la visualización de los valores"/><St' + 
'rRes Name="propDoublePass" Text="Determina si el motor de informes debe hacer una segunda pasada"/><StrRes Name="propDown" Text="Determina si el botó' + 
'n de menú está pulsado o no"/><StrRes Name="propDownThenAcross" Text="Determina como de larga será la tabla cruzada"/><StrRes Name="propDriverName"' + 
' Text="Nombre del driver del BDE"/><StrRes Name="propDropShadow" Text="Determina si el objeto tiene sombra"/><StrRes Name="propDuplex" Text="Especific' + 
'a si se activa el modo duplex para esta página"/><StrRes Name="propEditMask" Text="Especifica la máscara que se usará para la edición en este cont' + 
'rol"/><StrRes Name="propEnabled" Text="Determina si el control estará accesible"/><StrRes Name="propEngineOptions" Text="Opciones del motor de inform' + 
'es"/><StrRes Name="propExpression" Text="Valor de la expresión que contiene el objeto"/><StrRes Name="propExpressionDelimiters" Text="Caracteres que ' + 
'srán usados para delimitar las expresiones contenidas en el texto"/><StrRes Name="propFieldAliases" Text="Campos del dataset"/><StrRes Name="propFilt' + 
'er" Text="Condición del filtro para el Dataset"/><StrRes Name="propFiltered" Text="Determina si el Dataset debe aplicar el filtro contenido en la pro' + 
'piedad Filter"/><StrRes Name="propFlowTo" Text="El objeto texto mostrará un texto que no cabe en el objeto"/><StrRes Name="propFont" Text="Fuente usa' + 
'da en este objeto"/><StrRes Name="propFooterAfterEach" Text="Determina si la banda de pie debe mostrarse después de cada fila de datos"/><StrRes Name' + 
'="propFormatStr" Text="Formato para texto"/><StrRes Name="propFrame" Text="Atributos para el marco del objeto"/><StrRes Name="propGapX" Text="Indentad' + 
'o a la izquierda para el texto"/><StrRes Name="propGapY" Text="Indentado arriba para el texto"/><StrRes Name="propGlyph" Text="Imagen del control"/><S' + 
'trRes Name="propGroupIndex" Text="Indica el grupo de botones con los que interactuará el botón"/><StrRes Name="propHAlign" Text="Alineación horizon' + 
'tal del texto"/><StrRes Name="propHeight" Text="Alto del objeto"/><StrRes Name="propHideZeros" Text="Determina si se mostrará o no el valor cero"/><S' + 
'trRes Name="propHighlight" Text="Atributos para el resaltado"/><StrRes Name="propIndexName" Text="Nombre del índice"/><StrRes Name="propInitString" T' + 
'ext="Cadena de inicialización de Impresora pra Informes matriciales"/><StrRes Name="propItems" Text="Lista de items"/><StrRes Name="propKeepAspectRat' + 
'io" Text="Mantener el aspecto original de la imagen"/><StrRes Name="propKeepChild" Text="Determina si la banda ha de imprimirse junto a su hija"/><Str' + 
'Res Name="propKeepFooter" Text="Determina si la banda ha de imprimirse junto a su pie"/><StrRes Name="propKeepHeader" Text="Determina si la banda ha d' + 
'e imprimirse junto a su cabecera"/><StrRes Name="propKeepTogether" Text="Determina si la banda ha de imprimirse junto a todas sus subbandas"/><StrRes ' + 
'Name="propKind.TfrxFormat" Text="Tipo de formateo"/><StrRes Name="propKind" Text="Tipo de botón"/><StrRes Name="propLargeDesignHeight" Text="Determin' + 
'a si la página dentra longitud larga en el modo de diseño"/><StrRes Name="propLayout" Text="Disposición de la imagen en el botón"/><StrRes Name="p' + 
'ropLeft" Text="Posición izquierda del objeto"/><StrRes Name="propLeftMargin" Text="Tamaño del margen izquierdo de la página"/><StrRes Name="propLin' + 
'es" Text="Texto del objeto"/><StrRes Name="propLineSpacing" Text="Número de píxeles entre dos líneas de texto"/><StrRes Name="propLoginPrompt" Text' + 
'="Dtermina si se mostrará el diálogo de petición de login"/><StrRes Name="propMargin" Text="Determina el número de píxeles entre el borde de la i' + 
'magen y el borde del botón"/><StrRes Name="propMaster" Text="Dataset maestro"/><StrRes Name="propMasterFields" Text="Campos por los que se establece ' + 
'la relación Maestro-Detalle"/><StrRes Name="propMaxLength" Text="Máxima longitud del texto"/><StrRes Name="propMaxWidth" Text="Anchura máxima de la' + 
' columna"/><StrRes Name="propMemo" Text="Texto del objeto"/><StrRes Name="propMinWidth" Text="Anchura mínima de la columna"/><StrRes Name="propMirror' + 
'Margins" Text="Márgenes de página iguales en las páginas pares"/><StrRes Name="propModalResult" Text="Determina el valor que devolverá cuando se c' + 
'ierre con este botón una ventana modal"/><StrRes Name="propName.TFont" Text="Nombre de la fuente"/><StrRes Name="propName.TfrxReportOptions" Text="No' + 
'mbre del informe"/><StrRes Name="propName" Text="Nombre del objeto"/><StrRes Name="propNumGlyphs" Text="Indica el número de imágenes contenidas en l' + 
'a imagen indicada en la propiedad Glyph"/><StrRes Name="propOpenDataSource" Text="Determina si la fuente de datos será abierta automáticamente o no"' + 
'/><StrRes Name="propOrientation" Text="Orientación de la página"/><StrRes Name="propOutlineText" Text="Texto que se mostrará en el índice de la vi' + 
'sta previa"/><StrRes Name="propOutlineVisible" Text="Indica si se mostrará el índice en la vista previa"/><StrRes Name="propOutlineWidth" Text="Anch' + 
'ura que ocupará el índice en la vista previa"/><StrRes Name="propPageNumbers.TfrxPrintOptions" Text="Número de páginas que se imprimirán"/><StrRe' + 
's Name="propPaperHeight" Text="Alto de la página"/><StrRes Name="propPaperWidth" Text="Ancho de la página"/><StrRes Name="propParagraphGap" Text="In' + 
'dentación para la primera línea del párrafo"/><StrRes Name="propParams.TfrxBDEDatabase" Text="Parámetros de la conexión"/><StrRes Name="propParam' + 
's" Text="Parámetros de la consulta"/><StrRes Name="propParentFont" Text="Indica si el objeto usará la misma fuente que su contenedor"/><StrRes Name=' + 
'"propPassword" Text="Contraseña del informe"/><StrRes Name="propPasswordChar" Text="Indica el caracter que se mostrará en sustitución de los que re' + 
'almente se teclean"/><StrRes Name="propPicture" Text="Imagen"/><StrRes Name="propPicture.TfrxReportOptions" Text="Imagen que describe el informe"/><St' + 
'rRes Name="propPosition" Text="Posición inicial de la ventana"/><StrRes Name="propPreviewOptions" Text="Opciones de vista previa del informe"/><StrRe' + 
's Name="propPrintable" Text="Indica si el objeto es imprimible. Si se establece a False, el objeto será mostrado en la vista previa, pero no se impri' + 
'mirá"/><StrRes Name="propPrintChildIfInvisible" Text="Indica si la banda hija se imprimirá en el caso de que la banda padre sea invisible"/><StrRes ' + 
'Name="propPrinter" Text="Nombre de la impresora que aparecerá seleccionada al abrir o ejecutar el informe"/><StrRes Name="propPrintIfDetailEmpty" Tex' + 
't="Indica si la banda de datos se imprimirá en el caso de que sus subbandas estén vacías"/><StrRes Name="propPrintIfEmpty" Text="Indica si la pági' + 
'na se imprimirá en el caso de que los Datasets estén vacíos"/><StrRes Name="propPrintOnFirstPage" Text="Indica si la banda se imprimirá en la prim' + 
'era página"/><StrRes Name="propPrintOnLastPage" Text="Indica si la banda se imprimirá en la última página"/><StrRes Name="propPrintOnParent" Text=' + 
'"Determina si el subreport se puede imprimir en la banda padre"/><StrRes Name="propPrintOnPreviousPage" Text="Determina si la página se puede generar' + 
' en el espacio libre de la página previamente generada"/><StrRes Name="propPrintOptions" Text="Opciones de impresión del informe"/><StrRes Name="pro' + 
'pPrintPages" Text="Determina si se imprime todo o solo las páginas pares o las impares"/><StrRes Name="propRangeBegin" Text="Determina el punto de co' + 
'mienzo en la navegación en el dataset"/><StrRes Name="propRangeEnd" Text="Determina el punto de terminación en la navegación en el dataset"/><StrRe' + 
's Name="propRangeEndCount" Text="Determina el número de registros que se leerán del Dataset Si la propiedad RangeEnd es reCount"/><StrRes Name="prop' + 
'ReadOnly" Text="Determina si el texto del objeto es de solo lectura"/><StrRes Name="propRepeatHeaders" Text="Determina si la columna y la fila de cabe' + 
'cera s4e imprimirá en la página nueva"/><StrRes Name="propReportOptions" Text="Opciones del informe"/><StrRes Name="propReprintOnNewPage" Text="Dete' + 
'rmina si la banda será reimpresa en la nueva página"/><StrRes Name="propRestrictions" Text="Establecer restricciones"/><StrRes Name="propRightMargin' + 
'" Text="Tamaño del margen derecho de la página"/><StrRes Name="propRotation.TfrxBarCodeView" Text="Orientación del código de barras"/><StrRes Name' + 
'="propRotation" Text="Rotación del texto"/><StrRes Name="propRowCount" Text="Número de registros virtuales en la banda de datos"/><StrRes Name="prop' + 
'RowFields" Text="Nombres de campos que representan las filas cruzadas"/><StrRes Name="propRowLevels" Text="Número de niveles en la fila"/><StrRes Nam' + 
'e="propRTLReading" Text="Determina si el texto del objeto, se pintará de derecha a izquierda"/><StrRes Name="propSessionName" Text="Nombre de la sesi' + 
'ón del BDE"/><StrRes Name="propShadowColor" Text="Color de la sombra"/><StrRes Name="propShadowWidth" Text="Ancho de la sombra"/><StrRes Name="propSh' + 
'ape" Text="Tipo de dibujo"/><StrRes Name="propShiftMode" Text="Cambia el comportamiento del objeto"/><StrRes Name="propShowColumnHeader" Text="Determi' + 
'na si se mostrarán las cabeceras de columna en los cruces"/><StrRes Name="propShowColumnTotal" Text="Determina si se mostrará la columna de Total"/>' + 
'<StrRes Name="propShowRowHeader" Text="Determina si se mostrarán las cabeceras de fila"/><StrRes Name="propShowRowTotal" Text="Determina si se mostra' + 
'rá la fila de Total"/><StrRes Name="propShowDialog" Text="Determina si se mostrará el diálogo de impresión en la vista previa"/><StrRes Name="prop' + 
'ShowText" Text="Determina si se mostrará el texto del código de barras"/><StrRes Name="propSize" Text="Tamaño de fuente"/><StrRes Name="propSorted"' + 
' Text="Determina si los items serán ordenados o no"/><StrRes Name="propSpacing" Text="Determina el número de píxeles entre la imagen y el texto"/><' + 
'StrRes Name="propSQL" Text="Sentencia SQL"/><StrRes Name="propStartNewPage" Text="Lanzar una nueva página antes de imprimir la banda"/><StrRes Name="' + 
'propStretch" Text="Ajusta la imagen a los límetes del objeto"/><StrRes Name="propStretched" Text="Determina si el objeto puede ser ajustado"/><StrRes' + 
' Name="propStretchMode" Text="Comportamiento del ajuste al objeto"/><StrRes Name="propStyle.TFont" Text="Estilo de fuente"/><StrRes Name="propStyle" T' + 
'ext="Estilo de control"/><StrRes Name="propStyle.TfrxFrame" Text="Estilo del marco"/><StrRes Name="propSuppressRepeated" Text="Suprime los valores rep' + 
'etidos"/><StrRes Name="propTableName" Text="Nombre de la tabla de datos"/><StrRes Name="propTag" Text="Tag"/><StrRes Name="propTagStr" Text="Tag strin' + 
'g del objeto"/><StrRes Name="propText" Text="Texto del objeto"/><StrRes Name="propTitleBeforeHeader" Text="Determina si se mostrará el título del in' + 
'forme antes de la cabecera de página"/><StrRes Name="propTop" Text="Posición arriba del objeto"/><StrRes Name="propTopMargin" Text="Tamaño del marg' + 
'en arriba de la página"/><StrRes Name="propTyp" Text="Tipo de marco"/><StrRes Name="propUnderlines" Text="Determina si el texto aparecerá subrayado"' + 
'/><StrRes Name="propURL" Text="URL del objeto"/><StrRes Name="propUserName" Text="Nombre del usuario. Este nombre será usado para mostrarlo en el ár' + 
'bol de datos"/><StrRes Name="propVAlign" Text="Alineación vertical del texto"/><StrRes Name="propVersionBuild" Text="Información de versión"/><StrR' + 
'es Name="propVersionMajor" Text="Información de versión, mayor version"/><StrRes Name="propVersionMinor" Text="Información de versión info, menor ' + 
'version"/><StrRes Name="propVersionRelease" Text="Información de versión"/><StrRes Name="propVisible" Text="Indica si el objeto se verá o no"/><Str' + 
'Res Name="propWidth" Text="Anchura del objeto"/><StrRes Name="propWidth.TfrxFrame" Text="Anchura del marco"/><StrRes Name="propWindowState" Text="Esta' + 
'do inicial de la ventana"/><StrRes Name="propWordBreak" Text="Partir palabras rusas"/><StrRes Name="propWordWrap" Text="Determina si se insertarán re' + 
'tornos de carro en el texto cuando la longitud de este sobrepase el margen derecho"/><StrRes Name="propZoom.TfrxBarCodeView" Text="Zoom del código de' + 
' barras"/><StrRes Name="propConnectionName" Text="Nombre de la conexión con la base de datos usada en el informe"/><StrRes Name="propCurve" Text="Cur' + 
'vatura de los angulos redondeados del rectángulo"/><StrRes Name="propDrillDown" Text="Determina si el grupo puede ser desglosado"/><StrRes Name="prop' + 
'FontStyle" Text="Fuentes Estilo Matricial"/><StrRes Name="propHideIfSingleDataRecord" Text="Ocultar el pie si el grupo solo tiene una fila"/><StrRes N' + 
'ame="propOutlineExpand" Text="Determina si expandir el boceto del informe o no"/><StrRes Name="propPlainCells" Text="Determina si se imprimen varias c' + 
'eldas de lado a lado o apiladas"/><StrRes Name="propPrintMode" Text="Modo de impresión: normal, partir páginas grandes en una pequeña, o imprimir v' + 
'arias págianas pequeñas en una grande"/><StrRes Name="propPrintOnSheet" Text="Tamaño del papel. Usado si PrintMode no es pmDefault"/><StrRes Name="' + 
'propResetPageNumbers" Text="Reinicializa el número de páginas/total páginas cuando se imprime el grupo."/><StrRes Name="propReverse" Text="Determin' + 
'a si las páginas se imprimirán en orden descendente"/><StrRes Name="propShowFooterIfDrillDown" Text="Determina si se ha de mostrar el pie de grupo s' + 
'i el grupo es drilldown"/><StrRes Name="propSizeMode" Text="Como mostrar el Objeto OLE"/><StrRes Name="propVersion" Text="Versión de FastReport"/><St' + 
'rRes Name="propWideBarRatio" Text="Relative with of wide bars of the barcode"/><StrRes Name="propWysiwyg" Text="Determina si un objeto Richview debe u' + 
'sar la impresora para formatear el texto. Una impresora debe estar instalada y lista."/><StrRes Name="propArrowEnd" Text="Determina si se debe dibujar' + 
' una flecha en el extremo de la línea."/><StrRes Name="propArrowLength" Text="Longitud de la flecha"/><StrRes Name="propArrowSolid" Text="Determina s' + 
'i la flecha a dibujar será sólida"/><StrRes Name="propArrowStart" Text="Determina si se ha de dibujar una flecha en el comienzo de la línea"/><StrR' + 
'es Name="propArrowWidth" Text="Anchura de la flecha"/><StrRes Name="propCloseDataSource" Text="Determina si se ha de cerrar el DataSet cuando se cierr' + 
'e el informe"/><StrRes Name="propDatabase" Text="Conexión a la Base de Datos"/><StrRes Name="propIndexFieldNames" Text="Nombre del Indice"/><StrRes N' + 
'ame="propCommandTimeOut" Text="Cantidad de tiempo necesario para ejecutar una consulta"/><StrRes Name="propExpandDrillDown" Text="Determina si expandi' + 
'r elementos desglosados al inicio del informe"/><StrRes Name="propWysiwyg.TfrxMemoView" Text="Determina si el texto se verá tal y como se vé"/><StrR' + 
'es Name="propLeftLine" Text="Línea Izquierda del marco"/><StrRes Name="propTopLine" Text="Línea de arriba del marco"/><StrRes Name="propRightLine" T' + 
'ext="Línea derecha del marco"/><StrRes Name="propBottomLine" Text="Línea de abajo del marco"/><StrRes Name="propColor.TfrxFrameLine" Text="Color de ' + 
'la línea del marco"/><StrRes Name="propStyle.TfrxFrameLine" Text="Estilo de la línea del marco"/><StrRes Name="propWidth.TfrxFrameLine" Text="Anchur' + 
'a de la línea del marco"/><StrRes Name="propFileLink" Text="Expresión o nombre del archivo que contiene la imagen"/><StrRes Name="propEndlessWidth" ' + 
'Text="Modo sin fin de la página. Si se configura a TRUE, la página crecerá dependiendo del número de registros de datos"/><StrRes Name="propEndles' + 
'sHeight" Text="Modo sin fin de la página. Si se configura a TRUE, la página crecerá dependiendo del número de registros de datos"/><StrRes Name="p' + 
'ropAddHeight" Text="Agrega la cantidad de espacio especificada a la altura de la celda"/><StrRes Name="propAddWidth" Text="Agrega la cantidad de espac' + 
'io especificada a la anchura de la celda"/><StrRes Name="propAllowDuplicates" Text="Determina si la celda puede aceptar valores duplicados"/><StrRes N' + 
'ame="propJoinEqualCells" Text="Determina si los datos cruzados deben ensamblar las celdas con datos iguales"/><StrRes Name="propNextCross" Text="Seña' + 
'lar al siguiente dato cruzado que será mostrado lado a lado"/><StrRes Name="propNextCrossGap" Text="Espacio entre datos cruzados"/><StrRes Name="prop' + 
'ShowCorner" Text="Determina si el dato cruzado deberá mostrarse en la esquina superior izquierda de los elementos"/><StrRes Name="propSuppressNullRec' + 
'ords" Text="Determina si el dato cruzado deberá suprimir registros con valor nulo (NULL)"/><StrRes Name="propShowTitle" Text="Determina si el dato cr' + 
'uzado deberá mostrar un título"/><StrRes Name="propAutoSize" Text="Determina si el dato cruzado deberá ajustar su tamaño automáticamente"/><StrRe' + 
's Name="propShowHint" Text="Determina si el objeto debera mostrar la ayuda cuando se mueve el cursor encima"/><StrRes Name="propHint" Text="Texto de A' + 
'yuda"/><StrRes Name="propPaperSize" Text="Tamaño del Papel"/><StrRes Name="propPageCount" Text="Contador de páginas"/><StrRes Name="propBackPictureV' + 
'isible" Text="Determina si la página deberá mostrar una imagen de fondo"/><StrRes Name="propBackPicturePrintable" Text="Determina si la página debe' + 
'rá imprimir una imagen de fondo"/><StrRes Name="propHightQuality" Text="Mostrar imagen en alta calidad"/><StrRes Name="propLockType" Text="Indica el ' + 
'tipo de bloqueo al abrir una hoja de cálculo"/><StrRes Name="propIgnoreDupParams" Text="Ignorar parámetros duplicados en el Editor de Parámetros"/>' + 
'<StrRes Name="propTransparent" Text="Determina si la imagen puede ser transparente"/><StrRes Name="propTransparentColor" Text="Color transparente"/><S' + 
'trRes Name="propIgnoreNulls" Text="Permite ignorar los valores nulos en el gráfico"/><StrRes Name="propShowClildIfDrillDown" Text="Determina si se mu' + 
'estra la banda hija si el grupo se desglosa"/><StrRes Name="propUnderlinesTextMode" Text="Determina los modos de subrayado del objeto de texto"/><StrR' + 
'es Name="propCanShrink" Text="Determina si el objeto de texto puede encogerse"/></Resources>' + 
' ';

initialization
  frxResources.AddXML(resXML);

end.
