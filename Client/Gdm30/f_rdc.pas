unit f_rdc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  DB,

  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox,

  LibUtils,

  Gim10Fields;

type
  TRiesgoFrame = class(TFrame)
    RiesgoPanel: TcxGroupBox;
    Label4: TcxLabel;
    Label9: TcxLabel;
    Label5: TcxLabel;
    Label2: TcxLabel;
    RiesgoLabel: TcxLabel;
    margenRiesgoLabel: TcxLabel;
    PendienteFacturarLabel: TcxLabel;
    margenCreditoLabel: TcxLabel;
    RiesgoTotalLabel: TcxLabel;
    Label3: TcxLabel;
  private

    Riesgo,
    PendienteFacturar,
    MargenRiesgo,
    MargenCredito   : Decimal;

  public

    procedure ActualizaContenido( ClienteFields : TClienteFields );
    procedure ActualizaEstado( ShowPanel : Boolean; NewRecord : Boolean = False );

  end;

function CreaRiesgoFrame( ParentContainer : TCustomControl ) : TRiesgoFrame;

implementation

uses Gim00Fields,
     AppManager,

     dm_rcl;

{$R *.dfm}

resourceString
     RsMsg1 = 'N/A';

function CreaRiesgoFrame( ParentContainer : TCustomControl ) : TRiesgoFrame;
begin
     var RiesgoFrame := TRiesgoFrame.Create( ParentContainer.Owner );
     If   Assigned( RiesgoFrame )
     then With RiesgoFrame do
            begin
            RiesgoPanel.Parent := ParentContainer;
            RiesgoPanel.Align := alNone;
            RiesgoPanel.Anchors := [ akRight, akTop ];
            RiesgoPanel.Top := 0;
            RiesgoPanel.Left := ParentContainer.Width - Width;
            end;
     Result := RiesgoFrame;
end;

procedure TRiesgoFrame.ActualizaContenido( ClienteFields : TClienteFields );
begin
     If  RiesgoPanel.Visible and
         Assigned( ClienteFields ) and
         ClienteFields.Initialized and
         not ValueIsEmpty( ClienteFields.Codigo.Value )
     then begin

          RelacionesCliente.ObtenRiesgoTotal( ClienteFields, Riesgo, PendienteFacturar );

          RiesgoLabel.Caption := StrFormat( Riesgo, DecimalesMoneda );

          MargenRiesgoLabel.Style.Font.Color := clNavy;

          If   ClienteFields.Cobro_RiesgoLimite.Value=0.0
          then MargenRiesgoLabel.Caption := RsMsg1
          else begin
               MargenRiesgo := ClienteFields.Cobro_RiesgoLimite.Value - Riesgo;
               MargenRiesgoLabel.Caption := StrFormat( MargenRiesgo, DecimalesMoneda );
               If   MargenRiesgo<0.0
               then MargenRiesgoLabel.Style.Font.Color := clMaroon;
               end;

          PendienteFacturarLabel.Caption := StrFormat( PendienteFacturar, DecimalesMoneda );

          MargenCreditoLabel.Style.Font.Color := clNavy;

          If   ClienteFields.Factura_Credito.Value=0.0
          then MargenCreditoLabel.Caption := RsMsg1
          else begin
               MargenCredito := ClienteFields.Factura_Credito.Value - PendienteFacturar;
               MargenCreditoLabel.Caption := StrFormat( MargenCredito, DecimalesMoneda );
               If   MargenCredito<0.0
               then MargenCreditoLabel.Style.Font.Color := clMaroon;
               end;

          RiesgoTotalLabel.Caption := StrFormat( Riesgo + PendienteFacturar, DecimalesMoneda );
          end;
end;

procedure TRiesgoFrame.ActualizaEstado( ShowPanel  : Boolean;
                                        NewRecord  : Boolean = False );
begin
     With RiesgoPanel do
       If   ShowPanel
       then begin
            Visible := True;               // Si se visualiza tras posicionarlo la primera vez todavía no está escalado
            Left := Parent.Width - Width;  // Por los posibles cambios de escala
            If   NewRecord
            then begin
                 RiesgoLabel.Caption := '';
                 MargenRiesgoLabel.Caption := '';
                 PendienteFacturarLabel.Caption := '';
                 MargenCreditoLabel.Caption := '';
                 RiesgoTotalLabel.Caption := '';
                 end;
            BringToFront;
            end
       else Visible := False;
end;

end.
