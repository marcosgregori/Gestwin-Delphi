
{$R-}  // Es por la funci�n SendMessage( Handle, WM_SETICON, ICON_BIG, Icon.Handle ).
       // En Win32 LParam es un NativeInt y se producen errores de rango cuando el valor del handle es muy alto.

unit TouchQueryForm;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Generics.Collections,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,

  AppContainer,
  DB, nxDB, nxDBBase, nxllBde,
  Mask,

  cxGraphics, cxMemo, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxControls, cxContainer,
  cxEdit, cxStyles, cxGroupBox, cxRadioGroup, Menus, cxLookAndFeelPainters, cxButtons, dxSkinsCore, dxSkinsDefaultPainters,
  cxGridCustomView, cxGridCustomTableView, cxGridDBTableView, cxGrid, cxClasses, cxGridTableView,
  cxCalendar, cxDBEdit, cxLookAndFeels, cxLabel, cxTL, cxDBTL, cxTLData,
  cxSplitter, dxBar, dxmdaset,

  LibUtils,
  DataManager,
  AppForms,
  AppManager;

const HighPanel = 6;

type
  TDataEditEvent  = procedure( Target : TcxCustomEdit = nil ) of object;

  TTouchQueryPanel = class;

  TFieldPanelType = ( fpFixed, fpFocusedColumn, fpUser );

  TFieldPanel = class( TcxGroupBox )
    public
    Column : TcxGridDBColumn;
    SourceField : TField;
    IsARange : Boolean;
    FieldCtrl : array[ 0..1 ] of TcxCustomEdit;
    DataField : array[ 0..1 ] of TField;
    CloseButton : TcxButton;
    FieldPanelType : TFieldPanelType;
    end;

  TFilterFrame = class(TFrame)
    Data: TgxMemData;
    DataHoy: TDateField;
    DataSource: TDataSource;
    BackPanel: TcxGroupBox;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    Panel1: TcxGroupBox;
    DataPanel: TgxEditPanel;
    ButtonsPanel: TcxGroupBox;
    OkButton: TgBitBtn;
    CancelButton: TgBitBtn;
    CaptionPanel: TcxGroupBox;
    CaptionLabel: TcxLabel;
    FieldsButton: TcxButton;
    BarManager: TdxBarManager;
    procedure OkButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FrameExit(Sender: TObject);
    procedure RemoveFieldPanel( FieldPanel : TFieldPanel );
  private

    FFocusingFieldPanel : Boolean;
    FFilterFieldsPopupMenu : TdxBarPopupMenu;
    FDatasetInitialized : Boolean;

    procedure DoFilterMenuItemOnClick( Sender : TObject );

    function SetupFieldPanel( AColumn : TcxGridDBColumn; AFieldPanelType : TFieldPanelType; Field0 : TField = nil; Field1 : TField = nil ) : TFieldPanel;
    function SetupFieldPanelFromFieldName( FieldName : String; AFieldPanelType : TFieldPanelType; Field0 : TField = nil; Field1 : TField = nil ) : TFieldPanel;
    procedure UpdateFilterPopupChecks;
    procedure UpdateFrameHeight;
    procedure FocusFieldPanel( FieldPanel : TFieldPanel );
    procedure ClearGridFilter;
    procedure AddGridFilterItem(AFieldPanel: TFieldPanel);
    function SetupDatasetFilter( OnlyFixed : Boolean = False ) : Boolean;
    procedure UpdateFixedRangePanelData;
    function GetPanelByFieldName(Value: String): TFieldPanel;
    function GetFieldPanelHeight: Integer;
    function GetSourceFieldName( Field : TField ) : String;

  protected

    BottomMargin : SmallInt;

    procedure DoOnDateValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean );
    procedure DoOnDateQueryRequest( Sender: TcxCustomEdit );

  public

    FOwnerForm : TgxForm;
    FQueryPanel : TTouchQueryPanel;
    // FGridQueryFilter,
    FHasDateRange : Boolean;
    FFieldPanelList : TList< TFieldPanel >;
    FSQLString,
    FSQLWhere : String;
    FFromPos,
    FWherePos : SmallInt;
    FFiltered,
    FGridFiltered,
    FComplexSQLSentence : Boolean;

    FieldValuesArray : TFieldValuesArray;

    FOnSelected  : TBooleanEvent;
    FButtonPressed : Boolean;
    FFixedRangePanel,
    FFocusedColumnFieldPanel,
    FFirstFieldPanel : TFieldPanel;

    constructor Create( QueryPanel : TTouchQueryPanel; OnSelected : TBooleanEvent ); reintroduce;
    destructor Destroy; override;

    procedure SetupFrame;
    procedure ShowFrame( FirstTime : Boolean );
    procedure HideFrame( SaveState : Boolean );
    procedure ButtonPressed( IsOkButton : Boolean );
    procedure SaveFilterState;
    procedure ReadFilterState;
    procedure SetupFilterFieldsPopup;
    procedure CancelFilter;
    procedure RemoveFilterPanels;

    property HasDateRange : Boolean read FHasDateRange;
    property FieldPanelHeight : Integer read GetFieldPanelHeight;
  end;

  TTouchQueryPanel = class( TcxGroupBox )
    private
      FOwnerForm,
      FSourceForm : TgxForm;
      FSyncDataButton,
      FInitSearchButton,
      FSaveButton,
      FStandAloneButton : TcxButton;
      FSetupColumnsButton : TcxButton;
      FInitSearchQuery : Boolean;
      FGridTableView : TcxGridDBTableView;
      FLockedColumn,
      FSearchColumn : TcxGridDBColumn;
      FTreeList : TcxDBTreeList;
      FRecordButtonLink : TRecordButtonLink;
      FLockControl : TcxCustomEdit;
      FLockRange : Boolean;
      FDescriptionField,
      FSourceField,
      FSearchField,
      FFixedRangeField : TField;
      FLockRangeField : TField;
      FTargetControl : TcxCustomEdit;
      FSourceQuery : TnxQuery;
      FSourceTable : TnxTable;
      FSourceDataset : TnxDataset;
      FLinked,
      FDetached : Boolean;
      FTargetTable : TnxeTable;
      FEditingValue : Variant;
      FQueryBeforeOpen : TDataSetNotifyEvent;  // Guarda el evento original del FSourceQuery
      FQueryFieldsPopupMenu : TdxBarPopupMenu;
      FSettingTargetValue : Boolean;
      FFilterFrame : TFilterFrame;
      FSpliter : TcxSplitter;
      FSettingUp,
      FUsesSourceField,
      FFilterFrameVisible,
      FStaticSourceValue,
      FFormWidthAdjusted : Boolean;
      FInitialState : TQueryGridInitialState;
      FBarPopupMenu : TdxBarPopupMenu;
      FCustomQueryFormWidth : Boolean;        // Indica que el usuario a modificado y guardado una anchura personalizada de la ventana
      FMinQueryFormWidth : Integer;
      FQueryStateChanged : Boolean;           // Indica que se ha modificado el estado y que debe guardarse cuando se cierre la ventana
      FDateSelection : TDateSelection;
      FDateStart,
      FDateEnd : TDateTime;
      FNewTarget : Boolean;
      FVisibleFieldList,
      FFilterFieldList,
      FValueList : TStringList;
      FLockConnectorText,
      FLockEmptyText : String;

      FOnFormShow : TNotifyEvent;
      FOnUserSelection,
      FOnSQLSetup,
      FOnColumnsSetup,
      FAfterReadQueryState : TSimpleEvent;
      FOnDataSelected : TDataEditEvent;
      FOnColumVisibilityChanged : TColumVisibilityChangedEvent;

      procedure SetInitSearchQuery( const Value : Boolean );

      procedure DoOnQueryBeforeOpen( Sender : TDataset );
      procedure DoOnUserSelection;
      procedure DoExpandGroups( Sender : TObject );
      procedure DoCollapseGroups( Sender : TObject );
      procedure DoTreeListFocusedNodeChanged(Sender: TcxCustomTreeList; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
      procedure DoTreeListDblClick(Sender: TObject);

    protected

      procedure DoSynchronizeDataClick( Sender : TObject );
      procedure DoInitSearchClick( Sender : TObject );
      procedure DoSaveClick( Sender : TObject );
      procedure DoStandAloneClick( Sender : TObject );

      procedure DoGridTableViewFocusedRecordChanged( Sender : TcxCustomGridTableView; aPrevFocusedRecord, aFocusedRecord : TcxCustomGridRecord; aNewItemRecordFocusingChanged : Boolean );
      // procedure doGridTableViewDblClick( Sender : TObject );
      procedure DoGridTableViewCellClick( Sender: TcxCustomGridTableView; ACellViewInfo : TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean );
      procedure DoGridTableViewCellDblClick( Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean );
      procedure DoControlKeyDown( Sender : TObject; var Key : Word; Shift : TShiftState );
      procedure DoGridTableViewFocusedItemChanged( Sender : TcxCustomGridTableView; APrevFocusedItem, AFocusedItem : TcxCustomGridTableItem );
      procedure DoGridDBTableViewColumnHeaderClick( Sender : TcxGridTableView; AColumn : TcxGridColumn );
      procedure DoGridTableViewColumnSizeChanged( Sender : TcxGridTableView; AColumn : TcxGridColumn );

      procedure DoOnGridEnter( Sender : TObject );
      procedure DoOnGridExit( Sender : TObject );

      procedure DoQueryMenuItemOnClick( Sender : TObject );

      procedure Notification( AComponent : TComponent;Operation  : TOperation );  override;

      procedure SetQueryFormWidth( ResetFormWidth : Boolean = False );
      procedure SetGridTableView( const Value : TcxGridDBTableView );
      procedure SetTreeList( const Value : TcxDBTreeList );
      procedure SetupQueryFieldsPopup;
      procedure SetSourceField( const Value : TField );
      procedure SetLinked( const Value : Boolean );
      procedure SetDetached( const Value : Boolean );
      procedure SetSourceQuery( const Value : TnxQuery );
      // procedure SetupQueryParams;
      procedure DataSelected;
      procedure ReadQueryState;
      procedure CloseQueryForm;

      procedure DoOnFormClose(Sender: TObject; var Action: TCloseAction);
      procedure DoOnFormActivate(Sender: TObject);
      procedure DoOnFormDeactivate(Sender: TObject);
      procedure DoOnFormDestroy(Sender: TObject);
      procedure DoOnFormKeyDown( Sender : TObject; var Key : Word; Shift : TShiftState );
      procedure DoOnFormKeyPress( Sender : TObject; var Key : Char);
      procedure DoOnFormResize( Sender : TObject );

      procedure DoOnColumnsSetup;

    public

      constructor Create( AOwner : TComponent ); override;
      destructor Destroy; override;

      procedure SaveQueryState;
      procedure Setup( LockRangeField : TField; EditControl : TcxCustomEdit; InitialState : TQueryGridInitialState = qgsNormal; ADateSelection : TDateSelection = dsFrom30DaysAgo; ADateStart : TDateTime = 0; ADateEnd : TdateTime = 0 );
      procedure UpdateSearchColumn( InvalidateForCustomization : Boolean = True );
      procedure UpdateTargetControl( EditControl : TcxCustomEdit );
      procedure SyncData;
      function LinkToTarget : Boolean;
      procedure ShowFilterFrame( Setup : Boolean = False );
      procedure CancelFilter;
      procedure DoOnFilterFrameProcess( const Accepted : Boolean );
      procedure DoOnSQLSetup;

      property EditingValue : Variant read FEditingValue write FEditingValue;
      property DateSelection : TDateSelection read FDateSelection;
      property DateStart : TDateTime read FDateStart;
      property DateEnd : TDateTime read FDateEnd;
      property FilterFrame : TFilterFrame read FFilterFrame;
      property QueryFieldsPopupMenu : TdxBarPopupMenu read FQueryFieldsPopupMenu;
      property MinQueryFormWidth : Integer read FMinQueryFormWidth write FMinQueryFormWidth;
      property InitSearchQuery : Boolean read FInitSearchQuery write SetInitSearchQuery;
      property TargetControl : TcxCustomEdit  read FTargetControl write FTargetControl;
      property Linked : Boolean read FLinked  write SetLinked;
      property LockedColumn : TcxGridDBColumn read FLockedColumn;
      property LockRange : Boolean read FLockRange write FLockRange;
      property Detached : Boolean read FDetached write SetDetached;
      property CustomQueryFormWidth : Boolean read FCustomQueryFormWidth write FCustomQueryFormWidth;

      property OwnerForm : TgxForm read FOwnerForm;
      property SourceForm : TgxForm read FSourceForm;
      property UsesSourceField : Boolean read FUsesSourceField;

      property SyncDataButton : TcxButton read FSyncDataButton;
      property InitSearchButton : TcxButton read FInitSearchButton;
      property SaveButton : TcxButton read FSaveButton;
      property StandAloneButton : TcxButton read FStandAloneButton;

      property VisibleFieldList : TStringList read FVisibleFieldList;
      property FilterFieldList : TStringList read FFilterFieldList;
      property SourceDataset : TnxDataset read FSourceDataset;
      property ValueList : TStringList read FValueList;

    published

      property GridTableView : TcxGridDBTableView read FGridTableView write SetGridTableView;
      property TreeList : TcxDBTreeList read FTreeList write SetTreeList;
      property SearchField : TField read FSearchField write FSearchField;
      property DescriptionField : TField read FDescriptionField write FDescriptionField;
      property SourceField : TField read FSourceField write SetSourceField;
      property StaticSourceValue : Boolean read FStaticSourceValue write FStaticSourceValue default False;
      property FilterFrameVisible : Boolean read FFilterFrameVisible write FFilterFrameVisible default True;
      property FixedRangeField : TField read FFixedRangeField write FFixedRangeField;
      property SourceQuery : TnxQuery read FSourceQuery write SetSourceQuery;
      property SourceTable : TnxTable read FSourceTable write FSourceTable;
      property LockConnectorText : String read FLockConnectorText write FLockConnectorText;
      property LockEmptyText : String read FLockEmptyText write FLockEmptyText;

      property OnDataSelected : TDataEditEvent read FOnDataSelected write FOnDataSelected;
      property OnFormShow : TNotifyEvent read FOnFormShow write FOnFormShow;
      property OnColumnsSetup : TSimpleEvent read FOnColumnsSetup write FOnColumnsSetup;
      property OnSQLSetup : TSimpleEvent read FOnSQLSetup write FOnSQLSetup;
      property OnColumVisibilityChanged : TColumVisibilityChangedEvent read FOnColumVisibilityChanged write FOnColumVisibilityChanged;
      property OnUserSelection : TSimpleEvent read FOnUserSelection write FOnUserSelection;

      property AfterReadQueryState : TSimpleEvent read FAfterReadQueryState write FAfterReadQueryState;
      end;

    TcxQueryDBDateEdit = class( TcxDBDateEdit )
      private
        FFieldPanel : TFieldPanel;
      public
        property FieldPanel : TFieldPanel read FFieldPanel write FFieldPanel;
      end;

procedure CreateTouchQueryForm( FormClass : TgxFormClass; var Reference; LockRangeField : TField; EditControl : TcxCustomEdit; InitialState     : TQueryGridInitialState = qgsNormal; DateSelection : TDateSelection = dsFrom30DaysAgo; DateStart : TDateTime = 0; DateEnd : TDateTime = 0 ); overload;
procedure CreateTouchQueryForm( FormClass : TgxFormClass; var Reference; EditControl : TcxCustomEdit; InitialState : TQueryGridInitialState = qgsNormal; DateSelection : TDateSelection = dsFrom30DaysAgo; DateStart : TDateTime = 0; DateEnd : TDateTime = 0 ); overload;
procedure CreateTouchQueryForm( FormClass : TgxFormClass; var Reference ); overload;

implementation

{$R *.dfm}

uses   Variants,
       DateUtils,

       cxCheckBox,
       cxFilter,
       cxFilterDialog,
       cxFindPanel,
       cxDisplayButtonEdit,

       b_msg;

resourceString
       RsMsg1   = 'Campos de b�squeda';
       RsMsg3   = 'Ning�n registro coincide con el filtro indicado.';
       RsMsg4   = 'Los valores introducidos en el filtro no son v�lidos.';
       RsMsg5   = 'Vuelva a introducir el filtro verificando la sintaxis.';
       RsMsg6   = '�Est� seguro de que desea cerrar la ventana de consulta?';

       RsMsg8   = 'Campos opcionales';
       RsMsg9   = 'Unable to open table';  // No traducir
       RsMsg10  = 'Expandir';
       RsMsg11  = 'Mostrar las lineas de los grupos';
       RsMsg12  = 'Colapsar';
       RsMsg13  = 'Ocultar las lineas de los grupos';

       HintMsg2 = 'Sincronizar datos : actualizar autom�ticamente la ventana destino.'#13'Teclas [Ctrl]+[D]';
       HintMsg3 = 'Permite mostrar u ocultar otros campos de la consulta.'#13'Teclas [Ctrl]+[C]';
       HintMsg4 = 'Iniciar siempre la consulta indicando un'#13'filtro o texto de b�squeda.'#13'Teclas [Ctrl]+[L]';
       HintMsg5 = 'Guardar la estructura de consulta para su uso posterior.'#13'Teclas [Ctrl]+[S]';
       HintMsg6 = 'Hacer que la ventana sea permanente.'#13'La ventana de consulta no se cerrar� cuando'#13'seleccione un registro y el estado actual se'#13'conservar� en la pr�xima consulta.';
       HintMsg7 = 'A�adir o quitar campos adicionales de filtrado.'#13'Tecla [Ctrl]+[T].';

const DefaultFieldPanelHeight = 28;

procedure CreateTouchQueryForm(     FormClass        : TgxFormClass;
                                var Reference;
                                    LockRangeField   : TField;
                                    EditControl      : TcxCustomEdit;
                                    InitialState     : TQueryGridInitialState = qgsNormal;
                                    DateSelection    : TDateSelection = dsFrom30DaysAgo;
                                    DateStart        : TDateTime = 0;
                                    DateEnd          : TDateTime = 0 );
var  OwnerForm,
     TargetForm : TgxForm;
     Instance : TComponent;
     QueryPanel : TTouchQueryPanel;

procedure FindQueryPanel( AOwner : TComponent );
begin
     QueryPanel := TTouchQueryPanel( FindComponentByClass( AOwner, TTouchQueryPanel ) );
end;

begin

     If   Assigned( EditControl )
     then TargetForm := LinkedFormsList.FindForm( GetParentForm( EditControl ), FormClass )
     else TargetForm := nil;

     If   Assigned( TargetForm )
     then begin
          With TargetForm do
            begin
            FindQueryPanel( TargetForm );
            If   Assigned( QueryPanel )
            then QueryPanel.UpdateTargetControl( EditControl );
            Visible := True;
            BringToFront;
            SetFocus;
            end;
          end
     else try
            OwnerForm := nil;
            Instance := TComponent( FormClass.NewInstance );
            TComponent( Reference ) := Instance;
            try
              Instance.Create( Application.MainForm );
              FindQueryPanel( Instance );
              OwnerForm := TgxForm( Instance );

              With OwnerForm do
                begin
                FormType := fmQuery;
                Visible := False;
                AdjustScale;

                BorderIcons := [];
                FormStyle := fsNormal;
                BorderStyle := bsNone;
                Parent := ApplicationContainer.QueryPanel;
                ManualDock( Parent );   // De esta forma la ventana recibe los eventos activate y deactivate

                Align := alClient;
                Visible := True;
                SetFocus;
                end;

              If   Assigned( QueryPanel )
              then QueryPanel.Setup( LockRangeField, EditControl, InitialState, DateSelection, DateStart, DateEnd );

            except On E : exception do
              begin
              If   Assigned( Instance )
              then With Instance do
                     If   not ( csDestroying in ComponentState )
                     then Free;
              If   E is EnxDatabaseError
              then begin

                   // Estoy intentando averiguar si es un error de 'tabla inexistente'

                   With EnxDatabaseError( E ) do
                     If   ErrorCode=DBIERR_NX_UNKNOWNEXCP
                     then If   Pos( RsMsg9, ErrorString )<>0
                          then raise EnxDatabaseError.nxCreate( DBIERR_INVALIDTABLENAME );

                   end
              else ShowException( E, nil );
              Abort;
              end;
            end;
          finally
            CleanFormValues;
            If   Assigned( OwnerForm )
            then OwnerForm.Visible := True;
            end;
end;

procedure CreateTouchQueryForm(     FormClass     : TgxFormClass;
                                var Reference;
                                    EditControl   : TcxCustomEdit;
                                    InitialState  : TQueryGridInitialState = qgsNormal;
                                    DateSelection : TDateSelection = dsFrom30DaysAgo;
                                    DateStart     : TDateTime = 0;
                                    DateEnd       : TDateTime = 0 );
begin
     CreateTouchQueryForm( FormClass, Reference, nil, EditControl, InitialState, DateSelection, DateStart, DateEnd );
end;

procedure CreateTouchQueryForm(     FormClass   : TgxFormClass;
                           var Reference );
begin
     CreateTouchQueryForm( FormClass, Reference, nil );
end;


{ TFilterFrame --------------------------------------------------------------- }

const MinFrameHeight = 60;
      MinQueryFormWidthWithDateRange = 335;

procedure TFilterFrame.CancelButtonClick(Sender: TObject);
begin
     ButtonPressed( False );
end;

constructor TFilterFrame.Create( QueryPanel : TTouchQueryPanel;
                                 OnSelected : TBooleanEvent );

var  Rect : TRect;

begin
     FQueryPanel := QueryPanel;
     FOwnerForm := FQueryPanel.OwnerForm;
     inherited Create( FOwnerForm );
     Parent := FOwnerForm;
     FOnSelected := OnSelected;
     FFieldPanelList := TList< TFieldPanel >.Create;
     FFilterFieldsPopupMenu := TdxBarPopupMenu.Create( FOwnerForm );
     FFilterFieldsPopupMenu.BarManager := Self.BarManager;
     TabOrder := 0;

     If   ApplicationContainer.AppUseSkins
     then begin
          Rect := ApplicationContainer.AppSkinPainter.GroupBoxBorderSize( True, cxgpTop );
          BottomMargin := ( Rect.Top + Rect.Bottom ) + 8;
          end
     else BottomMargin := 14;

end;

destructor TFilterFrame.Destroy;
begin
     FFieldPanelList.Free;
     inherited;
end;

procedure TFilterFrame.SaveFilterState;

var I : SmallInt;
    FieldPanel : TFieldPanel;

begin
     With FQueryPanel do
       If   not StaticSourceValue
       then begin

            For FieldPanel in FFieldPanelList do
              If   FieldPanel.FieldPanelType=fpUser
              then FilterFieldList.Add( GetSourceFieldName( FieldPanel.SourceField ) );

            If   Assigned( ValueList )
            then If   FHasDateRange
                 then begin
                      AddValueList( DataHoy, ValueList );
                      AddValueList( DataFechaInicial, ValueList );
                      AddValueList( DataFechaFinal, ValueList );
                      end;
            end;
end;

procedure TFilterFrame.FrameExit(Sender: TObject);
begin
     If   FOwnerForm.ActiveControl is TcxGridSite
     then If   not FButtonPressed // and TabKey
          then ButtonPressed( True );
     Visible := False;
     FQueryPanel.FSpliter.Visible := False;
end;

procedure TFilterFrame.ButtonPressed( IsOkButton : Boolean );

var  Inx,
     SearchFieldCount : SmallInt;
     FInvalidEdit : TcxCustoMEdit;

begin
     try
       FButtonPressed := True;
       If   IsOkButton
       then begin
            FInvalidEdit := DataPanel.ValidateEditControls( False, True );
            If   Assigned( FInvalidEdit )
            then begin
                 FInvalidEdit.SetFocus;
                 ShowHintMsg( RsgMsg396, '', FInvalidEdit );
                 Exit;
                 end;
            If   SetupDatasetFilter  // El filtro es correcto y se han encontrado registros
            then HideFrame( IsOkButton )
            else begin
                 FocusFieldPanel( FFirstFieldPanel );
                 Exit;
                 end;
            end;

       If   Assigned( FQueryPanel.GridTableView )
       then FQueryPanel.GridTableView.Site.Container.SetFocus
       else If   Assigned( FQueryPanel.TreeList )
            then FQueryPanel.TreeList.SetFocus;

     finally
       FButtonPressed := False;
       If   Assigned( ApplicationContainer.MainTopBar )
       then ApplicationContainer.MainTopBar.LockUpdate := False;  // Al darle el focus directamente al grid puede quedarse el TopBar desactivado
       end;
end;

procedure TFilterFrame.RemoveFilterPanels;

var  FIndex : SmallInt;
     FieldPanel : TFieldPanel;

begin
     For FIndex := FFieldPanelList.Count - 1 downto 0 do
       begin
       FieldPanel := FFieldPanelList[ FIndex ];
       If   FieldPanel.FieldPanelType<>fpFixed
       then RemoveFieldPanel( FieldPanel );
       end;
end;

procedure TFilterFrame.CancelFilter;
begin
     RemoveFilterPanels;
     SetupDatasetFilter( True );
     HideFrame( False );
     ApplicationContainer.EnableRecordButtons( True, True );
end;

procedure TFilterFrame.ClearGridFilter;
begin
     If   Assigned( FQueryPanel.GridTableView )
     then With FQueryPanel.GridTableView.DataController, Filter.Root do
            begin
            Filter.Active := False;
            Clear;   // Limpio los posibles filtros existentes en la rejilla
            Criteria.Options := [ fcoCaseInsensitive, fcoSoftNull, fcoSoftCompare, fcoIgnoreNull ];
            BoolOperatorKind := fboAnd;
            FGridFiltered := False;
            end;
end;

procedure TFilterFrame.AddGridFilterItem( AFieldPanel : TFieldPanel );

var  ItemList : TcxFilterCriteriaItemList;

procedure AddLikeFilter( Column    : TcxGridDBColumn;
                         SearchStr : String );

var  I : SmallInt;
     SubString : String;
     Conn : String;
     FilterCriteriaItem :TcxFilterCriteriaItem;

begin
     With ItemList do
       begin

       If   Pos( '%', SearchStr )=0
       then BoolOperatorKind := fboAnd
       else BoolOperatorKind := fboOr;

       I := 1;
       While ( I<=Length( SearchStr ) ) do
         begin
         SubString := ExtractSubString( SearchStr, I, ' ' );
         If   SubString<>''
         then begin
              If   Pos( '%', SubString )=0
              then SubString := '%' + SubString + '%';
              AddItem( Column, foLike, SubString, SubString );
              end;
         end;

       end;
end;

begin
     If   Assigned( FQueryPanel.GridTableView )
     then With AFieldPanel, FQueryPanel.GridTableView.DataController.Filter.Root do
            If   not ( ValueIsEmpty( DataField[ 0 ].Value ) ) and not( IsARange and ValueIsEmpty( DataField[ 1 ].Value ) )
            then begin
                 ItemList := AddItemList( fboAnd );
                 With ItemList do
                   If   IsARange
                   then begin
                        AddItem( Column, foGreaterEqual, DataField[ 0 ].Value, DataField[ 0 ].AsString );
                        AddItem( Column, foLessEqual, DataField[ 1 ].Value, DataField[ 1 ].AsString );
                        end
                   else AddLikeFilter( Column, DataField[ 0 ].AsString );
                 FGridFiltered := True;
                 end;
end;

function TFilterFrame.GetSourceFieldName( Field : TField ) : String;
begin
     If   Field.Origin=''
     then Result := Field.FieldName
     else Result := Field.Origin;
end;

function TFilterFrame.SetupDatasetFilter( OnlyFixed : Boolean = False ) : Boolean;

var  Inx : Integer;
     FieldName,
     FilterStr,
     CurrentSQLString,
     CurrentSQLWhere,
     SearchStr1,
     SearchStr2 : String;
     FieldPanel : TFieldPanel;
     MaxLength : SmallInt;

function GetLikeExpression( FieldName : String;
                            SearchStr : String ) : String;

var  I : SmallInt;
     SubString : String;
     Conn : String;

begin

     // Si el usuario introduce un caracter % en la expresi�n se utiliza el conector OR en lugar de AND porque las
     // expresiones del tipo '43% 45%' solo pueden significar que empiecen por 43 o 45, puesto que no pueden empezar
     // por ambos. Otras combinaciones son menos jugosas pero creo que el concepto sigue siendo v�lido.

     Result := '';
     If   Pos( '%', SearchStr )=0
     then Conn := ' AND '
     else Conn := ' OR ';
     I := 1;
     While ( I<=Length( SearchStr ) ) do
       begin
       SubString := ExtractSubString( SearchStr, I, ' ' );
       If   SubString<>''
       then begin
            If   Result<>''
            then Result := Result + Conn;
            If   Pos( '%', SubString )=0
            then SubString := QuotedStr( '%' + SubString + '%' )
            else SubString := QuotedStr( SubString );
            Result := Result + FieldName + ' LIKE ' + SubString + ' IGNORE CASE ';
            end;
       end;
end;

function ExtractValidStr( Value : String ) : String;
begin
     Result := StringReplace( Value, '''', '''''', [ rfReplaceAll ] );
end;

procedure AddStrField( Value : String );
begin
     If   FilterStr<>''
     then StrAdd( FilterStr, ' AND ' );
     StrAdd( FilterStr, Value );
end;

begin

     Result := False;

     With FQueryPanel do
       begin

       If   Assigned( GridTableView )
       then GridTableView.BeginUpdate;

       ClearGridFilter;

       FilterStr := '';
       FFiltered := False;
       FGridFiltered := False;                                                 

       // En algunas consultas utilizo una tabla como primera fuente de los datos para evitar leer todos los registros con el query

       try

         If   FSettingUp and Assigned( FSourceTable )
         then begin

              FSourceDataset := FSourceTable;

              GridTableView.DataController.DataSource.DataSet := FSourceTable;

              With FSourceTable do
                begin

                try
                  
                  DisableControls;

                  Open;

                  If   not ShiftKey and
                       Assigned( TargetControl ) and
                       ( IndexFieldCount=1 ) and
                       ( TargetControl.Properties is TcxCustomTextEditProperties )
                  then begin
                       MaxLength := TcxCustomTextEditProperties( TargetControl.Properties ).MaxLength;
                       If   Length( FEditingValue )<MaxLength
                       then SetRange( [ FEditingValue ], [ FEditingValue + HighStrCode ] );
                       end;

                finally
                  EnableControls;
                  end;

                end;

              end
         else With FSourceQuery do
                try

                  ReadOnly := True;
                  RequestLive := False;                  

                  FSourceDataset := FSourceQuery;

                  DisableControls;

                  try

                    Close;

                    CurrentSQLString := FSQLString;

                    // El campo de bloqueo limita la consulta a los valores del campo (de momento solo admito strings)

                    If   FLockRange
                    then AddStrField( GetSourceFieldName( FLockRangeField ) + '=' + QuotedStr( ExtractValidStr( FLockRangeField.AsString ) ) );

                    // En las consultas con SELECTS anidados se espera que el primer WHERE permita fijar el rango del par�metro fijo y
                    // para el resto se utiliza el filtro de la rejilla

                    For FieldPanel in FFieldPanelList do
                      With FieldPanel do
                        If   not ( OnlyFixed and ( FieldPanelType<>fpFixed ) )
                        then begin

                             If   ( SourceField.FieldKind=fkData ) and
                                  ( not FComplexSQLSentence or ( FComplexSQLSentence and ( FieldPanelType=fpFixed ) ) )
                             then begin

                                  FieldName := GetSourceFieldName( SourceField );
                                  SearchStr1 := ExtractValidStr( DataField[ 0 ].AsString );
                                  If   IsARange
                                  then begin
                                       case SourceField.DataType of
                                         ftSmallInt,
                                         ftInteger,
                                         ftFloat,
                                         ftCurrency,
                                         ftBCD      : begin
                                                      SearchStr2 := ExtractValidStr( DataField[ 1 ].AsString );
                                                      If   ( SearchStr1<>'' ) and ( SearchStr2<>'' )
                                                      then AddStrField( ' ( ' + FieldName + ' BETWEEN ' + SearchStr1 + ' AND ' + SearchStr2 + ' ) ' );
                                                      end;
                                         ftDate     : AddStrField( ' ( ' + FieldName + ' BETWEEN ' + SQLDateString( FieldCtrl[ 0 ].EditValue ) + ' AND ' + SQLDateString( FieldCtrl[ 1 ].EditValue ) + ' ) ' );
                                         ftDateTime : AddStrField( ' ( ' + FieldName + ' BETWEEN ' + SQLDateTimeString( FieldCtrl[ 0 ].EditValue ) + ' AND ' + SQLDateTimeString( FieldCtrl[ 1 ].EditValue ) + ' ) ' );
                                         end;
                                       end
                                  else If   SearchStr1<>''
                                       then If   SourceField.DataType in [ ftString, ftWideString ]
                                            then AddStrField( GetLikeExpression( FieldName, SearchStr1 ) )
                                            else AddStrField( FieldName + '=' + SearchStr1 );

                                  end
                             else AddGridFilterItem( FieldPanel );
                             FFiltered := FFiltered or ( FieldPanelType<>fpFixed );
                             end;
                         CurrentSQLWhere := '';
                         If   FSQLWhere=''
                         then begin
                              If   FilterStr<>''
                              then CurrentSQLWhere := FilterStr;
                              end
                         else begin
                              CurrentSQLWhere := FSQLWhere;
                              If   FilterStr<>''
                              then CurrentSQLWhere := CurrentSQLWhere + ' AND ' + FilterStr;
                              end;

                         If   CurrentSQLWhere<>''
                         then System.Insert( ' WHERE ' + CurrentSQLWhere, CurrentSQLString, FWherePos );
                                  
                    SQL.Text := CurrentSQLString;

                    Open;

                    {
                    If   Eof
                    then begin
                         ShowNotification( ntStop, RsMsg3, '' );
                         FFiltered := False;
                         Exit;
                         end;
                    }
                    // FFiltered := FilterStr<>'';

                    First;

                  except on E : Exception do
                    begin
                    ShowNotification( ntStop, RsMsg4, RsMsg5 );
                    ClearGridFilter;
                    FFiltered := False;
                    Exit;
                    end;
                  end;

                finally
                  EnableControls;
                  end;

         If   Assigned( GridTableView )
         then If   FGridFiltered
              then With FQueryPanel.GridTableView.DataController do
                     begin
                     Filter.Active := True;
                     DataModeController.GridMode := False;
                     end;

         FDatasetInitialized := True;
         Result := True;


       finally
         If   Assigned( GridTableView )
         then GridTableView.EndUpdate;
         end;

       end;

end;

procedure TFilterFrame.OkButtonClick(Sender: TObject);
begin
     ButtonPressed( True );
end;

procedure TFilterFrame.SetupFrame;

var  DaysFrom,
     DaysTo : Double;
     Inx,
     MaxLength : Integer;
     FieldPanel : TFieldPanel;
     UCSQLString : String;
     WhereStart,
     WhereEnd,
     WhereLength,
     NextCommandPos,
     AsCommandPos,
     SelectPos,
     Ds,
     De : SmallInt;

begin

     With FQueryPanel do
       If   Assigned( FSourceQuery )
       then begin

            //* 11.07.2010  He a�adido un delimitador del comando WHERE principal para evitar errores en sentencias complejas
            //              Hay que utilizar { y } para delimitar la expresi�n condicional de la siguiente forma (ejemplo) :
            //              SELECT * FROM Fichero WHERE{ Codigo=:Codigo } ORDER BY Nombre

            DoOnSQLSetup;

            FSQLString := StringReplace( FSourceQuery.SQL.Text, #13#10, ' ', [ rfReplaceAll, rfIgnoreCase ] );
            UCSQLString := AnsiUpperCase( FSQLString );
            FSQLWhere := '';

            Ds := Pos( 'WHERE{', FSQLString );
            If   Ds<>0
            then begin
                 De := Pos( '}', FSQLString );
                 FWherePos := Ds;
                 WhereLength := De - Ds;
                 FSQLWhere := Trim( Copy( FSQLString, Ds + 6, WhereLength - 6 ) );
                 System.Delete( FSQLString, Ds, WhereLength + 1 );
                 FComplexSQLSentence := True;
                 end
            else begin

                 // Intentando delimitar el �rea de la expresi�n WHERE

                 FFromPos :=  Pos( 'FROM ', UCSQLString );
                 FWherePos := Pos( 'WHERE ', UCSQLString );

                 NextCommandPos := Pos( 'GROUP BY ', UCSQLString );
                 If   NextCommandPos=0
                 then begin
                      NextCommandPos := Pos( 'HAVING ', UCSQLString );
                      If   NextCommandPos=0
                      then NextCommandPos := Pos( 'ORDER BY ', UCSQLString );
                      end;

                 AsCommandPos := Pos( ') AS ', UCSQLString );
                 If   ( AsCommandPos<>0 ) and ( AsCommandPos>FFromPos ) and( AsCommandPos<NextCommandPos )
                 then NextCommandPos := AsCommandPos;

                 If   FWherePos=0  // No hay comando WHERE
                 then begin
                      If   NextCommandPos=0
                      then FWherePos := Length( FSQLString ) + 1
                      else FWherePos := NextCommandPos - 1;
                      end
                 else begin
                      WhereStart := FWherePos;
                      If   NextCommandPos=0
                      then WhereEnd := Length( FSQLString ) + 1
                      else WhereEnd := NextCommandPos - 1;
                      WhereLength := WhereEnd - WhereStart;
                      FSQLWhere := Trim( Copy( FSQLString, WhereStart + 6, WhereLength - 6 ) );
                      System.Delete( FSQLString, WhereStart, WhereLength );
                      end;

                 SelectPos := Pos( 'SELECT ', UCSQLString ) + 7;
                 FComplexSQLSentence := Pos( 'SELECT ', Copy( UCSQLString, SelectPos, Length( UCSQLString ) ) )<>0;
                 end;
                 
            If   not FStaticSourceValue
            then begin

                 If   not Assigned( FixedRangeField ) and
                      Assigned( SourceField )
                 then FixedRangeField := SourceField;

                 If   Assigned( FQueryPanel.GridTableView )
                 then If   Assigned( FixedRangeField )
                      then With FixedRangeField do
                             If   DataType in [ ftDate, ftDateTime ]
                             then FFixedRangePanel := SetupFieldPanelFromFieldName( FieldName, fpFixed, DataFechaInicial, DataFechaFinal )
                             else FFixedRangePanel := SetupFieldPanelFromFieldName( FieldName, fpFixed );

                 end;

            FieldsButton.DropDownMenu := FFilterFieldsPopupMenu;
            FieldsButton.Hint := HintMsg7;

            SetupFilterFieldsPopup;

            UpdateFixedRangePanelData;

            If   TouchApplication or not ( FInitSearchQuery or FHasDateRange )
            then SetupDatasetFilter;
            
            end;

end;

procedure TFilterFrame.UpdateFixedRangePanelData;

var  DaysFrom,
     DaysTo : Double;
     MaxLength : Integer;

procedure DefaultDatesRange;
begin
     With FQueryPanel do
       case DateSelection of
         dsFrom30DaysAgo   : begin
                             DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;
                             DataFechaFinal.Value   := ApplicationContainer.TodayDate;
                             end;
         dsFromOneYearAgo  : begin
                             DataFechaInicial.Value := IncYear( ApplicationContainer.TodayDate, - 1 );
                             DataFechaFinal.Value   := ApplicationContainer.TodayDate;
                             end;
         dsToLastDayOfYear : begin
                             DataFechaInicial.Value := ApplicationContainer.TodayDate;
                             DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
                             end;
         end;
end;

begin

     Data.Edit;

     If   Assigned( FFixedRangePanel )
     then With FQueryPanel do
            begin

            FFixedRangePanel.TabOrder := 0;
            FFixedRangePanel.Top := 0;
            FHasDateRange := Assigned( FFixedRangePanel ) and ( FFixedRangePanel.SourceField.DataType in [ ftDate, ftDateTime ] );
            If   FHasDateRange
            then begin

                 MinQueryFormWidth := MinQueryFormWidthWithDateRange;

                 If   DateSelection=dsFixed
                 then begin
                      DataFechaInicial.Value := DateStart;
                      DataFechaFinal.Value := DateEnd;
                      end
                 else If   DataFechaInicial.IsNull
                      then DefaultDatesRange
                      else With FFixedRangePanel do
                             begin
                             // En este caso se supone que se han guardado los par�metros previamente
                             DaysFrom := DataHoy.Value - DataFechaInicial.Value;
                             DaysTo := DataFechaFinal.Value - DataHoy.Value;
                             If   ( DaysFrom>=0 ) and ( DaysFrom<=MaxDaysRange ) and
                                  ( DaysTo>=0 ) and ( DaysTo<=MaxDaysRange )
                             then begin
                                  DataFechaInicial.Value := ApplicationContainer.TodayDate - DaysFrom;
                                  DataFechaFinal.Value := ApplicationContainer.TodayDate + DaysTo;
                                  end
                             else DefaultDatesRange;
                             end;

                 {
                 DataFechaInicial.OnValidate := DoOnDateValidate;
                 DataFechaFinal.OnValidate := DoOnDateValidate;
                 }

                 end
            else If   FFixedRangePanel.SourceField.DataType in [ ftString, ftWideString ]
                 then begin
                      If   Assigned( TargetControl )
                      then begin
                           If   EditingValue<>''
                           then begin
                                MaxLength := TcxCustomTextEditProperties( TcxDBTextEdit( TargetControl ).Properties ).MaxLength;
                                With FFixedRangePanel.DataField[ 0 ] do
                                  If   ( Length( EditingValue )<MaxLength ) and not ShiftKey
                                  then Value := EditingValue + '%';
                                end;
                           end;
                      end
                 else If   FFixedRangePanel.SourceField.DataType in [ ftSmallInt, ftInteger ]
                      then With FFixedRangePanel do
                             begin
                             DataField[ 0 ].Value := GetMinFieldValue( SourceField );
                             DataField[ 1 ].Value := GetMaxFieldValue( SourceField );
                             end;

            end;

end;

function TFilterFrame.GetPanelByFieldName( Value : String ) : TFieldPanel;

var  FieldPanel : TFieldPanel;

begin
     Result := nil;
     For FieldPanel in FFieldPanelList do
       If   FieldPanel.SourceField.FieldName=Value
       then begin
            Result := FieldPanel;
            Break;
            end;
end;

procedure TFilterFrame.ShowFrame( FirstTime : Boolean );

var  DaysFrom,
     DaysTo : Double;
     Inx : Integer;
     FieldPanel : TFieldPanel;
     FocusedColumn : TcxgridDBColumn;
     FieldName : String;
     PrevFocusedColumnPanel : TFieldPanel;

begin

     With FQueryPanel do
       If   ( FSourceDataset=FSourceTable ) and
            Assigned( GridTableView ) and
            ( GridTableView.DataController.DataSource.DataSet=FSourceTable )
       then begin
            FSourceTable.Close;
            GridTableView.DataController.DataSource.DataSet := FSourceQuery;
            GridTableView.DataController.UpdateItems( True );
            FSourceDataset := FSourceQuery;
            end;


     FieldPanel := nil;
     PrevFocusedColumnPanel := FFocusedColumnFieldPanel;
     FFocusedColumnFieldPanel := nil;
     FocusedColumn := nil;
     FieldName := '';

     If   FirstTime
     then begin
          If   FQueryPanel.FInitSearchQuery and Assigned( FQueryPanel.SearchField )
          then FieldName := FQueryPanel.SearchField.FieldName;
          end
     else begin
          If   Assigned( FQueryPanel.GridTableView )
          then FocusedColumn := TcxGridDBColumn( FQueryPanel.GridTableView.Controller.FocusedColumn );
          If   Assigned( FocusedColumn )
          then FieldName := FocusedColumn.DataBinding.FieldName;
          end;

     If   FieldName<>''
     then begin

          FieldPanel := GetPanelByFieldName( FieldName );

          If   not Assigned( FieldPanel )
          then If   FirstTime
               then FieldPanel := SetupFieldPanelFromFieldName( FieldName, fpUser )
               else FieldPanel := SetupFieldPanel( FocusedColumn, fpFocusedColumn );

          If   not ShiftKey and Assigned( PrevFocusedColumnPanel ) and ( PrevFocusedColumnPanel<>FieldPanel ) and ( PrevFocusedColumnPanel.FieldPanelType=fpFocusedColumn )
          then RemoveFieldPanel( PrevFocusedColumnPanel );

          FFocusedColumnFieldPanel := FieldPanel;
          end;
         
     Data.Edit;

     UpdateFrameHeight;

     // Si el usuario pulsa <Shift> mientras solicita el acceso al panel del filtro la consulta se realiza sobre el dataset

     FQueryPanel.FSpliter.Visible := True;
     Visible := True;

     FOwnerForm.ActiveControl := Self;

     FFirstFieldPanel := nil;

     If   FirstTime and FHasDateRange
     then FFirstFieldPanel := FFixedRangePanel
     else FFirstFieldPanel := FieldPanel;

     UpdateFilterPopupChecks;

     FocusFieldPanel( FFirstFieldPanel );
end;

procedure TFilterFrame.FocusFieldPanel( FieldPanel : TFieldPanel );
begin
     If   Visible
     then try
            FFocusingFieldPanel := True;
            If   not Assigned( FieldPanel ) and ( FFieldPanelList.Count>0 )
            then FieldPanel := FFieldPanelList[ 0 ];
            If   Assigned( FieldPanel )
            then With FieldPanel.FieldCtrl[ 0 ] do
                   begin
                   FOwnerForm.Visible := True;
                   FOwnerForm.ActiveControl := FieldPanel.FieldCtrl[ 0 ]; // SetFocus;
                   If   Visible
                   then SetFocus;
                   SelectAll;
                   end;
          finally
            FFocusingFieldPanel := False;
            end;
end;

function TFilterFrame.GetFieldPanelHeight : Integer;
begin
     Result := ScaledToCurrent( DefaultFieldPanelHeight );
end;

procedure TFilterFrame.UpdateFrameHeight;

var  FrameHeight : SmallInt;

begin
     FrameHeight := ( ( FFieldPanelList.Count  ) * FieldPanelHeight ) + CaptionPanel.Height + BottomMargin;
     If   FrameHeight<MinFrameHeight
     then FrameHeight := MinFrameHeight;
     Height := FrameHeight;
end;

procedure TFilterFrame.HideFrame( SaveState : Boolean );
begin
     If   ShiftKey
     then ApplicationContainer.DeleteWindowState( FQueryPanel.OwnerForm )  // Se borra simplemente pulsando <Shift> cuando se cierra la ventana
     else If   SaveState
          then begin
               DataHoy.Value := ApplicationContainer.TodayDate;
               FQueryPanel.SaveQueryState;
               end;
     Visible := False;
     FQueryPanel.FSpliter.Visible := False;
end;

procedure TFilterFrame.DoOnDateValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean );

var FieldPanel : TFieldPanel;
    FechaInicial,
    FechaFinal : TcxEditValue;


begin
     FieldPanel := TcxQueryDBDateEdit( Sender ).FieldPanel;
     BlockDateOutRange( Sender, DisplayValue, FieldPanel.FieldCtrl[ 0 ], FieldPanel.FieldCtrl[ 1 ], ErrorText );
end;

procedure TFilterFrame.DoOnDateQueryRequest( Sender: TcxCustomEdit );
begin
     TcxDBDateEdit( Sender ).DroppedDown := True;
end;

function TFilterFrame.SetupFieldPanel( AColumn         : TcxGridDBColumn;
                                       AFieldPanelType : TFieldPanelType;
                                       Field0          : TField = nil;
                                       Field1          : TField = nil ) : TFieldPanel;

var  FieldPanel : TFieldPanel;
     FieldLabel : TcxLabel;
     CtrlWidth,
     CurrentLeft : Integer;
     DatasetActive : Boolean;
     Exceso : SmallInt;

function CreateControl( FieldPanel : TFieldPanel )  : TcxCustomEdit;

var  CheckBox : TcxDBCheckBox;
     DateEdit : TcxQueryDBDateEdit;

begin
     case FieldPanel.SourceField.DataType of
       ftSmallInt,
       ftInteger   : Result := TcxDBSpinEdit.Create( Self );
       ftBoolean   : begin
                     CheckBox := TcxDBCheckBox.Create( Self );
                     CheckBox.Transparent := True;
                     Result := CheckBox;
                     end;
       ftDate,
       ftDateTime  : begin
                     DateEdit := TcxQueryDBDateEdit.Create( Self );
                     DateEdit.Properties.Required := True;
                     DateEdit.Properties.OnQueryRequest := DoOnDateQueryRequest;
                     DateEdit.Properties.OnValidate := DoOnDateValidate;
                     DateEdit.FieldPanel := FieldPanel;
                     Result := DateEdit;
                     end;
       ftTime      : Result := TcxDBTimeEdit.Create( Self );
       else          Result := TcxDBTextEdit.Create( Self );                     
       end;
     If   Assigned( Result )
     then Result.Parent := FieldPanel;
end;

function GetDefaultWidth : SmallInt;
begin
     case FieldPanel.SourceField.DataType of
       ftBoolean  : Result := ScaledToCurrent( 12 );
       ftSmallInt : Result := ScaledToCurrent( 60 );
       else         Result := ScaledToCurrent( 100 );
       end;
end;

procedure CreateField( FieldIndex : SmallInt );

var  TargetField : TField;

begin
     case FieldPanel.SourceField.DataType of
         ftSmallInt : TargetField := TSmallIntField.Create( Self );
         ftInteger  : TargetField := TIntegerField.Create( Self );
         ftFloat    : TargetField := TFloatField.Create( Self );
         ftBoolean  : TargetField := TBooleanField.Create( Self );
         ftDate,
         ftDateTime : TargetField := TDateField.Create( Self );
         ftTime     : TargetField := TTimeField.Create( Self );
         else         TargetField := TStringField.Create( Self );
         end;

     With FieldPanel do
       begin
       DataField[ FieldIndex ] := TargetField;
       DataField[ FieldIndex ].FieldName := Format( 'Field%d', [ Data.FieldCount ] );
       If   FieldPanel.SourceField.DataType in [ ftString, ftWideString ]
       then DataField[ FieldIndex ].Size := 255;
       DataField[ FieldIndex ].DataSet := Data;
       end;

end;

begin
     Result := nil;
     DatasetActive := Data.Active;
     If   DatasetActive
     then FieldValuesArray := GetRecordFieldValues( Data );
     Data.Active := False;
     try
       FieldPanel := TFieldPanel.Create( Self );
       If   Assigned( FieldPanel )
       then begin

            FieldPanel.Parent := DataPanel;
             
            FieldPanel.PanelStyle.Active := True;
            FieldPanel.Style.BorderStyle := ebsNone;
            If   ApplicationContainer.AppUseSkins
            then begin
                 FieldPanel.Style.TransparentBorder := False;
                 FieldPanel.Transparent := True;
                 end;
            
            FieldPanel.Top := DataPanel.Height + 10;
            FieldPanel.Height := ScaledToCurrent( DefaultFieldPanelHeight );
            FieldPanel.Align := alTop;
            FieldPanel.Visible := False;

            FieldPanel.Column := AColumn;
            FieldPanel.SourceField := FieldPanel.Column.DataBinding.Field;
            FieldPanel.FieldPanelType := AFieldPanelType;

            FieldLabel := TcxLabel.Create( Self );
            FieldLabel.Parent := FieldPanel;

            FieldLabel.AutoSize := False;
            FieldLabel.Caption := ' ' + AColumn.Caption;
            FieldLabel.Transparent := True;
            FieldLabel.Width := ScaledToCurrent( 100 );
            FieldLabel.Align := alLeft;

            If   Assigned( Field0 )
            then FieldPanel.DataField[ 0 ] := Field0
            else CreateField( 0 );

            FieldPanel.FieldCtrl[ 0 ] := CreateControl( FieldPanel );

            With TcxDBEditDataBinding( FieldPanel.FieldCtrl[ 0 ].DataBinding ) do
              begin
              DataSource := Self.DataSource;
              DataField := FieldPanel.DataField[ 0 ].FieldName;
              end;

            If   FieldPanel.SourceField.DataType in [ ftString, ftWideString, ftBoolean ]  // No tienen rango
            then begin
                 If   FieldPanel.SourceField.DataType= ftBoolean
                 then TcxDBCheckBox( FieldPanel.FieldCtrl[ 0 ] ).ActiveProperties.NullStyle := nssUnchecked;
                 FieldPanel.FieldCtrl[ 0 ].Align := alClient;
                 end
            else begin

                 FieldPanel.IsARange := True;

                 FieldPanel.FieldCtrl[ 0 ].Width := GetDefaultWidth;
                 FieldPanel.FieldCtrl[ 0 ].Left := FieldLabel.Width;
                 FieldPanel.FieldCtrl[ 0 ].Align := alLeft;

                 // CurrentLeft := FieldPanel.FieldCtrl[ 0 ].Left + FieldPanel.FieldCtrl[ 0 ].Width + 4;

                 If   Assigned( Field1 )
                 then FieldPanel.DataField[ 1 ] := Field1
                 else CreateField( 1 );

                 FieldPanel.FieldCtrl[ 1 ] := CreateControl( FieldPanel );

                 FieldPanel.FieldCtrl[ 1 ].Left := FieldLabel.Width + FieldPanel.FieldCtrl[ 0 ].Width; // CurrentLeft;
                 // FieldPanel.FieldCtrl[ 1 ].Top := 1;
                 FieldPanel.FieldCtrl[ 1 ].Width := GetDefaultWidth;
                 FieldPanel.FieldCtrl[ 1 ].AlignWithMargins := True;
                 FieldPanel.FieldCtrl[ 1 ].Margins.SetBounds( 2, 0, 0, 0 );
                 FieldPanel.FieldCtrl[ 1 ].Align := alLeft;

                 With TcxDBEditDataBinding( FieldPanel.FieldCtrl[ 1 ].DataBinding ) do
                   begin
                   DataSource := Self.DataSource;
                   DataField := FieldPanel.DataField[ 1 ].FieldName;
                   end;

                 end;

            {
            If   AFieldPanelType<>fpFixed
            then begin
                 CloseButton := TcxButton.Create( Self );
                 With CloseButton do
                   begin
                   Parent := FieldPanel;
                   Anchors := [ akTop, akRight ];
                   Top := 2;
                   Left := FieldPanel.Width - 24;
                   Width := 22;
                   Height := 22;
                   ApplicationContainer.ButtonImageList.GetImage( 5, Glyph );
                   end;
                 end;
            }

            FFieldPanelList.Add( FieldPanel );

            FieldPanel.Visible := True;

            Result := FieldPanel;
            end;

     finally
       Data.Active := DatasetActive;
       If   DatasetActive
       then SetRecordFieldValues( Data, FieldValuesArray );
       {
       If   FieldPanel.SourceField.DataType  in [ ftSmallInt, ftInteger ]
       then case FieldIndex of
              0 : DataField[ FieldIndex ].Value := GetMinFieldValue( FieldPanel.SourceField );
              1 : DataField[ FieldIndex ].Value := GetMaxFieldValue( FieldPanel.SourceField );
              end;
       }
     end;

end;

function TFilterFrame.SetupFieldPanelFromFieldName( FieldName       : String;
                                                    AFieldPanelType : TFieldPanelType;
                                                    Field0          : TField = nil;
                                                    Field1          : TField = nil ) : TFieldPanel;

var  Column : TcxGridDBColumn;

begin
     Result := nil;
     Column := FQueryPanel.GridTableView.GetColumnByFieldName( FieldName );
     If   Assigned( Column )
     then Result := SetupFieldPanel( Column, AFieldPanelType, Field0, Field1 );
end;

procedure TFilterFrame.UpdateFilterPopupChecks;

var  I, Inx : Integer;

begin
     With FFilterFieldsPopupMenu.ItemLinks do
       begin
       BeginUpdate;
       try
         For I := 0 to Count - 1 do
           If   Items[ I ].Item is TdxBarButton
           then With TdxBarButton( Items[ I ].Item ) do
                  Down := Assigned( GetPanelByFieldName( Hint ) );  // En Hint est� el FieldName
       finally
         EndUpdate;
         end;
       end;

end;

procedure TFilterFrame.ReadFilterState;

var  I : Integer;
     FieldName : String;

begin

     With FQueryPanel, FFilterFieldsPopupMenu.ItemLinks do
       begin
       BeginUpdate;
       try
         For I := 1 to Count - 1 do
           If   Items[ I ].Item is TdxBarButton
           then With TdxBarButton( Items[ I ].Item ) do
                  begin
                  FieldName := Hint;
                  Down := FQueryPanel.FilterFieldList.IndexOf( FieldName )<>-1;
                  If   Down
                  then SetupFieldPanelFromFieldName( FieldName, fpUser );
                  end;
       finally
         EndUpdate;
         end;
       end;

     {  Desactivado hasta que averigue que funci�n ten�a originalmente (en serio, no lo recuerdo)

     With FQueryPanel do
       begin
       Data.Edit;
       SetDatasetValues( Data, ValueList, OwnerForm );
       end;
     }

end;

procedure TFilterFrame.SetupFilterFieldsPopup;

var I : SmallInt;
    MenuItem : TdxBarButton;
    ColumnField : TField;

begin
     With FQueryPanel do
       begin
       // FilterFieldsPopupMenu.Font.Size := GetScaledMenuFontSize;
       If   Assigned( GridTableView )
       then With GridTableView do
              For I := 0 to ColumnCount - 1 do
                begin
                ColumnField := Columns[ I ].DataBinding.Field;
                If   Assigned( ColumnField )
                then If   Assigned( Columns[ I ] ) and ( ColumnField<>FixedRangeField ) and not( ColumnField.DataType in [ ftBlob, ftMemo, ftGraphic, ftWideMemo ] )
                     then begin
                          MenuItem := Self.BarManager.AddButton;
                          If   Columns[ I ].HeaderHint<>''
                          then MenuItem.Caption := Columns[ I ].HeaderHint
                          else MenuItem.Caption := Columns[ I ].Caption;
                          MenuItem.ButtonStyle := bsChecked;
                          MenuItem.Hint := Columns[ I ].DataBinding.FieldName;
                          MenuItem.Down := False;
                          MenuItem.OnClick := DoFilterMenuItemOnClick;
                          FFilterFieldsPopupMenu.ItemLinks.Add( MenuItem );
                          end;
                end;
       end;
end;

procedure TFilterFrame.RemoveFieldPanel( FieldPanel : TFieldPanel );
begin
     If   Assigned( FieldPanel )
     then begin
          FFieldPanelList.Remove( FieldPanel );
          FieldPanel.Free;
          If   FFirstFieldPanel=FieldPanel
          then FFirstFieldPanel := nil;
          end;
end;

procedure TFilterFrame.DoFilterMenuItemOnClick( Sender : TObject );
begin
     If   Sender is TdxBarButton
     then With Sender as TdxBarButton do
            begin
            RemoveFieldPanel( GetPanelByFieldName( Hint ) );  // Por si acaso
            If   Down
            then FocusFieldPanel( SetupFieldPanelFromFieldName( Hint, fpUser ) );
            FQueryPanel.FQueryStateChanged := True;
            end;
     UpdateFrameHeight;
end;

{ TTouchQueryPanel ------------------------------------------------------- }

constructor TTouchQueryPanel.Create( AOwner : TComponent );

var MenuItem : TdxBarButton;

procedure CreateFlatButton( var AButton  : TcxButton;
                                ImgIndex : SmallInt );
begin
     AButton := TcxButton.Create( FOwnerForm );
     If   Assigned( AButton )
     then With AButton do
            begin
            Parent := Self;
            Width := 32;
            Height := 32;
            Align := alRight;
            AlignWithMargins := True;
            Margins.SetBounds( 6, 0, 0, 0 );
            SpeedButtonOptions.CanBeFocused := False;
            SpeedButtonOptions.Flat := True;
            SpeedButtonOptions.Transparent := True;
            AllowAllUp := True;
            ShowHint := True;

            ApplicationForms.ControlsImageList.GetImage( ImgIndex, Glyph );
            NumGlyphs := 1;
            end;
end;

begin

     inherited;

     // Opciones de apariencia por defecto

     PanelStyle.Active := True;
     Style.BorderStyle := ebsNone;
     Align := alBottom;
     Height := 36;
     Caption := '';
     BevelOuter := bvLowered;

     FVisibleFieldList := TStringList.Create;
     FFilterFieldList := TStringList.Create;
     FValueList := TStringList.Create;
     FMinQueryFormWidth := ScaledToCurrent( 270 );
     FFilterFrameVisible := True;
     FStaticSourceValue := False;
     FFormWidthAdjusted := False;

     If   not IsDesignTime
     then begin

          If   Owner is TgxForm
          then FOwnerForm :=  Owner as TgxForm
          else raise Exception.Create( 'Los TTouchQueryPanel solo se pueden situar sobre un TgxForm.' );

          FOwnerForm.BorderIcons := [ biSystemMenu ];  // Solo close
          
          FFilterFrame := TFilterFrame.Create( Self, DoOnFilterFrameProcess );
          FFilterFrame.Align := alTop;

          FSpliter := TcxSplitter.Create( Self );
          FSpliter.AlignSplitter := salTop;
          FSpliter.Visible := False;
          FSpliter.Parent := FOwnerForm;
          FSpliter.Align := alTop;

          FQueryFieldsPopupMenu := TdxBarPopupMenu.Create( FOwnerForm );
          FQueryFieldsPopupMenu.BarManager := FFilterFrame.BarManager;
          With FQueryFieldsPopupMenu do
            begin
            MenuItem := FFilterFrame.BarManager.AddButton;
            MenuItem.Caption := RsMsg8;
            MenuItem.Enabled := False;
            ItemLinks.Add( MenuItem );
            end;

          With FOwnerForm do
            begin

            KeyPreview := True;
            Constraints.MinWidth := ScaledToCurrent( 300 );
            
            Icon := ApplicationForms.QueryIcon.Picture.Icon;
            SendMessage( Handle, WM_SETICON, ICON_BIG, Icon.Handle );
                        
            OnKeyDown := DoOnFormKeyDown;
            OnKeyPress := DoOnFormKeyPress;

            OnClose := DoOnFormClose;
            OnActivate := DoOnFormActivate;
            OnDeactivate := DoOnFormDeactivate;
            OnDestroy := DoOnFormDestroy;
            OnResize := DoOnFormResize;

            end;

          FSetupColumnsButton := TcxButton.Create( Self );
          With FSetupColumnsButton do
            begin
            Parent := Self;
            Width := 37;
            Align := alLeft;
            GroupIndex := 0;
            Kind := cxbkOfficeDropDown;
            Visible := False;
            Hint := HintMsg3;
            ApplicationForms.ControlsImageList.GetImage( 3, Glyph );
            OptionsImage.Margin := 2;
            SpeedButtonOptions.Flat := True;
            SpeedButtonOptions.Transparent := True;
            DropDownMenu := FQueryFieldsPopupMenu;
            CanBeFocused := False;
            end;

          //* 24.01.2010  Nuevos botones para manejar las consultas independientes

          CreateFlatButton( FSaveButton, 7 );
          With FSaveButton do
            begin
            Visible := False;
            Hint := HintMsg5;
            OnClick := DoSaveClick;
            end;

          CreateFlatButton( FStandAloneButton, 19 );
          With FStandAloneButton do
            begin
            Visible := False;
            Hint := HintMsg6;
            OnClick := DoStandAloneClick;
            end;

          CreateFlatButton( FInitSearchButton, 2 );
          With FInitSearchButton do
            begin
            GroupIndex := 3;
            Hint := HintMsg4;
            OnClick := DoInitSearchClick;
            end;

          CreateFlatButton( FSyncDataButton, 1  );
          With FSyncDataButton do
            begin
            GroupIndex := 2;
            Hint := HintMsg2;
            OnClick := DoSynchronizeDataClick;
            end;

          // FSourceForm := TgxForm( Application.MainForm.ActiveMDIChild );

          end;
end;

destructor TTouchQueryPanel.Destroy;
begin
     FVisibleFieldList.Free;
     FFilterFieldList.Free;
     FValueList.Free;
     inherited;
end;

procedure TTouchQueryPanel.Notification( AComponent : TComponent; Operation : TOperation );
begin
     inherited Notification( AComponent, Operation );
     If   Operation=opRemove
     then If   AComponent=FGridTableView
          then FGridTableView := nil
          else If   AComponent=FTreeList
               then FTreeList := nil
               else If   AComponent=FDescriptionField
                    then FDescriptionField := nil
                    else If   AComponent=FSourceField
                         then FSourceField := nil
                         else If   AComponent=FSearchField
                              then FSearchField := nil
                              else If   AComponent=FFixedRangeField
                                   then FFixedRangeField := nil
                                   else If   AComponent=FSourceQuery
                                        then FSourceQuery := nil
                                        else If   AComponent=FSourceTable
                                             then FSourceTable := nil;
end;

procedure TTouchQueryPanel.SetGridTableView( const Value : TcxGridDBTableView );
begin
     If   Assigned( FGridTableView )
     then With FGridTableView do
            begin
            OnDblClick := nil;
            OnFocusedRecordChanged := nil;
            OnKeyDown := nil;
            end;

     FGridTableView := Value;

     If   Assigned( FGridTableView )
     then With FGridTableView do
            begin

            FRecordButtonLink := TRecordButtonLink.Create( Self );
            LinkedComponent := FRecordButtonLink;
            FilterBox.Visible := fvNever;

            OptionsSelection.CellSelect := True;
            DataController.DataModeController.GridMode := True;   // La situaci�n cambia cuando se aplica un filtro
            DataController.DataModeController.SyncMode := True;
            OptionsCustomize.ColumnFiltering := False;
            OptionsCustomize.ColumnSorting := False;
            OnCellClick := DoGridTableViewCellClick;
            OnCellDblClick := DoGridTableViewCellDblClick;
            OnFocusedRecordChanged := DoGridTableViewFocusedRecordChanged;
            OnKeyDown := DoControlKeyDown;
            OnFocusedItemChanged  := DoGridTableViewFocusedItemChanged;
            OnColumnHeaderClick := DoGridDBTableViewColumnHeaderClick;
            OnColumnSizeChanged := DoGridTableViewColumnSizeChanged;

            If   Site.Container is TcxGrid
            then With TcxGrid( Site.Container ) do
                   begin
                   OnEnter := DoOnGridEnter;
                   OnExit := DoOnGridExit;
                   end;

            If   not Assigned( ApplicationContainer.AppSkinPainter )
            then Styles.ContentEven := ApplicationContainer.QueryContentEvenStyle;

            end;
end;

procedure TTouchQueryPanel.SetTreeList( const Value : TcxDBTreeList );
begin

     If   Assigned( FTreeList )
     then With FTreeList do
            begin
            OnDblClick := nil;
            OnFocusedNodeChanged := nil;
            OnKeyDown := nil;
            end;

     FTreeList := Value;

     If   Assigned( FTreeList )
     then With FTreeList do
            begin

            FRecordButtonLink := TRecordButtonLink.Create( Self );

            OptionsSelection.CellSelect := True;
            OptionsData.Editing := False;

            OnFocusedNodeChanged := DoTreeListFocusedNodeChanged;
            OnDblClick := DoTreeListDblClick;
            OnKeyDown := DoControlKeyDown;

            If   not Assigned( ApplicationContainer.AppSkinPainter )
            then Styles.ContentEven := ApplicationContainer.QueryContentEvenStyle;

            end;
end;

procedure TTouchQueryPanel.DoTreeListFocusedNodeChanged( Sender            : TcxCustomTreeList;
                                                     APrevFocusedNode,
                                                     AFocusedNode      : TcxTreeListNode);
begin
     SyncData;
end;

procedure TTouchQueryPanel.DoTreeListDblClick( Sender : TObject );
begin
     DataSelected;
end;

procedure TTouchQueryPanel.DoGridDBTableViewColumnHeaderClick( Sender  : TcxGridTableView;
                                                           AColumn : TcxGridColumn);
begin

     // Inicialmente la rejilla está en modo GridMode (para acelerar la aparición de la primera ventana)
     // Si el usuario intenta ordenar una columna quito el modo GridMode para permitir la ordenación

     With FGridTableView do
       begin
       DataController.DataModeController.GridMode := False;
       OptionsCustomize.ColumnFiltering := True;
       OptionsCustomize.ColumnSorting := True;
       end;

end;

procedure TTouchQueryPanel.DoOnGridEnter( Sender : TObject );
begin
     ApplicationContainer.EnableRecordButtons( True, True, FilterFrame.FFiltered or FilterFrame.FGridFiltered );
end;

procedure TTouchQueryPanel.DoOnGridExit( Sender : TObject );
begin
     ApplicationContainer.EnableRecordButtons( False );
end;

procedure TTouchQueryPanel.DoGridTableViewColumnSizeChanged( Sender  : TcxGridTableView;
                                                             AColumn : TcxGridColumn );
begin
     FQueryStateChanged := True;
end;

procedure TTouchQueryPanel.SyncData;
begin
     If   MDIChildFormExists( FSourceForm )
     then begin
          If   FSyncDataButton.Down and Assigned( FSourceDataset )
          then With FTargetTable do
                 try
                   SaveRange;
                   CancelRange;
                   SetToDatasetPos( FSourceDataset );
                 finally
                   RestoreRange;
                   end;
          end
     else With FSyncDataButton do
            begin
            Down := False;
            Visible := False;
            end;
end;

procedure TTouchQueryPanel.SetQueryFormWidth( ResetFormWidth : Boolean = False );

var  GridWidth : Integer;
     CxBorder,
     I : SmallInt;

begin

     If   not FCustomQueryFormWidth or ResetFormWidth
     then begin

          GridWidth := 0;

          If  Assigned( FGridTableView )
          then With FGridTableView do
                 begin
                 DoOnColumnsSetup;
                 For I := 0 to ColumnCount - 1 do
                   If   Columns[ I ].Visible
                   then GridWidth := GridWidth + Columns[ I ].Width;
                 end
          else If   Assigned( FTreeList )
               then With FTreeList do
                      begin
                      For I := 0 to ColumnCount - 1 do
                        If   Columns[ I ].Visible
                        then GridWidth := GridWidth + Columns[ I ].Width;
                      end;

          GridWidth := Trunc( GridWidth * 1.2 );

          If   GridWidth <MinQueryFormWidth
          then GridWidth := MinQueryFormWidth
          else If   GridWidth>GetDesktopWidth
               then GridWidth := GetDesktopWidth;

          var PanelWidth := ScaledToCurrent( GridWidth );

          ApplicationContainer.QueryPanel.Left := GetDesktopWidth - PanelWidth;
          ApplicationContainer.QueryPanel.Width := PanelWidth;
          ApplicationContainer.QueryPanel.Visible := True;
          ApplicationContainer.QueryPanel.BringToFront;

          end;

     FFormWidthAdjusted := True;
end;

procedure TTouchQueryPanel.SetupQueryFieldsPopup;

var I : SmallInt;
    MenuItem : TdxBarButton;
    ColumnField : TField;

begin
     If   Assigned( FGridTableView )
     then With FGridTableView do
            For I := 0 to ColumnCount - 1 do
              If   Assigned( Columns[ I ] ) and ( ( ( Columns[ I ].VisibleForCustomization ) or ( FGridTableView.Preview.Column=Columns[ I ] ) ) )
              then begin
                   ColumnField := Columns[ I ].DataBinding.Field;
                   If    ( ColumnField<>FSourceField ) and
                         // ( ColumnField<>FSearchField ) and
                         ( ColumnField<>FFixedRangeField )
                   then begin
                        MenuItem := FFilterFrame.BarManager.AddButton;

                        // En ocasiones el título de la columna no es lo bastante explícito por el espacio disponible.
                        // En esos casos se puede poner una descripci�n más completa en HeaderHint

                        If   Columns[ I ].HeaderHint<>''
                        then MenuItem.Caption := Columns[ I ].HeaderHint
                        else MenuItem.Caption := Columns[ I ].Caption;

                        MenuItem.ButtonStyle := bsChecked;
                        MenuItem.Hint := Columns[ I ].DataBinding.FieldName;
                        MenuItem.Down := Columns[ I ].Visible; // False;
                        MenuItem.OnClick := DoQueryMenuItemOnClick;
                        FQueryFieldsPopupMenu.ItemLinks.Add( MenuItem );
                        FSetupColumnsButton.Visible := True;
                        end;
                   end;

end;

procedure TTouchQueryPanel.DoQueryMenuItemOnClick( Sender : TObject );

var Column : TcxGridDBColumn;

begin
     If   Sender is TdxBarButton
     then With Sender as TdxBarButton do
            begin
            Column := FGridTableView.GetColumnByFieldName( Hint );
            If   Assigned( Column )
            then begin
                 Column.Visible := Down;
                 If   FGridTableView.Preview.Column=Column
                 then FGridTableView.Preview.Visible := Down;
                 If   not FOwnerForm.Maximized
                 then SetQueryFormWidth;
                 FQueryStateChanged := True;
                 If   Assigned( FOnColumVisibilityChanged )
                 then FOnColumVisibilityChanged( Column );
                 end;
            end;
end;

procedure TTouchQueryPanel.DoOnColumnsSetup;
begin
     If   Assigned( FOnColumnsSetup )
     then FOnColumnsSetup;
end;

procedure TTouchQueryPanel.DoOnSQLSetup;
begin
     If   Assigned( FOnSQLSetup )
     then FOnSQLSetup;
end;

procedure TTouchQueryPanel.UpdateSearchColumn( InvalidateForCustomization : Boolean = True );
begin
     FSearchColumn := nil;
     If   Assigned( FGridTableView )
     then With FGridTableView do
            If   Assigned( FSearchField )
            then begin
                 FSearchColumn := GetColumnByFieldName( FSearchField.FieldName );                   
                 If   Assigned( FSearchColumn ) and InvalidateForCustomization
                 then FSearchColumn.VisibleForCustomization := False;                   
                 end;
end;

procedure TTouchQueryPanel.Setup( LockRangeField   : TField;
                                  EditControl      : TcxCustomEdit;
                                  InitialState     : TQueryGridInitialState = qgsNormal;
                                  ADateSelection   : TDateSelection = dsFrom30DaysAgo;
                                  ADateStart       : TDateTime = 0;
                                  ADateEnd         : TDateTime = 0 );
begin

     FSettingUp := True;
     FInitialState := InitialState;
     FLockRangeField := LockRangeField;
     FLockRange := False;

     try

       If   Assigned( EditControl )
       then begin
            FSourceForm := GetParentForm( EditControl ) as TgxForm;
            LinkedFormsList.Add( FSourceForm, FOwnerForm );
            UpdateTargetControl( EditControl );   // Antes de asignar Linked, porque necesita FTargetControl
            end;

       If   Assigned( LockRangeField ) and Assigned( FSourceForm )
       then begin
            If   ( FSourceForm.FormType=fmEdit ) and Assigned( FSourceForm.FormManager )
            then FLockRange := FSourceForm.FormManager.RangeLocked
            else FLockRange := not ValueIsEmpty( LockRangeField.Value );
            FLockControl := GetEditControlByFieldName( FSourceForm, LockRangeField.FieldName );
            FLockRange := FLockRange and not ShiftKey;
            end;

       Linked := InitialState in [ qgsLinked, qgsDetached ];

       FStandAloneButton.Visible := Linked and Assigned( FOnUserSelection );
       FInitSearchButton.Visible := not FStaticSourceValue and not Assigned( FTreeList );

       FDateSelection := ADateSelection;
       FDateStart := ADateStart;
       FDateEnd := ADateEnd;

       UpdateSearchColumn;                        
       SetupQueryFieldsPopup;
       ReadQueryState;
     
       FilterFrame.SetupFrame;

       If   Assigned( FGridTableView )
       then With FGridTableView do
              begin
              If   Assigned( FOwnerForm ) and not TouchApplication
              then FOwnerForm.ActiveControl := Site.Container;
              If   Assigned( FSearchColumn )
              then Controller.FocusedColumn := FSearchColumn
              else If   Assigned( OptionsBehavior.IncSearchItem )
                   then Controller.FocusedColumn := Columns[ OptionsBehavior.IncSearchItem.Index ];
              end;

       SetQueryFormWidth;

       If   Assigned( FTreeList )
       then FTreeList.FullExpand;

       If   FInitialState=qgsDetached
       then Detached := True;

       With FFilterFrame do
         If   FInitSearchQuery or HasDateRange
         then ShowFilterFrame( True );

     finally
       FSettingUp := False;
       end;
end;

procedure TTouchQueryPanel.UpdateTargetControl( EditControl : TcxCustomEdit );
begin
     FTargetControl := EditControl;
     FEditingValue := FTargetControl.DisplayingValue;
     FNewTarget := True;
end;

procedure TTouchQueryPanel.ShowFilterFrame( Setup : Boolean = False );
begin
     If   FFilterFrameVisible and Assigned( FSourceQuery ) and Assigned( FFilterFrame ) and Assigned( FGridTableView ) and not TouchApplication
     then FFilterFrame.ShowFrame( Setup );
end;

procedure TTouchQueryPanel.CancelFilter;
begin
     If   Assigned( FFilterFrame )
     then begin
          FFilterFrame.CancelFilter;
          If   Assigned( FGridTableView )
          then FGridTableView.Site.Container.SetFocus;
          end;
end;

procedure TTouchQueryPanel.DoOnFilterFrameProcess( const Accepted : Boolean );
begin
     If   Assigned( FSourceQuery )
     then FGridTableView.Site.Container.SetFocus;
end;

procedure TTouchQueryPanel.SaveQueryState;

var  I : SmallInt;
     BarButton : TdxBarButton;

begin
     If   not TouchApplication and FQueryStateChanged
     then begin
          VisibleFieldList.Clear;
          FilterFieldList.Clear;
          ValueList.Clear;
          With FQueryFieldsPopupMenu.ItemLinks do
            For I := 1 to Count - 1 do
              If   Items[ I ].Item is TdxBarButton
              then begin
                   BarButton := TdxBarButton( Items[ I ].Item );
                   If   BarButton.Down
                   then VisibleFieldList.Add( BarButton.Hint );  // En Hint está el nombre del campo
                   end;
          FFilterFrame.SaveFilterState;
          ApplicationContainer.SaveQueryConfig( Self );
          FQueryStateChanged := False;
          end;
end;

procedure TTouchQueryPanel.ReadQueryState;

var  I : SmallInt;
     Column : TcxGridDBColumn;

begin

     If   not TouchApplication
     then begin
          If   ApplicationContainer.ReadQueryConfig( Self )
          then begin

               With FQueryFieldsPopupMenu.ItemLinks do
                 try
                   BeginUpdate;
                   For I := 1 to Count - 1 do
                     If   Items[ I ].Item is TdxBarButton
                     then With TdxBarButton( Items[ I ].Item ) do
                            begin
                            Down := FVisibleFieldList.IndexOf( Hint )<>-1;
                            Column := FGridTableView.GetColumnByFieldName( Hint );
                            If   Assigned( Column )
                            then begin
                                 Column.Visible := Down;
                                 If   FGridTableView.Preview.Column=Column
                                 then FGridTableView.Preview.Visible := Down;
                                 end;
                            end;
                 finally
                   EndUpdate;
                 end;

               FFilterFrame.ReadFilterState;

               end;
          end;

     If   Assigned( FAfterReadQueryState )
     then FAfterReadQueryState;

     If   Assigned( FLockRangeField ) and FLockRange
     then begin

          With FOwnerForm do
            begin
            Caption := Caption + ' ' + FLockConnectorText + ' ' + IfThen( FLockRangeField.FieldName='', FLockEmptyText, FLockRangeField.AsString );
            Hint := Caption;
            ShowHint := True;
            end;

          FLockedColumn := FGridTableView.GetColumnByFieldName( FLockRangeField.FieldName );
          If   Assigned( FLockedColumn )
          then FLockedColumn.Visible := False;

          end;

end;

procedure TTouchQueryPanel.DoOnFormClose(Sender: TObject; var Action: TCloseAction);
begin
     SaveQueryState;
     Action := caFree;
end;

procedure TTouchQueryPanel.DoOnFormActivate(Sender: TObject);
begin
     If   Assigned( FGridTableView )
     then begin

          ActiveRecordButtonLink := FRecordButtonLink;

          With FFilterFrame do
            If   not FDetached and FNewTarget and not FFocusingFieldPanel
            then If   FInitSearchQuery or HasDateRange
                 then ShowFilterFrame( True );

          end;

     FNewTarget := False;
end;

procedure TTouchQueryPanel.DoOnFormDeactivate(Sender: TObject);
begin

     If   ( Screen.ActiveCustomForm.ClassType<>TcxFilterDialog ) and
          not( ( Screen.ActiveCustomForm<>FOwnerForm ) and
          not Assigned( Screen.ActiveCustomForm.Owner ) )
     then begin

          If   Assigned( FGridTableView )
          then ActiveRecordButtonLink := nil;

          If   not ( csDestroying in OwnerForm.ComponentState ) and    // Ya se est� cerrando
               not FDetached and
               not FSettingTargetValue
          then CloseQueryForm;

          end;
end;

procedure TTouchQueryPanel.CloseQueryForm;
begin
     If   TouchApplication
     then ApplicationContainer.QueryPanel.Visible := False;
     FOwnerForm.Close;
end;

procedure TTouchQueryPanel.DoOnFormDestroy(Sender: TObject);
begin
     LinkedFormsList.Remove( FSourceForm, FOwnerForm );
end;

procedure TTouchQueryPanel.DoExpandGroups( Sender : TObject );
begin
     FGridTableView.ViewData.Expand( True );
end;

procedure TTouchQueryPanel.DoCollapseGroups( Sender : TObject );
begin
     FGridTableView.ViewData.Collapse( True );
end;

procedure TTouchQueryPanel.DoSynchronizeDataClick( Sender : TObject );
begin
     SyncData;
end;

procedure TTouchQueryPanel.DoInitSearchClick( Sender : TObject );
begin
     FInitSearchQuery := FInitSearchButton.Down;
     FQueryStateChanged := True;
end;

procedure TTouchQueryPanel.DoSaveClick( Sender : TObject );
begin
     //
end;

procedure TTouchQueryPanel.DoStandAloneClick( Sender : TObject );
begin
     Detached := True;
end;

procedure TTouchQueryPanel.DoGridTableViewFocusedRecordChanged( Sender                        : TcxCustomGridTableView;
                                                            APrevFocusedRecord,
                                                            AFocusedRecord                : TcxCustomGridRecord;
                                                            ANewItemRecordFocusingChanged : Boolean );
begin
     If   not IsDesignTime
     then SyncData;
end;

procedure TTouchQueryPanel.SetSourceField( const Value : TField );

var  SourceColumn : TcxGridDBColumn;

procedure SetContentStyle( aStyle : TcxStyle );
begin
     If   Assigned( FSourceField ) and Assigned( FGridTableView )
     then With FGridTableView do
            begin
            SourceColumn := GetColumnByFieldName( FSourceField.FieldName );
            If   Assigned( SourceColumn )
            then begin
                 SourceColumn.Styles.Content := AStyle;                 
                 SourceColumn.VisibleForCustomization := False;                 
                 end;
            end;
end;

begin
     If   FSourceField<>Value
     then begin
          SetContentStyle( nil );
          FSourceField := Value;
          SetContentStyle( ApplicationContainer.QueryContentSourceColumnStyle );
          end;
end;

procedure TTouchQueryPanel.SetLinked( const Value : Boolean );
begin
     FLinked := Value;
     FTargetTable := nil;
     If   FLinked
     then If   Assigned( FTargetControl )
          then With FTargetControl do
                 If   DataBinding is TcxDBEditDataBinding
                 then With TcxDBEditDataBinding( DataBinding ) do
                        If   Assigned( DataSource ) and ( DataSource.Dataset is TnxeTable )
                        then FTargetTable := TnxeTable( DataSource.Dataset );
     FSyncDataButton.Enabled := Assigned( FTargetTable );
end;

procedure TTouchQueryPanel.SetDetached( const Value : Boolean );

var  MenuItem : TdxBarButton;

begin

     FDetached := Value;
     If   FDetached   // No se puede convertir un grid separado del form (Detached) a su estado por defecto
     then begin
          FInitSearchButton.Visible := False;
          FStandAloneButton.Visible := False;
          FSaveButton.Visible := False; // True;    De momento no est� implementado

          With FGridTableView do
            begin

            OptionsView.GroupByBox := True;

            {  No parece mucho m�s efectivo que el sistema actual (como solo funciona en GridMode es igualmente lento con gran cantidad de registros)

            FindPanel.DisplayMode := fpdmAlways;
            FindPanel.FocusViewOnApplyFilter := True;

            DataController.DataModeController.GridMode := False;
            }

            With OptionsCustomize do
              begin
              ColumnGrouping := True;
              ColumnMoving := True;
              ColumnFiltering := True;
              ColumnSorting := True;
              end;

            FBarPopupMenu := TdxBarPopupMenu.Create( OwnerForm );
            FBarPopupMenu.BarManager := FFilterFrame.BarManager;
            With FBarPopupMenu do
              begin
              MenuItem := FFilterFrame.BarManager.AddButton;
              MenuItem.Caption := RsMsg10;
              MenuItem.Hint := RsMsg11;
              MenuItem.OnClick := DoExpandGroups;
              ApplicationForms.ControlsImageList.GetImage( 8, MenuItem.Glyph );
              ItemLinks.Add( MenuItem );

              MenuItem := FFilterFrame.BarManager.AddButton;
              MenuItem.Caption := RsMsg12;
              MenuItem.Hint := RsMsg13;
              MenuItem.OnClick := DoCollapseGroups;
              ApplicationForms.ControlsImageList.GetImage( 9, MenuItem.Glyph );
              ItemLinks.Add( MenuItem );
              end;

            PopupMenu := FBarPopupMenu;
            end;

          // LinkedFormsList.Remove( FSourceForm, FOwnerForm );

          With OwnerForm do
            begin
            FormType := fmGrid;  // Al cambiar el tipo de Forma a fmGrid se convierte en persistente (no se destruye al perder el focus)
            Maximize;
            Visible := True;
            BringToFront;
            end;

          UpdateMDILayout( ApplicationContainer.CurrentMDILayout );
          end;
end;

procedure TTouchQueryPanel.SetSourceQuery( const Value : TnxQuery );
begin
     If   Value<>FSourceQuery
     then begin
          If   Assigned( FSourceQuery )
          then FSourceQuery.BeforeOpen := FQueryBeforeOpen;
          FSourceQuery := Value;
          If   Assigned( FSourceQuery )
          then begin
               FQueryBeforeOpen := FSourceQuery.BeforeOpen;
               FSourceQuery.BeforeOpen := DoOnQueryBeforeOpen;
               end;
          end;
end;

procedure TTouchQueryPanel.SetInitSearchQuery( const Value : Boolean );
begin
     FInitSearchQuery := Value;
     FInitSearchButton.Down := FInitSearchQuery;
end;

procedure TTouchQueryPanel.DoOnQueryBeforeOpen( Sender : TDataset );
begin
     // SetupQueryParams;
     If   Assigned( FQueryBeforeOpen )
     then FQueryBeforeOpen( Sender );
end;

procedure TTouchQueryPanel.DoGridTableViewCellClick(     Sender        : TcxCustomGridTableView;
                                                     ACellViewInfo : TcxGridTableDataCellViewInfo;
                                                     AButton       : TMouseButton;
                                                     AShift        : TShiftState;
                                                 var AHandled      : Boolean );
begin
     If   ApplicationContainer.AppTouchMode and
          ACellViewInfo.WasFocusedBeforeClick
     then begin
          DataSelected;
          AHandled := True;
          end;
end;

procedure TTouchQueryPanel.DoGridTableViewCellDblClick(     Sender        : TcxCustomGridTableView;
                                                        ACellViewInfo : TcxGridTableDataCellViewInfo;
                                                        AButton       : TMouseButton;
                                                        AShift        : TShiftState;
                                                    var AHandled      : Boolean );

begin
     DataSelected;
     AHandled := True;
end;

function TTouchQueryPanel.LinkToTarget : Boolean;
begin
     Result := False;
     If   Assigned( FTargetTable )
     then With FTargetTable do
            try
              DisableControls;
              SaveRange;
              CancelRange;     // Si no se desactivan los controles CancelRange provoca un deDataSetChange
              SetToDatasetPos( FSourceDataset );
              Result := True;
            finally
              RestoreRange;
              EnableControls;
              end;
end;

procedure TTouchQueryPanel.DoOnUserSelection;
begin
     If   Assigned( FOnUserSelection )
     then FOnUserSelection;
end;

procedure TTouchQueryPanel.DataSelected;
begin

     If   FDetached
     then begin
          DoOnUserSelection;
          Exit;
          end;

     //* Que por lo menos haya una l�nea y est� seleccionada

     If   ( Assigned( FGridTableView ) and ( FGridTableView.Controller.SelectedRowCount=1 ) ) or
          ( Assigned( FTreeList ) and ( FTreeList.SelectionCount>0 ) )
     then try
            If   Assigned( FOnDataSelected )
            then FOnDataSelected( FTargetControl )
            else If   not LinkToTarget
                 then If   Assigned( FSourceField ) and
                           Assigned( FTargetControl )
                      then try
                             FSettingTargetValue := True;
                             try
                               If   Assigned( FLockControl ) and
                                    not FLockRange and
                                    Assigned( FLockRangeField ) and
                                    not FLockRangeField.IsIndexField   // Solo se actualiza el campo de bloqueo si no pertenece a la clave de un mantenimiento
                                                                       // es decir, listados, procesos y otros campos complementarios dentro de un mantenimiento
                               then FLockControl.PostEditValue( FSourceDataset.FieldValues[ FLockRangeField.FieldName ] );
                               TargetControl.PostEditValue( FSourceDataset.FieldValues[ FSourceField.FieldName ] );  // Puede ser la tabla o el query
                               TargetControl.SetFocus;
                             finally
                               ModifiedAfterEnter := True;
                               end;
                            finally
                              FSettingTargetValue := False;
                              end;
          except
            end;

     If   Assigned( TargetControl )
     then SelectEditControl( TargetControl );

     If   not FDetached and not ( csDestroying in FOwnerForm.ComponentState )
     then CloseQueryForm;

end;

procedure TTouchQueryPanel.DoGridTableViewFocusedItemChanged( Sender            : TcxCustomGridTableView;
                                                          APrevFocusedItem,
                                                          AFocusedItem      : TcxCustomGridTableItem);
begin
     FGridTableView.OptionsBehavior.IncSearchItem := AFocusedItem;
end;

procedure TTouchQueryPanel.DoControlKeyDown(     Sender : TObject;
                                         var Key    : Word;
                                             Shift  : TShiftState );

procedure ClickButton( AButton : TcxButton );
begin
     With AButton do
       begin
       Down := not Down;
       Click;
       end;
     Key := 0;
end;

begin
     case Key of
       VK_F4     : If   ( Shift=[] ) or ( ssShift in Shift ) or ( ( ssCtrl in Shift ) and ( ssAlt  in Shift ) )   // <F4>, <Shift>+<F4> � <Alt Gr>+<F4>
                   then ShowFilterFrame;
       VK_SPACE,
       VK_RETURN : DataSelected;
       VK_ESCAPE : CloseQueryForm;
       VK_BACK   : If   ( ( ssCtrl in Shift ) and ( ssAlt  in Shift ) )
                   then FRecordButtonLink.RecordBtnPressed( sbnCancelSrchRec );           // <Alt gr>+<Back>

       $43       : If   ssCtrl in Shift  // [Ctrl] + C
                   then ClickButton( FSetupColumnsButton );
       $44       : If   ssCtrl in Shift  // [Ctrl] + D
                   then ClickButton( FSyncDataButton );
       $4C       : If   ssCtrl in Shift  // [Ctrl] + L
                   then ClickButton( FInitSearchButton );
       $53       : If   ssCtrl in Shift  // [Ctrl] + S
                   then ClickButton( FSaveButton );
       end;
end;

procedure TTouchQueryPanel.DoOnFormKeyPress(     Sender : TObject;
                                         var Key    : Char);
begin
     case Key of
       #$D  : Key := #0;    // Evitando el molesto Beep
       end;
end;

procedure TTouchQueryPanel.DoOnFormResize( Sender : TObject );
begin
     If   FFormWidthAdjusted
     then FQueryStateChanged := True;
end;

procedure TTouchQueryPanel.DoOnFormKeyDown(     Sender : TObject;
                                        var Key    : Word;
                                            Shift  : TShiftState );
begin
     If   Assigned( FFilterFrame ) and FFilterFrame.Visible
     then With FFilterFrame do
            case Key of
              VK_RETURN : ButtonPressed( True );
              VK_ESCAPE : If   FDatasetInitialized
                          then ButtonPressed( False )
                          else CloseQueryForm;
              $54       : If   ssCtrl in Shift  // [Ctrl] + T
                          then FieldsButton.Click;
              end
     else case Key of
              VK_ESCAPE : If   FDetached
                          then begin
                               If   ShowNotification( ntQuestionWarning, RsMsg6 )<>mrYes
                               then Key := 0;
                               end
                          else CloseQueryForm;
              end;
end;

initialization

  RegisterClasses( [ TTouchQueryPanel ] );

end.


