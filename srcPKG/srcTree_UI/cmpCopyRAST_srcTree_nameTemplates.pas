unit cmpCopyRAST_srcTree_nameTemplates;

{$mode objfpc}{$H+}

interface

uses
  ComCtrls,
  Classes, SysUtils;

type

 tCmpCopyRAST_srcTree_nameTemplates=class(TCustomTreeView)
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

constructor tCmpCopyRAST_srcTree_nameTemplates.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);
    Items.Add(nil,'NEW');
   { with Columns.Add do begin
        Caption:='Template';
        AutoSize:=TRUE;
    end;
    with Columns.Add do begin
        Caption:='Template1';
        AutoSize:=TRUE;
    end;
    with Columns.Add do begin
        Caption:='Template2';
        AutoSize:=TRUE;
    end;
    //
    with Items.Add do begin
        Caption:='sdf';
        Items.Add.Caption:='asdf';
    end;
    ShowColumnHeaders:=TRUE;
    ViewStyle:=vsReport; }
end;

destructor tCmpCopyRAST_srcTree_nameTemplates.Destroy;
begin
    inherited;
end;

{function tCmpCopyRAST_srcTree_nameTemplates.CanEdit(Item: TListItem): Boolean;
begin
    inherited;
    result:=true;
end; }

end.

