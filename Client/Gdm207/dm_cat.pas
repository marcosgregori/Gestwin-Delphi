
unit dm_cat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,

  AppForms,
  DB,
  nxdb,
  DataManager,
  cxEdit,
  cxEditRepositoryItems,

  Gim207Fields;


type
  TCategoriaModule = class(TDataModule)
    DmCategoriaTable: TnxeTable;
    DmCategoriasArticuloTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

  public

    DmCategoriaFields : TCategoriaFields;
    DmCategoriasArticuloFields : TCategoriasArticuloFields;

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False );
    function  Descripcion( Value : String ; NotificaSiNoExiste : Boolean = True ) : String;
    function  Obten( Value : String; NotificaSiNoExiste : Boolean = False ) : Boolean;
    function  Nivel( Value : String ) : SmallInt;

    function LeeCategoriasArticulo(CodigoArticulo: String): String;
    procedure SuprimeCategoriasArticulo(CodigoArticulo: String);
    procedure GuardaCategoriasArticulo(CodigoArticulo, ListaCategorias: String);

  end;

var CategoriaModule: TCategoriaModule = nil;

function  Categoria : TCategoriaModule;

implementation

uses LibUtils,
     Variants,
     EnterpriseDataAccess,
     AppManager,

     Gdm00Dm;

{$R *.DFM}

resourceString
     RsMsg1 = 'No existe una categoría con este código|Puede consultar los conceptos existentes pulsando [F4].';
     RsMsg2 = 'La categoría número %d ha sido dada de baja.';

function Categoria : TCategoriaModule;
begin
     CreateDataModule( TCategoriaModule, CategoriaModule );
     Result := CategoriaModule;
end;

procedure TCategoriaModule.Valida(     EditControl   : TcxCustomEdit;
                                   var DisplayValue  : Variant;
                                   var ErrorText     : TCaption;
                                   var Error         : Boolean;
                                       IsInfoControl : Boolean = False );
begin
     ValidateRelation( EditControl, DmCategoriaTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, 'Nombre', IsInfoControl );
end;

procedure TCategoriaModule.DataModuleCreate(Sender: TObject);
begin
     DmCategoriaFields := TCategoriaFields.Create( DmCategoriaTable );
     DmCategoriasArticuloFields := TCategoriasArticuloFields( DmCategoriasArticuloTable );
end;

procedure TCategoriaModule.DataModuleDestroy(Sender: TObject);
begin
     CategoriaModule := nil;
end;

function TCategoriaModule.Descripcion( Value : String; NotificaSiNoExiste : Boolean ) : String;
begin
     GetRelationDescription( DmCategoriaTable, [ Value ], Result, NotificaSiNoExiste );
end;

function TCategoriaModule.Nivel( Value : String ) : SmallInt;

var  ExisteCategoriaPadre : Boolean;

begin
     Result := 0;
     If   DmCategoriaTable.FindKey( [ Value ] )
     then repeat
            If   DmCategoriaFields.CodigoPadre.Value<>''
            then ExisteCategoriaPadre := DmCategoriaTable.FindKey( [ DmCategoriaFields.CodigoPadre.Value ] )
            else ExisteCategoriaPadre := False;
            If   ExisteCategoriaPadre
            then Inc( Result );
          until not ExisteCategoriaPadre or ( Result>20 );   // Por poner algún límite
end;

function TCategoriaModule.Obten( Value              : String;
                                 NotificaSiNoExiste : Boolean = False ) : Boolean;
begin
     Result := DmCategoriaTable.FindKey( [ Value ] );
     If   NotificaSiNoExiste and not Result
     then begin
          ShowNotification( ntStop, Format( RsMsg2, [ Value ] ), '' );
          Abort;
          end;
end;

// Devuelve una cadena separada por ';' con las clases. Se puede utilizar en TdxTokenEdit

function TCategoriaModule.LeeCategoriasArticulo( CodigoArticulo : String ) : String;
begin
     With DmCategoriasArticuloTable do
       try
         Result := '';
         // IndexFieldNames := 'CodigoArticulo;CodigoCategoria';
         SetRange( [ CodigoArticulo ] );
         First;
         While not Eof do
           begin
           If   Result<>''
           then StrAdd( Result, ';' );
           StrAdd( Result, DmCategoriasArticuloFields.CodigoCategoria.Value );
           Next;
           end;
       finally
         CancelRange;
         end;
end;

procedure TCategoriaModule.GuardaCategoriasArticulo( CodigoArticulo, ListaCategorias : String );
begin
     SuprimeCategoriasArticulo( CodigoArticulo );

end;

procedure TCategoriaModule.SuprimeCategoriasArticulo( CodigoArticulo : String );
begin
     If   DataModule00.TiendaVirtual
     then EnterpriseDataModule.ExecQuery( 'DELETE FROM CategoriasArticulo WHERE CodigoArticulo=' + QuotedStr( CodigoArticulo ) );
end;

end.
