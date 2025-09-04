unit dm_sch;

interface

uses
  Windows, Messages, SysUtils, Classes,
  DB,
  nxdb,

  DataManager,
  ServerDataModule,

  Gim00Fields;


type
  TSchedulerModule = class(TServerDataModule)
    DmPlanificadorTable: TnxeTable;
    DmRecursosPlanificadorTable: TnxeTable;
    DmPlanificadorAuxTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private
    DmPlanificadorFields : TPlanificadorFields;
    DmRecursosPlanificadorFields : TRecursosPlanificadorFields;
  public
    procedure CreaEvento( IDEvento : String; Inicio : TDateTime; Titulo, Mensaje : String );
    procedure BorraEvento( IDEvento : String );

  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses UITypes,
     LibUtils,
     DateUtils,

     AppManager,
     MainData,
     SessionData;

{$R *.dfm}

const omAllDayEvent = $0001;  // Options flag masks
      omEnabled     = $0002;
      omReminder    = $0004;
      omCollapsed   = $0008;
      omGroup       = $0010;

      tlsFree        = 0;     // Time line state
      tlsTentative   = 1;
      tlsBusy        = 2;
      tlsOutOfOffice = 3;

procedure TSchedulerModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmPlanificadorFields := TPlanificadorFields.Create( DmPlanificadorTable );
     DmRecursosPlanificadorFields := TRecursosPlanificadorFields.Create( DmRecursosPlanificadorTable );
end;

procedure TSchedulerModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm00.SchedulerModule := nil;
end;

procedure TSchedulerModule.CreaEvento( IDEvento : String;
                                       Inicio   : TDateTime;
                                       Titulo,
                                       Mensaje  : String );

var  Hour, Min, Sec, MSec : Word;
     FechaInicio,
     FechaFin : TDateTime;

begin
     BorraEvento( IDEvento );

     DecodeTime( SessionDataModule.WorkStart, Hour, Min, Sec, MSec );  // Obtengo la hora de inicio
     FechaInicio := RecodeTime( Inicio, Hour, Min, Sec, MSec );        // Se la añado a la fecha
     FechaFin := IncMinute( FechaInicio, 15 );

     try

       DmPlanificadorTable.Append;

       DmPlanificadorFields.IDRecurso.Value := SessionDataModule.CodigoUsuario;
       DmPlanificadorFields.IDEvento.Value := IDEvento;
       DmPlanificadorFields.Inicio.Value := FechaInicio;
       DmPlanificadorFields.InicioActual.Value := FechaInicio;
       DmPlanificadorFields.Final.Value := FechaFin;
       DmPlanificadorFields.FinalActual.Value := FechaFin;
       DmPlanificadorFields.Titulo.Value := Titulo;
       DmPlanificadorFields.TipoDeEvento.Value := 0;
       DmPlanificadorFields.ColorEtiqueta.Value := TColorRec.SysDefault;
       DmPlanificadorFields.Mensaje.Value := Mensaje;
       DmPlanificadorFields.Opciones.Value := omEnabled or omReminder;
       DmPlanificadorFields.IndiceRecurrencia.Value := -1;  // No hay recurrencia
       DmPlanificadorFields.FechaRecordatorio.Value := Inicio;
       DmPlanificadorFields.MinutosAntesEmpezarRecordatorio.Value := 15;
       DmPlanificadorFields.Estado.Value := tlsBusy;

       DmPlanificadorTable.Post;

     except
       DmPlanificadorTable.Cancel;
       raise;
       end;

end;

procedure TSchedulerModule.BorraEvento( IDEvento : String );
begin
     With DmPlanificadorAuxTable do
         If   FindKey( [ IDEvento ] )
         then Delete;
end;

end.
