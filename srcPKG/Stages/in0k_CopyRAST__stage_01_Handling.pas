unit in0k_CopyRAST__stage_01_Handling;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,

  in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_CORE,
  in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_ITEM_4USEs,

  in0k_CopyRAST_srcTree_ITEMs,
  in0k_lazIdeSRC_CopyRAST_srcTree,
  in0k_CopyRAST_STAGEs_CORE;

type

 tCopyRast__stage_01_Handling=class(tCopyRast_SrcTree_STAGE_LMR)
  protected
   _P4Build_:tCopyRastSrcTree_P4Build;
    function _P4Build_processing_(const TestMode:eSrcTree_f8a_FileTestMode; const FileName:string):boolean;
  protected
    function _execute_makeMidlleROOT_(const src:tCopyRast_stROOT):tCopyRast_stROOT; override;
    function _execute_makeResultROOT_(const src:tCopyRast_stROOT):tCopyRast_stROOT; override;
  protected
    function _2Result_NeedCopy_FILE_ (const value:tCopyRastNODE_FILE):boolean;
  public
    constructor Create(const STAGEs:tCopyRAST_STAGEs_CORE);
    destructor DESTROY; override;
  end;

implementation

constructor tCopyRast__stage_01_Handling.Create(const STAGEs:tCopyRAST_STAGEs_CORE);
begin
    inherited;
   _P4Build_:=tCopyRastSrcTree_P4Build.Create(_owner_Builder);
   _P4Build_.Handler_ADD(tSrcTree_itmHandler4Build__f8a_Item_4USEs);
   _P4Build_.mProcessing_testFile:=@_P4Build_processing_;
   _enabled_:=TRUE;
end;

destructor tCopyRast__stage_01_Handling.DESTROY;
begin
   _P4Build_.FREE;
    inherited;
end;

function tCopyRast__stage_01_Handling._execute_makeMidlleROOT_(const src:tCopyRast_stROOT):tCopyRast_stROOT;
begin
    result:=CopyRast_SrcTree_Copy(src);
   _P4Build_.EXECUTE(result);
end;

function tCopyRast__stage_01_Handling._execute_makeResultROOT_(const src:tCopyRast_stROOT):tCopyRast_stROOT;
begin
    result:=CopyRast_SrcTree_Copy(src);
end;

function tCopyRast__stage_01_Handling._P4Build_processing_(const TestMode:eSrcTree_f8a_FileTestMode; const FileName:string):boolean;
begin
    case TestMode of
      eSTf8aFTM__processing: result:=TRUE;
      eSTf8aFTM__needAppend: result:=TRUE;
      eSTf8aFTM__needHandle: result:=FALSE;
    end;
end;

//------------------------------------------------------------------------------

function tCopyRast__stage_01_Handling._2Result_NeedCopy_FILE_(const value:tCopyRastNODE_FILE):boolean;
var tmpBASE:tCopyRast_stBASE;
begin
    result:=false;
    tmpBASE:=SrcTree_fndBaseDIR(_midlleROOT_);
    if Assigned(tmpBASE) then begin
        result:=SrcTree_isParent_4_Item(tmpBASE,value);
    end;
end;


end.

