
unit l_lgc;

interface

uses     
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ComCtrls,

  dm_sal, Menus, cxLookAndFeelPainters, cxButtons, cxGraphics, DB, nxdb,
  cxMaskEdit, cxDropDownEdit, cxDBEdit, cxIndexedComboBox, cxPC,
  cxControls, cxContainer, cxEdit, cxTextEdit, ReportManager,
  cxCalendar, dxBarBuiltInMenu,

  cxCheckBox, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLookAndFeels, cxLabel, cxGroupBox, cxPCdxBarPopupMenu, dxmdaset,

  DataManager,

  Gim10Fields;


type
    TRptLgcForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    SerieInicialCtrl: TcxDBTextEdit;
    VencimientoInicialCtrl: TcxDBDateEdit;
    VencimientoFinalCtrl: TcxDBDateEdit;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    GrupoInicialCtrl: TcxDBTextEdit;
    GrupoFinalCtrl: TcxDBTextEdit;
    CodigoClienteInicialCtrl: TcxDBTextEdit;
    CodigoClienteFinalCtrl: TcxDBTextEdit;
    VendedorInicialCtrl: TcxDBTextEdit;
    VendedorFinalCtrl: TcxDBTextEdit;
    TipoDocumentoCtrl: TcxDBIndexedComboBox;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    SerieFinalCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataVencimientoInicial: TDateField;
    DataVencimientoFinal: TDateField;
    DataSource: TDataSource;
    report: TgxReportManager;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox3: TgxRangeBox;
    DataSerieInicial: TWideStringField;
    DataSerieFinal: TWideStringField;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataTipoDocumento: TSmallintField;
    DataVendedorInicial: TWideStringField;
    DataVendedorFinal: TWideStringField;
    DataGrupoClienteInicial: TWideStringField;
    DataGrupoClienteFinal: TWideStringField;
    gxRangeBox4: TgxRangeBox;
    gxRangeBox5: TgxRangeBox;
    cxDBCheckBox1: TcxDBCheckBox;
    DataIniciarPagina: TBooleanField;
    DataAgruparDia: TBooleanField;
    AgruparDiaCtrl: TcxDBCheckBox;
    Label6: TcxLabel;
    Label4: TcxLabel;
    Label3: TcxLabel;
    Label1: TcxLabel;
    Label11: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label7: TcxLabel;
    Label13: TcxLabel;
    Label15: TcxLabel;
    Label8: TcxLabel;
    Label12: TcxLabel;
    Label14: TcxLabel;
    EfectoCobrarQuery: TnxeQuery;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure SerieCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SerieFinalCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClienteCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure VendedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GrupoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GrupoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    private

    protected
    class procedure ListadoGestionCobro( Sender : TObject );

    public

      EfectoCobrarFields : TEfectoCobrarFields;
      FormaCobroFields : TFormaCobroFields;
      RelacionEfectosTable : TnxeTable;
      RelacionEfectosFields : TRelacionEfectosFields;

      InsertarRegistro : Boolean;
      TipoDeDocumento : SmallInt;

    end;

var RptLgcForm : TRptLgcForm = nil;


implementation

uses   dxBar,

       LibUtils,
       AppForm,
       AppManager,
       EnterpriseDataAccess,
       
       Gdm10Frm,
       Gdm00Dm,
       Gdm10Dm,

       b_msg,

       dm_sub,
       dm_ven,
       dm_gdc,
       dm_ecc,
       dm_sdf,

       cx_sub,
       cx_sdf,
       cx_ven,
       cx_gdc;

{$R *.dfm}

class procedure TRptLgcForm.ListadoGestionCobro( Sender : TObject );
begin
     CreateReportForm( TRptLgcForm, RptLgcForm );
end;

procedure TRptLgcForm.InitializeForm;
begin

     DataSerieFinal.Value := HighStrCode;
     DataVencimientoInicial.Value  := ApplicationContainer.TodayDate;
     DataVencimientoFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataClienteInicial.Value := '430000000';
     DataClienteFinal.Value  := '43' + HighStrCode;
     DataVendedorFinal.Value := HighStrCode;
     DataGrupoClienteFinal.Value := HighStrCode;
     DataIniciarPagina.Value := True;
end;

procedure TRptLgcForm.SerieCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender);
end;

procedure TRptLgcForm.SerieFinalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptLgcForm.VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TRptLgcForm.VendedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplaYValue, ErrorText, Error, True );
end;

procedure TRptLgcForm.FormManagerOkButton;

const TextoGrupo : array[ 0..1 ] of String = ( 'vendedor', 'grupo de cliente' );

procedure ConstruyeConsulta;

var  CodigoGrupo,
     SQLText : String;
     Consulta : TnxeQuery;

begin

     With Report, ReportManagerDataModule do
       begin
       Consulta := GetQuery;
       If   Assigned( Consulta )
       then begin

            If   PageControl.ActivePageIndex=0
            then SQLText := ' EfectoCobrar.Vendedor AS CodigoGrupo, Vendedor.Nombre AS DescripcionGrupo '
            else SQLText := ' EfectoCobrar.GrupoFacturacion AS CodigoGrupo, GrupoCliente.Descripcion AS DescripcionGrupo ';

            SQLText := 'SELECT EfectoCobrar.*, Cuenta.Descripcion AS Nombre, SerieFacturacion.Descripcion AS DescripcionSerie, ' +
                       SQLText +
                       'FROM  EFectoCobrar ' +
                       '      LEFT JOIN Remesa ON ( Remesa.Ejercicio=EfectoCobrar.EjercicioRemesa AND Remesa.NroRemesa=EfectoCobrar.NroRemesa ) ' +
                       '      LEFT JOIN FormaCobro ON ( FormaCobro.Codigo=EfectoCobrar.FormaDePago ) ' +
                       '      LEFT JOIN Cuenta ON ( Cuenta.Codigo=EfectoCobrar.SubcuentaCliente ) ' +
                       '      LEFT JOIN SerieFacturacion ON ( SerieFacturacion.Codigo=EfectoCobrar.Serie ) ';

            If   PageControl.ActivePageIndex=0
            then StrAdd( SQLText, 'LEFT JOIN Vendedor ON ( Vendedor.Codigo=EfectoCobrar.Vendedor ) ' )
            else StrAdd( SQLText, 'LEFT JOIN GrupoCliente ON ( GrupoCliente.Codigo=EfectoCobrar.GrupoFacturacion ) ' );

            StrAdd( SQLText, 'WHERE Serie BETWEEN ' + QuotedStr( DataSerieInicial.Value ) + ' AND '  + QuotedStr( DataSerieFinal.Value ) + ' AND ' +
                             'SubcuentaCliente BETWEEN ' + QuotedStr( DataClienteInicial.Value ) + ' AND ' + QuotedStr( DataClienteFinal.Value ) + ' AND ' +
                             'FechaVencimiento BETWEEN '+ SQLDateString( DataVencimientoInicial.Value ) +  ' AND ' + SQLDateString( DataVencimientoFinal.Value ) + ' AND ' );

            If   PageControl.ActivePageIndex=0
            then StrAdd( SQLText, 'Vendedor BETWEEN ' + QuotedStr( DataVendedorInicial.Value ) + ' AND ' + QuotedStr( DataVendedorFinal.Value ) + ' AND ' )
            else StrAdd( SQLText, 'GrupoFacturacion BETWEEN ' + QuotedStr( DataGrupoClienteInicial.Value ) + ' AND ' + QuotedStr( DataGrupoClienteFinal.Value ) +' AND ' );

            StrAdd( SQLText, '( FechaCobro IS NULL AND ( EfectoCobrar.NroRemesa IS NULL OR ( EfectoCobrar.NroRemesa<>0 AND NOT Remesa.Estado IS NULL AND Remesa.Estado in ( 0, 4 ) ) ) )' );  // Pendiente o Aceptada

            If   DataTipoDocumento.Value<>0
            then StrAdd( SQLText, ' AND FormaCobro.TipoDeDocumento=' + IntToStr( DataTipoDocumento.Value ) + ' ' );

            If   DataAgruparDia.Value
            then StrAdd( SQLText, 'ORDER BY CodigoGrupo,Serie,FechaVencimiento,NroFactura,NroEfecto' )
            else StrAdd( SQLText, 'ORDER BY CodigoGrupo,Serie,SubcuentaCliente,FechaVencimiento,NroFactura,NroEfecto' );

            Consulta.SQL.Text := SQLText;
            end;

       end;
end;

begin
     With Report do
       try
         Load;
         ConstruyeConsulta;
         SetValue( RsSeleccion, PageControl.ActivePageIndex );
         SetValue( 'TextoTipoDocumento', TipoDocumentoCtrl.Text );
         SetValue( 'TextoGrupo', TextoGrupo[ PageControl.ActivePageIndex ] );
         Start;
       except on E : Exception do
         Cancel( E );
         end;
end;

procedure TRptLgcForm.GrupoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoCliente.Valida( Sender, DisplaYValue, ErrorText, Error, True );
end;

procedure TRptLgcForm.GrupoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TRptLgcForm.CodigoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender );
end;

procedure TRptLgcForm.CodigoClienteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplaYValue, ErrorText, Error, nil, True );
end;

procedure SetupUnit;

var  MenuItem : TMenuItem;

begin
     If   Assigned( Gds10Frm )
     then With Gds10Frm do
            begin
            ListadoGestionCobroItem.Visible := ivAlways;
            ListadoGestionCobroItem.OnClick := TRptLgcForm.ListadoGestionCobro;
            end;
end;

initialization
     AddProcedure( imOnEnterpriseAccess, 0, SetupUnit );

end.
