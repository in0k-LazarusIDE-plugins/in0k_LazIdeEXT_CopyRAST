unit srcTree_item_4Project;

{$mode objfpc}{$H+}

interface

uses srcTree_item_coreROOT,
     srcTree_item_coreMAIN;

type

 tSrcTree_Root4Project=class(tSrcTree_ROOT)
  end;

 tSrcTree_Main4Project=class(tSrcTree_MAIN)
  public
    constructor Create(const Text:string); override;
  end;


implementation

//==============================================================================

constructor tSrcTree_Main4Project.Create(const Text:string);
begin
    inherited Create(Text);
end;

end.

