{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit in0k_lazExt_CopyRAST;

interface

uses
  REG, in0k_lazIdeSRC_ExpertCORE, lazExt_CopyRAST_wndCORE, lazExt_CopyRAST, 
  lazExt_CopyRAST_StrConsts, lazExt_CopyRAST_wndPackage, 
  lazExt_CopyRAST_wndProject, lazExt_CopyRAST_node, lazExt_CopyRAST_node_File, 
  lazExt_CopyRAST_node_Folder, lazExt_CopyRAST_node_ROOT, 
  in0k_lazIdeSRC_srcTree_CORE_fromIDEProcs_FNK, 
  lazExt_CopyRAST_node_ROOT_package, in0k_lazIdeSRC_FuckUpForm_01, 
  lazExt_CopyRAST_node_ROOT_project, lazExt_CopyRAST_FuckUpForm, 
  Processing_CORE, lazExt_CopyRAST_operation_clearTargetDir, 
  lazExt_CopyRAST_operation_createTargetDirs, 
  lazExt_CopyRAST_operation_copyFiles, 
  lazExt_CopyRAST_operation_PSF_updateUnit, 
  lazExt_CopyRAST_operation_PSF_updateUsesMain, 
  lazExt_CopyRAST_operation_PSF_TEST, lazExt_CopyRAST_TEXTs, 
  lazExt_CopyRAST_Node2TEXTs, lazExt_CopyRAST_operationNode_EXECUTOR_Package, 
  lazExt_CopyRAST_processingNODE, lazExt_CopyRAST_processingMCHN, 
  prcNode_clearTargetDir, prcNode_createTargetDir, prcNode_copyFile, 
  prcNode_PSF_updateUnit, prcNode_PSF_updateUses, prcNode_XML_updateLPK, 
  prcNode_core_srcEdit, prcNode_core_xmlEdit, prcNode_XML_updateLPK_v4, 
  prcNode_XML_CompilerOptions_SearchPaths, prcNode_XML_Files, 
  prcNode_PSF_updateInclude, in0k_lazIdeSRC_srcTree_CORE_itemFileSystem, 
  in0k_lazExt_CopyRAST_cmpTree, srcTree_builder_CORE, 
  in0k_lazIdeSRC_srcTree_4Package, in0k_lazIdeSRC_srcTree_CORE_item, 
  in0k_lazIdeSRC_srcTree_item_fsFolder, in0k_lazIdeSRC_srcTree_item_fsFile, 
  srcTree_FNC, in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND, 
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_GET, 
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET, 
  in0k_lazIdeSRC_srcTree_FNK_mainFILE_GET, 
  in0k_lazIdeSRC_srcTree_FNK_mainFILE_FND, 
  in0k_lazIdeSRC_srcTree_FNK_mainFILE_SET, 
  in0k_lazIdeSRC_srcTree_FNK_srchPATH_ADD, 
  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK, 
  in0k_lazIdeSRC_srcTree_item_Globals, srcTree_handler_CORE, 
  srcTree_handler_CORE_makeLIST, 
  in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_usesFile, 
  srcTree_handler_CORE_makeListFsFILE, in0k_lazIdeSRC_srcTree_CORE_Processing, 
  srcTree_handler_CORE_fsFILE2CodeBUF, 
  in0k_lazIdeSRC_srcTree_FNK_rootFILE_FND, 
  in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_files4INC, 
  in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_ITEM_4INCs, 
  in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_ITEM_4USEs, 
  in0k_lazIdeSRC_srcTree_FNK_FsFILE_FND, 
  in0k_lazIdeSRC_srcTree_CORE_filePkgType_FNK, 
  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_add, 
  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_FND, 
  in0k_lazIdeSRC_srcTree_FNK_fsFLDR_GET, 
  in0k_lazIdeSRC_srcTree_FNK_fsFILE_ADD, 
  in0k_lazIdeSRC_srcTree_FNK_fsFILE_GET, cmpCopyRAST_srcTree_approvedFiles, 
  cmpCopyRAST_srcTree_approvedNAMEs, srcTree_handler4build_CORE, 
  cmpCopyRAST_srcTree, lazExt_CopyRAST__xmlConfig, 
  lazExt_CopyRAST__xmlConfig_approvedFILEs2NAMEs, 
  in0k_lazIdeSRC_srcTree_itemsList, in0k_ext4ColorTheme, 
  in0k_CopyRAST_stage__ChangePaths, in0k_CopyRAST_stage__ChangePaths_CNFGs, 
  CopyRAST_srcTree_4Handler_CNFGs, frmCopyRAST_EDIT, 
  in0k_CopyRAST__frmSTAGE_CORE, frmCopyRAST_srcTree_approvedFILEs2NAMEs, 
  in0k_CopyRAST__frmSTAGE_02_Revision, in0k_CopyRAST__frmSTAGE_twoTree_CORE, 
  in0k_CopyRAST__stage_01_Handling, in0k_CopyRAST_STAGEs_CORE, 
  in0k_CopyRAST_STAGEs, in0k_CopyRAST__wndCORE, in0k_CopyRAST__wndProject, 
  in0k_CopyRAST__wndPackage, in0k_CopyRAST__wnd_SHOW, 
  in0k_CopyRAST_Stage_CORE, in0k_CopyRAST__frmSTAGE_00_CreateTree, 
  in0k_CopyRAST__frmSTAGE_01_Handling, in0k_CopyRAST__frmSTAGE_03_Rename, 
  in0k_CopyRAST__frmSTAGE_04_Copying, 
  in0k_CopyRAST__frmSTAGE_05_PostProcessing, in0k_CopyRAST__frmSTAGE_LMR_CORE, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('REG', @REG.Register);
end;

initialization
  RegisterPackage('in0k_lazExt_CopyRAST', @Register);
end.
