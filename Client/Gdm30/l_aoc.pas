
unit l_aoc;

interface

uses AppForms, StdCtrls, Mask, ExtCtrls, Buttons,
     Controls, Classes, Forms,

     LibUtils,
     AppContainer,
     ComCtrls,

     Menus, cxLookAndFeelPainters, cxButtons,

     ReportManager, DB, nxdb,DataManager, cxCurrencyEdit,
     cxDBEdit, cxMaskEdit, cxSpinEdit, cxControls, cxContainer, cxEdit,
     cxTextEdit, dxmdaset,

     Gim30Fields,
     dm_art, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics,
  cxLookAndFeels, cxLabel, cxGroupBox;


type
    TRptAocForm = class(TgxForm)
    FormManager: TgxFormManager;
    ArticuloDatEconTable: TnxeTable;
    Report: TgxReportManager;
   DataPanel: TgxEditPanel;
    ArticuloInicialCtrl: TcxDBTextEdit;
    ArticuloFinalCtrl: TcxDBTextEdit;
    MesInicialCtrl: TcxDBSpinEdit;
    MesFinalCtrl: TcxDBSpinEdit;
    ImporteMinimoCtrl: TcxDBCurrencyEdit;
    ImporteMaximoCtrl: TcxDBCurrencyEdit;
    MostrarCtrl: TcxDBSpinEdit;
    gxRangeBox1: TgxRangeBox;
    gxRangeBox2: TgxRangeBox;
   Data: TgxMemData;
   DataSource: TDataSource;
   DataArticuloInicial: TWideStringField;
   DataArticuloFinal: TWideStringField;
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
    procedure ArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

      ArticuloDatEconFields : TArticuloDatEconFields;

      ReportConsumosTable : TnxeTable;
      ReportConsumosFields : TReportConsumosFields;

      AcumArticulo : TAcumuladoArticulo;
      ImporteTotal : Decimal;
      NroRegistroActual : smallInt;

    end;

var
  RptAocForm: TRptAocForm = nil;

procedure ListadoABCArticulosCompras;

implementation

uses   SysUtils,
       DateUtils,
       EnterpriseDataAccess,

       Gdm30Dm,
       Gim00Fields,
       Gim10Fields,

       b_msg,

       cx_art;

{$R *.DFM}

procedure ListadoABCArticulosCompras;
begin
     CreateReportForm( TRptAocForm, RptAocForm );
end;

procedure TRptAocForm.initializeForm;
begin

     ArticuloDatEconFields := TArticuloDatEconFields.Create( ArticuloDatEconTable );

     SetEditControlsDecimals( [ ImporteMinimoCtrl, ImporteMaximoCtrl ] );

     DataArticuloFinal.Value := HighStrCode;
     DataMesInicial.Value := 1;
     DataMesFinal.Value := MonthOf( ApplicationContainer.TodayDate );
     DataImporteMaximo.Value := 9999999.99;
     DataMostrar.Value := 99999;
end;

procedure TRptAocForm.MesCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateMonth( Sender, DisplayValue, ErrorText, Error );
end;

procedure TRptAocForm.ArticuloCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

procedure TRptAocForm.FormManagerOkButton;

procedure SeleccionaRegistros;
begin

     FillChar( AcumArticulo, SizeOf( AcumArticulo ),#0 );

     With ArticuloDatEconTable do
       begin

       SetRange( [ ApplicationContainer.Ejercicio, DataArticuloInicial.Value, '', '', '', '' ],
                 [ ApplicationContainer.Ejercicio, DataArticuloFinal.Value, HighStrCode, HighStrCode, HighStrCode, HighStrCode ] );

       try

         NroRegistroActual := 0;
         ImporteTotal := 0.0;

         ReportConsumosTable.IndexFieldNames := 'ID';

         ApplicationContainer.StartProgression( RecordCount * 2 );

         First;
         while not Eof do
           begin

           With ReportConsumosFields do
             begin

             Articulo.CalculaAcumulados( ArticuloDatEconFields, AcumArticulo, DataMesInicial.Value, DataMesFinal.Value, True );

             With AcumArticulo do
               begin

               If   ReportConsumosTable.FindKey( [ ArticuloDatEconFields.Codigo.Value ] )
               then begin
                    ReportConsumosTable.Edit;
                    Importe1.Value := Importe1.Value + TotalImporteCompras
                    end
               else begin
                    ReportConsumosTable.Append;
                    ID.Value := ArticuloDatEconFields.Codigo.Value;
                    Codigo.Value := ArticuloDatEconFields.Codigo.Value;
                    Descripcion.Value := Articulo.Descripcion( Codigo.Value, True );
                    Importe1.Value := TotalImporteCompras;
                    end;

               ReportConsumosTable.Post;

               ImporteTotal := ImporteTotal + TotalImporteCompras;
               end;

             end;

           ApplicationContainer.ShowProgression;

           Next;
           end;

         First;
         while not Eof do
           begin

           If   ( ReportConsumosFields.Importe1.Value<DataImporteMinimo.Value )  or
                ( ReportConsumosFields.Importe1.Value>DataImporteMaximo.Value )
           then begin
                ImporteTotal := ImporteTotal - ReportConsumosFields.Importe1.Value;
                Delete;
                end
           else Next;

           ApplicationContainer.showProgression;
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

         SeleccionaRegistros;

         ReportConsumosTable.IndexName := 'Index1'; // Importe1

         SetValueFields(Data );
         SetValue( RsImporteTotal, ImporteTotal );
         Start;
       except on E : Exception do Cancel( E );
         end;

       end;

end;

procedure TRptAocForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scCompras, False, Sender );
end;

end.

