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
  frmCopyRAST_cie_ReNames_tmpltRule, in0k_colors4StdSheme
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

