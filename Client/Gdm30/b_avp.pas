
unit b_avp;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,

  AppContainer,

  Mask,
  ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, DB, nxdb,
  DataManager, cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit,
  cxCheckBox, cxControls, cxContainer, cxEdit, cxTextEdit, dxmdaset,

  dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLabel, cxGroupBox,

  Gim10Fields,
  Gim30Fields, cxSpinEdit, dxUIAClasses;


type
    TBoxAvpForm = class(TgxForm)
    DataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    ClienteInicialCtrl: TcxDBTextEdit;
    ClienteFinalCtrl: TcxDBTextEdit;
    VentaPeriodicaTable: TnxeTable;
    SerieCtrl: TcxDBTextEdit;
    LineaVentaPeriodicaTable: TnxeTable;
    SuprimirCtrl: TcxDBCheckBox;
    FechaCtrl: TcxDBDateEdit;
    gxRangeBox2: TgxRangeBox;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataSerie: TWideStringField;
    DataClienteInicial: TWideStringField;
    DataClienteFinal: TWideStringField;
    DataSuprimirPrecios: TBooleanField;
    DataFecha: TDateField;
    Label7: TcxLabel;
    Label6: TcxLabel;
    DescSerieLabel: TcxLabel;
    Label3: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    cxDBCheckBox1: TcxDBCheckBox;
    DataActualizarDescripciones: TBooleanField;
    DataTipo: TSmallintField;
    cxLabel2: TcxLabel;
    TipoCtrl: TcxDBSpinEdit;
    DescTipoLabel: TcxLabel;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TipoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure TipoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    private

      ArticuloFields : TArticuloFields;

    public

      VentaPeriodicaFields : TVentaPeriodicaFields;
      LineaVentaPeriodicaFields : TLineaVentaPeriodicaFields;

      procedure DoProcess;
    end;

var  BoxAvpForm : TBoxAvpForm = nil;

procedure ActualizaPreciosVentaPeriodica( UnCodigoCliente : String );


implementation

uses   LibUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm30Frm,

       dmi_mov,

       dm_sdf,
       dm_cli,
       dm_art,
       dm_mov,
       dm_tvp,
       
       a_vpe,
       a_sdf,
       a_cli,

       b_msg,
       b_pro,

       cx_cli,
       cx_sdf,
       cx_tvp,

       f_prg;

{$R *.DFM}

resourceString
       RsMsg2 = 'Ficha nº %d.';

var  CodigoCliente : String;

procedure ActualizaPreciosVentaPeriodica( UnCodigoCliente : String );
begin
     CodigoCliente := UnCodigoCliente;
     CreateEditForm( TBoxAvpForm, BoxAvpForm, [], TGds30Frm.VentasSection );
end;

procedure TBoxAvpForm.FormManagerOkButton;
begin
     CreateProcessForm( DoProcess, Caption );
end;

procedure TBoxAvpForm.SerieCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [ Sender.EditingValue ] );
end;

procedure TBoxAvpForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxAvpForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxAvpForm.TipoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposVentasPeriodicas( Sender );
end;

procedure TBoxAvpForm.TipoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     TipoVentaPeriodica.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxAvpForm.DoProcess;

var  FCantidad : Decimal;
     FPrecio : Double;
     FPuntoVerde,
     FRecargo,
     FDescuento : Decimal;
     EsUnaOferta : Boolean;
     TipoInicial,
     TipoFinal : SmallInt;
     
begin

     EnterpriseDataModule.StartTransaction( [ LineaVentaPeriodicaTable ] );

     try

       try

         If   DataTipo.Value=0
         then begin
              TipoInicial := 0;
              TipoFinal := 99;
              end
         else begin
              TipoInicial := DataTipo.Value;
              TipoFinal := DataTipo.Value;
              end;
         
        With VentaPeriodicaTable do
         begin
         SetRange( [ TipoInicial, DataSerie.Value, DataClienteInicial.Value ], [ TipoFinal, DataSerie.Value, DataClienteFinal.Value ] );
         First;
         While not Eof do
           begin

           With LineaVentaPeriodicaTable do
             begin

             ProcessFrame.AddRecordMsg( Format( RsMsg2, [ VentaPeriodicaFields.NroFicha.Value ] ) );

             With VentaPeriodicaFields do
               SetRange( [ NroFicha.Value, 1 ], [ NroFicha.Value, MaxSmallint ] );

             First;
             While not Eof do
               begin

               //* 13.01.2004 Añadida la opción de supresión de precios
               //* 27.03.2011 Añadida la opción de actualización de descripciones

               Edit;

               With LineaVentaPeriodicaFields do
                 If   CodigoArticulo.Value<>ArticuloManual
                 then begin

                      Articulo.Obten( CodigoArticulo.Value, ArticuloFields );

                      If   DataSuprimirPrecios.Value
                      then Precio.Value := 0.0
                      else begin

                           FPrecio := 0.0;
                           FPuntoVerde := 0.0;
                           FRecargo := 0.0;
                           FDescuento := 0.0;
                           EsUnaOferta := False;

                           Articulo.ObtenPrecioyDtoVenta( tmNoDefinido,
                                                          VentaPeriodicaFields.CodigoCliente.Value,
                                                          CodigoArticulo.Value,
                                                          CodigoClaseA.Value,
                                                          CodigoClaseB.Value,
                                                          CodigoClaseC.Value,
                                                          FCantidad,
                                                          FPrecio,
                                                          FPuntoVerde,
                                                          FRecargo,
                                                          FDescuento,
                                                          EsUnaOferta,
                                                          '',
                                                          False,
                                                          DataFecha.Value );

                           If   FPrecio<>0.0
                           then Precio.Value := FPrecio;

                           end;

                      If   DataActualizarDescripciones.Value
                      then Descripcion.Value := ArticuloFields.Descripcion.Value;

                      end;

               Post;

               Next;
               end;
             end;

           Next;
           end;

         end;

        EnterpriseDataModule.commit;

        except on E : Exception do 
          begin
          EnterpriseDataModule.RollBack;
          If   not ( E is EDatabaseError)
          then ShowException( E, Self );
          ShowNotification( ntStop, RsgMsg436, RsgMsg437 );
          end;
          
        end;

      finally
        If   Assigned( MntVpeForm )
        then MntVpeForm.GridView.DataController.UpdateItems( False );
        end;
        
end;

procedure TBoxAvpForm.FormManagerInitializeForm;
begin
     VentaPeriodicaFields := TVentaPeriodicaFields.Create( VentaPeriodicaTable );
     LineaVentaPeriodicaFields := TLineaVentaPeriodicaFields.Create( LineaVentaPeriodicaTable );

     ArticuloFields := TArticuloFields.Create( Self );

     If   CodigoCliente=''
     then DataClienteFinal.Value := HighStrCode
     else begin
          DataClienteInicial.Value := CodigoCliente;
          DataClienteFinal.Value := CodigoCliente;
          end;

     DataSuprimirPrecios.Value := False;
     DataFecha.Value := ApplicationContainer.TodayDate;
end;

procedure TBoxAvpForm.ClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TBoxAvpForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TBoxAvpForm.ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, nil, True );
end;

end.
