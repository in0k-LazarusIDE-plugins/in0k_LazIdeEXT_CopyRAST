unit in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs_CNFGs;

{$mode objfpc}{$H+}

interface

uses
  CopyRAST_srcTree_4Handler_CNFGs,

  contnrs,
  Classes, SysUtils;

type //=========================================================================

 tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node=class(tCopyRAST_srcTree_4Handler_CNFGsNode)
  protected
   _nameStated_:string;
   _pathStated_:string;
   _nameCustom_:boolean;
   _pathCustom_:boolean;
  public
    property NameCustom:boolean read _nameCustom_ write _nameCustom_;
    property NameStated:string  read _nameStated_ write _nameStated_;
    property PathCustom:boolean read _pathCustom_ write _pathCustom_;
    property PathStated:string  read _pathStated_ write _pathStated_;
  public
    constructor Create;
    destructor DESTROY; override;
  public
    procedure COPY(const Source:tCopyRAST_srcTree_4Handler_CNFGsNode); override;
    function needSAVE:boolean;                                         override;
  end;

 tCopyRAST_HandlerCNFGs_ReNAMEs_customer_LAER=class(tCopyRAST_srcTree_4Handler_CNFGs)
  protected
    function _CNFG_CRT_:tCopyRAST_srcTree_4Handler_CNFGsNode; override;
  end;

type //=========================================================================

 tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule=class(tCopyRAST_srcTree_4Handler_CNFGsNode)
  protected
   _prntITEM_:tObject; //< это с родительского
    function _isInherited_MARK_:boolean;
    function _isInherited_RULE_:boolean;
  protected
   _template_:string;
   _exchange_:string;
   _ruleUSED_:boolean;
  public
    property Template:string  read _template_ write _template_;
    property Exchange:string  read _exchange_ write _exchange_;
    property Enabled :boolean read _ruleUSED_ write _ruleUSED_;
  public
    constructor Create(const ParentItem:tObject=nil);
    destructor DESTROY; override;
  public
    property isInherited_MARK:boolean read _isInherited_MARK_;
    property isInherited_RULE:boolean read _isInherited_RULE_;
  public
    procedure COPY(const Source:tCopyRAST_srcTree_4Handler_CNFGsNode); override;
    function needSAVE:boolean;                                         override;
  end;

 tCopyRAST_HandlerCNFGs_ReNAMEs_template_prnt=class(tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule)
  public
   constructor Create;
  end;



 tCopyRAST_HandlerCNFGs_ReNAMEs_template_List=class(tCopyRAST_srcTree_4Handler_CNFGsLAIR)
  protected
   _usePrntRules_:boolean;
  protected
    function  _item_GET_(Index:Integer):tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
    procedure _item_SET_(Index:Integer; value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule);
  protected
    procedure AddAsParent(const parent:tObject; const list:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
  public
    property Items[Index:integer]:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule read _item_GET_ write _item_SET_;
    function needSAVE:boolean; override;
  public
    constructor Create;
  public
    property PrntRules_USE:boolean read _usePrntRules_ write _usePrntRules_;
    function PrntRules_MarkPRESENT:boolean;
  end;

 tCopyRAST_HandlerCNFGs_ReNAMEs_template_LAIR=class(tCopyRAST_srcTree_4Handler_CNFGs)
  protected
    function _CNFG_CRT_:tCopyRAST_srcTree_4Handler_CNFGsNode; override;
  public
    function CNFGS_GET(const path:string):tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
  end;

implementation

{%region --- customer ---------------------------------------------------}

constructor tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node.Create;
begin
   _nameCustom_:=false;
   _nameStated_:='';
   _pathCustom_:=false;
   _pathStated_:='';
end;

destructor tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node.DESTROY;
begin
    inherited;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node.COPY(const Source:tCopyRAST_srcTree_4Handler_CNFGsNode);
begin
    {$ifOpt D+}
    Assert(Assigned(Source));
    Assert(Source is tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node);
    {$endIf}
   _nameCustom_:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node(Source).NameCustom;
   _nameStated_:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node(Source).NameStated;
   _pathCustom_:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node(Source).PathCustom;
   _pathStated_:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node(Source).PathStated;
end;

function tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node.needSAVE:boolean;
begin
    result:= NOT // ОТРИЦАЕМ состояние "НУЛИВОВГО состояния" (не заданного)
             (
                (_nameStated_='')and(_nameCustom_=false)
                AND
                (_pathStated_='')and(_pathCustom_=false)
             );
end;

//==============================================================================

function tCopyRAST_HandlerCNFGs_ReNAMEs_customer_LAER._CNFG_CRT_:tCopyRAST_srcTree_4Handler_CNFGsNode;
begin
    result:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node.Create;
end;

{%endregion}

{%region --- template ---------------------------------------------------}

constructor tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule.Create(const ParentItem:tObject=nil);
begin
   _template_:='';
   _exchange_:='';
   _prntITEM_:=ParentItem;
   _ruleUSED_:=TRUE;
end;

destructor tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule.DESTROY;
begin
    inherited;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule.COPY(const Source:tCopyRAST_srcTree_4Handler_CNFGsNode);
begin
    {$ifOpt D+}
    Assert(Assigned(Source));
    Assert(Source is tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule);
    {$endIf}
   _template_:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(Source).Template;
   _exchange_:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(Source).Exchange;
end;

function tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule.needSAVE:boolean;
begin
    result:=((_template_<>'')or(_exchange_<>''))and(not Assigned(_prntITEM_));
end;

//------------------------------------------------------------------------------

function tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule._isInherited_MARK_:boolean;
begin
    result:=Assigned(_prntITEM_)and(_prntITEM_=self);
end;

function tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule._isInherited_RULE_:boolean;
begin
    result:=Assigned(_prntITEM_)and(_prntITEM_<>self);
end;

//==============================================================================

constructor tCopyRAST_HandlerCNFGs_ReNAMEs_template_prnt.Create;
begin
    inherited Create;
   _prntITEM_:=self;
end;

//==============================================================================

constructor tCopyRAST_HandlerCNFGs_ReNAMEs_template_List.Create;
begin
    inherited;
   _usePrntRules_:=TRUE;
end;

//------------------------------------------------------------------------------

function tCopyRAST_HandlerCNFGs_ReNAMEs_template_List._item_GET_(Index:Integer):tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    result:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule(inherited _item_GET_(Index));
end;

procedure tCopyRAST_HandlerCNFGs_ReNAMEs_template_List._item_SET_(Index:Integer; value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule);
begin
    inherited _item_SET_(Index,value);
end;

//------------------------------------------------------------------------------

function tCopyRAST_HandlerCNFGs_ReNAMEs_template_List.needSAVE:boolean;
var i:integer;
  tmp:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    result:=false;
    for i:=0 to _LAIR_CNT_-1 do begin
        if Items[i].needSAVE then begin
            result:=true;
            Break;
        end;
    end;
end;

function tCopyRAST_HandlerCNFGs_ReNAMEs_template_List.PrntRules_MarkPRESENT:boolean;
var i:integer;
begin
    result:=false;
    for i:=0 to _LAIR_CNT_-1 do begin
        if Items[i].isInherited_MARK then begin
            result:=true;
            break;
        end;
    end;
end;

//------------------------------------------------------------------------------

procedure tCopyRAST_HandlerCNFGs_ReNAMEs_template_List.AddAsParent(const parent:tObject; const list:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
var i:integer;
  tmp:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    for i:=0 to list.Count-1 do begin
        tmp:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule.Create;
        tmp.COPY(list.Items[i]);
        tmp._prntITEM_:=parent;
       _item_ADD_(tmp);
    end;
end;

//==============================================================================

function tCopyRAST_HandlerCNFGs_ReNAMEs_template_LAIR._CNFG_CRT_:tCopyRAST_srcTree_4Handler_CNFGsNode;
begin
    result:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_List.Create;
end;

//------------------------------------------------------------------------------

function tCopyRAST_HandlerCNFGs_ReNAMEs_template_LAIR.CNFGS_GET(const path:string):tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
begin
    result:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_List(inherited CNFGS_GET(path));
end;

{%endregion}

end.

