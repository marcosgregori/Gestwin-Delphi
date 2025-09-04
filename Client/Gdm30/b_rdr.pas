
unit b_rdr;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask, Menus, cxLookAndFeelPainters, cxButtons, dxSkinsCore, cxControls,
  cxContainer, cxEdit, cxCheckBox, cxDBEdit, DB, dxmdaset, DataManager,
  cxGraphics, cxLookAndFeels, dxSkinsDefaultPainters, cxLabel, cxGroupBox,
  dxUIAClasses;


type
    TBoxRdrForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    cxGroupBox2: TcxGroupBox;
    cxDBCheckBox2: TcxDBCheckBox;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataRecalcularCosteFacturas: TBooleanField;
    cxDBCheckBox4: TcxDBCheckBox;
    cxLabel3: TcxLabel;
    RevisarEstadoTablasCtrl: TcxDBCheckBox;
    DataRevisarEstadoTablas: TBooleanField;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    procedure FormManagerOkButton;
    private
    procedure ExecuteProcess;

    public

    end;

var
  BoxRdrForm: TBoxRdrForm;

procedure ProcesoReconstruccionResultados;

implementation

uses   Gdm30Frm,

       dm_rdr,

       b_pro;

{$R *.DFM}

procedure ProcesoReconstruccionResultados;
begin
     CreateEditForm( TBoxRdrForm, BoxRdrForm, TGds30Frm.ResultadosSection, True );
end;

procedure TBoxRdrForm.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxRdrForm.ExecuteProcess;
begin
     ReconstruccionResultados.Reconstruccion( ApplicationContainer.Ejercicio,
                                              ApplicationContainer.Ejercicio,
                                              DataRevisarEstadoTablas.Value,
                                              False,
                                              False,
                                              False,
											                        DataRecalcularCosteFacturas.Value );
end;

end.
