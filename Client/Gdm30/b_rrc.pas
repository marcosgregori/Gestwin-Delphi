
unit b_rrc;

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
    TBoxRrcForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataRecalcularLineas: TBooleanField;
    DataReasignarNrosRegistro: TBooleanField;
    ReasignarGroupBox: TcxGroupBox;
    cxDBCheckBox1: TcxDBCheckBox;
    ReasignarNrosRegistroCtrl: TcxDBCheckBox;
    cxGroupBox2: TcxGroupBox;
    cxDBCheckBox2: TcxDBCheckBox;
    RecalcularLineasCtrl: TcxDBCheckBox;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    RecalcularFacturadosCtrl: TcxDBCheckBox;
    DataRecalcularFacturados: TBooleanField;
    DataConvertirImagenes: TBooleanField;
    DataRecalcularCosteFacturas: TBooleanField;
    cxDBCheckBox4: TcxDBCheckBox;
    cxLabel3: TcxLabel;
    RevisarEstadoTablasCtrl: TcxDBCheckBox;
    DataRevisarEstadoTablas: TBooleanField;
    cxGroupBox1: TcxGroupBox;
    cxLabel2: TcxLabel;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure RecalcularLineasCtrlPropertiesEditValueChanged(
      Sender: TObject);
    private
    procedure ExecuteProcess;

    public
    class procedure ReconstruccionResultadosComerciales( Sender : TObject );
    end;

var
  BoxRrcForm: TBoxRrcForm;


implementation

uses   dxBar,

       AppManager,

       Gdm00Dm,
       Gdm00Frm,

       dm_rdr,

       b_pro;

{$R *.DFM}

class procedure TBoxRrcForm.ReconstruccionResultadosComerciales( Sender : TObject );
begin
     CreateEditForm( TBoxRrcForm, BoxRrcForm, nil, True );
end;

procedure TBoxRrcForm.FormManagerInitializeForm;
begin

     RecalcularLineasCtrl.Enabled := not DataModule00.DmEmpresaFields.Articulo_PreciosIVA.Value;

     // Height := Height - ReasignarGroupBox.Height;
end;

procedure TBoxRrcForm.RecalcularLineasCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     RecalcularFacturadosCtrl.Enabled := RecalcularLineasCtrl.Checked;
end;

procedure TBoxRrcForm.FormManagerOkButton;
begin
     CreateProcessForm( ExecuteProcess, Caption );
end;

procedure TBoxRrcForm.ExecuteProcess;
begin
     ReconstruccionResultados.Reconstruccion( ApplicationContainer.Ejercicio,
                                              ApplicationContainer.Ejercicio,
                                              DataRevisarEstadoTablas.Value,
                                              DataReasignarNrosRegistro.Value,
                                              DataRecalcularLineas.Value,
                                              DataRecalcularFacturados.Value,
                                              DataRecalcularCosteFacturas.Value );
end;

procedure Setup;

var  MenuItem : TMenuItem;

begin
     With Gds00Frm do
       begin
       ReconstruccionResultadosItem.Visible := ivAlways;
       ReconstruccionResultadosItem.OnClick := TBoxRrcForm.ReconstruccionResultadosComerciales;
       end;
end;

initialization
    AddProcedure( imOnEnterpriseAccess, 0, Setup );

end.
