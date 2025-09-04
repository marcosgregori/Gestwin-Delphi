unit EditSelector;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,

  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxClasses, cxGridLevel, cxGrid, cxGroupBox, cxDBEdit, cxLabel, cxButtons,
  cxGridCustomView, cxGridCustomTableView, cxGridDBTableView,
  cxContainer, cxEdit, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, Data.DB, cxDBData, cxGridTableView, dxSkinsCore, cxTextEdit,
  dxSkinsDefaultPainters, Vcl.Menus, Vcl.StdCtrls, dxUIAClasses,

  AppContainer,
  AppForms,
  AppManager,
  GridTableViewController,

  DataManager;

type
  TgxEditSelector = class;

  TSelectorRelationForm = class(TgxForm)
    GridLevel: TcxGridLevel;
    Grid: TcxGrid;
    GridTableViewController: TGridTableViewController;
    FormManager: TgxFormManager;
    ButtonPanel: TgxEditPanel;
    AcceptButton: TgBitBtn;
    CleanButton: TgBitBtn;
    procedure FormManagerCloseForm(Sender: TObject; var Action: TCloseAction);
    procedure FormManagerDeactivateForm(ChildProcess: Boolean);
    procedure CleanButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

    FEditSelector : TgxEditSelector;

  protected
    procedure CreateParams(var Params: TCreateParams); override;

  public

    property EditSelector : TgxEditSelector read FEditSelector write FEditSelector;
    property TableViewController : TGridTableViewController read GridTableViewController;
  end;

  TEditMode = ( tesSimple, tesRange, tesRelation );

  // Es de un tipo especial para poder reconocerlo fácilmente en los procesos de validación

  TgxRelationButton = class( TgBitBtn )
    private
      FEditSelector : TgxEditSelector;
    public
      property EditSelector : TgxEditSelector read FEditSelector;
    end;

  TgxSelectorOptions = class( TPersistent )
  private

    FEditSelector : TgxEditSelector;
    FStartEdit,
    FEndEdit : TcxTextEdit;
    FRangeBox : TgxRangeBox;
    FGridView : TcxGridDBTableView;
    FGridWidth : SmallInt;
    FOnValidateCodigo : TcxEditValidateEvent;
    FFieldName : String;
    FField : TField;

    procedure SetGridView(const Value: TcxGridDBTableView);
    procedure SetEndEdit(const Value: TcxTextEdit );
    procedure SetStartEdit(const Value: TcxTextEdit );
    procedure DoOnValidateCodigo(Sender: TcxCustomEdit; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    function GetField : TField;

  public
    constructor Create( AOwner: TgxEditSelector ); virtual;
    procedure Assign(ASource: TPersistent); override;
    procedure FreeNotification(Sender: TComponent); virtual;

    property Field : TField read GetField;

  published

    property StartEdit : TcxTextEdit read FStartEdit write SetStartEdit;
    property EndEdit : TcxTextEdit read FEndEdit write SetEndEdit;
    property GridView : TcxGridDBTableView read FGridView write SetGridView;
    property RangeBox : TgxRangeBox read FRangeBox write FRangeBox;
    property FieldName : String read FFieldName write FFieldName;
    end;

  TgxEditSelector = class( TcxGroupBox )

  private

    FEditMode : TEditMode;
    FSelectorOptions : TgxSelectorOptions;
    FRelationButton : TgxRelationButton;
    FEditModeButton : TgBitBtn;
    FGridDataset : TnxeTable;
    FOwnerForm : TCustomForm;
    FRelationFormVisible : Boolean;
    FOnEditModeChanged : TSimpleEvent;
    FSelectorRelationForm : TSelectorRelationForm;

    procedure SetEditMode( const Value : TEditMode );
    procedure DoOnControlKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure DoOnModeButtonClick( Sender : TObject );
    procedure DoOnRelationButtonClick( Sender : TObject );
    procedure ShowRelationForm;
    procedure SetSelectorOptions(AValue: TgxSelectorOptions);
    procedure DoCommute;
    procedure SetFocus; override;

  protected

    procedure Loaded; override;
    procedure Initialize; override;
    procedure Notification( AComponent : TComponent;Operation  : TOperation );  override;

    procedure UpdateDescription;

  public

    constructor Create( AOwner : TComponent ); override;
    destructor Destroy; override;

    procedure ExtractList( StringList : TStringList );

    function GetRelationText( QuotedRelation : Boolean = False; Suffix : String = '' ): String;
    function GetSQLSelection( FieldName : String = 'Codigo' ) : String;
    procedure GetRangeSelection( out CodigoInicial, CodigoFinal : String );
    function GetReportSelectionText : String;
    procedure Validate( var AErrorText : TCaption; var AError: Boolean);
    function ValidValue( Value : String ) : Boolean;

    property ModeButton : TgBitBtn read FEditModeButton;
    property RelationButton : TgxRelationButton read FRelationButton;
    property SelectorRelationForm : TSelectorRelationForm read FSelectorRelationForm;

  published

    property EditMode : TEditMode read FEditMode write SetEditMode default tesRange;
    property SelectorOptions : TgxSelectorOptions read FSelectorOptions write SetSelectorOptions;
    property OnEditModeChanged : TSimpleEvent read FOnEditModeChanged write FOnEditModeChanged;

    end;

     // Solo hay un SelectorRelationForm activo en un momento dado y es la referencia se utiliza en AppForms para saber si está la ventana abierta

var  CurrentSelectorRelationForm : TSelectorRelationForm = nil;

implementation

uses  Math,
      Vcl.Buttons,
      LibUtils;

{$R *.dfm}

resourceString
    HintMsg1 = 'Cambio de modo de selección del filtro : Valor único, rango o relación.'#13'Teclas [Ctrl][+])';

    RsMsg1 = '¿Está seguro de que desea limpiar todos los registros?';
    RsMsg2 = 'Debe indicar, al menos, un registro en la relación.';
    RsMsg3 = 'Este código ya está en la lista';

const  RelationButtonWidth = 80;

{ TgxEditSelector }

procedure TgxEditSelector.SetSelectorOptions( AValue: TgxSelectorOptions );
begin
     If   AValue<>FSelectorOptions
     then begin
          FSelectorOptions.Assign( AValue );
          // Updates ...
          end;
end;


constructor TgxEditSelector.Create( AOwner : TComponent );
begin
     inherited;

     // Valores por defecto

     PanelStyle.Active := True;
     Alignment := alCenterCenter;
     Caption := '';
     Style.BorderStyle := ebsNone;
     Style.TransparentBorder := False;
     Height := 25;
     Width := 25;
     FEditMode := tesRange;

     // Componentes

     FEditModeButton := TgBitBtn.Create( Self );
     FEditModeButton.Name := 'ModeButton';
     FEditModeButton.Caption := '';
     FEditModeButton.Parent := Self;
     FEditModeButton.Left := 0;
     FEditModeButton.Align := alClient;
     FEditModeButton.Hint := HintMsg1;
     FEditModeButton.TabStop := False;
     FEditModeButton.OptionsImage.Margin := -1;
     FEditModeButton.SpeedButtonOptions.CanBeFocused := False;
     FEditModeButton.SpeedButtonOptions.Flat := True;
     FEditModeButton.SpeedButtonOptions.Transparent := True;
     FEditModeButton.NumGlyphs := 1;
     FEditModeButton.OptionsImage.Glyph.Assign( ApplicationForms.EditSelectorImage.Picture.Graphic );
     FEditModeButton.OptionsImage.Glyph.SourceWidth := 18;
     FEditModeButton.OptionsImage.Glyph.SourceHeight := 18;
     FEditModeButton.OnClick := DoOnModeButtonClick;

     FRelationButton := TgxRelationButton.Create( Self );
     FRelationButton.FEditSelector := Self;
     FRelationButton.Name := 'ListButton';
     FRelationButton.Caption := 'Relación';
     FRelationButton.Width := RelationButtonWidth;
     FRelationButton.Visible := False;
     FRelationButton.OptionsImage.Images := ApplicationForms.ControlsImageList;
     FRelationButton.OptionsImage.ImageIndex := 15;
     FRelationButton.OptionsImage.Layout := blGlyphRight;
     FRelationButton.OptionsImage.Margin := 0;
     FRelationButton.OptionsImage.Spacing := 7;
     FRelationButton.OnClick := DoOnRelationButtonClick;
     FRelationButton.ModalResult := mrNone;  // Evito que se intercepte [Intro] (ver TgBitBtn.WMGetDlgCode )
     FRelationButton.OnKeyDown := DoOnControlKeyDown;

end;

procedure TgxEditSelector.Loaded;

var  AColumn: TcxGridColumn;
     AProperties: TcxCustomEditProperties;

begin
     inherited;

     If   Owner is TCustomForm
     then FOwnerForm := TCustomForm( Owner );

     EditMode := FEditMode;   // Para que se aplique la opción por defecto

     // En la primera posición de las columnas visibles  está el código

     If   not IsDesignTime and
          Assigned( FSelectorOptions )
     then With FSelectorOptions do
            If   Assigned( GridView )
            then If   GridView.ColumnCount>1
                 then begin
                      AColumn := GridView.Columns[ 0 ];
                      If   Assigned( AColumn.Properties )
                      then begin
                           FOnValidateCodigo := AColumn.Properties.OnValidate;
                           AColumn.Properties.OnValidate := DoOnValidateCodigo;
                           end;
                      end;
end;

destructor TgxEditSelector.Destroy;
begin
     FreeAndNil( SelectorRelationForm );
     FreeAndNil( FSelectorOptions );
     inherited;
end;

procedure TgxEditSelector.DoOnControlKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
     If   ( ssCtrl in Shift ) and ( Key=VK_ADD )
     then DoCommute;
end;

procedure TgxEditSelector.DoOnModeButtonClick(Sender: TObject);
begin
     DoCommute;
end;

procedure TgxEditSelector.DoCommute;
begin
     case EditMode of
        tesSimple   : If   Assigned( FSelectorOptions.FEndEdit )
                      then EditMode := tesRange
                      else If   Assigned( FSelectorOptions.FGridView )
                           then EditMode := tesRelation;
        tesRange    : If   Assigned( FSelectorOptions.FGridView )
                      then EditMode := tesRelation
                      else EditMode := tesSimple;
        tesRelation : EditMode := tesSimple;
        end;

     If   FRelationFormVisible
     then begin
          FRelationButton.TabOrder := FSelectorOptions.FStartEdit.TabOrder;
          FRelationButton.SetFocus;
          ShowRelationForm;
          end
     else FSelectorOptions.FStartEdit.SetFocus;
end;

procedure TgxEditSelector.DoOnRelationButtonClick(Sender: TObject);
begin
     ShowRelationForm;
end;

procedure TgxEditSelector.ExtractList( StringList  : TStringList );

var  I : SmallInt;
     CodigoField : TField;

begin
     With FSelectorOptions do
       case FEditMode of
         tesSimple    : StringList.Add( FStartEdit.Text );
         tesRange     : begin
                        StringList.Add( FStartEdit.Text );
                        StringList.Add( FEndEdit.Text );
                        end;
         tesRelation  : If   Assigned( FGridDataset )
                        then With FGridDataset do
                               try
                                 DisableControls;
                                 CodigoField := FGridDataset.FieldByName( FselectorOptions.FieldName );
                                 If   Assigned( CodigoField )
                                 then begin
                                      First;
                                      While not Eof do
                                        begin
                                        StringList.Add( CodigoField.AsString );
                                        Next;
                                        end;
                                      end;
                               finally
                                 EnableControls;
                                 end;
         end;
end;

function TgxEditSelector.GetRelationText( QuotedRelation : Boolean = False;
                                          Suffix         : String = '' ) : String;

var  CodeList : TStringList;
     ElementValue,
     DescriptionText : String;
     I : SmallInt;

begin
     CodeList := TStringList.Create;
     try
       ExtractList( CodeList );
       DescriptionText := '';
       For I := 0 to CodeList.Count - 1 do
         begin
         If   DescriptionText<>''
         then DescriptionText := DescriptionText + ',';
         ElementValue := CodeList.Strings[ I ];
         If   ElementValue=''
         then ElementValue := '<>';   // Pueden existir códigos vacíos, como los de los registros genéricos (series, almacen, etc..)
         If   QuotedRelation
         then ElementValue := QuotedStr( ElementValue );
         DescriptionText := DescriptionText + ElementValue;
         end;
     finally
       CodeList.Free;
       end;
     Result := DescriptionText;
end;

function TgxEditSelector.GetSQLSelection( FieldName : String = 'Codigo' ) : String;

var  Quoted : Boolean;

begin
     Quoted := FSelectorOptions.Field.DataType in [ ftString, ftWideString ];
     case FEditMode of
       tesSimple   : Result := FieldName + '=' +
                               IfThen( Quoted, QuotedStr( FSelectorOptions.FStartEdit.Text ), FSelectorOptions.FStartEdit.Text ) + ' ';
       tesRange    : Result := FieldName + ' BETWEEN ' +
                               IfThen( Quoted, QuotedStr( FSelectorOptions.FStartEdit.Text ), FSelectorOptions.FStartEdit.Text ) + ' AND ' +
                               IfThen( Quoted, QuotedStr( FSelectorOptions.FEndEdit.Text ), FSelectorOptions.FEndEdit.Text ) + ' ';
       tesRelation : Result := FieldName + ' IN ( ' + GetRelationText( Quoted ) + ') ';
       end;
end;

procedure TgxEditSelector.GetRangeSelection( out CodigoInicial, CodigoFinal : String );
begin
     case FEditMode of
       tesSimple   : begin
                     CodigoInicial := FSelectorOptions.FStartEdit.Text;
                     CodigoFinal := CodigoInicial;
                     end;
       tesRange    : begin
                     CodigoInicial := FSelectorOptions.FStartEdit.Text;
                     CodigoFinal := FSelectorOptions.FEndEdit.Text;
                     end;
       tesRelation : begin

                     // El rango inicial se fija con el menor y mayor valor de la selección. Luego hay que utilizar ValidValue para comprobar cada registro.
                     // Debe existir el índice asociado al campo FselectorOptions.FieldName, que es el de la selección

                     FGridDataset.IndexFieldNames := FSelectorOptions.FieldName;
                     FGridDataset.First;
                     CodigoInicial := FGridDataset.FieldValues[ FSelectorOptions.FieldName ];
                     FGridDataset.Last;
                     CodigoFinal := FGridDataset.FieldValues[ FSelectorOptions.FieldName ];

                     end;
       end;
end;

function TgxEditSelector.GetReportSelectionText : String;
begin
     // De momento solo con valores de cadena
     case FEditMode of
       tesSimple   : Result := FSelectorOptions.FStartEdit.Text;
       tesRange    : Result := 'desde ' + QuotedStr( FSelectorOptions.FStartEdit.Text ) + ' hasta ' + QuotedStr( FSelectorOptions.FEndEdit.Text ) + '.';
       tesRelation : Result := GetRelationText;
       end;
end;

function TgxEditSelector.ValidValue( Value : String ) : Boolean;
begin
     case FEditMode of
       tesSimple   : Result := FSelectorOptions.FStartEdit.Text=Value;
       tesRange    : Result := ( Value>=FSelectorOptions.FStartEdit.Text ) and ( Value<=FSelectorOptions.FEndEdit.Text );
       tesRelation : Result := FGridDataset.Locate( FSelectorOptions.FieldName, Value, [] );
       end;
end;


procedure TgxEditSelector.Initialize;
begin
     inherited;
     FSelectorOptions := TgxSelectorOptions.Create( Self );
end;

procedure TgxEditSelector.Notification( AComponent : TComponent;
                                        Operation  : TOperation );
begin
     inherited Notification( AComponent, Operation );
     If   Assigned( FSelectorOptions )
     then With FSelectorOptions do
            If   Operation=opRemove
            then  If   AComponent=FStartEdit
                  then StartEdit := nil
                  else If   AComponent=FEndEdit
                       then EndEdit := nil
                            else If   AComponent=GridView
                                 then GridView := nil
                                 else If   AComponent=FRangeBox
                                      then RangeBox := nil;
end;

procedure TgxEditSelector.SetEditMode( const Value : TEditMode );
begin
     FEditMode := Value;
     With FSelectorOptions do
       If   Assigned( FStartEdit )
       then begin

            FStartEdit.Enabled := FEditMode in [ tesSimple, tesRange ];
            If   Assigned( FEndEdit )
            then begin
                 FEndEdit.Visible := FEditMode=tesRange;
                 FEndEdit.Enabled := FEndEdit.Visible;
                 FEndEdit.ClearDescription;
                 end;

            If   Assigned( FRangeBox )
            then FRangeBox.Visible := FEditMode=tesRange;

            FRelationFormVisible := ( FEditMode=tesRelation ) and Assigned( FGridView ) and Assigned( FGridView.DataController.DataSource );

            If   FRelationFormVisible
            then begin
                 FRelationButton.Parent := FStartEdit.Parent;
                 With FStartEdit do
                   FRelationButton.SetBounds( Left, Top, Max( Width, ScaledToCurrent( RelationButtonWidth ) ), Height );
                 FRelationButton.BringToFront;
                 If   Assigned( FStartEdit.DescriptionLabel )
                 then FStartEdit.DescriptionLabel.Enabled := True;  // La utilizo para mostrar la relación separada por comas
                 end;

            FRelationButton.Visible := FRelationFormVisible;

            If   Assigned( FOnEditModeChanged )
            then FOnEditModeChanged;

            UpdateDescription;
            end;
end;

procedure TgxEditSelector.SetFocus;
begin
     If   FEditMode=tesRelation
     then FRelationButton.SetFocus
     else inherited;
end;

procedure TgxEditSelector.ShowRelationForm;

var  Position : TPoint;
     FormExists : Boolean;
     TabHeight : SmallInt;
     
begin

     FormExists := Assigned( FSelectorRelationForm );
     If   not FormExists
     then With FSelectorOptions do
            begin

            CreateForm( fmSelector, TSelectorRelationForm, FSelectorRelationForm, True, True );

            SelectorRelationForm.EditSelector := Self;
            SelectorRelationForm.Width := FGridWidth + 6;
            SelectorRelationForm.Height := 250;

            SelectorRelationForm.GridLevel.GridView := FGridView;
            SelectorRelationForm.GridTableViewController.TableView := FGridView;
            SelectorRelationForm.GridTableViewController.SetupTableViewLink;  // No se ha inicializado en Loaded porque no estaba asignado el TableView

            If   Assigned( FGridView.DataController.DataSource.Dataset )
            then If   FGridView.DataController.DataSource.Dataset is TnxeTable
                 then begin
                      FGridDataset := TnxeTable( FGridView.DataController.DataSource.Dataset );
                      FGridDataset.Active := True;
                      end
                 else raise Exception.Create( 'El dataset debe ser un TnxeTable' );

            end;

     Position.X := FRelationButton.Left - 2;
     Position.Y := FRelationButton.Top + FRelationButton.Height - 1;

     Position := FRelationButton.Parent.ClientToScreen( Position );
     Position := Application.MainForm.ScreenToClient( Position );

     If   ApplicationContainer.TDI
     then begin
          Inc( Position.X, ScaledToCurrent( 2 ) );
          If   ApplicationContainer.SkinController.UseSkins
          then TabHeight := 36  //  ( 28 + 8 )
          else TabHeight := 34;
          Inc( Position.Y, -ScaledToCurrent( TabHeight ) ); { -( ApplicationContainer.TabbedMDIManager.TabProperties.TabHeight + ScaledToCurrent( 8 ) ) ); }
          end;
          
     SelectorRelationForm.Left := Position.X;
     SelectorRelationForm.Top := Position.Y - GetDesktopTop;

     With SelectorRelationForm do
       begin
       FormManager.FormResult := mrNone;
       CloseWindowWhenFocusLost := True;
       end;

     CurrentSelectorRelationForm := SelectorRelationForm;

     SelectorRelationForm.Visible := True;
     SelectorRelationForm.BringToFront;

     If   FormExists
     then begin

          // Pongo el focus primero en el botón para provocar que se cree una línea de edición cuando la lista está vacía y
          // no es la primera vez que se abre (el usuario la ha abierto antes pero no ha introducido líneas)

          SelectorRelationForm.Enabled := True;
          SelectorRelationForm.AcceptButton.SetFocus;
          SelectorRelationForm.Grid.SetFocus;
          end;

end;

procedure TgxEditSelector.Validate( var AErrorText : TCaption;
                                    var AError     : Boolean );
begin
     If   FEditMode=tesRelation
     then If    Assigned( FGridDataset )
          then If   FGridDataset.RecordCount=0
               then begin
                    AError := True;
                    AErrorText := RsMsg2;
                    end;
end;

procedure TgxEditSelector.UpdateDescription;
begin
     If   Assigned( SelectorOptions.StartEdit.DescriptionLabel )
     then If   EditMode=tesRelation
          then SelectorOptions.StartEdit.DescriptionLabel.EditValue := GetRelationText( False, '.' )
          else SelectorOptions.StartEdit.ValidateEdit( False );
end;


{ TSelectorRelationForm }

procedure TSelectorRelationForm.CleanButtonClick(Sender: TObject);
begin
     If   ShowNotification( ntQuestionWarning, RsMsg1 )=mrYes
     then With FEditSelector.FGridDataset do
            begin
            DisableControls;
            try
              First;
              While not Eof do
                Delete;
            finally
              EnableControls;
              end;
            end;
end;

procedure TSelectorRelationForm.CreateParams( var Params : TCreateParams );
begin
     inherited CreateParams( Params );
     Params.Style := Params.Style and not WS_CAPTION;
end;

procedure TSelectorRelationForm.FormManagerCloseForm( Sender: TObject; var Action: TCloseAction);
begin
     FEditSelector.UpdateDescription;
     Visible := False; // Es importante que también se oculte aquí, además de en FormManagerDeactivateForm porque ambos procesos son excluyentes
     If   Assigned( FEditSelector.FOwnerForm )
     then SendMessage( Application.MainForm.ClientHandle, WM_MDIActivate, FEditSelector.FOwnerForm.Handle, 0 );
     CurrentSelectorRelationForm := nil;
end;

procedure TSelectorRelationForm.FormManagerDeactivateForm( ChildProcess : Boolean );
begin
     {
     If   not ChildProcess
     then Visible := False;
     }
end;

procedure TSelectorRelationForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     If   ( ssCtrl in Shift ) and ( Key=VK_ADD )
     then FEditSelector.DoCommute;
end;

{ TgxSelectorOptions }

procedure TgxSelectorOptions.Assign(ASource: TPersistent);
begin
     If   ASource is TgxSelectorOptions
     then begin
          StartEdit := TgxSelectorOptions( ASource ).StartEdit;
          EndEdit := TgxSelectorOptions( ASource ).EndEdit;
          GridView := TgxSelectorOptions( ASource ).GridView;
          FieldName := TgxSelectorOptions( ASource ).FieldName;
          end
     else inherited Assign( ASource );

end;

constructor TgxSelectorOptions.Create(AOwner: TgxEditSelector);
begin
     inherited Create;
     FEditSelector := AOwner;
     FFieldName := 'Codigo';
end;

procedure TgxSelectorOptions.FreeNotification(Sender: TComponent);
begin
     If   Sender=FStartEdit
     then FStartEdit := nil
     else If   Sender=FEndEdit
          then FEndEdit := nil
          else If   Sender=FGridView
               then FGridView := nil;
end;

procedure TgxSelectorOptions.SetEndEdit( const Value: TcxTextEdit );
begin
     FEndEdit := Value;
     If   Assigned( FEndEdit )
     then FEndEdit.OnKeyDown := FEditSelector.DoOnControlKeyDown;
end;

procedure TgxSelectorOptions.SetGridView(const Value: TcxGridDBTableView);

var  I : SmallInt;

begin
     FGridView := Value;
     If   not IsDesignTime and
          Assigned( FGridView )
     then With FGridView do
            begin
            OptionsBehavior.FocusCellOnTab := True;
            OptionsBehavior.FocusCellOnCycle := True;
            OptionsBehavior.FocusFirstCellOnNewRecord := True;

            FGridWidth := 30;  // La anchura del GridTableViewController mas los bordes
            For I := 0 to ColumnCount - 1 do
              begin
              Inc( FGridWidth, Columns[ I ].Width );
              If   Columns[ I ].DataBinding.FieldName=FieldName
              then begin
                   // Marco la columna del FieldName como required para que no se inserten líneas sin código
                   Columns[ I ].Properties.Required := True;
                   end;
              end;

            OptionsView.ColumnAutoWidth := True;
            end;
end;

function TgxSelectorOptions.GetField : TField;
begin
     If   not Assigned( FField ) and
          Assigned( FGridView )
     then begin
          var GridDBColumn := FGridView.GetColumnByFieldName(FFieldName );
          If   Assigned( GridDBColumn )
          then FField := GridDBColumn.DataBinding.Field;
          end;
     Result := FField;
end;

procedure TgxSelectorOptions.DoOnValidateCodigo(     Sender       : TcxCustomEdit;
                                                 var DisplayValue : Variant;
                                                 var ErrorText    : TCaption;
                                                 var Error        : Boolean );

var  Codigo : String;
     RecordIndex : Integer;

begin
     Codigo := VarToStr( DisplayValue );  // Evitando los nulls
     RecordIndex := GridView.DataController.FindRecordIndexByText( 0, 0, Codigo, False, False, True );
     If   ( RecordIndex>=0 ) and
          ( RecordIndex<>GridView.Controller.SelectedRows[ 0 ].RecordIndex )
     then begin
          ErrorText := RsMsg3;
          Error := True;
          end
     else If   Assigned( FOnValidateCodigo )
          then FOnValidateCodigo( Sender, DisplayValue, ErrorText, Error );
end;

procedure TgxSelectorOptions.SetStartEdit( const Value: TcxTextEdit );
begin
     FStartEdit := Value;
     If   Assigned( FStartEdit )
     then FStartEdit.OnKeyDown := FEditSelector.DoOnControlKeyDown;
end;

initialization

  RegisterClasses( [ TgxEditSelector ] );

end.


