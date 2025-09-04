unit f_ecc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppContainer, StdCtrls, ExtCtrls,

  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,

  Gim10Fields, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxGroupBox, cxLabel;

type
  TEccFrame = class(TFrame)
    AmpliacionPanel: TcxGroupBox;
    GrupoFacturacionCtrl: TcxDBTextEdit;
    VendedorCtrl: TcxDBTextEdit;
    Label11: TcxLabel;
    Label12: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    procedure GrupoFacturacionCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GrupoFacturacionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GrupoFacturacionCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure VendedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private
   FOnClienteCtrlEditValueChanged : TNotifyEvent;
   procedure DoOnClienteCtrlPropertiesEditValueChanged(Sender: TObject);
  public

  end;

implementation

uses AppForms,
     AppManager,

     a_ecc,

     dm_gdc,
     dm_ven,
     dm_cli,

     a_ven,
     a_gdc,

     cx_gdc,
     cx_ven;

{$R *.dfm}

procedure SetupFrame;

var EccFrame : TEccFrame;

begin
     If   Assigned( MntEccForm )
     then begin

          EccFrame := TEccFrame.Create( MntEccForm );

          With EccFrame do
            begin

            AmpliacionPanel.Parent := MntEccForm.DatosTabSheet;
            AmpliacionPanel.Top := MntEccForm.DatosPanel.Height;
            AmpliacionPanel.Align := alClient;

            GrupoFacturacionCtrl.DataBinding.DataSource :=  MntEccForm.DataSource;
            VendedorCtrl.DataBinding.DataSource := MntEccForm.DataSource;
            FOnClienteCtrlEditValueChanged := MntEccForm.ClienteCtrl.Properties.OnEditValueChanged;
            MntEccForm.ClienteCtrl.Properties.OnEditValueChanged := DoOnClienteCtrlPropertiesEditValueChanged;

            MntEccForm.Height := MntEccForm.Height + EccFrame.Height;

            PlaceForm( MntEccForm );
            end;

          end;
end;

procedure TEccFrame.DoOnClienteCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   Assigned( FOnClienteCtrlEditValueChanged )
     then FOnClienteCtrlEditValueChanged(Sender );
     With MntEccForm do
       If   ClienteCtrl.Editing and
            ClienteFields.Initialized
       then begin
            GrupoFacturacionCtrl.PostEditValue( ClienteFields.Factura_Agrupacion.Value );
            VendedorCtrl.PostEditValue( ClienteFields.Vendedor.Value );
            end;

end;

procedure TEccFrame.GrupoFacturacionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntGruposCliente( [ GrupoFacturacionCtrl.EditingValue ] );
end;

procedure TEccFrame.GrupoFacturacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TEccFrame.GrupoFacturacionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then GrupoFacturacionCtrl.Description := rsgNinguno
     else GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TEccFrame.VendedorCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntVendedores( [ VendedorCtrl.EditingValue ] );
end;

procedure TEccFrame.VendedorCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TEccFrame.VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then VendedorCtrl.Description := rsgNinguno
     else Vendedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

initialization
  AddProcedure( imOnCreateComponent, idMntEccForm, SetupFrame );

end.
