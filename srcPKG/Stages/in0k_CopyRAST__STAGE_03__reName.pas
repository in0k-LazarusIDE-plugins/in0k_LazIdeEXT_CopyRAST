unit in0k_CopyRAST__STAGE_03__reName;

{$mode objfpc}{$H+}

interface

uses
  //{$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
  in0k_lazIdeSRC_DEBUG,
  //{$endIf}

  Classes, Dialogs,

  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  in0k_lazIdeSRC_srcTree_item_fsFile,


  //PackageDependencyIntf,

  srcTree_builder_CORE,

  sysutils,

  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_FNK_rootFILE_FND,
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,
  in0k_lazIdeSRC_srcTree_FNK_mainFILE_FND,

  RegExpr,


srcTree_handler4build_CORE,


  in0k_CopyRAST_srcTree_ITEMs,
  in0k_CopyRAST__STAGE_03_configs,
  lazExt_CopyRAST__xmlConfig,
  lazExt_CopyRAST__xmlConfig_approvedFILEs2NAMEs,

  in0k_CopyRAST_STAGEs_CORE;

type

 {tCopyRastSrcTree_itmH4ReNAMEs_FLDR=class(tSrcTree_itmHandler4Build)
  public // ВЫПОЛНЕНИЕ
    //function Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;}

 {tCopyRastSrcTree_itmH4ReNAMEs_FILE=class(tSrcTree_itmHandler4Build)
  public // ВЫПОЛНЕНИЕ
    //function Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;}

 tCopyRast_stage__ChangePaths=class(tCopyRast_SrcTree_STAGE_L_R)
  private
   _regExpr_:TRegExpr;
  strict private
    function _macross_Present_(const srcString:string):boolean;
    function _macross_APPLAY_ (var   srcString:string; const mcrName,mcrValue:String):boolean; overload;
    function _macross_APPLAY_ (const srcString:string; const macrossList:tStringList):string;  overload;
  strict private
   _mcrWRNG_:tStringList; //< ИСКЛЮЧАЕМЫХ макросов при указании имен
    function  _mcrWRNG_Exclude(const srcString:string):string;
  strict private
   _macross_:tStringList;
    procedure _macross_reClc_;
    function  _macross_APPLAY_CopyRAST_(const srcString:string):string;
    function  _macross_APPLAY_Lazarus_ (const srcString:string):string;
  strict private
    function  _macross_getNullName_ROOT_:string;
    function  _macross_getNullName_BASE_:string;
  private
    function  _macross_APPLAY_(const srcString:string):string;
  private   //< наша конфигурация
   _cnfg_customer_ROOT_:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node; //< собственные названия для ROOT
   _cnfg_customer_FILE_:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_LAIR; //< собственные названия для ФАЙЛОВ
   _cnfg_customer_FLDR_:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_LAIR; //< собственные названия для ПАПОК
   _cnfg_template_ROOT_:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List; //< шаблоны для ROOT
   _cnfg_template_LAER_:tCopyRAST_HandlerCNFGs_ReNAMEs_template_LAIR; //< шаблоны для ВСЕХ остальных
   _cnfg_macross__LIST_:tCopyRAST_HandlerCNFGs_ReNAMEs_macros_List;   //< шаблоны для ROOT
  private
    function  _cnfgClc_newROOT_ {(const item:tCopyRast_stROOT)}:string;
    function  _cnfgClc_newBASE_ {(const item:tCopyRast_stBASE)}:string;
    function  _cnfgClc_newMAIN_ {(const item:tCopyRast_stMAIN)}:string;
  private
    function  _cnfgClc_newNAME_ (const item:tCopyRast_stITEM):string; //overload;
    function  _cnfgClc_newPATH_ (const item:tCopyRast_stITEM):string; //overload;
    function  _cnfgClc_newNameFLDR_ (const item:tSrcTree_item; out leftFLDR:tSrcTree_fsFLDR):string; //overload;
  protected //< работа с Конфигурацией
    procedure _CNFGs_INIT_;                                        override;
    procedure _CNFGs_FREE_;                                        override;
    procedure _CNFGs_LOAD_(const Configs:tLazExt_CopyRAST_CONFIG); override;
    procedure _CNFGs_SAVE_(const Configs:tLazExt_CopyRAST_CONFIG); override;
  protected
    function  _get_oldName_ROOT_(const item:tSrcTree_ROOT):string;
    function  _get_oldName_BASE_(const item:tSrcTree_BASE):string;
    function  _clc_newName_ROOT_:string;
    function  _clc_newName_BASE_:string;
    function  _clc_newName_MAIN_(const ext:string):string;

    //tCopyRast_stMAIN

    function  _clc_newName_FLDR_(const item:tSrcTree_item; out leftFLDR:tSrcTree_fsFLDR):string;
    function  _clc_newName_FILE_(const item:tCopyRast_stITEM):string;





    //function  _getNewPATH_FLDR_(const item:tCopyRastNODE_FLDR):string;
    //function  _getNewPATH_FILE_(const item:tCopyRastNODE_FILE):string;
    //procedure _prc_addNew_FLDR_(const item:tCopyRastNODE_FLDR);
    //procedure _prc_addNew_FILE_(const item:tCopyRastNODE_FILE);

  protected
    procedure _execute_makeResultROOT_OTHEr_(const resRoot:tCopyRast_stROOT; const src:tCopyRast_stROOT);
    procedure _execute_makeResultROOT_MAINs_(out   resRoot:tCopyRast_stROOT; const src:tCopyRast_stROOT);
  protected
    //procedure _EXECUTE_;
    function _execute_makeResultROOT_(const src:tCopyRast_stROOT):tCopyRast_stROOT; override;
  public
    //procedure EXECUTE(const nodeRoot:tSrcTree_ROOT); overload;
  public
    constructor Create(const STAGEs:tCopyRAST_STAGEs_CORE); override;
    destructor DESTROY; override;
  protected
    //_CNFGs4NAME_:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME;
  protected
   (* //procedure _CNFGs4NAME_SET_(const List:TStringList; const item:tSrcTree_item; const reNames:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);
    //procedure _CNFGs4NAME_GET_(const List:TStringList; const item:tSrcTree_item; const reNames:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);
    //procedure _TMPLs4NAME_SET_(const List:TStringList; const item:tSrcTree_item; const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
    *)

  protected
    function  _template_GET_link_(const item:tSrcTree_item):tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
    procedure _template_MakeLIST_(const item:tSrcTree_item; const list:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List; const ENABLED_only:boolean; const asParent,asEnable:boolean);
  protected
    function  _template_APPLAY_RULE_4item_(const srcItem:tSrcTree_item; const rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule):boolean;
    function  _template_APPLAY_RULE_(const srcItem:tSrcTree_item; const srcName:string; const rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule; out outName:string):integer;
    //function  _template_APPLAY_LIST_(const srcName:string;        const list:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List; out outName:string):integer; overload;
    function  _template_APPLAY_LIST_(const srcItem:tSrcTree_item; const list:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List; var outName:string):integer;

  public // для ЛЕВОГО дерева
    procedure CNFG_customer_SET       (const item:tSrcTree_item; const CNFG:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node);
    function  CNFG_customer_GET       (const item:tCopyRast_stITEM):tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node;
    function  CNFG_customer_NameCustom(const item:tCopyRast_stITEM):boolean;
    function  CNFG_customer_PathCustom(const item:tCopyRast_stITEM):boolean;
    procedure CNFG_template_SET       (const item:tSrcTree_item; const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
    function  CNFG_template_GET       (const item:tSrcTree_item):tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
    function  CNFG_template_count     (const item:tSrcTree_item):integer;
  public // для ПРАВОГО дерева
    function  RSLT_wasReNamed         (const item:tCopyRast_stITEM):boolean;

  public
    (*function  Validate_FLDR(const value:string):boolean;
    function  Validate_FILE(const value:string):boolean;   *)
  public
    function  Template_APPLAY(const srcItem:tSrcTree_item; const srcName:string; const rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule; out outName:string):integer;
  end;

implementation

{%region --- возня с ДЕБАГОМ -------------------------------------- /fold}
{$if declared(in0k_lazIde_DEBUG)}
    // `in0k_lazIde_DEBUG` - это функция ИНДИКАТОР что используется
    //                       моя "система имен и папок"
    {$define _debug_}     //< типа да ... можно делать ДЕБАГ отметки
{$else}
    {$undef _debug_}
{$endIf}
{%endregion}


{%region --- tCopyRastSrcTree_itmH4ReNAMEs_FILE ------------------- }

type
_tSTAGE03_prcHandler_CORE_=class(tSrcTree_prcHandler4Build)
  protected
   _STAGE_:tCopyRast_stage__ChangePaths;
  protected
   _rsltRoot_:tCopyRast_stROOT; //< куда все делаем
  public
    function calc_FLDR_Name(const item:tCopyRast_stITEM; out leftFLDR:tSrcTree_fsFLDR):string;
    function calc_FILE_Name(const item:tCopyRast_stITEM):string;
  public
    function target_ROOT:tCopyRast_stROOT;
    function target_BASE:tCopyRast_stBASE;
    function target_MAIN:tCopyRast_stMAIN;
  end;

//------------------------------------------------------------------------------

function _tSTAGE03_prcHandler_CORE_.target_ROOT:tCopyRast_stROOT;
begin
    result:=_rsltRoot_;
end;

function _tSTAGE03_prcHandler_CORE_.target_BASE:tCopyRast_stBASE;
begin
    result:=tCopyRast_stBASE(Builder.fnd_BASE(_rsltRoot_));
end;

function _tSTAGE03_prcHandler_CORE_.target_MAIN:tCopyRast_stMAIN;
begin
    result:=Builder.fnd_MAIN(_rsltRoot_);
end;

//------------------------------------------------------------------------------

function _tSTAGE03_prcHandler_CORE_.calc_FLDR_Name(const item:tCopyRast_stITEM; out leftFLDR:tSrcTree_fsFLDR):string;
begin
    {$ifDef _debug_}Assert(Assigned(_STAGE_));{$endIf}
    result:=_STAGE_._clc_newName_FLDR_(item,leftFLDR);
end;

function _tSTAGE03_prcHandler_CORE_.calc_FILE_Name(const item:tCopyRast_stITEM):string;
begin
    {$ifDef _debug_}Assert(Assigned(_STAGE_));{$endIf}
    result:=_STAGE_._clc_newName_FILE_(item);
end;

////////////////////////////////////////////////////////////////////////////////

type
_tSTAGE03_itmHandler_CORE_=class(tSrcTree_itmHandler4Build)
  public
    function target_ROOT:tCopyRast_stROOT;
    function target_BASE:tCopyRast_stBASE;
    function target_MAIN:tCopyRast_stMAIN;
  end;

function _tSTAGE03_itmHandler_CORE_.target_ROOT:tCopyRast_stROOT;
begin
    result:=_tSTAGE03_prcHandler_CORE_(_OWNER_).target_ROOT;
end;

function _tSTAGE03_itmHandler_CORE_.target_BASE:tCopyRast_stBASE;
begin
    result:=_tSTAGE03_prcHandler_CORE_(_OWNER_).target_BASE;
end;

function _tSTAGE03_itmHandler_CORE_.target_MAIN:tCopyRast_stMAIN;
begin
    result:=_tSTAGE03_prcHandler_CORE_(_OWNER_).target_MAIN;
end;








type

tCopyRastSrcTree_itmH4ReNAMEs_FILE=class(_tSTAGE03_itmHandler_CORE_)
 protected
   function _getTargetFLDR_:_tSrcTree_item_fsNodeFLDR_;
   function _newTargetFILE_(const fldr:_tSrcTree_item_fsNodeFLDR_):tCopyRastNODE_FILE;
 public
   function Processing:boolean; override; // ВЫПОЛНИТЬ обработку
 end;

// получить/СОЗДАТЬ НОВУЮ папку для prcssdITEM
function tCopyRastSrcTree_itmH4ReNAMEs_FILE._getTargetFLDR_:_tSrcTree_item_fsNodeFLDR_;
var tmpLeft:tSrcTree_fsFLDR;
var tmpPATH:string;
    tmpKING:sSrcTree_SrchPath;
begin
    result:=nil;
    // ищем СТРОКУ-ПУТЬ и применяем МАКРОСЫ
    tmpPATH:=_tSTAGE03_prcHandler_CORE_(_OWNER_).calc_FLDR_Name(prcssdITEM,tmpLeft);
    // ищем НАБОР "путиПоиска"
    tmpKING:=[];
    if Assigned(tmpLeft) then begin
        // есть явное указание из какой папки мы есть, из нее и берем
        tmpKING:=tSrcTree_fsFLDR(tmpLeft).inSearchPATHs
    end
    else begin
        // ищем ОТКУДА брать поисковые пути, видимо из НЕШЕЙ ролительской папки
        tmpLeft:=SrcTree_fsFolder__fnd_PARENT(prcssdITEM);
        if Assigned(tmpLeft)
        then tmpKING:=tSrcTree_fsFLDR(tmpLeft).inSearchPATHs;
        tmpLeft:=nil; //< отметим что папки слева НЕТ
    end;
    // ищем/создаем папку
    if tmpPATH='' then result:=target_BASE //< тут видимо берем БАЗОВУЮ папку
    else begin // создаем и ИНТелектуАЛЬНО вяжем
        result:=Builder.add_FLDR(target_ROOT,tmpPATH,tmpKING);
        if Assigned(tmpLeft) then CopyRastNODE_LINK(tmpLeft,result);
    end;
end;

function tCopyRastSrcTree_itmH4ReNAMEs_FILE._newTargetFILE_(const fldr:_tSrcTree_item_fsNodeFLDR_):tCopyRastNODE_FILE;
var tmpNAME:string;
begin
    // ищем СТРОКУ-НАЗВАНИЕ и применяем МАКРОСЫ
    tmpNAME:=_tSTAGE03_prcHandler_CORE_(_OWNER_).calc_FILE_Name(prcssdITEM);
    //
    if tmpNAME<>'' then begin
        tmpNAME:=srcTree_fsFnk_ConcatPaths(fldr.fsPath,tmpNAME);
        result :=tCopyRastNODE_FILE(Builder.add_FILE(target_ROOT,tmpNAME,tCopyRastNODE_FILE(prcssdITEM).fileKIND));
        CopyRastNODE_LINK(tCopyRastNODE_FILE(prcssdITEM),result);
    end
    else begin
        {todo: про ОШИБКИ !}
    end;
end;

function tCopyRastSrcTree_itmH4ReNAMEs_FILE.Processing:boolean;
var tmpFLDR:_tSrcTree_item_fsNodeFLDR_;
begin //
    if prcssdITEM is tCopyRastNODE_FILE then begin //< работаем ТОЛЬКО с ФАЙЛАМИ
        {$ifDef _DEBUG_}DEBUG(self.ClassName+'.'+'Processing','prcssdITEM="'+prcssdITEM.ItemNAME+'"');{$endIf}
        tmpFLDR:=_getTargetFLDR_; //<
        if Assigned(tmpFLDR) then begin
           _newTargetFILE_(tmpFLDR);
        end
        else begin
            {todo: про ОШИБКИ !}
        end;
    end;
    result:=TRUE;
end;

{%endregion}


{%region --- tCopyRastSrcTree_itmH4ReNAMEs_FILE ------------------- }

type
_tSTAGE03_prcHandler_=class(_tSTAGE03_prcHandler_CORE_)
  protected
    procedure _EXECUTE_; override;
  end;

procedure _tSTAGE03_prcHandler_._EXECUTE_;
begin
    EXECUTE_4TREE(tCopyRastSrcTree_itmH4ReNAMEs_FILE);
end;

{%endregion}


////////////////////////////////////////////////////////////////////////////////

constructor  tCopyRast_stage__ChangePaths.Create(const STAGEs:tCopyRAST_STAGEs_CORE);
begin
    inherited;
   _regExpr_ :=TRegExpr.Create;
   _macross_ :=TStringList.Create;
end;

destructor tCopyRast_stage__ChangePaths.DESTROY;
begin
   _macross_.FREE;
   _macross_:=nil;
   _regExpr_.FREE;
   _regExpr_:=nil;
    inherited;
end;

(*
//------------------------------------------------------------------------------

(*function tCopyRast_stage__ChangePaths._get_newFLDR_(const item:tSrcTree_item; out fldrPATH:string; out fldrKIND:sSrcTree_SrchPath; out leftFLDR:tCopyRastNODE_FLDR):boolean;
var ctm:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node;
    tmp:tSrcTree_item;
begin
    result:=false;

    {ctm:=CNFG_customer_GET(item);
    if (Assigned(ctm))and(ctm.PathCustom) then begin



    end;}





    tmp:=SrcTree_fsFolder__fnd_PARENT(item);
    if Assigned(tmp) then begin
        fldrPATH:=tSrcTree_fsFLDR(tmp).fsBase;
        fldrKIND:=tSrcTree_fsFLDR(tmp).inSearchPATHs;
        leftFLDR:=tCopyRastNODE_FLDR(tmp);
        result  :=TRUE;
    end;
end; *)

{function tCopyRast_stage__ChangePaths._cnfgClc_newNAME_(const item:tSrcTree_item; out fileName:string; out fileKIND:eSrcTree_FileType):boolean;
var ctm:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node;
    lst:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
begin
    fileName:=item.ItemNAME;
    //
    ctm:=CNFG_customer_GET(item);
    if (Assigned(ctm))and(ctm.NameCustom) then begin
        fileName:=ctm.NameStated;
        result:=true;
    end
    else begin
        // надо строить правила изменения и т.д.
        lst:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_List.Create;
       _template_MakeLIST_(item,lst,TRUE,false,true);
       _template_APPLAY_LIST_(item,lst,fileName);
        lst.FREE;
    end;
    ctm.FREE;
    result:=true;
end;}


*)
{%region --- _cnfgClc_XXX.. ---------------------------------------------}

function tCopyRast_stage__ChangePaths._cnfgClc_newROOT_:string;
begin
    result:='';
    // проверим ЯВНОЕ указание имен
    if (Assigned(_cnfg_customer_ROOT_))and(TRUE or (_cnfg_customer_ROOT_.NameCustom)) //< ВСЕГДА используется
    then result:=_cnfg_customer_ROOT_.NameStated;
    // название по УМОЛЧАНИЮ?
    if result='' then result:=_macross_getNullName_ROOT_;
end;

function tCopyRast_stage__ChangePaths._cnfgClc_newBASE_:string;
var ctm:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node;
begin
    result:='';
    // проверим ЯВНОЕ указание имен
    if (Assigned(_cnfg_customer_ROOT_))and(TRUE or (_cnfg_customer_ROOT_.PathCustom)) //< ВСЕГДА используется
    then result:=_cnfg_customer_ROOT_.PathStated;
    // название по УМОЛЧАНИЮ?
    if result='' then result:=_macross_getNullName_BASE_;
end;

function tCopyRast_stage__ChangePaths._cnfgClc_newMAIN_:string;
var ctm:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node;
    ext:string;
begin
    result:=_cnfgClc_newROOT_;
    // название по УМОЛЧАНИЮ?
    if result='' then result:=_macross_getNullName_ROOT_;
    // расширение
    {if Assigned(_sourceROOT_) then begin
        ext:=srcTree_fsFnk_ExtractFileExt( SrcTree_fndMainFILE(_sourceROOT_).fsName );
        if ext<>'' then begin
            result:=srcTree_fsFnk_ChangeFileExt(result,ext)
        end;
    end;}
end;

//------------------------------------------------------------------------------





function tCopyRast_stage__ChangePaths._cnfgClc_newNAME_(const item:tCopyRast_stITEM):string;
var ctm:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node;
    lst:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
begin
    result:='';
    if item is _tSrcTree_item_fsNode_ then begin
        result:=_tSrcTree_item_fsNode_(item).fsName;
        ctm:=CNFG_customer_GET(item); // проверим ЯВНОЕ указание имен
        if (Assigned(ctm))and(ctm.NameCustom) then begin
            result:=ctm.NameStated;
        end
        else begin // проверим ШАБЛОНЫ переименования
            lst:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_List.Create;
           _template_MakeLIST_   (item,lst,TRUE,false,true);
           _template_APPLAY_LIST_(item,lst,result);
            lst.FREE;
        end;
        ctm.FREE;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// расчитать новы ПУТЬ
function tCopyRast_stage__ChangePaths._cnfgClc_newPATH_(const item:tSrcTree_item):string;
var tmp:tSrcTree_fsFLDR;
begin
    result:=_cnfgClc_newNameFLDR_(item,tmp);
end;

// расчитываем новый путь .. начинаем с себя и идем ВВЕРХ по дереву
function tCopyRast_stage__ChangePaths._cnfgClc_newNameFLDR_(const item:tSrcTree_item; out leftFLDR:tSrcTree_fsFLDR):string;
var ctm:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node;
    tmpName:string;
begin {todo: уйти от рекурсии}
    {$ifDef _debug_}Assert(Assigned(item));{$endIf}
    leftFLDR:=nil;
    result  :='';
    //---
    if (item is tSrcTree_BASE)or(NOT Assigned(item.ItemPRNT)) then begin
        // это УЖе базовая папка => выше НЕ поднимаемся
        leftFLDR:=tSrcTree_fsFLDR(item);
        result  :='';
    end
   else
    if item is tSrcTree_fsFLDR then begin // это ПАПКА .. работаем
        // ищем свое ИМЯ
        tmpName:=_cnfgClc_newNAME_(item);
        // ищем свой ПУТЬ
        ctm:=CNFG_customer_GET(item); // проверим ЯВНОЕ указание
        if (Assigned(ctm))and(ctm.PathCustom)
        then result:=ctm.PathStated
        else begin
            // путь для нас ЯВНО не указан, считаем путь по родителю
            result:=_cnfgClc_newNameFLDR_(item.ItemPRNT,leftFLDR);
        end;
        ctm.FREE;
        // и по финалу, соединяем свое НОВОЕ имя и НОВЫЙ путь родителя
        leftFLDR:=tSrcTree_fsFLDR(item);
        result  :=srcTree_fsFnk_ConcatPaths(result,tmpName);
    end
   else
    if Assigned(item.ItemPRNT) then begin //< в других случаях идем ВЫШЕ
        // ищем свой ПУТЬ
        ctm:=CNFG_customer_GET(item); // проверим ЯВНОЕ указание
        if (Assigned(ctm))and(ctm.PathCustom) then begin
            result:=ctm.PathStated;
        end
        else begin // путь для нас ЯВНО не указан, считаем путь по родителю
            result:=_cnfgClc_newNameFLDR_(item.ItemPRNT,leftFLDR);
        end;
        ctm.FREE;
    end;
end;

{%endregion}

{%region -- _clc_..Name.. -----------------------------------------------}

function tCopyRast_stage__ChangePaths._get_oldName_ROOT_(const item:tSrcTree_ROOT):string;
begin
    {$ifOpt D+}
    Assert(Assigned(item));
    Assert(IS_CopyRAST_stROOT(item));
    {$endIf}
    result:=item.ItemTEXT;
end;

// расчитать Имя: ROOT файла
// берем ИМЯ главного файла и УДАЛЯЕМ расширение
function tCopyRast_stage__ChangePaths._clc_newName_ROOT_:string;
begin
    result:=_macross_APPLAY_(_cnfgClc_newROOT_);
end;

function tCopyRast_stage__ChangePaths._get_oldName_BASE_(const item:tSrcTree_BASE):string;
begin
    {$ifOpt D+}
    Assert(Assigned(item));
    Assert(IS_CopyRAST_stBASE(item));
    {$endIf}
    result:=item.ItemTEXT;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// расчитать Имя: (ПУТЬ) базовой папки
function tCopyRast_stage__ChangePaths._clc_newName_BASE_:string;
begin
    result:=_macross_APPLAY_(_cnfgClc_newBASE_);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// расчитать Имя: ГЛАВНОГО файла
// @prm ext расширение файла из старого
function tCopyRast_stage__ChangePaths._clc_newName_MAIN_(const ext:string):string;
begin
    result:=_macross_APPLAY_(_cnfgClc_newMAIN_);
    result:= srcTree_fsFnk_ChangeFileExt(result, ext);
end;

function tCopyRast_stage__ChangePaths._clc_newName_FLDR_(const item:tSrcTree_item; out leftFLDR:tSrcTree_fsFLDR):string;
begin // ищем СТРОКУ-НАЗВАНИЕ в "конфигурации" и применяем МАКРОСЫ
    result:=_cnfgClc_newNameFLDR_(item,leftFLDR);
    result:=_macross_APPLAY_(result);
end;

function tCopyRast_stage__ChangePaths._clc_newName_FILE_(const item:tCopyRast_stITEM):string;
begin // ищем СТРОКУ-НАЗВАНИЕ в "конфигурации" и применяем МАКРОСЫ
    result:=_cnfgClc_newNAME_(item);
    result:=_macross_APPLAY_ (result);
end;

{%endregion}

(*

//function tCopyRast_stage__ChangePaths._getNewPATH_FLDR_(const item:tCopyRastNODE_FLDR):string;
//begin
//    result:={ccc+}item.fsPath;
//end;

//function tCopyRast_stage__ChangePaths._getNewPATH_FILE_(const item:tCopyRastNODE_FILE):string;
//begin
//   _regExpr_.InputString:=item.ItemNAME;
//   _regExpr_.Expression :='^in0k_lazIdeSRC_(\w+)(\.pas)$';
//    if _regExpr_.Exec(1) then begin
//        result:=_regExpr_.Replace(item.ItemNAME,'asdf$1$2',true);
//
//        result:=ExtractFilePath(item.fsPath)+result;
//    end
//    else result:=ccc+item.fsName;
//end;

//------------------------------------------------------------------------------


{procedure tCopyRast_stage__ChangePaths._prc_AddNew_FLDR_(const item:tCopyRastNODE_FLDR);
var tmp:tCopyRastNODE_FLDR;
begin // создадим и свяжем
    tmp:=tCopyRastNODE_FLDR(_builder_.add_FLDR(_newROOT_, _getNewPATH_FLDR_(item), item.inSearchPATHs ));
    CopyRastNODE_LINK(item,tmp);
end;}

{procedure tCopyRast_stage__ChangePaths._prc_AddNew_FILE_(const item:tCopyRastNODE_FILE);
var tmp:tCopyRastNODE_FILE;
begin // создадим и свяжем
    tmp:=tCopyRastNODE_FILE(_builder_.add_FILE(_newROOT_, {item.ItemPRNT.fsPath+'\'+}_getNewPATH_FILE_(item), item.fileKIND ));
    CopyRastNODE_LINK(item,tmp);
end;}

//------------------------------------------------------------------------------

*)

// #2 теперь про ОСТАЛЬНЫЕ файлы
procedure tCopyRast_stage__ChangePaths._execute_makeResultROOT_OTHEr_(const resRoot:tCopyRast_stROOT; const src:tCopyRast_stROOT);
var prcHandler:_tSTAGE03_prcHandler_;
begin
    prcHandler:=_tSTAGE03_prcHandler_.Create(_owner_Builder);
    prcHandler._STAGE_   :=self;
    prcHandler._rsltRoot_:=resRoot;
    prcHandler.EXECUTE(src); // EXECUTE_4TREE(); tCopyRastSrcTree_itmH4ReNAMEs_FILE
    prcHandler.FREE;
end;

// #1 Создаем ОСНОВНЫЕ в ручную
procedure tCopyRast_stage__ChangePaths._execute_makeResultROOT_MAINs_(out resRoot:tCopyRast_stROOT; const src:tCopyRast_stROOT);
var tmpItem:tCopyRast_stITEM;
begin {todo: про ОШИБКИ !}
    // КОРЕНЬ
    resRoot:=_owner_Builder.crt_ROOT(_clc_newName_ROOT_);
    CopyRastNODE_LINK_simple(src,resRoot);
    // базовая папка
    tmpItem:=_owner_Builder.set_BASE(resRoot,_clc_newName_BASE_);
    CopyRastNODE_LINK_simple(_owner_Builder.fnd_BASE(src),tmpItem);
    // главный файл
    tmpItem:=_owner_Builder.set_MAIN(resRoot,_clc_newName_MAIN_( srcTree_fsFnk_ExtractFileExt(_owner_Builder.fnd_MAIN(src).fsName) ));
    CopyRastNODE_LINK_simple(_owner_Builder.fnd_MAIN(src),tmpItem);
end;


function tCopyRast_stage__ChangePaths._execute_makeResultROOT_(const src:tCopyRast_stROOT):tCopyRast_stROOT;
var tmpItem:tCopyRast_stITEM;
    tmpName:string;
begin {todo: про ОШИБКИ !}
   _macross_reClc_;
   _execute_makeResultROOT_MAINs_(result,src);
   _execute_makeResultROOT_OTHEr_(result,src);
end;


(*

(*procedure tCopyRast_stage__ChangePaths.EXECUTE(const nodeRoot:tSrcTree_ROOT);
begin
    //_configs_:=Configs;
   _newROOT_:=_prc_setNew_ROOT_(nodeRoot);
    //-----
   _prc_setNew_BASE_({tCopyRastNODE_BASE}(_builder_.fnd_BASE(nodeRoot)));
   _prc_setNew_MAIN_({tCopyRastNODE_MAIN}(_builder_.fnd_MAIN(nodeRoot)));
    //
   //inherited EXECUTE(nodeRoot);
    //NewROOT:=_newROOT_;
end;*)

//------------------------------------------------------------------------------

*)

procedure tCopyRast_stage__ChangePaths._CNFGs_INIT_;
begin
    inherited;
   _cnfg_customer_ROOT_:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node.Create;
   _cnfg_customer_FLDR_:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_LAIR.Create;
   _cnfg_customer_FILE_:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_LAIR.Create;
   _cnfg_template_ROOT_:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_List.Create;
   _cnfg_template_LAER_:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_LAIR.Create;
   _cnfg_macross__LIST_:=tCopyRAST_HandlerCNFGs_ReNAMEs_macros_List  .Create;

end;

procedure tCopyRast_stage__ChangePaths._CNFGs_FREE_;
begin
    inherited;
   _cnfg_customer_ROOT_.FREE;
   _cnfg_customer_FLDR_.FREE;
   _cnfg_customer_FILE_.FREE;
   _cnfg_template_ROOT_.FREE;
   _cnfg_template_LAER_.FREE;
   _cnfg_macross__LIST_.FREE;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCopyRast_stage__ChangePaths._CNFGs_LOAD_(const Configs:tLazExt_CopyRAST_CONFIG);
begin
    inherited;
    CRxC_aF2N__customerROOT__Load(Configs,'',_cnfg_customer_ROOT_);
    CRxC_aF2N__customerFLDR__Load(Configs,'',_cnfg_customer_FLDR_);
    CRxC_aF2N__customerFILE__Load(Configs,'',_cnfg_customer_FILE_);
    CRxC_aF2N__templateROOT__Load(Configs,'',_cnfg_template_ROOT_);
    CRxC_aF2N__templateLAIR__Load(Configs,'',_cnfg_template_LAER_);
    CRxC_aF2N__macross_LIST__Load(Configs,'',_cnfg_macross__LIST_);
end;

procedure tCopyRast_stage__ChangePaths._CNFGs_SAVE_(const Configs:tLazExt_CopyRAST_CONFIG);
begin
    inherited;
    CRxC_aF2N__customerROOT__Save(Configs,'',_cnfg_customer_ROOT_);
    CRxC_aF2N__customerFLDR__Save(Configs,'',_cnfg_customer_FLDR_);
    CRxC_aF2N__customerFILE__Save(Configs,'',_cnfg_customer_FILE_);
    CRxC_aF2N__templateROOT__Save(Configs,'',_cnfg_template_ROOT_);
    CRxC_aF2N__templateLAIR__Save(Configs,'',_cnfg_template_LAER_);
    CRxC_aF2N__macross_LIST__Save(Configs,'',_cnfg_macross__LIST_);
end;

(*

//------------------------------------------------------------------------------

{procedure tCopyRast_stage__ChangePaths._CNFGs4NAME_SET_(const List:TStringList; const item:tSrcTree_item; const reNames:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);
var tmpIndx:integer;
    tmpData:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME;
begin
    {$ifOPT D+}
    Assert(Assigned(List));
    Assert(Assigned(item));
    Assert(Assigned(reNames));
    {$endIf}
    if List.Find(tSrcTree_fsFILE(item).fsBase,tmpIndx) then begin
        if reNames.SaveNEED then begin //< ищем и заполняем
            tmpData:=tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME(List.Objects[tmpIndx]);
            tmpData.Copy(reNames);
        end
        else begin //< его почистили, надо УДАЛИТЬ
            List.Objects[tmpIndx].FREE;
            List.Delete(tmpIndx);
        end;
    end
    else begin
        if reNames.SaveNEED then begin //< создаем и заполняем
            tmpData:=tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME.Create;
            tmpData.Copy(reNames);
            List.AddObject(tSrcTree_fsFILE(item).fsBase, tmpData);
        end;
    end;
end; }

{procedure tCopyRast_stage__ChangePaths._CNFGs4NAME_GET_(const List:TStringList; const item:tSrcTree_item; const reNames:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);
var tmpIndx:integer;
    tmpData:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME;
begin
    {$ifOPT D+}
    Assert(Assigned(List));
    Assert(Assigned(item));
    {$endIf}
    if List.Find(tSrcTree_fsFILE(item).fsBase,tmpIndx) then begin
        tmpData:=tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME(List.Objects[tmpIndx]);
        reNames.Copy(tmpData);
    end;
end;}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

(*procedure tCopyRast_stage__ChangePaths._TMPLs4NAME_SET_(const List:TStringList; const item:tSrcTree_item; const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
var tmpIndx:integer;
    tmpData:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME;
begin
    {$ifOPT D+}
    Assert(Assigned(List));
    Assert(Assigned(item));
    Assert(Assigned(value));
    {$endIf}
    if List.Find(tSrcTree_fsFILE(item).fsBase,tmpIndx) then begin
        List.Objects[tmpIndx].FREE;
        List.Delete(tmpIndx);
    end;
    List.AddObject(tSrcTree_fsFILE(item).fsBase, value);

{    if List.Find(tSrcTree_fsFILE(item).fsBase,tmpIndx) then begin
        if reNames.SaveNEED then begin //< ищем и заполняем
            tmpData:=tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME(List.Objects[tmpIndx]);
            tmpData.Copy(reNames);
        end
        else begin //< его почистили, надо УДАЛИТЬ
            List.Objects[tmpIndx].FREE;
            List.Delete(tmpIndx);
        end;
    end
    else begin
        if reNames.SaveNEED then begin //< создаем и заполняем
            tmpData:=tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME.Create;
            tmpData.Copy(reNames);
            List.AddObject(tSrcTree_fsFILE(item).fsBase, tmpData);
        end;
    end;}
end;*)

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

*)

{%region -- _macros_ ----------------------------------------------------}

const
  _cMacrosSMBL_equal_    ='=';
  _cMacrosNAME_crOldNAME_='crOldNAME';
  _cMacrosNAME_crNewNAME_='crNewNAME';
  _cMacrosNAME_crOldPATH_='crOldPATH';
  _cMacrosNAME_crNewPATH_='crNewPATH';

// переСоздаем список НАШИХ макросов
procedure tCopyRast_stage__ChangePaths._macross_reClc_;
var i:integer;
    m:tCopyRAST_HandlerCNFGs_ReNAMEs_macros_node;
begin
   _macross_.Clear;
    // заполним ЗАНОГО
   _macross_.Add(_cMacrosNAME_crOldNAME_+_cMacrosSMBL_equal_+_get_oldName_ROOT_(_sourceROOT_));
   _macross_.Add(_cMacrosNAME_crNewNAME_+_cMacrosSMBL_equal_+_clc_newName_ROOT_);
   _macross_.Add(_cMacrosNAME_crOldPATH_+_cMacrosSMBL_equal_+_get_oldName_BASE_(_owner_Builder.fnd_BASE(_sourceROOT_)));
    //_macross_.Add(_cMacrosNAME_crNewPATH_+_cMacrosSMBL_equal_+_clc_newName_ROOT_(_resultROOT_));

    // загрузим ПОЛЬЗОВАТЕЛЬСКИЕ
    for i:=0 to _cnfg_macross__LIST_.Count-1 do begin
        m:=_cnfg_macross__LIST_.Items[i];
       _macross_.Add(m.macrosName+_cMacrosSMBL_equal_+m.macrosValue);
    end;
    {$ifDef _DEBUG_}
    for i:=0 to _macross_.Count-1 do begin
        DEBUG(self.ClassName+'.'+'_macross_reClc_',_macross_.Strings[i]);
    end;
    {$endIf}
end;

//------------------------------------------------------------------------------

function tCopyRast_stage__ChangePaths._macross_Present_(const srcString:string):boolean;
begin
   _regExpr_.ModifierI  :=TRUE;
   _regExpr_.Expression :='(\$\(.*\))'; // шаблон поиска для поиска "макросов"
   _regExpr_.InputString:=srcString;
    //
    result:=_regExpr_.Exec(1);
end;

function tCopyRast_stage__ChangePaths._macross_APPLAY_(var srcString:string; const mcrName,mcrValue:String):boolean;
var tmpString:string;
begin
    result:=FALSE;
    //---
   _regExpr_.ModifierI  :=TRUE;
   _regExpr_.Expression :='(\$\('+mcrName+'\))'; // шаблон поиска макроса с "ИМЕНЕМ"
   _regExpr_.InputString:=srcString;
    //---
    ShowMessage('GOGOGO: '+srcString+' mcrName="'+mcrName+'" value="'+mcrValue+'"');
    while _regExpr_.Exec(1) do begin //< меняем пока меняется !!! МОЖЕМ ЗАЦИКЛИТЬСЯ
        tmpString:=_regExpr_.Replace(srcString,mcrValue,FALSE);
        result   :=TRUE;
        srcString:=tmpString;
       _regExpr_ .InputString:=srcString;
    end;
end;

function tCopyRast_stage__ChangePaths._macross_APPLAY_(const srcString:string; const macrossList:tStringList):string;
var chCount:integer;
    i      :integer;
begin // прям ХЗ ... может через ШТАТНЫЕ Лазаруса сделать
    result :=srcString;
    if _macross_Present_(result) then begin
        chCount:=1;
        while chCount>0 do begin //< меняем пока меняется !!! МОЖЕМ ЗАЦИКЛИТЬСЯ
            chCount:=0;
            for i:=0 to macrossList.Count-1 do begin
                if _macross_APPLAY_(result, macrossList.Names[i],macrossList.Values[macrossList.Names[i]])
                then begin
                    if _macross_Present_(result) then begin
                        // ЕСТЬ смысл искать дальше!
                        inc(chCount);
                    end
                    else begin
                        // искать дальше БЕЗсмысленно ... макросов больше НЕТ
                        chCount:=0;
                        BREAK;
                    end;
                end;
            end;
        end;
    end;
end;

//------------------------------------------------------------------------------

function tCopyRast_stage__ChangePaths._mcrWRNG_Exclude(const srcString:string):string;
begin
    result:=_macross_APPLAY_(srcString, _mcrWRNG_);
end;

//------------------------------------------------------------------------------

function tCopyRast_stage__ChangePaths._macross_APPLAY_CopyRAST_(const srcString:string):string;
begin
    result:=_macross_APPLAY_(srcString, _macross_);
end;

function tCopyRast_stage__ChangePaths._macross_APPLAY_Lazarus_ (const srcString:string):string;
begin
    {todo: DO it!}
    result:=srcString;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCopyRast_stage__ChangePaths._macross_APPLAY_(const srcString:string):string;
begin
    result:=srcString;
    result:=_macross_APPLAY_CopyRAST_(result);
    result:=_macross_APPLAY_Lazarus_ (result);
end;

//------------------------------------------------------------------------------

function tCopyRast_stage__ChangePaths._macross_getNullName_ROOT_:string;
begin
    result:='$('+_cMacrosNAME_crOldNAME_+')'+'_CR'
end;

function tCopyRast_stage__ChangePaths._macross_getNullName_BASE_:string;
begin
    result:='$('+_cMacrosNAME_crOldPATH_+')'+'_CR'
end;

{%endRegion}


//------------------------------------------------------------------------------

function _item_4_cnfg_customer_ROOT_(const item:tSrcTree_item):boolean;
begin
    try
    result:=false;
    //---
    if item is tSrcTree_ROOT then result:=true
   else
    if item is tSrcTree_BASE then result:=true
   else
    if item is tSrcTree_MAIN then result:=true;

    except
        ShowMessage('nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn');
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCopyRast_stage__ChangePaths.CNFG_customer_SET(const item:tSrcTree_item; const CNFG:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node);
var s:string;
begin
    if not Assigned(item) then EXIT;
    //---
    if _item_4_cnfg_customer_ROOT_(item) then begin
        // --- Про Имя
       _cnfg_customer_ROOT_.NameCustom:=TRUE;
        s:=CNFG.NameStated;
        // исключаем "ЗАПРЕЩЕННЫЕ"
       _macross_APPLAY_(s, _cMacrosNAME_crNewNAME_,'');
       _macross_APPLAY_(s, _cMacrosNAME_crNewPATH_,'');
       _cnfg_customer_ROOT_.NameStated:=trim(s);
        // --- Про ПУТЬ
       _cnfg_customer_ROOT_.PathCustom:=TRUE;
        s:=CNFG.PathStated;
        // исключаем "ЗАПРЕЩЕННЫЕ"
       _macross_APPLAY_(s, _cMacrosNAME_crNewNAME_,'');
       _macross_APPLAY_(s, _cMacrosNAME_crNewPATH_,'');
       _cnfg_customer_ROOT_.PathStated:=trim(s);
        //---
       _macross_reClc_;
    end
   else
    if item is tSrcTree_fsFILE then begin
       _cnfg_customer_FILE_.CNFG_SET(tSrcTree_fsFILE(item).fsBase,CNFG)
    end
   else
    if item is tSrcTree_fsFLDR then begin
      _cnfg_customer_FLDR_.CNFG_SET(tSrcTree_fsFLDR(item).fsBase,CNFG)
    end
end;

function tCopyRast_stage__ChangePaths.CNFG_customer_GET(const item:tCopyRast_stITEM):tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node;
var b:boolean;
begin
    result:=nil;
    if not Assigned(item) then EXIT;
    //---
    try
    b:= _item_4_cnfg_customer_ROOT_(item)
    except
    ShowMessage('pppppppppppppppppppppppppppppppppppppppppppppp');
    end;

    try
    if b then begin
        if not Assigned(_cnfg_customer_FILE_) then ShowMessage('77777777777777777777777');
        try
        result:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node.Create;
        if item is tCopyRast_stROOT then begin
            result.NameCustom:= TRUE;
            result.NameStated:=_cnfgClc_newROOT_;
            result.PathCustom:= TRUE;
            result.PathStated:=_cnfgClc_newBASE_;
        end
       else
        if item is tCopyRast_stBASE then begin
            result.NameCustom:= TRUE;
            result.NameStated:=_cnfgClc_newROOT_;
            result.PathCustom:= TRUE;
            result.PathStated:=_cnfgClc_newBASE_;
        end
       else
        if item is tCopyRast_stMAIN then begin
            result.NameCustom:= TRUE;
            result.NameStated:=_cnfgClc_newMAIN_;
            result.PathCustom:= TRUE;
            result.PathStated:=_cnfgClc_newBASE_;
        end;
        except
        ShowMessage('999999999999999999');
        end;
    end
   else
    if item is tSrcTree_fsFILE then begin
        if not Assigned(_cnfg_customer_FILE_) then ShowMessage('5555555555555555555-555555555555555');

        try
        result:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node(_cnfg_customer_FILE_.CNFG_GET(tSrcTree_fsFILE(item).fsBase));
        except
        ShowMessage('5555555555555555555');
        end;
    end
   else
    if item is tSrcTree_fsFLDR then begin
        if not Assigned(_cnfg_customer_FILE_) then ShowMessage('666666666666666-666666666666666');
        try
        result:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node(_cnfg_customer_FLDR_.CNFG_GET(tSrcTree_fsFLDR(item).fsBase));
        except
        ShowMessage('666666666666666');
        end;
    end
    except
    ShowMessage('66666666666666677777777777777777777777777');
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// используется СОБСТВЕННОЕ название
function tCopyRast_stage__ChangePaths.CNFG_customer_NameCustom(const item:tCopyRast_stITEM):boolean;
begin
    result:=false;
    if _item_4_cnfg_customer_ROOT_(item) then begin
        if Assigned(_cnfg_customer_ROOT_) then result:=_cnfg_customer_ROOT_.NameCustom;
    end
    else
    if (item is tSrcTree_fsFILE) then begin
        if Assigned(_cnfg_customer_FILE_) then result:=_cnfg_customer_FILE_.NameCustom(tSrcTree_fsFILE(item).fsBase);
    end
    else
    if (item is tSrcTree_fsFLDR) then begin
        if Assigned(_cnfg_customer_FLDR_) then result:=_cnfg_customer_FLDR_.NameCustom(tSrcTree_fsFLDR(item).fsBase);
    end
end;

// используется СОБСТВЕННОЕ путь
function tCopyRast_stage__ChangePaths.CNFG_customer_PathCustom(const item:tCopyRast_stITEM):boolean;
begin
    result:=false;
    if _item_4_cnfg_customer_ROOT_(item) then begin
        if Assigned(_cnfg_customer_ROOT_) then result:=_cnfg_customer_ROOT_.PathCustom;
    end
    else
    if (item is tSrcTree_fsFILE) then begin
        if Assigned(_cnfg_customer_FILE_) then result:=_cnfg_customer_FILE_.PathCustom(tSrcTree_fsFILE(item).fsBase);
    end
    else
    if (item is tSrcTree_fsFLDR) then begin
        if Assigned(_cnfg_customer_FLDR_) then result:=_cnfg_customer_FLDR_.PathCustom(tSrcTree_fsFLDR(item).fsBase);
    end
end;

//------------------------------------------------------------------------------

procedure tCopyRast_stage__ChangePaths.CNFG_template_SET(const item:tSrcTree_item; const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
begin
    {$ifOpt D+}
    Assert(Assigned(item));
    {$endIf}
    if item is tSrcTree_ROOT then begin
       _cnfg_template_ROOT_.COPY(value);
       _macross_reClc_;
    end
   else begin
       _cnfg_template_LAER_.CNFG_SET(_tSrcTree_item_fsNodeFLDR_(item).fsBase, value);
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCopyRast_stage__ChangePaths._template_GET_link_(const item:tSrcTree_item):tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
begin
    {$ifOpt D+}
    Assert(Assigned(item));
    {$endIf}
    if Assigned(item.ItemPRNT) then begin
        result:=_cnfg_template_LAER_.CNFGS_GET(_tSrcTree_item_fsNodeFLDR_(item).fsBase);
	end
    else begin // нет родителя => берем типа ВЕРХНИЙ
        result:=_cnfg_template_ROOT_;
	end;
end;

procedure tCopyRast_stage__ChangePaths._template_MakeLIST_(const item:tSrcTree_item; const list:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List; const ENABLED_only:boolean; const asParent,asEnable:boolean);
var as_Prnt:tSrcTree_item;
    itmList:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
    tmpRule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
var i:integer;
begin
    if not Assigned(item) then EXIT;
    //------------------------------

    // метка про РОДИТЕЛЯ
    if asParent then as_Prnt:=item
    else as_Prnt:=nil;

    // посик ЛИЧНОГО списка
    itmList:=_template_GET_link_(item);

    // Формирование списка
    if not Assigned(itmList) then begin
        // НИКАИХ правил НЕ указано => ПО УМОЛЧАНИЮ => добавляем родительские
       _template_MakeLIST_(item.ItemPRNT,list,ENABLED_only,TRUE,TRUE);
	end
    else begin
        if not itmList.PrntRules_MarkPRESENT then begin
           // Меток родительского НЕТ => добавляем родительские в НАЧАЛО
           if itmList.PrntRules_USE or (not ENABLED_only) then begin
              _template_MakeLIST_(item.ItemPRNT,list,ENABLED_only,TRUE, itmList.PrntRules_USE);
        end;
		end;
        for i:=0 to itmList.Count-1 do begin
            if itmList.Items[i].isInherited_MARK then begin
                // встретили метку для РОДИТЕЛЬСКИХ
                if itmList.PrntRules_USE or (not ENABLED_only) then begin
                   _template_MakeLIST_(item.ItemPRNT,list,ENABLED_only,TRUE, itmList.PrntRules_USE);
                end;
            end
            else begin
                tmpRule:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule.Create(as_Prnt);
                tmpRule.COPY(itmList.Items[i]);
                tmpRule.Enabled:=tmpRule.Enabled and asEnable;
                list.Add(tmpRule);
            end;
		end;
	end;
end;


function tCopyRast_stage__ChangePaths.CNFG_template_GET(const item:tSrcTree_item):tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
begin
    {$ifOpt D+}
    Assert(Assigned(item));
    {$endIf}
    result:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_List.Create;
   _template_MakeLIST_(item,result,FALSE,false,true);
   {
    if item is tSrcTree_ROOT then begin
        result:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_List.Create;
        result.COPY(_cnfg_template_ROOT_);
    end
   else begin
        result:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_List(_cnfg_template_LAER_.CNFG_GET(_tSrcTree_item_fsNodeFLDR_(item).fsBase));
    end; }
end;

// Кол-во шаблонов указанных в ЭТОМ узле
function tCopyRast_stage__ChangePaths.CNFG_template_count(const item:tSrcTree_item):integer;
var itmList:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
begin
    if not Assigned(item) then EXIT(0);
    //------------------------------
    // посик ЛИЧНОГО списка
    itmList:=_template_GET_link_(item);
    if Assigned(itmList) then result:=itmList.Count
    else result:=0;
end;


//==============================================================================

function tCopyRast_stage__ChangePaths.RSLT_wasReNamed(const item:tCopyRast_stITEM):boolean;
var temp:tSrcTree_item;
begin
    if not Assigned(item) then EXIT(false);
    //-------------------------------------
    temp:=CopyRAST_stITEM_DATA(item)^.sideLeft;
    if Assigned(temp)
    then result:=temp.ItemNAME<>item.ItemNAME
    else result:=TRUE;
end;

(*


{function tCopyRast_stage__ChangePaths.CNFGs4NAME_GET(const item:tSrcTree_item):tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME;
begin
   _CNFGs4NAME_.CLEAR;
    result:=_CNFGs4NAME_;
    if not Assigned(item) then EXIT;
    //---
    if item is tSrcTree_ROOT then begin
        //result.Copy(_cnfg_customer_ROOT_);
    end
   else
    if item is tSrcTree_BASE then begin
        //result.Copy(_cnfg_customer_ROOT_);
    end
   else
    if item is tSrcTree_MAIN then begin
        //result.Copy(_cnfg_customer_ROOT_);
    end
   else
    if item is tSrcTree_fsFILE then begin
       // _CNFGs4NAME_GET_(_cnfg_customer_FILE_,item,result);
    end
   else
    if item is tSrcTree_fsFLDR then begin
       //  _CNFGs4NAME_GET_(_cnfg_customer_FLDR_,item,result);
    end
end;}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


//------------------------------------------------------------------------------

function tCopyRast_stage__ChangePaths.Validate_FLDR(const value:string):boolean;
begin {todo: добавить СЕРЪЕЗНУЮ проверку}
    result:=Trim(value)<>'';
end;

function tCopyRast_stage__ChangePaths.Validate_FILE(const value:string):boolean;
begin {todo: добавить СЕРЪЕЗНУЮ проверку}
    result:=Trim(value)<>'';
end;


//------------------------------------------------------------------------------

*)


//------------------------------------------------------------------------------

const
  c_Replaced=0;
  c_NoNEED  =1;
  c_notFound=2;


function tCopyRast_stage__ChangePaths._template_APPLAY_RULE_4item_(const srcItem:tSrcTree_item; const rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule):boolean;
begin
    if srcItem is tCopyRastNODE_FLDR then result:=rule.Use4FLDR
   else
    if srcItem is tCopyRastNODE_FILE then result:=rule.Use4FILE;



end;

function tCopyRast_stage__ChangePaths._template_APPLAY_RULE_(const srcItem:tSrcTree_item; const srcName:string; const rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule; out outName:string):integer;
var tmpTemplate:string;
    tmpExchange:string;
begin
    outName:=srcName;
    result :=c_NoNEED;
    //--- парвило НЕ работает
    if not rule.Enabled then EXIT;
    //--- к этим оно НЕ применимо
    if IS_CopyRAST_stROOT(srcItem) then EXIT;
    if IS_CopyRAST_stBASE(srcItem) then EXIT;
    if IS_CopyRAST_stMAIN(srcItem) then EXIT;
    //--- для НАС оно НЕ включено
    if (srcItem is tCopyRastNODE_FILE)and(not rule.Use4FILE) then EXIT;
    if (srcItem is tCopyRastNODE_FLDR)and(not rule.Use4FLDR) then EXIT;
    //---
    tmpTemplate:=_macross_APPLAY_(rule.Template);
    tmpExchange:=_macross_APPLAY_(rule.Exchange);


    if rule.RegExUSE
    then begin
        {todo: делать МАКРОСЫ}
       _regExpr_.InputString:=srcName;
       _regExpr_.Expression :=tmpTemplate; // шаблон поиска
        if _regExpr_.Exec(1) then begin
            outName:=_regExpr_.Replace(srcName,tmpExchange,true);
            result :=c_Replaced;
        end
        else begin
            result :=c_notFound;
        end;
    end
    else begin
        {todo: делать через POS}
    end;
end;

function tCopyRast_stage__ChangePaths._template_APPLAY_LIST_(const srcItem:tSrcTree_item; const list:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List; var outName:string):integer;
var tmpName:string;
    i      :integer;
    rule   :tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    tmpName:=outName;
    if tmpName='' then tmpName:=srcItem.ItemNAME;
    //
    for i:=0 to list.Count-1 do begin
        rule:=list.Items[i];
        result:=_template_APPLAY_RULE_(srcItem,tmpName,rule,outName);
        if result=c_Replaced then begin
            tmpName:=outName; //< новая строка для поиска
            if rule.use_Last then BREAK; //< это было ПОСЛЕДНЕЕ правило
        end;
    end;
end;

function tCopyRast_stage__ChangePaths.Template_APPLAY(const srcItem:tSrcTree_item; const srcName:string; const rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule; out outName:string):integer;
begin
    result:=_template_APPLAY_RULE_(srcItem,srcName,rule,outName);
end;

end.

