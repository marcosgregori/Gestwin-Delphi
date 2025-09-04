
unit b_iav101;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, AppForms, StdCtrls, Buttons, Mask,

  AppContainer,

  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,

  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox,

  Gim10Fields,
  Gim30Fields, dxmdaset;

type
  TBoxIav101Form = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    PathCtrl: TcxDBTextEdit;
    examinarButton: TgBitBtn;
    SerieCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataPath: TWideStringField;
    DataSerie: TWideStringField;
    Label3: TcxLabel;
    Label19: TcxLabel;
    Label20: TcxLabel;
    cxGroupBox5: TcxGroupBox;
    cxLabel5: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxGroupBox1: TcxGroupBox;
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure ExaminarButtonClick(Sender: TObject);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);

  private

    StrDataFile : string;

  public
    procedure ExecuteProcess;
  end;

var  BoxIav101Form: TBoxIav101Form = nil;

procedure ImportacionAlbaranesVenta;

implementation

{$R *.DFM}

uses   Files,
       FileCtrl,
       DateUtils,
       LibUtils,
       AppManager,
       EnterpriseDataAccess,
       SessionDataAccess,

       Gdm101Frm,

       dm_sdf,
       dm_iav101,

       a_pg101,

       cx_sdf,

       b_msg,
       b_pro;

resourceString
  RsMsg6   = 'El fichero no existe.';
  RsMsg7   = 'Seleccione un fichero válido pulsando el botón [Examinar ...].';

procedure ImportacionAlbaranesVenta;
begin
     CreateEditForm( TBoxIav101Form, BoxIav101Form, Gds101Frm.HormigonerasSection, True );
end;

procedure TBoxIav101Form.FormManagerInitializeForm;
begin
     CloseWindowWhenFocusLost := True;

     If   ParametrosHormigonesRec.FicheroImportacion=''
     then DataPath.Value := 'ALBBETON.PRN'
     else DataPath.Value := ParametrosHormigonesRec.FicheroImportacion;
end;

procedure TBoxIav101Form.FormManagerOkButton;
begin
     If   not FileExists( DataPath.Value )
     then begin
          ShowHintMsg( RsMsg6, RsMsg7 );
          Abort;
          end;
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxIav101Form.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxIav101Form.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxIav101Form.ExaminarButtonClick(Sender: TObject);
begin
     With ApplicationForms.OpenFileDialog do
       begin
       InitialDir := ExtractFilePath( DataPath.Value );
       Filter := 'Ficheros de datos (*.prn)|*.PRN';
       If   Execute
       then begin
            DataPath.Value := FileName;
            PathCtrl.SetFocus;
            end;
       end;
end;

procedure TBoxIav101Form.ExecuteProcess;
begin
     ImportacionAlbaranesVenta101.EjecutaProceso( DataSerie.Value, LoadFileToString( DataPath.Value ) );
end;

end.

