unit b_avs;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Mask,
  Tabs, Menus, cxLookAndFeelPainters, cxButtons, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMemo, DataManager, DB, cxDBEdit, cxRichEdit,
  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxGroupBox, dxGDIPlusClasses, cxImage,

  AppForms,
  AppContainer, cxGeometry, dxFramedControl, dxPanel, dxUIAClasses,
  cxDBRichEdit, dxmdaset;

type
  TAvisoForm = class(TgxForm)
    ButtonPanel: TdxPanel;
    FormManager: TgxFormManager;
    DataScreen: TdxPanel;
    CloseButton: TgBitBtn;
    Panel1: TdxPanel;
    Image: TcxImage;
    Panel2: TdxPanel;
    DataSource: TDataSource;
    MemData: TgxMemData;
    DataMemo: TWideMemoField;
    AnnotationRichEdit: TcxDBRichEdit;
    procedure FormManagerInitializeForm;
    procedure FormManagerDestroyForm;
    procedure FormManagerCreateForm;
  private

    DataField : TWideMemoField;

  public
    constructor Create( ADataField : TWideMemoField ); reintroduce;

  end;

var AvisoForm : TAvisoForm = nil;

procedure ShowWarning( ADataField : TWideMemoField );

implementation

{$R *.dfm}

uses   b_msg;

procedure ShowWarning( ADataField : TWideMemoField );
begin
     AvisoForm := TAvisoForm.Create( ADataField );
     With AvisoForm do
       try
         ShowModal;
       finally
         Free;
         end;
end;

constructor TAvisoForm.Create( ADataField : TWideMemoField );
begin
     DataField := ADataField;
     inherited Create( Application.MainForm );
end;

procedure TAvisoForm.FormManagerCreateForm;
begin
     ApplicationContainer.WarningActive := True;
end;

procedure TAvisoForm.FormManagerDestroyForm;
begin
     ApplicationContainer.WarningActive := False;
end;

procedure TAvisoForm.FormManagerInitializeForm;
begin
     If   Assigned( DataField )
     then begin
          MemData.Append;
          DataMemo.Value := DataField.Value;
          end;
end;

end.

