
unit MainServerLibReg;

interface

procedure Register;

implementation


uses    Windows,
        Classes,
        Vcl.ExtCtrls,
        DesignIntf,
        DesignEditors,

        AppManager,
        DataManager,
        XMLDoc,
        Forms,

        nxsdTypes,
        nxDB,
        DB,

        EnterpriseData,
        ServerDataModule,
        BaseSessionData,
        SectionData,
        BaseServerContainer,

        ScroogeXHTML;

const   GestwinTab = 'Gestwin';

procedure Register;
begin

     { DataModules }

     RegisterCustomModule( TServerDataModule, TCustomModule );
     RegisterCustomModule( TEnterpriseDataModule, TCustomModule );
     RegisterCustomModule( TBaseSessionDataModule, TCustomModule );
     RegisterCustomModule( TSectionDataModule, TCustomModule );
     RegisterCustomModule( TBaseServerContainerModule, TCustomModule );

     // Otros

     RegisterComponents( GestwinTab, [ TXMLDocument, TBTScroogeXHTML ] );


end;

initialization

   IsDesignTime := True;

end.


