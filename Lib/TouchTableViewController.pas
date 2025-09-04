
unit TouchTableViewController;

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

    TRowShiftEvent = procedure( ShiftOperation : TShiftOperation ) of object;

    { TTouchGridTableViewController -------------------------------------------------------------------- }

    TTouchGridTableViewController = class( TcxGroupBox )
    private

      FOwnerForm : TgxForm;
      FFormManager : TgxFormManager;
      FTableView : TcxGridDBTableView;
      FDataset : TnxDataset;
      IDataset : InxeDataset;
      FTable : TnxeTable;
      FForm : TForm;
      FButtonWidth : Integer;
      FRecordButtonLink : TRecordButtonLink;
      FUserSelectionTimer : TTimer;
      FValidatingTableView,
      FValidatingTableViewAfterEdit,
      FHighlightFixedColumns : Boolean;
      FDocumentActive : Boolean;
      FUseGridFilterBox : Boolean;
      FValidatingColumn : TcxGridDBColumn;
      FCurrentCellViewInfo : TcxGridTableDataCellViewInfo;
      FSavedOnFocusedRecordChanged : TcxGridFocusedRecordChangedEvent;
      FSavedOnCustomDrawCell : TcxGridTableDataCellCustomDrawEvent;

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

      FGridOnCellClick,
      FGridOnCellDblClick : TcxGridCellClickEvent;

      FTableViewEditing,                                       // La configuración del GridTable al inicio
      FTableViewDeleting,
      FTableViewInserting  : Boolean;

      FGridOnEnter,
      FGridOnExit : TNotifyEvent;
      FOnUserSelection : TUserSelectionEvent;

      FOnRowShift : TRowShiftEvent;

      FOnShowDocument,
      FOnRowInsert,

      FOnCanEditRow,
      FOnCanDeleteRow,
      FOnCanInsertRow,
      FOnCanShiftRow,
      FOnCanShowDocument : TCheckEvent;

      FGridOnFocusedItemChanged : TcxGridFocusedItemChangedEvent;
      // FGridOnFocusedRecordChanged : TcxGridFocusedRecordChangedEvent;
      FTableViewColumnHeaderClick : TcxGridColumnEvent;

      FShowDeleteWarning,
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

      FDocumentButton,
      FShiftDownButton,
      FShiftUpButton,
      FInsertButton,
      FAppendButton,
      FDeleteButton : TcxButton;

      FFirtsItemIndex: Integer;

      FOnInsert,
      FOnDelete : TNotifyEvent;

      procedure OnDocumentButtonClick(Sender: TObject);
      procedure OnShiftUpButtonClick(Sender: TObject);
      procedure OnShiftDownButtonClick(Sender: TObject);
      procedure OnInsertButtonClick(Sender: TObject);
      procedure OnAppendButtonClick(Sender: TObject);
      procedure OnDeleteButtonClick(Sender: TObject);

      // procedure SetDocumentActive( const Value : Boolean );
      procedure SetTableView( const Value : TcxGridDBTableView );
      procedure SetShiftRecords( const Value : Boolean );
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

      procedure DoOnCustomDrawCell( Sender : TcxCustomGridTableView; ACanvas : TcxCanvas; AViewInfo : TcxGridTableDataCellViewInfo; var ADone : Boolean );
      procedure DoOnFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean );

      procedure DoOnUserSelectionTimer( Sender : TObject );

      function CanShiftRow : Boolean;
      function CanEditRow : Boolean;
      function CanInsertRow : Boolean;
      function CanDeleteRow : Boolean;
      function CanShowDocument : Boolean;

      procedure SetButtonsAlignment;

    protected
      procedure DoExit; override;
      procedure Notification( AComponent : TComponent; Operation : TOperation ); override;
      procedure Loaded; override;

      function GetOwnerForm: TgxForm;
      function GetFormManager : TgxFormManager;
    public
      constructor Create( AOwner : TComponent ); override;
      procedure CreateWnd; override;
      procedure Resize; override;
      procedure Update; override;
      procedure SetupTableViewLink;
      procedure CheckFixedColumnsStyle;
      procedure ShiftUp( ToFirstRow : Boolean = False );
      procedure ShiftDown( ToLastRow : Boolean = False );
      procedure InsertRow;
      procedure AppendRow;
      procedure DeleteRow( ShowWarning : Boolean = True );
      procedure RefreshGrid;

      procedure ValidateTableView( AfterEditing : Boolean = False );

      property  AutoIncValue : Variant read FAutoIncValue;
      property  DocumentActive : Boolean read FDocumentActive write SetDocumentActive;

      property  DocumentButton : TcxButton read FDocumentButton;
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

    published

      property HighlightFixedColumns : Boolean read FHighlightFixedColumns write FHighlightFixedColumns default True;
      property TableView : TcxGridDBTableView read FTableView write SetTableView;
      property ShiftRecords : Boolean read FShiftRecords write SetShiftRecords;
      property UseGridFilterBox : Boolean read FUseGridFilterBox write FUseGridFilterBox;

      property OnUserSelection : TUserSelectionEvent read FOnUserSelection write FOnUserSelection;
      property OnInsert : TNotifyEvent read FOnInsert write FOnInsert;
      property OnDelete : TNotifyEvent read FOnDelete write FOnDelete;
      property OnRowShift : TRowShiftEvent read FOnRowShift write FOnRowShift;
      property OnRowInsert : TCheckEvent read FOnRowInsert write FOnRowInsert;
      property OnShowDocument : TCheckEvent read FOnShowDocument write FOnShowDocument;

      property OnCanEditRow : TCheckEvent read FOnCanEditRow write FOnCanEditRow;
      property OnCanDeleteRow : TCheckEvent read FOnCanDeleteRow write FOnCanDeleteRow;
      property OnCanInsertRow : TCheckEvent read FOnCanInsertRow write FOnCanInsertRow;
      property OnCanShiftRow : TCheckEvent read FOnCanShiftRow write FOnCanShiftRow;
      property OnCanShowDocument : TCheckEvent read FOnCanShowDocument write FOnCanShowDocument;
    end;

    TTouchGridTableViewPanel = class( TcxGroupBox )
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

    TTouchGridTableViewPanelGroupBox = class( TcxGroupBox, IgxGridFooterComponent )
    private
      FGridFooter : TTouchGridTableViewPanel;
      FGridColumn : TcxGridColumn;
    protected
     procedure DoExit; override;
     procedure Notification( AComponent : TComponent; Operation : TOperation ); override;
     procedure Loaded; override;
     function GetGridColumn : TcxGridColumn;
    published
      property GridColumn : TcxGridColumn read FGridColumn write FGridColumn;
      end;

   TTouchGridTableViewPanelLabel = class( TcxLabel, IgxGridFooterComponent )
    private
      FGridFooter : TTouchGridTableViewPanel;
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
       cxGridDBDataDefinitions,

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

       HintMsg1 = 'Muestra el documento que originó esta línea.'#13'Teclas [Ctrl]+[D]';

       HintMsg21 = 'Desplaza el registro una línea hacia arriba'#13'Teclas [Ctrl]+[Shift]+[Arriba]\no al principio de la lista'#13'Teclas [Ctrl]+[Shift]+[Inicio], Ratón [Shift]+<Click>';
       HintMsg22 = 'Desplaza el registro una línea hacia abajo'#13'Teclas [Ctrl]+[Shift]+[Abajo]\no al final de la lista'#13'Teclas [Ctrl]+[Shift]+[Fin], Ratón [Shift]+<Click>';

       HintMsg24 = 'Inserta un nuevo registro (línea).'#13'Tecla [Insert]';
       HintMsg25 = 'Suprime un registro (línea).'#13'Tecla [Supr]';
       HintMsg26 = 'Añade un nuevo registro (línea).'#13'Tecla [Shift]+[Insert]';

// TTouchGridTableViewController

constructor TTouchGridTableViewController.Create( AOwner : TComponent );
begin
     inherited;

     FHighlightFixedColumns := True;
     Style.BorderStyle := ebsNone;

     FUserSelectionTimer := TTimer.Create( Self );
     FUserSelectionTimer.Enabled := False;
     FUserSelectionTimer.Interval := 200;
     FUserSelectionTimer.OnTimer := DoOnUserSelectionTimer;

     Enabled := TouchApplication;
     Caption := '';
     PanelStyle.Active := True;
     BevelInner := bvNone;
     BevelOuter := bvNone;

end;

procedure TTouchGridTableViewController.CreateWnd;
begin
     inherited CreateWnd;
end;

{
procedure TButton.Click;
begin
     If   GetTickCount - Tag < GetDoubleClickTime
     then begin
          // ShowMessage('only 1 click is needed');
          end
     else begin
          // if user hasn't clicked for at least GetDoubleClickTime() miliseconds, process onClick procedure
          inherited;
          // remember the time when button is clicked
          Tag := GetTickCount;
          end;
end;
}

function TTouchGridTableViewController.GetOwnerForm : TgxForm;

var  AForm : TCustomForm;

begin
     If   not Assigned( FOwnerForm )
     then begin
          AForm := GetParentForm( Self, { TopForm } False );
          If   AForm is TgxForm
          then FOwnerForm := TgxForm( AForm )
          else raise Exception.Create( RsMsg69 );
          end;
     Result := FOwnerForm;
end;

function TTouchGridTableViewController.GetFormManager : TgxFormManager;
begin
     If   not Assigned( FFormManager )
     then If   Assigned( OwnerForm )
          then FFormManager := TgxFormManager( FOwnerForm.FindComponent( FormManagerName ) );
     Result := FFormManager;
end;

procedure TTouchGridTableViewController.SetButtonsAlignment;

var  BA, BB : TAlign;

procedure SetupButton( AButton : TcxButton; Align : TAlign );
begin
     AButton.Align := Align;
     If   not ( Align in [ alTop, alLeft ] ) // Es el primer botón
     then If   Align=alBottom
          then AButton.Margins.Top := 4
          else AButton.Margins.Left:= 4;
end;

begin
     If   Assigned( FAppendButton )
     then If   TouchApplication
          then begin
               SetupButton( FAppendButton, TAlign.alTop );
               SetupButton( FDeleteButton, TAlign.alBottom );
               end
          else begin

               If   Align in [ alRight, alLeft ]
               then begin
                    BA := TAlign.alTop;
                    BB := TAlign.alBottom;
                    Width := FShiftUpButton.Width + 4;
                    end
               else begin
                    BA := TAlign.alLeft;
                    BB := TAlign.alRight;
                    Height := FShiftUpButton.Height + 4;
                    end;

               SetupButton( FShiftUpButton, BA );

               SetupButton( FShiftDownButton, BB );
               SetupButton( FInsertButton, BB );
               SetupButton( FAppendButton, BB );
               SetupButton( FDeleteButton, BB );
               SetupButton( FDocumentButton, BB );

               end;
end;

procedure TTouchGridTableViewController.Update;

var  BEnabled : Boolean;
     AutoEdit,
     AssignedFocusedRow : Boolean;

begin

     inherited Update;

     If   Assigned( FAppendButton ) and
          Assigned( FDataset )
     then begin

          AutoEdit := False;
          AssignedFocusedRow := False;

          If   Assigned( FTableView ) and
               Assigned( FTableView.DataController ) and
               Assigned( FTableView.DataController.DataSource )
          then begin
               AutoEdit := FTableView.DataController.DataSource.AutoEdit;
               AssignedFocusedRow := Assigned( FTableView.Controller.FocusedRow );
               end;

          BEnabled := AutoEdit and Enabled and ( FDataset.State<>dsInsert );

          If   TouchApplication
          then FAppendButton.Enabled := True
          else begin

               FDocumentButton.Visible := Assigned( FOnShowDocument );

               FShiftUpButton.Visible := FShiftRecords;
               FShiftDownButton.Visible := FShiftRecords;

               FDeleteButton.Visible := Assigned( FOnDelete ) or FTableViewDeleting;
               FInsertButton.Visible := Assigned( FOnInsert ) or FTableViewInserting;
               FAppendButton.Visible := Assigned( FOnInsert ) or FTableViewInserting;

               DocumentActive := CanShowDocument;  // Esto activa y desactiva el botón del documento

               FShiftUpButton.Enabled := BEnabled and CanShiftRow;
               FShiftDownButton.Enabled := BEnabled and CanShiftRow;
               FInsertButton.Enabled := BEnabled and CanInsertRow;
               FAppendButton.Enabled := BEnabled and CanInsertRow;
               end;

          FDeleteButton.Enabled := AutoEdit and Enabled and AssignedFocusedRow and not CantDeleteRecords and CanDeleteRow;

          end;
end;

procedure TTouchGridTableViewController.DoExit;
begin
     DoOnExit;
end;

procedure TTouchGridTableViewController.Notification( AComponent : TComponent; Operation : TOperation );
begin
     inherited Notification( AComponent, Operation );
     If   Operation=opRemove
     then begin
          If   AComponent=FTableView
          then FTableView := nil;
          end;
end;

procedure TTouchGridTableViewController.SetShiftRecords( const Value : Boolean );
begin
     If   FShiftRecords<>Value
     then begin
          FShiftRecords := Value;
          Update;
          end;
end;

procedure TTouchGridTableViewController.SetDocumentActive( const Value : Boolean );
begin
     FDocumentActive := Value;
     If   Assigned( FDocumentButton )
     then FDocumentButton.Enabled := Enabled and FDocumentActive;
end;

procedure TTouchGridTableViewController.OnDocumentButtonClick(Sender: TObject);
begin
     If   Assigned( FOnShowDocument )
     then FOnShowDocument;
end;

procedure TTouchGridTableViewController.RefreshGrid;
begin
     // Si la rejilla no está en modo SmartRefresh ya se actualiza automáticamente después de cada inserción o cambio

     With FTableView.DataController do
       If   DataModeController.SmartRefresh
       then UpdateItems( False );

end;

procedure TTouchGridTableViewController.Resize;

var  BtnHeight : Integer;

procedure UpdateButtonHeight( Button : TcxButton );
begin
     With Button do
       begin
       Height := BtnHeight;
       OptionsImage.Glyph.SourceHeight := BtnHeight - 8;
       OptionsImage.Glyph.SourceWidth := BtnHeight - 8;
       end;
end;

begin
     inherited;

     If   Assigned( FAppendButton )
     then begin
          BtnHeight := FAppendButton.Width;

          If   not TouchApplication
          then begin
               UpdateButtonHeight( FShiftUpButton );
               UpdateButtonHeight( FInsertButton );
               UpdateButtonHeight( FDocumentButton );
               UpdateButtonHeight( FShiftDownButton );
               end;

          UpdateButtonHeight( FDeleteButton );
          UpdateButtonHeight( FAppendButton );
          end;
end;

procedure TTouchGridTableViewController.OnShiftUpButtonClick(Sender: TObject);
begin
     ShiftUp( IsKeyPressed( VK_SHIFT ) );
end;

procedure TTouchGridTableViewController.ShiftUp( ToFirstRow : Boolean = False );

var  I, J : SmallInt;
     RecordFieldValues : TFieldValuesArray;
     ShiftOperation : TShiftOperation;

begin
     If   Assigned( FDataset ) and  // Si está asignado FDataset, también lo está IDataset
          FShiftRecords and
          FAppendButton.Enabled
     then With FDataset do
            begin
            DisableControls;
            IDataset.ShiftingRecords := True;
            FTableView.DataController.BeginFullUpdate;
            try
              If   Assigned( FOnRowShift )
              then begin
                   If   ToFirstRow
                   then ShiftOperation := soFirst
                   else ShiftOperation := soPrior;
                   FOnRowShift( ShiftOperation );
                   end
              else begin

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
              IDataset.ShiftingRecords := False;
              FTableView.DataController.EndFullUpdate;
              EnableControls;
              RefreshGrid;
              If   ToFirstRow
              then First
              else Prior;
              end;

            end;

end;

procedure TTouchGridTableViewController.ShiftDown( ToLastRow : Boolean = False );

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
              If   Assigned( FOnRowShift )
              then begin
                   If   ToLastRow
                   then ShiftOperation := soLast
                   else ShiftOperation := soNext;
                   FOnRowShift( ShiftOperation );
                   end
              else begin
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
              IDataset.ShiftingRecords := False;
              FTableView.DataController.EndFullUpdate;
              EnableControls;
              RefreshGrid;
              If   ToLastRow
              then Last
              else Next;
              end;

            end;

end;

procedure TTouchGridTableViewController.OnInsertButtonClick(Sender: TObject);
begin
     InsertRow;
end;

procedure TTouchGridTableViewController.OnShiftDownButtonClick(Sender: TObject);
begin
     ShiftDown( IsKeyPressed( VK_SHIFT ) );
end;

procedure TTouchGridTableViewController.OnAppendButtonClick(Sender: TObject);
begin
     AppendRow;
end;

procedure TTouchGridTableViewController.InsertRow;
begin
     If   Assigned( FOnInsert )
     then FOnInsert( Self );
     If   Assigned( FTableView ) and CanInsertRow
     then FTableView.Controller.CreateNewRecord( False );
end;

procedure TTouchGridTableViewController.AppendRow;
begin
     If   Assigned( FOnInsert )
     then FOnInsert( Self );
     If   Assigned( FTableView ) and CanInsertRow
     then FTableView.Controller.CreateNewRecord( True );
          {
          With FTableView.Controller do
            begin
            FTableView.DataController.Append;
            FTableView.Site.SetFocus;
            FocusFirstAvailableItem;
            FTableView.Controller.EditingController.ShowEdit;
            end;
          }
end;

procedure TTouchGridTableViewController.OnDeleteButtonClick(Sender: TObject);
begin
     If   Assigned( FTableView )
     then If   dceInsert in FTableView.DataController.EditState
          then FTableView.DataController.Cancel
          else DeleteRow;
end;

procedure TTouchGridTableViewController.DeleteRow( ShowWarning : Boolean = True );
begin
     If   not CantDeleteRecords and CanDeleteRow
     then begin
          If   Assigned( FOnDelete )
          then FOnDelete( Self );
          If   Assigned( FTableView )
          then try
                 FShowDeleteWarning := ShowWarning;
                 FTableView.DataController.DeleteSelection;
               finally
                 FShowDeleteWarning := False;
                 FTableView.DataController.Refresh;
                 end;
          end;
end;

procedure TTouchGridTableViewController.DoDatasetBeforeDelete( Dataset : TDataSet );

var  DeleteMessage : String;

begin
     If   Assigned( IDataset ) and not IDataset.ShiftingRecords
     then begin
          If   FShowDeleteWarning
          then begin
               FShowDeleteWarning := False;  // En el borrado de múltiples líneas también evita que se muestre el aviso por cada una
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

procedure TTouchGridTableViewController.SetTableView( const Value : TcxGridDBTableView );

var  TableViewDataController : TcxGridDBDataController;

begin
     If   Value<>FTableView
     then begin
          FTableView := Value;
          If   Assigned( FTableView ) and not IsDesignTime
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

               TableViewDataController := TcxGridDBDataController( FTableView.DataController );
               If   not FTableView.OptionsData.Editing and
                    not ( Assigned( TableViewDataController.Summary.DefaultGroupSummaryItems.OnSummary ) or
                          Assigned( TableViewDataController.Summary.FooterSummaryItems.OnSummary ) or
                          Assigned( TableViewDataController.Summary.OnAfterSummary ) )
               then TableViewDataController.DataModeController.GridMode := True;   //* 19.05.2010  Finalmente me rindo a la tiranía del rendimiento

               FSavedOnFocusedRecordChanged := FTableView.OnFocusedRecordChanged;
               FTableView.OnFocusedRecordChanged:= DoOnFocusedRecordChanged;
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
                 end;
               end;
          end;
end;

procedure TTouchGridTableViewController.DoOnCustomDrawCell(     Sender    : TcxCustomGridTableView;
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

procedure TTouchGridTableViewController.DoOnFocusedRecordChanged( Sender                         : TcxCustomGridTableView;
                                                           APrevFocusedRecord,
                                                           AFocusedRecord                 : TcxCustomGridRecord;
                                                           ANewItemRecordFocusingChanged  : Boolean );
begin
     If   Assigned( FSavedOnFocusedRecordChanged )
     then FSavedOnFocusedRecordChanged( Sender, APrevFocusedRecord, AFocusedRecord, ANewItemRecordFocusingChanged );
     DocumentActive := CanShowDocument;
end;

procedure TTouchGridTableViewController.CheckFixedColumnsStyle;

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

procedure TTouchGridTableViewController.Loaded;


procedure CreateButton( var AButton     : TcxButton;
                            Image       : TcxImageCollectionItem;
                            AMessage    : String;
                            AOnClick    : TNotifyEvent );
begin
     AButton := TcxButton.Create( Self );
     With AButton do
       begin
       Parent := Self;
       Width := FButtonWidth;
       Height := FButtonWidth;
       SpeedButtonOptions.CanBeFocused := False;
       SpeedButtonOptions.Flat := True;
       SpeedButtonOptions.Transparent := True;
       Glyph.Assign( Image.Picture.Graphic );
       NumGlyphs := 1;
       OptionsImage.Glyph.SourceHeight := FButtonWidth - 8;
       OptionsImage.Glyph.SourceWidth := FButtonWidth - 8;
       Hint := AMessage;
       ShowHint := True;
       Caption := '';
       OnClick := aOnClick;
       end;
end;

begin
     inherited;
     FForm := TForm( GetParentForm( Self ) );

     FButtonWidth := Width - 2;

     If   TouchApplication
     then begin
          CreateButton( FAppendButton, ApplicationForms.RowInsertImage, HintMsg26, OnAppendButtonClick );
          CreateButton( FDeleteButton, ApplicationForms.RowDeleteImage, HintMsg25, OnDeleteButtonClick );
          end
     else begin
          CreateButton( FShiftUpButton, ApplicationForms.RowShiftUpImage, HintMsg21, OnShiftUpButtonClick );

          CreateButton( FInsertButton, ApplicationForms.RowInsertImage, HintMsg24, OnInsertButtonClick );
          CreateButton( FAppendButton, ApplicationForms.RowAppendImage, HintMsg26, OnAppendButtonClick );
          CreateButton( FDeleteButton, ApplicationForms.RowDeleteImage, HintMsg25, OnDeleteButtonClick );
          CreateButton( FDocumentButton, ApplicationForms.RowEditImage, HintMsg1, OnDocumentButtonClick );
          CreateButton( FShiftDownButton, ApplicationForms.RowShiftDownImage, HintMsg22, OnShiftDownButtonClick );
          end;

     SetButtonsAlignment;

     Update;

     SetupTableViewLink;
end;

procedure TTouchGridTableViewController.SetupTableViewLink;

var  TableViewDataController : TcxGridDBDataController;

begin
     If   not IsDesignTime and Assigned( FTableView )
     then begin
          TableViewDataController := TcxGridDBDataController( FTableView.DataController );
          If   Assigned( TableViewDataController.DataSource )
          then If   Assigned( TableViewDataController.DataSource.Dataset )
               then begin
                    FDataset := TnxDataset( TableViewDataController.DataSource.Dataset );
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

procedure TTouchGridTableViewController.DoGridCellClick(     Sender        : TcxCustomGridTableView;
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

procedure TTouchGridTableViewController.DoGridCellDblClick(     Sender        : TcxCustomGridTableView;
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

procedure TTouchGridTableViewController.DoOnUserSelectionTimer( Sender : TObject );

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

procedure TTouchGridTableViewController.DoColumnHeaderClick( Sender  : TcxGridTableView;
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

procedure TTouchGridTableViewController.DoGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
                          then OnDocumentButtonClick( Sender );

         else       If   Assigned( FGridOnKeyDown )
                    then FGridOnKeyDown( Sender, Key, Shift );
         end;

end;

procedure TTouchGridTableViewController.DoGridEnter( Sender : TObject );
begin

     Enabled := True;
     Update;

     If   not FDataset.ControlsDisabled
     then begin

          If   ( IDataset.MasterRelation=mrTied ) and
               Assigned( FormManager.Table )
          then FormManager.Table.Update;

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

procedure TTouchGridTableViewController.CheckEditingOnExit;

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

function TTouchGridTableViewController.CanEditRow : Boolean;
begin
     If   Assigned( FOnCanEditRow )
     then Result := FOnCanEditRow
     else If   Assigned( FTableView )
          then Result := FDataset.ControlsDisabled or FTableView.OptionsData.Editing
          else Result := False;
end;

function TTouchGridTableViewController.CanShowDocument : Boolean;
begin
     If   Assigned( FOnCanShowDocument )
     then Result := FOnCanShowDocument
     else Result := False;
end;

function TTouchGridTableViewController.CanShiftRow : Boolean;
begin
     If   Assigned( FOnCanShiftRow )
     then Result := FOnCanShiftRow
     else Result := True;
end;

function TTouchGridTableViewController.CanInsertRow : Boolean;
begin

     // Compruebo el ControlsDisabled para permitir realizar inserciones desde la aplicación (código) aunque al usuario no
     // le esté permitido hacerlo. Basta con desactivar los controles y realizar las inserciones.

     If   Assigned( FOnCanInsertRow )
     then Result := FOnCanInsertRow
     else If   Assigned( FTableView )
          then Result := FDataset.ControlsDisabled or FTableView.OptionsData.Inserting or FTableView.OptionsData.Appending
          else Result := False;
end;

function TTouchGridTableViewController.CanDeleteRow : Boolean;
begin
     If   Assigned( FOnCanDeleteRow )
     then Result := FOnCanDeleteRow
     else If   Assigned( FTableView )
          then Result := FDataset.ControlsDisabled or FTableView.OptionsData.Deleting
          else Result := False;
end;

procedure TTouchGridTableViewController.DoGridExit( Sender : TObject );
begin

     CheckEditingOnExit;

     If   FDataset.State=dsInsert
     then begin
          FTableView.DataController.Cancel;  // Desbloqueo el registro y/o cancelo las inserciones incompletas
          CheckFirstRequiredColumn( FTableView.Controller.FocusedItem, True );
          end;

     Enabled := TouchApplication;
     Update;
     If   Assigned( FGridOnExit )
     then FGridOnExit( Sender );

end;

procedure TTouchGridTableViewController.DoDatasetBeforeInsert(Dataset: TDataSet);
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

procedure TTouchGridTableViewController.DoDatasetAfterEdit(Dataset: TDataSet);
begin
     try
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

procedure TTouchGridTableViewController.DoDatasetOnNewRecord(Dataset: TDataSet);
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

procedure TTouchGridTableViewController.DoDatasetBeforePost(Dataset: TDataSet);

var  TopRowIndex,
     FocusedRecordIndex : Integer;
     FirtsItemIndex: Integer;
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
                                           RecordFieldValues := GetRecordFieldValues( FDataset );
                                           DisableControls;
                                           Cancel;

                                           // En ocasiones el control de edición consigue mantenerse activo y se producía un error al intentar validarlo porque
                                           // el registro ya no está en modo edición (no importa que se cierre a lo bruto porque todos los campos ya están validados y guardados )

                                           If   Assigned( FTableView.Controller.EditingController )
                                           then FTableView.Controller.EditingController.HideEdit( False );

                                           IDataset.ShiftingRecords := True;

                                           If   Assigned( FTable )
                                           then Database.StartTransactionWith( [ FTable ] );

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
                                             IDataset.ShiftingRecords := False;
                                             EnableControls;  // Para que se realicen las tareas asociadas al post
                                             end;

                                           Append;
                                           SetRecordFieldValues( FDataset, RecordFieldValues );
                                           If   Assigned( FDatasetBeforePost )
                                           then FDatasetBeforePost( Dataset );
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

            end;

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

procedure TTouchGridTableViewController.DoDatasetAfterPost(Dataset: TDataSet);
begin
     If   Assigned( FDatasetAfterPost )
     then FDatasetAfterPost( Dataset );
     If   FDatasetInserting
     then begin
          RefreshGrid;
          FTableView.Controller.FocusFirstAvailableItem;
          end;
end;

procedure TTouchGridTableViewController.DoDatasetOnUpdateState(Dataset: TDataSet);
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

procedure TTouchGridTableViewController.DoDatasetApplyMasterRange(Dataset: TDataSet);
begin
     If   not ( csDestroying in ComponentState )
     then With Dataset do
            begin
            If   not ControlsDisabled and Assigned( FTableView )
            then With FTableView.DataController do
                   If   DataModeController.SmartRefresh
                   then UpdateItems( False );
            If   Assigned( FDatasetOnApplyMasterRange )
            then FDatasetOnApplyMasterRange( Dataset );
            end;
end;

// La validación se debe producir cuando se entra en modo edición o antes de guardar el registro. En el primer caso se utiliza el parámetro InvalidateBefore.
// Es importante validar el registro cuando se entra en modo edición para que se ejecuten los procedimientos asociados a la validación (carga de registros asociados, etc..)

procedure TTouchGridTableViewController.ValidateTableView( AfterEditing : Boolean = False );

var  I : Integer;
     ErrorText : TCaption;
     Error : Boolean;
     EditDisplayValue  : Variant;

begin
     If   Assigned( FTableView )
     then try

          FValidatingTableView := True;
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

procedure TTouchGridTableViewController.CheckFirstRequiredColumn( AFocusedItem : TcxCustomGridTableItem;
                                                             Exiting      : Boolean = False );

var  FirstRequeriedColumn : SmallInt;

begin
     FirstRequeriedColumn := GetFirstEditableItemIndex( FTableView, True );
     If   ( FirstRequeriedColumn>=0 ) and
          ( ( Exiting and ( AFocusedItem.Index>=FirstRequeriedColumn ) ) or ( AFocusedItem.Index>FirstRequeriedColumn ) ) and
          ValueIsEmpty( TableView.Columns[ FirstRequeriedColumn ].EditValue )
     then begin
          FTableView.DataController.Cancel;
          Abort;
          end;
end;

procedure TTouchGridTableViewController.DoFocusedItemChanged( Sender            : TcxCustomGridTableView;
                                                       APrevFocusedItem,
                                                       AFocusedItem      : TcxCustomGridTableItem);

begin
     If   Sender.DataController.IsEditing
     then begin
          If   Assigned( APrevFocusedItem )
          then CheckFirstRequiredColumn( AFocusedItem );
          If   Assigned( FGridOnFocusedItemChanged )
          then FGridOnFocusedItemChanged( Sender, APrevFocuseditem, AFocusedItem );
          end;
end;

{ TTouchGridTableViewPanel }

constructor TTouchGridTableViewPanel.Create( AOwner : TComponent );
begin
     inherited;
     PanelStyle.Active := True;
     Style.BorderStyle := ebsNone;
     TransParent := True;
     Anchors := Anchors - [ akLeft ];
     Caption := '';
     FAutoUpdatePanels := True;
end;

procedure TTouchGridTableViewPanel.DoExit;
begin
     DoOnExit;
end;

procedure TTouchGridTableViewPanel.Notification( AComponent : TComponent; Operation : TOperation );
begin
     inherited Notification( AComponent, Operation );
     If   Operation=opRemove
     then begin
          If   AComponent=FGrid
          then FGrid := nil
          end;
end;

procedure TTouchGridTableViewPanel.SetGrid( const Value : TcxGrid );
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

function TTouchGridTableViewPanel.GetColumnWidth( GridColumn : TcxGridColumn ) : Integer;

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

procedure TTouchGridTableViewPanel.UpdateLayout;

var   GridFooterComponent : IgxGridFooterComponent;

begin
     If   FAutoUpdatePanels
     then For var I := 0 to ControlCount - 1 do
            begin
            var Control := Controls[ I ];
            If   ( Control is TTouchGridTableViewPanelGroupBox ) or
                 ( Control is TTouchGridTableViewPanelLabel )
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
procedure TTouchGridTableViewPanel.Resize;
begin
     inherited;
     UpdateLayout;
end;
}

procedure TTouchGridTableViewPanel.DoOnStructureNavigatorChanged( Sender : TObject );
begin
     If   Assigned( FGrid ) and not FGrid.IsLoading
     then UpdateLayout;
end;

// TTouchGridTableViewPanelGroupBox

function TTouchGridTableViewPanelGroupBox.GetGridColumn: TcxGridColumn;
begin
     Result := FGridColumn;
end;

procedure TTouchGridTableViewPanelGroupBox.Loaded;
begin
     inherited;
     PanelStyle.Active := True;
     Transparent := True;
     If   Parent is TTouchGridTableViewPanel
     then FGridFooter := TTouchGridTableViewPanel( Parent );
end;

procedure TTouchGridTableViewPanelGroupBox.DoExit;
begin
     DoOnExit;
end;

procedure TTouchGridTableViewPanelGroupBox.Notification( AComponent : TComponent;
                                                    Operation  : TOperation );
begin
     inherited Notification( AComponent, Operation );
     If   Operation=opRemove
     then begin
          If   AComponent=FGridColumn
          then FGridColumn := nil;
          end;
end;

// TTouchGridTableViewPanelLabel

function TTouchGridTableViewPanelLabel.GetGridColumn: TcxGridColumn;
begin
     Result := FGridColumn;
end;

procedure TTouchGridTableViewPanelLabel.Loaded;
begin
     inherited;
     Transparent := True;
     If   Parent is TTouchGridTableViewPanel
     then FGridFooter := TTouchGridTableViewPanel( Parent );
end;

procedure TTouchGridTableViewPanelLabel.DoExit;
begin
     DoOnExit;
end;

procedure TTouchGridTableViewPanelLabel.Notification( AComponent : TComponent;
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

  RegisterClasses( [ TTouchGridTableViewController,
                     TTouchGridTableViewPanel,
                     TTouchGridTableViewPanelGroupBox,
                     TTouchGridTableViewPanelLabel ] );
finalization

end.

