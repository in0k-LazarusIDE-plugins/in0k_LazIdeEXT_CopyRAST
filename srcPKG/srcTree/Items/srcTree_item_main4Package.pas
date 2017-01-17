unit srcTree_item_main4Package;

{$mode objfpc}{$H+}

interface

uses
  PackageIntf,
  srcTree_item_coreMAIN;

type

 tSrcTree_Main4Package=class(tSrcTree_MAIN)
  public
    constructor Create(const Text:string); override;
  end;

implementation

constructor tSrcTree_Main4Package.Create(const Text:string);
begin
    inherited Create(Text);
end;

end.

