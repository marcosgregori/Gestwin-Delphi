
unit l_abm;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,
     LibUtils,
     AppContainer,
     ComCtrls,
     dm_sto, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxGroupBox, cxRadioGroup,
     cxGraphics, cxMaskEdit, cxDropDownEdit, cxIndexedComboBox, cxCheckBox,
     cxSpinEdit, ReportManager, DB, dxmdaset, DataManager, nxdb,

     Gim30Fields, dxSkinsCore, cxLookAndFeels, dxSkinsDefaultPainters, cxLabel;


type
    TExistenciasFields = class( TnxeDatasetFields)
    public
      CodigoArticulo : TWideStringField;
      Descripcion : TWideStringField;
      CodigoAlmacen : TWideStringField;
      Nombre : TWideStringField;
      StockMinimo : TBCDField;
      StockMaximo : TBCDField;
    end;
    
    TRptAbmForm = class(TgxForm)
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    ArticuloInicialCtrl: TcxDBTextEdit;
    ArticuloFinalCtrl: TcxDBTextEdit;
    MesInicialCtrl: TcxDBSpinEdit;
    MesFinalCtrl: TcxDBSpinEdit;
    SobreStockVirtualCtrl: TcxDBCheckBox;
    MostrarCtrl: TcxDBIndexedComboBox;
    SeleccionAlmacenCtrl: TcxDBRadioGroup;
    AlmacenCtrl: TcxDBTextEdit;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
    Data: TgxMemData;
    DataSource: TDataSource;
    Report: TgxReportManager;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
    DataMesInicial: TSmallintField;
    DataMesFinal: TSmallintField;
    DataAlmacen: TWideStringField;
    DataSobreStockVirtual: TBooleanField;
    DataMostrarArticulos: TSmallintField;
    DataSeleccionAlmacen: TSmallintField;
    Label3: TcxLabel;
    Label6: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    Label8: TcxLabel;
    Label1: TcxLabel;
    DescAlmacenLabel: TcxLabel;
    Label4: TcxLabel;
    Label7: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataTodasLasClases: TBooleanField;
    ExistenciasQuery : TnxeQuery;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure SeleccionAlmacenCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure MesCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

      ReportExistenciasTable : TnxeTable;
      ReportExistenciasFields : TReportExistenciasFields;

      Existencias : Decimal;
      
    public
            
    
    end;

var  RptAbmForm: TRptAbmForm = nil;

procedure ListadoBajoMinimosExceso;

implementation

uses   SysUtils,
       DateUtils,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm30Dm,
       Gim10Fields,

       dmi_sto,

       dm_art,
       dm_alm,
       dm_tma,
       dm_cls,
       dm_fdc,

       b_msg,

       cx_art,
       cx_alm,
       cx_tma;

{$R *.DFM}

procedure ListadoBajoMinimosExceso;
begin
     CreateReportForm( TRptAbmForm, RptAbmForm );
end;

procedure TRptAbmForm.InitializeForm;
begin
     DataSeleccionAlmacen.Value := 0;
     DataArticuloFinal.Value := HighStrCode;
     DataMesInicial.Value := 0;
     DataMesFinal.Value := MonthOf( ApplicationContainer.TodayDate );
     DataMostrarArticulos.Value := 0;
     DataSobreStockVirtual.Value := False;
end;

procedure TRptAbmForm.MesCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateMonth( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptAbmForm.SeleccionAlmacenCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     AlmacenCtrl.Enabled := DataSeleccionAlmacen.Value=1;
end;

procedure TRptAbmForm.AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TRptAbmForm.AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scAmbas, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptAbmForm.ArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TRptAbmForm.ArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptAbmForm.FormManagerOkButton;

procedure SeleccionaRegistros;

var   CodigoAlmacenInicial,
      CodigoAlmacenFinal : String;
      ExistenciasArticulo : IExistenciasArticulo;
      StockMinimo,
      StockMaximo : Decimal;
      ExistenciasFields : TExistenciasFields;
            
begin

     ReportExistenciasTable := Report.CreateEmptyTable( 'Existencias', DataModule30.GetSQL( 'Existencias' ) );
     ReportExistenciasFields := TReportExistenciasFields.Create( ReportExistenciasTable );
     
     If   DataSeleccionAlmacen.Value=0
     then begin
          CodigoAlmacenInicial := '';
          CodigoAlmacenFinal := 'ZZ';
          end
     else begin
          CodigoAlmacenInicial := DataAlmacen.AsString;
          CodigoAlmacenFinal := DataAlmacen.AsString;
          end;

     // He dividido la consulta en dos solo para que no se considere en absoluto el fichero ExistenciasAlmacen si
     // el usuario activa la opción, introduce datos en la tabla y desactiva de nuevo la opción
     
     If   DataModule00.DmEmpresaFields.Articulo_StockMinMaxPorAlmacen.Value 
     then ExistenciasQuery.SQL.Text := Report.GetSQLText( 'RelacionStockPorAlmacen' )
     else ExistenciasQuery.SQL.Text := Report.GetSQLText( 'RelacionStockArticulos' );
     
     ExistenciasQuery.Params[ 0 ].AsString := DataArticuloInicial.AsString;  
     ExistenciasQuery.Params[ 1 ].AsString := DataArticuloFinal.AsString;
     ExistenciasQuery.Params[ 2 ].AsString := CodigoAlmacenInicial;
     ExistenciasQuery.Params[ 3 ].AsString := CodigoAlmacenFinal;
          
     ExistenciasQuery.Open;

     ExistenciasFields := TExistenciasFields.Create( ExistenciasQuery );

     try

       ApplicationContainer.StartProgression( ExistenciasQuery.RecordCount );
  
       ExistenciasQuery.First;
       while not ExistenciasQuery.Eof do
         begin
                      
         StockMinimo := ExistenciasFields.StockMinimo.Value;
         StockMaximo := ExistenciasFields.StockMaximo.Value;
                                 
         ExistenciasArticulo := StockAlmacen.ObtenStock( ExistenciasFields.CodigoArticulo.Value, True, '', '', '', True, '', False, ExistenciasFields.CodigoAlmacen.Value, True, '', False, ApplicationContainer.Ejercicio, DataMesInicial.Value,DataMesFinal.Value );

         If   DataSobreStockVirtual.Value
         then Existencias := ExistenciasArticulo.SumaExistencias.PendienteRecibir + ExistenciasArticulo.SumaExistencias.Saldo - ExistenciasArticulo.SumaExistencias.PendienteServir
         else Existencias := ExistenciasArticulo.SumaExistencias.Saldo;
                  
         If   ( ( DataMostrarArticulos.Value in [ 0, 2 ] ) and ( Existencias<StockMinimo ) ) or
              ( ( DataMostrarArticulos.Value in [ 1, 2 ] ) and ( Existencias>StockMaximo ) )
         then begin

              ReportExistenciasTable.Append;

              ReportExistenciasFields.CodigoArticulo.Value := ExistenciasFields.CodigoArticulo.Value;
              ReportExistenciasFields.Descripcion.Value := ExistenciasFields.Descripcion.Value;                            
              ReportExistenciasFields.CodigoAlmacen.Value := ExistenciasFields.CodigoAlmacen.Value;
              ReportExistenciasFields.Existencias.Value := Existencias;
              ReportExistenciasFields.PendienteRecibir.Value := ExistenciasArticulo.SumaExistencias.PendienteRecibir;
              ReportExistenciasFields.PendienteServir.Value := ExistenciasArticulo.SumaExistencias.PendienteServir;
              ReportExistenciasFields.StockMinimo.Value := StockMinimo;
              ReportExistenciasFields.StockMaximo.Value := StockMaximo;

              ReportExistenciasTable.Post;
              end;
                                
         ApplicationContainer.ShowProgression;

         ExistenciasQuery.Next;
         end;

       finally
         ApplicationContainer.EndProgression;
         end;

end;

begin
     With Report do
       begin
       try
         Load;
         SeleccionaRegistros;
         SetValue( RsMostrar, MostrarCtrl.Text );
         FacturaCompras.FijaDecimalesInforme( Report );
         Clase.SetReportTitles( Report, 4 );
         Start;
       except on E : Exception do Cancel( E );
         end;

       end;

end;

end.

