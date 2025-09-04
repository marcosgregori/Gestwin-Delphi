unit a_pdc;

interface

uses Forms, AppForms, StdCtrls, Buttons, Mask, Controls, Classes, Windows,
  ExtCtrls, Graphics, ComCtrls,
  AppContainer,
  DataManager,
  dm_art, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,

  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,

  Gdm30Dm, cxLabel, cxDBLabel, dxmdaset, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxGroupBox, cxGridCardView,
  cxGridDBCardView,
  Gim90Fields, DBCGrids;

type
  TMntPdcForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    ClienteTable: TnxeTable;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    ClienteDataSource: TDataSource;
    ClienteTableCodigo: TWideStringField;
    ClienteTableNombre: TWideStringField;
    NombreClienteLabel: TcxDBLabel;
    PersonaContactoDataSource: TDataSource;
    ClienteTableVendedor: TWideStringField;
    Label10: TcxLabel;
    PersonaContactoTable: TnxeTable;
    PersonaContactoTableTipo: TSmallintField;
    PersonaContactoTablePropietario: TWideStringField;
    PersonaContactoTableNroRegistro: TSmallintField;
    PersonaContactoTableNombre: TWideStringField;
    PersonaContactoTableTelefonoOficina: TWideStringField;
    PersonaContactoTableMovil: TWideStringField;
    PersonaContactoTableTelefonoParticular: TWideStringField;
    PersonaContactoTableFax: TWideStringField;
    PersonaContactoTableNoLlamar: TBooleanField;
    PersonaContactoTableEMail: TWideStringField;
    PersonaContactoTableFechaNacimiento: TDateField;
    PersonaContactoTableAsignadoA: TWideStringField;
    PersonaContactoTableObservaciones: TWideMemoField;
    DBCtrlGrid1: TDBCtrlGrid;
    cxDBTextEdit1: TcxDBTextEdit;
    cxDBLabel1: TcxDBLabel;
    cxLabel1: TcxLabel;
    Panel1: TcxGroupBox;
    AñadirContactoButton: TcxButton;
    cxLabel2: TcxLabel;
    cxDBTextEdit2: TcxDBTextEdit;
    DescAsignadoLabel: TcxLabel;
    LineaMovimientoTable: TnxeTable;
    Time1Label: TcxLabel;
    Time2Label: TcxLabel;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormManagerInitializeForm;
    procedure DBCtrlGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PersonaContactoTableAfterInsert(DataSet: TDataSet);
    procedure AñadirContactoButtonClick(Sender: TObject);
    procedure cxDBTextEdit2PropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure PersonaContactoTableBeforeInsert(DataSet: TDataSet);
  private
    PersonaContactoFields : TPersonaContactoFields;
  public

  end;

var  MntPdcForm: TMntPdcForm = nil;

procedure MntPersonasContacto( KeyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,
       EnterpriseDataAccess,
       Gdm00Dm,

       dm_cli,
       dm_tec,

       a_cli,

       cx_cli;

procedure MntPersonasContacto( KeyValues : array of const );
begin
     CreateEditForm( TMntPdcForm, MntPdcForm, KeyValues );
end;

procedure TMntPdcForm.AñadirContactoButtonClick(Sender: TObject);

var  CT : Cardinal;
     Inx : Integer;

begin
     // PersonaContactoTable.Append;
     With LineaMovimientoTable do
       begin
       Last;
       CT := GetTickCount;
       For Inx := 0 to 10000 do
         GetNextAutoIncValue;
       Time1Label.Caption := Format( '%d', [ GetTickCount - CT ] );

       CT := GetTickCount;
       For Inx := 0 to 10000 do
         GetNewAutoIncValue;
       Time2Label.Caption := Format( '%d', [ GetTickCount - CT ] );

       end;
end;

procedure TMntPdcForm.CodigoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TMntPdcForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TMntPdcForm.cxDBTextEdit2PropertiesValidate(     Sender       : TcxCustomEdit;
                                                       var DisplayValue : Variant;
                                                       var ErrorText    : TCaption;
                                                       var Error        : Boolean);
begin
     Tecnico.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntPdcForm.DBCtrlGrid1KeyDown(     Sender : TObject;
                                          var Key    : Word;
                                              Shift  : TShiftState );
begin
     If   Key=VK_INSERT
     then PersonaContactoTable.Append;
end;

procedure TMntPdcForm.FormManagerInitializeForm;
begin
     PersonaContactoFields := TPersonaContactoFields.Create( PersonaContactoTable );
     SetFieldRange( PersonaContactoTableNroRegistro );
end;

procedure TMntPdcForm.PersonaContactoTableAfterInsert(DataSet: TDataSet);
begin
     With PersonaContactoFields do
       begin
       Propietario.Value := ClienteTableCodigo.Value;
       Tipo.Value := 2;  // Clientes
       end;
end;

procedure TMntPdcForm.PersonaContactoTableBeforeInsert(DataSet: TDataSet);
begin
     PersonaContactoTable.NewAutoIncRecord( True );
end;

end.

