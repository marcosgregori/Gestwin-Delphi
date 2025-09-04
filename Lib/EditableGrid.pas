unit EditableGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, nxdb, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGrid, Menus, Buttons, ExtCtrls, AppForms, cxGridDBTableView,
  cxCurrencyEdit, cxLookAndFeelPainters, StdCtrls, cxButtons, AppContainer,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxContainer,
  cxGroupBox, DataManager, cxLookAndFeels, dxPScxGridLnk,
  dxSkinsdxBarPainter, cxBarEditItem, dxBar, cxNavigator,

  GridTableViewController,

  dxDateRanges,

  LibUtils, cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations;


type
  TEditableGridFrame = class(TFrame)
    Query: TnxeQuery;
    DataSource: TDataSource;
    BarManager: TdxBarManager;
    ButtonsBar: TdxBar;
    CancelButton: TdxBarLargeButton;
    PageSettingsButton: TdxBarLargeButton;
    PreviewButton: TdxBarLargeButton;
    PrintButton: TdxBarLargeButton;
    FormatPageButton: TdxBarLargeButton;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    GridTableViewController: TGridTableViewController;
    CollapseBar: TdxBar;
    procedure SpeedButton3Click(Sender: TObject);
    procedure PersonalizarItemClick(Sender: TObject);
    procedure TableViewDataControllerFilterChanged(Sender: TObject);
    procedure PreviewButtonClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure PageSettingsButtonClick(Sender: TObject);
    procedure FormatPageButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure dxBarLargeButton1Click(Sender: TObject);
    procedure dxBarLargeButton2Click(Sender: TObject);
    procedure FrameResize(Sender: TObject);
  private
    FOwnerForm : TgxForm;
    FCurrentGroupIndex : SmallInt;
    FPreviewBtnClicked,
    FPrintBtnClicked : Boolean;
    FGridReportLink : TdxGridReportLink;
    SQLText : String;

    function RecordButtonEvent( AnAppSpeedBtn : TSpeedBtnTag ) : Boolean;

  public
   procedure CreateItems;

   procedure Setup; overload;
   procedure Setup( ASQLText : String ); overload;

   function SetupTextColumn( FieldName : String; ACaption : String; AWidth : SmallInt; IsVisible : Boolean = True; IsEditable : Boolean = True ) : TcxGridDBColumn;
   function SetupDecimalColumn( FieldName : String; ACaption : String; AWidth : SmallInt; AMaxLength : SmallInt; ADecimals  : SmallInt = DecimalesMoneda; IsVisible : Boolean = True; IsEditable : Boolean = True ) : TcxGridDBColumn;

   function SetupColumn( FieldName : String; ACaption : String; AWidth : SmallInt; IsVisible : Boolean = True; IsEditable : Boolean = True ) : TcxGridDBColumn;

   function AddDefaultGroupSummaryItem( AColumn : TcxGridDBColumn; AFieldName : String = '' ) : TcxGridDBTableSummaryItem;
   procedure AddDefaultGroupSummaryItems( Columns : array of TcxGridDBColumn );
   procedure AddGroupIndex( AColumn : TcxGridDBColumn );
   procedure AddGroupsIndex( Columns : array of TcxGridDBColumn );
  end;

implementation

uses  cxGridCommon,
      cxGridDBDataDefinitions,
      dxPSCore,

      cxTextEdit,

      PrintSystem,
      PrintPreviewWindow,
      AppManager,

      b_msg;

{$R *.dfm}

resourceString
      RsMsg1  = 'Si cierra la ventana se cerrará también la vista previa.';
      RsMsg2  = '¿Confirma que desea cerrar la ventana de todas formas?' ;
      RsMsg3  = 'Debe situarse sobre un TgxForm.';


procedure TEditableGridFrame.Setup;
begin

     If   not ( Owner is TgxForm )
     then raise Exception.Create( RsMsg3 );

     FOwnerForm := TgxForm( Owner );

     FGridReportLink := TdxGridReportLink.Create( Self );
     FGridReportLink.Component := Grid;
     FGridReportLink.ComponentPrinter := PrintSystemDataModule.ComponentPrinter;

     dxPSPreviewDialogManager.CurrentPreviewDialogStyle := PreviewDialogStyleInfoName;

     GridTableViewController.RecordButtonLink.OnRecordButtonEvent := RecordButtonEvent;

end;


procedure TEditableGridFrame.Setup( ASQLText : String );
begin
     Setup;
     SQLText := ASQLText;
     With Query do
       begin
       SQL.Text := SQLText;
       Open;
       Last;
       CreateItems;
       end;
end;

function TEditableGridFrame.AddDefaultGroupSummaryItem( AColumn    : TcxGridDBColumn;
                                                        AFieldName : String = '' ) : TcxGridDBTableSummaryItem;
begin
     Result := TcxGridDBTableSummaryItem( GridView.DataController.Summary.DefaultGroupSummaryItems.Add );
     With Result do
        begin
        BeginUpdate;
        try
          Column := AColumn;
          FieldName := AFieldName;
          Kind := skSum;
          Position := spFooter;
        finally
          EndUpdate;
          end;
        end;
end;

procedure TEditableGridFrame.AddGroupIndex( AColumn : TcxGridDBColumn );
begin
     With AColumn do
       begin
       GroupIndex := FCurrentGroupIndex;
       Visible := False;
       end;
     Inc( FCurrentGroupIndex );
end;

procedure TEditableGridFrame.AddGroupsIndex( Columns : array of TcxGridDBColumn );

var  I : SmallInt;

begin
     For I := 0 to High( Columns ) do
       AddGroupIndex( Columns[ I ] );
end;

procedure TEditableGridFrame.TableViewDataControllerFilterChanged(Sender: TObject);

var  FilterEnabled : Boolean;

begin
     With GridView.DataController do
       begin
       FilterEnabled := not( Filter.IsEmpty or not Filter.Active );
       Groups.FullExpand;
       end;
     ApplicationContainer.EnableRecordButtons( True, True, FilterEnabled );
end;

function TEditableGridFrame.SetupTextColumn( FieldName      : String;
                                             ACaption       : String;
                                             AWidth         : SmallInt;
                                             IsVisible      : Boolean = True;
                                             IsEditable     : Boolean = True ) : TcxGridDBColumn;
begin
     Result := SetupColumn( FieldName, ACaption, AWidth, IsVisible, IsEditable );
     If   Assigned( Result )
     then With Result do
            begin
            PropertiesClass := TcxTextEditProperties;
            Properties.ValidateOnEnter := False;
            end;
end;

 function TEditableGridFrame.SetupDecimalColumn( FieldName      : String;
                                                 ACaption       : String;
                                                 AWidth         : SmallInt;
                                                 AMaxLength     : SmallInt;
                                                 ADecimals      : SmallInt = DecimalesMoneda;
                                                 IsVisible      : Boolean = True;
                                                 IsEditable     : Boolean = True ) : TcxGridDBColumn;

var  Field : TField;

begin
     Result := SetupColumn( FieldName, ACaption, AWidth, IsVisible, IsEditable );
     If   Assigned( Result )
     then With Result do
            begin
            SetColumnDecimals( Result, ADecimals );
            TcxCustomTextEditProperties( Properties ).MaxLength := AMaxLength;
            Visible := IsVisible;
            Options.Editing := IsEditable;
            PropertiesClass := TcxCurrencyEditProperties;
            Properties.ValidateOnEnter := False;
            end;
end;

function TEditableGridFrame.SetupColumn( FieldName   : String;
                                         ACaption    : String;
                                         AWidth      : SmallInt;
                                         IsVisible   : Boolean = True;
                                         IsEditable  : Boolean = True ) : TcxGridDBColumn;

var  Field : TField;

begin
     Result := GridView.GetColumnByFieldName( FieldName );
     If   Assigned( Result )
     then With Result do
            begin
            Caption := ACaption;
            Width := AWidth;
            Visible := IsVisible;
            Options.Editing := IsEditable;
            If   not IsEditable
            then Styles.Content := ApplicationContainer.EditFixedColumnStyle;
            end;
end;

procedure TEditableGridFrame.PageSettingsButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.ComponentPrinter.PageSetupEx( 0, False, True, FPreviewBtnClicked, FPrintBtnClicked, FGridReportLink );
end;

procedure TEditableGridFrame.PersonalizarItemClick(Sender: TObject);
begin
     // GridView.ColumnsCustomizing;
end;

procedure TEditableGridFrame.PreviewButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.ComponentPrinter.Preview( False, FGridReportLink );
end;

procedure TEditableGridFrame.PrintButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.Print( FGridReportLink );
end;

procedure TEditableGridFrame.SpeedButton3Click(Sender: TObject);
begin
     Release;
end;

function TEditableGridFrame.RecordButtonEvent( AnAppSpeedBtn : TSpeedBtnTag ) : Boolean;
begin
     Result := False;
     case AnAppSpeedBtn of
       sbnRefreshRec :
         begin
         DataSource.Enabled := False;
         Application.ProcessMessages;
         // Si se produce cualquier exception no se reactiva el DataSourse. Que el usuario vuelva a refrescar el dataset
         DataSource.Enabled := True;
         GridView.DataController.Groups.FullExpand;
         Grid.SetFocus;
         Result := True;
         end;
       end;
end;

procedure TEditableGridFrame.AddDefaultGroupSummaryItems( Columns : array of TcxGridDBColumn);

var  I : SmallInt;

begin
     For I := 0 to High( Columns ) do
       AddDefaultGroupSummaryItem( Columns[ I ] );
end;

procedure TEditableGridFrame.CancelButtonClick(Sender: TObject);
begin
     FOwnerForm.Close;
end;

procedure TEditableGridFrame.CreateItems;

var  I: Integer;
     AItem : TcxCustomGridTableItem;

begin
    With GridView.DataController do
      begin
      GridView.BeginUpdate;
      BeginUpdateFields;
      try
        With DataSet do
          For I := 0 to FieldCount - 1 do
            begin
            AItem := GridView.CreateItem;
            With AItem do
              begin
              With DataBinding as TcxGridItemDBDataBinding do
                FieldName := Fields[ I ].FieldName;
              Name := CreateUniqueName( GridView.Owner, GridView, AItem, ScxGridPrefixName, Fields[ I ].FieldName );
              Visible := False; // Fields[I].Visible;
              end;
            end;
      finally
        EndUpdateFields;
        GridView.EndUpdate;
        end;
      end;
end;

procedure TEditableGridFrame.dxBarLargeButton1Click(Sender: TObject);
begin
     GridView.DataController.Groups.FullExpand;
end;

procedure TEditableGridFrame.dxBarLargeButton2Click(Sender: TObject);
begin
     GridView.DataController.Groups.FullCollapse;
end;

procedure TEditableGridFrame.FormatPageButtonClick(Sender: TObject);
begin
     PrintSystemDataModule.ComponentPrinter.DesignReport( FGridReportLink );
end;

procedure TEditableGridFrame.FrameResize(Sender: TObject);
begin
     CollapseBar.DockedLeft := Width;
end;

{
 With GridView.DataController.Summary do
              begin
              BeginUpdate;
              try

                SummaryGroups.Clear;

                SummaryGroup := SummaryGroups.Add;
                With SummaryGroup do
                  begin

                  SummaryGroupItemLink := TcxGridTableSummaryGroupItemLink( Links.Add );
                  SummaryGroupItemLink.Column := TableViewNroAsiento;

                  SummaryItem := TcxGridDBTableSummaryItem( SummaryItems.Add );
                  With SummaryItem do
                    begin
                    Column := TableViewDebe;
                    Kind := skSum;
                    Format := FloatDisplayFormat( DecimalesMoneda );
                    end;

                  SummaryItem := TcxGridDBTableSummaryItem( SummaryItems.Add );
                  With SummaryItem do
                    begin
                    Column := TableViewHaber;
                    Kind := skSum;
                    Format := FloatDisplayFormat( DecimalesMoneda );
                    end;

                  end;

              finally
                EndUpdate;
                end;

              end;
 }

end.
