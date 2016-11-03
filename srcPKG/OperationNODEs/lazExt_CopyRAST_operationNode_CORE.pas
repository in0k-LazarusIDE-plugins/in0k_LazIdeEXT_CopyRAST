unit lazExt_CopyRAST_operationNode_CORE;

{$mode objfpc}{$H+}

interface

//uses lazExt_CopyRAST_node, lazExt_CopyRAST_node_ROOT;

type


  tCopyRast_counter=LongWord;


  tOprNodeEXECUTOR=class;


  tCopyRAST_node=class
   end;
  tOperationNode_CORE=class;
  tOperationNode_TYPE=class of tOperationNode_CORE;

  tOperationNode_CORE=class
  private
   _OWNER_:tOprNodeEXECUTOR;
   _PARNT_:tOperationNode_CORE;
   _eNODE_:tCopyRAST_node;
  protected
    procedure doEvent_onEDT(const message:string);
    procedure doEvent_onERR(const message:string);
    procedure EXECUTE_4TREE(const t_eItem:tOperationNode_TYPE);
    procedure EXECUTE_4NODE(const t_eItem:tOperationNode_TYPE);
  public
    property  node4Execut:tCopyRAST_node read _eNODE_;
    function  Is_Possible(const Node:tCopyRAST_node):boolean; virtual;
    function  doOperation:boolean;                            virtual;
  public
    constructor Create(const Owner:tOprNodeEXECUTOR; const Parent:tOperationNode_CORE);
  end;


  tOprNodeEXECUTOR=class
   private
    _cnt_exec_:LongWord;
    _cnt_edit_:LongWord;
    _err_TEXT_:string;
     procedure _CNTs_CLN_;


   private
     function  _create_OprNode_(const nodeType:tOperationNode_TYPE; const Parent:tOperationNode_CORE):tOperationNode_CORE;
   private
     procedure _doEvent_onEDT_(const Oprt:tOperationNode_CORE; const node:tCopyRAST_node; const MSG:string);
     procedure _doEvent_onERR_(const Oprt:tOperationNode_CORE; const node:tCopyRAST_node; const MSG:string);
   private

     //procedure _EXECUTE_NODE_ (const OprN:tOperationNode_CORE; treN);
   private
     function  _EXECUTE_wasER_:boolean;
     function  _EXECUTE__NODE_(const eItem:tOperationNode_CORE; const eNode:tCopyRAST_node):boolean;
     function  _EXECUTE_4NODE_(const ePRNT:tOperationNode_CORE; const t_eItem:tOperationNode_TYPE; const eNode:tCopyRAST_node):boolean;
     function  _EXECUTE_4TREE_(const ePRNT:tOperationNode_CORE; const t_eItem:tOperationNode_TYPE):boolean;
   public
     constructor Create;
   end;




implementation

constructor tOperationNode_CORE.Create(const Owner:tOprNodeEXECUTOR; const Parent:tOperationNode_CORE);
begin
   _OWNER_:=Owner;
   _PARNT_:=Parent;
   _eNODE_:=NIL;
end;

//------------------------------------------------------------------------------

procedure tOperationNode_CORE.doEvent_onEDT(const message:string);
begin
   _OWNER_._doEvent_onEDT_(self,_eNODE_,message);
end;

procedure tOperationNode_CORE.doEvent_onERR(const message:string);
begin
   _OWNER_._doEvent_onERR_(self,_eNODE_,message);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tOperationNode_CORE.EXECUTE_4NODE(const t_eItem:tOperationNode_TYPE);
begin
    _OWNER_._EXECUTE__NODE_(t_eItem,_eNODE_);
end;

procedure tOperationNode_CORE.EXECUTE_4TREE(const t_eItem:tOperationNode_TYPE);
begin
    _OWNER_._EXECUTE_4TREE_(t_eItem);
end;

//------------------------------------------------------------------------------

function tOperationNode_CORE.Is_Possible(const Node:tCopyRAST_node):boolean;
begin
    result:=FALSE;//NOT is_ExecNode(node); //< типа автоматом ИСКЛЮЧАЕМ самоВызов
end;

function tOperationNode_CORE.doOperation:boolean;
begin
    result:=TRUE;
end;

//------------------------------------------------------------------------------
//==============================================================================


constructor tOprNodeEXECUTOR.Create;
begin
   _CNTs_CLN_
end;

function tOprNodeEXECUTOR._create_OprNode_(const nodeType:tOperationNode_TYPE; const Parent:tOperationNode_CORE):tOperationNode_CORE;
begin
    result:=nodeType.Create(self,Parent);
    //---
    //result.
end;

//------------------------------------------------------------------------------

procedure tOprNodeEXECUTOR._CNTs_CLN_;
begin
   _cnt_exec_:=0;
   _cnt_edit_:=0;
end;

//------------------------------------------------------------------------------

procedure tOprNodeEXECUTOR._doEvent_onEDT_(const Oprt:tOperationNode_CORE; const node:tCopyRAST_node; const MSG:string);
begin
    inc(_cnt_edit_);
    {todo: запись в динЛог}
    {todo: запись в txtЛог}
end;

procedure tOprNodeEXECUTOR._doEvent_onERR_(const Oprt:tOperationNode_CORE; const node:tCopyRAST_node; const MSG:string);
begin
   _err_TEXT_:=MSG;
    {todo: запись в динЛог}
    {todo: запись в txtЛог}
end;

//------------------------------------------------------------------------------

function tOprNodeEXECUTOR._EXECUTE_wasER_:boolean;
begin
    result:=_err_TEXT_<>'';
end;

// выполняем операцию для ЕДИНСТВЕННОГО "узла информации"
function tOprNodeEXECUTOR._EXECUTE__NODE_(const eItem:tOperationNode_CORE; const eNode:tCopyRAST_node):boolean;
begin
    result:=true;
    //---
    if not eItem.Is_Possible(eNode) then EXIT;
    inc(_cnt_exec_);
    eItem._eNODE_:=eNode;
    result:=eItem.doOperation;
end;

function _EXECUTE_4NODE_(const ePRNT:tOperationNode_CORE; const t_eItem:tOperationNode_TYPE; const eNode:tCopyRAST_node):boolean;
var item:tOperationNode_CORE;
begin
    item:=t_eItem.Create(self,ePRNT);
    result:=_EXECUTE__NODE_(item,eNode);
    item.FREE;
end;


function _EXECUTE_4TREE_(const ePRNT:tOperationNode_CORE; const t_eItem:tOperationNode_TYPE):boolean;
var item:tOperationNode_CORE;
begin
    item:=t_eItem.Create(self,ePRNT);
    //---
    //тут обход ДЕРЕВА в рекурсии result:=_EXECUTE__NODE_(item,eNode);
    //---
    item.FREE;
end;


{procedure tOprNodeEXECUTOR._EXECUTE_forTREE_(const OprN:tOperationNode_TYPE);
begin

end;

procedure tOprNodeEXECUTOR._EXECUTE_forNODE_(const OprN:tOperationNode_TYPE);
begin

end; }

end.

