unit in0k_CopyRAST__cmpSTAGE_Tree;

{$mode objfpc}{$H+}

interface

uses
  in0k_CopyRAST_STAGEs_CORE,
  //
  cmpCopyRAST_srcTree;

type
 tCmpCopyRAST_stageTree=class(tCmpCopyRAST_srcTree)
  private
   _CopyRast_STAGE_:tCopyRast_STAGE;
    procedure _CopyRast_STAGE_set_(const value:tCopyRast_STAGE);
  public
    property CopyRast_STAGE:tCopyRast_STAGE read _CopyRast_STAGE_ write _CopyRast_STAGE_set_;
  end;
 tCmpCopyRAST_stageTree_TYPE=class of tCmpCopyRAST_stageTree;

implementation

procedure tCmpCopyRAST_stageTree._CopyRast_STAGE_set_(const value:tCopyRast_STAGE);
begin
   _CopyRast_STAGE_:=value;
end;

end.

