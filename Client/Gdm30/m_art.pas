unit m_art;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, cxLookAndFeelPainters, AppForms, StdCtrls, cxButtons,
  AppContainer, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData,
  nxdb, DataManager, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, dxSkinsCore,
  dxSkinscxPCPainter, cxContainer, cxGroupBox, cxLookAndFeels, EditableGrid,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView;

type
  TEdcArtForm = class(TgxForm)
    FormManager: TgxFormManager;
    EditableGridFrame: TEditableGridFrame;
    procedure FormManagerInitializeForm;
    procedure EditableGridFrameGridTableViewControllerUserSelection(Sender: TObject; var AHandled : Boolean);
  private
      CodigoColumn,
      DescripcionColumn,
      CodigoBarrasColumn,
      FamiliaColumn,
      CodigoProveedorColumn,
      PrecioCompraColumn,
      DtoCompraColumn,
      PrecioVentaColumn,
      RecargoVentaColumn,
      ComisionColumn,
      DtoVentaColumn,
      MargenComercialColumn,
      StockMinimoColumn,
      StockMaximoColumn,
      BultosColumn,
      KilosColumn,
      VolumenColumn,
      UnidadesPorCajaColumn,
      UnidadesPorPalletColumn  : TcxGridDBColumn;
      AmpliacionColumn : Array[ 1..16 ] of TcxGridDBColumn;

      DefaultGroupSummaryItem : TcxGridDBTableSummaryItem;

      procedure DoOnFamiliaValidate( Sender : TcxCustomEdit; var DisplayValue : TcxEditValue; var ErrorText : TCaption; var Error : Boolean );
      procedure DoOnFamiliaQuery( Sender : TcxCustomEdit );

      procedure DoOnCodigoProveedorValidate( Sender : TcxCustomEdit; var DisplayValue : TcxEditValue; var ErrorText : TCaption; var Error : Boolean );
      procedure DoOnCodigoProveedorQuery( Sender : TcxCustomEdit );

  protected
  class var
    SQLString : String;
    Agrupacion : SmallInt;
  public

  end;

var  EdcArtForm: TEdcArtForm = nil;

procedure RejillaEdicionArticulos( SQLString  : String;
                                   Agrupacion : SmallInt );

implementation

uses  Math,
      LibUtils,
      EnterpriseDataAccess,

      Gdm00Dm,
      Gim00Fields,
      Gim30Fields,

      cxTextEdit,
      cxCheckBox,
      cxIntegerEdit,

      dm_fam,
      dm_pro,

      a_art,

      cx_fam,
      cx_pro;

{$R *.dfm}

procedure RejillaEdicionArticulos( SQLString  : String;
                                   Agrupacion : SmallInt );
begin
     TEdcArtForm.SQLString := SQLString;
     TEdcArtForm.Agrupacion := Agrupacion;
     CreateEditForm( TEdcArtForm, EdcArtForm );
end;

procedure TEdcArtForm.EditableGridFrameGridTableViewControllerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     With EditableGridFrame.GridView.Controller do
       If   Assigned( FocusedRecord ) and not FocusedItem.Editable
       then begin
            MntArticulos( [ FocusedRecord.Values[ CodigoColumn.Index ] ] );
            AHandled := True;
            end;
end;

procedure TEdcArtForm.FormManagerInitializeForm;

var  ColumnWidth, I : SmallInt;
     SQLText,
     ColumnFieldName,
     ColumnHeader : String;

begin

     ID := idEdcArtForm;

     With EditableGridFrame, DataModule00.DmEmpresaFields do
       begin

       SQLText := 'SELECT Codigo, Descripcion, CodigoBarras, Familia, CodigoProveedor, Precio_Compra, Dto_Compra, Precio_Venta, Recargo_Venta, Dto_Venta, MargenComercial, Comision, Stock_Minimo, Stock_Maximo, Bultos, Kilos, Volumen, UnidadesPorCaja, UnidadesPorPallet ';

       If   Articulo_CamposLibres.Value
       then For I := 1 to High( Articulo_CampoLibre ) do
              If   not ValueIsEmpty( Articulo_CampoLibre[ I ].Value )
              then StrAdd( SQLText, ' ,CampoLibre' + StrInt( I ) );

       StrAdd( SQLText, ' FROM Articulo WHERE ' + SQLString );

       EditableGridFrame.Setup( SQLText );

       CodigoColumn := SetupTextColumn( 'Codigo', 'Código', 90, True, False );         // No es editable
       DescripcionColumn := SetupTextColumn( RsDescripcion, 'Descripción', 390 );
       CodigoBarrasColumn := SetupTextColumn( 'CodigoBarras', 'Cód. barras', 90 );

       FamiliaColumn := SetupTextColumn( 'Familia', 'Familia', 55 );
       If   Assigned( FamiliaColumn )
       then With FamiliaColumn.Properties do
              begin
              OnValidate := DoOnFamiliaValidate;
              OnQueryRequest := DoOnFamiliaQuery;
              end;

       CodigoProveedorColumn := SetupTextColumn( 'CodigoProveedor', 'Cód. proveedor', 60 );
       If   Assigned( CodigoProveedorColumn )
       then With TcxTextEditProperties( CodigoProveedorColumn.Properties ) do
              begin
              TextEditPad := tpLeftZero;
              ExpandZeroes := true;
              PadAlways := False;
              OnValidate := DoOnCodigoProveedorValidate;
              OnQueryRequest := DoOnCodigoProveedorQuery;
              end;

       PrecioCompraColumn := SetupDecimalColumn( 'Precio_Compra', 'Precio compra', 90, 10, Compras_DecPrecio.Value );
       DtoCompraColumn := SetupDecimalColumn( 'Dto_Compra', '% Dto. compra', 50, 5, Compras_DecDto.Value );
       PrecioVentaColumn := SetupDecimalColumn( 'Precio_Venta', 'Precio venta', 90, 10, Ventas_DecPrecio.Value );
       RecargoVentaColumn := SetupDecimalColumn( 'Recargo_Venta', 'Rec. venta', 90, 10, Ventas_DecRecargo.Value );
       ComisionColumn := SetupDecimalColumn( 'Comision', '% Comisión', 50, 5, 2 );
       DtoVentaColumn := SetupDecimalColumn( 'Dto_Venta', '% Dto. venta', 50, 5, Ventas_DecDto.Value );
       MargenComercialColumn  := SetupDecimalColumn( 'MargenComercial', '% Margen com.', 50, 5 );
       StockMinimoColumn := SetupDecimalColumn( 'Stock_Minimo', 'Stock mínimo', 90, 10, Ventas_DecCantidad.Value );
       StockMaximoColumn := SetupDecimalColumn( 'Stock_Maximo', 'Stock máximo', 90, 10, Ventas_DecCantidad.Value );
       BultosColumn := SetupDecimalColumn( 'Bultos', 'Bultos', 90, 6, 0 );
       KilosColumn := SetupDecimalColumn( 'Kilos', 'Kilos', 90, 10, 3 );
       VolumenColumn := SetupDecimalColumn( 'Volumen', 'Volumen', 90, 10, 3 );
       UnidadesPorCajaColumn := SetupDecimalColumn( 'UnidadesPorCaja', 'Unid./caja', 90, 10, Ventas_DecCantidad.Value );
       UnidadesPorPalletColumn := SetupDecimalColumn( 'UnidadesPorPallet', 'Unid./pallet', 90, 10, 4 );

       If   Articulo_CamposLibres.Value
       then For I := 1 to High( Articulo_CampoLibre ) do
              If   not ValueIsEmpty( Articulo_CampoLibre[ I ].Value )
              then begin
                   ColumnFieldName := 'CampoLibre' + StrInt( I );
                   ColumnHeader := Articulo_CampoLibre[ I ].Value;
                   case I of
                       1..4,
                     13..16 : begin
                              If   not( I in [ 3, 4 ] )
                              then ColumnWidth := 200
                              else ColumnWidth := 100;
                              AmpliacionColumn[ I ] := SetupTextColumn( ColumnFieldName, ColumnHeader, ColumnWidth );
                              AmpliacionColumn[ I ].PropertiesClass := TcxTextEditProperties;
                              end;
                       5..8 : AmpliacionColumn[ I ] := SetupDecimalColumn( ColumnFieldName, ColumnHeader, 90, 10, 4 );
                          9 : begin
                              AmpliacionColumn[ I ] := SetupColumn( ColumnFieldName, ColumnHeader, 80 );  // Boolean
                              AmpliacionColumn[ I ].PropertiesClass := TcxCheckBoxProperties;
                              end;
                     10..12 : begin
                              AmpliacionColumn[ I ] := SetupColumn( ColumnFieldName, ColumnHeader, 90 );  // Integer
                              AmpliacionColumn[ I ].PropertiesClass := TcxIntegerEditProperties;
                              end;
                     end;
                   AmpliacionColumn[ I ].Properties.Required := Articulo_CampoLibOblig[ I ].Value;
                   end;

       case Agrupacion of
         1 : AddGroupsIndex( [ FamiliaColumn ] );
         2 : AddGroupsIndex( [ CodigoProveedorColumn ] );
         end;

       UnidadesPorCajaColumn.Visible := Articulo_Cajas.Value;
       RecargoVentaColumn.Visible := Ventas_Recargos.Value;
       PrecioVentaColumn.Visible := not Articulo_PreciosIVA.Value;
       UnidadesPorPalletColumn.Visible := Articulo_Pallets.Value;
       BultosColumn.Visible := Articulo_Bultos.Value;
       KilosColumn.Visible := Articulo_Bultos.Value;
       VolumenColumn.Visible := Articulo_Bultos.Value;
       PrecioCompraColumn.Visible := not DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value;
       PrecioCompraColumn.VisibleForCustomization := not DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value;
       DtoCompraColumn.Visible := not DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value;
       DtoCompraColumn.VisibleForCustomization := not DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value;

       If   not ValueIsEmpty( Ventas_NombreRecargos.Value )
       then RecargoVentaColumn.Caption := Ventas_NombreRecargos.Value;

       end;

end;

procedure TEdcArtForm.DoOnFamiliaValidate(     Sender       : TcxCustomEdit;
                                           var DisplayValue : TcxEditValue;
                                           var ErrorText    : TCaption;
                                           var Error        : Boolean );
begin
     Familia.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TEdcArtForm.DoOnFamiliaQuery( Sender : TcxCustomEdit );
begin
     ConsultaFamilias( Sender );
end;

procedure TEdcArtForm.DoOnCodigoProveedorValidate(     Sender       : TcxCustomEdit;
                                                   var DisplayValue : TcxEditValue;
                                                   var ErrorText    : TCaption;
                                                   var Error        : Boolean );
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TEdcArtForm.DoOnCodigoProveedorQuery( Sender : TcxCustomEdit );
begin
     ConsultaProveedores( Sender );
end;

end.
