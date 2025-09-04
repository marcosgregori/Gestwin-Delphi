
unit b_pst119;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, dxmdaset,

  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox, cxRadioGroup, cxCheckBox, cxIndexedComboBox, cxIntegerEdit,
  cxCustomListBox, cxCheckListBox;


type
    TBoxPst119Form = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    CheckListBox: TcxCheckListBox;
    cxLabel2: TcxLabel;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    private

    protected
    class var

    public
      procedure DoProcess;
    end;

var  BoxPst119Form : TBoxPst119Form = nil;

procedure PublicacionStocksAUNA;


implementation

uses   DateUtils,
       LibUtils,
       AppManager,
       EnterpriseDataAccess,

       dm_sst119,
       dm_alm,

       b_msg,
       b_pro,

       f_prg;

{$R *.DFM}

procedure PublicacionStocksAUNA;
begin
     CreateEditForm( TBoxPst119Form, BoxPst119Form );
end;

procedure TBoxPst119Form.FormManagerInitializeForm;

var  CheckListBoxItem  : TcxCheckListBoxItem;

begin
     For var I := 1 to 3 do
       If   SuministroStocks.IdAlmacen[ I ]<>''
       then begin
            CheckListBoxItem := CheckListBox.Items.Add;
            CheckListBoxItem.Text := Almacen.Descripcion( SuministroStocks.CodigoAlmacen[ I ] );
            end;
end;

procedure TBoxPst119Form.FormManagerOkButton;
begin
     CreateProcessForm( DoProcess, Caption );
end;

procedure TBoxPst119Form.DoProcess;

var  ListaAlmacenes : TListaAlmacenesArray;

begin
     For var I := 1 to 3 do
       If   I<=CheckListBox.Items.Count
       then ListaAlmacenes[ I ] := CheckListBox.Items[ I - 1 ].Checked
       else ListaAlmacenes[ I ] := False;
     SuministroStocks.PublicaStock( ListaAlmacenes );
end;

end.

