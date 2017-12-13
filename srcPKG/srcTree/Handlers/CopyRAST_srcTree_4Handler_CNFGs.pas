unit CopyRAST_srcTree_4Handler_CNFGs;

{$mode objfpc}{$H+}

interface

uses
  Classes,contnrs;

type

 tCopyRAST_srcTree_4Handler_CNFGsNode=class
  public
    procedure COPY(const Source:tCopyRAST_srcTree_4Handler_CNFGsNode); virtual; {$ifOpt D-}abstruct;{$endIf}
    function needSAVE:boolean; virtual;
  end;

 tCopyRAST_srcTree_4Handler_CNFGsLAIR=class(tCopyRAST_srcTree_4Handler_CNFGsNode)
  protected
   _LAIR_:TObjectList;
    function  _LAIR_CNT_:integer;
    function  _item_GET_(Index:Integer):tCopyRAST_srcTree_4Handler_CNFGsNode;
    procedure _item_SET_(Index:Integer; value:tCopyRAST_srcTree_4Handler_CNFGsNode);
    function  _item_ADD_(value:tCopyRAST_srcTree_4Handler_CNFGsNode):integer;
  public
    procedure CLEAR(const withOutData:boolean=false);
    procedure COPY(const Source:tCopyRAST_srcTree_4Handler_CNFGsNode); override;
  public
    property Count:integer read _LAIR_CNT_;
    property Items[Index:integer]:tCopyRAST_srcTree_4Handler_CNFGsNode read _item_GET_ write _item_SET_;
  public
    function  IndexOf(const item:tCopyRAST_srcTree_4Handler_CNFGsNode):integer;
    function  Add    (const item:tCopyRAST_srcTree_4Handler_CNFGsNode):integer;
    procedure Delete (const indx:integer);
  public
    constructor Create;
    destructor DESTROY; override;
  end;

 tCopyRAST_srcTree_4Handler_CNFGs=class
  protected
   _LIST_:TStringList;
    procedure _LIST_CLR_;
    function  _LIST_CNT_:integer;
    function  _CNFG_CRT_:tCopyRAST_srcTree_4Handler_CNFGsNode; virtual; {$ifOpt D-}abstruct;{$endIf}
  public
    constructor Create;
    destructor DESTROY; override;
  public
    property  CNFGS_Count:integer read _LIST_CNT_;
    procedure CNFGS_Item(const index:integer; out   Path:string; out   Item:tCopyRAST_srcTree_4Handler_CNFGsNode);
    procedure CNFGS_Add (out   index:integer; const Path:string; const Item:tCopyRAST_srcTree_4Handler_CNFGsNode); overload;
    procedure CNFGS_Add (const Path:string; const Item:tCopyRAST_srcTree_4Handler_CNFGsNode);                      overload;
    function  CNFGS_GET (const path:string):tCopyRAST_srcTree_4Handler_CNFGsLAIR;
  public
    function  CNFG_GET(const path:string):tObject;
    procedure CNFG_GET(const path:string; out   Item:tObject);
    procedure CNFG_SET(const path:string; const Item:tCopyRAST_srcTree_4Handler_CNFGsNode);
  end;

implementation

{$ifOpt D+}
procedure tCopyRAST_srcTree_4Handler_CNFGsNode.COPY(const Source:tCopyRAST_srcTree_4Handler_CNFGsNode);
begin
    Assert(Assigned(Source));
end;
{$endIf}

function tCopyRAST_srcTree_4Handler_CNFGsNode.needSAVE:boolean;
begin
    result:=TRUE;
end;

//==============================================================================

constructor tCopyRAST_srcTree_4Handler_CNFGsLAIR.Create;
begin
    inherited;
   _LAIR_:=TObjectList.Create(TRUE);
end;

destructor tCopyRAST_srcTree_4Handler_CNFGsLAIR.DESTROY;
begin
    inherited;
   _LAIR_.FREE;
end;

//------------------------------------------------------------------------------

function tCopyRAST_srcTree_4Handler_CNFGsLAIR._LAIR_CNT_:integer;
begin
    {$ifOpt D+}
    Assert(Assigned(_LAIR_));
    {$endIf}
    result:=_LAIR_.Count;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCopyRAST_srcTree_4Handler_CNFGsLAIR._item_GET_(Index:Integer):tCopyRAST_srcTree_4Handler_CNFGsNode;
begin
    {$ifOpt D+}
    Assert(Assigned(_LAIR_));
    {$endIf}
    result:=tCopyRAST_srcTree_4Handler_CNFGsNode(_LAIR_.Items[Index]);
end;

procedure tCopyRAST_srcTree_4Handler_CNFGsLAIR._item_SET_(Index:Integer; value:tCopyRAST_srcTree_4Handler_CNFGsNode);
begin
    {$ifOpt D+}
    Assert(Assigned(_LAIR_));
    Assert(Assigned( value));
    {$endIf}
   _LAIR_.Items[Index]:=value;
end;

function tCopyRAST_srcTree_4Handler_CNFGsLAIR._item_ADD_(value:tCopyRAST_srcTree_4Handler_CNFGsNode):integer;
begin
    {$ifOpt D+}
    Assert(Assigned(_LAIR_));
    Assert(Assigned( value));
    {$endIf}
    result:=_LAIR_.Add(value);
end;

//------------------------------------------------------------------------------

function tCopyRAST_srcTree_4Handler_CNFGsLAIR.Add(const item:tCopyRAST_srcTree_4Handler_CNFGsNode):integer;
begin
    result:=_item_ADD_(item);
end;

function tCopyRAST_srcTree_4Handler_CNFGsLAIR.IndexOf(const item:tCopyRAST_srcTree_4Handler_CNFGsNode):Integer;
begin
    result:=_LAIR_.IndexOf(item);
end;

procedure tCopyRAST_srcTree_4Handler_CNFGsLAIR.Delete(const indx:integer);
begin
   _LAIR_.Delete(indx);
end;

//------------------------------------------------------------------------------


procedure tCopyRAST_srcTree_4Handler_CNFGsLAIR.CLEAR(const withOutData:boolean=false);
var i:integer;
begin
    if withOutData then begin
       _LAIR_.OwnsObjects:=FALSE;
       _LAIR_.Clear;
       _LAIR_.OwnsObjects:=TRUE;
    end
    else begin
       _LAIR_.Clear;
    end;
end;

procedure tCopyRAST_srcTree_4Handler_CNFGsLAIR.COPY(const Source:tCopyRAST_srcTree_4Handler_CNFGsNode);
var i:integer;
  tmp:tCopyRAST_srcTree_4Handler_CNFGsNode;
begin
    {$ifOpt D+}
    Assert(Assigned(_LAIR_));
    Assert(Assigned(Source));
    Assert(Source is tCopyRAST_srcTree_4Handler_CNFGsLAIR);
    {$endIf}
   _LAIR_.Clear;
    for i:=0 to tCopyRAST_srcTree_4Handler_CNFGsLAIR(Source)._LAIR_CNT_-1 do begin
        tmp:=tCopyRAST_srcTree_4Handler_CNFGsLAIR(Source)._item_GET_(i);
        tmp:=tCopyRAST_srcTree_4Handler_CNFGsNode(tmp.ClassType.Create);
        tmp.COPY(tCopyRAST_srcTree_4Handler_CNFGsLAIR(Source)._item_GET_(i));
       _item_ADD_(tmp);
    end;
end;

//==============================================================================

constructor tCopyRAST_srcTree_4Handler_CNFGs.Create;
begin
   _LIST_:=TStringList.Create;
   _LIST_.Sorted:=TRUE;
end;

destructor tCopyRAST_srcTree_4Handler_CNFGs.DESTROY;
begin
   _LIST_CLR_;
   _LIST_.Free;
end;

//------------------------------------------------------------------------------

function tCopyRAST_srcTree_4Handler_CNFGs._LIST_CNT_:integer;
begin
    result:=_LIST_.Count;
end;

procedure tCopyRAST_srcTree_4Handler_CNFGs._LIST_CLR_;
var i:integer;
begin
    {$ifOpt D+}
    Assert(Assigned(_LIST_));
    {$endIf}
    for i:=0 to _LIST_.Count-1 do begin
       _LIST_.Objects[i].FREE;
    end;
   _LIST_.Clear;
end;

//------------------------------------------------------------------------------

procedure tCopyRAST_srcTree_4Handler_CNFGs.CNFGS_Item(const index:integer; out Path:string; out Item:tCopyRAST_srcTree_4Handler_CNFGsNode);
begin
    Path:=_LIST_.Strings[index];
    Item:=tCopyRAST_srcTree_4Handler_CNFGsNode(_LIST_.Objects[index]);
end;

procedure tCopyRAST_srcTree_4Handler_CNFGs.CNFGS_Add(out index:integer; const Path:string; const Item:tCopyRAST_srcTree_4Handler_CNFGsNode);
begin
    index:=_LIST_.AddObject(Path,Item);
end;

procedure tCopyRAST_srcTree_4Handler_CNFGs.CNFGS_Add(const Path:string; const Item:tCopyRAST_srcTree_4Handler_CNFGsNode);
begin
   _LIST_.AddObject(Path,Item);
end;

//------------------------------------------------------------------------------

{$ifOpt D+}
function tCopyRAST_srcTree_4Handler_CNFGs._CNFG_CRT_:tCopyRAST_srcTree_4Handler_CNFGsNode;
begin
   result:=tCopyRAST_srcTree_4Handler_CNFGsNode.Create;
end;
{$endIf}

procedure tCopyRAST_srcTree_4Handler_CNFGs.CNFG_GET(const path:string; out Item:tObject);
var i:integer;
begin
    Item:=_CNFG_CRT_;
    if _LIST_.Find(path,i) then begin
        tCopyRAST_srcTree_4Handler_CNFGsNode(Item).COPY(tCopyRAST_srcTree_4Handler_CNFGsNode(_LIST_.Objects[i]));
    end
end;

function tCopyRAST_srcTree_4Handler_CNFGs.CNFGS_GET(const path:string):tCopyRAST_srcTree_4Handler_CNFGsLAIR;
var i:integer;
begin
    result:=nil;
    if _LIST_.Find(path,i) then begin
        result:=tCopyRAST_srcTree_4Handler_CNFGsLAIR(_LIST_.Objects[i])
    end
end;

function tCopyRAST_srcTree_4Handler_CNFGs.CNFG_GET(const path:string):tObject;
var i:integer;
begin
    result:=_CNFG_CRT_;
    if _LIST_.Find(path,i) then begin
        tCopyRAST_srcTree_4Handler_CNFGsNode(result).COPY(tCopyRAST_srcTree_4Handler_CNFGsNode(_LIST_.Objects[i]));
    end
end;

procedure tCopyRAST_srcTree_4Handler_CNFGs.CNFG_SET(const path:string; const Item:tCopyRAST_srcTree_4Handler_CNFGsNode);
var i:integer;
begin
    if _LIST_.Find(path,i) then begin
        if Item.needSAVE
        then begin
            tCopyRAST_srcTree_4Handler_CNFGsNode(_LIST_.Objects[i]).COPY(Item);
        end
        else begin
           _LIST_.Objects[i].FREE;
           _LIST_.Delete(i);
        end;
    end
    else begin
        if Item.needSAVE then begin
            i:=_LIST_.AddObject(path,_CNFG_CRT_);
            tCopyRAST_srcTree_4Handler_CNFGsNode(_LIST_.Objects[i]).COPY(Item);
        end;
    end;
end;

end.

