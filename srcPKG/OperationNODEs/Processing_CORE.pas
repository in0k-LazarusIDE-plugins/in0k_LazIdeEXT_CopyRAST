unit Processing_CORE;

{$mode objfpc}{$H+}

interface

{$define _DEBUG_}

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.

uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}in0k_lazIdeSRC_DEBUG,{$endIf}
     sysutils,
     lazExt_CopyRAST_node,
     lazExt_CopyRAST_node_ROOT,
     lazExt_CopyRAST_Node2TEXTs;// lazExt_CopyRAST_node, lazExt_CopyRAST_node_ROOT;

type


  tCopyRast_counter=LongWord;
  tOprNodeEXECUTOR=class;

  //tCopyRAST_node=class
  // end;
  tOperationNode_CORE=class;
  tOperationNode_TYPE=class of tOperationNode_CORE;

 tOperationNode_CORE=class
  private
   _OWNER_:tOprNodeEXECUTOR;
   _PARNT_:tOperationNode_CORE;
   _eNODE_:tCopyRAST_node;
    function _get_toolHigher_:tOperationNode_CORE;
    function _get_rootHigher_:tCopyRAST_ROOT;
  protected
    procedure doEvent_onNoNeed(const message:string);
    procedure doEvent_onPASSED(const message:string);
    procedure doEvent_on_ERROR(const message:string);
  protected
    function EXECUTE_4TREE(const t_eItem:tOperationNode_TYPE):boolean;
    function EXECUTE_4NODE(const t_eItem:tOperationNode_TYPE):boolean;
  public
    property  Tool_Higher:tOperationNode_CORE read _get_toolHigher_;
    property  Tool_Parent:tOperationNode_CORE read _PARNT_;
    property  node4Execut:tCopyRAST_node read _eNODE_;
    function  Is_Possible:boolean; virtual;
    function  doOperation:boolean; virtual;
  public
    constructor Create(const Owner:tOprNodeEXECUTOR; const Parent:tOperationNode_CORE);
  end;


  tOprNodeEXECUTOR=class
   private
    _all_tryEXE_:LongWord; //< кол-во Попыток запуска
    _cnt_ERRORs_:LongWord; //< кол-во Реально запущеных
    _cnt_actual_:LongWord; //< кол-во Реально запущеных
    _cnt_MISSED_:LongWord; //< кол-во ПРОПУЩЕНЫХ
    _cnt_PASSED_:LongWord; //< кол-во Выполненных
    _cnt_NoNeed_:LongWord; //< кол-во УЖЕ сделаных ранее
    _err_TEXT_:string;
     procedure _CNTs_CLN_;
   private
     function  _create_OprNode_(const nodeType:tOperationNode_TYPE; const Parent:tOperationNode_CORE):tOperationNode_CORE;
   private
    _time_:QWord;
   private
    _doLog_onMISSED_:boolean;
    _doLog_onNoNeed_:boolean;
   private
     procedure _doEvent_onMISSED_(const Oprt:tOperationNode_CORE; const node:tCopyRAST_node);
     procedure _doEvent_onNoNeed_(const Oprt:tOperationNode_CORE; const node:tCopyRAST_node; const MSG:string);
     procedure _doEvent_onPASSED_(const Oprt:tOperationNode_CORE; const node:tCopyRAST_node; const MSG:string);
     procedure _doEvent_on_ERROR_(const Oprt:tOperationNode_CORE; const node:tCopyRAST_node; const MSG:string);
   private
    _nodeRoot_:tCopyRAST_ROOT;
   private
     function  _EXECUTE_wasER_:boolean;
     function  _EXECUTE__NODE_(const eItem:tOperationNode_CORE; const eNode:tCopyRAST_node):boolean;
     function  _EXECUTE_4NODE_(const ePRNT:tOperationNode_CORE; const t_eItem:tOperationNode_TYPE; const eNode:tCopyRAST_node):boolean;
     function  _EXECUTE__TREE_(const eItem:tOperationNode_CORE; const eNode:tCopyRAST_node):boolean;
     function  _EXECUTE_4TREE_(const ePRNT:tOperationNode_CORE; const t_eItem:tOperationNode_TYPE):boolean;
   protected
     procedure _make_log_Start_;
     procedure _make_log_onEND_;
     procedure _EXECUTE_(const eItem:tOperationNode_TYPE);
   public
     constructor Create(const nodeRoot:tCopyRAST_ROOT);
   public
     //procedure EXECUTE; virtual;//(const eItem:tOperationNode_TYPE):boolean;
   end;


//  machining
//  the
//  processing node
//  prcNode
//  prcMCHN
//
//  handler
//  processor

implementation

// @prm Owner  владелец обработчик
// @prm Parent выше стоящий УЗЕЛ обработки
constructor tOperationNode_CORE.Create(const Owner:tOprNodeEXECUTOR; const Parent:tOperationNode_CORE);
begin
   _OWNER_:=Owner;
   _PARNT_:=Parent;
   _eNODE_:=NIL;
end;

//------------------------------------------------------------------------------

function tOperationNode_CORE._get_toolHigher_:tOperationNode_CORE;
begin
    result:=self;
    while Assigned(result._PARNT_) do result:=result._PARNT_;
end;

function tOperationNode_CORE._get_rootHigher_:tCopyRAST_ROOT;
var tmp:tCopyRAST_node;
begin
    result:=nil;
    tmp:=_eNODE_;
    while (Assigned(tmp))and(not (tmp is tCopyRAST_ROOT)) do tmp:=tmp.NodePRNT;
end;

//------------------------------------------------------------------------------

// вызвать при УСПЕШНОМ редактировании
procedure tOperationNode_CORE.doEvent_onPASSED(const message:string);
begin
   _OWNER_._doEvent_onPASSED_(self,_eNODE_,message);
end;

// вызвать при УЖЕ сделано
procedure tOperationNode_CORE.doEvent_onNoNeed(const message:string);
begin
   _OWNER_._doEvent_onNoNeed_(self,_eNODE_,message);
end;

// вызвать при ВОЗНИКНОВЕНИИ ошибки
procedure tOperationNode_CORE.doEvent_on_ERROR(const message:string);
begin
   _OWNER_._doEvent_on_ERROR_(self,_eNODE_,message);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// запустить выполнение для ТЕКУЩЕГО узла
function tOperationNode_CORE.EXECUTE_4NODE(const t_eItem:tOperationNode_TYPE):boolean;
begin
    result:=_OWNER_._EXECUTE_4NODE_(self,t_eItem,_eNODE_);
end;

// запустить выполнение для ВСЕГО дерева
function tOperationNode_CORE.EXECUTE_4TREE(const t_eItem:tOperationNode_TYPE):boolean;
begin
    result:=_OWNER_._EXECUTE_4TREE_(self,t_eItem);
end;

//------------------------------------------------------------------------------

// проверить, возможна ли (выполнима ли) операция для узла
function tOperationNode_CORE.Is_Possible:boolean;
begin
    result:=FALSE;
    {$ifdef _DEBUG_}DEBUG(Self.ClassName+'.Is_Possible='+BoolToStr(result,' true','false')+' for '+CopyRastNode2TEXTs(node4Execut));{$endIf}
end;

// выполнить операцию над текущим узлом
function tOperationNode_CORE.doOperation:boolean;
begin
    result:=TRUE;
    {$ifdef _DEBUG_}DEBUG(Self.ClassName+'.doOperation='+BoolToStr(result,' true','false')+' for '+CopyRastNode2TEXTs(node4Execut));{$endIf}
end;

//------------------------------------------------------------------------------
//==============================================================================

constructor tOprNodeEXECUTOR.Create(const nodeRoot:tCopyRAST_ROOT);
begin
   _nodeRoot_:=nodeRoot;
   _doLog_onMISSED_:=false;
   _doLog_onNoNeed_:=false;
   _CNTs_CLN_;
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
   _cnt_ERRORs_:=0;
   _all_tryEXE_:=0;
   _cnt_actual_:=0;
   _cnt_MISSED_:=0;
   _cnt_PASSED_:=0;
   _cnt_NoNeed_:=0;
end;

//------------------------------------------------------------------------------

const
  _c_onEvent_TXT_passed_='Passed';
  _c_onEvent_TXT_noNeed_='noNeed';
  _c_onEvent_TXT_missed_='missed';
  _c_onEvent_TXT__Error_='ERROR!';

procedure tOprNodeEXECUTOR._doEvent_onMISSED_(const Oprt:tOperationNode_CORE; const node:tCopyRAST_node);
begin
    inc(_cnt_MISSED_);
    if _doLog_onMISSED_ then begin
        {$ifdef _DEBUG_}DEBUG(_c_onEvent_TXT_missed_,' ['+Self.ClassName+'.Is_Possible='+BoolToStr(FALSE,' true','false')+' for '+CopyRastNode2TEXTs(node)+']');{$endIf}
        {todo: запись в txtЛог}
	end;
end;

procedure tOprNodeEXECUTOR._doEvent_onNoNeed_(const Oprt:tOperationNode_CORE; const node:tCopyRAST_node; const MSG:string);
begin
    inc(_cnt_NoNeed_);
    if _doLog_onNoNeed_ then begin
        {$ifdef _DEBUG_}DEBUG(_c_onEvent_TXT_noNeed_,MSG+' ['+Oprt.ClassName+' for '+CopyRastNode2TEXTs(node)+']');{$endIf}
        {todo: запись в txtЛог}
	end;
end;

procedure tOprNodeEXECUTOR._doEvent_onPASSED_(const Oprt:tOperationNode_CORE; const node:tCopyRAST_node; const MSG:string);
begin
    inc(_cnt_PASSED_);
    {$ifdef _DEBUG_}DEBUG(_c_onEvent_TXT_passed_,MSG+' ['+Oprt.ClassName+' for '+CopyRastNode2TEXTs(node)+']');{$endIf}
    {todo: запись в txtЛог}
    ApplicationName;
end;

procedure tOprNodeEXECUTOR._doEvent_on_ERROR_(const Oprt:tOperationNode_CORE; const node:tCopyRAST_node; const MSG:string);
begin
    inc(_cnt_ERRORs_);
   _err_TEXT_:=MSG;
    {$ifdef _DEBUG_}DEBUG(_c_onEvent_TXT__Error_,MSG+' ['+Oprt.ClassName+' for '+CopyRastNode2TEXTs(node)+']');{$endIf}
    {todo: запись в txtЛог}
end;

//------------------------------------------------------------------------------

function tOprNodeEXECUTOR._EXECUTE_wasER_:boolean;
begin
    result:=_err_TEXT_<>'';
end;

//------------------------------------------------------------------------------

// выполняем операцию для ЕДИНСТВЕННОГО "узла информации"
// @ret false дальнейшее выполнение прекратить
function tOprNodeEXECUTOR._EXECUTE__NODE_(const eItem:tOperationNode_CORE; const eNode:tCopyRAST_node):boolean;
begin
    inc(_all_tryEXE_);
    result:=true;
    //---
    eItem._eNODE_:=eNode;
    if not eItem.Is_Possible then _doEvent_onMISSED_(eItem,eNode)
    else begin
        inc(_cnt_actual_);
        result:=eItem.doOperation;
    end;
end;

function tOprNodeEXECUTOR._EXECUTE_4NODE_(const ePRNT:tOperationNode_CORE; const t_eItem:tOperationNode_TYPE; const eNode:tCopyRAST_node):boolean;
var item:tOperationNode_CORE;
begin
    item:=t_eItem.Create(self,ePRNT);
    result:=_EXECUTE__NODE_(item,eNode);
    item.FREE;
end;

//------------------------------------------------------------------------------

function  tOprNodeEXECUTOR._EXECUTE__TREE_(const eItem:tOperationNode_CORE; const eNode:tCopyRAST_node):boolean;
var tmp:tCopyRAST_node;
begin // глупо и тупо рекурсией
    result:=_EXECUTE__NODE_(eItem,eNode);
    //--- пошли по детям
    tmp:=eNode.NodeCHLD;
    while Assigned(tmp) do begin
        //result:=_EXECUTE__TREE_(eItem,tmp) AND result;
        result:=_EXECUTE__TREE_(eItem,tmp);
        if not result then BREAK;
        tmp:=tmp.NodeNEXT;
    end;
end;

function tOprNodeEXECUTOR._EXECUTE_4TREE_(const ePRNT:tOperationNode_CORE; const t_eItem:tOperationNode_TYPE):boolean;
var item:tOperationNode_CORE;
begin
    item:=t_eItem.Create(self,ePRNT);
    //---
    //тут обход ДЕРЕВА в рекурсии
    result:=_EXECUTE__TREE_(item,_nodeRoot_);
    //---
    item.FREE;
end;

//------------------------------------------------------------------------------

procedure tOprNodeEXECUTOR._EXECUTE_(const eItem:tOperationNode_TYPE);
begin
   _EXECUTE_4TREE_(nil,eItem);
end;

//------------------------------------------------------------------------------

procedure tOprNodeEXECUTOR._make_log_Start_;
begin
   _CNTs_CLN_;
    {$ifdef _DEBUG_}DEBUG('CopyRAST START',DateTimeToStr(NOW));{$endIf}
   _time_:=GetTickCount64;
end;

procedure tOprNodeEXECUTOR._make_log_onEND_;
begin
   _time_:=GetTickCount64-_time_;
    //---
    {$ifdef _DEBUG_}DEBUG('CopyRAST  STOP',DateTimeToStr(NOW)+' running time: '+inttostr(round(_time_/1000)));{$endIf}
    //---
    {$ifdef _DEBUG_}DEBUG('tryEXE: '+inttostr(_all_tryEXE_));{$endIf}
    {$ifdef _DEBUG_}DEBUG(_c_onEvent_TXT_missed_+': '+inttostr(_cnt_MISSED_));{$endIf}
    {$ifdef _DEBUG_}DEBUG(_c_onEvent_TXT_noNeed_+': '+inttostr(_cnt_NoNeed_));{$endIf}
    {$ifdef _DEBUG_}DEBUG(_c_onEvent_TXT_passed_+': '+inttostr(_cnt_PASSED_));{$endIf}
    {$ifdef _DEBUG_}DEBUG(_c_onEvent_TXT__Error_+': '+inttostr(_cnt_ERRORs_));{$endIf}
    //---
    if _err_TEXT_<>'' then begin
        {$ifdef _DEBUG_}DEBUG('last ERR text: '+_err_TEXT_);{$endIf}
    end;
    //---
end;

//------------------------------------------------------------------------------



end.

