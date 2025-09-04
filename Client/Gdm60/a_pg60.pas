
unit a_pg60;

interface

uses Forms, AppForms, Windows, StdCtrls, Buttons, Mask,
  Controls, Classes, ExtCtrls, printers,
  ComCtrls,
  Dialogs, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxCheckBox, cxGroupBox,
  cxRadioGroup, DB,  dxSkinsCore, cxGraphics, cxLookAndFeels, cxLabel,
  dxSkinsDefaultPainters, dxmdaset, cxMaskEdit, cxSpinEdit, dxShellDialogs,
  dxUIAClasses,

  AppContainer,
  DataManager,

  Gdm60Dm;

type                                          
  TmntPg60Form = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    CodigoEquipoMovilCtrl: TcxDBTextEdit;
    OpenDialog: TdxOpenFileDialog;
    SeleccionConsumosCtrl: TcxDBCheckBox;
    MemData: TgxMemData;
    DataSource: TDataSource;
    MemDataCodigoEquipoMovil: TWideStringField;
    MemDataDocumento: TSmallintField;
    MemDataSeleccionConsumos: TBooleanField;
    DocumentoCtrl: TcxDBRadioGroup;
    Label2: TcxLabel;
    Label1: TcxLabel;
    Label7: TcxLabel;
    cxGroupBox2: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    MemDataMantenerDocumentos: TBooleanField;
    MantenerDocumentosCtrl: TcxDBCheckBox;
    procedure CodigoEquipoMovilCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoEquipoMovilCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoEquipoMovilCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerOkButton;
    procedure FormManagerDestroyForm;
    procedure FormManagerInitializeForm;
  private
  public

  end;

var   MntPg60Form : TmntPg60Form =nil;
      ParametrosPreventaRec : TParametrosPreventaRec;

const ctParametrosModulo = 1060;

procedure MntParametros;
procedure CompruebaParametros;

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,
       AppManager,

       Gdm00Dm,
       Gdm30Dm,
       Gim00Fields,
       Gdm60Frm,

       dm_pga,
       dm_eqm,

       a_pga,
       a_eqm,

       cx_eqm,

       b_msg,
       b_dir;

resourceString
       RsMsg5  = 'No se han fijado los parámetros de el módulo de preventa.';
       RsMsg6  = 'Utilice la ventana que se muestra a continuación para editarlos.';

procedure MntParametros;
begin
     CreateEditForm( TMntPg60Form, MntPg60Form, TGds60Frm.PreventaSection, True );
end;

procedure ObtenParametros;
begin
     Configuracion.ObtenParametros( ctParametrosModulo, CodigoEmpresaActual, TParametrosRec( ParametrosPreventaRec ) );
end;

procedure CompruebaParametros;
begin
     If   ParametrosPreventaRec.CodigoEquipoMovil=''
     then begin
          ShowNotification( ntStop, RsMsg5, RsMsg6 );
          MntParametros;
          Abort;
          end;

end;

procedure TmntPg60Form.FormManagerOkButton;
begin

     ParametrosPreventaRec.CodigoEquipoMovil := MemDataCodigoEquipoMovil.Value;
     ParametrosPreventaRec.DocumentoTrabajo := MemDataDocumento.Value;
     ParametrosPreventaRec.SeleccionConsumos := MemDataSeleccionConsumos.Value;
     ParametrosPreventaRec.MantenerDocumentos := MemDataMantenerDocumentos.Value;
     
     Configuracion.GuardaParametros( ctParametrosModulo, CodigoEmpresaActual,  TParametrosRec( ParametrosPreventaRec ) );
end;

procedure TmntPg60Form.FormManagerDestroyForm;
begin
     Configuracion.Update;
end;

procedure TmntPg60Form.FormManagerInitializeForm;
begin
     ObtenParametros;

     MemDataCodigoEquipoMovil.Value := ParametrosPreventaRec.CodigoEquipoMovil;
     MemDataDocumento.Value := ParametrosPreventaRec.DocumentoTrabajo;
     MemDataSeleccionConsumos.Value := ParametrosPreventaRec.SeleccionConsumos;
     MemDataMantenerDocumentos.Value := ParametrosPreventaRec.MantenerDocumentos;
end;

procedure TmntPg60Form.CodigoEquipoMovilCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntEquiposMoviles( [ Sender.EditValue ] );
end;

procedure TmntPg60Form.CodigoEquipoMovilCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEquiposMoviles( Sender );
end;

procedure TmntPg60Form.CodigoEquipoMovilCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     EquipoMovil.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

initialization
     AddProcedure( imGetParamConf, 0, ObtenParametros );

end.

