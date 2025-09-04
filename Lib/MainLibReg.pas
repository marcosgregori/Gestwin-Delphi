
unit MainLibReg;

interface

{$R *.dcr}

procedure Register;

implementation


uses    Windows,
        Classes,

        AppContainer,

        DesignIntf,
        DesignEditors,

        AppForms,
        QueryForm,
        AppManager,
        DataManager,
        DataAccess,

        cxLibraryReg,
        cxContainer,
        cxScrollBar,

        XMLDoc,
        SHDocVw,

        Forms,

        nxsdTypes,
        nxDB,
        DB,

        GridTableViewController,
        QueryGrid,
        WorkCalendar,
        EditSelector,
        DashboardSection,

        b_msg,

        f_prg,
        f_grd;


const   GestwinTab = 'Gestwin';
        InternetPage = 'Internet';

{ DataManager --------------------------------------------------------- }

Type   TgStringProperty = class( TStringProperty )
       public
         function GetAttributes : TPropertyAttributes; override;
         procedure GetValueList( AList : TStrings ); virtual;
         procedure GetValues( proc : TGetStrProc ); override;
         end;

{ TgStringProperty }

function TgStringProperty.GetAttributes : TPropertyAttributes;
begin
     Result := [ paValueList, paSortList, paMultiSelect ];
end;

procedure TgStringProperty.GetValues(Proc: TGetStrProc);

var   I : SmallInt;
      Values : TStringList;

begin
     Values := TStringList.create;
     try
       GetValueList( Values );
       for I := 0 to Values.count - 1 do
         Proc( Values[ I ] );
     finally
       Values.free;
       end;
end;

procedure TgStringProperty.GetValueList( AList : TStrings );
begin
end;

// TAutoIncFieldProperty

Type  TAutoIncFieldProperty = class( TgStringProperty )
      public
        procedure GetValueList( AList : TStrings ); override;
        end;

procedure TAutoIncFieldProperty.GetValueList( AList : TStrings );

var   AComponent : TPersistent;

begin
     AComponent := GetComponent( 0 );
     If   Assigned( AComponent ) and ( AComponent is TDataset )
     then TDataset( AComponent ).GetFieldNames( AList );
end;

{AppForms ------------------------------------------------------------------ }

procedure Register;
begin

     { AppForms }

     RegisterComponents( GestwinTab, [ TgAppSection,
                                       TgxFormManager,
                                       TgxEditPanel,
                                       TgxScrollBoxPanel,
                                       TgQueryPanel,
                                       TgxRangeBox,
                                       TgxLockRangeButton,
                                       TgxPageControlNavigator,
                                       TgxFilterPageControl,
                                       TgxEditSelector,
                                       TgxPasswordEdit,
                                       TgxDBPasswordEdit ] );

     RegisterCustomModule( TgxForm, TCustomModule );

     RegisterCustomModule( TApplicationForms, TCustomModule );

     { AppContainer }

     RegisterComponents( GestwinTab, [ TgBitBtn ] );

     RegisterCustomModule( TApplicationContainer, TCustomModule );

     { TGridTableViewController }

     RegisterComponents( GestwinTab, [ TGridTableViewController,
                                       TGridTableViewPanel,
                                       TGridTableViewPanelGroupBox,
                                       TGridTableViewPanelLabel ] );

     {QueryGrid}

     RegisterCustomModule( TPersistentQueryModule, TCustomModule );

     { WorkCalendar }

     RegisterComponents( GestwinTab, [ TWorkCalendar] );

     { DataManager }

     RegisterComponents( GestwinTab, [ TnxeDatabase,
                                       TnxeDatabaseDictionary,
                                       TnxeCachedDataset,
                                       TnxeTable,
                                       TnxeQuery,
                                       TgxMemData,
                                       TnxeStoredProc ] );

     RegisterPropertyEditor( TypeInfo( String ), TnxeTable, 'AutoIncFieldName', TAutoIncFieldProperty );
     RegisterPropertyEditor( TypeInfo( String ), TnxeQuery, 'AutoIncFieldName', TAutoIncFieldProperty );
     RegisterPropertyEditor( TypeInfo( String ), TnxeCachedDataset, 'AutoIncFieldName', TAutoIncFieldProperty );
     RegisterPropertyEditor( TypeInfo( String ), TgxMemData, 'AutoIncFieldName', TAutoIncFieldProperty );

     // Web

     RegisterComponents( InternetPage, [ TWebBrowser,
                                         TInternetExplorer,
                                         TInternetExplorerMedium,
                                         TShellWindows,
                                         TShellUIHelper,
                                         TShellNameSpace ] );


     RegisterNoIcon( [ TProcessFrame,
                       TGridOutputFrame {,
                       TDashboardSectionFrame } ] );

     {
     RegisterCustomModule( TProcessFrame, TCustomModule );
     RegisterCustomModule( TGridOutputFrame, TCustomModule );
     }

     RegisterCustomModule( TDashboardSectionFrame, TCustomModule );

end;

initialization
    IsDesignTime := True;

end.


