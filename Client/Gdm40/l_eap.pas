
unit l_eap;

interface

uses Windows, AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     AppContainer,

     ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, ReportManager, DB,
     nxdb, DataManager, cxCheckBox, cxDBEdit, cxSpinEdit, cxMaskEdit,
     cxDropDownEdit, cxCalendar, cxControls, cxContainer, cxEdit, cxTextEdit,
     cxGroupBox, cxRadioGroup, dxmdaset,

     Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, dxUIAClasses;


type

    TRelacionFields = class( TnxeDatasetFields )
      Propietario,
      Nombre,
      CodigoArticulo,
      CodigoClaseA,
      CodigoClaseB,
      CodigoClaseC,
      Descripcion : TWideStringField;
      NroOperacion : TIntegerField;
      NroRegistro : TLongWordField;
      Cantidad,
      CantidadProcesada,
      CantidadCargada,
      Existencias : TBCDField;
      end;

    TRptEapForm = class(TgxForm)
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    DataPanel: TgxEditPanel;
    ArticuloInicialCtrl: TcxDBTextEdit;
    ArticuloFinalCtrl: TcxDBTextEdit;
    CodigoClaseACtrl: TcxDBTextEdit;
    CodigoClaseBCtrl: TcxDBTextEdit;
    CodigoClaseCCtrl: TcxDBTextEdit;
    LoteCtrl: TcxDBTextEdit;
    Data: TgxMemData;
    DataSeleccionAlmacen: TSmallintField;
    DataArticuloInicial: TWideStringField;
    DataArticuloFinal: TWideStringField;
    DataAlmacen: TWideStringField;
    DataSource: TDataSource;
    SeleccionAlmacenCtrl: TcxDBRadioGroup;
    AlmacenCtrl: TcxDBTextEdit;
    gxRangeBox2: TgxRangeBox;
    DataCodigoClaseA: TWideStringField;
    DataCodigoClaseB: TWideStringField;
    DataCodigoClaseC: TWideStringField;
    DataLote: TWideStringField;
    Label3: TcxLabel;
    capClaseALabel: TcxLabel;
    capClaseBLabel: TcxLabel;
    descClaseALabel: TcxLabel;
    descClaseBLabel: TcxLabel;
    capClaseCLabel: TcxLabel;
    descClaseCLabel: TcxLabel;
    Label5: TcxLabel;
    Label1: TcxLabel;
    DescAlmacenLabel: TcxLabel;
    Label4: TcxLabel;
    Label7: TcxLabel;
    DataTodasLasClases: TBooleanField;
    TodasLasClasesCtrl: TcxDBCheckBox;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure ArticuloCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SeleccionAlmacenCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure CodigoClaseCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoClaseCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure LoteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure TodasLasClasesCtrlPropertiesEditValueChanged(
      Sender: TObject);
    private
      RelacionTable : TnxeTable;

    public

      MovimientoFields : TMovimientoFields;
      LineaMovimientoFields : TLineaMovimientoFields;

      ReportFichaArticuloTable : TnxeTable;
      ReportFichaArticuloFields : TReportFichaArticuloFields;

      Procesar : Boolean;
      SerieFacturacionActual : String;
      CodigoArticuloActual : String;

    end;

var
  RptEapForm: TRptEapForm = nil;

procedure ListadoEstadoArticulosPendientes;

implementation

uses   SysUtils,
       LibUtils,
       DateUtils,

       Gdm00Dm,
       Gim10Fields,

       dmi_sto,

       dm_art,
       dm_sto,
       dm_hdc,
       dm_tma,
       dm_cls,
       dm_fdv,
       dm_alm,

       b_msg,

       cx_cls1,
       cx_art,
       cx_alm;

{$R *.DFM}

procedure ListadoEstadoArticulosPendientes;
begin
     CreateReportForm( TRptEapForm, RptEapForm );
end;

procedure TRptEapForm.InitializeForm;
begin
     TodasLasClasesCtrl.Enabled := Clase.ExisteClase( tcClaseA );
     Clase.SetupEditControls( CodigoClaseACtrl, CodigoClaseBCtrl, CodigoClaseCCtrl );
     LoteCtrl.Enabled := DataModule00.DmEmpresaFields.Stock_LotesProductos.Value;
     DataSeleccionAlmacen.Value := 0;
     DataArticuloFinal.Value := HighStrCode;

end;

procedure TRptEapForm.LoteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     With LoteCtrl do
       If   ValueIsEmpty( DisplayValue )
       then Description := RsgMsgTodos
       else Description := '';

end;

procedure TRptEapForm.SeleccionAlmacenCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     AlmacenCtrl.Enabled := DataSeleccionAlmacen.Value=1;
end;

procedure TRptEapForm.TodasLasClasesCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ValidateEditControls( [ CodigoClaseACtrl, CodigoClaseBCtrl, CodigoClaseCCtrl ] );
end;

procedure TRptEapForm.FormManagerOkButton;

procedure SeleccionaRegistros;

var  RelacionFields : TRelacionFields;
     SQLText,
     SQLSeleccion : String;
     ExistenciasArticulo : IExistenciasArticulo;

begin

     SQLSeleccion := SQLFieldsFormat( ' CodigoArticulo BETWEEN ? AND ? ', [ DataArticuloInicial, DataArticuloFinal ] );

     If   not DataSeleccionAlmacen.Value=1
     then StrAdd( SQLSeleccion, SQLFieldsFormat( ' AND CodigoAlmacen=? ', [ DataAlmacen ] ) );

     If   CodigoClaseACtrl.Enabled
     then begin
          If   not DataTodasLasClases.Value
          then StrAdd( SQLSeleccion, ' AND CodigoClaseA=' + QuotedStr( DataCodigoClaseA.Value ) );
          If   CodigoClaseBCtrl.Enabled
          then begin
               If   not DataTodasLasClases.Value
               then StrAdd( SQLSeleccion, ' AND CodigoClaseB=' + QuotedStr( DataCodigoClaseB.Value ) );
               If   CodigoClaseCCtrl.Enabled
               then If   not DataTodasLasClases.Value
                    then StrAdd( SQLSeleccion, ' AND CodigoClaseC=' + QuotedStr( DataCodigoClaseC.Value ) );
               end;
          end;

     // Un año de movimientos pendientes (de momento es fijo, ya veremos la reacción de los usuarios)

     StrAdd( SQLSeleccion, ' AND Fecha BETWEEN ' + SQLDateString( IncYear( ApplicationContainer.TodayDate, -1 ) ) + ' AND ' + SQLDateString( ApplicationContainer.TodayDate ) + ' ' );

     SQLText := Report.GetSQLText;
     SetSQLVar( SQLText, 'Seleccion', SQLSeleccion );

     RelacionTable := Report.CreateQueryTable( 'Relacion', SQLText );
     RelacionFields := TRelacionFields.Create( RelacionTable );

     With RelacionTable do
       try

         ApplicationContainer.StartProgression( RecordCount );

         First;
         While not Eof do
           begin

           With RelacionFields do
             begin

             Edit;

             ExistenciasArticulo := StockAlmacen.ObtenStock( CodigoArticulo.Value,
                                                             DataTodasLasClases.Value,
                                                             DataCodigoClaseA.Value,
                                                             DataCodigoClaseB.Value,
                                                             DataCodigoClaseC.Value,
                                                             True,
                                                             '',
                                                             DataSeleccionAlmacen.Value=0,
                                                             DataAlmacen.Value,
                                                             True,
                                                             '',
                                                             False,
                                                             ApplicationContainer.Ejercicio,
                                                             0,
                                                             ApplicationContainer.NroMesFinal );

             Existencias.Value := ExistenciasArticulo.SumaExistencias.Saldo;
             CantidadCargada.Value := HojaCarga.ObtenCantidadCargada( NroRegistro.Value );

             Post;
             end;

           ApplicationContainer.ShowProgression;

           Next;
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
         FacturaVentas.FijaDecimalesInforme( Report );
         SetValue( RsNombreAlmacen, DescAlmacenLabel.Caption );
         Clase.SetReportTitles( Report, 4 );
         Start;
       except on E : Exception do Cancel( E );
         end;

       end;

end;

procedure TRptEapForm.AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TRptEapForm.AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scVentas, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptEapForm.ArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scVentas, True, Sender );
end;

procedure TRptEapForm.ArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptEapForm.CodigoClaseCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( TNroClase( Sender.Tag ), True, Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptEapForm.CodigoClaseCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClases1( TNroClase( Sender.Tag ), Sender );
end;

end.

