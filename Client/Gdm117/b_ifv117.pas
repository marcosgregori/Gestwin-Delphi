
unit b_ifv117;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask,

  AppContainer,
  ComCtrls,
  Menus,
  cxLookAndFeelPainters,
  cxButtons,
  DB, nxdb, DataManager, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxDBEdit,

  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox, dxmdaset, dxUIAClasses;

type
  TBoxIfv117Form = class(TgxForm)
    DataPanel: TgxEditPanel;
    PathCtrl: TcxDBTextEdit;
    examinarButton: TgBitBtn;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataPath: TWideStringField;
    FormManager: TgxFormManager;
    Label3: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox5: TcxGroupBox;
    cxLabel5: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure ExaminarButtonClick(Sender: TObject);
    function FormManagerGetAccessLevel: Smallint;

  protected

    class procedure ImportacionFacturas( Sender : TObject );

  private

  public
    procedure ExecuteProcess;
  end;

var BoxIfv117Form: TBoxIfv117Form = nil;

implementation

{$R *.DFM}

uses   dxBar,

       Files,
       FileCtrl,
       DateUtils,
       LibUtils,
       AppManager,
       EnterpriseDataAccess,

       Gim00Fields,

       Gdm30Frm,

       dm_reg,
       dm_ifv117,

       b_msg,
       b_pro,
       f_prg,

       Gdm00Dm;

resourceString
      RsMsg5  = 'El fichero especificado no existe';
      RsMsg6  = 'Utilice el botón [Examinar...] para localizar un fichero válido';

const
      ncrPathFicheroFacturas117 = 'PathFicheroFacturas117';

class procedure TBoxIfv117Form.ImportacionFacturas( Sender : TObject );
begin
     CreateEditForm( TBoxIfv117Form, BoxIfv117Form, TGds30Frm.VentasSection, True );
end;

procedure TBoxIfv117Form.FormManagerInitializeForm;
begin
     DataPath.Value := Registro.ObtenValorString( ncrPathFicheroFacturas117, CodigoEmpresaActual );
end;

procedure TBoxIfv117Form.FormManagerOkButton;
begin

     If   not FileExists( DataPath.AsString )
     then begin
          ShowHintMsg( RsMsg5, RsMsg6 );
          Abort;
          end;

     CreateProcessForm( ExecuteProcess, Caption );

     Registro.GuardaValor( ncrPathFicheroFacturas117, CodigoEmpresaActual, DataPath.Value );
end;

procedure TBoxIfv117Form.ExaminarButtonClick(Sender: TObject);
begin
     With ApplicationForms.OpenFileDialog do
       begin
       Filter := '';
       If   Execute
       then begin
            DataPath.AsString := FileName;
            PathCtrl.SetFocus;
            end;
       end;
end;

procedure TBoxIfv117Form.ExecuteProcess;
begin
     ImportacionFacturasVenta117.EjecutaProceso( LoadFileToString( DataPath.Value ) );
end;

function TBoxIfv117Form.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.acCaProcesos.Value;
end;

procedure Setup;

var  MenuItem : TMenuItem;

begin
     With Gds30Frm do
       begin
       ImportacionFacturasItem.Visible := ivAlways;
       ImportacionFacturasItem.OnClick := TBoxIfv117Form.ImportacionFacturas;
       end;
end;

initialization
    AddProcedure( imOnEnterpriseAccess, 0, Setup );

end.

