
unit gdm91Frm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls,

  dxSkinsCore, dxSkinsdxBarPainter, dxBar, cxClasses,
  dxSkinsDefaultPainters, dxBarExtItems, cxImage, cxBarEditItem,

  AppManager,
  AppContainer,
  AppForms;

type
  Tgds91Frm = class(TFrame)
    AppSection: TgAppSection;
    BarManager: TdxBarManager;
    BarManagerBar: TdxBar;
    ContactosWebItem: TdxBarButton;
    ListadoContactosWebItem: TdxBarButton;
    ContactosItem: TdxBarButton;
    ActividadesItem: TdxBarButton;
    ProveedoresExternosItem: TdxBarButton;
    TarjetasRegistroItem: TdxBarButton;
    Ficheros2: TdxBarSubItem;
    RelacionSuscripcionesItem: TdxBarButton;
    Suscripciones1: TdxBarSubItem;
    InformesItem: TdxBarSubItem;
    Infexternos1: TdxBarSubItem;
    ImportarContactosItem: TdxBarButton;
    Procesos1: TdxBarSubItem;
    dxBarButton1: TdxBarButton;
    procedure Contenido0ItemClick(Sender: TObject);
    procedure IndiceAlfabetico0ItemClick(Sender: TObject);
    function AppSectionSetAccess: Boolean;

    procedure ActividadesItemClick(Sender: TObject);
    procedure ContactosItemClick(Sender: TObject);
    procedure ProveedoresExternosItemClick(Sender: TObject);
    procedure TarjetasRegistroItemClick(Sender: TObject);
    procedure ImportarContactosItemClick(Sender: TObject);
    procedure RelacionSuscripcionesItemClick(Sender: TObject);
    procedure ContactosWebItemClick(Sender: TObject);
    procedure ListadoContactosWebItemClick(Sender: TObject);
    procedure AppSectionUpdateMainMenu;
    procedure dxBarButton1Click(Sender: TObject);
    
  private

  public

  end;

var  Gds91Frm : Tgds91Frm = nil;

implementation

{$R *.dfm}

uses   LibUtils,
       AppForm,

       dm_pga,

       a_cnw,
       l_cnw,
       a_cnt,
       a_act,

       a_pex,
       a_tdr,

       b_rsc,
       b_rai;

       // b_icc;   Archivado

procedure Tgds91Frm.Contenido0ItemClick(Sender: TObject);
begin
     ShowHelp;
end;

procedure Tgds91Frm.dxBarButton1Click(Sender: TObject);
begin
     RelacionActualizaciones( [] );
end;

procedure Tgds91Frm.IndiceAlfabetico0ItemClick(Sender: TObject);
begin
     ShowHelpForm( 'hs91', 'alfabetico' );
end;

procedure Tgds91Frm.ListadoContactosWebItemClick(Sender: TObject);
begin
     ListadoContactosWeb;
end;

function Tgds91Frm.AppSectionSetAccess: Boolean;
begin
     Result := true;
end;

procedure Tgds91Frm.AppSectionUpdateMainMenu;
begin
     BarManager.BeginUpdate;
     try

     finally
       BarManager.EndUpdate;
     end;
end;

// ....

procedure Tgds91Frm.ActividadesItemClick(Sender: TObject);
begin
     MntActividades( [] );
end;

procedure Tgds91Frm.ContactosItemClick(Sender: TObject);
begin
     mntContactos( [] );
end;

procedure Tgds91Frm.ContactosWebItemClick(Sender: TObject);
begin
     MntContactosWeb( [] );
end;

procedure Tgds91Frm.ProveedoresExternosItemClick(Sender: TObject);
begin
     MntProveedoresExternos( [] );
end;

procedure Tgds91Frm.RelacionSuscripcionesItemClick(Sender: TObject);
begin
     RelacionSuscripciones( [] );
end;

procedure Tgds91Frm.TarjetasRegistroItemClick(Sender: TObject);
begin
     MntTarjetasRegistro( [] );
end;

procedure Tgds91Frm.ImportarContactosItemClick(Sender: TObject);
begin
     // importacionClientes;
end;

procedure SectionSetup;
begin
     Gds91Frm := Tgds91Frm.Create( Application );
     If   Assigned( Gds91Frm )
     then begin
          ApplicationContainer.AddAppSection( Gds91Frm.AppSection );
          Gds91Frm.BarManager.ImageOptions.Images := ApplicationForms.ControlsImageList;
          end;
end;


initialization
     AddProcedure( imOptionalSectionModule, 91, SectionSetup );

end.

