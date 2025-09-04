unit l_tpe;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,
  Mask,
  ReportManager, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  DataManager, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  cxGraphics, cxLookAndFeels, dxSkinsCore, cxLabel, cxGroupBox,
  dxSkinsDefaultPainters, cxMaskEdit, cxDropDownEdit, cxCalendar, cxSpinEdit,
  cxRadioGroup,
  nxdb,

  Gim30Fields,
  Gim70Fields;


type
    TRptTpeForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    MaquinaInicialCtrl: TcxDBTextEdit;
    MaquinaFinalCtrl: TcxDBTextEdit;
    FormManager: TgxFormManager;
    Report: TgxReportManager;
    Data: TgxMemData;
    DataMaquinaInicial: TWideStringField;
    DataMaquinaFinal: TWideStringField;
    DataSource: TDataSource;
    gxRangeBox1: TgxRangeBox;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    gxRangeBox2: TgxRangeBox;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    Label6: TcxLabel;
    gxRangeBox3: TgxRangeBox;
    TurnoInicialCtrl: TcxDBSpinEdit;
    TurnoFinalCtrl: TcxDBSpinEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    AgruparPorCtrl: TcxDBRadioGroup;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    DataTurnoInicial: TSmallintField;
    DataTurnoFinal: TSmallintField;
    DataAgruparPor: TSmallintField;
    SecuenciaAsignacionTable: TnxeTable;
    procedure CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure InitializeForm;
    procedure FormManagerOkButton;
    procedure TurnoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    private
    type

      TTareasPendientesFields = class( TnxeDatasetFields)
      public
        CodigoGrupo : TWideStringField;
        DescripcionGrupo : TWideStringField;
        NroPedido : TIntegerField;
        Fecha : TDateField;
        CodigoCliente,
        NombreCliente,
        CodigoArticulo,
        DescripcionArticulo,
        CodigoClaseA,
        CodigoClaseB,
        CodigoClaseC : TWideStringField;
        NroOrden : TIntegerField;
        NroProceso : TIntegerField;
        Turno : TSmallIntField;
        UnidadesAFabricar : TBCDField;
        Cantidad : TBCDField;
        Tiempo : TLongWordField;
        end;

      var
      TareasPendientesTable : TnxeTable;
      TareasPendientesFields : TTareasPendientesFields;

      SecuenciaAsignacionFields : TSecuenciaAsignacionFields;

      DsOrdenFabricacionFields : TOrdenFabricacionFields;
      DsMovimientoFields : TMovimientoFields;
      DsMaquinaFields : TMaquinaFields;

    public

    end;

var RptTpeForm: TRptTpeForm = nil;

procedure ListadoTareasPendientes;


implementation

uses   dmi_odf,

       dm_maq,
       dm_odf,
       dm_mov,
       dm_cli,
       dm_mat,
       dm_art,
       dm_fdc,
       dm_cls,

       cx_maq,
       cx_tur;

{$R *.DFM}

procedure ListadoTareasPendientes;
begin
     CreateReportForm( TRptTpeForm, RptTpeForm );
end;

procedure TRptTpeForm.InitializeForm;
begin

     SecuenciaAsignacionFields := TSecuenciaAsignacionFields.Create( SecuenciaAsignacionTable );

     DsOrdenFabricacionFields := TOrdenFabricacionFields.Create( Self );
     DsMovimientoFields := TMovimientoFields.Create( Self );
     DsMaquinaFields := TMaquinaFields.Create( Self );

     DataMaquinaInicial.Value := '';
     DataMaquinaFinal.Value := HighStrCode;
     DataFechaInicial.Value := ApplicationContainer.TodayDate;
     DataFechaFinal.Value := ApplicationContainer.LastDayOfYearDate;
     DataTurnoInicial.Value := 1;
     DataTurnoFinal.Value := 4;
     DataAgruparPor.Value := 0;
end;

procedure TRptTpeForm.TurnoCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaTurnos( Sender );
end;

procedure TRptTpeForm.CodigoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Maquina.Valida( Sender, DisplayValue, ErrorText, Error, True );
end;

procedure TRptTpeForm.FormManagerOkButton;

procedure SeleccionaRegistros;
begin
     With SecuenciaAsignacionTable do
       try

         // Fecha;Turno;CodigoMaquina;NroOrdenEntrada

         SetRange( [ DataFechaInicial.Value, DataTurnoInicial.Value, DataMaquinaInicial.value, 0 ],
                   [ DataFechaFinal.Value, DataTurnoFinal.Value, DataMaquinaFinal.Value, MaxSmallint ] );

         ApplicationContainer.StartProgression( RecordCount );
         First;
         While not Eof do
           begin
           If   not SecuenciaAsignacionFields.Realizado.Value and
                OrdenFabricacion.Obten( SecuenciaAsignacionFields.Ejercicio.Value, moOrden, SecuenciaAsignacionFields.NroOrdenFabricacion.Value, DsOrdenFabricacionFields )
           then begin
                TareasPendientesTable.Append;

                Maquina.Obten( SecuenciaAsignacionFields.CodigoMaquina.Value, DsMaquinaFields );

                If   DataAgruparPor.Value=0
                then begin
                     TareasPendientesFields.CodigoGrupo.Value := SecuenciaAsignacionFields.CodigoMaquina.Value;
                     TareasPendientesFields.DescripcionGrupo.Value := DsMaquinaFields.Descripcion.Value;
                     end
                else begin
                     TareasPendientesFields.CodigoGrupo.Value := DsMaquinaFields.CodigoMaquinaTipo.Value;
                     TareasPendientesFields.DescripcionGrupo.Value := MaquinaTipo.Descripcion( DsMaquinaFields.CodigoMaquinaTipo.Value );
                     end;

                TareasPendientesFields.NroPedido.Value := DsOrdenFabricacionFields.NroPedido.Value;

                If   ( DsOrdenFabricacionFields.NroPedido.Value<>0 ) and Movimiento.ObtenMovimiento( DsOrdenFabricacionFields.EjercicioPedido.Value, DsOrdenFabricacionFields.NroPedido.Value, DsMovimientoFields )
                then begin
                     // Solo si existe el pedido
                     TareasPendientesFields.CodigoCliente.Value := DsMovimientoFields.Propietario.Value;
                     TareasPendientesFields.NombreCliente.Value := Cliente.Descripcion( DsMovimientoFields.Propietario.Value );
                     end;

                TareasPendientesFields.Fecha.Value := SecuenciaAsignacionFields.Fecha.Value;
                TareasPendientesFields.CodigoArticulo.Value := DsOrdenFabricacionFields.CodigoArticulo.Value;
                TareasPendientesFields.DescripcionArticulo.Value := Articulo.Descripcion( DsOrdenFabricacionFields.CodigoArticulo.Value );
                TareasPendientesFields.CodigoClaseA.Value := DsOrdenFabricacionFields.CodigoClaseA.Value;
                TareasPendientesFields.CodigoClaseB.Value := DsOrdenFabricacionFields.CodigoClaseB.Value;
                TareasPendientesFields.CodigoClaseC.Value := DsOrdenFabricacionFields.CodigoClaseC.Value;
                TareasPendientesFields.NroOrden.Value := SecuenciaAsignacionFields.NroOrdenFabricacion.Value;
                TareasPendientesFields.NroProceso.Value := SecuenciaAsignacionFields.NroProceso.Value;
                TareasPendientesFields.Turno.Value := SecuenciaAsignacionFields.Turno.Value;
                TareasPendientesFields.UnidadesAFabricar.Value := DsOrdenFabricacionFields.UnidadesAFabricar.Value;
                TareasPendientesFields.Cantidad.Value := SecuenciaAsignacionFields.Cantidad.Value;
                TareasPendientesFields.Tiempo.Value := SecuenciaAsignacionFields.Tiempo.Value;

                TareasPendientesTable.Post;
                end;
           Next;
           end;
       finally
         ApplicationContainer.EndProgression;
         end;
end;

begin
      With Report do
       try
         Load;
         TareasPendientesTable := Report.CreateEmptyTable( 'TareasPendientes' );
         TareasPendientesFields := TTareasPendientesFields.Create( TareasPendientesTable );
         SeleccionaRegistros;
         FacturaCompras.FijaDecimalesInforme( Report );
         Clase.SetReportTitles( Report, 4 );
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

procedure TRptTpeForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMaquinas( Sender );
end;

end.
