unit a_def;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,
  Grids, Menus, cxLookAndFeelPainters, DB, nxdb, DataManager,
  cxButtons, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  cxCurrencyEdit, cxGraphics, cxLookAndFeels, dxSkinsCore, cxLabel,
  cxGroupBox, dxSkinsDefaultPainters, cxMaskEdit, cxSpinEdit, cxTimeEdit,

  Gim70Fields, dxUIAClasses;

type
  TMntDefForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBSpinEdit;
    DefectoTable: TnxeTable;
    dataPanel: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    DefectoDataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    CodigoClaseACtrl: TcxDBTextEdit;
    CodigoClaseBCtrl: TcxDBTextEdit;
    CodigoClaseCCtrl: TcxDBTextEdit;
    capClaseALabel: TcxLabel;
    capClaseBLabel: TcxLabel;
    DescClaseALabel: TcxLabel;
    DescClaseBLabel: TcxLabel;
    capClaseCLabel: TcxLabel;
    DescClaseCLabel: TcxLabel;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure CodigoClaseCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoClaseCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoClaseCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
  private
    DefectoFields : TDefectoFields;
  public

  end;

var
  MntDefForm: TMntDefForm = nil;

procedure MntDefectos( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Gdm70Dm,
       Gdm70Frm,

       dm_cls,

       a_cls,

       cx_def,
       cx_cls1,

       b_msg,

       l_def;

procedure MntDefectos( KeyValues : array of const );
begin
     CreateEditForm( TMntDefForm, MntDefForm, KeyValues, Gds70Frm.ProduccionSection );
end;

procedure TMntDefForm.CodigoClaseCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( Sender.Tag ), Sender.EditingValue ] );
end;

procedure TMntDefForm.CodigoClaseCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( TNroClase( Sender.Tag ), Sender );
end;

procedure TMntDefForm.CodigoClaseCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( TNroClase( Sender.Tag ), False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntDefForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaDefectos( Sender, qgsLinked );
end;

procedure TMntDefForm.FormManagerInitializeForm;
begin
     DefectoFields := TDefectoFields.Create( DefectoTable );;

     Clase.SetupEditControls( CodigoClaseACtrl, CodigoClaseBCtrl, CodigoClaseCCtrl );
     SetFieldRange( DefectoFields.Codigo);
end;

procedure TMntDefForm.FormManagerReportRequest;
begin
     ListadoDefectos;
end;

end.
