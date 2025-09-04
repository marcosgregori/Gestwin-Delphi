{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           ExpressScheduler                                         }
{                                                                    }
{           Copyright (c) 2003-2025 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSSCHEDULER AND ALL ACCOMPANYING }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.              }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxSchedulerStrs;

{$I cxVer.inc}

interface

resourcestring
  scxUntitledEvent = 'Evento sin título';

  scxVertical   = 'Vertical';
  scxHorizontal = 'Horizontal';
  scxTimeGrid   = 'RejillaTemporal';

  scxMinute  = 'Minuto';
  scxMinutes = 'Minutos';
  scxHour    = 'Hora';
  scxHours   = 'Horas';
  scxOneDay  = 'Un día';

  // Navigation buttons
  scxNextAppointment = 'Próxima cita';
  scxPrevAppointment = 'Cita anterior'; 

  // dialogs constants
  scxDeleteRecurringEventDescription = 'es un evento recurrente. ¿Desea borrar solo esta ocurrencia o la serie entera?';
  scxEditRecurringEventDescription   = 'es un evento recurrente. ¿Desea editar solo esta ocurrencia o la serie entera?';

  scxGoToDateDialogCaption     = 'Ir a la fecha';
  scxDeleteTypeDialogCaption   = 'Confirmar borrado';
  scxDeleteTypeOccurrenceLabel = 'Borrar este evento';
  scxDeleteTypeSeriesLabel     = 'Borrar las series';
  scxEditTypeDialogCaption     = 'Abrir elemento recurrente';
  scxEditTypeOccurrenceLabel   = 'Abrir este evento';
  scxEditTypeSeriesLabel       = 'Abrir las series';

  scxExitConfirmation  = '¿Desea guardar los cambios?';
  scxDeleteConfirmation= 'El elemento ha cambiado. ¿Está seguro de que desea eliminarlo?';
  scxWrongTimeBounds   = 'La fecha final es anterior a la inicial.';
  scxWrongPattern      = 'La plantilla de recurrencia no es válida.';
  scxReplaceOccurrenceDate = 'Algunos meses tienen menos de %s dias. Para esos meses, el evento caerá en el último día del mes.';
  scxInvalidRecurrenceDuration = 'La duración del evento debe ser menor que la frecuencia con la que ocurre. ' +
    'Acorte la duración, o modifique la plantilla de recurrencia en la ventana de edición.';
  scxConfirmLostExceptions = 'Cualquier excepción asociada con este evento recurrente se perderá. ¿Está de acuerdo?';
  scxInvalidNumber      = 'Debe introducir un número válido.';
  scxShedulerEditorFormNotRegistered = 'No hay form de editor registrado';
  scxNoAvailableFreeTime = 'No hay tiempo libre disponible.';
  scxCannotRescheduleOccurrence = 'No se puede reasignar un acontecimiento de la cita recurrrente "%s" si éste salta sobre un acontecimiento posterior de la misma misma cita.';
  scxTwoOccurrencesPerDay = 'Dos acontecimientos de "%s" no pueden ocurrir el mismo día.';

  scxEvent             = 'Evento';
  scxUntitled          = 'Sin titulo';

  scxNoneEvent         = 'evento simple';
  scxRecurrenceEvent   = 'evento recurrente';
  scxExceptionEvent    = 'evento excepcional';
  scxOccurenceEvent    = 'evento ocasional';

  scxAdd               = '&Añadir';
  scxEdit              = '&Editar';
  scxDelete            = '&Suprimir';
  scxRecurrence        = '&Recurrencia';
  scxActionRecurrence  = 'Recurrencia';

  scxDate              = '&Fecha:';
  scxShowIn            = '&Mostrar en:';
  scxAgendaCalendar    = 'Agenda Calendar';
  scxDayCalendar       = 'Calendario diario';
  scxWeekCalendar      = 'Calendario semanal';
  scxMonthCalendar     = 'Calendario mensual';
  scxWorkWeekCalendar  = 'Calendario de semana laboral';

  scxContinueFrom      = 'Desde';
  scxContinueTo        = 'Hasta';
  scxEventsConflict    = 'Entra en conflicto con otro evento de la agenda.';
  scxResource          = 'Recurso';
  scxSubject           = '&Asunto:';
  scxLocation          = '&Lugar:';
  scxLabelAs           = 'Etiquetar como:';
  scxLabel             = '&Etiqueta:';
  scxStartTime         = '&Inicio:';
  scxEndTime           = '&Fin:';
  scxAllDayEvent       = 'E&vento diario';
  scxRecurrenceLabel   = 'Recurrencia:';

  scxReminder          = 'Recordar:';
  scxShowTimeAs        = 'Most&rar como:';
  scxShowAs            = 'Mostrar como:';

  scxSuffixMinute      = 'minuto';
  scxSuffixMinutes     = 'minutos';
  scxSuffixHour        = 'hora';
  scxSuffixHours       = 'horas';
  scxSuffixDay         = 'día';
  scxSuffixDays        = 'días';
  scxSuffixWeek        = 'semana';
  scxSuffixWeeks       = 'semanas';

  scxBusy              = 'Ocupado';
  scxFree              = 'Libre';
  scxTentative         = 'Tentativa';
  scxOutOfOffice       = 'Fuera del trabajo';

  scxRecurrenceCaption = 'Recurrencia del evento';
  scxRecurrenceHolidayCaption  = 'Recurrencia de fiesta';

  scxEventTime         = ' Hora del evento ';
  scxRecurrencePattern = ' Plantilla de recurrencia ';
  scxRangeOfRecurrence = ' Rango de recurrencia ';
  scxStart             = '&Inicio:';
  scxStart1            = 'I&nicio:';
  scxEnd               = '&Fin:';
  scxDuration          = 'D&uración:';
  // Pattern
  scxDaily             = '&Diariamente';
  scxWeekly            = '&Semanalmente';
  scxQuarterly         = '&Quincenalmente';
  scxMonthly           = '&Mensualmente';
  scxYearly            = '&Anualmente';
  // daily
  scxEvery             = '&Cada';
  scxEveryWeekDay      = 'Cada dia de la &semana';
  scxDays              = 'día(s)';
  // weekly
  scxWeeksOn           = 'semana(s) el:';
  scxRecurEvery        = 'Re&petir cada';
  //monthly
  scxOfEvery           = 'de cada';
  scxMonths            = 'mes(es)';
  // yearly
  scxThe               = 'E&l';
  scxOf                = 'de';

  // Modern Style Hint
  scxModernStyleHintStart        = 'Inicio:';
  scxModernStyleHintEnd          = 'Fin:';
  scxModernStyleHintLocation     = 'Lugar:';
  scxModernStyleHintReminder     = 'Recordatorio:';
  scxModernStyleHintResources     = 'Recursos:';
  scxModernStyleHintComplete     = 'Completo:';
  scxModernStyleHintReminderNone = 'Ninguno';


  // Task links
  scxTaskComplete                   = 'Tarea co&mpleta:';
  scxTaskStatus                     = 'Estado de la tarea';
  scxTaskDependencyEditorCaption    = 'Dependencia de la tarea';
  scxTaskWrongTimeBounds            = 'Debe introducirse una nueva fecha entre el periodo %s - %s.';
  scxFinishToFinishLong   = 'Final-a-Final (FF)';
  scxFinishToStartLong    = 'Final-a-Inicio (FI)';
  scxFrom                 = 'Desde:';
  scxStartToFinishLong    = 'Inicio-a-Final (IF)';
  scxStartToStartLong     = 'Inicio-a-Incio (II)';
  scxTo                   = 'Hasta:';
  scxType                 = '&Tipo:';

  // other
  scxFirst             = 'primer';
  scxSecond            = 'segundo';
  scxThird             = 'tercer';
  scxFourth            = 'cuarto';
  scxLast              = 'último';
  scxDay               = 'D&ía';
  scxDay1              = 'dia';
  scxWeekday           = 'dia de la semana';
  scxWeekendday        = 'dia de fin de semana';
  scxNoEndDate         = '&Sin fecha final';
  scxEndAfter          = 'Finalizar &tras:';
  scxEndBy             = 'Finalizar &el:';
  scxOccurences        = 'ocurrencias';

  // buttons
  scxAdd1              = 'Añadir';
  scxAdd1Hint          = 'Añadir (Ins)';
  scxEditDotted        = 'Editar...';
  scxApply             = '&Aplicar';
  scxFindAvailableTime = 'Encontrar tiempo disponible';
  scxOk                = '&Aceptar';
  scxSaveAndClose      = 'Guardar &y Cerrar';
  scxSaveAndCloseHint  = 'Guardar y cerrar';
  scxSave              = 'Guardar';
  scxCancel            = '&Cancelar';
  scxClose             = '&Cerrar';
  scxActionClose       = 'Cerrar';
  scxDown              = '&Abajo';
  scxDelete1           = 'Borrar';
  scxDelete1Hint       = 'Borrar (Supr)';
  scxEdit1             = 'Editar';
  scxImport            = '&Importar';
  scxExport            = '&Exportar';
  scxImportHint        = 'Importar';
  scxExportHint        = 'Exportar';
  scxRemoveRecur       = '&Quitar ocurrencia';
  scxSelectAll         = 'Seleccionar &todo';
  scxSelectNone        = 'No seleccionar &nada';
  scxUp                = '&Arriba';
  scxAppointment       = 'Cita';
  scxActions           = 'Acciones';
  scxOptions           = 'Opciones';
  //
  scxResourceLayoutCaption = 'Editor de recursos';

  // popup menu resources
  scxpmNewEvent          = '&Nuevo evento';
  scxpmNewAllDayEvent    = 'Nuevo &evento diario';
  scxpmNewRecurringEvent = 'Nuevo evento &recurrente';
  scxpmToday             = '&Hoy';
  scxpmGotoThisDay       = 'Ir a este &día';
  scxpmGoToDate          = 'Ir a la &fecha...';
  scxpmResourcesLayout   = 'Editor de recursos...';

  // for event
  scxpmOpen              = '&Abrir';
  scxpmEditSeries        = 'Editar Se&ries';
  scxpmShowTimeAs        = '&Mostrar como';
  scxpmDelete            = '&Borrar';
  scxpmFree              = '&Liberar';
  scxpmTentative         = '&Tentativa';
  scxpmBusy              = '&Ocupado';
  scxpmOutOfOffice       = '&Fuera del trabajo';
  scxpmLabel             = '&Etiqueta';

  // event label captions
  scxEventLabelNone      = 'Ninguna';
  scxEventLabel0         = 'Importante';
  scxEventLabel1         = 'Trabajo';
  scxEventLabel2         = 'Personal';
  scxEventLabel3         = 'Vacaciones';
  scxEventLabel4         = 'Debe atenderse';
  scxEventLabel5         = 'Viaje necesario';
  scxEventLabel6         = 'Necesita preparación';
  scxEventLabel7         = 'Cumpleaños';
  scxEventLabel8         = 'Aniversario';
  scxEventLabel9         = 'Llamar por telefono';

  // for time ruler menu items
  scxpmTimeZone          = 'Cambiar la zona &horaria';
  scxpm60Minutes         = '6&0 Minutos';
  scxpm30Minutes         = '&30 Minutos';
  scxpm15Minutes         = '&15 Minutos';
  scxpm10Minutes         = '10 &Minutos';
  scxpm6Minutes          = '&6 Minutos';
  scxpm5Minutes          = '&5 Minutos';

  // for year view scale menu items
  scxpmFullYear          = '&Año completo';
  scxpmHalfYear          = '&Medio año';
  scxpmQuarter           = '&Trimestre';

  // year view scales
  scxFullYear            = 'Año completo';
  scxHalfYear            = 'Medio año';
  scxQuarter             = 'Trimestre';
  scxHalfYearShort       = 'M';
  scxQuarterShort        = 'T';

  //navigator hints
  scxFirstButtonHint     = 'Primer recurso';
  scxPrevPageButtonHint  = 'Página anterior';
  scxPrevButtonHint      = 'Recurso anterior';
  scxNextButtonHint      = 'Próximo recurso';
  scxNextPageButtonHint  = 'Prxima página';
  scxLastButtonHint      = 'Último recurso';
  scxShowMoreResourcesButtonHint  = 'Mostrar más recursos';
  scxShowFewerResourcesButtonHint = 'Mostrar menos recursos';

  //for reminder
  scxrCaptionReminder  = '1 Recordatorio';
  scxrCaptionReminders = '%d Recordatorios';
  scxrDismissButton    = '&Olvidar';
  scxrDismissAllButton = 'Olvidar &todo';
  scxrDueIn            = 'Previsto';
  scxrOpenItemButton   = '&Abrir elemento';
  scxrSnoozeButton     = '&Recordar';
  scxrSubject          = 'Asunto';
  scxrSnoozeLabel      = '&Recordar';
  scxrSelected         = '%d recordatorios seleccionados';
  scxrStartTime        = 'Hora de inicio: %s';

  // time
  scxTime0m     = '0 minutos';
  scxTime5m     = '5 minutos';
  scxTime10m    = '10 minutos';
  scxTime15m    = '15 minutos';
  scxTime20m    = '20 minutos';
  scxTime30m    = '30 minutos';
  scxTime1h     = '1 hora';
  scxTime2h     = '2 horas';
  scxTime3h     = '3 horas';
  scxTime4h     = '4 horas';
  scxTime5h     = '5 horas';
  scxTime6h     = '6 hors';
  scxTime7h     = '7 hoars';
  scxTime8h     = '8 horas';
  scxTime9h     = '9 horas';
  scxTime10h    = '10 horas';
  scxTime11h    = '11 horas';
  scxTime12h    = '12 horas';
  scxTime18h    = '18 horas';
  scxTime1d     = '1 día';
  scxTime2d     = '2 días';
  scxTime3d     = '3 días';
  scxTime4d     = '4 días';
  scxTime1w     = '1 semana';
  scxTime2w     = '2 semanas';
  // advance time
  scxAdvance0h  = '0 horas antes del inicio';
  scxAdvance5m  = '5 minutos antes del inicio';
  scxAdvance10m = '10 minutos antes del inicio';
  scxAdvance15m = '15 minutos antes del inicio';

  // for export

  secxSetDateRangeCaption = 'Fijar el rango de fechas';
  secxSetDateRangeText = 'Exportar y crear ocurrencias individuales de citas o ' +
    'tareas que ocurran entre:';
  secxSetDateRangeAnd = 'y';
  secxTrue = 'CIERTO';
  secxFalse = 'FALSO';
  secxExportStorageInvalid = 'Almacenamiento no asignado';

  // card field names

  secxYes          = 'Sí';
  secxNo           = 'No';
  secxSubject      = 'Asunto';
  secxLocation     = 'Lugar';
  secxDescription  = 'Descripción';
  secxAllDay       = 'Todo el día';
  secxStart        = 'Inicio';
  secxFinish       = 'Fin';
  secxState        = 'Estado';
  secxReminder     = 'Recordatorio';
  secxTimeRange    = '%s a %s';

  // table fields

  secxStartDate          = 'FechaInicio';
  secxStartTime          = 'HoraInicio';
  secxEndDate            = 'FechaFin';
  secxEndTime            = 'HoraFin';
  secxAlldayevent        = 'EventoDiario';
  secxReminderonoff      = 'RecordatorioOnOff';
  secxReminderDate       = 'FechaRecordatorio';
  secxReminderTime       = 'HoraRecordatorio';
  secxCategories         = 'Categorias';
  secxShowtimeas         = 'MostrarHoraComo';

  // storage
  scxRequiredFieldsNeeded = 'Los siguientes campos necesarios'#13#10'%sno han sido asignados!';
  scxInvalidFieldName = 'Nombre de campo no válido';
  scxInvalidCustomField = 'Campo personalizado no válido';

  // Event fields
  scxAllDayEventField = 'Evento diario'; 
  scxIDField = 'ID';
  scxActualFinishField = 'Final actual';
  scxActualStartField = 'Inicio actual';
  scxCaptionField = 'Titulo';
  scxEmptyDayCaption = 'No hay eventos';
  scxEnabledField = 'Activado';
  scxEventTypeField = 'Tipo';
  scxFinishField = 'Final';
  scxLabelField = 'Etiqueta';
  scxLocationField = 'Lugar';
  scxMessageField = 'Mensaje';
  scxParentIDField = 'ID padre';
  scxGroupIDField = 'ID grupo';
  scxRecurrenceField = 'Estructura de recurrencia';
  scxRecurrenceIndexField = 'Índice de recurrencia';
  scxReminderDateField = 'Fecha a recordar';
  scxReminderField = 'Recordar';
  scxReminderMinutesBeforeStartField = 'Minutos a recordar antes del inicio';
  scxResourceField = 'Recurso';
  scxStartField = 'Inicio';
  scxStateField = 'Estado';
  scxTaskCompleteField = 'Tarea completa';
  scxTaskIndexField = 'Índice de tarea'; 
  scxTaskLinksField = 'Enlaces de tarea';
  scxTaskStatusField = 'Estado de tarea';

  // status  
  scxNotStarted = 'No iniciado';
  scxInProgress = 'En progreso';
  scxComplete   = 'Completo';
  scxWaiting    = 'Esperando';
  scxDeferred   = 'Pospuesto';

  // Event task relations

  scxFinishToStart  = 'Fin-a-Inicio';
  scxStartToStart   = 'Inicio-a-Inicio';
  scxFinishToFinish = 'Fin-a-Fin';
  scxStartToFinish  = 'Inicio-a-Fin ';

  scxFinishToStartShort  = 'FI';
  scxStartToStartShort   = 'II';
  scxFinishToFinishShort = 'FF';
  scxStartToFinishShort  = 'IF';

  scxGanttEventHint = 'Tarea: %s'#13#10'Completado: %d %%'#13#10'Inicio: %s'#13#10'Fin: %s';
  scxLinkHint = 'Enlace a tarea: %s (%s)'#13#10'Desde: %s'#13#10'Hasta: %s';

  //

  scxCompleteDisplayFormat = '0 %';

  scxNone      = 'Evento simple';
  scxPattern   = 'Plantilla recurrente';
  scxOccurrence= 'Ocurrencia simple';
  scxException = 'Ocurrencia de excepción';
  scxCustom    = 'Ocurrencia personalizada';

  // Holidays

  scxHolidaysEditorCaption                = 'Editor de fiestas';
  scxLocationsGroupBox                    = 'Lugares';
  scxHolidaysGroupBox                     = 'Fiestas';
  scxAddedHolidaysGroupBox                = 'Fiestas añadidas';
  scxLocationName                         = 'Nombre:';
  scxHolidaysLocationEditorCaption        = 'Editor de lugares';
  scxHolidayName                          = 'Nombre:';
  scxHolidayDate                          = 'Fecha:';
  scxHolidaysLocationHolidayEditorCaption = 'Editor de fiestas';
  scxOutlookFormatMismatch                = 'Formato de fiesta incorrecto';
  scxHolidayDisplayFormat                 = '%s (%s)';
  scxAddedHolidayDisplayFormat            = '%s - %s (%s)';

const
  sRangeNames: array[0..4] of Pointer =
    (@scxFirst, @scxSecond, @scxThird, @scxFourth, @scxLast);
  sDayNames: array [0..9] of string =
    (scxDay, scxWeekDay, scxWeekendDay, '', '', '', '', '', '', '');
  sEventLabelCaptions: array[0..10] of Pointer = (
    @scxEventLabelNone, @scxEventLabel0, @scxEventLabel1, @scxEventLabel2,
    @scxEventLabel3, @scxEventLabel4, @scxEventLabel5, @scxEventLabel6,
    @scxEventLabel7, @scxEventLabel8, @scxEventLabel9);
  sEventRelations: array[0..3] of Pointer = (
    @scxFinishToStart, @scxStartToStart, @scxFinishToFinish, @scxStartToFinish);
  sEventRelationsShort: array[0..3] of Pointer = (
    @scxFinishToStartShort, @scxStartToStartShort, @scxFinishToFinishShort,
    @scxStartToFinishShort);
  sEventTaskStatus: array[0..4] of Pointer = 
    (@scxNotStarted, @scxInProgress, @scxComplete, @scxWaiting, @scxDeferred);

procedure cxSchedulerInitStrings;

implementation

uses
  System.SysUtils, dxCore, cxFormats;

const
  dxThisUnitName = 'cxSchedulerStrs';

procedure cxSchedulerInitStrings;
var
  I: Integer;
begin
  for I := 1 to 7 do
    sDayNames[2 + I] := dxFormatSettings.LongDayNames[I];
end;

procedure AddcxSchedulerResourceStringNames(AProduct: TdxProductResourceStrings);

  procedure InternalAdd(const AResourceStringName: string; AAddress: Pointer);
  begin
    AProduct.Add(AResourceStringName, AAddress);
  end;

begin
  InternalAdd('scxUntitledEvent', @scxUntitledEvent);
  InternalAdd('scxVertical', @scxVertical);
  InternalAdd('scxHorizontal', @scxHorizontal);
  InternalAdd('scxTimeGrid', @scxTimeGrid);
  InternalAdd('scxMinute', @scxMinute);
  InternalAdd('scxMinutes', @scxMinutes);
  InternalAdd('scxHour', @scxHour);
  InternalAdd('scxHours', @scxHours);
  InternalAdd('scxOneDay', @scxOneDay);
  InternalAdd('scxNextAppointment', @scxNextAppointment);
  InternalAdd('scxPrevAppointment', @scxPrevAppointment);
  InternalAdd('scxDeleteRecurringEventDescription', @scxDeleteRecurringEventDescription);
  InternalAdd('scxEditRecurringEventDescription', @scxEditRecurringEventDescription);
  InternalAdd('scxGoToDateDialogCaption', @scxGoToDateDialogCaption);
  InternalAdd('scxDeleteTypeDialogCaption', @scxDeleteTypeDialogCaption);
  InternalAdd('scxDeleteTypeOccurrenceLabel', @scxDeleteTypeOccurrenceLabel);
  InternalAdd('scxDeleteTypeSeriesLabel', @scxDeleteTypeSeriesLabel);
  InternalAdd('scxEditTypeDialogCaption', @scxEditTypeDialogCaption);
  InternalAdd('scxEditTypeOccurrenceLabel', @scxEditTypeOccurrenceLabel);
  InternalAdd('scxEditTypeSeriesLabel', @scxEditTypeSeriesLabel);
  InternalAdd('scxExitConfirmation', @scxExitConfirmation);
  InternalAdd('scxDeleteConfirmation', @scxDeleteConfirmation);
  InternalAdd('scxWrongTimeBounds', @scxWrongTimeBounds);
  InternalAdd('scxWrongPattern', @scxWrongPattern);
  InternalAdd('scxReplaceOccurrenceDate', @scxReplaceOccurrenceDate);
  InternalAdd('scxInvalidRecurrenceDuration', @scxInvalidRecurrenceDuration);
  InternalAdd('scxConfirmLostExceptions', @scxConfirmLostExceptions);
  InternalAdd('scxInvalidNumber', @scxInvalidNumber);
  InternalAdd('scxShedulerEditorFormNotRegistered', @scxShedulerEditorFormNotRegistered); 
  InternalAdd('scxNoAvailableFreeTime', @scxNoAvailableFreeTime);
  InternalAdd('scxCannotRescheduleOccurrence', @scxCannotRescheduleOccurrence);
  InternalAdd('scxTwoOccurrencesPerDay', @scxTwoOccurrencesPerDay);
  InternalAdd('scxEvent', @scxEvent);
  InternalAdd('scxUntitled', @scxUntitled);
  InternalAdd('scxNoneEvent', @scxNoneEvent);
  InternalAdd('scxRecurrenceEvent', @scxRecurrenceEvent);
  InternalAdd('scxExceptionEvent', @scxExceptionEvent);
  InternalAdd('scxOccurenceEvent', @scxOccurenceEvent); 
  InternalAdd('scxAdd', @scxAdd);
  InternalAdd('scxEdit', @scxEdit);
  InternalAdd('scxDelete', @scxDelete);
  InternalAdd('scxRecurrence', @scxRecurrence);
  InternalAdd('scxActionRecurrence', @scxActionRecurrence);
  InternalAdd('scxDate', @scxDate);
  InternalAdd('scxShowIn', @scxShowIn);
  InternalAdd('scxAgendaCalendar', @scxAgendaCalendar);
  InternalAdd('scxDayCalendar', @scxDayCalendar);
  InternalAdd('scxWeekCalendar', @scxWeekCalendar);
  InternalAdd('scxMonthCalendar', @scxMonthCalendar);
  InternalAdd('scxWorkWeekCalendar', @scxWorkWeekCalendar);
  InternalAdd('scxEventsConflict', @scxEventsConflict);
  InternalAdd('scxResource', @scxResource);
  InternalAdd('scxSubject', @scxSubject);
  InternalAdd('scxLocation', @scxLocation);
  InternalAdd('scxLabelAs', @scxLabelAs);
  InternalAdd('scxLabel', @scxLabel);
  InternalAdd('scxStartTime', @scxStartTime);
  InternalAdd('scxEndTime', @scxEndTime);
  InternalAdd('scxAllDayEvent', @scxAllDayEvent);
  InternalAdd('scxRecurrenceLabel', @scxRecurrenceLabel);
  InternalAdd('scxReminder', @scxReminder);
  InternalAdd('scxShowTimeAs', @scxShowTimeAs);
  InternalAdd('scxShowAs', @scxShowAs);
  InternalAdd('scxSuffixMinute', @scxSuffixMinute);
  InternalAdd('scxSuffixMinutes', @scxSuffixMinutes);
  InternalAdd('scxSuffixHour', @scxSuffixHour);
  InternalAdd('scxSuffixHours', @scxSuffixHours);
  InternalAdd('scxSuffixDay', @scxSuffixDay);
  InternalAdd('scxSuffixDays', @scxSuffixDays);
  InternalAdd('scxSuffixWeek', @scxSuffixWeek);
  InternalAdd('scxSuffixWeeks', @scxSuffixWeeks);
  InternalAdd('scxBusy', @scxBusy);
  InternalAdd('scxFree', @scxFree);
  InternalAdd('scxTentative', @scxTentative);
  InternalAdd('scxOutOfOffice', @scxOutOfOffice);
  InternalAdd('scxRecurrenceCaption', @scxRecurrenceCaption);
  InternalAdd('scxRecurrenceHolidayCaption', @scxRecurrenceHolidayCaption);
  InternalAdd('scxEventTime', @scxEventTime);
  InternalAdd('scxRecurrencePattern', @scxRecurrencePattern);
  InternalAdd('scxRangeOfRecurrence', @scxRangeOfRecurrence);
  InternalAdd('scxContinueFrom', @scxContinueFrom);
  InternalAdd('scxContinueTo', @scxContinueTo);
  InternalAdd('scxStart', @scxStart);
  InternalAdd('scxStart1', @scxStart1);
  InternalAdd('scxEnd', @scxEnd);
  InternalAdd('scxDuration', @scxDuration);
  InternalAdd('scxDaily', @scxDaily);
  InternalAdd('scxWeekly', @scxWeekly);
  InternalAdd('scxQuarterly', @scxQuarterly);
  InternalAdd('scxMonthly', @scxMonthly);
  InternalAdd('scxYearly', @scxYearly);
  InternalAdd('scxEvery', @scxEvery);
  InternalAdd('scxEveryWeekDay', @scxEveryWeekDay);
  InternalAdd('scxDays', @scxDays);
  InternalAdd('scxWeeksOn', @scxWeeksOn);
  InternalAdd('scxRecurEvery', @scxRecurEvery);
  InternalAdd('scxOfEvery', @scxOfEvery);
  InternalAdd('scxMonths', @scxMonths);
  InternalAdd('scxThe', @scxThe);
  InternalAdd('scxOf', @scxOf);
  InternalAdd('scxModernStyleHintStart', @scxModernStyleHintStart);
  InternalAdd('scxModernStyleHintEnd', @scxModernStyleHintEnd);
  InternalAdd('scxModernStyleHintLocation', @scxModernStyleHintLocation);
  InternalAdd('scxModernStyleHintReminder', @scxModernStyleHintReminder);
  InternalAdd('scxModernStyleHintResources', @scxModernStyleHintResources);
  InternalAdd('scxModernStyleHintComplete', @scxModernStyleHintComplete);
  InternalAdd('scxModernStyleHintReminderNone', @scxModernStyleHintReminderNone);
  InternalAdd('scxTaskComplete', @scxTaskComplete);
  InternalAdd('scxTaskStatus', @scxTaskStatus);
  InternalAdd('scxTaskDependencyEditorCaption', @scxTaskDependencyEditorCaption);
  InternalAdd('scxTaskWrongTimeBounds', @scxTaskWrongTimeBounds);
  InternalAdd('scxFinishToFinishLong', @scxFinishToFinishLong);
  InternalAdd('scxFinishToStartLong', @scxFinishToStartLong);
  InternalAdd('scxFrom', @scxFrom);
  InternalAdd('scxStartToFinishLong', @scxStartToFinishLong);
  InternalAdd('scxStartToStartLong', @scxStartToStartLong);
  InternalAdd('scxTo', @scxTo);
  InternalAdd('scxType', @scxType);
  InternalAdd('scxFirst', @scxFirst);
  InternalAdd('scxSecond', @scxSecond);
  InternalAdd('scxThird', @scxThird);
  InternalAdd('scxFourth', @scxFourth);
  InternalAdd('scxLast', @scxLast);
  InternalAdd('scxDay', @scxDay);
  InternalAdd('scxDay1', @scxDay1);
  InternalAdd('scxWeekDay', @scxWeekDay);
  InternalAdd('scxWeekendDay', @scxWeekendDay);
  InternalAdd('scxNoEndDate', @scxNoEndDate);
  InternalAdd('scxEndAfter', @scxEndAfter);
  InternalAdd('scxEndBy', @scxEndBy);
  InternalAdd('scxOccurences', @scxOccurences); 
  InternalAdd('scxAdd1', @scxAdd1);
  InternalAdd('scxAdd1Hint', @scxAdd1Hint);
  InternalAdd('scxEditDotted', @scxEditDotted);
  InternalAdd('scxApply', @scxApply);
  InternalAdd('scxFindAvailableTime', @scxFindAvailableTime);
  InternalAdd('scxOk', @scxOk);
  InternalAdd('scxSaveAndClose', @scxSaveAndClose);
  InternalAdd('scxSaveAndCloseHint', @scxSaveAndCloseHint);
  InternalAdd('scxSave', @scxSave);
  InternalAdd('scxCancel', @scxCancel);
  InternalAdd('scxClose', @scxClose);
  InternalAdd('scxActionClose', @scxActionClose);
  InternalAdd('scxDown', @scxDown);
  InternalAdd('scxDelete1', @scxDelete1);
  InternalAdd('scxDelete1Hint', @scxDelete1Hint);
  InternalAdd('scxEdit1', @scxEdit1);
  InternalAdd('scxImport', @scxImport);
  InternalAdd('scxExport', @scxExport);
  InternalAdd('scxImportHint', @scxImportHint);
  InternalAdd('scxExportHint', @scxExportHint);
  InternalAdd('scxRemoveRecur', @scxRemoveRecur);
  InternalAdd('scxSelectAll', @scxSelectAll);
  InternalAdd('scxSelectNone', @scxSelectNone);
  InternalAdd('scxUp', @scxUp);
  InternalAdd('scxResourceLayoutCaption', @scxResourceLayoutCaption);
  InternalAdd('scxpmNewEvent', @scxpmNewEvent);
  InternalAdd('scxpmNewAllDayEvent', @scxpmNewAllDayEvent);
  InternalAdd('scxpmNewRecurringEvent', @scxpmNewRecurringEvent);
  InternalAdd('scxpmToday', @scxpmToday);
  InternalAdd('scxpmGotoThisDay', @scxpmGotoThisDay);
  InternalAdd('scxpmGoToDate', @scxpmGoToDate);
  InternalAdd('scxpmResourcesLayout', @scxpmResourcesLayout);
  InternalAdd('scxpmOpen', @scxpmOpen);
  InternalAdd('scxpmEditSeries', @scxpmEditSeries);
  InternalAdd('scxpmShowTimeAs', @scxpmShowTimeAs);
  InternalAdd('scxpmDelete', @scxpmDelete);
  InternalAdd('scxpmFree', @scxpmFree);
  InternalAdd('scxpmTentative', @scxpmTentative);
  InternalAdd('scxpmBusy', @scxpmBusy);
  InternalAdd('scxpmOutOfOffice', @scxpmOutOfOffice);
  InternalAdd('scxpmLabel', @scxpmLabel);
  InternalAdd('scxEventLabelNone', @scxEventLabelNone);
  InternalAdd('scxEventLabel0', @scxEventLabel0);
  InternalAdd('scxEventLabel1', @scxEventLabel1);
  InternalAdd('scxEventLabel2', @scxEventLabel2);
  InternalAdd('scxEventLabel3', @scxEventLabel3);
  InternalAdd('scxEventLabel4', @scxEventLabel4);
  InternalAdd('scxEventLabel5', @scxEventLabel5);
  InternalAdd('scxEventLabel6', @scxEventLabel6);
  InternalAdd('scxEventLabel7', @scxEventLabel7);
  InternalAdd('scxEventLabel8', @scxEventLabel8);
  InternalAdd('scxEventLabel9', @scxEventLabel9);
  InternalAdd('scxpmTimeZone', @scxpmTimeZone);
  InternalAdd('scxpm60Minutes', @scxpm60Minutes);
  InternalAdd('scxpm30Minutes', @scxpm30Minutes);
  InternalAdd('scxpm15Minutes', @scxpm15Minutes);
  InternalAdd('scxpm10Minutes', @scxpm10Minutes);
  InternalAdd('scxpm6Minutes', @scxpm6Minutes);
  InternalAdd('scxpm5Minutes', @scxpm5Minutes);
  InternalAdd('scxpmFullYear', @scxpmFullYear);
  InternalAdd('scxpmHalfYear', @scxpmHalfYear);
  InternalAdd('scxpmQuarter', @scxpmQuarter);
  InternalAdd('scxFullYear', @scxFullYear);
  InternalAdd('scxHalfYear', @scxHalfYear);
  InternalAdd('scxQuarter', @scxQuarter);
  InternalAdd('scxHalfYearShort', @scxHalfYearShort);
  InternalAdd('scxQuarterShort', @scxQuarterShort);
  InternalAdd('scxFirstButtonHint', @scxFirstButtonHint);
  InternalAdd('scxPrevPageButtonHint', @scxPrevPageButtonHint);
  InternalAdd('scxPrevButtonHint', @scxPrevButtonHint);
  InternalAdd('scxNextButtonHint', @scxNextButtonHint);
  InternalAdd('scxNextPageButtonHint', @scxNextPageButtonHint);
  InternalAdd('scxLastButtonHint', @scxLastButtonHint);
  InternalAdd('scxShowMoreResourcesButtonHint', @scxShowMoreResourcesButtonHint);
  InternalAdd('scxShowFewerResourcesButtonHint', @scxShowFewerResourcesButtonHint);
  InternalAdd('scxrCaptionReminder', @scxrCaptionReminder);
  InternalAdd('scxrCaptionReminders', @scxrCaptionReminders);
  InternalAdd('scxrDismissButton', @scxrDismissButton);
  InternalAdd('scxrDismissAllButton', @scxrDismissAllButton);
  InternalAdd('scxrDueIn', @scxrDueIn);
  InternalAdd('scxrOpenItemButton', @scxrOpenItemButton);
  InternalAdd('scxrSnoozeButton', @scxrSnoozeButton);
  InternalAdd('scxrSubject', @scxrSubject);
  InternalAdd('scxrSnoozeLabel', @scxrSnoozeLabel);
  InternalAdd('scxrSelected', @scxrSelected);
  InternalAdd('scxrStartTime', @scxrStartTime);
  InternalAdd('scxTime0m', @scxTime0m);
  InternalAdd('scxTime5m', @scxTime5m);
  InternalAdd('scxTime10m', @scxTime10m);
  InternalAdd('scxTime15m', @scxTime15m);
  InternalAdd('scxTime20m', @scxTime20m);
  InternalAdd('scxTime30m', @scxTime30m);
  InternalAdd('scxTime1h', @scxTime1h);
  InternalAdd('scxTime2h', @scxTime2h);
  InternalAdd('scxTime3h', @scxTime3h);
  InternalAdd('scxTime4h', @scxTime4h);
  InternalAdd('scxTime5h', @scxTime5h);
  InternalAdd('scxTime6h', @scxTime6h);
  InternalAdd('scxTime7h', @scxTime7h);
  InternalAdd('scxTime8h', @scxTime8h);
  InternalAdd('scxTime9h', @scxTime9h);
  InternalAdd('scxTime10h', @scxTime10h);
  InternalAdd('scxTime11h', @scxTime11h);
  InternalAdd('scxTime12h', @scxTime12h);
  InternalAdd('scxTime18h', @scxTime18h);
  InternalAdd('scxTime1d', @scxTime1d);
  InternalAdd('scxTime2d', @scxTime2d);
  InternalAdd('scxTime3d', @scxTime3d);
  InternalAdd('scxTime4d', @scxTime4d);
  InternalAdd('scxTime1w', @scxTime1w);
  InternalAdd('scxTime2w', @scxTime2w);
  InternalAdd('scxAdvance0h', @scxAdvance0h);
  InternalAdd('scxAdvance5m', @scxAdvance5m);
  InternalAdd('scxAdvance10m', @scxAdvance10m);
  InternalAdd('scxAdvance15m', @scxAdvance15m);
  InternalAdd('secxExportStorageInvalid', @secxExportStorageInvalid);
  InternalAdd('secxYes', @secxYes);
  InternalAdd('secxNo', @secxNo);
  InternalAdd('secxSubject', @secxSubject);
  InternalAdd('secxLocation', @secxLocation);
  InternalAdd('secxDescription', @secxDescription);
  InternalAdd('secxAllDay', @secxAllDay);
  InternalAdd('secxStart', @secxStart);
  InternalAdd('secxFinish', @secxFinish);
  InternalAdd('secxState', @secxState);
  InternalAdd('secxReminder', @secxReminder);
  InternalAdd('secxTimeRange', @secxTimeRange);
  InternalAdd('secxStartDate', @secxStartDate);
  InternalAdd('secxStartTime', @secxStartTime);
  InternalAdd('secxEndDate', @secxEndDate);
  InternalAdd('secxEndTime', @secxEndTime);
  InternalAdd('secxAllDayEvent', @secxAllDayEvent);
  InternalAdd('secxReminderOnOff', @secxReminderOnOff);
  InternalAdd('secxReminderDate', @secxReminderDate);
  InternalAdd('secxReminderTime', @secxReminderTime);

  InternalAdd('secxTrue', @secxTrue);
  InternalAdd('secxFalse', @secxFalse);
  InternalAdd('secxSetDateRangeCaption', @secxSetDateRangeCaption);
  InternalAdd('secxSetDateRangeText', @secxSetDateRangeText);
  InternalAdd('secxSetDateRangeAnd', @secxSetDateRangeAnd);

  InternalAdd('secxCategories', @secxCategories);
  InternalAdd('secxShowTimeAs', @secxShowTimeAs);
  InternalAdd('scxRequiredFieldsNeeded', @scxRequiredFieldsNeeded);
  InternalAdd('scxInvalidFieldName', @scxInvalidFieldName);
  InternalAdd('scxInvalidCustomField', @scxInvalidCustomField);
  InternalAdd('scxAllDayEventField', @scxAllDayEventField);
  InternalAdd('scxIDField', @scxIDField);
  InternalAdd('scxActualFinishField', @scxActualFinishField);
  InternalAdd('scxActualStartField', @scxActualStartField);
  InternalAdd('scxCaptionField', @scxCaptionField);
  InternalAdd('scxEmptyDayCaption', @scxEmptyDayCaption);
  InternalAdd('scxEnabledField', @scxEnabledField);
  InternalAdd('scxEventTypeField', @scxEventTypeField);
  InternalAdd('scxFinishField', @scxFinishField);
  InternalAdd('scxLabelField', @scxLabelField);
  InternalAdd('scxLocationField', @scxLocationField);
  InternalAdd('scxMessageField', @scxMessageField);
  InternalAdd('scxParentIDField', @scxParentIDField);
  InternalAdd('scxRecurrenceField', @scxRecurrenceField);
  InternalAdd('scxRecurrenceIndexField', @scxRecurrenceIndexField);
  InternalAdd('scxReminderDateField', @scxReminderDateField);
  InternalAdd('scxReminderField', @scxReminderField);
  InternalAdd('scxReminderMinutesBeforeStartField', @scxReminderMinutesBeforeStartField);
  InternalAdd('scxResourceField', @scxResourceField);
  InternalAdd('scxStartField', @scxStartField);
  InternalAdd('scxStateField', @scxStateField);
  InternalAdd('scxTaskCompleteField', @scxTaskCompleteField);
  InternalAdd('scxTaskIndexField', @scxTaskIndexField);
  InternalAdd('scxTaskLinksField', @scxTaskLinksField);
  InternalAdd('scxTaskStatusField', @scxTaskStatusField);
  InternalAdd('scxNotStarted', @scxNotStarted);
  InternalAdd('scxInProgress', @scxInProgress);
  InternalAdd('scxComplete', @scxComplete);
  InternalAdd('scxWaiting', @scxWaiting);
  InternalAdd('scxDeferred', @scxDeferred);
  InternalAdd('scxFinishToStart', @scxFinishToStart);
  InternalAdd('scxStartToStart', @scxStartToStart);
  InternalAdd('scxFinishToFinish', @scxFinishToFinish);
  InternalAdd('scxStartToFinish', @scxStartToFinish);
  InternalAdd('scxFinishToStartShort', @scxFinishToStartShort);
  InternalAdd('scxStartToStartShort', @scxStartToStartShort);
  InternalAdd('scxFinishToFinishShort', @scxFinishToFinishShort);
  InternalAdd('scxStartToFinishShort', @scxStartToFinishShort);
  InternalAdd('scxGanttEventHint', @scxGanttEventHint);
  InternalAdd('scxLinkHint', @scxLinkHint);
  InternalAdd('scxCompleteDisplayFormat', @scxCompleteDisplayFormat);
  InternalAdd('scxNone', @scxNone);
  InternalAdd('scxPattern', @scxPattern);
  InternalAdd('scxOccurrence', @scxOccurrence);
  InternalAdd('scxException', @scxException);
  InternalAdd('scxCustom', @scxCustom);
  InternalAdd('scxHolidaysEditorCaption', @scxHolidaysEditorCaption);
  InternalAdd('scxLocationsGroupBox', @scxLocationsGroupBox);
  InternalAdd('scxHolidaysGroupBox', @scxHolidaysGroupBox);
  InternalAdd('scxAddedHolidaysGroupBox', @scxAddedHolidaysGroupBox);
  InternalAdd('scxLocationName', @scxLocationName);
  InternalAdd('scxHolidaysLocationEditorCaption', @scxHolidaysLocationEditorCaption);
  InternalAdd('scxHolidayName', @scxHolidayName);
  InternalAdd('scxHolidayDate', @scxHolidayDate);
  InternalAdd('scxHolidaysLocationHolidayEditorCaption', @scxHolidaysLocationHolidayEditorCaption);
  InternalAdd('scxOutlookFormatMismatch', @scxOutlookFormatMismatch);
  InternalAdd('scxHolidayDisplayFormat', @scxHolidayDisplayFormat);
  InternalAdd('scxAddedHolidayDisplayFormat', @scxAddedHolidayDisplayFormat);
  InternalAdd('scxGroupIDField', @scxGroupIDField);
  InternalAdd('scxAppointment', @scxAppointment);
  InternalAdd('scxActions', @scxActions);
  InternalAdd('scxOptions', @scxOptions);
end;


initialization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  cxSchedulerInitStrings;
  dxResourceStringsRepository.RegisterProduct('ExpressScheduler', @AddcxSchedulerResourceStringNames);
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
finalization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.UnRegisterProduct('ExpressScheduler');
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
end.
