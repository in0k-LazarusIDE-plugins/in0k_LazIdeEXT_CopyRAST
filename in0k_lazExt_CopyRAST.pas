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
  lazExt_CopyRAST_from_IDEProcs, in0k_lazIdeSRC_DEBUG, 
  lazExt_CopyRAST_node_ROOT_package, in0k_lazIdeSRC_FuckUpForm_01, 
  lazExt_CopyRAST_node_ROOT_project, lazExt_CopyRAST_FuckUpForm, 
  lazExt_CopyRAST_operationNode_CORE, 
  lazExt_CopyRAST_operation_clearTargetDir, 
  lazExt_CopyRAST_operation_createTargetDirs, 
  lazExt_CopyRAST_operation_copyFiles, 
  lazExt_CopyRAST_operation_PSF_updateUnit, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('REG', @REG.Register);
end;

initialization
  RegisterPackage('in0k_lazExt_CopyRAST', @Register);
end.
