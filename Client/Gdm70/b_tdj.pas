
unit b_tdj;

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
  cxLabel, cxGroupBox,

  AppManager,

  cxRadioGroup, cxCheckBox, cxIndexedComboBox, cxDurationEdit, cxSpinEdit,

  dmi_cla,

  Gim70Fields;


type

    TCambioTipoJornadaEvent = procedure( TipoJornada : TTipoJornada ) of object;

    TBoxTdjForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    MemData: TgxMemData;
    DataSource: TDataSource;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    TipoJornadaCtrl: TcxDBRadioGroup;
    MemDataTipoJornada: TSmallintField;
    PeriodosGroupBox: TcxGroupBox;
    TurnoActividad1Ctrl: TcxDBSpinEdit;
    DescTurnoActividad1: TcxLabel;
    TurnoActividad2Ctrl: TcxDBSpinEdit;
    DescTurnoActividad2Label: TcxLabel;
    TurnoActividad3Ctrl: TcxDBSpinEdit;
    DescTurnoActividad3Label: TcxLabel;
    TurnoActividad4Ctrl: TcxDBSpinEdit;
    DescTurnoActividad4Label: TcxLabel;
    cxLabel8: TcxLabel;
    TiempoExternoCtrl: TcxDBDurationEdit;
    cxGroupBox1: TcxGroupBox;
    CalendarioTable: TnxeTable;
    CalendarioDataSource: TDataSource;
    TurnosMemData: TgxMemData;
    TurnosMemDataTurno1: TSmallintField;
    TurnosMemDataTurno2: TSmallintField;
    TurnosMemDataTurno3: TSmallintField;
    TurnosMemDataTurno4: TSmallintField;
    TurnosMemDataTiempoExterno: TLongWordField;
    TurnosDataSource: TDataSource;
    TurnosMemDataTipoJornada: TSmallintField;
    TurnosMemDataFecha: TDateField;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure TipoJornadaCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure TurnoActividadCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure TurnoActividadCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure TurnoActividad1CtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    private

      CalendarioFields : TCalendarioFields;

      SeleccionJornada : Boolean;   // Indica que se utiliza el mantenimiento solo pra seleccionar un tipo de jornada de los disponibles

      procedure ConfiguraListaTiposJornada;

    protected
    class var
      Fecha : TDate;
      TipoJornada : TTipoJornada;
      ParametrosGenerales : Boolean;
      OnFijaTipoJornada : TCambioTipoJornadaEvent;

    public

    end;

var  BoxTdjForm : TBoxTdjForm = nil;

procedure FijaTipoJornada( Fecha               : TDate;
                           TipoJornada         : TTipoJornada;
                           ParametrosGenerales : Boolean;
                           OnFijaTipoJornada   : TCambioTipoJornadaEvent = nil );


implementation

uses   DateUtils,
       LibUtils,
       EnterpriseDataAccess,

       dm_tur,

       a_tur,

       cx_tur,

       b_msg;

{$R *.DFM}

procedure FijaTipoJornada( Fecha               : TDate;
                           TipoJornada         : TTipoJornada;
                           ParametrosGenerales : Boolean;
                           OnFijaTipoJornada   : TCambioTipoJornadaEvent = nil );
begin
     TBoxTdjForm.Fecha := Fecha;
     TBoxTdjForm.TipoJornada := TipoJornada;
     TBoxTdjForm.ParametrosGenerales := ParametrosGenerales;
     TBoxTdjForm.OnFijaTipoJornada := OnFijaTipoJornada;
     CreateEditForm( TBoxTdjForm, BoxTdjForm );
end;

procedure TBoxTdjForm.ConfiguraListaTiposJornada;
begin
     With CalendarioTable do
       For var I := 1 to 4 do
         begin
         TurnosMemData.Append;
         var Fecha := EncodeDate( I + 100, 1, 1 );
         If   FindKey( [ Fecha ] )
         then TurnosMemData.CopyFields( CalendarioTable )
         else begin
              TurnosMemDataFecha.Value := Fecha;
              TurnosMemDataTipoJornada.Value := I;
              end;
         TurnosMemData.Post;
         end;

end;
procedure TBoxTdjForm.FormManagerInitializeForm;

var  I : SmallInt;

procedure SetupTipoJornada( Especial : Boolean );
begin
     TipoJornadaCtrl.Properties.Items[ 0 ].Enabled := Especial;
     For var Index := 1 to 4 do
       TipoJornadaCtrl.Properties.Items[ Index ].Enabled := not Especial;
end;

begin

     CalendarioFields := TCalendarioFields.Create( CalendarioTable );

     SeleccionJornada :=  not ParametrosGenerales and ( TipoJornada<>edEspecial );

     try

       TurnosMemData.DisableControls;

       TurnosMemData.Open;

       If   ParametrosGenerales
       then begin
            ConfiguraListaTiposJornada;
            MemDataTipoJornada.Value := edJornadaCompleta;
            end
       else begin

            If   CalendarioTable.FindKey( [ Fecha ] )
            then TipoJornada := CalendarioFields.TipoJornada.Value;

            If   TipoJornada=edEspecial
            then begin
                 TurnosMemData.Append;
                 TurnosMemDataFecha.Value := Fecha;
                 If   CalendarioTable.FindKey( [ Fecha ] )
                 then TurnosMemData.CopyFields( CalendarioTable );
                 end
            else begin
                 ConfiguraListaTiposJornada;
                 SetGroupBoxEditControlsReadOnly( PeriodosGroupBox, True );
                 end;

            MemDataTipoJornada.Value := TipoJornada;

            Caption := StrFormatDate( Fecha, dfDetailed );

            SetupTipoJornada( MemDataTipoJornada.Value=edEspecial );

            end;

     finally
       TurnosMemData.EnableControls;
       end;

end;

procedure TBoxTdjForm.FormManagerOkButton;

var  I : SmallInt;

begin
      With CalendarioTable do
        begin
        Cancel;
        If   ParametrosGenerales
        then begin
             For I := 1 to 4 do
               If   TurnosMemData.Locate( 'TipoJornada', I , [] )
               then begin

                    //** 06/10/2020  La versión de 64bits no admite fechas por debajo del 1/1/100 (se utiliza una función del SO para la conversión)

                    If   FindKey( [ EncodeDate( I + 100, 1, 1 ) ] )
                    then Edit
                    else Append;
                    CalendarioTable.CopyFields( TurnosMemData );
                    Post;
                    end;
             end
        else begin

             If   FindKey( [ Fecha ] )
             then Edit
             else begin
                  Append;
                  CalendarioFields.Fecha.Value := Fecha;
                  end;

             If   not SeleccionJornada
             then CalendarioTable.CopyFields( TurnosMemData );

             CalendarioFields.TipoJornada.Value := MemDataTipoJornada.Value;

             Post;

             If   Assigned( OnFijaTipoJornada )
             then OnFijaTipoJornada( CalendarioFields.TipoJornada.Value );
             end;
       end;
end;


procedure TBoxTdjForm.TipoJornadaCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     PeriodosGroupBox.Enabled := ( MemDataTipoJornada.Value=0 ) or ParametrosGenerales;
     If   ParametrosGenerales or SeleccionJornada
     then begin
          If   TurnosMemData.State=dsEdit
          then TurnosMemData.Post;
          If   TurnosMemData.Locate( 'TipoJornada', MemDataTipoJornada.Value, [] )
          then begin
               TurnosMemData.Edit;
               FormManager.ValidateDataArea( faData, False );
               end;
          end;
end;

procedure TBoxTdjForm.TurnoActividadCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTurnos( Sender );
end;

procedure TBoxTdjForm.TurnoActividad1CtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Turno.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxTdjForm.TurnoActividadCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTurnos( [ Sender.EditingValue ] );
end;

end.

