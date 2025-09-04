
unit TouchMainLibReg;

interface

{$R *.dcr}

procedure Register;

implementation


uses    Windows,
        Classes,

        AppManager,

        DesignIntf,
        DesignEditors,

        cxLibraryReg,

        TouchQueryForm,
        TouchTableViewController;


const   GestwinTab = 'Gestwin';

procedure Register;
begin

     RegisterComponents( GestwinTab, [ TTouchQueryPanel,
                                       TTouchGridTableViewController ] );


end;

initialization
    IsDesignTime := True;

end.


