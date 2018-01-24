unit in0k_CopyRAST_srcTree_Stage;

{$mode objfpc}{$H+}

interface

{$ifDef CopyRAST_DEBUG}
    {$define _local_DEBUG_}
{$endIf}

uses
  in0k_lazIdeSRC_srcTree_CORE_item,
  lazExt_CopyRAST__xmlConfig,
  srcTree_handler4build_CORE,
  //---
  in0k_CopyRAST_srcTree_ITEMs;


type

 tCopyRast_SrcTree_itmSTAGE=class(tSrcTree_itmHandler4Build)
  protected
    function ROOT_Source:tCopyRast_stROOT; {$ifOpt D-}inline;{$endIf}
    function ROOT_Target:tCopyRast_stROOT; {$ifOpt D-}inline;{$endIf}
  end;

 tCopyRast_SrcTree_itmSTAGE_justCopy=class(tCopyRast_SrcTree_itmSTAGE)
  public
    function Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;


 tCopyRast_SrcTree_prcSTAGE=class;

 mCopyRast_STAGE_onRootChange=procedure(const Sender:tCopyRast_SrcTree_prcSTAGE; const newRoot:tCopyRast_stROOT) of object;


 tCopyRast_SrcTree_prcSTAGE=class(tSrcTree_prcHandler4Build)
  protected
   _mOn_srcRootCHG_:mCopyRast_STAGE_onRootChange;
   _mOn_trgRootCHG_:mCopyRast_STAGE_onRootChange;
  protected
    procedure _CNFGs_FREE_;                                        virtual;
    procedure _CNFGs_LOAD_(const Configs:tLazExt_CopyRAST_CONFIG); virtual;
    procedure _CNFGs_SAVE_(const Configs:tLazExt_CopyRAST_CONFIG); virtual;
  public
    procedure  CNFGs_LOAD (const Configs:tLazExt_CopyRAST_CONFIG);
    procedure  CNFGs_SAVE (const Configs:tLazExt_CopyRAST_CONFIG);
  strict private
   _targetROOT_:tCopyRast_stROOT;
    procedure _targetROOT_SET_(const value:tCopyRast_stROOT); {$ifOpt D-}inline;{$endIf}
    procedure _sourceROOT_SET_(const value:tCopyRast_stROOT); {$ifOpt D-}inline;{$endIf}
  protected
    function  _targetROOT_GET_:tCopyRast_stROOT;              {$ifOpt D-}inline;{$endIf}
    function  _sourceROOT_GET_:tCopyRast_stROOT;              {$ifOpt D-}inline;{$endIf}
  strict private
    procedure _targetROOT_NEW_Root(const src:tCopyRast_stROOT);
    procedure _targetROOT_NEW_Base(const src:tCopyRast_stITEM);
    procedure _targetROOT_NEW_Main(const src:tCopyRast_stITEM);
  private
    procedure _targetROOT_NEW_(const srcRoot:tCopyRast_stITEM);
  public
    property  ROOT_Source_onChange:mCopyRast_STAGE_onRootChange read _mOn_srcRootCHG_ write _mOn_srcRootCHG_;
    property  ROOT_Target_onChange:mCopyRast_STAGE_onRootChange read _mOn_trgRootCHG_ write _mOn_trgRootCHG_;
  public
    property  ROOT_Source:tCopyRast_stROOT read _sourceROOT_GET_;
    property  ROOT_Target:tCopyRast_stROOT read _targetROOT_GET_;
    //procedure ROOT_Target_CLEAR;
  public
    function  EXECUTE(const nodeRoot:tSrcTree_item):boolean; override;
    procedure doClear(const full:boolean=true); virtual;
  public
    destructor DESTROY; override;
  end;


implementation

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
    {$ifDEF _local_DEBUG_}                         ;
        Assert(Assigned(_OWNER_), ClassName+'._OWNER_===NIL');
        //     | типа тест ... для проверки СООБЩЕНИЯ
        Assert(_OWNER_ is tCopyRast_SrcTree_prcSTAGE, ClassName+'._OWNER_('+_OWNER_.ClassName+') is NOT '+tCopyRast_SrcTree_itmSTAGE.ClassName);
        Assert(Assigned(tCopyRast_SrcTree_prcSTAGE(_OWNER_)._targetROOT_GET_), ClassName+'._OWNER_._targetROOT_===NIL');
    {$endIf}
    result:=tCopyRast_stROOT(tCopyRast_SrcTree_prcSTAGE(_OWNER_)._targetROOT_GET_);
end;

{%endregion}

{%region --- .._itmSTAGE_justCopy.. ------}

function tCopyRast_SrcTree_itmSTAGE_justCopy.Processing:boolean; // ВЫПОЛНИТЬ обработку
begin

end;

{%endregion}
//==============================================================================

destructor tCopyRast_SrcTree_prcSTAGE.DESTROY;
begin
   _CNFGs_FREE_;
    inherited;
end;

//------------------------------------------------------------------------------

{procedure tCopyRast_SrcTree_prcSTAGE._targetROOT_SET_(const root:tCopyRast_stROOT);
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


procedure tCopyRast_SrcTree_prcSTAGE._targetROOT_SET_(const value:tCopyRast_stROOT);
var tmpRoot:tCopyRast_stROOT;
begin
    if _targetROOT_<>value then begin
        if Assigned(_targetROOT_) then begin
            tmpRoot:=_targetROOT_;
            //
           _targetROOT_:=nil;
            if Assigned(_mOn_trgRootCHG_) then _mOn_trgRootCHG_(self,nil);
            //
            tmpRoot.Free;
        end;
        //
       _targetROOT_:=value;
        if Assigned(_mOn_trgRootCHG_) then _mOn_trgRootCHG_(self,nil);
    end;
end;

function tCopyRast_SrcTree_prcSTAGE._targetROOT_GET_:tCopyRast_stROOT;
begin
    result:=_targetROOT_;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCopyRast_SrcTree_prcSTAGE._sourceROOT_SET_(const value:tCopyRast_stROOT);
begin
    if _execRoot_<>value then begin
       _execRoot_:=value;
        if Assigned(_mOn_srcRootCHG_) then _mOn_srcRootCHG_(self,value);
    end;
end;

function tCopyRast_SrcTree_prcSTAGE._sourceROOT_GET_:tCopyRast_stROOT;
begin
    {$ifDEF _local_DEBUG_}
        Assert(not Assigned(_execRoot_) OR IS_CopyRAST_stROOT(_execRoot_));
    {$endIf}
    result:=tCopyRast_stROOT(_execRoot_);
end;

//------------------------------------------------------------------------------

procedure tCopyRast_SrcTree_prcSTAGE._targetROOT_NEW_Root(const src:tCopyRast_stROOT);
begin
    {$ifOPT D+}
    Assert(Assigned(src));
    Assert(IS_CopyRAST_stROOT(src),src.ClassName+' is NOT valid CopyRAST_stROOT');
    {$endIf}
    // создадим
    if src is tCopyRastNODE_Root4Package
    then _targetROOT_:=tCopyRastNODE_Root4Package(_builder_.crt_ROOT(src.ItemTEXT))
   else
    if src is tCopyRastNODE_Root4Project
    then _targetROOT_:=tCopyRastNODE_Root4Project(_builder_.crt_ROOT(src.ItemTEXT));
    // свяжем
    CopyRastNODE_LINK(src,_targetROOT_);
end;

procedure tCopyRast_SrcTree_prcSTAGE._targetROOT_NEW_Base(const src:tCopyRast_stITEM);
var tmp:tCopyRast_stBASE;
begin // создадим и свяжем
    {$ifOPT D+}
    Assert(Assigned(_targetROOT_));
    Assert(Assigned(src));
    Assert(IS_CopyRAST_stBASE(src),src.ClassName+' is NOT valid CopyRAST_stBASE');
    {$endIf}
    // создадим и свяжем
    tmp:=tCopyRast_stBASE(_builder_.set_BASE(_targetROOT_,tCopyRast_stBASE(src).fsPath));
    CopyRastNODE_LINK(src,tmp);
end;

procedure tCopyRast_SrcTree_prcSTAGE._targetROOT_NEW_Main(const src:tCopyRast_stITEM);
var tmp:tCopyRast_stMAIN;
begin // создадим и свяжем
    {$ifOPT D+}
    Assert(Assigned(_targetROOT_));
    Assert(Assigned(src));
    Assert(IS_CopyRAST_stMAIN(src),src.ClassName+' is NOT valid CopyRAST_stMAIN');
    {$endIf}
    // создадим и свяжем
    tmp:=_builder_.set_MAIN(_targetROOT_,tCopyRast_stMAIN(src).fsPath);
    CopyRastNODE_LINK(src,tmp);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCopyRast_SrcTree_prcSTAGE._targetROOT_NEW_(const srcRoot:tCopyRast_stITEM);
begin
    {$ifDEF _local_DEBUG_}
        Assert(Assigned(srcRoot));
        Assert(IS_CopyRAST_stROOT(srcRoot));
    {$endIf}
   _targetROOT_:=nil;
   _targetROOT_NEW_Root(                   tCopyRast_stROOT(srcRoot));
   _targetROOT_NEW_Base(_builder_.fnd_BASE(tCopyRast_stROOT(srcRoot)));
   _targetROOT_NEW_Main(_builder_.fnd_MAIN(tCopyRast_stROOT(srcRoot)));
end;

//------------------------------------------------------------------------------

function tCopyRast_SrcTree_prcSTAGE.EXECUTE(const nodeRoot:tSrcTree_item):boolean;
begin
    {$ifDEF _local_DEBUG_}
      Assert(not Assigned(_execRoot_) OR IS_CopyRAST_stROOT(_execRoot_));
    {$endIf}
   _sourceROOT_SET_(tCopyRast_stROOT(nodeRoot));
   _targetROOT_SET_(NIL);
    //---
   _targetROOT_NEW_(nodeRoot);
    result:=inherited EXECUTE(nodeRoot);
    //---
    if Assigned(_mOn_trgRootCHG_) then _mOn_trgRootCHG_(self,_targetROOT_);
end;

procedure tCopyRast_SrcTree_prcSTAGE.doClear(const full:boolean=true);
begin
   _targetROOT_SET_(nil);
    if full then _sourceROOT_SET_(nil);
end;

//------------------------------------------------------------------------------

{procedure tCopyRast_SrcTree_prcSTAGE.ROOT_Target_CLEAR;
begin
   _targetROOT_CLR_;
end;}

//------------------------------------------------------------------------------

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
   _CNFGs_FREE_;
   _CNFGs_LOAD_(Configs);
end;

procedure tCopyRast_SrcTree_prcSTAGE.CNFGs_SAVE(const Configs:tLazExt_CopyRAST_CONFIG);
begin
   _CNFGs_SAVE_(Configs);
end;

end.

