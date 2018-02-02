unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  MacroIntf, in0k_lazarusIdeSRC_ideMacrosCODE, in0k_lazarusIdeSRC_MacrosLIST,
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ValEdit,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Memo1: TMemo;
    ToggleBox1: TToggleBox;
    ValueListEditor1: TValueListEditor;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    CloseAction:=caFree;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    edit2.Text:=ideMacros_enCODE(edit1.Text, Memo1.Lines);
end;

procedure TForm1.FormCreate(Sender: TObject);
var i:integer;
    s:string;
    q:string;
begin
    for i:=0 to MacrosLIST_Count-1 do begin
        s:='$('+MacrosLIST_Value(i)+')';
        q:=s;
        IDEMacros.SubstituteMacros(q);

        ValueListEditor1.Strings.Add( s+'='+q);
    end;
    memo1.Clear;
    memo1.Lines.Add('FPCSrcDir');
    memo1.Lines.Add('LazarusDir');
    memo1.Lines.Add('ExeExt');
    memo1.Lines.Add('LanguageID');
    memo1.Lines.Add('LanguageName');
    memo1.Lines.Add('TestDir');
    memo1.Lines.Add('ConfDir');
    memo1.Lines.Add('Home');


end;

end.

