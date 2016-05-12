with Ada.Text_IO;		use Ada.Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;

-- TJA Biblotetket
with TJa.Sockets;               use TJa.Sockets;
with TJa.Window.Elementary;     use TJa.Window.Elementary;
with TJa.Window.Graphic;        use TJa.Window.Graphic; 
with TJa.Window.Text;           use TJa.Window.Text;
with TJa.Keyboard;              use TJa.Keyboard;
with TJa.Keyboard.Keys;         use TJa.Keyboard.Keys;


with Chess_Game_Graphic;        use Chess_Game_Graphic;
with Chess_Game_Handling;       use Chess_Game_Handling;


-- Chess_Game

package Chess_Game_Play is
   
   procedure Other_Player_Moves(Other_Player_X1, Other_Player_Y1, Other_Player_X2, Other_Player_Y2, Choosen_Chess_Piece : in out Integer);
   procedure Draw_Is_Size_Ok_Box;
   procedure Display_Waiting_Message;
   procedure Message_Black_Or_White(My_Colour : in Character);
   procedure Alert_Your_Turn( On : in Boolean);
   procedure Alert_Check( On : in Boolean);
   procedure Game_Over( Results : in Character);
private
   
end Chess_Game_Play;
