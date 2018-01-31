unit in0k_CopyRAST__frmSTAGE_CORE;

{$mode objfpc}{$H+}

interface

uses
  in0k_CopyRAST_STAGEs_CORE,
  lazExt_CopyRAST__xmlConfig,
  frmCopyRAST_EDIT;

type

 tFrmCopyRAST_STAGE=class(tFrmCopyRastEDIT)
  protected
   _STAGE_:tCopyRast_STAGE;
    procedure _STAGE_doSet_(const value:tCopyRast_STAGE);
    procedure _STAGE_onSet_(const value:tCopyRast_STAGE); virtual;
    procedure _STAGE_onCLR_;                              virtual;
  public
    property STAGE:tCopyRast_STAGE read _STAGE_ write _STAGE_doSet_;
  protected
    function  frmSettings_Section:string;
  public
    procedure frmSettings_LOAD(const xmlCongif:tLazExt_CopyRAST_CONFIG); virtual;
    procedure frmSettings_SAVE(const xmlCongif:tLazExt_CopyRAST_CONFIG); virtual;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

implementation

{$R *.lfm}

procedure tFrmCopyRAST_STAGE.AfterConstruction;
begin
   _STAGE_onCLR_;
    inherited;
end;

procedure tFrmCopyRAST_STAGE.BeforeDestruction;
begin
   _STAGE_onCLR_;
    inherited;
end;

//------------------------------------------------------------------------------


procedure tFrmCopyRAST_STAGE._STAGE_doSet_(const value:tCopyRast_STAGE);
begin
   _ctrl_OnChange_LOCK_(TRUE);
    if _STAGE_<>value then begin
      _STAGE_:=value;
       if Assigned(_STAGE_)
       then _STAGE_onSet_(_STAGE_)
       else _STAGE_onCLR_;
    end;
   _ctrl_OnChange_LOCK_(false);
end;

procedure tFrmCopyRAST_STAGE._STAGE_onSet_(const value:tCopyRast_STAGE);
begin
   //
end;

procedure tFrmCopyRAST_STAGE._STAGE_onCLR_;
begin
    {for child}
   _ctrl_eventClr_onChange_;
   _ctrl_Enabled_SET_(FALSE);
end;

//------------------------------------------------------------------------------

function tFrmCopyRAST_STAGE.frmSettings_Section:string;
begin
    result:=self.ClassName;
end;

procedure tFrmCopyRAST_STAGE.frmSettings_LOAD(const xmlCongif:tLazExt_CopyRAST_CONFIG);
begin
    //
end;

procedure tFrmCopyRAST_STAGE.frmSettings_SAVE(const xmlCongif:tLazExt_CopyRAST_CONFIG);
begin
    //
end;

end.

