unit fg_100;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Series, TeEngine, ExtCtrls, TeeProcs, Chart, AppForms, InpFrames,
  Buttons, Menus, AppContainer, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  StdCtrls, cxButtons, VclTee.TeeGDIPlus;

type
  TGadgetG100Frame = class(TFrame)
    Chart: TChart;
    ComprasSeries: TFastLineSeries;
    VentasSeries: TFastLineSeries;
    FrameManager: TgFrameManager;
    RendimientoSeries: TBarSeries;
    OptionsBtn: TcxButton;
    OptionsPopupMenu: TPopupMenu;
    AcumuladoItem: TMenuItem;
    N1: TMenuItem;
    MostrarValoresItem: TMenuItem;
    procedure FrameManagerInitialize;
    procedure FrameManagerUpdate;
    procedure ChartDblClick(Sender: TObject);
    procedure OptionsBtnClick(Sender: TObject);
    procedure MostrarValoresItemClick(Sender: TObject);
  private
    Acumulado,
    MostrarValores : Boolean;

  public
  end;

implementation

{$R *.dfm}

uses  DateUtils,

      dm_sal;

resourceString
      RsMsg1   = 'Rentabilidad %s';
      RsMsg2   = 'acumulada';
      RsMsg3   = 'mensual';
            
procedure TGadgetG100Frame.ChartDblClick(Sender: TObject);
begin
     If   Assigned( OnDblClick )
     then OnDblClick( Sender );
end;

procedure TGadgetG100Frame.FrameManagerInitialize;
begin
     FrameManagerUpdate;
end;

procedure TGadgetG100Frame.FrameManagerUpdate;

var  Compras,
     Ventas : Decimal;

const Cuentas : array[ 1..2 ] of String = ( '6', '7' );

var   EjercicioActual,
      MesActual,
      Contador : SmallInt;

function  InsertaValor( Cuenta   : String;
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

     RendimientoSeries.Clear;
     ComprasSeries.Clear;
     VentasSeries.Clear;

     RendimientoSeries.Marks.Visible := MostrarValores;
     ComprasSeries.Marks.Visible := MostrarValores;
     VentasSeries.Marks.Visible := MostrarValores;

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

       Compras := InsertaValor( Cuentas[ 1 ], ComprasSeries );
       Ventas := InsertaValor( Cuentas[ 2 ], VentasSeries, True );
       InsertaValor( '', RendimientoSeries, False, Ventas - Compras );

       Inc( MesActual );
       If   MesActual>ApplicationContainer.NroMesFinal
       then begin
            MesActual := ApplicationContainer.NroMesInicial;
            Inc( EjercicioActual );
            end;

       Inc( Contador );
       end;

end;

procedure TGadgetG100Frame.MostrarValoresItemClick(Sender: TObject);
begin
     case TComponent( Sender ).Tag of
       0 : Acumulado := not Acumulado;
       1 : MostrarValores := not MostrarValores;
       end;
     AcumuladoItem.Checked := Acumulado;
     MostrarValoresItem.Checked := MostrarValores;
     FrameManagerUpdate;
end;

procedure TGadgetG100Frame.OptionsBtnClick(Sender: TObject);

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

