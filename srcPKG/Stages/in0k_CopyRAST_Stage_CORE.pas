unit in0k_CopyRAST_Stage_CORE;

{$mode objfpc}{$H+}

interface

{$ifDef CopyRAST_DEBUG}
    {$define _local_DEBUG_}
{$endIf}

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  lazExt_CopyRAST__xmlConfig,
  srcTree_handler4build_CORE,
  srcTree_builder_CORE,
  //---
  in0k_CopyRAST_srcTree_ITEMs;


type

 tCopyRast_SrcTree_itmSTAGE=class(tSrcTree_itmHandler4Build)
  protected
    function ROOT_Source:tCopyRast_stROOT; {$ifOpt D-}inline;{$endIf}
    function ROOT_Target:tCopyRast_stROOT; {$ifOpt D-}inline;{$endIf}
  end;


type

 tCopyRast_SrcTree_prcSTAGE=class;
 tCopyRast_SrcTree_STAGE_CORE=class;

 mCopyRast_STAGE_onRootChange=procedure(const Sender:tCopyRast_SrcTree_STAGE_CORE; const newRoot:tCopyRast_stROOT) of object;


{ tCopyRast_SrcTree_STAGE_00_CORE=class
  protected
   _creater_:tSrcTree_Creater_TYPE;
  protected
    constructor Create(const BUILDer:tSrcTree_Builder_CORE); override;
  public
    constructor Create(const BUILDer:tSrcTree_Builder_CORE; const Creater_TYPE:tSrcTree_Creater_TYPE);


  end;   }





 tCopyRast_SrcTree_prcSTAGE=class(tCopyRast_SrcTree_STAGE_CORE)
  protected //< что хотим получить
   _rootResult_:tCopyRast_stROOT;
   _rootResult_mOnCHANGE_:mCopyRast_STAGE_onRootChange;
    procedure _rootResult_CLR_; virtual;                      {$ifOpt D-}inline;{$endIf}
    procedure _rootResult_SET_(const value:tCopyRast_stROOT); {$ifOpt D-}inline;{$endIf}
  protected //< с Чего начинаем
   _rootSource_:tCopyRast_stROOT;
   _rootSource_mOnCHANGE_:mCopyRast_STAGE_onRootChange;
    procedure _rootSource_CLR_; virtual;                      {$ifOpt D-}inline;{$endIf}
    procedure _rootSource_SET_(const value:tCopyRast_stROOT); {$ifOpt D-}inline;{$endIf}
  protected // работа с Конфигурацией
    procedure _CNFGs_FREE_;                                        virtual;
    procedure _CNFGs_CREATE_;                                      virtual;
    procedure _CNFGs_LOAD_(const Configs:tLazExt_CopyRAST_CONFIG); virtual;
    procedure _CNFGs_SAVE_(const Configs:tLazExt_CopyRAST_CONFIG); virtual;
  public    // работа с Конфигурацией
    procedure  CNFGs_LOAD (const Configs:tLazExt_CopyRAST_CONFIG);
    procedure  CNFGs_SAVE (const Configs:tLazExt_CopyRAST_CONFIG);


  protected
    //source
    //result

   _BUILDer_:tSrcTree_Builder_CORE;
  protected
  strict private
  protected
    function  _targetROOT_GET_:tCopyRast_stROOT;              {$ifOpt D-}inline;{$endIf}
    function  _sourceROOT_GET_:tCopyRast_stROOT;              {$ifOpt D-}inline;{$endIf}
  strict private
    //function  _targetROOT_NEW_Root(const src:tCopyRast_stROOT):tCopyRast_stROOT;
    //function  _targetROOT_NEW_Base(const src:tCopyRast_stITEM):tCopyRast_stBASE;
    //function  _targetROOT_NEW_Main(const src:tCopyRast_stITEM):tCopyRast_stMAIN;
  private
    procedure _targetROOT_NEW_(const srcRoot:tCopyRast_stITEM);
  public
    property  ROOT_Source         :tCopyRast_stROOT read _sourceROOT_GET_;
    property  ROOT_Source_onChange:mCopyRast_STAGE_onRootChange read _rootSource_mOnCHANGE_ write _rootSource_mOnCHANGE_;
    property  ROOT_Target         :tCopyRast_stROOT read _targetROOT_GET_;
    property  ROOT_Target_onChange:mCopyRast_STAGE_onRootChange read _rootResult_mOnCHANGE_ write _rootResult_mOnCHANGE_;
  protected
    procedure _EXECUTE_; virtual;
  public
    function  EXECUTE(const nodeRoot:tSrcTree_item):boolean; //override;
    procedure doClear(const full:boolean=true); virtual;
  public
    constructor Create(const aBUILDer:tSrcTree_Builder_CORE); virtual;// override;
    destructor DESTROY; override;
  end;



type
 tCopyRast_SrcTree_STAGE_00_CORE=class(tCopyRast_SrcTree_prcSTAGE)

  end;

 tCopyRast_SrcTree_STAGE_XX_CORE=class(tCopyRast_SrcTree_prcSTAGE)

  end;


implementation

constructor tCopyRast_SrcTree_STAGE_CORE.Create(const BUILDer:tSrcTree_Builder_CORE);
begin
   _enabled_:=FALSE;
end;

//------------------------------------------------------------------------------

constructor tCopyRast_SrcTree_STAGE_00_CORE.Create(const BUILDer:tSrcTree_Builder_CORE);
begin
    inherited;
end;

constructor tCopyRast_SrcTree_STAGE_00_CORE.Create(const BUILDer:tSrcTree_Builder_CORE; const Creater_TYPE:tSrcTree_Creater_TYPE);
begin
    _creater_:=Creater_TYPE.Create;
end;

//------------------------------------------------------------------------------

procedure tCopyRast_SrcTree_STAGE_CORE._rootResult_CLR_;
var tmpRoot:tCopyRast_stROOT;
begin
    if Assigned(_rootResult_) then begin
        tmpRoot:=_rootResult_;
       _rootResult_:=nil;
        if Assigned(_rootResult_mOnCHANGE_) then _rootResult_mOnCHANGE_(self,nil);
        tmpRoot.Free;
    end;
end;

procedure tCopyRast_SrcTree_STAGE_CORE._rootResult_SET_(const value:tCopyRast_stROOT);
begin
    if _rootResult_<>value then begin
       _rootResult_CLR_; {todo: УБРАТЬ отсюда}
        //
       _rootResult_:=value;
        if Assigned(_rootResult_mOnCHANGE_) then _rootResult_mOnCHANGE_(self,nil);
    end;
end;

{function tCopyRast_SrcTree_STAGE_CORE._targetROOT_GET_:tCopyRast_stROOT;
begin
    result:=_rootResult_;
end; }




{%region --- .._itmSTAGE.. ------}

function tCopyRast_SrcTree_itmSTAGE.ROOT_Source:tCopyRast_stROOT;
begin
    {$ifDEF _local_DEBUG_}
        Assert(IS_CopyRAST_stROOT(executed_Root));
    {$endIf}
    result:=tCopyRast_stROOT(executed_Root)
end;

function tCopyRast_SrcTree_itmSTAGE.ROOT_Target:tCopyRast_stROOT;
begin
  (*  {$ifDEF _local_DEBUG_}                         ;
        Assert(Assigned(_OWNER_), ClassName+'._OWNER_===NIL');
        //     | типа тест ... для проверки СООБЩЕНИЯ
        Assert(_OWNER_ is tCopyRast_SrcTree_prcSTAGE, ClassName+'._OWNER_('+_OWNER_.ClassName+') is NOT '+tCopyRast_SrcTree_itmSTAGE.ClassName);
        Assert(Assigned(tCopyRast_SrcTree_prcSTAGE(_OWNER_)._targetROOT_GET_), ClassName+'._OWNER_._targetROOT_===NIL');
    {$endIf}
    result:=tCopyRast_stROOT(tCopyRast_SrcTree_prcSTAGE(_OWNER_)._targetROOT_GET_); *)
end;

{%endregion}

//==============================================================================


constructor tCopyRast_SrcTree_prcSTAGE.Create(const aBUILDer:tSrcTree_Builder_CORE);
begin
    //inherited Create(aBUILDer);
    //------------------------
   _enabled_:=FALSE;
    //
   _rootSource_mOnCHANGE_:=nil;
   _rootResult_mOnCHANGE_:=nil;
    //
   _rootResult_:=nil;
    //
   _CNFGs_CREATE_;
end;

destructor tCopyRast_SrcTree_prcSTAGE.DESTROY;
begin
   _rootResult_CLR_;
   _CNFGs_FREE_;
    inherited;
end;

//------------------------------------------------------------------------------

{procedure tCopyRast_SrcTree_prcSTAGE._rootResult_SET_(const root:tCopyRast_stROOT);
begin
    if _targetROOT_<>root then begin
       _targetROOT_:=root;
        if Assigned(_mOn_trgRootCHG_) then _mOn_trgRootCHG_(self,_targetROOT_);
    end;
end;}

{procedure tCopyRast_SrcTree_prcSTAGE._targetROOT_CLR_;
begin
   _targetROOT_SET_(nil);
end;}



// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCopyRast_SrcTree_prcSTAGE._rootSource_CLR_;
begin
   _rootSource_SET_(NIL);
end;

procedure tCopyRast_SrcTree_prcSTAGE._rootSource_SET_(const value:tCopyRast_stROOT);
begin
    if _rootSource_<>value then begin
       _rootSource_:=value;
        if Assigned(_rootSource_mOnCHANGE_) then _rootSource_mOnCHANGE_(self,value);
    end;
end;

function tCopyRast_SrcTree_prcSTAGE._sourceROOT_GET_:tCopyRast_stROOT;
begin
    {$ifDEF _local_DEBUG_}
        Assert(not Assigned(_execRoot_) OR IS_CopyRAST_stROOT(_execRoot_));
    {$endIf}
    result:=tCopyRast_stROOT(_rootSource_);
end;

//------------------------------------------------------------------------------

(*procedure tCopyRast_SrcTree_prcSTAGE._targetROOT_NEW_Root(const src:tCopyRast_stROOT);
begin
  (*  {$ifOPT D+}
    Assert(Assigned(src));
    Assert(IS_CopyRAST_stROOT(src),src.ClassName+' is NOT valid CopyRAST_stROOT');
    {$endIf}
    // создадим
    if src is tCopyRastNODE_Root4Package
    then _rootResult_:=tCopyRastNODE_Root4Package(_builder_.crt_ROOT(src.ItemTEXT))
   else
    if src is tCopyRastNODE_Root4Project
    then _rootResult_:=tCopyRastNODE_Root4Project(_builder_.crt_ROOT(src.ItemTEXT));
    // свяжем
    CopyRastNODE_LINK(src,_rootResult_);    *)
end; *)

(*procedure tCopyRast_SrcTree_prcSTAGE._targetROOT_NEW_Base(const src:tCopyRast_stITEM);
var tmp:tCopyRast_stBASE;
begin // создадим и свяжем
 (*   {$ifOPT D+}
    Assert(Assigned(_rootResult_));
    Assert(Assigned(src));
    Assert(IS_CopyRAST_stBASE(src),src.ClassName+' is NOT valid CopyRAST_stBASE');
    {$endIf}
    // создадим и свяжем
    tmp:=tCopyRast_stBASE(_builder_.set_BASE(_rootResult_,tCopyRast_stBASE(src).fsPath));
    CopyRastNODE_LINK(src,tmp);*)
end; *)

(*procedure tCopyRast_SrcTree_prcSTAGE._targetROOT_NEW_Main(const src:tCopyRast_stITEM);
var tmp:tCopyRast_stMAIN;
begin // создадим и свяжем
 (*   {$ifOPT D+}
    Assert(Assigned(_rootResult_));
    Assert(Assigned(src));
    Assert(IS_CopyRAST_stMAIN(src),src.ClassName+' is NOT valid CopyRAST_stMAIN');
    {$endIf}
    // создадим и свяжем
    tmp:=_builder_.set_MAIN(_rootResult_,tCopyRast_stMAIN(src).fsPath);
    CopyRastNODE_LINK(src,tmp);*)
end;*)

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCopyRast_SrcTree_prcSTAGE._targetROOT_NEW_(const srcRoot:tCopyRast_stITEM);
begin
 (*   {$ifDEF _local_DEBUG_}
        Assert(Assigned(srcRoot));
        Assert(IS_CopyRAST_stROOT(srcRoot));
    {$endIf}
   _rootResult_:=nil;
   _targetROOT_NEW_Root(                   tCopyRast_stROOT(srcRoot));
   _targetROOT_NEW_Base(_builder_.fnd_BASE(tCopyRast_stROOT(srcRoot)));
   _targetROOT_NEW_Main(_builder_.fnd_MAIN(tCopyRast_stROOT(srcRoot))); *)
end;

//------------------------------------------------------------------------------

procedure tCopyRast_SrcTree_prcSTAGE._EXECUTE_;
begin
   //
end;

function tCopyRast_SrcTree_prcSTAGE.EXECUTE(const nodeRoot:tSrcTree_item):boolean;
begin
 (*   {$ifDEF _local_DEBUG_}
      Assert(not Assigned(_rootSource_) OR IS_CopyRAST_stROOT(_rootSource_));
    {$endIf}
    //--- готовимся
   _rootSource_SET_(tCopyRast_stROOT(nodeRoot)); //< ПереУстановить
   _rootResult_SET_(NIL);                        //< УНИЧТОЖЕНИЕ
    //--- выполняем
    if _enabled_ then begin
       _targetROOT_NEW_(nodeRoot);           //< подготавливаем ОСНОВНЫЕ узлы
        result:=inherited EXECUTE(nodeRoot); //< выполняем алгоритм
    end
    else begin //< алгоритм НЕ выполнять ... просто копирование
       _rootResult_:=CopyRast_SrcTree_Copy(_sourceROOT_GET_);
    end;
    //--- отчытываемся
    if Assigned(_rootResult_mOnCHANGE_) then _rootResult_mOnCHANGE_(self,_rootResult_);
    //*)
end;

procedure tCopyRast_SrcTree_prcSTAGE.doClear(const full:boolean=true);
begin
   _rootResult_CLR_;
    if full then _rootSource_CLR_;
end;

//------------------------------------------------------------------------------

{procedure tCopyRast_SrcTree_prcSTAGE.ROOT_Target_CLEAR;
begin
   _targetROOT_CLR_;
end;}

//------------------------------------------------------------------------------

procedure tCopyRast_SrcTree_prcSTAGE._CNFGs_CREATE_;
begin
    //
end;

procedure tCopyRast_SrcTree_prcSTAGE._CNFGs_FREE_;
begin
    //
end;

procedure tCopyRast_SrcTree_prcSTAGE._CNFGs_LOAD_(const Configs:tLazExt_CopyRAST_CONFIG);
begin
    //
end;

procedure tCopyRast_SrcTree_prcSTAGE._CNFGs_SAVE_(const Configs:tLazExt_CopyRAST_CONFIG);
begin
    //
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCopyRast_SrcTree_prcSTAGE.CNFGs_LOAD(const Configs:tLazExt_CopyRAST_CONFIG);
begin
    // чистим
   _CNFGs_FREE_;
   _CNFGs_CREATE_;
    // загружаем
   _CNFGs_LOAD_(Configs);
end;

procedure tCopyRast_SrcTree_prcSTAGE.CNFGs_SAVE(const Configs:tLazExt_CopyRAST_CONFIG);
begin
   _CNFGs_SAVE_(Configs);
end;

end.

