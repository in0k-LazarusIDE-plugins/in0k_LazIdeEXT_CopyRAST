unit in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs;

{$mode objfpc}{$H+}

interface

uses
  Classes,

  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
  in0k_lazIdeSRC_srcTree_item_Globals,
  in0k_lazIdeSRC_srcTree_item_fsFolder,
  in0k_lazIdeSRC_srcTree_item_fsFile,


  PackageDependencyIntf,

  srcTree_builder_CORE,

  sysutils,

  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,
  in0k_lazIdeSRC_srcTree_FNK_mainFILE_FND,

  RegExpr,


srcTree_handler4build_CORE,


  in0k_CopyRAST_srcTree_ITEMs,
  in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs_CNFGs,
  lazExt_CopyRAST__xmlConfig,
  lazExt_CopyRAST__xmlConfig_approvedFILEs2NAMEs,

  in0k_CopyRAST_srcTree_Stage;

type

 {tCopyRastSrcTree_itmH4ReNAMEs_FLDR=class(tSrcTree_itmHandler4Build)
  public // ВЫПОЛНЕНИЕ
    function Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;

 tCopyRastSrcTree_itmH4ReNAMEs_FILE=class(tSrcTree_itmHandler4Build)
  public // ВЫПОЛНЕНИЕ
    function Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;}

 tCopyRast_SrcTree_stageReNAMEs_itm4file=class(tCopyRast_SrcTree_itmSTAGE)
  protected
    function _getTargetFLDR_:_tSrcTree_item_fsNodeFLDR_;
    function _newTargetFILE_(const fldr:_tSrcTree_item_fsNodeFLDR_):tCopyRastNODE_FILE;
  public
    function Processing:boolean; override; // ВЫПОЛНИТЬ обработку
  end;


 tCopyRastSrcTree_prcH4ReNAMEs=class(tCopyRast_SrcTree_prcSTAGE)
  private
   _regExpr_:TRegExpr;
  strict private
   _macross_:tStringList;
    procedure _macross_reClc_;
    function  _macross_APPLAY_CopyRAST_(const srcString:string):string;
    function  _macross_APPLAY_Lazarus_ (const srcString:string):string;
  private
    function  _macross_APPLAY_(const srcString:string):string;
  private
   _cnfg_customer_ROOT_:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node;
   _cnfg_customer_FILE_:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_LAER;
   _cnfg_customer_FLDR_:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_LAER;
   _cnfg_template_ROOT_:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
   _cnfg_template_LAER_:tCopyRAST_HandlerCNFGs_ReNAMEs_template_LAIR;
    procedure _cnfg_XXXX_CRT_;
    procedure _cnfg_XXXX_DST_;
    procedure _cnfg_XXX_LOAD_(const cnfgs:tLazExt_CopyRAST_CONFIG);
    procedure _cnfg_XXX_SAVE_(const cnfgs:tLazExt_CopyRAST_CONFIG);
  private
    function  _cnfgClc_newBASE_ (const item:tSrcTree_item):string; overload;
    function  _cnfgClc_newNAME_ (const item:tSrcTree_item):string; overload;
    function  _cnfgClc_newPATH_ (const item:tSrcTree_item):string; overload;
    function  _cnfgClc_newNameFLDR_ (const item:tSrcTree_item; out leftFLDR:tSrcTree_fsFLDR):string; overload;
  protected
    function  _get_oldName_ROOT_(const item:tSrcTree_ROOT):string;
    function  _clc_newName_ROOT_(const item:tSrcTree_ROOT):string;
    function  _clc_newName_BASE_(const item:tSrcTree_BASE):string;
    function  _clc_newName_MAIN_(const item:tSrcTree_MAIN):string;

    //function  _getNewPATH_FLDR_(const item:tCopyRastNODE_FLDR):string;
    //function  _getNewPATH_FILE_(const item:tCopyRastNODE_FILE):string;
    //procedure _prc_addNew_FLDR_(const item:tCopyRastNODE_FLDR);
    //procedure _prc_addNew_FILE_(const item:tCopyRastNODE_FILE);
  protected
    procedure _EXECUTE_; override;
  public
    procedure CNFGs_LOAD(const Configs:tLazExt_CopyRAST_CONFIG);
    procedure CNFGs_SAVE(const Configs:tLazExt_CopyRAST_CONFIG);
  public
    //procedure EXECUTE(const nodeRoot:tSrcTree_ROOT); overload;
  public
    constructor Create(const aBUILDer:tSrcTree_Builder_CORE); override;
    destructor DESTROY; override;
  protected
    //_CNFGs4NAME_:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME;
  protected
    //procedure _CNFGs4NAME_SET_(const List:TStringList; const item:tSrcTree_item; const reNames:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);
    //procedure _CNFGs4NAME_GET_(const List:TStringList; const item:tSrcTree_item; const reNames:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);
    //procedure _TMPLs4NAME_SET_(const List:TStringList; const item:tSrcTree_item; const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
    function  _template_GET_link_(const item:tSrcTree_item):tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
    procedure _template_MakeLIST_(const item:tSrcTree_item; const list:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List; const ENABLED_only:boolean; const asParent,asEnable:boolean);

  protected
    function  _template_APPLAY_RULE_(const srcItem:tSrcTree_item; const srcName:string; const rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule; out outName:string):integer;
    function  _template_APPLAY_LIST_(const srcItem:tSrcTree_item; const list:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List; out outName:string):integer;


  public
    procedure CNFG_customer_SET(const item:tSrcTree_item; const CNFG:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node);
    function  CNFG_customer_GET(const item:tSrcTree_item):tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node;
    procedure CNFG_template_SET(const item:tSrcTree_item; const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
    function  CNFG_template_GET(const item:tSrcTree_item):tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
  public
    function  Validate_FLDR(const value:string):boolean;
    function  Validate_FILE(const value:string):boolean;
  public
    function  Template_APPLAY(const srcItem:tSrcTree_item; const srcName:string; const rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule; out outName:string):integer;
  public
    //property ROOT_old:tSrcTree_item read _execRoot_;// write _nodeRoot_;
  end;

implementation

{%region --- tCopyRast_SrcTree_stageReNAMEs_itm4file ------------------- }

// получить-СОЗДАТЬ НОВУЮ папку для prcssdITEM
function tCopyRast_SrcTree_stageReNAMEs_itm4file._getTargetFLDR_:_tSrcTree_item_fsNodeFLDR_;
var tmpLeft:tSrcTree_item;
var tmpPATH:string;
    tmpKING:sSrcTree_SrchPath;
begin
    result:=nil;
    // ищем СТРОКУ-ПУТЬ и применяем МАКРОСЫ
    tmpPATH:=tCopyRastSrcTree_prcH4ReNAMEs(_OWNER_)._cnfgClc_newNameFLDR_(prcssdITEM, tSrcTree_fsFLDR(tmpLeft));
    tmpPATH:=tCopyRastSrcTree_prcH4ReNAMEs(_OWNER_)._macross_APPLAY_(tmpPATH);
    // ищем НАБОР "путиПоиска"
    tmpKING:=[];
    if Assigned(tmpLeft) then tmpKING:=tSrcTree_fsFLDR(tmpLeft).inSearchPATHs
    else begin
        // ищем ОТКУДА брать поисковые пути
        tmpLeft:=SrcTree_fsFolder__fnd_PARENT(prcssdITEM);
        if Assigned(tmpLeft) then begin
            tmpKING:=tSrcTree_fsFLDR(tmpLeft).inSearchPATHs;
        end;
        tmpLeft:=nil;
    end;
    // ищем НОВУЮ папку
    if tmpPATH=''
    then result:=SrcTree_fndBaseDIR(ROOT_Target) //< тут видимо берем БАЗОВУЮ папку
    else begin
        result:=Builder.add_FLDR(ROOT_Target,tmpPATH,tmpKING); {todo:!!!!!!!!}
        // вяжем
        if Assigned(tmpLeft) then CopyRastNODE_LINK(tmpLeft,result);
    end;
end;

function tCopyRast_SrcTree_stageReNAMEs_itm4file._newTargetFILE_(const fldr:_tSrcTree_item_fsNodeFLDR_):tCopyRastNODE_FILE;
var tmpNAME:string;
begin
    // ищем СТРОКУ-НАЗВАНИЕ и применяем МАКРОСЫ
    tmpNAME:=tCopyRastSrcTree_prcH4ReNAMEs(_OWNER_)._cnfgClc_newNAME_(prcssdITEM);
    tmpNAME:=tCopyRastSrcTree_prcH4ReNAMEs(_OWNER_)._macross_APPLAY_(tmpNAME);
    //
    if tmpNAME<>'' then begin
        tmpNAME:=srcTree_fsFnk_ConcatPaths(fldr.fsPath,tmpNAME);
        result :=tCopyRastNODE_FILE(Builder.add_FILE(ROOT_Target,tmpNAME,tCopyRastNODE_FILE(prcssdITEM).fileKIND));
        CopyRastNODE_LINK(tCopyRastNODE_FILE(prcssdITEM),result);
    end
    else begin
        {todo: про ОШИБКИ !}
    end;
end;

function tCopyRast_SrcTree_stageReNAMEs_itm4file.Processing:boolean;
var tmpFLDR:_tSrcTree_item_fsNodeFLDR_;
begin //
    if prcssdITEM is tCopyRastNODE_FILE then begin //< работаем ТОЛЬКО с ФАЙЛАМИ
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

////////////////////////////////////////////////////////////////////////////////

constructor tCopyRastSrcTree_prcH4ReNAMEs.Create(const aBUILDer:tSrcTree_Builder_CORE);
begin
    inherited;
   _regExpr_ :=TRegExpr.Create;
   _macross_ :=TStringList.Create;
   _macross_.Add('MainNewName=ttttt');

    //---
   _cnfg_XXXX_CRT_;
    //---
  // _CNFGs4NAME_:=tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME.Create;
end;

destructor tCopyRastSrcTree_prcH4ReNAMEs.DESTROY;
begin
    inherited;

   _macross_ .FREE;
   _cnfg_XXXX_DST_;

   _regExpr_.FREE;
  // _CNFGs4NAME_.FREE;
  // _newROOT_.FREE;
end;

//------------------------------------------------------------------------------

(*function tCopyRastSrcTree_prcH4ReNAMEs._get_newFLDR_(const item:tSrcTree_item; out fldrPATH:string; out fldrKIND:sSrcTree_SrchPath; out leftFLDR:tCopyRastNODE_FLDR):boolean;
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

{function tCopyRastSrcTree_prcH4ReNAMEs._cnfgClc_newNAME_(const item:tSrcTree_item; out fileName:string; out fileKIND:eSrcTree_FileType):boolean;
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

{%region --- _cnfgClc_XXX.. ---------------------------------------------}

function tCopyRastSrcTree_prcH4ReNAMEs._cnfgClc_newBASE_(const item:tSrcTree_item):string;
var ctm:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node;
begin
    result:='';
    if item is tSrcTree_BASE then begin
        ctm:=CNFG_customer_GET(item); // проверим ЯВНОЕ указание имен
        if (Assigned(ctm))and(ctm.PathCustom) then begin
            result:=ctm.PathStated;
        end;
        if result='' then begin {todo: имя по умолчанию?}
            result:=_tSrcTree_item_fsBaseDIR_(item).ItemNAME+'_CopyRAST';
        end;
        ctm.FREE;
    end
    else begin
        if Assigned(item.ItemPRNT) then result:=_cnfgClc_newBASE_(item.ItemPRNT);
    end;
end;

function tCopyRastSrcTree_prcH4ReNAMEs._cnfgClc_newNAME_(const item:tSrcTree_item):string;
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
           _template_MakeLIST_(item,lst,TRUE,false,true);
           _template_APPLAY_LIST_(item,lst,result);
            lst.FREE;
        end;
        ctm.FREE;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// расчитать новы ПУТЬ
function tCopyRastSrcTree_prcH4ReNAMEs._cnfgClc_newPATH_(const item:tSrcTree_item):string;
var tmp:tSrcTree_fsFLDR;
begin
    result:=_cnfgClc_newNameFLDR_(item,tmp);
end;

// расчитываем новый путь .. начинаем с себя и идем ВВЕРХ по дереву
function tCopyRastSrcTree_prcH4ReNAMEs._cnfgClc_newNameFLDR_(const item:tSrcTree_item; out leftFLDR:tSrcTree_fsFLDR):string;
var ctm:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node;
    tmpName:string;
begin {todo: уйти от рекурсии}
    result:='';
    leftFLDR:=nil;
    if item is tSrcTree_BASE then begin // это УЖе базовая папка => выше НЕ поднимаемся
        result  :='';
        leftFLDR:=tSrcTree_fsFLDR(item);
    end
   else
    if item is tSrcTree_fsFLDR then begin // это ПАПКА .. работаем
        // ищем свое ИМЯ
        tmpName:=_cnfgClc_newNAME_(item);
        // ищем свой ПУТЬ
        ctm:=CNFG_customer_GET(item); // проверим ЯВНОЕ указание
        if (Assigned(ctm))and(ctm.PathCustom) then begin
            result:=ctm.PathStated;
        end
        else begin // путь для нас ЯВНО не указан, считаем путь по родителю
            if Assigned(item.ItemPRNT) then begin
                result:=_cnfgClc_newNameFLDR_(item.ItemPRNT,leftFLDR);
            end;
        end;
        ctm.FREE;
        // и по финалу, соединяем свое НОВОЕ имя и НОВЫЙ путь родителя
        result:=srcTree_fsFnk_ConcatPaths(result,tmpName);
        leftFLDR:=tSrcTree_fsFLDR(item);
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






//------------------------------------------------------------------------------

{%region -- _clc_..Name.. -----------------------------------------------}

function tCopyRastSrcTree_prcH4ReNAMEs._get_oldName_ROOT_(const item:tSrcTree_ROOT):string;
begin
    {$ifOpt D+}
    Assert(Assigned(item));
    Assert(IS_CopyRAST_stROOT(item));
    {$endIf}
    result:=item.ItemTEXT;
end;

// расчитать Имя: ROOT файла
// берем ИМЯ главного файла и УДАЛЯЕМ расширение
function tCopyRastSrcTree_prcH4ReNAMEs._clc_newName_ROOT_(const item:tSrcTree_ROOT):string;
var itmMAIN:tSrcTree_MAIN;
begin
    itmMAIN:=SrcTree_fndMainFILE(item);
    if Assigned(itmMAIN) then begin
        result:=_clc_newName_MAIN_(itmMAIN);
        result:=srcTree_fsFnk_ExtractFileNameOnly(result);
    end
    else begin
        result:=item.ItemNAME;
    end;
end;

// расчитать Имя: (ПУТЬ) базовой папки
function tCopyRastSrcTree_prcH4ReNAMEs._clc_newName_BASE_(const item:tSrcTree_BASE):string;
begin
    result:=_cnfgClc_newBASE_(item);
end;

// расчитать Имя: ГЛАВНОГО файла
function tCopyRastSrcTree_prcH4ReNAMEs._clc_newName_MAIN_(const item:tSrcTree_MAIN):string;
var itmMAIN:tSrcTree_MAIN;
    tmp_ext:string;
begin
    itmMAIN:=(item);
    if Assigned(itmMAIN) then begin
        // берем ИМЯ
        result:=_cnfgClc_newNAME_(itmMAIN);
        // проверим разрешение
        tmp_ext:=srcTree_fsFnk_ExtractFileExt(result);
        if tmp_ext='' then begin
            tmp_ext:=srcTree_fsFnk_ExtractFileExt(item.fsName);
            result :=srcTree_fsFnk_ChangeFileExt(result,tmp_ext)
        end;
    end
    else begin
        result:=item.ItemNAME;
    end;
end;

{%endregion}


//function tCopyRastSrcTree_prcH4ReNAMEs._getNewPATH_FLDR_(const item:tCopyRastNODE_FLDR):string;
//begin
//    result:={ccc+}item.fsPath;
//end;

//function tCopyRastSrcTree_prcH4ReNAMEs._getNewPATH_FILE_(const item:tCopyRastNODE_FILE):string;
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


{procedure tCopyRastSrcTree_prcH4ReNAMEs._prc_AddNew_FLDR_(const item:tCopyRastNODE_FLDR);
var tmp:tCopyRastNODE_FLDR;
begin // создадим и свяжем
    tmp:=tCopyRastNODE_FLDR(_builder_.add_FLDR(_newROOT_, _getNewPATH_FLDR_(item), item.inSearchPATHs ));
    CopyRastNODE_LINK(item,tmp);
end;}

{procedure tCopyRastSrcTree_prcH4ReNAMEs._prc_AddNew_FILE_(const item:tCopyRastNODE_FILE);
var tmp:tCopyRastNODE_FILE;
begin // создадим и свяжем
    tmp:=tCopyRastNODE_FILE(_builder_.add_FILE(_newROOT_, {item.ItemPRNT.fsPath+'\'+}_getNewPATH_FILE_(item), item.fileKIND ));
    CopyRastNODE_LINK(item,tmp);
end;}

//------------------------------------------------------------------------------

procedure tCopyRastSrcTree_prcH4ReNAMEs._EXECUTE_;
var tmpItem:tCopyRast_stITEM;
    tmpName:string;
begin
    // переустановим НОВОЕ имя для ВСЕГО проекта
    tmpItem:=_targetROOT_GET_;
    if Assigned(tmpItem) and IS_CopyRAST_stROOT(tmpItem) then begin
        tmpName:=_clc_newName_ROOT_(_sourceROOT_GET_);
        SrcTree_re_set_itemTEXT(tmpItem,tmpName);
    end
    else begin
        {todo: про ОШИБКИ !}
    end;
    // переустановим НОВЫЙ путь к БАЗОВОЙ папке
    tmpItem:=_builder_.fnd_BASE(_targetROOT_GET_);
    if Assigned(tmpItem) and IS_CopyRAST_stBASE(tmpItem) then begin
        tmpName:=_clc_newName_BASE_(_builder_.fnd_BASE(_sourceROOT_GET_));
        SrcTree_re_set_itemTEXT(tmpItem,tmpName);
    end
    else begin
        {todo: про ОШИБКИ !}
    end;
    // переустановим НОВОЕ имя для ФАЙЛА проекта
    tmpItem:=_builder_.fnd_MAIN(_targetROOT_GET_);
    if Assigned(tmpItem) and IS_CopyRAST_stMAIN(tmpItem) then begin
        tmpName:=_clc_newName_MAIN_(_builder_.fnd_MAIN(_sourceROOT_GET_));
        SrcTree_re_set_itemTEXT(tmpItem,tmpName);
    end
    else begin
        {todo: про ОШИБКИ !}
    end;
    //
    // теперь про ОСТАЛЬНЫЕ файлы
   _macross_reClc_;
    EXECUTE_4TREE(tCopyRast_SrcTree_stageReNAMEs_itm4file);
end;

(*procedure tCopyRastSrcTree_prcH4ReNAMEs.EXECUTE(const nodeRoot:tSrcTree_ROOT);
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

procedure tCopyRastSrcTree_prcH4ReNAMEs.CNFGs_LOAD(const Configs:tLazExt_CopyRAST_CONFIG);
begin
   _cnfg_XXX_LOAD_(Configs);
end;

procedure tCopyRastSrcTree_prcH4ReNAMEs.CNFGs_SAVE(const Configs:tLazExt_CopyRAST_CONFIG);
begin
   _cnfg_XXX_SAVE_(Configs);
end;

//------------------------------------------------------------------------------

{procedure tCopyRastSrcTree_prcH4ReNAMEs._CNFGs4NAME_SET_(const List:TStringList; const item:tSrcTree_item; const reNames:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);
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

{procedure tCopyRastSrcTree_prcH4ReNAMEs._CNFGs4NAME_GET_(const List:TStringList; const item:tSrcTree_item; const reNames:tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME);
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

(*procedure tCopyRastSrcTree_prcH4ReNAMEs._TMPLs4NAME_SET_(const List:TStringList; const item:tSrcTree_item; const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
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

function _item_4_cnfg_customer_ROOT_(const item:tSrcTree_item):boolean;
begin
    result:=false;
    //---
    if item is tSrcTree_ROOT then result:=true
   else
    if item is tSrcTree_BASE then result:=true
   else
    if item is tSrcTree_MAIN then result:=true;
end;

procedure tCopyRastSrcTree_prcH4ReNAMEs.CNFG_customer_SET(const item:tSrcTree_item; const CNFG:tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node);
begin
    if not Assigned(item) then EXIT;
    //---
    if _item_4_cnfg_customer_ROOT_(item) then begin
       _cnfg_customer_ROOT_.Copy(CNFG);
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

function tCopyRastSrcTree_prcH4ReNAMEs.CNFG_customer_GET(const item:tSrcTree_item):tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node;
begin
    result:=nil;
    if not Assigned(item) then EXIT;
    //---
    if _item_4_cnfg_customer_ROOT_(item) then begin
        result:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node.Create;
        result.COPY(_cnfg_customer_ROOT_);
    end
   else
    if item is tSrcTree_fsFILE then begin
        result:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node(_cnfg_customer_FILE_.CNFG_GET(tSrcTree_fsFILE(item).fsBase));
    end
   else
    if item is tSrcTree_fsFLDR then begin
        result:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node(_cnfg_customer_FLDR_.CNFG_GET(tSrcTree_fsFILE(item).fsBase));
    end
end;

//------------------------------------------------------------------------------

procedure tCopyRastSrcTree_prcH4ReNAMEs.CNFG_template_SET(const item:tSrcTree_item; const value:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List);
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

function tCopyRastSrcTree_prcH4ReNAMEs._template_GET_link_(const item:tSrcTree_item):tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
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


procedure tCopyRastSrcTree_prcH4ReNAMEs._template_MakeLIST_(const item:tSrcTree_item; const list:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List; const ENABLED_only:boolean; const asParent,asEnable:boolean);
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

function tCopyRastSrcTree_prcH4ReNAMEs.CNFG_template_GET(const item:tSrcTree_item):tCopyRAST_HandlerCNFGs_ReNAMEs_template_List;
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


{function tCopyRastSrcTree_prcH4ReNAMEs.CNFGs4NAME_GET(const item:tSrcTree_item):tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME;
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

procedure tCopyRastSrcTree_prcH4ReNAMEs._cnfg_XXXX_CRT_;
begin
   _cnfg_customer_ROOT_:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_node.Create;
   _cnfg_customer_FLDR_:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_LAER.Create;
   _cnfg_customer_FILE_:=tCopyRAST_HandlerCNFGs_ReNAMEs_customer_LAER.Create;
    //---
   _cnfg_template_ROOT_:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_List.Create;
   _cnfg_template_LAER_:=tCopyRAST_HandlerCNFGs_ReNAMEs_template_LAIR.Create;
end;

procedure tCopyRastSrcTree_prcH4ReNAMEs._cnfg_XXXX_DST_;
begin
   _cnfg_customer_ROOT_.FREE;
   _cnfg_customer_FLDR_.FREE;
   _cnfg_customer_FILE_.FREE;
    //---
   _cnfg_template_ROOT_.FREE;
   _cnfg_template_LAER_.FREE;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tCopyRastSrcTree_prcH4ReNAMEs._cnfg_XXX_LOAD_(const cnfgs:tLazExt_CopyRAST_CONFIG);
begin
    CRxC_aF2N__customerROOT__Load(cnfgs,'',_cnfg_customer_ROOT_);
    CRxC_aF2N__customerFLDR__Load(cnfgs,'',_cnfg_customer_FLDR_);
    CRxC_aF2N__customerFILE__Load(cnfgs,'',_cnfg_customer_FILE_);
    //
    CRxC_aF2N__templateROOT__Load(cnfgs,'',_cnfg_template_ROOT_);
    CRxC_aF2N__templateLAIR__Load(cnfgs,'',_cnfg_template_LAER_);
end;

procedure tCopyRastSrcTree_prcH4ReNAMEs._cnfg_XXX_SAVE_(const cnfgs:tLazExt_CopyRAST_CONFIG);
begin
    CRxC_aF2N__customerROOT__Save(cnfgs,'',_cnfg_customer_ROOT_);
    CRxC_aF2N__customerFLDR__Save(cnfgs,'',_cnfg_customer_FLDR_);
    CRxC_aF2N__customerFILE__Save(cnfgs,'',_cnfg_customer_FILE_);
    //
    CRxC_aF2N__templateROOT__Save(cnfgs,'',_cnfg_template_ROOT_);
    CRxC_aF2N__templateLAIR__Save(cnfgs,'',_cnfg_template_LAER_);
end;

//------------------------------------------------------------------------------

function tCopyRastSrcTree_prcH4ReNAMEs.Validate_FLDR(const value:string):boolean;
begin {todo: добавить СЕРЪЕЗНУЮ проверку}
    result:=Trim(value)<>'';
end;

function tCopyRastSrcTree_prcH4ReNAMEs.Validate_FILE(const value:string):boolean;
begin {todo: добавить СЕРЪЕЗНУЮ проверку}
    result:=Trim(value)<>'';
end;


//------------------------------------------------------------------------------

{%region -- _macros_ ----------------------------------------------------}

const
  _cMacrosSMBL_equal_    ='=';
  _cMacrosNAME_crOldNAME_='crOldNAME';
  _cMacrosNAME_crNewNAME_='crNewNAME';

// переСоздаем список НАШИХ макросов
procedure tCopyRastSrcTree_prcH4ReNAMEs._macross_reClc_;
begin
   _macross_.Clear;
    // заполним ЗАНОГО
   _macross_.Add(_cMacrosNAME_crOldNAME_+_cMacrosSMBL_equal_+_get_oldName_ROOT_(_sourceROOT_GET_));
   _macross_.Add(_cMacrosNAME_crNewNAME_+_cMacrosSMBL_equal_+_clc_newName_ROOT_(_targetROOT_GET_));
end;

//------------------------------------------------------------------------------

function tCopyRastSrcTree_prcH4ReNAMEs._macross_APPLAY_CopyRAST_(const srcString:string):string;
var i:integer;
begin
    result:=srcString;//'($MainNewName)';
    //---
   _regExpr_.ModifierI:=TRUE;
    for i:=0 to _macross_.Count-1 do begin
       _regExpr_.InputString:=result;
       _regExpr_.Expression :='(\$\('+_macross_.Names[i]+'\))'; // шаблон поиска
        if _regExpr_.Exec(1) then begin
            result:=_regExpr_.Replace(result,_macross_.Values[_macross_.Names[i]],FALSE);
        end
    end;
end;

function tCopyRastSrcTree_prcH4ReNAMEs._macross_APPLAY_Lazarus_ (const srcString:string):string;
begin
    {todo: DO it!}
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tCopyRastSrcTree_prcH4ReNAMEs._macross_APPLAY_(const srcString:string):string;
begin
    result:=srcString;
    result:=_macross_APPLAY_CopyRAST_(result);
    result:=_macross_APPLAY_Lazarus_ (result);
end;

{%endRegion}

//------------------------------------------------------------------------------

const
  c_Replaced=0;
  c_NoNEED  =1;
  c_notFound=2;


function tCopyRastSrcTree_prcH4ReNAMEs._template_APPLAY_RULE_(const srcItem:tSrcTree_item; const srcName:string; const rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule; out outName:string):integer;
var tmpTemplate:string;
    tmpExchange:string;
begin
    outName:=srcName;
    result :=c_NoNEED;
    //---
    if not rule.Enabled then EXIT;
    //---
    if IS_CopyRAST_stROOT(srcItem) then EXIT;
    if IS_CopyRAST_stBASE(srcItem) then EXIT;
    if IS_CopyRAST_stMAIN(srcItem) then EXIT;
    //
    if (srcItem is tCopyRastNODE_FILE)and(not rule.Use4FILE) then EXIT;
    if (srcItem is tCopyRastNODE_FLDR)and(not rule.Use4FLDR) then EXIT;
    //---
    tmpTemplate:=_macross_APPLAY_(rule.Template);
    tmpExchange:=_macross_APPLAY_(rule.Exchange);


    if rule.RegExUSE then begin
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

function tCopyRastSrcTree_prcH4ReNAMEs._template_APPLAY_LIST_(const srcItem:tSrcTree_item; const list:tCopyRAST_HandlerCNFGs_ReNAMEs_template_List; out outName:string):integer;
var srcName:string;
    i      :integer;
    rule   :tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule;
begin
    srcName:=srcItem.ItemNAME;
    for i:=0 to list.Count-1 do begin
        rule:=list.Items[i];
        result:=_template_APPLAY_RULE_(srcItem,srcName,rule,outName);
        if result=c_Replaced then begin
            srcName:=outName; //< новая строка для поиска
            if rule.use_Last then BREAK; //< это было ПОСЛЕДНЕЕ правило
        end;
    end;
end;

function tCopyRastSrcTree_prcH4ReNAMEs.Template_APPLAY(const srcItem:tSrcTree_item; const srcName:string; const rule:tCopyRAST_HandlerCNFGs_ReNAMEs_template_rule; out outName:string):integer;
begin
    result:=_template_APPLAY_RULE_(srcItem,srcName,rule,outName);
end;

end.

