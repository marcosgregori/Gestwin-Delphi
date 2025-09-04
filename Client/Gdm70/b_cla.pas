
unit b_cla;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, dxmdaset,
  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox, cxRadioGroup, cxCheckBox, cxIndexedComboBox, cxDurationEdit, cxSpinEdit,
  Vcl.Grids, WorkCalendar, dxGDIPlusClasses, cxImage, cxIntegerEdit, dxUIAClasses,

  AppManager,

  Gim70Fields,

  dmi_cla ;


type
    TBoxClaForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    MemData: TgxMemData;
    DataSource: TDataSource;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    CloseButton: TgBitBtn;
    CalendarioTable: TnxeTable;
    CalendarioDataSource: TDataSource;
    WorkCalendar: TWorkCalendar;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    cxImage1: TcxImage;
    cxLabel1: TcxLabel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    MesCtrl: TcxDBIndexedComboBox;
    cxLabel2: TcxLabel;
    cxButton3: TcxButton;
    cxButton4: TcxButton;
    EjercicioCtrl: TcxDBIntegerEdit;
    MemDataMes: TSmallintField;
    MemDataEjercicio: TSmallintField;
    cxGroupBox3: TcxGroupBox;
    cxLabel8: TcxLabel;
    gBitBtn1: TgBitBtn;
    gBitBtn2: TgBitBtn;
    gBitBtn3: TgBitBtn;
    gBitBtn4: TgBitBtn;
    gBitBtn5: TgBitBtn;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure WorkCalendarDblClick(Sender: TObject);
    procedure WorkCalendarDrawCell(ACanvas: TCanvas; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure gBitBtn1Click(Sender: TObject);
    procedure gBitBtn2Click(Sender: TObject);
    procedure gBitBtn3Click(Sender: TObject);
    procedure gBitBtn4Click(Sender: TObject);
    procedure gBitBtn5Click(Sender: TObject);
    procedure WorkCalendarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    private

      CalendarioFields : TCalendarioFields;

      CellDate : TDate;
      TipoDeJornada : TTipoJornada;

      function GetCellRecord( CellDate : TDate ) : Boolean;
      procedure UpdateCalendar;
      procedure CambiaTipoDeJornada( UnTipoDeJornada : TTipoJornada );
      procedure ExecuteProcess;

    protected

    public

    end;

var  BoxClaForm : TBoxClaForm = nil;

procedure CalendarioLaboral;


implementation

uses   DateUtils,
       LibUtils,
       EnterpriseDataAccess,

       dm_cla,
       dm_maq,
       dm_odf,

       b_tdj,

       b_msg,
       b_pro;

{$R *.DFM}

resourceString
       RsMsg1   = 'Existen tareas asignadas y pendientes de realizar en esta fecha.';
       RsMsg2   = 'Si modifica el tipo de jornada se tendrán que recalcular todas las asignaciones realizadas.';
       RsMsg3   = 'Sólo puede modificar el estado de los registros del ejercicio activo.';
       RsMsg4   = 'Cambie de ejercicio y repita la operación solicitada.';
       RsMsg5   = 'Solo puede modificar el tipo de jornada de fechas actuales o futuras.';
       RsMsg6   = '¿Está seguro de que desea cambiar el tipo de jornada en esta fecha?';

procedure CalendarioLaboral;
begin
     CreateEditForm( TBoxClaForm, BoxClaForm );
end;

procedure TBoxClaForm.FormManagerInitializeForm;
begin

     CalendarioFields := TCalendarioFields.Create( CalendarioTable );

     MemData.Open;
     MemDataMes.Value := MonthOf( ApplicationContainer.TodayDate );
     MemDataEjercicio.Value := YearOf( ApplicationContainer.TodayDate );

end;

procedure TBoxClaForm.UpdateCalendar;
begin
     WorkCalendar.Year := MemDataEjercicio.Value;
     WorkCalendar.Month := MemDataMes.Value;
end;

function TBoxClaForm.GetCellRecord( CellDate : TDate ) : Boolean;

var  Day : Byte;

begin
     If   CalendarioTable.FindKey( [ CellDate ] )
     then Result := True
     else begin
          CalendarioTable.Append;
          CalendarioFields.Fecha.Value := CellDate;
          CalendarioFields.TipoJornada.Value := Calendario.ObtenTipoJornadaDefecto( DayOfWeek( CellDate ) );
          CalendarioTable.Browse;
          Result := False;
          end;
end;

procedure TBoxClaForm.WorkCalendarDblClick(Sender: TObject);
begin

     If   WorkCalendar.Year<>ApplicationContainer.Ejercicio
     then begin
          ShowNotification( ntStop, RsMSg3, RsMsg4 );
          Exit;
          end
     else If   WorkCalendar.CalendarDate<ApplicationContainer.TodayDate
          then begin
               ShowNotification( ntStop, RsMSg5 );
               Exit;
               end;

     If   ShowNotification( ntQuestionWarning, RsMsg6, RsMsg2 )=mrYes
     then FijaTipoJornada( WorkCalendar.CalendarDate, edJornadaCompleta, False, CambiaTipoDeJornada );

end;

procedure TBoxClaForm.WorkCalendarDrawCell(ACanvas: TCanvas; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);

var  DayText :String;
     Day : SmallInt;
     CellDate : TDate;

begin

     If   ARow=0
     then Exit;

     try

       DayText := WorkCalendar.CellText[ ACol, ARow ];
       If   DayText=''
       then Exit;

       Day := StrToInt( DayText );

       CellDate := EncodeDate( WorkCalendar.Year, WorkCalendar.Month, Day );

       GetCellRecord( CellDate );

       With ACanvas, Rect do
         begin
         Font.Color := clWhite;
         Brush.Style := bsSolid;
         case CalendarioFields.TipoJornada.Value of
           edJornadaCompleta :
             begin
             Font.Color := clNavy;
             Brush.Color := clWhite;
             end;
           edMediaJornada :
             Brush.Color := clIconGreen;
           edJornadaIntensiva :
             Brush.Color := clIconBlue;
           edFestivo :
             Brush.Color := clIconRed;
           edEspecial :
             Brush.Color := clIconYellow;
           end;
         end;

     except
     end;

end;

procedure TBoxClaForm.WorkCalendarKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     If   Key=VK_SPACE
     then WorkCalendarDblClick( nil );
end;

procedure TBoxClaForm.cxButton1Click(Sender: TObject);
begin
     MemDataMes.Value := MemDataMes.Value - 1;
     If   MemDataMes.Value=0
     then begin
          MemDataMes.Value := 12;
          MemDataEjercicio.Value := MemDataEjercicio.Value - 1;
          end;
     UpdateCalendar;
end;

procedure TBoxClaForm.cxButton2Click(Sender: TObject);
begin
     MemDataMes.Value := MemDataMes.Value + 1;
     If   MemDataMes.Value=13
     then begin
          MemDataMes.Value := 1;
          MemDataEjercicio.Value := MemDataEjercicio.Value + 1;
          end;
     UpdateCalendar;
end;

procedure TBoxClaForm.cxButton3Click(Sender: TObject);
begin
     MemDataEjercicio.Value := MemDataEjercicio.Value - 1;
     UpdateCalendar;
end;

procedure TBoxClaForm.cxButton4Click(Sender: TObject);
begin
     MemDataEjercicio.Value := MemDataEjercicio.Value + 1;
     UpdateCalendar;
end;

procedure TBoxClaForm.FormManagerOkButton;
begin
     //..
end;

procedure TBoxClaForm.gBitBtn1Click(Sender: TObject);
begin
     CambiaTipoDeJornada( edJornadaCompleta );
end;

procedure TBoxClaForm.gBitBtn2Click(Sender: TObject);
begin
     CambiaTipoDeJornada( edMediaJornada );
end;

procedure TBoxClaForm.gBitBtn3Click(Sender: TObject);
begin
     CambiaTipoDeJornada( edJornadaIntensiva );
end;

procedure TBoxClaForm.gBitBtn4Click(Sender: TObject);
begin
     CambiaTipoDeJornada( edFestivo );
end;

procedure TBoxClaForm.gBitBtn5Click(Sender: TObject);
begin
     FijaTipoJornada( WorkCalendar.CalendarDate, edEspecial, False );
end;

procedure TBoxClaForm.CambiaTipoDeJornada( UnTipoDeJornada : TTipoJornada );

var  RecordExists : Boolean;
     Day, Month, Year : Word;
     TipoJornadaAnterior : TTipoJornada;

begin

     CellDate := WorkCalendar.CalendarDate;
     TipoDeJornada := UnTipoDeJornada;

     RecordExists := GetCellRecord( CellDate );

     If   not( CalendarioFields.TipoJornada.Value in [ edEspecial..edFestivo ] )
     then TipoJornadaAnterior := edJornadaCompleta
     else TipoJornadaAnterior := CalendarioFields.TipoJornada.Value;

     If   ( TipoJornadaAnterior<>TipoDeJornada ) and
            Maquina.HayTareasPendientes( CellDate )
     then If   ShowNotification( ntQuestionWarning, RsMsg1, RsMsg2 )<>mrYes
          then Exit;

     CreateProcessForm( ExecuteProcess, Caption );

end;

procedure TBoxClaForm.ExecuteProcess;
begin
     OrdenFabricacion.ReajustaTareas( CellDate, TipoDeJornada );
     WorkCalendar.Invalidate;
end;

end.

