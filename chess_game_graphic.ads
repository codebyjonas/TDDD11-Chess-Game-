with Ada.Text_IO;		use Ada.Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;

-- TJA Biblotetket
with TJa.Window.Elementary;     use TJa.Window.Elementary;
with TJa.Window.Graphic;        use TJa.Window.Graphic; 
with TJa.Window.Text;           use TJa.Window.Text;

-- Chess_Game

package Chess_Game_Graphic is
   
   -- Variabler, stor del färger
   Highlight_Colour  : Colour_Type := Blue;
   Background_Colour : Colour_Type := White;
   
   -- Procedurer och Funktioner
   procedure Draw_Complete_Game_Board(Size : in Integer := 10); --TMP! Med std value 
   procedure Graphic_Mark_Position(X, Y : in Integer);
   procedure Graphic_Unmark_Position(X, Y : in Integer);
   procedure Move_Chess_Piece(X, Y: in Integer);
   procedure Remove_Chess_Piece(X, Y : in Integer);
private
   
end Chess_Game_Graphic;
