unit in0k_CopyRAST_STAGEs;

{$mode objfpc}{$H+}

interface

uses
  srcTree_builder_CORE,
  in0k_CopyRAST_STAGEs_CORE,

  in0k_CopyRAST__stage_01_Handling,

  in0k_lazIdeSRC_CopyRAST_srcTree;

type

 tCopyRAST_STAGEs=class(tCopyRAST_STAGEs_CORE)
  protected
    procedure _stages_CRT_; override;
  end;


 tCopyRAST_STAGEs_4Package=class(tCopyRAST_STAGEs)

  protected
    function _builder_TYPE_:tSrcTree_Builder_TYPE; override;
    function _creater_TYPE_:tSrcTree_Creater_TYPE; override;
  public
    constructor Create(const MainIdeOobject:TObject); override;
  end;


implementation



procedure tCopyRAST_STAGEs._stages_CRT_;
begin
    inherited;
   _stage_01_:=tCopyRast__stage_01_Handling.Create(self);//(_Builder_);
   _stage_02_:=tCopyRast_SrcTree_STAGE_L_R.Create(self);//tCopyRast_stage__JustCopying.Create(_Builder_);
   _stage_03_:=tCopyRast_SrcTree_STAGE_L_R.Create(self);//tCopyRast_stage__ChangePaths.Create(_Builder_);
   _stage_04_:=tCopyRast_SrcTree_STAGE_L_R.Create(self);//tCopyRast_stage__JustCopying.Create(_Builder_);
   _stage_05_:=tCopyRast_SrcTree_STAGE_L_R.Create(self);//tCopyRast_stage__JustCopying.Create(_Builder_);
end;




constructor tCopyRAST_STAGEs_4Package.Create(const MainIdeOobject:TObject);
begin
    inherited;
end;

//------------------------------------------------------------------------------

function tCopyRAST_STAGEs_4Package._builder_TYPE_:tSrcTree_Builder_TYPE;
begin
    result:=tCopyRastSrcTree_Builder4Package;
end;

function tCopyRAST_STAGEs_4Package._creater_TYPE_:tSrcTree_Creater_TYPE;
begin
    result:=tCopyRastSrcTree_Creater4Package;
end;


end.


