unit c_art;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,

  Mask, ComCtrls, ReportManager, Menus, cxLookAndFeelPainters, cxButtons, cxGraphics,
  cxMaskEdit, cxDropDownEdit, cxDBEdit, cxIndexedComboBox, cxTextEdit, cxPC,
  cxControls, cxContainer, cxEdit, cxCheckBox, DB, dxmdaset, DataManager,

  Gim30Fields, dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxGroupBox, cxPCdxBarPopupMenu,
  dxBarBuiltInMenu, dxUIAClasses;


type
    TCnsArtForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    IncluirObsoletosCtrl: TcxDBCheckBox;
    Data: TgxMemData;
    DataCodigoArticuloInicial: TStringField;
    DataCodigoArticuloFinal: TStringField;
    DataCodigoFamiliaInicial: TStringField;
    DataCodigoFamiliaFinal: TStringField;
    DataProveedorInicial: TStringField;
    DataProveedorFinal: TStringField;
    DataIncluirObsoletos: TBooleanField;
    DataSource: TDataSource;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    gxRangeBox1: TgxRangeBox;
    CodigoArticuloInicialCtrl: TcxDBTextEdit;
    CodigoArticuloFinalCtrl: TcxDBTextEdit;
    TabSheet2: TcxTabSheet;
    gxRangeBox2: TgxRangeBox;
    CodigoFamiliaInicialCtrl: TcxDBTextEdit;
    CodigoFamiliaFinalCtrl: TcxDBTextEdit;
    TabSheet3: TcxTabSheet;
    gxRangeBox3: TgxRangeBox;
    ProveedorInicialCtrl: TcxDBTextEdit;
    ProveedorFinalCtrl: TcxDBTextEdit;
    Label3: TcxLabel;
    Label1: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label4: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label5: TcxLabel;
    Label2: TcxLabel;
    Label11: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoArticuloCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoFamiliaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoFamiliaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

    end;

var
  CnsArtForm: TCnsArtForm;

procedure SeleccionRejillaEdicionArticulos;


implementation

uses   LibUtils,
       EnterpriseDataAccess,

       Gim00Fields,

       dm_pga,
       dm_fdc,
       dm_fdv,
       dm_art,
       dm_fam,
       dm_pro,

       cx_art,
       cx_fam,
       cx_pro,

       m_art;

{$R *.DFM}

procedure SeleccionRejillaEdicionArticulos;
begin
     If   Assigned( EdcArtForm )
     then EdcArtForm.BringToFront
     else CreateReportForm( TCnsArtForm, CnsArtForm );
end;

procedure TCnsArtForm.initializeForm;
begin
     DataCodigoArticuloFinal.Value := HighStrCode;
     DataCodigoFamiliaFinal.Value := HighStrCode;
     DataProveedorFinal.Value := HighStrCode;
end;

procedure TCnsArtForm.ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TCnsArtForm.ProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TCnsArtForm.FormManagerOkButton;

var SQLSelectText : String;

begin
     case PageControl.ActivePageIndex of
       0 : SQLSelectText := SQLFieldsFormat( 'Codigo BETWEEN ? AND ? ', [ DataCodigoArticuloInicial, DataCodigoArticuloFinal ] );
       1 : SQLSelectText := SQLFieldsFormat( 'Familia BETWEEN ? AND ? ', [ DataCodigoFamiliaInicial, DataCodigoFamiliaFinal ] );
       2 : SQLSelectText := SQLFieldsFormat( 'CodigoProveedor BETWEEN ? AND ? ', [ DataProveedorInicial, DataProveedorFinal ] );
       end;

     If   not DataIncluirObsoletos.Value
     then StrAdd( SQLSelectText, ' AND not Obsoleto ' );

     {
     case PageControl.ActivePageIndex of
       0 : StrAdd( SQLSelectText, ' ORDER BY Codigo' );
       1 : StrAdd( SQLSelectText, ' ORDER BY Familia' );
       2 : StrAdd( SQLSelectText, ' ORDER BY CodigoProveedor' );
       end;
     }

     RejillaEdicionArticulos( SQLSelectText, PageControl.ActivePageIndex );
end;

procedure TCnsArtForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TCnsArtForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, True, Sender );
end;

procedure TCnsArtForm.CodigoFamiliaCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaFamilias( Sender );
end;

procedure TCnsArtForm.CodigoFamiliaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Familia.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

end.
