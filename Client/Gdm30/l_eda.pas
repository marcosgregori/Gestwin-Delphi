
unit l_eda;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,
     ComCtrls,

     dm_sto, Menus, cxLookAndFeelPainters, cxButtons, cxPC, cxCheckBox,
     cxDBEdit, cxGroupBox, cxRadioGroup, cxControls, cxContainer, cxEdit,
     cxTextEdit, cxMaskEdit, cxSpinEdit, ReportManager, DB, dxmdaset,
     DataManager, cxGraphics, cxDropDownEdit, cxIndexedComboBox,

     Gim30Fields, nxdb, dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels,
  dxSkinsDefaultPainters, cxLabel, cxPCdxBarPopupMenu, dxBarBuiltInMenu;

type
    TRptEdaForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    ValorarCtrl: TcxDBCheckBox;
    PrecioValoracionCtrl: TcxDBRadioGroup;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    ArticuloInicialCtrl: TcxDBTextEdit;
    ArticuloFinalCtrl: TcxDBTextEdit;
    FamiliaInicialCtrl: TcxDBTextEdit;
    FamiliaFinalCtrl: TcxDBTextEdit;
    OrdenarCtrl: TcxDBCheckBox;
    Data: TgxMemData;
    DataSeleccionAlmacen: TSmallintField;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
    DataMesInicial: TSmallintField;
    DataMesFinal: TSmallintField;
    DataAlmacen: TWideStringField;
    DataSource: TDataSource;
    Report: TgxReportManager;
    gxRangeBox1: TgxRangeBox;
    MesInicialCtrl: TcxDBSpinEdit;
    MesFinalCtrl: TcxDBSpinEdit;
    SeleccionAlmacenCtrl: TcxDBRadioGroup;
    AlmacenCtrl: TcxDBTextEdit;
    gxRangeBox2: TgxRangeBox;
    gxRangeBox3: TgxRangeBox;
    DataFamiliaInicial: TWideStringField;
    DataFamiliaFinal: TWideStringField;
    DataValorar: TBooleanField;
    DataPrecioValoracion: TSmallintField;
    DataOrdenar: TBooleanField;
    DataIncluir: TSmallintField;
    DataTipoMovimiento: TSmallintField;
    Label8: TcxLabel;
    Label9: TcxLabel;
    Label6: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    Label1: TcxLabel;
    DescAlmacenLabel: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    Label7: TcxLabel;
    Label10: TcxLabel;
    Label11: TcxLabel;
    Label15: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    TipoMovimientoCtrl: TcxDBSpinEdit;
    IncluirCtrl: TcxDBIndexedComboBox;
    Label12: TcxLabel;
    Label13: TcxLabel;
    DescTipoMovimientoLabel: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataDesglosarLotes: TBooleanField;
    DesglosarLotesCtrl: TcxDBCheckBox;
    ReportExistenciasTable: TnxeTable;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SeleccionAlmacenCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FamiliaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FamiliaFinalCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure MesCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ValorarCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure TipoMovimientoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TipoMovimientoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure IncluirCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ReportSetReportName;
    procedure ValorarCtrlPropertiesChange(Sender: TObject);
    private

      TodosLosAlmacenes : Boolean;

      function SendProgress( ObjectName : String; Percent1, Percent2 : SmallInt ) : Boolean;

    public

    end;

var RptEdaForm: TRptEdaForm = nil;

procedure ListadoExistenciasArticulos;

implementation

uses   SysUtils,
       DateUtils,
       LibUtils,
       AppManager,
       NexusRpcData,
       EnterpriseDataAccess,

       frxClass,

       Gdm30Dm,
       Gim00Fields,
       Gim10Fields,

       dmi_sto,

       dm_art,
       dm_fam,
       dm_alm,
       dm_tma,
       dm_cls,
       dm_mov,
       dm_fdc,

       b_msg,

       cx_art,
       cx_fam,
       cx_alm,
       cx_tma;

{$R *.DFM}

procedure ListadoExistenciasArticulos;
begin
     CreateReportForm( TRptEdaForm, RptEdaForm );
end;

procedure TRptEdaForm.IncluirCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     TipoMovimientoCtrl.Enabled := IncluirCtrl.EditValue=8;
end;

procedure TRptEdaForm.InitializeForm;
begin
     DataSeleccionAlmacen.Value := 0;
     DataArticuloFinal.Value := HighStrCode;
     DataFamiliaFinal.Value := HighStrCode;
     DataIncluir.Value := 0;
     DataValorar.Value := False;
     DataPrecioValoracion.Value := 0;
     DataMesFinal.Value := MonthOf( ApplicationContainer.TodayDate );
     DataOrdenar.Value := False;
end;

procedure TRptEdaForm.MesCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateMonth( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptEdaForm.ReportSetReportName;
begin
     If   DataValorar.Value
     then Report.FileName := '\dm30\l_eda2'
     else Report.FileName := '\dm30\l_eda1';
end;

procedure TRptEdaForm.SeleccionAlmacenCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     AlmacenCtrl.Enabled := DataSeleccionAlmacen.Value=1;
end;

procedure TRptEdaForm.TipoMovimientoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposMovimientoAlmacen( Sender );
end;

procedure TRptEdaForm.TipoMovimientoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     TipoMovAlmacen.Valida( Sender,DisplayValue, ErrorText, Error );
end;

procedure TRptEdaForm.ValorarCtrlPropertiesChange(Sender: TObject);
begin
     Report.UpdateReportName;
end;

procedure TRptEdaForm.ValorarCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     PrecioValoracionCtrl.Enabled := ValorarCtrl.Checked;
end;

procedure TRptEdaForm.FamiliaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFamilias( Sender );
end;

procedure TRptEdaForm.FamiliaFinalCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Familia.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptEdaForm.FormManagerOkButton;

var  CodigoInicial,
     CodigoFinal,
     RemoteTableName : String;

begin
     With Report do
       begin
       try

         Load;

         If   PageControl.ActivePageIndex=0
         then begin
              CodigoInicial := DataArticuloInicial.Value;
              CodigoFinal := DataArticuloFinal.Value;
              end
         else begin
              CodigoInicial := DataFamiliaInicial.Value;
              CodigoFinal := DataFamiliaFinal.Value;
              end;

         ApplicationContainer.StartProgression( 100, { Cancelable } False );
         try
           NexusRpc.OnProgress := SendProgress;
           RemoteTableName := StockAlmacen.ListadoExistencias( DataSeleccionAlmacen.Value=0,
                                                               DataAlmacen.Value,
                                                               DataMesInicial.Value,
                                                               DataMesFinal.Value,
                                                               PageControl.ActivePageIndex,
                                                               CodigoInicial,
                                                               CodigoFinal,
                                                               IncluirCtrl.ItemIndex,
                                                               DataTipoMovimiento.Value,
                                                               DataValorar.Value,
                                                               DataPrecioValoracion.Value,
                                                               DataDesglosarLotes.Value );
         finally
           NexusRpc.OnProgress := nil;
           ApplicationContainer.EndProgression;
           end;

         If   RemoteTableName<>''
         then begin

              ReportExistenciasTable.Close;

              ReportExistenciasTable.PreserveTemporalTableName := True;
              ReportExistenciasTable.TableName := RemoteTableName;

              ReportExistenciasTable.Open;

              If   ReportExistenciasTable.RecordCount=0
              then begin
                   ReportExistenciasTable.Close;
                   ShowNotification( ntWarning, RsgMsg318 );
                   Abort;
                   end
              else begin

                   var ReportTable := AssignTable( 'Existencias', ReportExistenciasTable );

                   SetValue( RsSeleccion, PageControl.ActivePageIndex );
                   SetValue( 'TextoIncluir', IncluirCtrl.Text );
                   SetValue( 'TextoTipoMovimiento', DescTipoMovimientoLabel.Caption );

                   With ReportTable do
                     case PageControl.ActivePageIndex of
                       0 : If   DataOrdenar.Value
                           then IndexFieldNames := RsDescripcion
                           else IndexFieldNames := 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC';
                       1 : If   DataOrdenar.Value
                           then IndexFieldNames := 'CodigoFamilia;Descripcion'
                           else IndexFieldNames := 'CodigoFamilia;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC';
                       end;

                   SetValueFields( Data );
                   FacturaCompras.FijaDecimalesInforme( Report );
                   Clase.SetReportTitles( Report, 4 );
                   Start;
                   end;

              end;

       except on E : Exception do
         Cancel( E );
         end;

       end;
end;

function TRptEdaForm.SendProgress( ObjectName : String; Percent1, Percent2 : SmallInt ) : Boolean;
begin
     ApplicationContainer.ShowProgression( '', Percent1 );
end;

procedure TRptEdaForm.AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TRptEdaForm.AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scAmbas, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptEdaForm.ArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TRptEdaForm.ArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

end.

