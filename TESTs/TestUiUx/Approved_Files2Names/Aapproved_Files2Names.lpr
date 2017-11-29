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
  lazExt_CopyRAST__xmlConfig_approvedFILEs2NAMEs
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

