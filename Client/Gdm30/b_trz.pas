unit b_trz;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics, Contnrs,

     AppContainer,

     Gim10Fields,
     Gim30Fields,

     cxStyles,
     cxCustomData,
     cxGraphics,
     cxFilter,
     cxData,
     cxDataStorage,
     cxEdit,
     DB,
     cxDBData,
     nxdb,
     DataManager,
     EnterpriseDataAccess,
     cxGridLevel,
     cxClasses,
     cxControls,
     Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox, cxLookAndFeels,
     cxContainer,
     dxSkinsCore,
     dxSkinsDefaultPainters,
     cxLabel,
     cxGroupBox,
     cxScrollBox,
     dxmdaset,
     DBCtrls,

     dmi_mov,
     dm_mov,
     f_doc, System.ImageList, Vcl.ImgList, cxImageList, dxUIAClasses;

type
  TBoxTrzForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Panel3: TcxGroupBox;
    CloseButton: TgBitBtn;
    DataPanel: TgxEditPanel;
    keyPanel: TcxGroupBox;
    Panel2: TcxGroupBox;
    Panel1: TcxGroupBox;
    ScrollBox: TcxScrollBox;
    Consulta: TnxeQuery;
    ConsultaEjercicio: TSmallintField;
    ConsultaNroOperacion: TIntegerField;
    ConsultaNroLinea: TSmallintField;
    ConsultaFecha: TDateField;
    ConsultaTipoMovimientoOrigen: TSmallintField;
    ConsultaEjercicioOrigen: TSmallintField;
    ConsultaNroOperacionOrigen: TIntegerField;
    ConsultaNroRegistroOrigen: TIntegerField;
    ConsultaUIDArticulo: TGuidField;
    ConsultaCodigoArticulo: TWideStringField;
    ConsultaCodigoClaseA: TWideStringField;
    ConsultaCodigoClaseB: TWideStringField;
    ConsultaCodigoClaseC: TWideStringField;
    ConsultaLoteFabricacion: TWideStringField;
    ConsultaNumeroSerie: TWideStringField;
    ConsultaDescripcion: TWideStringField;
    ConsultaCodigoAlmacen: TWideStringField;
    ConsultaUbicacion: TWideStringField;
    ConsultaCantidad: TBCDField;
    ConsultaCantidadProcesada: TBCDField;
    ConsultaPrecioDivisa: TBCDField;
    ConsultaPrecio: TFloatField;
    ConsultaRecargo: TBCDField;
    ConsultaPuntoVerde: TBCDField;
    ConsultaDescuento: TBCDField;
    ConsultaNroCajas: TBCDField;
    ConsultaLargo: TBCDField;
    ConsultaAncho: TBCDField;
    ConsultaAlto: TBCDField;
    ConsultaNoCalcularMargen: TBooleanField;
    ConsultaAnotacion: TWideMemoField;
    MovimientoTable: TnxeTable;
    ConsultaNroRegistro: TLongWordField;
    codigoCtrlCaption: TcxLabel;
    cxLabel1: TcxLabel;
    DescripcionBox: TcxLabel;
    CodigoBox: TcxLabel;

    procedure FormManagerInitializeForm;
    procedure FormManagerDestroyForm;

  private
    BoxCount : SmallInt;

    ListaDocumentos : TComponentList;
    MovimientoFields : TMovimientoFields;
    ArticuloFields : TArticuloFields;

    function CreaCajaDocumento( Top, Left : SmallInt ) : TDocFrame;
    procedure DoOnClickBox( Sender : TObject );
  public

  end;

var
  BoxTrzForm: TBoxTrzForm = nil;

procedure MuestraTrazadoArticulo( TipoMovimiento : TTipoMovimiento;
                                  NroOperacion   : Integer;
                                  CodigoArticulo : String;
                                  UIDArticulo    : TGuid );

implementation

{$R *.DFM}

uses   Windows,
       SysUtils,
       LibUtils,
       Variants,

       Gim00Fields,

       a_mov,
       
       dm_cli,
       dm_cls,
       dm_pro,
       dm_art,

       b_msg;

type TDocumentoObject = class( TComponent )
      public
       Nivel : SmallInt;
       NroOperacion : Integer;
       Fecha : TDate;
       Serie : String;
       NroDocumento : Integer;
       NroRegistro : Integer;
       TipoMovimiento : SmallInt;
       Ejercicio : SmallInt;
       NroRegistroOrigen : Integer;
       TipoMovimientoOrigen : SmallInt;
       EjercicioOrigen : SmallInt;
       NroOperacionOrigen : Integer;
       Propietario : String;
       Nombre : String;
       end;

var  FTipoMovimiento : TTipoMovimiento;
     FNroOperacion   : Integer;
     FCodigoArticulo : String;
     FUIDArticulo    : TGuid;

procedure MuestraTrazadoArticulo( TipoMovimiento : TTipoMovimiento;
                                  NroOperacion   : Integer;
                                  CodigoArticulo : String;
                                  UIDArticulo    : TGuid );
begin
     FTipoMovimiento := TipoMovimiento;
     FNroOperacion := NroOperacion;
     FCodigoArticulo := CodigoArticulo;
     FUIDArticulo := UIDArticulo;
     FreeAndNil( BoxTrzForm );
     CreateEditForm( TBoxTrzForm, BoxTrzForm, [] );
end;

function ListCompare( Item1, Item2 : Pointer ): Integer;
begin
     If   TDocumentoObject( Item1 ).Nivel<TDocumentoObject( Item2 ).Nivel
     then Result := -1
     else If   TDocumentoObject( Item1 ).Nivel>TDocumentoObject( Item2 ).Nivel
          then Result := 1
          else If   ( TDocumentoObject( Item1 ).Fecha<TDocumentoObject( Item2 ).Fecha ) or
                    ( ( TDocumentoObject( Item1 ).Fecha=TDocumentoObject( Item2 ).Fecha ) and ( TDocumentoObject( Item1 ).NroOperacion<TDocumentoObject( Item2 ).NroOperacion ) )
               then Result := -1
               else If   ( TDocumentoObject( Item1 ).Fecha>TDocumentoObject( Item2 ).Fecha ) or
                         ( ( TDocumentoObject( Item1 ).Fecha=TDocumentoObject( Item2 ).Fecha ) and ( TDocumentoObject( Item1 ).NroOperacion>TDocumentoObject( Item2 ).NroOperacion ) )
                    then Result := 1
                    else Result := 0;
end;

function TBoxTrzForm.CreaCajaDocumento( Top, Left : SmallInt ) : TDocFrame;
begin
     Inc( BoxCount );
     Result := TDocFrame.Create( Self );
     Result.Left := Left;
     Result.Top := Top;
     Result.Parent := ScrollBox;
     Result.Name := 'DocFrame' + IntToStr( BoxCount );
     Result.OnClick := DoOnClickBox;
end;

procedure TBoxTrzForm.DoOnClickBox( Sender : TObject );
begin
     If   Sender is TDocFrame
     then With TDocFrame( Sender ) do
            MntMovimientosPorNroRegistro( TDocumentoObject( ListaDocumentos.Items[ FIndex ] ).NroRegistro );
end;

procedure TBoxTrzForm.FormManagerDestroyForm;
begin
     FreeAndNil( ListaDocumentos );
end;

procedure TBoxTrzForm.FormManagerInitializeForm;

var  DocFrame : TDocFrame;
     Inx1, Inx2,
     RTop, RLeft,
     ImageIndex : SmallInt;
     DocumentoObject : TDocumentoObject;

begin

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     ArticuloFields := TArticuloFields.Create( Self );

     ListaDocumentos := TComponentList.Create;

     Articulo.Obten( FCodigoArticulo, ArticuloFields, True );

     CodigoBox.Caption:= ArticuloFields.Codigo.Value;
     DescripcionBox.Caption := ArticuloFields.Descripcion.Value;

     With Consulta do
       begin
       SQL.Text := 'Select * From LineaMovimiento Where UIDArticulo=' + SQLGUID( FUIDArticulo ) + ' Order By Fecha, NroOperacion';
       Open;
       First;
       While not Eof do
         begin

         If   MovimientoTable.FindKey( [ ConsultaEjercicio.Value, ConsultaNroOperacion.Value ] )
         then With ListaDocumentos do
                begin

                DocumentoObject := TDocumentoObject.Create( Self );

                With DocumentoObject do
                  begin
                  Nivel := 0;
                  NroOperacion := MovimientoFields.NroOperacion.Value;
                  Fecha := ConsultaFecha.Value;
                  Serie := MovimientoFields.Serie.Value;
                  NroRegistro := ConsultaNroRegistro.Value;
                  TipoMovimiento := MovimientoFields.TipoMovimiento.Value;
                  Ejercicio := ConsultaEjercicio.Value;
                  TipoMovimientoOrigen := ConsultaTipoMovimientoOrigen.Value;
                  EjercicioOrigen := ConsultaEjercicioOrigen.Value;
                  NroOperacionOrigen := ConsultaNroOperacionOrigen.Value;
                  NroRegistroOrigen := ConsultaNroRegistroOrigen.Value;

                  If   TipoMovimiento in [ tmOferta..tmCompra, tmPresupuesto..tmVenta ]
                  then begin
                       NroDocumento := MovimientoFields.NroDocumento.Value;
                       Propietario := MovimientoFields.Propietario.Value;
                       If   TipoMovimiento in [ tmOferta, tmPedidoCompra,tmCompra ]
                       then Nombre := Proveedor.Descripcion( Propietario, False )
                       else Nombre := Cliente.Descripcion( Propietario, False );
                       end
                  else begin
                       NroDocumento := MovimientoFields.NroOperacion.Value;
                       Nombre := MovimientoFields.DescripcionMovimiento.Value;
                       end;


                  end;

                ListaDocumentos.Add( DocumentoObject );
                end;

         Next;
         end;

       Close;
       end;

       // Operaciones para ordenar y vincular los documentos

       With ListaDocumentos do
         For Inx1 := 0 to Count - 1 do
           For Inx2 := 0 to Count - 1 do
             If   Inx1<>Inx2
             then begin
                  var Documento1 := TDocumentoObject( Items[ Inx1 ] );
                  var Documento2 := TDocumentoObject( Items[ Inx2 ] );
                  If   ( Documento1.TipoMovimientoOrigen=Documento2.TipoMovimiento ) and
                       ( Documento1.EjercicioOrigen=Documento2.Ejercicio ) and
                       ( Documento1.NroOperacionOrigen=Documento2.NroOperacion )
                       // ( Documento1.NroRegistroOrigen=Documento2.NroRegistro )
                  then Documento1.Nivel := Documento2.Nivel + 1;
                  end;

       ListaDocumentos.Sort( ListCompare );

       //

       RTop := 5;

       With ListaDocumentos do
         For Inx1 := 0 to Count - 1 do
           With TDocumentoObject( Items[ Inx1 ] ) do
             begin
             RLeft := Nivel * 20;
             DocFrame := CreaCajaDocumento( RTop, RLeft );
             With DocFrame do
               begin
               FIndex := Inx1;
               TipoMovimientoLabel.Caption := Movimiento.TextoTipoMovimiento( TipoMovimiento, False, True );
               NroDocumentoLabel.Caption := Serie + ' ' + IntToStr( NroDocumento );
               FechaLabel.Caption := StrFormatDate( Fecha );
               PropietarioLabel.Caption := Propietario;
               NombreLabel.Caption := Nombre;

               If   Nivel<>0
               then begin
                    If   ( Inx1<Count - 1 ) and ( Nivel=TDocumentoObject( Items[ Inx1 + 1 ] ).Nivel )
                    then ImageIndex := 0
                    else ImageIndex := 1;
                    ConectorImage0.Visible := ImageIndex=0;
                    ConectorImage1.Visible := ImageIndex=1;
                    end;

               If   ( TipoMovimiento=FTipoMovimiento ) and ( NroOperacion=FNroOperacion )
               then BackPanel.Style.Color := clRowHighlight;

               Inc( Rtop, Height );
               end;
             end;


end;


end.



