unit uTST_005_srcTree_itemROOT__fnd_absPATH_000;

{$mode objfpc}{$H+}

interface

uses
    in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
    in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
    in0k_lazIdeSRC_srcTree_item_Globals,
    //
    in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,
    in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,
    //
    in0k_lazIdeSRC_srcTree_FNK_PATH_FND_abs,
    //
    SysUtils, fpcunit, testregistry;

type

 tTST_srcTree_itemROOT__fnd_absPATH_000= class(TTestCase)
  protected
    ROOT:tSrcTree_ROOT;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure BaseDIR;
    procedure BaseDIR_prev;
    procedure BaseDIR_next;
  end;


implementation

procedure tTST_srcTree_itemROOT__fnd_absPATH_000.SetUp;
begin
    ROOT:=tSrcTree_ROOT.Create('ROOT'); //< собсно создаем
    SrcTree_setBaseDIR(ROOT,srcTree_fsFnk_ChompPathDelim(GetTempDir)+PathDelim+'A'); //< устанавливаем ГЛАВНЫЙ путь
end;

procedure tTST_srcTree_itemROOT__fnd_absPATH_000.TearDown;
begin
    ROOT.FREE;
end;

//==============================================================================

procedure tTST_srcTree_itemROOT__fnd_absPATH_000.BaseDIR;
var res:_tSrcTree_item_fsNodeFLDR_;
   fldr: string;
begin // ищем БАЗОВЫЙ путь
   fldr:=srcTree_fsFnk_ChompPathDelim(GetTempDir)+PathDelim+'A';
   //---
   res :=SrcTree_fndPathABS(ROOT,fldr);
   //--- от ДОЛЖЕН быть
   AssertNotNull('notFound',res);
   AssertSame   ('`res` must by BaseDIR',res,SrcTree_fndBaseDIR(ROOT));
end;

procedure tTST_srcTree_itemROOT__fnd_absPATH_000.BaseDIR_prev;
var res:_tSrcTree_item_fsNodeFLDR_;
   fldr: string;
begin // ищем РОДИТЕЛЬСКУЮ для БАЗОВЫЙ путь
   fldr:=srcTree_fsFnk_ChompPathDelim(GetTempDir);
   //---
   res :=SrcTree_fndPathABS(ROOT,fldr);
   //--- его НЕ должно быть
   AssertNull('Found',res);
end;

procedure tTST_srcTree_itemROOT__fnd_absPATH_000.BaseDIR_next;
var res:_tSrcTree_item_fsNodeFLDR_;
   fldr: string;
begin // ищем ДОЧЕРНЮЮ для БАЗОВЫЙ путь
   fldr:=srcTree_fsFnk_ChompPathDelim(GetTempDir)+PathDelim+'A'+PathDelim+'A';
   //---
   res :=SrcTree_fndPathABS(ROOT,fldr);
   //--- его НЕ должно быть
   AssertNull('Found',res);
end;

initialization
    RegisterTest(tTST_srcTree_itemROOT__fnd_absPATH_000);

end.

