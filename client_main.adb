with Ada.Command_Line;      use Ada.Command_Line;
with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;

with TJa.Sockets;           use TJa.Sockets;
with TJa.Window.Elementary; use TJa.Window.Elementary;
with TJa.Window.Text;       use TJa.Window.Text;
with TJa.Keyboard;          use TJa.Keyboard;
with TJa.Keyboard.Keys;     use TJa.Keyboard.Keys;
with Chess_Game_Handling;   use Chess_Game_Handling;
with Chess_Game_Graphic;    use Chess_Game_Graphic;
with Chess_Game_Play;       use Chess_Game_Play;


procedure Client_Main is
   
   
   -- TATA43 - analys
   Socket                       : Socket_Type;
   My_Colour, Results            : Character;
   Actual_Game_Round_Case, X1, Y1, Chess_Type, Other_Player_X1, Other_Player_Y1, Other_Player_X2, Other_Player_Y2, Choosen_Chess_Piece : Integer;
   
begin
   
   Settings;
     
   Initiate(Socket);
   
   -- Game Play
   -- Draw Outer Box
   Draw_Outer_Box;
   Draw_Is_Size_Ok_Box;
   Display_Waiting_Message;
   Connect(Socket, Argument(1), Positive'Value(Argument(2))); 
   Get(Socket, My_Colour);
   Draw_Complete_Game_Board; 
   Draw_Complete_Info_Box;
   Message_Black_Or_White(My_Colour);
   
   loop
      -- Hämta Typ av runda:
      --- 1. Schack Matt
      --- 2. Schack
      --- 3. Regular
      --- 4. First Round  
      Get(Socket, Actual_Game_Round_Case);
      if Actual_Game_Round_Case < 4 then
	 Get(Socket, Other_Player_X1);
	 Get(Socket, Other_Player_Y1);
	 Get(Socket, Other_Player_X2);
	 Get(Socket, Other_Player_Y2);
	 Get(Socket, Choosen_Chess_Piece);
	 Other_Player_Moves(Other_Player_X1, Other_Player_Y1, Other_Player_X2, Other_Player_Y2, Choosen_Chess_Piece);
      end if;
      
      -- Avgör vilket fall som ska köra 
      case Actual_Game_Round_Case is
	 when 1 => 
	    Alert_Check(False);
	    Put_Line(Socket, 1);
	    -- TODO: Vem vann?
	    Results := 'l';
	    delay 1.0;
	    Game_Over(Results);
	 when 2 =>
	    Alert_Your_Turn(False);
	    Alert_Check(True);
	    -- TODO: Skapa Graphic_Display_Is_Check;
	    --Graphic_Display_Is_Check; 
	    Play_Round(Socket, X1, Y1);
	 when 3 =>
	    Put_To_Info_Box("Your turn                            ", 2);
	    Alert_Your_Turn(True);
	    Play_Round(Socket, X1, Y1);
	 when 4 => 
	    Alert_Your_Turn(True);
	    Alert_Check(False);
	    Play_Round(Socket, X1, Y1);
	 when 5 =>
	    Alert_Your_Turn(False);
	    Alert_Check(False);
	    Put_To_Info_Box("Waiting for opponent                 ", 2);
	    Offset_Input;
	 when 6 =>
	    delay 1.0;
	    Results := 'w';
	    Game_Over(Results);
	 when others =>
	    Put("Error Actual_Game_Round_Case");
	    -- Raise Error 
      end case;
   end loop;
   
   
   
end Client_Main;
