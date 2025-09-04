unit l_art;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,

  Mask, ComCtrls, ReportManager, Menus, cxLookAndFeelPainters, cxButtons, cxGraphics,
  cxMaskEdit, cxDropDownEdit, cxDBEdit, cxIndexedComboBox, cxTextEdit, cxPC,
  cxControls, cxContainer, cxEdit, cxCheckBox, DB, dxmdaset, DataManager,

  Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxLookAndFeels, cxLabel, cxGroupBox, cxPCdxBarPopupMenu, dxBarBuiltInMenu,
  dxUIAClasses;


type
    TRptArtForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    OrdenarCtrl: TcxDBCheckBox;
    IVAIncluidoCtrl: TcxDBCheckBox;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    CodigoArticuloInicialCtrl: TcxDBTextEdit;
    CodigoArticuloFinalCtrl: TcxDBTextEdit;
    CodigoFamiliaInicialCtrl: TcxDBTextEdit;
    CodigoFamiliaFinalCtrl: TcxDBTextEdit;
    IncluirObsoletosCtrl: TcxDBCheckBox;
    ModeloCtrl: TcxDBIndexedComboBox;
    MostrarDescuentosCtrl: TcxDBCheckBox;
    NoValorarCtrl: TcxDBCheckBox;
    Report: TgxReportManager;
    MostrarCodigosBarrasCtrl: TcxDBCheckBox;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCodigoArticuloInicial: TWideStringField;
    DataCodigoArticuloFinal: TWideStringField;
    DataCodigoFamiliaInicial: TWideStringField;
    DataCodigoFamiliaFinal: TWideStringField;
    DataModelo: TSmallintField;
    DataIVAIncluido: TBooleanField;
    DataIncluirObsoletos: TBooleanField;
    DataMostrarDescuentos: TBooleanField;
    DataOrdenar: TBooleanField;
    DataNoValorar: TBooleanField;
    DataMostrarCodigosBarras: TBooleanField;
    TabSheet3: TcxTabSheet;
    DataProveedorInicial: TWideStringField;
    DataProveedorFinal: TWideStringField;
    gxRangeBox3: TgxRangeBox;
    ProveedorInicialCtrl: TcxDBTextEdit;
    ProveedorFinalCtrl: TcxDBTextEdit;
    Label3: TcxLabel;
    Label6: TcxLabel;
    codigosBarrasLabel: TcxLabel;
    Label1: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label4: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label5: TcxLabel;
    Label2: TcxLabel;
    Label11: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataSoloArticulosTienda: TBooleanField;
    GroupBox1: TcxGroupBox;
    TiendaGroupBox: TcxGroupBox;
    SoloArticulosTiendaCtrl: TcxDBCheckBox;
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
    procedure ModeloCtrlPropertiesChange(Sender: TObject);
    procedure CodigoArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NoValorarCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure reportSetReportName;
    private

    public

    end;

var
  RptArtForm: TRptArtForm;

procedure ListadoArticulos;


implementation

uses   EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gim10Fields,

       dm_pga,
       dm_fdc,
       dm_fdv,
       dm_art,
       dm_fam,
       dm_pro,
       dm_iva,

       cx_art,
       cx_fam,
       cx_pro;

{$R *.DFM}

procedure ListadoArticulos;
begin
     CreateReportForm( TrptArtForm, rptArtForm );
end;

procedure TRptArtForm.InitializeForm;
begin
     DataModelo.Value := 0;
     DataCodigoArticuloFinal.Value := HighStrCode;
     DataCodigoFamiliaFinal.Value := HighStrCode;
     DataProveedorFinal.Value := HighStrCode;
     DataMostrarDescuentos.Value := True;
     SetupPanelableCtrl( SoloArticulosTiendaCtrl, DataModule00.TiendaVirtual, { AdjustFormHeight }True );
end;

procedure TRptArtForm.ModeloCtrlPropertiesChange(Sender: TObject);
begin
     IVAIncluidoCtrl.Enabled := ( DataModelo.Value in [ 0, 1 ] ) and not DataNoValorar.Value;
     IVAIncluidoCtrl.Checked := False;
     MostrarDescuentosCtrl.Enabled := not DataNoValorar.Value;
     MostrarCodigosBarrasCtrl.Enabled:= DataModelo.Value in [ 2, 3 ];

     CodigosBarrasLabel.Enabled := DataModelo.Value in [ 2, 3 ];

     If   DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value
     then begin
          DataNoValorar.Value := DataModelo.Value<>3;
          NoValorarCtrl.Enabled := DataModelo.Value=3;
          end;

     Report.UpdateReportName;  // El modelo afecta al nombre del fichero del report y a la lista de informes personalizados
end;

procedure TRptArtForm.NoValorarCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     DataMostrarDescuentos.Value := not NoValorarCtrl.Checked;
     MostrarDescuentosCtrl.Enabled := not NoValorarCtrl.Checked;
end;

procedure TRptArtForm.ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TRptArtForm.ProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptArtForm.ReportSetReportName;

var  FileExt : String;

begin
     With Report do
       begin
       If   DataModelo.Value<3
       then FileExt := IntToStr( DataModelo.Value + 1 )
       else FileExt := '3';
       FileName := 'dm30\l_art' + FileExt;
       end;
end;

procedure TRptArtForm.FormManagerOkButton;

var  Seleccion : SmallInt;

begin

     With Report do
       try

         Title := 'Artículos : ' + ModeloCtrl.Text;
         Seleccion := PageControl.ActivePageIndex;

         (*

          Consulta.SQL.Clear;
          Consulta.SQL.Add( 'Select Articulo.Codigo, Articulo.Descripcion, Articulo.Precio_Compra, Articulo.Dto_Compra, Articulo.Precio_Venta, ' );
          Consulta.SQL.Add( 'Articulo.Dto_Venta, Articulo.TipoIVA, Articulo.Comision, Articulo.Obsoleto, Articulo.Familia, Articulo.CodigoProveedor ' );

          case <Seleccion> of
            0 : ;
            1 : Consulta.SQL.Add( ', Familia.Descripcion AS Familia_Descripcion ' );
            2 : Consulta.SQL.Add( ', Proveedor.Nombre ' );
            end;

          Consulta.SQL.Add( 'From   Articulo ' );

          case <Seleccion> of
            0 : ;
            1 : Consulta.SQL.Add( 'LEFT JOIN Familia On ( Familia.Codigo=Articulo.Familia ) ' );
            2 : Consulta.SQL.Add( 'LEFT JOIN Proveedor On (Proveedor.Codigo=Articulo.CodigoProveedor ) ' );
            end;

          // Selección

          case <Seleccion> of
            0 : Consulta.SQL.Add( 'WHERE Articulo.Codigo>=''' + <CodigoArticuloInicial> + ''' and Articulo.Codigo<=''' + <CodigoArticuloFinal> + '''' );
            1 : Consulta.SQL.Add( 'WHERE Articulo.Familia>=''' + <CodigoFamiliaInicial> + ''' and Articulo.Familia<=''' + <CodigoFamiliaFinal> + '''' );
            2 : Consulta.SQL.Add( 'WHERE Articulo.CodigoProveedor>=''' + <ProveedorInicial> + ''' and Articulo.CodigoProveedor<=''' + <ProveedorFinal> + '''' );
            end;

          If   not <IncluirObsoletos>
          then Consulta.SQL.Add( ' AND ( Obsoleto IS NULL OR NOT Obsoleto ) ' );

          If   <SoloArticulosTienda>
          then Consulta.SQL.Add( ' AND ( NOT VisibleTienda IS NULL AND VisibleTienda ) ' );

          case <Seleccion> of
            0 : begin
                If   <Ordenar>
                then begin
                     Consulta.SQL.Add( 'Order by Articulo.Descripcion' );
                     GroupHeader1.Visible := True;
                     end
                else Consulta.SQL.Add( 'Order by Articulo.Codigo' );
                GroupHeader2.Visible := False;
                GroupHeader2.Condition := 'True';
                end;
            1 : begin
                Consulta.SQL.add( ' Order by Articulo.Familia' );
                If   <Ordenar>
                then Consulta.SQL.Add( ', Articulo.Descripcion' )
                else Consulta.SQL.Add( ', Articulo.Codigo' );
                GroupHeader2.Visible := True;
                GroupHeader2.Condition := '<Consulta."Familia">';
                end;
            2 : begin
                Consulta.SQL.Add( ' Order by Articulo.CodigoProveedor' );
                If   <Ordenar>
                then Consulta.SQL.Add( ', Articulo.Descripcion' )
                else Consulta.SQL.Add( ', Articulo.Codigo' );
                GroupHeader2.Visible := True;
                GroupHeader2.Condition := '<Consulta."CodigoProveedor">';
                end
            end;

         *)

         Load;

         FacturaCompras.FijaDecimalesInforme( Report );
         FacturaVentas.FijaDecimalesInforme( Report );

         SetValue( RsSeleccion, Seleccion );
         // SetValue( RsPeriodoTiposIVA, Tasa.PeriodoImpositivo( ApplicationContainer.TodayDate ) );

         Start;

       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptArtForm.CodigoArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptArtForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, True, Sender );
end;

procedure TRptArtForm.CodigoFamiliaCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaFamilias( Sender );
end;

procedure TRptArtForm.CodigoFamiliaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Familia.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

end.
