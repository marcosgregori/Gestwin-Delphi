unit f_cdt116;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls,

  Db,

  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,

  Gim10Fields, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxGroupBox, cxLabel, cxCurrencyEdit, nxdb,
  DataManager,

  Gim116Fields;

type
  TCdtFrame = class(TFrame)
    AmpliacionPanel: TcxGroupBox;
    Label11: TcxLabel;
    CantoPulidoCtrl: TcxDBCurrencyEdit;
    cxLabel2: TcxLabel;
    TaladroCtrl: TcxDBCurrencyEdit;
    cxLabel3: TcxLabel;
    EmbalajeCtrl: TcxDBCurrencyEdit;
    EscotsCtrl: TcxDBCurrencyEdit;
    cxLabel4: TcxLabel;
    PuntasCtrl: TcxDBCurrencyEdit;
    cxLabel5: TcxLabel;
    VariosCtrl: TcxDBCurrencyEdit;
    cxLabel1: TcxLabel;
  private

  public

  end;

implementation

uses AppForms,
     AppManager,

     Gim30Fields,

     Gdm00Dm,

     a_cdt;

{$R *.dfm}

procedure SetupFrame;

var CdtFrame : TCdtFrame;

begin
     If   Assigned( MntCdtForm )
     then begin

          CdtFrame := TCdtFrame.Create( MntCdtForm );

          With CdtFrame do
            begin

            AmpliacionPanel.Parent := MntCdtForm.DataPanel;
            AmpliacionPanel.Top := MntCdtForm.DescripcionPanel.Height;
            AmpliacionPanel.Align := alClient;

            SetEditControlsDecimals( [ CantoPulidoCtrl, TaladroCtrl, PuntasCtrl, VariosCtrl, EscotsCtrl, EmbalajeCtrl ], DataModule00.DmEmpresaFields.Ventas_DecPrecio.Value );

            MntCdtForm.Height := MntCdtForm.Height + CdtFrame.Height;

            PlaceForm( MntCdtForm );
            end;

          end;
end;

initialization
  AddProcedure( imOnCreateComponent, idMntCdtForm, SetupFrame );

end.
