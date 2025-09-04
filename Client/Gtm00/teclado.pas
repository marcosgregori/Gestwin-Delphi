
unit teclado;

interface

uses Forms, StdCtrls, Controls, Buttons, Classes, Mask,
     ExtCtrls, ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxDBEdit, nxdb, DataManager, DB,
     cxMaskEdit, cxDropDownEdit, cxCalendar, cxCheckBox,
     dxSkinsCore, dxSkinsDefaultPainters, cxLabel, cxGraphics,
     cxLookAndFeels, cxGroupBox, dxmdaset,
     cxButtonEdit, cxLookupEdit, cxDBLookupEdit, cxDisplayButtonEdit,

     AppContainer,
     AppForms,
     LibUtils;

type
  TTecladoForm = class( TgxForm )
    ButtonsPanel: TgxEditPanel;
    OchoButton: TcxButton;
    gBitBtn1: TcxButton;
    NueveButton: TcxButton;
    gEditPanel1: TgxEditPanel;
    gBitBtn2: TcxButton;
    gBitBtn3: TcxButton;
    gBitBtn4: TcxButton;
    gEditPanel2: TgxEditPanel;
    gBitBtn5: TcxButton;
    gBitBtn6: TcxButton;
    gBitBtn7: TcxButton;
    gEditPanel3: TgxEditPanel;
    gBitBtn8: TcxButton;
    gBitBtn9: TcxButton;
    gBitBtn10: TcxButton;
    gEditPanel4: TgxEditPanel;

  private

  protected

  public

  end;

var
  TecladoForm : TTecladoForm = nil;

implementation

{$R *.dfm}

uses   Windows,
       SysUtils,

       AppManager;

procedure SetupTeclado;
begin
     TecladoForm := TTecladoForm.Create( Application.MainForm );
     If   Assigned( TecladoForm )
     then With TecladoForm do
            begin
            Parent := ApplicationContainer.DataPanel;

            For var Component in TecladoForm do
              If   Component is TcxButton
              then TcxButton( Component ).Width := ( ApplicationContainer.DataPanel.Width - 45 ) div 3;

            Visible := True;
            end;
end;

initialization
   // AddProcedure( imStartUp, 0, SetupTeclado );

end.
