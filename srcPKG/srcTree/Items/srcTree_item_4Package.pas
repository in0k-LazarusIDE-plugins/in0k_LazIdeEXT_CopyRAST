unit srcTree_item_4Package;

{$mode objfpc}{$H+}

interface

uses srcTree_item_coreROOT,
     srcTree_item_coreMAIN;

type

 tSrcTree_Root4Package=class(tSrcTree_ROOT)
  end;

 tSrcTree_Main4Package=class(tSrcTree_MAIN)
  public
    constructor Create(const Text:string); override;
  end;


implementation

//==============================================================================

constructor tSrcTree_Main4Package.Create(const Text:string);
begin
    inherited Create(Text);
end;

end.

