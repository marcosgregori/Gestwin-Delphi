

unit l_adp;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons, Mask,

  Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxDBEdit, dxmdaset, cxCheckBox, dxSkinsCore,
  dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox,

  AppContainer,
  DataManager,
  ReportManager,

  Gim10Fields,

  dm_sal, cxSpinEdit, dxUIAClasses;


type
    TRptAdpForm = class(TgxForm)
    FormManager: TgxFormManager;
    report: TgxReportManager;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DataPanel: TgxEditPanel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    MemDataSource: TDataSource;
    Data: TgxMemData;
    Label10: TcxLabel;
    NroDiasPlazoCtrl: TcxDBSpinEdit;
    Label9: TcxLabel;
    cxLabel2: TcxLabel;
    DataNroDiasPlazo: TSmallintField;
    procedure InitializeForm;
    procedure FormManagerOkButton;
    private
    public

    end;

var RptAdpForm : TRptAdpForm = nil;

procedure InformeAplazamientoPago;


implementation

uses   Math,

       nxllTypes,

       LibUtils,
       DateUtils,
       QueryGrid,
       EnterpriseDataAccess,

       dm_sub,
       dm_ecc,

       q_adu;

{$R *.DFM}

procedure InformeAplazamientoPago;
begin
     CreateReportForm( TRptAdpForm, RptAdpForm );
end;

procedure TRptAdpForm.InitializeForm;
begin
      DataNroDiasPlazo.Value := 30;
end;

procedure TRptAdpForm.FormManagerOkButton;

procedure  EjecutaConsulta;

var  Ejercicio,
     EjercicioInicial,
     EjercicioFinal : SmallInt;
     Query : TnxQuery;
     SQLText : String;
     PrimerDia,
     UltimoDia : TDate;
     Sufijo : String;

     TotalDiasImportePagos,
     TotalPagosRealizados,
     TotalPagosDentroPlazo,
     TotalDiasImportePendiente,
     TotalPagosPendientes,
     NroFacturasDentroPlazo,
     NroFacturasTotal : Decimal;

     PeriodoMedioPago,
     NroDias,
     RatioOperacionesPagadas,
     RatioOperacionesPendientes,
     PorcentajePagosDentroPlazo,
     PorcentajeNroFacturasDentroPlazo,

     DiasPorImporte : Decimal;

     ImporteField : TBCDField;
     FechaLibramientoField,
     FechaPagoField : TDateField;

begin

     For Ejercicio := ApplicationContainer.Ejercicio - 1 to ApplicationContainer.Ejercicio do
       begin

       SQLText := 'SELECT SUM( CASE WHEN Efecto.FechaPago IS NOT NULL AND EXTRACT( YEAR FROM Efecto.FechaPago )=<Ejercicio> THEN Efecto.Importe ELSE 0.0 END ) AS TotalPagosRealizados, ' +
                   '       SUM( CASE WHEN Efecto.FechaPago IS NOT NULL AND EXTRACT( YEAR FROM Efecto.FechaPago )=<Ejercicio> AND NroDias<=' + IntToStr( DataNroDiasPlazo.Value ) + ' THEN Efecto.Importe ELSE 0.0 END ) AS TotalPagosDentroPlazo, ' +
                   '       SUM( CASE WHEN Efecto.FechaPago IS NOT NULL AND EXTRACT( YEAR FROM Efecto.FechaPago )=<Ejercicio> THEN Efecto.Importe * NroDias ELSE 0.0 END ) AS TotalDiasImportePagos, ' +
                   '       SUM( CASE WHEN Efecto.FechaPago IS NULL OR EXTRACT( YEAR FROM Efecto.FechaPago )><Ejercicio> THEN Efecto.Importe ELSE 0.0 END ) AS TotalPagosPendientes, ' +
                   '       SUM( CASE WHEN Efecto.FechaPago IS NULL OR EXTRACT( YEAR FROM Efecto.FechaPago )><Ejercicio> THEN Efecto.Importe * NroDias ELSE 0.0 END ) AS TotalDiasImportePendiente, ' +
                   '       COUNT( DISTINCT( CASE WHEN Efecto.FechaPago IS NOT NULL AND EXTRACT( YEAR FROM Efecto.FechaPago )=<Ejercicio> AND NroDias<=' + IntToStr( DataNroDiasPlazo.Value ) + ' THEN Serie ELSE '''' END ) ) - 1 AS NroFacturasDentroPlazo, ' +
                   '       COUNT( DISTINCT( CASE WHEN Efecto.FechaPago IS NOT NULL AND EXTRACT( YEAR FROM Efecto.FechaPago )=<Ejercicio> THEN Serie ELSE '''' END ) ) - 1 AS NroFacturasTotal ' +
                   '       FROM ( SELECT *, ' +
                   '                     CASE WHEN FechaPago IS NULL  OR EXTRACT( YEAR FROM Seleccion.FechaPago )><Ejercicio> THEN ( CAST( <UltimoDia> AS INT ) - CAST( Seleccion.FechaLibramiento AS INT ) ) ' +
                   '                          ELSE ( CAST( Seleccion.FechaPago AS INT ) - CAST( Seleccion.FechaLibramiento AS INT ) ) END AS NroDias ' +
                   '              FROM  ( SELECT EfectoPagar.Serie, EfectoPagar.NroEfecto, EfectoPagar.NroRemesa, EfectoPagar.FechaLibramiento, RemesaPago.Estado, ' +
                   '                             CASE WHEN EfectoPagar.ImportePagado IS NULL THEN EfectoPagar.Importe ELSE EfectoPagar.ImportePagado END AS Importe, ' +
                   '                             CASE WHEN EfectoPagar.NroRemesa IS NULL OR EfectoPagar.NroRemesa=0 THEN EfectoPagar.FechaPago ELSE RemesaPago.FechaPago END AS FechaPago ' +
                   '                      FROM    EfectoPagar ' +
                   '                              LEFT JOIN RemesaPago ON ( RemesaPago.Ejercicio=EfectoPagar.EjercicioRemesa AND RemesaPago.NroRemesa=EfectoPagar.NroRemesa ) ' +
                   '                              WHERE   ( EfectoPagar.SubcuentaProveedor BETWEEN ''400000000'' AND ''419999999'' ) AND ( EfectoPagar.FechaLibramiento BETWEEN <PrimerDia> AND <UltimoDia> ) AND ( EfectoPagar.Importe>0.0 ) ' +
                   '                    ) AS Seleccion ' +
                   '             ) AS Efecto ';

       // Empresas con ejercicio partido obliga

       EjercicioInicial := Ejercicio - 2;
       If   ApplicationContainer.NroMesInicial=1
       then EjercicioFinal := Ejercicio
       else EjercicioFinal := Ejercicio + 1;

       PrimerDia := EncodeDate( EjercicioInicial, ApplicationContainer.NroMesInicial, 1 );
       UltimoDia := EncodeDate( EjercicioFinal, ApplicationContainer.NroMesFinal, DaysInAMonth( EjercicioFinal, ApplicationContainer.NroMesFinal ) );

       SetSQLVar( SQLText, 'Ejercicio', IntToStr( Ejercicio ) );
       SetSQLVar( SQLText, 'PrimerDia', SQLDateString( PrimerDia ) );
       SetSQLVar( SQLText, 'UltimoDia', SQLDateString( UltimoDia ) );

       Sufijo := IntToStr( ApplicationContainer.Ejercicio - Ejercicio );  // 0 = Ejercicio actual y 1= Ejercicio anterior

       Query := EnterpriseDataModule.OpenQuery( SQLText );
       If   Assigned( Query )
       then With Query do
              try

                TotalDiasImportePagos := FieldValues[ 'TotalDiasImportePagos' ];
                TotalPagosRealizados := FieldValues[ 'TotalPagosRealizados' ];
                TotalPagosDentroPlazo := FieldValues[ 'TotalPagosDentroPlazo' ];
                TotalDiasImportePendiente := FieldValues[ 'TotalDiasImportePendiente' ];
                TotalPagosPendientes := FieldValues[ 'TotalPagosPendientes' ];
                NroFacturasDentroPlazo := Max( FieldValues[ 'NroFacturasDentroPlazo' ], 0 );  // Impido que sea negativo (si no hay facturas es -1)
                NroFacturasTotal := Max( FieldValues[ 'NroFacturasTotal' ], 0 );

                RatioOperacionesPagadas := 0.0;
                RatioOperacionesPendientes := 0.0;
                PeriodoMedioPago := 0;

                If   TotalPagosRealizados<>0.0
                then RatioOperacionesPagadas := TotalDiasImportePagos / TotalPagosRealizados;
                If   TotalPagosPendientes<>0.0
                then RatioOperacionesPendientes := TotalDiasImportePendiente / TotalPagosPendientes;
                If   ( TotalDiasImportePagos + TotalDiasImportePendiente )<>0.0
                then PeriodoMedioPago := ( ( RatioOperacionesPagadas * TotalPagosRealizados ) + ( RatioOperacionesPendientes * TotalPagosPendientes ) ) / ( TotalPagosRealizados + TotalPagosPendientes );

                If   TotalPagosRealizados<>0.0
                then PorcentajePagosDentroPlazo := ( TotalPagosDentroPlazo * 100.0 ) / TotalPagosRealizados
                else PorcentajePagosDentroPlazo := 0.0;

                If   NroFacturasTotal<>0.0
                then PorcentajeNroFacturasDentroPlazo := ( NroFacturasDentroPlazo * 100.0 ) / NroFacturasTotal
                else PorcentajeNroFacturasDentroPlazo := 0.0;

                TotalPagosDentroPlazo := TotalPagosDentroPlazo / 1000.0;  // En miles de euros

                Report.SetValue( 'RatioOperacionesPagadas' + Sufijo, RatioOperacionesPagadas );
                Report.SetValue( 'RatioOperacionesPendientes' + Sufijo, RatioOperacionesPendientes );
                Report.SetValue( 'PeriodoMedioPago' + Sufijo, PeriodoMedioPago );
                Report.SetValue( 'TotalPagosRealizados' + Sufijo, TotalPagosRealizados );
                Report.SetValue( 'TotalPagosPendientes' + Sufijo, TotalPagosPendientes );
                Report.SetValue( 'TotalPagosDentroPlazo' + Sufijo, TotalPagosDentroPlazo );
                Report.SetValue( 'PorcentajePagosDentroPlazo' + Sufijo, PorcentajePagosDentroPlazo );
                Report.SetValue( 'NroFacturasDentroPlazo' + Sufijo, NroFacturasDentroPlazo );
                Report.SetValue( 'NroFacturasTotal' + Sufijo, NroFacturasTotal );
                Report.SetValue( 'PorcentajeNroFacturasDentroPlazo' + Sufijo, PorcentajeNroFacturasDentroPlazo );

              finally
                Query.Free;
                end

       else Abort;

       end;
end;

begin
     With Report do
       try
         Load;
         EjecutaConsulta;
         Start;
       except on E : Exception do Cancel( E );
         end;
end;

end.

