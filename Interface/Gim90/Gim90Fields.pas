unit Gim90Fields;

interface

uses   DB,
       DataManager;

{$TYPEINFO ON}   // Rtti

type

  TTipoTareaFields = class( TnxeDatasetFields)
  public
    Codigo : TWideStringField;
    Descripcion : TWideStringField;
    Urgente : TBooleanField;
  end;

  TTecnicoFields = class( TnxeDatasetFields)
  public
    Codigo : TWideStringField;
    Nombre : TWideStringField;
    TelefonoMovil : TWideStringField;
  end;

  TTareaFields = class( TnxeDatasetFields )
  public
    Ejercicio : TSmallIntField;
    NroTarea : TIntegerField;
    Estado : TSmallIntField;
    Fecha : TDateField;
    NroAplicacion : TSmallIntField;
    Modulo : TSmallIntField;
    CodigoCliente : TWideStringField;
    CodigoTecnico : TWideStringField;
    Urgente : TBooleanField;
    Prioridad : TSmallIntField;
    CodigoTipoTarea : TWideStringField;
    Asunto : TWideStringField;
    FechaResolucion : TDateField;
    Tiempo : TLongWordField;
    Duracion : TTimeField;
    Resolucion : TWideStringField;
  end;

  TPersonaContactoFields = class( TnxeDatasetFields )
   public
    Tipo : TSmallIntField;
    Propietario : TWideStringField;
    NroRegistro : TSmallIntField;
    Nombre : TWideStringField;
    TelefonoOficina : TWideStringField;
    Movil : TWideStringField;
    TelefonoParticular  : TWideStringField;
    Fax : TWideStringField;
    NoLlamar : TBooleanField;
    EMail : TWideStringField;
    FechaNacimiento : TDateField;
    AsignadoA : TWideStringField;
    Observaciones : TWideMemoField;
end;

TTarjetaRegistroFields = class( TnxeDatasetFields)
  public
    NroRegistro : TIntegerField;
    NroSerie : TLargeIntField;
    CodigoGestion : TWideStringField;
    Nombre : TWideStringField;
    Domicilio : TWideStringField;
    Localidad : TWideStringField;
    CodigoPais : TWideStringField;
    CodigoProvincia : TWideStringField;
    CodigoPostal : TWideStringField;
    Telefono : TWideStringField;
    Fax : TWideStringField;
    FechaInstalacion : TDateField;
    FechaCaducidad : TDateField;
    CodigoProveedor : TWideStringField;
    Aplicacion : TSmallIntField;
    Version : TSmallIntField;
    Release : TSmallIntField;
    NroUsuarios : TSmallIntField;
    TipoContrato : TSmallIntField;
    ModulosOpcionales : TSmallIntField;
    NroFichaVentaPeriodica : TIntegerField;
  end;

  TLineaTarjetaRegistroFields = class( TnxeDatasetFields)
  public
    NroRegistro : TIntegerField;
    NroLinea : TSmallIntField;
    Fecha : TDateField;
    NroSerie : TLargeIntField;
    Version : TSmallIntField;
    Release : TSmallIntField;
    NroUsuarios : TSmallIntField;
    FechaCaducidad : TDateField;
    Observaciones : TWideStringField;
  end;

  TActividadFields = class( TnxeDatasetFields)
  public
    Codigo : TWideStringField;
    Descripcion : TWideStringField;
  end;

  TProveedorExternoFields = class( TnxeDatasetFields)
  public
    Codigo : TWideStringField;
    Nombre : TWideStringField;
    Domicilio : TWideStringField;
    Localidad : TWideStringField;
    CodigoPais : TWideStringField;
    CodigoProvincia : TWideStringField;
    CodigoPostal : TWideStringField;
  end;

  TContactoWebFields = class( TnxeDatasetFields)
  public
    Codigo : TWideStringField;
    Nombre : TWideStringField;
    Domicilio : TWideStringField;
    Localidad : TWideStringField;
    CodigoProvincia : TWideStringField;
    CodigoPostal : TWideStringField;
    Empresa : TWideStringField;
    PrimerContacto : TDateField;
    Telefono : TWideStringField;
    EMail : TWideStringField;
    Distribuidor : TBooleanField;
    PersonaContacto : TWideStringField;
    Cargo : TWideStringField;
    CopiaEvaluacion : TBooleanField;
    AplicacionEvaluacion : TSmallIntField;
    InteresadoContable : TBooleanField;
    InteresadoComercial : TBooleanField;
    InteresadoContableComercial : TBooleanField;
    InteresadoTPV : TBooleanField;
    InteresadoPreventa : TBooleanField;
    Comentarios : TWideMemoField;
    Notas : TWideMemoField;
    FechaEnvioDemoVirtualUI: TDateField;
    FechaEnvioEvaluacion : TDateField;
    FechaEnvioRecordatorio : TDateField;
    FechaEnvioOferta : TDateField;
    FechaCompra : TDateField;
    CodigoGestion : TWideStringField;
  end;

  TContactoFields = class( TnxeDatasetFields)
  public
    Codigo : TWideStringField;
    Nombre : TWideStringField;
    Domicilio : TWideStringField;
    Localidad : TWideStringField;
    CodigoPais : TWideStringField;
    CodigoProvincia : TWideStringField;
    CodigoPostal : TWideStringField;
    CodigoActividad : TWideStringField;
    PersonaContacto1 : TWideStringField;
    Cargo1 : TWideStringField;
    Movil1 : TWideStringField;
    EMail1 : TWideStringField;
    PersonaContacto2 : TWideStringField;
    Cargo2 : TWideStringField;
    Movil2 : TWideStringField;
    EMail2 : TWideStringField;
    PaginaWeb : TWideStringField;
    PrimerContacto : TDateField;
    UltimoContacto : TDateField;
    Telefono : TWideStringField;
    Fax : TWideStringField;
    Informatizado : TBooleanField;
    ProveedorExterno : TWideStringField;
    Interesado : TBooleanField;
    ProximoContacto : TDateField;
    Notas : TWideMemoField;
  end;

  // De momento es un registro simple de instalaciones, pero ha sido diseñado como un sistema
  // de control de suscripciones

  TRegistroAplicacionFields = class( TnxeDatasetFields )
    NroRegistro : TUnsignedAutoIncField;
    Fecha : TDateTimeField;
    Tipo : TSmallIntField;
    CodigoUsuario : TWideStringField;
    Nombre : TWideStringField;
    NroRegistroAplicacion : TIntegerField;
    NroPrograma : TSmallIntField;
    Version : TSmallIntField;
    Release : TSmallIntField;
    NroSerie : TLargeIntField;
    ClaveActivacion : TLargeIntField;
    NroUsuarios : TSmallIntField;
    Localizacion : TWideStringField;
    CodigoResultado : TSmallIntField;
  end;

  TRegistroActualizacionesFields = class( TnxeDatasetFields )
    NroRegistro : TUnsignedAutoIncField;
    Fecha : TDateTimeField;
    NroSerie : TLargeIntField;
    ClaveActivacion : TLargeIntField;
    NroRegistroAplicacion : TIntegerField;
    NroPrograma : TSmallIntField;
    Version : TSmallIntField;
    Release : TSmallIntField;
    NroUsuarios : TSmallIntField;
    Localizacion : TWideStringField;
    CodigoResultado : TSmallIntField;
  end;

  implementation

end.
