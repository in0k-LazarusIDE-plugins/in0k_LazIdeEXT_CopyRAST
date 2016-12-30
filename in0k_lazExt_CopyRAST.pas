{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit in0k_lazExt_CopyRAST;

interface

uses
    REG, in0k_lazIdeSRC_ExpertCORE, lazExt_CopyRAST_wndCORE, lazExt_CopyRAST, 
    lazExt_CopyRAST_StrConsts, lazExt_CopyRAST_wndPackage, 
    lazExt_CopyRAST_wndProject, lazExt_CopyRAST_node, 
    lazExt_CopyRAST_node_File, lazExt_CopyRAST_node_Folder, 
    lazExt_CopyRAST_node_ROOT, lazExt_CopyRAST_from_IDEProcs, 
    in0k_lazIdeSRC_DEBUG, lazExt_CopyRAST_node_ROOT_package, 
    in0k_lazIdeSRC_FuckUpForm_01, lazExt_CopyRAST_node_ROOT_project, 
    lazExt_CopyRAST_FuckUpForm, Processing_CORE, 
    lazExt_CopyRAST_operation_clearTargetDir, 
    lazExt_CopyRAST_operation_createTargetDirs, 
    lazExt_CopyRAST_operation_copyFiles, 
    lazExt_CopyRAST_operation_PSF_updateUnit, 
    lazExt_CopyRAST_operation_PSF_updateUsesMain, 
    lazExt_CopyRAST_operation_PSF_TEST, lazExt_CopyRAST_TEXTs, 
    lazExt_CopyRAST_Node2TEXTs, 
    lazExt_CopyRAST_operationNode_EXECUTOR_Package, 
    lazExt_CopyRAST_processingNODE, lazExt_CopyRAST_processingMCHN, 
    prcNode_clearTargetDir, prcNode_createTargetDir, prcNode_copyFile, 
    prcNode_PSF_updateUnit, prcNode_PSF_updateUses, prcNode_XML_updateLPK, 
    prcNode_core_srcEdit, prcNode_core_xmlEdit, prcNode_XML_updateLPK_v4, 
    prcNode_XML_CompilerOptions_SearchPaths, prcNode_XML_Files, 
    prcNode_PSF_updateInclude, srcTree_item_coreFileSystem, 
    in0k_lazExt_CopyRAST_cmpTree, srcTree_builder_CORE, 
    srcTree_builder_4Package, srcTree_item_root4Package, srcTree_item_CORE, 
    srcTree_item_coreROOT, srcTree_item_baseDIR, srcTree_item_coreMAIN, 
    srcTree_item_main4Package, srcTree_item_fsFolder, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('REG', @REG.Register);
end;

initialization
  RegisterPackage('in0k_lazExt_CopyRAST', @Register);
end.
