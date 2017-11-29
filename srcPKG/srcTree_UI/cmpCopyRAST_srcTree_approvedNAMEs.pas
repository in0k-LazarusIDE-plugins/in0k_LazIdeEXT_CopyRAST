unit cmpCopyRAST_srcTree_approvedNAMEs;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  cmpCopyRAST_srcTree;

type

 tCmpCopyRAST_srcTree_approvedNAMEs=class(tCmpCopyRAST_srcTree)
  public
    constructor Create(AnOwner: TComponent); override;
  end;

implementation

constructor tCmpCopyRAST_srcTree_approvedNAMEs.Create(AnOwner:TComponent);
begin
    inherited Create(AnOwner);
   _lftSide_mustNotNIL_:=TRUE;
end;


end.

