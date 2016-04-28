with Ada.Text_IO;		use Ada.Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;

-- TJA Biblotetket
with TJa.Window.Elementary;     use TJa.Window.Elementary;
with TJa.Window.Graphic;        use TJa.Window.Graphic; 
with TJa.Window.Text;           use TJa.Window.Text;

-- Chess_Game

package Chess_Game_Graphic is
   
   -- Variabler, stor del färger
   White_Chessman    : Colour_Type := Light_Grey;
   Black_Chessman    : Colour_Type := Black;
   Highlight_Colour  : Colour_Type := Bright_Yellow;
   Foreground_Colour : Colour_Type := White;
   Background_Colour : Colour_Type := Dark_Grey;
   
   -- Procedurer och Funktioner
   procedure Draw_Complete_Game_Board; 
   procedure Graphic_Mark_Position(X, Y : in Integer; Colour : in Colour_Type := Highlight_Colour);
   procedure Move_Chess_Piece(X, Y: in Integer);
private
   
end Chess_Game_Graphic;
