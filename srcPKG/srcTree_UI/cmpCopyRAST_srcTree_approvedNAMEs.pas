unit cmpCopyRAST_srcTree_approvedNAMEs;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  ComCtrls,

  in0k_colors4StdSheme,
  cmpCopyRAST_srcTree;

type

 tCmpCopyRAST_srcTree_approvedNAMEs=class(tCmpCopyRAST_srcTree)
  protected
   _show_unReNamed_FLDR_:boolean;
   _show_unReNamed_FILE_:boolean;
  protected
    function  CustomDrawItem(Node:TTreeNode; State:TCustomDrawState; Stage:TCustomDrawStage; var PaintImages:Boolean):Boolean; override;
  public
    constructor Create(AnOwner: TComponent); override;
  end;

implementation

constructor tCmpCopyRAST_srcTree_approvedNAMEs.Create(AnOwner:TComponent);
begin
    inherited Create(AnOwner);
   _lftSide_mustNotNIL_:=TRUE;
end;


// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCmpCopyRAST_srcTree_approvedNAMEs.CustomDrawItem(Node:TTreeNode; State:TCustomDrawState; Stage:TCustomDrawStage; var PaintImages:Boolean):Boolean;
begin
    result:=inherited;
    if (Stage=cdPrePaint) and result then begin
        Canvas.Font.Color:=in0k_colors4StdSheme__getRed//clGray
    end;
end;

end.

