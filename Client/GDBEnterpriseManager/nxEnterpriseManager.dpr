{##############################################################################}
{# NexusDB EnterpriseManager: nxEnterpriseManager.dpr 4.70                    #}
{# Copyright (c) Nexus Database 2003-2023                                     #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB EnterpriseManager: Project File                                    #}
{##############################################################################}

{$I nxemDefine.inc}

// JCL_DEBUG_EXPERT_INSERTJDBG ON
// JCL_DEBUG_EXPERT_DELETEMAPFILE ON
// JCL_DEBUG_EXPERT_GENERATEJDBG ON
program nxEnterpriseManager;

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
  dgAddDatabase in 'dgAddDatabase.pas' {dlgAddDatabase},
  dgChangeAllTables in 'dgChangeAllTables.pas' {dlgChangeAllTables},
  dgCopyToTable in 'dgCopyToTable.pas' {dlgCopyToTable},
  dgCSVImport in 'dgCSVImport.pas' {frmTextFileImport},
  dgCSVImportAdvancedSettings in 'dgCSVImportAdvancedSettings.pas' {dlgTextImportAdvancedOptions},
  dgCSVImportNexus in 'dgCSVImportNexus.pas' {frmTextFileImportNexus},
  dgCSVImportProgress in 'dgCSVImportProgress.pas' {dlgTextFileImportProgress},
  dgImportTableDefinition in 'dgImportTableDefinition.pas' {dlgImportTableDef},
  dgInputQueryInteger in 'dgInputQueryInteger.pas' {dlgInputQueryInteger},
  dgInputQueryString in 'dgInputQueryString.pas' {dlgInputQueryString},
  dgLoginDialog in 'dgLoginDialog.pas' {dlgLoginDialog},
  dgRebuildProgress in 'dgRebuildProgress.pas' {frmRebuildProgress},
  dgRegisteredServers in 'dgRegisteredServers.pas' {dlgRegisterServers},
  dgSelectIndex in 'dgSelectIndex.pas' {dlgSelectIndex},
  dgSelectRuntimePackages in 'dgSelectRuntimePackages.pas' {dlgSelectRuntimePackages},
  dgSetAutoinc in 'dgSetAutoinc.pas' {dlgSetAutoInc},
  dgSetRange in 'dgSetRange.pas' {dlgSetRange},
  dgSQLBrowserSqlHistory in 'dgSQLBrowserSqlHistory.pas' {dlgSQLBrowserSqlHistory},
  dgSQLError in 'dgSQLError.pas' {dlgSQLError},
  dgSQLOptions in 'dgSQLOptions.pas' {dlgSQLOptions},
  dgSQLParameters in 'dgSQLParameters.pas' {dlgParams},
  dmMain in 'dmMain.pas' {dmEM: TDataModule},
  fmBaseBrowser in 'fmBaseBrowser.pas' {frmBaseBrowser},
  fmDictionaryBrowser2 in 'fmDictionaryBrowser2.pas' {frmDictionaryBrowser2},
  fmDictionaryBrowserSimple in 'fmDictionaryBrowserSimple.pas' {frmDictionaryBrowserSimple},
  {$IFDEF EMIncludeReportEngine}
  nxemReportEngineFastReport in 'nxemReportEngineFastReport.pas',
  {$ENDIF }
  fmMainForm in 'fmMainForm.pas' {frmMain},
  fmQueryBrowser in 'fmQueryBrowser.pas' {frmQueryBrowser},
  fmTableBrowser in 'fmTableBrowser.pas' {frmTableBrowser},
  fmTableStreams in 'fmTableStreams.pas' {frmTableStreams},
  fmTreeBrowser in 'fmTreeBrowser.pas' {frmTreeBrowser},
  frmLiveBackup in 'frmLiveBackup.pas' {fmLiveBackup},
  nxcgCodeGen in 'nxcgCodeGen.pas',
  nxcgCodeGenCommon in 'nxcgCodeGenCommon.pas',
  nxcgCodeGenSQL in 'nxcgCodeGenSQL.pas',
  nxcgMain in 'nxcgMain.pas' {ddcgMainForm},
  nxcgTablePassword in 'nxcgTablePassword.pas' {TablePasswordForm},
  nxcgUtils in 'nxcgUtils.pas',
  nxcgWizard in 'nxcgWizard.pas' {WizardForm},
  nxemBaseDictionaryEditors in 'nxemBaseDictionaryEditors.pas',
  nxemDictionaryEditorsStrings in 'nxemDictionaryEditorsStrings.pas',
  nxemFieldDescDictionaryEditor in 'nxemFieldDescDictionaryEditor.pas' {nxFieldDescriptorFrame: TFrame},
  nxemFulltextDictionaryEditor in 'nxemFulltextDictionaryEditor.pas' {nxFulltextDescriptorFrame: TFrame},
  nxemFulltextIndexDictionaryEditor in 'nxemFulltextIndexDictionaryEditor.pas' {nxFulltextIndexDescriptorFrame: TFrame},
  //.. nxemGlyphs in 'nxemGlyphs.pas' {frmEMGlyps: TDataModule},
  nxemIndexDescDictionaryEditor in 'nxemIndexDescDictionaryEditor.pas' {nxIndexDescriptorFrame: TFrame},
  nxemRefIntDictionaryEditor in 'nxemRefIntDictionaryEditor.pas' {nxRefIntDescriptorFrame: TFrame},
  nxExeConst in 'nxExeConst.pas',
  nxpvImportConst in 'nxpvImportConst.pas',
  nxpvImportPreview in 'nxpvImportPreview.pas',
  unConfigInfo in 'unConfigInfo.pas',
  unDictionaryBrowserHelper in 'unDictionaryBrowserHelper.pas',
  unFormList in 'unFormList.pas',
  unGuiUtils in 'unGuiUtils.pas',
  unSqlWindowConfig in 'unSqlWindowConfig.pas',
  unTreeNodeObject in 'unTreeNodeObject.pas',
  dgVerifyTables in 'dgVerifyTables.pas' {dlgVerifyTables},
  unCsvExport in 'unCsvExport.pas',
  dgNewTableDefaults in 'dgNewTableDefaults.pas' {dlgNewTableDefaults},
  nxsdDataDictionaryAudit in '..\nxsdDataDictionaryAudit.pas',
  nxemAuditDictionaryEditor in 'nxemAuditDictionaryEditor.pas' {nxAuditDescriptorFrame: TFrame},
  nxsrAuditMonitor in '..\nxsrAuditMonitor.pas',
  {$IFDEF EMIncludeActiveQueryBuilder}
  dgQueryBuilder in 'dgQueryBuilder.pas' {dlgQueryBuilder},
  {$ENDIF }
  dgClientMessaging in 'dgClientMessaging.pas',
  CustomAccessValidation in 'CustomAccessValidation.pas',
  dmUpdateCheck in '..\Server\dmUpdateCheck.pas' {dmUpdateREST: TDataModule},
  unUpdateCheck in '..\Server\unUpdateCheck.pas',
  unUpdateJsonObject in '..\Server\unUpdateJsonObject.pas',
  fraGenericBlobTemplate in 'fraGenericBlobTemplate.pas' {frGenericBlobTemplate: TFrame},
  fraByteArrayTemplate in 'fraByteArrayTemplate.pas' {frByteArrayTemplate: TFrame},
  fraGraphicBlobTemplate in 'fraGraphicBlobTemplate.pas' {frGraphicBlobTemplate: TFrame},
  fraMemoBlobTemplate in 'fraMemoBlobTemplate.pas' {frMemoBlobTemplate: TFrame},
  dgConnectionProperties in 'dgConnectionProperties.pas' {dlgConnectionProperties},
  unScaledForm in 'unScaledForm.pas',
  dgUsersAndPrivileges in 'dgUsersAndPrivileges.pas' {dlgUsersAndPrivileges};

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
