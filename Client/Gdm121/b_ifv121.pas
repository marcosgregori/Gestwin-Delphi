
unit b_ifv121;

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
  cxLabel, cxGroupBox, dxmdaset, dxUIAClasses, cxRadioGroup;

type
  TBoxIfv121Form = class(TgxForm)
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
    cxLabel1: TcxLabel;
    DataTipoFichero: TSmallintField;
    TipoFicheroCtrl: TcxDBRadioGroup;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure ExaminarButtonClick(Sender: TObject);
    function FormManagerGetAccessLevel: Smallint;
    procedure PathCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);

  private

  protected

    PathFichero : String;

    class procedure ImportacionFacturas( Sender : TObject );

  public
    procedure ExecuteProcess;
  end;

var BoxIfv121Form: TBoxIfv121Form = nil;

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

       Gdm10Frm,

       dm_reg,
       dm_ifv121,

       b_msg,
       b_pro,
       f_prg,

       Gdm00Dm;

resourceString
      RsMsg1  = 'El fichero %s no existe';
      RsMsg2  = 'Utilice el botón [Examinar...] para localizar un fichero válido';

const
      ncrPathFicherosFacturas121 = 'PathFicherosFacturas121';

class procedure TBoxIfv121Form.ImportacionFacturas( Sender : TObject );
begin
     CreateEditForm( TBoxIfv121Form, BoxIfv121Form, TGds10Frm.LibrosIVASection, True );
end;

procedure TBoxIfv121Form.PathCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

const FileName : Array of String =  [ 'diario', 'mensual' ];

begin
     If   not ValueIsEmpty( DisplayValue )
     then begin
          var Tipo : SmallInt := DataTipoFichero.Value;
          PathFichero := DisplayValue + '\' + FileName[ Tipo ] + '.csv';
          If   not FileExists( PathFichero )
          then begin
               Error := True;
               ErrorText :=  Format( RsMsg1, [ PathFichero ] );
               end;
          end;
end;

procedure TBoxIfv121Form.FormManagerInitializeForm;
begin
     DataTipoFichero.Value := 0;  // Diario
     DataPath.Value := Registro.ObtenValorString( ncrPathFicherosFacturas121, CodigoEmpresaActual );
end;

procedure TBoxIfv121Form.FormManagerOkButton;
begin

     CreateProcessForm( ExecuteProcess, Caption );

     Registro.GuardaValor( ncrPathFicherosFacturas121, CodigoEmpresaActual, DataPath.Value );
end;

procedure TBoxIfv121Form.ExaminarButtonClick(Sender: TObject);

var Directories : TArray<string>;

begin
     var DirPath := PathCtrl.EditValue;
     If   SelectDirectory( DirPath, Directories, [] )
     then begin
          DataPath.AsString := Directories[0];
          PathCtrl.SetFocus;
          end;
end;

procedure TBoxIfv121Form.ExecuteProcess;
begin
     ImportacionFacturas121.EjecutaProceso( LoadFileToString( PathFichero ), { Diario } DataTipoFichero.Value=0 )
end;

function TBoxIfv121Form.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.acCaProcesos.Value;
end;

procedure Setup;

var  MenuItem : TMenuItem;

begin
     With Gds10Frm do
       begin
       ImportacionFacturasItem.Visible := ivAlways;
       ImportacionFacturasItem.OnClick := TBoxIfv121Form.ImportacionFacturas;
       end;
end;

initialization
    AddProcedure( imOnEnterpriseAccess, 0, Setup );

end.

