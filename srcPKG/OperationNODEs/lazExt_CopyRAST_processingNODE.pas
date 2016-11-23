unit lazExt_CopyRAST_processingNODE;

{$mode objfpc}{$H+}

interface

uses
  Processing_CORE;

type

 tPrcNODE_Base=class(tOperationNode_CORE)
  public
    function Is_Possible:boolean; override;
    function doOperation:boolean; override;
  end;


implementation

function tPrcNODE_Base.Is_Possible:boolean;
begin
    result:=true;
end;

function tPrcNODE_Base.doOperation:boolean;
begin
    result:=TRUE;  //< по умолчанию: продолжить обработку СЛЕДУЮЩИХ узлов
end;


end.

