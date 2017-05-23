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
  in0k_lazIdeSRC_srcTree_coreFromIDEProcs, in0k_lazIdeSRC_DEBUG, 
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
  prcNode_PSF_updateInclude, in0k_lazIdeSRC_srcTree_item_coreFileSystem, 
  in0k_lazExt_CopyRAST_cmpTree, srcTree_builder_CORE, 
  srcTree_builder_4Package, in0k_lazIdeSRC_srcTree_item_CORE, 
  in0k_lazIdeSRC_srcTree_item_fsFolder, in0k_lazIdeSRC_srcTree_item_fsFile, 
  in0k_lazIdeSRC_srcTree_FNK_relPATH_FND, 
  in0k_lazIdeSRC_srcTree_FNK_relPATH_Get, srcTree_FNC, 
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND, 
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_GET, 
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET, 
  in0k_lazIdeSRC_srcTree_FNK_mainFILE_GET, 
  in0k_lazIdeSRC_srcTree_FNK_mainFILE_FND, 
  in0k_lazIdeSRC_srcTree_FNK_mainFILE_SET, 
  in0k_lazIdeSRC_srcTree_FNK_srchPATH_ADD, 
  in0k_lazIdeSRC_srcTree_FNK_nodeFILE_FND, 
  in0k_lazIdeSRC_srcTree_FNK_nodeFILE_ADD, 
  in0k_lazIdeSRC_srcTree_coreFileSystemFNK, 
  in0k_lazIdeSRC_srcTree_item_Globals, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('REG', @REG.Register);
end;

initialization
  RegisterPackage('in0k_lazExt_CopyRAST', @Register);
end.
