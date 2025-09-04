unit fg_101;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Series, TeEngine, ExtCtrls, TeeProcs, Chart, AppForms, InpFrames,
  Menus, Buttons, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  StdCtrls, cxButtons, VclTee.TeeGDIPlus;

type
  TGadgetG101Frame = class(TFrame)
    Chart: TChart;
    ClientesSeries: TFastLineSeries;
    FrameManager: TgFrameManager;
    RiesgoSeries: TAreaSeries;
    OptionsBtn: TcxButton;
    OptionsPopupMenu: TPopupMenu;
    AcumuladoItem: TMenuItem;
    N1: TMenuItem;
    MostrarValoresItem: TMenuItem;
    EfectosClientesSeries: TFastLineSeries;
    procedure FrameManagerInitialize;
    procedure FrameManagerUpdate;
    procedure ChartDblClick(Sender: TObject);
    procedure MostrarValoresItemClick(Sender: TObject);
    procedure OptionsBtnClick(Sender: TObject);
  private
    Acumulado,
    MostrarValores : Boolean;
  public
  end;

implementation

{$R *.dfm}

uses  DateUtils,
      AppContainer,

      dm_sal;

resourceString
      RsMsg1   = 'Riesgo %s';
      RsMsg2   = 'acumulado';
      RsMsg3   = 'mensual';

procedure TGadgetG101Frame.ChartDblClick(Sender: TObject);
begin
     If   Assigned( OnDblClick )
     then OnDblClick( Sender );
end;

procedure TGadgetG101Frame.FrameManagerInitialize;
begin
     FrameManagerUpdate;
end;

procedure TGadgetG101Frame.FrameManagerUpdate;

const Cuentas : array[ 1..2 ] of String = ( '430', '431' );

var   EjercicioActual,
      MesActual,
      Contador : SmallInt;
      RiesgoClientes,
      RiesgoEfectos : Decimal;
      
function InsertaValor( Cuenta   : String;
                       Series   : TChartSeries;
                       Acreedor : Boolean = False;
                       Valor    : Decimal = 0.0 ) : Decimal;

var  ValorSaldo : Decimal;

begin
     If   Cuenta<>''
     then With Saldos do
            begin
            If   Acumulado
            then ValorSaldo := SaldoPeriodo( Cuenta, '', True, EjercicioActual, 0, MesActual ).Saldo
            else ValorSaldo := SaldoPeriodo( Cuenta, '', True, EjercicioActual, MesActual, MesActual ).Saldo;
            end
     else ValorSaldo := Valor;
     If   Acreedor
     then ValorSaldo := -ValorSaldo;
     Series.AddXY( Contador, ValorSaldo, StrMonth( MesActual, True ) );
     Result := Abs( ValorSaldo );
end;

begin

     ClientesSeries.Clear;
     EfectosClientesSeries.Clear;
     RiesgoSeries.Clear;

     ClientesSeries.Marks.Visible := MostrarValores;
     EfectosClientesSeries.Marks.Visible := MostrarValores;
     RiesgoSeries.Marks.Visible := MostrarValores;

      With Chart.Title do
       If   Acumulado
       then Caption := Format( RsMsg1, [ RsMsg2 ] )
       else Caption := Format( RsMsg1, [ RsMsg3 ] );
       
     EjercicioActual := ApplicationContainer.Ejercicio;
     MesActual := MonthOf( ApplicationContainer.TodayDate ) - 11;
     If   MesActual<ApplicationContainer.NroMesInicial
     then begin
          MesActual := ApplicationContainer.NroMesFinal + MesActual;
          Dec( EjercicioActual );
          end;

     Contador := 1;
     While Contador<=12 do
       begin

       RiesgoClientes := InsertaValor( Cuentas[ 1 ], ClientesSeries );
       RiesgoEfectos := InsertaValor( Cuentas[ 2 ], EfectosClientesSeries );
       InsertaValor( '', RiesgoSeries, False, RiesgoClientes + RiesgoEfectos);

       Inc( MesActual );
       If   MesActual>ApplicationContainer.NroMesFinal
       then begin
            MesActual := ApplicationContainer.NroMesInicial;
            Inc( EjercicioActual );
            end;

       Inc( Contador );
       end;

end;

procedure TGadgetG101Frame.MostrarValoresItemClick(Sender: TObject);
begin
     case TComponent( Sender ).Tag of
       0 : Acumulado := not Acumulado;
       1 : MostrarValores := not MostrarValores;
       end;
     AcumuladoItem.Checked := Acumulado;
     MostrarValoresItem.Checked := MostrarValores;
     FrameManagerUpdate;
end;

procedure TGadgetG101Frame.OptionsBtnClick(Sender: TObject);

var  Position : TPoint;

begin
     With OptionsBtn do
       begin
       Position := Point( Left + Width + 2, Top );
       Position := Self.ClientToScreen( Position );
       OptionsPopupMenu.Popup( Position.X, Position.Y );
       end;

end;

end.

