
unit l_oco;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     LibUtils,
     AppContainer,
     ComCtrls,

     Menus, cxLookAndFeelPainters, cxButtons,

     dm_rpr, ReportManager, DB, nxdb,DataManager, cxCurrencyEdit,
  cxDBEdit, cxMaskEdit, cxSpinEdit, cxControls, cxContainer, cxEdit,
  cxTextEdit, dxmdaset,

     Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox;


type
    TRptOcoForm = class(TgxForm)
    FormManager: TgxFormManager;
    ProveedorDatEconTable: TnxeTable;
    Report: TgxReportManager;
   DataPanel: TgxEditPanel;
    ProveedorInicialCtrl: TcxDBTextEdit;
    ProveedorFinalCtrl: TcxDBTextEdit;
    MesInicialCtrl: TcxDBSpinEdit;
    MesFinalCtrl: TcxDBSpinEdit;
    ImporteMinimoCtrl: TcxDBCurrencyEdit;
    ImporteMaximoCtrl: TcxDBCurrencyEdit;
    MostrarCtrl: TcxDBSpinEdit;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
   Data: TgxMemData;
   DataSource: TDataSource;
   DataProveedorInicial: TWideStringField;
   DataProveedorFinal: TWideStringField;
   DataMesInicial: TSmallintField;
   DataMesFinal: TSmallintField;
   DataImporteMinimo: TBCDField;
   DataImporteMaximo: TBCDField;
   DataMostrar: TIntegerField;
    Label3: TcxLabel;
    Label6: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    Label1: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label4: TcxLabel;
    Label7: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure MesCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

      ProveedorDatEconFields : TProveedorDatEconFields;

      ReportConsumosTable : TnxeTable;
      ReportConsumosFields : TReportConsumosFields;

      AcumProveedor : TAcumuladoProveedor;
      ImporteTotal : Decimal;
      NroRegistroActual : smallInt;
      
    end;

var
  RptOcoForm: TRptOcoForm = nil;

procedure ListadoABCProveedores;

implementation

uses   SysUtils,
       DateUtils,

       EnterpriseDataAccess,

       Gdm30Dm,
       Gim00Fields,
       Gim10Fields,

       dm_pro,
       
       b_msg,

       cx_pro;

{$R *.DFM}

procedure ListadoABCProveedores;
begin
     CreateReportForm( TRptOcoForm, RptOcoForm );
end;

procedure TRptOcoForm.initializeForm;
begin

     ProveedorDatEconFields := TProveedorDatEconFields.Create( ProveedorDatEconTable );

     SetEditControlsDecimals( [ ImporteMinimoCtrl, ImporteMaximoCtrl ] );

     DataProveedorFinal.Value    := HighStrCode;
     DataMesInicial.Value := 1;
     DataMesFinal.Value := MonthOf( ApplicationContainer.TodayDate );
     DataImporteMaximo.Value := 9999999.99;
     DataMostrar.Value := 99999;
end;

procedure TRptOcoForm.MesCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateMonth( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptOcoForm.ProveedorCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptOcoForm.FormManagerOkButton;

procedure SeleccionaRegistros;

var   TotalNetoCompras  : Decimal;

begin

     FillChar( AcumProveedor, SizeOf( AcumProveedor ),#0 );

     With ProveedorDatEconTable do
       begin

       SetRange( [ ApplicationContainer.Ejercicio,DataProveedorInicial.Value ], [ ApplicationContainer.Ejercicio, DataProveedorFinal.Value ] );

       try

         NroRegistroActual := 0;
         ImporteTotal := 0.0;

         ApplicationContainer.StartProgression( RecordCount );

         First;
         while not Eof do
           begin

           With ProveedorDatEconFields do
             begin

             RelacionesProveedor.CalculaAcumulados( ProveedorDatEconFields, AcumProveedor,DataMesInicial.Value,DataMesFinal.Value );

             With AcumProveedor do
               begin

               TotalNetoCompras := TotalImporteCompras - TotalImporteDescuentos;

               If   ( TotalNetoCompras>=DataImporteMinimo.Value ) and
                    ( TotalNetoCompras<=DataImporteMaximo.Value )
               then begin

                    ReportConsumosTable.Append;

                    DecAdd( ImporteTotal, TotalNetoCompras );

                    ReportConsumosFields.ID.Value := Codigo.Value;
                    ReportConsumosFields.CodigoPropietario.Value := Codigo.Value;
                    ReportConsumosFields.Nombre.Value := Proveedor.Descripcion( Codigo.Value, True );
                    ReportConsumosFields.Importe1.Value := TotalNetoCompras;

                    ReportConsumosTable.Post;
                    end;
               end;

             end;

           ApplicationContainer.ShowProgression;

           Next;
           end;

         finally
           ApplicationContainer.EndProgression;
           end;

       end;
end;

begin
     Enabled := False;

     With Report do
       begin
       try
         Load;

         ReportConsumosTable := CreateEmptyTable( 'Consulta',DataModule30.GetSQL( 'Consumos' ) );
         ReportConsumosFields := TReportConsumosFields.Create( ReportConsumosTable );
         ReportConsumosTable.IndexName := 'Index1'; // Importe1

         SeleccionaRegistros;
         SetValueFields(Data );
         setValue( RsImporteTotal, ImporteTotal );
         Start;
       except on E : Exception do Cancel( E );
         end;

       end;

end;

procedure TRptOcoForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

end.

