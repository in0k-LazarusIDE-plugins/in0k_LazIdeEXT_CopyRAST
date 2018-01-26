unit in0k_CopyRAST__frmSTAGE_CORE;

{$mode objfpc}{$H+}

interface

uses
  in0k_CopyRAST_srcTree_Stage,
  lazExt_CopyRAST__xmlConfig,
  frmCopyRAST_EDIT;

type

 tFrmCopyRAST_STAGE=class(tFrmCopyRastEDIT)
  protected
   _STAGE_:tCopyRast_SrcTree_prcSTAGE;
    procedure _STAGE_set_(const value:tCopyRast_SrcTree_prcSTAGE); virtual;
  public
    property STAGE:tCopyRast_SrcTree_prcSTAGE read _STAGE_ write _STAGE_set_;
  protected
    function  wndSettings_Section:string;
  public
    procedure wndSettings_LOAD(const xmlCongif:tLazExt_CopyRAST_CONFIG); virtual;
    procedure wndSettings_SAVE(const xmlCongif:tLazExt_CopyRAST_CONFIG); virtual;
  end;

implementation

{$R *.lfm}

procedure tFrmCopyRAST_STAGE._STAGE_set_(const value:tCopyRast_SrcTree_prcSTAGE);
begin
   _STAGE_:=value;
end;

//------------------------------------------------------------------------------

function tFrmCopyRAST_STAGE.wndSettings_Section:string;
begin
    result:=self.ClassName;
end;

procedure tFrmCopyRAST_STAGE.wndSettings_LOAD(const xmlCongif:tLazExt_CopyRAST_CONFIG);
begin
    //
end;

procedure tFrmCopyRAST_STAGE.wndSettings_SAVE(const xmlCongif:tLazExt_CopyRAST_CONFIG);
begin
    //
end;

end.

