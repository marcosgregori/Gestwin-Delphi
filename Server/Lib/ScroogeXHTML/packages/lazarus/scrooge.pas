{ Diese Datei wurde automatisch von Lazarus erzeugt. Sie darf nicht bearbeitet 
  werden!
  Dieser Quelltext dient nur dem Übersetzen und Installieren des Packages.
 }

unit scrooge; 

interface

uses
  ScroogeXHTML_reg, LazarusPackageIntf;

implementation

procedure Register; 
begin
  RegisterUnit('ScroogeXHTML_reg', @ScroogeXHTML_reg.Register); 
end; 

initialization
  RegisterPackage('scrooge', @Register); 
end.
