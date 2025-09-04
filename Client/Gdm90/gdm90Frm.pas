
unit gdm90Frm;

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
  Tgds90Frm = class(TFrame)
    AppSection: TgAppSection;
    BarManager: TdxBarManager;
    BarManagerBar1: TdxBar;
    TiposTareaItem: TdxBarButton;
    TecnicosItem: TdxBarButton;
    FicherosItem: TdxBarSubItem;
    MantenimientoTareasItem: TdxBarButton;
    GestionItem: TdxBarSubItem;
    Infexternos1: TdxBarSubItem;
    ExportImportTareasItem: TdxBarButton;
    Procesos1: TdxBarSubItem;
    PersonasContactoItem: TdxBarButton;
    GestionTareasItem: TdxBarButton;
    ExportacionFicherosItem: TdxBarButton;
    PGCItem: TdxBarButton;
    procedure Contenido0ItemClick(Sender: TObject);
    procedure IndiceAlfabetico0ItemClick(Sender: TObject);
    procedure TiposTareaItemClick(Sender: TObject);
    procedure TecnicosItemClick(Sender: TObject);
    procedure MantenimientoTareasItemClick(Sender: TObject);
    function AppSectionSetAccess: Boolean;
    procedure ExportImportTareasItemClick(Sender: TObject);
    procedure AppSectionUpdateMainMenu;
    procedure OrdenarIconosItemClick(Sender: TObject);
    procedure PGCItemClick(Sender: TObject);
    procedure PersonasContactoItemClick(Sender: TObject);
    procedure GestionTareasItemClick(Sender: TObject);

  private

  public

  end;

var  Gds90Frm : Tgds90Frm = nil;

implementation

{$R *.dfm}

uses   LibUtils,
       AppForm,

       Gdm00Dm,

       dm_pga,

       a_pdc,
       a_tdt,
       a_tec,

       a_tar,
       b_gdt,

       a_pgc,
       // b_etr

       b_export,   // Incluido a petición del público
       b_import;

procedure Tgds90Frm.AppSectionUpdateMainMenu;
begin
     BarManager.BeginUpdate;
     try

     finally
       BarManager.EndUpdate;
     end;
end;

procedure Tgds90Frm.OrdenarIconosItemClick(Sender: TObject);
begin
     ApplicationForm.ArrangeIcons;
end;

procedure Tgds90Frm.PersonasContactoItemClick(Sender: TObject);
begin
     MntPersonasContacto( [] );
end;

procedure Tgds90Frm.PGCItemClick(Sender: TObject);
begin
     MntPGC( [] );
end;

procedure Tgds90Frm.Contenido0ItemClick(Sender: TObject);
begin
     ShowHelp;
end;

procedure Tgds90Frm.GestionTareasItemClick(Sender: TObject);
begin
     GestionTareas;
end;

procedure Tgds90Frm.IndiceAlfabetico0ItemClick(Sender: TObject);
begin
     ShowHelpForm( 'hs90', 'alfabetico' );
end;

function Tgds90Frm.AppSectionSetAccess: Boolean;
begin
     Result := True;
end;

// ....

procedure Tgds90Frm.TiposTareaItemClick(Sender: TObject);
begin
     MntTiposTarea( [] );
end;

procedure Tgds90Frm.TecnicosItemClick(Sender: TObject);
begin
     MntTecnicos( [] );
end;

procedure Tgds90Frm.MantenimientoTareasItemClick(Sender: TObject);
begin
     MntTareas( [] );
end;

procedure SectionSetup;
begin
     Gds90Frm := Tgds90Frm.create( Application );
     If   Assigned( Gds90Frm )
     then begin
          ApplicationContainer.AddAppSection( Gds90Frm.AppSection );
          Gds90Frm.BarManager.ImageOptions.Images := ApplicationForms.ControlsImageList;
          end;
end;

procedure Tgds90Frm.ExportImportTareasItemClick(Sender: TObject);
begin
     // ExportacionImportacionTareas;
end;


initialization
     AddProcedure( imOptionalSectionModule, 90, SectionSetup );
end.

