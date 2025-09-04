
unit b_iav103;

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
  cxLabel, cxGroupBox, dxmdaset,

  Gim103Fields;

type
  TBoxIav103Form = class(TgxForm)
    DataPanel: TgxEditPanel;
    PathCtrl: TcxDBTextEdit;
    examinarButton: TgBitBtn;
    SerieCtrl: TcxDBTextEdit;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataPath: TWideStringField;
    DataSerie: TWideStringField;
    FormManager: TgxFormManager;
    Label3: TcxLabel;
    Label19: TcxLabel;
    Label20: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox5: TcxGroupBox;
    cxLabel5: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure examinarButtonClick(Sender: TObject);
    function FormManagerGetAccessLevel: Smallint;
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);

  protected
    class procedure ImportacionAlbaranesExternos( Sender : TObject );

  private

    ParametrosImportacionRec : TParametrosImportacionRec;

  public
    procedure ExecuteProcess;
  end;

var BoxIav103Form: TBoxIav103Form = nil;

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

       dm_pga,
       dm_sdf,
       dm_iav103,

       cx_sdf,

       b_msg,
       b_pro,
       f_prg,

       Gdm00Dm;

resourceString
      RsMsg5  = 'El fichero especificado no existe';
      RsMsg6  = 'Utilice el botón [Examinar...] para localizar un Fichero válido';

class procedure TBoxIav103Form.ImportacionAlbaranesExternos( Sender : TObject );
begin
     CreateEditForm( TBoxIav103Form, BoxIav103Form, TGds30Frm.VentasSection, True );
end;

procedure TBoxIav103Form.FormManagerInitializeForm;
begin

     Configuracion.ObtenParametros( ctImpAlbExternos, CodigoEmpresaActual, TParametrosRec( ParametrosImportacionRec ) );

     DataPath.Value  := ParametrosImportacionRec.FicheroMovimientos;
     DataSerie.Value := ParametrosImportacionRec.SerieAlbaranDestino;
end;

procedure TBoxIav103Form.FormManagerOkButton;
begin

     If   not FileExists( DataPath.AsString )
     then begin
          ShowHintMsg( RsMsg5, RsMsg6 );
          Abort;
          end;

     CreateProcessForm( ExecuteProcess, Caption );

     ParametrosImportacionRec.FicheroMovimientos  := DataPath.Value;
     ParametrosImportacionRec.SerieAlbaranDestino := DataSerie.Value;

     Configuracion.GuardaParametros( ctImpAlbExternos, CodigoEmpresaActual, TParametrosRec( ParametrosImportacionRec ) );
end;

procedure TBoxIav103Form.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxIav103Form.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxIav103Form.ExaminarButtonClick(Sender: TObject);
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

procedure TBoxIav103Form.ExecuteProcess;
begin
     ImportacionAlbaranesVenta103.EjecutaProceso( DataSerie.Value, LoadFileToString( DataPath.Value ) );
end;

function TBoxIav103Form.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.acCaProcesos.Value;
end;

procedure Setup;

var  MenuItem : TMenuItem;

begin
     With Gds30Frm do
       begin
       ImportacionPozosItem.Visible := ivAlways;
       ImportacionPozosItem.OnClick := TBoxIav103Form.ImportacionAlbaranesExternos;
       end;

end;

initialization

    AddProcedure( imOptionalSectionModule, 103 );

    AddProcedure( imOnEnterpriseAccess, 0, Setup );

end.

