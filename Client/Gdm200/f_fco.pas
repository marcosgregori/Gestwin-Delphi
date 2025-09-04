unit f_fco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls,

  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,

  Gdm10Dm, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxMaskEdit,
  cxDropDownEdit, cxIndexedComboBox, cxLookAndFeels, cxLookAndFeelPainters,
  cxGroupBox;

type
  TFcoFrame = class(TFrame)
    Label1: TLabel;
    CodigoFacturaECtrl: TcxDBIndexedComboBox;
    AmpliacionPanel: TcxGroupBox;
  private
  public

  end;

implementation

uses AppManager,
     AppForms,

     Gim10Fields,

     Gdm200Dm,

     a_fco,

     dm_fco;
     
{$R *.dfm}

procedure SetupFrame;

var FcoFrame : TFcoFrame;
    I : SmallInt;

begin
     If   Assigned( MntFcoForm )
     then begin

          FcoFrame := TFcoFrame.Create( MntFcoForm );

          With FcoFrame do
            begin

            AmpliacionPanel.Parent := MntFcoForm.DataPanel;
            AmpliacionPanel.Align := alClient;

            With CodigoFacturaECtrl do
              begin
              For I := 1 to NroFormasPagoFacturaE do
                Properties.Items.Add( TextoFormasPagoFacturaE[ I ] );
              DataBinding.DataSource := MntFcoForm.FormaCobroDataSource;
              end;

          end;

          MntFcoForm.Height := MntFcoForm.Height + FcoFrame.Height;

          PlaceForm( MntFcoForm );
          end;
end;

initialization
  AddProcedure( imOnCreateComponent, idMntFcoForm, SetupFrame );

end.
