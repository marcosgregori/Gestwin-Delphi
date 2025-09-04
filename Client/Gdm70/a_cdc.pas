unit a_cdc;

interface

uses
  ExtCtrls,

  Forms, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
  Data.DB, nxdb, DataManager, cxButtons, cxControls, cxContainer, cxEdit,
  cxGroupBox, cxTextEdit, cxRadioGroup, cxDBEdit, Vcl.StdCtrls,
  Vcl.Controls, System.Classes,

  AppForms,
  AppContainer, cxLabel, cxMaskEdit, cxSpinEdit, dxSkinsCore,
  dxSkinsDefaultPainters;

type
  TMntCdcForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    codigoCtrlCaption: TcxLabel;
    CodigoCosteTable: TnxeTable;
    dataPanel: TgxEditPanel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    DescripcionCtrl: TcxDBTextEdit;
    TipoCtrl: TcxDBRadioGroup;
    DataSource: TDataSource;
    CodigoCtrl: TcxDBSpinEdit;
    CodigoCosteTableCodigo: TSmallintField;
    CodigoCosteTableDescripcion: TWideStringField;
    CodigoCosteTableTipo: TSmallintField;
    procedure FormManagerReportRequest;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCosteTableNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var  MntCdcForm : TMntCdcForm = nil;

procedure MntCodigosCoste( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Gdm70Frm,

       cx_cdc,

       l_cdc;

procedure MntCodigosCoste( KeyValues : array of const );
begin
     CreateEditForm( TMntCdcForm, MntCdcForm, KeyValues, TGds70Frm.ProduccionSection );
end;

procedure TMntCdcForm.CodigoCosteTableNewRecord(DataSet: TDataSet);
begin
     CodigoCosteTableTipo.Value := 0; // Coste por hora
end;

procedure TMntCdcForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosCoste( Sender );
end;

procedure TMntCdcForm.FormManagerReportRequest;
begin
     ListadoCodigosCoste;
end;

end.
