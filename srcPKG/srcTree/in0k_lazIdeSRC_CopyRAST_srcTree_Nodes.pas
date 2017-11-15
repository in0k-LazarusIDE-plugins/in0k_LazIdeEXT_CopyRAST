unit in0k_lazIdeSRC_CopyRAST_srcTree_Nodes;

{$mode objfpc}{$H+}

interface

uses     Dialogs,

  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  in0k_lazIdeSRC_srcTree_item_fsFile,
  in0k_lazIdeSRC_srcTree_item_Globals;


type
 rCopyRastNODE_DATA=record
   sideLeft :tSrcTree_item;
   sideRight:tSrcTree_item;
  end;


type
 tCopyRastNODE_ROOT=class(tSrcTree_ROOT)
  public
    CR_DATA:rCopyRastNODE_DATA;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

 tCopyRastNODE_BASE=class(tSrcTree_BASE)
  public
    CR_DATA:rCopyRastNODE_DATA;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

 tCopyRastNODE_MAIN=class(tSrcTree_MAIN)
  public
    CR_DATA:rCopyRastNODE_DATA;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

 tCopyRastNODE_FLDR=class(tSrcTree_fsFLDR)
  public
    CR_DATA:rCopyRastNODE_DATA;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

 tCopyRastNODE_FILE=class(tSrcTree_fsFILE)
  public
    CR_DATA:rCopyRastNODE_DATA;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;



  //---
  tCopyRastNODE_Root4Package=tSrcTree_Root4Package;
  tCopyRastNODE_Main4Package=tSrcTree_Main4Package;
  //---
  tCopyRastNODE_Root4Project=tSrcTree_Root4Project;
  tCopyRastNODE_Main4Project=tSrcTree_Main4Project;
  //---


procedure CopyRastNODE_CopyData_ROOT(const source,target:tCopyRastNODE_ROOT);
procedure CopyRastNODE_CopyData_BASE(const source,target:tCopyRastNODE_BASE);
procedure CopyRastNODE_CopyData_MAIN(const source,target:tCopyRastNODE_MAIN);
procedure CopyRastNODE_CopyData_FLDR(const source,target:tCopyRastNODE_FLDR);
procedure CopyRastNODE_CopyData_FILE(const source,target:tCopyRastNODE_FILE);


function  CopyRast_SrcTree_Copy(const source:tCopyRastNODE_ROOT):tCopyRastNODE_ROOT;

implementation

{%region --- CxDx -------------------------------------------------------}

procedure tCopyRastNODE_ROOT.AfterConstruction;
begin
    inherited;
    with CR_DATA do begin
        sideRight:=nil;
        sideLeft :=nil;
    end;
end;

procedure tCopyRastNODE_ROOT.BeforeDestruction;
begin
    inherited;
end;

//------------------------------------------------------------------------------

procedure tCopyRastNODE_BASE.AfterConstruction;
begin
    inherited;
    with CR_DATA do begin
        sideRight:=nil;
        sideLeft :=nil;
    end;
end;

procedure tCopyRastNODE_BASE.BeforeDestruction;
begin
    inherited;
end;

//------------------------------------------------------------------------------

procedure tCopyRastNODE_MAIN.AfterConstruction;
begin
    inherited;
    with CR_DATA do begin
        sideRight:=nil;
        sideLeft :=nil;
    end;
end;

procedure tCopyRastNODE_MAIN.BeforeDestruction;
begin
    inherited;
end;

//------------------------------------------------------------------------------

procedure tCopyRastNODE_FLDR.AfterConstruction;
begin
    inherited;
    with CR_DATA do begin
        sideRight:=nil;
        sideLeft :=nil;
    end;
end;

procedure tCopyRastNODE_FLDR.BeforeDestruction;
begin
    inherited;
end;

//------------------------------------------------------------------------------

procedure tCopyRastNODE_FILE.AfterConstruction;
begin
    inherited;
    with CR_DATA do begin
        sideRight:=nil;
        sideLeft :=nil;
    end;
end;

procedure tCopyRastNODE_FILE.BeforeDestruction;
begin
    inherited;
end;

{%endregion}

{%region --- copyData ---------------------------------------------------}

procedure CopyRastNODE_CopyData_ROOT(const source,target:tCopyRastNODE_ROOT);
begin
  {$IfOpt D+}
    Assert(Assigned(source));
    Assert(Assigned(target));
  {$endIf}
  SrcTree_re_set_itemTEXT(target,source.ItemTEXT);
  source.CR_DATA.sideRight:=target;
  target.CR_DATA.sideLeft :=source;
end;

procedure CopyRastNODE_CopyData_BASE(const source,target:tCopyRastNODE_BASE);
begin
  {$IfOpt D+}
    Assert(Assigned(source));
    Assert(Assigned(target));
  {$endIf}
  SrcTree_re_set_itemTEXT(target,source.ItemTEXT);
  source.CR_DATA.sideRight:=target;
  target.CR_DATA.sideLeft :=source;
end;

procedure CopyRastNODE_CopyData_MAIN(const source,target:tCopyRastNODE_MAIN);
begin
  {$IfOpt D+}
    Assert(Assigned(source));
    Assert(Assigned(target));
  {$endIf}
  SrcTree_re_set_itemTEXT(target,source.ItemTEXT);
  source.CR_DATA.sideRight:=target;
  target.CR_DATA.sideLeft :=source;
end;

procedure CopyRastNODE_CopyData_FLDR(const source,target:tCopyRastNODE_FLDR);
begin
  {$IfOpt D+}
    Assert(Assigned(source));
    Assert(Assigned(target));
  {$endIf}
  SrcTree_re_set_itemTEXT(target,source.ItemTEXT);
  SrcTree_fsFolder__set_SrchPATHs(target,source.inSearchPATHs);
  source.CR_DATA.sideRight:=target;
  target.CR_DATA.sideLeft :=source;
end;

procedure CopyRastNODE_CopyData_FILE(const source,target:tCopyRastNODE_FILE);
begin
  {$IfOpt D+}
    Assert(Assigned(source));
    Assert(Assigned(target));
  {$endIf}
  SrcTree_re_set_itemTEXT(target,source.ItemTEXT);
  SrcTree_fsFILE__set_FileKIND(target,source.fileKIND);
  source.CR_DATA.sideRight:=target;
  target.CR_DATA.sideLeft :=source;
end;

{%endregion}

function _CR_SrcTree_Copy_(const item:tSrcTree_item):tSrcTree_item;
var chld:tSrcTree_item;
begin
    if item is tCopyRastNODE_FILE then begin
        result:=tCopyRastNODE_FILE.Create('');
        CopyRastNODE_CopyData_FILE(tCopyRastNODE_FILE(item),tCopyRastNODE_FILE(result));
    end
   else
    if item is tCopyRastNODE_FLDR then begin
        result:=tCopyRastNODE_FLDR.Create('');
        CopyRastNODE_CopyData_FLDR(tCopyRastNODE_FLDR(item),tCopyRastNODE_FLDR(result));
    end
   else
    if item is tCopyRastNODE_BASE then begin
      result:=tCopyRastNODE_BASE.Create('');
      CopyRastNODE_CopyData_BASE(tCopyRastNODE_BASE(item),tCopyRastNODE_BASE(result));
    end
    //---
   else
    // --- _Main4xxx ---
    if item is tCopyRastNODE_Main4Project then begin
      result:=tCopyRastNODE_Main4Project.Create('');
      CopyRastNODE_CopyData_MAIN(tCopyRastNODE_MAIN(item),tCopyRastNODE_MAIN(result));
    end
   else
    if item is tCopyRastNODE_Main4Package then begin
      result:=tCopyRastNODE_Main4Package.Create('');
      CopyRastNODE_CopyData_MAIN(tCopyRastNODE_MAIN(item),tCopyRastNODE_MAIN(result));
    end
    //---
   else
    // --- _Root4xxx ---
    if item is tCopyRastNODE_Root4Project then begin
      result:=tCopyRastNODE_Root4Project.Create('');
      CopyRastNODE_CopyData_ROOT(tCopyRastNODE_ROOT(item),tCopyRastNODE_ROOT(result));
    end
   else
    if item is tCopyRastNODE_Root4Package then begin
      result:=tCopyRastNODE_Root4Package.Create('');
      CopyRastNODE_CopyData_ROOT(tCopyRastNODE_ROOT(item),tCopyRastNODE_ROOT(result));
    end
    //---
   else begin //< ВСЕ ПРОПАЛО
      {todo: ВСЕ ПРОПАЛО}
       ShowMessage('ER');
    end;
    //---
    chld:=item.ItemCHLD;
    while Assigned(chld) do begin
        SrcTree_insert_ChldLast(result,_CR_SrcTree_Copy_(chld));
        //--->
        chld:=chld.ItemNEXT;
    end;
end;

function CopyRast_SrcTree_Copy(const source:tCopyRastNODE_ROOT):tCopyRastNODE_ROOT;
begin
    result:=tCopyRastNODE_ROOT(_CR_SrcTree_Copy_(source));
end;

end.

