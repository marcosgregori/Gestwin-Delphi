
unit b_sup;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons, Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, dxmdaset,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox, dxUIAClasses,

  nxdb,

  AppContainer,
  DataManager,

  Gim30Fields;


type
    TBoxSupForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    DataSource: TDataSource;
    Data: TgxMemData;
    DataSerie: TWideStringField;
    DataNroPedidoInicial: TIntegerField;
    DataNroPedidoFinal: TIntegerField;
    gxRangeBox1: TgxRangeBox;
    SerieCtrl: TcxDBTextEdit;
    NroPedidoInicialCtrl: TcxDBTextEdit;
    NroPedidoFinalCtrl: TcxDBTextEdit;
    MovimientoTable: TnxeTable;
    Label6: TcxLabel;
    DesTipoAstoLabel: TcxLabel;
    Label7: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    SeriePanel: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure NroPedidoFinalCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroPedidoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    private

    public

      MovimientoFields : TMovimientoFields;

      procedure DoProcess;
    end;

var BoxSupForm : TBoxSupForm = nil;

procedure SupresionPedidosVenta;


implementation

uses   LibUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dmi_mov,

       dm_sdf,
       dm_mov,

       b_msg,
       b_pro,

       cx_sdf,
       cx_mve,

       f_prg;

{$R *.DFM}

resourceString
       RsMsg2 = 'Pedido nº %d.';

procedure SupresionPedidosVenta;
begin
     CreateEditForm( TBoxSupForm, BoxSupForm, TGds30Frm.VentasSection, True );
end;

procedure TBoxSupForm.FormManagerOkButton;
begin
     CreateProcessForm( DoProcess, Caption );
end;

procedure TBoxSupForm.NroPedidoFinalCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With NroPedidoFinalCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := DataNroPedidoInicial.Value;
end;

procedure TBoxSupForm.NroPedidoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMovimientosVenta( tmVenta, sdTodos, DataSerie,Sender );
end;

procedure TBoxSupForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxSupForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxSupForm.DoProcess;
begin

     try

       try

        With MovimientoTable do
         begin

         SetRange( [ tmPedidoVenta, ApplicationContainer.Ejercicio, DataSerie.Value, DataNroPedidoInicial.Value ],
                   [ tmPedidoVenta, ApplicationContainer.Ejercicio, DataSerie.Value, DataNroPedidoFinal.Value ] );
         First;
         While not Eof  do
           begin
           Movimiento.SuprimeMovimiento( MovimientoFields.Ejercicio.Value, MovimientoFields.NroOperacion.Value );
           ProcessFrame.AddMsg( ntInformation, Format( RsMsg2, [ MovimientoFields.NroDocumento.Value ] ) );
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

      finally
        end;

end;

procedure TBoxSupForm.FormManagerInitializeForm;
begin
     MovimientoFields := TMovimientoFields.Create( MovimientoTable );

     SetupPanelableCtrl( SerieCtrl, Movimiento.SeriesEnDocumentosVenta( tmPedidoVenta ) );
     If   SerieCtrl.Enabled
     then SerieFacturacion.AplicaRestriccionSerie( SerieCtrl );
end;

end.
