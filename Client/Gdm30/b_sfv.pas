
unit b_sfv;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,

  Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, nxdb, DataManager, DB,
  dxmdaset, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,

  Gim30Fields, dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox, dxUIAClasses;


type
    TBoxSfvForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    gxRangeBox1: TgxRangeBox;
    SerieCtrl: TcxDBTextEdit;
    NroFacturaInicialCtrl: TcxDBTextEdit;
    NroFacturaFinalCtrl: TcxDBTextEdit;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataSerie: TWideStringField;
    DataNroFacturaInicial: TIntegerField;
    DataNroFacturaFinal: TIntegerField;
    FacturaVentasTable: TnxeTable;
    Label6: TcxLabel;
    DescSerieLabel: TcxLabel;
    Label7: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure NroFacturaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure NroFacturaFinalCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    private

    public

      FacturaVentasFields : TFacturaVentasFields;

      procedure DoProcess;
    end;

var
  BoxSfvForm : TBoxSfvForm = nil;

procedure supresionFacturasVenta;


implementation

uses   LibUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm30Frm,

       dm_sdf,
       dm_fdv,
       dm_ecc,
       dm_ast,
       dm_tma,

       b_msg,
       b_pro,

       cx_sdf,
       cx_fdv,

       f_prg;

{$R *.DFM}

resourceString
       RsMsg1 = 'Suprimiendo facturas.';
       RsMsg2 = 'Factura nº %d.';
       RsMsg3 = 'La factura nº %d consta como contabilizada. No será suprimida.';
       RsMsg5 = 'Realizando el proceso de supresión de facturas de venta.';

procedure supresionFacturasVenta;
begin
     CreateEditForm( TBoxSfvForm, BoxSfvForm, TGds30Frm.VentasSection, True );
end;

procedure TBoxSfvForm.FormManagerOkButton;
begin
     CreateProcessForm( DoProcess, caption );
end;

procedure TBoxSfvForm.NroFacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFacturasVenta( DataSerie, Sender );
end;

procedure TBoxSfvForm.NroFacturaFinalCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With NroFacturaFinalCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := DataNroFacturaInicial.Value;
end;

procedure TBoxSfvForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxSfvForm.SerieCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxSfvForm.DoProcess;
begin

     With ProcessFrame do
       try

         Canceled := False;

         AddMsg( ntInformation, RsMsg5 );
         AddMsg( ntInformation, RsMsg1 );

         With FacturaVentasTable do
           begin
           SetRange( [ ApplicationContainer.Ejercicio, DataSerie.Value, DataNroFacturaInicial.Value ],
                     [ ApplicationContainer.Ejercicio, DataSerie.Value, DataNroFacturaFinal.Value ] );
           First;
           While not Eof and not Canceled do
             begin

            With FacturaVentasFields do
              If   Traspasada.Value
              then AddMsg( ntWarning, Format( RsMsg3, [ NroFactura.Value ] ) )
              else begin
                   AddMsg( ntInformation, Format( RsMsg2, [ NroFactura.Value ] ) );
                   FacturaVentas.SuprimeFactura( Serie.Value, NroFactura.Value )
                   end;

            Next;
            end;

          end;

       except on E : Exception do
         begin
         If   not ( E is EDatabaseError )
         then ShowException( E, Self );
         ShowNotification( ntStop, RsgMsg436, RsgMsg437 );
         end;
       end;

end;

procedure TBoxSfvForm.FormManagerInitializeForm;
begin
     FacturaVentasFields := TFacturaVentasFields.Create( FacturaVentasTable );

     SerieFacturacion.AplicaRestriccionSerie( SerieCtrl );

     Asiento.CompruebaEjercicioCerrado;
end;

end.
