unit lazExt_CopyRAST_wndProject;

{$mode objfpc}{$H+}

interface

uses lazExt_CopyRAST_wndCORE,
     lazExt_CopyRAST_StrConsts,
  Classes;

const
  clazExt_CopyRAST_wndProject_name='IDE_CopyRastPRJ_Tool';

type

  { Twnd_lazExt_CopyRAST_Project }

 Twnd_lazExt_CopyRAST_Project = class(Twnd_lazExt_CopyRAST_CORE)
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

implementation

{$R *.lfm}

procedure Twnd_lazExt_CopyRAST_Project.FormCreate(Sender: TObject);
begin
    inherited;
    //---
    Caption:=cRes_CopyRAST_PKG_name;
end;

//------------------------------------------------------------------------------


end.

