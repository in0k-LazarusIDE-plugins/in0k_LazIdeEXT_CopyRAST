unit in0kLazExt_CopyRAST_srcTree_HandlerReNAMEs_CNFGs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;


type

 tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME=class
  public
    nameNew:string;
    nameCst:boolean;
    pathNew:string;
    pathCst:boolean;
  public
    function  SaveNEED:boolean;
    procedure CLEAR;
  end;

implementation

procedure tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME.CLEAR;
begin
    nameNew:='';
    nameCst:=false;
    pathNew:='';
    pathCst:=false;
end;

function tCopyRAST_srcTree_HandlerReNAMEs_CNFGs4NAME.SaveNEED:boolean;
begin
    result:=(nameNew<>'')or(pathNew<>'');
end;


end.

