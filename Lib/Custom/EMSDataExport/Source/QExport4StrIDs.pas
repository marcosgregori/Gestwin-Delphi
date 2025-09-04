unit QExport4StrIDs;

interface

const
  QERes = 32000;

  SMSExcelFilter = QERes + 2000;
  SMSAccessFilter = QERes + 2001;
  SMSAccess2007Filter = QERes + 2902;
  SMSWordFilter  = QERes + 2002;
  SRTFFilter     = QERes + 2003;
  SHTMLFilter    = QERes + 2004;
  SPDFFilter     = QERes + 2005;
  STextFilter    = QERes + 2006;
  SXMLFilter     = QERes + 2007;
  SCSVFilter     = QERes + 2008;
  SDIFFFilter    = QERes + 2009;
  SSYLKFilter    = QERes + 2010;
  SLaTeXFilter   = QERes + 2011;
  SSQLFilter     = QERes + 2012;
  SDBFFilter     = QERes + 2013;
  SODSFilter     = QERes + 2600;
  SODTFilter     = QERes + 2601;
  SXLSXFilter     = QERes + 2727;
  SDOCXFilter     = QERes + 2728;

  QEM_ExportSourceNotAssigned = QERes + 2014;
  QEM_DefineSheetError        = QERes + 2015;
  QEM_ExportSourceNotActive   = QERes + 2016;
  QEM_ExportSourceEmpty       = QERes + 2017;
  QEM_AllowedExportsEmpty     = QERes + 2018;
  QEM_StopExportCaption       = QERes + 2019;
  QEM_StopExportConfirm       = QERes + 2020;
  QEM_NewFormatValue          = QERes + 2021;
  QEM_EnterValue              = QERes + 2022;
  QEM_FileNotPresent          = QERes + 2023;
  QEM_ExportAccessOleError    = QERes + 2024;
  QEM_CreateAccessDatabaseError = QERes + 2903;
  QEM_DirNotFound             = QERes + 2025;

  QEPF_Letter         = QERes + 2026;
  QEPF_Legal          = QERes + 2027;
  QEPF_A3             = QERes + 2028;
  QEPF_A4             = QERes + 2029;
  QEPF_A5             = QERes + 2030;
  QEPF_B5_JIS         = QERes + 2031;
  QEPF_US_Std_Fanfold = QERes + 2032;
  QEPF_Fanfold        = QERes + 2033;
  QEPF_User           = QERes + 2034;

  QEUN_Inch           = QERes + 2035;
  QEUN_Millimeter     = QERes + 2036;
  QEUN_Dot            = QERes + 2037;

  QEPO_Portrait       = QERes + 2038;
  QEPO_Landscape      = QERes + 2039;

  QED_Title = QERes + 2040;
  QED_AdvancedTitle = QERes + 2041;
  QED_CloseButtonCaption = QERes + 2042;
  QED_ExportTitle = QERes + 2043;
  QED_CancelButtonCaption = QERes + 2044;
  QED_FileName = QERes + 2045;
  QED_SelectFile = QERes + 2046;
  QED_OpenAfterExport = QERes + 2047;
  QED_PrintAfterExport = QERes + 2048;

  // Export Type
  QED_ExportType_Title = QERes + 2049;
  QED_ExportType_Formats = QERes + 2050;
  QED_ExportType_ExportTo = QERes + 2051;
  QED_ExportType_XLS = QERes + 2052;
  QED_ExportType_Access = QERes + 2053;
  QED_ExportType_Access2007 = QERes + 2900;
  QED_ExportType_DOC = QERes + 2054;
  QED_ExportType_RTF = QERes + 2055;
  QED_ExportType_HTML = QERes + 2056;
  QED_ExportType_PDF = QERes + 2057;
  QED_ExportType_TXT = QERes + 2058;
  QED_ExportType_XML = QERes + 2059;
  QED_ExportType_DBF = QERes + 2060;
  QED_ExportType_CSV = QERes + 2061;
  QED_ExportType_DIFF = QERes + 2062;
  QED_ExportType_SYLK = QERes + 2063;
  QED_ExportType_LaTeX = QERes + 2064;
  QED_ExportType_SQL = QERes + 2065;
  QED_ExportType_Clipboard = QERes + 2066;
  QED_ExportType_ODS = QERes + 2602;
  QED_ExportType_ODT = QERes + 2603;
  QED_ExportType_XLSX = QERes + 2725;
  QED_ExportType_DOCX = QERes + 2726;

  QED_ExportType_Options = QERes + 2067;
  QED_ExportType_Constraints = QERes + 2068;
  QED_ExportType_Options_GoToFirstRecord = QERes + 2069;
  QED_ExportType_Options_CurrentRecordOnly = QERes + 2070;
  QED_ExportType_Options_ExportEmpty = QERes + 2071;
  QED_ExportType_ExportAllRecords = QERes + 2072;
  QED_ExportType_Options_ExportRecCount = QERes + 2073;
  QED_ExportType_Options_SkipRecCount = QERes + 2074;
  QED_ExportType_Options_Records = QERes + 2075;

  QED_Tools = QERes + 2076;
  QED_ExportType_Save = QERes + 2077;
  QED_ExportType_Load = QERes + 2078;

  QED_ExportType_Start = QERes + 2079;
  QED_ExportType_Close = QERes + 2080;

  // Fields
  QED_Fields_Title = QERes + 2081;
  QED_Fields_Available = QERes + 2082;
  QED_Fields_Exported = QERes + 2083;
  QED_Fields_Add = QERes + 2084;
  QED_Fields_AddAll = QERes + 2085;
  QED_Fields_Remove = QERes + 2086;
  QED_Fields_RemoveAll = QERes + 2087;
  QED_Fields_ShowDisplayLabel = QERes + 2821;

  // Formats
  QED_Formats_Title = QERes + 2088;
  QED_Formats_Common = QERes + 2089;
  QED_Formats_Integer = QERes + 2090;
  QED_Formats_Float = QERes + 2091;
  QED_Formats_Date = QERes + 2092;
  QED_Formats_Time = QERes + 2093;
  QED_Formats_DateTime  = QERes + 2094;
  QED_Formats_Currency = QERes + 2095;
  QED_Formats_BooleanTrue = QERes + 2096;
  QED_Formats_BooleanFalse = QERes + 2097;
  QED_Formats_NullString = QERes + 2098;
  QED_Formats_User = QERes + 2099;
  QED_Formats_Add = QERes + 2100;
  QED_Formats_Edit = QERes + 2101;
  QED_Formats_Delete = QERes + 2102;
  QED_Formats_Clear = QERes + 2103;
  
  QED_Formats_Separators = QERes + 2769;
  QED_Formats_DecimalSeparator = QERes + 2770;
  QED_Formats_DateSeparator = QERes + 2771;
  QED_Formats_ThousandSeparator = QERes + 2772;
  QED_Formats_TimeSeparator = QERes + 2773;

  // Header & Footer
  QED_Header_Footer_Title = QERes + 2104;
  QED_Header_Footer_Header = QERes + 2105;
  QED_Header_Footer_Footer = QERes + 2106;

  // Captions
  QED_Captions_AllowCaptions = QERes + 2107;
  QED_Captions_Title = QERes + 2108;
  QED_Captions_FeldName = QERes + 2109;
  QED_Captions_Caption = QERes + 2110;
  QED_Captions_Width = QERes + 2111;
  QED_Captions_Align = QERes + 2112;
  QED_Align_Left = QERes + 2113;
  QED_Align_Right = QERes + 2114;
  QED_Align_Center = QERes + 2115;
  QED_StringGrid_CaptionRow = QERes + 2116;

  // Word / RTF
  QED_RTF_Title = QERes + 2117;
  QED_RTF_DataStyles = QERes + 2118;
  QED_RTF_BaseStyles = QERes + 2119;
  QED_RTF_StripStyles = QERes + 2120;
  QED_RTF_AddRTFStyle = QERes + 2121;
  QED_RTF_DelRTFStyle = QERes + 2122;
  QED_RTF_MoveRTFStyleUp = QERes + 2123;
  QED_RTF_MoveRTFStyleDown = QERes + 2124;
  QED_RTF_LoadRTFStyle = QERes + 2125;
  QED_RTF_SaveRTFStyle = QERes + 2126;
  QED_RTF_StripType = QERes + 2127;
  QED_RTF_StripType_None = QERes + 2128;
  QED_RTF_StripType_Col = QERes + 2129;
  QED_RTF_StripType_Row = QERes + 2130;
  QED_RTF_Font = QERes + 2131;
  QED_RTF_FontSize = QERes + 2132;
  QED_RTF_FontColor = QERes + 2133;
  QED_RTF_FontBold = QERes + 2134;
  QED_RTF_FontItalic = QERes + 2135;
  QED_RTF_FontStrikeOut = QERes + 2136;
  QED_RTF_FontUnderline = QERes + 2137;
  QED_RTF_Left = QERes + 2138;
  QED_RTF_Center = QERes + 2139;
  QED_RTF_Right = QERes + 2140;
  QED_RTF_Fill = QERes + 2141;
  QED_RTF_BackgroundColor = QERes + 2142;
  QED_RTF_HighlightColor = QERes + 2143;
  QED_RTF_AllowBackground = QERes + 2144;
  QED_RTF_AllowHighlight = QERes + 2145;
  QED_RTF_Sample = QERes + 2146;
  QED_RTF_Advanced = QERes + 2147;
  QED_RTF_PageOrientation = QERes + 2148;

  QED_RTF_Reset_Item = QERes + 2149;
  QED_RTF_Reset_SelectedItems = QERes + 2150;
  QED_RTF_Reset_All = QERes + 2151;
  QED_RTF_Reset_All_Question_Caption = QERes + 2152;
  QED_RTF_Reset_All_Question = QERes + 2153;

  QED_RTF_Header = QERes + 2154;
  QED_RTF_Caption = QERes + 2155;
  QED_RTF_Data = QERes + 2156;
  QED_RTF_Footer = QERes + 2157;

  QED_RTF_StyleItem = QERes + 2158;

  // XML
  QED_XML_Title = QERes + 2159;
  QED_XML_Standalone = QERes + 2160;
  QED_XML_Encoding = QERes + 2161;

  // SQL
  QED_SQL_Title = QERes + 2162;
  QED_SQL_TableOptions = QERes + 2163;
  QED_SQL_AddCreateTable = QERes + 2164;
  QED_SQL_TableName = QERes + 2165;
  QED_SQL_Commit = QERes + 2166;
  QED_SQL_CommitAfter_01 = QERes + 2167;
  QED_SQL_CommitAfter_02 = QERes + 2168;
  QED_SQL_CommitAfterScript = QERes + 2169;
  QED_SQL_CommitStatement = QERes + 2170;
  QED_SQL_Other = QERes + 2171;
  QED_SQL_NullAs = QERes + 2172;
  QED_SQL_StatementTerm = QERes + 2173;

  // HTML
  QED_HTML_Title = QERes + 2174;
  QED_HTML_Preview_Title = QERes + 2175;
  QED_HTML_Preview_DefaultText = QERes + 2176;
  QED_HTML_Preview_NonVisitedLink = QERes + 2177;
  QED_HTML_Preview_VisitedLink = QERes + 2178;
  QED_HTML_Preview_ActiveLink = QERes + 2179;
  QED_HTML_Preview_Template = QERes + 2180;
  QED_HTML_Preview_SaveTemplate = QERes + 2181;
  QED_HTML_Preview_LoadTemplate = QERes + 2182;

  QED_HTML_Basic_Title = QERes + 2183;
  QED_HTML_Basic_PageTitle = QERes + 2184;
  QED_HTML_Basic_CSS = QERes + 2185;
  QED_HTML_Basic_CSSInternal = QERes + 2186;
  QED_HTML_Basic_CSSExternal = QERes + 2187;
  QED_HTML_Basic_CSSFileName = QERes + 2188;
  QED_HTML_Basic_OverwriteCSSFile = QERes + 2189;

  QED_HTML_Multifile_Title = QERes + 2190;
  QED_HTML_MultiFile_IndexLinkTemplate = QERes + 2191;

  QED_HTML_Basic_MultiFile_Options = QERes + 2192;
  QED_HTML_Basic_MultiFile_Use = QERes + 2193;
  QED_HTML_Basic_MultiFile_RecCount_01 = QERes + 2194;
  QED_HTML_Basic_MultiFile_RecCount_02 = QERes + 2195;
  QED_HTML_Basic_MultiFile_GenerateIndex = QERes + 2196;
  QED_HTML_Basic_MultiFile_Navigation = QERes + 2197;
  QED_HTML_Basic_MultiFile_Navigation_OnTop = QERes + 2198;
  QED_HTML_Basic_MultiFile_Navigation_OnBottom = QERes + 2199;
  QED_HTML_Basic_MultiFile_IndexLinkTitle = QERes + 2200;
  QED_HTML_Basic_MultiFile_FirstLinkTitle = QERes + 2201;
  QED_HTML_Basic_MultiFile_PriorLinkTitle = QERes + 2202;
  QED_HTML_Basic_MultiFile_NextLinkTitle = QERes + 2203;
  QED_HTML_Basic_MultiFile_LastLinkTitle = QERes + 2204;

  QED_HTML_Advanced_Title = QERes + 2205;
  QED_HTML_Advanced_Body_Options = QERes + 2206;
  QED_HTML_Advanced_Body_FontName = QERes + 2207;
  QED_HTML_Advanced_Body_Background = QERes + 2208;
  QED_HTML_Advanced_Body_Attributes = QERes + 2209;
  QED_HTML_Advanced_Table_Options = QERes + 2210;
  QED_HTML_Advanced_Table_CellPadding = QERes + 2211;
  QED_HTML_Advanced_Table_CellSpasing = QERes + 2212;
  QED_HTML_Advanced_Table_Border = QERes + 2213;
  QED_HTML_Advanced_Table_Background = QERes + 2214;
  QED_HTML_Advanced_Table_Attributes = QERes + 2215;

  // XLS
  QED_XLS_Title = QERes + 2216;
  QED_XLS_Advanced_Title = QERes + 2217;
  QED_XLS_Page_Header = QERes + 2218;
  QED_XLS_Page_Footer = QERes + 2219;
  QED_XLS_Sheet_Title = QERes + 2220;
  QED_XLS_AutoCalcColWidth = QERes + 2221;
  QED_XLS_AutoAddSheet = QERes + 2823;
  QED_XLS_AutoTruncateValue = QERes + 2824;
  QED_XLS_Page_Background = QERes + 2222;
  QED_XLS_PrintColumnHeaders = QERes + 2820;

  QED_XLS_DataFormat_Title = QERes + 2223;

  QED_XLS_DataFormat_Fields = QERes + 2224;
  QED_XLS_DataFormat_Options = QERes + 2225;
  QED_XLS_DataFormat_Styles = QERes + 2226;
  QED_XLS_DataFormat_Styles_Add = QERes + 2227;
  QED_XLS_DataFormat_Styles_Del = QERes + 2228;
  QED_XLS_DataFormat_Styles_Up = QERes + 2229;
  QED_XLS_DataFormat_Styles_Down = QERes + 2230;
  QED_XLS_DataFormat_Styles_Save = QERes + 2231;
  QED_XLS_DataFormat_Styles_Load = QERes + 2232;
  QED_XLS_DataFormat_Styles_StripStyle_Caption = QERes + 2233;
  QED_XLS_DataFormat_Styles_StripStyle_None = QERes + 2234;
  QED_XLS_DataFormat_Styles_StripStyle_Col = QERes + 2235;
  QED_XLS_DataFormat_Styles_StripStyle_Row = QERes + 2236;

  QED_XLS_Reset_Item = QERes + 2237;
  QED_XLS_Reset_SelectedItems = QERes + 2238;
  QED_XLS_Reset_All = QERes + 2239;
  QED_XLS_Reset_All_Question_Caption = QERes + 2240;
  QED_XLS_Reset_All_Question = QERes + 2241;

  QED_XLS_SampleCell = QERes + 2242;

  QED_XLS_Header = QERes + 2243;
  QED_XLS_Caption = QERes + 2244;
  QED_XLS_Data = QERes + 2245;
  QED_XLS_Aggregate = QERes + 2246;
  QED_XLS_Footer = QERes + 2247;
  QED_XLS_Hyperlink = QERes + 2248;
  QED_XLS_Note = QERes + 2249;
  QED_XLS_StripStyle = QERes + 2250;
  QED_XLS_Cell = QERes + 2251;

  QED_XLS_StyleItem = QERes + 2252;

  QED_XLS_Font_Title = QERes + 2253;
  QED_XLS_Font = QERes + 2254;
  QED_XLS_FontSize = QERes + 2255;
  QED_XLS_Font_Color = QERes + 2256;
  QED_XLS_Font_Bold = QERes + 2257;
  QED_XLS_Font_Italic = QERes + 2258;
  QED_XLS_Font_StrikeOut = QERes + 2259;
  QED_XLS_Underline_Single = QERes + 2260;
  QED_XLS_Underline_Single_Accounting = QERes + 2261;
  QED_XLS_Underline_Double = QERes + 2262;
  QED_XLS_Underline_Double_Accounting = QERes + 2263;
  QED_XLS_Alignment_Horizontal_Left = QERes + 2264;
  QED_XLS_Alignment_Horizontal_Center = QERes + 2265;
  QED_XLS_Alignment_Horizontal_Right = QERes + 2266;
  QED_XLS_Alignment_Horizontal_Fill = QERes + 2267;
  QED_XLS_Alignment_Vertical_Top = QERes + 2268;
  QED_XLS_Alignment_Vertical_Center = QERes + 2269;
  QED_XLS_Alignment_Vertical_Bottom = QERes + 2270;

  QED_XLS_Borders_Title = QERes + 2271;
  QED_XLS_Border_None = QERes + 2272;
  QED_XLS_Border_Top = QERes + 2273;
  QED_XLS_Border_Top_Color = QERes + 2274;
  QED_XLS_Border_Bottom = QERes + 2275;
  QED_XLS_Border_Bottom_Color = QERes + 2276;
  QED_XLS_Border_Left = QERes + 2277;
  QED_XLS_Border_Left_Color = QERes + 2278;
  QED_XLS_Border_Right = QERes + 2279;
  QED_XLS_Border_Right_Color = QERes + 2280;

  QED_XLS_Fill_Title = QERes + 2281;
  QED_XLS_Fill_Background = QERes + 2282;
  QED_XLS_Fill_Pattern_None = QERes + 2283;
  QED_XLS_Fill_Foreground = QERes + 2284;

  QED_XLS_Aggregate_Title = QERes + 2285;
  QED_XLS_Function = QERes + 2286;
  QED_XLS_Function_None = QERes + 2287;
  QED_XLS_Function_Sum = QERes + 2288;
  QED_XLS_Function_Avg = QERes + 2289;
  QED_XLS_Function_Min = QERes + 2290;
  QED_XLS_Function_Max = QERes + 2291;

  QED_XLS_Extensions = QERes + 2292;

  QED_XLS_Hyperlinks = QERes + 2293;
  QED_XLS_AddHyperlink = QERes + 2294;
  QED_XLS_DelHyperlink = QERes + 2295;
  QED_XLS_Hyperlink_DefaultTitle = QERes + 2296;
  QED_XLS_Hyperlink_Col = QERes + 2297;
  QED_XLS_Hyperlink_Row = QERes + 2298;
  QED_XLS_Hyperlink_Style = QERes + 2299;
  QED_XLS_Hyperlink_Style_URL = QERes + 2300;
  QED_XLS_Hyperlink_Style_LocalFile = QERes + 2301;
  QED_XLS_Hyperlink_Title = QERes + 2302;
  QED_XLS_Hyperlink_Target = QERes + 2303;
  QED_XLS_Hyperlink_ScreenTip = QERes + 2304;

  QED_XLS_Notes = QERes + 2305;
  QED_XLS_AddNote = QERes + 2306;
  QED_XLS_DelNote = QERes + 2307;
  QED_XLS_Note_DefaultTitle = QERes + 2308;
  QED_XLS_Note_Base = QERes + 2309;
  QED_XLS_Note_Col = QERes + 2310;
  QED_XLS_Note_Row = QERes + 2311;
  QED_XLS_Note_Lines = QERes + 2312;
  QED_XLS_Note_Font = QERes + 2313;
  QED_XLS_Note_FontName = QERes + 2314;
  QED_XLS_Note_FontSize = QERes + 2315;
  QED_XLS_Note_FontColor = QERes + 2316;
  QED_XLS_Note_FontBold = QERes + 2317;
  QED_XLS_Note_FontItalic = QERes + 2318;
  QED_XLS_Note_FontStrikeOut = QERes + 2319;
  QED_XLS_Note_Underline_Single = QERes + 2320;
  QED_XLS_Note_Underline_SingleAccounting = QERes + 2321;
  QED_XLS_Note_Underline_Double = QERes + 2322;
  QED_XLS_Note_Underline_DoubleAccounting = QERes + 2323;
  QED_XLS_Note_Horizontal_Left = QERes + 2324;
  QED_XLS_Note_Horizontal_Center = QERes + 2325;
  QED_XLS_Note_Horizontal_Right = QERes + 2326;
  QED_XLS_Note_Horizontal_Fill = QERes + 2327;
  QED_XLS_Note_Vertical_Top = QERes + 2328;
  QED_XLS_Note_Vertical_Center = QERes + 2329;
  QED_XLS_Note_Vertical_Bottom = QERes + 2330;
  QED_XLS_Note_Orientation = QERes + 2331;
  QED_XLS_Note_Orientation_NoRotation = QERes + 2332;
  QED_XLS_Note_Orientation_TopToBottom = QERes + 2333;
  QED_XLS_Note_Orientation_CounterClockWise = QERes + 2334;
  QED_XLS_Note_Orientation_ClockWise = QERes + 2335;
  QED_XLS_Note_Fill = QERes + 2336;
  QED_XLS_Note_FillType = QERes + 2337;
  QED_XLS_Note_FillType_Solid = QERes + 2338;
  QED_XLS_Note_FillType_Gradient = QERes + 2339;
  QED_XLS_Note_Gradient_Horizontal = QERes + 2340;
  QED_XLS_Note_Gradient_Vertical = QERes + 2341;
  QED_XLS_Note_Gradient_DiagonalUp = QERes + 2342;
  QED_XLS_Note_Gradient_DiagonalDown = QERes + 2343;
  QED_XLS_Note_Gradient_FromCorner = QERes + 2344;
  QED_XLS_Note_Gradient_FromCenter = QERes + 2345;
  QED_XLS_Note_BackgroundColor = QERes + 2346;
  QED_XLS_Note_ForegroundColor = QERes + 2347;
  QED_XLS_Note_Transparency = QERes + 2348;

  QED_XLS_Charts = QERes + 2349;
  QED_XLS_AddChart = QERes + 2350;
  QED_XLS_DelChart = QERes + 2351;
  QED_XLS_Chart_DefaultTitle = QERes + 2352;
  QED_XLS_Chart_Base = QERes + 2353;
  QED_XLS_Chart_Title = QERes + 2354;
  QED_XLS_Chart_Style = QERes + 2355;
  QED_XLS_Chart_Style_Column = QERes + 2356;
  QED_XLS_Chart_Style_Column3D = QERes + 2357;
  QED_XLS_Chart_Style_Bar = QERes + 2358;
  QED_XLS_Chart_Style_Bar3D = QERes + 2359;
  QED_XLS_Chart_Style_Line = QERes + 2360;
  QED_XLS_Chart_Style_LineMark = QERes + 2361;
  QED_XLS_Chart_Style_Line3D = QERes + 2362;
  QED_XLS_Chart_Style_Pie = QERes + 2363;
  QED_XLS_Chart_Style_Pie3D = QERes + 2364;
  QED_XLS_Chart_Style_Area = QERes + 2365;
  QED_XLS_Chart_Style_Area3D = QERes + 2366;
  QED_XLS_Chart_Style_Surface = QERes + 2367;
  QED_XLS_Chart_Style_Surface3D = QERes + 2368;
  QED_XLS_Chart_Style_Radar = QERes + 2369;
  QED_XLS_Chart_Style_RadarArea = QERes + 2370;
  QED_XLS_Chart_Position = QERes + 2371;
  QED_XLS_Chart_AutoPosition = QERes + 2372;
  QED_XLS_Chart_Placement = QERes + 2373;
  QED_XLS_Chart_Placement_Bottom = QERes + 2374;
  QED_XLS_Chart_Placement_Right = QERes + 2375;
  QED_XLS_Chart_Left = QERes + 2376;
  QED_XLS_Chart_Top = QERes + 2377;
  QED_XLS_Chart_Height = QERes + 2378;
  QED_XLS_Chart_Width = QERes + 2379;
  QED_XLS_Chart_CustomPosition = QERes + 2380;
  QED_XLS_Chart_Position_X1 = QERes + 2381;
  QED_XLS_Chart_Position_Y1 = QERes + 2382;
  QED_XLS_Chart_Position_X2 = QERes + 2383;
  QED_XLS_Chart_Position_Y2 = QERes + 2384;
  QED_XLS_Chart_CategoryLabels = QERes + 2385;
  QED_XLS_Chart_CategoryLabel_Column = QERes + 2386;
  QED_XLS_Chart_CategoryLabel_Custom = QERes + 2387;
  QED_XLS_Chart_CategoryLabels_Col1 = QERes + 2388;
  QED_XLS_Chart_CategoryLabels_Row1 = QERes + 2389;
  QED_XLS_Chart_CategoryLabels_Col2 = QERes + 2390;
  QED_XLS_Chart_CategoryLabels_Row2 = QERes + 2391;
  QED_XLS_Chart_LegendPosition = QERes + 2392;
  QED_XLS_Chart_LegendPosition_Bottom = QERes + 2393;
  QED_XLS_Chart_LegendPosition_Corner = QERes + 2394;
  QED_XLS_Chart_LegendPosition_Top = QERes + 2395;
  QED_XLS_Chart_LegendPosition_Right = QERes + 2396;
  QED_XLS_Chart_LegendPosition_Left = QERes + 2397;
  QED_XLS_Chart_ShowLegend = QERes + 2398;
  QED_XLS_Chart_AutoColor = QERes + 2399;

  QED_XLS_Series = QERes + 2400;
  QED_XLS_AddSeries = QERes + 2401;
  QED_XLS_DelSeries = QERes + 2402;
  QED_XLS_Series_DefaultTitle = QERes + 2403;
  QED_XLS_Series_Title = QERes + 2404;
  QED_XLS_Series_DataRange = QERes + 2405;
  QED_XLS_Series_Column = QERes + 2406;
  QED_XLS_Series_Custom = QERes + 2407;
  QED_XLS_Series_DataRange_Col1 = QERes + 2408;
  QED_XLS_Series_DataRange_Row1 = QERes + 2409;
  QED_XLS_Series_DataRange_Col2 = QERes + 2410;
  QED_XLS_Series_DataRange_Row2 = QERes + 2411;
  QED_XLS_Series_Color = QERes + 2412;

  QED_XLS_Cells = QERes + 2413;
  QED_XLS_AddCell = QERes + 2414;
  QED_XLS_DelCell = QERes + 2415;
  QED_XLS_Cell_DisplayName = QERes + 2416;
  QED_XLS_Cell_Base = QERes + 2417;
  QED_XLS_Cell_Col = QERes + 2418;
  QED_XLS_Cell_Row = QERes + 2419;
  QED_XLS_Cell_Type = QERes + 2420;
  QED_XLS_Cell_Type_Boolean = QERes + 2421;
  QED_XLS_Cell_Type_DateTime = QERes + 2422;
  QED_XLS_Cell_Type_Numeric = QERes + 2423;
  QED_XLS_Cell_Type_String = QERes + 2424;
  QED_XLS_Cell_Value = QERes + 2425;
  QED_XLS_Cell_DateTimeFormat = QERes + 2426;
  QED_XLS_Cell_NumericFormat = QERes + 2427;

  QED_XLS_MergedCells = QERes + 2428;
  QED_XLS_AddMergedCell = QERes + 2429;
  QED_XLS_DelMergedCell = QERes + 2430;
  QED_XLS_MergedCell_DefaultTitle = QERes + 2431;
  QED_XLS_MergedCell_FirstCol = QERes + 2432;
  QED_XLS_MergedCell_FirstRow = QERes + 2433;
  QED_XLS_MergedCell_LastCol = QERes + 2434;
  QED_XLS_MergedCell_LastRow = QERes + 2435;

  QEE_Caption = QERes + 2436;
  QEE_XLS_ExportSourceConfirm = QERes + 2437;

  QEE_XLS_Confirm = QERes + 2438;
  QEE_XLS_NewSheet = QERes + 2439;
  QEE_XLS_AddNewSheet = QERes + 2440;
  QEE_XLS_DefineSheetTitle = QERes + 2441;
  QEE_XLS_EditSheet = QERes + 2442;
  QEE_XLS_EditSheetTitle = QERes + 2443;
  QEE_XLS_SheetTitleIsEmpty = QERes + 2444;
  QEE_XLS_ColumnName = QERes + 2445;
  QEE_XLS_AddFieldFormat = QERes + 2446;
  QEE_XLS_DefineColumnName = QERes + 2447;
  QEE_XLS_ColumnAlreadyExists = QERes + 2448;
  QEE_XLS_EditColumnName = QERes + 2449;
  QEE_XLS_SetAllToDefaultConfirm = QERes + 2450;
  QEE_XLS_SetSelToDefaultConfirm = QERes + 2451;
  QEE_XLS_Question = QERes + 2452;
  QEE_XLS_ExportSourceUndefined = QERes + 2453;
  QEE_XLS_MaxRowsError = QERes + 2822;
  QED_XLS_DefRowHeight = QERes + 3000;
  QEE_XLS_MaxColsError = QERes + 3001;

  // ASCII
  QED_ASCII_Title = QERes + 2454;
  QED_TXT_Title = QERes + 2455;
  QED_TXT_AutoCalcColWidth = QERes + 2456;
  QED_TXT_Spacing = QERes + 2457;
  QED_CSV_Title = QERes + 2458;
  QED_CSV_QuoteStrings = QERes + 2459;
  QED_CSV_Comma = QERes + 2460;
  QED_CSV_Quote = QERes + 2461;

  // Access
  QED_Access_Title = QERes + 2462;
  QED_Access_TableOptions = QERes + 2463;
  QED_Access_TableName = QERes + 2464;
  QED_Access_CreateTable = QERes + 2465;

  // PDF
  QED_PDF_Title = QERes + 2466;
  QED_PDF_FontName = QERes + 2467;
  QED_PDF_FontEncoding = QERes + 2468;
  QED_PDF_FontSize = QERes + 2469;
  QED_PDF_FontColor = QERes + 2470;
  QED_PDF_Sample = QERes + 2471;

  QED_PDF_GridOptions = QERes + 2472;
  QED_PDF_ColSpacing = QERes + 2473;
  QED_PDF_RowSpacing = QERes + 2474;
  QED_PDF_GridLineWidth = QERes + 2475;

  QED_PDF_PageOptions = QERes + 2476;
  QED_PDF_PageSize = QERes + 2477;
  QED_PDF_PageWidth = QERes + 2478;
  QED_PDF_PageHeight = QERes + 2479;
  QED_PDF_PageUnits = QERes + 2480;
  QED_PDF_PageOrientation = QERes + 2481;
  QED_PDF_Margins = QERes + 2482;
  QED_PDF_MarginLeft = QERes + 2483;
  QED_PDF_MarginRight = QERes + 2484;
  QED_PDF_MarginTop = QERes + 2485;
  QED_PDF_MarginBottom = QERes + 2486;

  QED_PDF_HeaderFont = QERes + 2487;
  QED_PDF_CaptionFont = QERes + 2488;
  QED_PDF_DataFont = QERes + 2489;
  QED_PDF_FooterFont = QERes + 2490;
  //New PDF Section
  QED_PDF_UseUserFont = QERes + 2800;
  QED_PDF_UserFontName = QERes + 2801;
  QED_PDF_UserFontColor = QERes + 2802;
  QED_PDF_UserFontSize = QERes + 2803;
  QED_PDF_UserFontBold = QERes + 2804;
  QED_PDF_UserFontItalic = QERes + 2805;

  // ODS
  QED_ODS_Title = QERes + 2604;
  QED_ODS_Header = QERes + 2605;
  QED_ODS_CaptionRow = QERes + 2606;
  QED_ODS_Data = QERes + 2607;
  QED_ODS_Footer = QERes + 2608;
  QED_ODS_StripStyle = QERes + 2609;
  QED_ODS_StandardSheetName = QERes + 2610;
  QED_ODS_FontColor = QERes + 2611;
  QED_ODS_Bold = QERes + 2612;
  QED_ODS_Italic = QERes + 2613;
  QED_ODS_StrikeOut = QERes + 2614;
  QED_ODS_Underline = QERes + 2615;
  QED_ODS_LeftAlgmt = QERes + 2616;
  QED_ODS_RightAlgmt = QERes + 2617;
  QED_ODS_JustifyAlgmt = QERes + 2618;
  QED_ODS_TopAlgmt = QERes + 2619;
  QED_ODS_MiddleAlgmt = QERes + 2620;
  QED_ODS_BottomAlgmt = QERes + 2621;
  QED_ODS_BackgroundCaption = QERes + 2622;
  QED_ODS_BackgroundColor = QERes + 2623;
  QED_ODS_SheetName = QERes + 2624;
  QED_ODS_Options = QERes + 2625;
  QED_ODS_StripStyles = QERes + 2626;
  QED_ODS_SStyleAdd = QERes + 2627;
  QED_ODS_SStyleRemove = QERes + 2628;
  QED_ODS_SStyleUp = QERes + 2629;
  QED_ODS_SStyleDown = QERes + 2630;
  QED_ODS_UseBorder = QERes + 2631;
  QED_ODS_BorderColor = QERes + 2632;
  QED_ODS_CenterAlgmt = QERes + 2633;
  QED_ODS_BorderWidth = QERes + 2634;
  QED_ODS_SampleText = QERes + 2635;
  QED_ODS_FontName = QERes + 2636;
  QED_ODS_FontSize = QERes + 2637;
  QED_ODS_StripType = QERes + 2638;
  QED_ODS_StripNone = QERes + 2639;
  QED_ODS_StripColumn = QERes + 2640;
  QED_ODS_StripRow = QERes + 2641;
  QED_ODS_SaveStyle =  QERes + 2642;
  QED_ODS_LoadStyle = QERes + 2643;
  //dee
  QED_ODS_Font_Title = QERes + 2806;
  QED_ODS_Borders_Title = QERes + 2807;

  // ODT
  QED_ODT_Title = QERes + 2650;
  QED_ODT_Header = QERes + 2651;
  QED_ODT_CaptionRow = QERes + 2652;
  QED_ODT_Data = QERes + 2653;
  QED_ODT_Footer = QERes + 2654;
  QED_ODT_StripStyle = QERes + 2655;
  QED_ODT_StandardTableName = QERes + 2656;
  QED_ODT_TableName = QERes + 2657;
  QED_ODT_SStyleAdd = QERes + 2658;
  QED_ODT_SStyleRemove = QERes + 2659;
  QED_ODT_SStyleUp = QERes + 2660;
  QED_ODT_SStyleDown = QERes + 2661;
  QED_ODT_StripType = QERes + 2662;
  QED_ODT_StripNone = QERes + 2663;
  QED_ODT_StripColumn = QERes + 2664;
  QED_ODT_StripRow = QERes + 2665;
  QED_ODT_UseBorder = QERes + 2666;
  QED_ODT_BorderColor = QERes + 2667;
  QED_ODT_BorderWidth = QERes + 2668;
  QED_ODT_FontName = QERes + 2669;
  QED_ODT_FontSize = QERes + 2670;
  QED_ODT_FontColor = QERes + 2671;
  QED_ODT_Bold = QERes + 2672;
  QED_ODT_Italic = QERes + 2673;
  QED_ODT_StrikeOut = QERes + 2674;
  QED_ODT_Underline = QERes + 2675;
  QED_ODT_LeftAlgmt = QERes + 2676;
  QED_ODT_CenterAlgmt = QERes + 2677;
  QED_ODT_RightAlgmt = QERes + 2678;
  QED_ODT_JustifyAlgmt = QERes + 2679;
  QED_ODT_TopAlgmt = QERes + 2680;
  QED_ODT_MiddleAlgmt = QERes + 2681;
  QED_ODT_BottomAlgmt = QERes + 2682;
  QED_ODT_UseBackground = QERes + 2683;
  QED_ODT_BackgroundColor = QERes + 2684;
  QED_ODT_UseHighlight = QERes + 2685;
  QED_ODT_HighlightColor = QERes + 2686;
  QED_ODT_SampleText = QERes + 2687;
  QED_ODT_SaveStyle = QERes + 2644;
  QED_ODT_LoadStyle = QERes + 2645;
  //dee
  QED_ODT_Borders_Title = QERes + 2808;
  QED_ODT_Styles_Title = QERes + 2809;
  QED_ODT_Options_Title = QERes + 2810;
  QED_ODT_Font_Title = QERes + 2811;

  //XLSX
  QED_XLSX_Title = QERes + 2767;
  QED_XLSX_Header = QERes + 2688;
  QED_XLSX_CaptionRow = QERes + 2689;
  QED_XLSX_Data = QERes + 2690;
  QED_XLSX_Footer = QERes + 2691;
  QED_XLSX_StripStyle = QERes + 2692;
  QED_XLSX_StandardSheetName = QERes + 2693;
  QED_XLSX_FontColor = QERes + 2694;
  QED_XLSX_Bold = QERes + 2695;
  QED_XLSX_Italic = QERes + 2696;
  QED_XLSX_Underline = QERes + 2698;
  QED_XLSX_LeftAlgmt = QERes + 2699;
  QED_XLSX_RightAlgmt = QERes + 2700;
  QED_XLSX_JustifyAlgmt = QERes + 2701;
  QED_XLSX_TopAlgmt = QERes + 2702;
  QED_XLSX_MiddleAlgmt = QERes + 2703;
  QED_XLSX_BottomAlgmt = QERes + 2704;
  QED_XLSX_BackgroundCaption = QERes + 2705;
  QED_XLSX_BackgroundColor = QERes + 2706;
  QED_XLSX_SheetName = QERes + 2707;
  QED_XLSX_Options = QERes + 2708;
  QED_XLSX_StripStyles = QERes + 2709;
  QED_XLSX_SStyleAdd = QERes + 2710;
  QED_XLSX_SStyleRemove = QERes + 2711;
  QED_XLSX_SStyleUp = QERes + 2712;
  QED_XLSX_SStyleDown = QERes + 2713;
  QED_XLSX_UseBorder = QERes + 2714;
  QED_XLSX_BorderColor = QERes + 2715;
  QED_XLSX_CenterAlgmt = QERes + 2716;
  QED_XLSX_BorderWidth = QERes + 2717;
  QED_XLSX_SampleText = QERes + 2718;
  QED_XLSX_FontName = QERes + 2719;
  QED_XLSX_FontSize = QERes + 2720;
  QED_XLSX_StripType = QERes + 2721;
  QED_XLSX_StripNone = QERes + 2722;
  QED_XLSX_StripColumn = QERes + 2723;
  QED_XLSX_StripRow = QERes + 2724;
  QED_XLSX_WrapText = QERes + 2768;
  //dee
  QED_XLSX_Font_Title = QERes + 2812;
  QED_XLSX_Borders_Title = QERes + 2813;
  QED_XLSX_BorderStyle = QERes + 2814;

  // DOCX
  QED_DOCX_Title = QERes + 2729;
  QED_DOCX_Header = QERes + 2730;
  QED_DOCX_CaptionRow = QERes + 2731;
  QED_DOCX_Data = QERes + 2732;
  QED_DOCX_Footer = QERes + 2733;
  QED_DOCX_StripStyle = QERes + 2734;
  QED_DOCX_StandardTableName = QERes + 2735;
  QED_DOCX_TableName = QERes + 2736;
  QED_DOCX_SStyleAdd = QERes + 2737;
  QED_DOCX_SStyleRemove = QERes + 2738;
  QED_DOCX_SStyleUp = QERes + 2739;
  QED_DOCX_SStyleDown = QERes + 2740;
  QED_DOCX_StripType = QERes + 2741;
  QED_DOCX_StripNone = QERes + 2742;
  QED_DOCX_StripColumn = QERes + 2743;
  QED_DOCX_StripRow = QERes + 2744;
  QED_DOCX_UseBorder = QERes + 2745;
  QED_DOCX_BorderColor = QERes + 2746;
  QED_DOCX_BorderWidth = QERes + 2747;
  QED_DOCX_FontName = QERes + 2748;
  QED_DOCX_FontSize = QERes + 2749;
  QED_DOCX_FontColor = QERes + 2750;
  QED_DOCX_Bold = QERes + 2751;
  QED_DOCX_Italic = QERes + 2752;
  QED_DOCX_StrikeOut = QERes + 2753;
  QED_DOCX_Underline = QERes + 2754;
  QED_DOCX_LeftAlgmt = QERes + 2755;
  QED_DOCX_CenterAlgmt = QERes + 2756;
  QED_DOCX_RightAlgmt = QERes + 2757;
  QED_DOCX_JustifyAlgmt = QERes + 2758;
  QED_DOCX_UseBackground = QERes + 2762;
  QED_DOCX_BackgroundColor = QERes + 2763;
  QED_DOCX_UseHighlight = QERes + 2764;
  QED_DOCX_HighlightColor = QERes + 2765;
  QED_DOCX_SampleText = QERes + 2766;
  //dee
  QED_DOCX_Borders_Title = QERes + 2815;
  QED_DOCX_Styles_Title = QERes + 2816;
  QED_DOCX_Options_Title = QERes + 2817;
  QED_DOCX_Font_Title = QERes + 2818;
  QED_DOCX_BorderStyle = QERes + 2819;

  // Progress
  QEDP_Caption = QERes + 2491;
  QEDP_Status = QERes + 2492;
  QEDP_Time = QERes + 2493;
  QEDP_Speed = QERes + 2494;
  QEDP_Preparing = QERes + 2495;
  QEDP_Skipping = QERes + 2496;
  QEDP_Skipped = QERes + 2497;
  QEDP_Exporting = QERes + 2498;
  QEDP_Exported = QERes + 2499;
  QEDP_Fetching = QERes + 2500;
  QEDP_Fetched = QERes + 2501;
  QEDP_Pause = QERes + 2502;
  QEDP_Cancel = QERes + 2503;
  QEDP_OK = QERes + 2504;
  QEDP_Aborted = QERes + 2505;
  QEDP_Finished = QERes + 2506;
  QEDP_RowsPerSec = QERes + 2507;
  QEDP_TimeFormat = QERes + 2508;

  // Access
  QED_Access_Password = QERes + 2509;

  //..............................
  //
  QED_TXT_Encoding = QERes + 2901;
  QED_XLS_Function_Count = QERes + 2904;

implementation

end.
