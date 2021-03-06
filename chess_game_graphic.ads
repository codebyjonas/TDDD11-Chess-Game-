with Ada.Text_IO;		use Ada.Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;

-- TJA Biblotetket
with TJa.Window.Elementary;     use TJa.Window.Elementary;
with TJa.Window.Graphic;        use TJa.Window.Graphic; 
with TJa.Window.Text;           use TJa.Window.Text;

-- Chess_Game

package Chess_Game_Graphic is
   
   -- Variabler, stor del färger
   White_Chessman                      : constant Colour_Type := Light_Grey;
   Black_Chessman                      : constant Colour_Type := Black;
   Highlight_Colour                    : constant Colour_Type := Bright_Yellow;
   Highlight_Colour_Contrast           : constant Colour_Type := Yellow;
   Secondary_Highlight_Colour          : constant Colour_Type := Bright_Magenta;
   Secondary_Highlight_Colour_Contrast : constant Colour_Type := Magenta;
   Foreground_Colour                   : constant Colour_Type := White;
   Background_Colour                   : constant Colour_Type := Dark_Grey;
   
   Offset_X          : constant Integer := 10;
   Offset_Y          : constant Integer := 5;

   
   -- Procedurer och Funktioner
   procedure Draw_Complete_Game_Board; 
   procedure Graphic_Mark_Position(X, Y : in Integer; 
				   Chessman : in Integer := 0; 
				   Colour : in Colour_Type := Highlight_Colour;
				   Colour_Contrast : in Colour_Type := Highlight_Colour_Contrast);
   procedure Graphic_Unmark_Position(X, Y : in out Integer;
				     Chessman : in Integer := 0);
   procedure Graphic_Move_Chess_Piece(X, Y, Choosen_Chess_Piece: in Integer);
   procedure Put_Chessman( Chessman : in Character; 
			   X, Y     : in out Integer; 
			   F_Colour : in Colour_Type := Foreground_Colour; 
			   B_Colour : in Colour_Type := Background_Colour);
   function Chessman_Number_2_Character( Item : in Integer) return Character;
   procedure Draw_Box(X, Y, H_Size, V_Size : in Integer; 
		      Foreground_Colour    : in Colour_Type := White;
		      Background_Colour    : in Colour_Type := Blue);
   procedure Draw_Complete_Info_Box;
   procedure Put_To_Info_Box( Text : in String; Row : in Integer);
   procedure Draw_Outer_Box;
   
private
   
end Chess_Game_Graphic;
