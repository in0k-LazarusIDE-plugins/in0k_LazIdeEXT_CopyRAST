unit cmpCopyRAST_srcTree_approvedFiles;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  cmpCopyRAST_srcTree;

type

 tCmpCopyRAST_srcTree_approvedFILEs=class(tCmpCopyRAST_srcTree)
  public
    constructor Create(AnOwner: TComponent); override;
  end;

implementation

constructor tCmpCopyRAST_srcTree_approvedFILEs.Create(AnOwner:TComponent);
begin
    inherited Create(AnOwner);
   _rhtSide_mustNotNIL_:=TRUE;
end;

end.

