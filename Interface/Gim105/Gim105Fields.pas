{$ALIGN OFF} {$OPTIMIZATION OFF}

unit Gim105Fields;

interface

uses  DB,
      DataManager,

      Gim00Fields;

{$TYPEINFO ON}   // Rtti

const ctParametrosModulo105 = 1105;

type

    TVendedoresClienteFields = class( TnxeDatasetFields)
    public
      CodigoCliente : TWideStringField;
      NroRegistro : TSmallIntField;
      CodigoVendedor : TWideStringField;
      Comision : TBCDField;
    end;

    TVendedoresFacturaFields = class( TnxeDatasetFields)
    public
      Ejercicio : TSmallIntField;
      Serie : TWideStringField;
      NroFactura : TIntegerField;
      NroRegistro : TSmallIntField;
      CodigoVendedor : TWideStringField;
      ImporteBase : TBCDField;
      Comision : TBCDField;
    end;

    TDesgloseBultosLineaFields = class( TnxeDatasetFields )
    public
       Ejercicio : TSmallIntField;
       NroOperacion : TIntegerField;
       NroRegistroLinea : TIntegerField;
       Barcada : TWideStringField;
       MetrosBrutos : TBCDField;
       MetrosNetos : TBCDField;
       PesoBruto : TBCDField;
       PesoNeto : TBCDField;
    end;

implementation

end.
