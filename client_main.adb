with Ada.Command_Line;    use Ada.Command_Line;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;

with TJa.Sockets;         use TJa.Sockets;

-- TODO Skapa paket
with Chess_Game_Handling; use Chess_Game_Handling;
with Chess_Game_Graphic;  use Chess_Game_Graphic;

procedure Client_Main is
   
   procedure Put_Array(Possible_Array: in Cordinate_Array) is
      
   begin
      
      for I in 1..28 loop
	 Put(Possible_Array(I).X); 
	 Put(Possible_Array(I).Y);
      end loop;
      
   end Put_Array;
   
   
   
   procedure Other_Player_Moves(Other_Player_X1, Other_Player_Y1, Other_Player_X2, Other_Player_Y2, Choosen_Chess_Piece : in out Integer) is
      
   begin
      
      Graphic_Unmark_Position(Other_Player_X1, Other_Player_Y1);
      Graphic_Move_Chess_Piece(Other_Player_X2, Other_Player_Y2, Choosen_Chess_Piece);
      
      
   end Other_Player_Moves;
   
   
   Socket                       : Socket_Type;
   My_Color                     : Character;
   Actual_Game_Round_Case, X1, Y1, Chess_Type, Other_Player_X1, Other_Player_Y1, Other_Player_X2, Other_Player_Y2, Choosen_Chess_Piece : Integer;
   
begin
  
   Initiate(Socket);
   
   -- Anslut till Server 
   Connect(Socket, Argument(1), Positive'Value(Argument(2))); 
   
   Get(Socket, My_Color);
  
   
   if My_Color = 'w' then 
      Put("Du är vit");
   elsif My_Color = 'b' then
      Put("Du är svart");
   else
      -- Raise Error 
      Put("Fel");
   end if;
   
   
   -- Rita upp planen
   --- TODO: En snyggare plan  
   Draw_Complete_Game_Board; 
   
   loop
      -- Hämta Typ av runda:
      --- 1. Schack Matt
      --- 2. Schack
      --- 3. Regular
      --- 4. First Round 
      Get(Socket, Actual_Game_Round_Case);
      if Actual_Game_Round_Case /= 4 then
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
	    Put("Schack Matt");
	    Put_Line(Socket, 1);
	    -- TODO: Skapa Game_Over;
	    -- Game_Over;
	 when 2 =>
	    Put("Schack");
	    -- TODO: Skapa Graphic_Display_Is_Check;
	    --Graphic_Display_Is_Check; 
	    Play_Round(Socket, X1, Y1);
	 when 3 =>
	    Play_Round(Socket, X1, Y1);
	 when 4 => 
	    Put("ååh det är första gången för dig...");
	    Play_Round(Socket, X1, Y1);
	 when others =>
	    Put("FÄN det är fEL");
	    -- Raise Error 
      end case;
   end loop;
   
   
   
end Client_Main;
