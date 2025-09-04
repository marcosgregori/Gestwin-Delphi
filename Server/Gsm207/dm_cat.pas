
unit dm_cat;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB,
  nxdb,

  Spring,
  LibUtils,
  DataManager,
  ServerDataModule,
  SessionIntf,
  BaseSessionData,

  sgcJSON,

  Gim207Fields;

type  TCategoriaModule = class(TServerDataModule)
        DmCategoriaTable: TnxeTable;
        procedure ServerDataModuleCreate(Sender: TObject);
        procedure ServerDataModuleDestroy(Sender: TObject);

       private

       public

         DmCategoriaFields : TCategoriaFields;

         // WebService

         class function ObtenListaCategoriasWs( SessionDataModule : TBaseSessionDataModule; DataIn, DataOut : IsgcJSON ) : Boolean;

         function ObtenListaCategorias( DataIn, DataOut : IsgcJSON ) : Boolean;
       end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses AppManager,
     SessionData,
     ServerContainer,
     ServerUtils,                   WebService,

     nxrdClass,
     nxrbTypes,
     nxllTypes,
     nxllBDE,
     nxsdServerEngine,

     Gsm00Dm,

     dmi_iva,

     dm_pai,
     dm_iva;

{$R *.DFM}

procedure TCategoriaModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmCategoriaFields := TCategoriaFields.Create( DmCategoriaTable );
end;

procedure TCategoriaModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm207.CategoriaModule := nil
end;

// WebService

class function TCategoriaModule.ObtenListaCategoriasWs( SessionDataModule : TBaseSessionDataModule;
                                                        DataIn,
                                                        DataOut           : IsgcJSON ) : Boolean;
begin
     If   Assigned( SessionDataModule )
     then TSessionDataModule( SessionDataModule ).Dm207.CategoriaModule.ObtenListaCategorias( DataIn, DataOut );
end;

function TCategoriaModule.ObtenListaCategorias( DataIn, DataOut : IsgcJSON ) : Boolean;

var  PageSize,
     Page : Integer;

     SelectCommand,
     FilterCommand : String;
     Query : TnxQuery;

begin

     Result := False;

     try

       var ParametersData := GetNodeObject( DataIn, 'parameters' );
       If   Assigned( ParametersData )
       then begin

            PageSize := StrToIntDef( ParametersData.Node[ 'pageSize' ].Value, 20 );
            Page:= StrToIntDef( ParametersData.Node[ 'page' ].Value, 0 );

            var CodigoTarifa := SessionDataModule.ClienteTiendaFields.Factura_Tarifa.Value;

            {

            SELECT DISTINCT( CodigoCategoria ), Count( * ) AS NumeroArticulos
            INTO ##ContadorCategorias
            FROM CategoriasArticulo
            GROUP BY CodigoCategoria;

            SELECT Categoria.Codigo, Categoria.Nombre, Categoria.CodigoPadre, NumeroArticulos
            FROM Categoria
            LEFT JOIN ##ContadorCategorias AS Contador ON ( Categoria.Codigo=Contador.CodigoCategoria )

            }

            SelectCommand := 'SELECT DISTINCT( CodigoCategoria ), Count( * ) AS NumeroArticulos ' +
                             'INTO #ContadorCategorias ' +
                             'FROM CategoriasArticulo ';

            If   CodigoTarifa<>''
            then StrAdd( SelectCommand, 'INNER JOIN TarifaVentas  ON ( Tipo=0 AND TarifaVentas.CodigoTarifa=' + QuotedStr( CodigoTarifa ) + ' AND TarifaVentas.CodigoArticulo=CategoriasArticulo.CodigoArticulo ) ' );

            StrAdd( SelectCommand, 'GROUP BY CodigoCategoria; ' );

            If   // SessionDataModule.Dm207.ConfiguracionTiendaVirtualModule.ArticulosPorGrupoCliente and
                 ( CodigoTarifa<>'' )
            then StrAdd( SelectCommand, 'SELECT Categoria.Codigo, Categoria.Nombre, Categoria.CodigoPadre, NumeroArticulos ' +
                                        'FROM( SELECT DISTINCT( CategoriasArticulo.CodigoCategoria ) AS CodigoCategoria ' +
                                        '      FROM TarifaVentas ' +
                                        '           INNER JOIN CategoriasArticulo ON ( CategoriasArticulo.CodigoArticulo=TarifaVentas.CodigoArticulo ) ' +
                                        '      WHERE TarifaVentas.CodigoTarifa=' + QuotedStr( CodigoTarifa ) + ' AND ' +
                                        '            CategoriasArticulo.CodigoArticulo IS NOT NULL ) AS CategoriasTarifa ' +
                                        '      LEFT JOIN Categoria ON ( Categoria.Codigo=CategoriasTarifa.CodigoCategoria ) ' +
                                        '      LEFT JOIN ##ContadorCategorias AS Contador ON ( Categoria.Codigo=Contador.CodigoCategoria ) ' +
                                        'WHERE id IS NOT NULL ' )
            else StrAdd( SelectCommand, 'SELECT Categoria.Codigo, Categoria.Nombre, Categoria.CodigoPadre, NumeroArticulos ' +
                                        'FROM Categoria ' +
                                        'LEFT JOIN #ContadorCategorias AS Contador ON ( Categoria.Codigo=Contador.CodigoCategoria )' );

            Query := SectionDataModule.OpenQuery( SelectCommand, { RaiseError } True, { Notify } False );

            try

              var ArrayIndex := 0;

              If   Assigned( Query ) and ( Query.RecordCount>0 )
              then begin

                   var FieldCodigo := Query.FieldByName( 'Codigo' );
                   var FieldCodigoPadre := Query.FieldByName( 'CodigoPadre' );
                   var FieldDescripcion := Query.FieldByName( 'Nombre' );
                   var FieldNumeroArticulos := Query.FieldByName( 'NumeroArticulos' );

                   var DataArray : IsgcJSON := TsgcJSON.Create( nil );
                   DataArray.IsArray := True;

                   Query.First;

                   While not Query.Eof do
                     begin

                     var Product1Object := TsgcJSON.Create( nil );

                     Product1Object.AddPair( 'codigo', StrToJSONText( FieldCodigo.AsString ) );
                     Product1Object.AddPair( 'codigoPadre', FieldCodigoPAdre.AsString );
                     Product1Object.AddPair( 'descripcion', StrToJSONText( FieldDescripcion.AsString ) );
                     Product1Object.AddPair( 'numeroArticulos', StrToJSONText( FieldNumeroArticulos.AsString ) );

                     DataArray.AddObject( IntToStr( ArrayIndex ) ).JSONObject := Product1Object;

                     Inc( ArrayIndex );

                     Query.Next;
                     end;

                   DataOut.AddObject( 'loadout' ).JSONObject := DataArray;

                   // var RecordsRead := WebServiceData.GetSQLCount( EnterpriseDataModule, SelectCommand );

                   DataOut.AddPair( 'recordsRead', ArrayIndex );

                   Result := True;
                   end;

              finally
                Query.Close;
                end;

            end;

     except
       end;

end;

procedure InitializeWebServices;
begin
     ServerContainerModule.AddWebServiceFunction( 'Categoria.ObtenLista', TCategoriaModule.ObtenListaCategoriasWs );
end;

// var CategoriaControl : InxClassFactoryControl;

initialization
   // TnxClassFactory.RegisterClass( CLSID_CategoriaService, TCategoriaService, CategoriaControl );

   AddProcedure( imStartup, 0, InitializeWebServices );

end.

