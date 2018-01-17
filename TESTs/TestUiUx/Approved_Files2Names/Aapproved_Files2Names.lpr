program Aapproved_Files2Names;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, lazcontrols, Unit1, makeTest_copyRastOBJ,
  in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs,
  in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs_CNFGs,
  lazExt_CopyRAST__xmlConfig_approvedFILEs2NAMEs,
  frmCopyRAST_srcTree_approvedFILEs2NAMEs, cmpCopyRAST_srcTree_nameTemplates,
  CopyRAST_srcTree_4Handler_CNFGs, frmCopyRAST_CnfgItem_EDIT,
  frmCopyRAST_cie_ReNames_customer, frmCopyRAST_cie_ReNames_template,
  frmCopyRAST_cie_ReNames_tmpltRule, in0k_ext4ColorTheme,
  lazExt_CopyRAST_clcNotRenamed, frmCopyRAST_EDIT, in0k_CopyRAST__frmSTAGE,
  in0k_CopyRAST__frmSTAGE_approveFILEs, in0k_CopyRAST__frmSTAGE_twoTree,
  in0k_CopyRAST_srcTree_Stage, in0k_lazIdeSRC_CopyRastSrcNODE_ROOT,
  in0k_CopyRAST_srcTreeNode_DATA
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

