unit in0k_colors4StdSheme;

{$mode objfpc}{$H+}

interface

uses Graphics,
    Classes, SysUtils;


function in0k_colors4StdSheme__getRed:tColor;


                                  //Green
                                  //Red

implementation

const cStartColor=clHotLight;//clHighlight;

function in0k_colors4StdSheme__getRed:tColor;
var R,G,B:byte;
begin
    RedGreenBlue(ColorToRGB(cStartColor), R,G,B);
    if (G<R)and(B<R) then begin
        result:=RGBToColor(R,G,B);
    end
   else
    if (R<G)and(B<G) then begin
        result:=RGBToColor(G,B,R);
    end
   else begin
        result:=RGBToColor(B,R,G);
    end;
end;

end.

