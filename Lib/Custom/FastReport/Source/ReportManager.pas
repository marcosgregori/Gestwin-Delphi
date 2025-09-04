unit ReportManager;

interface

uses  Windows,
      Messages,
      SysUtils,
      Classes,
      Graphics,
      Controls,
      Forms,
      Dialogs,

      DB,
      nxsdServerEngine,
      nxreRemoteServerEngine,
      nxllTransport,
      nxtcCOMTransport,
      nxllComponent,
      nxDB,

      cxEdit,
      cxDBEdit,

      frxClass,
      frxCustomDB,
      frxGZip,
      frxDCtrl,
      frxDMPExport,
      frxGradient,
      frxChBox,
      frxCross,
      frxRich,
      // frxChart,
      frxBarcode,
      frxNXComponents,
      frxDesgn,
      frxTableObject,

      frxExportPDF,
      frxExportImage,
      frxExportRTF,
      frxExportXML,
      frxExportXLS,
      frxExportHTML,
      frxExportTXT,
      frxExportMail,
      frxExportCSV,
      frxExportText,

      AppContainer,
      AppForms,
      
      AppManager,
      DataAccess,
      DataManager,
      SQLSet,
      QueryGrid,
      frxExportODF,

      XMLDom,
      XMLIntf,
      XMLDoc,

      f_rep,
      f_grd,

      xml.win.msxmldom,
      dxPrnDev,
      dxPSGlbl,
      dxPSUtl,
      dxPrnPg,
      dxBkgnd,
      dxWrap,
      dxSkinsCore,
      dxSkinscxPCPainter,
      cxDrawTextUtils,

      { psReportFast, }

  	   frxCrypt, 
	   frxExportXLSX, frxExportBaseDialog, frxExportDOCX, frxMap, frxGaugeView;

type

  TCompExpr = ( ceEqual,
                ceLessOrEqual,
                ceGreater,
                ceGreaterOrEqual,
                ceNotEqual );

  TSelectedPages = ( spAll, spCurrent, spSeletion );
  TPrintPages = ( ppAll, ppOdd, ppEven );
  TDocumentDataType = ( dtReport, dtHTMLPage, dtReportSchema, dtSpreadSheet, dtText );

  TgxReportManager = class;

  TReportManagerDataModule = class(TDataModule)
    OpenDialog: TOpenDialog;
    FrxBarCodeObject: TfrxBarCodeObject;
    FrxRichObject: TfrxRichObject;
    FrxCrossObject: TfrxCrossObject;

    frxCheckBoxObject: TfrxCheckBoxObject;
    frxGradientObject: TfrxGradientObject;
    frxDotMatrixExport: TfrxDotMatrixExport;
    frxDialogControls: TfrxDialogControls;
    frxGZipCompressor: TfrxGZipCompressor;
    FrxNXComponents: TfrxNXComponents;
    Designer: TfrxDesigner;
    frxHTMLExport: TfrxHTMLExport;
    frxXMLExport: TfrxXMLExport;
    frxRTFExport: TfrxRTFExport;
    frxBMPExport: TfrxBMPExport;
    frxJPEGExport: TfrxJPEGExport;
    frxPDFExport: TfrxPDFExport;
    frxSimpleTextExport: TfrxSimpleTextExport;
    frxCSVExport: TfrxCSVExport;
    frxMailExport: TfrxMailExport;
    ReportQuery: TnxeQuery;
    frxODSExport: TfrxODSExport;
    frxODTExport: TfrxODTExport;
    XMLDocument: TXMLDocument;
    frxCrypt: TfrxCrypt;
    frxDOCXExport: TfrxDOCXExport;
    frxGaugeObject: TfrxGaugeObject;
    frxMapObject: TfrxMapObject;
	   procedure DesignerShowStartupScreen(Sender: TObject);
    procedure frxDesignerShow(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);

  private

    FDesignReportManager : TgxReportManager;
    FCurrentReport : TfrxReport;
    FFirstProgressNotification : Boolean;
    FTemporalReportTablesList : TStringList;
    FDesignningReport,
    FDontShowProgression : Boolean;

    procedure CleanTemporalReportTables( aReport : TfrxReport );

  protected
    procedure Notification( AComponent : TComponent; operation : TOperation );  override;

  public

    procedure Update;
    function  DesignReport( FileName : String = '' ) : TfrxReport;
    function  DesignActiveReport : TfrxReport;
    procedure DoOnHideDesignerForm( aSender : TObject );
    procedure DoProgressStart( Sender : TfrxReport; ProgressType : TfrxProgressType; Progress : Integer );
    procedure DoProgressStop( Sender : TfrxReport; ProgressType : TfrxProgressType; Progress : Integer );
    procedure DoProgress( Sender : TfrxReport; ProgressType : TfrxProgressType; Progress : Integer );
    // procedure DoPageAdded( Pages : TfrxCustomPreviewPages; Progress : integer );

    procedure AddTemporalReportTable( Report : TfrxReport; FileName : String );
    procedure RemoveTemporalReportTable( Report : TfrxReport; FileName : String );

    procedure ValidateReportLocation( CodigoEmpresa : String; DocumentType : TDocumentDataType; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean );
    function  GetReportLocation( FileName : String; CodigoEmpresa : String; TipoFichero : TDocumentDataType = dtReport ) : String;

    property  DesignningReport : Boolean read FDesignningReport;
    property  DontShowProgression : Boolean read FDontShowProgression write FDontShowProgression;
  end;

  TfrxeParams = class( TfrxParams )
    private
    function GetParamValue(const ParamName: String): Variant;
    procedure SetParamValue(const ParamName: String; const Value: Variant);
    public
    property ParamValues[const ParamName: String]: Variant read GetParamValue write SetParamValue;
    end;

  TgxReportManager  = class( TComponent )
    private

      FBeforeStart,
      FAfterStart : TSimpleEvent;

      FFileName,
      FDefaultFileName,
      FTitle : String;

      FActive,
      FNotifyFormulaError  : Boolean;
      FfrxReport : TfrxReport;
      FToPrinter,
      FCheckIfReportEmpty,
      FHideReportList : Boolean;
      FParamsDataset : TgxMemData;
      FMainDataset : TDataset;   // El dataset utilizado para comprobar si el listado contiene datos
      FPageSize : String;
      FPageSizeNumber : Integer;
      FInputForm : TForm;        // La ventana de selección de datos del listado. Si el report está en un módulo, puede fijarse manualmente.
      FReportFromList : Boolean;
      FReportListFrame : TReportListFrame;
      FFormManager : TgxFormManager;
      FPersistentQueryModule : TPersistentQueryModule;

      FSQLSet : TgxSQLSet;

      FReportList : TStringList;

      FOnSetReportName,
      FOnSelectPrinter : TSimpleEvent;

      procedure SetGlobalVariables;
      // function StrCmpValue( cmpExpr : TCompExpr ) : String;
      function GetWindowHandle : hWnd;
      function GetOutlineVisible : Boolean;
      procedure SetOutlineVisible( const Value : Boolean );
      procedure SetShowDialog( const Value : Boolean );
      function  GetShowDialog : Boolean;
      procedure FreeReport;

    protected

      procedure SetFileName( const Value : String );
      procedure DoOnSetReportFromList( Sender : TObject );

    public

      constructor Create( AOwner : TComponent ); override;
      destructor  Destroy; override;

      procedure ActivatePage( PageIndex : SmallInt );

      procedure DoOnSetReportName;

      procedure SetSQLItems( const Value : TgxSQLItems );
      function  GetSQLItems : TgxSQLItems;
      function GetSQLText( Title : String = '' ): String;

      procedure SetValue( FieldName : String; FieldValue : Variant; DontQuote : Boolean = False );
      procedure SetValueField( Field : TField ); overLoad;
      procedure SetValueFields( Fields : array of TField ); overload;
      procedure SetValueFields( Dataset : TDataset ); overload;
      procedure SetValueControl( EditControl : TcxCustomEdit );
      procedure SetValueControls( const EditControls : array of TcxCustomEdit );

      procedure SetNumberVarFormat( VarName : String; decimals : byte );

      function FindMemo( MemoName : String ) : TfrxMemoView;
      procedure SetMemoFormat( MemoName, AFormatStr : String; AFormatKind : TfrxFormatKind = fkNumeric );
      procedure SetMemoVisible( MemoName : String; Value : Boolean );

      function GetReportLocation( CodigoEmpresa : String ) : String;
      function GetReportQuery( DataSetName : String = 'Consulta' ) : TfrxNXQuery;
      function GetQuery( DataSetName : String = 'Consulta' ) : TnxeQuery;
      function GetReportTable( DataSetName : String ) : TfrxNxTable;
      function AssignTable( DataSetName : String; SourceTable : TnxeTable ) : TnxeTable;

      function CreateQueryTable( DataSetName : String; SQLString : String; FieldParams : array of TField; BeforePostRecord : TCopyRecordsPostEvent = nil; TableSide : TTableSide = tsClientSide ) : TnxeTable; overload;
      function CreateQueryTable( DataSetName : String; SQLString : String; BeforePostRecord : TCopyRecordsPostEvent = nil; TableSide : TTableSide = tsClientSide ) : TnxeTable; overload;

      function CreateQueryIntoReportTable( DataSetName, SQLString : String ) : TfrxNxTable;

      function CreateEmptyTable( DataSetName : String; ASQLSet : TgxSQLSet = nil; TableSide : TTableSide = tsClientSide ) : TnxeTable; overload;
      function CreateEmptyTable( DataSetName : String; CreateSQL : String; TableSide : TTableSide = tsClientSide ) : TnxeTable; overload;

      function CreateEmptyReportTable( DataSetName : String; CreateSQL : String; TableSide : TTableSide = tsClientSide; OpenTable : Boolean = True ) : TfrxNxTable; overload;
      function CreateEmptyReportTable( DataSetName : String; ASQLSet : TgxSQLSet = nil; TableSide : TTableSide = tsClientSide; OpenTable : Boolean = True ) : TfrxNxTable; overload;

      function GetTable( DataSetName : String ) : TnxeTable;

      procedure AddSQLExpression( Expression : String; DataSetName : String = 'Consulta' );
      procedure SetSQLExpression( Expression : String; DataSetName : String = 'Consulta' );

      // function StrCompExp( Value : byte; CmpExprSet : array of TCompExpr ) : String; overLoad;
      // function StrCompExp( Value : Boolean; CmpExprSet : array of TCompExpr ) : String; overLoad;
      procedure SetReportPrinter( const Value : String );
      procedure SetPageSize( const Value : String );
      procedure SetReportPrinterAndPage( const APrinter : String; Const APageSize : String );
      procedure OpenReportTables;
      procedure CheckEmptyReport;
      procedure CheckReportList;
      procedure SetReportFromList( ReportIndex : SmallInt );
      procedure UpdateReportList;
      procedure UpdateReportName;

      procedure Load( OpenTables : Boolean = True ); overload;
      procedure Load( PersistentQueryModule : TPersistentQueryModule; AQueryTable : TnxeTable = nil; OpenTables : Boolean = True ); overload;

      procedure Start( LockPrinterOption : Boolean = False );
      function ExportToPDF( FileName : String; AddFilePath : Boolean = True ) : String;
      function ExportToHTML( FileName : String; AddFilePath : Boolean = True; OutputStream : TMemoryStream = nil ) : String; overload;
      procedure ExportToHTML( OutputStream : TMemoryStream = nil ); overload;
      function ExportToSimpleText( AFileName : String; AddFilePath: Boolean = True; OutputStream : TMemoryStream = nil ): String; overload;
      procedure ExportToSimpleText( OutputStream : TMemoryStream = nil ); overload;

      procedure Launch;
      procedure Reset;
      procedure Cancel( E : Exception = nil );
      procedure Detach;

      property Active : Boolean read FActive;
      property FormManager : TgxFormManager read FFormManager write FFormManager;
      property DefaultFileName : String read FDefaultFileName write FDefaultFileName;
      property InputForm : TForm read FInputForm write FInputForm;
      property NotifyFormulaError : Boolean read FNotifyFormulaError write FNotifyFormulaError default False;
      property WindowHandle : hWnd read GetWindowHandle;
      property ShowDialog : Boolean read GetShowDialog write SetShowDialog;
      property ReportPrinter : String write SetReportPrinter;
      property PageSize : String write SetPageSize;
      property FrxReport : TfrxReport read FfrxReport;
      property OutlineVisible : Boolean read GetOutlineVisible write SetOutlineVisible;
      property SQLSet : TgxSQLSet read FSQLSet;
      property MainDataset : TDataset read FMainDataset write FMainDataset;
      property ReportList : TStringList read FreportList;
      property ReportFromList : Boolean read FReportFromList;
      property ReportListFrame : TReportListFrame read FReportListFrame;

    published

      property FileName : String read FFileName write SetFileName;
      property Title : String read FTitle write FTitle;
      property CheckIfReportEmpty : Boolean read FCheckIfReportEmpty write FCheckIfReportEmpty default True;
      property HideReportList : Boolean read FHideReportList write FHideReportList;
      property SQLItems : TgxSQLItems read GetSQLItems write SetSQLItems;
      property ParamsDataset : TgxMemData read FParamsDataset write FParamsDataset;
      property ToPrinter : Boolean read FToPrinter write FToPrinter;

      property OnSelectPrinter : TSimpleEvent read FOnSelectPrinter write FOnSelectPrinter;
      property OnSetReportName : TSimpleEvent read FOnSetReportName write FOnSetReportName;
      property BeforeStart : TSimpleEvent read FBeforeStart write FBeforeStart;
      property AfterStart : TSimpleEvent read FAfterStart write FAfterStart;
      end;

procedure CreateReportForm( FormClass : TgxFormClass; var Reference; Values : array of const ); overLoad;
procedure CreateReportForm( FormClass : TgxFormClass; var Reference ); overLoad;

procedure CreateEmptyTable( DataSetName : String; CreateSQL : String; TargetTable : TnxeTable; TableSide : TTableSide = tsClientSide; OpenTable : Boolean = True );
procedure CreateQueryTable( DataSetName : String; SQLString : String; FieldParams : array of TField; TargetTable : TnxeTable; BeforePostRecord : TCopyRecordsPostEvent = nil; TableSide : TTableSide = tsClientSide );
procedure CheckEmptyReportTable( Dataset : TDataset );
function CheckReportLocation( FileName : String; CodigoEmpresa : String; DocumentType : TDocumentDataType; var ErrorText : TCaption; var Error : Boolean ) : String;
function GetReportName( FileName : String ) : String;
procedure GetReportList( ReportList : TStrings; FileBaseName : String; DocumentType : TDocumentDataType = dtReport; RootReports : Boolean = False );

function ReportManagerDataModule : TReportManagerDataModule;

resourceString
     RsSeleccion    = 'Seleccion';
     RsTextoMoneda  = 'TextoMoneda';

const
     // dtReport, dtHTMLPage, dtReportSchema, dtSpreadSheet );
     ReportExtension : array [ TDocumentDataType ] of String = ( '.FR3', '.HTML', '.RCF', '.XLSX', '.TXT' );

implementation

uses Variants,
     Menus,
     Files,
     Printers,
     LibUtils,

     cxIndexedComboBox,

     frxPrinter,
     frxPrintDialog,
     frxPreview,
     frxRes,
     frxImageConverter,

     nxllException,
     nxDBBase,
     nxsdConst,
     nxsdTypes,
     nxsdDataDictionary,
     nxsdDataDictionaryStrings,

     EnterpriseDataAccess,
     SessionDataAccess,

     b_msg;

{$R *.dfm}

resourceString
     RsEmpresaNombre       = 'Empresa.Nombre';
     RsEmpresaDomicilio    = 'Empresa.Domicilio';
     RsEmpresaLocalidad    = 'Empresa.Localidad';
     RsEmpresaCP           = 'Empresa.CP';
     RsEmpresaProvincia    = 'Empresa.Provincia';
     RsEmpresaNIF          = 'Empresa.NIF';
     RsEmpresaCodigo       = 'Empresa.Codigo';
     RsEjercicio           = 'Ejercicio';
     RsUsuarioCodigo       = 'Usuario.Codigo';
     RsInformeTitulo       = 'Informe.Titulo';
     RsFmtMoneda           = 'FmtMoneda';
     RsTipoCambioEuro      = 'TipoCambioEuro';
     RsHoy                 = 'Hoy';
     RsSubrayarLineas      = 'SubrayarLineas';
     RsCabeceraEmpresa     = 'CabeceraEmpresa';
     RsEmpresaTelefono     = 'Empresa.Telefono';
     RsEmpresaFax          = 'Empresa.Fax';

     RsMsg99   = 'GESTWIN';

     RsMsg100  = 'El fichero [%s] no existe o no se encuentra en el directorio adecuado.';
     RsMsg101  = 'Debe situarse (1) en  el directorio de reports por defecto, (2) en el directorio global o (3) en el de la empresa activa:'#13 +
                 '  1. \Gestwin\reports'#13 +
                 '  2. \Gestwin\reports_'#13 +
                 '  3. \Gestwin\reports_001.';
     RsMsg102  = 'Error durante la preparación del informe.';
     RsMsg103  = 'No se ha podido fijar el valor de la variable [%s].';
     RsMsg104  = 'Obteniendo los datos ...';
     RsMsg105  = 'El proceso de generación del impreso se ha interrumpido.';
     RsMsg106  = 'Problema : %s';
     RsMsg107  = 'No existe una impresora asignada por defecto.';
     RsMsg108  = 'Asigne una impresora por defecto antes de intentar emitir informes.';
     RsMsg109  = 'No existe un Memo de nombre [%s] en el informe.';
     RsMsg110  = 'Se ha producido un error al generar el fichero de exportación.';
     RsMsg111  = 'La tabla o consulta [%s] no ha sido definida en el informe.';
     RsMsg112  = 'No se ha asignado la tabla virtual.';
     RsMsg113  = 'Parámetro inexistente [%s].';
     RsMsg115  = 'Si es un impreso externo debe revisar sus formatos de impresos en la sección "Configuración".';
     RsMsg116  = 'No se ha seleccionado ningún registro.';
     RsMsg117  = 'Modifique los parámetros de la consulta y reintente el proceso.';
     RsMsg118  = 'El fichero [%s] no es un fichero %s (con extensión %s).';
     RsMsg119  = 'Ya hay un informe en preparación.';
     RsMsg120  = 'Espere a que éste finalice y reintente el proceso más adelante.';

var  FReportManagerDataModule : TReportManagerDataModule = nil;

function ReportManagerDataModule : TReportManagerDataModule;
begin
     CreateDataModule( TReportManagerDataModule, FReportManagerDataModule );
     Result := FReportManagerDataModule;
end;

procedure CreateReportForm(     FormClass : TgxFormClass;
                            var Reference;
                                Values    : array of const );
begin
     If   RunningProcess
     then ShowNotification( ntStop, RsgMsg118, RsgMsg119 )
     else begin
          TForm( Reference ) := nil;
          CreateForm( fmReport,
                      FormClass, Reference, Values,
                      { CheckReference } True,
                      { Hidden }  False,
                      { InstanceCount } 0,
                      { AppSection } nil,

                      procedure( Form : TgxForm )
                        begin
                        If   Assigned( Form )
                        then begin
                             var ReportManagerComponent := FindComponentByClass( Form, TgxReportManager );
                             If   Assigned( ReportManagerComponent )
                             then With TgxReportManager( ReportManagerComponent ) do
                                    begin
                                    var FormManagerComponent := FindComponentByClass( Form, TgxFormManager );
                                    If   Assigned( FormManagerComponent )
                                    then begin
                                         FormManager := TgxFormManager( FormManagerComponent );
                                         UpdateReportList;
                                         end;
                                    end;
                             end;
                        end
                    );
          end;
end;

procedure CreateReportForm(     FormClass : TgxFormClass;
                            var Reference );
begin
     CreateReportForm( FormClass, Reference, [] );
end;

procedure CreateEmptyTable( DataSetName : String;
                            CreateSQL   : String;
                            TargetTable : TnxeTable;
                            TableSide   : TTableSide = tsClientSide;
                            OpenTable   : Boolean = True );

var   TmpTableName : String;

begin
     If   Assigned( TargetTable )
     then With TargetTable do
            begin

            Close;   // Por si acaso

            case TableSide of
              tsServerSide : Database := SessionDataModule.ServerTmpDatabase;
              tsClientSide : Database := SessionDataModule.TmpDatabase;
              tsMemory     : Database := SessionDataModule.InMemoryDatabase;
              end;

            TmpTableName := GetTemporalTableName( Database, DataSetName );

            // En CreateSQL debe ir una sentencia Create Table <TableName> ( ... );

            CreateSQL := StringReplace( CreateSQL, '<TableName>', TmpTableName, [ rfReplaceAll, rfIgnoreCase ] );
            ExecQuery(  Database, CreateSQL );

            If   TargetTable.Owner is TfrxNxTable
            then ReportManagerDataModule.AddTemporalReportTable( TfrxNxTable( TargetTable.Owner ).Report, AddPathDelim( Database.Path ) + TmpTableName );

            TableName := TmpTableName;
            TableType := ttVirtual;
            PreserveTemporalTableName := True;

            If   OpenTable
            then Open;

            end;

end;

procedure CheckEmptyReportTable( Dataset : TDataset );
begin
     If   Assigned( Dataset ) and
          Dataset.Active
     then If   Dataset.RecordCount=0
          then begin
               ShowNotification( ntStop, RsMsg116, RsMsg117 );
               Abort;
               end;
end;

function GetReportName( FileName : String ) : String;

var  Report : TFrxReport;
     RootNode : IXMLNode;
     ReportFile : Text;
     ReportName,
     TextLine : String;
     Pp, Ps, Pi : SmallInt;

// const ReportOptionsName = 'ReportOptions.Name';

begin

     // He escogido una forma rápida de obtener el nombre antes que una segura

     Result := '<Sin nombre>';

     AssignFile( ReportFile, FileName );
     Reset( ReportFile );
     If   IoResult=0
     then try
            ReadLn( ReportFile );
            If   not Eof( ReportFile )
            then begin
                 ReadLn( ReportFile, TextLine );
                 TextLine := UTF8Decode( TextLine );
                 Pp := Pos( 'ReportOptions.Name', TextLine );
                 If   Pp<>0
                 then begin
                      Ps := Pp + 20;
                      Pi := Ps;
                      While ( Pi<=Length( TextLine ) ) and ( TextLine[ Pi ]<>'"' ) do
                        Inc( Pi );
                      Result := Copy( TextLine, Ps, Pi - Ps );
                      end;
                 end;
          finally
            Close( ReportFile );
            end;

     {

     --------- Una forma más rápida que la segura pero aún así algo más lenta (también puede ser util para obtener atributos y valores del fichero XML directamente)

     XMLDocument.LoadFromFile( FileName );
     RootNode := XMLDocument.ChildNodes.FindNode( 'TfrxReport' );
     If   Assigned( RootNode )
     then If   RootNode.HasAttribute( ReportOptionsName )
          then Result := RootNode.Attributes[ ReportOptionsName ];

     --------- La forma segura -pero demasiado lenta- de obtener el nombre

     Report := TfrxReport.Create( Self );
     try
       Report.LoadFromFile( FileName );
       Result := Report.ReportOptions.Name;
     finally
       Report.Free;
       end;
     }

end;

function CheckReportLocation(     FileName      : String;
                                  CodigoEmpresa : String;
                                  DocumentType  : TDocumentDataType;
                              var ErrorText     : TCaption;
                              var Error         : Boolean ) : String;

var  ReportDir,
     FileBaseName,
     FileExt : String;
     ErrorTextArray : array of String;

const
    ReportTypeText : array [ TDocumentDataType ] of String = ( 'de informes', 'HTML', 'RCF', 'de hoja de cálculo', 'texto' );

begin

     Result := '';
     Error := False;
     ErrorText := '';
     FileExt := ExtractFileExt( FileName );

     If   FileExt=''
     then FileName := FileName + ReportExtension[ dtReport ]
     else begin
          Error := UpperCase( FileExt )<>ReportExtension[ DocumentType ];
          If   Error
          then begin
               ErrorText := JoinMessage( Format( RsMsg118,[ FileName, ReportTypeText[ DocumentType ], ReportExtension[ DocumentType ] ] ), RsMsg115 );
               Exit;
               end;
          end;

     ReportDir := ExtractFileDir( FileName );
     FileBaseName := ExtractFileName( FileName );

     // El directorio de reports de la Empresa

     If   CodigoEmpresa<>''
     then begin
          Result := GetUserReportsRootPath + 'reports_' + CodigoEmpresa + '\' + FileBaseName;
          If   FileExists( Result )
          then Exit;
          end;

     // El directorio de reports globales

     Result := ApplicationPath + 'reports_\' + FileBaseName;
     If   FileExists( Result )
     then Exit;

     // El directorio de reports de distribución (los que se incluyen con el programa)

     Result := ApplicationPath + 'reports\' + FileBaseName;
     If   FileExists( Result )
     then Exit;

     If   ( ReportDir<>'' ) and ( Copy( ReportDir, 2, 1 )<>':' )  // No es un Path completo
     then begin
          Result := ApplicationPath + 'reports\' + ReportDir + '\' + FileBaseName;
          If   FileExists( Result )
          then Exit;
          end;

     Error := True;
     ErrorText := JoinMessage( Format( RsMsg100, [ FileName ] ), RsMsg101 );
end;

procedure GetReportList( ReportList   : TStrings;
                         FileBaseName : String;
                         DocumentType : TDocumentDataType = dtReport;
                         RootReports  : Boolean = False );

procedure AddReports( Path : String );

var  SearchRec : TSearchRec;
     FileName,
     ReportName : String;

begin
     If   FindFirst( Path + FileBaseName + '*' + ReportExtension[ DocumentType ], faArchive, SearchRec )=0
     then try
            repeat
              FileName := ExtractFileNameWithoutExtension( SearchRec.Name );
              If   FileName<>FileBaseName
              then begin
                   If   DocumentType=dtReport
                   then ReportName := GetReportName( Path + SearchRec.Name )
                   else ReportName := FileName;
                   If   ReportName<>''
                   then ReportList.Add( ReportName + '=' + Path + SearchRec.Name );
                   end;
            until FindNext( SearchRec )<>0;
          finally
            FindClose( SearchRec );
            end;
end;

begin
     If   CodigoEmpresaActual<>''
     then AddReports( GetUserReportsRootPath + 'reports_' + CodigoEmpresaActual + '\' );
     AddReports( ApplicationPath + 'reports_\' );
     If   RootReports
     then AddReports( ApplicationPath + 'reports\' );
end;

procedure CreateQueryTable( DataSetName      : String;
                            SQLString        : String;
                            FieldParams      : array of TField;
                            TargetTable      : TnxeTable;
                            BeforePostRecord : TCopyRecordsPostEvent = nil;
                            TableSide        : TTableSide = tsClientSide );

var   TableDataDictionary : TnxDataDictionary;

begin

     If   Assigned( TargetTable )
     then With ReportManagerDataModule, TargetTable do
            begin

            If   Active and ( TableType in [ ttMemVirtual, ttVirtual, ttTemporal ] )
            then begin
                 Close;
                 DeleteTable;
                 end;

            ReportQuery.Database := EnterpriseDataModule.UserDatabase;
            ReportQuery.SQL.Text := SQLString;

            If   High( FieldParams )>0
            then ReportQuery.SetParamValuesFromFields( FieldParams );
            ReportQuery.Open;
            CheckEmptyReportTable( ReportQuery );

            TableDataDictionary := TnxDataDictionary.Create;

             With TargetTable do
               try

                 case TableSide of
                   tsServerSide : Database := SessionDataModule.ServerTmpDatabase;
                   tsClientSide : Database := SessionDataModule.TmpDatabase;
                   tsMemory     : Database := SessionDataModule.InMemoryDatabase;
                   end;

                 TableName := GetTemporalTableName( Database, TableName );
                 PreserveTemporalTableName := True;

                 TableDataDictionary.Assign( ReportQuery._Dictionary );

                 TableDataDictionary.RemoveIndicesDescriptor;    // Por si hay algún indice definido en la tabla del report
                 TableDataDictionary.EnsureIndicesDescriptor.AddIndex( csSeqAccessIndexName, 0, False, csSeqAccessIndexName, TnxRefKeyDescriptor );

                 Database.CreateTable( True, TableName, '', TableDataDictionary );

                 // A veces, al editar el informe, se guarda el último indice usado en el diseñador de informes
                 // Como el índice hay que fijarlo igualmente a mano, porque en este momento solo existe el secuencial,
                 // es mejor evitar un error de índice inexistente quitando cualquier asignación

                 IndexName := csSeqAccessIndexName;

                 Open;

                 IndexName := csSeqAccessIndexName;   // Por si existe un índice por defecto

                 CopyRecords( ReportQuery, True, BeforePostRecord );

                 If   TargetTable.Owner is TFrxNxTable
                 then ReportManagerDataModule.AddTemporalReportTable( TFrxNxTable( TargetTable.Owner ).Report, AddPathDelim( Database.Path ) + TableName + '.nx1' );

               finally
                 ReportQuery.Close;
                 TableDataDictionary.Free;
                 end;

            end;

end;

// -----------------------------------------------------------------------------------

procedure TReportManagerDataModule.Update;
begin
     ReportQuery.Database := EnterpriseDataModule.UserDatabase;
end;

function TReportManagerDataModule.DesignReport( FileName : String = '' ) : TfrxReport;
begin

     Application.MainForm.SetFocus;

     FDesignReportManager := TgxReportManager.Create( Self );
     FDesignReportManager.FileName := FileName;
     FDesignReportManager.Load( False );

     If   Assigned( FDesignReportManager.FrxReport )
     then With FDesignReportManager.FrxReport do
            begin
            DesignReport( False, False { True } );
            If   Assigned( Designer )
            then begin
                 // AppForms.CenterForm( Designer );
                 // Designer.BringToFront;
                 end;
            end;

     Result := FDesignReportManager.FrxReport;
end;

procedure TReportManagerDataModule.doOnHideDesignerForm( ASender : TObject );
begin
end;

function TReportManagerDataModule.DesignActiveReport : TfrxReport;

var  FileName : String;

begin
     FileName := ApplicationContainer.ActiveReportFileName;
     If   ApplicationContainer.TryToCloseAll=mrOk
     then Result := DesignReport( FileName )
     else Result := nil;
end;

procedure TReportManagerDataModule.DoProgressStart( Sender       : TfrxReport;
                                                    ProgressType : TfrxProgressType;
                                                    Progress     : Integer );
begin

     If   FDontShowProgression
     then Exit;

     If   ProgressType=ptExporting
     then begin
          If   Assigned( Sender.PreviewForm )
          then With  TfrxPreviewForm( Sender.PreviewForm ) do
                 begin
                 ProgressBar.Visible := True;
                 ProgressBar.Properties.Max := Sender.PreviewPages.Count;
                 end;
          end
     else If   Assigned( PrintDialog )
          then PrintDialog.StartProgression
          else If   not Assigned( Sender.PreviewForm ) or PrnFromPreview
               then begin
                    ApplicationContainer.StartProgression( 100, True, FCurrentReport );
                    If   PrnFromPreview and Assigned( Sender.PreviewForm ) and ( Sender.PreviewForm is TgxForm )
                    then Sender.PreviewForm.Enabled := False;
                    end;
     FFirstProgressNotification := True;
end;

procedure TReportManagerDataModule.DoProgress( Sender       : TfrxReport;
                                               ProgressType : TfrxProgressType;
                                               Progress     : Integer );
begin
     If   FDontShowProgression
     then Exit;

     If   ProgressType=ptExporting
     then begin
          If   Assigned( Sender.PreviewForm )
          then With  TfrxPreviewForm( Sender.PreviewForm ) do
                 begin
                 ProgressBar.Position := Progress;
                 ProgressLabel.Caption := 'Exportando página ' + IntToStr( Progress ) + ' de ' + IntToStr( Sender.PreviewPages.Count );
                 end;
          end
     else If   Assigned( PrintDialog )
          then begin
               If   Sender.OldStyleProgress and FFirstProgressNotification
               then begin
                    PrintDialog.ShowProgression( RsMsg104 );
                    FFirstProgressNotification := False;
                    end
               else PrintDialog.ShowProgression( 'Página ' + IntToStr( Progress ) + '.' );
               end
          else If   not Assigned( Sender.PreviewForm ) or PrnFromPreview
               then begin
                    If   not RunningProcess
                    then ApplicationContainer.StartProgression( 100, True, FCurrentReport );
                    ApplicationContainer.ShowProgression( 'Página ' + IntToStr( Progress ) + '.' );
                    end;
end;

procedure TReportManagerDataModule.DoProgressStop( Sender       : TfrxReport;
                                                   ProgressType : TfrxProgressType;
                                                   Progress     : integer );
begin
     If   FDontShowProgression
     then Exit;

     If   ProgressType=ptExporting
     then begin
          If   Assigned( Sender.PreviewForm )
          then With  TfrxPreviewForm( Sender.PreviewForm ) do
                 begin
                 ProgressBar.Visible := False;
                 Progresslabel.Caption := '';
                 end;
          end
     else If   Assigned( PrintDialog )
          then PrintDialog.EndProgression
          else If   not Assigned( Sender.PreviewForm ) or PrnFromPreview
               then begin
                    ApplicationContainer.EndProgression;
                    If   PrnFromPreview and Assigned( Sender.PreviewForm ) and ( Sender.PreviewForm is TgxForm )
                    then Sender.PreviewForm.Enabled := True;
                    end;
end;

procedure TReportManagerDataModule.frxDesignerShow(Sender: TObject);
begin
end;

{
procedure TReportDataModule.doPageAdded( Pages : TfrxCustomPreviewPages; Progress : integer );
begin
     If   Assigned( PrintDialog )
     then PrintDialog.ShowProgression( 'Página ' + IntToStr( Progress ) + '.' )
     else ApplicationContainer.ShowProgression( 'Página ' + IntToStr( Progress ) + '.'  );
end;
}

procedure TReportManagerDataModule.DataModuleCreate(Sender: TObject);
begin
     FTemporalReportTablesList := TStringList.Create;

     // El directorio global ni se crea durante la instalación ni cuando se crea una nueva Empresa.
     // O sea, que éste es un buen momento para crearlo.

     CheckDirectory( AddPathDelim( ApplicationPath ) + 'reports_', True );
end;

procedure TReportManagerDataModule.DataModuleDestroy(Sender: TObject);
begin
     FTemporalReportTablesList.Free;
     FReportManagerDataModule := nil;
end;

procedure TReportManagerDataModule.AddTemporalReportTable( Report   : TfrxReport;
                                                           FileName : String );
begin
     FTemporalReportTablesList.AddObject( FileName, Report );
end;

procedure TReportManagerDataModule.RemoveTemporalReportTable( Report   : TfrxReport;
                                                              FileName : String );

var  FileIndex : Integer;

begin
     FTemporalReportTablesList.Find( FileName, FileIndex );
     If   FileIndex>=0
     then FTemporalReportTablesList.Delete( FileIndex );
end;

procedure TReportManagerDataModule.CleanTemporalReportTables( aReport : TfrxReport );

var  Index  : SmallInt;

begin
     With FTemporalReportTablesList do
       begin
       Index := 0;
       While Index<count do
         begin
         If   Objects[ Index ]=aReport
         then begin
              If   Pos( '_', Strings[ Index ] )<>0   // Una última comprobación. No me gustaría cargarme un fichero normal por accidente
              then begin
                   EraseFile( Strings[ Index ], False );
                   Delete( Index );
                   Continue;
                   end;
              end;
         Inc( Index );
         end;
       end;
end;

procedure TReportManagerDataModule.Notification( AComponent : TComponent; operation : TOperation );

var  AFrxReport  : TfrxReport;

begin
     inherited Notification( AComponent, operation );
     If   operation=opRemove
     then begin
          If   AComponent is TfrxReport
          then begin
               AFrxReport := AComponent as TfrxReport;
               CleanTemporalReportTables( AFrxReport );
               ApplicationContainer.ReportList.Remove( AFrxReport );
               end;
          end;
end;

function TReportManagerDataModule.GetReportLocation( FileName      : String;
                                                     CodigoEmpresa : String;
                                                     TipoFichero   : TDocumentDataType = dtReport) : String;


var ErrorText : TCaption;
    Error : Boolean;
    ErrorMessage,
    ErrorDesc : String;

begin
     Result := CheckReportLocation( FileName, CodigoEmpresa, TipoFichero, ErrorText, Error );
     If   Error
     then begin
          SplitMessage( ErrorText, ErrorMessage, ErrorDesc );
          ShowNotification( ntStop, ErrorMessage, ErrorDesc);
          Abort;
          end;
end;

procedure TReportManagerDataModule.ValidateReportLocation(     CodigoEmpresa : String;
                                                               DocumentType  : TDocumentDataType;
                                                           var DisplayValue  : Variant;
                                                           var ErrorText     : TCaption;
                                                           var Error         : Boolean);
begin
     CheckReportLocation( DisplayValue, CodigoEmpresa, DocumentType, ErrorText, Error );
end;

// TfrxeParams

function TfrxeParams.GetParamValue(const ParamName: String): Variant;

var  ParamItem : TfrxParamItem;

begin
     ParamItem := Find( ParamName );
     If   Assigned( ParamItem )
     then Result := ParamItem.Value
     else raise Exception.Create( Format( RsMsg113, [ ParamName ] ) );
end;

procedure TfrxeParams.SetParamValue(const ParamName: String; const Value: Variant);

var  ParamItem : TfrxParamItem;

begin
     ParamItem := Find( ParamName );
     If   Assigned( ParamItem )
     then ParamItem.Value := Value
     else raise Exception.Create( Format( RsMsg113, [ ParamName ] ) );
end;

// TgxReportManager

constructor TgxReportManager.Create( AOwner : TComponent );
begin
     inherited Create( AOwner );
     FCheckIfReportEmpty := True;
     FSQLSet := TgxSQLSet.Create( Self );
     If   AOwner is TForm
     then FInputForm := TForm( AOwner );
end;

destructor TgxReportManager.Destroy;
begin
     FreeAndNil( FReportList );
     inherited;
end;

function TgxReportManager.GetWindowHandle : hWnd;
begin
     Result := 0;
     With FfrxReport do
       If   not ToPrinter and Assigned( Preview )
       then Result := Preview.Handle;
end;

procedure TgxReportManager.ActivatePage( PageIndex : SmallInt );
begin
     FrxReport.Pages[ PageIndex ].Visible := True;
end;

procedure TgxReportManager.SetValueField( Field : TField );

var  Value : Variant;
     DontQuote : Boolean;

begin
     DontQuote := False;
     case Field.DataType of
       ftString,
       ftWideString   : Value := VarToStr( Field.Value );
       ftSmallInt,
       ftInteger,
       ftWord         : Value := VarToInteger( Field.Value );
       ftBoolean      : Value := VarToBoolean( Field.Value );
       ftBCD,
       ftFloat,
       ftCurrency     : Value := VarToDecimal( Field.Value );
       ftDate         : begin
                        Value := 'EncodeDate(' + FormatDateTime( 'YYYY,MM,DD', Field.Value ) + ')';
                        DontQuote := True;
                        end
       else             Value := Field.Value;
       end;
     SetValue( Field.FieldName, Value, DontQuote );
end;

procedure TgxReportManager.SetValueFields( Dataset : TDataset );

var  Index : SmallInt;

begin
     With Dataset do
       For Index := 0 to FieldCount - 1 do
         SetValueField( Fields[ Index ] );
end;

procedure TgxReportManager.SetValueFields( Fields : array of TField );

var  Index : Integer;

begin
     For Index := 0 to High( Fields ) do
       SetValueField( Fields[ Index ] );
end;

procedure TgxReportManager.SetValue( FieldName  : String;
                                     FieldValue : Variant;
                                     DontQuote  : Boolean = False );
begin
     try
       With FfrxReport.Variables do
         If   IndexOf( FieldName )<>-1
         then begin
              case VarType( FieldValue ) and VarTypeMask of
                VarString,
                VarUString : If   not DontQuote
                             then FieldValue := QuotedStr( VarToStr( FieldValue ) );
                end;
              Variables[ FieldName ] := FieldValue;
              end;
     except
       If   FNotifyFormulaError
       then begin
            ShowNotification( ntStop, RsMsg102, Format( RsMsg103, [ FieldName ] ) );
            Abort;
            end;
       end;

end;

procedure TgxReportManager.SetValueControl( EditControl : TcxCustomEdit );
begin
     If   EditControl is TcxDBRadioGroup
     then With TcxDBRadioGroup( EditControl ) do
            SetValue( 'Texto' + DataBinding.DataField, Properties.Items[ ItemIndex ].Caption )
     else If   EditControl is TcxDBIndexedComboBox
          then With TcxDBIndexedComboBox( EditControl ) do
                 SetValue( 'Texto' + DataBinding.DataField, Text );
end;

procedure TgxReportManager.SetValueControls( const EditControls : array of TcxCustomEdit );

var   Index : SmallInt;

begin
     For Index := 0 to High( EditControls ) do
       SetValueControl( EditControls[ Index ] );
end;

procedure TgxReportManager.SetSQLItems( const Value : TgxSQLItems );
begin
      FSQLSet.SQLItems := Value;
end;

function TgxReportManager.GetSQLItems : TgxSQLItems;
begin
      Result := FSQLSet.SQLItems;
end;

function TgxReportManager.GetSQLText( Title : String = '' ): String;
begin
     With FSQLSet do
       If   Title=''
       then Result := GetSQLText  // ( const TitleIndex : Integer = 0 ), por lo devuelve el primero
       else Result := GetSQLText( Title );
end;

procedure TgxReportManager.SetMemoFormat( MemoName,
                                          AFormatStr  : String;
                                          AFormatKind : TfrxFormatKind = fkNumeric );

var  frxTCMemo : TfrxMemoView;

begin
     frxTCMemo := TfrxMemoView( FfrxReport.FindObject( MemoName + 'Memo' ) );
     If   Assigned( frxTCMemo )
     then With frxTCMemo.DisplayFormat do
            begin
            FormatStr := AFormatStr;
            Kind := AFormatKind;
            end
     else raise Exception.Create( Format( RsMsg109, [ MemoName ] ) );
end;

function TgxReportManager.FindMemo( MemoName : String ) : TfrxMemoView;
begin
     Result := TfrxMemoView( FfrxReport.FindObject( MemoName + 'Memo' ) );
end;

procedure TgxReportManager.SetMemoVisible( MemoName : String;
                                           Value    : Boolean );

var  FrxMemo : TfrxMemoView;

begin
     FrxMemo := FindMemo( MemoName );
     If   Assigned( FrxMemo )
     then FrxMemo.Visible := Value;
end;

procedure TgxReportManager.SetNumberVarFormat( VarName  : String;
                                               Decimals : Byte );

begin
     SetValue( VarName, '###,##0.' + GetDecimalPad( Decimals ) );
end;

function TgxReportManager.GetOutlineVisible : Boolean;
begin
     Result := FfrxReport.PreviewOptions.OutlineVisible;
end;

procedure TgxReportManager.SetOutlineVisible( const Value : Boolean );
begin
     FfrxReport.PreviewOptions.OutlineVisible := Value;
end;

procedure TgxReportManager.SetFileName( const Value : String );
begin
     If   ( csLoading in ComponentState ) or ( FDefaultFileName='' )
     then FDefaultFileName := Value;
     If   not ( csDesigning in ComponentState ) and ( Value='' )
     then FFileName := FDefaultFileName
     else FFileName := Value;
end;

// Esta función desconecta el informe del componente TgxReportManager, de forma que no será suprimido si se vuelve
// a cargar uno nuevo

procedure TgxReportManager.Detach;
begin
     FfrxReport := nil;
end;

procedure TgxReportManager.Launch;
begin
     try
       Load;
       Start;
     except on E : Exception do
       Cancel( E );
       end;
end;

procedure TgxReportManager.FreeReport;
begin
     If   Assigned( FfrxReport )
     then If   ApplicationContainer.ReportList.IndexOf( FfrxReport )<>-1
          then begin
               ApplicationContainer.ReportList.Remove( FfrxReport );
               If   not( csDestroying in FfrxReport.ComponentState )
               then FfrxReport.Free;
               FfrxReport := nil;
               end;
end;

procedure TgxReportManager.Reset;

function  CreateReportUniqueName : String;

const ReportBaseName = 'Report';
var   I : SmallInt;

begin
     I := 1;
     With FrxReport do
       While Assigned( Owner.FindComponent( ReportBaseName + IntToStr( I ) ) ) do
         Inc( I );
     Result := ReportBaseName + IntToStr(  I );
end;

begin
     If   not ( csDesigning in ComponentState )
     then begin
          FreeReport;
          FActive := False;
          FfrxReport := TfrxReport.Create( Application.MainForm );
          With FfrxReport do
            begin
            Name := CreateReportUniqueName;
            ShowProgress := False;   // No quiero que se muestre la ventana de progreso por defecto porque se utilizan otros progressbars
            PreviewOptions.MDIChild := True;
            PreviewOptions.Maximized := False;
            PreviewOptions.Modal := False;
            PreviewOptions.OutlineVisible := False;
            PreviewOptions.ZoomMode := zmDefault; // zmPageWidth;
            PreviewOptions.Buttons := [ pbPrint, pbExport, pbExportQuick, pbFind, pbLoad, pbSave, pbZoom, pbTools, pbPageSetup, pbEdit, pbNavigator ];
            IniFile := '\Software\Gestwin\Reports\';
            ApplicationContainer.ReportList.Add( FfrxReport );
            end;
          end;
end;

procedure TgxReportManager.Cancel( E : Exception = nil );
begin
     ApplicationContainer.EndProgression;
     If   Assigned( E ) and not ( E is EAbort )
     then ShowNotification( ntStop, RsMsg105, Format( RsMsg106, [ E.Message ] ) );
     FreeAndNil( FPersistentQueryModule );
     FreeReport;
     Abort;
end;

function TgxReportManager.GetReportLocation( CodigoEmpresa : String ) : String;
begin
     Result := ReportManagerDataModule.GetReportLocation( FileName, CodigoEmpresa );
end;

function TgxReportManager.GetReportQuery( DataSetName : String = 'Consulta' ) : TfrxNXQuery;

var  FrxDataset : TFrxDataset;

begin
     Result := nil;
     FrxDataset := FfrxReport.GetDataset( DataSetName );
     If   Assigned( FrxDataset )
     then If   FrxDataset is TfrxNxQuery
          then Result := TfrxNxQuery( FrxDataset );
end;

function TgxReportManager.GetQuery( DataSetName : String = 'Consulta' ) : TnxeQuery;

var  FrxQuery : TfrxNxQuery;

begin
     FrxQuery := GetReportQuery( DataSetName );
     If   Assigned( FrxQuery )
     then Result := FrxQuery.Query
     else raise Exception.Create( Format( RsMsg111, [ DataSetName ] ) );
end;

function TgxReportManager.GetReportTable( DataSetName : String ) : TfrxNxTable;

var  FrxDataset : TFrxDataset;

begin
     Result := nil;
     FrxDataset := FfrxReport.GetDataset( DataSetName );
     If   Assigned( FrxDataset )
     then If   FrxDataset is TfrxNxTable
          then Result := TfrxNxTable( FrxDataset );
end;

function TgxReportManager.AssignTable( DataSetName : String;
                                       SourceTable : TnxeTable ) : TnxeTable;

var  FrxTable : TfrxNxTable;

begin
     Result := nil;
     FrxTable := GetReportTable( DataSetName );
     If   Assigned( FrxTable )
     then begin
          SourceTable.Open;
          FrxTable.AssignExternalTable( SourceTable );
          Result := FrxTable.Table;
          end;
end;

function  TgxReportManager.CreateQueryTable( DataSetName      : String;
                                             SQLString        : String;
                                             BeforePostRecord : TCopyRecordsPostEvent = nil;
                                             TableSide        : TTableSide = tsClientSide ) : TnxeTable;
begin
     Result := CreateQueryTable( DataSetName, SQLString, [], BeforePostRecord, TableSide );
end;

function  TgxReportManager.CreateQueryTable( DataSetName      : String;
                                             SQLString        : String;
                                             FieldParams      : array of TField;
                                             BeforePostRecord : TCopyRecordsPostEvent = nil;
                                             TableSide        : TTableSide = tsClientSide ) : TnxeTable;

var   FrxTable : TfrxNxTable;
      TableDataDictionary : TnxDataDictionary;

begin
     Result := nil;
     FrxTable := GetReportTable( DataSetName ) ;
     If   Assigned( FrxTable )
     then begin
          ReportManager.CreateQueryTable( DataSetName, SQlString, FieldParams, FrxTable.Table, BeforePostRecord, TableSide );
          Result := FrxTable.Table;
          end
     else raise Exception.Create( RsMsg112 );
end;

function TgxReportManager.CreateQueryIntoReportTable( DataSetName,
                                                      SQLString   : String ) : TfrxNxTable;
begin
     Result := GetReportTable( DataSetName ) ;
     If   Assigned( Result )
     then CreateQueryIntoTable( SQLString, Result.Table, tsServerSide, DataSetName );
end;

function  TgxReportManager.CreateEmptyTable( DataSetName : String;
                                             ASQLSet     : TgxSQLSet = nil;
                                             TableSide   : TTableSide = tsClientSide ) : TnxeTable;
begin
     If   not Assigned( ASQLSet )
     then ASQLSet := SQLSet;
     Result := CreateEmptyTable( DatasetName, ASQLSet.GetSQLText( DatasetName ), TableSide );
end;

function  TgxReportManager.CreateEmptyTable( DataSetName : String;
                                             CreateSQL   : String;
                                             TableSide   : TTableSide = tsClientSide ) : TnxeTable;
begin
     Result := GetTable( DatasetName );
     ReportManager.CreateEmptyTable( DataSetName, CreateSQL, Result, TableSide );
end;

function  TgxReportManager.CreateEmptyReportTable( DataSetName : String;
                                                   ASQLSet     : TgxSQLSet = nil;
                                                   TableSide   : TTableSide = tsClientSide;
                                                   OpenTable   : Boolean = True ) : TfrxNxTable;
begin
     If   not Assigned( ASQLSet )
     then ASQLSet := SQLSet;
     Result := CreateEmptyReportTable( DataSetName, ASQLSet.GetSQLText( DatasetName ), TableSide, OpenTable );
end;

function  TgxReportManager.CreateEmptyReportTable( DataSetName : String;
                                                   CreateSQL   : String;
                                                   TableSide   : TTableSide = tsClientSide;
                                                   OpenTable   : Boolean = True ) : TfrxNxTable;
begin
     Result := GetReportTable( DataSetName ) ;
     If   Assigned( Result )
     then ReportManager.CreateEmptyTable( DataSetName, CreateSQL, Result.Table, TableSide, OpenTable );
end;

function TgxReportManager.GetTable( DataSetName : String ) : TnxeTable;

var  FrxTable  : TfrxNxTable;

begin
     FrxTable := GetReportTable( DataSetName );
     If   Assigned( FrxTable )
     then Result := FrxTable.Table
     else raise Exception.Create( Format( RsMsg111, [ DataSetName ] ) );
end;

{
function TgxReportManager.StrCmpValue( CmpExpr : TCompExpr ) : String;
begin
     case cmpExpr of
       ceEqual          : Result := '=';
       ceLessOrEqual    : Result := '<=';
       ceGreater        : Result := '>';
       ceGreaterOrEqual : Result := '>=';
       ceNotEqual       : Result := '<>';
       end;
end;

function TgxReportManager.StrCompExp( Value      : byte;
                                      CmpExprSet : array of TCompExpr ) : String;
begin
     Result := StrCmpValue( CmpExprSet[ Value ] );
end;

function TgxReportManager.StrCompExp( Value      : Boolean;
                                      CmpExprSet : array of TCompExpr ) : String;
begin
     Result := StrCmpValue( CmpExprSet[ Ord( Value ) ] );
end;
}

procedure TgxReportManager.SetSQLExpression( Expression  : String;
                                             DataSetName : String = 'Consulta' );

var  FrxDataset : TFrxDataset;

begin
     FrxDataset := FfrxReport.GetDataset( DataSetName );
     If   Assigned( FrxDataset ) and ( FrxDataset is TfrxNXQuery )
     then With TfrxNXQuery( FrxDataset ) do
            begin
            SQL.Clear;
            SQL.Add( Expression );
            end;
end;

procedure TgxReportManager.AddSQLExpression( Expression  : String;
                                             DataSetName : String = 'Consulta' );

var  FrxDataset : TFrxDataset;

begin
     FrxDataset := FfrxReport.GetDataset( DataSetName );
     If   Assigned( FrxDataset ) and ( FrxDataset is TfrxNXQuery )
     then With TfrxNXQuery( FrxDataset ) do
            SQL.Add( Expression );
end;

procedure TgxReportManager.SetGlobalVariables;

var   SaveNotifyError : Boolean;
      NombreEmpresa : String;

begin

     With ApplicationContainer do
       begin

       SaveNotifyError := FNotifyFormulaError;

       try

         FNotifyFormulaError := False;

         If   FTitle=''
         then If   Self.Owner is TForm
              then Title := TForm( Self.Owner ).Caption;

         FfrxReport.ReportOptions.Name := FTitle;

         If   CodigoEmpresaActual=''
         then NombreEmpresa := RsMsg99
         else NombreEmpresa := Empresa_nombre;

         SetValue( RsEmpresaNombre, NombreEmpresa );
         SetValue( RsEmpresaDomicilio, Empresa_domicilio );
         SetValue( RsEmpresaLocalidad, Empresa_localidad );
         SetValue( RsEmpresaCP, Empresa_cp );
         SetValue( RsEmpresaProvincia, Empresa_provincia );
         SetValue( RsEmpresaNIF, Empresa_nif );
         
         SetValue( RsEmpresaTelefono, Empresa_telefono );
         SetValue( RsEmpresaFax, Empresa_fax );

         SetValue( RsEmpresaCodigo, CodigoEmpresaActual );
         SetValue( RsEjercicio, Ejercicio );

         SetValue( RsUsuarioCodigo, CodigoUsuarioActual );
         SetValue( RsInformeTitulo, FTitle );

         SetNumberVarFormat( RsFmtMoneda, DecimalesMoneda );

         SetValue( RsHoy, ApplicationContainer.TodayDate );

         SetValue( RsCabeceraEmpresa, CodigoEmpresaActual + ' - ' + NombreEmpresa + ' - ' + IntToStr( Ejercicio ) );

         If   ApplicationContainer.ReportTitleBarColor<>clGray
         then try
                var Shape := FfrxReport.FindObject( 'TituloCabeceraShape' );
                If   Assigned( Shape ) and ( Shape is TfrxShapeView )
                then With TfrxShapeView( Shape ) do
                       begin
                       Color := ApplicationContainer.ReportTitleBarColor;
                       Frame.Color := Color;
                       end;
              except
                end;

       finally
         FNotifyFormulaError := SaveNotifyError;
         end;

       end;
end;

procedure TgxReportManager.SetReportPrinter( const Value : String );
begin
     With FrxPrinters do
       If   ( Value=frxResources.Get( 'pgDefault' ) ) or ( Copy( Value, 1, 1 )='[')  // Impresora por defecto
       then PrinterIndex := -1
       else PrinterIndex := Printers.IndexOf( Value );
end;

procedure TgxReportManager.SetPageSize( const Value : String );
begin
     FPageSize := Value;
     FPageSizeNumber := -1;
     If   Assigned( FfrxReport )
     then If   not ( ( Value=frxResources.Get( 'pgDefault' ) ) or ( Copy( Value, 1, 1 )='[') )
          then FPageSizeNumber := SetReportPageSize( FFrxReport, FPageSize );
end;

procedure TgxReportManager.SetReportPrinterAndPage( const APrinter  : String;
                                                    const APageSize : String );
begin
     ReportPrinter := APrinter;
     PageSize := APageSize;
end;

procedure TgxReportManager.OpenReportTables;

var  FrxDataset : TFrxDataset;
     Index : SmallInt;

begin
     If   Assigned( FfrxReport )
     then With FfrxReport  do
            For Index := 0 to DataSets.count - 1 do
              begin
              FrxDataset := DataSets[ Index ].DataSet;
              If   FrxDataset is TfrxNXTable
              then With TfrxNXTable( FrxDataset ) do
                     begin

                     // Las tablas virtuales (no tienen un diccionario en el que se especifique su estructura porque
                     // aún no han sido definidas) no deben ser abiertas

                     If   ( TableType in [ ttStandard, ttTemporal ] ) and
                          Assigned( GetTableDictionary( Table.BaseTableName ) )
                     then Open;

                     If   TableType=ttTemporal
                     then ReportManagerDataModule.AddTemporalReportTable( FrxReport, FilePath );

                     end;

              end;
end;

procedure TgxReportManager.CheckEmptyReport;
begin
     If   Assigned( FfrxReport )
     then With FfrxReport  do
            If   FCheckIfReportEmpty
            then CheckEmptyReportTable( FMainDataset );
end;

procedure TgxReportManager.DoOnSetReportFromList( Sender : TObject );
begin
     If   Assigned( FReportListFrame )
     then SetReportFromList( FReportListFrame.RelacionInformesCtrl.ItemIndex );
end;

procedure TgxReportManager.UpdateReportName;
begin
     DoOnSetReportName;
     UpdateReportList;
end;

procedure TgxReportManager.UpdateReportList;

var   Inx : Integer;
      Form : TForm;

const TextoEstandar : String = '<Estandar>';

var   ShowReportList : Boolean;

begin
     If   Assigned( FFormManager ) and not FHideReportList
     then begin
          ShowReportList := False;
          CheckReportList;
          Form := TForm( Self.Owner );
          If   ReportList.Count>0
          then begin

               If   not Assigned( FReportListFrame )
               then begin
                    FReportListFrame := TReportListFrame.Create( Form );
                    FFormManager.AddOptionPanelFrame( FReportListFrame );
                    With FReportListFrame.RelacionInformesCtrl do
                      begin
                      DataBinding.DataSource := FFormManager.MemDataSetDataSource;
                      DataBinding.DataField := ReportListFieldName;
                      Properties.OnEditValueChanged := DoOnSetReportFromList;
                      end;

                    FFormManager.ReportListCtrl := FReportListFrame.RelacionInformesCtrl;
                    If   Assigned( FFormManager.GridOutputCtrl )
                    then FReportListFrame.RelacionInformesCtrl.Enabled := not FFormManager.GridOutputCtrl.Checked;

                    end;

               With FReportListFrame do
                 begin

                 With RelacionInformesCtrl do
                   begin
                   Properties.Items.BeginUpdate;
                   try
                     Properties.Items.Clear;
                     Properties.Items.Add( TextoEstandar );
                     For Inx := 0 to ReportList.Count - 1 do
                       Properties.Items.Add( ReportList.Names[ Inx ] + '  ( ' + ExtractFileName( ReportList.ValueFromIndex[ Inx ] ) + ' )' );
                   finally
                     Properties.Items.EndUpdate;
                     end;
                     
                   If   ApplicationContainer.ReadFieldContent( Form, RelacionInformesCtrl, FFormManager.ValueList )
                   then AddBlueMark( RelacionInformesCtrl )
                   else PostEditValue( TextoEstandar );
                   
                   end;

                 ShowReportList := RelacionInformesCtrl.Properties.Items.Count>1;
                 end;

               end;


          If   Assigned( FReportListFrame )
          then FFormManager.ShowOptionPanelFrame( FReportListFrame, ShowReportList );

          end;
end;

procedure TgxReportManager.CheckReportList;
begin
     DoOnSetReportName;
     If   Assigned( FReportList )
     then FReportList.Clear
     else FReportList := TStringList.Create;
     GetReportList( FReportList, ExtractFileName( FileName ), dtReport );
end;

procedure TgxReportManager.SetReportFromList( ReportIndex : SmallInt );

var Index : SmallInt;

begin
     FReportFromList := False;
     If   not ( csLoading in ComponentState )
     then If   ReportIndex=0
          then FileName := FDefaultFileName
          else If   Assigned( FReportList )
               then begin
                    Index := ReportIndex - 1;
                    If   ( Index>=0 ) and ( Index<FReportList.Count )
                    then begin
                         FileName := FReportList.ValueFromIndex[ Index ];
                         FReportFromList := True;
                         end;
                    end;
end;

procedure TgxReportManager.DoOnSetReportName;
begin
     If   Assigned( FOnSetReportName )
     then FOnSetReportName;
end;

procedure TgxReportManager.Load( PersistentQueryModule : TPersistentQueryModule;
                                 AQueryTable           : TnxeTable = nil;
                                 OpenTables            : Boolean = True );

var  FrxDataset : TFrxDataset;

begin
     FPersistentQueryModule := PersistentQueryModule;
     Load( OpenTables );
     If   Assigned( FPersistentQueryModule )
     then With FPersistentQueryModule do
            begin
            If   not Assigned( AQueryTable ) and ( FfrxReport.Datasets.Count>0 )
            then begin
                 FrxDataset := FfrxReport.Datasets[ 0 ].DataSet;
                 If   FrxDataset is TfrxNXTable
                 then AQueryTable := TfrxNXTable( FrxDataset ).Table;
                 end;
            Initialize( AQueryTable );
            Update;
            end;
end;

procedure TgxReportManager.Load( OpenTables : Boolean = True );

var  ReportPath : String;

begin

     If   PreparingReport
     then begin
          ShowNotification( ntStop, RsMsg119, RsMsg120 );
          Abort;
          end;

     Reset;

     If   not FReportFromList
     then DoOnSetReportName;

     If   FFileName<>''
     then begin

          If   ( Copy( FFileName, 1, 2 )='\\' ) or ( Copy( FFileName, 2, 1 )=':' )
          then ReportPath := FFileName
          else ReportPath := GetReportLocation( CodigoEmpresaActual );

          FfrxReport.LoadFromFile( ReportPath );
          end;

     ReportManagerDataModule.FCurrentReport := FfrxReport;

     With FfrxReport, ReportManagerDataModule do
       begin
       OnProgressStart := DoProgressStart;
       OnProgress := DoProgress;
       OnProgressStop := DoProgressStop;
       FreeNotification( ReportManagerDataModule );
       end;

     If   OpenTables
     then OpenReportTables;

     FActive := True;

end;

procedure TgxReportManager.SetShowDialog( const Value : Boolean );
begin
     If   Assigned( FfrxReport )
     then If   Assigned( FfrxReport.PrintOptions )
          then FfrxReport.PrintOptions.ShowDialog := Value;
end;

function  TgxReportManager.GetShowDialog : Boolean;
begin
     If   Assigned( FfrxReport )
     then Result := FfrxReport.PrintOptions.ShowDialog
     else Result := False;
end;

procedure TgxReportManager.Start( LockPrinterOption : Boolean = False );
begin
     With ReportManagerDataModule do
       try

         If   Assigned( FBeforeStart )
         then FBeforeStart;

         CheckEmptyReport;

         SetGlobalVariables;

         If   Assigned( FParamsDataset )
         then SetValueFields( FParamsDataset );

         FrxPrinters.PrinterIndex := -1;

         If   Assigned( FOnSelectPrinter )
         then FOnSelectPrinter;

         If   not FrxPrinters.HasPhysicalPrinters
         then ShowNotification( ntStop, RsMsg107, RsMsg108 )
         else begin
              SetPrintReportOptions( FfrxReport, ToPrinter, False, LockPrinterOption );
              With FfrxReport do
                begin
                If   not ShowDialog
                then PrepareReport( True );
                If   Print
                then Free
                else If   PrintCanceled
                     then Cancel;
                end;
              end;

         If   Assigned( FAfterStart )
         then FAfterStart;

       finally
         ApplicationContainer.EndProgression;
         end;
end;

function TgxReportManager.ExportToPDF( FileName    : String;
                                       AddFilePath : Boolean = True ) : String;

var  FPDFExport : TfrxPDFExport;

begin

     Result := '';

     With ReportManagerDataModule do
       begin

       CheckEmptyReport;
       SetGlobalVariables;

       If   Assigned( FParamsDataset )
       then SetValueFields( FParamsDataset );

       If   not frxPrinters.HasPhysicalPrinters
       then ShowNotification( ntStop, RsMsg107, RsMsg108 )
       else begin

            SetPrintReportOptions( FfrxReport, ToPrinter, False );

            FPDFExport := TfrxPDFExport.Create( nil );
            try

              FPDFExport.ShowDialog := False;

              FPDFExport.Compressed := ApplicationContainer.PDFCompressed;
              FPDFExport.EmbeddedFonts := ApplicationContainer.PDFEmbeddedFonts;
              FPDFExport.PrintOptimized := ApplicationContainer.PDFPrintOptimized;
              FPDFExport.Background := ApplicationContainer.PDFBackground;

              FPDFExport.PageNumbers := '1-999999';
              If   AddFilePath
              then FPDFExport.FileName := AddPathDelim( SessionDataModule.GetExportDirectory ) + FileName
              else FPDFExport.FileName := FileName;
              try
                FfrxReport.PrepareReport( True );
                FfrxReport.Export( FPDFExport );
              except
                ShowNotification( ntStop, RsMsg110 );
                Abort;
                end;

              Result := FPDFExport.FileName;

            finally
              FreeReport;
              FPDFExport.Free;
              end;

            end;

       end;
end;

procedure TgxReportManager.ExportToHTML( OutputStream : TMemoryStream = nil );
begin
     ExportToHTML( '', False, OutputStream  );
end;

function TgxReportManager.ExportToHTML( FileName     : String;
                                        AddFilePath  : Boolean = True;
                                        OutputStream : TMemoryStream = nil ) : String;

var  FHTMLExport : TfrxHTMLExport;
     
begin

     Result := '';

     With ReportManagerDataModule do
       begin

       CheckEmptyReport;
       SetGlobalVariables;

       If   not frxPrinters.HasPhysicalPrinters
       then ShowNotification( ntStop, RsMsg107, RsMsg108 )
       else begin

            SetPrintReportOptions( FfrxReport, ToPrinter, False );

            FHTMLExport := TfrxHTMLExport.Create( nil );

            try

              FHTMLExport.ExportPictures := True;
              FHTMLExport.PictureType := gpPNG;
              FHTMLExport.AbsLinks := True;
              FHTMLExport.ShowDialog := False;
              FHTMLExport.PageNumbers := '1-999999';

              If   Assigned( OutputStream )
              then FHTMLExport.Stream := OutputStream;

              If   AddFilePath
              then FHTMLExport.FileName := AddPathDelim( SessionDataModule.GetExportDirectory ) + FileName
              else FHTMLExport.FileName := FileName;

              With FfrxReport do
                try
                  PrepareReport( True );
                  Export( FHTMLExport );
                except
                  ShowNotification( ntStop, RsMsg110 );
                  Abort;
                  end;

              Result := FHTMLExport.FileName;

            finally
              FHTMLExport.Free;
              end;
            end;
       end;
end;

procedure TgxReportManager.ExportToSimpleText( OutputStream : TMemoryStream = nil );
begin
     ExportToSimpleText( '', False, OutputStream  );
end;

function TgxReportManager.ExportToSimpleText( AFileName    : String;
                                              AddFilePath  : Boolean = True;
                                              OutputStream : TMemoryStream = nil ) : String;

var  FSimpleTextExport : TfrxSimpleTextExport;

begin

     Result := '';

     With ReportManagerDataModule do
       begin

       CheckEmptyReport;
       SetGlobalVariables;

       If   not frxPrinters.HasPhysicalPrinters
       then ShowNotification( ntStop, RsMsg107, RsMsg108 )
       else begin

            SetPrintReportOptions( FfrxReport, ToPrinter, False );

            FSimpleTextExport := TfrxSimpleTextExport.Create( nil );

            try

              With FSimpleTextExport do
                begin

                EmptyLines := True;

                If   Assigned( OutputStream )
                then Stream := OutputStream
                else begin
                     ShowDialog := False;
                     PageNumbers := '1-999999';
                     If   AddFilePath
                     then FileName := AddPathDelim( SessionDataModule.GetExportDirectory ) + AFileName
                     else FileName := AFileName;
                     end;
                end;

              With FfrxReport do
                try
                  PrepareReport( True );
                  Export( FSimpleTextExport );
                except
                  ShowNotification( ntStop, RsMsg110 );
                  Abort;
                  end;

              Result := FSimpleTextExport.FileName;

            finally
              FSimpleTextExport.Free;
              end;

            end;

       end;
end;

procedure TReportManagerDataModule.DesignerShowStartupScreen(Sender: TObject);

var  DesignerForm : TfrxDesignerForm;

begin
     // De momento, sin usar
     DesignerForm := TfrxDesignerForm(Sender);
     If   Assigned( DesignerForm )
     then ;
end;

initialization
     RegisterClasses( [ TgxReportManager, TPersistentQueryModule ] );

end.


