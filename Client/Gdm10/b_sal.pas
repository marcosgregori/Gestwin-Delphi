
unit b_sal;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes, Graphics, Windows,
     ExtCtrls,

     AppContainer,

     ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxHeader, cxGroupBox,
     cxRadioGroup, DB, dxmdaset, DataManager, Grids, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, nxdb, cxCurrencyEdit,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels,
  cxLabel, ImgList, cxNavigator, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBExtLookupComboBox, EditSelector, dxDateRanges, AppForms,
  GridTableViewController, cxSpinEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxIntegerEdit,
  cxCheckBox, cxSpinButton, dxScrollbarAnnotations;

type   TTipoDesplazamientoLinea = ( dlPrimera, dlAnterior, dlProxima, dlUltima );

type
  TBrwSalForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CentroCosteCtrl: TcxDBTextEdit;
    SeleccionCentroCosteCtrl: TcxDBRadioGroup;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataPanel: TgxEditPanel;
    Data: TgxMemData;
    DataSeleccionCentroCoste: TSmallIntField;
    DataCentroCoste: TWideStringField;
    DataSource: TDataSource;
    DataCuenta: TWideStringField;
    SaldosMemoryDataSource: TDataSource;
    SaldosMemoryTable: TnxMemTable;
    DescCuentaLabel: TcxLabel;
    descCCLabel: TcxLabel;
    Label4: TcxLabel;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewPeriodo: TcxGridDBColumn;
    TableViewDebe1: TcxGridDBColumn;
    TableViewDebe2: TcxGridDBColumn;
    TableViewHaber1: TcxGridDBColumn;
    TableViewHaber2: TcxGridDBColumn;
    TableViewSaldoPeriodo1: TcxGridDBColumn;
    TableViewSaldoPeriodo2: TcxGridDBColumn;
    TableViewSaldo1: TcxGridDBColumn;
    TableViewSaldo2: TcxGridDBColumn;
    TableViewSeparator: TcxGridDBColumn;
    TableViewNombrePeriodo: TcxGridDBColumn;
    cxLabel1: TcxLabel;
    GridViewRepository: TcxGridViewRepository;
    CuentasTableView: TcxGridDBTableView;
    CuentasDataSource: TDataSource;
    CuentasTable: TnxeTable;
    CuentasTableCodigo: TStringField;
    CuentasTableDescripcion: TStringField;
    CuentasTableViewCodigo: TcxGridDBColumn;
    CuentasTableViewDescripcion: TcxGridDBColumn;
    EditSelector: TgxEditSelector;
    CuentasTableNroRegistro: TSmallintField;
    SaldosMemoryTableIndice: TSmallintField;
    SaldosMemoryTablePeriodo: TSmallintField;
    SaldosMemoryTableDebe1: TCurrencyField;
    SaldosMemoryTableHaber1: TCurrencyField;
    SaldosMemoryTableSaldo1: TCurrencyField;
    SaldosMemoryTableSaldoPeriodo1: TCurrencyField;
    SaldosMemoryTableDebe2: TCurrencyField;
    SaldosMemoryTableHaber2: TCurrencyField;
    SaldosMemoryTableSaldoPeriodo2: TCurrencyField;
    SaldosMemoryTableSaldo2: TCurrencyField;
    SaldosMemoryTableNombrePeriodo: TWideStringField;
    CuentaCtrl: TcxDBTextEdit;
    DataEjercicio: TSmallintField;
    SaldosMemoryTableVariacion: TSmallintField;
    TableViewVariacion: TcxGridDBColumn;
    DataMostrarVariacion: TBooleanField;
    SaldosMemoryTableVariacionPeriodo: TSmallintField;
    TableViewVariacionPeriodo: TcxGridDBColumn;
    CaptionPanel: TGridTableViewPanel;
    MostrarVariacionCtrl: TcxDBCheckBox;
    EjercicioAnteriorButton: TcxButton;
    EjercicioPosteriorButton: TcxButton;
    EjercicioActualLabel: TcxLabel;
    EjercicioAnteriorLabel: TGridTableViewPanelLabel;
    GridTableViewPanelGroupBox1: TGridTableViewPanelGroupBox;
    procedure FormManagerInitializeForm;
    procedure FormManagerGraphicRequest;
    procedure SubcuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SeleccionCCCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure SubcuentaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CentroCosteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormManagerFocusedAreaChanged;
    procedure CuentasTableViewCodigoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure EditSelectorEditModeChanged;
    procedure EjercicioActualCtrlPropertiesValuePosted(Sender: TObject);
    procedure TableViewVariacionGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure EjercicioAnteriorButtonClick(Sender: TObject);
    procedure EjercicioPosteriorButtonClick(Sender: TObject);
    procedure MostrarVariacionCtrlPropertiesChange(Sender: TObject);
    procedure CaptionPanelResize(Sender: TObject);
  private

    procedure ActualizaPanelEjercicio;
    procedure ActualizaSaldos;
    procedure IncrementaEjercicio( Increment : SmallInt );
  public

  end;

procedure SaldoCuentas( MultipleInstances : Boolean = False );

implementation

{$R *.DFM}

uses   SysUtils,
       LibUtils,
       DateUtils,
       Variants,

       AppManager,
       SessionDataAccess,
       DataAccess,

       Gim00Fields,
       Gdm00Dm,

       dmi_sal,

       dm_pga,
       dm_sub,
       dm_cco,
       dm_sal,
       dm_sec,

       a_ast,

       cx_sub,
       cx_cco,

       g_sal;

resourceString
     RsMsg1 = 'Debe indicar, al menos, un cuenta.';

procedure SaldoCuentas( MultipleInstances : Boolean = False );
begin
     CreateEditForm( TBrwSalForm, [], MultipleInstances );
end;

procedure TBrwSalForm.FormManagerFocusedAreaChanged;
begin
     If   FormManager.DataAreaFocused
     then begin
          DataEjercicio.Value := ApplicationContainer.Ejercicio;
          ActualizaSaldos;
          end
     else SaldosMemoryDataSource.Enabled := False;
end;

procedure TBrwSalForm.ActualizaSaldos;

var ListaCuentas : TStringList;
    I : SmallInt;

procedure ActualizaSaldosEjercicio( SumasySaldos : ISumasySaldos );

var SumaSaldo : Decimal;
    I, J : SmallInt;

procedure ActualizaRegistro( Periodo,
                             Indice       : Byte );

var  NombrePeriodo : String;

begin
     With SaldosMemoryTable do
       begin

       If   FindKey( [ Periodo ] )
       then Edit
       else begin
            Append;
            NombrePeriodo := StPeriodo[ Periodo ];
            If   not ( Periodo in [ 0, 13, 14 ] )
            then NombrePeriodo := '    ' + NombrePeriodo;
            SaldosMemoryTableNombrePeriodo.Value := NombrePeriodo;
            SaldosMemoryTableIndice.Value := Indice;
            SaldosMemoryTablePeriodo.Value := Periodo;
            end;

       SumaSaldo := SumaSaldo + SumasySaldos.Debe[ Periodo ] - SumasySaldos.Haber[ Periodo ];

       If   SumasySaldos.Ejercicio=DataEjercicio.Value
       then begin
            SaldosMemoryTableDebe1.Value := SaldosMemoryTableDebe1.Value + SumasySaldos.Debe[ Periodo ];
            SaldosMemoryTableHaber1.Value := SaldosMemoryTableHaber1.Value + SumasySaldos.Haber[ Periodo ];
            SaldosMemoryTableSaldoPeriodo1.Value := SaldosMemoryTableSaldoPeriodo1.Value + SumasySaldos.Debe[ Periodo ] - SumasySaldos.Haber[ Periodo ];
            SaldosMemoryTableSaldo1.Value := SaldosMemoryTableSaldo1.Value + SumaSaldo;
            end
       else begin
            SaldosMemoryTableDebe2.Value := SaldosMemoryTableDebe2.Value + SumasySaldos.Debe[ Periodo ];
            SaldosMemoryTableHaber2.Value := SaldosMemoryTableHaber2.Value + SumasySaldos.Haber[ Periodo ];
            SaldosMemoryTableSaldoPeriodo2.Value := SaldosMemoryTableSaldoPeriodo2.Value + SumasySaldos.Debe[ Periodo ] - SumasySaldos.Haber[ Periodo ];
            SaldosMemoryTableSaldo2.Value := SaldosMemoryTableSaldo2.Value + SumaSaldo;
            end;

       Post;
       end;
end;

begin

     If   not FormManager.DataAreaFocused
     then Exit;

     SaldosMemoryTable.IndexFieldNames := 'Periodo';

     SumaSaldo := 0.0;

     ActualizaRegistro( 0, 0 );

     I := ApplicationContainer.NroMesInicial;
     J := 1;
     repeat
       ActualizaRegistro( I, J );
       Inc( J );
       Inc( I );
       If   I=13
       then I := 1;
     until J=13;

     ActualizaRegistro( 13, 13 );
     ActualizaRegistro( 14, 14 );

     SaldosMemoryTable.IndexFieldNames := 'Indice';
end;

begin

     If   not FormManager.DataAreaFocused
     then Exit;

     ActualizaPanelEjercicio;

     ListaCuentas := TStringList.Create;
     SaldosMemoryTable.DisableControls;
     try

       EditSelector.ExtractList( ListaCuentas );

       If   ListaCuentas.Count=0
       then begin
            ShowNotification( ntStop, RsMsg1 );
            FormManager.SelectFirstKeyControl;
            Abort;
            end;

       SaldosMemoryTable.DeleteRecords;

       For I := 0 to ListaCuentas.Count - 1 do
         ActualizaSaldosEjercicio( Saldos.SaldoPeriodo( ListaCuentas.Strings[ I ],
                                                        DataCentroCoste.Value,
                                                        DataSeleccionCentroCoste.Value=0,
                                                        DataEjercicio.Value,
                                                        0,
                                                        14,
                                                        True ) );  // Saldos de apertura diferenciados (en el periodo 0 )

       For I := 0 to ListaCuentas.Count - 1 do
         ActualizaSaldosEjercicio( Saldos.SaldoPeriodo( ListaCuentas.Strings[ I ],
                                                        DataCentroCoste.Value,
                                                        DataSeleccionCentroCoste.Value=0,
                                                        DataEjercicio.Value - 1,
                                                        0,
                                                        14,
                                                        True ) );

       // Cálculo de las variaciones

       If   DataMostrarVariacion.Value
       then With SaldosMemoryTable do
              begin
              First;
              While not Eof do
                begin
                If   ( ( SaldosMemoryTableDebe1.Value<>0.0 ) or ( SaldosMemoryTableHaber1.Value<>0.0 ) )
                then begin
                     Edit;
                     If   SaldosMemoryTableSaldoPeriodo2.Value<>0.0
                     then begin
                           var Variacion := SaldosMemoryTableSaldoPeriodo1.Value - SaldosMemoryTableSaldoPeriodo2.Value;
                           var Porcentaje := Trunc( ( Variacion * 100 ) / SaldosMemoryTableSaldoPeriodo2.Value );
                           SaldosMemoryTableVariacionPeriodo.Value := Porcentaje;
                           end;

                     If   SaldosMemoryTableSaldo2.Value<>0.0
                     then begin
                           var Variacion := SaldosMemoryTableSaldo1.Value - SaldosMemoryTableSaldo2.Value;
                           var Porcentaje := Trunc( ( Variacion * 100 ) / SaldosMemoryTableSaldo2.Value );
                           SaldosMemoryTableVariacion.Value := Porcentaje;
                           end;
                     Post;
                     end;
                Next;
                end;

              end;

       SaldosMemoryDataSource.Enabled := True;

     finally
       ListaCuentas.Free;
       SaldosMemoryTable.EnableControls;
       SaldosMemoryTable.Locate( 'Periodo', MonthOf( ApplicationContainer.TodayDate ), [] );
       TableView.Controller.FocusedRowIndex := 0;  // Para que se vea la primera fila si la ventana es demasiado pequeña
       TableView.Controller.FocusedRowIndex := IndiceMes( MonthOf( ApplicationContainer.TodayDate ) );
       end;

end;

procedure TBrwSalForm.SeleccionCCCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     CentroCosteCtrl.Enabled := DataSeleccionCentroCoste.Value=1;
end;

procedure TBrwSalForm.SubcuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, False, False );
end;

procedure TBrwSalForm.SubcuentaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, False, False );
end;

procedure TBrwSalForm.TableViewVariacionGetDisplayText(     Sender  : TcxCustomGridTableItem;
                                                            ARecord : TcxCustomGridRecord;
                                                        var AText   : string );
begin
     var Value := TableView.DataController.Values[ ARecord.RecordIndex, Sender.Index ];
     If   VarIsNumeric( Value )
     then begin
          AText := IntToStr( Value ) + ' %';
          end;
end;

procedure TBrwSalForm.CaptionPanelResize(Sender: TObject);
begin
     EjercicioAnteriorButton.Left := EjercicioActualLabel.Left - 30;
     EjercicioPosteriorButton.Left := EjercicioActualLabel.Left + 40;
     MostrarVariacionCtrl.Left := EjercicioActualLabel.Left + 140;
end;

procedure TBrwSalForm.CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCentrosCoste( Sender );
end;

procedure TBrwSalForm.CentroCosteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwSalForm.CuentasTableViewCodigoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     var Descripcion := Cuenta.Valida( Sender, DisplayValue, ErrorText, Error, nil, False, False );
     If   not Error and CuentasTable.Editing
     then CuentasTableDescripcion.Value := Descripcion;
end;

procedure TBrwSalForm.EditSelectorEditModeChanged;
begin
     If   EditSelector.EditMode=tesSimple
     then FormManager.FirstKeyControl := CuentaCtrl
     else FormManager.FirstKeyControl := EditSelector.RelationButton;
end;

procedure TBrwSalForm.EjercicioActualCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaSaldos;
end;

procedure TBrwSalForm.EjercicioAnteriorButtonClick(Sender: TObject);
begin
     If   FormManager.DataAreaFocused
     then IncrementaEjercicio( -1 );
end;

procedure TBrwSalForm.EjercicioPosteriorButtonClick(Sender: TObject);
begin
     If   FormManager.DataAreaFocused
     then IncrementaEjercicio( 1 );
end;

procedure TBrwSalForm.IncrementaEjercicio( Increment : SmallInt );
begin
     DataEjercicio.Value := DataEjercicio.Value + Increment;
     ActualizaSaldos;
end;

procedure TBrwSalForm.FormManagerInitializeForm;

var   I,
      J   : SmallInt;

begin

     SeleccionCentroCosteCtrl.Enabled := DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value;
     CentroCosteCtrl.Enabled := DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value;

     SetColumnsDecimals( [ TableViewDebe1, TableViewHaber1, TableViewSaldoPeriodo1, TableViewSaldo1 ] );
     SetColumnsDecimals( [ TableViewDebe2, TableViewHaber2, TableViewSaldoPeriodo2, TableViewSaldo2 ] );

     TableViewNombrePeriodo.Styles.Content := ApplicationContainer.EditFixedColumnStyle;
     TableViewSeparator.Styles.Content := ApplicationContainer.EditFixedColumnStyle;

     SaldosMemoryTable.Database := SessionDataModule.InMemoryDatabase;
     SaldosMemoryTable.Open;

     DataSeleccionCentroCoste.Value := 0;
     DataEjercicio.Value := ApplicationContainer.Ejercicio;

     ActualizaPanelEjercicio;

end;

procedure TBrwSalForm.MostrarVariacionCtrlPropertiesChange(Sender: TObject);
begin
     // Si el cambio se hace en el evento OnPost no se actualizaría cuando el usuario guarda la configuración del campo MostrarVariación
     ActualizaSaldos;
     TableViewVariacionPeriodo.Visible := DataMostrarVariacion.Value;
     TableViewVariacion.Visible := DataMostrarVariacion.Value;
end;

procedure TBrwSalForm.ActualizaPanelEjercicio;
begin
     EjercicioActualLabel.Caption := IntToStr( DataEjercicio.Value  );
     EjercicioAnteriorLabel.Caption := IntToStr( DataEjercicio.Value - 1 );
end;

procedure TBrwSalForm.FormManagerGraphicRequest;
begin
      GraficoSaldos;
end;

end.


