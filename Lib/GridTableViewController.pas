
unit GridTableViewController;

{$A-}
{$C PRELOAD}
{$IMPORTEDDATA ON}

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

       Spring,

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
       cxGridDBBandedTableView,
       cxMaskEdit,
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
       dxBar,
       dxSkinsForm,
       dxGDIPlusClasses,
       cxGridDBDataDefinitions,

       nxllTypes,
       nxllMemoryManager,
       nxsdDataDictionary,

       AppManager,
       AppContainer,
       DataManager,
       AppForms,
       DB,
       nxDB,
       cxLookAndFeelPainters,
       dxSkinsCore,
       cxControls,

       dxSkinsdxBarPainter,
       ShellAnimations,
       cxGraphics,
       dxSkinsDefaultPainters,


       f_grd;


type

    TGridTableViewController = class;

    TRowShiftEvent = procedure( ShiftOperation : TShiftOperation ) of object;
    TUpdateEvent = procedure( Sender : TGridTableViewController ) of object;

    { TGridTableViewController -------------------------------------------------------------------- }

    TGridTableViewController = class( TcxGroupBox )
    private

      FOwnerForm : TgxForm;
      FFormManager : TgxFormManager;
      FTableView : TcxGridTableView;
      FDataset : TnxDataset;
      IDataset : InxeDataset;
      FTable : TnxeTable;
      FForm : TForm;
      FRecordButtonLink : TRecordButtonLink;
      FUserSelectionTimer : TTimer;
      FValidatingTableView,
      FValidatingTableViewAfterEdit,
      FHighlightFixedColumns : Boolean;
      FOriginActive,
      FDocumentActive : Boolean;
      FUseGridFilterBox : Boolean;
      FValidatingColumn : TcxGridDBColumn;
      FCurrentCellViewInfo : TcxGridTableDataCellViewInfo;
      FSavedOnFocusedRecordChanged : TcxGridFocusedRecordChangedEvent;
      FSavedOnCustomDrawCell : TcxGridTableDataCellCustomDrawEvent;
      FTableViewDataController : TcxGridDBDataController;

      FTableAfterOpen,
      FCachedDatasetAfterOpen,
      FCachedDatasetBeforeClose,

      FDatasetBeforeInsert,
      FDatasetOnNewRecord,
      FDatasetAfterEdit,
      FDatasetBeforePost,
      FDatasetAfterPost,
      FDatasetBeforeDelete,
      FDatasetOnUpdateState,
      FDatasetOnApplyMasterRange : TDatasetNotifyEvent;

      FGridOnKeyDown : TKeyEvent;
      FOnUpdate : Event<TUpdateEvent>;

      FGridOnCellClick,
      FGridOnCellDblClick : TcxGridCellClickEvent;

      FBeforeValidateTableView : TNotifyEvent;

      FTableViewEditing,                                       // La configuración del GridTable al inicio
      FTableViewDeleting,
      FTableViewInserting  : Boolean;

      FGridOnEnter,
      FGridOnExit : TNotifyEvent;
      FOnUserSelection : TUserSelectionEvent;

      FOnRowShift : TRowShiftEvent;
      FBeforeRowShift,
      FAfterRowShift : TNotifyEvent;

      FOnShowOrigin,
      FOnShowDocument,
      FOnRowInsert,

      FOnCanEditRow,
      FOnCanDeleteRow,
      FOnCanInsertRow,
      FOnCanShiftRow,
      FOnCanShowOrigin,
      FOnCanShowDocument : TCheckEvent;

      FGridOnFocusedItemChanged : TcxGridFocusedItemChangedEvent;
      // FGridOnFocusedRecordChanged : TcxGridFocusedRecordChangedEvent;
      FTableViewColumnHeaderClick : TcxGridColumnEvent;

      FHideWhenDisabled,
      FShowDeleteWarning,
      FDontShowDeleteWarning,
      FDatasetAppending,
      FDatasetInserting : Boolean;    // Realizando una inserción con renumeración de líneas
      FAutoIncField : TField;
      FMinAutoIncValue,
      FMaxAutoIncValue,
      FAutoIncValue,
      FLastAutoIncValue : Variant;
      FRecordBuffer : PChar;
      FControllerPostingRecord,
      FShiftRecords : Boolean;      // Realizando una inserción de línea

      FBackgroundPanel : TcxGroupBox;

      FShowOriginButton,
      FShowDocumentButton,
      FShiftDownButton,
      FShiftUpButton,
      FInsertButton,
      FAppendButton,
      FDeleteButton : TcxButton;

      FFirtsItemIndex: Integer;

      FOnInsert,
      FOnDelete : TNotifyEvent;

      procedure OnShowOriginButtonClick(Sender: TObject);
      procedure OnShowDocumentButtonClick(Sender: TObject);
      procedure OnShiftUpButtonClick(Sender: TObject);
      procedure OnShiftDownButtonClick(Sender: TObject);
      procedure OnInsertButtonClick(Sender: TObject);
      procedure OnAppendButtonClick(Sender: TObject);
      procedure OnDeleteButtonClick(Sender: TObject);

      procedure SetTableView( const Value : TcxGridTableView );
      procedure SetShiftRecords( const Value : Boolean );
      procedure SetOriginActive( const Value : Boolean );
      procedure SetDocumentActive( const Value : Boolean );

      procedure CheckFirstRequiredColumn( AFocusedItem : TcxCustomGridTableItem; Exiting : Boolean = False);
      procedure CheckEditingOnExit;

      procedure DoDatasetBeforeInsert(Dataset: TDataSet);
      procedure DoDatasetOnNewRecord(Dataset: TDataSet);
      procedure DoDatasetAfterEdit(Dataset: TDataSet);
      procedure DoDatasetBeforePost(Dataset: TDataSet);
      procedure DoDatasetAfterPost(Dataset: TDataSet);
      procedure DoDatasetBeforeDelete(Dataset: TDataSet);
      procedure DoDatasetOnUpdateState(Dataset: TDataSet);
      procedure DoDatasetApplyMasterRange(Dataset: TDataSet);

      procedure DoFocusedItemChanged( Sender : TcxCustomGridTableView; APrevFocusedItem, AFocusedItem : TcxCustomGridTableItem);
      procedure DoColumnHeaderClick( Sender : TcxGridTableView; AColumn : TcxGridColumn );
      procedure DoGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure DoGridCellClick( Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
      procedure DoGridCellDblClick( Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
      procedure DoGridEnter( Sender : TObject );
      procedure DoGridExit( Sender : TObject );
      procedure DoBeforeShift;
      procedure DoAfterShift;
      procedure DoBeforeValidateTableView;

      procedure DoOnCustomDrawCell( Sender : TcxCustomGridTableView; ACanvas : TcxCanvas; AViewInfo : TcxGridTableDataCellViewInfo; var ADone : Boolean );
      procedure DoOnFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean );

      procedure DoOnUserSelectionTimer( Sender : TObject );

      function CanShiftRow : Boolean;
      function CanEditRow : Boolean;
      function CanInsertRow : Boolean;
      function CanDeleteRow : Boolean;
      function CanShowOrigin : Boolean;
      function CanShowDocument : Boolean;

      procedure SetButtonsAlignment;

    protected

      procedure DoExit; override;
      procedure Notification( AComponent : TComponent; Operation : TOperation ); override;
      procedure Loaded; override;

      function GetOwnerForm: TgxForm;
      function GetFormManager : TgxFormManager;

      procedure DeleteRow;
      procedure Update; override;

      procedure InsertRow;
      procedure AppendRow;

    public

      constructor Create( AOwner : TComponent ); override;
      procedure CreateWnd; override;

      procedure SetupTableViewLink;
      procedure ShiftUp( ToFirstRow : Boolean = False );
      procedure ShiftDown( ToLastRow : Boolean = False );

      procedure ValidateTableView( AfterEditing : Boolean = False );
      procedure RefreshGrid;
      procedure CheckFixedColumnsStyle;

      property  AutoIncValue : Variant read FAutoIncValue;
      property  OriginActive : Boolean read FOriginActive write SetOriginActive;
      property  DocumentActive : Boolean read FDocumentActive write SetDocumentActive;

      property  ShowOriginButton : TcxButton read FShowOriginButton;
      property  ShowDocumentButton : TcxButton read FShowDocumentButton;
      property  ShiftDownButton : TcxButton read FShiftDownButton;
      property  ShiftUpButton : TcxButton read FShiftUpButton;
      property  InsertButton : TcxButton read FInsertButton;
      property  AppendButton : TcxButton read FAppendButton;
      property  DeleteButton : TcxButton read FDeleteButton;

      property  FormManager : TgxFormManager read GetFormManager;
      property  OwnerForm : TgxForm read GetOwnerForm;
      property  RecordButtonLink : TRecordButtonLink read FRecordButtonLink;
      // property  ShiftingRecords : Boolean read FShiftingRecords;
      property  ValidatingTableView : Boolean read FValidatingTableView write FValidatingTableView;
      property  ValidatingTableViewAfterEdit : Boolean read FValidatingTableViewAfterEdit write FValidatingTableViewAfterEdit;
      property  ValidatingColumn : TcxGridDBColumn read FValidatingColumn;  // Solo válida si ValidatingTableView=True

      property OnUpdate: Event<TUpdateEvent> read FOnUpdate write FOnUpdate;

    published

      property ControllerPostingRecord : Boolean read FControllerPostingRecord;
      property DontShowDeleteWarning : Boolean read FDontShowDeleteWarning write FDontShowDeleteWarning default False;
      property HideWhenDisabled : Boolean read FHideWhenDisabled write FHideWhenDisabled default False;
      property HighlightFixedColumns : Boolean read FHighlightFixedColumns write FHighlightFixedColumns default True;
      property TableView : TcxGridTableView read FTableView write SetTableView;
      property ShiftRecords : Boolean read FShiftRecords write SetShiftRecords;
      property UseGridFilterBox : Boolean read FUseGridFilterBox write FUseGridFilterBox;

      property BeforeRowShift : TNotifyEvent read FBeforeRowShift write FBeforeRowShift;
      property AfterRowShift : TNotifyEvent read FAfterRowShift write FAfterRowShift;
      property BeforeValidateTableView : TNotifyEvent read FBeforeValidateTableView write FBeforeValidateTableView;

      property OnUserSelection : TUserSelectionEvent read FOnUserSelection write FOnUserSelection;
      property OnInsert : TNotifyEvent read FOnInsert write FOnInsert;
      property OnDelete : TNotifyEvent read FOnDelete write FOnDelete;
      property OnRowShift : TRowShiftEvent read FOnRowShift write FOnRowShift;
      property OnRowInsert : TCheckEvent read FOnRowInsert write FOnRowInsert;
      property OnShowOrigin : TCheckEvent read FOnShowOrigin write FOnShowOrigin;
      property OnShowDocument : TCheckEvent read FOnShowDocument write FOnShowDocument;

      property OnCanEditRow : TCheckEvent read FOnCanEditRow write FOnCanEditRow;
      property OnCanDeleteRow : TCheckEvent read FOnCanDeleteRow write FOnCanDeleteRow;
      property OnCanInsertRow : TCheckEvent read FOnCanInsertRow write FOnCanInsertRow;
      property OnCanShiftRow : TCheckEvent read FOnCanShiftRow write FOnCanShiftRow;
      property OnCanShowOrigin : TCheckEvent read FOnCanShowOrigin write FOnCanShowOrigin;
      property OnCanShowDocument : TCheckEvent read FOnCanShowDocument write FOnCanShowDocument;
    end;

    TGridTableViewPanel = class( TcxGroupBox )
    private
      FGrid : TcxGrid;
      FAutoUpdatePanels : Boolean;

    protected

      procedure DoExit; override;
      procedure Notification( AComponent : TComponent; Operation : TOperation ); override;
      // procedure Resize; override;
      procedure SetGrid( const Value : TcxGrid );
      procedure DoOnStructureNavigatorChanged( Sender : TObject );

    public
      constructor Create( AOwner : TComponent ); override;
      procedure UpdateLayout;
      function GetColumnWidth( GridColumn : TcxGridColumn ) : Integer;

    published
      property Grid : TcxGrid read FGrid write SetGrid;
      property AutoUpdatePanels : Boolean read FAutoUpdatePanels write FAutoUpdatePanels default True;
      end;

    IgxGridFooterComponent = interface
      ['{366824C2-2602-4EDE-BA6E-1FF52F9DAAB0}']
      function GetGridColumn : TcxGridColumn;
      end;

    TGridTableViewPanelGroupBox = class( TcxGroupBox, IgxGridFooterComponent )
    private
      FGridFooter : TGridTableViewPanel;
      FGridColumn : TcxGridColumn;
    protected
     procedure DoExit; override;
     procedure Notification( AComponent : TComponent; Operation : TOperation ); override;
     procedure Loaded; override;
     function GetGridColumn : TcxGridColumn;
    published
      property GridColumn : TcxGridColumn read FGridColumn write FGridColumn;
      end;

   TGridTableViewPanelLabel = class( TcxLabel, IgxGridFooterComponent )
    private
      FGridFooter : TGridTableViewPanel;
      FGridColumn : TcxGridColumn;
    protected
      procedure DoExit; override;
      procedure Notification( AComponent : TComponent; Operation : TOperation ); override;
      procedure Loaded; override;
      function GetGridColumn : TcxGridColumn;

    published
      property GridColumn : TcxGridColumn read FGridColumn write FGridColumn;
      end;

implementation

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

       DataAccess,
       NexusRpcData,

       QueryForm,
       EditSelector,
       MsgFrame,

       b_msg,
       b_flt,
       b_sch;

resourceString

       RsMsg31 = 'El componente debe implementar InxeDataset.';

       HintMsg1 = 'Muestra el documento que originó esta línea.'#13'Teclas [Ctrl]+[O]';
       HintMsg2 = 'Editar la lista de documentos asociados a la línea.'#13'Teclas [Ctrl]+[D]';

       HintMsg21 = 'Desplaza el registro una línea hacia arriba'#13'Teclas [Ctrl]+[Shift]+[Arriba]\no al principio de la lista'#13'Teclas [Ctrl]+[Shift]+[Inicio], Ratón [Shift]+<Click>';
       HintMsg22 = 'Desplaza el registro una línea hacia abajo'#13'Teclas [Ctrl]+[Shift]+[Abajo]\no al final de la lista'#13'Teclas [Ctrl]+[Shift]+[Fin], Ratón [Shift]+<Click>';

       HintMsg24 = 'Inserta un nuevo registro (línea).'#13'Tecla [Insert]';
       HintMsg25 = 'Suprime un registro (línea).'#13'Tecla [Supr]';
       HintMsg26 = 'Añade un nuevo registro (línea).'#13'Tecla [Shift]+[Insert]';

// TGridTableViewController

constructor TGridTableViewController.Create( AOwner : TComponent );

var  ButtonWidth : SmallInt;

procedure CreateButton( var AButton     : TcxButton;
                            Image       : TcxImageCollectionItem;
                            AMessage    : String;
                            AOnClick    : TNotifyEvent );
begin
     AButton := TcxButton.Create( Self );
     With AButton do
       begin
       Parent := FBackgroundPanel;
       Width := ButtonWidth;
       Height := ButtonWidth;
       SpeedButtonOptions.CanBeFocused := False;
       SpeedButtonOptions.Flat := True;
       SpeedButtonOptions.Transparent := True;
       Glyph.Assign( Image.Picture.Graphic );
       OptionsImage.Glyph.SourceHeight := ButtonWidth - 8;
       OptionsImage.Glyph.SourceWidth := ButtonWidth - 8;
       NumGlyphs := 1;
       Hint := AMessage;
       ShowHint := True;
       Caption := '';
       OnClick := aOnClick;
       end;
end;

begin
     inherited;

     FHighlightFixedColumns := True;
     Style.BorderStyle := ebsNone;

     FUserSelectionTimer := TTimer.Create( Self );
     FUserSelectionTimer.Enabled := False;
     FUserSelectionTimer.Interval := 200;
     FUserSelectionTimer.OnTimer := DoOnUserSelectionTimer;

     Enabled := False;
     Caption := '';
     PanelStyle.Active := True;
     BevelInner := bvNone;
     BevelOuter := bvNone;
     Style.TransparentBorder := False;

     Width := 38;
     ButtonWidth := Width - 2;

     FBackgroundPanel := TcxGroupBox.Create( Self );

     FBackgroundPanel.Parent := Self;
     FBackgroundPanel.Align := alClient;
     FBackgroundPanel.Alignment := alCenterCenter;
     FBackgroundPanel.Style.BorderStyle := ebsNone;
     FBackgroundPanel.Style.TransparentBorder := False;
     FBackgroundPanel.PanelStyle.Active := True;
     FBackgroundPanel.Transparent := True;

     CreateButton( FInsertButton, ApplicationForms.RowInsertImage, HintMsg24, OnInsertButtonClick );
     CreateButton( FAppendButton, ApplicationForms.RowAppendImage, HintMsg26, OnAppendButtonClick );

     CreateButton( FDeleteButton, ApplicationForms.RowDeleteImage, HintMsg25, OnDeleteButtonClick );

     CreateButton( FShiftUpButton, ApplicationForms.RowShiftUpImage, HintMsg21, OnShiftUpButtonClick );
     CreateButton( FShiftDownButton, ApplicationForms.RowShiftDownImage, HintMsg22, OnShiftDownButtonClick );

     CreateButton( FShowOriginButton, ApplicationForms.ShowOriginImage, HintMsg1, OnShowOriginButtonClick );
     CreateButton( FShowDocumentButton, ApplicationForms.ShowDocumentImage, HintMsg2, OnShowDocumentButtonClick );

end;

procedure TGridTableViewController.CreateWnd;
begin
     inherited CreateWnd;
     SetButtonsAlignment;
     Update;
end;


function TGridTableViewController.GetOwnerForm : TgxForm;

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

function TGridTableViewController.GetFormManager : TgxFormManager;
begin
     If   not Assigned( FFormManager )
     then If   Assigned( OwnerForm )
          then FFormManager := TgxFormManager( FOwnerForm.FindComponent( FormManagerName ) );
     Result := FFormManager;
end;

procedure TGridTableViewController.SetButtonsAlignment;

var  TopPos, BottomPos : SmallInt;

procedure SetupButton( AButton      : TcxButton;
                       ButtonAlign  : TAlign;
                       TopMargin    : SmallInt = 0;
                       BottomMargin : SmallInt = 0 );
begin
     If   ButtonAlign=alTop
     then AButton.Top := TopPos
     else AButton.Top := BottomPos;

     AButton.AlignWithMargins := True;
     AButton.Align := ButtonAlign;
     AButton.Margins.Left := 2;
     AButton.Margins.Right := 2;
     AButton.Margins.Top := TopMargin;
     AButton.Margins.Bottom := BottomMargin;

     If   ButtonAlign=alTop
     then TopPos := AButton.Top + AButton.Height
     else BottomPos := AButton.Top + AButton.Height

end;

begin

     If   Assigned( FShiftUpButton )
     then begin

          TopPos := 1;
          BottomPos := 1;

          SetupButton( FInsertButton, alTop );
          SetupButton( FAppendButton, alTop );

          SetupButton( FDeleteButton, alTop, 12 );

          SetupButton( FShowOriginButton, alBottom );
          SetupButton( FShowDocumentButton, alBottom );

          SetupButton( FShiftUpButton, alBottom, 12 );
          SetupButton( FShiftDownButton, alBottom );

          FShowOriginButton.Visible := Assigned( FOnShowOrigin );
          FShowDocumentButton.Visible := Assigned( FOnShowDocument );

          FShiftUpButton.Visible := FShiftRecords;
          FShiftDownButton.Visible := FShiftRecords;

          FDeleteButton.Visible := Assigned( FOnDelete ) or FTableViewDeleting;
          FInsertButton.Visible := Assigned( FOnInsert ) or FTableViewInserting;
          If   Assigned( FAppendButton )
          then FAppendButton.Visible := Assigned( FOnInsert ) or FTableViewInserting;

          end;
end;

procedure TGridTableViewController.Update;

var  BEnabled : Boolean;
     AutoEdit,
     AssignedFocusedRow : Boolean;
     PanelVisible : Boolean;

begin

     inherited Update;


     PanelVisible := not ( FHideWhenDisabled and not Enabled );

     If   PanelVisible and Assigned( FShiftUpButton )
     then begin

          AutoEdit := False;

          AssignedFocusedRow := False;

          If   Assigned( FTableViewDataController ) and
               Assigned( FTableViewDataController.DataSource )
          then begin
               AutoEdit := FTableViewDataController.DataSource.AutoEdit;
               AssignedFocusedRow := Assigned( FTableView.Controller.FocusedRow );
               end;

          OriginActive := CanShowOrigin;
          DocumentActive := CanShowDocument;  // Esto activa y desactiva el botón del documento

          BEnabled := AutoEdit and Enabled and ( FDataset.State<>dsInsert );

          FShiftUpButton.Enabled := BEnabled and CanShiftRow;
          FShiftDownButton.Enabled := BEnabled and CanShiftRow;

          FDeleteButton.Enabled := AutoEdit and Enabled and AssignedFocusedRow and not CantDeleteRecords and CanDeleteRow;
          FInsertButton.Enabled := BEnabled and CanInsertRow;
          If   Assigned( FAppendButton )
          then FAppendButton.Enabled := BEnabled and CanInsertRow;

          FOnUpdate.Invoke( Self );

          end;

     FBackgroundPanel.Visible := PanelVisible;

end;

procedure TGridTableViewController.DoExit;
begin
     DoOnExit;
end;

procedure TGridTableViewController.Notification( AComponent : TComponent; Operation : TOperation );
begin
     inherited Notification( AComponent, Operation );
     If   Operation=opRemove
     then begin
          If   AComponent=FTableView
          then FTableView := nil;
          end;
end;

procedure TGridTableViewController.SetShiftRecords( const Value : Boolean );
begin
     If   FShiftRecords<>Value
     then begin
          FShiftRecords := Value;
          Update;
          end;
end;

procedure TGridTableViewController.SetDocumentActive( const Value : Boolean );
begin
     FDocumentActive := Value;
     If   Assigned( FShowDocumentButton )
     then FShowDocumentButton.Enabled := Enabled and FDocumentActive;
end;

procedure TGridTableViewController.SetOriginActive( const Value : Boolean );
begin
     FOriginActive := Value;
     If   Assigned( FShowOriginButton )
     then FShowOriginButton.Enabled := Enabled and FOriginActive;
end;

procedure TGridTableViewController.OnShowOriginButtonClick(Sender: TObject);
begin
     If   Assigned( FOnShowOrigin )
     then FOnShowOrigin;
end;

procedure TGridTableViewController.OnShowDocumentButtonClick(Sender: TObject);
begin
     If   Assigned( FOnShowDocument )
     then FOnShowDocument;
end;

procedure TGridTableViewController.RefreshGrid;
begin
     // Si la rejilla no está en modo SmartRefresh ya se actualiza automáticamente después de cada inserción o cambio

     If   Assigned( FTableViewDataController )
     then With FTableViewDataController do
       If   DataModeController.SmartRefresh
       then UpdateItems( False );

end;

procedure TGridTableViewController.OnShiftUpButtonClick(Sender: TObject);
begin
     ShiftUp( IsKeyPressed( VK_SHIFT ) );
end;

procedure TGridTableViewController.ShiftUp( ToFirstRow : Boolean = False );

var  I, J : SmallInt;
     RecordFieldValues : TFieldValuesArray;
     ShiftOperation : TShiftOperation;

begin
     If   Assigned( FDataset ) and  // Si está asignado FDataset, también lo está IDataset
          FShiftRecords and
          FShiftUpButton.Enabled
     then With FDataset do
            begin
            DisableControls;
            IDataset.ShiftingRecords := True;
            FTableView.DataController.BeginFullUpdate;
            try

              DoBeforeShift;

              If   Assigned( FOnRowShift )
              then begin
                   If   ToFirstRow
                   then ShiftOperation := soFirst
                   else ShiftOperation := soPrior;
                   FOnRowShift( ShiftOperation );
                   end
              else If   Assigned( FAutoIncField )
                   then begin

                        If   Assigned( FTable )
                        then Database.StartTransactionWith( [ FTable ] );

                        try

                          Cancel;
                          Prior;
                          If   not Bof
                          then begin
                               If   ToFirstRow
                               then Next;
                               RecordFieldValues := GetRecordFieldValues( FDataset );
                               I := FAutoIncField.Value;
                               Delete; // La linea en curso

                               If   ToFirstRow
                               then begin
                                    If   I<FAutoIncField.Value
                                    then I := FAutoIncField.Value;
                                    While not Bof do
                                      begin
                                      Edit;
                                      FAutoIncField.Value := I;
                                      Post;
                                      Dec( I );
                                      Prior;
                                      end;
                                    J := FMinAutoIncValue;
                                    end
                               else begin
                                    Edit;
                                    FAutoIncField.Value := I;
                                    Post;
                                    J := I + 1;
                                    end;

                               Append;
                               SetRecordFieldValues( FDataset, RecordFieldValues );
                               FAutoIncField.Value := J;
                               Post;
                               end;

                          If   Assigned( FTable )
                          then Database.Commit;

                        except
                          If   Assigned( FTable )
                          then Database.RollBack;
                          Cancel;
                          end;

                        end;

            finally
              DoAfterShift;
              FTableView.DataController.EndFullUpdate;
              EnableControls;
              IDataset.ShiftingRecords := False;
              RefreshGrid;
              If   ToFirstRow
              then First
              else Prior;
              end;

            end;

end;

procedure TGridTableViewController.ShiftDown( ToLastRow : Boolean = False );

var  I, J : SmallInt;
     RecordFieldValues : TFieldValuesArray;
     Bm : TBookMark;
     ShiftOperation : TShiftOperation;

begin
     If   Assigned( FDataset ) and
          FShiftRecords and
          FShiftDownButton.Enabled
     then With FDataset do
            begin
            DisableControls;
            IDataset.ShiftingRecords := True;
            FTableView.DataController.BeginFullUpdate;
            try

              DoBeforeShift;

              If   Assigned( FOnRowShift )
              then begin
                   If   ToLastRow
                   then ShiftOperation := soLast
                   else ShiftOperation := soNext;
                   FOnRowShift( ShiftOperation );
                   end
              else If   Assigned( FAutoIncField )
                   then begin

                        If   Assigned( FTable )
                        then Database.StartTransactionWith( [ FTable ] );
                        try

                          Cancel;
                          If   not ToLastRow
                          then Bm := GetBookMark;
                          Next;
                          If   not Eof
                          then begin

                               If   ToLastRow
                               then Prior;
                               RecordFieldValues := GetRecordFieldValues( FDataset );
                               I := FAutoIncField.Value;
                               Delete;

                               If   ToLastRow
                               then begin
                                    While not Eof do
                                      begin
                                      Edit;
                                      FAutoIncField.Value := I;
                                      Post;
                                      Inc( I );
                                      Next;
                                      end;
                                    J := I;
                                    end
                               else begin
                                    GotoBookMark( Bm );
                                    Edit;
                                    FAutoIncField.Value := I;
                                    Post;
                                    J := I - 1;
                                    end;

                               Append;
                               SetRecordFieldValues( FDataset, RecordFieldValues );
                               FAutoIncField.Value := J;
                               Post;
                               end;

                          If   Assigned( FTable )
                          then Database.Commit;

                        except
                          If   Assigned( FTable )
                          then Database.RollBack;
                          Cancel;
                          end;

                        end;

            finally
              DoAfterShift;
              FTableView.DataController.EndFullUpdate;
              EnableControls;
              IDataset.ShiftingRecords := False;
              RefreshGrid;
              If   ToLastRow
              then Last
              else Next;
              end;

            end;

end;

procedure TGridTableViewController.OnInsertButtonClick(Sender: TObject);
begin
     InsertRow;
end;

procedure TGridTableViewController.OnShiftDownButtonClick(Sender: TObject);
begin
     ShiftDown( IsKeyPressed( VK_SHIFT ) );
end;

procedure TGridTableViewController.OnAppendButtonClick(Sender: TObject);
begin
     AppendRow;
end;

procedure TGridTableViewController.InsertRow;
begin
     If   Assigned( FOnInsert )
     then FOnInsert( Self );
     If   Assigned( FTableView ) and CanInsertRow
     then FTableView.Controller.CreateNewRecord( False );
end;

procedure TGridTableViewController.AppendRow;
begin
     If   Assigned( FOnInsert )
     then FOnInsert( Self );
     If   Assigned( FTableView ) and CanInsertRow
     then begin
          FTableView.Controller.GoToLast( { AGoIntoDetail } True );
          FTableView.Controller.CreateNewRecord( True );
          end;
end;

procedure TGridTableViewController.OnDeleteButtonClick(Sender: TObject);
begin
     If   Assigned( FTableView )
     then If   dceInsert in FTableView.DataController.EditState
          then FTableView.DataController.Cancel
          else DeleteRow;
end;

procedure TGridTableViewController.DeleteRow;
begin
     If   not CantDeleteRecords and CanDeleteRow
     then begin
          If   Assigned( FOnDelete )
          then FOnDelete( Self );
          If   Assigned( FTableView )
          then try
                 FShowDeleteWarning := True;
                 FTableView.DataController.DeleteSelection;
               finally
                 FShowDeleteWarning := False;
                 FTableView.DataController.Refresh;
                 end;
          end;
end;

procedure TGridTableViewController.DoDatasetBeforeDelete( Dataset : TDataSet );

var  DeleteMessage : String;

begin
     If   Assigned( IDataset ) and not IDataset.ShiftingRecords
     then begin
          If   FShowDeleteWarning and not FDontShowDeleteWarning
          then begin
               // En el borrado de múltiples líneas, FShowDeleteWarning evita que se muestre el aviso por cada una
               FShowDeleteWarning := False;
               If   FTableView.DataController.GetSelectedCount>1
               then DeleteMessage := RsgMsg182
               else DeleteMessage := RsgMsg179;
               If   ShowNotification( ntQuestionWarning, DeleteMessage )<>mrYes
               then Abort;
               end;
          If   Assigned( FDatasetBeforeDelete )
          then FDatasetBeforeDelete( FDataset );
          end;
end;

procedure TGridTableViewController.SetTableView( const Value : TcxGridTableView );
begin
     If   Value<>FTableView
     then begin

          FTableView := Value;
          FTableViewDataController := nil;

          If   not IsDesignTime and
               Assigned( FTableView ) and
               ( ( FTableView is TcxGridDBBandedTableView ) or ( FTableView is TcxGridDBTableView ) )
          then begin

               With FTableView.OptionsData do
                 begin
                 FTableViewEditing := Editing;          // La configuración del GridTable al inicio
                 FTableViewDeleting := Deleting;
                 FTableViewInserting := Inserting;
                 end;

               If   Assigned( FRecordButtonLink )
               then FRecordButtonLink.Free;

               FRecordButtonLink := TRecordButtonLink.Create( Self );

               FTableView.LinkedComponent := FRecordButtonLink;

               FTableViewDataController := TcxGridDBDataController( FTableView.DataController );
               If   not FTableView.OptionsData.Editing and
                    not ( ( FTableViewDataController.Summary.DefaultGroupSummaryItems.Count<>0 ) or Assigned( FTableViewDataController.Summary.DefaultGroupSummaryItems.OnSummary ) or
                          ( FTableViewDataController.Summary.FooterSummaryItems.Count<>0 ) or Assigned( FTableViewDataController.Summary.FooterSummaryItems.OnSummary )  or
                          Assigned( FTableViewDataController.Summary.OnAfterSummary ) )
               then FTableViewDataController.DataModeController.GridMode := True;   //* 19.05.2010  Finalmente me rindo a la tiranía del rendimiento

               FSavedOnFocusedRecordChanged := FTableView.OnFocusedRecordChanged;
               FTableView.OnFocusedRecordChanged := DoOnFocusedRecordChanged;
               {
               FSavedOnCustomDrawCell := FTableView.OnCustomDrawCell;
               FTableView.OnCustomDrawCell:= DoOnCustomDrawCell;
               }

               With FTableView do
                 begin
                 If   OptionsData.Editing
                 then OptionsBehavior.ImmediateEditor := False     //* 10.04.2009  Es algo molesto que cuando estás consultando una rejilla se entre siempre en modo edición
                 else If   not Assigned( ApplicationContainer.AppSkinPainter )
                      then Styles.ContentEven := ApplicationContainer.QueryContentEvenStyle;

                 // Opciones por defecto de las rejillas

                 OptionsCustomize.ColumnHorzSizing := True;

                 end;
               end;
          end;
end;

procedure TGridTableViewController.DoOnCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                           ACanvas   : TcxCanvas;
                                                           AViewInfo : TcxGridTableDataCellViewInfo;
                                                       var ADone     : Boolean );
begin

     // Está desactivado

     If   Assigned( FSavedOnCustomDrawCell )
     then FSavedOnCustomDrawCell( Sender, ACanvas, AViewInfo, ADone );

     If   AViewInfo.Editing
     then begin
          AViewInfo.EditViewInfo.Paint( ACanvas );
          ACanvas.DrawComplexFrame( AViewInfo.ClientBounds, clOrange, clOrange, [bLeft, bTop, bBottom, bRight], 1 );
          ADone := True;
          end;

end;

procedure TGridTableViewController.DoOnFocusedRecordChanged( Sender                         : TcxCustomGridTableView;
                                                             APrevFocusedRecord,
                                                             AFocusedRecord                 : TcxCustomGridRecord;
                                                             ANewItemRecordFocusingChanged  : Boolean );
begin
     If   Assigned( FSavedOnFocusedRecordChanged )
     then FSavedOnFocusedRecordChanged( Sender, APrevFocusedRecord, AFocusedRecord, ANewItemRecordFocusingChanged );
     OriginActive := CanShowOrigin;
     DocumentActive := CanShowDocument;
     If   Assigned( AFocusedRecord ) 
     then Update;
end;

procedure TGridTableViewController.CheckFixedColumnsStyle;

var  I : SmallInt;

begin
     If   Assigned( FTableView ) and FHighlightFixedColumns
     then With FTableView do
            For I := 0 to ColumnCount - 1 do
              With Columns[ I ] do
                If   Options.Editing
                then Styles.Content := nil
                else Styles.Content := ApplicationContainer.EditFixedColumnStyle;
end;

procedure TGridTableViewController.Loaded;
begin
     inherited;
     FForm := TForm( GetParentForm( Self ) );
     SetupTableViewLink;
end;

procedure TGridTableViewController.SetupTableViewLink;
begin
     If   not IsDesignTime and Assigned( FTableViewDataController )
     then begin
          If   Assigned( FTableViewDataController.DataSource )
          then If   Assigned( FTableViewDataController.DataSource.Dataset )
               then begin
                    FDataset := TnxDataset( FTableViewDataController.DataSource.Dataset );
                    FDataset.GetInterface( InxeDataset, IDataset );
                    If   Assigned( IDataset )
                    then With FDataset, IDataset do
                           begin

                           If   FDataset is TnxeTable
                           then FTable := TnxeTable( FDataset );

                           FDatasetBeforeInsert := BeforeInsert;
                           BeforeInsert := DoDatasetBeforeInsert;

                           FDatasetOnNewRecord := OnNewRecord;
                           OnNewRecord := DoDatasetOnNewRecord;

                           FDatasetAfterEdit := AfterEdit;
                           AfterEdit := DoDatasetAfterEdit;

                           FDatasetBeforePost := BeforePost;
                           BeforePost := DoDatasetBeforePost;

                           FDatasetAfterPost := AfterPost;
                           AfterPost := DoDatasetAfterPost;

                           FDatasetBeforeDelete := BeforeDelete;
                           BeforeDelete := DoDatasetBeforeDelete;

                           FireEditionEvents := True;

                           FDatasetOnUpdateState := OnUpdateState;
                           OnUpdateState := DoDatasetOnUpdateState;

                           FDatasetOnApplyMasterRange := OnApplyMasterRange;
                           OnApplyMasterRange := DoDatasetApplyMasterRange;

                           With FTableView do
                             begin

                             CheckFixedColumnsStyle;

                             FTableViewColumnHeaderClick := OnColumnHeaderClick;
                             OnColumnHeaderClick := DoColumnHeaderClick;

                             OptionsBehavior.HotTrack := True;

                             If   Site.Container is TcxGrid
                             then With TcxGrid( Site.Container ) do
                                    begin
                                    FGridOnKeyDown := OnKeyDown;
                                    OnKeyDown := DoGridKeyDown;
                                    FGridOnCellClick := OnCellClick;
                                    FGridOnCellDblClick := OnCellDblClick;
                                    OnCellClick := DoGridCellClick;
                                    OnCellDblClick := DoGridCellDblClick;
                                    FGridOnEnter := OnEnter;
                                    OnEnter := DoGridEnter;
                                    FGridOnExit := OnExit;
                                    OnExit  := DoGridExit;
                                    FGridOnFocusedItemChanged := OnFocusedItemChanged;
                                    OnFocusedItemChanged := DoFocusedItemChanged;
                                    end;

                             end;

                           end
                    else raise Exception( RsMsg31 );

                    end;
          end;
end;

procedure TGridTableViewController.DoGridCellClick(     Sender        : TcxCustomGridTableView;
                                                      ACellViewInfo : TcxGridTableDataCellViewInfo;
                                                      AButton       : TMouseButton;
                                                      AShift        : TShiftState;
                                                  var AHandled      : Boolean );
begin
     FCurrentCellViewInfo := nil;
     If   Assigned( FGridOnCellClick )
     then FGridOnCellClick( Sender, ACellViewInfo, AButton, AShift, AHandled );
     If   not AHandled and
          ( AButton=mbLeft ) and
          ACellViewInfo.WasFocusedBeforeClick
     then begin
          FCurrentCellViewInfo := ACellViewInfo;
          FUserSelectionTimer.Enabled := True;
          end;
end;

procedure TGridTableViewController.DoGridCellDblClick(     Sender        : TcxCustomGridTableView;
                                                         ACellViewInfo : TcxGridTableDataCellViewInfo;
                                                         AButton       : TMouseButton;
                                                         AShift        : TShiftState;
                                                     var AHandled      : Boolean );

begin
     FCurrentCellViewInfo := nil;
     If   Assigned( FGridOnCellDblClick )
     then FGridOnCellDblClick( Sender, ACellViewInfo, AButton, AShift, AHandled );
     If   not AHandled and
          ( AButton=mbLeft )
     then begin
          FCurrentCellViewInfo := ACellViewInfo;
          FUserSelectionTimer.Enabled := True;
          end;
end;

procedure TGridTableViewController.DoOnUserSelectionTimer( Sender : TObject );

var  AHandled : Boolean;

begin
     FUserSelectionTimer.Enabled := False;
     AHandled := False;

     If   Assigned( FOnUserSelection )
     then FOnUserSelection( Self, AHandled );

     If   not AHandled and
          Assigned( FCurrentCellViewInfo ) and
          FTableView.OptionsData.Editing
     then FTableView.Controller.EditingController.StartEditShowingTimer( FCurrentCellViewInfo.Item );

end;

procedure TGridTableViewController.DoBeforeShift;
begin
     If   Assigned( FBeforeRowShift )
     then FBeforeRowShift( Self );
end;

procedure TGridTableViewController.DoAfterShift;
begin
     If   Assigned( FAfterRowShift )
     then FAfterRowShift( Self );
end;

procedure TGridTableViewController.DoBeforeValidateTableView;
begin
     If   Assigned( FBeforeValidateTableView )
     then FBeforeValidateTableView( Self );
end;

procedure TGridTableViewController.DoColumnHeaderClick( Sender  : TcxGridTableView;
                                                      AColumn : TcxGridColumn );

var  TableViewDataController : TcxGridDBDataController;

begin
     If   Assigned( FTableView )
     then begin
          TableViewDataController := TcxGridDBDataController( FTableView.DataController );
          TableViewDataController.DataModeController.GridMode := False;
          If   Assigned( FTableViewColumnHeaderClick )
          then FTableViewColumnHeaderClick( Sender, AColumn );
          end;
end;

procedure TGridTableViewController.DoGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     With FTableView do
       case Key of

         VK_DELETE : If   Shift=[]
                     then begin
                          DeleteRow;
                          Key := 0;
                          end;

         VK_INSERT : If   Shift=[]
                     then begin
                          InsertRow;
                          Key := 0;
                          end
                     else If   ssShift in Shift
                          then begin
                               AppendRow;
                               Key := 0;
                               end;

         VK_SPACE  : If   Shift = []
                     then FUserSelectionTimer.Enabled := True;

         $44       : If   ssCtrl in Shift  // <Ctrl> + D
                     then If   FDocumentActive
                          then OnShowDocumentButtonClick( Sender );

         $4F       : If   ssCtrl in Shift  // <Ctrl> + O
                     then If   FOriginActive
                          then OnShowOriginButtonClick( Sender );

         else       If   Assigned( FGridOnKeyDown )
                    then FGridOnKeyDown( Sender, Key, Shift );

         end;

end;

procedure TGridTableViewController.DoGridEnter( Sender : TObject );
begin

     Enabled := True;
     Update;

     If   not FDataset.ControlsDisabled
     then begin

          If   ( IDataset.MasterRelation=mrTied ) and
               Assigned( FormManager.Table )
          then With FormManager do
                 begin
                 ValidateDataArea( faData );
                 Table.Update;
                 end;

          If   Assigned( IDataset.AutoIncField )
          then begin
               FAutoIncField := IDataset.AutoIncField;
               FMinAutoIncValue := IDataset.MinAutoIncValue;
               FMaxAutoIncValue := IDataset.MaxAutoIncValue;
               end;

          If   FDataset.Active
          then If   FDataset.RecordCount=0
               then begin
                    If   FTableView.OptionsData.Appending
                    then FTableView.Controller.CreateNewRecord( True );
                    end
               else If   not Assigned( FTableView.Controller.FocusedRecord )
                    then FTableView.Controller.FocusRecord( 0, True );

          FTableView.Controller.FocusFirstAvailableItem;
          FFirtsItemIndex := FTableView.Controller.FocusedItemIndex;
          end;

     If   Assigned( FGridOnEnter )
     then FGridOnEnter( Sender );
end;

procedure TGridTableViewController.DoGridExit( Sender : TObject );
begin

     CheckEditingOnExit;

     If   FDataset.State=dsInsert
     then begin
          FTableView.DataController.Cancel;  // Desbloqueo el registro y/o cancelo las inserciones incompletas
          CheckFirstRequiredColumn( FTableView.Controller.FocusedItem, True );
          end;

     Enabled := False;
     Update;
     If   Assigned( FGridOnExit )
     then FGridOnExit( Sender );

end;

procedure TGridTableViewController.CheckEditingOnExit;

var  FRIndex : Integer;

begin
     If   FTableView.DataController.IsEditing
     then With FTableView.Controller do
            begin
            FRIndex := FocusedRecordIndex;
            CheckEditing( FRIndex, False );
            EditingController.HideEdit( True );
            end;
end;

function TGridTableViewController.CanEditRow : Boolean;
begin
     If   Assigned( FOnCanEditRow )
     then Result := FOnCanEditRow
     else If   Assigned( FTableView )
          then Result := FDataset.ControlsDisabled or FTableView.OptionsData.Editing
          else Result := False;
end;

function TGridTableViewController.CanShowOrigin : Boolean;
begin
     If   Assigned( FOnCanShowOrigin )
     then Result := FOnCanShowOrigin
     else Result := False;
end;

function TGridTableViewController.CanShowDocument : Boolean;
begin
     If   Assigned( FOnCanShowDocument )
     then Result := FOnCanShowDocument
     else Result := False;
end;

function TGridTableViewController.CanShiftRow : Boolean;
begin
     If   Assigned( FOnCanShiftRow )
     then Result := FOnCanShiftRow
     else Result := True;
end;

function TGridTableViewController.CanInsertRow : Boolean;
begin

     // Compruebo el ControlsDisabled para permitir realizar inserciones desde la aplicación (código) aunque al usuario no
     // le esté permitido hacerlo. Basta con desactivar los controles y realizar las inserciones.

     If   Assigned( FOnCanInsertRow )
     then Result := FOnCanInsertRow
     else If   Assigned( FTableView )
          then Result := FDataset.ControlsDisabled or FTableView.OptionsData.Inserting or FTableView.OptionsData.Appending
          else Result := False;
end;

function TGridTableViewController.CanDeleteRow : Boolean;
begin
     If   Assigned( FOnCanDeleteRow )
     then Result := FOnCanDeleteRow
     else If   Assigned( FTableView )
          then Result := FDataset.ControlsDisabled or FTableView.OptionsData.Deleting
          else Result := False;
end;

procedure TGridTableViewController.DoDatasetBeforeInsert(Dataset: TDataSet);
begin
     With FDataset do
       If   not IDataset.ShiftingRecords and not ControlsDisabled
       then If   CanInsertRow
            then begin

                 If   Assigned( FAutoIncField )
                 then begin

                      FLastAutoIncValue := FMinAutoIncValue;
                      FAutoIncValue := FMinAutoIncValue;

                      If   RecordCount<>0
                      then begin
                           FLastAutoIncValue := FAutoIncField.Value;
                           FAutoIncValue := FLastAutoIncValue + 1;
                           If   FAutoIncValue>FMaxAutoIncValue
                           then Abort;
                           end;

                      end;

                 If   Assigned( FDatasetBeforeInsert )
                 then FDatasetBeforeInsert( Dataset );

                 end
            else Abort;
end;

procedure TGridTableViewController.DoDatasetAfterEdit(Dataset: TDataSet);
begin
     If   not FDataset.ControlsDisabled
     then try
            FValidatingTableViewAfterEdit := True;
            If   Assigned( FTableView.ViewData.EditingRecord )
            then try
                   ValidateTableView( True );
                 except
                   end;
            If   Assigned( FDatasetAfterEdit )
            then FDatasetAfterEdit( Dataset );
          finally
            FValidatingTableViewAfterEdit := False;
            end;
end;

procedure TGridTableViewController.DoDatasetOnNewRecord(Dataset: TDataSet);
begin
     With FDataset do
       If   not IDataset.ShiftingRecords and not ControlsDisabled
       then begin

            // No se puede asignar el valor de 'FAutoIncField' en DoDatasetBeforeInsert porque el Dataset
            // todavía no está en modo dsInsert

            If   Assigned( FDatasetOnNewRecord )
            then FDatasetOnNewRecord( FDataset );

            FDatasetAppending := IDataset.IsAppending;

            If   Assigned( FAutoIncField )
            then If   FDatasetAppending
                 then begin
                      If   RecordCount=0
                      then FAutoIncField.Value := FLastAutoIncValue
                      else FAutoIncField.Value := FLastAutoIncValue + 1;
                      end
                 else FAutoIncField.Value := FLastAutoIncValue;

            end;
end;

procedure TGridTableViewController.DoDatasetBeforePost(Dataset: TDataSet);

var  TopRowIndex,
     FocusedRecordIndex : Integer;
     FirtsItemIndex: Integer;
     IsFiltered,
     ACycleChanged : Boolean;
     RecordFieldValues : TFieldValuesArray;
     ActiveControlParent : TWinControl;

function ActiveControlInGrid : Boolean;
begin
     If   Assigned( FForm.ActiveControl )
     then begin
          ActiveControlParent := FForm.ActiveControl.Parent;
          If   ActiveControlParent is TcxCustomEdit
          then Result := TcxCustomEdit( ActiveControlParent ).IsInplace
          else Result := ActiveControlParent=FTableView.Site.Container;
          end
     else Result := False;
end;

procedure CheckBeforePost;
begin
     If   Assigned( FDatasetBeforePost )
     then try
            FDatasetBeforePost( Dataset );
          except on E : EAbort do
            begin
            If   ActiveControlInGrid
            then ActiveControlParent.SetFocus
            else FTableView.DataController.Cancel;
            raise;
            end;
          else raise;
          end;
end;

begin

       FocusedRecordIndex := 0;

       If   not FControllerPostingRecord
       then begin

            If   FTableView.DataController.IsEditing
            then try

                   FControllerPostingRecord := True;
                   FDatasetInserting := False;

                   FocusedRecordIndex := FTableView.Controller.FocusedRecordIndex;
                   TopRowIndex := FTableView.Controller.TopRowIndex;

                   FTableView.DataController.BeginUpdate;

                   If   FDataset.Modified
                   then begin

                        CheckFirstRequiredColumn( FTableView.Controller.FocusedItem, True );

                        { Aunque validar de nuevo todos los campos pueda parecer una redundancia (al introducir los valores éstos ya se validan)
                          en las rejillas cabe la posibilidad de que se inserten valores por defecto que el usuario no tiene por qué validar
                          necesariamente, puesto que se puede salir de la edición de la línea en cualquier momento y desde cualquier columna.
                          Eso sin contar que hay que comprobar que todos los campos obligatorios se han completado, claro. }

                        try
                          ValidateTableView;
                        except
                          If   not ActiveControlInGrid
                          then begin
                               FTableView.DataController.Cancel;
                               Abort;
                               end
                          else raise;
                          end;

                        end;

                   If   ( FDataset.State=dsInsert ) and Assigned( FAutoIncField )
                   then If   not FDatasetAppending
                        then With FDataset do
                               If   RecordCount<>0
                               then begin
                                    FDatasetInserting := True;
                                    If   Assigned( FOnRowInsert )
                                    then FOnRowInsert
                                    else begin

                                         try

                                           CheckBeforePost;

                                           RecordFieldValues := GetRecordFieldValues( FDataset );
                                           DisableControls;
                                           Cancel;

                                           // En ocasiones el control de edición consigue mantenerse activo y se producía un error al intentar validarlo porque
                                           // el registro ya no está en modo edición (no importa que se cierre a lo bruto porque todos los campos ya están validados y guardados )

                                           If   Assigned( FTableView.Controller.EditingController )
                                           then FTableView.Controller.EditingController.HideEdit( False );

                                           IDataset.ShiftingRecords := True;

                                           If   Assigned( FTable )
                                           then begin
                                                Database.StartTransactionWith( [ FTable ] );

                                                // Aunque tenga un filtro para que solo se vean ciertos registros, el resto existe y puede inteferir
                                                // Por eso desactivo temporalmente el filtro

                                                IsFiltered := FTable.Filtered;
                                                FTable.Filtered := False;
                                                end;

                                           try

                                               try

                                                 Last;
                                                 While not Bof and ( FAutoIncField.Value>=FLastAutoIncValue ) do
                                                   begin
                                                   Edit;
                                                   FAutoIncField.Value := FAutoIncField.Value + 1;
                                                   Post;
                                                   Prior;
                                                   end;

                                                 If   Assigned( FTable )
                                                 then Database.Commit;

                                               except
                                                 If   Assigned( FTable )
                                                 then Database.RollBack;
                                                 raise;
                                                 end;

                                           finally
                                             If   Assigned( FTable )
                                             then FTable.Filtered := IsFiltered;
                                             IDataset.ShiftingRecords := False;
                                             EnableControls;  // Para que se realicen las tareas asociadas al post
                                             end;

                                           Append;

                                           SetRecordFieldValues( FDataset, RecordFieldValues );

                                           Post;

                                         except
                                           EnableControls;
                                           If   ActiveControlInGrid
                                           then FTableView.Controller.FocusedRecordIndex := FocusedRecordIndex
                                           else FTableView.DataController.Cancel;
                                           raise;
                                           end;

                                         Abort;  // El post ya se ha realizado, por eso cancelo el post original
                                         end;
                                    end;

                 finally
                   IDataset.ShiftingRecords := False;

                   FTableView.Controller.TopRowIndex := TopRowIndex;
                   FTableView.Controller.FocusedRecordIndex := FocusedRecordIndex;

                   FTableView.DataController.EndUpdate;

                   FControllerPostingRecord := False;
                   end;

            CheckBeforePost;

            end;

end;

procedure TGridTableViewController.DoDatasetAfterPost(Dataset: TDataSet);
begin
     If   Assigned( FDatasetAfterPost )
     then FDatasetAfterPost( Dataset );
     If   FDatasetInserting
     then begin
          RefreshGrid;
          FTableView.Controller.FocusFirstAvailableItem;
          end;
end;

procedure TGridTableViewController.DoDatasetOnUpdateState(Dataset: TDataSet);
begin
     If   not ( csDestroying in ComponentState )
     then With Dataset do
            begin
            If   not ControlsDisabled and Assigned( FTableView )
            then FTableView.OptionsBehavior.AlwaysShowEditor := State in [ dsInsert, dsEdit ];
            If   Assigned( FDatasetOnUpdateState )
            then FDatasetOnUpdateState( Dataset );
            Update;
            end;
end;

// Los TableViews que tienen marcada la actualización inteligente (SmartRefresh) son incapaces de refrescarse por sí
// mismos cuando el registro maestro cambia. Sin embargo la mejora en la velocidad y la rebaja de la carga del tráfico en la red
// aconsejan utilizar esta opción.

procedure TGridTableViewController.DoDatasetApplyMasterRange(Dataset: TDataSet);
begin
     If   not ( csDestroying in ComponentState )
     then With Dataset do
            begin
            If   not ControlsDisabled and Assigned( FTableViewDataController )
            then With FTableViewDataController do
                   If   DataModeController.SmartRefresh
                   then UpdateItems( False );
            If   Assigned( FDatasetOnApplyMasterRange )
            then FDatasetOnApplyMasterRange( Dataset );
            end;
end;

// La validación se debe producir cuando se entra en modo edición o antes de guardar el registro. En el primer caso se utiliza el parámetro InvalidateBefore.
// Es importante validar el registro cuando se entra en modo edición para que se ejecuten los procedimientos asociados a la validación (carga de registros asociados, etc..)

procedure TGridTableViewController.ValidateTableView( AfterEditing : Boolean = False );

var  I : Integer;
     ErrorText : TCaption;
     Error : Boolean;
     EditDisplayValue  : Variant;

begin
     If   not FDataset.ControlsDisabled and Assigned( FTableView )
     then try

          FValidatingTableView := True;

          DoBeforeValidateTableView;

          For I := 0 to FTableView.ColumnCount - 1 do
            begin
            FValidatingColumn := TcxGridDBColumn( FTableView.Columns[ I ] );
            If   FValidatingColumn.Visible and Assigned( FTableView.ViewData.EditingRecord ) and
                 Assigned( FValidatingColumn.Properties )
            then begin

                 { Aquí no se puede utilizar ValidateEdit porque el cxCustomEdit de las columnas solo existe durante
                   la edición por parte del usuario. La alternativa es utilizar la función de validación pasando el valor
                   del campo }

                 EditDisplayValue := FTableView.ViewData.EditingRecord.Values[ I ];
                 Error := False;

                 With FValidatingColumn.Properties do
                   If   ( Required or DefaultValuesProvider.DefaultRequired ) and ValueIsEmpty( EditDisplayValue )
                   then begin
                        Error := True;
                        ErrorText := JoinMessage( RsgMsg171, RsgMsg172 );
                        end
                   else If   Assigned( OnValidate )
                        then OnValidate( nil, EditDisplayValue, ErrorText, Error );

                 If   Error and not AfterEditing
                 then begin

                      With FValidatingColumn do
                        begin
                        Focused := True;
                        Editing := True;
                        end;

                      raise EcxEditValidationError.Create( ErrorText );

                      end;

                 end;

            end;

          finally
            FValidatingTableView := False;
            end;
end;

procedure TGridTableViewController.CheckFirstRequiredColumn( AFocusedItem : TcxCustomGridTableItem;
                                                             Exiting      : Boolean = False );

var  FirstRequeriedColumn : SmallInt;

begin
     FirstRequeriedColumn := GetFirstEditableItemIndex( FTableView, True );
     If   ( FirstRequeriedColumn>=0 ) and
          ( ( Exiting and ( AFocusedItem.VisibleIndex>=FirstRequeriedColumn ) ) or ( AFocusedItem.VisibleIndex>FirstRequeriedColumn ) ) and
          ValueIsEmpty( TableView.VisibleColumns[ FirstRequeriedColumn ].EditValue )
     then begin
          FTableView.DataController.Cancel;
          Abort;
          end;
end;

procedure TGridTableViewController.DoFocusedItemChanged( Sender            : TcxCustomGridTableView;
                                                         APrevFocusedItem,
                                                         AFocusedItem      : TcxCustomGridTableItem);

begin
     If   Sender.DataController.IsEditing and
          not Sender.Controller.EditingController.CreatingNewRecord
     then begin
          If   Assigned( APrevFocusedItem )
          then CheckFirstRequiredColumn( APrevFocusedItem );
          If   Assigned( FGridOnFocusedItemChanged )
          then FGridOnFocusedItemChanged( Sender, APrevFocuseditem, AFocusedItem );
          end;
end;

{ TGridTableViewPanel }

constructor TGridTableViewPanel.Create( AOwner : TComponent );
begin
     inherited;
     PanelStyle.Active := True;
     Style.BorderStyle := ebsNone;
     TransParent := True;
     Anchors := Anchors - [ akLeft ];
     Caption := '';
     FAutoUpdatePanels := True;
end;

procedure TGridTableViewPanel.DoExit;
begin
     DoOnExit;
end;

procedure TGridTableViewPanel.Notification( AComponent : TComponent; Operation : TOperation );
begin
     inherited Notification( AComponent, Operation );
     If   Operation=opRemove
     then begin
          If   AComponent=FGrid
          then FGrid := nil
          end;
end;

procedure TGridTableViewPanel.SetGrid( const Value : TcxGrid );
begin
     If   Value<>FGrid
     then begin
          If   Assigned( FGrid )
          then FGrid.OnLayoutChanged := nil;
          FGrid := Value;
          If   Assigned( FGrid )
          then FGrid.OnStructureNavigatorChanged := DoOnStructureNavigatorChanged;
          end;
end;

function TGridTableViewPanel.GetColumnWidth( GridColumn : TcxGridColumn ) : Integer;

var  ColumnBounds : TRect;

begin
     Result := 0;
     If   Assigned( GridColumn.GridView.ViewInfo )
     then With GridColumn.GridView.ViewInfo.HeaderViewInfo do
            begin
            ColumnBounds := Items[ GridColumn.VisibleIndex ].Bounds;
            With ColumnBounds do
              Result := Right - Left;
            end;
end;

procedure TGridTableViewPanel.UpdateLayout;

var   GridFooterComponent : IgxGridFooterComponent;

begin
     If   FAutoUpdatePanels
     then For var I := 0 to ControlCount - 1 do
            begin
            var Control := Controls[ I ];
            If   ( Control is TGridTableViewPanelGroupBox ) or
                 ( Control is TGridTableViewPanelLabel )
            then If   Supports( Control, IgxGridFooterComponent, GridFooterComponent )
                 then begin
                      var GridColumn := GridFooterComponent.GetGridColumn;
                      If   Assigned( GridColumn )
                      then begin
                           var CustomEdit := TcxCustomEdit( Control );
                           If   Assigned( GridColumn.GridView.ViewInfo )
                           then With GridColumn.GridView.ViewInfo.HeaderViewInfo do
                                  For var ColumnIndex := 0 to Count - 1 do
                                    If   Items[ ColumnIndex ].Column=GridColumn
                                    then begin

                                         var ColumnBounds := Items[ ColumnIndex ].Bounds;

                                         { CustomEdit.Anchors
                                              con akLeft esta fijado al borde izquierdo de la columna del grid
                                              con akRight está alineado al border derecho de la columna
                                              con akLeft + akRight está alineado a ambos lados (ocupa el ancho de la columna)
                                         }

                                        If   ( akLeft in CustomEdit.Anchors ) and ( akRight in CustomEdit.Anchors )
                                        then begin
                                             CustomEdit.Width := ColumnBounds.Right - ColumnBounds.Left;
                                             If   CustomEdit.AlignWithMargins
                                             then CustomEdit.Width := CustomEdit.Width - CustomEdit.Margins.Right;
                                             end;

                                        If   akLeft in CustomEdit.Anchors
                                        then CustomEdit.Left := FGrid.Bounds.Left + ColumnBounds.Left - 1
                                        else If   akRight in CustomEdit.Anchors
                                             then CustomEdit.Left := FGrid.Bounds.Left + ColumnBounds.Right - CustomEdit.Width;

                                        If   CustomEdit.AlignWithMargins
                                        then begin
                                             CustomEdit.Width := CustomEdit.Width - CustomEdit.Margins.Left;
                                             CustomEdit.Left := CustomEdit.Left + CustomEdit.Margins.Left;
                                             end;

                                         Break;
                                         end;
                           end;
                      end;
            end;
end;

{
procedure TGridTableViewPanel.Resize;
begin
     inherited;
     UpdateLayout;
end;
}

procedure TGridTableViewPanel.DoOnStructureNavigatorChanged( Sender : TObject );
begin
     If   Assigned( FGrid ) and not FGrid.IsLoading
     then UpdateLayout;
end;

// TGridTableViewPanelGroupBox

function TGridTableViewPanelGroupBox.GetGridColumn: TcxGridColumn;
begin
     Result := FGridColumn;
end;

procedure TGridTableViewPanelGroupBox.Loaded;
begin
     inherited;
     PanelStyle.Active := True;
     Transparent := True;
     If   Parent is TGridTableViewPanel
     then FGridFooter := TGridTableViewPanel( Parent );
end;

procedure TGridTableViewPanelGroupBox.DoExit;
begin
     DoOnExit;
end;

procedure TGridTableViewPanelGroupBox.Notification( AComponent : TComponent;
                                                    Operation  : TOperation );
begin
     inherited Notification( AComponent, Operation );
     If   Operation=opRemove
     then begin
          If   AComponent=FGridColumn
          then FGridColumn := nil;
          end;
end;

// TGridTableViewPanelLabel

function TGridTableViewPanelLabel.GetGridColumn: TcxGridColumn;
begin
     Result := FGridColumn;
end;

procedure TGridTableViewPanelLabel.Loaded;
begin
     inherited;
     Transparent := True;
     If   Parent is TGridTableViewPanel
     then FGridFooter := TGridTableViewPanel( Parent );
end;

procedure TGridTableViewPanelLabel.DoExit;
begin
     DoOnExit;
end;

procedure TGridTableViewPanelLabel.Notification( AComponent : TComponent;
                                           Operation  : TOperation );
begin
     inherited Notification( AComponent, Operation );
     If   Operation=opRemove
     then begin
          If   AComponent=FGridColumn
          then FGridColumn := nil;
          end;
end;

initialization

  RegisterClasses( [ TGridTableViewController,
                     TGridTableViewPanel,
                     TGridTableViewPanelGroupBox,
                     TGridTableViewPanelLabel ] );
finalization

end.

