unit b_cdc1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppForms, ExtCtrls, Menus, cxLookAndFeelPainters, StdCtrls,
  cxButtons, AppContainer, cxControls, cxSplitter, frxDock, cxGraphics,
  cxLookAndFeels,

  InpFrames,
  Generics.Collections, cxContainer, cxEdit, dxSkinsCore, cxGroupBox,
  dxSkinsDefaultPainters;

type
  TBoxCdc1Form = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    RightPanel: TcxGroupBox;
    ButtonsPanel: TgxEditPanel;
    Panel1: TcxGroupBox;
    ActualizarButton: TgBitBtn;
    CloseButton: TgBitBtn;
    ConfigurarButton: TgBitBtn;
    GridPanel: TGridPanel;
    FramePanel1: TcxGroupBox;
    FramePanel2: TcxGroupBox;
    FramePanel3: TcxGroupBox;
    FramePanel4: TcxGroupBox;
    procedure FormManagerInitializeForm;
    procedure ActualizarButtonClick(Sender: TObject);
    procedure FormManagerShowForm;
    procedure FormManagerDestroyForm;
  private
    FrameManagerList : TList<TgFrameManager>;
    FrameExpanded : Boolean;
  protected
    procedure FrameDblClick(Sender: TObject);
  public
    procedure UpdateFrames;
  end;

var
  BoxCdc1Form: TBoxCdc1Form = nil;

procedure CentroControl;

implementation

uses   fg_100,
       fg_101,

       fi_100;

{$R *.dfm}

procedure CentroControl;
begin
     CreateEditForm( TBoxCdc1Form, BoxCdc1Form, [] );
end;

procedure TBoxCdc1Form.FormManagerDestroyForm;
begin
     FrameManagerList.Free;
end;

procedure TBoxCdc1Form.FormManagerInitializeForm;

procedure RegistraGadget( FrameClass : TFrameClass;
                          AParent    : TWinControl );

var  GadgetFrame : TFrame;
     FrameManager : TgFrameManager;

begin
     GadgetFrame := nil;
     CreateFrame( FrameClass, GadgetFrame );
     GadgetFrame.Parent := AParent;
     FrameManager := TgFrameManager( GadgetFrame.FindComponent( FrameManagerName ) );
     If   Assigned( FrameManager )
     then begin
          FrameManagerList.Add( FrameManager );
          FrameManager.Frame.OnDblClick := FrameDblClick;
          FrameManager.DoOnInitialize;
          end;
end;

begin
     FrameManagerList := TList<TgFrameManager>.Create;

     RegistraGadget( TGadgetG100Frame, FramePanel1 );
     RegistraGadget( TGadgetG101Frame, FramePanel3 );

     RegistraGadget( TGadgetI100Frame, FramePanel2 );
end;

procedure TBoxCdc1Form.FrameDblClick(Sender: TObject);

var  OwnerFrame : TFrame;
     ParentPanel : TcxGroupBox;
     Index : SmallInt;

begin
     If   TComponent( Sender ).Owner is TFrame
     then begin
          OwnerFrame := TComponent( Sender ).Owner as TFrame;
          ParentPanel := OwnerFrame.Parent as TcxGroupBox;
          With GridPanel do
            begin
            ColumnCollection.BeginUpdate;
            RowCollection.BeginUpdate;
            If   FrameExpanded
            then begin
                 ColumnCollection[ 0 ].Value := 50;
                 ColumnCollection[ 1 ].Value := 50;
                 RowCollection[ 0 ].Value := 50;
                 RowCollection[ 1 ].Value := 50;
                 end
            else case ParentPanel.Tag of
                   0 : begin
                       ColumnCollection[ 1 ].Value := 0;
                       RowCollection[ 1 ].Value := 0;
                       end;
                   1 : begin
                       ColumnCollection[ 0 ].Value := 0;
                       RowCollection[ 0 ].Value := 0;
                       end;
                   2 : begin
                       ColumnCollection[ 1 ].Value := 0;
                       RowCollection[ 0 ].Value := 0;
                       end;
                   3 : begin
                       ColumnCollection[ 0 ].Value := 0;
                       RowCollection[ 0 ].Value := 0;
                       end;
                   end;
            ColumnCollection.EndUpdate;
            RowCollection.EndUpdate;
            end;
            FrameExpanded := not FrameExpanded;
          end;
end;

procedure TBoxCdc1Form.FormManagerShowForm;
begin
     Maximize;
end;

procedure TBoxCdc1Form.ActualizarButtonClick(Sender: TObject);
begin
     UpdateFrames;
end;

procedure TBoxCdc1Form.UpdateFrames;

var  Index : SmallInt;

begin
     With FrameManagerList do
       For Index := 0 to Count - 1 do
          Items[ Index ].DoOnUpdate;
end;

end.
