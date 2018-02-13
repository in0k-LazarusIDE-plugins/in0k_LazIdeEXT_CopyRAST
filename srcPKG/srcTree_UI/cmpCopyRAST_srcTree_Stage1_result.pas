unit cmpCopyRAST_srcTree_Stage1_result;

{$mode objfpc}{$H+}

interface

uses
  Graphics,
  ComCtrls,
    in0k_lazIdeSRC_srcTree_CORE_item,

  in0k_CopyRAST_srcTree_ITEMs,
  in0k_CopyRAST_srcTreeNode_DATA,
  cmpCopyRAST_srcTree;


type

 tCmpCopyRAST_srcTree_Stage1_result=class(tCmpCopyRAST_srcTree)

  protected
   _rootSRC_:tCopyRast_stROOT;
    procedure _rootSRC_set_(const value:tCopyRast_stROOT);

  protected
    function  CustomDrawItem(Node:TTreeNode; State:TCustomDrawState; Stage:TCustomDrawStage; var PaintImages:Boolean):Boolean; override;
  public
    property RootSRC:tCopyRast_stROOT write _rootSRC_set_;
  end;

implementation

procedure tCmpCopyRAST_srcTree_Stage1_result._rootSRC_set_(const value:tCopyRast_stROOT);
begin
   _rootSRC_:=value;
end;

function tCmpCopyRAST_srcTree_Stage1_result.CustomDrawItem(Node:TTreeNode; State:TCustomDrawState; Stage:TCustomDrawStage; var PaintImages:Boolean):Boolean;
var tmpNode:tSrcTree_item;
    tmpData:pCopyRastNODE_DATA;
begin
    result:=inherited;
    if (Stage=cdPrePaint){ and (_lftSide_mustNotNIL_ or _rhtSide_mustNotNIL_)} and result then begin
        tmpNode:=tSrcTree_item(Node.Data);
        if Assigned(tmpNode) and IS_CopyRast_stITEM(tmpNode)
        then begin
            Canvas.Font.Color:=clred;//GrayText//color_Red//clGray

            if not Assigned( CopyRastNODE_presentInLeft(_rootSRC_,tmpNode) )
            then Canvas.Font.Color:=clGreen;


            {tmpData:=CopyRAST_stITEM_DATA(tmpNode);
            if _lftSide_mustNotNIL_ and not Assigned(tmpData^.sideLeft)
            then Canvas.Font.Color:=clGrayText//color_Red//clGray
           else
            if _rhtSide_mustNotNIL_ and not Assigned(tmpData^.sideRight)
            then Canvas.Font.Color:=clGrayText//color_Red//clGray }
        end;
    end;
end;




end.

