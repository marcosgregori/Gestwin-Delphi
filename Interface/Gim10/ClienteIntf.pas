{$ALIGN OFF}
{$OPTIMIZATION OFF}

unit ClienteIntf;

{ Este fichero ha sido generado automáticamente desde la utilidad de creación de interfaces
  de Gestwin (Gestión de tareas->Procesos->Exportacion a ficheros). }

interface

uses  SysUtils,
      Classes,

      LibUtils,
      DataManager,

      nxllComponent,
      nxllTypes,
      nxivTypes,
      nxrdClass,
      nxrbTypes,
      nxsdTypes,
      nxrbVariantFiler,

      DB,
      SessionIntf,

      Gim10Fields;

const
  CLSID_Cliente : TnxGuid = '{0D09FB4C-C638-4C39-A303-9FAE87D8FFD2}';

type

  ICliente = interface( IInvokableRecord )
    [ '{A4941C7F-0126-48DD-A18F-033FA0493D78}' ] 

    procedure ToDataset( ClienteFields : TClienteFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
    function GetRemoteCursorID : TnxCursorID;
    procedure SetRemoteCursorID( const Value : TnxCursorID );
    function GetState : TDataSetState;
    procedure SetState( const Value : TDataSetState );

    // Los campos que forman parte de un índice es conveniente que no sean Variants.
    // El resto, sin embargo, pueden ser valores nulos, o el campo no estar definido en el dataset.

    function GetCodigo : String;
    function GetNombre : Variant;
    function GetDomicilio : Variant;
    function GetLocalidad : Variant;
    function GetCodigoPais : Variant;
    function GetCodigoProvincia : Variant;
    function GetCodigoPostal : Variant;
    function GetTelefono : Variant;
    function GetFax : Variant;
    function GetNIF : Variant;
    function GetTipoIdentificacion : Variant;
    function GetEMail : Variant;
    function GetDocumentosExternos : Variant;
    function GetVendedor : Variant;
    function GetSubcuenta : Variant;
    function GetCodigoDivisa : Variant;
    function GetCampoLibre( Index : SmallInt ) : Variant;
    function GetBloqueado : Variant;
    function GetObsoleto : Variant;
    function GetFechaAlta : Variant;
    function GetPalabraPaso : Variant;
    function GetLatitud : Variant;
    function GetLongitud : Variant;
    function GetTiendaVirtual : Variant;
    function GetEnvios_Nombre : Variant;
    function GetEnvios_Domicilio : Variant;
    function GetEnvios_Localidad : Variant;
    function GetEnvios_CodigoProv : Variant;
    function GetEnvios_CodigoPostal : Variant;
    function GetEnvios_FormaEnvio : Variant;
    function GetEnvios_Transportista : Variant;
    function GetEnvios_CodigoFormaEnvio : Variant;
    function GetEnvios_Bloqueado : Variant;
    function GetEnvios_MotivoBloqueo : Variant;
    function GetFactura_DtoPP : Variant;
    function GetFactura_DtoES : Variant;
    function GetFactura_RecFinanc : Variant;
    function GetFactura_ModeloIVA : Variant;
    function GetFactura_TipoFijoIVA : Variant;
    function GetFactura_TipoRet : Variant;
    function GetFactura_Credito : Variant;
    function GetFactura_Agrupacion : Variant;
    function GetFactura_Reservado : Variant;
    function GetFactura_Tarifa : Variant;
    function GetFactura_Comision : Variant;
    function GetFactura_NroCopias : Variant;
    function GetFactura_NroCopiasAlbaran : Variant;
    function GetFactura_Moneda : Variant;
    function GetFactura_EnviarPorCorreo : Variant;
    function GetFactura_SinDtosConsumo : Variant;
    function GetFactura_NoAplicarOfertas : Variant;
    function GetFactura_CodigoEAN : Variant;
    function GetCobro_Nombre : Variant;
    function GetCobro_Domicilio : Variant;
    function GetCobro_Localidad : Variant;
    function GetCobro_CodigoProv : Variant;
    function GetCobro_CodigoPostal : Variant;
    function GetCobro_FormaCobro : Variant;
    function GetCobro_DiaCobro1 : Variant;
    function GetCobro_DiaCobro2 : Variant;
    function GetCobro_MesNoCobro : Variant;
    function GetCobro_CodigoEntidad : Variant;
    function GetCobro_Entidad : Variant;
    function GetCobro_CodigoSucursal : Variant;
    function GetCobro_Sucursal : Variant;
    function GetCobro_DC : Variant;
    function GetCobro_Cuenta : Variant;
    function GetCobro_CtaEntidad : Variant;
    function GetCobro_CodigoINEPlaza : Variant;
    function GetCobro_RiesgoLimite : Variant;
    function GetCobro_ReferenciaMandato : Variant;
    function GetCobro_FechaMandato : Variant;
    function GetCobro_CicloMandato : Variant;
    function GetCobro_BIC : Variant;
    function GetCobro_IBAN : Variant;
    function GetAnotacion : Variant;
    function GetAviso : Variant;
    function GetMostrarAviso : Variant;

    procedure SetCodigo( const Value  : String );
    procedure SetNombre( const Value  : Variant );
    procedure SetDomicilio( const Value  : Variant );
    procedure SetLocalidad( const Value  : Variant );
    procedure SetCodigoPais( const Value  : Variant );
    procedure SetCodigoProvincia( const Value  : Variant );
    procedure SetCodigoPostal( const Value  : Variant );
    procedure SetTelefono( const Value  : Variant );
    procedure SetFax( const Value  : Variant );
    procedure SetNIF( const Value  : Variant );
    procedure SetTipoIdentificacion( const Value  : Variant );
    procedure SetEMail( const Value  : Variant );
    procedure SetDocumentosExternos( const Value  : Variant );
    procedure SetVendedor( const Value  : Variant );
    procedure SetSubcuenta( const Value  : Variant );
    procedure SetCodigoDivisa( const Value  : Variant );
    procedure SetCampoLibre( Index : SmallInt; const Value  : Variant );
    procedure SetBloqueado( const Value  : Variant );
    procedure SetObsoleto( const Value  : Variant );
    procedure SetFechaAlta( const Value  : Variant );
    procedure SetPalabraPaso( const Value  : Variant );
    procedure SetLatitud( const Value  : Variant );
    procedure SetLongitud( const Value  : Variant );
    procedure SetTiendaVirtual( const Value  : Variant );
    procedure SetEnvios_Nombre( const Value  : Variant );
    procedure SetEnvios_Domicilio( const Value  : Variant );
    procedure SetEnvios_Localidad( const Value  : Variant );
    procedure SetEnvios_CodigoProv( const Value  : Variant );
    procedure SetEnvios_CodigoPostal( const Value  : Variant );
    procedure SetEnvios_FormaEnvio( const Value  : Variant );
    procedure SetEnvios_Transportista( const Value  : Variant );
    procedure SetEnvios_CodigoFormaEnvio( const Value  : Variant );
    procedure SetEnvios_Bloqueado( const Value  : Variant );
    procedure SetEnvios_MotivoBloqueo( const Value  : Variant );
    procedure SetFactura_DtoPP( const Value  : Variant );
    procedure SetFactura_DtoES( const Value  : Variant );
    procedure SetFactura_RecFinanc( const Value  : Variant );
    procedure SetFactura_ModeloIVA( const Value  : Variant );
    procedure SetFactura_TipoFijoIVA( const Value  : Variant );
    procedure SetFactura_TipoRet( const Value  : Variant );
    procedure SetFactura_Credito( const Value  : Variant );
    procedure SetFactura_Agrupacion( const Value  : Variant );
    procedure SetFactura_Reservado( const Value  : Variant );
    procedure SetFactura_Tarifa( const Value  : Variant );
    procedure SetFactura_Comision( const Value  : Variant );
    procedure SetFactura_NroCopias( const Value  : Variant );
    procedure SetFactura_NroCopiasAlbaran( const Value  : Variant );
    procedure SetFactura_Moneda( const Value  : Variant );
    procedure SetFactura_EnviarPorCorreo( const Value  : Variant );
    procedure SetFactura_SinDtosConsumo( const Value  : Variant );
    procedure SetFactura_NoAplicarOfertas( const Value  : Variant );
    procedure SetFactura_CodigoEAN( const Value  : Variant );
    procedure SetCobro_Nombre( const Value  : Variant );
    procedure SetCobro_Domicilio( const Value  : Variant );
    procedure SetCobro_Localidad( const Value  : Variant );
    procedure SetCobro_CodigoProv( const Value  : Variant );
    procedure SetCobro_CodigoPostal( const Value  : Variant );
    procedure SetCobro_FormaCobro( const Value  : Variant );
    procedure SetCobro_DiaCobro1( const Value  : Variant );
    procedure SetCobro_DiaCobro2( const Value  : Variant );
    procedure SetCobro_MesNoCobro( const Value  : Variant );
    procedure SetCobro_CodigoEntidad( const Value  : Variant );
    procedure SetCobro_Entidad( const Value  : Variant );
    procedure SetCobro_CodigoSucursal( const Value  : Variant );
    procedure SetCobro_Sucursal( const Value  : Variant );
    procedure SetCobro_DC( const Value  : Variant );
    procedure SetCobro_Cuenta( const Value  : Variant );
    procedure SetCobro_CtaEntidad( const Value  : Variant );
    procedure SetCobro_CodigoINEPlaza( const Value  : Variant );
    procedure SetCobro_RiesgoLimite( const Value  : Variant );
    procedure SetCobro_ReferenciaMandato( const Value  : Variant );
    procedure SetCobro_FechaMandato( const Value  : Variant );
    procedure SetCobro_CicloMandato( const Value  : Variant );
    procedure SetCobro_BIC( const Value  : Variant );
    procedure SetCobro_IBAN( const Value  : Variant );
    procedure SetAnotacion( const Value  : Variant );
    procedure SetAviso( const Value  : Variant );
    procedure SetMostrarAviso( const Value  : Variant );
    property RemoteCursorID : TnxCursorID read GetRemoteCursorID write SetRemoteCursorID;
    property State : TDatasetState read GetState write SetState;

    property Codigo : String read GetCodigo write SetCodigo;
    property Nombre : Variant read GetNombre write SetNombre;
    property Domicilio : Variant read GetDomicilio write SetDomicilio;
    property Localidad : Variant read GetLocalidad write SetLocalidad;
    property CodigoPais : Variant read GetCodigoPais write SetCodigoPais;
    property CodigoProvincia : Variant read GetCodigoProvincia write SetCodigoProvincia;
    property CodigoPostal : Variant read GetCodigoPostal write SetCodigoPostal;
    property Telefono : Variant read GetTelefono write SetTelefono;
    property Fax : Variant read GetFax write SetFax;
    property NIF : Variant read GetNIF write SetNIF;
    property TipoIdentificacion : Variant read GetTipoIdentificacion write SetTipoIdentificacion;
    property EMail : Variant read GetEMail write SetEMail;
    property DocumentosExternos : Variant read GetDocumentosExternos write SetDocumentosExternos;
    property Vendedor : Variant read GetVendedor write SetVendedor;
    property Subcuenta : Variant read GetSubcuenta write SetSubcuenta;
    property CodigoDivisa : Variant read GetCodigoDivisa write SetCodigoDivisa;
    property CampoLibre[ Index : SmallInt ] : Variant read GetCampoLibre write SetCampoLibre;
    property Bloqueado : Variant read GetBloqueado write SetBloqueado;
    property Obsoleto : Variant read GetObsoleto write SetObsoleto;
    property FechaAlta : Variant read GetFechaAlta write SetFechaAlta;
    property PalabraPaso : Variant read GetPalabraPaso write SetPalabraPaso;
    property Latitud : Variant read GetLatitud write SetLatitud;
    property Longitud : Variant read GetLongitud write SetLongitud;
    property TiendaVirtual : Variant read GetTiendaVirtual write SetTiendaVirtual;
    property Envios_Nombre : Variant read GetEnvios_Nombre write SetEnvios_Nombre;
    property Envios_Domicilio : Variant read GetEnvios_Domicilio write SetEnvios_Domicilio;
    property Envios_Localidad : Variant read GetEnvios_Localidad write SetEnvios_Localidad;
    property Envios_CodigoProv : Variant read GetEnvios_CodigoProv write SetEnvios_CodigoProv;
    property Envios_CodigoPostal : Variant read GetEnvios_CodigoPostal write SetEnvios_CodigoPostal;
    property Envios_FormaEnvio : Variant read GetEnvios_FormaEnvio write SetEnvios_FormaEnvio;
    property Envios_Transportista : Variant read GetEnvios_Transportista write SetEnvios_Transportista;
    property Envios_CodigoFormaEnvio : Variant read GetEnvios_CodigoFormaEnvio write SetEnvios_CodigoFormaEnvio;
    property Envios_Bloqueado : Variant read GetEnvios_Bloqueado write SetEnvios_Bloqueado;
    property Envios_MotivoBloqueo : Variant read GetEnvios_MotivoBloqueo write SetEnvios_MotivoBloqueo;
    property Factura_DtoPP : Variant read GetFactura_DtoPP write SetFactura_DtoPP;
    property Factura_DtoES : Variant read GetFactura_DtoES write SetFactura_DtoES;
    property Factura_RecFinanc : Variant read GetFactura_RecFinanc write SetFactura_RecFinanc;
    property Factura_ModeloIVA : Variant read GetFactura_ModeloIVA write SetFactura_ModeloIVA;
    property Factura_TipoFijoIVA : Variant read GetFactura_TipoFijoIVA write SetFactura_TipoFijoIVA;
    property Factura_TipoRet : Variant read GetFactura_TipoRet write SetFactura_TipoRet;
    property Factura_Credito : Variant read GetFactura_Credito write SetFactura_Credito;
    property Factura_Agrupacion : Variant read GetFactura_Agrupacion write SetFactura_Agrupacion;
    property Factura_Reservado : Variant read GetFactura_Reservado write SetFactura_Reservado;
    property Factura_Tarifa : Variant read GetFactura_Tarifa write SetFactura_Tarifa;
    property Factura_Comision : Variant read GetFactura_Comision write SetFactura_Comision;
    property Factura_NroCopias : Variant read GetFactura_NroCopias write SetFactura_NroCopias;
    property Factura_NroCopiasAlbaran : Variant read GetFactura_NroCopiasAlbaran write SetFactura_NroCopiasAlbaran;
    property Factura_Moneda : Variant read GetFactura_Moneda write SetFactura_Moneda;
    property Factura_EnviarPorCorreo : Variant read GetFactura_EnviarPorCorreo write SetFactura_EnviarPorCorreo;
    property Factura_SinDtosConsumo : Variant read GetFactura_SinDtosConsumo write SetFactura_SinDtosConsumo;
    property Factura_NoAplicarOfertas : Variant read GetFactura_NoAplicarOfertas write SetFactura_NoAplicarOfertas;
    property Factura_CodigoEAN : Variant read GetFactura_CodigoEAN write SetFactura_CodigoEAN;
    property Cobro_Nombre : Variant read GetCobro_Nombre write SetCobro_Nombre;
    property Cobro_Domicilio : Variant read GetCobro_Domicilio write SetCobro_Domicilio;
    property Cobro_Localidad : Variant read GetCobro_Localidad write SetCobro_Localidad;
    property Cobro_CodigoProv : Variant read GetCobro_CodigoProv write SetCobro_CodigoProv;
    property Cobro_CodigoPostal : Variant read GetCobro_CodigoPostal write SetCobro_CodigoPostal;
    property Cobro_FormaCobro : Variant read GetCobro_FormaCobro write SetCobro_FormaCobro;
    property Cobro_DiaCobro1 : Variant read GetCobro_DiaCobro1 write SetCobro_DiaCobro1;
    property Cobro_DiaCobro2 : Variant read GetCobro_DiaCobro2 write SetCobro_DiaCobro2;
    property Cobro_MesNoCobro : Variant read GetCobro_MesNoCobro write SetCobro_MesNoCobro;
    property Cobro_CodigoEntidad : Variant read GetCobro_CodigoEntidad write SetCobro_CodigoEntidad;
    property Cobro_Entidad : Variant read GetCobro_Entidad write SetCobro_Entidad;
    property Cobro_CodigoSucursal : Variant read GetCobro_CodigoSucursal write SetCobro_CodigoSucursal;
    property Cobro_Sucursal : Variant read GetCobro_Sucursal write SetCobro_Sucursal;
    property Cobro_DC : Variant read GetCobro_DC write SetCobro_DC;
    property Cobro_Cuenta : Variant read GetCobro_Cuenta write SetCobro_Cuenta;
    property Cobro_CtaEntidad : Variant read GetCobro_CtaEntidad write SetCobro_CtaEntidad;
    property Cobro_CodigoINEPlaza : Variant read GetCobro_CodigoINEPlaza write SetCobro_CodigoINEPlaza;
    property Cobro_RiesgoLimite : Variant read GetCobro_RiesgoLimite write SetCobro_RiesgoLimite;
    property Cobro_ReferenciaMandato : Variant read GetCobro_ReferenciaMandato write SetCobro_ReferenciaMandato;
    property Cobro_FechaMandato : Variant read GetCobro_FechaMandato write SetCobro_FechaMandato;
    property Cobro_CicloMandato : Variant read GetCobro_CicloMandato write SetCobro_CicloMandato;
    property Cobro_BIC : Variant read GetCobro_BIC write SetCobro_BIC;
    property Cobro_IBAN : Variant read GetCobro_IBAN write SetCobro_IBAN;
    property Anotacion : Variant read GetAnotacion write SetAnotacion;
    property Aviso : Variant read GetAviso write SetAviso;
    property MostrarAviso : Variant read GetMostrarAviso write SetMostrarAviso;

    end;

   TCliente = class( TnxClass, InxRemoteableClass, ICliente)
     private

     FRemoteCursorID,
     FState : Variant;

     FCodigo,
     FNombre,
     FDomicilio,
     FLocalidad,
     FCodigoPais,
     FCodigoProvincia,
     FCodigoPostal,
     FTelefono,
     FFax,
     FNIF,
     FTipoIdentificacion,
     FEMail,
     FDocumentosExternos,
     FVendedor,
     FSubcuenta,
     FCodigoDivisa : Variant;
     FCampoLibre : Array[ 1..4 ] of Variant;
     FBloqueado,
     FObsoleto,
     FFechaAlta,
     FPalabraPaso,
     FLatitud,
     FLongitud,
     FTiendaVirtual,
     FEnvios_Nombre,
     FEnvios_Domicilio,
     FEnvios_Localidad,
     FEnvios_CodigoProv,
     FEnvios_CodigoPostal,
     FEnvios_FormaEnvio,
     FEnvios_Transportista,
     FEnvios_CodigoFormaEnvio,
     FEnvios_Bloqueado,
     FEnvios_MotivoBloqueo,
     FFactura_DtoPP,
     FFactura_DtoES,
     FFactura_RecFinanc,
     FFactura_ModeloIVA,
     FFactura_TipoFijoIVA,
     FFactura_TipoRet,
     FFactura_Credito,
     FFactura_Agrupacion,
     FFactura_Reservado,
     FFactura_Tarifa,
     FFactura_Comision,
     FFactura_NroCopias,
     FFactura_NroCopiasAlbaran,
     FFactura_Moneda,
     FFactura_EnviarPorCorreo,
     FFactura_SinDtosConsumo,
     FFactura_NoAplicarOfertas,
     FFactura_CodigoEAN,
     FCobro_Nombre,
     FCobro_Domicilio,
     FCobro_Localidad,
     FCobro_CodigoProv,
     FCobro_CodigoPostal,
     FCobro_FormaCobro,
     FCobro_DiaCobro1,
     FCobro_DiaCobro2,
     FCobro_MesNoCobro,
     FCobro_CodigoEntidad,
     FCobro_Entidad,
     FCobro_CodigoSucursal,
     FCobro_Sucursal,
     FCobro_DC,
     FCobro_Cuenta,
     FCobro_CtaEntidad,
     FCobro_CodigoINEPlaza,
     FCobro_RiesgoLimite,
     FCobro_ReferenciaMandato,
     FCobro_FechaMandato,
     FCobro_CicloMandato,
     FCobro_BIC,
     FCobro_IBAN,
     FAnotacion,
     FAviso,
     FMostrarAviso : Variant;

     function GetCodigo : String;
     function GetNombre : Variant;
     function GetDomicilio : Variant;
     function GetLocalidad : Variant;
     function GetCodigoPais : Variant;
     function GetCodigoProvincia : Variant;
     function GetCodigoPostal : Variant;
     function GetTelefono : Variant;
     function GetFax : Variant;
     function GetNIF : Variant;
     function GetTipoIdentificacion : Variant;
     function GetEMail : Variant;
     function GetDocumentosExternos : Variant;
     function GetVendedor : Variant;
     function GetSubcuenta : Variant;
     function GetCodigoDivisa : Variant;
     function GetCampoLibre( Index : SmallInt ) : Variant;
     function GetBloqueado : Variant;
     function GetObsoleto : Variant;
     function GetFechaAlta : Variant;
     function GetPalabraPaso : Variant;
     function GetLatitud : Variant;
     function GetLongitud : Variant;
     function GetTiendaVirtual : Variant;
     function GetEnvios_Nombre : Variant;
     function GetEnvios_Domicilio : Variant;
     function GetEnvios_Localidad : Variant;
     function GetEnvios_CodigoProv : Variant;
     function GetEnvios_CodigoPostal : Variant;
     function GetEnvios_FormaEnvio : Variant;
     function GetEnvios_Transportista : Variant;
     function GetEnvios_CodigoFormaEnvio : Variant;
     function GetEnvios_Bloqueado : Variant;
     function GetEnvios_MotivoBloqueo : Variant;
     function GetFactura_DtoPP : Variant;
     function GetFactura_DtoES : Variant;
     function GetFactura_RecFinanc : Variant;
     function GetFactura_ModeloIVA : Variant;
     function GetFactura_TipoFijoIVA : Variant;
     function GetFactura_TipoRet : Variant;
     function GetFactura_Credito : Variant;
     function GetFactura_Agrupacion : Variant;
     function GetFactura_Reservado : Variant;
     function GetFactura_Tarifa : Variant;
     function GetFactura_Comision : Variant;
     function GetFactura_NroCopias : Variant;
     function GetFactura_NroCopiasAlbaran : Variant;
     function GetFactura_Moneda : Variant;
     function GetFactura_EnviarPorCorreo : Variant;
     function GetFactura_SinDtosConsumo : Variant;
     function GetFactura_NoAplicarOfertas : Variant;
     function GetFactura_CodigoEAN : Variant;
     function GetCobro_Nombre : Variant;
     function GetCobro_Domicilio : Variant;
     function GetCobro_Localidad : Variant;
     function GetCobro_CodigoProv : Variant;
     function GetCobro_CodigoPostal : Variant;
     function GetCobro_FormaCobro : Variant;
     function GetCobro_DiaCobro1 : Variant;
     function GetCobro_DiaCobro2 : Variant;
     function GetCobro_MesNoCobro : Variant;
     function GetCobro_CodigoEntidad : Variant;
     function GetCobro_Entidad : Variant;
     function GetCobro_CodigoSucursal : Variant;
     function GetCobro_Sucursal : Variant;
     function GetCobro_DC : Variant;
     function GetCobro_Cuenta : Variant;
     function GetCobro_CtaEntidad : Variant;
     function GetCobro_CodigoINEPlaza : Variant;
     function GetCobro_RiesgoLimite : Variant;
     function GetCobro_ReferenciaMandato : Variant;
     function GetCobro_FechaMandato : Variant;
     function GetCobro_CicloMandato : Variant;
     function GetCobro_BIC : Variant;
     function GetCobro_IBAN : Variant;
     function GetAnotacion : Variant;
     function GetAviso : Variant;
     function GetMostrarAviso : Variant;

     procedure SetCodigo( const Value  : String );
     procedure SetNombre( const Value  : Variant );
     procedure SetDomicilio( const Value  : Variant );
     procedure SetLocalidad( const Value  : Variant );
     procedure SetCodigoPais( const Value  : Variant );
     procedure SetCodigoProvincia( const Value  : Variant );
     procedure SetCodigoPostal( const Value  : Variant );
     procedure SetTelefono( const Value  : Variant );
     procedure SetFax( const Value  : Variant );
     procedure SetNIF( const Value  : Variant );
     procedure SetTipoIdentificacion( const Value  : Variant );
     procedure SetEMail( const Value  : Variant );
     procedure SetDocumentosExternos( const Value  : Variant );
     procedure SetVendedor( const Value  : Variant );
     procedure SetSubcuenta( const Value  : Variant );
     procedure SetCodigoDivisa( const Value  : Variant );
     procedure SetCampoLibre( Index : SmallInt; const Value  : Variant );
     procedure SetBloqueado( const Value  : Variant );
     procedure SetObsoleto( const Value  : Variant );
     procedure SetFechaAlta( const Value  : Variant );
     procedure SetPalabraPaso( const Value  : Variant );
     procedure SetLatitud( const Value  : Variant );
     procedure SetLongitud( const Value  : Variant );
     procedure SetTiendaVirtual( const Value  : Variant );
     procedure SetEnvios_Nombre( const Value  : Variant );
     procedure SetEnvios_Domicilio( const Value  : Variant );
     procedure SetEnvios_Localidad( const Value  : Variant );
     procedure SetEnvios_CodigoProv( const Value  : Variant );
     procedure SetEnvios_CodigoPostal( const Value  : Variant );
     procedure SetEnvios_FormaEnvio( const Value  : Variant );
     procedure SetEnvios_Transportista( const Value  : Variant );
     procedure SetEnvios_CodigoFormaEnvio( const Value  : Variant );
     procedure SetEnvios_Bloqueado( const Value  : Variant );
     procedure SetEnvios_MotivoBloqueo( const Value  : Variant );
     procedure SetFactura_DtoPP( const Value  : Variant );
     procedure SetFactura_DtoES( const Value  : Variant );
     procedure SetFactura_RecFinanc( const Value  : Variant );
     procedure SetFactura_ModeloIVA( const Value  : Variant );
     procedure SetFactura_TipoFijoIVA( const Value  : Variant );
     procedure SetFactura_TipoRet( const Value  : Variant );
     procedure SetFactura_Credito( const Value  : Variant );
     procedure SetFactura_Agrupacion( const Value  : Variant );
     procedure SetFactura_Reservado( const Value  : Variant );
     procedure SetFactura_Tarifa( const Value  : Variant );
     procedure SetFactura_Comision( const Value  : Variant );
     procedure SetFactura_NroCopias( const Value  : Variant );
     procedure SetFactura_NroCopiasAlbaran( const Value  : Variant );
     procedure SetFactura_Moneda( const Value  : Variant );
     procedure SetFactura_EnviarPorCorreo( const Value  : Variant );
     procedure SetFactura_SinDtosConsumo( const Value  : Variant );
     procedure SetFactura_NoAplicarOfertas( const Value  : Variant );
     procedure SetFactura_CodigoEAN( const Value  : Variant );
     procedure SetCobro_Nombre( const Value  : Variant );
     procedure SetCobro_Domicilio( const Value  : Variant );
     procedure SetCobro_Localidad( const Value  : Variant );
     procedure SetCobro_CodigoProv( const Value  : Variant );
     procedure SetCobro_CodigoPostal( const Value  : Variant );
     procedure SetCobro_FormaCobro( const Value  : Variant );
     procedure SetCobro_DiaCobro1( const Value  : Variant );
     procedure SetCobro_DiaCobro2( const Value  : Variant );
     procedure SetCobro_MesNoCobro( const Value  : Variant );
     procedure SetCobro_CodigoEntidad( const Value  : Variant );
     procedure SetCobro_Entidad( const Value  : Variant );
     procedure SetCobro_CodigoSucursal( const Value  : Variant );
     procedure SetCobro_Sucursal( const Value  : Variant );
     procedure SetCobro_DC( const Value  : Variant );
     procedure SetCobro_Cuenta( const Value  : Variant );
     procedure SetCobro_CtaEntidad( const Value  : Variant );
     procedure SetCobro_CodigoINEPlaza( const Value  : Variant );
     procedure SetCobro_RiesgoLimite( const Value  : Variant );
     procedure SetCobro_ReferenciaMandato( const Value  : Variant );
     procedure SetCobro_FechaMandato( const Value  : Variant );
     procedure SetCobro_CicloMandato( const Value  : Variant );
     procedure SetCobro_BIC( const Value  : Variant );
     procedure SetCobro_IBAN( const Value  : Variant );
     procedure SetAnotacion( const Value  : Variant );
     procedure SetAviso( const Value  : Variant );
     procedure SetMostrarAviso( const Value  : Variant );

     function LoadFromReader( AReader : InxReader ) : HRESULT;
     function SaveToWriter( AWriter : InxWriter ) : HRESULT;

     function GetRemoteCursorID : TnxCursorID;
     procedure SetRemoteCursorID( const Value : TnxCursorID );
     function GetState : TDataSetState;
     procedure SetState( const Value : TDataSetState );
     function GetClassID : TnxGuid;

     public

     constructor Create; reintroduce;

     class function FromDataset( ClienteFields  : TClienteFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : ICliente;
     procedure ToDataset( ClienteFields : TClienteFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );

     end;

implementation

uses  Variants;

{ TCliente }

constructor TCliente.Create;
begin
     inherited Create( @CLSID_Cliente, nil, nil, False);
     FState := dsInsert;
end;

class function TCliente.FromDataset( ClienteFields : TClienteFields; ReadBlobs : Boolean = True; OldValues : Boolean = False ) : ICliente;

var   SaveState : TDataSetState;
      ApplyOldValues : Boolean;

begin
      Result := TCliente.Create;

      With Result do
        begin

        RemoteCursorID := ClienteFields.GetRemoteCursorID;
        State := ClienteFields.Dataset.State;
        SaveState := State;

        ApplyOldValues := OldValues and not ( State in [ dsInsert, dsSetKey ] );
        If   ApplyOldValues
        then ClienteFields.IDataset.SetTempState( dsOldValue );

        try

          Codigo := GetFieldAsVariant( ClienteFields.Codigo );
          Nombre := GetFieldAsVariant( ClienteFields.Nombre );
          Domicilio := GetFieldAsVariant( ClienteFields.Domicilio );
          Localidad := GetFieldAsVariant( ClienteFields.Localidad );
          CodigoPais := GetFieldAsVariant( ClienteFields.CodigoPais );
          CodigoProvincia := GetFieldAsVariant( ClienteFields.CodigoProvincia );
          CodigoPostal := GetFieldAsVariant( ClienteFields.CodigoPostal );
          Telefono := GetFieldAsVariant( ClienteFields.Telefono );
          Fax := GetFieldAsVariant( ClienteFields.Fax );
          NIF := GetFieldAsVariant( ClienteFields.NIF );
          TipoIdentificacion := GetFieldAsVariant( ClienteFields.TipoIdentificacion );
          EMail := GetFieldAsVariant( ClienteFields.EMail );
          DocumentosExternos := GetFieldAsVariant( ClienteFields.DocumentosExternos );
          Vendedor := GetFieldAsVariant( ClienteFields.Vendedor );
          Subcuenta := GetFieldAsVariant( ClienteFields.Subcuenta );
          CodigoDivisa := GetFieldAsVariant( ClienteFields.CodigoDivisa );
          For var Inx := 1 to 4 do 
            CampoLibre[ Inx ] := GetFieldAsVariant( ClienteFields.CampoLibre[ Inx ] );
          Bloqueado := GetFieldAsVariant( ClienteFields.Bloqueado );
          Obsoleto := GetFieldAsVariant( ClienteFields.Obsoleto );
          FechaAlta := GetFieldAsVariant( ClienteFields.FechaAlta );
          PalabraPaso := GetFieldAsVariant( ClienteFields.PalabraPaso );
          Latitud := GetFieldAsVariant( ClienteFields.Latitud );
          Longitud := GetFieldAsVariant( ClienteFields.Longitud );
          TiendaVirtual := GetFieldAsVariant( ClienteFields.TiendaVirtual );
          Envios_Nombre := GetFieldAsVariant( ClienteFields.Envios_Nombre );
          Envios_Domicilio := GetFieldAsVariant( ClienteFields.Envios_Domicilio );
          Envios_Localidad := GetFieldAsVariant( ClienteFields.Envios_Localidad );
          Envios_CodigoProv := GetFieldAsVariant( ClienteFields.Envios_CodigoProv );
          Envios_CodigoPostal := GetFieldAsVariant( ClienteFields.Envios_CodigoPostal );
          Envios_FormaEnvio := GetFieldAsVariant( ClienteFields.Envios_FormaEnvio );
          Envios_Transportista := GetFieldAsVariant( ClienteFields.Envios_Transportista );
          Envios_CodigoFormaEnvio := GetFieldAsVariant( ClienteFields.Envios_CodigoFormaEnvio );
          Envios_Bloqueado := GetFieldAsVariant( ClienteFields.Envios_Bloqueado );
          Factura_DtoPP := GetFieldAsVariant( ClienteFields.Factura_DtoPP );
          Factura_DtoES := GetFieldAsVariant( ClienteFields.Factura_DtoES );
          Factura_RecFinanc := GetFieldAsVariant( ClienteFields.Factura_RecFinanc );
          Factura_ModeloIVA := GetFieldAsVariant( ClienteFields.Factura_ModeloIVA );
          Factura_TipoFijoIVA := GetFieldAsVariant( ClienteFields.Factura_TipoFijoIVA );
          Factura_TipoRet := GetFieldAsVariant( ClienteFields.Factura_TipoRet );
          Factura_Credito := GetFieldAsVariant( ClienteFields.Factura_Credito );
          Factura_Agrupacion := GetFieldAsVariant( ClienteFields.Factura_Agrupacion );
          Factura_Reservado := GetFieldAsVariant( ClienteFields.Factura_Reservado );
          Factura_Tarifa := GetFieldAsVariant( ClienteFields.Factura_Tarifa );
          Factura_Comision := GetFieldAsVariant( ClienteFields.Factura_Comision );
          Factura_NroCopias := GetFieldAsVariant( ClienteFields.Factura_NroCopias );
          Factura_NroCopiasAlbaran := GetFieldAsVariant( ClienteFields.Factura_NroCopiasAlbaran );
          Factura_Moneda := GetFieldAsVariant( ClienteFields.Factura_Moneda );
          Factura_EnviarPorCorreo := GetFieldAsVariant( ClienteFields.Factura_EnviarPorCorreo );
          Factura_SinDtosConsumo := GetFieldAsVariant( ClienteFields.Factura_SinDtosConsumo );
          Factura_NoAplicarOfertas := GetFieldAsVariant( ClienteFields.Factura_NoAplicarOfertas );
          Factura_CodigoEAN := GetFieldAsVariant( ClienteFields.Factura_CodigoEAN );
          Cobro_Nombre := GetFieldAsVariant( ClienteFields.Cobro_Nombre );
          Cobro_Domicilio := GetFieldAsVariant( ClienteFields.Cobro_Domicilio );
          Cobro_Localidad := GetFieldAsVariant( ClienteFields.Cobro_Localidad );
          Cobro_CodigoProv := GetFieldAsVariant( ClienteFields.Cobro_CodigoProv );
          Cobro_CodigoPostal := GetFieldAsVariant( ClienteFields.Cobro_CodigoPostal );
          Cobro_FormaCobro := GetFieldAsVariant( ClienteFields.Cobro_FormaCobro );
          Cobro_DiaCobro1 := GetFieldAsVariant( ClienteFields.Cobro_DiaCobro1 );
          Cobro_DiaCobro2 := GetFieldAsVariant( ClienteFields.Cobro_DiaCobro2 );
          Cobro_MesNoCobro := GetFieldAsVariant( ClienteFields.Cobro_MesNoCobro );
          Cobro_CodigoEntidad := GetFieldAsVariant( ClienteFields.Cobro_CodigoEntidad );
          Cobro_Entidad := GetFieldAsVariant( ClienteFields.Cobro_Entidad );
          Cobro_CodigoSucursal := GetFieldAsVariant( ClienteFields.Cobro_CodigoSucursal );
          Cobro_Sucursal := GetFieldAsVariant( ClienteFields.Cobro_Sucursal );
          Cobro_DC := GetFieldAsVariant( ClienteFields.Cobro_DC );
          Cobro_Cuenta := GetFieldAsVariant( ClienteFields.Cobro_Cuenta );
          Cobro_CtaEntidad := GetFieldAsVariant( ClienteFields.Cobro_CtaEntidad );
          Cobro_CodigoINEPlaza := GetFieldAsVariant( ClienteFields.Cobro_CodigoINEPlaza );
          Cobro_RiesgoLimite := GetFieldAsVariant( ClienteFields.Cobro_RiesgoLimite );
          Cobro_ReferenciaMandato := GetFieldAsVariant( ClienteFields.Cobro_ReferenciaMandato );
          Cobro_FechaMandato := GetFieldAsVariant( ClienteFields.Cobro_FechaMandato );
          Cobro_CicloMandato := GetFieldAsVariant( ClienteFields.Cobro_CicloMandato );
          Cobro_BIC := GetFieldAsVariant( ClienteFields.Cobro_BIC );
          Cobro_IBAN := GetFieldAsVariant( ClienteFields.Cobro_IBAN );
          MostrarAviso := GetFieldAsVariant( ClienteFields.MostrarAviso );

          If   ReadBlobs
          then begin
               Envios_MotivoBloqueo := GetFieldAsVariant( ClienteFields.Envios_MotivoBloqueo );
               Anotacion := GetFieldAsVariant( ClienteFields.Anotacion );
               Aviso := GetFieldAsVariant( ClienteFields.Aviso );
               end
          else begin
               Envios_MotivoBloqueo := '';
               Anotacion := '';
               Aviso := '';
               end;

        finally
          If   ApplyOldValues
          then ClienteFields.IDataset.RestoreState( SaveState );
        end;
      end;

end;

procedure TCliente.ToDataset( ClienteFields : TClienteFields; PreserveState : Boolean = False; ReadBlobs : Boolean = True );
begin
     try

       If   not PreserveState
       then ClienteFields.SetStateFromInterface( FState );

       ClienteFields.Codigo.Value := FCodigo;

       SetFieldAsVariant( ClienteFields.Nombre, FNombre );
       SetFieldAsVariant( ClienteFields.Domicilio, FDomicilio );
       SetFieldAsVariant( ClienteFields.Localidad, FLocalidad );
       SetFieldAsVariant( ClienteFields.CodigoPais, FCodigoPais );
       SetFieldAsVariant( ClienteFields.CodigoProvincia, FCodigoProvincia );
       SetFieldAsVariant( ClienteFields.CodigoPostal, FCodigoPostal );
       SetFieldAsVariant( ClienteFields.Telefono, FTelefono );
       SetFieldAsVariant( ClienteFields.Fax, FFax );
       SetFieldAsVariant( ClienteFields.NIF, FNIF );
       SetFieldAsVariant( ClienteFields.TipoIdentificacion, FTipoIdentificacion );
       SetFieldAsVariant( ClienteFields.EMail, FEMail );
       SetFieldAsVariant( ClienteFields.DocumentosExternos, FDocumentosExternos );
       SetFieldAsVariant( ClienteFields.Vendedor, FVendedor );
       SetFieldAsVariant( ClienteFields.Subcuenta, FSubcuenta );
       SetFieldAsVariant( ClienteFields.CodigoDivisa, FCodigoDivisa );
       For var Inx := 1 to 4 do 
         SetFieldAsVariant( ClienteFields.CampoLibre[ Inx ], FCampoLibre[ Inx ] );
       SetFieldAsVariant( ClienteFields.Bloqueado, FBloqueado );
       SetFieldAsVariant( ClienteFields.Obsoleto, FObsoleto );
       SetFieldAsVariant( ClienteFields.FechaAlta, FFechaAlta );
       SetFieldAsVariant( ClienteFields.PalabraPaso, FPalabraPaso );
       SetFieldAsVariant( ClienteFields.Latitud, FLatitud );
       SetFieldAsVariant( ClienteFields.Longitud, FLongitud );
       SetFieldAsVariant( ClienteFields.TiendaVirtual, FTiendaVirtual );
       SetFieldAsVariant( ClienteFields.Envios_Nombre, FEnvios_Nombre );
       SetFieldAsVariant( ClienteFields.Envios_Domicilio, FEnvios_Domicilio );
       SetFieldAsVariant( ClienteFields.Envios_Localidad, FEnvios_Localidad );
       SetFieldAsVariant( ClienteFields.Envios_CodigoProv, FEnvios_CodigoProv );
       SetFieldAsVariant( ClienteFields.Envios_CodigoPostal, FEnvios_CodigoPostal );
       SetFieldAsVariant( ClienteFields.Envios_FormaEnvio, FEnvios_FormaEnvio );
       SetFieldAsVariant( ClienteFields.Envios_Transportista, FEnvios_Transportista );
       SetFieldAsVariant( ClienteFields.Envios_CodigoFormaEnvio, FEnvios_CodigoFormaEnvio );
       SetFieldAsVariant( ClienteFields.Envios_Bloqueado, FEnvios_Bloqueado );
       SetFieldAsVariant( ClienteFields.Factura_DtoPP, FFactura_DtoPP );
       SetFieldAsVariant( ClienteFields.Factura_DtoES, FFactura_DtoES );
       SetFieldAsVariant( ClienteFields.Factura_RecFinanc, FFactura_RecFinanc );
       SetFieldAsVariant( ClienteFields.Factura_ModeloIVA, FFactura_ModeloIVA );
       SetFieldAsVariant( ClienteFields.Factura_TipoFijoIVA, FFactura_TipoFijoIVA );
       SetFieldAsVariant( ClienteFields.Factura_TipoRet, FFactura_TipoRet );
       SetFieldAsVariant( ClienteFields.Factura_Credito, FFactura_Credito );
       SetFieldAsVariant( ClienteFields.Factura_Agrupacion, FFactura_Agrupacion );
       SetFieldAsVariant( ClienteFields.Factura_Reservado, FFactura_Reservado );
       SetFieldAsVariant( ClienteFields.Factura_Tarifa, FFactura_Tarifa );
       SetFieldAsVariant( ClienteFields.Factura_Comision, FFactura_Comision );
       SetFieldAsVariant( ClienteFields.Factura_NroCopias, FFactura_NroCopias );
       SetFieldAsVariant( ClienteFields.Factura_NroCopiasAlbaran, FFactura_NroCopiasAlbaran );
       SetFieldAsVariant( ClienteFields.Factura_Moneda, FFactura_Moneda );
       SetFieldAsVariant( ClienteFields.Factura_EnviarPorCorreo, FFactura_EnviarPorCorreo );
       SetFieldAsVariant( ClienteFields.Factura_SinDtosConsumo, FFactura_SinDtosConsumo );
       SetFieldAsVariant( ClienteFields.Factura_NoAplicarOfertas, FFactura_NoAplicarOfertas );
       SetFieldAsVariant( ClienteFields.Factura_CodigoEAN, FFactura_CodigoEAN );
       SetFieldAsVariant( ClienteFields.Cobro_Nombre, FCobro_Nombre );
       SetFieldAsVariant( ClienteFields.Cobro_Domicilio, FCobro_Domicilio );
       SetFieldAsVariant( ClienteFields.Cobro_Localidad, FCobro_Localidad );
       SetFieldAsVariant( ClienteFields.Cobro_CodigoProv, FCobro_CodigoProv );
       SetFieldAsVariant( ClienteFields.Cobro_CodigoPostal, FCobro_CodigoPostal );
       SetFieldAsVariant( ClienteFields.Cobro_FormaCobro, FCobro_FormaCobro );
       SetFieldAsVariant( ClienteFields.Cobro_DiaCobro1, FCobro_DiaCobro1 );
       SetFieldAsVariant( ClienteFields.Cobro_DiaCobro2, FCobro_DiaCobro2 );
       SetFieldAsVariant( ClienteFields.Cobro_MesNoCobro, FCobro_MesNoCobro );
       SetFieldAsVariant( ClienteFields.Cobro_CodigoEntidad, FCobro_CodigoEntidad );
       SetFieldAsVariant( ClienteFields.Cobro_Entidad, FCobro_Entidad );
       SetFieldAsVariant( ClienteFields.Cobro_CodigoSucursal, FCobro_CodigoSucursal );
       SetFieldAsVariant( ClienteFields.Cobro_Sucursal, FCobro_Sucursal );
       SetFieldAsVariant( ClienteFields.Cobro_DC, FCobro_DC );
       SetFieldAsVariant( ClienteFields.Cobro_Cuenta, FCobro_Cuenta );
       SetFieldAsVariant( ClienteFields.Cobro_CtaEntidad, FCobro_CtaEntidad );
       SetFieldAsVariant( ClienteFields.Cobro_CodigoINEPlaza, FCobro_CodigoINEPlaza );
       SetFieldAsVariant( ClienteFields.Cobro_RiesgoLimite, FCobro_RiesgoLimite );
       SetFieldAsVariant( ClienteFields.Cobro_ReferenciaMandato, FCobro_ReferenciaMandato );
       SetFieldAsVariant( ClienteFields.Cobro_FechaMandato, FCobro_FechaMandato );
       SetFieldAsVariant( ClienteFields.Cobro_CicloMandato, FCobro_CicloMandato );
       SetFieldAsVariant( ClienteFields.Cobro_BIC, FCobro_BIC );
       SetFieldAsVariant( ClienteFields.Cobro_IBAN, FCobro_IBAN );
       SetFieldAsVariant( ClienteFields.MostrarAviso, FMostrarAviso );

       If   ReadBlobs
       then begin
            SetFieldAsVariant( ClienteFields.Envios_MotivoBloqueo, FEnvios_MotivoBloqueo );
            SetFieldAsVariant( ClienteFields.Anotacion, FAnotacion );
            SetFieldAsVariant( ClienteFields.Aviso, FAviso );
            end
       else begin
            ClienteFields.Envios_MotivoBloqueo.Clear;
            ClienteFields.Anotacion.Clear;
            ClienteFields.Aviso.Clear;
            end;

     except
       ClienteFields.Dataset.Cancel;
       raise;
       end;

end;

function TCliente.LoadFromReader( AReader : InxReader ) : HRESULT;

var VarFlags : TnxVarFlags;

begin
     nxReadVariant( VarFlags, FRemoteCursorID, AReader );
     nxReadVariant( VarFlags, FState, AReader );

     nxReadVariant( VarFlags, FCodigo, AReader );
     nxReadVariant( VarFlags, FNombre, AReader );
     nxReadVariant( VarFlags, FDomicilio, AReader );
     nxReadVariant( VarFlags, FLocalidad, AReader );
     nxReadVariant( VarFlags, FCodigoPais, AReader );
     nxReadVariant( VarFlags, FCodigoProvincia, AReader );
     nxReadVariant( VarFlags, FCodigoPostal, AReader );
     nxReadVariant( VarFlags, FTelefono, AReader );
     nxReadVariant( VarFlags, FFax, AReader );
     nxReadVariant( VarFlags, FNIF, AReader );
     nxReadVariant( VarFlags, FTipoIdentificacion, AReader );
     nxReadVariant( VarFlags, FEMail, AReader );
     nxReadVariant( VarFlags, FDocumentosExternos, AReader );
     nxReadVariant( VarFlags, FVendedor, AReader );
     nxReadVariant( VarFlags, FSubcuenta, AReader );
     nxReadVariant( VarFlags, FCodigoDivisa, AReader );
     For var Inx := 1 to 4 do 
       nxReadVariant( VarFlags, FCampoLibre[ Inx ], AReader );
     nxReadVariant( VarFlags, FBloqueado, AReader );
     nxReadVariant( VarFlags, FObsoleto, AReader );
     nxReadVariant( VarFlags, FFechaAlta, AReader );
     nxReadVariant( VarFlags, FPalabraPaso, AReader );
     nxReadVariant( VarFlags, FLatitud, AReader );
     nxReadVariant( VarFlags, FLongitud, AReader );
     nxReadVariant( VarFlags, FTiendaVirtual, AReader );
     nxReadVariant( VarFlags, FEnvios_Nombre, AReader );
     nxReadVariant( VarFlags, FEnvios_Domicilio, AReader );
     nxReadVariant( VarFlags, FEnvios_Localidad, AReader );
     nxReadVariant( VarFlags, FEnvios_CodigoProv, AReader );
     nxReadVariant( VarFlags, FEnvios_CodigoPostal, AReader );
     nxReadVariant( VarFlags, FEnvios_FormaEnvio, AReader );
     nxReadVariant( VarFlags, FEnvios_Transportista, AReader );
     nxReadVariant( VarFlags, FEnvios_CodigoFormaEnvio, AReader );
     nxReadVariant( VarFlags, FEnvios_Bloqueado, AReader );
     nxReadVariant( VarFlags, FEnvios_MotivoBloqueo, AReader );
     nxReadVariant( VarFlags, FFactura_DtoPP, AReader );
     nxReadVariant( VarFlags, FFactura_DtoES, AReader );
     nxReadVariant( VarFlags, FFactura_RecFinanc, AReader );
     nxReadVariant( VarFlags, FFactura_ModeloIVA, AReader );
     nxReadVariant( VarFlags, FFactura_TipoFijoIVA, AReader );
     nxReadVariant( VarFlags, FFactura_TipoRet, AReader );
     nxReadVariant( VarFlags, FFactura_Credito, AReader );
     nxReadVariant( VarFlags, FFactura_Agrupacion, AReader );
     nxReadVariant( VarFlags, FFactura_Reservado, AReader );
     nxReadVariant( VarFlags, FFactura_Tarifa, AReader );
     nxReadVariant( VarFlags, FFactura_Comision, AReader );
     nxReadVariant( VarFlags, FFactura_NroCopias, AReader );
     nxReadVariant( VarFlags, FFactura_NroCopiasAlbaran, AReader );
     nxReadVariant( VarFlags, FFactura_Moneda, AReader );
     nxReadVariant( VarFlags, FFactura_EnviarPorCorreo, AReader );
     nxReadVariant( VarFlags, FFactura_SinDtosConsumo, AReader );
     nxReadVariant( VarFlags, FFactura_NoAplicarOfertas, AReader );
     nxReadVariant( VarFlags, FFactura_CodigoEAN, AReader );
     nxReadVariant( VarFlags, FCobro_Nombre, AReader );
     nxReadVariant( VarFlags, FCobro_Domicilio, AReader );
     nxReadVariant( VarFlags, FCobro_Localidad, AReader );
     nxReadVariant( VarFlags, FCobro_CodigoProv, AReader );
     nxReadVariant( VarFlags, FCobro_CodigoPostal, AReader );
     nxReadVariant( VarFlags, FCobro_FormaCobro, AReader );
     nxReadVariant( VarFlags, FCobro_DiaCobro1, AReader );
     nxReadVariant( VarFlags, FCobro_DiaCobro2, AReader );
     nxReadVariant( VarFlags, FCobro_MesNoCobro, AReader );
     nxReadVariant( VarFlags, FCobro_CodigoEntidad, AReader );
     nxReadVariant( VarFlags, FCobro_Entidad, AReader );
     nxReadVariant( VarFlags, FCobro_CodigoSucursal, AReader );
     nxReadVariant( VarFlags, FCobro_Sucursal, AReader );
     nxReadVariant( VarFlags, FCobro_DC, AReader );
     nxReadVariant( VarFlags, FCobro_Cuenta, AReader );
     nxReadVariant( VarFlags, FCobro_CtaEntidad, AReader );
     nxReadVariant( VarFlags, FCobro_CodigoINEPlaza, AReader );
     nxReadVariant( VarFlags, FCobro_RiesgoLimite, AReader );
     nxReadVariant( VarFlags, FCobro_ReferenciaMandato, AReader );
     nxReadVariant( VarFlags, FCobro_FechaMandato, AReader );
     nxReadVariant( VarFlags, FCobro_CicloMandato, AReader );
     nxReadVariant( VarFlags, FCobro_BIC, AReader );
     nxReadVariant( VarFlags, FCobro_IBAN, AReader );
     nxReadVariant( VarFlags, FAnotacion, AReader );
     nxReadVariant( VarFlags, FAviso, AReader );
     nxReadVariant( VarFlags, FMostrarAviso, AReader );

     Result := S_OK;
end;

function TCliente.SaveToWriter( AWriter : InxWriter) : HRESULT;
begin
     nxWriteVariant( FRemoteCursorID, AWriter );
     nxWriteVariant( FState, AWriter );

     nxWriteVariant( FCodigo, AWriter );
     nxWriteVariant( FNombre, AWriter );
     nxWriteVariant( FDomicilio, AWriter );
     nxWriteVariant( FLocalidad, AWriter );
     nxWriteVariant( FCodigoPais, AWriter );
     nxWriteVariant( FCodigoProvincia, AWriter );
     nxWriteVariant( FCodigoPostal, AWriter );
     nxWriteVariant( FTelefono, AWriter );
     nxWriteVariant( FFax, AWriter );
     nxWriteVariant( FNIF, AWriter );
     nxWriteVariant( FTipoIdentificacion, AWriter );
     nxWriteVariant( FEMail, AWriter );
     nxWriteVariant( FDocumentosExternos, AWriter );
     nxWriteVariant( FVendedor, AWriter );
     nxWriteVariant( FSubcuenta, AWriter );
     nxWriteVariant( FCodigoDivisa, AWriter );
     For var Inx := 1 to 4 do 
       nxWriteVariant( FCampoLibre[ Inx ], AWriter );
     nxWriteVariant( FBloqueado, AWriter );
     nxWriteVariant( FObsoleto, AWriter );
     nxWriteVariant( FFechaAlta, AWriter );
     nxWriteVariant( FPalabraPaso, AWriter );
     nxWriteVariant( FLatitud, AWriter );
     nxWriteVariant( FLongitud, AWriter );
     nxWriteVariant( FTiendaVirtual, AWriter );
     nxWriteVariant( FEnvios_Nombre, AWriter );
     nxWriteVariant( FEnvios_Domicilio, AWriter );
     nxWriteVariant( FEnvios_Localidad, AWriter );
     nxWriteVariant( FEnvios_CodigoProv, AWriter );
     nxWriteVariant( FEnvios_CodigoPostal, AWriter );
     nxWriteVariant( FEnvios_FormaEnvio, AWriter );
     nxWriteVariant( FEnvios_Transportista, AWriter );
     nxWriteVariant( FEnvios_CodigoFormaEnvio, AWriter );
     nxWriteVariant( FEnvios_Bloqueado, AWriter );
     nxWriteVariant( FEnvios_MotivoBloqueo, AWriter );
     nxWriteVariant( FFactura_DtoPP, AWriter );
     nxWriteVariant( FFactura_DtoES, AWriter );
     nxWriteVariant( FFactura_RecFinanc, AWriter );
     nxWriteVariant( FFactura_ModeloIVA, AWriter );
     nxWriteVariant( FFactura_TipoFijoIVA, AWriter );
     nxWriteVariant( FFactura_TipoRet, AWriter );
     nxWriteVariant( FFactura_Credito, AWriter );
     nxWriteVariant( FFactura_Agrupacion, AWriter );
     nxWriteVariant( FFactura_Reservado, AWriter );
     nxWriteVariant( FFactura_Tarifa, AWriter );
     nxWriteVariant( FFactura_Comision, AWriter );
     nxWriteVariant( FFactura_NroCopias, AWriter );
     nxWriteVariant( FFactura_NroCopiasAlbaran, AWriter );
     nxWriteVariant( FFactura_Moneda, AWriter );
     nxWriteVariant( FFactura_EnviarPorCorreo, AWriter );
     nxWriteVariant( FFactura_SinDtosConsumo, AWriter );
     nxWriteVariant( FFactura_NoAplicarOfertas, AWriter );
     nxWriteVariant( FFactura_CodigoEAN, AWriter );
     nxWriteVariant( FCobro_Nombre, AWriter );
     nxWriteVariant( FCobro_Domicilio, AWriter );
     nxWriteVariant( FCobro_Localidad, AWriter );
     nxWriteVariant( FCobro_CodigoProv, AWriter );
     nxWriteVariant( FCobro_CodigoPostal, AWriter );
     nxWriteVariant( FCobro_FormaCobro, AWriter );
     nxWriteVariant( FCobro_DiaCobro1, AWriter );
     nxWriteVariant( FCobro_DiaCobro2, AWriter );
     nxWriteVariant( FCobro_MesNoCobro, AWriter );
     nxWriteVariant( FCobro_CodigoEntidad, AWriter );
     nxWriteVariant( FCobro_Entidad, AWriter );
     nxWriteVariant( FCobro_CodigoSucursal, AWriter );
     nxWriteVariant( FCobro_Sucursal, AWriter );
     nxWriteVariant( FCobro_DC, AWriter );
     nxWriteVariant( FCobro_Cuenta, AWriter );
     nxWriteVariant( FCobro_CtaEntidad, AWriter );
     nxWriteVariant( FCobro_CodigoINEPlaza, AWriter );
     nxWriteVariant( FCobro_RiesgoLimite, AWriter );
     nxWriteVariant( FCobro_ReferenciaMandato, AWriter );
     nxWriteVariant( FCobro_FechaMandato, AWriter );
     nxWriteVariant( FCobro_CicloMandato, AWriter );
     nxWriteVariant( FCobro_BIC, AWriter );
     nxWriteVariant( FCobro_IBAN, AWriter );
     nxWriteVariant( FAnotacion, AWriter );
     nxWriteVariant( FAviso, AWriter );
     nxWriteVariant( FMostrarAviso, AWriter );
     Result := S_OK;
end;

{ Getters}

function TCliente.GetClassID: TnxGuid;
begin
     Result := CLSID_Cliente;
end;

function TCliente.GetRemoteCursorID: TnxCursorID;
begin
     Result := FRemoteCursorID;
end;

function TCliente.GetState: TDataSetState;
begin
     Result := FState;
end;


function TCliente.GetCodigo : String;
begin
     Result := FCodigo;
end;

function TCliente.GetNombre : Variant;
begin
     Result := FNombre;
end;

function TCliente.GetDomicilio : Variant;
begin
     Result := FDomicilio;
end;

function TCliente.GetLocalidad : Variant;
begin
     Result := FLocalidad;
end;

function TCliente.GetCodigoPais : Variant;
begin
     Result := FCodigoPais;
end;

function TCliente.GetCodigoProvincia : Variant;
begin
     Result := FCodigoProvincia;
end;

function TCliente.GetCodigoPostal : Variant;
begin
     Result := FCodigoPostal;
end;

function TCliente.GetTelefono : Variant;
begin
     Result := FTelefono;
end;

function TCliente.GetFax : Variant;
begin
     Result := FFax;
end;

function TCliente.GetNIF : Variant;
begin
     Result := FNIF;
end;

function TCliente.GetTipoIdentificacion : Variant;
begin
     Result := FTipoIdentificacion;
end;

function TCliente.GetEMail : Variant;
begin
     Result := FEMail;
end;

function TCliente.GetDocumentosExternos : Variant;
begin
     Result := FDocumentosExternos;
end;

function TCliente.GetVendedor : Variant;
begin
     Result := FVendedor;
end;

function TCliente.GetSubcuenta : Variant;
begin
     Result := FSubcuenta;
end;

function TCliente.GetCodigoDivisa : Variant;
begin
     Result := FCodigoDivisa;
end;

function TCliente.GetCampoLibre( Index : SmallInt ) : Variant;
begin
     Result := FCampoLibre[ Index ];
end;

function TCliente.GetBloqueado : Variant;
begin
     Result := FBloqueado;
end;

function TCliente.GetObsoleto : Variant;
begin
     Result := FObsoleto;
end;

function TCliente.GetFechaAlta : Variant;
begin
     Result := FFechaAlta;
end;

function TCliente.GetPalabraPaso : Variant;
begin
     Result := FPalabraPaso;
end;

function TCliente.GetLatitud : Variant;
begin
     Result := FLatitud;
end;

function TCliente.GetLongitud : Variant;
begin
     Result := FLongitud;
end;

function TCliente.GetTiendaVirtual : Variant;
begin
     Result := FTiendaVirtual;
end;

function TCliente.GetEnvios_Nombre : Variant;
begin
     Result := FEnvios_Nombre;
end;

function TCliente.GetEnvios_Domicilio : Variant;
begin
     Result := FEnvios_Domicilio;
end;

function TCliente.GetEnvios_Localidad : Variant;
begin
     Result := FEnvios_Localidad;
end;

function TCliente.GetEnvios_CodigoProv : Variant;
begin
     Result := FEnvios_CodigoProv;
end;

function TCliente.GetEnvios_CodigoPostal : Variant;
begin
     Result := FEnvios_CodigoPostal;
end;

function TCliente.GetEnvios_FormaEnvio : Variant;
begin
     Result := FEnvios_FormaEnvio;
end;

function TCliente.GetEnvios_Transportista : Variant;
begin
     Result := FEnvios_Transportista;
end;

function TCliente.GetEnvios_CodigoFormaEnvio : Variant;
begin
     Result := FEnvios_CodigoFormaEnvio;
end;

function TCliente.GetEnvios_Bloqueado : Variant;
begin
     Result := FEnvios_Bloqueado;
end;

function TCliente.GetEnvios_MotivoBloqueo : Variant;
begin
     Result := FEnvios_MotivoBloqueo;
end;

function TCliente.GetFactura_DtoPP : Variant;
begin
     Result := FFactura_DtoPP;
end;

function TCliente.GetFactura_DtoES : Variant;
begin
     Result := FFactura_DtoES;
end;

function TCliente.GetFactura_RecFinanc : Variant;
begin
     Result := FFactura_RecFinanc;
end;

function TCliente.GetFactura_ModeloIVA : Variant;
begin
     Result := FFactura_ModeloIVA;
end;

function TCliente.GetFactura_TipoFijoIVA : Variant;
begin
     Result := FFactura_TipoFijoIVA;
end;

function TCliente.GetFactura_TipoRet : Variant;
begin
     Result := FFactura_TipoRet;
end;

function TCliente.GetFactura_Credito : Variant;
begin
     Result := FFactura_Credito;
end;

function TCliente.GetFactura_Agrupacion : Variant;
begin
     Result := FFactura_Agrupacion;
end;

function TCliente.GetFactura_Reservado : Variant;
begin
     Result := FFactura_Reservado;
end;

function TCliente.GetFactura_Tarifa : Variant;
begin
     Result := FFactura_Tarifa;
end;

function TCliente.GetFactura_Comision : Variant;
begin
     Result := FFactura_Comision;
end;

function TCliente.GetFactura_NroCopias : Variant;
begin
     Result := FFactura_NroCopias;
end;

function TCliente.GetFactura_NroCopiasAlbaran : Variant;
begin
     Result := FFactura_NroCopiasAlbaran;
end;

function TCliente.GetFactura_Moneda : Variant;
begin
     Result := FFactura_Moneda;
end;

function TCliente.GetFactura_EnviarPorCorreo : Variant;
begin
     Result := FFactura_EnviarPorCorreo;
end;

function TCliente.GetFactura_SinDtosConsumo : Variant;
begin
     Result := FFactura_SinDtosConsumo;
end;

function TCliente.GetFactura_NoAplicarOfertas : Variant;
begin
     Result := FFactura_NoAplicarOfertas;
end;

function TCliente.GetFactura_CodigoEAN : Variant;
begin
     Result := FFactura_CodigoEAN;
end;

function TCliente.GetCobro_Nombre : Variant;
begin
     Result := FCobro_Nombre;
end;

function TCliente.GetCobro_Domicilio : Variant;
begin
     Result := FCobro_Domicilio;
end;

function TCliente.GetCobro_Localidad : Variant;
begin
     Result := FCobro_Localidad;
end;

function TCliente.GetCobro_CodigoProv : Variant;
begin
     Result := FCobro_CodigoProv;
end;

function TCliente.GetCobro_CodigoPostal : Variant;
begin
     Result := FCobro_CodigoPostal;
end;

function TCliente.GetCobro_FormaCobro : Variant;
begin
     Result := FCobro_FormaCobro;
end;

function TCliente.GetCobro_DiaCobro1 : Variant;
begin
     Result := FCobro_DiaCobro1;
end;

function TCliente.GetCobro_DiaCobro2 : Variant;
begin
     Result := FCobro_DiaCobro2;
end;

function TCliente.GetCobro_MesNoCobro : Variant;
begin
     Result := FCobro_MesNoCobro;
end;

function TCliente.GetCobro_CodigoEntidad : Variant;
begin
     Result := FCobro_CodigoEntidad;
end;

function TCliente.GetCobro_Entidad : Variant;
begin
     Result := FCobro_Entidad;
end;

function TCliente.GetCobro_CodigoSucursal : Variant;
begin
     Result := FCobro_CodigoSucursal;
end;

function TCliente.GetCobro_Sucursal : Variant;
begin
     Result := FCobro_Sucursal;
end;

function TCliente.GetCobro_DC : Variant;
begin
     Result := FCobro_DC;
end;

function TCliente.GetCobro_Cuenta : Variant;
begin
     Result := FCobro_Cuenta;
end;

function TCliente.GetCobro_CtaEntidad : Variant;
begin
     Result := FCobro_CtaEntidad;
end;

function TCliente.GetCobro_CodigoINEPlaza : Variant;
begin
     Result := FCobro_CodigoINEPlaza;
end;

function TCliente.GetCobro_RiesgoLimite : Variant;
begin
     Result := FCobro_RiesgoLimite;
end;

function TCliente.GetCobro_ReferenciaMandato : Variant;
begin
     Result := FCobro_ReferenciaMandato;
end;

function TCliente.GetCobro_FechaMandato : Variant;
begin
     Result := FCobro_FechaMandato;
end;

function TCliente.GetCobro_CicloMandato : Variant;
begin
     Result := FCobro_CicloMandato;
end;

function TCliente.GetCobro_BIC : Variant;
begin
     Result := FCobro_BIC;
end;

function TCliente.GetCobro_IBAN : Variant;
begin
     Result := FCobro_IBAN;
end;

function TCliente.GetAnotacion : Variant;
begin
     Result := FAnotacion;
end;

function TCliente.GetAviso : Variant;
begin
     Result := FAviso;
end;

function TCliente.GetMostrarAviso : Variant;
begin
     Result := FMostrarAviso;
end;

{ Setters}

procedure TCliente.SetRemoteCursorID( const Value : TnxCursorID );
begin
     FRemoteCursorID := Value;
end;

procedure TCliente.SetState( const Value : TDataSetState );
begin
     FState := Value;
end;


procedure TCliente.SetCodigo(  const Value : String );
begin
     FCodigo := Value;
end;

procedure TCliente.SetNombre(  const Value : Variant );
begin
     FNombre := Value;
end;

procedure TCliente.SetDomicilio(  const Value : Variant );
begin
     FDomicilio := Value;
end;

procedure TCliente.SetLocalidad(  const Value : Variant );
begin
     FLocalidad := Value;
end;

procedure TCliente.SetCodigoPais(  const Value : Variant );
begin
     FCodigoPais := Value;
end;

procedure TCliente.SetCodigoProvincia(  const Value : Variant );
begin
     FCodigoProvincia := Value;
end;

procedure TCliente.SetCodigoPostal(  const Value : Variant );
begin
     FCodigoPostal := Value;
end;

procedure TCliente.SetTelefono(  const Value : Variant );
begin
     FTelefono := Value;
end;

procedure TCliente.SetFax(  const Value : Variant );
begin
     FFax := Value;
end;

procedure TCliente.SetNIF(  const Value : Variant );
begin
     FNIF := Value;
end;

procedure TCliente.SetTipoIdentificacion(  const Value : Variant );
begin
     FTipoIdentificacion := Value;
end;

procedure TCliente.SetEMail(  const Value : Variant );
begin
     FEMail := Value;
end;

procedure TCliente.SetDocumentosExternos(  const Value : Variant );
begin
     FDocumentosExternos := Value;
end;

procedure TCliente.SetVendedor(  const Value : Variant );
begin
     FVendedor := Value;
end;

procedure TCliente.SetSubcuenta(  const Value : Variant );
begin
     FSubcuenta := Value;
end;

procedure TCliente.SetCodigoDivisa(  const Value : Variant );
begin
     FCodigoDivisa := Value;
end;

procedure TCliente.SetCampoLibre( Index : SmallInt; const Value : Variant );
begin
     FCampoLibre[ Index ] := Value;
end;

procedure TCliente.SetBloqueado(  const Value : Variant );
begin
     FBloqueado := Value;
end;

procedure TCliente.SetObsoleto(  const Value : Variant );
begin
     FObsoleto := Value;
end;

procedure TCliente.SetFechaAlta(  const Value : Variant );
begin
     FFechaAlta := Value;
end;

procedure TCliente.SetPalabraPaso(  const Value : Variant );
begin
     FPalabraPaso := Value;
end;

procedure TCliente.SetLatitud(  const Value : Variant );
begin
     FLatitud := Value;
end;

procedure TCliente.SetLongitud(  const Value : Variant );
begin
     FLongitud := Value;
end;

procedure TCliente.SetTiendaVirtual(  const Value : Variant );
begin
     FTiendaVirtual := Value;
end;

procedure TCliente.SetEnvios_Nombre(  const Value : Variant );
begin
     FEnvios_Nombre := Value;
end;

procedure TCliente.SetEnvios_Domicilio(  const Value : Variant );
begin
     FEnvios_Domicilio := Value;
end;

procedure TCliente.SetEnvios_Localidad(  const Value : Variant );
begin
     FEnvios_Localidad := Value;
end;

procedure TCliente.SetEnvios_CodigoProv(  const Value : Variant );
begin
     FEnvios_CodigoProv := Value;
end;

procedure TCliente.SetEnvios_CodigoPostal(  const Value : Variant );
begin
     FEnvios_CodigoPostal := Value;
end;

procedure TCliente.SetEnvios_FormaEnvio(  const Value : Variant );
begin
     FEnvios_FormaEnvio := Value;
end;

procedure TCliente.SetEnvios_Transportista(  const Value : Variant );
begin
     FEnvios_Transportista := Value;
end;

procedure TCliente.SetEnvios_CodigoFormaEnvio(  const Value : Variant );
begin
     FEnvios_CodigoFormaEnvio := Value;
end;

procedure TCliente.SetEnvios_Bloqueado(  const Value : Variant );
begin
     FEnvios_Bloqueado := Value;
end;

procedure TCliente.SetEnvios_MotivoBloqueo(  const Value : Variant );
begin
     FEnvios_MotivoBloqueo := Value;
end;

procedure TCliente.SetFactura_DtoPP(  const Value : Variant );
begin
     FFactura_DtoPP := Value;
end;

procedure TCliente.SetFactura_DtoES(  const Value : Variant );
begin
     FFactura_DtoES := Value;
end;

procedure TCliente.SetFactura_RecFinanc(  const Value : Variant );
begin
     FFactura_RecFinanc := Value;
end;

procedure TCliente.SetFactura_ModeloIVA(  const Value : Variant );
begin
     FFactura_ModeloIVA := Value;
end;

procedure TCliente.SetFactura_TipoFijoIVA(  const Value : Variant );
begin
     FFactura_TipoFijoIVA := Value;
end;

procedure TCliente.SetFactura_TipoRet(  const Value : Variant );
begin
     FFactura_TipoRet := Value;
end;

procedure TCliente.SetFactura_Credito(  const Value : Variant );
begin
     FFactura_Credito := Value;
end;

procedure TCliente.SetFactura_Agrupacion(  const Value : Variant );
begin
     FFactura_Agrupacion := Value;
end;

procedure TCliente.SetFactura_Reservado(  const Value : Variant );
begin
     FFactura_Reservado := Value;
end;

procedure TCliente.SetFactura_Tarifa(  const Value : Variant );
begin
     FFactura_Tarifa := Value;
end;

procedure TCliente.SetFactura_Comision(  const Value : Variant );
begin
     FFactura_Comision := Value;
end;

procedure TCliente.SetFactura_NroCopias(  const Value : Variant );
begin
     FFactura_NroCopias := Value;
end;

procedure TCliente.SetFactura_NroCopiasAlbaran(  const Value : Variant );
begin
     FFactura_NroCopiasAlbaran := Value;
end;

procedure TCliente.SetFactura_Moneda(  const Value : Variant );
begin
     FFactura_Moneda := Value;
end;

procedure TCliente.SetFactura_EnviarPorCorreo(  const Value : Variant );
begin
     FFactura_EnviarPorCorreo := Value;
end;

procedure TCliente.SetFactura_SinDtosConsumo(  const Value : Variant );
begin
     FFactura_SinDtosConsumo := Value;
end;

procedure TCliente.SetFactura_NoAplicarOfertas(  const Value : Variant );
begin
     FFactura_NoAplicarOfertas := Value;
end;

procedure TCliente.SetFactura_CodigoEAN(  const Value : Variant );
begin
     FFactura_CodigoEAN := Value;
end;

procedure TCliente.SetCobro_Nombre(  const Value : Variant );
begin
     FCobro_Nombre := Value;
end;

procedure TCliente.SetCobro_Domicilio(  const Value : Variant );
begin
     FCobro_Domicilio := Value;
end;

procedure TCliente.SetCobro_Localidad(  const Value : Variant );
begin
     FCobro_Localidad := Value;
end;

procedure TCliente.SetCobro_CodigoProv(  const Value : Variant );
begin
     FCobro_CodigoProv := Value;
end;

procedure TCliente.SetCobro_CodigoPostal(  const Value : Variant );
begin
     FCobro_CodigoPostal := Value;
end;

procedure TCliente.SetCobro_FormaCobro(  const Value : Variant );
begin
     FCobro_FormaCobro := Value;
end;

procedure TCliente.SetCobro_DiaCobro1(  const Value : Variant );
begin
     FCobro_DiaCobro1 := Value;
end;

procedure TCliente.SetCobro_DiaCobro2(  const Value : Variant );
begin
     FCobro_DiaCobro2 := Value;
end;

procedure TCliente.SetCobro_MesNoCobro(  const Value : Variant );
begin
     FCobro_MesNoCobro := Value;
end;

procedure TCliente.SetCobro_CodigoEntidad(  const Value : Variant );
begin
     FCobro_CodigoEntidad := Value;
end;

procedure TCliente.SetCobro_Entidad(  const Value : Variant );
begin
     FCobro_Entidad := Value;
end;

procedure TCliente.SetCobro_CodigoSucursal(  const Value : Variant );
begin
     FCobro_CodigoSucursal := Value;
end;

procedure TCliente.SetCobro_Sucursal(  const Value : Variant );
begin
     FCobro_Sucursal := Value;
end;

procedure TCliente.SetCobro_DC(  const Value : Variant );
begin
     FCobro_DC := Value;
end;

procedure TCliente.SetCobro_Cuenta(  const Value : Variant );
begin
     FCobro_Cuenta := Value;
end;

procedure TCliente.SetCobro_CtaEntidad(  const Value : Variant );
begin
     FCobro_CtaEntidad := Value;
end;

procedure TCliente.SetCobro_CodigoINEPlaza(  const Value : Variant );
begin
     FCobro_CodigoINEPlaza := Value;
end;

procedure TCliente.SetCobro_RiesgoLimite(  const Value : Variant );
begin
     FCobro_RiesgoLimite := Value;
end;

procedure TCliente.SetCobro_ReferenciaMandato(  const Value : Variant );
begin
     FCobro_ReferenciaMandato := Value;
end;

procedure TCliente.SetCobro_FechaMandato(  const Value : Variant );
begin
     FCobro_FechaMandato := Value;
end;

procedure TCliente.SetCobro_CicloMandato(  const Value : Variant );
begin
     FCobro_CicloMandato := Value;
end;

procedure TCliente.SetCobro_BIC(  const Value : Variant );
begin
     FCobro_BIC := Value;
end;

procedure TCliente.SetCobro_IBAN(  const Value : Variant );
begin
     FCobro_IBAN := Value;
end;

procedure TCliente.SetAnotacion(  const Value : Variant );
begin
     FAnotacion := Value;
end;

procedure TCliente.SetAviso(  const Value : Variant );
begin
     FAviso := Value;
end;

procedure TCliente.SetMostrarAviso(  const Value : Variant );
begin
     FMostrarAviso := Value;
end;

var ClienteControl : InxClassFactoryControl;

initialization
   nxInvokeRegistry.RegisterInterface( TypeInfo( ICliente ) );

   TnxClassFactory.RegisterClass( CLSID_Cliente, TCliente, ClienteControl );

end.
