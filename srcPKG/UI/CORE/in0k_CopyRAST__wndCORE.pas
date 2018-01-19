unit in0k_CopyRAST__wndCORE;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
{$define _DEBUG_}

uses
  {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}in0k_lazIdeSRC_DEBUG,{$endIf}

  ProjectIntf,  LazIDEIntf,
  PackageIntf,
  lazExt_CopyRAST__xmlConfig,
  lazExt_CopyRAST__xmlConfig_Base,

  in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,

  Classes, SysUtils, FileUtil, CheckBoxThemed, DividerBevel, Forms, Controls,
  Graphics, Dialogs, StdCtrls, ComCtrls, ExtCtrls, ActnList;



type

  { TwndCopyRAST_CORE }

 tWndCopyRAST_CORE=class(TForm)
    a_wnd_CANSEL: TAction;
    a_wnd_OK: TAction;
    a_wnd_Applay: TAction;
    ActionList1: TActionList;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBoxThemed1: TCheckBoxThemed;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    procedure a_wnd_ApplayExecute(Sender: TObject);
    procedure a_wnd_CANSELExecute(Sender: TObject);
    procedure a_wnd_OKExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  protected
    function _getConfigFileName_IDE_:string; virtual;
    function _getConfigFileName_EXT_:string;
  protected
    function  _init_ConfigFileName_fndIn_IDE_:boolean;
    function  _init_ConfigFileName_fndIn_EXT_:boolean;
    procedure _init_ConfigFileName_fndIn;
    procedure _init_ConfigFileName_;
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
    //
    PageControl1.ActivePageIndex:=0;
end;

destructor tWndCopyRAST_CORE.DESTROY;
begin
    inherited;
end;


procedure tWndCopyRAST_CORE.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    CloseAction:=caFree;
end;

//------------------------------------------------------------------------------

procedure tWndCopyRAST_CORE.a_wnd_ApplayExecute(Sender: TObject);
begin
   _CNFG_Save_(RadioButton1.Checked);
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

end.

