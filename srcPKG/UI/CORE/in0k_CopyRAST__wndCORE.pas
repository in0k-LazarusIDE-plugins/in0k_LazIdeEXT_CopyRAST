unit in0k_CopyRAST__wndCORE;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
{$define _DEBUG_}

uses
  {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}in0k_lazIdeSRC_DEBUG,{$endIf}

  IDEIntf, IDEImagesIntf,
  ProjectIntf,  LazIDEIntf,       LCLVersion,
  PackageIntf,
  lazExt_CopyRAST__xmlConfig,
  lazExt_CopyRAST__xmlConfig_Base,

  cmpCopyRAST_srcTree,
  in0k_CopyRAST_STAGEs, in0k_CopyRAST__frmSTAGE_twoTree,

  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,

  Classes, SysUtils, FileUtil, CheckBoxThemed, DividerBevel, ExtendedNotebook,
  Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, ActnList, Types;



type

  { TwndCopyRAST_CORE }

 tWndCopyRAST_CORE=class(TForm)
    a_STG_reFresh: TAction;
    a_wnd_CANSEL: TAction;
    a_wnd_OK: TAction;
    a_wnd_Applay: TAction;
    ActionList1: TActionList;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    CheckBoxThemed1: TCheckBoxThemed;
    frmCopyRAST_STAGE_twoTree1: TfrmCopyRAST_STAGE_twoTree;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    TabSheet1: TTabSheet;
    TabSheet_Stage_0: TTabSheet;
    TabSheet_Stage_1: TTabSheet;
    TabSheet_Stage_2: TTabSheet;
    TabSheet_Stage_3: TTabSheet;
    TabSheet_Stage_4: TTabSheet;
    TabSheet_Stage_5: TTabSheet;
    TabSheet8: TTabSheet;
    procedure a_STG_reFreshExecute(Sender: TObject);
    procedure a_wnd_ApplayExecute(Sender: TObject);
    procedure a_wnd_CANSELExecute(Sender: TObject);
    procedure a_wnd_OKExecute(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ExtendedNotebook1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure PageControl1Change(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure TabSheet3ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure TabSheet3Enter(Sender: TObject);
    procedure TabSheet_Stage_0Show(Sender: TObject);
    procedure TabSheet_Stage_1Show(Sender: TObject);
  protected
    function _getConfigFileName_IDE_:string; virtual;
    function _getConfigFileName_EXT_:string;
  protected
    function  _init_ConfigFileName_fndIn_IDE_:boolean;
    function  _init_ConfigFileName_fndIn_EXT_:boolean;
    procedure _init_ConfigFileName_fndIn;
    procedure _init_ConfigFileName_;
  strict private
    function _stage_is_LOCK_(const stageIdx:integer):boolean;
  strict private
   _pages_LST_:integer;
    function _pages_Is_begin_(const tabIndx:integer  ):boolean;
    function _pages_Is_begin_(const tabShet:TTabSheet):boolean;

    function _pages_Is_STAGE_(const tabIndx:integer  ):boolean;
    function _pages_Is_STAGE_(const tabShet:TTabSheet):boolean;
    function _pages_getSTAGE_(const tabIndx:integer  ):integer;
    function _pages_getSTAGE_(const tabShet:TTabSheet):integer;
    function _pages_Enabled_ (const tabIndx:integer  ):boolean;

    function _pages_Is_final_(const tabIndx:integer  ):boolean;
    function _pages_Is_final_(const tabShet:TTabSheet):boolean;

  strict private
   _stageImgIDX_bbb_:integer;
    //---
   _stageImgIDX_DIS_:integer;
   _stageImgIDX_ENB_:integer;
   _stageImgIDX_WRK_:integer;
    //---
   _stageImgIDX_eOk_:integer;
   _stageImgIDX_eER_:integer;
  private
    function _getImageIDX_bbb_:integer;
    function _getImageIDX_DIS_:integer;
    function _getImageIDX_ENB_:integer;
    function _getImageIDX_WRK_:integer;
    function _getImageIDX_eEr_:integer;
    function _getImageIDX_eOk_:integer;
  private
    function _wndName_calc_:string;
    function _wndCptn_calc_:string;
  protected
    procedure _CNFG_LOAD_(const inIDE:boolean);
    procedure _CNFG_loadDO_(const cnf:tLazExt_CopyRAST_CONFIG);
    procedure _CNFG_Save_(const inIDE:boolean);
    procedure _CNFG_saveDO_(const cnf:tLazExt_CopyRAST_CONFIG);
  protected
   _parentOBJ_:TObject;     //< объект над которым работаем (LazIDE)
   _parentFRM_:TCustomForm; //< форма которая нас вызвала (LazIDE)
  protected
   _cpRastObj_:tCopyRAST_STAGEs; //< объект над которым работаем
    function   _copyRastObj_CRT_:tCopyRAST_STAGEs; virtual;
    procedure  _copyRastObj_DST_;

  protected

    procedure _stages_reIMAGE_;
  protected
    procedure _STAGES_onCLEAN_(const Sender:tCopyRAST_STAGEs; const stageIndex:integer);
    procedure _STAGES_onSTAGE_(const Sender:tCopyRAST_STAGEs; const stageIndex:integer);

  protected
   _view_stage0_files_:tCmpCopyRAST_srcTree;
  public
    procedure Init(const ParentOBJ:TObject; const ParentFRM:TCustomForm);
  public
    constructor Create(AOwner:TComponent); override;
    destructor DESTROY; override;
  public
    class function ide_CoreName:string; virtual;
    class function ide_Name4OBJ(const OBJ:TLazProject):string; overload;
    class function ide_Name4OBJ(const OBJ:TIDEPackage):string; overload;
  end;

implementation

{$R *.lfm}


constructor tWndCopyRAST_CORE.Create(AOwner:TComponent);
begin
    inherited;
   _parentOBJ_:=nil;
   _parentFRM_:=nil;
   _cpRastObj_:=nil;
    //
   _stageImgIDX_bbb_:=-1;
   _stageImgIDX_DIS_:=-1;
   _stageImgIDX_ENB_:=-1;
   _stageImgIDX_WRK_:=-1;
   _stageImgIDX_eER_:=-1;
   _stageImgIDX_eOk_:=-1;
    //
    PageControl1.ActivePageIndex:=0;
    PageControl1.Images:=IDEImages.Images_16;
    //
   _view_stage0_files_:=tCmpCopyRAST_srcTree.Create(self);
   _view_stage0_files_.Parent:=TabSheet_Stage_0;
   _view_stage0_files_.Align:=alClient;
end;

destructor tWndCopyRAST_CORE.DESTROY;
begin
   _copyRastObj_DST_;
    //---
    inherited;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tWndCopyRAST_CORE.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    CloseAction:=caFree;
end;

//------------------------------------------------------------------------------

procedure tWndCopyRAST_CORE.PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
var nxtPage:integer;
begin
    with TPageControl(Sender) do nxtPage:=IndexOfPageAt(ScreenToClient(Mouse.CursorPos));
    AllowChange:=_pages_Enabled_(nxtPage);
   { if _pages_Enabled_();




    TPageControl.TabToPageIndex();:=;


   _pages_LST_:=TPageControl(Sender).PageIndex;
    TPageControl(Sender).WindowProc:=;
   Sender.beglo  }
end;

procedure tWndCopyRAST_CORE.PageControl1Change(Sender: TObject);
var tmpStage:integer;
begin
   { if _pages_Is_STAGE_(PageControl1.PageIndex) then begin
        tmpStage:=_pages_getSTAGE_(PageControl1.PageIndex);
        if _cpRastObj_.STAGE_IDX+1<tmpStage then begin
            PageControl1.PageIndex:=_pages_LST_;
        end
       else
        if (_cpRastObj_.STAGE_IDX+1=tmpStage)and(not _cpRastObj_.STAGE_END) then begin
            PageControl1.PageIndex:=_pages_LST_;
        end
    end; }
end;

//------------------------------------------------------------------------------

procedure tWndCopyRAST_CORE.TabSheet3ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure tWndCopyRAST_CORE.TabSheet3Enter(Sender: TObject);
begin
  //
end;

procedure tWndCopyRAST_CORE.TabSheet_Stage_0Show(Sender: TObject);
begin
    if (_cpRastObj_.STAGE_IDX=0)and(not _cpRastObj_.STAGE_END) then begin
       _cpRastObj_.DoSTAGE(0);
    end;
end;

procedure tWndCopyRAST_CORE.TabSheet_Stage_1Show(Sender: TObject);
begin
    if ((_cpRastObj_.STAGE_IDX=0)and(    _cpRastObj_.STAGE_END))
    OR ((_cpRastObj_.STAGE_IDX=1)and(not _cpRastObj_.STAGE_END))
    then begin
       _cpRastObj_.DoSTAGE(1);
    end;
end;

//------------------------------------------------------------------------------

procedure tWndCopyRAST_CORE.a_wnd_ApplayExecute(Sender: TObject);
begin
   _CNFG_Save_(RadioButton1.Checked);
end;

procedure tWndCopyRAST_CORE.a_STG_reFreshExecute(Sender: TObject);
begin
    if PageControl1.PageIndex=0 then begin
      _cpRastObj_.DoCLEAN(0);
    end
   else
    if PageControl1.PageIndex=PageControl1.PageCount-1 then begin
      _cpRastObj_.DoCLEAN(0);
       PageControl1.PageIndex:=0;
    end
   else begin
      _cpRastObj_.DoSTAGE(PageControl1.PageIndex-1);
    end;
end;

procedure tWndCopyRAST_CORE.a_wnd_CANSELExecute(Sender: TObject);
begin
    Close;
end;

procedure tWndCopyRAST_CORE.a_wnd_OKExecute(Sender: TObject);
begin
   _CNFG_Save_(RadioButton1.Checked);
    Close;
end;

procedure tWndCopyRAST_CORE.Button4Click(Sender: TObject);
begin
  _cpRastObj_.DoSTAGE(0);
end;

procedure tWndCopyRAST_CORE.ExtendedNotebook1Change(Sender: TObject);
begin

end;

//------------------------------------------------------------------------------

function tWndCopyRAST_CORE._init_ConfigFileName_fndIn_IDE_:boolean;
var tmp:tLazExt_CopyRAST_CONFIG;
begin {todo: разбираться с МЕСТОМ хранения настроек}
    result:=FALSE;
    (*tmp:=CopyRAST_fileConfig_FIND(_getConfigFileName_IDE_,FALSE);
    if Assigned(tmp) then begin
        result:=CRxC_BASE__SettingsPRESENT(tmp);
    end;
    tmp.WriteToDisk;
    tmp.FREE;*)
end;

function tWndCopyRAST_CORE._init_ConfigFileName_fndIn_EXT_:boolean;
var tmp:tLazExt_CopyRAST_CONFIG;
begin {todo: разбираться с МЕСТОМ хранения настроек}
    result:=TRUE;
    (*tmp:=CopyRAST_fileConfig_FIND(_getConfigFileName_EXT_,TRUE);
    if Assigned(tmp) then begin
        result:=CRxC_BASE__SettingsPRESENT(tmp);
    end;
    tmp.WriteToDisk;
    tmp.FREE;*)
end;

procedure tWndCopyRAST_CORE._init_ConfigFileName_fndIn;
var inIDE:boolean;
    inEXT:boolean;
begin
    {todo: разбираться с МЕСТОМ хранения настроек}
    inIde:=_init_ConfigFileName_fndIn_IDE_;
    inEXT:=_init_ConfigFileName_fndIn_EXT_;
    //---
    if inIde and inEXT then begin
        RadioButton1.Checked:=TRUE;
    end
   else
    if inIde then begin
       RadioButton1.Checked:=TRUE;
    end
   else
    if inEXT then begin
       RadioButton2.Checked:=TRUE;
    end
   else begin
       RadioButton1.Checked:=TRUE;
    end;
end;

//------------------------------------------------------------------------------


procedure tWndCopyRAST_CORE._init_ConfigFileName_;
begin
    RadioButton1.Caption:=srcTree_fsFnk_ExtractFileName(_getConfigFileName_IDE_);
    RadioButton2.Caption:=srcTree_fsFnk_ExtractFileName(_getConfigFileName_EXT_);
end;

procedure tWndCopyRAST_CORE.Init(const ParentOBJ:TObject; const ParentFRM:TCustomForm);
begin
    inherited;
   _parentOBJ_:=ParentOBJ;
   _ParentFRM_:=ParentFRM;
    //
    Self.Name   :=_wndName_calc_;
    Self.Caption:=_wndCptn_calc_;
    //
   _init_ConfigFileName_;
   _init_ConfigFileName_fndIn;
    //
    //CRxC_BASE__SettingsEXCLUDE(tmp,CheckBoxThemed1.Checked);
   _cpRastObj_:=_copyRastObj_CRT_;
   _cpRastObj_.onCLEAN:=@_STAGES_onCLEAN_;
   _cpRastObj_.onSTAGE:=@_STAGES_onSTAGE_;
    //
    frmCopyRAST_STAGE_twoTree1.STAGE:=_cpRastObj_.Stage_1;
    //
   _stages_reIMAGE_;
end;


//------------------------------------------------------------------------------

const
 _cTxt_PDTCHRK_='_';
 _cTxt_Probel1_=' ';

const //< для НАЗВАНИЯ окна
 _cCoreWnd_IDE_='IdeTOOL_';
// _cCoreWnd_PRJ_='PRJ';
// _cCoreWnd_PCK_='PCK';

const //< для ЗАГОЛОВКА окна
 _cCoreUsrCPTN_='CopyRUST';
 _cCoreUsrCPT1_='-';
 _cCoreUsr_PRJ_='Project';
 _cCoreUsr_PCK_='Package';

class function tWndCopyRAST_CORE.ide_CoreName:string;
begin
    result:=_cCoreWnd_IDE_+self.ClassName;
end;

class function tWndCopyRAST_CORE.ide_Name4OBJ(const OBJ:TLazProject):string;
begin
    result:=ide_CoreName+_cTxt_PDTCHRK_+OBJ.Name;
end;

class function tWndCopyRAST_CORE.ide_Name4OBJ(const OBJ:TIDEPackage):string;
begin
    result:=ide_CoreName+_cTxt_PDTCHRK_+OBJ.Name;
end;

//------------------------------------------------------------------------------

function tWndCopyRAST_CORE._getConfigFileName_IDE_:string;
begin
    if _parentOBJ_ is TLazProject then begin
        result:=TLazProject(_parentOBJ_).ProjectInfoFile;
    end
   else
    if _parentOBJ_ is TIDEPackage then begin
        result:=TIDEPackage(_parentOBJ_).Filename;
    end
   else
    begin
        result:=''
    end;
end;

function tWndCopyRAST_CORE._getConfigFileName_EXT_:string;
begin
    result:=srcTree_fsFnk_ChangeFileExt(_getConfigFileName_IDE_,'.CopyRAST');
end;

//------------------------------------------------------------------------------

function tWndCopyRAST_CORE._wndName_calc_:string;
begin
    if Assigned(_parentOBJ_) then begin
       if _parentOBJ_ is TLazProject
       then result:=ide_Name4OBJ(TLazProject(_parentOBJ_))
      else
       if _parentOBJ_ is TIDEPackage
       then result:=ide_Name4OBJ(TIDEPackage(_parentOBJ_))
      else begin
            result:=ide_CoreName+_cTxt_PDTCHRK_+_parentOBJ_.ClassName;
        end;
    end
    else result:=ide_CoreName;
end;

function tWndCopyRAST_CORE._wndCptn_calc_:string;
begin
    result:=_cCoreUsrCPTN_;
    if Assigned(_parentOBJ_) then begin
        result:=result+_cTxt_Probel1_;
        if _parentOBJ_ is TLazProject then begin
            result:=result+_cCoreUsr_PRJ_;
        end
       else
        if _parentOBJ_ is TIDEPackage then begin
            result:=result+_cCoreUsr_PCK_;
        end;
        //
        result:=result+_cTxt_Probel1_+_cCoreUsrCPT1_+_cTxt_Probel1_;
        //
        if _parentOBJ_ is TLazProject then begin
            result:=result+TLazProject(_parentOBJ_).Name;
        end
       else
        if _parentOBJ_ is TIDEPackage then begin
            result:=result+TIDEPackage(_parentOBJ_).Name;
        end
       else begin
            result:=result+_parentOBJ_.ClassName;
        end;
    end;
end;

//------------------------------------------------------------------------------

procedure tWndCopyRAST_CORE._CNFG_loadDO_(const cnf:tLazExt_CopyRAST_CONFIG);
begin
    CheckBoxThemed1.Checked:=CRxC_BASE__SettingsEXCLUDE(cnf);
end;

procedure tWndCopyRAST_CORE._CNFG_LOAD_(const inIDE:boolean);
var tmp:tLazExt_CopyRAST_CONFIG;
begin
    //--- получаем ЭКЗЕМПЛЯР
    if NOT false {inIde} then {todo: разбираться с МЕСТОМ хранения настроек} begin
        tmp:=CopyRAST_fileConfig_FIND(_getConfigFileName_IDE_,FALSE);
    end
    else begin
        tmp:=CopyRAST_fileConfig_FIND(_getConfigFileName_EXT_,FALSE);
    end;
    //--- ГРУЗИМСЯ ---
   _CNFG_loadDO_(tmp);
    //--- ЧИСТИМСЯ ------
    if NOT false {inIde} then {todo: разбираться с МЕСТОМ хранения настроек} begin
       tmp.FREE;
    end
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tWndCopyRAST_CORE._CNFG_saveDO_(const cnf:tLazExt_CopyRAST_CONFIG);
begin
    CRxC_BASE__SettingsEXCLUDE(cnf,CheckBoxThemed1.Checked);
end;

procedure tWndCopyRAST_CORE._CNFG_Save_(const inIDE:boolean);
var tmp:tLazExt_CopyRAST_CONFIG;
begin
    //--- сначала пытаемся очистить в СТАРЫХ местах
    {todo: разбираться с МЕСТОМ хранения настроек}
    (*if inIde then begin
        // чистим кеши LAZARUS`a
        tmp:=CopyRAST_fileConfig_FIND(_getConfigFileName_EXT_,FALSE);
        tmp.FREE;
        // физически идаляем файл
        DeleteFile(_getConfigFileName_EXT_);
    end
    else begin
        tmp:=CopyRAST_fileConfig_FIND(_getConfigFileName_IDE_,FALSE);
        if Assigned(tmp) then tmp.DeletePath(cLazExt_CopyRAST__xmlConfig_SECTION);
    end;*)
    //--- получаем ЭКЗЕМПЛЯР
    if FALSE {inIde} then {todo: разбираться с МЕСТОМ хранения настроек} begin
        tmp:=CopyRAST_fileConfig_FIND(_getConfigFileName_IDE_,FALSE);
    end
    else begin
        tmp:=CopyRAST_fileConfig_FIND(_getConfigFileName_EXT_,FALSE);
    end;
    //--- СОХРАНЯЕМСЯ ---
   _CNFG_saveDO_(tmp);
    //--- ЧИСТИМСЯ ------
    if NOT false {inIde} then {todo: разбираться с МЕСТОМ хранения настроек} begin
       tmp.FREE;
    end
end;

//------------------------------------------------------------------------------

procedure tWndCopyRAST_CORE._stages_reIMAGE_;
var i:integer;
begin
    PageControl1.Pages[0].ImageIndex:=_getImageIDX_bbb_;
    //--
    PageControl1.Pages[PageControl1.PageCount-1].ImageIndex:=_getImageIDX_eEr_;
    {todo}
    //-- про СТАДИИ
    if NOT Assigned(_cpRastObj_) then begin
        for i:=1 to PageControl1.PageCount-2
        do PageControl1.Pages[i].ImageIndex:=_getImageIDX_DIS_;
    end
    else begin
        for i:=0 to _cpRastObj_.STAGE_IDX-1
        do PageControl1.Pages[i+1].ImageIndex:=_getImageIDX_ENB_;
        // про ТЕКУЩУЮ
        if _cpRastObj_.STAGE_END
        then PageControl1.Pages[_cpRastObj_.STAGE_IDX+1].ImageIndex:=_getImageIDX_ENB_
        else PageControl1.Pages[_cpRastObj_.STAGE_IDX+1].ImageIndex:=_getImageIDX_WRK_;
        // про СЛЕДУЮЩЕЮ
        if _cpRastObj_.STAGE_IDX<PageControl1.PageCount-2 then begin
            if _cpRastObj_.STAGE_END
            then PageControl1.Pages[_cpRastObj_.STAGE_IDX+2].ImageIndex:=_getImageIDX_WRK_
            else PageControl1.Pages[_cpRastObj_.STAGE_IDX+2].ImageIndex:=_getImageIDX_DIS_;
        end;
        // про ОСТАЛЬНЫЕ
        for i:=_cpRastObj_.STAGE_IDX+2 to PageControl1.PageCount-3
        do PageControl1.Pages[i+1].ImageIndex:=_getImageIDX_DIS_;
    end;
end;

procedure tWndCopyRAST_CORE._STAGES_onCLEAN_(const Sender:tCopyRAST_STAGEs; const stageIndex:integer);
begin
    if stageIndex=0 then begin
       _view_stage0_files_.Root:=nil;
    end;

   _stages_reIMAGE_;
end;

procedure tWndCopyRAST_CORE._STAGES_onSTAGE_(const Sender:tCopyRAST_STAGEs; const stageIndex:integer);
begin
    if stageIndex=0 then begin
       _view_stage0_files_.Root:=_cpRastObj_.SrcTREE;
    end;
   _stages_reIMAGE_;
end;

//------------------------------------------------------------------------------

function tWndCopyRAST_CORE._copyRastObj_CRT_:tCopyRAST_STAGEs;
begin // это для детей, они ДОЛЖНЫ переопределить
    result:=nil;
end;

procedure tWndCopyRAST_CORE._copyRastObj_DST_;
begin
    // не красиво, уничтодаем объекты _copyRastObj через пользовательский интерфейс
    {todo: необходимо переделать}
    //ItemsTreeView.BeginUpdate;
    //ItemsTreeView.Items.Clear; // собственноо вот тут и идет УНИЧТОЖЕНИЕ объектов
    //---
    //_cpRastObj_:=nil;
    //---
    //ItemsTreeView.EndUpdate;
   _cpRastObj_.Free;
   _cpRastObj_:=NIL;
end;


//------------------------------------------------------------------------------

function tWndCopyRAST_CORE._stage_is_LOCK_(const stageIdx:integer):boolean;
begin
    result:=TRUE;
    if not Assigned(_cpRastObj_) then exit;
    //
    if stageIdx<=_cpRastObj_.STAGE_IDX then result:=false
    else begin
        if _cpRastObj_.STAGE_IDX+1<stageIdx then result:=TRUE
        else result:=not _cpRastObj_.STAGE_END;
    end;
end;

//------------------------------------------------------------------------------

// ПЕРВАЯ вкладка
function tWndCopyRAST_CORE._pages_Is_begin_(const tabIndx:integer):boolean;
begin
    result:=(0=tabIndx);
end;

function tWndCopyRAST_CORE._pages_Is_begin_(const tabShet:TTabSheet):boolean;
begin
    result:=_pages_Is_begin_(tabShet.PageIndex)
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// ПОСЛЕДНЯЯ вкладка
function tWndCopyRAST_CORE._pages_Is_final_(const tabIndx:integer):boolean;
begin
    result:=(tabIndx=PageControl1.PageCount-1);
end;

function tWndCopyRAST_CORE._pages_Is_final_(const tabShet:TTabSheet):boolean;
begin
    result:=_pages_Is_final_(tabShet.PageIndex)
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tWndCopyRAST_CORE._pages_Enabled_(const tabIndx:integer):boolean;
begin
    if not _pages_Is_STAGE_(tabIndx)
    then result:=TRUE
    else result:=not _stage_is_LOCK_(_pages_getSTAGE_(tabIndx));
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tWndCopyRAST_CORE._pages_Is_STAGE_(const tabIndx:integer):boolean;
begin
    result:=(0<tabIndx)and(tabIndx<PageControl1.PageCount-1);
end;

function tWndCopyRAST_CORE._pages_Is_STAGE_(const tabShet:TTabSheet):boolean;
begin
    result:=_pages_Is_STAGE_(tabShet.PageIndex)
end;

function tWndCopyRAST_CORE._pages_getSTAGE_(const tabIndx:integer):integer;
begin
    result:=-1;
    if _pages_Is_STAGE_(tabIndx) then result:=tabIndx-1;
end;

function tWndCopyRAST_CORE._pages_getSTAGE_(const tabShet:TTabSheet):integer;
begin
    result:=_pages_getSTAGE_(tabShet)
end;

//------------------------------------------------------------------------------


// загрузка картинки и получение её индекса
function _do_getIdxImj4IdeImages_(const fName:string):integer;
begin
    try
      {$if (01080000<=lcl_fullversion)}
          result:=IDEImages.LoadImage(fName,16);
      {$else}
          result:=IDEImages.LoadImage(16,fName);
      {$endIf}
    except
      result:=-1;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

const
  _cImgName_BBB_='pkg_properties';
   //---
  _cImgName_DIS_='menu_build_lazarus';
  _cImgName_ENB_='menu_build';
  _cImgName_WRK_='menu_quick_compile';
   //---
  _cImgName_eOk_='pkg_compile';
  _cImgName_eER_='pkg_conflict';

function tWndCopyRAST_CORE._getImageIDX_bbb_:integer;
begin
    if _stageImgIDX_bbb_<0 then _stageImgIDX_bbb_:=_do_getIdxImj4IdeImages_(_cImgName_BBB_);
    result:=_stageImgIDX_bbb_;
end;

function tWndCopyRAST_CORE._getImageIDX_DIS_:integer;
begin
    if _stageImgIDX_DIS_<0 then _stageImgIDX_DIS_:=_do_getIdxImj4IdeImages_(_cImgName_DIS_);
    result:=_stageImgIDX_DIS_;
end;

function tWndCopyRAST_CORE._getImageIDX_ENB_:integer;
begin
    if _stageImgIDX_ENB_<0 then _stageImgIDX_ENB_:=_do_getIdxImj4IdeImages_(_cImgName_ENB_);
    result:=_stageImgIDX_ENB_;
end;

function tWndCopyRAST_CORE._getImageIDX_WRK_:integer;
begin
    if _stageImgIDX_WRK_<0 then _stageImgIDX_WRK_:=_do_getIdxImj4IdeImages_(_cImgName_WRK_);
    result:=_stageImgIDX_WRK_;
end;

function tWndCopyRAST_CORE._getImageIDX_eEr_:integer;
begin
    if _stageImgIDX_eER_<0 then _stageImgIDX_eER_:=_do_getIdxImj4IdeImages_(_cImgName_eER_);
    result:=_stageImgIDX_eER_;
end;

function tWndCopyRAST_CORE._getImageIDX_eOk_:integer;
begin
    if _stageImgIDX_eOk_<0 then _stageImgIDX_eOk_:=_do_getIdxImj4IdeImages_(_cImgName_eOk_);
    result:=_stageImgIDX_eOk_;
end;

end.

