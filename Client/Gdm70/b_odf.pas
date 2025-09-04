unit b_odf;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes,
     ExtCtrls, Generics.Collections,

  AppContainer,

  Grids, Menus, cxLookAndFeelPainters, cxGraphics, DB, nxdb,
  DataManager, cxMaskEdit, cxDropDownEdit, cxDBEdit, cxIndexedComboBox,
  cxCurrencyEdit, cxButtons, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxLookAndFeels, dxSkinsCore, cxLabel, cxGroupBox, dxSkinsDefaultPainters,

  cxSpinEdit, cxDurationEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
  cxIntegerEdit, cxCalendar, cxCheckBox, dxDateRanges, GridTableViewController, cxDBLabel,

  LibUtils,
  AppForms,
  Gim30Fields,
  Gim70Fields,

  dmi_odf,

  b_odf_1, cxScrollBox;

type
  TBoxOdfForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    NroOrdenCtrl: TcxDBIntegerEdit;
    OrdenFabricacionTable: TnxeTable;
    dataPanel: TgxEditPanel;
    OrdenFabricacionDataSource: TDataSource;
    codigoCtrlCaption: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    HeaderGroupBox: TcxGroupBox;
    LineaOFOperacionTable: TnxeTable;
    LineaOFOperacionDataSource: TDataSource;
    LineaOFOperacionTableEjercicio: TSmallintField;
    LineaOFOperacionTableTipo: TSmallintField;
    LineaOFOperacionTableNroOrden: TIntegerField;
    LineaOFOperacionTableNroProceso: TSmallintField;
    LineaOFOperacionTableCodigoOperacion: TWideStringField;
    LineaOFOperacionTableOperacionExterna: TBooleanField;
    LineaOFOperacionTableCodigoSubcontratista: TWideStringField;
    LineaOFOperacionTableCodigoMaquina: TWideStringField;
    LineaOFOperacionTableTurno: TSmallintField;
    LineaOFOperacionTableFechaInicio: TDateField;
    LineaOFOperacionTableFechaFinalizacion: TDateField;
    LineaOFOperacionTableObservaciones: TWideStringField;
    LineaOFOperacionTableDescripcion: TWideStringField;
    EstadoLabel: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    cxLabel3: TcxLabel;
    DescPedidoLabel: TcxLabel;
    cxLabel1: TcxLabel;
    DescArticuloLabel: TcxLabel;
    cxLabel2: TcxLabel;
    Label2: TcxLabel;
    PrioridadLabel: TcxLabel;
    cxGroupBox4: TcxGroupBox;
    capClaseALabel: TcxLabel;
    DescClaseALabel: TcxLabel;
    cxGroupBox3: TcxGroupBox;
    capClaseBLabel: TcxLabel;
    DescClaseBLabel: TcxLabel;
    cxGroupBox5: TcxGroupBox;
    capClaseCLabel: TcxLabel;
    DescClaseCLabel: TcxLabel;
    CodigoArticuloCtrl: TcxDBLabel;
    CodigoClaseACtrl: TcxDBLabel;
    CodigoClaseBCtrl: TcxDBLabel;
    CodigoClaseCCtrl: TcxDBLabel;
    LoteCtrl: TcxDBLabel;
    UnidadesAFabricarCtrl: TcxDBLabel;
    CargasCtrl: TcxDBLabel;
    FechaCtrl: TcxDBLabel;
    DescPrioridadLabel: TcxLabel;
    ProcesosPanel: TcxScrollBox;
    EjercicioCtrl: TcxDBSpinEdit;
    EjercicioPedidoLabel: TcxLabel;
    NroPedidoLabel: TcxLabel;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure OrdenFabricacionTableGetRecord(DataSet: TDataSet);
    procedure NroOrdenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure OrdenFabricacionTableSetKey(DataSet: TDataSet);
    procedure FormManagerReportFormRequest;
    procedure FormManagerDestroyForm;
    procedure ProcesosPanelEnter(Sender: TObject);
    procedure EjercicioCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerPreparedForm;

  private

    OrdenFabricacionFields : TOrdenFabricacionFields;
    LineaOFOperacionFields : TLineaOFOperacionFields;

    ArticuloFields : TArticuloFields;
    MovimientoFields : TMovimientoFields;

    FEstadoOrdenFabricacion : TEstadoOrdenFabricacion;
    FOrdenCompletada,
    FAjusteCompletado : Boolean;
    FUnidades : Decimal;
    FBoxFrameList : TList<TBoxOdf1Frame>;

    procedure RefreshRecord;
    procedure FocusFirstPanel;
    procedure MuestraSituacionOrden;

  public
  end;

var
  BoxOdfForm: TBoxOdfForm = nil;

procedure SituacionOrdenFabricacion( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Graphics,
       SysUtils,
       DateUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm70Dm,
       Gdm70Frm,

       b_msg,
       b_pro,

       dmi_mov,
       dmi_cpr,

       dm_odf,
       dm_mov,
       dm_cpr,
       dm_cli,
       dm_cls,
       dm_art,
       dm_lmp,
       dm_maq,
       dm_pro,
       dm_opc,

       cx_odf,

       r_odf;

resourceString
    RsMsg1 = 'Solo puede especificar órdenes de fabricación del ejercicio anterior o actual.';

procedure SituacionOrdenFabricacion( KeyValues : array of const );
begin
     CreateEditForm( TBoxOdfForm, BoxOdfForm, KeyValues, Gds70Frm.ProduccionSection );
end;

procedure TBoxOdfForm.FormManagerDestroyForm;
begin
     FBoxFrameList.Free;
end;

procedure TBoxOdfForm.FormManagerInitializeForm;
begin

     FBoxFrameList := TList<TBoxOdf1Frame>.Create;

     OrdenFabricacionFields := TOrdenFabricacionFields.Create( OrdenFabricacionTable );
     LineaOFOperacionFields := TLineaOFOperacionFields.Create( LineaOFOperacionTable );

     ArticuloFields := TArticuloFields.Create( Self );
     MovimientoFields := TMovimientoFields.Create( Self );

     Clase.SetupEditControls( CodigoClaseACtrl, CodigoClaseBCtrl, CodigoClaseCCtrl, 0, True );

     OrdenFabricacionTable.SetDefaultRangeValues( [ ApplicationContainer.Ejercicio - 1, moOrden ], [ ApplicationContainer.Ejercicio, moOrden ] );
     SetFieldRange( OrdenFabricacionFields.NroOrden );

end;

procedure TBoxOdfForm.FormManagerPreparedForm;
begin
     MuestraSituacionOrden;
end;

procedure TBoxOdfForm.FormManagerReportFormRequest;
begin
     InformeOrdenesFabricacion( OrdenFabricacionFields.NroOrden.Value, True );
end;

procedure TBoxOdfForm.FormManagerReportRequest;
begin
     InformeOrdenesFabricacion( OrdenFabricacionFields.NroOrden.Value );
end;

procedure TBoxOdfForm.OrdenFabricacionTableSetKey(DataSet: TDataSet);
begin
     OrdenFabricacionFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
end;

procedure TBoxOdfForm.ProcesosPanelEnter(Sender: TObject);
begin
     If   ProcesosPanel.IsFocused
     then FocusFirstPanel;
end;

procedure TBoxOdfForm.NroOrdenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOrdenesFabricacion( ApplicationContainer.Ejercicio, Sender, qgsLinked );
end;

procedure TBoxOdfForm.RefreshRecord;
begin
     OrdenFabricacionTable.Refresh;
end;

procedure TBoxOdfForm.EjercicioCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Ejercicio : SmallInt;

begin
     Ejercicio := VarToInteger( DisplayValue );
     If   ( Ejercicio<>ApplicationContainer.Ejercicio ) and
          ( Ejercicio<>ApplicationContainer.Ejercicio - 1 )
     then begin
          Error := True;
          ErrorText := RsMsg1;
          end;
end;

procedure TBoxOdfForm.FocusFirstPanel;
begin
     If   FBoxFrameList.Count>0
     then FBoxFrameList[ 0 ].SetFocus;
end;

procedure TBoxOdfForm.OrdenFabricacionTableGetRecord(DataSet: TDataSet);
begin
     MuestraSituacionOrden;
end;

procedure TBoxOdfForm.MuestraSituacionOrden;

var  BoxFrameCount : SmallInt;
     BoxFrame : TBoxOdf1Frame;
     TextoOperador : String;

     DecimalesCantidad : SmallInt;

     StockContenedor,
     StockDefectuosas,
     CantidadPendiente,
     CantidadFinal,
     ExtraidasIncorporadas,
     MermasExcesos,
     StockSubcontratista : IExistenciasContenedor;

function LastVisibleFrame : SmallInt;

var  Count : SmallInt;

begin
     Count := -1;
     For var Frame in FBoxFrameList do
       If   Frame.Visible
       then Inc( Count )
       else Break;
     Result := Count;
end;

begin

     If   FormManager.FormPrepared and Assigned( OrdenFabricacionFields ) and not OrdenFabricacionFields.Ejercicio.IsNull
     then With OrdenFabricacionFields do
            begin

            FEstadoOrdenFabricacion := OrdenFabricacion.Estado( Ejercicio.Value, Tipo.Value, NroOrden.Value );
            EstadoLabel.Caption := OrdenFabricacion.TextoEstado( FEstadoOrdenFabricacion );

            case FEstadoOrdenFabricacion of
              eoNoIniciada  : EstadoLabel.Style.TextColor := clIconGreen;
              eoEnCurso     : EstadoLabel.Style.TextColor := clIconOrange;
              eoFinalizada,
              eoCerrada     : EstadoLabel.Style.TextColor := clIconRed;
              end;

            Movimiento.ObtenMovimiento( tmPedidoVenta, Ejercicio.Value, '', NroPedido.Value, MovimientoFields );

            If   OrdenFabricacionFields.NroPedido.Value<>0
            then begin
                 EjercicioPedidoLabel.Caption := IntToStr( OrdenFabricacionFields.EjercicioPedido.Value );
                 NroPedidoLabel.Caption := IntToStr( OrdenFabricacionFields.NroPedido.Value );
                 DescPedidoLabel.Caption := StrFormatDate( MovimientoFields.Fecha.Value ) + ', ' + Cliente.Descripcion( MovimientoFields.Propietario.Value )
                 end
            else begin
                 EjercicioPedidoLabel.Caption := '';
                 NroPedidoLabel.Caption := '';
                 DescPedidoLabel.Caption := '';
                 end;

            DescArticuloLabel.Caption := Articulo.Descripcion( CodigoArticulo.Value, True,  ArticuloFields );

            var ListaClasesLabel : TcxCustomEditArray := [ CodigoClaseACtrl, CodigoClaseBCtrl, CodigoClaseCCtrl ];
            For var Control in ListaClasesLabel do
              If   Control.Enabled and Assigned( TcxDBTextEditDataBinding( Control.DataBinding ).Field )
              then TcxLabel( Control.DescriptionLabel ).Caption := Clase.Descripcion( Control.Tag,
                                                                   TcxDBTextEditDataBinding( Control.DataBinding ).Field.Value,
                                                                   True );

            DescPrioridadLabel.Caption := OrdenFabricacion.TextoPrioridad( Prioridad.Value );

            try

              ProcesosPanel.VertScrollBar.Visible := False;

              // Oculto todos los sub-paneles del registro anterior

              For var Inx := FBoxFrameList.Count - 1 downto 0 do
                FreeAndNil( FBoxFrameList[ Inx ] );
              FBoxFrameList.Clear;

              // Muestro los nuevos paneles de las operaciones

              BoxFrameCount := 0;

              With LineaOFOperacionTable do
                begin

                // Ejercicio;Tipo;NroOrden;NroProceso

                With OrdenFabricacionFields do
                  SetRange( [ Ejercicio.Value, Tipo.Value, NroOrden.Value, 1 ], [ Ejercicio.Value, Tipo.Value, NroOrden.Value, MaxSmallint ] );

                First;

                While not Eof do
                  begin

                  BoxFrame := TBoxOdf1Frame.Create( Self );
                  FBoxFrameList.Add( BoxFrame );

                  BoxFrame.Visible := False;
                  BoxFrame.Name := 'BoxFrame' + IntToStr( FBoxFrameList.Count );
                  BoxFrame.Parent := ProcesosPanel;
                  BoxFrame.Align := alTop;

                  BoxFrame.Top := BoxFrame.Height * FBoxFrameList.Count;

                  BoxFrame.NroProcesoLabel.Caption := IntToStr( LineaOFOperacionFields.NroProceso.Value );
                  BoxFrame.OperacionLabel.Caption := LineaOFOperacionFields.CodigoOperacion.Value + ', ' + Operacion.Descripcion( LineaOFOperacionFields.CodigoOperacion.Value );
                  BoxFrame.FechaInicioLabel.Caption := StrFormatDate( LineaOFOperacionFields.FechaInicio.Value );
                  BoxFrame.FechaFinalizacionLabel.Caption := StrFormatDate( LineaOFOperacionFields.FechaFinalizacion.Value );

                  // Cantidad pendiente (el proceso 0 existe, y contiene la cantidad inicial a procesar)

                  CantidadPendiente := Contenedor.ContenidoProceso( OrdenFabricacionFields.EjercicioLanzamiento.Value,
                                                                    OrdenFabricacionFields.NroOrden.Value,
                                                                    LineaOFOperacionFields.NroProceso.Value - 1,
                                                                    cnProductoAcabadoCorrecto );

                  StockContenedor  := Contenedor.ContenidoProceso( OrdenFabricacionFields.EjercicioLanzamiento.Value,
                                                                   OrdenFabricacionFields.NroOrden.Value,
                                                                   LineaOFOperacionFields.NroProceso.Value,
                                                                   [ cnProductoCorrecto ] );

                  StockDefectuosas := Contenedor.ContenidoProceso( OrdenFabricacionFields.EjercicioLanzamiento.Value,
                                                                   OrdenFabricacionFields.NroOrden.Value,
                                                                   LineaOFOperacionFields.NroProceso.Value,
                                                                   [ cnProductoDefectuoso ]  );

                  CantidadFinal := Contenedor.ContenidoProceso( OrdenFabricacionFields.EjercicioLanzamiento.Value,
                                                                OrdenFabricacionFields.NroOrden.Value,
                                                                LineaOFOperacionFields.NroProceso.Value,
                                                                cnProductoAcabadoCorrecto );

                  DecimalesCantidad := DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value;

                  BoxFrame.CantidadPendienteLabel.Caption := StrFormat( CantidadPendiente.Entradas, DecimalesCantidad );
                  BoxFrame.CantidadContenedorLabel.Caption := StrFormat( StockContenedor.Entradas, DecimalesCantidad );

                  BoxFrame.DefectuosasImage.Visible := StockDefectuosas.Saldo<>0.0;
                  BoxFrame.StockDefectuosasLabel.Visible := BoxFrame.DefectuosasImage.Visible;
                  BoxFrame.DefectuosasHint.Visible := BoxFrame.DefectuosasImage.Visible;
                  If   BoxFrame.DefectuosasImage.Visible
                  then BoxFrame.StockDefectuosasLabel.Caption := StrFormat( StockDefectuosas.Saldo, DecimalesCantidad );

                  ExtraidasIncorporadas := Contenedor.ContenidoProceso( OrdenFabricacionFields.EjercicioLanzamiento.Value,
                                                                        OrdenFabricacionFields.NroOrden.Value,
                                                                        LineaOFOperacionFields.NroProceso.Value,
                                                                        [ cnExtraccionesIncorporaciones ]  );

                  BoxFrame.ExtraidasImage.Visible := ExtraidasIncorporadas.Saldo<0.0;
                  BoxFrame.ExtraidasLabel.Visible := BoxFrame.ExtraidasImage.Visible;
                  BoxFrame.ExtraidasHint.Visible := BoxFrame.ExtraidasImage.Visible;
                  If   BoxFrame.ExtraidasImage.Visible
                  then BoxFrame.ExtraidasLabel.Caption := StrFormat( Abs( ExtraidasIncorporadas.Saldo ), DecimalesCantidad );

                  BoxFrame.IncorporadasImage.Visible := ExtraidasIncorporadas.Saldo>0.0;
                  BoxFrame.IncorporadasLabel.Visible := BoxFrame.IncorporadasImage.Visible;
                  BoxFrame.IncorporadasHint.Visible := BoxFrame.IncorporadasImage.Visible;

                  If   BoxFrame.IncorporadasImage.Visible
                  then BoxFrame.IncorporadasLabel.Caption := StrFormat( ExtraidasIncorporadas.Saldo, DecimalesCantidad );

                  MermasExcesos := Contenedor.ContenidoProceso( OrdenFabricacionFields.EjercicioLanzamiento.Value,
                                                                OrdenFabricacionFields.NroOrden.Value,
                                                                LineaOFOperacionFields.NroProceso.Value,
                                                                [ cnMermaExceso ]  );

                  BoxFrame.MermasExcesosImage.Visible := MermasExcesos.Saldo<>0.0;
                  BoxFrame.MermasExcesosLabel.Visible := BoxFrame.MermasExcesosImage.Visible;
                  If   BoxFrame.MermasExcesosImage.Visible
                  then BoxFrame.MermasExcesosLabel.Caption := StrFormat( Abs( MermasExcesos.Saldo ), DecimalesCantidad );

                  BoxFrame.StockSubcontratistaLabel.Visible := LineaOFOperacionFields.OperacionExterna.Value;

                  If   LineaOFOperacionFields.OperacionExterna.Value
                  then begin

                       TextoOperador := LineaOFOperacionFields.CodigoSubcontratista.Value + ' - ' + Proveedor.Descripcion( LineaOFOperacionFields.CodigoSubcontratista.Value );

                       // Cantidad en el contenedor del subcontratista

                       StockSubcontratista := Contenedor.ContenidoProceso( OrdenFabricacionFields.EjercicioLanzamiento.Value,
                                                                           OrdenFabricacionFields.NroOrden.Value,
                                                                           LineaOFOperacionFields.NroProceso.Value,
                                                                           [ cnProductoSubcontratista ] );

                       BoxFrame.StockSubcontratistaLabel.Caption := StrFormat( StockSubcontratista.Saldo, DecimalesCantidad );
                       BoxFrame.TareaPanel.Style.Color := clLightOrange;
                       end
                  else begin
                       TextoOperador := LineaOFOperacionFields.CodigoMaquina.Value + ' - ' + Maquina.Descripcion( LineaOFOperacionFields.CodigoMaquina.Value );
                       BoxFrame.TareaPanel.Style.Color := clCream;
                       end;

                  BoxFrame.OperadorLabel.Caption := TextoOperador;
                  BoxFrame.UltimoProcesoPanel.Visible := False;
                  BoxFrame.CantidadFinalPanel.Visible := False;

                  BoxFrame.Visible := True;

                  Inc( BoxFrameCount );

                  If   CantidadFinal.Salidas=0.0   // Aún no se ha fabricado nada. No muestro el resto de los procesos
                  then Break
                  else Next;

                  end;
                end;

              var Lvf := LastVisibleFrame;
              If   Lvf>=0
              then With FBoxFrameList[ Lvf ] do
                     If   CantidadFinal.Saldo=0.0
                     then UltimoProcesoPanel.Visible := True
                     else begin
                          CantidadFinalPanel.Visible := True;
                          CantidadFinalLabel.Caption := StrFormat( CantidadFinal.Saldo, DecimalesCantidad );

                          If   FEstadoOrdenFabricacion in [ eoFinalizada, eoCerrada ]
                          then CantidadFinalLabel.Style.TextColor:= clGreen
                          else CantidadFinalLabel.Style.TextColor:= clGray;

                          end;

            finally
              ProcesosPanel.Realign;
              ProcesosPanel.VertScrollBar.Visible := True;
              end;

            end;
end;

end.
