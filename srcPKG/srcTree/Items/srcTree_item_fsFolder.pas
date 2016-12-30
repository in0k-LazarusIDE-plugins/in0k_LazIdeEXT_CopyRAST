unit srcTree_item_fsFolder;

{$mode objfpc}{$H+}

interface

uses
  srcTree_item_coreFileSystem;

type

  eSrcTree_SrchPath=(SrcTree_SrchPath__Fu,SrcTree_SrchPath__Fi,SrcTree_SrchPath__Fl);
  sSrcTree_SrchPath=set of eSrcTree_SrchPath;

 tSrcTree_item_fsNodeFLDR=class(tSrcTree_item_fsNodeDIR)
  protected
    function _get_ItemHint_:string; override;
  protected
   _SrchPaths_:sSrcTree_SrchPath;
  public
    property inSearchPATHs:sSrcTree_SrchPath read _SrchPaths_;
  end;


procedure SrcTree_item_fsFolder__addSearhPATH(const item:tSrcTree_item_fsNodeFLDR; SearchPATH:eSrcTree_SrchPath);

//function eCopyRAST_node_SrchPath__2__text(const item:eCopyRAST_node_SrchPath):string;



implementation

procedure SrcTree_item_fsFolder__addSearhPATH(const item:tSrcTree_item_fsNodeFLDR; SearchPATH:eSrcTree_SrchPath);
begin
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    item._SrchPaths_:=item._SrchPaths_+[SearchPATH];
end;

function _SrchPath__2__text_(const SrchPath:eSrcTree_SrchPath):string;
begin
    case SrchPath of
        SrcTree_SrchPath__Fu: result:='Fu';
        SrcTree_SrchPath__Fi: result:='Fi';
        SrcTree_SrchPath__Fl: result:='Fl';
    end;
end;

function _SrchPaths__2__text_(const SrchPaths:sSrcTree_SrchPath):string;
var tmp:eSrcTree_SrchPath;
begin
    result:='';
    //---
    tmp:=SrcTree_SrchPath__Fu;
    if tmp in SrchPaths then begin
        if result<>'' then result:=result+',';
        result:=result+_SrchPath__2__text_(tmp);
		end;
    //---
    tmp:=SrcTree_SrchPath__Fi;
    if tmp in SrchPaths then begin
        if result<>'' then result:=result+',';
        result:=result+_SrchPath__2__text_(tmp);
		end;
    //---
    tmp:=SrcTree_SrchPath__Fl;
    if tmp in SrchPaths then begin
        if result<>'' then result:=result+',';
        result:=result+_SrchPath__2__text_(tmp);
		end;
end;

function tSrcTree_item_fsNodeFLDR._get_ItemHint_:string;
begin
    result:=inherited _get_ItemHint_;
    if _SrchPaths_<>[] then begin
        result:=result+LineEnding+'SrchPaths:'+_SrchPaths__2__text_(_SrchPaths_);
		end;
end;

end.

