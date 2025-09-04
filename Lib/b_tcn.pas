unit b_tcn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, cxPC, cxControls, AppContainer, Menus,
  cxLookAndFeelPainters, cxButtons, dxSkinsCore, dxSkinscxPCPainter,
  dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels, cxContainer, cxEdit,
  cxLabel, cxPCdxBarPopupMenu, dxBarBuiltInMenu, cxGroupBox;

type
  TOperacion = ( opNinguna, opSuma, opResta, opProducto, opDivision );
  TTecladoFrame = class(TFrame)
    Panel2: TcxGroupBox;
    Panel1: TcxGroupBox;
    LeftRightButton: TcxButton;
    UpDownButton: TcxButton;
    ModoButton: TcxButton;
    PageControl: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    SpeedButton4: TcxButton;
    SpeedButton5: TcxButton;
    SpeedButton6: TcxButton;
    SpeedButton7: TcxButton;
    SpeedButton8: TcxButton;
    SpeedButton9: TcxButton;
    SpeedButton10: TcxButton;
    SpeedButton11: TcxButton;
    SpeedButton12: TcxButton;
    SpeedButton27: TcxButton;
    SpeedButton31: TcxButton;
    SpeedButton32: TcxButton;
    SpeedButton35: TcxButton;
    SpeedButton36: TcxButton;
    SpeedButton37: TcxButton;
    SpeedButton2: TcxButton;
    SpeedButton40: TcxButton;
    SpeedButton41: TcxButton;
    cxTabSheet2: TcxTabSheet;
    SpeedButton13: TcxButton;
    SpeedButton14: TcxButton;
    SpeedButton15: TcxButton;
    SpeedButton16: TcxButton;
    SpeedButton17: TcxButton;
    SpeedButton18: TcxButton;
    SpeedButton19: TcxButton;
    SpeedButton20: TcxButton;
    SpeedButton21: TcxButton;
    SpeedButton22: TcxButton;
    SpeedButton23: TcxButton;
    SpeedButton24: TcxButton;
    SpeedButton25: TcxButton;
    SpeedButton26: TcxButton;
    ClearButton: TcxButton;
    SpeedButton28: TcxButton;
    SpeedButton29: TcxButton;
    SpeedButton30: TcxButton;
    SpeedButton1: TcxButton;
    CloseMDIFormButton: TcxButton;
    SpeedButton3: TcxButton;
    ValorLabel: TcxLabel;
    Shape1: TShape;
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton41Click(Sender: TObject);
    procedure SpeedButton40Click(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton36Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure NumericButtonClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton37Click(Sender: TObject);
    procedure SpeedButton35Click(Sender: TObject);
    procedure ModoButtonClick(Sender: TObject);
    procedure CalculadoraButtonClick(Sender: TObject);
    procedure UpDownButtonClick(Sender: TObject);
    procedure LeftRightButtonClick(Sender: TObject);
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CloseMDIFormButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton29Click(Sender: TObject);
    procedure SpeedButton30Click(Sender: TObject);
    procedure ResultadoClick(Sender: TObject);
    procedure SpeedButton25Click(Sender: TObject);
    procedure SpeedButton22Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton26Click(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure SpeedButton28Click(Sender: TObject);
  private

    FValor : Currency;
    FTextoValorInterno: String;
    FLastActiveControl: TWinControl;
    FValorOperacion: Currency;
    FOperacion : TOperacion;
    FPosicionComa: SmallInt;

    FSettingPos,
    FMovingFrame : Boolean;
    FFrameX,
    FFrameY : Integer;

    FIzquierda,
    FArriba : Boolean;

    procedure ActualizaPosicion;
    procedure ActualizaValorInterno;
    procedure Add( Value : String );
    function ContieneComa: Boolean;
    procedure FijaOperacion( Operacion : TOperacion );
    procedure AplicaOperacion;
    procedure Limpia;
    procedure CambiaModo( Value : SmallInt );
  public
    procedure UpdatePos( NewLeft : Integer = 0; NewTop : Integer = 0 );
  end;

var  TecladoFrame : TTecladoFrame = nil;

procedure MuestraTecladoNumerico;

implementation

{$R *.dfm}

uses  AppForms;

procedure MuestraTecladoNumerico;
begin
     If   Assigned( TecladoFrame )
     then TecladoFrame.Visible := not TecladoFrame.Visible
     else begin
          TecladoFrame := TTecladoFrame.Create( Application.MainForm );
          If   Assigned( TecladoFrame )
          then With TecladoFrame do
                 begin
                 Parent := Application.MainForm;
                 FIzquierda := ApplicationContainer.PosQueryFormsAtLeft;
                 FArriba := True;
                 ActualizaPosicion;
                 CambiaModo( 0 );
                 Visible := True;
                 end;
          end;
end;

procedure TTecladoFrame.ActualizaValorInterno;
begin
     try
       FValor := StrToFloat( FTextoValorInterno );
     except
        FValor := 0.0;
        FTextoValorInterno := '';
       end;
     ValorLabel.Caption := FTextoValorInterno;
end;


procedure TTecladoFrame.CloseMDIFormButtonClick(Sender: TObject);
begin
     Visible := False;
end;

function TTecladoFrame.ContieneComa : Boolean;
begin
     FPosicionComa := Pos( ',', FTextoValorInterno );
     Result := FPosicionComa<>0;
end;

procedure TTecladoFrame.Add( Value : String );
begin
     If   Length( FTextoValorInterno )<12
     then If   not( ContieneComa and ( Length( FTextoValorInterno ) - FPosicionComa>6 ) )
          then If   not ( ( Value=',' ) and ContieneComa )
               then If   not( ( Copy( Value, 1, 1 )='0' ) and ( Length( FTextoValorInterno )=0 ) )
                    then begin
                         FTextoValorInterno := FTextoValorInterno + Value;
                         ActualizaValorInterno;
                         end;
end;

procedure TTecladoFrame.FormActivate(Sender: TObject);
begin
     If   Assigned( Application.MainForm )
     then FLastActiveControl := Application.MainForm.ActiveControl;
end;

procedure TTecladoFrame.FormDestroy(Sender: TObject);
begin
     TecladoFrame := nil;
end;

procedure TTecladoFrame.Panel1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     FMovingFrame := True;
     FFrameX := x;
     FFrameY := y;
end;

procedure TTecladoFrame.UpdatePos( NewLeft : Integer = 0;
                                   NewTop  : Integer = 0 );

var  TopPanelsHeight,
     StatusBarHeight,
     MaxBottom,
     MaxRight : Integer;

begin
     If   NewLeft=0
     then NewLeft := Left;

     If   NewTop=0
     then NewTop := Top;

     If   NewLeft<0
     then NewLeft := 0
     else begin
          MaxRight := Application.MainForm.Width - Width - 10;
          If   NewLeft>MaxRight
          then NewLeft := MaxRight;
          end;

     With ApplicationContainer do
       begin
       TopPanelsHeight := GetDesktopTop { GetMainPanelsHeight( True ) } + 3;
       If   Assigned( MainStatusBar ) and Assigned( MainStatusBar.Control )
       then StatusBarHeight := MainStatusBar.Control.Height
       else StatusBarHeight := 34; // Un valor por defecto
       end;

     MaxBottom := Application.MainForm.Height - Height - ( StatusBarHeight * 2 );
     If   NewTop>MaxBottom
     then NewTop := MaxBottom;
     If   NewTop<TopPanelsHeight
     then NewTop := TopPanelsHeight;

     SetBounds( NewLeft, NewTop, Width, Height );
end;

procedure TTecladoFrame.Panel1MouseMove( Sender: TObject;Shift: TShiftState; X, Y: Integer);

var  NewLeft,
     NewTop : Integer;

begin
     If   FMovingFrame and not FSettingPos
     then try
            FSettingPos := True;
            NewLeft := Left + ( X - FFrameX );
            NewTop := Top  + ( Y - FFrameY );
            UpdatePos( NewLeft, NewTop );
          finally
            FSettingPos := False;
            end;
end;

procedure TTecladoFrame.Panel1MouseUp(Sender: TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
      FMovingFrame := False;
end;

procedure TTecladoFrame.SpeedButton14Click(Sender: TObject);
begin
     Delete( FTextoValorInterno, Length( FTextoValorInterno ), 1 );
     ActualizaValorInterno
end;

procedure TTecladoFrame.ResultadoClick(Sender: TObject);
begin
     AplicaOperacion;
end;

procedure TTecladoFrame.AplicaOperacion;

var  Resultado : Currency;

begin
     Case FOperacion of
       opSuma     : Resultado := FValorOperacion + FValor;
       opResta    : Resultado := FValorOperacion - FValor;
       opProducto : Resultado := FValorOperacion * FValor;
       opDivision : If   FValor<>0.0
                    then Resultado := FValorOperacion / FValor
                    else Resultado := 0.0;
       else         Exit;
       end;
     FTextoValorInterno := FloatToStr( Resultado );
     ActualizaValorInterno;
     FOperacion := opNinguna;
end;

procedure TTecladoFrame.SpeedButton22Click(Sender: TObject);
begin
     Add( Chr( ( Sender as TComponent ).Tag ) );
end;

procedure TTecladoFrame.SpeedButton25Click(Sender: TObject);
begin
     AplicaOperacion;  
     FijaOperacion( opSuma );
end;

procedure TTecladoFrame.FijaOperacion( Operacion : TOperacion );
begin
     FValorOperacion := FValor;
     FOperacion := Operacion;
     FTextoValorInterno := '';
end;

procedure TTecladoFrame.SpeedButton26Click(Sender: TObject);

var Index : SmallInt;

begin
     ResultadoClick( nil );
     {
     If   Assigned( FLastActiveControl )
     then FLastActiveControl.SetFocus;
     }
     For Index :=  1 to Length( FTextoValorInterno ) do
       If   FTextoValorInterno[ Index ]=','
       then KeyEvent( VK_OEM_COMMA )
       else KeyEvent( Ord( FTextoValorInterno[ Index ] ) );
     KeyEvent( VK_TAB );
     Limpia;
end;

procedure TTecladoFrame.SpeedButton28Click(Sender: TObject);
begin
     FijaOperacion( opDivision );
end;

procedure TTecladoFrame.Limpia;
begin
     FTextoValorInterno := '';
     FOPeracion := opNinguna;
     ActualizaValorInterno;
end;

procedure TTecladoFrame.CalculadoraButtonClick(Sender: TObject);
begin
     PageControl.ActivePageIndex := 0;     
end;

procedure TTecladoFrame.ClearButtonClick(Sender: TObject);
begin
     Limpia;
end;

procedure TTecladoFrame.SpeedButton29Click(Sender: TObject);
begin
     FijaOperacion( opProducto );
end;

procedure TTecladoFrame.SpeedButton2Click(Sender: TObject);
begin
     KeyEvent( Vk_Tab, [ ssShift ] );
end;

procedure TTecladoFrame.LeftRightButtonClick(Sender: TObject);
begin
     FIzquierda := not FIzquierda;
     ActualizaPosicion;
end;

procedure TTecladoFrame.SpeedButton30Click(Sender: TObject);
begin
     FijaOperacion( opResta );
end;

procedure TTecladoFrame.SpeedButton35Click(Sender: TObject);
begin
    KeyEvent( VK_Escape );
end;

procedure TTecladoFrame.SpeedButton36Click(Sender: TObject);
begin
     KeyEvent( VK_DELETE );
end;

procedure TTecladoFrame.SpeedButton37Click(Sender: TObject);
begin
     KeyEvent( VK_TAB );
end;

procedure TTecladoFrame.SpeedButton3Click(Sender: TObject);
begin
     KeyEvent( VK_SUBTRACT );
end;

procedure TTecladoFrame.SpeedButton40Click(Sender: TObject);
begin
     KeyEvent( VK_UP );
end;

procedure TTecladoFrame.SpeedButton41Click(Sender: TObject);
begin
     KeyEvent( VK_DOWN );
end;

procedure TTecladoFrame.NumericButtonClick(Sender: TObject);
begin
     KeyEvent( ( Sender as TComponent ).Tag );
end;

procedure TTecladoFrame.SpeedButton5Click(Sender: TObject);
begin
     KeyEvent( VK_BACK );end;

procedure TTecladoFrame.SpeedButton6Click(Sender: TObject);
begin
     KeyEvent( VK_OEM_COMMA );
end;

procedure TTecladoFrame.CambiaModo( Value : SmallInt );
begin
     If  Value=0
     then Height := 280
     else Height := 312;
     PageControl.ActivePageIndex := Value;
end;

procedure TTecladoFrame.ModoButtonClick(Sender: TObject);
begin
     CambiaModo( PageControl.ActivePageIndex xor 1 );
     ActualizaPosicion;
end;

procedure TTecladoFrame.UpDownButtonClick(Sender: TObject);
begin
     FArriba:= not FArriba;
     ActualizaPosicion;
end;

procedure TTecladoFrame.ActualizaPosicion;
begin
     Anchors := [];
     If   FIzquierda
     then begin
          Left := 1;
          Anchors := Anchors +  [ akLeft ];
          end
     else begin
          Left := GetDesktopWidth - Width;
          Anchors := Anchors + [ akRight ];
          end;
     If   FArriba
     then begin
          Top := GetDesktopTop + 1;
          Anchors := Anchors + [ akTop ];
          end
     else begin
          Top := GetDesktopTop + GetDesktopHeight - Height;
          Anchors := Anchors + [ akBottom ];
          end;
end;

end.
