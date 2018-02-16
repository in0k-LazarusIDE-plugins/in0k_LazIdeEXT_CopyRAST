unit in0k_CopyRAST_srcTree_ITEMs;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_itemsList,
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  in0k_lazIdeSRC_srcTree_item_fsFile,
  in0k_lazIdeSRC_srcTree_item_Globals,

  in0k_lazIdeSRC_srcTree_FNK_rootFILE_FND,

  in0k_CopyRAST_srcTreeNode_DATA;

type

 tCopyRast_stITEM=tSrcTree_item;
 tCopyRast_stROOT=tSrcTree_ROOT;
 tCopyRast_stMAIN=tSrcTree_MAIN;

type

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

type

 tCopyRast_stBASE=class(tSrcTree_BASE)
  public
    CR_DATA:rCopyRastNODE_DATA;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

type

 tCopyRastNODE_Root4Package=class(tSrcTree_Root4Package)
  public
    CR_DATA:rCopyRastNODE_DATA;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

 tCopyRastNODE_Main4Package=class(tSrcTree_Main4Package)
  public
    CR_DATA:rCopyRastNODE_DATA;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

type

 tCopyRastNODE_Root4Project=class(tSrcTree_Root4Project)
  public
    CR_DATA:rCopyRastNODE_DATA;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

 tCopyRastNODE_Main4Project=class(tSrcTree_Main4Project)
  public
    CR_DATA:rCopyRastNODE_DATA;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;


//==============================================================================

function IS_CopyRAST_stITEM  (const value:tCopyRast_stITEM):boolean; overload; {$ifOPT D-}inline;{$endIf}
function IS_CopyRAST_stITEM  (const value:tObject         ):boolean; overload; {$ifOPT D-}inline;{$endIf}
function IS_CopyRAST_stITEM  (const value:pointer         ):boolean; overload; {$ifOPT D-}inline;{$endIf}

function IS_CopyRAST_stROOT  (const value:tCopyRast_stITEM):boolean; overload; {$ifOPT D-}inline;{$endIf}
function IS_CopyRAST_stROOT  (const value:tObject         ):boolean; overload; {$ifOPT D-}inline;{$endIf}
function IS_CopyRAST_stROOT  (const value:pointer         ):boolean; overload; {$ifOPT D-}inline;{$endIf}

function IS_CopyRAST_stBASE  (const value:tCopyRast_stITEM):boolean; overload; {$ifOPT D-}inline;{$endIf}
function IS_CopyRAST_stBASE  (const value:tObject         ):boolean; overload; {$ifOPT D-}inline;{$endIf}
function IS_CopyRAST_stBASE  (const value:pointer         ):boolean; overload; {$ifOPT D-}inline;{$endIf}

function IS_CopyRAST_stMAIN  (const value:tCopyRast_stITEM):boolean; overload; {$ifOPT D-}inline;{$endIf}
function IS_CopyRAST_stMAIN  (const value:tObject         ):boolean; overload; {$ifOPT D-}inline;{$endIf}
function IS_CopyRAST_stMAIN  (const value:pointer         ):boolean; overload; {$ifOPT D-}inline;{$endIf}

function CopyRAST_stITEM_DATA(const value:tCopyRast_stITEM):pCopyRastNODE_DATA; overload; {$ifOPT D-}inline;{$endIf}
function CopyRAST_stITEM_DATA(const value:tObject         ):pCopyRastNODE_DATA; overload; {$ifOPT D-}inline;{$endIf}
function CopyRAST_stITEM_DATA(const value:pointer         ):pCopyRastNODE_DATA; overload; {$ifOPT D-}inline;{$endIf}


function CopyRastNODE_ROOT(const value:tSrcTree_item):tSrcTree_ROOT;






function  CopyRastNODE_useInLeft (const rootRight:tSrcTree_ROOT; const value:tSrcTree_item):tSrcTree_item;
function  CopyRastNODE_useInRight(const rootLeft :tSrcTree_ROOT; const value:tSrcTree_item):tSrcTree_item;

procedure CopyRastNODE_listUseInLeft (const rootRight:tSrcTree_ROOT; const value:tSrcTree_item; const LIST:tSrcTree_listITEMs);
procedure CopyRastNODE_listUseInRight(const rootLeft :tSrcTree_ROOT; const value:tSrcTree_item; const LIST:tSrcTree_listITEMs);


procedure CopyRastNODE_LINK(const leftSide,rightSide:tSrcTree_item);


function  CopyRastNODE_presentInLeft(const rootLeft:tCopyRast_stROOT; const value:tCopyRast_stITEM):tCopyRast_stITEM;






//procedure CopyRastNODE_CopyData_ROOT(const source,target:tCopyRastNODE_ROOT);
procedure CopyRastNODE_CopyData_BASE(const source,target:tCopyRast_stBASE);
//procedure CopyRastNODE_CopyData_MAIN(const source,target:tCopyRastNODE_MAIN);
procedure CopyRastNODE_CopyData_FLDR(const source,target:tCopyRastNODE_FLDR);
procedure CopyRastNODE_CopyData_FILE(const source,target:tCopyRastNODE_FILE);


type
  mNeedCopyLeft2Right=function(const item:tCopyRast_stITEM):boolean of object;

function  CopyRast_SrcTree_copyLeft2Right(const source:tCopyRast_stROOT):tCopyRast_stROOT;
function  CopyRast_SrcTree_copyLeft2Right(const source:tCopyRast_stROOT; const testFnk:mNeedCopyLeft2Right):tCopyRast_stROOT;


implementation

function IS_CopyRAST_stROOT(const value:tCopyRast_stITEM):boolean;
begin
//    {$ifOPT D+}
//    Assert(Assigned(value));
//    {$endIf}
    result:=FALSE;
    if value is tCopyRastNODE_Root4Package then exit(true);
    if value is tCopyRastNODE_Root4Project then exit(true);
end;

function IS_CopyRAST_stBASE(const value:tCopyRast_stITEM):boolean;
begin
//    {$ifOPT D+}
//    Assert(Assigned(value));
//    {$endIf}
    result:=FALSE;
    if value is tCopyRast_stBASE then exit(true);
end;

function IS_CopyRAST_stMAIN(const value:tCopyRast_stITEM):boolean;
begin
//    {$ifOPT D+}
//    Assert(Assigned(value));
//    {$endIf}
    result:=FALSE;
    if value is tCopyRastNODE_Main4Package then exit(true);
    if value is tCopyRastNODE_Main4Project then exit(true);
end;

function IS_CopyRAST_stITEM(const value:tCopyRast_stITEM):boolean;
begin
//    {$ifOPT D+}
//    Assert(Assigned(value));
//    {$endIf}
    result:=FALSE;
    if value is tCopyRastNODE_FILE then exit(true);
    if value is tCopyRastNODE_FLDR then exit(true);
    if IS_CopyRAST_stBASE(value)   then exit(true);
    if IS_CopyRAST_stMAIN(value)   then exit(true);
    if IS_CopyRAST_stROOT(value)   then exit(true);
end;

function CopyRAST_stITEM_DATA(const value:tCopyRast_stITEM):pCopyRastNODE_DATA;
begin
//    {$ifOPT D+}
//    Assert(Assigned(value));
//   Assert(IS_CopyRAST_stITEM(value));
//    {$endIf}
    result:=nil;
    if value is tCopyRastNODE_FILE then exit(@tCopyRastNODE_FILE(value).CR_DATA);
    if value is tCopyRastNODE_FLDR then exit(@tCopyRastNODE_FLDR(value).CR_DATA);
    if value is tCopyRast_stBASE then exit(@tCopyRast_stBASE(value).CR_DATA);
    if value is tCopyRastNODE_Main4Package then exit(@tCopyRastNODE_Main4Package(value).CR_DATA);
    if value is tCopyRastNODE_Root4Package then exit(@tCopyRastNODE_Root4Package(value).CR_DATA);
    if value is tCopyRastNODE_Main4Project then exit(@tCopyRastNODE_Main4Project(value).CR_DATA);
    if value is tCopyRastNODE_Root4Project then exit(@tCopyRastNODE_Root4Project(value).CR_DATA);
end;

//------------------------------------------------------------------------------

function IS_CopyRAST_stROOT(const value:tObject):boolean;
begin
//    {$ifOPT D+}
//    Assert(Assigned(value));
//    {$endIf}
    result:=IS_CopyRAST_stROOT(tCopyRast_stITEM(value));
end;

function IS_CopyRAST_stROOT(const value:pointer):boolean;
begin
//    {$ifOPT D+}
//    Assert(Assigned(value));
//    {$endIf}
    result:=IS_CopyRAST_stROOT(TObject(value));
end;

//------------------------------------------------------------------------------

function IS_CopyRAST_stBASE(const value:tObject):boolean;
begin
    {$ifOPT D+}
    Assert(Assigned(value));
    {$endIf}
    result:=IS_CopyRAST_stBASE(tCopyRast_stITEM(value));
end;

function IS_CopyRAST_stBASE(const value:pointer):boolean;
begin
    {$ifOPT D+}
    Assert(Assigned(value));
    {$endIf}
    result:=IS_CopyRAST_stBASE(TObject(value));
end;

//------------------------------------------------------------------------------

function IS_CopyRAST_stMAIN(const value:tObject):boolean;
begin
    {$ifOPT D+}
    Assert(Assigned(value));
    {$endIf}
    result:=IS_CopyRAST_stMAIN(tCopyRast_stITEM(value));
end;

function IS_CopyRAST_stMAIN(const value:pointer):boolean;
begin
    {$ifOPT D+}
    Assert(Assigned(value));
    {$endIf}
    result:=IS_CopyRAST_stMAIN(TObject(value));
end;

//------------------------------------------------------------------------------

function IS_CopyRAST_stITEM(const value:TObject):boolean;
begin
    {$ifOPT D+}
    Assert(Assigned(value));
    {$endIf}
    result:=IS_CopyRAST_stITEM(tCopyRast_stITEM(value));
end;

function IS_CopyRAST_stITEM(const value:pointer):boolean;
begin
    {$ifOPT D+}
    Assert(Assigned(value));
    {$endIf}
    result:=IS_CopyRAST_stITEM(TObject(value));
end;

//------------------------------------------------------------------------------

function CopyRAST_stITEM_DATA(const value:TObject):pCopyRastNODE_DATA;
begin
    {$ifOPT D+}
    Assert(Assigned(value));
    {$endIf}
    result:=CopyRAST_stITEM_DATA(tCopyRast_stITEM(value));
end;

function CopyRAST_stITEM_DATA(const value:pointer):pCopyRastNODE_DATA;
begin
    {$ifOPT D+}
    Assert(Assigned(value));
    {$endIf}
    result:=CopyRAST_stITEM_DATA(TObject(value));
end;

//==============================================================================



function CopyRastNODE_ROOT(const value:tSrcTree_item):tSrcTree_ROOT;
begin
    {$ifOPT D+}
    Assert(Assigned(value));
    {$endIf}
    result:=tSrcTree_ROOT(value);
    while Assigned(result) do begin
        if tObject(result) is tSrcTree_ROOT then EXIT;
        result:=tSrcTree_ROOT(tSrcTree_item(result).ItemPRNT);
    end;
end;

//------------------------------------------------------------------------------

function _useInLeft_(const right:tSrcTree_item; const value:tSrcTree_item):boolean; {$ifOPT D-}inline;{$endIf}
var tmpDATA:pCopyRastNODE_DATA;
begin
    result:=false;
    if IS_CopyRAST_stITEM(right) then begin
        tmpDATA:=CopyRAST_stITEM_DATA(right);
        if Assigned(tmpDATA) then begin
            if tmpDATA^.sideLeft=value then begin
                result:=TRUE;
            end;
        end;
    end;
end;

function CopyRastNODE_useInLeft(const rootRight:tSrcTree_ROOT; const value:tSrcTree_item):tSrcTree_item;
var tmp:tSrcTree_item;
begin
    {$ifOPT D+}
    Assert(Assigned(rootRight));
    Assert(IS_CopyRAST_stITEM(rootRight));
    Assert(Assigned(value));
    Assert(IS_CopyRAST_stITEM(value));
    {$endIf}
    result:=rootRight;
    if _useInLeft_(result,value) then exit
    else begin
        result:=rootRight.ItemCHLD;
        while Assigned(result) do begin
            tmp:=CopyRastNODE_useInLeft(tSrcTree_ROOT(result),value);
            if Assigned(tmp) then begin
                result:=tmp;
                BREAK;
            end;
            result:=result.ItemNEXT;
        end;
    end;
end;

procedure CopyRastNODE_listUseInLeft (const rootRight:tSrcTree_ROOT; const value:tSrcTree_item; const LIST:tSrcTree_listITEMs);
var tmp:tSrcTree_item;
begin
    {$ifOPT D+}
    Assert(Assigned(rootRight));
    Assert(IS_CopyRAST_stITEM(rootRight));
    Assert(Assigned(value));
    Assert(IS_CopyRAST_stITEM(value));
    Assert(Assigned(LIST));
    {$endIf}
    tmp:=rootRight;
    if _useInLeft_(tmp,value) then begin
        LIST.Add(tmp);
    end;
    //---
    tmp:=tmp.ItemCHLD;
    while Assigned(tmp) do begin
        CopyRastNODE_listUseInLeft(tSrcTree_ROOT(tmp),value,LIST);
        tmp:=tmp.ItemNEXT;
    end;
end;


//------------------------------------------------------------------------------

function _useInRight_(const left:tSrcTree_item; const value:tSrcTree_item):boolean; {$ifOPT D-}inline;{$endIf}
var tmpDATA:pCopyRastNODE_DATA;
begin
    result:=false;
    if IS_CopyRAST_stITEM(left) then begin
        tmpDATA:=CopyRAST_stITEM_DATA(left);
        if Assigned(tmpDATA) then begin
            if tmpDATA^.sideRight=value then begin
                result:=TRUE;
            end;
        end;
    end;
end;

function CopyRastNODE_useInRight(const rootLeft:tSrcTree_ROOT; const value:tSrcTree_item):tSrcTree_item;
var tmp:tSrcTree_item;
begin
    {$ifOPT D+}
    Assert(Assigned(rootLeft));
    Assert(IS_CopyRAST_stITEM(rootLeft),rootLeft.ClassName+'  is NOT CopyRastNODE');
    Assert(Assigned(value));
    Assert(IS_CopyRAST_stITEM(value));
    {$endIf}
    result:=rootLeft;
    if _useInLeft_(result,value) then exit
    else begin
        result:=rootLeft.ItemCHLD;
        while Assigned(result) do begin
            tmp:=CopyRastNODE_useInRight(tSrcTree_ROOT(result),value);
            if Assigned(tmp) then begin
                result:=tmp;
                BREAK;
            end;
            result:=result.ItemNEXT;
        end;
    end;
end;

procedure CopyRastNODE_listUseInRight(const rootLeft :tSrcTree_ROOT; const value:tSrcTree_item; const LIST:tSrcTree_listITEMs);
var tmp:tSrcTree_item;
begin
    {$ifOPT D+}
    Assert(Assigned(rootLeft));
    Assert(IS_CopyRAST_stITEM(rootLeft));
    Assert(Assigned(value));
    Assert(IS_CopyRAST_stITEM(value));
    Assert(Assigned(LIST));
    {$endIf}
    tmp:=rootLeft;
    if _useInRight_(tmp,value) then begin
        LIST.Add(tmp);
    end;
    //---
    tmp:=tmp.ItemCHLD;
    while Assigned(tmp) do begin
        CopyRastNODE_listUseInRight(tSrcTree_ROOT(tmp),value,LIST);
        tmp:=tmp.ItemNEXT;
    end;
end;

//------------------------------------------------------------------------------

procedure CopyRastNODE_LINK(const leftSide,rightSide:tSrcTree_item);
var tmpRootLeft :tSrcTree_ROOT;
    tmpRootRight:tSrcTree_ROOT;
var tmpItem:tSrcTree_item;
    tmpDATA:pCopyRastNODE_DATA;
    tmpLIST:tSrcTree_listITEMs;
    i      :integer;
begin
    {$ifOPT D+}
    Assert(Assigned(leftSide));
    Assert(IS_CopyRAST_stITEM(leftSide));
    Assert(Assigned(rightSide));
    Assert(IS_CopyRAST_stITEM(rightSide));
    {$endIf}
    tmpRootLeft :=CopyRastNODE_ROOT(leftSide);
    tmpRootRight:=CopyRastNODE_ROOT(rightSide);
    if Assigned(tmpRootLeft) and Assigned(tmpRootRight) then begin
        //
        tmpLIST:=tSrcTree_listITEMs.Create;
        CopyRastNODE_listUseInRight(tmpRootLeft,rightSide,tmpLIST);
        if ((tmpLIST.Count=1)and(tmpLIST.Items[0]<>leftSide)) OR
           ( tmpLIST.Count>1 )
        then begin
            for i:=0 to tmpLIST.Count-1 do begin
                tmpDATA:=CopyRAST_stITEM_DATA(tmpLIST.Items[i]);
                tmpDATA^.sideRight:=tmpLIST.Items[i];
            end;
            tmpDATA:=CopyRAST_stITEM_DATA(leftSide);
            tmpDATA^.sideRight:=leftSide;
        end
        else begin
            tmpDATA:=CopyRAST_stITEM_DATA(leftSide);
            tmpDATA^.sideRight:=rightSide;
        end;
        tmpLIST.FREE;
        //
        tmpLIST:=tSrcTree_listITEMs.Create;
        CopyRastNODE_listUseInLeft(tmpRootRight,leftSide,tmpLIST);
        if ((tmpLIST.Count=1)and(tmpLIST.Items[0]<>rightSide)) OR
           ( tmpLIST.Count>1 )
        then begin
            for i:=0 to tmpLIST.Count-1 do begin
                tmpDATA:=CopyRAST_stITEM_DATA(tmpLIST.Items[i]);
                tmpDATA^.sideLeft:=tmpLIST.Items[i];
            end;
            tmpDATA:=CopyRAST_stITEM_DATA(rightSide);
            tmpDATA^.sideLeft:=rightSide;
        end
        else begin
            tmpDATA:=CopyRAST_stITEM_DATA(rightSide);
            tmpDATA^.sideLeft:=leftSide;
        end;
        tmpLIST.FREE;
    end;
end;

{%region --- CxDx -------------------------------------------------------}



//------------------------------------------------------------------------------

{procedure tCopyRastNODE_MAIN.AfterConstruction;
begin
    inherited;
    with CR_DATA do begin
        sideRight:=nil;
        sideLeft :=nil;
    end;
end;}

{procedure tCopyRastNODE_MAIN.BeforeDestruction;
begin
    inherited;
end;}

//------------------------------------------------------------------------------

procedure tCopyRastNODE_FLDR.AfterConstruction;
begin
    inherited;
    CopyRAST_srcTreeNodeDATA_Init(@CR_DATA);
end;

procedure tCopyRastNODE_FLDR.BeforeDestruction;
begin
    inherited;
end;

//------------------------------------------------------------------------------

procedure tCopyRastNODE_FILE.AfterConstruction;
begin
    inherited;
    CopyRAST_srcTreeNodeDATA_Init(@CR_DATA);
end;

procedure tCopyRastNODE_FILE.BeforeDestruction;
begin
    inherited;
end;

//------------------------------------------------------------------------------

procedure tCopyRast_stBASE.AfterConstruction;
begin
    inherited;
    CopyRAST_srcTreeNodeDATA_Init(@CR_DATA);
end;

procedure tCopyRast_stBASE.BeforeDestruction;
begin
    inherited;
end;

//------------------------------------------------------------------------------

procedure tCopyRastNODE_Root4Package.AfterConstruction;
begin
    inherited;
    CopyRAST_srcTreeNodeDATA_Init(@CR_DATA);
end;

procedure tCopyRastNODE_Root4Package.BeforeDestruction;
begin
    inherited;
end;

procedure tCopyRastNODE_Main4Package.AfterConstruction;
begin
    inherited;
    CopyRAST_srcTreeNodeDATA_Init(@CR_DATA);
end;

procedure tCopyRastNODE_Main4Package.BeforeDestruction;
begin
    inherited;
end;

//------------------------------------------------------------------------------

procedure tCopyRastNODE_Root4Project.AfterConstruction;
begin
    inherited;
    CopyRAST_srcTreeNodeDATA_Init(@CR_DATA);
end;

procedure tCopyRastNODE_Root4Project.BeforeDestruction;
begin
    inherited;
end;

procedure tCopyRastNODE_Main4Project.AfterConstruction;
begin
    inherited;
    CopyRAST_srcTreeNodeDATA_Init(@CR_DATA);
end;

procedure tCopyRastNODE_Main4Project.BeforeDestruction;
begin
    inherited;
end;

{%endregion}


{procedure CopyRastNODE_setLINK(const leftSide,rightSide:tCopyRastNODE_ROOT);
begin
    leftSide.CR_DATA.sideRight:=rightSide;
    rightSide.CR_DATA.sideLeft:=leftSide;
end; }

procedure CopyRastNODE_setLINK(const leftSide,rightSide:tCopyRast_stBASE);
begin
    leftSide.CR_DATA.sideRight:=rightSide;
    rightSide.CR_DATA.sideLeft:=leftSide;
end;

{procedure CopyRastNODE_setLINK(const leftSide,rightSide:tCopyRastNODE_MAIN);
begin
    leftSide.CR_DATA.sideRight:=rightSide;
    rightSide.CR_DATA.sideLeft:=leftSide;
end;}

procedure CopyRastNODE_setLINK(const leftSide,rightSide:tCopyRastNODE_FLDR);
begin
    if Assigned(rightSide.CR_DATA.sideLeft) then begin
        rightSide.CR_DATA.sideLeft:=nil;
    end
    else rightSide.CR_DATA.sideLeft:=leftSide;
    leftSide.CR_DATA.sideRight:=rightSide;
end;

procedure CopyRastNODE_setLINK(const leftSide,rightSide:tCopyRastNODE_FILE);
begin
    leftSide.CR_DATA.sideRight:=rightSide;
    rightSide.CR_DATA.sideLeft:=leftSide;
end;

{%region --- copyData ---------------------------------------------------}

{procedure CopyRastNODE_CopyData_ROOT(const source,target:tCopyRastNODE_ROOT);
begin
  {$IfOpt D+}
    Assert(Assigned(source));
    Assert(Assigned(target));
  {$endIf}
  SrcTree_re_set_itemTEXT(target,source.ItemTEXT);
  source.CR_DATA.sideRight:=target;
  target.CR_DATA.sideLeft :=source;
end;}

procedure CopyRastNODE_CopyData_BASE(const source,target:tCopyRast_stBASE);
begin
  {$IfOpt D+}
    Assert(Assigned(source));
    Assert(Assigned(target));
  {$endIf}
  SrcTree_re_set_itemTEXT(target,source.ItemTEXT);
  source.CR_DATA.sideRight:=target;
  target.CR_DATA.sideLeft :=source;
end;

{procedure CopyRastNODE_CopyData_MAIN(const source,target:tCopyRastNODE_MAIN);
begin
  {$IfOpt D+}
    Assert(Assigned(source));
    Assert(Assigned(target));
  {$endIf}
  SrcTree_re_set_itemTEXT(target,source.ItemTEXT);
  source.CR_DATA.sideRight:=target;
  target.CR_DATA.sideLeft :=source;
end;}

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

(*function _CR_SrcTree_Copy_(const item:tSrcTree_item):tSrcTree_item;
var chld:tSrcTree_item;
begin
 {   if item is tCopyRastNODE_FILE then begin
        result:=tCopyRastNODE_FILE.Create('');
        CopyRastNODE_CopyData_FILE(tCopyRastNODE_FILE(item),tCopyRastNODE_FILE(result));
    end
   else
    if item is tCopyRastNODE_FLDR then begin
        result:=tCopyRastNODE_FLDR.Create('');
        CopyRastNODE_CopyData_FLDR(tCopyRastNODE_FLDR(item),tCopyRastNODE_FLDR(result));
    end
   else
    if item is tCopyRast_stBASE then begin
      result:=tCopyRast_stBASE.Create('');
      CopyRastNODE_CopyData_BASE(tCopyRast_stBASE(item),tCopyRast_stBASE(result));
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
    end;  }
end;  *)

{%region --- по НОДОВОЕ копирование дерева ----------}

function _CR_SrcTree_Copy_item_(const source:tCopyRast_stITEM):tCopyRast_stITEM;
var chld :tCopyRast_stITEM;
    lData:pCopyRastNODE_DATA;
    rData:pCopyRastNODE_DATA;
begin // сам узел .. создаем, копируем данные, связываем
      {todo: проверки}
    result:=tCopyRast_stITEM(source.ClassType.Create);
    result.CopyData(source);
    lData:=CopyRAST_stITEM_DATA(source);
    rData:=CopyRAST_stITEM_DATA(result);
    lData^.sideRight:=result;
    rData^.sideLeft :=source;
end;

//------------------------------------------------------------------------------

function _CRST_CopyL2R_(const item:tCopyRast_stITEM):tCopyRast_stITEM; overload;
var chld :tCopyRast_stITEM;
    lData:pCopyRastNODE_DATA;
    rData:pCopyRastNODE_DATA;
begin
    // сам узел ..
    result:=_CR_SrcTree_Copy_item_(item);
    // про детей теперь
    chld:=item.ItemCHLD;
    while Assigned(chld) do begin
        SrcTree_insert_ChldLast(result,_CRST_CopyL2R_(chld));
        chld:=chld.ItemNEXT;
    end;
end;

function CopyRast_SrcTree_copyLeft2Right(const source:tCopyRast_stROOT):tCopyRast_stROOT;
begin {todo: уйти от рекурсии}
    result:=tCopyRast_stROOT(_CRST_CopyL2R_(source));
end;

//------------------------------------------------------------------------------

function _CRST_testNeedCopyItemOrCHILDs_(const source:tCopyRast_stITEM; const testFnk:mNeedCopyLeft2Right):boolean;
var tmp:tCopyRast_stITEM;
begin {todo: уйти от рекурсии}
    {$ifOpt D+}
        Assert(Assigned(source));
        Assert(Assigned(testFnk));
    {$endIf}
    result:=testFnk(source);
    if not result then begin //< копировать не надо? проверим детей
        tmp:=source.ItemCHLD;
        while Assigned(tmp) do begin
            if _CRST_testNeedCopyItemOrCHILDs_(tmp,testFnk) then begin
                // кого-то внутри НАДО копировать!
                result:=TRUE;
                BREAK;
            end;
            //-->
            tmp:=tmp.ItemNEXT;
        end;
    end;
end;

function _CRST_CopyL2R_(const item:tCopyRast_stITEM; const testFnk:mNeedCopyLeft2Right):tCopyRast_stITEM; overload;
var srcCHLD:tCopyRast_stITEM;
    newITEM:tCopyRast_stITEM;
begin
    result:=nil;
    if _CRST_testNeedCopyItemOrCHILDs_(item,testFnk) then begin
        result:=_CR_SrcTree_Copy_item_(item);
        //
        srcCHLD:=item.ItemCHLD;
        while Assigned(srcCHLD) do begin
            newITEM:=_CRST_CopyL2R_(srcCHLD,testFnk);
            if Assigned(newITEM)
            then SrcTree_insert_ChldLast(result,newITEM);
            //-->
            srcCHLD:=srcCHLD.ItemNEXT;
        end;
    end;
end;

function CopyRast_SrcTree_copyLeft2Right(const source:tCopyRast_stROOT; const testFnk:mNeedCopyLeft2Right):tCopyRast_stROOT;
begin {todo: уйти от рекурсии}
    result:=tCopyRast_stROOT(_CRST_CopyL2R_(source,testFnk));
end;

{%endregion}
















function CopyRastNODE_presentInLeft(const rootLeft:tCopyRast_stROOT; const value:tCopyRast_stITEM):tCopyRast_stITEM;
var tmpNext:tCopyRast_stITEM;
    itmData:pCopyRastNODE_DATA;
begin
    result:=value;
    while Assigned(result) do begin
        itmData:=CopyRAST_stITEM_DATA(result);
        result :=itmData^.sideLeft;
        if Assigned(result) and (SrcTree_fndRootFILE(result)=rootLeft)
        then BREAK;
    end;
end;


end.



