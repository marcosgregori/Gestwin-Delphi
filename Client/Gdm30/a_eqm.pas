unit a_eqm;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls,

  AppContainer,

  Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, 

  Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxCurrencyEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, dxmdaset, cxLookAndFeels, cxLabel, cxGroupBox,
  cxNavigator, dxDateRanges, AppForms, GridTableViewController,
  dxScrollbarAnnotations, dxUIAClasses;

type
  TMntEqmForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    EquipoMovilTable: TnxeTable;
    dataPanel: TgxEditPanel;
    DescripcionCtrl: TcxDBTextEdit;
    CodigoVendedorCtrl: TcxDBTextEdit;
    DataSource: TDataSource;
    Panel1: TcxGroupBox;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewCodigo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    TableViewManager: TGridTableViewController;
    RutasEquipoMovilDataSource: TDataSource;
    RutasEquipoMovilTable: TnxeTable;
    RutasEquipoMovilTableDescripcion: TWideStringField;
    codigoCtrlCaption: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label11: TcxLabel;
    Label12: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    CodigoUsuarioCtrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    RutasEquipoMovilTableCodigoEquipoMovil: TWideStringField;
    RutasEquipoMovilTableCodigoRuta: TWideStringField;
    RutasEquipoMovilTableNroOrden: TSmallintField;
    cxGroupBox1: TcxGroupBox;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoVendedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoVendedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoVendedorCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure FormManagerInitializeForm;
    procedure GridViewCodigoPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure RutasEquipoMovilTableCalcFields(DataSet: TDataSet);
    procedure CodigoUsuarioCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoUsuarioCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoUsuarioCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private

  public
    EquipoMovilFields : TEquipoMovilFields;
  end;

var  MntEqmForm: TMntEqmForm = nil;

procedure MntEquiposMoviles( keyValues : array of const );

implementation

{$R *.DFM}

uses   SysUtils,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dm_eqm,
       dm_rut,
       dm_ven,
       dm_usr,

       a_rut,
       a_ven,
       a_usr,

       cx_rut,
       cx_ven,
       cx_usr,

       cx_eqm,

       l_eqm;

resourceString
     RsMsg1  = 'Esta ruta ya está incluida en este equipo móvil.';
     RsMsg2  = '<Cualquiera>';
     RsMsg3  = '<No asignado>';
          
procedure MntEquiposMoviles( keyValues : array of const );
begin
     CreateEditForm( TMntEqmForm, MntEqmForm, KeyValues, TGds30Frm.VentasSection );
end;

procedure TMntEqmForm.FormManagerReportRequest;
begin
     ListadoEquiposMoviles;
end;

procedure TMntEqmForm.GridViewCodigoPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntRutas( [ Sender.EditingValue ] );
end;

procedure TMntEqmForm.GridViewCodigoPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRutas( Sender );
end;

procedure TMntEqmForm.GridViewCodigoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Index : SmallInt;

begin
     Ruta.Valida( Sender, DisplayValue, ErrorText, Error );
     If   not Error
     then With GridView.DataController do
            For Index := 0 to RecordCount - 1 do
              If   Index<>FocusedRecordIndex
              then If   GetValue( Index, 0 )=DisplayValue
                   then begin
                        ErrorText := RsMsg1;
                        Error := True;
                        end;
end;

procedure TMntEqmForm.RutasEquipoMovilTableCalcFields(DataSet: TDataSet);
begin
     RutasEquipoMovilTableDescripcion.Value := Ruta.Descripcion( RutasEquipoMovilTableCodigoRuta.Value, False );
end;

function TMntEqmForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.acVEFicheros.Value;
end;

procedure TMntEqmForm.FormManagerInitializeForm;
begin
    EquipoMovilFields := TEquipoMovilFields.Create( EquipoMovilTable );
end;

procedure TMntEqmForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEquiposMoviles( Sender, qgsLinked );
end;

procedure TMntEqmForm.CodigoUsuarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntUsuarios( [ Sender.EditingValue ] );
end;
procedure TMntEqmForm.CodigoUsuarioCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
  ConsultaUsuarios( Sender );
end;

procedure TMntEqmForm.CodigoUsuarioCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean );
begin
    If   DisplayValue=''
    then CodigoUsuarioCtrl.Description := RsMsg3
    else Usuario.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntEqmForm.CodigoVendedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntVendedores( [ Sender.EditingValue ] );
end;

procedure TMntEqmForm.CodigoVendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TMntEqmForm.CodigoVendedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   DisplayValue=''
     then CodigoVendedorCtrl.Description := RsMsg2
     else Vendedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

end.
