unit b_com;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes, Vcl.Graphics, WinAPI.Windows,
  ExtCtrls,

  AppContainer,

  Grids, Menus, cxLookAndFeelPainters, cxGraphics, DB, nxdb,
  DataManager, cxMaskEdit, cxDropDownEdit, cxDBEdit, cxIndexedComboBox,
  cxCurrencyEdit, cxButtons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxLookAndFeels, dxSkinsCore, cxLabel, cxGroupBox, dxSkinsDefaultPainters,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  cxSpinEdit, cxDurationEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,

  LibUtils,
  Gim70Fields, dxDateRanges, AppForms, GridTableViewController, cxCalendar,
  dxmdaset, dxScrollbarAnnotations, cxTimeEdit, WorkCalendar,
  cxIntegerEdit, dxGDIPlusClasses, cxImage;

type
  TBoxComForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoMaquinaCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    CodigoCtrlCaption: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    SecuenciaAsignacionTable: TnxeTable;
    SecuenciaAsignacionDataSource: TDataSource;
    cxLabel1: TcxLabel;
    NroTurnoCtrl: TcxDBSpinEdit;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    SecuenciaAsignacionTableEjercicio: TSmallintField;
    SecuenciaAsignacionTableNroOrdenFabricacion: TIntegerField;
    SecuenciaAsignacionTableNroProceso: TSmallintField;
    SecuenciaAsignacionTableSegmento: TSmallintField;
    SecuenciaAsignacionTableCodigoMaquina: TWideStringField;
    SecuenciaAsignacionTableFecha: TDateField;
    SecuenciaAsignacionTableTurno: TSmallintField;
    SecuenciaAsignacionTableNroOrdenEntrada: TSmallintField;
    SecuenciaAsignacionTablePrioridad: TSmallintField;
    SecuenciaAsignacionTableTiempo: TLongWordField;
    SecuenciaAsignacionTableCantidad: TBCDField;
    SecuenciaAsignacionTableRealizado: TBooleanField;
    MemData: TgxMemData;
    MemDataSource: TDataSource;
    MemDataCodigoMaquina: TStringField;
    MemDataTurno: TSmallintField;
    OrdenFabricacionTable: TnxeTable;
    SecuenciaAsignacionTableCodigoArticulo: TStringField;
    SecuenciaAsignacionTableCodigoClaseA: TStringField;
    SecuenciaAsignacionTableCodigoClaseB: TStringField;
    SecuenciaAsignacionTableCodigoClaseC: TStringField;
    SecuenciaAsignacionTableDescripcionArticulo: TStringField;
    SecuenciaAsignacionTableHoraInicio: TTimeField;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    LeftCalendarPanel: TcxGroupBox;
    RightCalendarPanel: TcxGroupBox;
    LeftWorkCalendar: TWorkCalendar;
    RightWorkCalendar: TWorkCalendar;
    cxGroupBox7: TcxGroupBox;
    cxImage1: TcxImage;
    cxLabel2: TcxLabel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    MesCtrl: TcxDBIndexedComboBox;
    cxLabel5: TcxLabel;
    cxButton3: TcxButton;
    cxButton4: TcxButton;
    EjercicioCtrl: TcxDBIntegerEdit;
    LeftCalendarLabel: TcxLabel;
    RightCalendarLabel: TcxLabel;
    cxLabel8: TcxLabel;
    cxGroupBox5: TcxGroupBox;
    Shape2: TShape;
    Shape1: TShape;
    Shape3: TShape;
    Shape4: TShape;
    cxImage2: TcxImage;
    cxImage3: TcxImage;
    MemDataMes: TSmallintField;
    MemDataEjercicio: TSmallintField;
    Shape5: TShape;
    procedure FormManagerInitializeForm;
    procedure CodigoMaquinaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoMaquinaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoMaquinaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure NroTurnoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure NroTurnoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure NroTurnoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure FormManagerFocusedAreaChanged;
    procedure gxFormResize(Sender: TObject);
    procedure MesButtonClick(Sender: TObject);
    procedure EjercicioButtonClick(Sender: TObject);
    procedure LeftWorkCalendarDrawCell(ACanvas: TCanvas; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure RightWorkCalendarDrawCell(ACanvas: TCanvas; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure EjercicioCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure MesCtrlPropertiesEditValueChanged(Sender: TObject);
  private

    MaquinaFields : TMaquinaFields;
    OcupacionMaquinaFields : TOcupacionMaquinaFields;

    procedure UpdateCalendarsState;
    procedure ActualizaFechas;
    procedure DrawCell( WorkCalendar : TWorkCalendar; ACanvas : TCanvas; ACol, ARow : Integer; Rect : TRect; State : TGridDrawState );

  public
  end;

var
  BoxComForm: TBoxComForm = nil;

procedure CalendarioOcupacionMaquinas;

implementation

{$R *.DFM}

uses   System.SysUtils,
       System.DateUtils,

       Gdm70Dm,
       Gdm70Frm,

       b_msg,

       dm_maq,
       dm_tur,
       dm_cla,

       a_maq,
       a_tur,

       cx_maq,
       cx_tur;

procedure CalendarioOcupacionMaquinas;
begin
     CreateEditForm( TBoxComForm, BoxComForm, [], Gds70Frm.ProduccionSection );
end;

procedure TBoxComForm.CodigoMaquinaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntMaquinas( [ Sender.EditingValue ] );
end;

procedure TBoxComForm.CodigoMaquinaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMaquinas( Sender );
end;

procedure TBoxComForm.CodigoMaquinaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Maquina.Valida( Sender, DisplayValue, ErrorText, Error, False, MaquinaFields );
end;

procedure TBoxComForm.EjercicioButtonClick(Sender: TObject);
begin
     MemDataEjercicio.Value := MemDataEjercicio.Value + TComponent( Sender ).Tag;
end;

procedure TBoxComForm.EjercicioCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ActualizaFechas;
end;

procedure TBoxComForm.MesButtonClick(Sender: TObject);
begin

     MemDataMes.Value := MemDataMes.Value + TComponent( Sender ).Tag;
     If   MemDataMes.Value=0
     then begin
          MemDataMes.Value := 12;
          MemDataEjercicio.Value := MemDataEjercicio.Value - 1;
          end
     else If   MemDataMes.Value=13
          then begin
               MemDataMes.Value := 1;
               MemDataEjercicio.Value := MemDataEjercicio.Value + 1;
               end;

end;

procedure TBoxComForm.MesCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ActualizaFechas;
end;

procedure TBoxComForm.UpdateCalendarsState;
begin
     LeftWorkCalendar.Enabled := FormManager.DataAreaFocused;
     RightWorkCalendar.Enabled := FormManager.DataAreaFocused;
     LeftWorkCalendar.Invalidate;
     RightWorkCalendar.Invalidate;
end;

procedure TBoxComForm.FormManagerFocusedAreaChanged;
begin
     UpdateCalendarsState;
end;

procedure TBoxComForm.FormManagerInitializeForm;
begin
     MaquinaFields := TMaquinaFields.Create( Self );
     OcupacionMaquinaFields := TOcupacionMaquinaFields.Create( Self );

     MemDataMes.Value := MonthOf( ApplicationContainer.TodayDate );
     MemDataEjercicio.Value := YearOf( ApplicationContainer.TodayDate );

     UpdateCalendarsState;
end;

procedure TBoxComForm.gxFormResize(Sender: TObject);
begin
     LeftCalendarPanel.Width := Width div 2;
end;

procedure TBoxComForm.LeftWorkCalendarDrawCell(ACanvas: TCanvas; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
     DrawCell( LeftWorkCalendar, ACanvas, ACol, ARow, Rect, State );
end;

procedure TBoxComForm.RightWorkCalendarDrawCell(ACanvas: TCanvas; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
     DrawCell( RightWorkCalendar, ACanvas, ACol, ARow, Rect, State );
end;

procedure TBoxComForm.DrawCell( WorkCalendar : TWorkCalendar;
                                ACanvas      : TCanvas;
                                ACol,
                                ARow         : Integer;
                                Rect         : TRect;
                                State        : TGridDrawState );

var  DayText :String;
     Day : SmallInt;
     CellDate : TDate;
     Porcentaje : SmallInt;
     TiempoDisponibleTotal : TDuration;

begin

     With ACanvas do
       begin
       Font.Size := 10;
       Font.Color := clBlack;
       Font.Style := [];
       Brush.Color := clWhite;
       Brush.Style := bsSolid;
       end;

     If   not WorkCalendar.Enabled
     then begin
          ACanvas.Font.Color := clLightGray;
          Exit;
          end;

     If   ARow=0
     then begin
          ACanvas.Font.Style := [ fsBold ];
          Exit;
          end;

     If   ( MemDataCodigoMaquina.Value='' ) or
          ( MemDataTurno.Value=0 )
     then Exit;

     try

       DayText := WorkCalendar.CellText[ ACol, ARow ];
       If   DayText=''
       then Exit;

       Day := StrToInt( DayText );

       CellDate := EncodeDate( WorkCalendar.Year, WorkCalendar.Month, Day );

       Porcentaje := 0;
       TiempoDisponibleTotal := Calendario.ObtenDisponibilidadFecha( CellDate, MemDataTurno.Value ) * MaquinaFields.ProcesosSimultaneos.Value;
         If   TiempoDisponibleTotal>0
         then begin
              Maquina.ObtenRegistroOcupacion( Maquinafields.Codigo.Value, CellDate, MemDataTurno.Value, OcupacionMaquinaFields );
              Porcentaje := ( OcupacionMaquinaFields.Ocupado.Value * 100 ) div TiempoDisponibleTotal;
              end
         else Exit;

       // ACanvas.Font.Color := clMediumGray;

       case Porcentaje of
             0 :
           ;
         1..25 :
           ACanvas.Brush.Color := $00b5e8cc;
         26..50 :
           ACanvas.Brush.Color := $00adf9f7;
         51..75 :
           ACanvas.Brush.Color := $00a7a5ff;
         else
           ACanvas.Brush.Color := $007875FF;

         end;

     except
       end;

end;

procedure TBoxComForm.NroTurnoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTurnos( [ Sender.EditingValue ] );
end;

procedure TBoxComForm.NroTurnoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTurnos( Sender );
end;

procedure TBoxComForm.NroTurnoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Turno.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxComForm.ActualizaFechas;

var  Month,
     Year,
     NextYear,
     NextMonth : SmallInt;

begin

     Month := MemDataMes.Value;
     Year := MemDataEjercicio.Value;

     var LastDay := DaysInAMonth( Year, Month );
     If   LeftWorkCalendar.Day>LastDay
     then LeftWorkCalendar.Day := LastDay;
     LeftWorkCalendar.Month := Month;
     LeftWorkCalendar.Year := Year;

     NextYear := Year;
     NextMonth := Month;

     If   NextMonth=12
     then begin
          NextMonth := 1;
          Inc( NextYear );
          end
     else Inc( NextMonth );

     LastDay := DaysInAMonth( NextYear, NextMonth );
     If   RightWorkCalendar.Day>LastDay
     then RightWorkCalendar.Day := LastDay;
     RightWorkCalendar.Month := NextMonth;
     RightWorkCalendar.Year  := NextYear;

     LeftCalendarLabel.Caption := StrMonth( Month, False )     + ' / ' + StrInt( Year );
     RightCalendarLabel.Caption := StrMonth( NextMonth, False ) + ' / ' + StrInt( NextYear );

     LeftWorkCalendar.Invalidate;
     RightWorkCalendar.Invalidate;

end;

end.
