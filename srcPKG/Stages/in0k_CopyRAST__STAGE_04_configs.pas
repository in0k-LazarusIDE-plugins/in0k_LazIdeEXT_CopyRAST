unit in0k_CopyRAST__STAGE_04_configs;

{$mode objfpc}{$H+}

interface

uses
  CopyRAST_srcTree_4Handler_CNFGs;


type

 tCopyRast_STAGE__copyFiles__CNFGs=class(tCopyRAST_srcTree_4Handler_CNFGsNode)
  private
   _TargetDirDEL_:boolean; //< ПОЛНОСТЬЮ удалять
   _TargetDirCLR_:boolean; //< очищать папку назвачения
  public
    property TargetDirDELETE:boolean read _TargetDirCLR_ write _TargetDirCLR_;
    property TargetDirCLEAR :boolean read _TargetDirCLR_ write _TargetDirCLR_;
  public
    constructor Create;
  end;

implementation

constructor tCopyRast_STAGE__copyFiles__CNFGs.Create;
begin
    inherited;
   _TargetDirCLR_:=TRUE;
end;

end.

