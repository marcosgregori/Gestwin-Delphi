unit l_cli;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, ReportManager, DB,
  dxmdaset, DataManager, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxPC,
  cxControls, cxCheckBox, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox,
  cxPCdxBarPopupMenu, dxBarBuiltInMenu;

                                                                                                  
type
    TRptCliForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    OrdenarCtrl: TcxDBCheckBox;
    TodosLosDatosCtrl: TcxDBCheckBox;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    GrupoClienteTabSheet: TcxTabSheet;
    GrupoInicialCtrl: TcxDBTextEdit;
    GrupoFinalCtrl: TcxDBTextEdit;
    TabSheet3: TcxTabSheet;
    CodigoPostalInicialCtrl: TcxDBTextEdit;
    CodigoPostalFinalCtrl: TcxDBTextEdit;
    ProvinciaInicialCtrl: TcxDBTextEdit;
    ProvinciaFinalCtrl: TcxDBTextEdit;
    CodigoPaisCtrl: TcxDBTextEdit;
    VendedorTabSheet: TcxTabSheet;
    VendedorInicialCtrl: TcxDBTextEdit;
    VendedorFinalCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataOrdenar: TBooleanField;
    DataTodosLosDatos: TBooleanField;
    DataGrupoInicial: TWideStringField;
    DataGrupoFinal: TWideStringField;
    DataCodigoPostalInicial: TWideStringField;
    DataCodigoPostalFinal: TWideStringField;
    DataProvinciaInicial: TWideStringField;
    DataProvinciaFinal: TWideStringField;
    DataVendedorInicial: TWideStringField;
    DataVendedorFinal: TWideStringField;
    DataCodigoPais: TWideStringField;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox3: TgxRangeBox;
    gxRangeBox4: TgxRangeBox;
    cxTabSheet1: TcxTabSheet;
    gxRangeBox5: TgxRangeBox;
    FormaCobroInicialCtrl: TcxDBTextEdit;
    FormaCobroFinalCtrl: TcxDBTextEdit;
    DataFormaCobroInicial: TWideStringField;
    DataFormaCobroFinal: TWideStringField;
    Label4: TcxLabel;
    Label5: TcxLabel;
    Label2: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label12: TcxLabel;
    Label11: TcxLabel;
    Label15: TcxLabel;
    Label16: TcxLabel;
    Label1: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    Label17: TcxLabel;
    Label18: TcxLabel;
    Label19: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    IncluirObsoletosCtrl: TcxDBCheckBox;
    DataIncluirObsoletos: TBooleanField;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GrupoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GrupoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure VendedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ProvinciaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalInicialCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalFinalCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalFinalCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoPostalCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoPaisCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoPaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormaCobroPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormaCobroCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure ProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure ProvinciaFinalCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ProvinciaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
    private

    public

    end;

var
  RptCliForm: TRptCliForm;

procedure ListadoClientes;


implementation

uses   Gim30Fields,

       Gdm00Dm,

       dm_pai,
       dm_prv,
       dm_cop,
       dm_cli,
       dm_gdc,
       dm_ven,
       dm_fco,

       cx_cli,
       cx_gdc,
       cx_ven,
       cx_prv,
       cx_pai,
       cx_cop,
       cx_fco;

{$R *.DFM}

procedure ListadoClientes;
begin
     CreateReportForm( TRptCliForm, RptCliForm );
end;

procedure TRptCliForm.InitializeForm;

var  GestionComercialActiva : Boolean;

begin

     Id := idRptCliForm;

     DataClienteFinal.Value := HighStrCode;
     DataGrupoFinal.Value := HighStrCode;
     DataCodigoPais.Value := CodigoEspaña;
     DataVendedorFinal.Value := HighStrCode;
     DataProvinciaFinal.Value := HighStrCode;
     DataCodigoPostalFinal.Value := HighStrCode;
     DataFormaCobroFinal.Value := HighStrCode;
     DataOrdenar.Value := False;
     DataTodosLosDatos.Value := False;

     GestionComercialActiva := {$IFDEF DEBUGAPP} True {$ELSE} ApplicationContainer.IsModuleActive( [ 30 ] ) {$ENDIF} ;
     GrupoClienteTabSheet.TabVisible := GestionComercialActiva and DataModule00.DmEmpresaFields.Cliente_GruposFac.Value;
     VendedorTabSheet.TabVisible := GestionComercialActiva;

end;

procedure TRptCliForm.ProvinciaCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaProvincias( DataCodigoPais.Value, Sender );
end;

procedure TRptCliForm.ProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( DataCodigoPais.Value, Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCliForm.ProvinciaFinalCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ProvinciaFinalCtrl.Editing
     then CodigoPostalFinalCtrl.PostEditValue( '' );
end;

procedure TRptCliForm.ProvinciaInicialCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ProvinciaInicialCtrl.Editing
     then CodigoPostalInicialCtrl.PostEditValue( '' );
end;

procedure TRptCliForm.VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TRptCliForm.VendedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCliForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TRptCliForm.ClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptCliForm.CodigoPaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TRptCliForm.CodigoPaisCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
     If   not Error
     then CodigoPostal.SetupCPControl( DisplayValue, [ ProvinciaInicialCtrl, ProvinciaFinalCtrl ],
                                                     [ CodigoPostalInicialCtrl, CodigoPostalFinalCtrl ] );
end;

procedure TRptCliForm.CodigoPostalFinalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( DataCodigoPais.Value, DataProvinciaFinal.Value, Sender );
end;

procedure TRptCliForm.CodigoPostalFinalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( DataCodigoPais.Value, DataProvinciaFinal.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptCliForm.CodigoPostalInicialCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( DataCodigoPais.Value, DataProvinciaInicial.Value, Sender );
end;

procedure TRptCliForm.CodigoPostalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( DataCodigoPais.Value, DataProvinciaInicial.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptCliForm.FormaCobroCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptCliForm.FormaCobroPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

procedure TRptCliForm.FormManagerOkButton;
begin
     Enabled := False;
     With Report do
       try
         Load;
         SetValue( RsSeleccion, PageControl.ActivePageIndex );
         With DataModule00.DmEmpresaFields do
           begin
           SetValue( 'MostrarCamposLibres', Cliente_CamposLibres.Value );
           If   Cliente_CamposLibres.Value
           then begin
                SetValue( 'CampoLibre1', Cliente_CampoLibre[ 1 ].Value );
                SetValue( 'CampoLibre2', Cliente_CampoLibre[ 2 ].Value );
                SetValue( 'CampoLibre3', Cliente_CampoLibre[ 3 ].Value );
                SetValue( 'CampoLibre4', Cliente_CampoLibre[ 4 ].Value );
                end;
           end;
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptCliForm.GrupoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TRptCliForm.GrupoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

end.
