unit f_sdf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls, DB, nxDB, DataManager,

  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  cxCheckBox, cxMaskEdit, cxSpinEdit, cxCurrencyEdit,

  AppForms,
  
  Menus, cxLookAndFeelPainters, cxButtons, dxSkinsCore,
  dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels, cxLabel, cxGroupBox,
  dxUIAClasses;

type
  TMntSdfFrame = class(TFrame)
    AmpliacionPanel: TcxGroupBox;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label4: TcxLabel;
    capEmpresaLabel: TcxLabel;
    DescEmpresaLabel: TcxLabel;
    FormatoAlbaranLabel: TcxLabel;
    FormatoFacturaLabel: TcxLabel;
    FormatoReciboLabel: TcxLabel;
    ContabilizarCtrl: TcxDBCheckBox;
    Empresa_DestinoCtrl: TcxDBTextEdit;
    Afectar_StockCtrl: TcxDBCheckBox;
    FormatoAlbaranCtrl: TcxDBSpinEdit;
    FormatoFacturaCtrl: TcxDBSpinEdit;
    FormatoReciboCtrl: TcxDBSpinEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    FormatoPedidoCtrl: TcxDBSpinEdit;
    cxLabel3: TcxLabel;
    procedure FormatoAlbaranCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure FormatoFacturaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure FormatoReciboCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure FormatoAlbaranCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormatoFacturaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormatoReciboCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FormatoAlbaranCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormatoFacturaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormatoReciboCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Empresa_DestinoCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Empresa_DestinoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Empresa_DestinoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Afectar_StockCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure FormatoPedidoCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure FormatoPedidoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormatoPedidoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
  private
  protected
  end;

var MntSdfFrame : TMntSdfFrame = nil;

implementation

uses LibUtils,
     AppManager,
     EnterpriseDataAccess,

     Gim00Fields,

     Gim10Fields,
     Gim30Fields,

     a_sdf,
     dm_ine,
     dm_emp,
     dm_sdf,
     dm_cco,
     dm_sub,

     a_emp,
     a_imp,
     a_cco,
     a_sub,

     b_msg,

     cx_sdf,
     cx_imp,
     cx_emp,
     cx_cco,
     cx_sub;

{$R *.dfm}

resourceString
       RsMsg1  = 'Ha modificado la forma en que esta serie de facturación afecta a las existencias.';
       RsMsg2  = 'Recuerde que debe reconstruir los resultados si quiere que los movimientos existentes reflejen la nueva situación.';

procedure SetupFrame;

var Index : SmallInt;

begin
     If   Assigned( MntSdfForm )
     then begin

          MntSdfFrame := TMntSdfFrame.Create( MntSdfForm );

          With MntSdfFrame do
            begin

            MntSdfForm.HelpFile := 'hs30';

            // Colocando los paneles en su posición dentro de la ventana de edición

            AmpliacionPanel.Parent := MntSdfForm.DataPanel;
            AmpliacionPanel.Top := 300;
            AmpliacionPanel.TabOrder := 1;
            AmpliacionPanel.Align := alTop;

            MntSdfForm.Height := MntSdfForm.Height + AmpliacionPanel.Height;

            PlaceForm( MntSdfForm );
            end;

          end;
end;

procedure TMntSdfFrame.FormatoAlbaranCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impAlbaranesVenta ), Sender.EditingValue ] );
end;

procedure TMntSdfFrame.FormatoAlbaranCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impAlbaranesVenta, Sender );
end;

procedure TMntSdfFrame.FormatoAlbaranCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impAlbaranesVenta, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntSdfFrame.FormatoFacturaCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impFacturasVenta ), Sender.EditingValue ] );
end;

procedure TMntSdfFrame.FormatoFacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impFacturasVenta, Sender );
end;

procedure TMntSdfFrame.FormatoFacturaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impFacturasVenta, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntSdfFrame.FormatoPedidoCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impPedidosVenta ), Sender.EditingValue ] );
end;

procedure TMntSdfFrame.FormatoPedidoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impPedidosVenta, Sender );
end;

procedure TMntSdfFrame.FormatoPedidoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impPedidosVenta, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntSdfFrame.FormatoReciboCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntImpresos( [ Ord( impDocumentoCobro ), Sender.EditingValue ] );
end;

procedure TMntSdfFrame.FormatoReciboCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaImpresos( impDocumentoCobro, Sender );
end;

procedure TMntSdfFrame.FormatoReciboCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     InformeExterno.Valida( impDocumentoCobro, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntSdfFrame.Empresa_DestinoCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntEmpresas( [ Sender.EditingValue ] );
end;

procedure TMntSdfFrame.Empresa_DestinoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEmpresas( Sender );
end;

procedure TMntSdfFrame.Empresa_DestinoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Empresa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntSdfFrame.Afectar_StockCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   Afectar_StockCtrl.Editing and ( MntSdfForm.SerieFacturacionTable.State=dsEdit )
     then ShowNotification( ntWarning, RsMsg1, RsMsg2 );
end;

initialization
  AddProcedure( imOnCreateComponent, idMntSdfForm, SetupFrame );

end.

