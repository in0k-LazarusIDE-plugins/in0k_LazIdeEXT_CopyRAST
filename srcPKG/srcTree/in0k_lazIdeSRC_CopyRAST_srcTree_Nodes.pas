unit in0k_lazIdeSRC_CopyRAST_srcTree_Nodes;

{$mode objfpc}{$H+}

interface

uses     Dialogs,
  {Classes,} contnrs,
  in0k_lazIdeSRC_srcTree_itemsList,
  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  in0k_lazIdeSRC_srcTree_item_fsFile,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_4Package;


type

 eCopyRastNODE_KIND=(CRNK_notVerified);
 tCopyRastNODE_KIND=set of eCopyRastNODE_KIND;


 rCopyRastNODE_DATA=record
   sideLeft :tSrcTree_item;
   sideRight:tSrcTree_item;
   NodeSTATE:tCopyRastNODE_KIND;
   NodeDATAs:pointer;
  end;
 pCopyRastNODE_DATA=^rCopyRastNODE_DATA;


procedure CopyRastNodeDATA_Init     (const data:pCopyRastNODE_DATA);
function  CopyRastNodeDATA_Datas_GET(const data:pCopyRastNODE_DATA):pointer;
procedure CopyRastNodeDATA_Datas_SET(const data:pCopyRastNODE_DATA; const value:pointer);

type
 {tCopyRastNODE_ROOT=class(tSrcTree_ROOT)
  public
    CR_DATA:rCopyRastNODE_DATA;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end; }

 tCopyRastNODE_BASE=class(tSrcTree_BASE)
  public
    CR_DATA:rCopyRastNODE_DATA;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

 {tCopyRastNODE_MAIN=class(tSrcTree_MAIN)
  public
    CR_DATA:rCopyRastNODE_DATA;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;
  }
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
  tCopyRastNODE_Root4Package=class(tSrcTree_ROOT)
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

  //---
 tCopyRastNODE_Root4Project=class(tSrcTree_ROOT)
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
  //---



function isCopyRastNODE   (const value:tObject      ):boolean; overload;
function isCopyRastNODE   (const value:pointer      ):boolean; overload;
function CopyRastNODE_DATA(const value:tObject      ):pCopyRastNODE_DATA;
function CopyRastNODE_ROOT(const value:tSrcTree_item):tSrcTree_ROOT;

function CopyRastNODE_useInLeft (const rootRight:tSrcTree_ROOT; const value:tSrcTree_item):tSrcTree_item;
function CopyRastNODE_useInRight(const rootLeft :tSrcTree_ROOT; const value:tSrcTree_item):tSrcTree_item;

procedure CopyRastNODE_listUseInLeft (const rootRight:tSrcTree_ROOT; const value:tSrcTree_item; const LIST:tSrcTree_listITEMs);
procedure CopyRastNODE_listUseInRight(const rootLeft :tSrcTree_ROOT; const value:tSrcTree_item; const LIST:tSrcTree_listITEMs);


procedure CopyRastNODE_LINK(const leftSide,rightSide:tSrcTree_item);





//procedure CopyRastNODE_CopyData_ROOT(const source,target:tCopyRastNODE_ROOT);
procedure CopyRastNODE_CopyData_BASE(const source,target:tCopyRastNODE_BASE);
//procedure CopyRastNODE_CopyData_MAIN(const source,target:tCopyRastNODE_MAIN);
procedure CopyRastNODE_CopyData_FLDR(const source,target:tCopyRastNODE_FLDR);
procedure CopyRastNODE_CopyData_FILE(const source,target:tCopyRastNODE_FILE);


//function  CopyRast_SrcTree_Copy(const source:tCopyRastNODE_ROOT):tCopyRastNODE_ROOT;



//procedure CopyRastNODE_setLINK(const leftSide,rightSide:tCopyRastNODE_ROOT); overload;
//procedure CopyRastNODE_setLINK(const leftSide,rightSide:tCopyRastNODE_BASE); overload;
//procedure CopyRastNODE_setLINK(const leftSide,rightSide:tCopyRastNODE_MAIN); overload;
//procedure CopyRastNODE_setLINK(const leftSide,rightSide:tCopyRastNODE_FLDR); overload;
//procedure CopyRastNODE_setLINK(const leftSide,rightSide:tCopyRastNODE_FILE); overload;


implementation

procedure CopyRastNodeDATA_Init(const data:pCopyRastNODE_DATA);
begin
    with data^ do begin
        sideLeft :=nil;
        sideRight:=nil;
        NodeSTATE:=[];
        NodeDATAs:=nil;
    end;
end;

function CopyRastNodeDATA_Datas_GET(const data:pCopyRastNODE_DATA):pointer;
begin
    result:=data^.NodeDATAs;
end;

procedure CopyRastNodeDATA_Datas_SET(const data:pCopyRastNODE_DATA; const value:pointer);
begin
    data^.NodeDATAs:=value;
end;

//------------------------------------------------------------------------------

function isCopyRastNODE(const value:tObject):boolean;
begin
    {$ifOPT D+}
    Assert(Assigned(value));
    {$endIf}
    result:=FALSE;
    if value is tCopyRastNODE_FILE then exit(true);
    if value is tCopyRastNODE_FLDR then exit(true);
    if value is tCopyRastNODE_BASE then exit(true);
    if value is tCopyRastNODE_Main4Package then exit(true);
    if value is tCopyRastNODE_Root4Package then exit(true);
    if value is tCopyRastNODE_Main4Project then exit(true);
    if value is tCopyRastNODE_Root4Project then exit(true);
end;

function isCopyRastNODE(const value:pointer):boolean;
begin
    {$ifOPT D+}
    Assert(Assigned(value));
    {$endIf}
    result:=isCopyRastNODE(TObject(value));
end;

function CopyRastNODE_DATA(const value:tObject):pCopyRastNODE_DATA;
begin
    {$ifOPT D+}
    Assert(Assigned(value));
    {$endIf}
    result:=nil;
    if value is tCopyRastNODE_FILE then exit(@tCopyRastNODE_FILE(value).CR_DATA);
    if value is tCopyRastNODE_FLDR then exit(@tCopyRastNODE_FLDR(value).CR_DATA);
    if value is tCopyRastNODE_BASE then exit(@tCopyRastNODE_BASE(value).CR_DATA);
    if value is tCopyRastNODE_Main4Package then exit(@tCopyRastNODE_Main4Package(value).CR_DATA);
    if value is tCopyRastNODE_Root4Package then exit(@tCopyRastNODE_Root4Package(value).CR_DATA);
    if value is tCopyRastNODE_Main4Project then exit(@tCopyRastNODE_Main4Project(value).CR_DATA);
    if value is tCopyRastNODE_Root4Project then exit(@tCopyRastNODE_Root4Project(value).CR_DATA);
end;

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
    if isCopyRastNODE(right) then begin
        tmpDATA:=CopyRastNODE_DATA(right);
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
    Assert(isCopyRastNODE(rootRight));
    Assert(Assigned(value));
    Assert(isCopyRastNODE(value));
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
    Assert(isCopyRastNODE(rootRight));
    Assert(Assigned(value));
    Assert(isCopyRastNODE(value));
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
    if isCopyRastNODE(left) then begin
        tmpDATA:=CopyRastNODE_DATA(left);
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
    Assert(isCopyRastNODE(rootLeft),rootLeft.ClassName+'  is NOT CopyRastNODE');
    Assert(Assigned(value));
    Assert(isCopyRastNODE(value));
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
    Assert(isCopyRastNODE(rootLeft));
    Assert(Assigned(value));
    Assert(isCopyRastNODE(value));
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
    Assert(isCopyRastNODE(leftSide));
    Assert(Assigned(rightSide));
    Assert(isCopyRastNODE(rightSide));
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
                tmpDATA:=CopyRastNODE_DATA(tmpLIST.Items[i]);
                tmpDATA^.sideRight:=tmpLIST.Items[i];
            end;
            tmpDATA:=CopyRastNODE_DATA(leftSide);
            tmpDATA^.sideRight:=leftSide;
        end
        else begin
            tmpDATA:=CopyRastNODE_DATA(leftSide);
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
                tmpDATA:=CopyRastNODE_DATA(tmpLIST.Items[i]);
                tmpDATA^.sideLeft:=tmpLIST.Items[i];
            end;
            tmpDATA:=CopyRastNODE_DATA(rightSide);
            tmpDATA^.sideLeft:=rightSide;
        end
        else begin
            tmpDATA:=CopyRastNODE_DATA(rightSide);
            tmpDATA^.sideLeft:=leftSide;
        end;
        tmpLIST.FREE;
    end;
end;

{%region --- CxDx -------------------------------------------------------}

procedure tCopyRastNODE_Root4Project.AfterConstruction;
begin
    inherited;
    CopyRastNodeDATA_Init(@CR_DATA);
end;

procedure tCopyRastNODE_Root4Project.BeforeDestruction;
begin
    inherited;
end;

procedure tCopyRastNODE_Main4Project.AfterConstruction;
begin
    inherited;
    CopyRastNodeDATA_Init(@CR_DATA);
end;

procedure tCopyRastNODE_Main4Project.BeforeDestruction;
begin
    inherited;
end;



procedure tCopyRastNODE_Root4Package.AfterConstruction;
begin
    inherited;
    CopyRastNodeDATA_Init(@CR_DATA);
end;

procedure tCopyRastNODE_Root4Package.BeforeDestruction;
begin
    inherited;
end;

procedure tCopyRastNODE_Main4Package.AfterConstruction;
begin
    inherited;
    CopyRastNodeDATA_Init(@CR_DATA);
end;

procedure tCopyRastNODE_Main4Package.BeforeDestruction;
begin
    inherited;
end;

//------------------------------------------------------------------------------

procedure tCopyRastNODE_BASE.AfterConstruction;
begin
    inherited;
    CopyRastNodeDATA_Init(@CR_DATA);
end;

procedure tCopyRastNODE_BASE.BeforeDestruction;
begin
    inherited;
end;

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
    CopyRastNodeDATA_Init(@CR_DATA);
end;

procedure tCopyRastNODE_FLDR.BeforeDestruction;
begin
    inherited;
end;

//------------------------------------------------------------------------------

procedure tCopyRastNODE_FILE.AfterConstruction;
begin
    inherited;
    CopyRastNodeDATA_Init(@CR_DATA);
end;

procedure tCopyRastNODE_FILE.BeforeDestruction;
begin
    inherited;
end;

{%endregion}


{procedure CopyRastNODE_setLINK(const leftSide,rightSide:tCopyRastNODE_ROOT);
begin
    leftSide.CR_DATA.sideRight:=rightSide;
    rightSide.CR_DATA.sideLeft:=leftSide;
end; }

procedure CopyRastNODE_setLINK(const leftSide,rightSide:tCopyRastNODE_BASE);
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

function _CR_SrcTree_Copy_(const item:tSrcTree_item):tSrcTree_item;
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
    end;  }
end;

{function CopyRast_SrcTree_Copy(const source:tCopyRastNODE_ROOT):tCopyRastNODE_ROOT;
begin
    result:=tCopyRastNODE_ROOT(_CR_SrcTree_Copy_(source));
end;  }

end.



