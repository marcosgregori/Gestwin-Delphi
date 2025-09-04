
unit dm_efe;

interface

uses
  Windows, Messages, SysUtils, Classes,

  DB,
  nxdb,
  DataManager,
  ServerDataModule,

  Gim10Fields,
  Gim30Fields;

type

   TEfectoModule = class(TServerDataModule)
    DmEfectoTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

    DmEfectoFields : TEfectoFields;

  public

    procedure ObtenVencimientos(    Seccion          : TSeccionComercial;
                                    Ejercicio        : smallInt;
                                    Propietario      : String;
                                    Serie            : String;
                                    NroFactura       : longInt;
                                var RelacionEfectos  : TRelacionEfectos );

    procedure SuprimeEfectos( Seccion       : TSeccionComercial;
                              Propietario   : String;
                              Serie         : String;
                              NroFactura    : longInt );

    procedure GeneraEfectos(     Seccion          : TSeccionComercial;
                                 Propietario      : String;
                                 Serie            : String;
                                 NroFactura       : longInt;
                                 FechaFactura     : TDateTime;
                             var RelacionEfectos  : TRelacionEfectos );
  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses LibUtils,
     AppManager,
     SessionData;

{$R *.DFM}

procedure TEfectoModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmEfectoFields := TEfectoFields.Create( DmEfectoTable );
end;

procedure TEfectoModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm30.EfectoModule := nil;
end;

procedure TEfectoModule.ObtenVencimientos(     Seccion          : TSeccionComercial;
                                               Ejercicio        : smallInt;
                                               Propietario      : String;
                                               Serie            : String;
                                               NroFactura       : longInt;
                                           var RelacionEfectos  : TRelacionEfectos );

begin
     With DmEfectoTable do
       try
         FillChar( RelacionEfectos, SizeOf( RelacionEfectos ), #0 );
         SetRange( [ Ejercicio, Seccion, Propietario, Serie, NroFactura,  0 ],
                   [ Ejercicio, Seccion, Propietario, Serie, NroFactura, 12 ] );
         First;
         While not Eof do
           begin
           With DmEfectoFields do
             begin
             Inc( RelacionEfectos.NroEfectos );
             RelacionEfectos.FechaLibramiento[ RelacionEfectos.NroEfectos ] := FechaFactura.Value;
             RelacionEfectos.FechaVencimiento[ RelacionEfectos.NroEfectos ] := FechaVencimiento.Value;
             RelacionEfectos.Importe[ RelacionEfectos.NroEfectos ] := Importe.Value;
             end;
           Next;
           end;

       finally
         CancelRange;
         end;
end;


procedure TEfectoModule.SuprimeEfectos( Seccion       : TSeccionComercial;
                                        Propietario   : String;
                                        Serie         : String;
                                        NroFactura    : longInt );

begin
     EnterpriseDataModule.ExecSQLCommand( Format( 'DELETE FROM Efecto WHERE Ejercicio=%d AND Tipo=%d AND Propietario=%s AND Serie=%s AND NroDocumento=%d',
                                                  [ SessionDataModule.Ejercicio, Seccion, QuotedStr( Propietario ), QuotedStr( Serie ), NroFactura ] ) );
end;

procedure TEfectoModule.GeneraEfectos(     Seccion          : TSeccionComercial;
                                           Propietario      : String;
                                           Serie            : String;
                                           NroFactura       : LongInt;
                                           FechaFactura     : TDateTime;
                                       var RelacionEfectos  : TRelacionEfectos );

var  Index  : SmallInt;

begin
     SuprimeEfectos( Seccion, Propietario, Serie, NroFactura );

     With DmEfectoTable, RelacionEfectos do
       For Index := 1 to NroEfectos do
           If   Importe[ Index ]<>0.0
           then begin

                Append;

                DmEfectoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                DmEfectoFields.Tipo.Value := Seccion;
                DmEfectoFields.Propietario.Value := Propietario;
                DmEfectoFields.Serie.Value := Serie;
                DmEfectoFields.NroDocumento.Value := NroFactura;
                DmEfectoFields.FechaFactura.Value := FechaFactura;

                DmEfectoFields.NroEfecto.Value := Index;
                DmEfectoFields.FechaVencimiento.Value := FechaVencimiento[ Index ];
                DmEfectoFields.Importe.Value := Importe[ Index ];

                Post;
                end;

end;


end.

