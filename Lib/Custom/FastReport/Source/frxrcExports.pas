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

unit frxrcExports;

interface

implementation

uses frxRes;

const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="1252"><StrRes Name="8000" Text="Exportar Excel"/><StrRes Name="8001" Text="Estilos"/><StrRe' + 
's Name="8002" Text="Imágenes"/><StrRes Name="8003" Text="Combinar celdas"/><StrRes Name="8004" Text="Exportar Rápido"/><StrRes Name="8005" Text="Tal' + 
' como lo ves (WYSIWYG)"/><StrRes Name="8006" Text="Como texto"/><StrRes Name="8007" Text="Segundo plano"/><StrRes Name="8008" Text="Abrir Excel despu�' + 
'�s de exportar"/><StrRes Name="8009" Text="Archivo de Excel (*.xls)|*.xls"/><StrRes Name="8010" Text=".xls"/><StrRes Name="8100" Text="Exportar a Exce' + 
'l"/><StrRes Name="8101" Text="Estilos"/><StrRes Name="8102" Text="Tal como lo ves (WYSIWYG)"/><StrRes Name="8103" Text="Segundo Plano"/><StrRes Name="' + 
'8104" Text="Abrir Excel después de exportar"/><StrRes Name="8105" Text="Archivo XML Excel (*.xls)|*.xls"/><StrRes Name="8106" Text=".xls"/><StrRes Na' + 
'me="8200" Text="Exportar a HTML"/><StrRes Name="8201" Text="Abrir después de exportar"/><StrRes Name="8202" Text="Estilos"/><StrRes Name="8203" Text=' + 
'"Imágenes"/><StrRes Name="8204" Text="Todo en una carpeta"/><StrRes Name="8205" Text="Ancho fijo"/><StrRes Name="8206" Text="Navegador"/><StrRes Name' + 
'="8207" Text="Multipágina"/><StrRes Name="8208" Text="Navegador Mozilla"/><StrRes Name="8209" Text="Segundo plano"/><StrRes Name="8210" Text="Archivo' + 
' HTML (*.html)|*.html"/><StrRes Name="8211" Text=".html"/><StrRes Name="8300" Text="Exportar a texto (Impresoras matriciales)"/><StrRes Name="8301" Te' + 
'xt="Vista previa Si/No"/><StrRes Name="8302" Text="Opciones de exportación"/><StrRes Name="8303" Text="Separador de páginas"/><StrRes Name="8304" Te' + 
'xt="Código de página OEM"/><StrRes Name="8305" Text="Líneas vacías"/><StrRes Name="8306" Text="Espacios fijos"/><StrRes Name="8307" Text="Páginas' + 
':"/><StrRes Name="8308" Text="Indique los números de página y/o un rango, separados por comas. Por ejemplo: 1,3,5-12"/><StrRes Name="8309" Text=" Es' + 
'calado"/><StrRes Name="8310" Text="Escala X"/><StrRes Name="8311" Text="Escala Y"/><StrRes Name="8312" Text=" Marcos"/><StrRes Name="8313" Text="Ningu' + 
'no"/><StrRes Name="8314" Text="Simple"/><StrRes Name="8315" Text="Gráfico"/><StrRes Name="8316" Text="Solo códigos de página OEM"/><StrRes Name="83' + 
'17" Text="Imprimir después de exportar"/><StrRes Name="8318" Text="Guardar opciones"/><StrRes Name="8319" Text=" Vista previa"/><StrRes Name="8320" T' + 
'ext="Ancho:"/><StrRes Name="8321" Text="Alto:"/><StrRes Name="8322" Text="Página"/><StrRes Name="8323" Text="Más Zoom"/><StrRes Name="8324" Text="Me' + 
'nos Zoom"/><StrRes Name="8325" Text="Archivo de texto (Impresoras matriciales)(*.prn)|*.prn"/><StrRes Name="8326" Text=".prn"/><StrRes Name="8400" Tex' + 
't="Imprimir"/><StrRes Name="8401" Text="Impresora"/><StrRes Name="8402" Text="Nombre"/><StrRes Name="8403" Text="Configurar..."/><StrRes Name="8404" T' + 
'ext="Copias"/><StrRes Name="8405" Text="Número de copias"/><StrRes Name="8406" Text=" Configuración"/><StrRes Name="8407" Text="Tipo de impresora"/>' + 
'<StrRes Name="8408" Text=".fpi"/><StrRes Name="8409" Text="Plantilla de inicialización de impresora (*.fpi)|*.fpi"/><StrRes Name="8410" Text=".fpi"/>' + 
'<StrRes Name="8411" Text="Plantilla de inicialización de impresora (*.fpi)|*.fpi"/><StrRes Name="8500" Text="Exportar a RTF"/><StrRes Name="8501" Tex' + 
't="Imágenes"/><StrRes Name="8502" Text="Tal como lo vés"/><StrRes Name="8503" Text="Abrir después de exportar"/><StrRes Name="8504" Text="Archivo R' + 
'TF (*.rtf)|*.rtf"/><StrRes Name="8505" Text=".rtf"/><StrRes Name="8600" Text="Opciones de exportación"/><StrRes Name="8601" Text=" Opciones de imagen' + 
'"/><StrRes Name="8602" Text="Calidad JPEG"/><StrRes Name="8603" Text="Resolución (ppp)"/><StrRes Name="8604" Text="Archivos separados"/><StrRes Name=' + 
'"8605" Text="Recortar páginas"/><StrRes Name="8606" Text="Monocromo"/><StrRes Name="8700" Text="Exportar a PDF"/><StrRes Name="8701" Text="PDF/A"/><S' + 
'trRes Name="8702" Text="Fuentes embebidas"/><StrRes Name="8703" Text="Impresión optimizada"/><StrRes Name="8704" Text="Esquema (Índice)"/><StrRes Na' + 
'me="8705" Text="Abrir después de exportar"/><StrRes Name="8706" Text="Esquema"/><StrRes Name="8707" Text="Archivos de Adobe PDF (*.pdf)|*.pdf"/><StrR' + 
'es Name="8708" Text=".pdf"/><StrRes Name="8709" Text="Transparencia"/><StrRes Name="8710" Text="Estándar de PDF:"/><StrRes Name="8711" Text="Versión' + 
' de PDF:"/><StrRes Name="8712" Text="Comprimido"/><StrRes Name="8716" Text="Firma"/><StrRes Name="8717" Text="Firma digital"/><StrRes Name="8718" Text' + 
'="Firmar el documento"/><StrRes Name="8719" Text="Lugar"/><StrRes Name="8720" Text="Reason"/><StrRes Name="8721" Text="Contacto"/><StrRes Name="8722" ' + 
'Text="Certificado"/><StrRes Name="8723" Text="Fichero:"/><StrRes Name="8724" Text="Palabra de paso"/><StrRes Name="8725" Text="Guardar la palabra de p' + 
'aso"/><StrRes Name="8726" Text="¡Atención! Guardar la palabra de paso puede ser inseguro"/><StrRes Name="8727" Text="Información Adicional"/><StrRe' + 
's Name="8728" Text="Descripción"/><StrRes Name="8729" Text="Auto llenado"/><StrRes Name="DigitalSignature" Text="Firma digital"/><StrRes Name="Input"' + 
' Text="Entrada"/><StrRes Name="SignatureObjectName" Text="Nombre del Objeto de Firma"/><StrRes Name="8713" Text="Form. interactivos"/><StrRes Name="87' + 
'14" Text="Símbolos utilizados"/><StrRes Name="8715" Text="Aqui se debe usar una expresión simple.&#13;&#10; Example: &#38;#34;A-Z,a-z&#38;#34; o el ' + 
'número de un símbolo: &#38;#34;#40-#50,#200,#255&#38;#34;."/><StrRes Name="RTFexport" Text="Archivo RTF"/><StrRes Name="BMPexport" Text="Imagen BMP"' + 
'/><StrRes Name="JPEGexport" Text="Imagen JPEG"/><StrRes Name="TIFFexport" Text="Imagen TIFF"/><StrRes Name="PNGexport" Text="Imagen PNG"/><StrRes Name' + 
'="EMFexport" Text="Imagen EMF"/><StrRes Name="TextExport" Text="Texto (Impresora matricial)"/><StrRes Name="XlsOLEexport" Text="Tabla Excel (OLE)"/><S' + 
'trRes Name="HTMLexport" Text="Archivo HTML"/><StrRes Name="XlsXMLexport" Text="Tabla Excel (XML)"/><StrRes Name="PDFexport" Text="Archivo PDF"/><StrRe' + 
's Name="ProgressWait" Text="Espere por favor"/><StrRes Name="ProgressRows" Text="Opciones de filas"/><StrRes Name="ProgressColumns" Text="Opciones de ' + 
'columnas"/><StrRes Name="ProgressStyles" Text="Opciones de estilos"/><StrRes Name="ProgressObjects" Text="Exportando objetos"/><StrRes Name="TIFFexpor' + 
'tFilter" Text="Imagen Tiff (*.tif)|*.tif"/><StrRes Name="BMPexportFilter" Text="Imagen BMP (*.bmp)|*.bmp"/><StrRes Name="JPEGexportFilter" Text="Image' + 
'n Jpeg (*.jpg)|*.jpg"/><StrRes Name="PNGexportFilter" Text="Imagen PNG (*.png)|*.png"/><StrRes Name="EMFexportFilter" Text="Imagen EMF (*.emf)|*.emf"/' + 
'><StrRes Name="HTMLNavFirst" Text="Primera"/><StrRes Name="HTMLNavPrev" Text="Anterior"/><StrRes Name="HTMLNavNext" Text="Siguiente"/><StrRes Name="HT' + 
'MLNavLast" Text="Ultima"/><StrRes Name="HTMLNavRefresh" Text="Refrescar"/><StrRes Name="HTMLNavPrint" Text="Imprimir"/><StrRes Name="HTMLNavTotal" Tex' + 
't="Total páginas"/><StrRes Name="8800" Text="Exportar a texto"/><StrRes Name="8801" Text="Archivo de texto (*.txt)|*.txt"/><StrRes Name="8802" Text="' + 
'.txt"/><StrRes Name="SimpleTextExport" Text="Archivo de texto"/><StrRes Name="8850" Text="Exportar a CSV"/><StrRes Name="8851" Text="Archivo CSV (*.cs' + 
'v)|*.csv"/><StrRes Name="8852" Text=".csv"/><StrRes Name="8853" Text="Separador"/><StrRes Name="CSVExport" Text="Archivo CSV"/><StrRes Name="8900" Tex' + 
't="Enviar por E-mail"/><StrRes Name="8901" Text="E-mail"/><StrRes Name="8902" Text="Cuenta"/><StrRes Name="8903" Text="Conexión"/><StrRes Name="8904"' + 
' Text="Dirección"/><StrRes Name="8905" Text="Adjunto"/><StrRes Name="8906" Text="Formato"/><StrRes Name="8907" Text="De la dirección"/><StrRes Name=' + 
'"8908" Text="Del nombre"/><StrRes Name="8909" Text="Servidor"/><StrRes Name="8910" Text="Usuario"/><StrRes Name="8911" Text="Correo"/><StrRes Name="89' + 
'12" Text="Mensaje"/><StrRes Name="8913" Text="Texto"/><StrRes Name="8914" Text="Organización"/><StrRes Name="8915" Text="Contraseña"/><StrRes Name="' + 
'8916" Text="Puerto"/><StrRes Name="8917" Text="Recordar propiedades"/><StrRes Name="8918" Text="Algunos campos obligatorios no se han completado"/><St' + 
'rRes Name="8919" Text="Configuración avanzada"/><StrRes Name="8920" Text="Firma"/><StrRes Name="8921" Text="Construir"/><StrRes Name="8922" Text="Asu' + 
'nto"/><StrRes Name="8923" Text="Un saludo"/><StrRes Name="8924" Text="Enviar el correo a"/><StrRes Name="8925" Text="Protocolo de Correo:"/><StrRes Na' + 
'me="8926" Text="Espera"/><StrRes Name="EmailExport" Text="Correo (E-mail)"/><StrRes Name="FastReportFile" Text="Archivo de informe"/><StrRes Name="Gif' + 
'exportFilter" Text="Archivo Gif (*.gif)|*.gif"/><StrRes Name="GIFexport" Text="Imagen Gif"/><StrRes Name="8950" Text="Continuo"/><StrRes Name="8951" T' + 
'ext="Cabecera de página/Pié"/><StrRes Name="8952" Text="Texto"/><StrRes Name="8953" Text="Cabecera/Pié"/><StrRes Name="8954" Text="Ninguno"/><StrRe' + 
's Name="ODSExportFilter" Text="Hoja de Cálculo OpenOffice/LibreOffice (*.ods)|*.ods"/><StrRes Name="ODSExport" Text="Hoja de Cálculo OpenOffice/Libr' + 
'eOffice"/><StrRes Name="ODTExportFilter" Text="Texto OpenOffice/LibreOffice (*.odt)|*.odt"/><StrRes Name="ODTExport" Text="Texto OpenOffice/LibreOffic' + 
'e"/><StrRes Name="8960" Text=".ods"/><StrRes Name="8961" Text=".odt"/><StrRes Name="8962" Text="Seguridad"/><StrRes Name="8963" Text="Opciones de segu' + 
'ridad"/><StrRes Name="8964" Text="Contraseña de propietario"/><StrRes Name="8965" Text="Contraseña de usuario"/><StrRes Name="8966" Text="Imprimir e' + 
'l documento"/><StrRes Name="8967" Text="Modificar el documento"/><StrRes Name="8968" Text="Copiar texto y gráficos"/><StrRes Name="8969" Text="Añadi' + 
'r o modificar anotaciones"/><StrRes Name="8970" Text="Seguridad del PDF"/><StrRes Name="8971" Text="Información del documento"/><StrRes Name="8972" T' + 
'ext="Información"/><StrRes Name="8973" Text="Título"/><StrRes Name="8974" Text="Autor"/><StrRes Name="8975" Text="Asunto"/><StrRes Name="8976" Text=' + 
'"Palabras clave"/><StrRes Name="8977" Text="Creador"/><StrRes Name="8978" Text="Productor"/><StrRes Name="8979" Text="Autentificación"/><StrRes Name=' + 
'"8980" Text="Permisos"/><StrRes Name="8981" Text="Visor"/><StrRes Name="8982" Text="Preferencias del visor"/><StrRes Name="8983" Text="Ocultar barra d' + 
'e herramientas"/><StrRes Name="8984" Text="Ocultar barra de menú"/><StrRes Name="8985" Text="Ocultar ventana de usuario"/><StrRes Name="8986" Text="A' + 
'justar ventana"/><StrRes Name="8987" Text="Centrar ventana"/><StrRes Name="8988" Text="Imprimir escalado"/><StrRes Name="8989" Text="Confirmación de ' + 
'lectura"/><StrRes Name="9000" Text="Recuento de Filas:"/><StrRes Name="9001" Text="Dividir por hoja"/><StrRes Name="9002" Text="No dividir por hoja"/>' + 
'<StrRes Name="9003" Text="Usar páginas del informe"/><StrRes Name="9004" Text="Usar impresión del ancestro"/><StrRes Name="9101" Text="Exportar a DB' + 
'F"/><StrRes Name="9102" Text="dBase (DBF) exportación"/><StrRes Name="9103" Text=".dbf"/><StrRes Name="9104" Text="No se ha podido cargar el fichero"' + 
'/><StrRes Name="9105" Text="Fallo"/><StrRes Name="9106" Text="Nombres de campos"/><StrRes Name="9107" Text="Automáticamente"/><StrRes Name="9108" Tex' + 
't="Manualmente"/><StrRes Name="9109" Text="Cargar desde fichero"/><StrRes Name="9110" Text="Ficheros de texto (*.txt)|*.txt|Todos los ficheros|*.*"/><' + 
'StrRes Name="9111" Text="Ficheros DBF (*.dbf)|*.dbf|Todos los ficheros|*.*"/><StrRes Name="9151" Text="Fichero Excel 97/2000/XP"/><StrRes Name="9152" ' + 
'Text="Fichero auto creado"/><StrRes Name="9153" Text="Opciones"/><StrRes Name="9154" Text="Página"/><StrRes Name="9155" Text="Líneas de rejilla"/><S' + 
'trRes Name="9156" Text="Todas en una página"/><StrRes Name="9157" Text="Agrupación de datos"/><StrRes Name="9158" Text="Similar al informe"/><StrRes' + 
' Name="9159" Text="Trozos. Cada fragmento tiene (líneas):"/><StrRes Name="9160" Text="El tamaño del trozo debe ser un valor entero no negativo."/><S' + 
'trRes Name="9161" Text="Una sóla hoja debe ser Falso cuando se exporta por trozos"/><StrRes Name="9162" Text="Autor"/><StrRes Name="9163" Text="Comen' + 
'tarios"/><StrRes Name="9164" Text="Palabras clave"/><StrRes Name="9165" Text="Revisión"/><StrRes Name="9166" Text="Versión"/><StrRes Name="9167" Tex' + 
't="Aplicación"/><StrRes Name="9168" Text="Asunto"/><StrRes Name="9169" Text="Categoría"/><StrRes Name="9170" Text="Compañía"/><StrRes Name="9171" ' + 
'Text="Título"/><StrRes Name="9172" Text="Administrador"/><StrRes Name="9173" Text="General"/><StrRes Name="9174" Text="Información"/><StrRes Name="9' + 
'175" Text="Protección"/><StrRes Name="9176" Text="Contraseña"/><StrRes Name="9177" Text="Si se establece una contraseña, el documento generado esta' + 
'rá protegido con esta contraseña. Ésta se guarda siempre en caracteres Unicode y debe tener menos de 256 caracteres."/><StrRes Name="9178" Text="Co' + 
'nfirmación"/><StrRes Name="9179" Text="La confirmación de la contraseña no coincide. Escriba la contraseña de nuevo."/><StrRes Name="9180" Text="S' + 
'e intenta establecer una contraseña de %d caracteres. El máximo permitido es de %d caracteres."/><StrRes Name="9181" Text="Ajustar tamaño de la pá' + 
'gina"/><StrRes Name="9182" Text="Exportar a Excel 97/2000/XP"/><StrRes Name="9183" Text="Borrar líneas vacías"/><StrRes Name="9184" Text="Exportar f' + 
'ormulas"/><StrRes Name="9185" Text="Solo datos"/><StrRes Name="BiffCol" Text="Redimensionando columnas"/><StrRes Name="BiffRow" Text="Redimensionando ' + 
'filas"/><StrRes Name="BiffCell" Text="Exportando celdas"/><StrRes Name="BiffImg" Text="Exportando imágenes"/><StrRes Name="9200" Text="Microsoft Exce' + 
'l XML"/><StrRes Name="9201" Text="Microsoft PowerPoint XML"/><StrRes Name="9203" Text="Microsoft Word XML"/><StrRes Name="9204" Text="Archivos Microso' + 
'ft Excel XML (*.xlsx)|*.xlsx|Todos los archivos|*.*"/><StrRes Name="9205" Text="Archivos Microsoft PowerPoint XML (*.pptx)|*.pptx|Todos los archivos|*' + 
'.*"/><StrRes Name="9206" Text="Archivos Microsoft Word XML (*.docx)|*.docx|Todos los archivos|*.*"/><StrRes Name="9300" Text="HTML con capas"/><StrRes' + 
' Name="9301" Text="Ficheros HTML (*.html)|*.html|Todos los ficheros|*.*"/><StrRes Name="9302" Text="Exportación de HTML con capas"/><StrRes Name="930' + 
'3" Text="HTML5 con capas"/><StrRes Name="9304" Text="HTML4 con capas"/><StrRes Name="9305" Text="Exportar a HTML con capas"/><StrRes Name="9400" Text=' + 
'"Reordenando componentes"/><StrRes Name="9401" Text="Representando componentes"/><StrRes Name="9402" Text="Ajustando la intersección de componentes"/' + 
'><StrRes Name="9403" Text="Quitando lineas vacías"/><StrRes Name="9404" Text="Ajustando marcos"/><StrRes Name="9405" Text="Dividiendo celdas grandes"' + 
'/><StrRes Name="9406" Text="Componiendo fichero BIFF"/><StrRes Name="xProto" Text="Prototipo de exportación"/><StrRes Name="xBlank" Text="Exportació' + 
'n vacía"/><StrRes Name="expMailAddr" Text="Dirección o direcciones delimitadas por comas"/><StrRes Name="9500" Text="Exportar a SVG"/><StrRes Name="' + 
'9512" Text="Imágenes unificadas"/><StrRes Name="9513" Text="Formateado"/><StrRes Name="9520" Text="Exportar a ZPL"/><StrRes Name="9521" Text="Imprimi' + 
'r como bitmap"/><StrRes Name="9522" Text="Separar filas"/><StrRes Name="9523" Text="Archivo ZPL..."/><StrRes Name="9530" Text="Exportar a PS"/><StrRes' + 
' Name="9531" Text="Tiene múltiples ficheros"/><StrRes Name="9532" Text="Inclur imágenes"/><StrRes Name="9540" Text="Exportar a PPML"/><StrRes Name="' + 
'HTMLExtension" Text=".html"/><StrRes Name="SVGDescription" Text="Fichero SVG"/><StrRes Name="SVGFilter"      Text="Fichero SVG (*.svg)|*.svg"/><StrRes' + 
' Name="SVGExtension"   Text=".svg"/><StrRes Name="ZPLFilter"      Text="Fichero ZPL (*.zpl)|*.zpl"/><StrRes Name="ZPLExtension"   Text=".zpl"/><StrRes' + 
' Name="PSFilter"      Text="Fichero PS (*.ps)|*.ps"/><StrRes Name="PSExtension"   Text=".ps"/><StrRes Name="PPMLFilter"      Text="Fichero PPML (*.ppm' + 
'l)|*.ppml"/><StrRes Name="PPMLExtension"   Text=".ppml"/><StrRes Name="PPMLexport"   Text="Exportar a PPML..."/><StrRes Name="PSexport"   Text="Export' + 
'ar a PS..."/><StrRes Name="10000" Text="Typo de diseño"/><StrRes Name="10001" Text="Tabla - diseño tabular de el informe"/><StrRes Name="10002" Text' + 
'="Objecto - diseño con posición de objetos flotantes"/><StrRes Name="10003" Text="Texto - no implementado"/><StrRes Name="10100" Text="Error de firm' + 
'a"/><StrRes Name="10101" Text="Guardar registro"/><StrRes Name="10102" Text="Ignorar certificado"/><StrRes Name="WrongPassword" Text="Palabra de pasro' + 
' errónea"/><StrRes Name="UnknownHashAlgorithm" Text="Algoritmo Hash desconocido"/><StrRes Name="UnknownChipherAlgorithm" Text="Algoritmo de cifrado d' + 
'esconocido"/><StrRes Name="InvalidASN1File" Text="Ficchero de certificado no válido"/><StrRes Name="CantParseCertificate" Text="No se puede analizar ' + 
'el cedtificado"/><StrRes Name="PrepareSignError" Text="Error de preparación de firma"/><StrRes Name="SignDigestError" Text="Error de asimilación de ' + 
'firma"/><StrRes Name="CertificateNotFound" Text="No se encontró el archivo de certificado"/></Resources>' + 
' ';

initialization
  frxResources.AddXML(resXML);

end.
