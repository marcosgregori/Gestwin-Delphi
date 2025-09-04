{##############################################################################}
{# NexusDB EnterpriseManager: nxEnterpriseManager.dpr 4.50                    #}
{# Copyright (c) Nexus Database 2003-2021                                     #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB EnterpriseManager: Project File                                    #}
{##############################################################################}

{$I nxemDefine.inc}

// JCL_DEBUG_EXPERT_INSERTJDBG ON
// JCL_DEBUG_EXPERT_DELETEMAPFILE ON
// JCL_DEBUG_EXPERT_GENERATEJDBG ON
program GDBEnterpriseManager;

{$IFDEF DCC14OrLater}
//keep exe size down
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$ELSE}
  EM must be compiled with Delphi 2010+! The EM is always maintained in the latest Delphi version.
{$ENDIF}

uses
  nxReplacementMemoryManager,
  nxReplacementMove,
  nxPatchPPL,
  Windows,
  Forms,
  nxpvPlatformImplementation,
  dgAddDatabase,
  dgChangeAllTables,
  dgCopyToTable,
  dgCSVImport,
  dgCSVImportAdvancedSettings,
  dgCSVImportNexus,
  dgCSVImportProgress,
  dgImportTableDefinition,
  dgInputQueryInteger,
  dgInputQueryString,
  dgLoginDialog,
  dgRebuildProgress,
  dgRegisteredServers,
  dgSelectIndex,
  dgSelectRuntimePackages,
  dgSetAutoinc,
  dgSetRange,
  dgSQLBrowserSqlHistory,
  dgSQLError,
  dgSQLOptions,
  dgSQLParameters,
  dmMain,
  fmBaseBrowser,
  fmDictionaryBrowser2,
  fmDictionaryBrowserSimple,
  {$IFDEF EMIncludeReportEngine}
  nxemReportEngineFastReport,
  {$ENDIF }
  fmMainForm,
  fmQueryBrowser,
  fmTableBrowser,
  fmTableStreams,
  fmTreeBrowser,
  frmLiveBackup,
  nxcgCodeGen,
  nxcgCodeGenCommon,
  nxcgCodeGenSQL,
  nxcgMain,
  nxcgTablePassword,
  nxcgUtils,
  nxcgWizard,
  nxemBaseDictionaryEditors,
  nxemDictionaryEditorsStrings,
  nxemFieldDescDictionaryEditor,
  nxemFulltextDictionaryEditor,
  nxemFulltextIndexDictionaryEditor,
  //.. nxemGlyphs,
  nxemIndexDescDictionaryEditor,
  nxemRefIntDictionaryEditor,
  nxExeConst,
  nxpvImportConst,
  nxpvImportPreview,
  unConfigInfo,
  unDictionaryBrowserHelper,
  unFormList,
  unGuiUtils,
  unSqlWindowConfig,
  unTreeNodeObject,
  dgVerifyTables,
  unCsvExport,
  dgNewTableDefaults,
  nxsdDataDictionaryAudit,
  nxemAuditDictionaryEditor,
  nxsrAuditMonitor,
  {$IFDEF EMIncludeActiveQueryBuilder}
  dgQueryBuilder,
  {$ENDIF }
  dgClientMessaging,
  CustomAccessValidation,
  dmUpdateCheck,
  unUpdateCheck,
  unUpdateJsonObject,
  fraGenericBlobTemplate,
  fraByteArrayTemplate,
  fraGraphicBlobTemplate,
  fraMemoBlobTemplate,
  dgConnectionProperties,
  unScaledForm in 'unScaledForm.pas';

{$R *.RES}
{$R dxDPIAwareManifest.res}

{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

const
  IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE = $0040;
  IMAGE_DLLCHARACTERISTICS_NX_COMPAT = $0100;

{$SETPEOPTFLAGS IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE or
                IMAGE_DLLCHARACTERISTICS_NX_COMPAT}


begin
  Application.DefaultFont.Name := Config.FontName;
  Application.DefaultFont.Size := Config.FontSize;
  Screen.MessageFont.Name := Config.FontName;
  Screen.MessageFont.Size := Config.FontSize;
  Screen.MenuFont.Name := Config.FontName;
  Screen.MenuFont.Size := Config.FontSize;
  Application.MainFormOnTaskBar := True;
  Application.Title := 'NexusDB Enterprise Manager';
  Application.CreateForm(TdmEM, dmEM);
  //.. Application.CreateForm(TfrmEMGlyps, frmEMGlyps);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
