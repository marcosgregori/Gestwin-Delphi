
unit g_sal;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons, Grids,
  Mask, ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb, DataManager,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,

  cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters,
  cxLabel, cxGroupBox, cxStyles, cxCustomData, cxDBData,
  cxGridLevel, cxGridChartView, cxGridDBChartView, cxClasses, cxGridCustomView,
  cxGrid, dxmdaset, dxPScxGridLnk,

  LibUtils,
  AppContainer,

  Gim00Fields,
  Gim10Fields,

  dmi_sal,

  dm_sal,
  dm_plg,

  p_gph;


type
    TGphSalForm = class(TGphTemplateForm)
    procedure NroOperacionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);

    private

      SumasySaldos : ISumasySaldos;
      SumaDebeAcumulado,
      SumaHaberAcumulado,
      SumaSaldoAcumulado : Decimal;
      MostrarApertura : Boolean;
      Periodicidad,
      Periodo : SmallInt;

    public

      function ObtenTipoPlantillaGrafico : TTipoPlantillaGrafico; override;
      procedure DoOnInitialize; override;
      procedure DoOnAddFields( NroEjercicio, SeriesIndex : SmallInt; GridDBChartSeries : TcxGridDBChartSeries ); override;
      procedure DoOnCalculateSeries( NroEjercicio, SeriesIndex : SmallInt ); override;
    end;

var  GphSalForm : TGphSalForm = nil;

procedure GraficoSaldos;


implementation

uses   DateUtils,
       AppManager,
       AppForm,

       EnterpriseDataAccess,
       PrintSystem,

       Gdm10Frm,

       dm_pga,
       dm_sub,
       dm_cco,

       b_msg,

       a_psa,

       cx_sub,
       cx_cco,
       cx_plg;

{$R *.DFM}

procedure GraficoSaldos;
begin
     CreateEditForm( TGphSalForm, GphSalForm, [], TGds10Frm.ContableSection );
end;

procedure TGphSalForm.NroOperacionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MantenimientoPlantillaSaldos( [ Ord( pgSaldos ), Sender.Editingvalue, 0 ] );
end;

function TGphSalForm.ObtenTipoPlantillaGrafico: TTipoPlantillaGrafico;
begin
     Result := pgSaldos;
end;

procedure TGphSalForm.DoOnInitialize;
begin

     SumaDebeAcumulado := 0.0;
     SumaHaberAcumulado := 0.0;
     SumaSaldoAcumulado := 0.0;

     SumasySaldos := TSumasySaldos.Create;

     MostrarApertura := PlantillaGraficoFields.Opcion[ 2 ].Value;
     Periodo := PlantillaGraficoFields.Operacion[ 1 ].Value;
     Periodicidad := PlantillaGraficoFields.Operacion[ 3 ].Value;

end;

procedure TGphSalForm.DoOnAddFields( NroEjercicio, SeriesIndex: SmallInt; GridDBChartSeries: TcxGridDBChartSeries );

var  StrCodigos,
     StrDescripcion : String;
     Index : SmallInt;

begin
     StrCodigos := '';
     For Index := 1 to 6 do
       If   LineaPlantillaGraficoFields.Codigo[ Index ].Value<>''
       then begin
            If   StrCodigos<>''
            then StrCodigos := StrCodigos + ',';
            StrCodigos := StrCodigos + LineaPlantillaGraficoFields.Codigo[ Index ].Value;
            end;
     If   LineaPlantillaGraficoFields.Descripcion.Value=''
     then StrDescripcion := Cuenta.Descripcion( LineaPlantillaGraficoFields.Codigo[ 1 ].Value, True, True )
     else StrDescripcion := LineaPlantillaGraficoFields.Descripcion.Value;
     StrDescripcion :=  StrCodigos + ' : ' + StrDescripcion;
     If   ( Periodicidad=0 ) and ( Periodo<>2 )
     then StrDescripcion := IntToStr( NroEjercicio ) + ' - ' + StrDescripcion;

     GridDBChartSeries.DisplayText := StrDescripcion;
end;

procedure TGphSalForm.DoOnCalculateSeries( NroEjercicio, SeriesIndex: SmallInt);

procedure InsertaRegistroPeriodo( Posicion,
                                  Periodo,
                                  MesInicial,
                                  MesFinal,
                                  SeriesIndex : SmallInt );

var   Index : SmallInt;
      TextoPeriodo : String;
      ValorPeriodo : Decimal;

begin
     With LineaPlantillaGraficoFields do
       begin

       case Periodicidad of

         0 : // Mensual
           begin
           TextoPeriodo := StrMonth( Periodo, True );
           {
           case Operacion[ 1 ].Value of
             0 : ValorPeriodo := SumasySaldos.Debe[ Periodo ];
             1 : ValorPeriodo := SumasySaldos.Haber[ Periodo ];
             2 : ValorPeriodo := SumasySaldos.Debe[ Periodo ] - SumasySaldos.Haber[ Periodo ];
             3 : ValorPeriodo := SumasySaldos.Haber[ Periodo ] - SumasySaldos.Debe[ Periodo ];
             4 : ValorPeriodo := SumasySaldos.SumaDebe;
             5 : ValorPeriodo := SumasySaldos.SumaHaber;
             6 : ValorPeriodo := SumasySaldos.Saldo;
             7 : ValorPeriodo := -SumasySaldos.Saldo;
             end;
             }
           end;
         1,
         2 :
           begin
           If   Periodicidad=1  // Trimestral
           then begin
                TextoPeriodo := IntToStr( Periodo ) + 'T';
                If   ( Posicion=1 ) or ( Periodo=1 )
                then TextoPeriodo := IntToStr( NroEjercicio ) + ' : ' + TextoPeriodo;
                end
           else TextoPeriodo := IntToStr( Periodo );
           {
           case Operacion[ 1 ].Value of
             0 : ValorPeriodo := SumasySaldos.SumaDebe;
             1 : ValorPeriodo := SumasySaldos.SumaHaber;
             2 : ValorPeriodo := SumasySaldos.Saldo;
             3 : ValorPeriodo := -SumasySaldos.Saldo;
             end;
           }
           end;
         end;

       case Operacion[ 1 ].Value of
         0 : If   Periodicidad=0
             then ValorPeriodo := SumasySaldos.Debe[ Periodo ]
             else For Index := MesInicial to MesFinal do
                    ValorPeriodo := ValorPeriodo + SumasySaldos.Debe[ Periodo ];
         1 : If   Periodicidad=0
             then ValorPeriodo := SumasySaldos.Haber[ Periodo ]
             else For Index := MesInicial to MesFinal do
                    ValorPeriodo := ValorPeriodo + SumasySaldos.Haber[ Periodo ];
         2 : If   Periodicidad=0
             then ValorPeriodo := SumasySaldos.Debe[ Periodo ] - SumasySaldos.Haber[ Periodo ]
             else For Index := MesInicial to MesFinal do
                    ValorPeriodo := ValorPeriodo + SumasySaldos.Debe[ Periodo ] - SumasySaldos.Haber[ Periodo ];
         3 : If   Periodicidad=0
             then ValorPeriodo := SumasySaldos.Haber[ Periodo ] - SumasySaldos.Debe[ Periodo ]
             else For Index := MesInicial to MesFinal do
                    ValorPeriodo := ValorPeriodo + SumasySaldos.Haber[ Periodo ] - SumasySaldos.Debe[ Periodo ];
         4 : ValorPeriodo := SumasySaldos.SumaDebe;
         5 : ValorPeriodo := SumasySaldos.SumaHaber;
         6 : ValorPeriodo := SumasySaldos.Saldo;
         7 : ValorPeriodo := -SumasySaldos.Saldo;
         end;

       If   GridData.Locate( 'NroPeriodo', Posicion, [] )
       then GridData.Edit
       else begin
            GridData.Append;
            GridData.FieldValues[ 'NroPeriodo' ] := Posicion;
            GridData.FieldValues[ 'TextoPeriodo' ] := TextoPeriodo;
            end;

       GridData.FieldValues[ 'Valor' + IntToStr( SeriesIndex ) ] := ValorPeriodo;

       GridData.Post;

       end;

end;

procedure AcumulaSaldos( MesInicial, MesFinal : SmallInt );

var  Index : SmallInt;

begin
     // En el siguiente bucle se acumulan los valores. Codigo[ 7 ] es el centro de coste.

     SumasySaldos.Clear;

     With LineaPlantillaGraficoFields do
       For Index := 1 to 6 do
         If   Codigo[ Index ].Value<>''
         then SumasySaldos.Add( Saldos.SaldoPeriodo( Codigo[ Index ].Value,
                                                     Codigo[ 7 ].Value,
                                                     Codigo[ 7 ].Value='',   // Todos los centros de coste
                                                     NroEjercicio,
                                                     MesInicial,
                                                     MesFinal,
                                                     False ) )
         else Break;
end;

var  Contador,
     PosicionActual,
     MesActual : SmallInt;

begin

     case Periodicidad of
       0 : // Mensual
         begin
         If   Periodo=2   // Últimos 12 meses
         then begin

              MesActual := MonthOf( ApplicationContainer.TodayDate ) - 11;
              If   MesActual<ApplicationContainer.NroMesInicial
              then begin
                   MesActual := ApplicationContainer.NroMesFinal + MesActual;
                   Dec( NroEjercicio );
                   end;

              PosicionActual := 1;
              repeat

                AcumulaSaldos( 0, MesActual );
                InsertaRegistroPeriodo( PosicionActual, MesActual, MesActual, MesActual, SeriesIndex );

                Inc( MesActual );
                If   MesActual>ApplicationContainer.NroMesFinal
                then begin
                     MesActual := ApplicationContainer.NroMesInicial;
                     Inc( NroEjercicio );
                     end;

                Inc( PosicionActual );

              until PosicionActual=13;

              end
         else begin

              If   MostrarApertura
              then begin
                   AcumulaSaldos( 0, 0 );
                   InsertaRegistroPeriodo( 0, 0, 0, 0, SeriesIndex );
                   end;

              MesActual := ApplicationContainer.NroMesInicial;
              PosicionActual := 1;
              repeat

                AcumulaSaldos( 0, MesActual );
                InsertaRegistroPeriodo( MesActual, MesActual, MesActual, MesActual, SeriesIndex );
                Inc( PosicionActual );
                Inc( MesActual );
                If   MesActual>ApplicationContainer.NroMesFinal
                then MesActual := ApplicationContainer.NroMesInicial;

              until PosicionActual=13;

              end;
         end;

       1 : // Trimestral
         begin

         var TrimestreActual := Trunc( ( MonthOf( ApplicationContainer.TodayDate ) - 1 ) / 3 ) + 1;
         var PrimerMesTrimestre := ( ( TrimestreActual - 1 ) * 3 ) + 1;
         var FechaActual : TDate := IncMonth( EncodeDate( ApplicationContainer.Ejercicio, PrimerMesTrimestre, 1 ), -( Periodo * 3 ) );  // Me voy al primer día del primer trimestre
         PosicionActual := 1;
         While PosicionActual<=Periodo do   // Periodo contiene el número de trimestres
           begin
           NroEjercicio := YearOf( FechaActual );
           MesActual := MonthOf( FechaActual );
           TrimestreActual := Trunc( ( MesActual - 1 ) / 3 ) + 1;
           AcumulaSaldos( 0 { MesActual }, MesActual + 2 );
           InsertaRegistroPeriodo( PosicionActual, TrimestreActual, MesActual, MesActual + 2, SeriesIndex );
           FechaActual := IncMonth( FechaActual, 3 );  // El próximo trimestre
           Inc( PosicionActual );
           end;

         end;

       2 : // Anual
         begin
         PosicionActual := 1;
         For NroEjercicio := ApplicationContainer.Ejercicio - Periodo to ApplicationContainer.Ejercicio - 1 do
           begin
           AcumulaSaldos( 0, 12 );
           InsertaRegistroPeriodo( PosicionActual, NroEjercicio, 0, 12, SeriesIndex );
           Inc( PosicionActual );
           end;
         end;

       end;

end;

end.
