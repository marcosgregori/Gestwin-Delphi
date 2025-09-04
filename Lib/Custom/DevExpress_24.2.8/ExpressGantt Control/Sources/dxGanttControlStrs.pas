{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           ExpressGanttControl                                      }
{                                                                    }
{           Copyright (c) 2020-2025 Developer Express Inc.           }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSGANTTCONTROL AND ALL           }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
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

unit dxGanttControlStrs;

{$I cxVer.inc}
{$I dxGanttControl.inc}

interface

uses
  dxCore;

const
  dxGanttControlProductName = 'ExpressGanttControl';

resourcestring
  sdxGanttControlNoDataInfoText = '<No hay datos que mostrar>';

  sdxGanttControlStandardCalendarName = 'Est�ndar';
  sdxGanttControl24HoursCalendarName = '24 horas';
  sdxGanttControlNightCalendarName = 'Turno de noche';

  sdxGanttControlViewChartSheetColumnIndicatorCaption = 'Indicadores';
  sdxGanttControlViewChartSheetColumnIndicatorDescription = 'Indicadores que ayudan a comunicar informaci�n importante relacionada con la tarea.';
  sdxGanttControlViewChartSheetColumnTaskModeCaption = 'Modo de la tarea';
  sdxGanttControlViewChartSheetColumnTaskModeDescription = 'Puede programar una tarea manualmente o permitir al control que lo haga autom�ticamente.'#13#10#13#10 +
    'Tareas programas autom�ticamente: Debe especificar el inicio/fin y la duraci�n. El control no puede modificar esos valores pero le avisar� si los valores introducidos generar�n problemas potenciales en su proyectop.'#13#10#13#10 +
    'Tareas programadas autom�ticamente: El control calcula la fecha de inicio/fin y duraci�n bas�ndose en los cambios en su proyecto.';
  sdxGanttControlViewChartSheetColumnTaskNameCaption = 'Nombre de la tarea';
  sdxGanttControlViewChartSheetColumnTaskNameDescription = 'Nombre de la tarea.';
  sdxGanttControlViewChartSheetColumnTaskDurationCaption = 'Duraci�n';
  sdxGanttControlViewChartSheetColumnTaskDurationDescription = 'El lapso de tiempo total de trabajo necesario para completar la tarea.';
  sdxGanttControlViewChartSheetColumnTaskStartCaption = 'Inicio';
  sdxGanttControlViewChartSheetColumnTaskStartDescription = 'La fecha y hora de inicio programadas de la tarea.';
  sdxGanttControlViewChartSheetColumnTaskFinishCaption = 'Fin';
  sdxGanttControlViewChartSheetColumnTaskFinishDescription = 'La fecha y hora de finalizaci�n programadas de la tarea.';
  sdxGanttControlViewChartSheetColumnTaskPredecessorsCaption = 'Predecesores';
  sdxGanttControlViewChartSheetColumnTaskPredecessorsDescription = 'Numeros de identificaci�n (ID) de las tareas predecesoras. Los predecesores determinan si las tareas dependientes se pueden completar.';
  sdxGanttControlViewChartSheetColumnTaskResourceNameCaption = 'Nombre del recurso';
  sdxGanttControlViewChartSheetColumnTaskResourceNameDescription = 'Lista de recurso(s) asignados a una tarea.';
  sdxGanttControlViewChartSheetColumnPercentCompleteCaption = '% Completo';
  sdxGanttControlViewChartSheetColumnPercentCompleteDescription = 'Progreso de la tarea expresado como un porcentaje de la duraci�n completada de la tarea.';

  sdxGanttControlSheetExtendedAttributeCostColumnDescription = 'Un campo personalizado que almacena informaci�n sobre costes.';
  sdxGanttControlSheetExtendedAttributeDateColumnDescription = 'Un campo personalizado que almacena informaci�n sobre la fecha y hora.';
  sdxGanttControlSheetExtendedAttributeStartColumnDescription = 'Un campo personalizado que almacena informaci�n sobre la fecha y hora de inicio.';
  sdxGanttControlSheetExtendedAttributeFinishColumnDescription = 'Un campo personalizado que almacena informaci�n sobre la fecha y hora de finalizaci�n.';
  sdxGanttControlSheetExtendedAttributeFlagColumnDescription = 'Un campo personalizado que puede usar para indicar si est� marcado para una acci�n posterior o identificaci�n de alg�n tipo.';
  sdxGanttControlSheetExtendedAttributeDurationColumnDescription = 'Un campo personalizado que almacena informaci�n sobre la duraci�n.';
  sdxGanttControlSheetExtendedAttributeTextColumnDescription = 'Un campo personalizado que almacena un valor de texto.';
  sdxGanttControlSheetExtendedAttributeNumberColumnDescription = 'Un campo personalizado que almacena un valor num�rico.';

  sdxGanttControlViewResourceSheetColumnIndicatorCaption = 'Indicadores';
  sdxGanttControlViewResourceSheetColumnIndicatorDescription = '';
  sdxGanttControlViewResourceSheetColumnResourceNameCaption = 'Nombre del recurso';
  sdxGanttControlViewResourceSheetColumnResourceNameDescription = 'Un nombre del recurso.';
  sdxGanttControlViewResourceSheetColumnTypeCaption = 'Tipo';
  sdxGanttControlViewResourceSheetColumnTypeDescription = 'Especifica si el recurso est� relacionado con el trabajo, el material o el coste.'#13#10#13#10 +
    'Recurso de trabajo: personas y equipo.'#13#10'Recurso material: suministros consumibles.'#13#10'Recurso de costos: costos independientes necesarios para completar una tarea (por ejemplo, un billete de avi�n).';
  sdxGanttControlViewResourceSheetColumnGroupCaption = 'Grupo';
  sdxGanttControlViewResourceSheetColumnGroupDescription = 'El nombre del grupo al que pertenece un recurso.';
  sdxGanttControlViewResourceSheetColumnBaseCalendarCaption = 'Calendario base';
  sdxGanttControlViewResourceSheetColumnBaseCalendarDescription = 'Especifica el calendario base utilizado para el calendario de recursos. Los calendarios definen el tiempo de trabajo de los recursos.';

  sdxGanttControlViewTimelineStartText = 'Inicio';
  sdxGanttControlViewTimelineFinishText = 'Fin';

  sdxGanttControlResourceTypeWork = 'Trabajo';
  sdxGanttControlResourceTypeMaterial = 'Material';
  sdxGanttControlResourceTypeCost = 'Coste';

  sdxGanttControlTaskModeManuallyScheduled = 'Programado manualmente';
  sdxGanttControlTaskModeAutoScheduled = 'Auto-programado';

  sdxGanttControlViewChartThirdsOfMonthsCaptionBegin = 'B';
  sdxGanttControlViewChartThirdsOfMonthsCaptionMiddle = 'M';
  sdxGanttControlViewChartThirdsOfMonthsCaptionEnd = 'E';
  sdxGanttControlViewChartFirstQuarter = '1er trimestre';
  sdxGanttControlViewChartSecondQuarter = '2� trimestre';
  sdxGanttControlViewChartThirdQuarter = '3er trimestre';
  sdxGanttControlViewChartFourthQuarter = '4� trimestre';
  sdxGanttControlViewChartQuarters = 'T%d';
  sdxGanttControlViewChartHalfYears = 'S%d';

  sdxGanttControlTaskPredecessorLinkTypeFF = 'FF';
  sdxGanttControlTaskPredecessorLinkTypeFS = 'FS';
  sdxGanttControlTaskPredecessorLinkTypeSF = 'SF';
  sdxGanttControlTaskPredecessorLinkTypeSS = 'SS';

  sdxGanttControlDurationFormatElapsedTimePrefix = 'e';
  sdxGanttControlDurationFormatEstimatedTimePostfix = '?';
  sdxGanttControlDurationFormatMinuteExtraShort = 'm';
  sdxGanttControlDurationFormatMinute = 'minuto';
  sdxGanttControlDurationFormatMinutes = 'minutos';
  sdxGanttControlDurationFormatMinuteShort = 'min';
  sdxGanttControlDurationFormatMinutesShort = 'mins';
  sdxGanttControlDurationFormatHourExtraShort = 'h';
  sdxGanttControlDurationFormatHour = 'hora';
  sdxGanttControlDurationFormatHours = 'horas';
  sdxGanttControlDurationFormatHourShort = 'hr';
  sdxGanttControlDurationFormatHoursShort = 'hrs';
  sdxGanttControlDurationFormatDayExtraShort = 'd';
  sdxGanttControlDurationFormatDay = 'd�a';
  sdxGanttControlDurationFormatDays = 'd�as';
  sdxGanttControlDurationFormatWeekExtraShort = 'w';
  sdxGanttControlDurationFormatWeek = 'semana';
  sdxGanttControlDurationFormatWeeks = 'semana';
  sdxGanttControlDurationFormatWeekShort = 'se';
  sdxGanttControlDurationFormatWeeksShort = 'sms';
  sdxGanttControlDurationFormatMonthExtraShort = 'me';
  sdxGanttControlDurationFormatMonth = 'mes';
  sdxGanttControlDurationFormatMonths = 'meses';
  sdxGanttControlDurationFormatMonthShort = 'mes';
  sdxGanttControlDurationFormatMonthsShort = 'meses';

  sdxGanttControlTaskID = '(ID %d)';
  sdxGanttControlResourceID = '(ID %d)';

  sdxGanttControlTaskConstraintTypeALAP = 'Lo m�s tarde posible';
  sdxGanttControlTaskConstraintTypeASAP = 'Lo antes posible';
  sdxGanttControlTaskConstraintTypeFNET = 'No terminar antes de';
  sdxGanttControlTaskConstraintTypeFNLT = 'Terminar no m�s tarde de';
  sdxGanttControlTaskConstraintTypeMFO = 'Debe terminar en';
  sdxGanttControlTaskConstraintTypeMSO = 'Debe empezar';
  sdxGanttControlTaskConstraintTypeSNET = 'No empiezar antes de';
  sdxGanttControlTaskConstraintTypeSNLT = 'No empiezar m�s tarde de';

  sdxGanttControlConfirmationDeleteSummary = '''%s'' es una tarea resumida. Si lo elimina, tambi�n se eliminar�n todas sus subtareas. �Desea continuar?';
  sdxGanttControlConfirmationDeleteTask = '�Est� seguro de que desea eliminar la tarea ''% s''?';
  sdxGanttControlConfirmationDeleteResource = '�Est� seguro de que desea eliminar el recurso ''% s''?';
  sdxGanttControlConfirmationDeleteLink = '�Est�s segura de que desea eliminar el enlace?';

  sdxGanttControlTaskDependencyDialogCaption = 'Dependencia de la tarea';
  sdxGanttControlTaskDependencyDialogFrom = 'Desde:';
  sdxGanttControlTaskDependencyDialogTo = 'hasta:';
  sdxGanttControlTaskDependencyDialogLinkType = '&Tipo:';
  sdxGanttControlTaskDependencyDialogLinkTypeFS = 'Fin a inicio(FI)';
  sdxGanttControlTaskDependencyDialogLinkTypeSS = 'Incio a inicio (II)';
  sdxGanttControlTaskDependencyDialogLinkTypeFF = 'Fin a fin (FF)';
  sdxGanttControlTaskDependencyDialogLinkTypeSF = 'Inicio a fin (IF)';
  sdxGanttControlTaskDependencyDialogLinkTypeNone = '(Ninguno)';
  sdxGanttControlTaskDependencyDialogLag = '&Retraso:';

  sdxGanttControlTimelineTaskHintFinishCaption = 'Fin de tarea:';
  sdxGanttControlTimelineTaskHintCompleteCaption = '% completado:';
  sdxGanttControlTimelineTaskHintDurationCaption = 'Duraci�n:';
  sdxGanttControlTimelineTaskHintStartCaption = 'Incio de tarea:';

  sdxGanttControlTaskInformationDialogCaption = 'Informaci�n de la tarea';
  sdxGanttControlTaskInformationDialogSummaryCaption = 'Informaci�n resumida de la tarea';
  sdxGanttControlTaskInformationDialogGeneralTabCaption = 'General';
  sdxGanttControlTaskInformationDialogAdvancedTabCaption = 'Avanzado';
  sdxGanttControlTaskInformationDialogName = '&Nombre:';
  sdxGanttControlTaskInformationDialogDuration = '&Duraci�n:';
  sdxGanttControlTaskInformationDialogEstimated = '&Estimaci�n';
  sdxGanttControlTaskInformationDialogPercentComplete = '&Porcentaje completado:';
  sdxGanttControlTaskInformationDialogScheduleMode = '&Modo programado:';
  sdxGanttControlTaskInformationDialogManuallySchedule = 'Programado manualmente';
  sdxGanttControlTaskInformationDialogAutoSchedule = 'Auto programado';
  sdxGanttControlTaskInformationDialogDates = 'Fechas';
  sdxGanttControlTaskInformationDialogDateStart = '&Inicio:';
  sdxGanttControlTaskInformationDialogDateFinish = '&Fin:';
  sdxGanttControlTaskInformationDialogDisplayOnTimeline = 'Mostrar en &Cronolog�a';
  sdxGanttControlTaskInformationDialogConstrainTask = 'Restringir tarea';
  sdxGanttControlTaskInformationDialogConstraintType = 'Restringir ti&po:';
  sdxGanttControlTaskInformationDialogConstraintDate = 'Restringir &fecha:';
  sdxGanttControlTaskInformationDialogCalendar = 'C&alendario';

  sdxGanttControlRecurringTaskInformationDialogCaption = 'Informaci�n de tareas recurrentes';
  sdxGanttControlRecurringTaskInformationDialogTaskName = 'Nombre de la &tarea:';
  sdxGanttControlRecurringTaskInformationDialogTaskDuration = 'Durac&i�n:';
  sdxGanttControlRecurringTaskInformationDialogRecurrencePattern = 'Patr�n de recurrencia';
  sdxGanttControlRecurringTaskInformationDialogDaily = 'Diariamen&te';
  sdxGanttControlRecurringTaskInformationDialogWeekly = '&Semanalmente';
  sdxGanttControlRecurringTaskInformationDialogMonthly = '&Mensualmente';
  sdxGanttControlRecurringTaskInformationDialogYearly = '&Anualmente';
  sdxGanttControlRecurringTaskInformationDialogDailyEvery = 'Cada';
  sdxGanttControlRecurringTaskInformationDialogDailyEveryDays = 'D�a(s)';
  sdxGanttControlRecurringTaskInformationDialogDailyEveryWorkdays = 'D�a(s) laboral(es)';
  sdxGanttControlRecurringTaskInformationDialogWeeklyRecurEvery = 'Recurrir cada.';
  sdxGanttControlRecurringTaskInformationDialogWeeklyRecurWeeksOn = 'Semana(s) en:';
  sdxGanttControlRecurringTaskInformationDialogFirst = 'Primero';
  sdxGanttControlRecurringTaskInformationDialogSecond = 'Segundo';
  sdxGanttControlRecurringTaskInformationDialogThird = 'Tercero';
  sdxGanttControlRecurringTaskInformationDialogFourth = 'Cuarto';
  sdxGanttControlRecurringTaskInformationDialogLast = '�ltimo';
  sdxGanttControlRecurringTaskInformationDialogDay = 'D�a';
  sdxGanttControlRecurringTaskInformationDialogOfEvery = 'de cada';
  sdxGanttControlRecurringTaskInformationDialogMonths = 'Mes(es)';
  sdxGanttControlRecurringTaskInformationDialogThe = 'Ele';
  sdxGanttControlRecurringTaskInformationDialogOn = '&en';
  sdxGanttControlRecurringTaskInformationDialogOf = 'de';
  sdxGanttControlRecurringTaskInformationDialogRange = 'Rango de recurrencia';
  sdxGanttControlRecurringTaskInformationDialogRangeStart = '&Incio:';
  sdxGanttControlRecurringTaskInformationDialogRangeEndAfter = 'Finalizar despu�s:';
  sdxGanttControlRecurringTaskInformationDialogRangeEndAfterOccurrences = 'Occurrencia(s)';
  sdxGanttControlRecurringTaskInformationDialogRangeEndBy = 'Terminar &por:';
  sdxGanttControlRecurringTaskInformationDialogSchedulingCalendar = 'Calendario para programar esta tarea';
  sdxGanttControlRecurringTaskInformationDialogSchedulingCalendarName = 'Cale&ndario:';

  sdxGanttControlChooseDetailsDialogCaption = 'Elija detalles';
  sdxGanttControlChooseDetailsDialogDescription = 'Seleccione los detalles para mostrar para los elementos dentro de esta hoja.';
  sdxGanttControlChooseDetailsDialogDetails = 'Detalles:';
  sdxGanttControlChooseDetailsDialogColumnWidthDescription = 'Ancho de columna (en p�xeles):';

  sdxGanttControlDialogDelete = '&Suprimir';
  sdxGanttControlDialogOk = 'Aceptar';
  sdxGanttControlDialogCancel = 'Cancelar';
  sdxGanttControlCaptionNone = 'Ninguno';

  sdxGanttControlExceptionImageNotFound = 'Imagen no encontrada';
  sdxGanttControlExceptionInvalidDuration = '''%s'' es una duraci�n no v�lida';
  sdxGanttControlExceptionInvalidDurationFormat = 'Formato de duraci�n no v�lido';
  sdxGanttControlExceptionInvalidFileFormat = 'Formato de archivo inv�lido';
  sdxGanttControlExceptionUnsupportedFileFormat = 'El formato de archivo no es compatible';
  sdxGanttControlExceptionTasksAreAlreadyLinked = 'Estas tareas ya est�n vinculadas entre s�.';
  sdxGanttControlExceptionTasksAreAlreadyLinkedThroughAnotherTaskChain = 'No puede vincular estas tareas porque ya est�n vinculadas a trav�s de otra cadena de tareas.';
  sdxGanttControlExceptionTasksCannotBeLinkedTwice = 'No puede vincular una tarea predecesora a la misma tarea sucesora dos veces.';
  sdxGanttControlExceptionOutlineChangeWouldCreateCircularRelationship = 'Este cambio de esquema generar� una relaci�n circular. Para eliminar las relaciones il�gicas entre tareas individuales, verifique las dependencias de las tareas a las que est� indentadas e intentelo de nuevo.';
  sdxGanttControlExceptionCannotLinkSummaryTaskToItsSubtask = 'No puede vincular un resumen a su subtarea. Anule la indentaci�n de una subtarea al nivel de esquema de resumen y vuelva a intentarlo.';
  sdxGanttControlExceptionPositionChangeWouldCreateCircularRelationship = 'Este cambio de posici�n generar� una relaci�n circular. Para eliminar las relaciones il�gicas entre las tareas individuales, revise las dependencias de tareas asociadas y vuelva a intentarlo.';

  sdxGanttControlMessageInvalidDurationFormat = 'Formato de duraci�n no v�lido. Especifique una duraci�n utilizando la notaci�n de formato est�ndar (por ejemplo, 4 horas o 2 d�as).';
  sdxGanttControlMessageInvalidLagValue = 'Tiempo de retraso no v�lido.'#13#10 +
    'Para resolver el problema, pruebe lo siguiente:'#13#10 +
    '- Tiempo de retraso fijo: ingrese un formato de n�mero y duraci�n en el campo de retraso (por ejemplo, 5d o 5ed para el tiempo transcurrido).'#13#10 +
    '- Ingrese un valor porcentual (50% o 50e% para el porcentaje de tiempo transcurrido) para expresar el tiempo de retraso como un porcentaje de la duraci�n de la tarea de un predecesor.'#13#10 +
    '- Inserte "-" antes del valor de retraso para especificar un tiempo de espera.';
  sdxGanttControlMessageInvalidMeasurementUnit = 'El "% s" es una unidad de medida no v�lida.';
  sdxGanttControlMessageInvalidPercentageCompletedValue = 'Los valores de porcentaje completado (% completado) deben estar entre 0 y 100.';
  sdxGanttControlMessageInvalidSummaryTaskLink = 'Los predecesores de una tarea o de una tarea de resumen de proyecto insertada ' +
    'deben tener una dependencia de fin a principio o de principio a fin.'#13#10'Seleccione las tareas que desea vincular en una ' +
    'dependencia de fin a comienzo o de comienzo a comienzo y, a continuaci�n, haga clic en el bot�n ' +
    'Vincular tareas en la pesta�la de tareas. Las tareas de resumen seleccionadas tambi�n est�n vinculadas';
  sdxGanttControlMessageInvalidPredecessorInformation = 'Informaci�n de predecesor no v�lida.'#13#10 +
    'Para resolver este problema, pruebe lo siguiente:.'#13#10 +
    '- Introduzca solo n�meros enteros positivos para las relaciones entre tareas en el mismo proyecto.'#13#10 +
    '- Para incluir un tipo de dependencia y un tiempo de entrega, especifique el ID del predecesor, el tipo de dependencia, "+"  y tiempo de adelanto o retraso (por ejemplo, 2FS + 3d).';
  sdxGanttControlMessageInvalidWeekSchedule = 'Para programar una tarea recurrente, debe especificar uno o m�s d�as para el patr�n de recurrencia.'#13#10#13#10 +
    'Marque las casillas de verificaci�n correspondientes a la derecha del intervalo de recurrencia semanal para especificar los d�as utilizados para este patr�n de recurrencia.';
  sdxGanttControlMessageTwiceResourcesInformation = 'No puede asignar el mismo recurso a una tarea dos veces. Para asociar el mismo recurso con diferentes tareas, use el contorno de recursos.';

  sdxGanttControlTaskCompletedHint = 'Esta tarea se complet� el'#13#10'%s.';
  sdxGanttControlTaskHasConstraintHint = 'Esta tarea tiene una restricci�n ''% s'' en% s.';
  sdxGanttControlRecurringTaskHint = 'Esta tarea ocurre %d veces entre %s y %s.';


  sdxGanttControlCommandAddTaskToTimelineCaption = 'Agregar a la cronolog�a';
  sdxGanttControlCommandScrollToTaskCaption = 'Desplzarse hasta la tarea';
  sdxGanttControlCommandInsertTaskCaption = 'Insertar tarea';
  sdxGanttControlCommandInsertRecurringTaskCaption = 'Insert Recurring Task...';
  sdxGanttControlCommandDeleteTaskCaption = 'Delete Task';
  sdxGanttControlCommandDeleteTasksCaption = 'Delete Tasks';
  sdxGanttControlCommandInformationCaption = 'Information...';
  sdxGanttControlCommandGoToTaskCaption = 'Go to Task';
  sdxGanttControlCommandRemoveFromTimelineCaption = 'Remove from Timeline';
  sdxGanttControlCommandRenameColumnCaption = 'Rename Column';
  sdxGanttControlCommandWordWrapCaption = 'Word Wrap';
  sdxGanttControlCommandInsertColumnCaption = 'Insert Column';
  sdxGanttControlCommandShowChooseColumnDetailsDialogCaption = 'More...';
  sdxGanttControlCommandHideColumnCaption = 'Hide Column';
  sdxGanttControlCommandBestFitColumnCaption = 'Best Fit';
  sdxGanttControlCommandBestFitAllColumnsCaption = 'Best Fit (all columns)';

implementation

const
  dxThisUnitName = 'dxGanttControlStrs';

procedure AddGanttControlResourceStringNames(AProduct: TdxProductResourceStrings);
begin
  AProduct.Add('sdxGanttControlStandardCalendarName', @sdxGanttControlStandardCalendarName);
  AProduct.Add('sdxGanttControl24HoursCalendarName', @sdxGanttControl24HoursCalendarName);
  AProduct.Add('sdxGanttControlNightCalendarName', @sdxGanttControlNightCalendarName);

  AProduct.Add('sdxGanttControlViewChartSheetColumnIndicatorCaption', @sdxGanttControlViewChartSheetColumnIndicatorCaption);
  AProduct.Add('sdxGanttControlViewChartSheetColumnIndicatorDescription', @sdxGanttControlViewChartSheetColumnIndicatorDescription);
  AProduct.Add('sdxGanttControlViewChartSheetColumnTaskModeCaption', @sdxGanttControlViewChartSheetColumnTaskModeCaption);
  AProduct.Add('sdxGanttControlViewChartSheetColumnTaskModeDescription', @sdxGanttControlViewChartSheetColumnTaskModeDescription);
  AProduct.Add('sdxGanttControlViewChartSheetColumnTaskNameCaption', @sdxGanttControlViewChartSheetColumnTaskNameCaption);
  AProduct.Add('sdxGanttControlViewChartSheetColumnTaskNameDescription', @sdxGanttControlViewChartSheetColumnTaskNameDescription);
  AProduct.Add('sdxGanttControlViewChartSheetColumnTaskDurationCaption', @sdxGanttControlViewChartSheetColumnTaskDurationCaption);
  AProduct.Add('sdxGanttControlViewChartSheetColumnTaskDurationDescription', @sdxGanttControlViewChartSheetColumnTaskDurationDescription);
  AProduct.Add('sdxGanttControlViewChartSheetColumnTaskStartCaption', @sdxGanttControlViewChartSheetColumnTaskStartCaption);
  AProduct.Add('sdxGanttControlViewChartSheetColumnTaskStartDescription', @sdxGanttControlViewChartSheetColumnTaskStartDescription);
  AProduct.Add('sdxGanttControlViewChartSheetColumnTaskFinishCaption', @sdxGanttControlViewChartSheetColumnTaskFinishCaption);
  AProduct.Add('sdxGanttControlViewChartSheetColumnTaskFinishDescription', @sdxGanttControlViewChartSheetColumnTaskFinishDescription);
  AProduct.Add('sdxGanttControlViewChartSheetColumnTaskPredecessorsCaption', @sdxGanttControlViewChartSheetColumnTaskPredecessorsCaption);
  AProduct.Add('sdxGanttControlViewChartSheetColumnTaskPredecessorsDescription', @sdxGanttControlViewChartSheetColumnTaskPredecessorsDescription);
  AProduct.Add('sdxGanttControlViewChartSheetColumnTaskResourceNameCaption', @sdxGanttControlViewChartSheetColumnTaskResourceNameCaption);
  AProduct.Add('sdxGanttControlViewChartSheetColumnTaskResourceNameDescription', @sdxGanttControlViewChartSheetColumnTaskResourceNameDescription);
  AProduct.Add('sdxGanttControlViewChartSheetColumnPercentCompleteCaption', @sdxGanttControlViewChartSheetColumnPercentCompleteCaption);
  AProduct.Add('sdxGanttControlViewChartSheetColumnPercentCompleteDescription', @sdxGanttControlViewChartSheetColumnPercentCompleteDescription);

  AProduct.Add('sdxGanttControlViewResourceSheetColumnIndicatorCaption', @sdxGanttControlViewResourceSheetColumnIndicatorCaption);
  AProduct.Add('sdxGanttControlViewResourceSheetColumnIndicatorDescription', @sdxGanttControlViewResourceSheetColumnIndicatorDescription);
  AProduct.Add('sdxGanttControlViewResourceSheetColumnResourceNameCaption', @sdxGanttControlViewResourceSheetColumnResourceNameCaption);
  AProduct.Add('sdxGanttControlViewResourceSheetColumnResourceNameDescription', @sdxGanttControlViewResourceSheetColumnResourceNameDescription);
  AProduct.Add('sdxGanttControlViewResourceSheetColumnTypeCaption', @sdxGanttControlViewResourceSheetColumnTypeCaption);
  AProduct.Add('sdxGanttControlViewResourceSheetColumnTypeDescription', @sdxGanttControlViewResourceSheetColumnTypeDescription);
  AProduct.Add('sdxGanttControlViewResourceSheetColumnGroupCaption', @sdxGanttControlViewResourceSheetColumnGroupCaption);
  AProduct.Add('sdxGanttControlViewResourceSheetColumnGroupDescription', @sdxGanttControlViewResourceSheetColumnGroupDescription);
  AProduct.Add('sdxGanttControlViewResourceSheetColumnBaseCalendarCaption', @sdxGanttControlViewResourceSheetColumnBaseCalendarCaption);
  AProduct.Add('sdxGanttControlViewResourceSheetColumnBaseCalendarDescription', @sdxGanttControlViewResourceSheetColumnBaseCalendarDescription);

  AProduct.Add('sdxGanttControlViewTimelineStartText', @sdxGanttControlViewTimelineStartText);
  AProduct.Add('sdxGanttControlViewTimelineFinishText', @sdxGanttControlViewTimelineFinishText);

  AProduct.Add('sdxGanttControlResourceTypeWork', @sdxGanttControlResourceTypeWork);
  AProduct.Add('sdxGanttControlResourceTypeMaterial', @sdxGanttControlResourceTypeMaterial);
  AProduct.Add('sdxGanttControlResourceTypeCost', @sdxGanttControlResourceTypeCost);

  AProduct.Add('sdxGanttControlTaskModeManuallyScheduled', @sdxGanttControlTaskModeManuallyScheduled);
  AProduct.Add('sdxGanttControlTaskModeAutoScheduled', @sdxGanttControlTaskModeAutoScheduled);

  AProduct.Add('sdxGanttControlViewChartThirdsOfMonthsCaptionBegin', @sdxGanttControlViewChartThirdsOfMonthsCaptionBegin);
  AProduct.Add('sdxGanttControlViewChartThirdsOfMonthsCaptionMiddle', @sdxGanttControlViewChartThirdsOfMonthsCaptionMiddle);
  AProduct.Add('sdxGanttControlViewChartThirdsOfMonthsCaptionEnd', @sdxGanttControlViewChartThirdsOfMonthsCaptionEnd);
  AProduct.Add('sdxGanttControlViewChartFirstQuarter', @sdxGanttControlViewChartFirstQuarter);
  AProduct.Add('sdxGanttControlViewChartSecondQuarter', @sdxGanttControlViewChartSecondQuarter);
  AProduct.Add('sdxGanttControlViewChartThirdQuarter', @sdxGanttControlViewChartThirdQuarter);
  AProduct.Add('sdxGanttControlViewChartFourthQuarter', @sdxGanttControlViewChartFourthQuarter);
  AProduct.Add('sdxGanttControlViewChartQuarters', @sdxGanttControlViewChartQuarters);
  AProduct.Add('sdxGanttControlViewChartHalfYears', @sdxGanttControlViewChartHalfYears);

  AProduct.Add('sdxGanttControlTaskPredecessorLinkTypeFF', @sdxGanttControlTaskPredecessorLinkTypeFF);
  AProduct.Add('sdxGanttControlTaskPredecessorLinkTypeFS', @sdxGanttControlTaskPredecessorLinkTypeFS);
  AProduct.Add('sdxGanttControlTaskPredecessorLinkTypeSF', @sdxGanttControlTaskPredecessorLinkTypeSF);
  AProduct.Add('sdxGanttControlTaskPredecessorLinkTypeSS', @sdxGanttControlTaskPredecessorLinkTypeSS);

  AProduct.Add('sdxGanttControlDurationFormatElapsedTimePrefix', @sdxGanttControlDurationFormatElapsedTimePrefix);
  AProduct.Add('sdxGanttControlDurationFormatEstimatedTimePostfix', @sdxGanttControlDurationFormatEstimatedTimePostfix);
  AProduct.Add('sdxGanttControlDurationFormatMinuteExtraShort', @sdxGanttControlDurationFormatMinuteExtraShort);
  AProduct.Add('sdxGanttControlDurationFormatMinute', @sdxGanttControlDurationFormatMinute);
  AProduct.Add('sdxGanttControlDurationFormatMinutes', @sdxGanttControlDurationFormatMinutes);
  AProduct.Add('sdxGanttControlDurationFormatMinuteShort', @sdxGanttControlDurationFormatMinuteShort);
  AProduct.Add('sdxGanttControlDurationFormatMinutesShort', @sdxGanttControlDurationFormatMinutesShort);
  AProduct.Add('sdxGanttControlDurationFormatHourExtraShort', @sdxGanttControlDurationFormatHourExtraShort);
  AProduct.Add('sdxGanttControlDurationFormatHour', @sdxGanttControlDurationFormatHour);
  AProduct.Add('sdxGanttControlDurationFormatHours', @sdxGanttControlDurationFormatHours);
  AProduct.Add('sdxGanttControlDurationFormatHourShort', @sdxGanttControlDurationFormatHourShort);
  AProduct.Add('sdxGanttControlDurationFormatHoursShort', @sdxGanttControlDurationFormatHoursShort);
  AProduct.Add('sdxGanttControlDurationFormatDayExtraShort', @sdxGanttControlDurationFormatDayExtraShort);
  AProduct.Add('sdxGanttControlDurationFormatDay', @sdxGanttControlDurationFormatDay);
  AProduct.Add('sdxGanttControlDurationFormatDays', @sdxGanttControlDurationFormatDays);
  AProduct.Add('sdxGanttControlDurationFormatWeekExtraShort', @sdxGanttControlDurationFormatWeekExtraShort);
  AProduct.Add('sdxGanttControlDurationFormatWeek', @sdxGanttControlDurationFormatWeek);
  AProduct.Add('sdxGanttControlDurationFormatWeeks', @sdxGanttControlDurationFormatWeeks);
  AProduct.Add('sdxGanttControlDurationFormatWeekShort', @sdxGanttControlDurationFormatWeekShort);
  AProduct.Add('sdxGanttControlDurationFormatWeeksShort', @sdxGanttControlDurationFormatWeeksShort);
  AProduct.Add('sdxGanttControlDurationFormatMonthExtraShort', @sdxGanttControlDurationFormatMonthExtraShort);
  AProduct.Add('sdxGanttControlDurationFormatMonth', @sdxGanttControlDurationFormatMonth);
  AProduct.Add('sdxGanttControlDurationFormatMonths', @sdxGanttControlDurationFormatMonths);
  AProduct.Add('sdxGanttControlDurationFormatMonthShort', @sdxGanttControlDurationFormatMonthShort);
  AProduct.Add('sdxGanttControlDurationFormatMonthsShort', @sdxGanttControlDurationFormatMonthsShort);

  AProduct.Add('sdxGanttControlTaskID', @sdxGanttControlTaskID);
  AProduct.Add('sdxGanttControlResourceID', @sdxGanttControlResourceID);

  AProduct.Add('sdxGanttControlTaskConstraintTypeALAP', @sdxGanttControlTaskConstraintTypeALAP);
  AProduct.Add('sdxGanttControlTaskConstraintTypeASAP', @sdxGanttControlTaskConstraintTypeASAP);
  AProduct.Add('sdxGanttControlTaskConstraintTypeFNET', @sdxGanttControlTaskConstraintTypeFNET);
  AProduct.Add('sdxGanttControlTaskConstraintTypeFNLT', @sdxGanttControlTaskConstraintTypeFNLT);
  AProduct.Add('sdxGanttControlTaskConstraintTypeMFO', @sdxGanttControlTaskConstraintTypeMFO);
  AProduct.Add('sdxGanttControlTaskConstraintTypeMSO', @sdxGanttControlTaskConstraintTypeMSO);
  AProduct.Add('sdxGanttControlTaskConstraintTypeSNET', @sdxGanttControlTaskConstraintTypeSNET);
  AProduct.Add('sdxGanttControlTaskConstraintTypeSNLT', @sdxGanttControlTaskConstraintTypeSNLT);

  AProduct.Add('sdxGanttControlConfirmationDeleteSummary', @sdxGanttControlConfirmationDeleteSummary);
  AProduct.Add('sdxGanttControlConfirmationDeleteTask', @sdxGanttControlConfirmationDeleteTask);
  AProduct.Add('sdxGanttControlConfirmationDeleteResource', @sdxGanttControlConfirmationDeleteResource);
  AProduct.Add('sdxGanttControlConfirmationDeleteLink', @sdxGanttControlConfirmationDeleteLink);

  AProduct.Add('sdxGanttControlTaskDependencyDialogCaption', @sdxGanttControlTaskDependencyDialogCaption);
  AProduct.Add('sdxGanttControlTaskDependencyDialogFrom', @sdxGanttControlTaskDependencyDialogFrom);
  AProduct.Add('sdxGanttControlTaskDependencyDialogTo', @sdxGanttControlTaskDependencyDialogTo);
  AProduct.Add('sdxGanttControlTaskDependencyDialogLinkType', @sdxGanttControlTaskDependencyDialogLinkType);
  AProduct.Add('sdxGanttControlTaskDependencyDialogLinkTypeFS', @sdxGanttControlTaskDependencyDialogLinkTypeFS);
  AProduct.Add('sdxGanttControlTaskDependencyDialogLinkTypeSS', @sdxGanttControlTaskDependencyDialogLinkTypeSS);
  AProduct.Add('sdxGanttControlTaskDependencyDialogLinkTypeFF', @sdxGanttControlTaskDependencyDialogLinkTypeFF);
  AProduct.Add('sdxGanttControlTaskDependencyDialogLinkTypeSF', @sdxGanttControlTaskDependencyDialogLinkTypeSF);
  AProduct.Add('sdxGanttControlTaskDependencyDialogLinkTypeNone', @sdxGanttControlTaskDependencyDialogLinkTypeNone);
  AProduct.Add('sdxGanttControlTaskDependencyDialogLag', @sdxGanttControlTaskDependencyDialogLag);

  AProduct.Add('sdxGanttControlTimelineTaskHintFinishCaption', @sdxGanttControlTimelineTaskHintFinishCaption);
  AProduct.Add('sdxGanttControlTimelineTaskHintCompleteCaption', @sdxGanttControlTimelineTaskHintCompleteCaption);
  AProduct.Add('sdxGanttControlTimelineTaskHintDurationCaption', @sdxGanttControlTimelineTaskHintDurationCaption);
  AProduct.Add('sdxGanttControlTimelineTaskHintStartCaption', @sdxGanttControlTimelineTaskHintStartCaption);

  AProduct.Add('sdxGanttControlTaskInformationDialogCaption', @sdxGanttControlTaskInformationDialogCaption);
  AProduct.Add('sdxGanttControlTaskInformationDialogSummaryCaption', @sdxGanttControlTaskInformationDialogSummaryCaption);
  AProduct.Add('sdxGanttControlTaskInformationDialogGeneralTabCaption', @sdxGanttControlTaskInformationDialogGeneralTabCaption);
  AProduct.Add('sdxGanttControlTaskInformationDialogAdvancedTabCaption', @sdxGanttControlTaskInformationDialogAdvancedTabCaption);
  AProduct.Add('sdxGanttControlTaskInformationDialogName', @sdxGanttControlTaskInformationDialogName);
  AProduct.Add('sdxGanttControlTaskInformationDialogDuration', @sdxGanttControlTaskInformationDialogDuration);
  AProduct.Add('sdxGanttControlTaskInformationDialogEstimated', @sdxGanttControlTaskInformationDialogEstimated);
  AProduct.Add('sdxGanttControlTaskInformationDialogPercentComplete', @sdxGanttControlTaskInformationDialogPercentComplete);
  AProduct.Add('sdxGanttControlTaskInformationDialogScheduleMode', @sdxGanttControlTaskInformationDialogScheduleMode);
  AProduct.Add('sdxGanttControlTaskInformationDialogManuallySchedule', @sdxGanttControlTaskInformationDialogManuallySchedule);
  AProduct.Add('sdxGanttControlTaskInformationDialogAutoSchedule', @sdxGanttControlTaskInformationDialogAutoSchedule);
  AProduct.Add('sdxGanttControlTaskInformationDialogDates', @sdxGanttControlTaskInformationDialogDates);
  AProduct.Add('sdxGanttControlTaskInformationDialogDateStart', @sdxGanttControlTaskInformationDialogDateStart);
  AProduct.Add('sdxGanttControlTaskInformationDialogDateFinish', @sdxGanttControlTaskInformationDialogDateFinish);
  AProduct.Add('sdxGanttControlTaskInformationDialogDisplayOnTimeline', @sdxGanttControlTaskInformationDialogDisplayOnTimeline);
  AProduct.Add('sdxGanttControlTaskInformationDialogConstrainTask', @sdxGanttControlTaskInformationDialogConstrainTask);
  AProduct.Add('sdxGanttControlTaskInformationDialogConstraintType', @sdxGanttControlTaskInformationDialogConstraintType);
  AProduct.Add('sdxGanttControlTaskInformationDialogConstraintDate', @sdxGanttControlTaskInformationDialogConstraintDate);
  AProduct.Add('sdxGanttControlTaskInformationDialogCalendar', @sdxGanttControlTaskInformationDialogCalendar);

  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogCaption', @sdxGanttControlRecurringTaskInformationDialogCaption);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogTaskName', @sdxGanttControlRecurringTaskInformationDialogTaskName);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogTaskDuration', @sdxGanttControlRecurringTaskInformationDialogTaskDuration);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogRecurrencePattern', @sdxGanttControlRecurringTaskInformationDialogRecurrencePattern);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogDaily', @sdxGanttControlRecurringTaskInformationDialogDaily);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogWeekly', @sdxGanttControlRecurringTaskInformationDialogWeekly);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogMonthly', @sdxGanttControlRecurringTaskInformationDialogMonthly);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogYearly', @sdxGanttControlRecurringTaskInformationDialogYearly);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogDailyEvery', @sdxGanttControlRecurringTaskInformationDialogDailyEvery);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogDailyEveryDays', @sdxGanttControlRecurringTaskInformationDialogDailyEveryDays);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogWeeklyRecurEvery', @sdxGanttControlRecurringTaskInformationDialogWeeklyRecurEvery);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogWeeklyRecurWeeksOn', @sdxGanttControlRecurringTaskInformationDialogWeeklyRecurWeeksOn);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogFirst', @sdxGanttControlRecurringTaskInformationDialogFirst);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogSecond', @sdxGanttControlRecurringTaskInformationDialogSecond);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogThird', @sdxGanttControlRecurringTaskInformationDialogThird);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogFourth', @sdxGanttControlRecurringTaskInformationDialogFourth);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogLast', @sdxGanttControlRecurringTaskInformationDialogLast);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogDay', @sdxGanttControlRecurringTaskInformationDialogDay);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogOfEvery', @sdxGanttControlRecurringTaskInformationDialogOfEvery);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogMonths', @sdxGanttControlRecurringTaskInformationDialogMonths);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogOn', @sdxGanttControlRecurringTaskInformationDialogOn);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogRange', @sdxGanttControlRecurringTaskInformationDialogRange);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogRangeStart', @sdxGanttControlRecurringTaskInformationDialogRangeStart);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogRangeEndAfter', @sdxGanttControlRecurringTaskInformationDialogRangeEndAfter);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogRangeEndAfterOccurrences', @sdxGanttControlRecurringTaskInformationDialogRangeEndAfterOccurrences);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogRangeEndBy', @sdxGanttControlRecurringTaskInformationDialogRangeEndBy);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogSchedulingCalendar', @sdxGanttControlRecurringTaskInformationDialogSchedulingCalendar);
  AProduct.Add('sdxGanttControlRecurringTaskInformationDialogSchedulingCalendarName', @sdxGanttControlRecurringTaskInformationDialogSchedulingCalendarName);

  AProduct.Add('sdxGanttControlDialogDelete', @sdxGanttControlDialogDelete);
  AProduct.Add('sdxGanttControlDialogOk', @sdxGanttControlDialogOk);
  AProduct.Add('sdxGanttControlDialogCancel', @sdxGanttControlDialogCancel);

  AProduct.Add('sdxGanttControlCaptionNone', @sdxGanttControlCaptionNone);

  AProduct.Add('sdxGanttControlExceptionImageNotFound', @sdxGanttControlExceptionImageNotFound);
  AProduct.Add('sdxGanttControlExceptionInvalidDuration', @sdxGanttControlExceptionInvalidDuration);
  AProduct.Add('sdxGanttControlExceptionInvalidDurationFormat', @sdxGanttControlExceptionInvalidDurationFormat);
  AProduct.Add('sdxGanttControlExceptionInvalidFileFormat', @sdxGanttControlExceptionInvalidFileFormat);
  AProduct.Add('sdxGanttControlExceptionUnsupportedFileFormat', @sdxGanttControlExceptionUnsupportedFileFormat);
  AProduct.Add('sdxGanttControlExceptionTasksAreAlreadyLinked', @sdxGanttControlExceptionTasksAreAlreadyLinked);
  AProduct.Add('sdxGanttControlExceptionTasksAreAlreadyLinkedThroughAnotherTaskChain', @sdxGanttControlExceptionTasksAreAlreadyLinkedThroughAnotherTaskChain);
  AProduct.Add('sdxGanttControlExceptionTasksCannotBeLinkedTwice', @sdxGanttControlExceptionTasksCannotBeLinkedTwice);
  AProduct.Add('sdxGanttControlExceptionOutlineChangeWouldCreateCircularRelationship', @sdxGanttControlExceptionOutlineChangeWouldCreateCircularRelationship);
  AProduct.Add('sdxGanttControlExceptionCannotLinkSummaryTaskToItsSubtask', @sdxGanttControlExceptionCannotLinkSummaryTaskToItsSubtask);
  AProduct.Add('sdxGanttControlExceptionPositionChangeWouldCreateCircularRelationship', @sdxGanttControlExceptionPositionChangeWouldCreateCircularRelationship);

  AProduct.Add('sdxGanttControlMessageInvalidDurationFormat', @sdxGanttControlMessageInvalidDurationFormat);
  AProduct.Add('sdxGanttControlMessageInvalidLagValue', @sdxGanttControlMessageInvalidLagValue);
  AProduct.Add('sdxGanttControlMessageInvalidMeasurementUnit', @sdxGanttControlMessageInvalidMeasurementUnit);
  AProduct.Add('sdxGanttControlMessageInvalidPercentageCompletedValue', @sdxGanttControlMessageInvalidPercentageCompletedValue);
  AProduct.Add('sdxGanttControlMessageInvalidSummaryTaskLink', @sdxGanttControlMessageInvalidSummaryTaskLink);
  AProduct.Add('sdxGanttControlMessageInvalidPredecessorInformation', @sdxGanttControlMessageInvalidPredecessorInformation);
  AProduct.Add('sdxGanttControlMessageInvalidWeekSchedule', @sdxGanttControlMessageInvalidWeekSchedule);
  AProduct.Add('sdxGanttControlMessageTwiceResourcesInformation', @sdxGanttControlMessageTwiceResourcesInformation);

  AProduct.Add('sdxGanttControlTaskCompletedHint', @sdxGanttControlTaskCompletedHint);
  AProduct.Add('sdxGanttControlTaskHasConstraintHint', @sdxGanttControlTaskHasConstraintHint);
  AProduct.Add('sdxGanttControlRecurringTaskHint', @sdxGanttControlRecurringTaskHint);

  AProduct.Add('sdxGanttControlCommandAddTaskToTimelineCaption', @sdxGanttControlCommandAddTaskToTimelineCaption);
  AProduct.Add('sdxGanttControlCommandScrollToTaskCaption', @sdxGanttControlCommandScrollToTaskCaption);
  AProduct.Add('sdxGanttControlCommandInsertTaskCaption', @sdxGanttControlCommandInsertTaskCaption);
  AProduct.Add('sdxGanttControlCommandInsertRecurringTaskCaption', @sdxGanttControlCommandInsertRecurringTaskCaption);
  AProduct.Add('sdxGanttControlCommandDeleteTaskCaption', @sdxGanttControlCommandDeleteTaskCaption);
  AProduct.Add('sdxGanttControlCommandDeleteTasksCaption', @sdxGanttControlCommandDeleteTasksCaption);
  AProduct.Add('sdxGanttControlCommandInformationCaption', @sdxGanttControlCommandInformationCaption);
  AProduct.Add('sdxGanttControlCommandGoToTaskCaption', @sdxGanttControlCommandGoToTaskCaption);
  AProduct.Add('sdxGanttControlCommandRemoveFromTimelineCaption', @sdxGanttControlCommandRemoveFromTimelineCaption);

  AProduct.Add('sdxGanttControlSheetExtendedAttributeCostColumnDescription', @sdxGanttControlSheetExtendedAttributeCostColumnDescription);
  AProduct.Add('sdxGanttControlSheetExtendedAttributeDateColumnDescription', @sdxGanttControlSheetExtendedAttributeDateColumnDescription);
  AProduct.Add('sdxGanttControlSheetExtendedAttributeStartColumnDescription', @sdxGanttControlSheetExtendedAttributeStartColumnDescription);
  AProduct.Add('sdxGanttControlSheetExtendedAttributeFinishColumnDescription', @sdxGanttControlSheetExtendedAttributeFinishColumnDescription);
  AProduct.Add('sdxGanttControlSheetExtendedAttributeFlagColumnDescription', @sdxGanttControlSheetExtendedAttributeFlagColumnDescription);
  AProduct.Add('sdxGanttControlSheetExtendedAttributeDurationColumnDescription', @sdxGanttControlSheetExtendedAttributeDurationColumnDescription);
  AProduct.Add('sdxGanttControlSheetExtendedAttributeTextColumnDescription', @sdxGanttControlSheetExtendedAttributeTextColumnDescription);
  AProduct.Add('sdxGanttControlSheetExtendedAttributeNumberColumnDescription', @sdxGanttControlSheetExtendedAttributeNumberColumnDescription);
  AProduct.Add('sdxGanttControlCommandRenameColumnCaption', @sdxGanttControlCommandRenameColumnCaption);
  AProduct.Add('sdxGanttControlCommandWordWrapCaption', @sdxGanttControlCommandWordWrapCaption);
  AProduct.Add('sdxGanttControlCommandInsertColumnCaption', @sdxGanttControlCommandInsertColumnCaption);
  AProduct.Add('sdxGanttControlCommandHideColumnCaption', @sdxGanttControlCommandHideColumnCaption);
  AProduct.Add('sdxGanttControlCommandShowChooseColumnDetailsDialogCaption', @sdxGanttControlCommandShowChooseColumnDetailsDialogCaption);
  AProduct.Add('sdxGanttControlCommandBestFitColumnCaption', @sdxGanttControlCommandBestFitColumnCaption);
  AProduct.Add('sdxGanttControlCommandBestFitAllColumnsCaption', @sdxGanttControlCommandBestFitAllColumnsCaption);
  AProduct.Add('sdxGanttControlChooseDetailsDialogCaption', @sdxGanttControlChooseDetailsDialogCaption);
  AProduct.Add('sdxGanttControlChooseDetailsDialogDescription', @sdxGanttControlChooseDetailsDialogDescription);
  AProduct.Add('sdxGanttControlChooseDetailsDialogDetails', @sdxGanttControlChooseDetailsDialogDetails);
  AProduct.Add('sdxGanttControlChooseDetailsDialogColumnWidthDescription', @sdxGanttControlChooseDetailsDialogColumnWidthDescription);
end;


initialization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.RegisterProduct(dxGanttControlProductName, @AddGanttControlResourceStringNames);
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.InitializationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
finalization
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationStarted(dxThisUnitName, SysInit.HInstance);{$ENDIF}
  dxResourceStringsRepository.UnRegisterProduct(dxGanttControlProductName, @AddGanttControlResourceStringNames);
  {$IFDEF DX_INITIALIZATION_LOGGING}TdxUnitSectionsLogger.FinalizationFinished(dxThisUnitName, SysInit.HInstance);{$ENDIF}
end.
