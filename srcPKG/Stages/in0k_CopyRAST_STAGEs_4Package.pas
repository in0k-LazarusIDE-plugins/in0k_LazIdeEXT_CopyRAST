unit in0k_CopyRAST_STAGEs_4Package;

{$mode objfpc}{$H+}

interface

uses
  srcTree_builder_CORE,
  in0k_CopyRAST_STAGEs,
  in0k_lazIdeSRC_CopyRAST_srcTree;

type

 tCopyRAST_STAGEs_4Package=class(tCopyRAST_STAGEs)

  protected
    function _builder_TYPE_:tSrcTree_Builder_TYPE; override;
    function _creater_TYPE_:tSrcTree_Creater_TYPE; override;
  public
    constructor Create(const MainIdeOobject:TObject); override;
  end;


implementation

constructor tCopyRAST_STAGEs_4Package.Create(const MainIdeOobject:TObject);
begin
    inherited;
end;

//------------------------------------------------------------------------------

function tCopyRAST_STAGEs_4Package._builder_TYPE_:tSrcTree_Builder_TYPE;
begin
    result:=tCopyRastSrcTree_Builder4Package;
end;

function tCopyRAST_STAGEs_4Package._creater_TYPE_:tSrcTree_Creater_TYPE;
begin
    result:=tCopyRastSrcTree_Creater4Package;
end;


end.

