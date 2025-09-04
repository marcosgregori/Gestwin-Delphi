
unit AppForms;

{$A-}
{$C PRELOAD}
{$IMPORTEDDATA ON}
{$TYPEINFO ON}

interface

uses   SysUtils,
       Windows,
       Messages,
       Classes,
       Graphics,
       Controls,
       Forms,
       Dialogs,
       StdCtrls,
       Buttons,
       ExtCtrls,
       Menus,
       ComCtrls,
       Grids,
       ImgList,
       ExtDlgs,
       AnsiStrings,
       Generics.Collections,
       LibUtils,

       cxContainer,
       cxLabel,
       cxEdit,
       cxTextEdit,
       cxInplaceContainer,
       cxDropDownEdit,
       cxGridCustomView,
       cxGridCustomTableView,
       cxGridDBTableView,
       cxMaskEdit,
       cxCalendar,
       cxGroupBox,
       cxCurrencyEdit,
       cxDBEdit,
       cxGrid,
       cxGridLevel,
       cxStyles,
       cxClasses,
       cxGridTableView,
       cxPC,
       cxButtons,
       cxFilter,
       cxCustomData,
       cxDBRichEdit,
       cxCheckBox,
       cxLookAndFeels,
       cxScrollBox,
       cxSplitter,
       cxButtonEdit,
       dxBar,
       dxSkinsForm,
       dxGDIPlusClasses,
       cxGridDBChartView,
       dxPanel,

       nxllTypes,
       nxllMemoryManager,
       nxsdDataDictionary,

       AppManager,
       AppContainer,
       DataManager,
       DB,
       nxDB,
       cxLookAndFeelPainters,
       dxSkinsCore,
       cxControls,

       dxSkinsdxBarPainter,
       ShellAnimations,
       cxGraphics,
       dxSkinsDefaultPainters,

       f_grd,

       System.ImageList,
       cxImageList,
       cxImage,
       dxBarExtItems,
       dxShellDialogs, dxUIAClasses;

const

  FormManagerName = 'FormManager';
  RecordButtonLinkName = 'RecordButtonLink';
  ReportListFieldName = '_RelacionInformes';
  GridOutputFieldName = '_EnviarARejilla';

  KeyCharSet : TSysCharSet = [ '!'..'z' ];
  NumericCharSet : TSysCharSet = [ '0'..'9' ];
  SignedNumericCharSet : TSysCharSet = [ '-', '0'..'9' ];
  SelectionKeys : TSysCharSet = [ '.', '+', '=' ];

  CM_DeferKeyFunc = WM_USER + 100;

  MaxDemoRecordCount = 50;
  DefaultOptionFrameHeight = 32;
  MaxDaysRange = 366;  // Cambiado desde 365 por los años bisiestos

type

  // -----------

  TFieldType           = ( fldUnknow,
                           fldString,
                           fldInteger,
                           fldLongInt,
                           fldDouble,
                           fldDate,
                           fldBoolean,
                           fldMemo,
                           fldTime,
                           fldDuration,
                           fldGraphic );

  TFormManagerModel    = ( fmInputForm,
                           fmEditForm,
                           fmPersistentInputForm,
                           fmReportForm,
                           fmDisplayForm );   // Cualquier Form que no tenga introducción de datos en la ventana principal, como el Dashboard, Scheduler, etc..

  TStringPad           = ( spNone,
                           spLeftZero,
                           spMiddleZero,
                           spRightZero,
                           spLeftBlank,
                           spLeftHighest,
                           spRightHighest );

  TDateSelection       = ( dsFrom30DaysAgo,
                           dsFromOneYearAgo,
                           dsToLastDayOfYear,
                           dsFixed );

  TDateRange           = ( drLower,
                           drLowerOrEqual,
                           drGreater,
                           drGreaterOrEqual );

  TShiftOperation      = ( soFirst,
                           soPrior,
                           soNext,
                           soLast );

  TCenterOrientation   = ( coVertical, coHorizontal, coBoth );

  TQueryGridInitialState = ( qgsNormal, qgsLinked, qgsDetached );

  TcxCustomEditArray =  array of TcxCustomEdit;
  TcxCustomButtonEditArray = array of TcxCustomButtonEdit;

  TgxFormManager = class;
  TRecordButtonLink = class;
  TgxForm = class;
  TgxLockRangeButton = class;
  TgxScrollBoxPanel = class;
  TgxEditPanel = class;

  TQueryEvent = function : Boolean of object;
  TUpdateFieldSetEvent = procedure( FieldArea : TFieldArea ) of object;
  TUpdateDataAreaEvent = procedure( FieldArea : TFieldArea; var ErrorText : TCaption; var ErrorResult : Boolean; NotifyError : Boolean;  UpdateData : Boolean; out InvalidCustomEdit : TcxCustomEdit ) of object;
  TAutoEditChangedEvent = procedure( var Value : Boolean ) of object;
  TDeactivateFormEvent  = procedure( ChildProcess : Boolean = False ) of object;
  TOnLockRangeEvent = procedure( var KeyValues : TFieldValuesArray ) of object;
  TColumVisibilityChangedEvent = procedure( Column : TcxGridDBColumn ) of object;
  TSetupToolBarEvent = procedure( Enable : Boolean ) of object;
  TQueryProcessEvent = procedure( TargetTables : array of TnxeTable ) of object;
  TEditTableEvent = procedure( Table : TnxeTable ) of object;
  TRowShiftEvent = procedure( ShiftOperation : TShiftOperation ) of object;
  TUserSelectionEvent = procedure( Sender : TObject; var AHandled : Boolean ) of object;
  TRecordButtonEvent = function( AnAppSpeedBtn : TSpeedBtnTag ) : Boolean of object;

  THelpProcedure = procedure( FileName : String );

  TCheckIndexFunction = reference to function ( Index : SmallInt; Edit : TcxCustomEdit ) : Boolean;
  TComponentProcedure = reference to procedure( Component : TComponent );
  TBeforeShowFormProcedure = reference to procedure( Form : TgxForm );

  TParamsDictionary = TDictionary< String, Variant>;

  TApplicationForms = class( TFrame )
    openPictureDialog: TOpenPictureDialog;
    savePictureDialog: TSavePictureDialog;
    RangeBoxImage: TcxImage;
    ControlsImageList: TcxImageList;
    ShellResources: TShellResources;
    BarManager: TdxBarManager;
    QueryGridPopupMenu: TdxBarPopupMenu;
    ExpandirButton: TdxBarButton;
    ColapsarButton: TdxBarButton;
    NotificationImageCollection: TcxImageCollection;
    WarningItem: TcxImageCollectionItem;
    AlertItem: TcxImageCollectionItem;
    HelpItem: TcxImageCollectionItem;
    WarningAlertItem: TcxImageCollectionItem;
    InformationItem: TcxImageCollectionItem;
    CancelItem: TcxImageCollectionItem;
    RedMarkImage: TImage;
    BlueMarkImage: TImage;
    QueryIcon: TImage;
    ListingIcon: TImage;
    EditIcon: TImage;
    EditControlPopupMenu: TdxBarPopupMenu;
    EditarButton: TdxBarButton;
    ConsultaButton: TdxBarButton;
    AnotacionButton: TdxBarButton;
    FuncionExtendidaButton: TdxBarButton;
    ValorPorDefectoButton: TdxBarButton;
    AcceptItem: TcxImageCollectionItem;
    ImageCollection: TcxImageCollection;
    RowShiftUpImage: TcxImageCollectionItem;
    RowShiftDownImage: TcxImageCollectionItem;
    RowInsertImage: TcxImageCollectionItem;
    RowAppendImage: TcxImageCollectionItem;
    RowDeleteImage: TcxImageCollectionItem;
    ShowDocumentImage: TcxImageCollectionItem;
    EditSelectorImage: TcxImageCollectionItem;
    LockWindowImage: TcxImageCollectionItem;
    AUNAImage: TcxImageCollectionItem;
    ShowOriginImage: TcxImageCollectionItem;
    OpenFileDialog: TdxOpenFileDialog;
    SaveFileDialog: TdxSaveFileDialog;
    RowEditImage: TcxImageCollectionItem;
    RowGearImage: TcxImageCollectionItem;
    RowPackageImage: TcxImageCollectionItem;
    procedure EditarButtonClick(Sender: TObject);
    procedure ConsultaButtonClick(Sender: TObject);
    procedure AnotacionButtonClick(Sender: TObject);
    procedure FuncionExtendidaButtonClick(Sender: TObject);
    procedure ValorPorDefectoButtonClick(Sender: TObject);

  private

    FButtonBitmap : TBitmap;
    FMouseEditControl : TcxCustomEdit;
    EditControlPopupMenuActive : Boolean;
    EditControlPopupMode : TcxEditControlPopupMode;

    procedure SpeedButton( aSpeedBtn : TSpeedBtnTag );
    procedure DoOnShowEditControlPopup( Sender: TcxCustomEdit; Mode : TcxEditControlPopupMode; X : Integer = 0; Y : Integer = 0 );

  public

    constructor Create( AOwner : TComponent ); override;
    destructor Destroy; override;

    function GetImageFromList( ImageList : TcxImageList; ImageIndex : SmallInt ) : TBitmap;
    function GetImageDataFromList( ImageList : TcxImageList; ImageIndex : SmallInt ) : AnsiString;

    end;

  { TgxFormManager ---------------------------------------------------- }

  TTableViewList = class( TList )
    protected
    procedure Notify( Ptr: Pointer; Action: TListNotification ); override;
    end;

  TTableViewListItem = class
    protected
      FTableView : TcxGridDBTableView;
      FAppending,
      FDeleting,
      FInserting : Boolean;
    public
      constructor Create( TableView : TcxGridDBTableView );
    end;

  TgxFormManager = class( TComponent )

  private
    FOwnedForm : TgxForm;
    FOwnedFormActive,
    FReadOnlyDataset,
    FBrowseOnlyDataset : Boolean;
    FDataset : TDataset;
    FDataSource : TDataSource;              // El DataSource asociado al dataset principal (solo uno)
    FMemDataset : TgxMemData;
    FMemDataSetDataSource : TDataSource;
    FTable : TnxeTable;
    FBrowseTable : TnxeTable;
    FReportListField : TStringField;
    FReportListCtrl : TcxDBComboBox;
    FGridOutputField : TBooleanField;
    FGridOutputCtrl : TcxDBCheckBox;
    FOkButton,
    FCloseButton,
    FDeleteButton : TgBitBtn;
    FLockWindowButton : TcxButton;
    FOptionsPanel : TdxPanel;                // Este TdxPanel contiene los frames con opciones de las ventanas fmReportForm
    FOptionsFramesCount : SmallInt;          // El número de frames visibles en el FOptionsPanel
    FGridOutputFrame : TGridOutputFrame;
    FLockRangeButton : TgxLockRangeButton;
    FWarningButton : TgBitBtn;
    FKeyPanel,
    FDataPanel,
    FButtonsPanel : TgxEditPanel;
    FModel : TFormManagerModel;
    FBackDropForm : Boolean;
    FShowQueryOption : Boolean;
    FShowQueryOptionPending : Boolean;
    FRecordButtonLink : TRecordButtonLink;
    FRelatedDocsMenu : TdxBarPopupMenu;
    FRelatedDocsMenuEnabled : Boolean;
    FButtonPressed : TModalResult;
    FInvalidCustomEdit : TcxCustomEdit;
    FFieldNotificationCount : SmallInt;

    FieldIndexValues : TFieldValuesArray;
    FDataSourceList : TList<TDataSource>;
    FTableViewList : TTableViewList;
    FValueList : TStringList;

    FButtonProcess,
    FDataAreaFocused,
    FCancelling,
    // FExclusiveForm,
    FInsertingAutoIncRecord,
    FEditAllowed : Boolean;

    FFirstKeyControl,
    FFirstDataControl : TWinControl;
    FAccessLevel : SmallInt;

    FFormInitialized,
    FFormPrepared,
    FCloseWindow,
    FShowingForm,
    FEnablingDatasources,
    FClosingOwnedForm,
    FFocusingKeyPanel,
    FFocusingDataPanel,
    FPostingCurrentRecord,
    FValidatingFormData,
    FInternalDataEvent,
    FAutoEditEnabled,
    FPostingKeyPanelEnterMsg,
    FKeyPanelFocusCanceled,
    FKeyButtonsEnabled,
    FDataButtonsEnabled,
    FHasScrollableControls : Boolean;

    FWindowBarButton : TdxBarButton;
    FRangeLocked : Boolean;

    // Eventos

    FTableBeforeInsert,
    FTableBeforeEdit,
    FTableAfterEdit,
    FTableAfterDelete,
    FTableAfterCancel,
    FTableOnGetRecord,
    FTableOnNewRecord,
    FOnDeleteEmptyHeader : TDataSetNotifyEvent;
    FOnAutoEditChanged : TAutoEditChangedEvent;
    FOnDeactivateForm : TDeactivateFormEvent;

    FBeforeSetup,
    FAfterSetup,
    FOnInitializeForm,
    FOnCreateForm,
    FOnDestroyForm,
    FAfterDestroyForm,
    FOnShowForm,
    FOnHideForm,
    FOnPreparedForm,
    FOnActivateForm,
    FOnUpdateButtonsState,
    FOnShowCantEditMessage : TSimpleEvent;

    FOnCloseForm : TCloseEvent;
    FOnCanClose,
    FOnCopyCurrentRecord,
    FOnRefreshCurrentRecord,
    FOnActivateRelatedDocsButton : TQueryEvent;

    FOnReportRequest,
    FOnReportFormRequest,
    FOnLabelsRequest,
    FOnGraphicRequest,
    FOnNoteRequest,
    FOnInsertRecRequest,
    FOnQueryGridRequest,
    FOnRelatedDocsRequest,

    FOnOkButton,
    FOnCloseButton,
    FOnFocusedAreaChanged,
    FBeforePostEditRecord,
    FOnEditRecordPosted,
    FOnEditRecordDeleted : TSimpleEvent;

    FOnSetupToolBar : TSetupToolBarEvent;

    FOnDeleteButton : TQueryEvent;

    FOnGetAccessLevel : TAccessLevelEvent;
    FOnSaveWindowParams : TSaveWndParamsEvent;
    FOnReadWindowParams : TSimpleEvent;

    FBeforeValidateDataArea,
    FAfterValidateDataArea : TUpdateDataAreaEvent;

    FOnKeyPanelMouseDown : TMouseEvent;
    FOnKeyPanelEnter,
    FOnDataPanelEnter,
    FOnButtonsPanelEnter,
    FOnShowQueryButtonClick : TNotifyEvent;

    procedure DoOnKeyPanelMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DoOnKeyPanelEnter( Sender : TObject );
    procedure DoOnDataPanelEnter( Sender : TObject );
    procedure DoOnEnterButtonsPanel( Sender : TObject );
    procedure DoOnResizeButtonsPanel( Sender : TObject );
    procedure DoTableBeforeEdit( Dataset : TDataSet);
    procedure DoTableAfterEdit( Dataset : TDataSet);
    procedure DoTableBeforeInsert( Dataset : TDataSet);
    procedure DoTableAfterDelete( Dataset : TDataSet);
    procedure DoTableAfterCancel( Dataset : TDataSet);
    procedure DoTableOnGetRecord( Dataset : TDataSet );
    procedure DoTableOnNewRecord( Dataset : TDataSet );

    procedure DoOnDefaultTableEditError( Dataset : TDataSet; E : EDatabaseError; var action : TDataAction );
    procedure UpdateDataControls;
    procedure UpdateRelatedDocsControls;
    procedure ActivateFormButtons( Value : Boolean );
    procedure SetShowQueryOption(const Value: Boolean);
    function GetOptionsPanel : TdxPanel;

   protected

    procedure Loaded; override;
    procedure FormActivate( Sender : TObject );
    procedure FormClick( Sender : TObject );
    procedure FormClose( Sender : TObject; Var action : TCloseAction );
    procedure FormCloseQuery( Sender : TObject; Var CanClose : Boolean );
    procedure FormCreate( Sender : TObject );
    procedure FormDeactivate( Sender : TObject );
    procedure FormDestroy( Sender : TObject );
    procedure FormDragDrop( Sender, source : TObject; X, Y : Integer );
    procedure FormDragOver( Sender, source : TObject; X, Y : Integer; State  : TDragState; Var accept : Boolean );
    procedure FormHide( Sender : TObject );
    procedure FormShow( Sender : TObject );
    function  CanCloseOwnedForm : Boolean;
    procedure CloseOwnedForm;
    function  Freeing : Boolean;
    procedure DoButtonPressed  ( Sender : TObject );
    function  DoCanClose : Boolean;
    procedure DoBringToFront( Sender: TObject );
    procedure DoOnTablePostError( DataSet : TDataSet; E : EDatabaseError; var Action : TDataAction );

    procedure ProcessModalResult( AModalResult : TModalResult);
    function  GetName : TComponentName;
    procedure Notification( AComponent : TComponent; Operation : TOperation );  override;
    procedure SetName( const newName : TComponentName);                         override;
    procedure SetModel( const Value : TFormManagerModel );
    procedure UpdateModel;  // Simplemente reasigna el modelo para actualizar los valores que dependen de él
    procedure SetDataset( const Value : TDataset);
    procedure FieldSetStructChanged;
    procedure TableDataEvent( Event : TDataEvent; info : LongInt );

    procedure DisableDataSources;
    procedure EnableDataSources( OnlyIfWasEnabled : Boolean = False );

    function  ActivateRelatedDocsButton : Boolean;

    procedure DoInitializeForm; virtual;
    procedure DoCreateForm; virtual;
    procedure DoDestroyForm; virtual;
    procedure DoAfterDestroyForm; virtual;
    procedure DoShowForm; virtual;
    procedure DoHideForm; virtual;
    procedure DoActivateForm; virtual;
    procedure DoDeactivateForm( ChildProcess : Boolean = False ); virtual;
    procedure DoPreparedForm;
    procedure DisableForm;
    function  GetOwnedFormActive : Boolean;
    procedure SetOwnedFormActive( const Value : Boolean );
    procedure SetDataAreaFocused( const Value : Boolean );
    procedure ResetScrollableControls;

    procedure RemoveAllBlueMarks;
    procedure AddAllBlueMarks;

    procedure BrowseLast;
    procedure BrowseFirst;
    procedure BrowsePrior;
    procedure BrowseNext;

    function DefaultBrowseTable : TnxeTable;
    procedure SyncBrowseTable;

  public

    FormResult : TModalResult;

    constructor Create( AOwner : TComponent ); override;
    destructor Destroy; override;
    procedure Setup;

    procedure ShowRelatedDocsMenu;

    function  ValidateEditPanel( EditPanel: TgxEditPanel; var ErrorText : TCaption; var ErrorResult : Boolean; NotifyError : Boolean = True; UpdateDisplayValues : Boolean = False; SkipControl: TcxCustomEdit = nil ) : TcxCustomEdit;
    function  ValidateEditControls( FieldArea : TFieldArea; var ErrorText : TCaption; var ErrorResult : Boolean;NotifyError : Boolean = True; UpdateDisplayValues : Boolean = False ) : TcxCustomEdit;
    procedure ValidateDataArea( FieldArea : TFieldArea; NotifyError : Boolean = True; UpdateDisplayValues : Boolean = False );
    procedure ClearEditPanel( EditPanel : TgxEditPanel );

    procedure SpeedBtnPressed( AnAppSpeedBtn : TSpeedBtnTag );
    {
    procedure UpdateRecord;
    procedure RefreshRecord;
    }
    procedure EditRecord;
    function ReloadRecord( DisableCtrls : Boolean = False ) : Boolean;
    procedure EnableAutoEdit( Value : Boolean );
    procedure InsertNewAutoIncrementRecord;
    function  SelectCurrentKey( KeyValues : array of const; CheckKeyFields : Boolean = False; ActivateForm : Boolean = False ) : Boolean;
    procedure SelectLastRecord;
    procedure CheckDatasetStateChange;
    procedure PostCurrentRecord;
    function  CheckDetailRecords( Posting : Boolean = False; NotificationShowed : Boolean = False ) : Boolean;
    procedure SetupToolbar( Value : Boolean; LockUpdate : Boolean = True );
    procedure SelectFirstDataControl;
    procedure SelectFirstKeyControl( SetEditMode : Boolean = False );
    procedure UpdateButtonsState;

    procedure AddOptionPanelFrame( OptionFrame : TFrame );
    procedure ShowOptionPanelFrame( OptionFrame : TFrame; Value : Boolean );

    procedure DoLockWindow;
    procedure DoReadWindowParams;
    procedure DoSaveWindowParams( Option : TSaveWndParamsOption );
    procedure DoLockWindowClick( Sender : TObject );
    procedure DoShowQueryClick( Sender : TObject );

    procedure LockGridOutputFrame;

    function GetValueFromList( Name : String; DefValue  : Variant ) : Variant;

    property AutoEditEnabled : Boolean read FAutoEditEnabled;
    property OwnedForm : TgxForm read FOwnedForm;
    // property ExclusiveForm : Boolean read FExclusiveForm write FExclusiveForm;
    property Name : TComponentName read GetName write SetName;
    property OkButton : TgBitBtn read FOkButton;
    property CloseButton : TgBitBtn read FCloseButton;
    property DeleteButton : TgBitBtn read FDeleteButton;
    property Datasource : TDataSource read FDataSource;
    property KeyPanel : TgxEditPanel read FKeyPanel;
    property DataPanel : TgxEditPanel read FDataPanel write FDataPanel;
    property OptionsPanel : TdxPanel read GetOptionsPanel;
    property ButtonsPanel : TgxEditPanel read FButtonsPanel;
    property FieldNotificationCount : SmallInt read FFieldNotificationCount write FFieldNotificationCount;
    property InsertingAutoIncRecord : Boolean read FInsertingAutoIncRecord;
    property FocusingDataPanel : Boolean read FFocusingDataPanel;
    property DataAreaFocused : Boolean read FDataAreaFocused write SetDataAreaFocused;
    property CloseWindow : Boolean read FCloseWindow write FCloseWindow;
    property ButtonPressed : TModalResult read FButtonPressed;
    property GridOutputFrame : TGridOutputFrame read FGridOutputFrame;
    property MemDataset : TgxMemData read FMemDataset;
    property MemDataSetDataSource : TDataSource read FMemDataSetDataSource;
    property ReportListField : TStringField read FReportListField;
    property GridOutputField : TBooleanField read FGridOutputField;
    property GridOutputCtrl : TcxDBCheckBox read FGridOutputCtrl;
    property ReportListCtrl : TcxDBComboBox read FReportListCtrl write FReportListCtrl;
    property OwnedFormActive : Boolean read GetOwnedFormActive write SetOwnedFormActive;
    property Cancelling : Boolean read FCancelling;
    property ValidatingFormData : Boolean read FValidatingFormData;
    property PostingCurrentRecord : Boolean read FPostingCurrentRecord;
    property FormInitialized : Boolean read FFormInitialized;
    property FormPrepared : Boolean read FFormPrepared;
    property ShowingForm : Boolean read FShowingForm;
    property EnablingDatasources : Boolean read FEnablingDatasources;
    property Table : TnxeTable read FTable;
    property RangeLocked : Boolean read FRangeLocked;
    property LockRangeButton : TgxLockRangeButton read FLockRangeButton;

  published

    property BackDropForm : Boolean read FBackDropForm write FBackDropForm default False;
    property BrowseTable : TnxeTable read FBrowseTable write FBrowseTable;
    property Dataset  : TDataset read FDataset write SetDataset;
    property FirstKeyControl : TWinControl read FFirstKeyControl write FFirstKeyControl;
    property FirstDataControl : TWinControl read FFirstDataControl write FFirstDataControl;
    property Model : TFormManagerModel read FModel  write SetModel default fmInputForm;
    property RelatedDocsMenu : TdxBarPopupMenu read FRelatedDocsMenu write FRelatedDocsMenu;
    property BrowseOnlyDataset : Boolean read FBrowseOnlyDataset write FBrowseOnlyDataset default False;
    property ShowQueryOption : Boolean read FShowQueryOption Write SetShowQueryOption;
    property ValueList : TStringList read FValueList;

    property BeforeValidateDataArea : TUpdateDataAreaEvent read FBeforeValidateDataArea write FBeforeValidateDataArea;
    property AfterValidateDataArea : TUpdateDataAreaEvent read FAfterValidateDataArea write FAfterValidateDataArea;
    property OnAutoEditChanged : TAutoEditChangedEvent  read FOnAutoEditChanged write FOnAutoEditChanged;

    property BeforeSetup : TSimpleEvent read FBeforeSetup write FBeforeSetup;
    property AfterDestroyForm : TSimpleEvent read FAfterDestroyForm write FAfterDestroyForm;
    property AfterSetup : TSimpleEvent read FAfterSetup write FAfterSetup;
    property OnInitializeForm : TSimpleEvent read FOnInitializeForm write FOnInitializeForm;
    property OnCreateForm : TSimpleEvent read FOnCreateForm write FOnCreateForm;
    property OnDestroyForm : TSimpleEvent read FOnDestroyForm write FOnDestroyForm;
    property OnHideForm : TSimpleEvent read FOnHideForm write FOnHideForm;
    property OnShowForm : TSimpleEvent read FOnShowForm write FOnShowForm;
    property OnPreparedForm : TSimpleEvent read FOnPreparedForm write FOnPreparedForm;
    property OnActivateForm : TSimpleEvent read FOnActivateForm write FOnActivateForm;
    property OnDeactivateForm : TDeactivateFormEvent read FOnDeactivateForm write FOnDeactivateForm;
    property OnCanClose : TQueryEvent read FOnCanClose write FOnCanClose;
    property OnCloseForm : TCloseEvent read FOnCloseForm write FOnCloseForm;

    property OnCopyCurrentRecord : TQueryEvent read FOnCopyCurrentRecord write FOnCopyCurrentRecord;
    property OnRefreshCurrentRecord : TQueryEvent read FOnRefreshCurrentRecord write FOnRefreshCurrentRecord;
    property OnDeleteEmptyHeader : TDataSetNotifyEvent read FOnDeleteEmptyHeader write FOnDeleteEmptyHeader;
    property OnReportRequest : TSimpleEvent read FOnReportRequest write FOnReportRequest;
    property OnReportFormRequest : TSimpleEvent read FOnReportFormRequest write FOnReportFormRequest;
    property OnActivateRelatedDocsButton : TQueryEvent read FOnActivateRelatedDocsButton write FOnActivateRelatedDocsButton;
    property OnLabelsRequest : TSimpleEvent read FOnLabelsRequest write FOnLabelsRequest;
    property OnGraphicRequest : TSimpleEvent read FOnGraphicRequest write FOnGraphicRequest;
    property OnNoteRequest : TSimpleEvent read FOnNoteRequest write FOnNoteRequest;
    property OnInsertRecRequest : TSimpleEvent read FOnInsertRecRequest write FOnInsertRecRequest;
    property OnRelatedDocsRequest : TSimpleEvent read FOnRelatedDocsRequest write FOnRelatedDocsRequest;
    property OnQueryGridRequest : TSimpleEvent read FOnQueryGridRequest write FOnQueryGridRequest;

    property OnOkButton : TSimpleEvent read FOnOkButton write FOnOkButton;
    property OnCloseButton : TSimpleEvent read FOnCloseButton write FOnCloseButton;
    property OnDeleteButton : TQueryEvent read FOnDeleteButton write FOnDeleteButton;
    property OnFocusedAreaChanged : TSimpleEvent read FOnFocusedAreaChanged write FOnFocusedAreaChanged;
    property OnGetAccessLevel : TAccessLevelEvent read FOnGetAccessLevel write FOnGetAccessLevel;
    property OnEditRecordDeleted : TSimpleEvent read FOnEditRecordDeleted write FOnEditRecordDeleted;
    property BeforePostEditRecord : TSimpleEvent read FBeforePostEditRecord write FBeforePostEditRecord;
    property OnEditRecordPosted : TSimpleEvent read FOnEditRecordPosted write FOnEditRecordPosted;
    property OnReadWindowParams : TSimpleEvent read FOnReadWindowParams write FOnReadWindowParams;
    property OnSaveWindowParams : TSaveWndParamsEvent read FOnSaveWindowParams write FOnSaveWindowParams;
    property OnSetupToolBar : TSetupToolBarEvent read FOnSetupToolBar write FOnSetupToolBar;
    property OnShowQueryButtonClick : TNotifyEvent read FOnShowQueryButtonClick write FOnShowQueryButtonClick;
    property OnUpdateButtonsState : TSimpleEvent read FOnUpdateButtonsState write FOnUpdateButtonsState;
    property OnShowCantEditMessage : TSimpleEvent read FOnShowCantEditMessage write FOnShowCantEditMessage;
    end;

    TRecordButtonLink = class( TComponent )
    protected
      FBtnLinkProcess : Boolean;
      FOnRecordButtonEvent : TRecordButtonEvent;
      SearchStr,
      SearchFieldName : String;
      SearchFieldIndex : Integer;
      SearchInProgress : Boolean;
      SearchField : TField;
      SearchDataset : TnxDataset;
      IsSearchExpression,
      ApplyToQuery : Boolean;
      FStartValues,
      FEndValues : TFieldValuesArray;
      FTableViewQuery : TnxeQuery;

    public
      constructor Create( AOwner : TComponent ); override;

      procedure RecordBtnPressed( AnAppSpeedBtn : TSpeedBtnTag );
      function  ApplyDatasetFilter( Dataset : TnxDataset; Field : TField ) : Boolean;

      property BtnLinkProcess : Boolean  read FBtnLinkProcess;
      property OnRecordButtonEvent : TRecordButtonEvent read FOnRecordButtonEvent write FOnRecordButtonEvent;

    end;

    { TgxForm ----------------------------------------------------------- }

    PgxForm = ^TgxForm;
    TgxFormClass = class of TgxForm;

    TgxForm = class( TdxSkinForm ) // TForm
    private
      FReferencePtr : PgxForm;
      FID : Integer;
      FMaximized,
      FMinimized,
      FShowedAndScaled,
      FScaleAdjusted : Boolean;
      FsLeft,
      FsTop,
      FsWidth,
      FsHeight : Integer;
      FFormManager : TgxFormManager;
      FBackgroundForm,
      FMDIMaximizedForm,
      FTDITabSheetForm,
      FCloseWindowWhenFocusLost,
      FFormVisible : Boolean;
      FInstanceCount : SmallInt;
      FExclusive : Boolean;
      FFormType : TFormType;
      FLastActiveEditControl : TcxCustomEdit;
      FGotoPreviousOnClose : Boolean;
      FAdjustingForm : Boolean;
      FFormerAppSection,
      FAppSection : TgAppSection;
      FExtendedName : String;  // Lo utilizo en forms que se utilizan con más de un mantenimiento. Por ejemplo, movimientos.
      FSavedBounds : Boolean;  // Indica que se ha fijado el tamaño y posición inicial a partir de la configuración guardada

      procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
      procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;

      function GetFormManager: TgxFormManager;
      procedure SetVisible(Value: Boolean); reintroduce;
      function GetVisible: Boolean;
      procedure SetReferencePtr( const Value: PgxForm );
      procedure SetFormType( const Value : TFormType );
      procedure SetCloseWindowWhenFocusLost( const Value : Boolean );

    protected

      FIsFrxBaseForm : Boolean;

      procedure Loaded; override;

      procedure DoCreate; override;
      procedure DoDestroy; override;
      procedure DoShow; override;
      procedure Resize; override;
      procedure Activate; override;
      procedure Deactivate; override;
      procedure KeyDown( var Key: Word; Shift: TShiftState); override;
      procedure KeyPress(var Key: Char); override;

      procedure ActivateControlToolbarOptions( LockUpdate : Boolean = True );
      procedure ActivateGridSite( GridSite : TcxGridSite );
      procedure DeActivateControlToolbarOptions;
      procedure ShowHints;
      procedure SaveFormPosition;
      procedure SetActiveEditControl( Control : TWinControl );

    public

      constructor Create( AOwner : TComponent ); override;
      destructor Destroy; override;

      procedure UpdateTabState( Subscribe : Boolean );
      procedure MaximizeForm;
      procedure RestoreWindow;
      procedure UpdateImageLists; override;
      procedure AdjustScale; virtual;
      function  GetActiveEditControl : TcxCustomEdit;
      procedure SelectNextControl( GoForward : Boolean = True );
      function  SetFocusedControl(Control: TWinControl): Boolean; override;
      procedure ToggleMaximize;
      procedure Maximize;
      procedure DoActivate;
      procedure DoDeactivate;

      property AppSection : TgAppSection read FAppSection write FAppSection;
      property BackgroundForm : Boolean read FBackgroundForm;
      property CloseWindowWhenFocusLost : Boolean read FCloseWindowWhenFocusLost write SetCloseWindowWhenFocusLost;
      property MDIMaximizedForm : Boolean read FMDIMaximizedForm;
      property TDITabSheetForm : Boolean read FTDITabSheetForm;
      property Exclusive : Boolean read FExclusive write FExclusive;
      property ExtendedName : String read FExtendedName write FExtendedName;
      property FormManager : TgxFormManager read GetFormManager;
      property GotoPreviousOnClose : Boolean read FGotoPreviousOnClose write FGotoPreviousOnClose;
      property ID : Integer read FID write FID;
      property InstanceCount : SmallInt read FInstanceCount;
      property Maximized : Boolean read FMaximized;
      property FormType : TFormType read FFormType write SetFormType default fmEdit;
      property ReferencePtr : PgxForm read FReferencePtr write SetReferencePtr;
      property SavedBounds : Boolean read FSavedBounds write FSavedBounds;
      property ScaleAdjusted : Boolean read FScaleAdjusted;
      property ShowedAndScaled : Boolean read FShowedAndScaled;
      property Visible : Boolean read GetVisible write SetVisible;
      end;

    { TLinkedFormsList ------------------------------------------------- }

    TLinkedFormsList = class( TList )
      public
        procedure Clear; override;
        procedure Add( ASourceForm, ATargetForm : TgxForm ); overload;
        procedure Remove( ASourceForm, ATargetForm : TgxForm ); overload;
        procedure ReleaseTargets( ASourceForm : TgxForm );
        function FindForm( ASourceForm : TCustomForm; FormClass : TgxFormClass ) : TgxForm;
      end;

    { TLinkedFormsItem ------------------------------------------------- }

    TLinkedFormsItem = class
      protected
        FSourceForm,
        FTargetForm : TgxForm;
      public
        constructor Create( ASourceForm, ATargetForm : TgxForm );
      end;

    { TgxScrollBoxPanel ----------------------------------------------------- }

     TgxScrollBoxPanel =  class( TcxGroupBox )
     private
       FScrollBox : TcxScrollBox;
     protected
       procedure SetParent( AParent : TWinControl ); override;
       procedure DoEnter; override;
       procedure DoExit; override;
     public

     end;

    { TgxEditPanel ----------------------------------------------------- }

     TEditPanelKind  = ( epStandard,
	                     epKeyPanel,
					     epDataPanel,
					     epInputPanel,
					     epButtonsPanel );

     TgxEditPanel =  class( TcxGroupBox )
     private

       FPanelKind : TEditPanelKind;
       FOwnerForm : TgxForm;
       FFormManager : TgxFormManager;
       FStateShape : TShape;
       FOnMouseActivate : TNotifyEvent;
       FBevelOuter: TPanelBevel;

     protected
       function GetOwnerForm : TgxForm;
       function GetFormManager : TgxFormManager;
       procedure SetPanelKind( const Value : TEditPanelKind );
       procedure DoExit; override;

     public
       constructor Create( AOwner : TComponent ); override;
       procedure UpdateStateImage;
       function ValidateEditControls( UpdateData : Boolean = False; StoreData : Boolean = False ) : TcxCustomEdit;

       property OwnerForm : TgxForm read GetOwnerForm;
       property FormManager : TgxFormManager read GetFormManager;

       published
       property BevelOuter: TPanelBevel read FBevelOuter write FBevelOuter stored False;
       property PanelKind : TEditPanelKind read FPanelKind write SetPanelKind default epStandard;
      end;

    { TgxFilterPageControl ------------------------------------------------------------------------}

    TgxFilterPageControl = class( TcxPageControl )
      private
        FFilterCheckBoxes : TList<TcxCheckBox>;
        FOnCheckBoxClick : TNotifyEvent;
        procedure DoOnCheckBoxClick(Sender: TObject);
        procedure DoOnEditValueChanged(Sender: TObject);
      protected
        procedure AfterLoaded; override;
        procedure CheckDefaultPage;
      public
        constructor Create(AOwner: TComponent); override;
        destructor Destroy; override;

        property FilterCheckBoxes : TList<TcxCheckBox> read FFilterCheckBoxes;
        // function HasTabSheetHighlighted : Boolean;

      published
        property OnCheckBoxClick : TNotifyEvent read FOnCheckBoxClick write FOnCheckBoxClick;
      end;

    { TgxPageControlNavigatorButton -------------------------------------------------------------- }

    TgxPageControlNavigatorButton = class( TcxButton )
      private
        FTabSheet : TcxTabSheet;
      public
        property TabSheet : TcxTabSheet read FTabSheet write FTabSheet;
      end;

    { TgxPageControlNavigator --------------------------------------------------------------------- }

    TgxPageControlNavigator = class( TcxGroupBox )
      private
        FLeftButton,
        FRightButton : TgxPageControlNavigatorButton;
        FPageControl : TcxPageControl;
        FOnClickButton : TNotifyEvent;
        procedure SetPageControl(const Value: TcxPageControl);
      protected
        procedure DoExit; override;
        procedure Loaded; override;
        procedure DoOnClickButton(Sender: TObject);
        procedure DoOnPageControlChange(Sender: TObject);
      public
        constructor Create( AOwner : TComponent ); override;
        procedure UpdateButtons;
        property LeftButton : TgxPageControlNavigatorButton read FLeftButton;
        property RightButton : TgxPageControlNavigatorButton read FRightButton;
      published
        property PageControl : TcxPageControl read FPageControl write SetPageControl;

        property OnClickButton : TNotifyEvent read FOnClickButton write FOnClickButton;
      end;

    TgxRangeBox = class( TPaintBox )
    private
    protected
      procedure Paint; override;
      procedure Loaded; override;
      end;

    TgxRedMarkBox = class( TPaintBox )
    private
    protected
      procedure Paint; override;
      procedure Loaded; override;
      end;

    TgxBlueMarkBox = class( TPaintBox )
    private
    protected
      procedure Paint; override;
      procedure Loaded; override;
      end;

    TgxLockRangeButton = class( TcxButton )
    private
      FEditControl : TcxCustomEdit;
      FInternalSettingLock,
      FSettingDefaultRange : Boolean;
      FOnLockRange : TOnLockRangeEvent;
      FEditTable : TnxeTable;

    protected

      FFormManager : TgxFormManager;

      procedure Loaded; override;
      procedure Notification( AComponent : TComponent; Operation : TOperation ); override;
      function  GetEditTable : TnxeTable;
      procedure SetLocked( Value : Boolean );
      procedure DoOnLockRange( KeyValues : TFieldValuesArray; ValidateEditControl : Boolean = True );

    public

      constructor Create( AOwner : TComponent ); override;

      procedure Click; override;
      procedure Unlock;

      procedure SetDefaultRange( SetTableKey : Boolean = False );
      property EditTable : TnxeTable read GetEditTable;
      property SettingDefaultRange : Boolean read FSettingDefaultRange;
    published
      property EditControl : TcxCustomEdit read FEditControl write FEditControl;
      property Glyph stored False;
      property OnLockRange : TOnLockRangeEvent read FOnLockRange write FOnLockRange;
      end;

    TgxPasswordEdit = class( TcxButtonEdit )

    private
      procedure DoOnButtonClick( Sender: TObject; AButtonIndex: Integer);
      procedure DoOnChange( Sender : TObject );

    protected
      procedure Loaded; override;

    public
      constructor Create( AOwner : TComponent ); override;
      procedure Reset;
      end;

    TgxDBPasswordEdit = class( TcxDBButtonEdit )

    private
      procedure DoOnButtonClick( Sender: TObject; AButtonIndex: Integer);
      procedure DoOnChange( Sender : TObject );

    protected
      procedure Loaded; override;

    public
      constructor Create( AOwner : TComponent ); override;
      procedure Reset;
      end;

function ApplicationForms : TApplicationForms;

procedure CreateForm( FormType : TFormType; FormClass : TgxFormClass; var Reference; Values : array of const; CheckReference : Boolean = True; Hidden : Boolean = False; InstanceCount : SmallInt = 0; AppSection : TgAppSection = nil; OnBeforeShowForm : TBeforeShowFormProcedure = nil ); overload;
procedure CreateForm( FormType : TFormType; FormClass : TgxFormClass; var Reference; CheckReference : Boolean = True; Hidden : Boolean = False; AppSection : TgAppSection = nil ); overload;
procedure CreateForm( FormType : TFormType; FormClass : TgxFormClass; Values : array of const; MultipleInstances : Boolean = False; Hidden : Boolean = False; AppSection : TgAppSection = nil ); overload;

{
procedure CreateFormExclusive( FormClass : TgxFormClass; var Reference; Values : Array of const ); overload;
procedure CreateFormExclusive( FormClass : TgxFormClass; var Reference ); overload;
}

procedure CreateEditForm( FormClass : TgxFormClass; var Reference; Values : array of const; AppSection : TgAppSection = nil; Exclusive : Boolean = False ); overload;
procedure CreateEditForm( FormClass : TgxFormClass; Values : array of const; MultipleInstances : Boolean = False; AppSection : TgAppSection = nil ); overload;
procedure CreateEditForm( FormClass : TgxFormClass; var Reference; AppSection : TgAppSection = nil; Exclusive : Boolean = False ); overload;

function CreateGridForm( FormClass : TgxFormClass ) : TgxForm; overload;
procedure CreateGridForm( FormClass : TgxFormClass; var Reference ); overload;

function CreateSpreadSheetForm( FormClass : TgxFormClass ) : TgxForm; overload;
procedure CreateSpreadSheetForm( FormClass : TgxFormClass; var Reference; Hidden : Boolean = False ); overload;

function CreatePDFViewerForm( FormClass : TgxFormClass; Path, FileName : String ) : TgxForm;

function CreateGanttForm( FormClass : TgxFormClass ) : TgxForm; overload;
procedure CreateGanttForm( FormClass : TgxFormClass; var Reference; Hidden : Boolean = False ); overload;

procedure CleanFormReference( AForm : TgxForm );
procedure DoNestedActivation( Msg : Cardinal; Control : TWinControl; Form : TCustomForm );
procedure MainMenuActive( Value : Boolean; ActivateForms : Boolean = False; UpdateMenus : Boolean = False );
// procedure ArrangeMDIChildForms( OnlyNotBackgroundForms : Boolean = False );
function  VisibleMDIChildCount : SmallInt;
function  MDIChildFormExists( AForm : TForm ) : Boolean;
procedure PlaceForm( AForm : TgxForm );
procedure CenterForm( AForm : TgxForm );
procedure CenterInParent( Control : TWinControl; Orientation : TCenterOrientation = coHorizontal );
procedure UpdateMDILayout( MDILayout : TMDILayout; CurrentForm : TgxForm = nil; ClosingForm : Boolean = False; Recursive : Boolean = False );
procedure ToggleSpeedButton( ASpeedButton : TSpeedButton );
function  GetItemLinkByBarItem( Bar : TdxBar; BarItem : TdxBarItem ) : TdxBarItemLink;
procedure SetBarItemsVisible( const BarItems : array of TdxBarItem; Value : Boolean );
function  AddBarButtonItem( MenuItem : TdxBarSubItem; ACaption : String; BeginAGroup : Boolean = False; Position : SmallInt = -1 ) : TdxBarButton;
procedure AddPanelButton( AButtonPanel : TcxGroupBox; AButton : TcxButton; ALeftMargin  : SmallInt = 2 );

procedure ShowButtonMenu( APopupMenu : TdxBarPopupMenu; AButton : TdxBarLargeButton );
// function  FindMenuTag( mainMenu : TMainMenu; MenuTag : LongInt ) : TMenuItem;
// procedure DrawHeaderMenuItem( MenuItem : TMenuItem; ACanvas : TCanvas; ARect : TRect );
function FindComponentByClass( AOwner : TComponent; AClassName : String ) : TComponent; overload;
function FindComponentByClass( AOwner : TComponent; AClassType : TClass ) : TComponent; overload;
// procedure ApplyToComponentClass( AOwner : TComponent; AClassType : TClass; Apply : TComponentProcedure );
function FindParentByClassName( Control : TWinControl; ParentClassName : String ) : TControl;
function FindOwnerByClass( Control : TWinControl; OwnerClass : TClass ) : TControl;
function GetParentTabSheet( Control: TControl ) : TcxTabSheet;
function GetParentHint( Control: TControl ) : String;
procedure ShowInputError( Sender : TcxCustomEdit; StError, StDesc : String );
function FindNextChildControl( ParentControl : TWinControl; FromStart : Boolean = True ) : TWinControl;
function ChildHasFocus( Control : TWinControl ) : Boolean;
procedure SelectChildControl( ParentControl : TWinControl; FromStart : Boolean = True );
function FindNextFormControl( CurControl : TWinControl; GoForward : Boolean = True  ) : TWinControl;
procedure SelectNextFormControl( CurControl : TWinControl; GoForward  : Boolean = True; CheckTabSheets : Boolean = False; Recursive : Boolean = False );
function ValidateEditControl( EditControl : TcxCustomEdit; UpdateData : Boolean = False; StoreData : Boolean = False ) : Boolean;
function ValidateEditControls( EditControls : TcxCustomEditArray; UpdateData : Boolean = False; StoreData : Boolean = False ) : Boolean;
function ValidateActiveEditControl( AForm : TForm; UpdateData : Boolean = False; StoreData : Boolean = False ) : Boolean;
procedure DoEditControlValidate( EditControl : TcxCustomEdit );
// function IsUserEditingControl( EditControl : TcxCustomEdit ) : Boolean;
function GetActiveGridTableViewData : TcxCustomGridTableViewData;
function GetFirstEditableItemIndex( GridView : TcxCustomGridTableView; Required : Boolean = True ) : Integer;
procedure CheckTextEditMinLength( Sender : TcxCustomEdit; DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean; MinLength : SmallInt = 0 );
procedure CheckNumericValue( var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);

function GetCustomEditCtrlArray( Owner : TComponent; Prefix : String; FirstIndex, LastIndex : SmallInt ) : TcxCustomEditArray;
function CustomEditCtrlArrayIsEmpty( CustomEditArray : TcxCustomEditArray ) : Boolean;

procedure ResetTab;

procedure GetDatasetValues( Dataset : TDataset; ValueList : TStringList );
procedure SetDatasetValues( Dataset : TDataset; ValueList : TStringList; TargetForm : TForm );
procedure AddBlueMark( EditControl : TcxCustomEdit );
procedure AddValueList( Field : TField; ValueList : TStringList );
procedure DatasetToParamValues( Dataset : TgxMemData; Params  : TParamsDictionary );

function GetDesktopTop : Integer;
function GetDesktopHeight : Integer;
function GetDesktopWidth : Integer;

function GetEditControl( AControl : TWinControl; IncludeGroupBoxes : Boolean = False ) : TcxCustomEdit;
procedure SelectEditControl( AControl : TWinControl );
function GetEditControlField( AControl : TComponent ) : TField;
function IsAutoIncControl( EditControl : TcxCustomEdit ) : Boolean;
function GetEditControlByName( AForm : TForm; AName : String ) : TcxCustomEdit;
function GetEditControlByFieldName( AForm : TForm; AFieldName : String ) : TcxCustomEdit;
function GetFirstEnabledButtonValue( RadioGroup : TcxDBRadioGroup ) : SmallInt;
function GetBarPopupMenuHeight( BarPopupMenu : TdxBarPopupMenu ) : SmallInt;
function GetBarPopupMenuWidth( BarPopupMenu : TdxBarPopupMenu ) : SmallInt;
procedure SetFirstEnabledButtonValue( RadioGroup : TcxDBRadioGroup; CheckIfEnabled : Boolean = True );
function FindRecordIndexByColumnValue( Column : TcxGridDBColumn; Value  : Variant ) : Integer;
function GetVisibleColumnIndex( GridView : TcxCustomGridTableView; ColumnIndex : SmallInt ) : SmallInt;
procedure SetColumnsEditingOption( GridView : TcxCustomGridTableView; CanEdit  : Boolean = True );
// procedure SwitchPasswordEchoMode( ButtonEditControls : TcxCustomButtonEditArray; Reset : Boolean = False );
procedure SetImageFromList( ImageList : TcxImageList; Glyph : TdxSmartGlyph; ImageIndex : SmallInt; Size : Smallint = 20 );

function GetDecimalPad( Decimals : SmallInt ) : String;
function FloatDisplayFormat( Decimals : Integer = DecimalesMoneda; ShowIfZero : Boolean = False ) :String;
function FloatEditFormat( Decimals : Integer = DecimalesMoneda; ShowIfZero : Boolean = False ) : String;

// procedure SetInfoColors( ACanvas : TCanvas );
procedure SetColumnDecimals( Column : TcxGridColumn; Decimals : SmallInt = DecimalesMoneda; ShowIfZero: Boolean = False );
procedure SetColumnsDecimals( const Columns : array of TcxGridColumn; Decimals : SmallInt = DecimalesMoneda; ShowIfZero : Boolean = False );
procedure SetEditControlDecimals( EditControl : TcxCustomCurrencyEdit; Decimals : SmallInt = DecimalesMoneda; ShowIfZero : Boolean = False );
procedure SetEditControlsDecimals( EditControls : array of TcxCustomCurrencyEdit; Decimals : SmallInt = DecimalesMoneda; ShowIfZero : Boolean = False );
procedure SetFooterSummaryItemsDecimals( TableView  : TcxGridDBTableView; const ItemsIndex : array of SmallInt; Decimals : SmallInt = DecimalesMoneda; ShowIfZero : Boolean = False );
procedure SetFooterSummaryItemDecimals( TableView  : TcxGridDBTableView; Index : SmallInt; Decimals : SmallInt = DecimalesMoneda; ShowIfZero : Boolean = True );
procedure SetDefaultGroupSummaryItemsDecimals( TableView : TcxGridDBTableView; const ItemsIndex : array of SmallInt; Decimals : SmallInt = DecimalesMoneda; ShowIfZero : Boolean = False );
procedure SetDefaultGroupSummaryItemDecimals( TableView : TcxGridDBTableView; Index : SmallInt; Decimals : SmallInt = DecimalesMoneda; ShowIfZero : Boolean = True );

procedure SetPanelValue( Panel : TcxGroupBox; Value : Variant; Decimales : SmallInt = DecimalesMoneda );

procedure SetBCDFieldDecimals( Field : TBCDField; Decimals : SmallInt = DecimalesMoneda; ShowIfZero : Boolean = False );
procedure SetBCDFieldsDecimals( Fields : array of TBCDField; Decimals : SmallInt = DecimalesMoneda; ShowIfZero : Boolean = False );

procedure SetupControlsPanel( Control : TWinControl; Enabled : Boolean; AdjustFormHeight : Boolean = False );

procedure SetupPanelableCtrl( Control : TcxCustomEdit; ControlEnabled : Boolean; AdjustFormHeight : Boolean = False; ParentContainer : TcxCustomEditContainer = nil ); overload;
procedure SetupPanelableCtrl( Control : TcxCustomEdit; ControlEnabled : Boolean; var ControlCount : SmallInt; AdjustFormHeight : Boolean = False ); overload;
procedure SetupPanelableCtrls( Controls : TcxCustomEditArray; OnSetEnabled : TCheckIndexFunction; AdjustFormHeight : Boolean = False ); overload;
procedure SetupPanelableCtrls( Controls : TcxCustomEditArray; Enabled : Boolean; AdjustFormHeight : Boolean = False ); overload;

procedure PinupAdjustableControl( AControl : TWinControl; AHeight  : SmallInt );

function ObtenSeleccionFilterPageControl( FiltroPageControl : TgxFilterPageControl; TabSheet : TcxTabSheet ) : SmallInt;

procedure SetActiveChartDiagram( GridDBChartView : TcxGridDBChartView; DiagramIndex : SmallInt );

procedure ShowGroupBox( Control : TcxGroupBox; Show : Boolean );
procedure SetGroupBoxControlsEnabled( Container : TcxCustomEdit; Value : Boolean; Force : Boolean = False ); overload;
procedure SetGroupBoxControlsEnabled( Container : TcxCustomEdit; Value : Boolean; Exceptions : array of TWinControl; Force : Boolean = False ); overload;
procedure SetGroupBoxEditControlsReadOnly( GroupBox : TcxGroupBox; Value : Boolean );

// procedure SetDefaultFont( Control  : TcxCustomEdit; DiffSize : SmallInt = 0 );
procedure SetClickableCaption( AGroupBox : TcxGroupBox; Value : String ); overload;
procedure SetClickableCaption( ALabel : TcxLabel; Value : String ); overload;

procedure SetFieldValueIfEmpty( Field : TField; SourceValue : Variant );
procedure SetEditValueIfEmpty( EditControl : TcxCustomEdit; SourceValue : Variant );
procedure SetRecordFieldValuesIfEmpty( Fields : array of TField; SourceValue : Variant );
procedure SetFieldRange( Field : TIntegerField; AMinValue : Integer = 1; AMaxValue : Integer = 99999999 ); overload;
procedure SetFieldRange( Field : TSmallIntField; AMinValue : Integer = 1; AMaxValue : Integer = High( SmallInt ) ); overload;
procedure SetFieldRange( Field : TField ); overload;

function GetKeyFieldValues( Table : TnxeTable ) : Variant;
procedure SetFieldsRange( Fields : array of TField );

function GetScrollBoxPanelCount( ScrollBox : TcxScrollBox ) : SmallInt;

function RecordExists(       Table : TnxeTable;
                       const Key   : array of const ) : Boolean;

procedure ValidateMonth(     Control      : TcxCustomEdit;
                         var DisplayValue : Variant;
                         var ErrorText    : TCaption;
                         var Error        : Boolean );

function ValidateYear(      DisplayValue    : Variant;
                        var ErrorText       : TCaption;
                        var Error           : Boolean;
                            IncludeLastYear : Boolean = False;
                            IncludeNextYear : Boolean = False ) : Boolean;

procedure ValidateDateRange(     DateRange     : TDateRange;
                                 ReferenceDate : TDate;
                             var DisplayValue  : Variant;
                             var ErrorText     : TCaption;
                             var Error         : Boolean );

function  ValidateRelation(       EditControl    : TcxCustomEdit;
                                  Table          : TnxeTable;
                            const Key            : array of const;
                            var   DisplayValue   : Variant;
                            var   ErrorText      : TCaption;
                            var   Error          : Boolean;

                                  DatasetFields  : TnxeDatasetFields = nil;
                                  DescFieldName  : String  = '';
                                  IsInfoControl  : Boolean = False ) : Boolean;

function  ValidateRelationEx(       EditControl     : TcxCustomEdit;
                                    Table           : TnxeTable;
                              const Key             : array of const;
                              var   DisplayValue    : Variant;
                              var   ErrorText       : TCaption;
                              var   Error           : Boolean;

                                    DatasetFields   : TnxeDatasetFields = nil;
                                    DescFieldName   : String  = '';
                                    IsInfoControl   : Boolean = False ) : String;

function GetRelationDescription(        Table              : TnxeTable;
                                  const Key                : array of const;
                                  out   Description        : String;
                                  const NotifyNonExistence : Boolean = False;
                                  const DescFieldName      : String = RsNombre ) : Boolean;

procedure BlockValueOutRange(    Sender         : TcxCustomEdit;
                                 DisplayValue   : TcxEditValue;
                                 FirstValueCtrl,
                                 LastValueCtrl  : TcxCustomEdit;
                             var ErrorText      : TCaption;
                                 MaxRange       : SmallInt = 1000 );

procedure BlockDateOutRange(     Sender         : TcxCustomEdit;
                                 DisplayValue   : TcxEditValue;
                                 FirstDateCtrl,
                                 LastDateCtrl   : TcxCustomEdit;
                             var ErrorText      : TCaption;
                                 MaxDays        : SmallInt = MaxDaysRange );

procedure CheckDateRange( FirstDate,
                          LastDate   : TDate;
                          MaxDays    : SmallInt = MaxDaysRange ); overload;

procedure CheckDateRange(     FirstDate,
                              LastDate   : TDate;
                          var ErrorText  : TCaption;
                          var Error      : Boolean;
                              MaxDays    : SmallInt = MaxDaysRange ); overload;

procedure SetFormValues( Values : array of const );
procedure CleanFormValues;
function FormValuesIsEmpty : Boolean;
procedure SetFormFieldsValues( Fields : array of TField );


var    ActiveFormManager      : TgxFormManager = nil;
       ClientShape            : TShape = nil;   // Un Shape transparente que ocupa el área de client para calcular su tamaño
       ActiveRecordButtonLink : TRecordButtonLink = nil;
       ActiveEditControl      : TcxCustomEdit = nil;
       LinkedFormsList        : TLinkedFormsList;

       RecordSpeedBtns        : TSpeedBtnTags = [ sbnFirstRec, sbnPriorRec, sbnRefreshRec, sbnNextRec, sbnLastRec, sbnSearchRec, sbnCancelSrchRec, sbnCopyRec ];

       // Este evento genérico solo existe para evitar referirse a EnterpriseDataAccess desde esta unit

       OnEditTableBeforeInsert : TEditTableEvent = nil;

var    FormValues             : TFieldValuesArray; // array of Variant;
       FormRecValues          : array of TVarRec;
       FormTableState         : TDatasetState = dsBrowse;
       FormCheckEditState     : Boolean = True;
       FormPositionIndex      : SmallInt = -1;
       NotifyError            : Boolean = False;

       LastGridFormReference : TgxForm = nil;
       LastSpreadSheetFormReference : TgxForm = nil;
       LastPDFViewerFormReference : TgxForm = nil;
       LastGanttFormReference  : TgxForm = nil;

       CurrentFormReference   : PgxForm;
       CurrentControlFunction : TSpeedBtnTag;
       ActiveControlFunctions : TSpeedBtnTags = [];

const  GraphicSizeWarning = 1048576;

       RsExpresion       = '<Expresión>';
       DataPanelBorder   = 5;
       FormRoundSize     = 14;

implementation

{$R *.dfm}

uses   Consts,
       Types,
       MultiMon,
       TypInfo,
       Variants,
       DateUtils,

       nxsdTypes,
       nxdbBase,
       nxllBde,
       nxllException,

       cxDB,
       cxVariants,
       cxGeometry,
       cxEditUtils,
       dxDPIAwareUtils,
       dxUxTheme,
       dxThemeManager,
       dxThemeConsts,
       dxTabbedMDI,
       dxSkinsLookAndFeelPainter,
       dxSkinInfo,
       cxGridDBDataDefinitions,

       DataAccess,
       NexusRpcData,

       GridTableViewController,
       QueryForm,
       EditSelector,
       MsgFrame,

       b_msg,
       b_flt,
       b_sch;


var    GUpdateRecordButtons : Boolean = False;
       GApplicationForms : TApplicationForms = nil;
       GResetTab : Boolean = False;
       GFocusedControl : TWinControl = nil;
       GLastMainChildForm : TgxForm = nil;
       GUpdatingMDILayout : Boolean = False;

const  InitRepeatPause = 400;
       RepeatPause = 100;

resourceString
       RsMsg1       = 'La ventana que intenta abrir no se pudo cerrar correctamente la ultima vez que la utilizó.';
       RsMsg2       = 'Si la ventana está siendo bloqueada por algún proceso, ciérrela y vuelva a intentarlo.'#13'Si no se soluciona el problerma, reinicie la aplicación.';
       //  RsMsg3       = 'Se ha producido una excepción.';
       RsMsg4       = 'Código inexistente.';
       RsMsg5       = 'Utilice la opción de consulta [B][F4][/B] para obtener una lista de los códigos disponibles.';
       RsMsg6       = '¿Está seguro de que desea cerrar la ventana de consulta?';
       RsMsg7       = 'Registros y documentos relacionados.';
       RsMsg8       = 'Se ha producido un error al acceder al gestor de base de datos.';
       RsMsg9       = 'Revise la configuración de arranque de GESTWIN y/o el estado del servidor de base de datos.';
       RsMsg10      = 'Demasiados filtros anidados.';
       RsMsg11      = 'Replantee la consulta con un anidamiento menor.';
       RsMsg12      = 'Ha hecho modificaciones en el registro actual.';
       RsMsg13      = '¿Confirma que desea abandonar la edición y perder los cambios realizados?';
       RsMsg14      = 'Este tipo de ventanas requiere un KeyPanel y un DataPanel.';
       RsMsg16      = 'Los valores introducidos en el filtro no son válidos.';
       RsMsg17      = 'Vuelva a introducir el filtro verificando la sintaxis.';
       RsMsg18      = 'Ningún registro coincide con el filtro indicado.';
       RsMsg19      = 'El registro está siendo editado y ha sido modificado.';
       RsMsg20      = 'No se puede cambiar de registro. Guarde o cancele los cambios y reintente el proceso cuando lo considere oportuno.';
       RsMsg21      = 'Se ha guardado la configuración.';
       RsMsg22      = 'La próxima vez que se abra la ventana se usarán los valores almacenados.';
       RsMsg23      = 'Ha ocurrido un error al intentar guardar los valores.';
       RsMsg24      = 'Reintente el proceso. En caso de error repetido revise su instalación.';
       RsMsg25      = 'Se ha borrado la configuración.';
       RsMsg26      = 'La ventana utilizará a partir de ahora los valores por defecto.';
       RsMsg28      = 'No ha introducido ninguna linea en este registro.';
       RsMsg29      = 'No pueden existir registros de este tipo sin líneas.'#13'¿Desea suprimir la cabecera de este registro?';
       RsMsg30      = 'Este componente debe colocarse en un TgxGridFooter.';
       RsMsg31      = 'El componente debe implementar InxeDataset.';
       RsMsg32      = ', al anterior';
       RsMsg33      = 'No existe el registro que intenta localizar.';
       RsMsg35      = 'El fichero está vacío. No hay ningún registro que seleccionar.';
       RsMsg36      = 'Este registro no pertenece al ejercicio o rango activos. No puede ser editado.';
       RsMsg37      = 'Para modificar o suprimir este registro debe situarse en el ejercicio al cual pertenece.';
       RsMsg38      = 'No existe ningún registro que contenga este valor del campo.';
       RsMsg39      = 'La fecha no pertenece al ejercicio en curso%s.';
       RsMsg40      = ' o al anterior';
       RsMsg41      = 'Puede cambiar de ejercicio activo para introducir registros de ejercicios anteriores o posteriores.';
       RsMsg43      = 'Valor autoincrementable no válido.';
       RsMsg44      = 'Si ha utilizado caracteres comodín (#), compruebe si el campo tiene una longitud fija o mínima.';
       RsMsg45      = '¿Está seguro de que desea cancelar la inserción de este registro?';
       RsMsg46      = 'Si cancela la edición en este punto perderá la información introducida hasta ahora en el registro.';
       RsMsg47      = 'No se ha podido generar un valor autoincrementable válido.';
       RsMsg48      = 'Revise el contenido del campo y utilice la sintaxis correcta para generar valores automáticos.';
       RsMsg50      = ' o al proximo';
       RsMsg51      = 'Otro usuario (o proceso) ha creado un registro con la misma clave mientras estaba competando su registro.';
       RsMsg52      = 'Se cancela la edición del registro en curso.'#13'Si desea evitar este tipo de conflictos en la generación automática de claves en entornos multiusuario, es aconsejable que active el uso de contadores (Parámetros generales de la aplicación).';
       RsMsg53      = 'No se ha podido crear un nuevo registro automático.';

       RsMsg55      = 'Los FrameManager debe situarse en un Frame.';
       RsMsg56      = 'No puede existir más de un FrameManager en un Frame.';
       RsMsg57      = 'El campo seleccionado no forma parte de la consulta.';
       RsMsg58      = 'Utilice las opciones que se muestran al pulsar sobre la cabecera de la columna para realizar búsquedas o filtros por este campo.';
       RsMsg59      = 'No puede modificar este registro';
       RsMsg60      = 'El registro está cerrado y tan solo puede ser consultado.';
       RsMsg64      = 'Esta entrada debe tener como mínimo %d caracteres.';
       RsMsg65      = 'No se ha encontrado ningun registro que contenga este valor en la columna seleccionada.';
       RsMsg66      = 'Modifique el texto de búsqueda y reintente la operación.';
       RsMsg68      = 'Este componente debe situarse en un TScrollBox.';
       RsMsg69      = 'Este componente debe situarse en un TgxForm.';

       RsMsg70      = 'No se ha podido guardar el registro.';
       RsMsg71      = 'Se cancela la edición.';
       RsMsg72      = 'El registro quedará tal y como estaba antes de intentar modificarlo.';
       RsMsg73      = 'El registro no ha sido creado.';

       RsMsg74      = 'La fecha debe ser %s que la fecha de referencia, %s';
       RsMsg75      = 'El rango de las fechas es muy alto.';
       RsMsg76      = '¿Está seguro de que desea utilizar un rango de fechas tan elevado? (es de <strong>%d días</strong>, del %s al %s)';
       RsMsg77      = 'El rango de valores es muy alto.';
       RsMsg78      = '¿Está seguro de que desea utilizar un rango de valores tan elevado? (es de %d registros)';

       RsMsg79      = 'Valor numérico incorrecto.';

       // En los hints no se debe utilizar HTML

       HintMsg1       = 'Muestra el documento que originó esta línea.\nTeclas [Ctrl]+[D]';
       HintMsg2       = 'Incluir/Excluir los parámetros\nde esta pestaña en el filtro.';
       HintMsg3       = ' [F11] para realizar una función especial aplicable a este campo';
       HintMsg4       = ' [Shift]+[F2] para obtener el valor por defecto de este campo';
       HintMsg5       = 'Fijar la ventana (Evitar que se cierre automáticamente al ejecutar el informe o activar otra ventana).\nTeclas [Ctrl]+[F]';
       HintMsg6       = ' [F12] para crear el próximo registro automático';
       HintMsg8       = 'Bloqueo del campo (Navegar fijando este campo).\nTeclas [Ctrl]+[B]';
       HintMsg9       = ' [F3] para editar o crear un nuevo registro';
       HintMsg10      = ' [F4] para obtener una relación de los registros existentes';
       HintMsg11      = ' [F4] para ver el selector de valores';
       HintMsg12      = ' [F11] ';

       HintMsg21      = 'Desplaza el registro una línea hacia arriba\nTeclas [Ctrl]+[Shift]+[Arriba]\no al principio de la lista\nTeclas [Ctrl]+[Shift]+[Inicio], Ratón [Shift]+<Click>';
       HintMsg22      = 'Desplaza el registro una línea hacia abajo\nTeclas [Ctrl]+[Shift]+[Abajo]\no al final de la lista\nTeclas [Ctrl]+[Shift]+[Fin], Ratón [Shift]+<Click>';

       HintMsg24      = 'Inserta un nuevo registro (línea).\nTecla [Insert]';
       HintMsg25      = 'Suprime un registro (línea).\nTecla [Supr]';
       HintMsg26      = 'Añade un nuevo registro (línea).\nTecla [Shift]+[Insert]';

       HintMsg32      = 'Los campos situados a la derecha determinan un rango de valores.\nArriba el valor inicial (desde) y abajo el final (hasta).';
       HintMsg34      = 'Menu de opciones asociadas a la ventana.\nTeclas [Ctrl]+[O]';
       HintMsg42      = 'Valor del campo fijado por el usuario.\nUtilice el menu de parámetros -situado en la barra inferior-\npara suprimirlo o actualizarlo.';

       HintMsg61      = 'Mostrar la consulta por pantalla, como una rejilla configurable.\nTeclas [Ctrl]+[R]';
       HintMsg62      = 'Pulse [Shift]+[Intro] para insertar saltos de línea.';
       // HintMsg63      = ' [Doble-Click] para editar con formato.';
       HintMsg64      = 'Utilice el botón derecho del ratón para\nacceder al menú de documentos vinculados.';


function ApplicationForms : TApplicationForms;
begin
     If   not Assigned( GApplicationForms )
     then GApplicationForms := TApplicationForms.Create( Application );
     Result := GApplicationForms;
end;

procedure CreateForm(       FormType         : TFormType;
                            FormClass        : TgxFormClass;
                      var   Reference;
                            Values           : Array of const;
                            CheckReference   : Boolean = True;
                            Hidden           : Boolean = False;
                            InstanceCount    : SmallInt = 0;
                            AppSection       : TgAppSection = nil;
                            OnBeforeShowForm : TBeforeShowFormProcedure = nil );

var  Instance : TComponent;
     Form : TgxForm;

begin

     try

       // ApplicationContainer.LockClientWindowUpdate;   // No parece que tenga ningún efecto aparente sobre la velocidad y limpieza al mostrar la ventana

       SetFormValues( Values );

       If   ReleasingApplication
       then begin
            Application.Terminate;   // Suele olvidarse
            Abort;
            end
       else begin
            Form := TgxForm( Reference );
            If   Assigned( Form )
            then try

                   With Form do
                     begin

                     If   ( csDestroying in ComponentState ) or ( Handle=0 )
                     then begin

                          try
                            Form.Free;
                          except
                            end;

                          TForm( Reference ) := nil;
                          CreateForm( FormType, FormClass, Reference, Values, CheckReference, Hidden, InstanceCount, AppSection );
                          Exit;
                          end;

                     If   Visible
                     then begin

                          RestoreWindow;
                          BringToFront;
                          SetFocus;

                          If   High( Values )>=0
                          then If   Assigned( OnShow )
                               then OnShow( nil );

                          end;
                     end;

                   except
                     ShowNotification( ntStop, RsMsg1, RsMsg2 );
                     Abort;
                     end
            else begin

                 If   CheckReference
                 then CurrentFormReference := @Reference
                 else CurrentFormReference := nil;

                 Instance := TComponent( FormClass.NewInstance );
                 TComponent( Reference ) := Instance;
                 try

                   try

                     Instance.Create( Application.MainForm );

                     If   DatabaseUpdateRequested
                     then Abort
                     else begin
                          Form := TgxForm( Reference );
                          If   CheckReference
                          then If   not Assigned( Form.ReferencePtr ) // no se ha inicializado correctamente
                               then Abort;

                          Form.FormType := FormType;
                          Form.FInstanceCount := InstanceCount;
                          If   Form.AppSection=nil  // Así se puede asignar en el Create del TForm
                          then Form.AppSection := AppSection;

                          If   TouchApplication
                          then begin
                               Form.BorderIcons := [];
                               Form.FormStyle := fsNormal;
                               Form.BorderStyle := bsNone;
                               Form.Align := alClient;
                               If   FormType in [ fmEdit, fmGrid, fmBackground ]
                               then Form.Parent := ApplicationContainer.DataPanel
                               else Form.Parent := ApplicationContainer.QueryPanel;
                               end;

                          Form.AdjustScale;

                          If   Assigned( OnBeforeShowForm )
                          then OnBeforeShowForm( Form );

                          If   Hidden
                          then Form.Visible := False
                          else If   ( Form.FormStyle=fsMDIChild ) or TouchApplication
                               then Form.Visible := True;

                          end;

                   except on E : Exception do
                     begin
                     TForm( Reference ) := nil;
                     If   E is EnxBaseException
                     then ShowDatabaseError( nil, E as EnxBaseException )
                     else ShowException( E, nil );
                     Abort;
                     end;

                   end;

                 finally
                   CurrentFormReference := nil;
                   end;

                 end;
       end;

     finally
       CleanFormValues;
       // ApplicationContainer.UnlockClientWindowUpdate;
       end;

end;

procedure CreateForm( FormType          : TFormType;
                      FormClass         : TgxFormClass;
                      Values            : Array of const;
                      MultipleInstances : Boolean = False;
                      Hidden            : Boolean = False;
                      AppSection        : TgAppSection = nil );

var  Form : TgxForm;
     InstanceCount : SmallInt;

function FindMDIChild : TgxForm;

var  I : SmallInt;
     Select : Boolean;

begin
     Result := nil;
     Select := False;
     InstanceCount := 0;
     With Application.MainForm do
       For I := 0 to MDIChildCount - 1 do
         If   MDIChildren[ I ].ClassType=FormClass
         then begin
              If   MultipleInstances
              then begin
                   If   InstanceCount<2
                   then Inc( InstanceCount )
                   else Select := True;      // No más de 3 ventanas del mismo tipo
                   end
              else Select := True;
              If   Select
              then begin
                   Result := TgxForm( MDIChildren[ I ] );
                   Exit;
                   end;
              end;
end;

begin
     Form := FindMDIChild;
     CreateForm( FormType, FormClass, Form, Values, False, Hidden, InstanceCount, AppSection );
end;

procedure CreateForm(       FormType        : TFormType;
                            FormClass       : TgxFormClass;
                      var   Reference;
                            CheckReference  : Boolean = True;
                            Hidden          : Boolean = False;
                            AppSection      : TgAppSection = nil  );
begin
     CreateForm( FormType, FormClass, Reference, [], CheckReference, Hidden, 0, AppSection );
end;

procedure CleanFormReference( AForm : TgxForm );
begin
     If   Assigned( AForm ) and not IsDesignTime
     then try

            AForm.ClassName; // Simplemente provoco una excepción si el valor no está correctemnete asignado
                             // Siempre es preferible una excepción durante una lectura que intentar asignar un valor a un puntero no válido

            If    Assigned( AForm.ReferencePtr )   // es una referencia al propio puntero del form
            then  begin
                  AForm.ReferencePtr^ := nil;
                  // Una vez limpia la referencia, el puntero ya no es válido
                  AForm.ReferencePtr := nil;
                  end;

            except
              end;
end;

procedure MainMenuActive( Value         : Boolean;
                          ActivateForms : Boolean = False;
                          UpdateMenus   : Boolean = False );

var   I  : SmallInt;
      BarSubItem : TdxBarSubItem;

begin
     With ApplicationContainer do
       If   not ReleasingApplication
       then If   Assigned( CurrentMainMenuBar )
            then begin

                 With CurrentMainMenuBar do
                   For I := 0 to ItemLinks.Count - 1 do
                     If   ItemLinks[ I ].Item is TdxBarSubItem
                     then begin
                          BarSubItem := TdxBarSubItem( ItemLinks[ I ].Item );
                          BarSubItem.Enabled := Value;
                          end;

                 If   UpdateMenus and Assigned( CurrentSection ) and Value
                 then CurrentSection.UpdateMainMenu;

                 SectionsButton.Enabled := Value;
                 IsMenuBarActive := Value;

                 If   ActivateForms
                 then With Application.MainForm do
                        For I := 0 to MDIChildCount - 1 do
                          MDIChildren[ I ].Enabled := Value;

                 end;
end;

function ChildHasFocus( Control : TWinControl ) : Boolean;
begin
     Result := False;
     For var I := 0 to Control.ControlCount - 1 do
       If   Control.Controls[ I ] is TWinControl
       then If   TWinControl( Control.Controls[ I ] ).Focused
            then begin
                 Result := True;
                 Break;
                 end;
end;

function FindNextChildControl( ParentControl : TWinControl;
                               FromStart     : Boolean = True ) : TWinControl;

var  I, StartIndex : Integer;
     List : TList;
     CurControl : TWinControl;

begin
     Result := nil;
     List := TList.Create;
     try
       ParentControl.GetTabOrderList( List );
       If   List.Count>0
       then begin
            If   FromStart
            then StartIndex := -1
            else StartIndex := List.Count;
            I := StartIndex;
            repeat
              If   FromStart
              then begin
                   Inc( I );
                   If   I=List.Count
                   then Break;
                   end
              else begin
                   If   I=0
                   then Break;
                   Dec( I );
                   end;
              CurControl := List[ I ];
              If   CurControl.CanFocus and CurControl.TabStop
              then Result := CurControl;
            until Assigned( Result ) or ( I=StartIndex );
            end;
     finally
       List.Free;
       end;
end;

procedure SelectChildControl( ParentControl : TWinControl;
                              FromStart     : Boolean = True );

var  ChildControl : TWinControl;

begin
     ChildControl := FindNextChildControl( ParentControl, FromStart );
     If   Assigned( ChildControl )
     then ChildControl.SetFocus;
end;

function FindNextFormControl( CurControl : TWinControl;
                              GoForward  : Boolean = True ) : TWinControl;

var  I, StartIndex : Integer;
     List : TList;
     Form : TCustomForm;

begin
     Result := nil;
     Form := GetParentForm( CurControl );
     If   Assigned( Form )
     then begin
            List := TList.Create;
            try
              Form.GetTabOrderList( List );
              If   List.Count>0
              then begin
                   StartIndex := List.IndexOf( CurControl );
                   If   StartIndex=-1
                   then If   GoForward
                        then StartIndex := List.Count - 1
                        else StartIndex := 0;
                   I := StartIndex;
                   repeat
                     If   GoForward
                     then begin
                          Inc( I );
                          If   I=List.Count
                          then I := 0;
                          end
                     else begin
                          If   I=0
                          then I := List.Count;
                          Dec( I );
                          end;
                     CurControl := List[ I ];
                     If   CurControl.TabStop and CurControl.CanFocus
                     then Result := CurControl;
                   until Assigned( Result ) or ( I=StartIndex );
                   end;
            finally
              List.Free;
              end;
            end;
end;

procedure SelectNextFormControl( CurControl     : TWinControl;
                                 GoForward      : Boolean = True;
                                 CheckTabSheets : Boolean = False;
                                 Recursive      : Boolean = False );

var  NextControl : TWinControl;
     TabSheet,
     NextTabSheet : TcxTabSheet;
     EditControl : TcxCustomEdit;
     AParentForm : TCustomForm;

begin
     GResetTab := False;

     NextControl := FindNextFormControl( CurControl, GoForward );
     TabSheet := GetParentTabSheet( CurControl );

     If   Assigned( NextControl )
     then begin

          If   not GResetTab and CheckTabSheets
          then If   Assigned( TabSheet )
               then If   not ( TabSheet.PageControl.HideTabs and ( TabSheet.PageControl.TabulationCycle=tcNone ) ) and // Los PageControl sin Tabs visibles son para stacks
                         ( TabSheet.PageControl.TabulationCycle<>tcNone )
                    then begin
                         If   GetParentTabSheet( NextControl )<>TabSheet
                         then begin
                              NextTabSheet := TabSheet.PageControl.FindNextPage( TabSheet, GoForward, True );
                              If   Assigned( NextTabSheet ) and
                                   ( ( GoForward and ( NextTabSheet.PageIndex>TabSheet.PageIndex ) ) or
                                     ( not GoForward and ( NextTabSheet.PageIndex<TabSheet.PageIndex ) ) )
                              then begin
                                   NextTabSheet.PageControl.ActivePage := NextTabSheet;
                                   // Puede haberse cancelado el focus durante la validación de un campo
                                   AParentForm := GetParentForm( NextTabSheet );
                                   If   GResetTab
                                   then begin
                                        AParentForm.ActiveControl := NextTabSheet;   // Si no es así el TcxPageControl no permite el cambio
                                        TabSheet.PageControl.ActivePage := TabSheet;
                                        end
                                   else begin
                                        If   NextTabSheet.PageControl.ActivePage=NextTabSheet
                                        then If   not GoForward or Recursive
                                             then begin
                                                  NextTabSheet.SetFocus;
                                                  SelectChildControl( NextTabSheet, GoForward );
                                                  end;
                                        Exit;
                                        end;
                                   end;
                              end;
                        end;

          // Un caso especial que se da en algunas ocasiones

          AParentForm := GetParentForm( NextControl );
          If   Assigned( AParentForm ) and not AParentForm.Active
          then Exit;

          NextControl.SetFocus;

         // Si quiero que se vuelva a considerar la tabulación (por si durante la validación o el cambio de valor de un campo he activado/desactivado el siguiente)
         // basta con poner ResetTab a True ...

         If   not Recursive and GResetTab
         then begin
              EditControl := GetEditControl( CurControl );
              If   Assigned( EditControl )
              then CurControl := EditControl;
              SelectNextFormControl( CurControl, GoForward, CheckTabSheets, True );
              end;

         end;
end;

procedure ControlKeyPress( var Key : Char );
begin
     case Key of
       '.' : If   IsKeyPressed( VK_DECIMAL )
             then Key := FormatSettings.DecimalSeparator;

       '+' : If   ApplicationContainer.SimTabWithKeyPad and IsKeyPressed( VK_ADD )
             then begin
                  keyEvent( VK_TAB );
                  Key := #0;
                  end;

       '-' : If   ApplicationContainer.SimTabWithKeyPad and IsKeyPressed( VK_SUBTRACT )
             then begin
                  keyEvent( VK_TAB, [ ssShift ] );
                  Key := #0;
                  end;
       end;
end;

// Usar la función 'StoreValue' del TcxCustomEdit para almacenar y validar al mismo tiempo un valor
// UpdateDate actualiza el valor desde el Field (DataBinding), descartando el posible valor contenido en EditValue

function ValidateEditControl( EditControl : TcxCustomEdit;
                              UpdateData  : Boolean = False;
                              StoreData   : Boolean = False ) : Boolean;
begin
     Result := False;
     If   Assigned( EditControl )
     then With EditControl do
            begin
            If   UpdateData
            then DataBinding.UpdateDisplayValue;
            Result := ValidateEdit( False );
            If   Result and StoreData
            then PostEditValue;
            end;
end;

function  ValidateEditControls( EditControls : TcxCustomEditArray;
                                UpdateData   : Boolean = False;
                                StoreData    : Boolean = False ) : Boolean;

var CustomEdit : TcxCustomEdit;

begin
     Result := True;
     For CustomEdit in EditControls do
       Result := Result and ValidateEditControl( CustomEdit, UpdateData, StoreData )
end;

function  ValidateActiveEditControl( AForm : TForm; UpdateData : Boolean = False; StoreData : Boolean = False ) : Boolean;

var   EditControl : TcxCustomEdit;

begin
     EditControl := GetEditControl( AForm.ActiveControl );
     If   Assigned( EditControl )
     then Result := ValidateEditControl( EditControl, UpdateData, StoreData )
     else Result := False;
end;

// Esta función solo ejecuta el DoOnValidate del EditControl, esté o no activo (Enabled)

procedure DoEditControlValidate( EditControl : TcxCustomEdit );

var  ErrorText : TCaption;
     Error : Boolean;
     EditDisplayValue  : Variant;

begin
     With EditControl, Properties  do
       If   Assigned( OnValidate )
       then begin
            EditDisplayValue := DataBinding.DisplayValue;
            OnValidate( EditControl, EditDisplayValue, ErrorText, Error );
            end;
end;

{
function IsUserEditingControl( EditControl : TcxCustomEdit ) : Boolean;
begin
     Result := False;
     If   Assigned( EditControl )
     then With EditControl do
            Result := not ExternalPostingValue and UserValidateAction and ( not IsInplace or CanPostEditValue );
end;
}

procedure ResetTab;
begin
     GResetTab := True;
end;

procedure SetFormValues( Values : array of const );

var   I, Segments  : SmallInt;

begin

     // Relleno dos arrays con el mismo contenido (por versatilidad) : uno de Variant y otro de TVarRec

     Segments := High( Values );
     If   Segments<>-1
     then begin
          SetLength( FormValues, Segments + 1 );
          SetLength( FormRecValues, Segments + 1 );
          For I := 0 to Segments do
            begin
            FormRecValues[ I ] := Values[ I ];
            FormValues[ I ] := VarRecToVariant( Values[ I ] );
            end;
          end;
end;

procedure CleanFormValues;
begin
     FormValues := nil;
     FormRecValues := nil;
     FormTableState := dsBrowse;
end;


function FormValuesIsEmpty : Boolean;
begin
     Result := True;
     If   Assigned( FormValues )
     then For var Value : Variant in FormValues do
             If   not VarIsNull( Value )
             then begin
                  Result := False;
                  Exit;
                  end;
end;

procedure SetFormFieldsValues( Fields : array of TField );

var   I, Segments  : SmallInt;

begin
     Segments := High( FormValues );
     If   ( Segments<>-1 ) and ( Segments=High( Fields ) )
     then For I := 0 to Segments do
            Fields[ I ].Value := FormValues[ I ];
end;

procedure CreateEditForm(     FormClass   : TgxFormClass;
                          var Reference;
                              AppSection : TgAppSection = nil;
                              Exclusive  : Boolean = False );
begin
     CreateEditForm( FormClass, Reference, [], AppSection, Exclusive );
end;

procedure CreateEditForm(     FormClass   : TgxFormClass;
                          var Reference;
                              Values      : array of const;
                              AppSection  : TgAppSection = nil;
                              Exclusive   : Boolean = False );

var  Form : TgxForm;

begin

     If   Exclusive
     then begin
          case ApplicationContainer.TryToCloseAll( False ) of   // No se deben cerrar los datamodules, solo se hace al cambiar de Empresa
            mrAbort:
               begin
               ShowNotification( ntStop, RsgMsg180, RsgMsg181 );
               Abort;
               end;
            mrCancel:
              Exit;
              end;
          DataAccessModule.CloseInactiveMainSessionResources;
          end;

     CreateForm( fmEdit, FormClass, Reference, Values, True, False, 0, AppSection );

     Form := TgxForm( Reference );
     If   Assigned( Form )
     then Form.Exclusive := Exclusive;
end;

procedure CreateEditForm( FormClass         : TgxFormClass;
                          Values            : array of const;
                          MultipleInstances : Boolean = False;
                          AppSection        : TgAppSection = nil );
begin
     CreateForm( fmEdit, FormClass, Values, MultipleInstances, False, AppSection );
end;

function GetEditControlByName( AForm : TForm; AName : String ) : TcxCustomEdit;

var  Component: TComponent;

begin
     Result := nil;
     Component := AForm.FindComponent( AName );
     If   Assigned( Component ) and ( Component is TcxCustomEdit )
     then Result := TcxCustomEdit( Component );
end;

function GetEditControlByFieldName( AForm : TForm; AFieldName : String ) : TcxCustomEdit;

var  Field : TField;
     Component: TComponent;
     EditControl : TcxCustomEdit;

begin
     Result := nil;
     For Component in AForm do
        If   Component is TWinControl
        then begin
             EditControl := GetEditControl( Component as TWinControl );
             If   Assigned( EditControl ) and Assigned( EditControl.DataBinding ) and ( EditControl.DataBinding is TcxDBEditDataBinding )
             then begin
                  Field := TcxDBEditDataBinding( EditControl.DataBinding ).Field;
                  If   Assigned( Field ) and InternalCompareString( Field.FieldName, AFieldName, False )
                  then begin
                       Result := EditControl;
                       Break;
                       end;
                  end;
             end;
end;

function GetEditControlField( AControl : TComponent ) : TField;

var DBField : TField;

begin
     Result := nil;
     If   AControl is TcxCustomEdit
     then With AControl as TcxCustomEdit do
            If   Assigned( DataBinding ) and ( DataBinding is TcxDBEditDataBinding )
            then With DataBinding as TcxDBEditDataBinding do
                   begin
                   DBField := nil;
                   If   Assigned( Field )
                   then DBField := Field
                   else If   Assigned( DataSource ) and Assigned( DataSource.Dataset )
                        then DBField := DataSource.Dataset.FieldByName( DataField );
                   If   Assigned( DBField ) and ( DBField is TField )
                   then Result := DBField as TField;
                   end;
end;

function IsAutoIncControl( EditControl : TcxCustomEdit ) : Boolean;
begin
     Result := False;
     If   Assigned( EditControl )
     then With EditControl do
            If   Assigned( DataBinding ) and ( DataBinding is TcxDBEditDataBinding )
            then With DataBinding as TcxDBEditDataBinding do
                   If   Assigned( Field )
                   then begin
                        If   DataSource.Dataset is TnxeTable
                        then Result := TnxeTable( DataSource.Dataset ).AutoIncFieldName=Field.FieldName
                        else If   DataSource.Dataset is TnxeQuery
                             then Result := TnxeQuery( DataSource.Dataset ).AutoIncFieldName=Field.FieldName;
                        end;
end;

procedure DoNestedActivation( Msg     : Cardinal;
                              Control : TWinControl;
                              Form    : TCustomForm );
begin
     If   Control=nil
     then Exit;
     // Encontrar el parent mas cercano que sea un form
     While ( Control.Parent<>nil ) and not ( Control is TCustomForm ) do
       Control := Control.Parent;
     If   Assigned( Control ) and ( Control<>Form )
     then SendMessage( Control.Handle, Msg, 0, 0 );
end;

procedure DatasetToParamValues( Dataset : TgxMemData;
                                Params  : TParamsDictionary );

var  I : SmallInt;
     FieldValue : Variant;

begin
     If   Assigned( Dataset )
     then With Dataset do
            For I := 0 to FieldCount - 1 do
              With Fields[ I ] do
                begin
                FieldValue := Value;
                If   VarIsNull( FieldValue )
                then case DataType of
                       ftString,
                       ftWideString : FieldValue := '';
                       ftSmallint,
                       ftInteger,
                       ftWord       : FieldValue := 0;
                       ftBoolean    : FieldValue := False;
                       ftFloat,
                       ftCurrency,
                       ftDate,
                       ftDateTime,
                       ftTime       : FieldValue := 0.0;
                       end;
                Params.Add( FieldName, FieldValue );
                end;
end;

procedure SetImageFromList( ImageList  : TcxImageList;
                            Glyph      : TdxSmartGlyph;
                            ImageIndex : SmallInt;
                            Size       : Smallint = 20 );
begin
     ImageList.GetImage( ImageIndex, Glyph );
     Glyph.SourceWidth := Size;
     Glyph.SourceHeight := Size;
end;

{ GridForm }

function CreateGridForm( FormClass : TgxFormClass ) : TgxForm;
begin
     LastGridFormReference := nil;
     CreateForm( fmGrid, FormClass, LastGridFormReference, [], False );
     Result := LastGridFormReference;
end;

procedure CreateGridForm(     FormClass : TgxFormClass;
                          var Reference );
begin
     CreateForm( fmGrid, FormClass, Reference, [], False );
     LastGridFormReference := TgxForm( Reference );
end;

{ SpreadSheetForm }

function CreateSpreadSheetForm( FormClass : TgxFormClass ) : TgxForm;
begin
     LastSpreadSheetFormReference := nil;
     CreateForm( fmBackground, FormClass, LastSpreadSheetFormReference, [], False );
     Result := LastSpreadSheetFormReference;
end;

procedure CreateSpreadSheetForm(     FormClass : TgxFormClass;
                                 var Reference;
                                     Hidden    : Boolean = False );
begin
     CreateForm( fmBackground, FormClass, Reference, [], False, Hidden );
     LastSpreadSheetFormReference := TgxForm( Reference );
end;

{ PDFViewerForm }

function CreatePDFViewerForm( FormClass : TgxFormClass; Path, FileName : String ) : TgxForm;
begin
     LastPDFViewerFormReference := nil;
     CreateForm( fmBackground, FormClass, LastPDFViewerFormReference, [], False );
     Result := LastPDFViewerFormReference;
end;

{ GanttForm }

function CreateGanttForm( FormClass : TgxFormClass ) : TgxForm;
begin
     LastGanttFormReference := nil;
     CreateForm( fmBackground, FormClass, LastGanttFormReference, [], False );
     Result := LastGanttFormReference;
end;

procedure CreateGanttForm(     FormClass : TgxFormClass;
                           var Reference;
                               Hidden    : Boolean = False );
begin
     CreateForm( fmBackground, FormClass, Reference, [], False, Hidden );
     LastGanttFormReference := TgxForm( Reference );
end;

function VisibleMDIChildCount : SmallInt;

var  I : SmallInt;

begin
     Result := 0;
     If   Assigned( Application.MainForm )
     then With Application.MainForm do
            For I := 0 to MDIChildCount - 1 do
              If   MDIChildren[ I ] is TgxForm
              then If   TgxForm( MDIChildren[ I ] ).Visible
                   then Inc( Result );
end;

function MDIChildFormExists( AForm : TForm ) : Boolean;

var  Index : SmallInt;

begin
     Result := False;
     With Application.MainForm do
       For Index := 0 to MDIChildCount - 1 do
         If   MDIChildren[ Index ]=AForm
         then begin
              Result := True;
              Exit;
              end;
end;

procedure PlaceForm( AForm : TgxForm );

var  AQueryPanel : TComponent;
     CenterIt : Boolean;
     CurrentBounds : TRect;

begin
     If   Assigned( AForm )
     then If   AForm.FormType<>fmSelector
          then If   Assigned( AForm.FormManager )
               then begin
                    If   ( ( ApplicationContainer.TDI ) or
                           ( ApplicationContainer.CurrentMDILayout=mdiNone ) or
                           ( AForm.FormStyle<>fsMDIChild ) or
                           ( AForm.FormManager.Model in [ fmInputForm, fmReportForm ] ) )
                    then CenterForm( AForm )
                    else UpdateMDILayout( ApplicationContainer.CurrentMDILayout, AForm );
                    end
               else If   AForm.FormType=fmQuery // Es un query
                    then begin
                         AQueryPanel := FindComponentByClass( AForm, TgQueryPanel );
                         If   Assigned( AQueryPanel )
                         then PlaceQueryForm( TgQueryPanel( AQueryPanel ), False );
                         end
                    else CenterForm( AForm );
end;

procedure CenterForm( AForm : TgxForm );

var   Point : TPoint;
      Wl, Wt, Ww, Wh,
      Cw, Ch : Integer;

begin
     If   Assigned( Application.MainForm ) and
          Assigned( AForm ) and
          not ( csDestroying in AForm.ComponentState ) and
          AForm.Enabled and
          ( AForm.FormStyle=fsMDIChild ) and
          not ( ( CodigoUsuarioActual<>'' ) and ApplicationContainer.TDI and AForm.TDITabSheetForm )
     then With AForm do
            begin

            // La comprobación de 'Visible' es para poder centrar la ventana aunque su estado final sea Maximized y así poder guardar la
            // posición y tamaño por si el usuario intenta restaurarla (se vuelve a llamar a esta función cuando la ventana es visible)

            If   not ( ( ApplicationContainer.CurrentMDILayout<>mdiNone ) and ( AForm.FormType=fmQuery ) )
            then If   Visible and ( MDIMaximizedForm or ( ( ApplicationContainer.CurrentMDILayout=mdiNone ) and Maximized ) )
                 then MaximizeForm
                 else begin

                      Wl := ( GetDesktopWidth - Width ) div 2;
                      If   Wl<0
                      then Wl := 0;

                      Wt := ( GetDesktopHeight - Height ) div 2;
                      If   Wt<0
                      then Wt := 0;

                      Cw := GetDesktopWidth;
                      Ww := Width;
                      If   Ww>Cw
                      then Ww := Cw;

                      Ch := GetDesktopHeight;
                      Wh := Height;
                      If   Wh>Ch
                      then Wh := Ch;

                      // Si hay más de una instancia de la misma ventana la desplazo un poco para que sea visible

                      If   InstanceCount<>0
                      then begin
                           Wl := Wl + ( InstanceCount * 30 );
                           Wt := Wt + ( InstanceCount * 30 );
                           end;

                      SetBounds( Wl, Wt, Ww, Wh );
                      end;

            end;
end;

procedure CenterInParent( Control     : TWinControl;
                          Orientation : TCenterOrientation = coHorizontal );


begin
     With Control do
       begin
       If   Orientation in [ coHorizontal, coBoth ]
       then Left := ( Parent.Width div 2 ) - ( Width div 2 );
       If   Orientation in [ coVertical, coBoth ]
       then Top := ( Parent.Height div 2 ) - ( Height div 2 );
       end;
end;

procedure UpdateMDILayout( MDILayout   : TMDILayout;
                           CurrentForm : TgxForm = nil;
                           ClosingForm : Boolean = False;
                           Recursive   : Boolean = False );

var  FormList : TList< TgxForm >;

     I : SmallInt;

     MainForm : TForm;

     MainChildForm,
     ChildForm : TgxForm;

     ChildTop,
     ChildLeft,
     ChildHeight,
     ChildWidth,
     MiddleWidth,
     MiddleHeight,
     MDIClientWidth,
     MDIClientHeight : Integer;

function GetActiveMDIChild( CheckBackgroundForm : Boolean = True ) : TgxForm;
begin
     Result := nil;
     var ActiveForm := MainForm.ActiveMDIChild;
     If   ActiveForm is TgxForm
     then begin
          var GForm := TgxForm( ActiveForm );
          If   not CheckBackgroundForm or GForm.BackgroundForm
          then Result := GForm;
          end;
end;

function NextAvailableForm : TgxForm;

var  CurrentActiveForm,
     ActiveForm : TgxForm;

begin
     Result := nil;
     CurrentActiveForm := GetActiveMDIChild;
     repeat
       MainForm.Next;
       ActiveForm := GetActiveMDIChild;
       If   Assigned( ActiveForm ) and
            not ( csDestroying in ActiveForm.ComponentState )
            and ActiveForm.Visible
       then begin
            Result := ActiveForm;
            Exit;
            end;
     until not Assigned( ActiveForm ) or ( ActiveForm=CurrentActiveForm );
end;

function FillFormList : Boolean;

var  I : SmallInt;
     AForm : TgxForm;

begin
     Result := False;

     MainChildForm := GetActiveMDIChild( { CheckBackgroundForm } False );

     // Puede que la ventana activa no sea de fondo o que se autodestruya

     If   Assigned( MainChildForm )
     then If   not MainChildForm.BackgroundForm
          then begin
               If   not ( csDestroying in MainChildForm.ComponentState ) and MainChildForm.Visible
               then PlaceForm( MainChildForm );
               MainChildForm := GLastMainChildForm;
               end
          else If   MainChildForm.CloseWindowWhenFocusLost
               then MainChildForm := nil;

     If   Assigned( MainChildForm )  // En caso contrario no hay ninguna ventana de fondo activa
     then begin

          If   ( csDestroying in MainChildForm.ComponentState ) or // Se está destruyendo precisamente la ventana activa
               not MainChildForm.Visible
          then begin
               If   GLastMainChildForm=CurrentForm
               then begin
                    GLastMainChildForm := nil;
                    MainForm.Next;
                    If   Assigned( CurrentForm ) and ( GetActiveMDIChild<>CurrentForm )
                    then UpdateMDILayout( MDILayout, nil, ClosingForm, { Recursive } True );
                    Exit;
                    end
               else MainChildForm := GLastMainChildForm;
               end
          else If   MainChildForm.BackgroundForm and MainChildForm.Visible
               then GLastMainChildForm := MainChildForm;

          end
     else Exit;

     // Ahora se puede crear la lista de ventanas secundarias

     If   Assigned( MainChildForm )
     then begin
          For I := 0 to MainForm.MDIChildCount - 1 do
            If   MainForm.MDIChildren[ I ] is TgxForm
            then begin

                 AForm := MainForm.MDIChildren[ I ] as TgxForm;

                 If   ( AForm.BackgroundForm ) and
                      ( AForm.Visible or ( ( AForm=CurrentForm ) and not ClosingForm ) ) and
                      ( not ( csDestroying in AForm.ComponentState ) ) and
                      ( AForm.WindowState=wsNormal ) and
                      ( AForm<>MainChildForm )
                 then FormList.Add( AForm );

                 end;
          Result := True;
          end;

end;

procedure ArrangeNoneLayoutForms;

var  I : SmallInt;
     AForm : TgxForm;

begin
     // Solo de reordenan las ventanas de fondo (maximizadas) y las temporales (fmInputForm), que se centran

     If   Assigned( Application.MainForm ) and not ApplicationContainer.TDI
     then If   Application.MainForm.FormStyle=fsMDIForm
          then For I := 0 to Application.MainForm.MDIChildCount - 1 do
                 If   Application.MainForm.MDIChildren[ I ] is TgxForm
                 then begin
                      AForm := TgxForm( Application.MainForm.MDIChildren[ I ] );
                      If   AForm.Maximized or AForm.CloseWindowWhenFocusLost
                      then PlaceForm( AForm );
                      end;
end;

begin

     If   ApplicationContainer.TDI
     then Exit;

     If   ApplicationContainer.TryingToCloseAllForms
     then GLastMainChildForm := nil
     else If   not GUpdatingMDILayout or Recursive
          then begin
               GUpdatingMDILayout := True;
               try

                 ApplicationContainer.CurrentMDILayout := MDILayout;

                 If   MDILayout=mdiNone
                 then ArrangeNoneLayoutForms
                 else begin

                      MainForm := Application.MainForm;

                      If   MDILayout<>mdiNone
                      then begin

                           FormList := TList< TgxForm >.Create;
                           try

                             If   FillFormList
                             then begin

                                  MDIClientHeight := GetDesktopHeight;
                                  MDIClientWidth := MainForm.ClientWidth - 4;

                                  MiddleWidth := MDIClientWidth div 2;
                                  MiddleHeight := MDIClientHeight div 2;

                                  // Tienen que haber, al menos, dos ventanas. Una de ellas es la ventana activa.

                                  If   Assigned( MainChildForm ) and ( FormList.Count>0 )
                                  then case MDILayout of

                                         mdiLeftRest :
                                           begin

                                           MainChildForm.Left := 0;
                                           MainChildForm.Top := 0;
                                           MainChildForm.Width := MiddleWidth;
                                           MainChildForm.Height:= MDIClientHeight;

                                           ChildTop := 0;
                                           ChildHeight := MDIClientHeight div FormList.Count;

                                           For I := 0 to FormList.Count - 1 do
                                             begin
                                             ChildForm := FormList.Items[ I ];
                                             If   Assigned( ChildForm )
                                             then begin
                                                  ChildForm.Left := MiddleWidth;
                                                  ChildForm.Top := ChildTop;
                                                  ChildForm.Width := MDIClientWidth - MiddleWidth;
                                                  If   I=FormList.Count - 1
                                                  then ChildForm.Height := MDIClientHeight - ChildForm.Top
                                                  else ChildForm.Height := ChildHeight;
                                                  Inc( ChildTop, ChildHeight );
                                                  end;
                                             end;

                                           end;

                                         mdiTopRest :
                                           begin

                                           MainChildForm.Left := 0;
                                           MainChildForm.Top := 0;
                                           MainChildForm.Width := MDIClientWidth;
                                           MainChildForm.Height:= MiddleHeight;

                                           ChildLeft := 0;
                                           ChildWidth := MDIClientWidth div FormList.Count;

                                           For I := 0 to FormList.Count - 1 do
                                             begin
                                             ChildForm := FormList.Items[ I ];
                                             If   Assigned( ChildForm )
                                             then begin
                                                  ChildForm.Left := ChildLeft;
                                                  ChildForm.Top := MiddleHeight;

                                                  ChildForm.Height := MiddleHeight;
                                                  If   I=FormList.Count - 1
                                                  then ChildForm.Width := MDIClientWidth - ChildForm.Left
                                                  else ChildForm.Width := ChildWidth;
                                                  Inc( ChildLeft, ChildWidth );
                                                  end;
                                             end;

                                           end;

                                         mdiHorizontalTile:
                                           begin

                                           ChildHeight := MDIClientHeight div ( FormList.Count + 1 );

                                           MainChildForm.Left := 0;
                                           MainChildForm.Top := 0;
                                           MainChildForm.Width := MDIClientWidth;
                                           MainChildForm.Height:= ChildHeight;

                                           ChildTop := ChildHeight;

                                           For I := 0 to FormList.Count - 1 do
                                             begin
                                             ChildForm := FormList.Items[ I ];
                                             If   Assigned( ChildForm )
                                             then begin
                                                  ChildForm.Left := 0;
                                                  ChildForm.Top := ChildTop;
                                                  ChildForm.Width := MDIClientWidth;
                                                  If   I=FormList.Count - 1
                                                  then ChildForm.Height := MDIClientHeight - ChildForm.Top
                                                  else ChildForm.Height := ChildHeight;
                                                  Inc( ChildTop, ChildHeight );
                                                  end;
                                             end;

                                           end;

                                         mdiVerticalTile:
                                           begin

                                           ChildWidth := MDIClientWidth div ( FormList.Count + 1 );

                                           MainChildForm.Left := 0;
                                           MainChildForm.Top := 0;
                                           MainChildForm.Width := ChildWidth;
                                           MainChildForm.Height:= MDIClientHeight;

                                           ChildLeft := ChildWidth;

                                           For I := 0 to FormList.Count - 1 do
                                             begin
                                             ChildForm := FormList.Items[ I ];
                                             If   Assigned( ChildForm )
                                             then begin
                                                  ChildForm.Left := ChildLeft;
                                                  ChildForm.Top := 0;
                                                  ChildForm.Height := MDIClientHeight;
                                                  If   I=FormList.Count - 1
                                                  then ChildForm.Width := MDIClientWidth - ChildForm.Left
                                                  else ChildForm.Width := ChildWidth;
                                                  Inc( ChildLeft, ChildWidth );
                                                  end;
                                             end;

                                           end;
                                         end
                                  else If   Assigned( MainChildForm ) and not ( csDestroying in MainChildForm.ComponentState )
                                       then If   MainChildForm.BackgroundForm and ( ApplicationContainer.CurrentMDILayout<>mdiNone )  // Básicamente maximizar/centrar la única ventana, si existe, o no hacer nada
                                            then MainChildForm.MaximizeForm
                                            else CenterForm( MainChildForm )
                                  end
                             else If   not ClosingForm and
                                       Assigned( CurrentForm ) and
                                       not ( csDestroying in CurrentForm.ComponentState )
                                  then begin

                                       // Cuando se abre la primera ventana de fondo también es conveniente guardala como última ventana activa

                                       If   CurrentForm.BackgroundForm
                                       then GLastMainChildForm := CurrentForm;

                                       CenterForm( CurrentForm );
                                       end;

                           finally
                             FormList.Free;
                             end;

                      end;
                 end;


               finally
                 GUpdatingMDILayout := False;
                 end;

               end;
end;

procedure ToggleSpeedButton( ASpeedButton : TSpeedButton );
begin
     If   Assigned( ASpeedButton )
     then With ASpeedButton do
            begin
            Down := not Down;
            Click;
            end;
end;

function AddBarButtonItem( MenuItem    : TdxBarSubItem;
                           ACaption    : String;
                           BeginAGroup : Boolean = False;
                           Position    : SmallInt = -1 ) : TdxBarButton;

var  Link : TdxBarItemLink;

begin
     Result := MenuItem.BarManager.AddButton;
     If   Assigned( Result )
     then With Result do
            begin
            Caption := ACaption;
            If   Position=-1
            then Link := MenuItem.ItemLinks.Add
            else Link := MenuItem.ItemLinks.Insert( Position );
            Link.Item := Result;
            Link.BeginGroup := BeginAGroup;
            end;
end;

procedure AddPanelButton( AButtonPanel : TcxGroupBox;
                          AButton      : TcxButton;
                          ALeftMargin  : SmallInt = 2 );
begin
     AButton.Parent := AButtonPanel;
     AButton.Align := alLeft;
     AButton.AlignWithMargins := True;
     AButton.Margins.SetBounds( ALeftMargin, 0, 0, 0 );
     AButton.Left := AButtonPanel.Width;  // Al final
     AButtonPanel.Width := AButtonPanel.Width + AButton.Width + ALeftMargin;
     AButtonPanel.Left := ScaledToCurrent( ( AButtonPanel.Parent.Width - AButtonPanel.Width ) div 2 );
end;

function GetItemLinkByBarItem( Bar     : TdxBar;
                               BarItem : TdxBarItem ) : TdxBarItemLink;

var I : SmallInt;

begin
     Result := nil;
     With Bar do
       For I := 0 to ItemLinks.Count - 1 do
         If   ItemLinks[ I ].Item=BarItem
         then begin
              Result := ItemLinks[ I ];
              Break;
              end
end;

procedure SetBarItemsVisible( const BarItems : array of TdxBarItem;
                                    Value    : Boolean );
var  I : SmallInt;

begin

     For I := 0 to High( BarItems ) do
       SetBarItemVisible( BarItems[ I ], Value );
end;

procedure ShowButtonMenu( APopupMenu    : TdxBarPopupMenu;
                          AButton       : TdxBarLargeButton );

var   P : TPoint;
      ItemLink : TdxBarItemLink;

begin
     With ApplicationContainer do
       begin

       If   IsMenuBarActive and AButton.Enabled
       then begin
            ItemLink := GetItemLinkByBarItem( MainTopBar, AButton );
            If   Assigned( ItemLink )
            then begin
                 P.X := ItemLink.Control.ViewInfo.Bounds.Left;
                 P.Y := GetDesktopTop;
                 P := Application.MainForm.ClientToScreen( P );
                 APopupMenu.Popup( P.X, P.Y );
                 end;
            end;
       end;
end;

{
function FindMenuTag( mainMenu : TMainMenu; MenuTag : LongInt ) : TMenuItem;

var  I  : SmallInt;

function Find( Item : TMenuItem ) : TMenuItem;

var  I : SmallInt;

begin
     Result := nil;
     If   MenuTag=Item.Tag
     then Result := Item
     else For I := 0 to Item.Count - 1 do
            begin
            Result := Find( Item[ I ] );
            If   Result<>nil
            then Exit;
            end;
end;


begin
     Result := nil;
     If   Assigned( mainMenu ) and
          ( MenuTag<>0 )
     then With mainMenu do
            For I := 0 to Items.Count - 1 do
              begin
              Result := Find( Items[ I ] );
              If   Result<>nil
              then Exit;
              end;
end;

procedure DrawHeaderMenuItem( MenuItem : TMenuItem;
                              ACanvas  : TCanvas;
                              ARect    : TRect );

var  MenuCaption : String;

begin
     With ACanvas do
       begin
       Font.Color := clNavy;
       Brush.Color := clMenu;
       MenuCaption := StrRemoveChars( MenuItem.Caption, [ cHotkeyPrefix ] );
       TextOut( ARect.Left + 6, ARect.Top, MenuCaption );
       end;
end;

}

function  FindComponentByClass( AOwner     : TComponent;
                                AClassType : TClass ) : TComponent;

var  Component : TComponent;

begin
     Result := nil;
     For Component in AOwner do
       If   Component.ClassType=AClassType
       then begin
            Result := Component;
            Break;
            end;
end;

procedure ApplyToComponentClass( AOwner     : TComponent;
                                 AClassType : TClass;
                                 Apply      : TComponentProcedure );

var  Component : TComponent;

begin
     For Component in AOwner do
       If   Component.ClassType=AClassType
       then Apply( Component );
end;

function  FindComponentByClass( AOwner     : TComponent;
                                AClassName : String ) : TComponent;

var  Component : TComponent;

begin
     Result := nil;
     For Component in AOwner do
       If   SameText( Component.ClassName, AClassName )
       then begin
            Result := Component;
            Break;
            end;
end;

function FindParentByClassName( Control : TWinControl; ParentClassName : String ) : TControl;
begin
     Result := nil;
     While Assigned( Control.Parent ) and ( Control.Parent is TControl ) do
       begin
       Control := Control.Parent;
       If   SameText( Control.ClassName, ParentClassName )
       then begin
            Result := Control;
            Break;
            end;
       end;
end;

function FindOwnerByClass( Control : TWinControl; OwnerClass : TClass ) : TControl;
begin
     Result := nil;
     While Assigned( Control.Owner ) and ( Control.Owner is TWinControl ) do
       begin
       Control := TWinControl( Control.Owner );
       If   Control is OwnerClass
       then begin
            Result := Control;
            Break;
            end;
       end;
end;

function GetParentTabSheet( Control: TControl ) : TcxTabSheet;
begin
     While ( not( Control is TcxTabSheet ) and not ( Control is TCustomForm ) ) and ( Control.Parent<>nil ) do
       Control := Control.Parent;
     If   Control is TcxTabSheet
     then Result := TcxTabSheet( Control )
     else Result := nil;
end;

function GetParentHint( Control: TControl ) : String;
begin
     Result := '';
     While ( not ( Control is TCustomForm ) ) and Assigned( Control.Parent ) do
       begin
       Control := Control.Parent;
       If   Control.Hint<>''
       then begin
            Result := Control.Hint;
            Break;
            end;
       end;
end;

function GetActiveGridTableViewData : TcxCustomGridTableViewData;

var   ActiveForm : TForm;
      GridSite : TcxGridSite;

begin
     Result := nil;
     ActiveForm := Application.MainForm.ActiveMDIChild;
     If   Assigned( ActiveForm )
     then If   ActiveForm.ActiveControl is TcxGridSite
          then begin
               GridSite := TcxGridSite( ActiveForm.ActiveControl );
               Result := TcxCustomGridTableViewData( GridSite.GridView.ViewData );
               end;
end;

procedure GetDatasetValues( Dataset   : TDataset;
                            ValueList : TStringList );

var   I : SmallInt;

begin
     If   Assigned( Dataset ) and Assigned( ValueList )
     then For I := 0 to Dataset.FieldCount - 1 do
              AddValueList( Dataset.Fields[ I ], ValueList );
end;

procedure AddValueList( Field     : TField;
                        ValueList : TStringList );
begin
     If   Assigned( Field )
     then ValueList.Add( Field.FieldName + '=' + Field.AsString );
end;

procedure SetDatasetValues( Dataset    : TDataset;
                            ValueList  : TStringList;
                            TargetForm : TForm );

var   I : SmallInt;
      Field : Tfield;
      EditControl : TcxCustomEdit;

begin

     //* 21.12.2008 Modificado para que se recuperen todos los campos del dataset, y no solo los que tienen un control asociado.

     If   Assigned( Dataset ) and Assigned( ValueList ) and Assigned( TargetForm )
     then For I := 0 to ValueList.Count - 1 do
            begin
            Field := Dataset.FindField( ValueList.Names[ I ] );
            If   Assigned( Field )
            then begin
                 Field.AsString := ValueList.ValueFromIndex[ I ];
                 EditControl := GetEditControlByFieldName( TargetForm, ValueList.Names[ I ] );
                 If   Assigned( EditControl )
                 then begin
                      ValidateEditControl( EditControl, True );
                      AddBlueMark( EditControl );
                      end;
                 end;
            end;

end;

procedure AddBlueMark( EditControl : TcxCustomEdit );

var  BlueMarkBox : TgxBlueMarkBox;

begin
     BlueMarkBox := TgxBlueMarkBox.Create( EditControl.Owner );
     With BlueMarkBox do
       begin
       Parent := EditControl.Parent;
       Left := EditControl.Left + EditControl.Width + 3;
       Top := EditControl.Top + 3;
       Width := 3;
       Height := 5;
       Hint := HintMsg42;
       ShowHint := True;
       end;
end;

procedure PinupAdjustableControl( AControl : TWinControl;
                                  AHeight  : SmallInt );
begin
     If   ApplicationContainer.TDI and ( Application.MainForm.Height<600 )
     then With AControl do
            begin
            Align := alTop;
            Height := AHeight;
            If   AControl.Owner is TForm
            then CenterForm( TgxForm( AControl.Owner ) );
            end;
end;

procedure ShowInputError( Sender   : TcxCustomEdit;
                          StError,
                          StDesc   : String );
begin
     ShowHintMsg( StError, StDesc, Sender );
     If   Assigned( Sender )
     then Sender.SetFocus;
     Abort;
end;

function RecordExists(       Table : TnxeTable;
                       const Key   : array of const ) : Boolean;

var DescFieldNames : TStringArray;
    DescFieldValues : LibUtils.TVariantArray;

begin
     DescFieldNames := [];
     Result := NexusRpc.CheckKey( Table.GetRemoteCursorID, VarRecToVariantArray( Key ), DescFieldNames, DescFieldValues );
end;

// Mantengo la versión anterior de validación hasta que estén todas las llamadas actualizadas

function  ValidateRelation(       EditControl    : TcxCustomEdit;
                                  Table          : TnxeTable;
                            const Key            : array of const;
                            var   DisplayValue   : Variant;
                            var   ErrorText      : TCaption;
                            var   Error          : Boolean;
                                  DatasetFields  : TnxeDatasetFields = nil;
                                  DescFieldName  : String  = '';
                                  IsInfoControl  : Boolean = False ) : Boolean;
begin
     Result := False;
     If   Assigned( EditControl )
     then EditControl.Description := '';

     If   ValueIsEmpty( DisplayValue )
     then Table.ResetFound
     else With Table do
            If   FindKey( Key )
            then begin
                 If   Assigned( EditControl ) and ( DescFieldName<>'' )
                 then EditControl.Description := VarToStrDef( Table.FieldValues[ DescFieldName ], '<Nulo>' );
                 Result := True;
                 end
            else If   not IsInfoControl
                 then begin
                      Error := True;
                      ErrorText := JoinMessage( RsMsg4, RsMsg5 );
                      end;

     If   Assigned( DatasetFields )
     then DatasetFields.Update( Table );
end;

function  ValidateRelationEx(       EditControl     : TcxCustomEdit;
                                    Table           : TnxeTable;
                              const Key             : array of const;
                              var   DisplayValue    : Variant;
                              var   ErrorText       : TCaption;
                              var   Error           : Boolean;

                                    DatasetFields   : TnxeDatasetFields = nil;
                                    DescFieldName   : String  = '';
                                    IsInfoControl   : Boolean = False ) : String;

var  RecordFound : Boolean;
     DescFieldValues : LibUtils.TVariantArray;

begin

     RecordFound := False;

     Result := '';
     If   Assigned( EditControl )
     then EditControl.Description := '';

     If   ValueIsEmpty( DisplayValue )
     then Table.ResetFound
     else begin

          { El sistema dual de consulta permite optimizar el tráfico en la red al descargarse el registro completo
            solo cuando es necesario. La función remota CheckKey tan solo devuelve un string con el contenido
            del campo de descripción.
          }

          If   Assigned( DatasetFields ) or not IsInfoControl
          then begin
               RecordFound := Table.FindKey( Key );
               If   RecordFound and ( DescFieldName<>'' )
               then Result := VarToStrDef( Table.FieldValues[ DescFieldName ], '<Nulo>' );
               end
          else try
                 RecordFound := NexusRpc.CheckKey( Table.GetRemoteCursorID,
                                                   VarRecToVariantArray( Key ),
                                                   LibUtils.TStringArray.Create( DescFieldName ),
                                                   DescFieldValues );
                 If   RecordFound
                 then Result := DescFieldValues[ 0 ];
               finally
                 end;

          If   RecordFound
          then begin
               If   Assigned( EditControl )
               then EditControl.Description := Result;
               end
          else If  not IsInfoControl
               then begin
                    Error := True;
                    ErrorText := JoinMessage( RsMsg4, RsMsg5 );
                    end;

          end;

    If   Assigned( DatasetFields )
    then DatasetFields.Update( Table );

end;

function GetRelationDescription(       Table              : TnxeTable;
                                 const Key                : array of const;
                                 out   Description        : String;
                                 const NotifyNonExistence : Boolean = False;
                                 const DescFieldName      : String = RsNombre ) : Boolean;

var  DescFieldValues : LibUtils.TVariantArray;

begin
     Description := '';
     var VariantKey := VarRecToVariantArray( Key );
     If   ( Length( VariantKey )>0 ) and not VarIsNull( VariantKey[ 0 ] )
     then begin
          Result := NexusRpc.CheckKey( Table.GetRemoteCursorID, VariantKey, TStringArray.Create( DescFieldName ), DescFieldValues );
          If   Result
          then Description := DescFieldValues[ 0 ];
          end
     else begin
          Result := False;
          If   NotifyNonExistence
          then Description := RsRegistroInexistente;
          end;
end;

procedure ValidateMonth(     Control      : TcxCustomEdit;
                         var DisplayValue : Variant;
                         var ErrorText    : TCaption;
                         var Error        : Boolean );
var Periodo : SmallInt;

begin
     Periodo := VarToSmallInt( DisplayValue );
     If   ( Periodo>=0 ) and
          ( Periodo<=14 )
     then Control.Description := StrMonth( Periodo, False )
     else begin
          Error := True;
          ErrorText := JoinMessage( RsgMsg313, RsgMsg314 );
          end;
end;

function ValidateYear(      DisplayValue    : Variant;
                        var ErrorText       : TCaption;
                        var Error           : Boolean;
                            IncludeLastYear : Boolean = False;
                            IncludeNextYear : Boolean = False ) : Boolean;

var Msg : String;

begin
     Result := True;
     If   not ValueIsEmpty( DisplayValue, varSmallInt )
     then If   ( not IsValidYear( VarToDateTime( DisplayValue ), ApplicationContainer.Ejercicio ) ) and
               not ( IncludeLastYear and IsValidYear( VarToDateTime( DisplayValue ), ApplicationContainer.Ejercicio - 1 ) ) and
               not ( IncludeNextYear and IsValidYear( VarToDateTime( DisplayValue ), ApplicationContainer.Ejercicio + 1 ) )
          then begin
               Msg := '';
               If   IncludeLastYear
               then If   IncludeNextYear
                    then Msg := RsMsg32
                    else Msg := RsMsg40;
               If   IncludeNextYear
               then StrAdd( Msg, RsMsg50 );
               Error := True;
               ErrorText := JoinMessage( Format( RsMsg39, [ Msg ] ), RsMsg41 );
               Result := False;   // Devolver el valor es útil para incluir la función en un if
               end;
end;

procedure ValidateDateRange(     DateRange     : TDateRange;
                                 ReferenceDate : TDate;
                             var DisplayValue  : Variant;
                             var ErrorText     : TCaption;
                             var Error         : Boolean );

const CmpText : Array[ drLower..drGreaterOrEqual ] of String = ( 'menor', 'menor o igual', 'mayor', 'mayor o igual' );
var   Date : TDate;

begin
     try
       Date := VarToDateTime( DisplayValue );
       case DateRange of
         drLower          : Error := not ( Date<ReferenceDate );
         drLowerOrEqual   : Error := not ( Date<=ReferenceDate );
         drGreater        : Error := not ( Date>ReferenceDate );
         drGreaterOrEqual : Error := not ( Date>=ReferenceDate );
         end;
       If   Error
       then ErrorText := Format( RsMsg74, [ CmpText[ DateRange ], StrFormatDate( ReferenceDate ) ] );
     except
       Error := True;
       end;
end;

procedure BlockDateOutRange(     Sender         : TcxCustomEdit;
                                 DisplayValue   : TcxEditValue;
                                 FirstDateCtrl,
                                 LastDateCtrl   : TcxCustomEdit;
                             var ErrorText      : TCaption;
                                 MaxDays        : SmallInt = MaxDaysRange );

var  FirstDate,
     LastDate : TDate;
     Days : Integer;

begin

     // La comprobación de la tecla Esc es para los QueryForms, porque debido al KeyPreview del Form y
     // al botón por defecto de cancelación, antes de aplicarla se pierde el focus. Por ese mismo motivo
     // no vale comprobar Sender.KeyPressed, porque aún no se ha asignado.

     If   not IsKeyPressed( VK_ESCAPE ) and
          Sender.Editing and
          Sender.ModifiedAfterEnter
     then begin

          If   Sender=FirstDateCtrl
          then FirstDate := VarToDate( DisplayValue )
          else FirstDate := FirstDateCtrl.EditValue;

          If   Sender=LastDateCtrl
          then LastDate := VarToDate( DisplayValue )
          else LastDate := LastDateCtrl.EditValue;

          If   ( FirstDate<>0 ) and
               ( LastDate<>0 )
          then begin
               Days :=  DaysBetween( FirstDate, LastDate );
               If   Days>MaxDays
               then If   ShowNotification( ntQuestionWarning, RsMsg75, Format( RsMsg76, [ Days, StrFormatDate( FirstDate ), StrFormatDate( LastDate ) ] ) )<>MrYes
                    then begin
                         ErrorText := '';
                         Sender.Reset;
                         Sender.SetFocus;
                         Abort;
                         end;
               end;

          end;
end;

procedure BlockValueOutRange(    Sender         : TcxCustomEdit;
                                 DisplayValue   : TcxEditValue;
                                 FirstValueCtrl,
                                 LastValueCtrl  : TcxCustomEdit;
                             var ErrorText      : TCaption;
                                 MaxRange       : SmallInt = 1000 );  // 1000 registros

var  FirstValue,
     LastValue : LongInt;
     Range : LongInt;

begin
     If   not IsKeyPressed( VK_ESCAPE ) and
          Sender.Editing and
          Sender.ModifiedAfterEnter
     then begin

          If   Sender=FirstValueCtrl
          then FirstValue := VarToInteger( DisplayValue )
          else FirstValue := FirstValueCtrl.EditValue;

          If   Sender=LastValueCtrl
          then LastValue := VarToInteger( DisplayValue )
          else LastValue := LastValueCtrl.EditValue;

         Range := Abs( LastValue - FirstValue );
         If   Range>MaxRange
         then If   ShowNotification( ntQuestionWarning, RsMsg77, Format( RsMsg78, [ Range ] ) )<>MrYes
              then begin
                   ErrorText := '';
                   Sender.Reset;
                   Sender.SetFocus;
                   Abort;
                   end;

          end;

end;

procedure CheckDateRange( FirstDate,
                          LastDate   : TDate;
                          MaxDays    : SmallInt = MaxDaysRange );

var  Days : Integer;

begin
     try
       If   ( FirstDate<>0 ) and
            ( LastDate<>0 )
       then begin
            Days :=  DaysBetween( FirstDate, LastDate );
            If   Days>MaxDays
            then ShowHintMsg( RsMsg75, Format( RsMsg76, [ Days ] ), nil, ntWarning );
            end;
     except
       end;
end;

procedure CheckDateRange(     FirstDate,
                              LastDate   : TDate;
                          var ErrorText  : TCaption;
                          var Error      : Boolean;
                              MaxDays    : SmallInt = MaxDaysRange );

var  Days : Integer;

begin
     try
       If   ( FirstDate<>0 ) and
            ( LastDate<>0 )
       then begin
            Days :=  DaysBetween( FirstDate, LastDate );
            If   Days>MaxDays
            then begin
                 Error := True;
                 ErrorText := JoinMessage( RsMsg75, Format( RsMsg76, [ Days ] ) );
                 end;
            end;
     except
       end;
end;

{
procedure SetInfoColors( ACanvas : TCanvas );
begin
     With ACanvas do
       begin
       Brush.Color := clInfoBk;
       Font.Color  := clInfoText;
       end;
end;

procedure SetButtonFaceColors( ACanvas : TCanvas );
begin
     With ACanvas do
       begin
       Brush.Color := clBtnFace;
       Font.Color  := clInfoText;
       end;
end;
}

// La idea es que hasta 2 decimales el formato sea rígido. A partir de ahí tanto la edición como la visualización son flexibles

function GetDecimalPad( Decimals : SmallInt ) : String;

var  Index : SmallInt;

begin
     Result := StringOfChar( '#', Decimals );
     For Index := 1 to 2 do
       If   Index<=Decimals
       then Result[ Index ] := '0';
end;

function FloatDisplayFormat( Decimals   : Integer = DecimalesMoneda;
                             ShowIfZero : Boolean = False ) : String;

begin
     Result := ',0.' + GetDecimalPad( Decimals );
     Result := Result + ';-' + Result;
     If   not ShowIfZero
     then Result := Result + ';#';
end;

function FloatEditFormat( Decimals         : Integer = DecimalesMoneda;
                          ShowIfZero       : Boolean = False ) : String;
begin
     Result := '0.' + GetDecimalPad( Decimals );
     Result := Result + ';-' + Result;
     If   not ShowIfZero
     then Result := Result + ';#';
end;

procedure SetColumnsDecimals( const Columns          : array of TcxGridColumn;
                                    Decimals         : SmallInt = DecimalesMoneda;
                                    ShowIfZero       : Boolean = False );

var  I : SmallInt;

begin
     For I := 0 to High( Columns ) do
       SetColumnDecimals( Columns[ I ], Decimals, ShowIfZero );
end;

procedure SetColumnDecimals( Column           : TcxGridColumn;
                             Decimals         : SmallInt = DecimalesMoneda;
                             ShowIfZero       : Boolean = False );

begin
     If   not Assigned( Column.Properties )
     then Column.PropertiesClass := TcxCurrencyEditProperties;
     If   Column.Properties is TcxCurrencyEditProperties
     then With TcxCurrencyEditProperties( Column.Properties ) do
            begin
            If   MaxLength=0
            then MaxLength := 10;  // Un valor por defecto
            DecimalPlaces := Decimals;
            DisplayFormat := FloatDisplayFormat( Decimals, ShowIfZero );
            EditFormat := FloatEditFormat( Decimals, ShowIfZero );
            Nullable := False;
            end;
end;

procedure SetFooterSummaryItemsDecimals(       TableView  : TcxGridDBTableView;
                                         const ItemsIndex : array of SmallInt;
                                               Decimals   : SmallInt = DecimalesMoneda;
                                               ShowIfZero : Boolean = False );
var  I : SmallInt;

begin
     For I := 0 to High( ItemsIndex ) do
       SetFooterSummaryItemDecimals( TableView, ItemsIndex[ I ], Decimals, ShowIfZero );
end;

procedure SetFooterSummaryItemDecimals( TableView  : TcxGridDBTableView;
                                        Index      : SmallInt;
                                        Decimals   : SmallInt = DecimalesMoneda;
                                        ShowIfZero : Boolean = True );
begin
     TableView.DataController.Summary.FooterSummaryItems[ Index ].Format := FloatDisplayFormat( Decimals, ShowIfZero );
end;

procedure SetDefaultGroupSummaryItemsDecimals(       TableView  : TcxGridDBTableView;
                                               const ItemsIndex : array of SmallInt;
                                                     Decimals   : SmallInt = DecimalesMoneda;
                                                     ShowIfZero : Boolean = False );
var  I : SmallInt;

begin
     For I := 0 to High( ItemsIndex ) do
       SetDefaultGroupSummaryItemDecimals( TableView, ItemsIndex[ I ], Decimals, ShowIfZero );
end;

procedure SetDefaultGroupSummaryItemDecimals( TableView        : TcxGridDBTableView;
                                              Index            : SmallInt;
                                              Decimals         : SmallInt = DecimalesMoneda;
                                              ShowIfZero       : Boolean = True );
begin
     TableView.DataController.Summary.DefaultGroupSummaryItems[ Index ].Format := FloatDisplayFormat( Decimals, ShowIfZero );
end;

procedure SetEditControlsDecimals( EditControls     : array of TcxCustomCurrencyEdit;
                                   Decimals         : SmallInt = DecimalesMoneda;
                                   ShowIfZero       : Boolean = False );
var  I : SmallInt;

begin
     For I := 0 to High( EditControls ) do
        SetEditControlDecimals( EditControls[ I ], Decimals, ShowIfZero );
end;

procedure SetEditControlDecimals( EditControl      : TcxCustomCurrencyEdit;
                                  Decimals         : SmallInt = DecimalesMoneda;
                                  ShowIfZero       : Boolean = False );
begin
     With EditControl.Properties do
       begin
       DecimalPlaces := Decimals;
       DisplayFormat := FloatDisplayFormat( Decimals, ShowIfZero );
       EditFormat := FloatEditFormat( Decimals, ShowIfZero );
       Nullable := False;
       end;
end;

{
procedure SetDefaultFont( Control  : TcxCustomEdit;
                          DiffSize : SmallInt = 0 );
begin
     With Control.Style.Font do
       begin
       Name := Fuente;
       Size := TamañoFuente + DiffSize;
       end;
end;
}

procedure SetClickableCaption( AGroupBox : TcxGroupBox; Value : String );
begin
     Value := Trim( Value );
     With AGroupBox do
       begin
       Caption := Value;
       Enabled := Value<>'';
       If   Value=''
       then Cursor := crDefault
       else Cursor := crHandPoint;
       end;
end;

procedure SetClickableCaption( ALabel: TcxLabel; Value : String );
begin
     Value := Trim( Value );
     With ALabel do
       begin
       Caption := Value;
       Enabled := Value<>'';
       If   Value=''
       then Cursor := crDefault
       else Cursor := crHandPoint;
       end;
end;

procedure SetBCDFieldsDecimals( Fields           : array of TBCDField;
                                Decimals         : SmallInt = DecimalesMoneda;
                                ShowIfZero       : Boolean = False );
var  I : SmallInt;

begin
     For I := 0 to High( Fields ) do
        SetBCDFieldDecimals( Fields[ I ], Decimals, ShowIfZero );
end;

procedure SetBCDFieldDecimals( Field            : TBCDField;
                               Decimals         : SmallInt = DecimalesMoneda;
                               ShowIfZero       : Boolean = False );
begin
     With Field do
       begin
       DisplayFormat := FloatDisplayFormat( Decimals, ShowIfZero );
       EditFormat := FloatEditFormat( Decimals, ShowIfZero );
       end;
end;

procedure SetFieldValueIfEmpty( Field : TField; SourceValue : Variant );
begin
     If   ValueIsEmpty( Field.Value )
     then Field.Value := SourceValue;
end;

procedure SetEditValueIfEmpty( EditControl : TcxCustomEdit;
                               SourceValue : Variant );
begin
     With EditControl do
        If   ValueIsEmpty( EditValue )
        then EditValue := SourceValue;
end;

procedure SetRecordFieldValuesIfEmpty( Fields      : array of TField;
                                       SourceValue : Variant );

var  I : SmallInt;

begin
     For I := 0 to High( Fields ) do
        SetFieldValueIfEmpty( Fields[ I ], SourceValue );
end;

// El valor máximo es tan solo el más utilizado en la aplicación

procedure SetFieldRange( Field      : TIntegerField;
                         AMinValue  : Integer = 1;
                         AMaxValue  : Integer = 99999999 );
begin
     With Field do
       begin
       MinValue := AMinValue;
       MaxValue := AMaxValue;
       EditFormat := '#';
       DisplayFormat := '#';
       end;
end;

procedure SetFieldRange( Field      : TSmallIntField;
                         AMinValue  : Integer = 1;
                         AMaxValue  : Integer = High( SmallInt ) );
begin
     With Field do
       begin
       MinValue := AMinValue;
       MaxValue := AMaxValue;
       EditFormat := '#';
       DisplayFormat := '#';
       end;
end;

procedure SetFieldRange( Field : TField );
begin
     If   Field is TSmallIntField
     then SetFieldRange( TSmallIntField( Field ) )
     else If   Field is TIntegerField
          then SetFieldRange( TIntegerField( Field ) );
end;

procedure SetFieldsRange( Fields : array of TField );

var Field : TField;

begin
     For Field in Fields do
       SetFieldRange( Field );
end;

function GetKeyFieldValues( Table : TnxeTable ) : Variant;
begin
     var FieldList := TList.Create;
     try
       Table.GetIndexFields( FieldList );
       Result := cxDB.GetDataSetValues( Table, FieldList );
     finally
       FieldList.Free;
       end;
end;

function GetRecordId( Table : TnxeTable ) : Variant;
begin
     var IdField := Table.FindField( 'Id' );
     If   Assigned( IdField )
     then Result := IdField.Value
     else Result := -1;
end;

function GetDesktopTop : Integer;
begin
     If   Assigned( ClientShape )
     then Result := ClientShape.Top
     else Result := 0;
end;

function GetDesktopHeight : Integer;
begin
     If   Assigned( ClientShape )
     then Result := ClientShape.Height
     else Result := Application.MainForm.ClientHeight;

     If   Assigned( ApplicationContainer.TabbedMDIManager ) and
          ApplicationContainer.TDI and
          Assigned( ApplicationContainer.TabbedMDIManager.ViewInfo ) and
          ApplicationContainer.TabbedMDIManager.ViewInfo.IsTabsVisible
     then begin
          var ActivePage := TdxTabbedMDITabProperties( ApplicationContainer.TabbedMDIManager.ViewInfo.Properties ).ActivePage;
          If   Assigned( ActivePage )
          then Result := ActivePage.MDIChild.ClientHeight;
          end;
end;

function GetDesktopWidth : Integer;
begin
     If   Assigned( ClientShape )
     then Result := ClientShape.Width 
     else Result := Application.MainForm.ClientWidth;
end;

function GetEditControl( AControl          : TWinControl;
                         IncludeGroupBoxes : Boolean = False ) : TcxCustomEdit;
begin
     Result := nil;
     If   Assigned( AControl )
     then If   ( AControl is TcxCustomEdit ) and not ( AControl is TcxCustomLabel ) and not ( not IncludeGroupBoxes and ( AControl is TcxGroupBox ) )
          then Result := TcxCustomEdit( AControl )
          else If   ( AControl.Owner is TcxCustomEdit ) and not ( AControl.Owner is TcxCustomLabel ) and not ( AControl.Owner is TcxGroupBox )
               then Result := TcxCustomEdit( AControl.Owner );
end;

procedure SelectEditControl( AControl : TWinControl );

var  CustomEdit : TcxCustomEdit;

begin
     If   Assigned( AControl )
     then begin
          CustomEdit := GetEditControl( AControl, { IncludeGroupBoxes } True  );
          If   Assigned( CustomEdit )
          then With CustomEdit do
                 begin
                 If   Visible
                 then Show;    // Solo para que se muestre el control si está oculto en una pestaña u otro contenedor
                 If   Enabled
                 then begin
                      SetFocus;
                      SelectAll;
                      end
                 else SelectNextFormControl( CustomEdit );
                 end;

          end;
end;

function GetFirstEnabledButtonValue( RadioGroup : TcxDBRadioGroup ) : SmallInt;

var  I : SmallInt;

begin
     Result := -1;
     With RadioGroup do
       For I := 0 to ControlCount - 1 do
          If   Buttons[ I ].Enabled
          then begin
               Result := Properties.Items[ I ].Value;
               Break;
               end;
end;

function GetBarPopupMenuHeight( BarPopupMenu : TdxBarPopupMenu ) : SmallInt;
begin
     Result := 0;
     With BarPopupMenu do
       try
         ItemLinks.CreateBarControl;
         Result := ItemLinks.BarControl.ClientHeight;
       finally
         ItemLinks.DestroyBarControl;
         end;
end;

function GetBarPopupMenuWidth( BarPopupMenu : TdxBarPopupMenu ) : SmallInt;
begin
     Result := 0;
     With BarPopupMenu do
       try
         ItemLinks.CreateBarControl;
         Result := ItemLinks.BarControl.ClientWidth;
       finally
         ItemLinks.DestroyBarControl;
         end;
end;

procedure SetFirstEnabledButtonValue( RadioGroup     : TcxDBRadioGroup;
                                      CheckIfEnabled : Boolean = True );

var  I : SmallInt;

begin
     If   RadioGroup.ItemIndex>=0
     then If   not CheckIfEnabled or not RadioGroup.Properties.Items[ RadioGroup.ItemIndex ].Enabled
          then For I := 0 to RadioGroup.Properties.Items.Count - 1 do
                 If   RadioGroup.Properties.Items[ I ].Enabled
                 then begin
                      RadioGroup.ItemIndex := I;
                      RadioGroup.PostEditValue( RadioGroup.Properties.Items[ I ].Value );
                      Break;
                      end;
end;

procedure SetPanelValue( Panel     : TcxGroupBox;
                         Value     : Variant;
                         Decimales : SmallInt = DecimalesMoneda );
begin
     If   VarIsNull( Value )
     then Panel.Caption := ''
     else Panel.Caption := StrFormat( VarToDecimal( Value ), Decimales );
end;

// Estos controles comparten el contenedor con otros controles. Es diferente a SetupPanelableCtrl, donde cada componente tiene su propio panel contenedor.

procedure SetupControlsPanel( Control          : TWinControl;
                              Enabled          : Boolean;
                              AdjustFormHeight : Boolean = False );
begin
     Control.Enabled := Enabled;
     Control.Visible := Enabled;
     var ControlContainer := Control.Parent;

     If   not Enabled
     then begin
          ControlContainer.Height := ControlContainer.Height - Control.Height;
          If   AdjustFormHeight
          then If   ControlContainer.Owner is TForm
               then With TForm( ControlContainer.Owner ) do
                      Height := Height - Control.Height;
          end;
end;

// PanelableCtrls

procedure SetupPanelableCtrl(     Control          : TcxCustomEdit;
                                  ControlEnabled   : Boolean;
                              var ControlCount     : SmallInt;
                                  AdjustFormHeight : Boolean = False );
begin
    SetupPanelableCtrl( Control, ControlEnabled, AdjustFormHeight );
    If   ControlEnabled
    then Inc( ControlCount );
end;

procedure SetupPanelableCtrl( Control          : TcxCustomEdit;
                              ControlEnabled   : Boolean;
                              AdjustFormHeight : Boolean = False;
                              ParentContainer  : TcxCustomEditContainer = nil );

var VisibilityChanged : Boolean;
    ControlContainer : TWinControl;

begin

     // Los controles panelables los sitúo sobre dos tipos de contenedores : TcxGroupBox o TgxScrollBoxPanel. En el segundo
     // caso se sitúan dentro de un TScrollBox, que debe ser realineado para actualizar el VerticalScrollBox.

     ControlContainer := Control.Parent;

     VisibilityChanged := False;

     If   not ( ControlContainer is TForm ) and
          not ( ControlContainer is TFrame )
     then begin
          VisibilityChanged := ControlContainer.Visible<>ControlEnabled;
          ControlContainer.Visible := ControlEnabled;
          end;

     If   VisibilityChanged
     then begin

          If   ControlContainer is TgxScrollBoxPanel
          then begin
               var ScrollBox := TgxScrollBoxPanel( ControlContainer ).FScrollBox;
               ScrollBox.VertScrollBar.Range := ScrollBox.VertScrollBar.Range + IntSign( ControlContainer.Height, ControlEnabled );
               ScrollBox.Realign;
               end
          else If   ControlContainer is TcxGroupBox
               then begin
                    If   ParentContainer=nil
                    then If   Assigned( ControlContainer.Parent ) and ( ControlContainer.Parent is TcxGroupBox )
                         then ParentContainer := TcxGroupBox( ControlContainer.Parent );
                    If   Assigned( ParentContainer )
                    then If   ParentContainer.Align<>alClient
                         then ParentContainer.Height := ParentContainer.Height + IntSign( ControlContainer.Height, ControlEnabled );
                    end;

          If   AdjustFormHeight
          then If   ControlContainer.Owner is TForm
               then With TForm( ControlContainer.Owner ) do
                      Height := Height + IntSign( ControlContainer.Height, { Positive } ControlEnabled );

          end;

     Control.Enabled := ControlEnabled;

end;

procedure SetupPanelableCtrls( Controls         : TcxCustomEditArray;
                               Enabled          : Boolean;
                               AdjustFormHeight : Boolean = False );
begin
     For var Control in Controls do
       SetupPanelableCtrl( Control, Enabled, AdjustFormHeight );
end;

procedure SetupPanelableCtrls( Controls         : TcxCustomEditArray;
                               OnSetEnabled     : TCheckIndexFunction;
                               AdjustFormHeight : Boolean = False );

var  Index : SmallInt;

begin
     Index := 0;
     For var Control in Controls do
       begin
       SetupPanelableCtrl( Control, OnSetEnabled( Index, Control ), AdjustFormHeight );
       Inc( Index );
       end;
end;

// Devuelve : 0  = La pestaña no ha sido marcada
//            1  = La pestaña está marcada
//            2  = la pestaña está marcada y al mismo tiempo seleccionada (fija no solo la selección sino el orden y agrupación)

function ObtenSeleccionFilterPageControl( FiltroPageControl : TgxFilterPageControl;
                                          TabSheet          : TcxTabSheet ) : SmallInt;
begin
     Result := 0;
     With TabSheet do
       If   Highlighted
       then begin
            Inc( Result );
            If   FiltroPageControl.ActivePage=TabSheet
            then Inc( Result );
            end;
end;

procedure SetActiveChartDiagram( GridDBChartView : TcxGridDBChartView; DiagramIndex : SmallInt );
begin
     With GridDBChartView do
       case DiagramIndex of
         0 : DiagramLine.Active := True;
         1 : DiagramColumn.Active := True;
         2 : DiagramStackedColumn.Active := True;
         3 : DiagramStackedBar.Active := True;
         4 : DiagramArea.Active := True;
         5 : DiagramStackedArea.Active := True;
         6 : DiagramPie.Active := True;
         end;
end;

procedure ShowGroupBox( Control : TcxGroupBox;
                        Show    : Boolean );

var  ContainerControl : TWinControl;

begin

     Control.Visible:= Show;

     SetGroupBoxControlsEnabled( Control, Show );  // Si no se desactivan se intentará validarlos

     ContainerControl := Control.Parent;
     If   ContainerControl is TgxScrollBoxPanel
     then TgxScrollBoxPanel( ContainerControl ).FScrollBox.Realign
     else If   ( ContainerControl is TcxGroupBox ) and  // Un panel dentro de otro
               not Control.Visible
          then If   ( Control.Align=alTop ) or ( Control.Align=alBottom)
               then ContainerControl.Height := ContainerControl.Height - Control.Height;

end;

function GetScrollBoxPanelCount( ScrollBox : TcxScrollBox ) : SmallInt;

var I : SmallInt;

begin
     Result := 0;
     For I := 0 to ScrollBox.ControlCount - 1 do
       If   ( ScrollBox.Controls[ I ] is TgxScrollBoxPanel ) and
            ScrollBox.Controls[ I ].Visible
       then Inc( Result );
end;

procedure SetGroupBoxControlsEnabled( Container : TcxCustomEdit;
                                      Value     : Boolean;
                                      Force     : Boolean = False );
begin
     SetGroupBoxControlsEnabled( Container, Value, [], Force );
end;

procedure SetGroupBoxControlsEnabled( Container  : TcxCustomEdit;
                                      Value      : Boolean;
                                      Exceptions : Array of TWinControl;
                                      Force      : Boolean = False );

var  I : SmallInt;
     ChildControl : TControl;

function IsAnException( Control : TWinControl ) : Boolean;
begin
     Result := False;
     For var Exception in Exceptions do
       If   Exception=Control
       then Exit( True );
end;

begin
     With Container do
       If   Force or ( Enabled<>Value )
       then begin
            Enabled := Value;
            For I := 0 to ControlCount - 1 do
              begin
              ChildControl := Controls[ I ];
              If   ChildControl is TWinControl
              then begin
                   var WinChildControl := TWinControl( ChildControl );

                   // Compruebo TWinControls porque hay subcomponentes que no son TcxCustomEdit como, por ejemplo, TabSheets

                   If   not IsAnException( WinChildControl )
                   then begin
                        If   WinChildControl.ControlCount>1
                        then SetGroupBoxControlsEnabled( TcxCustomEdit( ChildControl ), Value, Exceptions, Force );
                        WinChildControl.Enabled := Enabled;
                        end;

                   end;
              end;
            end;
end;

procedure SetGroupBoxEditControlsReadOnly( GroupBox : TcxGroupBox;
                                           Value    : Boolean );
begin
     For var Control in GroupBox do
       If   Control is TcxCustomEdit
       then TcxCustomEdit( Control ).ActiveProperties.ReadOnly := Value;
end;

procedure CheckTextEditMinLength(     Sender       : TcxCustomEdit;
                                      DisplayValue : Variant;
                                  var ErrorText    : TCaption;
                                  var Error        : Boolean;
                                      MinLength    : SmallInt = 0 );

var TextLength : SmallInt;

begin
     If   Sender is TcxTextEdit  // Solo los controles de texto
     then With ( Sender as TcxTextEdit ) do
            begin
            If   MinLength=0
            then MinLength := Properties.MaxLength;
            TextLength := Length( VarToStr( DisplayValue ) );

            // Los controles vacíos deben comprobarse con Required

            If   ( TextLength<>0 ) and ( TextLength<MinLength )
            then begin
                 ErrorText := RsMsg64;
                 Error := True;
                 end;
          end;
end;

procedure CheckNumericValue( var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);

var  Value : Extended;

begin
     If   ( DisplayValue<>'' ) and not TryStrToFloat( DisplayValue, Value )
     then begin
          Error := True;
          ErrorText := RsMsg79;
          end;
end;

function GetCustomEditCtrlArray( Owner : TComponent; Prefix : String; FirstIndex, LastIndex : SmallInt ) : TcxCustomEditArray;
begin
     Result := [];
     For var Inx := FirstIndex to LastIndex do
       begin
       var EditControl :=  Owner.FindComponent( Prefix + IntToStr( Inx ) + 'Ctrl' );
       If   Assigned( EditControl ) and ( EditControl is TcxCustomEdit )
       then Result := Result + [ TcxCustomEdit( EditControl ) ];
       end;
end;

function CustomEditCtrlArrayIsEmpty( CustomEditArray : TcxCustomEditArray ) : Boolean;
begin
    Result := True;
    For var CustomEdit in CustomEditArray do
      If   not ValueIsEmpty( CustomEdit.EditValue )
      then begin
           Result := False;
           Break;
           end;
end;

function GetFirstEditableItemIndex( GridView : TcxCustomGridTableView;
                                    Required : Boolean = True ) : Integer;

var  FirstItem,
     I : Integer;

begin
     Result := -1;
     If   GridView is TcxGridDBTableView
     then With TcxGridDBTableView( GridView ) do
            begin
            FirstItem := Controller.FirstAvailableItemIndex;
            If   FirstItem>=0
            then For I := FirstItem to VisibleItemCount - 1 do
                    With VisibleItems[ I ] do
                      If   Assigned( Properties )
                      then If   Options.Editing
                           then If   not Required or ( Required and Properties.Required )
                                then begin
                                     Result := I;
                                     Exit;
                                     end;
            end;
end;

function GetVisibleColumnIndex( GridView    : TcxCustomGridTableView;
                                ColumnIndex : SmallInt ) : SmallInt;
begin
     If   ColumnIndex>GridView.VisibleItemCount
     then ColumnIndex := GridView.VisibleItemCount - 1;
     Result := GridView.VisibleItems[ ColumnIndex ].Index;
end;

function FindRecordIndexByColumnValue( Column : TcxGridDBColumn;
                                       Value  : Variant ) : Integer;
var  I : Integer;

begin
     Result := -1;
     With Column.DataBinding.DataController do
       For I := 0 to RecordCount - 1 do
         If   Values[ I, Column.Index ]=Value
         then begin
              Result := I;
              Break;
              end;
end;

procedure SetColumnsEditingOption( GridView : TcxCustomGridTableView;
                                   CanEdit  : Boolean = True );

var  I : SmallInt;

begin
     With GridView, OptionsData do
       For I := 0 to GridView.ItemCount - 1 do
         If   Assigned( Items[ I ].Properties )
         then Items[ I ].Properties.ReadOnly := not CanEdit
         else Items[ I ].Options.Editing := CanEdit;
end;

{
procedure SwitchPasswordEchoMode( ButtonEditControls : TcxCustomButtonEditArray;
                                  Reset              : Boolean = False );

var  EchoMode : TcxEditEchoMode;

begin
     For var Control in ButtonEditControls do
       If   Control.Enabled
       then begin
            If   Reset
            then Control.Tag := 1;
            If   Control.Tag=0
            then EchoMode := eemNormal
            else EchoMode := eemPassword;
            Control.Properties.EchoMode := EchoMode;
            If   Reset
            then Control.Properties.Buttons[ 1 ].Enabled := False;
            Control.Tag := 1 - Control.Tag;
            end;
end;
}

{ TgApplicationForms ------------------------------------------------------------ }

constructor TApplicationForms.Create( AOwner : TComponent );


begin

     inherited Create( AOwner );

     FButtonBitmap := TBitmap.Create;   // Un Bitmap de conveniencia que utiliza GetImageFromList
     FButtonBitmap.PixelFormat := pf32bit;
     FButtonBitmap.AlphaFormat := afPremultiplied;

     If   not IsDesignTime
     then FOnShowEditControlPopup := DoOnShowEditControlPopup;

end;

destructor TApplicationForms.Destroy;


begin
     try
       ApplicationContainer.CloseAllReports;
       FButtonBitmap.Free;
     except on E : Exception do ShowException( E, nil );
       end;

     inherited Destroy;
end;

procedure TApplicationForms.DoOnShowEditControlPopup( Sender  : TcxCustomEdit;
                                               Mode    : TcxEditControlPopupMode;
                                               X       : Integer = 0;
                                               Y       : Integer = 0 );
begin
     If   Assigned( Sender ) and ( Sender is TcxCustomEdit )
     then try
            If   ( Mode=ecpMouseLeave )
            then begin
                 If   EditControlPopupMode=ecpMouseEnter
                 then With EditControlPopupMenu do
                        If   Assigned( SubMenuControl )
                        then SubMenuControl.Hide;
                 Exit;
                 end;
            EditControlPopupMenuActive := True;
            FMouseEditControl := TcxCustomEdit( Sender );
            With FMouseEditControl do
              begin
              If   CanFocus
              then SetFocus;
              If   IsFocused   // Puede perder el focus al intentar obtenerlo
              then If   Assigned( Properties )
                   then With Properties do
                          If   Assigned( OnEditRequest ) or
                               Assigned( OnQueryRequest ) or
                               Assigned( OnAnnotationRequest ) or
                               Assigned( OnExtendedFunction ) or
                               Assigned( OnDefaultValue )
                          then begin
                               SetBarItemVisible( EditarButton, Assigned( OnEditRequest ) );
                               SetBarItemVisible( ConsultaButton, Assigned( OnQueryRequest ) );
                               SetBarItemVisible( AnotacionButton, Assigned( OnAnnotationRequest ) );
                               SetBarItemVisible( FuncionExtendidaButton, Assigned( OnExtendedFunction ) );
                               SetBarItemVisible( ValorPorDefectoButton, Assigned( OnDefaultValue ) );
                               If   Mode=ecpMouseEnter
                               then EditControlPopupMenu.Popup( X, Y )
                               else EditControlPopupMenu.PopupFromCursorPos;
                               end;
              end;
          finally
            FMouseEditControl := nil;
            EditControlPopupMode := Mode;
            EditControlPopupMenuActive := False;
            end;
end;

function TApplicationForms.GetImageFromList( ImageList : TcxImageList; ImageIndex : SmallInt ) : TBitmap;
begin
     ImageList.GetImage( ImageIndex, FButtonBitmap );
     Result := FButtonBitmap;
end;

function TApplicationForms.GetImageDataFromList( ImageList : TcxImageList; ImageIndex : SmallInt ) : AnsiString;

var  AStream: TMemoryStream;

begin
     ImageList.GetImage( ImageIndex, FButtonBitmap );
     If   not Assigned( FButtonBitmap ) or FButtonBitmap.Empty
     then Result := ''
     else begin
          AStream := TMemoryStream.Create;
          try
            FButtonBitmap.SaveToStream( AStream );
            AStream.Position := 0;
            SetLength( Result, AStream.Size );
            AStream.ReadBuffer( Result[ 1 ], AStream.Size );
          finally
            AStream.Free;
            end;
          end;
end;

procedure TApplicationForms.SpeedButton( aSpeedBtn : TSpeedBtnTag );
begin
     If   Assigned( ActiveFormManager )
     then ActiveFormManager.SpeedBtnPressed( aSpeedBtn );
end;

procedure TApplicationForms.EditarButtonClick(Sender: TObject);
begin
     If   Assigned( FMouseEditControl )
     then FMouseEditControl.Properties.OnEditRequest( FMouseEditControl );
end;

procedure TApplicationForms.ConsultaButtonClick(Sender: TObject);
begin
     If   Assigned( FMouseEditControl )
     then FMouseEditControl.Properties.OnQueryRequest( FMouseEditControl );
end;

procedure TApplicationForms.AnotacionButtonClick(Sender: TObject);
begin
     If   Assigned( FMouseEditControl )
     then FMouseEditControl.Properties.OnAnnotationRequest( FMouseEditControl );
end;

procedure TApplicationForms.FuncionExtendidaButtonClick(Sender: TObject);
begin
     If   Assigned( FMouseEditControl )
     then FMouseEditControl.Properties.OnExtendedFunction( FMouseEditControl );
end;

procedure TApplicationForms.ValorPorDefectoButtonClick(Sender: TObject);
begin
     If   Assigned( FMouseEditControl )
     then FMouseEditControl.Properties.OnDefaultValue( FMouseEditControl );
end;


{ TRecordButtonLink ---------------------------------------------------- }

constructor TRecordButtonLink.Create( AOwner : TComponent );
begin
     inherited Create( AOwner );
     Name := RecordButtonLinkName;  // Solo puede haber uno por Owner
end;

procedure TRecordButtonLink.RecordBtnPressed( AnAppSpeedBtn : TSpeedBtnTag );

var   CurrentPos : TBookMark;
      Correct : Boolean;
      LastActiveControl : TWinControl;
      ADataset : TDataset;
      FilterColumn : TcxCustomGridTableItem;
      RecordIndex : Integer;
      TableViewDataController : TcxGridDBDataController;
      GridTableViewController : TGridTableViewController;

begin

     FBtnLinkProcess := True;

     try

       If   Assigned( FOnRecordButtonEvent )
       then If   FOnRecordButtonEvent( AnAppSpeedBtn )
            then Exit;

       If   Owner is TgxFormManager
       then With TgxFormManager( Owner ) do
              try

                      ApplicationContainer.RecordButtonPressed := AnAppSpeedBtn in [ sbnFirstRec..sbnLastRec ];

                      If   Assigned( FTable )
                      then With FTable do
                             begin

                             If   ( AnAppSpeedBtn=sbnRefreshRec ) and
                                  ( State<>dsbrowse )
                             then Exit;

                             LastActiveControl := OwnedForm.ActiveControl;
                             CurrentPos := nil;

                             try

                               UpdateRange;

                               CurrentPos := GetBookMark;

                               If   not Assigned( CurrentPos )
                               then case AnAppSpeedBtn of
                                      sbnPriorRec : AnAppSpeedBtn := sbnFirstRec;
                                      sbnNextRec  : AnAppSpeedBtn := sbnLastRec;
                                      end;

                               Cancel;

                               Correct := True;

                               case AnAppSpeedBtn of
                                 sbnFirstRec      : BrowseFirst;
                                 sbnPriorRec      : BrowsePrior;
                                 sbnRefreshRec    : If   Assigned( FOnRefreshCurrentRecord )
                                                    then FOnRefreshCurrentRecord
                                                    else begin
                                                         ReloadRecord;
                                                         Browse;
                                                         end;
                                 sbnNextRec       : BrowseNext;
                                 sbnLastRec       : BrowseLast;
                                 sbnSearchRec     : begin
                                                    // FocusedField := GetEditControlField( LastActiveControl.Owner );
                                                    Correct := ApplyDatasetFilter( DefaultBrowseTable, nil { FocusedField } );
                                                    If   Correct
                                                    then begin
                                                         SyncBrowseTable;
                                                         ApplicationContainer.EnableRecordButtons( True, True, True );
                                                         end;
                                                    end;
                                 sbnCancelSrchRec : begin
                                                    DefaultBrowseTable.Filtered := False;
                                                    SearchStr := '';
                                                    BrowseLast;
                                                    ApplicationContainer.EnableRecordButtons( True, True, False );
                                                    end;
                                 sbnCopyRec       : If   Assigned( CurrentPos )
                                                    then try
                                                           DisableControls;
                                                           If   Assigned( FOnCopyCurrentRecord )
                                                           then begin
                                                                Correct := FOnCopyCurrentRecord;
                                                                If   not Correct
                                                                then begin
                                                                     OwnedForm.ActiveControl := LastActiveControl;
                                                                     Exit;
                                                                     end;
                                                                end;
                                                         finally
                                                           If   Correct
                                                           then begin
                                                                Cancel;
                                                                SelectFirstKeyControl;
                                                                end;
                                                           EnableControls;
                                                           end;
                                  end;

                               If   not Correct
                               then If   Assigned( CurrentPos )
                                    then GotoBookMark( CurrentPos )
                                    else begin
                                         Cancel;
                                         BrowseLast;
                                         end;

                               If   Assigned( LastActiveControl )
                               then If   not LastActiveControl.Enabled or ( ( LastActiveControl.Owner is TcxCustomEdit ) and ( LastActiveControl.Owner as TcxCustomEdit ).IsInplace )
                                    then begin
                                         If   DataAreaFocused
                                         then SelectFirstDataControl
                                         else SelectFirstKeyControl;
                                         end
                                    else With LastActiveControl do
                                           begin
                                           Show;
                                           If   LastActiveControl is TcxCustomInnerTextEdit
                                           then TcxCustomInnerTextEdit( LastActiveControl ).SelectAll;
                                           SetFocus;
                                           end;

                             finally
                               FreeBookMark( CurrentPos );
                               end;

                             end;

                   finally
                     ApplicationContainer.RecordButtonPressed := False;
                     end
            else If   Owner is TGridTableViewController
                 then begin
                      GridTableViewController := TGridTableViewController( Owner );
                      With GridTableViewController do
                        If   Assigned( TableView )
                        then With TableView, Controller do
                               begin
                               TableViewDataController := TcxGridDBDataController( DataController );
                               case AnAppSpeedBtn of
                                 sbnSearchRec     : If   TableViewDataController.Filter.AutoDataSetFilter
                                                    then begin

                                                         If   GridTableViewController.UseGridFilterBox
                                                         then TableView.Filtering.RunCustomizeDialog
                                                         else begin

                                                              // El dataset tiene que ser un TnxeQuery

                                                              If   not Assigned( FTableViewQuery )
                                                              then try
                                                                     ADataset := TableViewDataController.DataSource.DataSet;
                                                                     If   Assigned( ADataset ) and ( ADataset is TnxeQuery )
                                                                     then FTableViewQuery := TnxeQuery( ADataset );
                                                                   except
                                                                     end;

                                                              If   Assigned( FTableViewQuery )
                                                              then begin
                                                                   SearchField := TcxGridDBColumn( FocusedColumn ).DataBinding.Field;
                                                                   If   Assigned( SearchField ) and ( SearchField.FieldKind=fkData )
                                                                   then begin
                                                                        Correct := ApplyDatasetFilter( FTableViewQuery, SearchField );
                                                                        FTableViewQuery.RefreshQuery;
                                                                        If   Correct
                                                                        then ApplicationContainer.EnableRecordButtons( True, True, True );
                                                                        end
                                                                   else ShowHintMsg( RsMsg57, RsMsg58 );
                                                                   end
                                                              else begin
                                                                   If   DataController.Filter.Active
                                                                   then FilterColumn := nil
                                                                   else FilterColumn := Controller.FocusedColumn;
                                                                   Filtering.RunCustomizeDialog( FilterColumn );
                                                                   If   DataController.Filter.Active
                                                                   then ApplicationContainer.EnableRecordButtons( True, True, True );
                                                                   end;

                                                              end;


                                                         end
                                                    else begin  // Nos conformaremos con una simple búsqueda

                                                         If   ShiftKey
                                                         then SearchInProgress := False;

                                                         If   not SearchInProgress
                                                         then begin
                                                              RecordIndex := TcxGridDBColumn( FocusedColumn ).Index;
                                                              If   RecordIndex<>SearchFieldIndex
                                                              then SearchStr := '';
                                                              SearchFieldIndex := RecordIndex;
                                                              Correct := SearchBox( TableView, SearchFieldIndex, SearchStr )=mrOk;
                                                              end
                                                         else Correct := True;

                                                         If   Correct and ( SearchStr<>'' )
                                                         then With TableView do
                                                                begin
                                                                RecordIndex := DataController.FindRecordIndexByText( FocusedRecordIndex + 1, SearchFieldIndex, SearchStr, True, True, True );
                                                                If   RecordIndex>=0
                                                                then begin
                                                                     SearchInProgress := True;
                                                                     DataController.ChangeFocusedRecordIndex( RecordIndex );
                                                                     ApplicationContainer.EnableRecordButtons( True, True, True );
                                                                     end
                                                                else begin
                                                                     ShowHintMsg( RsMsg65, RsMsg66 );
                                                                     SearchInProgress := False;
                                                                     end;
                                                                end;

                                                         end;
                                 sbnCancelSrchRec : begin
                                                    If   TableViewDataController.Filter.AutoDataSetFilter
                                                    then begin
                                                         If   GridTableViewController.UseGridFilterBox
                                                         then TableViewDataController.Filter.Active := False
                                                         else If   Assigned( FTableViewQuery )
                                                              then begin
                                                                   With FTableViewQuery do
                                                                     begin
                                                                     Filtered := False;
                                                                     FTableViewQuery.RefreshQuery;
                                                                     Last;
                                                                     end;
                                                                   end
                                                              else With TableView.DataController.Filter do
                                                                     begin
                                                                     Active := False;
                                                                     Clear;
                                                                     end;
                                                         end
                                                    else SearchInProgress := False;
                                                    SearchStr := '';
                                                    ApplicationContainer.EnableRecordButtons( True, True, False );
                                                    end;

                                 sbnFirstRec      : GotoFirst;
                                 sbnPriorRec      : GotoPrev( True );
                                 sbnRefreshRec    : If   Assigned( FormManager ) and
                                                         Assigned( FormManager.FOnRefreshCurrentRecord )
                                                    then FormManager.FOnRefreshCurrentRecord
                                                    else If   DataController.Active
                                                         then DataController.RefreshExternalData;
                                 sbnNextRec       : GotoNext( True );
                                 sbnLastRec       : GotoLast( True );
                                 sbnNote          : If   ApplicationContainer.NoteButton.Enabled and
                                                         Assigned( FormManager ) and
                                                         Assigned( FormManager.OnNoteRequest )
                                                    then FormManager.OnNoteRequest;
                                 end;
                               end;
                      end
                 else If   Owner is TgQueryPanel
                      then begin
                           var QueryPanel := TgQueryPanel( Owner );
                           With QueryPanel, GridTableView do
                             case AnAppSpeedBtn of
                               sbnSearchRec     : ShowFilterFrame;
                               sbnCancelSrchRec : begin
                                                  CancelFilter;
                                                  Controller.GotoFirst;
                                                  end;
                               sbnFirstRec      : Controller.GotoFirst;
                               sbnPriorRec      : Controller.GotoPrev( True );
                               sbnRefreshRec    : try
                                                    DataController.DataSource.Enabled := False;
                                                    If   Assigned( QueryPanel.SourceQuery )
                                                    then QueryPanel.SourceQuery.RefreshQuery
                                                    else If   Assigned( QueryPanel.SourceTable )
                                                         then QueryPanel.SourceTable.Refresh;
                                                  finally
                                                    DataController.DataSource.Enabled := True;
                                                    end;
                               sbnNextRec       : Controller.GotoNext( True );
                               sbnLastRec       : Controller.GotoLast( True );
                               end;
                           end;

     finally
       fBtnLinkProcess := False;
       end;
end;

function TRecordButtonLink.ApplyDatasetFilter( Dataset : TnxDataset;
                                               Field   : TField ) : Boolean;
var  RangePos : Integer;

function GetLikeExpression( FieldName    : String;
                            SearchString : String ) : String;

var  I : SmallInt;
     SubString : String;

begin
     Result := '';
     SearchString := StringReplace( SearchString, '''', '''''', [ rfReplaceAll ] );
     I := 1;
     While ( I<=Length( SearchString ) ) do
       begin
       SubString := ExtractSubString( SearchString, I, ' ' );
       If   SubString<>''
       then begin
            If   Result<>''
            then Result := Result + ' AND ';
            Result := Result + FieldName + ' LIKE ' + QuotedStr( '%' + SubString + '%' ) + ' IGNORE CASE ';
            end;
       end;
end;

function GetDateExpression( Value : String ) : String;
begin
     Result := SQLDateString( StrToDateTime( Value ) );
end;

function FormatSearchValue( Value    : String;
                            RangeEnd : Boolean = False ) : String;
begin
     If   Value=''
     then If   RangeEnd
          then Value := GetMaxValue( SearchField.DataType )
          else Value := GetMinValue( SearchField.DataType );

     case SearchField.DataType of
       ftString,
       ftWideString : begin
                      Value := StringReplace( Value, '''', '''''', [ rfReplaceAll ] );
                      Result := QuotedStr( UpperCase( Value ) );
                      end;
       ftDate       : Result := GetDateExpression( Value );
       else           Result := Value;
       end;
end;

begin

     Result := False;

     With Dataset do
       begin

       DisableControls;

       try

         Filter := '';
         Filtered := False;

         If   Assigned( Field )
         then SearchFieldName := Field.FieldName;

         If   FilterBox( Dataset, SearchFieldName, SearchStr, IsSearchExpression )=mrOk
         then If   SearchStr<>''
              then try

                     FilterType := ftSQLWhere;  // Por si acaso
                     If   IsSearchExpression
                     then Filter := SearchStr
                     else begin
                          SearchField  := FieldByName( SearchFieldName );
                          If   Assigned( SearchField )
                          then begin
                               SearchStr := StringReplace( SearchStr, '''', '''''', [ rfReplaceAll ] );
                               RangePos := Pos( '..', SearchStr );
                               If   RangePos=0
                               then begin
                                    case SearchField.DataType of
                                      ftString,
                                      ftWideString  : Filter := GetLikeExpression( SearchFieldName, SearchStr );
                                      ftDate        : Filter := SearchFieldName + '=' + GetDateExpression( SearchStr );
                                      else            Filter := SearchFieldName + '=' + SearchStr;
                                      end;
                                    end
                               else Filter := SearchFieldName + '>=' + FormatSearchValue( Copy( SearchStr, 1, RangePos - 1 ) ) + ' AND ' +
                                              SearchFieldName + '<=' + FormatSearchValue( Copy( SearchStr, RangePos + 2, 80  ), True );
                               end
                          else Exit;
                          end;

                     Filtered := True;
                     First;
                     If   Eof
                     then begin
                          ShowNotification( ntStop, RsMsg18 );
                          Filtered := False;
                          ApplicationContainer.EnableRecordButtons( True, True, False );  // Por si acaso
                          Exit;
                          end;

                     Result := True;

                   except
                     ShowNotification( ntStop, RsMsg16, RsMsg17 );
                     Filter   := '';
                     Filtered := False;
                     end;

         finally
           EnableControls;
           end;

       end;
end;

{ TgxForm ---------------------------------------------------------------- }

constructor TgxForm.Create( AOwner : TComponent );
begin
     inherited;
     FFormType := fmUnassigned;
end;

destructor TgxForm.Destroy;
begin
     If   Assigned( FFormManager )
     then If   FFormManager.Model in [ fmInputForm, fmEditForm, fmPersistentInputForm, fmReportForm ]
          then ApplicationContainer.HideAlerts;

     inherited Destroy;

     If   Assigned( FFormManager )
     then If   Assigned( FFormManager.AfterDestroyForm )
          then FFormManager.AfterDestroyForm;
end;

function TgxForm.GetFormManager : TgxFormManager;
begin
     If   not Assigned( FFormManager )
     then FFormManager := TgxFormManager( FindComponent( FormManagerName ) );
     Result := FFormManager;
end;

procedure TgxForm.DoCreate;
begin

     If   Assigned( FormManager )   // No usar FFormManager
     then FFormManager.Setup;

     If   Assigned( OnCreate )
     then OnCreate( Self );

     // Si es la primera ventana que se abre se guarda la sección porque puede que
     // la ventana cambie la sección activa y luego no vuelva a la que tenía el usuario

     If   ( FormStyle=fsMDIChild ) and
          ( FormType=fmEdit ) and
          ( VisibleMDIChildCount=0 )
     then FFormerAppSection := ApplicationContainer.CurrentSection;

end;

procedure TgxForm.DoShow;
begin
     inherited;
     // Color := ApplicationContainer.GetPainterColor( clBtnFace );
     // No quiero ajustar la escala en las ventanas de FastReports
     If   FIsFrxBaseForm
     then begin
          Font.Name := 'Segoe UI';
          Font.Size := 10;
          end
     else begin
          AdjustScale;
          If   not ApplicationContainer.TDI and ( FormStyle=fsMDIChild ) and ( Position<>poDefaultSizeOnly ) and not SavedBounds
          then PlaceForm( Self );
          SavedBounds := False;
          end;
     FShowedAndScaled := True;
end;


procedure TgxForm.RestoreWindow;
begin
     PostMessage( Handle, WM_SYSCOMMAND, SC_RESTORE, 0 );
end;

function TgxForm.GetActiveEditControl : TcxCustomEdit;

begin
     Result := nil;
     If   Assigned( ActiveControl )
     then If   ActiveControl is TcxCustomEdit
          then Result := ActiveControl as TcxCustomEdit
          else If   ActiveControl.Owner is TcxCustomEdit
               then Result := ActiveControl.Owner as TcxCustomEdit;
end;

procedure TgxForm.KeyPress( var Key: Char);
begin
     If   not FIsFrxBaseForm
     then begin
          ControlKeyPress( Key );
          case Key of
            #$D, #$F  : Key := #0;    // Evitando el molesto Beep
            end;
          end;
     inherited KeyPress( Key );
end;

procedure TgxForm.Loaded;
begin
     inherited;

     DoubleBuffered := True;  // antes False
     DoubleBufferedMode := dbmRequested;

     If   not IsDesignTime
     then begin
          With Constraints do
            begin
            MinWidth := 200;
            MinHeight := 100;
            end;
          ShowHint := True;
          end;

end;

procedure TgxForm.KeyDown( var Key    : Word;
                               Shift  : TShiftState );

var   Sbt : TSpeedBtnTag;
      CustomEdit : TcxCustomEdit;
      GridView : TcxGridDBTableView;
      GridTableItem : TcxCustomGridTableItem;
      GridTableViewController : TGridTableViewController;
      TabSheet : TcxTabSheet;
      CheckTab,
      CheckTabSheets,
      CantExit,
      EmptyDataset : Boolean;
      ADataSource : TDataSource;
      IDataset : InxeDataset;

procedure SelectNextPage( TabSheet  : TcxTabSheet;
                          GoForward : Boolean );
begin
     With TabSheet.PageControl do
       begin
       SelectNextPage( GoForward, True );
       ActivePage.SetFocus;
       SelectNextFormControl( ActivePage );
       end;
end;

procedure ClickButton( AButton : TcxButton );
begin
     With AButton do
       begin
       Down := not Down;
       Click;
       end;
     Key := 0;
end;

procedure CheckAutoEdit;
begin
     If   Assigned( FFormManager ) and ( FFormManager.Model=fmEditForm )
     then If   not FFormManager.AutoEditEnabled and
               not ( ( Key in  [ 0, VK_SHIFT, VK_CONTROL, VK_MENU, VK_PRIOR, VK_NEXT, VK_HOME, VK_END, VK_ESCAPE, VK_UP, VK_DOWN, VK_RIGHT, VK_LEFT, VK_F1..VK_F12 ] ) or
                     ( ( Key in [ VK_INSERT, $43 ] ) and IsKeyPressed( VK_CONTROL ) ) ) // Ctrl+Insert o Ctrl+C : Copiar
          then begin

               //* 07.04.2009 Hay casos en los que un campo es modificable aunque el registro esté en modo solo lectura
               //             Por ejemplo, los números de serie y lotes de los albaranes de venta ...

               If   Assigned( GridTableItem ) and ( GridTableItem.GridView.DataController is TcxGridDBDataController )
               then begin
                    ADataSource := TcxGridDBDataController( GridTableItem.GridView.DataController ).DataSource;
                    If   Assigned( ADataSource ) and ADataSource.AutoEdit and not GridTableItem.Properties.ReadOnly
                    then Exit;
                    end;

               If   Assigned( FFormManager.OnShowCantEditMessage )
               then FFormManager.OnShowCantEditMessage
               else ShowHintMsg( RsMsg59, RsMsg60 );
               Key := 0;
               end;
end;

function KeyFunction : TSpeedBtnTag;
begin
     Result := sbnNone;
     case Key of
       VK_HOME     : If   ssCtrl in Shift
                     then Result := sbnFirstRec;
       VK_DOWN,
       VK_NEXT     : If   ssCtrl in Shift
                     then Result := sbnNextRec;

       VK_UP,
       VK_PRIOR    : If   ssCtrl in Shift
                     then Result := sbnPriorRec;

       VK_END      : If   ssCtrl in Shift
                     then Result := sbnLastRec;

       VK_BACK     : If   ( ssCtrl in Shift ) and ( ssAlt in Shift )
                     then Result := sbnCancelSrchRec;

       VK_F1       : Result := sbnHelp;

       VK_F2       : If   Shift=[]
                     then Result := sbnEditRec
                     else If   ssShift in Shift
                          then Result := sbnDefaultValue;

       VK_F3       : If   ( ssCtrl in Shift ) and ( ssAlt in Shift )
                     then Result := sbnCopyRec
                     else If   ssShift in Shift
                          then Result := sbnQueryGrid
                          else If   ssCtrl in Shift
                               then Result := sbnRelatedDocs;

       VK_F4       : If   ( ssCtrl in Shift ) and ( ssAlt in Shift )
                     then Result := sbnSearchRec;

       VK_F5       : If   Shift=[]
                     then Result := sbnNote;

       VK_F6       : If   ssShift in Shift
                     then Result := sbnGraphic
                     else If   ApplicationContainer.ReportButton.Enabled and ( ( Shift=[] ) or ( ( ssCtrl in Shift ) and ( ssAlt  in Shift ) ) )
                          then Result := sbnReport ;

       VK_F7       : If   ( Shift=[] ) and ApplicationContainer.FormReportButton.Enabled
                     then Result := sbnFormReport;

       VK_F8       : If   ( Shift=[] ) and ApplicationContainer.LabelButton.Enabled
                     then Result := sbnLabels;

       VK_F11      : ;

       VK_F12      : Result := sbnInsertRec;  // Incluido <Shift>+<F12> o <Ctrl>+<F12>

       VK_RETURN   : If   Shift=[]
                     then Result := sbnAccept
                     else If   ssCtrl in Shift
                          then Result := sbnRefreshRec;

       VK_ESCAPE  :  Result := sbnClose;

       VK_DELETE  :  ;

       end;

end;

procedure CtrlCheckTab;
begin
     CheckTab := False;

     If   FFormManager.Model in [ fmEditForm, fmPersistentInputForm ]
     then CheckTab := True
     else If   Assigned( ActiveControl )
          then begin
               TabSheet := GetParentTabSheet( ActiveControl );
               If   Assigned( TabSheet )
               then CheckTab := ( TabSheet.PageControl.TabulationCycle=tcComplete ) or ( TabSheet.PageControl.Tag<>0 );  // El Tag lo mantengo por retro-compatibilidad
               end;

     Key := 0;
     SelectNextFormControl( ActiveControl, not( ssShift in Shift ), CheckTab );
end;

begin

     If   not IsDesignTime
     then begin

          HintKeyPressed := True;

          If   Assigned( FFormManager )
          then With FFormManager do
                 begin

                 If   ActiveControl is TcxGridSite
                 then begin
                      GridView := TcxGridDBTableView( TcxCustomGrid( TcxGridSite( ActiveControl ).Container ).ActiveView );
                      If   Assigned( GridView ) // and ( Shift=[] )
                      then Case Key of
                             VK_TAB     : begin
                                          Key := 0;
                                          If   not GridView.DataController.IsEditing
                                          then SelectNextFormControl( ActiveControl, not( ssShift in Shift ), True );
                                          end;

                             VK_Escape  : begin
                                          Key := 0;
                                          If   GridView.DataController.IsEditing
                                          then begin
                                               GridView.DataController.Cancel;
                                               Exit;
                                               end;
                                          SpeedBtnPressed( sbnClose );
                                          end;

                             VK_F4      : If   ( ssCtrl in Shift ) and ( ssAlt in Shift )
                                          then If   Assigned( ActiveRecordButtonLink )
                                               then ActiveRecordButtonLink.RecordBtnPressed( sbnSearchRec );

                             VK_F5      : If   Assigned( ActiveRecordButtonLink )
                                          then ActiveRecordButtonLink.RecordBtnPressed( sbnNote );

                             VK_F6       : If   ssShift in Shift
                                           then SpeedBtnPressed( sbnGraphic )
                                           else If   ApplicationContainer.ReportButton.Enabled and ( ( Shift=[] ) or ( ( ssCtrl in Shift ) and ( ssAlt  in Shift ) ) )
                                                then SpeedBtnPressed( sbnReport );

                             VK_BACK    : If   ( ssCtrl in Shift ) and ( ssAlt in Shift )
                                          then If   Assigned( ActiveRecordButtonLink )
                                               then ActiveRecordButtonLink.RecordBtnPressed( sbnCancelSrchRec );

                             VK_HOME,
                             VK_END,
                             VK_UP,
                             VK_DOWN    : If   ( ssCtrl in Shift ) and ( ssShift in Shift )
                                          then If   Assigned( ActiveRecordButtonLink ) and
                                                    ( ActiveRecordButtonLink.Owner is TGridTableViewController )
                                               then begin
                                                    GridTableViewController := TGridTableViewController( ActiveRecordButtonLink.Owner );
                                                    case Key of
                                                      VK_HOME : GridTableViewController.ShiftUp( True );
                                                      VK_END  : GridTableViewController.ShiftDown( True );
                                                      VK_UP   : GridTableViewController.ShiftUp;
                                                      VK_DOWN : GridTableViewController.ShiftDown;
                                                      end;
                                                     Key := 0;
                                                     Exit;
                                                    end;
                             end;
                      end
                 else If   ActiveControl is TgBitBtn
                      then begin
                           If   Key=VK_TAB
                           then CtrlCheckTab;
                           end
                      else begin
                           CustomEdit := GetActiveEditControl;
                           If   Assigned( CustomEdit ) and not ( CustomEdit.Parent is TFieldPanel )
                           then begin

                                GridTableItem := nil;

                                // Esto es solo un refuerzo, sobre todo para los Tabs desde controles que no son un TcxCustomTextEdit

                                CustomEdit.UpdateKeyPressed( Key, Shift );

                                // Si es la primera columna de un Grid y está vacía se sale de la rejilla

                                If   CustomEdit.IsInplace
                                then begin
                                     If   Shift=[]
                                     then If   CustomEdit.InplaceParams.Position.Item is TcxCustomGridTableItem
                                          then begin
                                               GridTableItem := TcxCustomGridTableItem( CustomEdit.InplaceParams.Position.Item );
                                               With GridTableItem do
                                                 begin
                                                 case Key of
                                                   VK_Return,
                                                   VK_TAB    : If   ValueIsEmpty( CustomEdit.EditingValue ) and
                                                                    ( ( GetFirstEditableItemIndex( GridView )=Index ) or ( evoAllowLoseFocus in CustomEdit.Properties.ValidationOptions ) )
                                                               then begin

                                                                    EmptyDataset := False;
                                                                    CantExit := False;

                                                                    If   ( GridView.DataController is TcxGridDBDataController )
                                                                    then begin
                                                                         ADataSource := TcxGridDBDataController( GridView.DataController ).DataSource;
                                                                         If   Assigned( ADataSource ) and Assigned( ADataSource.DataSet )
                                                                         then begin
                                                                              ADataSource.DataSet.GetInterface( InxeDataset, IDataset );
                                                                              If   Assigned( IDataset )
                                                                              then begin
                                                                                   EmptyDataset := ( ADataSource.Dataset.State=dsInsert ) and ( GridView.DataController.RecordCount=1 );
                                                                                   CantExit := IDataset.MasterRelation=mrTied;
                                                                                   end;
                                                                              end;
                                                                         end;

                                                                    If   EmptyDataset
                                                                    then If   CustomEdit.Properties.Required and CantExit
                                                                         then begin
                                                                              Key := 0;
                                                                              Exit;
                                                                              end;

                                                                    CustomEdit.CancelValidation := True;
                                                                    CustomEdit.Clear;
                                                                    If   Key=VK_TAB
                                                                    then begin
                                                                         Key := 0;
                                                                         CheckTabSheets := FFormManager.Model in [ fmEditForm, fmPersistentInputForm ];
                                                                         SelectNextFormControl( ActiveControl, not( ssShift in Shift ), CheckTabSheets );
                                                                         end;

                                                                    end;

                                                   Vk_Right  : If   ( GetFirstEditableItemIndex( GridView )=Index ) and ( ValueIsEmpty( CustomEdit.EditingValue ) )
                                                               then begin
                                                                    Key := 0;
                                                                    Exit;
                                                                    end;

                                                   Vk_Down   : If   ( GetFirstEditableItemIndex( GridView )=Index ) and ValueIsEmpty( CustomEdit.EditingValue )
                                                               then begin
                                                                    Key := 0;
                                                                    Exit;
                                                                    end;

                                                   VK_escape : If   CustomEdit.ModifiedAfterEnter
                                                               then Exit
                                                               else begin
                                                                    GridView.DataController.Cancel;
                                                                    CustomEdit.CancelValidation := True;
                                                                    Exit;
                                                                    end;
                                                   end;
                                                 end;
                                          end;
                                     end
                                else begin

                                     case Key of
                                       VK_TAB     : CtrlCheckTab;

                                       VK_Next,
                                       VK_Prior   : begin
                                                    TabSheet := GetParentTabSheet( ActiveControl );
                                                    If   Assigned( TabSheet )
                                                    then begin
                                                         SelectNextPage( TabSheet, Key=VK_Next );
                                                              Key := 0;
                                                              Exit;
                                                              end;
                                                         end;

                                            VK_Escape  : If   CustomEdit.ModifiedAfterEnter
                                                         then Exit
                                                         else CustomEdit.CancelValidation := True;

                                            $42        : If   ssCtrl in Shift  // B
                                                         then If   Assigned( FLockRangeButton ) and not DataAreaFocused
                                                         then begin
                                                              ClickButton( FLockRangeButton );
                                                              Exit;
                                                              end;

                                            $46        : If   ssCtrl in Shift  // F
                                                         then If   Assigned( FLockWindowButton )
                                                              then begin
                                                                   ClickButton( FLockWindowButton );
                                                                   Exit;
                                                                   end;

                                            $4F        : If   ssCtrl in Shift  // O
                                                         then If   Assigned( FWarningButton ) and ( FWarningButton.Visible )
                                                              then begin
                                                                   ClickButton( FWarningButton );
                                                                   Exit;
                                                                   end;

                                       end;

                                     end;

                                CheckAutoEdit;

                                If   Key=VK_F4
                                then If   CustomEdit is TcxCustomDropDownEdit
                                     then TcxCustomDropDownEdit( CustomEdit ).DroppedDown := True;

                                Sbt := KeyFunction;
                                If   Sbt<>sbnNone
                                then begin
                                     If   Sbt in RecordSpeedBtns
                                     then begin
                                          If   Assigned( FRecordButtonLink ) and ApplicationContainer.RecordButtonsEnabled
                                          then FRecordButtonLink.RecordBtnPressed( Sbt );
                                          end
                                     else SpeedBtnPressed( Sbt );
                                     Key := 0;
                                     end;

                                end;

                           end;

                 If   Key<>0
                 then begin
                      Sbt := KeyFunction;
                      If   Sbt in [ sbnAccept, sbnClose ]
                      then SpeedBtnPressed( Sbt );
                      end;

                 end;

          end;

     inherited KeyDown( Key, Shift );

end;

procedure TgxForm.DoDestroy;
begin
     If   BackgroundForm
     then UpdateMDILayout( ApplicationContainer.CurrentMDILayout, Self, { ClosingForm } True );
     inherited;
end;

function TgxForm.GetVisible : Boolean;
begin
     Result := FFormVisible;
end;

procedure TgxForm.UpdateTabState( Subscribe : Boolean );
begin
     If   ApplicationContainer.TDI
     then With ApplicationContainer.TabbedMDIManager do
            If   Subscribe
            then SubscribeChild( Handle )   // Si ya existe no se añadirá
            else UnSubscribeChild( Handle );
end;

procedure TgxForm.SetVisible( Value : Boolean );

const Vc : array[ False..True ] of Integer = ( SW_HIDE, SW_SHOW );

begin

     // Los MDI forms, por diseño, no pueden ocultarse. Esta función permite realizar esta labor excepcional.

     If   not IsDesignTime and ( FormStyle=fsMDIChild )
     then begin

          try

            If   Value and ( Value<>FFormVisible ) and not inherited Visible
            then PlaceForm( Self );

            FFormVisible := Value;

            If   TDITabSheetForm
            then UpdateTabState( FFormVisible );

            If   Value
            then begin
                 inherited Visible := True;
                 {
                   Dibujo ya la ventana porque si no se muestra un parón desagradable.
                   En el CMShowingChanged se hace un ShowWindow y un BringtoFront, pero no un Repaint inmediato
                 }
                 Repaint;
                 end;

            ShowWindow( Handle, Vc[ Value ] );

          finally
            end;

          If   not Value and BackgroundForm
          then UpdateMDILayout( ApplicationContainer.CurrentMDILayout, Self, { ClosingForm } True );

          end
     else inherited Visible := Value;

end;

procedure TgxForm.UpdateImageLists;
begin
     inherited UpdateImageLists;
end;


procedure TgxForm.AdjustScale;
begin
     If   not IsDesignTime
     then If   Scaled and ApplicationScaled
          then If   not FScaleAdjusted
               then begin
                    FScaleAdjusted := True;
                    If   AppScaleDPI<>dxDefaultDPI
                    then begin
                         Scaled := True;
                         ChangeScale( AppScaleDPI, dxDefaultDPI );
                         end;
                    end;
end;

procedure TgxForm.SaveFormPosition;
begin
     If   not FMinimized and
          not FMaximized
     then If   ( Left>=0 ) and ( Top>=0 )
          then begin
               FsLeft    := Left;
               FsTop     := Top;
               FsWidth   := Width;
               FsHeight  := Height;
               end
          else begin  // Cuando inicialmente se muestra maximizada, le asigno un tamaño por defecto
               FsLeft    := 0;
               FsTop     := 0;
               FsWidth   := 600;
               FsHeight  := 400;
               end;
end;

procedure TgxForm.WMSysCommand( var message : TWMSysCommand );
begin
     If   not IsDesignTime
     then With Message do
            try
              FAdjustingForm := True;

              If   FormStyle=fsMDIChild
              then case CmdType and $FFF0 of
                     SC_CLOSE    : If   biSystemMenu in BorderIcons
                                   then begin
                                        If   Assigned( FFormManager )
                                        then FFormManager.FormResult := mrCancel;
                                        end
                                   else Exit;

                     SC_RESTORE  : begin
                                   If   FMinimized
                                   then begin
                                        SetBounds( FsLeft, FsTop, FsWidth, FsHeight );
                                        WindowState := wsNormal;
                                        end;
                                   FMaximized := False;
                                   Exit;
                                   end;

                     SC_MINIMIZE : begin
                                   SaveFormPosition;
                                   FMinimized := True;
                                   FMaximized := False;
                                   end;

                     SC_MAXIMIZE : begin
                                   ToggleMaximize;
                                   Exit;
                                   end;

                     end;
            finally
              FAdjustingForm := False;
              end;
     inherited;
end;

procedure TgxForm.Resize;
begin
     If   not ( fsCreating in FormState )
     then begin
          inherited;                           // BufferedShowing
          If   not FAdjustingForm
          then FMaximized := False;
          end;
end;

procedure TgxForm.SelectNextControl( GoForward : Boolean = True );
begin
     SelectNext( ActiveControl, GoForward, True );
end;

procedure TgxForm.MaximizeForm;

var   W, H : SmallInt;

begin
     If   Assigned( Application.MainForm ) and
          ( FormStyle=fsMDIChild ) and
          Enabled
     then try
            FAdjustingForm := True;
            SaveFormPosition;
            W := Application.MainForm.ClientWidth; 
            H := GetDesktopHeight;
            Self.SetBounds( 0, 0, W, H );
            FMaximized := True;
          finally
            FAdjustingForm := False;
            end;
end;

function TgxForm.SetFocusedControl(Control: TWinControl): Boolean;
begin

     // Cada EditControl tiene un InnerControl (el control real) que también gana y pierde el focus,
     // con lo que se duplican (como poco) las activaciones y des-activaciones del control

     Result := False;
     If   not IsDesignTime
     then If   Assigned( ActiveEditControl ) and ( ( ActiveEditControl=Control ) or ( ActiveEditControl=Control.Owner ) )
          then Result := inherited SetFocusedControl( Control )
          else begin
               ActiveEditControl := nil;
               If   not ApplicationContainer.RecordButtonPressed
               then begin
                    ApplicationContainer.HideHintPanel;
                    DeActivateControlToolbarOptions;
                    end;
               Result := inherited SetFocusedControl( Control );
               If   Result
               then SetActiveEditControl( Control );
               end;
end;

procedure TgxForm.SetFormType(const Value: TFormType);
begin
     If   FFormType<>Value
     then begin

          FFormType := Value;

          FBackgroundForm := FFormType in [ fmGrid, fmBackground ];
          FTDITabSheetForm := ApplicationContainer.TDI and FBackgroundForm;
          FMDIMaximizedForm := not ApplicationContainer.TDI and FBackgroundForm and  ( FFormType<>fmQuery );

          If   Assigned( FFormManager )
          then begin
               FBackgroundForm := FBackgroundForm or ( FFormManager.FModel in [ fmEditForm, fmPersistentInputForm ] );
               FTDITabSheetForm := FTDITabSheetForm or ( ApplicationContainer.TDI and FBackgroundForm );
               FMDIMaximizedForm := FMDIMaximizedForm or ( ( not ApplicationContainer.TDI ) and ( ( ( ApplicationContainer.CurrentMDILayout<>mdiNone ) or ApplicationContainer.MaximizeEditForms ) and FBackgroundForm ) );
               end;

          If   FBackgroundForm
          then begin
               BorderIcons := [ biMaximize, biSystemMenu ];
               If   ApplicationContainer.CurrentMDILayout=mdiNone
               then BorderIcons := BorderIcons + [ biMinimize ];
               end
          else BorderIcons := [ biSystemMenu ];

          end;
end;

procedure TgxForm.SetReferencePtr(const Value: PgxForm);
begin
     FReferencePtr := Value;
end;

procedure TgxForm.SetActiveEditControl( Control : TWinControl );
begin
     If   Control is TcxGridSite
     then ActivateGridSite( Control as TcxGridSite )
     else begin
          If   Control is TcxCustomEdit
          then ActiveEditControl := Control as TcxCustomEdit
          else If   Control.Owner is TcxCustomEdit
               then ActiveEditControl := Control.Owner as TcxCustomEdit;
          If   not ApplicationContainer.RecordButtonPressed
          then begin
               ActivateControlToolbarOptions( { LockUpdate } False );
               ShowHints;
               end;
          If   Assigned( ActiveEditControl )
          then FLastActiveEditControl := ActiveEditControl;
          end;
end;

procedure TgxForm.SetCloseWindowWhenFocusLost(const Value: Boolean);
begin
     FCloseWindowWhenFocusLost := Value;
end;

procedure TgxForm.ToggleMaximize;
begin
     If   FMaximized
     then begin
          SetBounds( FsLeft, FsTop, FsWidth, FsHeight );
          FMaximized := False;
          FMinimized := False;
          end
     else Maximize;
end;

procedure TgxForm.CMVisibleChanged(var Message: TMessage);
begin
     inherited;
     FFormVisible := inherited Visible;
end;

procedure TgxForm.Maximize;
begin
     If   FormStyle=fsMDIChild
     then begin
          If   not FMaximized
          then begin
               MaximizeForm;
               WindowState := wsNormal;
               end;
          FMinimized := False;
          end
     else SendMessage( Handle, WM_SYSCOMMAND, SC_MAXIMIZE, 0 );
end;

procedure TgxForm.Activate;
begin
     inherited;
     If   not IsDesignTime
     then DoActivate;
end;

procedure TgxForm.DoActivate;
begin
end;

procedure TgxForm.Deactivate;
begin
     inherited;
     DoDeactivate;
end;

procedure TgxForm.DoDeactivate;
begin
     If   not IsDesignTime
     then ActiveEditControl := nil;
end;

procedure TgxForm.ActivateControlToolbarOptions( LockUpdate : Boolean = True );
begin

     If   Assigned( ApplicationContainer.MainTopBar )
     then try

            try

              If   LockUpdate
              then ApplicationContainer.MainTopBar.LockUpdate := True;

              If   Assigned( FormManager )
              then With FormManager do
                     begin
                     SetupToolbar( True, LockUpdate );
                     ActiveRecordButtonLink := FRecordButtonLink;
                     ActiveFormManager := FormManager;
                     end;

              If   Assigned( ActiveEditControl ) and ( FormStyle=fsMDIChild ) and not ApplicationContainer.RecordButtonPressed
              then With ActiveEditControl.Properties do
                     begin
                     If   Assigned( ApplicationContainer.EditButton )
                     then ApplicationContainer.EditButton.Enabled := Assigned( OnEditRequest );
                     If   Assigned( ApplicationContainer.QueryButton)
                     then ApplicationContainer.QueryButton.Enabled := Assigned( OnQueryRequest );
                     If   Assigned( ApplicationContainer.NoteButton )
                     then ApplicationContainer.NoteButton.Enabled := ApplicationContainer.NoteButton.Enabled or Assigned( OnAnnotationRequest );
                     If   Assigned( ApplicationContainer.InsertRecButton )
                     then ApplicationContainer.InsertRecButton.Enabled := IsAutoIncControl( ActiveEditControl );
                     end;

            finally
              If   LockUpdate
              then ApplicationContainer.MainTopBar.LockUpdate := False;
              end;

             except
               end;
end;

procedure TgxForm.ActivateGridSite( GridSite : TcxGridSite );

var ActiveGridView : TcxGridDBTableView;
    RecordButtonLink : TRecordButtonLink;
    FilterEnabled,
    Filtered : Boolean;
    TableViewDataController : TcxGridDBDataController;

begin
     If   Assigned( GridSite.GridView ) and ( GridSite.GridView is TcxGridDBTableView ) and Assigned( FormManager )  // Siempre con un FormManager en el form
     then begin
          ActiveGridView := TcxGridDBTableView( GridSite.GridView );
          TableViewDataController := TcxGridDBDataController( ActiveGridView.DataController );
          If   Assigned( TableViewDataController.DataSource )
          then begin

               Filtered := False;

               { If   ( FormManager.Model=fmPersistentInputForm ) or Assigned( FormManager.FOnSetupToolBar )
               then } ActivateControlToolbarOptions;

               RecordButtonLink := TRecordButtonLink( ActiveGridView.LinkedComponent );
               If   Assigned( RecordButtonLink )
               then begin

                    If   GridSite.Focused
                    then ActiveRecordButtonLink := RecordButtonLink
                    else ActiveRecordButtonLink := nil;

                    // Utilizo el campo AutoDataSetFilter para determinar si debe activarse el botón de filtrado

                    case FormManager.Model of
                      fmEditForm  : begin
                                    FilterEnabled := True;
                                    Filtered := RecordButtonLink.SearchStr<>'';
                                    end
                      {
                      fmGridForm  : begin
                                    FilterEnabled := True;
                                    Filtered := TableViewDataController.Filter.Active;
                                    end
                      }
                      else          begin
                                    FilterEnabled := TableViewDataController.Filter.AutoDataSetFilter;
                                    If   FilterEnabled
                                    then With TableViewDataController do
                                           If   Assigned( DataSource ) and Assigned( DataSource.Dataset )
                                           then Filtered := DataSource.Dataset.Filtered;
                                    end;
                      end;

                    ApplicationContainer.EnableRecordButtons( GridSite.IsFocused, GridSite.IsFocused and FilterEnabled, Filtered );
                    end;
               end;
          ShowHints;
          end;

     If   Assigned( ApplicationContainer.MainTopBar )
     then ApplicationContainer.MainTopBar.LockUpdate := False;
end;

procedure TgxForm.DeActivateControlToolbarOptions;
begin
     With ApplicationContainer do
       If   ( FormStyle=fsMDIChild ) and not RecordButtonPressed
       then begin
            If   Assigned( FormManager )
            then FormManager.SetupToolbar( False, { LockUpdate } False );
            If   Assigned( EditButton )
            then EditButton.Enabled := False;
            If   Assigned( QueryButton)
            then QueryButton.Enabled := False;
            If   Assigned( NoteButton )
            then NoteButton.Enabled := False;
            If   Assigned( InsertRecButton )
            then InsertRecButton.Enabled := False;
            end;
end;

procedure TgxForm.ShowHints;

var  HintStr : String;
     EditControl : TcxCustomEdit;

begin

     If   Assigned( ActiveControl )
     then begin

          HintStr := '';

          If   ActiveControl is TcxGridSite
          then begin
               HintStr := TcxGridSite( ActiveControl ).Container.Hint;
               If   HintStr=''
               then HintStr := GetParentHint( ActiveControl );
               end
          else begin
               EditControl := GetEditControl( ActiveControl );
               If   Assigned( EditControl )
               then begin
                    HintStr := '';

                    // El EditControl.ShowHint debe estar explícitamente desactivado (no vale con el valor por defecto)

                    If   ( EditControl.Hint='' ) or not EditControl.ShowHint
                    then begin

                         If   IsAutoIncControl( EditControl )
                         then StrAdd( HintStr, HintMsg6 );

                         If   Assigned( EditControl.Properties.OnEditRequest )
                         then StrAdd( HintStr, ',' + HintMsg9 );
                         If   Assigned( EditControl.Properties.OnQueryRequest )
                         then StrAdd( HintStr, ',' + HintMsg10 );
                         If   EditControl is TcxCustomPopupEdit
                         then StrAdd( HintStr, ',' + HintMsg11 );

                         If   Assigned( EditControl.Properties.OnExtendedFunction )
                         then If   EditControl.Hint=''
                              then StrAdd( HintStr, ',' + HintMsg3 )
                              else StrAdd( HintStr, ',' + HintMsg12 + EditControl.Hint );

                         If   Assigned( EditControl.Properties.OnDefaultValue )
                         then StrAdd( HintStr, ',' + HintMsg4 );

                         If   Copy( HintStr, 1, 1 )=','
                         then Delete( HintStr, 1, 1 );

                         If   HintStr<>''
                         then HintStr := 'Pulse : ' + HintStr + '.';

                         end;

                    If   EditControl.Hint<>''
                    then StrAdd( HintStr, ' ' + EditControl.Hint );

                    end;
               end;

          If   HintStr=''
          then ApplicationContainer.HideHintPanel
          else ApplicationContainer.SetHintPanelCaption( ActiveControl, HintStr );

          end;
end;

{ TgxEditPanel ------------------------------------------------------- - }

constructor TgxEditPanel.Create( AOwner : TComponent );
begin
     inherited;
     FPanelKind := epStandard;
end;

procedure TgxEditPanel.SetPanelKind( const Value : TEditPanelKind );
begin

     If   Value<>FPanelKind
     then begin

          FPanelKind := Value;

          Caption := '';
          Transparent := False;
          AlignWithMargins := False;
          OnCustomDrawContentBackground := nil;

          case FPanelKind of
            epDataPanel,
            epInputPanel : begin

                           PanelStyle.Active := True;

                           ShowHint := False;
                           ParentColor := False;
                           ParentBackground := False;
                           Style.BorderStyle := ebsSingle;
                           // Style.LookAndFeel.NativeStyle := True;   // Activar si se desea que se aplique el color cuando se utilizan pieles

                           If   Parent is TForm
                           then begin
                                AlignWithMargins := True;
                                With Margins do
                                  begin
                                  If   FPanelKind=epInputPanel
                                  then Top := DataPanelBorder
                                  else Top := 0;
                                  Left := DataPanelBorder;
                                  Right := DataPanelBorder;
                                  Bottom := 0;
                                  end;
                                end;

                           Style.Color := ApplicationContainer.GetPainterColor( clPanelDefault );

                           end

            else           begin

                           PanelStyle.Active := True;
                           Style.BorderStyle := ebsNone;
                           ParentColor := True;
                           ParentBackground := True;

                           If   ( FPanelKind=epKeyPanel ) and not Assigned( FStateShape )
                           then begin

                                FStateShape := TShape.Create( Self );
                                If   Assigned( FStateShape )
                                then begin
                                     FStateShape.Visible := False;
                                     FStateShape.Align := alLeft;
                                     FStateShape.Width := 4;
                                     FStateShape.Pen.Style:= psClear;
                                     FStateShape.Parent := Self;
                                     end;

                                end;

                           end;

            end;

          end;

end;

// Al ser un descendiente de TcxCustomEdit si no sobreescribo DoExit se validaría como si fuera un componente de introducción de datos

procedure TgxEditPanel.DoExit;
begin
          DoOnExit;
end;

procedure TgxEditPanel.UpdateStateImage;
begin
     If   FPanelKind=epKeyPanel
     then If   ( FormManager.Model=fmEditForm ) and Assigned( FormManager.Dataset )
          then begin
               FStateShape.Visible := True;
               case FormManager.Dataset.State of
                 dsSetKey : FStateShape.Brush.Color := clStateSetKey;
                 dsBrowse : FStateShape.Brush.Color := clStateBrowse;
                 dsEdit   : FStateShape.Brush.Color := clStateEdit;
                 dsInsert : FStateShape.Brush.Color := clStateInsert;
                 end;
               end;
end;

function TgxEditPanel.ValidateEditControls( UpdateData  : Boolean = False;
                                           StoreData   : Boolean = False ) : TcxCustomEdit;

var  I : Integer;
     EditControl : TcxCustomEdit;
     TabList : TList;

begin
     Result := nil;
     TabList := TList.Create;
     try
       GetTabOrderList( TabList );
       For I := 0 to TabList.Count - 1 do
         begin
         EditControl := GetEditControl( TWinControl( TabList[ I ] ) );
         If   Assigned( EditControl ) and not ( EditControl is TcxGroupBox ) and not ( EditControl is TcxLabel )
         then If   not ValidateEditControl( EditControl, UpdateData, StoreData )
              then begin
                   Result := EditControl;
                   Exit;
                   end;
         end;
     finally
       TabList.Free;
       end;
end;

function TgxEditPanel.GetOwnerForm : TgxForm;

var  AForm : TCustomForm;

begin
     If   not Assigned( FOwnerForm )
     then begin
          AForm := GetParentForm( Self );
          If   AForm is TgxForm
          then FOwnerForm := TgxForm( AForm )
          else raise Exception.Create( RsMsg69 );
          end;
     Result := FOwnerForm;
end;

function TgxEditPanel.GetFormManager : TgxFormManager;
begin
     If   not Assigned( FFormManager )
     then If   Assigned( OwnerForm )
          then FFormManager := TgxFormManager ( FOwnerForm.FindComponent( FormManagerName ) );
     Result := FFormManager;
end;

{ TgxCheckPageControl }

constructor TgxFilterPageControl.Create( AOwner : TComponent );
begin
     inherited;
     FFilterCheckBoxes := TList<TcxCheckBox>.Create;
end;

destructor TgxFilterPageControl.Destroy;
begin
     FFilterCheckBoxes.Free;
     inherited;
end;

procedure TgxFilterPageControl.AfterLoaded;

var  I, J : SmallInt;
     CheckBox : TcxCheckBox;

begin
     inherited;
     If   not IsDesignTime
     then begin

          // Es importante que sea Focusable, porque el CheckDefaultPage se llama a partir de un GetTabOrderList en ValidateEditPanel

          Focusable := True;

          For I := 0 to PageCount -1 do
            With Pages[ I ] do
              begin

              // Los posibles eventos asignados quedan suspendidos
              // Es demasiado costoso guardar todos los posibles eventos asignados y redireccionarlos.

              For J := 0 to ControlCount - 1 do
                If   Controls[ J ] is TcxCustomEdit
                then With TcxCustomEdit( Controls[ J ] ) do
                       Properties.OnEditValueChanged := DoOnEditValueChanged;

              // Creo el CheckBox de la página

              CheckBox := TcxCheckBox.Create( Self );
              With CheckBox do
                begin
                If   Assigned( ApplicationContainer.AppSkinPainter )
                then Width := ApplicationContainer.AppSkinPainter.CheckButtonSize.cx
                else Width := 21;
                Top := 2;
                Left := Pages[ I ].Width - Width - 6;
                Anchors := [ akRight, akTop ];
                Transparent := True;
                Hint := HintMsg2;
                TabStop := False;   // Tampoco se ve el focus, o sea que mejor no me paro
                Parent := Pages[ I ];
                OnClick := DoOnCheckBoxClick;
                end;

              FFilterCheckBoxes.Add( CheckBox );

              end;

            end;

end;

// Si no hay ninguna pestaña con el filtro activo se marca el de
// la pestaña activa

procedure TgxFilterPageControl.CheckDefaultPage;

var  I : SmallInt;
     ActiveCheckBox : TcxCheckBox;

begin
     If   Assigned( FFilterCheckBoxes ) and not ( csLoading in ComponentState )
     then begin
          ActiveCheckBox := FFilterCheckBoxes[ ActivePageIndex ];
          If   Assigned( ActiveCheckBox ) and not ActiveCheckBox.Checked
          then For I := 0 to PageCount - 1 do
                 If   FFilterCheckBoxes[ I ].Checked
                 then Exit;
          ActiveCheckBox.Checked := True;
          end;
end;

procedure TgxFilterPageControl.DoOnEditValueChanged( Sender : TObject );

var  ActiveCheckBox : TcxCheckBox;

begin
     If   TcxCustomEdit( Sender ).Editing
     then begin
          ActiveCheckBox := FFilterCheckBoxes[ ActivePageIndex ];
          If   Assigned( ActiveCheckBox )
          then begin
               ActiveCheckBox.Checked := True;
               DoOnCheckBoxClick( ActiveCheckBox );
               end;
          end;
end;

procedure TgxFilterPageControl.DoOnCheckBoxClick( Sender : TObject );

var  CheckBox : TcxCheckBox;
     TabSheet : TcxTabSheet;

begin
     If   Sender is TcxCheckBox
     then begin
          CheckBox := TcxCheckBox( Sender );
          TabSheet := TcxTabSheet( CheckBox.Parent );
          TabSheet.Highlighted := CheckBox.Checked;
          If   Assigned( FOnCheckBoxClick )
          then FOnCheckBoxClick( TabSheet );
          end;
end;

{
function TgxFilterPageControl.HasTabSheetHighlighted : Boolean;
begin
     Result := False;
     For var PageInx := 0 to Properties.PageCount - 1 do
       If   Properties.Pages[ PageInx ].Highlighted
       then begin
            Result := True;
            Exit;
            end;
end;
}

{ TgxPageControlNavigator }

constructor TgxPageControlNavigator.Create( AOwner : TComponent );
begin
     inherited;
     Alignment := alCenterCenter;
     Height := 28;
     FLeftButton := TgxPageControlNavigatorButton.Create( Self );
     With FLeftButton do
       begin
       Parent := Self;
       Align := alLeft;
       Width := 100;
       Margin := 4;
       Spacing := 5;
       OnClick := DoOnClickButton;
       ApplicationForms.ControlsImageList.GetImage( 11, Glyph );
       end;
     FRightButton := TgxPageControlNavigatorButton.Create( Self );
     With FRightButton do
       begin
       Parent := Self;
       Align := AlRight;
       Width := 100;
       Layout := blGlyphRight;
       Margin := 4;
       Spacing := 10;
       OnClick := DoOnClickButton;
       ApplicationForms.ControlsImageList.GetImage( 12, Glyph );
       end;
end;

procedure TgxPageControlNavigator.Loaded;
begin
     inherited;
     ParentBackground := False;
end;

procedure TgxPageControlNavigator.SetPageControl( const Value : TcxPageControl );
begin
     If   FPageControl<>Value
     then begin
          If   Assigned( FPageControl )
          then FPageControl.OnChange := nil;
          FPageControl := Value;
          If   Assigned( FPageControl )
          then FPageControl.OnChange := DoOnPageControlChange;
          UpdateButtons;
          end;
end;

procedure TgxPageControlNavigator.DoOnPageControlChange(Sender: TObject);
begin
     UpdateButtons;
end;

procedure TgxPageControlNavigator.UpdateButtons;

type TButtonArray = array of TgxPageControlNavigatorButton;
var  AButton : TgxPageControlNavigatorButton;
     TabSheet : TcxTabSheet;

begin
     If   Assigned( FPageControl )
     then For AButton in TButtonArray.Create( FLeftButton, FRightButton ) do
            begin
            With FPageControl do
              TabSheet := FindNextPageEx( ActivePage, AButton=FRightButton, True, False );
            AButton.Visible := Assigned( TabSheet );
            If   Assigned( TabSheet )
            then begin
                 AButton.Caption := TabSheet.Caption;
                 AButton.TabSheet := TabSheet;
                 end;
            end;
end;

procedure TgxPageControlNavigator.DoExit;
begin
     DoOnExit;
end;

procedure TgxPageControlNavigator.DoOnClickButton(Sender: TObject);
begin
     If   Assigned( FPageControl )
     then FPageControl.ActivePage := TgxPageControlNavigatorButton( Sender ).TabSheet;
     If   Assigned( FOnClickButton )
     then FOnClickButton( Self );
end;


// TTableViewList

procedure TTableViewList.Notify( Ptr: Pointer; Action: TListNotification );
begin
     If   Action=lnDeleted
     then TTableViewListItem( Ptr ).Free;
end;

// TTableViewListItem

constructor TTableViewListItem.Create( TableView : TcxGridDBTableView );
begin

     // Guardo OptionsData porque es modificado en tiempo de ejecución por EnableAutoEdit

     inherited Create;
     FTableView := TableView;

     FAppending := FTableView.OptionsData.Appending;
     FDeleting := FTableView.OptionsData.Deleting;
     FInserting := FTableView.OptionsData.Inserting;

end;

{ TgxFormManager -------------------------------------------------------- }

constructor TgxFormManager.Create( AOwner : TComponent );
begin

     inherited Create( AOwner );

     If   AOwner.FindComponent( FormManagerName )<>nil
     then raise Exception.Create( RsgMsg501 );

     FOwnedForm := TgxForm( AOwner );
     FModel := fmInputForm;
     FValueList := TStringList.Create;
     FValueList.Duplicates := dupIgnore;

     With OwnedForm do
       begin

       If   IsDesignTime and not( csLoading in ComponentState )
       then begin
                 BorderStyle := bsDialog;
                 FormStyle := fsMDIChild;
                 Position := poDefault;
                 end;

       If   not IsDesignTime
       then begin

            OnActivate := FormActivate;
            OnClick := FormClick;
            OnClose := FormClose;
            OnCloseQuery := FormCloseQuery;
            OnCreate := FormCreate;
            OnDeactivate := FormDeactivate;
            OnDestroy := FormDestroy;
            OnDragDrop := FormDragDrop;
            OnDragOver := FormDragOver;
            OnHide := FormHide;
            OnShow := FormShow;

            If   Assigned( Application.MainForm )
            then OnHelp := Application.MainForm.onHelp;

            FDataSourceList := TList<TDataSource>.Create;
            FTableViewList := TTableViewList.Create;

            KeyPreview := True;
            end;

       Tag := 0; // Por si acaso contiene algun valor
       FormResult := mrNone;
       FButtonPressed := mrNone;
       end;

end;

function TgxFormManager.DefaultBrowseTable: TnxeTable;
begin
     If   Assigned( FBrowseTable )
     then Result := FBrowseTable
     else Result := FTable;
end;

destructor TgxFormManager.Destroy;
begin

     try

       If   not IsDesignTime
       then begin

            If   Assigned( FRecordButtonLink )
            then FRecordButtonLink.Free;

            If   Assigned( OwnedForm )
            then With OwnedForm do
                   begin
                   OnActivate := nil;
                   OnClick := nil;
                   OnClose := nil;
                   OnCloseQuery := nil;
                   OnCreate := nil;
                   OnDblClick := nil;
                   OnDeactivate := nil;
                   OnDestroy := nil;
                   OnDragDrop := nil;
                   OnDragOver := nil;
                   OnHide := nil;
                   OnShow := nil;
                   end;

            FDataSourceList.Free;
            FTableViewList.Free;
            end;

     except On E : Exception do ShowException( E, Self );
       end;

     FValueList.Free;

     inherited Destroy;
end;

procedure TgxFormManager.SelectFirstDataControl;

var  FocusableControl : TWinControl;

begin
     FocusableControl := nil;
     If   Assigned( FFirstDataControl )
     then try

            FFirstDataControl.Show;
            With OwnedForm do
              begin

              If   ( FFirstDataControl is TcxPageControl ) and Assigned( TcxPageControl( FFirstDataControl ).ActivePage )
              then FocusableControl := FindNextFormControl( TcxPageControl( FFirstDataControl ).ActivePage )
              else If   FFirstDataControl.CanFocus
                   then FocusableControl := FFirstDataControl
                   else FocusableControl := FindNextFormControl( FFirstDataControl );

              GFocusedControl := FocusableControl;
              FocusableControl.SetFocus;
              end;

          finally

            {
              Si se ha llamado a SelectFirstKeyControl durante el SetFocus anterior, se debe cancelar todo proceso posterior.
              Lo de aplicar el focus a GFocusedControl -que es el control activado desde SelectFirstKeyControl- es porque
              cuando se está en medio de un proceso de asignación del focus de otro componente éste no se aplica.
            }

            If   FocusableControl<>GFocusedControl
            then begin
                 If   Assigned( GFocusedControl ) and GFocusedControl.CanFocus and ( Application.MainForm.ActiveMDIChild=GFocusedControl.Owner )
                 then GFocusedControl.SetFocus;
                 Abort;
                 end
            else If   not FocusableControl.CanFocus  //* 04.02.2010  Por cambios en el orden de aplicación de los eventos hay que comprobar si si ha desactivado el control despues de intentar fijar el focus
                 then begin
                      GFocusedControl := FindNextFormControl( FFirstDataControl );
                      GFocusedControl.SetFocus;
                      end;
            end;
end;

procedure TgxFormManager.SelectFirstKeyControl( SetEditMode : Boolean = False );

var  FocusableControl : TWinControl;

begin
     FocusableControl := nil;
     If   Assigned( FFirstKeyControl )
     then begin

          With OwnedForm do
            If   Enabled    // En algunos casos desactivo el form temporalmente (pe a_ast)
            then try

                   If   FFirstKeyControl.CanFocus
                   then FocusableControl := FFirstKeyControl
                   else FocusableControl := FindNextFormControl( FFirstKeyControl );
                   If   Assigned( FocusableControl )
                   then begin
                        GFocusedControl := FocusableControl;
                        FocusableControl.SetFocus;
                        If   ( FocusableControl is TcxCustomEdit )
                        then With TcxCustomEdit( FocusableControl ) do
                               begin
                               If   SetEditMode
                               then begin
                                    DoEditing;
                                    EditModified := True;
                                    end
                               else DataBinding.UpdateDisplayValue;
                               SelectAll;
                               end;
                        end;
                 finally
                   If   FocusableControl<>GFocusedControl
                   then begin
                        If   Assigned( GFocusedControl ) and GFocusedControl.CanFocus and ( Application.MainForm.ActiveMDIChild=GFocusedControl.Owner )
                        then GFocusedControl.SetFocus;
                        Abort;
                        end;
                   end;
          end
     else If   Model=fmPersistentInputForm
          then SelectFirstDataControl;
end;

procedure TgxFormManager.Loaded;
begin
     inherited Loaded;
     If   FModel=fmInputForm
     then UpdateModel;  // Para que se ejecute incluso cuando es el valor por defecto
end;

procedure TgxFormManager.DisableDataSources;
begin
     For var Datasource in FDataSourceList do
       If   Datasource.Dataset is TnxDataset   // Solo afecta a los tablas de la base de datos, no a los TgxMemData (por ejemplo)
       then With Datasource do
              begin
              Tag := Enabled.ToInteger;        // Guardo en Tag el estado actual del dataset, por si quiero reponerlo luego
              Enabled := False;
              end;
end;

procedure TgxFormManager.EnableDataSources( OnlyIfWasEnabled : Boolean = False );

var  IDataset : InxeDataset;

begin
     For var Datasource in FDataSourceList do
       If   Datasource.Dataset is TnxDataset
       then begin
            If   not( ( Datasource.Tag=0 ) and OnlyIfWasEnabled )
            then begin

                 {  Los datasets, aunque han sido previamente cerrados, se suelen abrir al asignarles un TnxeDatasetFields en los InitializeForm.
                    En el caso de que tengan un MasterSource y el MasterRange se aplique en la llamada a la función OnApplyMasterRange el rango no está inicializado. }

                 If   Datasource.Dataset.Active
                 then begin
                      Datasource.Dataset.GetInterface( InxeDataset, IDataset );
                      If   Assigned( IDataset )
                      then If   Assigned( IDataset.OnApplyMasterRange )
                           then IDataset.OnApplyMasterRange( Datasource.Dataset )
                           else IDataset.ApplyMasterRange;
                      end;
                 Datasource.Enabled := True;
                 end;
            end;
end;

procedure TgxFormManager.Setup;

var   Component : TComponent;
      I : SmallInt;
      FormDataSet : TDataSet;
      IDataset : InxeDataset;

begin

     If   not IsDesignTime
     then begin

          If   Assigned( FBeforeSetup )
          then FBeforeSetup;

          If   Assigned( FOnGetAccessLevel )
          then begin
               FAccessLevel := FOnGetAccessLevel;
               If   FAccessLevel=0
               then begin
                    ShowNotification( ntStop, RsgMsg431 );
                    Abort;
                    end;
               end
          else FAccessLevel := 1;   // Acceso permitido y completo

          For Component in OwnedForm do
            If   Component is TgBitBtn
            then begin
                 With TgBitBtn( Component ) do
                   If   ModalResult in [ mrOk, mrCancel, mrAbort ]
                   then begin
                        case ModalResult of
                          mrOk,
                          mrCancel : begin
                                     If   ModalResult=mrOk
                                     then FOkButton := TgBitBtn( Component )
                                     else begin
                                          FCloseButton := TgBitBtn( Component );
                                          FCloseButton.Cancel := True;
                                          end;
                                     If   ( FModel<>fmEditForm ) and ( Assigned( FOkButton ) and ( Assigned( FCloseButton ) and not FCloseButton.Default ) )
                                     then FOkButton.Default := True;
                                     end;
                          mrAbort  : FDeleteButton := TgBitBtn( Component );
                          end;
                        OnClick := DoButtonPressed;
                        end
                   else If   ( GlyphBitmap=gmWarning ) and ( ModalResult=mrIgnore ) and ( Caption='' )
                        then FWarningButton := TgBitBtn( Component );  // Solo uno por TgxForm
                  end
            else If   Component is TgxEditPanel
                 then begin
                      var EditPanel := TgxEditPanel( Component );
                      case EditPanel.PanelKind of
                        epKeyPanel       : FKeyPanel := EditPanel;
                        epDataPanel,
                        epInputPanel     : FDataPanel := EditPanel;
                        epButtonsPanel   : FButtonsPanel := EditPanel;
                        end;
                      end
                 else If   Component is TgxLockRangeButton
                      then begin
                           FLockRangeButton := TgxLockRangeButton( Component );   // Solo uno por TForm
                           FLockRangeButton.FFormManager := Self;
                           end
                      else If   Component is TDataSource
                           then begin
                                var DataSource := Component as TDataSource;
                                If   Assigned( DataSource.DataSet )
                                then begin
                                     FDataSourceList.Add( DataSource );
                                     If   FModel=fmReportForm
                                     then If   DataSource.Dataset is TgxMemData
                                          then FMemDataSetDataSource := DataSource;
                                     end;
                                end
                           else If   Component is TcxGridDBTableView
                                then FTableViewList.Add( TTableViewListItem.Create( TcxGridDBTableView( Component ) ) )
                                else If   Component is TcxDBRichEdit
                                     then With TcxDBRichEdit( Component ) do
                                            begin
                                            Hint := HintMsg62;
                                            Properties.PlainText := False;
                                            end
                                     else If   Component is TcxPageControl
                                          then FHasScrollableControls := True;

          If   Assigned( FKeyPanel )
          then begin

               FOnKeyPanelEnter := FKeyPanel.OnEnter;
               FKeyPanel.OnEnter := DoOnKeyPanelEnter;
               FOnKeyPanelMouseDown := FKeyPanel.OnMouseDown;
               FKeyPanel.OnMouseDown := DoOnKeyPanelMouseDown;

               If   Assigned( FRelatedDocsMenu )
               then With FKeyPanel do
                      begin
                      PopupMenu := FRelatedDocsMenu;
                      Hint := HintMsg64;
                      end;

               With FKeyPanel do
                 For I := 0 to ControlCount - 1 do
                   If   Controls[ I ] is TcxLabel
                   then With TcxLabel( Controls[ I ] ) do
                          begin
                          If   Assigned( FRelatedDocsMenu )
                          then begin
                               PopupMenu := FRelatedDocsMenu;
                               Hint := HintMsg64;
                               end;
                          OnMouseDown := DoOnKeyPanelMouseDown;
                          end;

               end;

          If   Assigned( FDataPanel )
          then begin
               FOnDataPanelEnter := FDataPanel.OnEnter;
               FDataPanel.OnEnter := DoOnDataPanelEnter;
               end;

          If   Assigned( FButtonsPanel )
          then begin
               FOnButtonsPanelEnter := FButtonsPanel.OnEnter;
               FButtonsPanel.OnEnter := DoOnEnterButtonsPanel;
               FButtonsPanel.OnResize:= DoOnResizeButtonsPanel;
               end;

          // Las nuevas ventanas utilizan <Esc> de una forma más sutil

          If   Assigned( FCloseButton ) and ( ( FKeyPanel is TgxEditPanel ) or ( FDataPanel is TgxEditPanel ) )
          then FCloseButton.Cancel := False;

          // Desactivo todos los DataSources para evitar la actividad en los componentes hasta que esté todo inicializado

          DisableDataSources;

          If   FModel=fmEditForm
          then begin

               If   Assigned( FTable )
               then begin

                    FReadOnlyDataset := FTable.ReadOnly or ( FAccessLevel=2 );
                    If   FReadOnlyDataset
                    then begin
                         FTable.Close;
                         FTable.ReadOnly := True;
                         FTable.Options := FTable.Options + [ dsoOptimisticLocks ];
                         end;

                    FRecordButtonLink := TRecordButtonLink.Create( Self );

                    FTable.TimeOut := LockEditTimeOut;
                    FTable.OnPostError := DoOnTablePostError;
                    FTable.FireEditionEvents := True;

                    // Ajusto el ReadOnly y activo los eventos de edición de todos los datasets del Form con datasource asociado

                    For var Datasource in FDataSourceList do
                      begin
                      FormDataSet := Datasource.DataSet;
                      If   Assigned( FormDataSet )
                      then If   FormDataSet=FTable
                           then FDataSource := Datasource
                           else If   FormDataset is TgxMemData
                                then FormDataset.Open
                                else begin
                                     FormDataSet.GetInterface( InxeDataset, IDataset );
                                     If   Assigned( IDataset )
                                     then begin
                                          IDataset.FireEditionEvents := True;
                                          If   FReadOnlyDataset
                                          then begin
                                               var WasOpen := FormDataSet.Active;
                                               FormDataSet.Close;
                                               IDataset.ReadOnly := True;
                                               If   WasOpen
                                               then FormDataSet.Open;
                                               end;
                                          end;
                                     end;
                      end;

                    FTable.Open;

                    end
               else raise Exception.Create( RsgMsg521 );

               UpdateButtonsState;

               end
          else If   FModel=fmReportForm
               then begin

                    If   Assigned( FButtonsPanel ) and not ApplicationContainer.TDI
                    then begin
                         FLockWindowButton := TcxButton.Create( OwnedForm );
                         If   Assigned( FLockWindowButton )
                         then With FLockWindowButton do
                                begin
                                Parent := FButtonsPanel;
                                Left := FButtonsPanel.Width  - 30;
                                Top := ( FButtonsPanel.Height div 2 ) - 10;
                                Anchors := [ akBottom, akRight ];
                                Width := 22;
                                Height := 22;
                                SpeedButtonOptions.CanBeFocused := False;
                                SpeedButtonOptions.Flat := True;
                                SpeedButtonOptions.Transparent := True;
                                OptionsImage.Glyph.Assign( ApplicationForms.ImageCollection.Items[ 8 ].Picture.Graphic );
                                OptionsImage.NumGlyphs := 4;
                                AllowAllUp := True;
                                GroupIndex := 1;
                                ShowHint := True;
                                Hint := HintMsg5;
                                OnClick := DoLockWindowClick;
                                end;
                         end;

                    end;

          OwnedForm.CloseWindowWhenFocusLost := OwnedForm.CloseWindowWhenFocusLost or ( FModel in [ fmInputForm, fmReportForm ] );

          If   Assigned( FAfterSetup )
          then FAfterSetup;

          end;

end;

procedure TgxFormManager.SetShowQueryOption( const Value : Boolean );
begin
     If   csLoading in ComponentState
     then FShowQueryOptionPending := Value
     else If   ( Value<>FShowQueryOption ) or FShowQueryOptionPending
          then begin
               FShowQueryOptionPending := False;
               If   not IsDesignTime
               then begin
                    If   Value
                    then begin
                         If   not Assigned( FGridOutputFrame )
                         then begin
                              FGridOutputFrame := TGridOutputFrame.Create( OwnedForm );
                              AddOptionPanelFrame( FGridOutputFrame );
                              With FGridOutputFrame.GridOutputCtrl do
                                begin
                                DataBinding.DataSource := MemDataSetDataSource;
                                DataBinding.DataField := GridOutputFieldName;
                                Properties.OnEditValueChanged := DoShowQueryClick;
                                If   Assigned( FFirstDataControl )
                                then Width := FFirstDataControl.Left - FGridOutputFrame.Left + ScaledToCurrent( 12 );
                                end;
                              FGridOutputCtrl := FGridOutputFrame.GridOutputCtrl;
                              end;
                         end
                    else If   Assigned( FGridOutputCtrl )
                         then FGridOutputCtrl.PostEditValue( False );
                    If   Assigned( FGridOutputFrame )
                    then ShowOptionPanelFrame( FGridOutputFrame, Value );
                    end;
               end;
     FShowQueryOption := Value;
end;

procedure TgxFormManager.LockGridOutputFrame;
begin
     If   Assigned( FGridOutputFrame )
     then FGridOutputFrame.Enabled := False;
end;

function TgxFormManager.GetOptionsPanel : TdxPanel;
begin
     If   not Assigned( FOptionsPanel )
     then If   Assigned( FDataPanel )
          then begin
               FOptionsPanel := TdxPanel.Create( FOwnedForm );
               With FOptionsPanel do
                 begin
                 Frame.Borders := [ bTop ];
                 Height := ScaledToCurrent( 6 );
                 Top := DataPanel.Height;    // Me aseguro de que se coloque al final
                 Align := alBottom;
                 Parent := DataPanel;
                 end;
               end;
     Result := FOptionsPanel;
end;

procedure TgxFormManager.AddOptionPanelFrame( OptionFrame : TFrame );
begin
     If   Assigned( OptionsPanel )
     then ShowOptionPanelFrame( OptionFrame, True );
end;

procedure TgxFormManager.ShowOptionPanelFrame( OptionFrame : TFrame;
                                               Value       : Boolean );
var  Hv : SmallInt;

begin
     If   OptionFrame.Visible<>Value
     then begin

          Hv := IntSign( OptionFrame.Height, Value );
          OwnedForm.Height := OwnedForm.Height + Hv + ScaledToCurrent( 6 ); // Dejo un poco de margen superior
          FOptionsPanel.Height := FOptionsPanel.Height + Hv + IntSign( ScaledToCurrent( 6 ), Value );
          Inc( FOptionsFramesCount, IntSign( 1, Value ) );
          FOptionsPanel.Visible := FOptionsFramesCount>0;

          OptionFrame.Height := ScaledToCurrent( DefaultOptionFrameHeight );
          OptionFrame.AlignWithMargins := False;
          OptionFrame.Top := FOptionsPanel.Height;  // Al final
          OptionFrame.Parent := FOptionsPanel;
          OptionFrame.Align := alTop;
          OptionFrame.HandleNeeded;
          OptionFrame.Visible := Value;

          PlaceForm( OwnedForm );
          end;
end;

procedure TgxFormManager.DoOnTablePostError(     DataSet : TDataSet;
                                                 E       : EDatabaseError;
                                             var Action  : TDataAction );
begin
     With FTable do
       begin
       If   E is EnxDatabaseError
       then If   EnxDatabaseError( E ).ErrorCode=DBIERR_KEYVIOL
            then begin
                 ShowNotification( ntStop, RsMsg51, RsMsg52 );
                 Cancel;
                 SelectFirstKeyControl;
                 Action := daAbort;
                 Exit;
                 end;
       DoOnDefaultError( Dataset, E, Action );
       end;
end;

procedure TgxFormManager.Notification( AComponent : TComponent; Operation : TOperation );
begin
     inherited Notification( AComponent, Operation );
     If   Operation=opRemove
     then begin
          If   AComponent=FFirstKeyControl
          then FFirstKeyControl := nil
          else If   AComponent=FFirstDataControl
               then FFirstDataControl := nil
               else If   AComponent=FDataset
                    then FDataset := nil
                    else If   AComponent=FBrowseTable
                         then FBrowseTable := nil
                         else If   AComponent=FRelatedDocsMenu
                              then FRelatedDocsMenu := nil;
          end;
end;

procedure TgxFormManager.FormCreate( Sender : TObject );
begin

     If   not IsDesignTime
     then try

            With OwnedForm do
              begin
              ReferencePtr := CurrentFormReference;

              If   Assigned( Application.MainForm )
              then begin
                   If   FModel=fmReportForm
                   then Icon := ApplicationForms.ListingIcon.Picture.Icon
                   else Icon := ApplicationForms.EditIcon.Picture.Icon;
                   SendMessage( Handle, WM_SETICON, ICON_BIG , Icon.Handle );
                   end;

              end;

            DoCreateForm;

            If   DatabaseUpdateRequested
            then Abort
            else begin

                 If   FModel=fmEditForm
                 then begin

                      If   Assigned( FTable )
                      then With FTable do
                             begin
                             DisableControls;
                             If   ( FormTableState=dsBrowse ) and not FormValuesIsEmpty
                             then FormTableState := dsSetKey;
                             end;

                      end
                 else If   Assigned( FMemDataset )
                      then begin

                           // Si es una ventana de reports voy a añadir el campo de selección de informes y el de salida por rejilla

                           FMemDataSet.Close;  // Por si acaso

                           If   FModel=fmReportForm
                           then begin

                                FReportListField := TStringField.Create( FMemDataSet );
                                With FReportListField do
                                  begin
                                  FieldName := ReportListFieldName;
                                  Size := 80;
                                  DataSet := FMemDataSet;
                                  end;

                                FGridOutputField := TBooleanField.Create( FMemDataSet );
                                With FGridOutputField do
                                  begin
                                  FieldName := GridOutputFieldName ;
                                  DataSet := FMemDataSet;
                                  end;

                                end;

                           With FMemDataset do
                             begin
                             DisableControls;
                             try
                               Open;
                               Append;
                             finally
                               EnableControls;
                               end;
                             end;

                           end;

                 DoInitializeForm;

                 ExecComponentProcedures( OwnedForm.ID, imOnCreateComponent );

                 end;

               except on E : Exception do
                 begin

                 try
                   If   Assigned( OwnedForm )
                   then OwnedForm.ReferencePtr := nil;     // basta con esto para que CreateForm considere el TForm no válido
                 except
                   end;

                 ShowException( E, Self );
                 Abort;
                 end;

               end;

end;

procedure TgxFormManager.FormDestroy( Sender : TObject );
begin

     If   not IsDesignTime
     then try

            ExecComponentProcedures( OwnedForm.ID, imOnDestroyComponent );

            //* 10.07.2004  Forma parte del sistema de ventanas vinculadas

            LinkedFormsList.ReleaseTargets( OwnedForm );

            DoDestroyForm;

            If   Assigned( FOwnedForm ) and ( FOwnedForm.FormStyle=fsMDIChild )
            then DisableForm;

            If   FModel in [ fmInputForm, fmReportForm ]
            then If   Assigned( ApplicationContainer.OnEndProgression )
                 then ApplicationContainer.OnEndProgression;

            CleanFormReference( OwnedForm );

            FOwnedForm := nil;

          except On E : Exception do
            ShowNotification( ntStop, RsgMsg123, E.Message );
            end;
end;

procedure TgxFormManager.DoBringToFront( Sender: TObject );
begin
     If   Assigned( OwnedForm )
     then OwnedForm.BringToFront;
end;

function  TgxFormManager.GetOwnedFormActive : Boolean;
begin
     Result := FOwnedFormActive;
end;

procedure TgxFormManager.SetOwnedFormActive( const Value : Boolean );
begin
     If   Value<>FOwnedFormActive
     then begin
          If   Value
          then begin
               ActiveFormManager := Self;
               ActiveRecordButtonLink := FRecordButtonLink;
               end
          else begin
               ActiveFormManager := nil;
               ActiveRecordButtonLink := nil;
               end;
          FOwnedFormActive := Value;
          end;
end;

procedure TgxFormManager.SetDataAreaFocused( const Value : Boolean );
begin
     If   Value<>FDataAreaFocused
     then begin
          If   FModel=fmPersistentInputForm
          then begin
               If   Value   // Se está intentando salir del área de clave
               then If   Assigned( FDataset )
                    then ValidateDataArea( faKey );
               end;
          FDataAreaFocused := Value;
          If   Assigned( FOnFocusedAreaChanged )
          then FOnFocusedAreaChanged;
          end;
end;

procedure TgxFormManager.DoLockWindow;
begin
     If   Assigned( FLockWindowButton )
     then FLockWindowButton.Down := not FLockWindowButton.Down;
end;

procedure TgxFormManager.DoLockWindowClick( Sender : TObject );
begin
     OwnedForm.FCloseWindowWhenFocusLost := not FLockWindowButton.Down;
end;

procedure TgxFormManager.DoShowQueryClick( Sender : TObject );
begin
     If   Assigned( FReportListCtrl )
     then ReportListCtrl.Enabled := not FGridOutputCtrl.Checked;
     If   Assigned( FOnShowQueryButtonClick )
     then FOnShowQueryButtonClick( Sender );
end;

procedure TgxFormManager.DoReadWindowParams;
begin
     // Recuperando el estado de la ventana
     // Si se pulsa <Shift> no se recupera el estado de la ventana y se borra la configuración existente

     If   IsKeyPressed( VK_SHIFT )
     then ApplicationContainer.DeleteWindowState( OwnedForm )
     else begin
          ApplicationContainer.ReadWindowState( OwnedForm, FValueList );
          If   Assigned( FOnReadWindowParams )
          then FOnReadWindowParams;
          If   FModel in [ fmInputForm, fmPersistentInputForm, fmReportForm ]
          then If   Assigned( FDataset ) and ( FValueList.Count>0 )
               then SetDatasetValues( FDataset, FValueList, OwnedForm );
          end;

end;

function TgxFormManager.GetValueFromList( Name      : String;
                                          DefValue  : Variant ) : Variant;

begin
     var Value := FValueList.Values[ Name ];
     If   Value=''
     then Result := DefValue
     else Result := Value;
end;


procedure TgxFormManager.DoSaveWindowParams( Option : TSaveWndParamsOption );

var  Correct : Boolean;
     EditControl : TcxCustomEdit;

begin
     Correct := False;

     If   not ( csDestroying in OwnedForm.ComponentState )
     then begin
          EditControl := nil;
          If   Option in [ wpFields, wpAll, wpOneField ]
          then begin
               EditControl := GetEditControl( OwnedForm.ActiveControl );
               If   Assigned( EditControl )
               then EditControl.PostEditValue;
               {
               If   Assigned( FOkButton ) and ( FOkButton.Enabled )
               then FOkButton.SetFocus;
               }
               end;

          If   Assigned( FOnSaveWindowParams )
          then Correct := FOnSaveWindowParams( Option )
          else case Option of
                 wpFields,
                 wpAll      : begin
                              FValueList.Clear;
                              GetDatasetValues( FDataset, FValueList );
                              Correct := ApplicationContainer.SaveWindowState( OwnedForm, FValueList, Option=wpAll );
                              If   Correct
                              then AddAllBlueMarks;
                              end;

                 wpOneField : If   Assigned( EditControl )
                              then begin
                                   Correct := ApplicationContainer.SaveFieldContent( OwnedForm, EditControl, FValueList );
                                   If   Correct
                                   then AddBlueMark( EditControl );
                                   end;

                 wpLayout   : Correct := ApplicationContainer.SaveWindowState( OwnedForm, nil, True );

                 wpDelete   : begin
                              Correct := ApplicationContainer.DeleteWindowState( OwnedForm );
                              If   Correct
                              then begin
                                   RemoveAllBlueMarks;
                                   FValueList.Clear;
                                   end;
                              end;
                 end;

          If   Correct
          then begin
               If   Option=wpDelete
               then ShowHintMsg( RsMsg25, RsMsg26, nil, ntCorrect )
               else ShowHintMsg( RsMsg21, RsMsg22, nil, ntCorrect );
               end
          else ShowHintMsg( RsMsg23, RsMSg24, nil );

          end;
end;

procedure TgxFormManager.DoInitializeForm;
begin
     If   Assigned( FOnInitializeForm )
     then FOnInitializeForm;
end;

procedure TgxFormManager.DoCreateForm;
begin
     If   Assigned( FOnCreateForm )
     then FOnCreateForm;
end;

procedure TgxFormManager.DoDestroyForm;
begin
     If   Assigned( FOnDestroyForm )
     then FOnDestroyForm;
end;

procedure TgxFormManager.DoAfterDestroyForm;
begin
     If   Assigned( FAfterDestroyForm )
     then FAfterDestroyForm;
end;

procedure TgxFormManager.DoHideForm;
begin
     If   Assigned( FOnHideForm )
     then FOnHideForm;
end;

procedure TgxFormManager.DoShowForm;
begin
     If   Assigned( FOnShowForm )
     then FOnShowForm;
end;

procedure TgxFormManager.DoPreparedForm;
begin
     If   Assigned( FOnPreparedForm )
     then FOnPreparedForm;
end;

procedure TgxFormManager.DoDeactivateForm( ChildProcess : Boolean = False );
begin
     If   Assigned( FOnDeactivateForm )
     then FOnDeactivateForm( ChildProcess );
end;

procedure TgxFormManager.DoActivateForm;
begin
     If   Assigned( FOnActivateForm )
     then FOnActivateForm;
end;

function TgxFormManager.getName : TComponentName;
begin
     Result := inherited name;
end;

procedure TgxFormManager.SetName( const NewName : TComponentName );
begin
     inherited SetName( FormManagerName );
end;

procedure TgxFormManager.SetModel( const Value : TFormManagerModel );
begin

     case Value of
       fmInputForm           : ;
       fmReportForm          : ;
       fmEditForm            : // Estos paneles son indispensables para la gestión de este tipo de ventanas
                               If   Assigned( FTable )
                               then If   not Assigned( FKeyPanel  ) or
                                         not Assigned( FDataPanel )
                                    then raise Exception.Create( RsMsg14 );
       end;

     FModel := Value;

end;

procedure TgxFormManager.UpdateModel;
begin
     SetModel( FModel );
end;

procedure TgxFormManager.SetDataset( const Value : TDataset );
begin

     If   Value<>FDataset
     then begin

          If   not IsDesignTime
          then begin

               If   Assigned( FTable )
               then With FTable do
                      begin
                      OnDataEvent := nil;

                      BeforeEdit := FTableBeforeEdit;
                      AfterEdit := FTableAfterEdit;
                      BeforeInsert := FTableBeforeInsert;
                      AfterDelete := FTableAfterDelete;
                      AfterCancel := FTableAfterCancel;
                      OnGetRecord := FTableOnGetRecord;
                      OnNewRecord := FTableOnNewRecord;

                      SetDefaultErrorManager;
                      end;

               FTable := nil;
               FMemDataset := nil;

               If   Assigned( Value )
               then begin

                    If   Value is TnxeTable
                    then begin
                         FTable := TnxeTable( Value );
                         With FTable do
                            begin

                            OnDataEvent := TableDataEvent;

                            FTableBeforeEdit := BeforeEdit;
                            BeforeEdit := DoTableBeforeEdit;

                            FTableAfterEdit := AfterEdit;
                            AfterEdit := DoTableAfterEdit;

                            FTableBeforeInsert := BeforeInsert;
                            BeforeInsert := DoTableBeforeInsert;

                            FTableAfterDelete := AfterDelete;
                            AfterDelete := DoTableAfterDelete;

                            FTableAfterCancel := AfterCancel;
                            AfterCancel := DoTableAfterCancel;

                            FTableOnGetRecord := OnGetRecord;
                            OnGetRecord := DoTableOnGetRecord;

                            FTableOnNewRecord := OnNewRecord;
                            OnNewRecord := DoTableOnNewRecord;

                            OnEditError := DoOnDefaultTableEditError;
                            end;
                         end
                    else If   Value is TgxMemData
                         then FMemDataset := TgxMemData( Value );

                    end;

               end;

          FDataset := Value;
          end;
end;

procedure TgxFormManager.FieldSetStructChanged;
begin
end;

procedure TgxFormManager.CheckDatasetStateChange;

var  NotificationShowed : Boolean;

begin
     If   not FReadOnlyDataset
     then begin
          var WasEditing := FTable.Editing;
          If   WasEditing
          then begin

               NotificationShowed := False;
               If   ( FTable.State=dsEdit ) and FTable.Modified
               then begin
                    NotificationShowed := True;
                    If   ShowNotification( ntQuestionWarning, RsMsg12, RsMsg13 )<>mrYes
                    then begin
                         SelectFirstDataControl;
                         Abort;
                         end;
                    end
               else If   FTable.State=dsInsert
                    then begin
                         NotificationShowed := True;
                         If   ShowNotification( ntQuestionWarning, RsMsg45, RsMsg46 )<>mrYes
                         then begin
                              SelectFirstDataControl;
                              Abort;
                              end;
                         end;

               CheckDetailRecords( { Posting } False, NotificationShowed );

               FTable.Cancel;

               // Compruebo si el registro en el que estoy posicionado es válido

               If   WasEditing and ( FTable.RecordCount<>0 )
               then FTable.CheckRecord;

               end;

          end;
end;

function TgxFormManager.CheckDetailRecords( Posting            : Boolean = False;
                                            NotificationShowed : Boolean = False ) : Boolean;
begin
     Result := False;
     If   Assigned( FTable )
     then If   FTable.Editing
          then If   not FTable.CheckDetailDatasets( Posting )
               then If   ( FTable.State in [ dsEdit, dsInsert ] ) and
                         ( not NotificationShowed and ( ShowNotification( ntQuestionWarning, RsMsg28, RsMsg29 )<>mrYes ) )
                    then begin
                         SelectFirstDataControl;
                         Abort;
                         end
                    else begin
                         If   Assigned( FOnDeleteEmptyHeader )
                         then FOnDeleteEmptyHeader( FTable );
                         FTable.Delete;
                         SelectFirstKeyControl;
                         Abort;
                         end;
end;

procedure TgxFormManager.DoOnKeyPanelMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
begin
     SelectFirstKeyControl;
     If   Assigned( FOnKeyPanelMouseDown )
     then FOnKeyPanelMouseDown( Sender, Button, Shift, X, Y );
end;

procedure TgxFormManager.DoOnResizeButtonsPanel(Sender: TObject);
begin
     If   ( FButtonsPanel.ControlCount>0 ) and
          ( FButtonsPanel.Controls[ 0 ] is TcxGroupBox )
     then FButtonsPanel.Controls[ 0 ].Left := ( FButtonsPanel.Width - FButtonsPanel.Controls[ 0 ].Width ) div 2;
end;

procedure TgxFormManager.DoOnKeyPanelEnter( Sender : TObject );
begin

     If   FKeyPanelFocusCanceled
     then begin
          FKeyPanelFocusCanceled := False;
          Exit;
          end;

     DataAreaFocused := False;
     If   Assigned( FTable ) and not FFocusingDataPanel
     then With FTable do
            try
              FFocusingKeyPanel := True;
              case FModel of
                fmInputForm           : ;
                fmReportForm          : ;
                fmEditForm            :
                                        //* 26.02.2009  He diferido el procesamiento de la entrada en el KeyPanel mediante un PostMessage porque
                                        //              había algun que otro problema con el focus cuando el usuario seleccionaba directamente un control del
                                        //              área de clave y se mostraba un ShowNotification (el proceso se interrumpe en medio de un SetFocusedControl).

                                        If   not FPostingKeyPanelEnterMsg and
                                             not FShowingForm and
                                             Editing
                                        then begin
                                             PostMessage( KeyPanel.WindowHandle, CM_Enter, 0 , 0 );
                                             FPostingKeyPanelEnterMsg := True;
                                             Exit;
                                             end
                                        else begin
                                             FPostingKeyPanelEnterMsg := False;
                                             EnableAutoEdit( True );
                                             CheckDatasetStateChange;


                                             //* 26.02.2009 Puesto que he diferido el OnEnter del panel y el control no estaba en la misma situación (estado de las tablas, los botones activos del toolbar, etc..)
                                             //             cuando ganó el focus, hay que actualizarlo.

                                             With OwnedForm do
                                               If   Assigned( ActiveControl )
                                               then begin
                                                    SelectEditControl( ActiveControl );
                                                    SetActiveEditControl( ActiveControl );
                                                    end;

                                             UpdateButtonsState;
                                             DoOnUpdateState;
                                             end;

                fmPersistentInputForm : ;
                end;
            finally
              FFocusingKeyPanel := False;
              end;

     If   Assigned( FOnKeyPanelEnter )
     then FOnKeyPanelEnter( Sender );

end;

function TgxFormManager.ReloadRecord( DisableCtrls : Boolean = False ) : Boolean;
begin
     Result := False;
     If   Assigned( FTable )
     then Result := FTable.ReloadRecord( DisableCtrls  );
end;

procedure TgxFormManager.DoOnDataPanelEnter( Sender : TObject );

var  RecordFound : Boolean;

begin

     If   not DataAreaFocused
     then begin

          DataAreaFocused := True;
          If   Assigned( FTable )
          then With FTable do
                 try
                   FFocusingDataPanel := True;
                   case FModel of
                     fmInputForm           : ;
                     fmReportForm          : ;
                     fmEditForm            : try
                                               If   FPostingKeyPanelEnterMsg
                                               then FKeyPanelFocusCanceled := True;
                                               ValidateDataArea( faKey, True );
                                               case State of
                                                 dsSetKey : try

                                                              CheckNullIndexValues;
                                                              DoOnSetKey;

                                                              FieldIndexValues := GetFieldIndexValues;
                                                              RecordFound := GotoKeyValues( FieldIndexValues );

                                                              FireEditionEvents := False;

                                                              If   not FReadOnlyDataset
                                                              then If   RecordFound
                                                                   then begin
                                                                        DoOnReadRecord;
                                                                        FEditAllowed := not ControlKey and CanEdit and CanEditRecord and not FBrowseOnlyDataset;
                                                                        EnableAutoEdit( FEditAllowed );
                                                                        If   FEditAllowed
                                                                        then Edit
                                                                        else Browse;
                                                                        end
                                                                   else If   CanInsert
                                                                        then try
                                                                               Append;
                                                                               DoOnReadRecord;
                                                                               EnableAutoEdit( True );

                                                                               If   FValueList.Count>0
                                                                               then SetDatasetValues( FTable, FValueList, OwnedForm );

                                                                             finally

                                                                               //* 13.02.2010  Si se cancela la inserción en el bloque anterior no hay que seguir con el proceso

                                                                               If   Editing
                                                                               then ValidateDataArea( faData, False, True )
                                                                               else DoOnUpdateState;

                                                                               end
                                                                        else begin
                                                                             ShowHintMsg( RsgMsg381, RsgMsg446 );
                                                                             SetKey;
                                                                             SetFieldIndexValues( FieldIndexValues );
                                                                             SelectFirstKeyControl;
                                                                             end;

                                                              If   Assigned( FKeyPanel )
                                                              then FKeyPanel.UpdateStateImage;

                                                            finally
                                                              FireEditionEvents := True;
                                                              end;

                                                 dsBrowse : try

                                                              // FireEditionEvents := False;

                                                              //* 05.05.2009  Vuelvo a leer el registro por si ha cambiado
                                                              //* 25.01.2011  Si el rango ha sido restaurado es porque el registro pertenece a otro ejercicio.
                                                              //              Aun así hay que volver a leer por si ha sido suprimido o ha sido modificado (por ejemplo)

                                                              // Es necesario releer las líneas de los registros con cabecera/lineas aunque parezca una repetición innecesaria
                                                              // porque el contenido de las mismas puede haber cambiado y eso puede afectar al estado general del registro.
                                                              // Por ejemplo, en los pedidos exportados a un albarán, si se tienen ambos mantenimiento abiertos y se cambia la cantidad
                                                              // recibida de una línea del albarán al volver al pedido y pulsar simplemente [Intro], no se actualiza la línea modificada.

                                                              RecordFound := ReloadRecord( { DisableCtrls } False );

                                                              FireEditionEvents := False;

                                                              If   RecordFound
                                                              then begin

                                                                   FEditAllowed := not FReadOnlyDataset and
                                                                                   not ControlKey and
                                                                                   CanEdit and
                                                                                   CanEditRecord and
                                                                                   not RangeRestored;

                                                                   EnableAutoEdit( FEditAllowed );

                                                                   // En modo FBrowseOnlyDataset no se puede editar la tabla principal, pero si las hijas

                                                                   FEditAllowed := FEditAllowed and not FBrowseOnlyDataset;

                                                                   If   FEditAllowed
                                                                   then Edit
                                                                   else Browse;

                                                                   end
                                                              else begin
                                                                   ShowHintMsg( RsgMsg381, RsgMsg446 );
                                                                   Cancel;
                                                                   SelectFirstKeyControl
                                                                   end;

                                                           finally
                                                             FireEditionEvents := True;
                                                             end;

                                                 dsInsert : If   not CanInsert
                                                            then begin
                                                                 ShowHintMsg( RsMsg35, '', nil );
                                                                 Cancel;
                                                                 end;

                                                 end;

                                               DoOnUpdateState;
                                               UpdateButtonsState;

                                             except On E : Exception do
                                               begin

                                               If   State in [ dsBrowse, dsSetKey ]
                                               then FieldIndexValues := []
                                               else FieldIndexValues := GetFieldIndexValues;

                                               If   OwnedForm.Active
                                               then begin
                                                    FFocusingDataPanel := False;  // Si no, no se validan los componentes
                                                    Browse; // Entre otras cosas, si estamos en modo dsSetKey, no se intenta guardar la clave
                                                    If   Length( FieldIndexValues )>0
                                                    then begin
                                                         SetKey;
                                                         SetFieldIndexValues( FieldIndexValues );
                                                         ValidateDataArea( faKey, False, True );
                                                         end;
                                                    end;

                                               If   Assigned( FKeyPanel )
                                               then FKeyPanel.UpdateStateImage;

                                               If   E is EnxDatabaseError
                                               then begin
                                                    ShowDatabaseError( FTable, E );
                                                    Abort;
                                                    end
                                               else raise;

                                               end;

                                             end;

                     fmPersistentInputForm : ;
                     end;
                 finally
                   FFocusingDataPanel := False;
                   end;
          end;

     If   Assigned( FOnDataPanelEnter )
     then FOnDataPanelEnter( Sender );
end;

procedure TgxFormManager.DoTableBeforeEdit( Dataset : TDataSet );
begin
     If   not DataAreaFocused
     then FTable.SettingKey := True;
     If   Assigned( FTableBeforeEdit )
     then FTableBeforeEdit( Dataset );
end;

procedure TgxFormManager.DoTableAfterEdit( Dataset : TDataSet );
begin
     try
       If   Assigned( FTableAfterEdit )
       then FTableAfterEdit( Dataset );
     except
       FTable.Cancel;
       raise;
       end;
end;

procedure TgxFormManager.DoTableBeforeInsert( Dataset : TDataSet );
begin

     If   Assigned( OnEditTableBeforeInsert )
     then OnEditTableBeforeInsert( FTable );

     If   Assigned( FTableBeforeInsert )
     then FTableBeforeInsert( Dataset );
end;

procedure TgxFormManager.DoTableAfterDelete( Dataset : TDataSet );
begin
     If   Assigned( FTableAfterDelete )
     then FTableAfterDelete( Dataset );
end;

procedure TgxFormManager.DoTableAfterCancel( Dataset : TDataSet );
begin
     If   Assigned( FTableAfterCancel )
     then FTableAfterCancel( Dataset );
     If   DataAreaFocused
     then begin
          SelectFirstKeyControl;
          EnableAutoEdit( True );
          end;
end;

procedure TgxFormManager.DoTableOnGetRecord( Dataset : TDataSet );
begin
     If   Assigned( FTableOnGetRecord )
     then FTableOnGetRecord( Dataset );
end;

procedure TgxFormManager.DoTableOnNewRecord( Dataset : TDataSet );
begin
     {  Para que los valores del índice estén disponibles en la inserción
        Es particularmente útil cuando hay tablas de detalle que tienen campos calculados
        y que pueden utilizar los valores de la tabla maestra
     }
     If   FFocusingDataPanel
     then FTable.SetFieldIndexValues( FieldIndexValues );
     If   Assigned( FTableOnNewRecord )
     then FTableOnNewRecord( Dataset );
end;

procedure TgxFormManager.UpdateRelatedDocsControls;
begin
     FRelatedDocsMenuEnabled := False;
     If   Model=fmEditForm
     then If   Assigned( FOnRelatedDocsRequest ) or Assigned( FRelatedDocsMenu )
          then FRelatedDocsMenuEnabled := FKeyButtonsEnabled and ActivateRelatedDocsButton;
     If   Assigned( ApplicationContainer.RelationsButton )
     then ApplicationContainer.RelationsButton.Enabled := FRelatedDocsMenuEnabled;
     If   Assigned( FRelatedDocsMenu )
     then begin
          FRelatedDocsMenu.AutoPopup := FRelatedDocsMenuEnabled;
          If   Assigned( FKeyPanel )
          then FKeyPanel.ShowHint := FRelatedDocsMenuEnabled;
          end;
end;

procedure TgxFormManager.EnableAutoEdit( Value : Boolean );

var  I : SmallInt;

     ViewsValue : Boolean;

begin
     If   not  ( csDestroying in ComponentState )
     then begin

          If   Value<>FAutoEditEnabled
          then begin

               For var Datasource in FDataSourceList do
                 If   not ( DataSource.DataSet is TgxMemData)
                 then DataSource.AutoEdit := Value;

               ViewsValue := Value;

               If   Assigned( FOnAutoEditChanged )
               then FOnAutoEditChanged( ViewsValue );

                With FTableViewList do
                  For I := 0 to Count - 1 do
                     With TTableViewListItem( Items[ I ] ) do
                       With FTableView do
                         If   ViewsValue
                         then begin
                              OptionsData.Appending := FAppending;
                              OptionsData.Deleting := FDeleting;
                              OptionsData.Inserting := FInserting;
                              If   OptionsData.Editing  // Si la rejilla no es editable no hay por qué impedir la ordenación
                              then begin
                                   OptionsCustomize.ColumnFiltering := False;
                                   OptionsCustomize.ColumnSorting := False;
                                   DataController.Filter.Clear;
                                   DataController.ClearSorting( False );
                                   end;
                              end
                         else begin
                              OptionsData.Appending := False;
                              OptionsData.Deleting := False;
                              OptionsData.Inserting := False;
                              OptionsCustomize.ColumnSorting := True;
                              OptionsCustomize.ColumnFiltering := True;
                              end;

               FAutoEditEnabled := Value;
               end;

          end;
end;

procedure TgxFormManager.UpdateButtonsState;
begin
     If   Assigned( FTable )
     then begin
          {
          If   Assigned( FCloseButton )
          then FCloseButton.Enabled := not ( ApplicationContainer.TDI and OWnedForm.TDITabSheetForm and not FTable.Editing );
          }
          If   Assigned( FDeleteButton )
          then FDeleteButton.Enabled := DataAreaFocused and ( FTable.State=dsEdit ) and FTable.CanEditRecord and not CantDeleteRecords;
          end;

     If   Assigned( FOnUpdateButtonsState )
     then FOnUpdateButtonsState;

end;

procedure TgxFormManager.UpdateDataControls;

var  FieldArea : TFieldArea;
     UpdateData : Boolean;

begin
     With FTable do
       If   ( State in [ dsBrowse, dsEdit, dsInsert ] ) and not FFocusingDataPanel
       then begin
            UpdateData := State=dsInsert;
            If   State in [ dsEdit, dsBrowse ]
            then FieldArea := faAll
            else FieldArea := faData;
            ValidateDataArea( FieldArea, False, UpdateData );
            UpdateRelatedDocsControls;
            end;
end;

procedure TgxFormManager.TableDataEvent( Event : TDataEvent;
                                        Info  : LongInt );

var  FieldIndexValues : TFieldValuesArray;

procedure EditState;
begin
     ResetScrollableControls;
     UpdateButtonsState;
end;

procedure EditKeyState;

var  Field : TField;
     FieldName : String;

begin
     With FTable do
       If   not ControlsDisabled
       then try

              // Intento averiguar el campo que se está editando para copiar la clave solo hasta él

              FieldName := '';
              Field := GetEditControlField( OwnedForm.GetActiveEditControl );
              If   Assigned( Field )
              then FieldName := Field.FieldName;

              DisableControls;

              // Con esto trato de evitar que la edición de la clave se haga sobre un rango fijado temporalmente

              If   RangeRestored
              then Browse;

              If   RecordCount=0
              then begin
                   EditKey;
                   SetupToolbar( True );
                   end
              else begin
                   FieldIndexValues := GetFieldIndexValues;
                   Browse;
                   SetKey;
                   SetFieldIndexValues( FieldIndexValues, FieldName );
                   end;

            finally
              EnableControls;
              end;
end;

begin
     If   not Freeing and
          ( FModel=fmEditForm ) and
          not FInternalDataEvent  and
          not FTable.InternalSeekProcess and
          not FTable.UpdatingProcess and
          not FTable.ControlsDisabled
     then try
            FInternalDataEvent := True;
            With FTable do
              case Event of
                deFieldChange           : ;

                deRecordChange          : ValidateDataArea( faAll, False, False );

                deDataSetScroll,
                                          // Actualizo los valores de los controles cuando el estado es dsInsert porque el contenido
                                          // de los mismos ha podido cambiar en DoOnNewRecord

                deLayoutChange,
                deDataSetChange         : UpdateDataControls;

                deUpdateRecord          : If   UpdatingProcess
                                          then ValidateDataArea( faAll );

                deUpdateState           : try

                                            case State of

                                              dsEdit   : If   DataAreaFocused
                                                         then EditState
                                                         else EditKeyState;

                                              dsInsert : begin

                                                         // Un caso especial : cuando el fichero está vacío, y se intenta editar la clave, el Dataset inserta automáticamente un registro
                                                         //                    En este caso hay que llamar a OnSetKey manualmente.

                                                         If   DataAreaFocused
                                                         then begin
                                                              If   not FFocusingDataPanel
                                                              then ValidateDataArea( faData, False, True );
                                                              end
                                                         else If   CanEdit or
                                                                   CanInsert
                                                              then EditKeyState
                                                              else begin
                                                                   ShowHintMsg( RsMsg35, '', nil );
                                                                   Cancel;
                                                                   Abort;
                                                                   end;

                                                         EditState;
                                                         end;

                                              dsBrowse : If   Assigned( FDeleteButton )
                                                         then With FDeleteButton do
                                                                begin
                                                                If   Focused and Assigned( FOkButton )
                                                                then If   OkButton.Enabled
                                                                     then OkButton.SetFocus;
                                                                Enabled := False;
                                                                end;

                                              dsSetKey : ;

                                              end;

                                          finally
                                            // EnableAutoEdit( ( State=dsSetKey) or CanEditRecord );
                                            If   Assigned( FKeyPanel )
                                            then FKeyPanel.UpdateStateImage; // Invalidate;
                                            UpdateRelatedDocsControls;
                                            end;

                deCheckBrowseMode       : ;
                dePropertyChange        : ;
                deFieldListChange       : ;
                deFocusControl          : ;
                deParentScroll          : ;
                deConnectChange         : ;
                deReconcileError        : ;
                deDisabledStateChange   : ;
                end;

          finally
            fInternalDataEvent := False;
            end;
end;

procedure TgxFormManager.DoOnDefaultTableEditError(     Dataset : TDataSet;
                                                       E       : EDatabaseError;
                                                   var action  : TDataAction );
begin
     If   Assigned( OnDatabaseError )
     then begin
          OnDatabaseError( Dataset, E );
          Action := daAbort;
          end;
     SelectFirstKeyControl;
end;

procedure TgxFormManager.ValidateDataArea( FieldArea           : TFieldArea;
                                           NotifyError         : Boolean = True;
                                           UpdateDisplayValues : Boolean = False );

var  ErrorText : TCaption;
     ErrorResult : Boolean;

begin

     ErrorResult := False;
     FInvalidCustomEdit := nil;

     If   Assigned( FBeforeValidateDataArea )
     then FBeforeValidateDataArea( FieldArea, ErrorText, ErrorResult, NotifyError, UpdateDisplayValues, FInvalidCustomEdit );

     If   not ErrorResult
     then begin

          FInvalidCustomEdit := ValidateEditControls( FieldArea, ErrorText, ErrorResult, NotifyError, UpdateDisplayValues );

          If   not ErrorResult
          then If   Assigned( FAfterValidateDataArea )
               then FAfterValidateDataArea( FieldArea, ErrorText, ErrorResult, NotifyError, UpdateDisplayValues, FInvalidCustomEdit );

          end;

     If   ErrorResult and
          NotifyError
     then begin
          case FieldArea of
            faKey  : ShowHintMsg( RsgMsg397, GetStrDef( ErrorText, RsgMsg398 ), FInvalidCustomEdit );
            faAll,
            faData : ShowHintMsg( RsgMsg396, ErrorText, FInvalidCustomEdit );
            end;
          If   Assigned( FInvalidCustomEdit )
          then begin
               SelectEditControl( FInvalidCustomEdit );
               FInvalidCustomEdit.EditModified := True;
               end;
          Abort;
          end;
end;

function TgxFormManager.ValidateEditPanel(     EditPanel           : TgxEditPanel;
                                           var ErrorText           : TCaption;
                                           var ErrorResult         : Boolean;
                                               NotifyError         : Boolean = True;
                                               UpdateDisplayValues : Boolean = False;
                                               SkipControl         : TcxCustomEdit = nil ) : TcxCustomEdit;

var  I : Integer;
     Control : TWinControl;
     EditControl : TcxCustomEdit;
     Validate : Boolean;
     TabList : TList;
     EditDisplayValue : Variant;
     TabSheet : TcxTabSheet;

begin
     Result := nil;

     If   Assigned( EditPanel )
     then begin

          If   Assigned( Dataset ) and ( not Dataset.Active or Dataset.ControlsDisabled )
          then Exit;

          TabList := TList.Create;

          try

            FValidatingFormData := True;

            EditPanel.GetTabOrderList( TabList );
            For I := 0 to TabList.Count - 1 do
              begin
              Control := TWinControl( TabList[ I ] );
              If   ( Control is TgxFilterPageControl ) and not FShowingForm
              then TgxFilterPageControl( Control ).CheckDefaultPage
              else begin

                   If   Control is TgxRelationButton
                   then EditControl := TgxRelationButton( Control ).EditSelector
                   else EditControl := GetEditControl( Control );

                   If   Assigned( EditControl )
                   then If   not ( EditControl is TcxLabel ) and not ( EditControl is TcxDBImage ) and ( EditControl<>SkipControl )
                        then If   ( ( EditControl.Enabled and EditControl.Parent.Enabled ) or
                                    ( ( EditPanel=FKeyPanel ) and ( FModel=fmEditForm ) ) or    // Los componentes del área de clave se validan siempre, estén activados o no
                                    ( evoValidateAlways in EditControl.Properties.ValidationOptions ) )
                             then begin

                                  {
                                    Cuando se muestra por primera vez se validan (sin error), luego ya no se validan
                                    las pestañas no visibles (seleccionadas) en las ventanas de procesos y listados.
                                    Tampoco hay necesidad de validar las pestañas desactivadas.

                                    Los TgxFilterPageControl requieren que se validen todas las pestañas, puesto que
                                    todas ellas pueden intervenir en el informe o proceso.

                                  }

                                  Validate := True;

                                  TabSheet := GetParentTabSheet( EditControl );
                                  If   Assigned( TabSheet )
                                  then If   ( Model in [ fmReportForm, fmInputForm ] )
                                       then Validate := ( ( TabSheet.Parent is TgxFilterPageControl ) and TabSheet.Highlighted ) or
                                                          ( TabSheet.Visible and not FShowingForm )     // Visible aquí solo indica que no es la pestaña activa, no que está desactivada
                                       else Validate := ( ( TabSheet.PageControl.TabulationCycle=tcNone ) and TabSheet.Visible ) or
                                                          ( TabSheet.PageControl.TabulationCycle<>tcNone ) and TabSheet.TabVisible and TabSheet.Enabled;

                                  If   Validate
                                  then try

                                         If   EditControl is TgxEditSelector
                                         then TgxEditSelector( EditControl ).Validate( ErrorText, ErrorResult )
                                         else begin

                                              If   UpdateDisplayValues or ( EditControl.ModifiedOnEnter and not EditControl.ModifiedAfterEnter )
                                              then EditControl.DataBinding.UpdateDisplayValue;

                                              If   EditControl is TcxDBCheckBox
                                              then begin
                                                   If   EditControl.ModifiedAfterEnter // or FShowingForm
                                                   then With TcxDBCheckBox( EditControl ).Properties do
                                                            If   Assigned( OnEditValueChanged )
                                                            then OnEditValueChanged( EditControl );
                                                   end
                                              else begin

                                                   EditDisplayValue := EditControl.DataBinding.DisplayValue;
                                                   ErrorResult := False;

                                                   If   Assigned( EditControl.ActiveProperties )
                                                   then If   ( EditControl.ActiveProperties.Required or EditControl.ActiveProperties.DefaultValuesProvider.DefaultRequired ) and ValueIsEmpty( EditDisplayValue )
                                                        then begin
                                                             EditControl.ClearDescription;
                                                             ErrorResult := True;
                                                             ErrorText := JoinMessage( RsgMsg171, RsgMsg172 );
                                                             end
                                                        else begin
                                                             ClearEditControlKeyPressed; // Lo hago para evitar que pueda ser considerada una acción del usuario
                                                             EditControl.ActiveProperties.ValidateDisplayValue( EditDisplayValue, ErrorText, ErrorResult, EditControl );
                                                             end;

                                                   end;

                                              end;

                                         If   ErrorResult
                                         then begin
                                              If   NotifyError
                                              then Abort
                                              else EditControl.IsEditValidated := False;
                                              end
                                         else EditControl.IsEditValidated := True;

                                       except
                                         EditControl.IsEditValidated := False;
                                         Result := EditControl;
                                         Exit;
                                         end

                                  else DoEditControlValidate( EditControl );

                                  end
                             else If   EditControl.EditModified     // Lo he puesto para evitar que se limpien los TgxEditSelectors cuando se valida el panel. Ya veremos los efectos colaterales.
                                  then EditControl.ClearDescription;

                   end;

              end;

          finally
            TabList.Free;
            FValidatingFormData := False;
            end;

          end;
end;

function TgxFormManager.ValidateEditControls(     FieldArea           : TFieldArea;
                                             var ErrorText           : TCaption;
                                             var ErrorResult         : Boolean;
                                                 NotifyError         : Boolean = True;
                                                 UpdateDisplayValues : Boolean = False ) : TcxCustomEdit;

begin
     Result := nil;
     If   Assigned( FKeyPanel ) and ( FieldArea in [ faKey, faAll ] )
     then Result := ValidateEditPanel( FKeyPanel, ErrorText, ErrorResult, NotifyError, UpdateDisplayValues );
     If   not Assigned( Result ) and ( FieldArea in [ faData, faAll ] )
     then Result := ValidateEditPanel( FDataPanel, ErrorText, ErrorResult, NotifyError, UpdateDisplayValues );
end;

procedure TgxFormManager.ResetScrollableControls;

var   Component : TComponent;

begin

     { Una nota con respecto a los PageControls : Cuando el FirstDataControl está en la primera página de un PageControl éste
       se resetea al ejecutarse la función SelectFirstDataControl (en el Show del control). Sin embargo lo que ésta función
       resetea (me refiero a ResetScrollableControls) son los PageControls que, formando parte de la ventana, no incluyen el
       FirstDataControl. Por ejemplo en el mantenimiento de facturas de venta del IVA hay un PageControl al pie y no incluye
       el FirstDataControl.
     }

     If   FHasScrollableControls and
          ( IsKeyPressed( VK_TAB ) or IsKeyPressed( VK_RETURN ) or FButtonProcess or FInsertingAutoIncRecord )
     then For Component in OwnedForm do
            If   Component is TcxPageControl
            then begin
                 With Component as TcxPageControl do
                   If   not ( HideTabs or ( Tag<>0 ) or ( Parent=FKeyPanel ) ) // En estos casos no se resetean
                   then begin
                        ActivePage := FindNextPage( nil, True, True );
                        ResetTab;
                        end;
                 end
            else If   Component is TScrollBox
                 then TScrollBox( Component ).VertScrollBar.Position := 0;
end;

procedure TgxFormManager.FormClick( Sender : TObject );
begin
end;

procedure TgxFormManager.FormClose( Sender : TObject; var Action : TCloseAction );
begin
     If   Assigned( FOnCloseForm )
     then FOnCloseForm( Sender, Action )
     else If   OwnedForm.FormStyle=fsMDIChild
          then begin
               If   DoCanClose
               then Action := caFree
               else Action := caNone;
               end
          else If   FormResult=mrNone
               then If   DoCanClose
                    then FormResult := mrCancel
                    else Action := caNone;

     If   Action=caFree
     then ApplicationContainer.HideHintPanel;

end;

procedure TgxFormManager.FormCloseQuery ( Sender : TObject; var CanClose : Boolean );
begin
     If   not ( csDestroying in ComponentState )
     then If   not IsDesignTime
          then try
                 If   OwnedForm.FormStyle=fsMDIChild
                 then begin
                      If   FButtonPressed=mrNone
                      then If   Assigned( FTable )
                           then With FTable do
                                  begin

                                  If   State in [ dsEdit, dsInsert ]
                                  then begin

                                       If   Modified
                                       then begin
                                            OwnedForm.BringToFront;
                                            If   ShowNotification( ntQuestionWarning, RsMsg12, RsMsg13 )<>mrYes
                                            then begin
                                                 CanClose := False;
                                                 Exit;
                                                 end;
                                            end;

                                       try
                                         CheckDetailRecords;
                                       except on E : Exception do
                                         begin
                                         // Cualquier otro tipo de error no está previsto, y debe ser grave (por lo menos, dejemos que se cierre la ventana)
                                         CanClose := not( E is EAbort );
                                         Exit;
                                         end;
                                       end;

                                       end;

                                  Cancel;
                                  end;
                      end;

                 CanClose := DoCanClose;

               except On EAbort do CanClose := False;
                      else         CanClose := True;
                 end;

end;

{ El parámetro LockUpdate se utiliza para evitar que, en algunos casos, se refresquen las ventanas
  al volver a desbloquear la actualización de la barra de botones (ApplicationContainer.MainTopBar.LockUpdate := False).
  En concreto, si se llama a la función durante la activación o desactivación de una ventana se producen
  refrescos molestos e innecesarios.
  }

procedure TgxFormManager.SetupToolbar( Value : Boolean; LockUpdate : Boolean = True );

var  ButtonEnabled,
     Filtered,
     Browsing : Boolean;

begin

     FKeyButtonsEnabled := False;
     FDataButtonsEnabled := False;

     If   not IsDesignTime and
          not ( csDestroying in ComponentState ) and
              Assigned( Application.MainForm ) and
          not( ApplicationContainer.RecordButtonPressed and OwnedFormActive ) and
             ( OwnedForm.FormStyle=fsMDIChild )
     then With ApplicationContainer do
            try

              If   LockUpdate
              then ApplicationContainer.MainTopBar.LockUpdate := True;

              Filtered := False;

              If   Assigned( FTable )
              then begin
                   ButtonEnabled := Value and not( FTable.State in [ dsEdit, dsInsert ] );
                   Filtered := FTable.Filtered;
                   end
              else ButtonEnabled := Value or ( Value and ( FModel=fmPersistentInputForm ) );

              FKeyButtonsEnabled := ButtonEnabled;

              UpdateRelatedDocsControls;

              If   Assigned( QueryGridButton )
              then QueryGridButton.Enabled := ButtonEnabled and Assigned( FOnQueryGridRequest );
              If   Assigned( ReportButton )
              then ReportButton.Enabled := ButtonEnabled and Assigned( FOnReportRequest );
              If   Assigned( FormReportButton )
              then FormReportButton.Enabled := ButtonEnabled and Assigned( FOnReportFormRequest );
              If   Assigned( LabelButton )
              then LabelButton.Enabled := ButtonEnabled and Assigned( FOnLabelsRequest );
              If   Assigned( GraphicButton )
              then GraphicButton.Enabled := ButtonEnabled and Assigned( FOnGraphicRequest );
              If   Assigned( CopyRecButton )
              then CopyRecButton.Enabled := ButtonEnabled and not DataAreaFocused and ( ActiveRecordButtonLink=FRecordButtonLink ) and Assigned( FOnCopyCurrentRecord );
              If   Assigned( SaveParamsButton )
              then SaveParamsButton.Enabled := ( CodigoEmpresaActual<>'' ) and ( CodigoUsuarioActual<>'' );

              If   Assigned( FTable )
              then ButtonEnabled := Value and ( FTable.State in [ dsEdit, dsInsert ] )
              else ButtonEnabled := Value;

              If   Assigned( NoteButton )
              then NoteButton.Enabled := ButtonEnabled and Assigned( FOnNoteRequest );

              FDataButtonsEnabled := ButtonEnabled;

              //* 06.11.2000 Añadido porque no siempre basta con la activacion/desactivacion

              Browsing := Value and ( ( FModel=fmEditForm ) or ( OwnedForm.FormType in [ fmGrid, fmBackground ] ) );
              If   Assigned( FTable )
              then Browsing := Browsing and ( FTable.State in [ dsBrowse, dsSetKey ] );

              ApplicationContainer.EnableRecordButtons( Browsing, Browsing, Filtered );

              If   Assigned( FOnSetupToolBar )
              then FOnSetupToolBar( Value );

            finally
              If   LockUpdate
              then ApplicationContainer.MainTopBar.LockUpdate := False;
              end;
end;

function TgxFormManager.ActivateRelatedDocsButton : Boolean;
begin
     If   Assigned( FOnActivateRelatedDocsButton )
     then Result := FOnActivateRelatedDocsButton
     else Result := True;
end;

procedure TgxFormManager.ShowRelatedDocsMenu;

var P : TPoint;
    ItemLink : TdxBarItemLink;

function ActivaOpcionUnica : Boolean;

var I : SmallInt;
    OnlyOne : Boolean;
    AMenuItemLink : TdxBarItemLink;

begin
     Result := False;
     If   IsKeyPressed( VK_F3 )
     then With RelatedDocsMenu do
            begin
            AMenuItemLink := nil;
            OnlyOne := True;
            For I := 0 to ItemLinks.Count - 1 do
              If   Assigned( ItemLinks[ I ] )
              then If   ItemLinks[ I ].Visible { and ItemLinks[ I ].Control.Enabled }
                   then begin
                        If   not OnlyOne
                        then Exit;
                        OnlyOne := False;
                        AMenuItemLink := ItemLinks[ I ];
                        end;
            If   Assigned( AMenuItemLink )
            then begin
                 TdxBarButton( AMenuItemLink.Control ).OnClick( nil );
                 Result := True;
                 end;
            end;
end;

begin
     With ApplicationContainer do
       If   IsMenuBarActive and
            Assigned( RelatedDocsMenu ) and
            Assigned( RelationsButton ) and
            FRelatedDocsMenuEnabled and
            RelationsButton.Enabled
       then begin

          With RelatedDocsMenu do
            If   Assigned( OnPopup )
            then OnPopup( Self );

            // La idea es que si hay una sola opción de menú activa no hace falta mostrar el menú de opciones
            // cuando se pulsa <Shift>+<F3>

            ItemLink := GetItemLinkByBarItem( MainTopBar, RelationsButton );
            If   Assigned( ItemLink )
            then begin
                 P.X := ItemLink.Control.ViewInfo.Bounds.Left;
                 P.Y := GetDesktopTop;
                 P := Application.MainForm.ClientToScreen( P );
                 RelatedDocsMenu.Popup( P.X, P.Y );
                 end;
            end;
end;

procedure TgxFormManager.SpeedBtnPressed( AnAppSpeedBtn : TSpeedBtnTag );

procedure SendToForm;

procedure ClickCloseButton;
begin
     If   Assigned( FCloseButton )
     then If   FCloseButton.Enabled
          then FCloseButton.Click;
end;

procedure ClickAcceptButton;
begin
     If   Assigned( FOkButton )
     then begin
          If   FOkButton.Enabled
          then FOkButton.Click;
          end
     else ClickCloseButton;  // En algunos casos poner ambos botones resulta redundante, porque el objetivo es el mismo : cerrar la ventana.
                             // Por lo tanto pulsar [Intro] o [Esc] tiene el mismo efecto.
end;

begin

     case AnAppSpeedBtn of

       sbnQueryGrid    : If   ApplicationContainer.QueryGridButton.Enabled and Assigned( FOnQueryGridRequest )
                         then FOnQueryGridRequest;

       sbnRelatedDocs  : If   ApplicationContainer.RelationsButton.Enabled
                         then If   Assigned( FOnRelatedDocsRequest )
                              then FOnRelatedDocsRequest
                              else ShowRelatedDocsMenu;

       sbnReport       : If   ApplicationContainer.ReportButton.Enabled and Assigned( FOnReportRequest )
                         then FOnReportRequest;

       sbnFormReport   : If   ApplicationContainer.FormReportButton.Enabled and Assigned( FOnReportFormRequest )
                         then FOnReportFormRequest;

       sbnLabels       : If   ApplicationContainer.LabelButton.Enabled and Assigned( FOnLabelsRequest )
                         then FOnLabelsRequest;

       sbnGraphic      : If   ApplicationContainer.GraphicButton.Enabled and Assigned( FOnGraphicRequest )
                         then FOnGraphicRequest;

       sbnNote         : If   ApplicationContainer.NoteButton.Enabled and Assigned( FOnNoteRequest )
                         then FOnNoteRequest;

       sbnEditRec      : EditRecord;

       sbnInsertRec    : If   ApplicationContainer.InsertRecButton.Enabled
                         then If   Assigned( FOnInsertRecRequest )
                              then FOnInsertRecRequest
                              else InsertNewAutoIncrementRecord;

       {
       sbnReloadRec    : RefreshRecord;

       sbnUpdateRec    : UpdateRecord;
       }

       sbnAccept       : ClickAcceptButton;

       sbnClose        : ProcessModalResult( mrCancel );
                         {
                         If   ApplicationContainer.TDI
                         then ProcessModalResult( mrCancel )
                         else ClickCloseButton;
                         }

       sbnHelp         : ShowHelp;

       end;
end;

begin
     If   ( AnAppSpeedBtn in ( [ sbnEdit, sbnQuery, sbnNote, sbnExtFunc, sbnDefaultValue ] ) ) and
          Assigned( ActiveEditControl )
     then With ActiveEditControl do
            try
              UpdateKeyPressed( 0, [] );  //.. De esta forma puedo identificar las llamadas desde botones
              Inc( FEditControlNotification );
              case AnAppSpeedBtn of
                sbnEdit    : DoOnEditRequest;
                sbnQuery   : DoOnQueryRequest;
                sbnNote    : If   Assigned( Properties.OnAnnotationRequest )
                             then DoOnAnnotationRequest
                             else SendToForm;
                sbnExtFunc : DoOnExtendedFunction;
                sbnDefaultValue : DoOnDefaultValue;
                end;
            finally
              Dec( FEditControlNotification );
              end
     else SendToForm;

end;

procedure TgxFormManager.DisableForm;
begin

     If   Assigned( ActiveFormManager ) and ( ActiveFormManager<>Self )
     then Exit;

     ApplicationContainer.DisableAllToolbarButtons;

     ActiveFormManager := nil;
     ActiveRecordButtonLink := nil;

end;

procedure TgxFormManager.DoOnEnterButtonsPanel( Sender : TObject );
begin
     If   Assigned( FOnButtonsPanelEnter )
     then FOnButtonsPanelEnter( Sender );
end;

procedure TgxFormManager.FormActivate( Sender : TObject );
begin

     FClosingOwnedForm := False;

     If   DatabaseUpdateRequested
     then Exit;

     DoActivateForm;

     //* 07.05.2003  Las ventanas que no son MDIChild pueden tener un FormManager, pero no deben
     //              contener controles activos.

     //* 08.12.2005  Cuando la ventana es modal los MDIChilds no reciben notificaciones de activación/desactivación
     //              por lo que es mejor no desactivar por defecto todos los botones.


     // ApplicationContainer.DoOnActivateEditForm( OwnedForm, Model in [ fmEditForm, fmPersistentInputForm ] );

     OwnedFormActive := True;

     If   Assigned( OwnedForm )
     then If   OwnedForm.FormStyle=fsMDIChild
          then SetupToolbar( True, { LockUpdate } False )
          else If   not ( fsModal in OwnedForm.FormState )
               then ApplicationContainer.DisableAllToolbarButtons;

     ActivateFormButtons( True );

end;

procedure TgxFormManager.FormDeactivate ( Sender : TObject );

var   ChildProcess : Boolean;

begin

     If   not Freeing
     then try

            OwnedFormActive := False;

            With OwnedForm do
              begin

              ChildProcess := FEditControlNotification<>0;

              // Las ventanas sin Owner son popups de edición y similares

              If   not ChildProcess
              then ChildProcess := ( Screen.ActiveCustomForm<>FOwnedForm ) and not Assigned( Screen.ActiveCustomForm.Owner );

              If   not ChildProcess
              then If   Assigned( FRecordButtonLink )
                   then ChildProcess := FRecordButtonLink.BtnLinkProcess;

              If   not ChildProcess
              then If   ActiveControl is TgBitBtn
                   then ChildProcess := ( ActiveControl as TgBitBtn ).Clicked;

              If   not ChildProcess
              then If   Assigned( CurrentSelectorRelationForm ) and
                        ( CurrentSelectorRelationForm<>OwnedForm )
                   then ChildProcess := CurrentSelectorRelationForm.Visible;

              end;

            DoDeactivateForm( ChildProcess );
            DisableForm;
            SetupToolbar( False, { LockUpdate } False );

            FOwnedForm.DeActivateControlToolbarOptions;

            ActivateFormButtons( False );

            With OwnedForm do
              If       FCloseWindowWhenFocusLost and
                       Enabled and
                   not FButtonProcess and
                   not ChildProcess and
                   not ApplicationContainer.HelpFormActive and
                   not ApplicationContainer.WebFormActive and
                   not ApplicationContainer.WarningActive and
                   not ApplicationForms.EditControlPopupMenuActive and
                       ( FormResult=mrNone ) and
                       DoCanClose
              then CloseOwnedForm;

            except
             end;

     GUpdateRecordButtons := True;

end;

procedure TgxFormManager.ActivateFormButtons( Value : Boolean );
begin
     If   Assigned( FButtonsPanel )
     then begin
          SetGroupBoxControlsEnabled( FButtonsPanel, Value, { Force } True );
          If   Value
          then UpdateButtonsState;
          end;
end;

procedure TgxFormManager.FormDragDrop( Sender, source : TObject; X, Y : Integer );
begin
end;

procedure TgxFormManager.FormDragOver(    Sender,
                                         source  : TObject;
                                         X,
                                         Y       : Integer;
                                         State   : TDragState;
                                     var accept  : Boolean );
begin
end;

procedure TgxFormManager.FormHide( Sender : TObject );
begin
     DoHideForm;
end;

procedure TgxFormManager.AddAllBlueMarks;

var  Component : TComponent;
     EditControl : TcxCustomEdit;

begin
     For Component in OwnedForm do
       If   Component is TWinControl
       then begin
            EditControl := GetEditControl( TWinControl( Component ) );
            If   Assigned( EditControl )
            then AddBlueMark( EditControl );
            end;
     OwnedForm.Invalidate;
end;

procedure TgxFormManager.RemoveAllBlueMarks;

procedure RemoveBlueMarks( Container : TWinControl );

var  I : SmallInt;

begin
     With Container do
       For I := ComponentCount - 1 downto 0 do
         If   Components[ I ] is TgxBlueMarkBox
         then Components[ I ].Free
         else If   Components[ I ] is TFrame
              then RemoveBlueMarks( TFrame( Components[ I ] ) );
end;

begin
     RemoveBlueMarks( OwnedForm );
     OwnedForm.Invalidate;
end;

procedure TgxFormManager.BrowseLast;
begin
     If   Assigned( BrowseTable ) and not FRangeLocked
     then begin
          BrowseTable.Last;
          If   BrowseTable.Found
          then Table.GotoCurrent( BrowseTable )
          else DataSet.Last;
          end
     else DataSet.Last;
end;

procedure TgxFormManager.BrowseFirst;
begin
     If   Assigned( BrowseTable ) and not FRangeLocked
     then begin
          BrowseTable.First;
          If   BrowseTable.Found
          then Table.GotoCurrent( BrowseTable )
          else DataSet.First;
          end
     else DataSet.First;
end;

procedure TgxFormManager.BrowsePrior;
begin
     If   Assigned( BrowseTable ) and not FRangeLocked
     then begin
          BrowseTable.Prior;
          If   BrowseTable.Found
          then Table.GotoCurrent( BrowseTable );
          end
     else DataSet.Prior;
end;

procedure TgxFormManager.BrowseNext;
begin
     If   Assigned( BrowseTable ) and not FRangeLocked
     then begin
          BrowseTable.Next;
          If   BrowseTable.Found
          then Table.GotoCurrent( BrowseTable );
          end
     else DataSet.Next;
end;

procedure TgxFormManager.SyncBrowseTable;
begin
     If   Assigned( BrowseTable )
     then If   BrowseTable.Found
          then Table.GotoCurrent( BrowseTable );
end;

procedure TgxFormManager.FormShow( Sender : TObject );

type TSelectControl = ( scNone, scKey, scData, scKeyOrData );

var   I : SmallInt;
      AField : TField;
      ErrorText : TCaption;
      ErrorResult,
      ValidateKeyControls : Boolean;
      SelectControl : TSelectControl;

begin

     If   DatabaseUpdateRequested
     then Abort;

     try

       If   FShowQueryOptionPending
       then ShowQueryOption := True;

       FShowingForm := True;

       // Si la ventana ya existía y se estaba editando un registro hay que salir ordenadamente

       If   ( FModel=fmEditForm ) and
            FFormInitialized and
            Assigned( FTable ) and
            FTable.Editing
       then If   FTable.Modified
            then begin
                 ShowHintMsg( RsMsg19, RsMsg20 );
                 Exit;
                 end
            else FTable.Cancel;

       // Si se está mostrando de nuevo (OnShow de CreateForm) una ventana que ya existía, el valor de FFormInitialized
       // cuando se llama a DoShowForm será False, porque ya fué inicializada cuando se creó.

       DoShowForm;

       FFormInitialized := True;
       SelectControl := scNone;

       try

         If   FModel=fmEditForm
         then begin

              If   Assigned( FTable )
              then With FTable do
                     begin

                     ValidateKeyControls := False;

                     If   FormCheckEditState
                     then try

                            FEnablingDatasources := True;

                            // Si se llama a FormShow durante la creación de la ventana los controles ya han sido desactivados en FormCreate
                            // pero si es solo un refresco (se actualiza una ventana ya abierta) los controles están activos

                            If   not ControlsDisabled
                            then DisableControls;

                            If   not FormValuesIsEmpty
                            then begin
                                 If   High( FormValues )<>Pred( IndexFieldCount )
                                 then raise Exception.Create( Format( RsgMsg534, [ TableName ] ) );
                                 If   Assigned( FLockRangeButton )
                                 then FLockRangeButton.DoOnLockRange( FormValues, False )
                                 else SetDefaultKeyRange( False );
                                 end
                            else If   Assigned( Sender )
                                 then SetDefaultKeyRange( False );

                            // Si Sender no está asignado es porque la ventana ya existe y es un refresco. La llamada se hace desde el OnShow( nil ) de CreateForm

                            If   Assigned( Sender )
                            then Cancel
                            else begin
                                 try
                                   Cancel;
                                 except
                                   Exit;
                                   end;
                                 If   FormValuesIsEmpty
                                 then Exit
                                 else FormTableState := dsSetKey;
                                 end;

                            case FormTableState of
                              dsBrowse    : begin

                                            // Se entra en modo SetKey para que se carguen los valores por defecto de la clave (DoOnSetKey) y
                                            // así poder aplicar el rango si es necesario

                                            If   Assigned( FLockRangeButton )
                                            then FLockRangeButton.SetDefaultRange( True )
                                            else BrowseLast;

                                            SelectControl := scKey;
                                            end;

                              dsEdit      : If   FindKey( FormRecValues )
                                            then begin
                                                 Edit;
                                                 SelectControl := scData;
                                                 end
                                            else Abort;

                              dsSetKey    : try

                                              If   not SelectCurrentKey( FormRecValues )
                                              then begin
                                                   SetKey;

                                                   // CheckNumericFieldsRange : Si alguno de los valores numéricos que se intentan asignar no están en el rango de los válidos en algún campo
                                                   // no quiero que se produzca una excepción. Simplemente no se intenta aplicar el valor y punto.

                                                   SetIndexValues( FormValues , { CheckNumericFieldsRange } True );
                                                   ValidateKeyControls := True;
                                                   end;

                                              SelectControl := scKey;
                                            except
                                              Last;
                                              end;

                              end;

                            If   Assigned( FKeyPanel )
                            then FKeyPanel.UpdateStateImage;

                          finally
                            EnableControls;            // Primero activo los controles para que se actualicen los del registro principal. Luego vendrá un UpdateDataControls para que se validen.
                            EnableDataSources( True ); // Una vez leído el registro principal ya puedo activar los datasources descendientes.
                            DoOnUpdateState;           // Una última oportunidad para activar los datasets descendientes no vinculados con la tabla principal (por ejemplo)
                            FEnablingDatasources := False;
                            end;

                     // Ajustando el rango de caracteres válidos de los campos de la clave, si no han sido fijados antes.

                     With FTable do
                       For I := 0 to IndexFieldCount - 1 do
                         begin
                         AField := IndexFields[ I ];
                         If   AField is TStringField
                         then If   AField.ValidChars=[]
                              then AField.ValidChars := KeyCharSet;
                         end;

                     If   ValidateKeyControls
                     then ValidateEditControls( faKey, ErrorText, ErrorResult, False );

                     end;

              end
         else begin

              EnableDataSources( True );

              If   Assigned( FDataset )
              then ValidateEditControls( faAll, ErrorText, ErrorResult, False );

              If   FModel in [ fmInputForm, fmPersistentInputForm, fmReportForm ]
              then SelectControl := scKeyOrData;   // En el caso de fmPersistentInputForm puede existir KeyPanel

              end;

       except On E : Exception do
         begin
         ShowException( E, Self );
         CloseOwnedForm;
         end;
       end;

     // He añadido aquí la apertura de los dataset enlazados con el principal para mejorar la velocidad de apertura de los mantenimientos
     // La forma de hacerlo es dejando la propiedad 'ActiveRuntime' del dataset de líneas en False para que no se abra hasta este momento.

     If   not FClosingOwnedForm
     then begin

          try

            If   FModel=fmEditForm
            then begin
                 If   Assigned( FTable )
                 then FTable.DoOnReadRecord;  // Por si hay datos complementarios que procesar (Memdatasets, etc..)
                 UpdateDataControls;
                 end;

            If   Assigned( FTable )
            then FTable.OpenDetailDataSets;

          except
            end;

          FFormPrepared := True;

          DoReadWindowParams;

          DoPreparedForm;

          case SelectControl of
            scKey :
              SelectFirstKeyControl;
            scData :
              SelectFirstDataControl;
            scKeyOrData :
              If   Assigned( FFirstKeyControl )
              then SelectFirstKeyControl
              else SelectFirstDataControl;
            end;

          end;

     finally
       FormCheckEditState := True;
       CleanFormValues;
       FormPositionIndex := -1;
       FShowingForm := False;
       end;
end;


function TgxFormManager.CanCloseOwnedForm : Boolean;
begin
     Result := False;
     If   DoCanClose
     then begin
          fCancelling := True;
          If   FModel=fmEditForm
          then begin
               If   Assigned( FTable )
               then FTable.Cancel;
               Result := True;
               end
          else Result := True;
          end;
end;

procedure TgxFormManager.DoButtonPressed( Sender : TObject );
begin
     try

       FButtonProcess := True;

       If   Assigned( Sender ) and ( Sender is TgBitBtn )
       then With Sender as TgBitBtn do
              begin
              FButtonPressed := ModalResult;
              If   Visible and Enabled
              then SetFocus;
              If   not TouchApplication and ( OwnedForm.ActiveControl<>Sender )
              then Exit;
              end;

       ProcessModalResult( FButtonPressed );

     finally
       FButtonProcess := False;
       end;

end;

procedure TgxFormManager.ProcessModalResult( AModalResult : TModalResult);

var   IsEditing,
      ShowQueryBox,
      SaveKillFocus : Boolean;
      ValueList : TStringList;
      DelSt : String;

function DontCloseWithEscape : Boolean;
begin
     Result := ( IsKeyPressed( VK_ESCAPE ) and ( FModel in [ fmEditForm, fmPersistentInputForm ] ) and ApplicationContainer.DontCloseWindowsWithEsc );
end;

begin

     If   not OwnedForm.Enabled or
          not OwnedForm.Visible
     then begin
          // sólo se da durante el preproceso de un report ...
          If   Assigned( ApplicationContainer.OnEndProgression )
          then ApplicationContainer.OnEndProgression( True );
          Exit;
          end;

     CloseWindow := False;
     SaveKillFocus := OwnedForm.FCloseWindowWhenFocusLost;
     OwnedForm.CloseWindowWhenFocusLost := False;
     FInvalidCustomEdit := nil;
     FCancelling := AModalresult=mrCancel;

     // Solo se guardan los parámetros cuando se mantiene pulsado <Shift>
     // SaveWindowParams := IsKeyPressed( VK_SHIFT );

     ValueList := TStringList.Create;

     try

       try

         case AModalResult of
             mrOk      : try

                           case FModel of
                             fmPersistentInputForm,
                             fmInputForm,
                             fmReportForm            : If   Assigned( FDataset )
                                                       then ValidateDataArea( faAll, True );

                             fmEditForm              : If   Assigned( FTable )
                                                       then If   DataAreaFocused and ( FTable.State in [ dsEdit, dsInsert ] )
                                                            then ValidateDataArea( faData, True );

                             end;

                           If   FModel in [ fmInputForm, fmReportForm ]
                           then OwnedForm.Enabled := False;

                           If   Assigned( FOnOkButton )
                           then FOnOkButton;

                         except On EAbort do
                                Exit;
                           else raise;
                           end;

             mrCancel  : If   Assigned( FOnCloseButton )
                         then FOnCloseButton;

             mrAbort   : begin
                         ShowQueryBox := True;

                         // Cuando el registro no es modificable se debe entrar en modo edición antes de intentar borrar
                         // el registro para bloquearlo

                         If   Assigned( FTable )
                         then FTable.Edit;

                         If   Assigned( FOnDeleteButton )
                         then ShowQueryBox := FOnDeleteButton;
                         If   ShowQueryBox
                         then begin

                              //* 09.06.2005 Añadida la ampliación del mensaje cuando el registro tiene líneas asociadas

                              DelSt := RsgMsg178;
                              If   Assigned( FTable ) and FTable.HasNestedDatasets
                              then StrAdd( DelSt, RsgMsg176 );

                              If   ShowNotification( ntQuestionWarning, DelSt )<>mrYes
                              then Exit;
                              end;
                         end;
             end;

       except
         on EAbort do
           begin
           CloseWindow := not ( FModel in [ fmEditForm, fmPersistentInputForm ] );
           Exit;
           end;
         on E : EDatabaseError do
           Abort;
         on E : Exception do
           ShowException( E, Self );
         else raise;
         end;

       try

         case AModalResult of
           mrOk     : begin
                      case FModel of

                        fmInputForm,
                        fmReportForm  : If   Freeing
                                        then Abort
                                        else begin
                                             FormResult := mrOk;
                                             With OwnedForm do
                                               If   ( FormStyle=fsMDIChild ) or TouchApplication
                                               then CloseWindow := ( FModel=fmInputForm ) or SaveKillFocus
                                               else ModalResult := mrOk;
                                             end;

                        fmEditForm    : With FTable do
                                          begin
                                          ErrorCounter := 0;
                                          case State of
                                            dsSetKey : SelectFirstDataControl;

                                            dsBrowse : If   OwnedForm.Active
                                                       then If   DataAreaFocused
                                                            then SelectFirstKeyControl
                                                            else SelectFirstDataControl;

                                            dsEdit,
                                            dsInsert : If   DataAreaFocused
                                                       then begin
                                                            If   FReadOnlyDataset or
                                                                 FBrowseOnlyDataset
                                                            then Cancel
                                                            else PostCurrentRecord;
                                                            SelectFirstKeyControl;
                                                            end
                                                       else SelectFirstDataControl;
                                            end;
                                          end;

                        fmPersistentInputForm : begin
                                                DataAreaFocused := not DataAreaFocused;
                                                If   FDataAreaFocused
                                                then begin
                                                     ResetScrollableControls;
                                                     SelectFirstDataControl;
                                                     end
                                                else SelectFirstKeyControl;
                                                end;

                        end;

                      end;

           mrCancel : begin

                      case FModel of
                        fmPersistentInputForm : If   Assigned( FKeyPanel )  // Hay Forms sin panel de clave
                                                then If   DataAreaFocused or DontCloseWithEscape
                                                     then begin
                                                          DataAreaFocused := False;
                                                          SelectFirstKeyControl;
                                                          Exit;
                                                          end;

                        fmInputForm,
                        fmReportForm          : ;
                        fmEditForm            : With FTable do
                                                  begin
                                                  IsEditing := DataAreaFocused or ( State in [ dsSetKey, dsEdit, dsInsert ] );

                                                  If   IsEditing
                                                  then try
                                                         CheckDetailRecords;
                                                       except
                                                         Exit;
                                                         end;

                                                  If   ( State=dsEdit ) and Modified
                                                  then begin
                                                       If   ShowNotification( ntQuestionWarning, RsMsg12, RsMsg13 )<>mrYes
                                                       then begin
                                                            SelectFirstDataControl;
                                                            Exit;
                                                            end;
                                                       end
                                                  else If   State=dsInsert
                                                       then If   ShowNotification( ntQuestionWarning, RsMsg45, RsMsg46 )<>mrYes
                                                            then begin
                                                                 SelectFirstDataControl;
                                                                 Exit;
                                                                 end;

                                                  try
                                                    If   State=dsSetKey
                                                    then Browse
                                                    else Cancel;
                                                  except
                                                    // CloseWindow := True;
                                                    Exit;
                                                    end;

                                                  If   IsEditing or DontCloseWithEscape
                                                  then begin
                                                       SelectFirstKeyControl;

                                                       // En algunos casos, si el fichero está vacío y al campo de clave que se activa se le asigna un valor
                                                       // por defecto, se vuelve a activar el modo dsSetKey

                                                       Cancel;
                                                       Exit;
                                                       end;

                                                  end;

                        end;


                      FormResult := mrCancel;

                      If   CanCloseOwnedForm
                      then With OwnedForm do
                             If   FormStyle=fsMDIChild
                             then CloseWindow := not DontCloseWithEscape
                             else ModalResult := mrCancel;

                      end;

           mrAbort  : case FModel of
                        fmEditForm   : If   Assigned( FTable )
                                       then try
                                              FTable.DeleteMasterRecord;
                                              If   Assigned( FOnEditRecordDeleted )
                                              then FOnEditRecordDeleted;
                                            finally
                                              FTable.Cancel;
                                              SelectFirstKeyControl;
                                              end;
                        else           begin
                                       FormResult  := mrAbort;
                                       CloseWindow := True;
                                       end;
                        end;
           end;

       except On E : Exception do
         begin
         If   E is EnxBaseException
         then try
                ShowDatabaseError( FTable, EnxBaseException( E ) );
                If   Assigned( FTable )
                then FTable.Cancel;
                Exit;
              except
                end;
         If   AModalResult=mrCancel
         then CloseWindow := True;
         end;

       end;

     finally

       ValueList.Free;

       If   CloseWindow
       then begin

            HintKeyPressed := True;

            //* 25.02.2010  Cuando está activo el TDI las ventanas de edición no se cierran con <Esc>.
            //* 29.01.2014  GotoPreviousOnClose. He creado la opción de evitar que una ventana se cierre con Esc, en su lugar se va a la ventana anterior
            //              Por supuesto esta opción solo tiene sentido cuando existen otras ventanas (ver b_rdr)

            If   FormResult in [ mrCancel, mrAbort ]
            then begin
                 {
                 If   ApplicationContainer.TDI and ( ApplicationContainer.TabbedMDIManager.ViewInfo.TabsViewInfo.Tabs.VisibleTabsCount>1 )
                 then ApplicationContainer.TabbedMDIManager.SelectPreviousTab
                 else }
                      If   OwnedForm.GotoPreviousOnClose
                      then Application.MainForm.Previous
                      else CloseOwnedForm;
                 end
            else CloseOwnedForm;

            {
            If   OWnedForm.TDITabSheetForm
            then Application.MainForm.Previous;
            If   Application.Mainform.ActiveMDIChild=OwnedForm
            then CloseOwnedForm;

            }

            end
       else If   Freeing
            then Abort
            else try
                   FCancelling := False;
                   OwnedForm.Enabled := True;
                   If   OwnedForm.FormStyle=fsMDIChild
                   then FormResult := mrNone;
                   FButtonPressed := mrNone;

                   //* 07.02.2011 Un nuevo comportamiento : el de las ventanas asociadas a un QueryGrid que se ocultan y quedan dispuestas para su uso la ventana del grid.

                   If   OwnedForm.Visible
                   then begin
                        OwnedForm.CloseWindowWhenFocusLost := SaveKillFocus;
                        If   FModel in [ fmInputForm, fmReportForm ]
                        then begin
                             OwnedForm.BringToFront;
                             {
                             If   Assigned( OwnedForm.FLastActiveEditControl )
                             then OwnedForm.FLastActiveEditControl.SetFocus
                             else
                             }
                             If  not Assigned( FInvalidCustomEdit )
                             then SelectFirstDataControl;
                             end;
                        end;

                 except
                   end;

       end;

end;

procedure TgxFormManager.ClearEditPanel( EditPanel : TgxEditPanel );

var  I : Integer;
     EditControl : TcxCustomEdit;
     TabList : TList;

begin
     If   Assigned( EditPanel )
     then With EditPanel do
            begin
            TabList := TList.Create;
            try
              GetTabOrderList( TabList );
              For I := 0 to TabList.Count - 1 do
                begin
                EditControl := GetEditControl( TWinControl( TabList[ I ] ) );
                If   Assigned( EditControl )
                then EditControl.Clear;
                end;
            finally
              TabList.Free;
              end;
            end;
end;

procedure TgxFormManager.CloseOwnedForm;
begin
     FOwnedForm.Close;
     FClosingOwnedForm := True;
end;

function TgxFormManager.Freeing : Boolean;
begin
     If   csDestroying in ComponentState
     then Result := True
     else try
            If   Assigned( FOwnedForm )
            then Result := csDestroying in FOwnedForm.ComponentState
            else Result := True;
            If   not Result
            then Result := FClosingOwnedForm or ApplicationContainer.DestroyingMainForm or ReleasingApplication;
          except
            Result := True;
            end;
end;

function TgxFormManager.DoCanClose : Boolean;
begin
     try
       ApplicationContainer.CurrentClosingForm := OwnedForm;
       If   Assigned( FOnCanClose )
       then Result := FOnCanClose
       else Result := True;
     finally
       ApplicationContainer.CurrentClosingForm := nil;
       end;
end;

procedure TgxFormManager.EditRecord;
begin
     If   not DataAreaFocused
     then SelectFirstDataControl;
     If   Assigned( FTable )
     then With FTable do
            If   FEditAllowed
            then FTable.Edit;
end;

{
procedure TgxFormManager.RefreshRecord;
begin
     If   Assigned( FTable ) and ( FTable.State=dsBrowse ) and not DataAreaFocused
     then FTable.Refresh;
end;

procedure TgxFormManager.UpdateRecord;

var   CurrentActiveControl : TWinControl;
      IndexFieldValues : TFieldValuesArray;
      RecordFound : Boolean;

begin
     // Simplemente navegar por el interior del registro sin modificarlo
     If   Assigned( FTable ) and Assigned( FOkButton ) and not DataAreaFocused
     then SelectFirstDataControl;
end;
}

procedure TgxFormManager.InsertNewAutoIncrementRecord;

var   KeyValue : String;
      EditControl : TcxCustomEdit;

function NewAutoIncRecordString : Boolean;

var   CurrentSt : String;

begin
     Result := False;
     try
       CurrentSt := FTable.GetNewAutoIncStringValue( KeyValue );
       If   CurrentSt<>''
       then try
              FTable.SetKey;
              FTable.AutoIncField.Value := CurrentSt;
              Result := True;
            except
              ShowHintMsg( RsMsg43, RsMsg44, EditControl );
              Result := False;
              end;
     except
       ShowNotification( ntWarning, RsMsg47, RsMsg48 );
       SelectFirstKeyControl;
       end;

end;

procedure ValidateKeyArea;

var  ErrorText : TCaption;
     ErrorResult : Boolean;

begin
     FInvalidCustomEdit := ValidateEditPanel( FKeyPanel, ErrorText, ErrorResult, True, True, EditControl );
     If   ErrorResult
     then begin
          ShowHintMsg( RsgMsg397, { RsgMsg398 + ''#13'' + } ErrorText, FInvalidCustomEdit );
          If   Assigned( FInvalidCustomEdit )
          then begin
               SelectEditControl( FInvalidCustomEdit );
               FInvalidCustomEdit.EditModified := True;
               end;
          Abort;
          end;
end;

begin
     If   Assigned( FTable )
     then try

            FInsertingAutoIncRecord := True;

            EditControl := GetEditControl( OwnedForm.ActiveControl );
            If   Assigned( EditControl )
            then With FTable do
                   If   ( State in [ dsBrowse, dsSetKey ] ) and CanInsert and ( AutoIncFieldName<>'' )
                   then begin

                          KeyValue := VarToStr( EditControl.EditingValue );
                          ValidateKeyArea;
                          EditControl.CancelValidation := True;  // Ya se ha validado en ValidateKeyArea y no hace falta que se vuelva a comprobar

                          DisableControls;
                          try

                            If   Assigned( FOkButton )
                            then FOkButton.SetFocus;

                            try
                              If   Assigned( AutoIncField ) and ( AutoIncField is TStringField )
                              then begin
                                   If   not NewAutoIncRecordString
                                   then Exit;
                                   end
                              else NewAutoIncRecord( False );
                            except on E : Exception do begin
                                                       If   not ( E is EAbort )
                                                       then ShowNotification( ntExceptionError, RsMsg53, E.Message );
                                                       Cancel;
                                                       SelectFirstKeyControl;
                                                       Abort;
                                                       end;
                              end;

                          finally
                            EnableControls;
                            end;

                          try
                            If   OwnedForm.Active
                            then SelectFirstDataControl;
                          except On EAbort do ;
                                 else      raise;
                            end;

                         end;
            finally
              FInsertingAutoIncRecord := False;
              end;

end;

function TgxFormManager.SelectCurrentKey( KeyValues       : array of const;
                                         CheckKeyFields  : Boolean = False;
                                         ActivateForm    : Boolean = False ) : Boolean;
begin
     Result := False;
     If   Assigned( FTable )
     then With FTable do
            try
              If   not IsKeyPressed( VK_control ) and ActivateForm
              then OwnedForm.BringToFront;
              Cancel;
              If   CheckKeyFields
              then ValidateDataArea( faKey, True, True );
              try
                SaveRange;
                CancelRange;

                SetKeyValues( KeyValues );
                Result := GotoRecord( skaEqualFirst );
              finally
                RestoreRange;
                end;
              If   ActivateForm
              then SelectFirstKeyControl;
            except
            end;

end;

procedure TgxFormManager.SelectLastRecord;
begin
     If   Assigned( FTable )
     then With FTable do
            begin
            Cancel;
            Last;
            end;
     SelectFirstKeyControl;
end;

procedure TgxFormManager.PostCurrentRecord;

var  SystemMessage,
     NotificationMsg : String;
     var FieldIndexValues : TFieldValuesArray;

procedure PostDetailDataSets;

var  DataSetList : TList<TDataset>;
     Dataset : TDataset;

begin
     DataSetList := TList<TDataset>.Create;
     try
       FTable.GetDetailDataSets( DataSetList );
       For Dataset in DataSetList do
         With Dataset do
           If   State in [ dsEdit, dsInsert ]
           then Post;
     finally
       DataSetList.Free;
       end;
end;

begin
     If   Assigned( FTable )
     then With FTable do
            try
              FPostingCurrentRecord := True;
              If   Editing // State in [ dsEdit, dsInsert ]
              then begin

                   If   Assigned( FBeforePostEditRecord )
                   then FBeforePostEditRecord;

                   CheckDetailRecords( True );
                   PostDetailDataSets;
                   try

                     If   RemoteEdit
                     then FieldIndexValues := GetFieldIndexValues;

                     Post;

                     If   RemoteEdit
                     then If   GotoKeyValues( FieldIndexValues )
                          then DataEvent( deDataSetChange, 0 )
                          else dsError( DBIERR_NOCURRREC );

                   except on E : Exception do
                       begin
                       If   not ( E is EAbort )
                       then begin

                            SystemMessage := E.Message;

                            If   ( E is EnxBaseException )
                            then SystemMessage := SystemMessage + #13 + ( E as EnxBaseException ).ErrorString;

                            If   State=dsInsert
                            then NotificationMsg := RsMsg73
                            else NotificationMsg := RsMsg72;

                            ShowNotification( ntStop, RsMsg70, RsMsg71 + ''#13'' + NotificationMsg, SystemMessage );

                            Cancel;
                            Refresh;
                            SelectFirstKeyControl;

                            end;

                       Abort;  // El proceso debe interrumpirse
                       end;
                     end;

                   If   Assigned( FOnEditRecordPosted )
                   then FOnEditRecordPosted;

                   end;
            finally
              FPostingCurrentRecord := False;
              end;

     SelectFirstKeyControl;
end;

// TgxRangeBox

procedure TgxRangeBox.Loaded;
begin
     inherited;
     Width := 13;
     Height := 37;
     If  not IsDesignTime
     then begin
          Hint := HintMsg32;
          ShowHint := True;
          end;
end;

procedure TgxRangeBox.Paint;
begin
     inherited;
     Canvas.Draw( 0, 0, ApplicationForms.RangeBoxImage.Picture.Graphic );
end;

// TgxRedMarkBox

procedure TgxRedMarkBox.Loaded;
begin
     inherited;
     Width := 13;
     Height := 13;
     If  not IsDesignTime
     then begin
          Hint := HintMsg32;
          ShowHint := True;
          end;
end;

procedure TgxRedMarkBox.Paint;
begin
     inherited;
     Canvas.Draw( 0, 0, ApplicationForms.RedMarkImage.Picture.Graphic );
end;

// TgxBlueMarkBox

procedure TgxBlueMarkBox.Loaded;
begin
     inherited;
     Width := 13;
     Height := 13;
     If  not IsDesignTime
     then begin
          Hint := HintMsg32;
          ShowHint := True;
          end;
end;

procedure TgxBlueMarkBox.Paint;
begin
     inherited;
     Canvas.Draw( 0, 0, ApplicationForms.BlueMarkImage.Picture.Graphic );
end;

// TgxLockRangeButton

constructor TgxLockRangeButton.Create( AOwner : TComponent );
begin
     inherited;

     Width := 22;
     Height := 22;

     GroupIndex := 1;
     AllowAllUp := True;
     ShowHint := True;
     Spacing := 2;

     SpeedButtonOptions.CanBeFocused := False;
     SpeedButtonOptions.Flat := True;
     SpeedButtonOptions.Transparent := True;

     Hint := HintMsg8;
     NumGlyphs := 1;
     {
     Glyph.PixelFormat := pf32bit;
     Glyph.AlphaFormat := afPremultiplied;
     ApplicationForms.ButtonsImageList.GetImage( 18, Glyph );
     }

end;

procedure TgxLockRangeButton.Notification( AComponent : TComponent; Operation : TOperation );
begin
     inherited;
     If   Operation=opRemove
     then If   AComponent=FEditControl
          then FEditControl := nil;
end;

procedure TgxLockRangeButton.Loaded;
begin
     inherited;
     ApplicationForms.ControlsImageList.GetImage( 18, Glyph );
     Glyph.SourceWidth := 20;
     Glyph.SourceHeight := 20;
end;

function TgxLockRangeButton.GetEditTable : TnxeTable;
begin
     If   not Assigned( FEditTable ) and Assigned( FEditControl )
     then With FEditControl do
            If   DataBinding is TcxDBEditDataBinding
            then With TcxDBEditDataBinding( DataBinding ) do
                   If   Assigned( DataSource )
                   then If   DataSource.DataSet is TnxeTable
                        then  FEditTable := TnxeTable( DataSource.Dataset );
     Result := FEditTable;
end;

procedure TgxLockRangeButton.SetDefaultRange( SetTableKey : Boolean = False );

var KeyValues : TFieldValuesArray;

begin
     If   Assigned( EditTable )
     then With FEditTable do
            try
              FSettingDefaultRange := True;
              If   SetTableKey
              then SetKey;
              KeyValues := GetIndexValues;
              DoOnLockRange( KeyValues, False );
            finally
              FSettingDefaultRange := False;
              end;
end;

procedure TgxLockRangeButton.SetLocked( Value : Boolean );
begin
     Down := Value;
     FFormManager.FRangeLocked := Value;
end;

procedure TgxLockRangeButton.DoOnLockRange( KeyValues           : TFieldValuesArray;
                                            ValidateEditControl : Boolean = True );

function CheckValidRange : Boolean;
begin
     Result := True;
     With FEditTable do
       If   ( RecordCount=0 ) and not FSettingDefaultRange
       then begin
            If   FEditControl.Editing
            then ShowHintMsg( RsMsg38, '' );
            SetLocked( False );
            SetDefaultRange( False );
            EditKey;
            Result := False;
            end;
end;

begin
     If   Assigned( FOnLockRange ) and Assigned( EditTable )
     then try
            FInternalSettingLock := True;

            FEditTable.DisableControls;

            With FEditTable do
              try

                FFormManager.FRangeLocked := Down;
                FOnLockRange( KeyValues );
                Browse;

                If   SetKeyRange( KeyValues, { ApplyRangeNow } False )  // Si devuelve False tan solo indica que no ha sido necesario fijar el rango porque éste no ha cambiado
                then CheckValidRange;

              finally

                If   State=dsBrowse
                then FFormManager.BrowseLast;

                If   not FSettingDefaultRange and ( RecordCount=0 )  // El fichero está vacío, entonces no interesa mantener el botón bloqueado
                then begin                                           // Excepto si estamos asignando un rango por defecto
                     If   Down
                     then begin
                          SetLocked( False );
                          DoOnLockRange( KeyValues, ValidateEditControl );
                          end;
                     end
                else If   CheckValidRange
                     then begin

                          FEditControl.Enabled := not Down;

                          If   ValidateEditControl and ( State=dsBrowse )
                          then begin
                               DoEditControlValidate( FEditControl );
                               If   Down
                               then begin
                                    If   Assigned( FFormManager )
                                    then FFormManager.SelectFirstKeyControl;
                                    end
                               else begin
                                    If   Assigned( ActiveEditControl )
                                    then ActiveEditControl.CancelValidation := True;
                                    FEditControl.SetFocus;
                                    end;
                               end;

                          end
                     else FEditControl.SelectAll;

                end;

          finally
            FInternalSettingLock := False;
            FEditTable.EnableControls;
            end;
end;

procedure TgxLockRangeButton.Unlock;

var KeyValues : TFieldValuesArray;

begin
     SetLocked( False );
     If   Assigned( FEditTable )
     then begin
          KeyValues := FEditTable.GetIndexValues;
          DoOnLockRange( KeyValues );
          end;
end;

procedure TgxLockRangeButton.Click;

var KeyValues : TFieldValuesArray;

begin
     If   Assigned( FEditControl ) and Assigned( EditTable )
     then try
            FInternalSettingLock := True;
            With FEditControl do
              begin
              try
                PostEditValue( EditingValue );
              except
                SetLocked( False );
                raise;
                end;
              If   Enabled
              then SetFocus;
              end;
            KeyValues := FEditTable.GetIndexValues;
            DoOnLockRange( KeyValues );
          finally
            FInternalSettingLock := False;
            end;

     inherited;
end;


{ TLinkedFormsItem ----------------------------------------------- }

constructor TLinkedFormsItem.Create( ASourceForm,
                                     ATargetForm  : TgxForm );
begin
     inherited Create;
     FSourceForm := ASourceForm;
     FTargetForm := ATargetForm;
end;

{ TLinkedFormsList ------------------------------------------------------- }

procedure TLinkedFormsList.Clear;

var  I  : Integer;

begin
     For I := 0 to Count - 1 do
       TLinkedFormsItem( Items[ I ] ).Free;
     inherited;
end;

procedure TLinkedFormsList.Add( ASourceForm,
                                ATargetForm    : TgxForm );
begin
     inherited Add( TLinkedFormsItem.Create( ASourceForm, ATargetForm ) );
end;

procedure TLinkedFormsList.Remove( ASourceForm,
                                   ATargetForm    : TgxForm );

var  I : Integer;
     LinkedFormsItem : TLinkedFormsItem;

begin
     With LinkedFormsList do
       For I := 0 to Count - 1 do
         begin
         LinkedFormsItem := TLinkedFormsItem( Items[ I ] );
         If   Assigned( LinkedFormsItem )
         then If   ( ( ASourceForm=nil ) or ( LinkedFormsItem.FSourceForm=ASourceForm ) ) and
                   ( LinkedFormsItem.FTargetForm=ATargetForm )
              then begin
                   TLinkedFormsItem( Items[ I ] ).Free;
                   Delete( I );
                   Pack;
                   Break;
                   end;
         end;
end;

procedure TLinkedFormsList.ReleaseTargets( ASourceForm : TgxForm );

var  I : Integer;
     LinkedFormsItem : TLinkedFormsItem;
     QueryPanel : TgQueryPanel;

begin
     With LinkedFormsList do
       begin
       For I := 0 to Count - 1 do
         begin
         LinkedFormsItem := TLinkedFormsItem( Items[ I ] );
         If   Assigned( LinkedFormsItem )
         then With LinkedFormsItem do
                If   FSourceForm=ASourceForm
                then begin
                     QueryPanel := TgQueryPanel( FindComponentByClass( FTargetForm, TgQueryPanel ) );
                     If   Assigned( QueryPanel ) and ( QueryPanel.Detached ) // and ( QueryPanel.PersistentQuery ) and Assigned( QueryPanel.OnUserSelection )
                     then begin
                          TLinkedFormsItem( Items[ I ] ).Free;
                          Put( I, nil );  // Lo marco como nulo, ya se eliminará de la lista al empaquetar al final
                          // QueryPanel.Detached := True;
                          end
                     else With FTargetForm do
                            If   not ( csDestroying in ComponentState )
                            then Release;
                     end;
         end;
       Pack;
       end;
end;

function TLinkedFormsList.FindForm( ASourceForm  : TCustomForm;
                                    FormClass    : TgxFormClass ) : TgxForm;

var  I : Integer;
     LinkedFormsItem : TLinkedFormsItem;

begin
     Result := nil;
     With LinkedFormsList do
       For I := 0 to Count - 1 do
         begin
         LinkedFormsItem := TLinkedFormsItem( Items[ I ] );
         If   Assigned( LinkedFormsItem )
         then With LinkedFormsItem do
                If   FSourceForm=ASourceForm
                then If   FTargetForm.ClassType=FormClass
                     then begin
                          Result := FTargetForm;
                          Break;
                          end;
         end;
end;

{ TgxScrollBoxPanel }

procedure TgxScrollBoxPanel.DoEnter;

var  Rows : SmallInt;
     Offset : Integer;

begin
     inherited;
     If   Assigned( FScrollBox )
     then If   FScrollBox.VertScrollBar.Visible
          then try

                 // Se trata de que los paneles no se muestren a medias

                 Rows := ( FScrollBox.Height div Height ) - 1;   // Las rejillas que caben en el ScrollBox, menos una, la actual
                 Offset := Top - FScrollBox.VertScrollBar.Position + Height;
                 If   FScrollBox.Height<Offset
                 then With FScrollBox.VertScrollBar do
                        Position := ( ( ( Top - ( Rows * Height ) ) div Increment ) * Increment ) - 1;

               except
                 end;
end;

procedure TgxScrollBoxPanel.DoExit;
begin
     DoOnExit;
end;

procedure TgxScrollBoxPanel.SetParent(AParent: TWinControl);
begin
     inherited;
     If   Assigned( AParent )
     then begin
          If   AParent is TcxScrollBox
          then FScrollBox := AParent as TcxScrollBox;
          PanelStyle.Active := True;
          Style.BorderStyle := ebsNone;
          end
     else FScrollBox := nil;

end;

//  Procedimientos comunes de TgxPasswordEdit y TgxDBPasswordEdit, porque derivar ambas clases de TcxCustomButtonEdit resultaría mas costoso

procedure PasswordEditCreate( ButtonEdit  : TcxCustomButtonEdit;
                              ClickEvent  : TcxEditButtonClickEvent;
                              ChangeEvent : TNotifyEvent );

var  EditButton : TcxEditButton;

begin
     With ButtonEdit do
       begin

       Properties.Buttons.Clear;

       EditButton := Properties.Buttons.Add;
       EditButton.Hint := 'Limpiar';
       EditButton.Kind := bkGlyph;

       EditButton := Properties.Buttons.Add;
       EditButton.Hint := 'Mostrar / ocultar la clave';
       EditButton.Kind := bkGlyph;

       Properties.OnButtonClick := ClickEvent;
       Properties.OnChange := ChangeEvent;
       end;
end;

procedure PasswordSwitchEchoMode( ButtonEdit : TcxCustomButtonEdit;
                                  ResetMode  : Boolean = False );

var  EchoMode : TcxEditEchoMode;

begin
     With ButtonEdit do
       If   Enabled
       then begin
            If   ResetMode
            then Tag := 1;
            If   Tag=0
            then EchoMode := eemNormal
            else EchoMode := eemPassword;
            Properties.EchoMode := EchoMode;
            If   ResetMode
            then Properties.Buttons[ 1 ].Enabled := False;
            Tag := 1 - Tag;
            end;
end;

procedure PasswordEditLoaded( ButtonEdit : TcxCustomButtonEdit );
begin
     SetImageFromList( ApplicationContainer.ButtonImageList, ButtonEdit.Properties.Buttons[ 0 ].Glyph, 69, 16 );
     SetImageFromList( ApplicationContainer.ButtonImageList, ButtonEdit.Properties.Buttons[ 1 ].Glyph, 70, 16 );

     PasswordSwitchEchoMode( ButtonEdit, True );
end;

{ TgxPasswordEdit }

constructor TgxPasswordEdit.Create(AOwner: TComponent);

var  EditButton : TcxEditButton;

begin
     inherited;
     PasswordEditCreate( Self, DoOnButtonClick, DoOnChange );
end;

procedure TgxPasswordEdit.Reset;
begin
     PasswordSwitchEchoMode( Self, True );
end;

procedure TgxPasswordEdit.DoOnButtonClick( Sender: TObject; AButtonIndex: Integer);
begin
     If   AButtonIndex=0
     then ClearAndPost
     else PasswordSwitchEchoMode( Self );
end;

procedure TgxPasswordEdit.DoOnChange( Sender : TObject );
begin
     Properties.Buttons[ 1 ].Enabled := True;
end;

procedure TgxPasswordEdit.Loaded;
begin
     inherited;

     PasswordEditLoaded( Self );
end;

{ TgxDBPasswordEdit }

constructor TgxDBPasswordEdit.Create(AOwner: TComponent);

var  EditButton : TcxEditButton;

begin
     inherited;
     PasswordEditCreate( Self, DoOnButtonClick, DoOnChange );
end;

procedure TgxDBPasswordEdit.Reset;
begin
     PasswordSwitchEchoMode( Self, True );
end;

procedure TgxDBPasswordEdit.DoOnButtonClick( Sender: TObject; AButtonIndex: Integer);
begin
     If   AButtonIndex=0
     then ClearAndPost
     else PasswordSwitchEchoMode( Self );
end;

procedure TgxDBPasswordEdit.DoOnChange( Sender : TObject );
begin
     Properties.Buttons[ 1 ].Enabled := True;
end;

procedure TgxDBPasswordEdit.Loaded;
begin
     inherited;

     PasswordEditLoaded( Self );
end;

initialization

  RegisterClasses( [ TApplicationForms,

                     TgxFormManager,
                     TgxForm,
                     TgxEditPanel,
                     TgxScrollBoxPanel,
                     TgxRangeBox,
                     TgxRedMarkBox,
                     TgxBlueMarkBox,
                     TgxLockRangeButton,
                     TgxPageControlNavigator,
                     TgxPageControlNavigatorButton,
                     TgxFilterPageControl ] );

  LinkedFormsList := TLinkedFormsList.Create;

finalization
   LinkedFormsList.Free;

end.

