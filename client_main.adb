with Ada.Command_Line;    use Ada.Command_Line;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;

with TJa.Sockets;         use TJa.Sockets;

-- TODO Skapa paket
with Chess_Game_Handling; use Chess_Game_Handling;
with Chess_Game_Graphic;  use Chess_Game_Graphic;

procedure Client_Main is
   
   Socket                 : Socket_Type;
   My_Color               : Character;
   Actual_Game_Round_Case,X,Y : Integer;
   
begin
  
   Initiate(Socket);
   
   -- Anslut till Server 
   Connect(Socket, Argument(1), Positive'Value(Argument(2))); 
   
   -- Black or White 
   Get(Socket, My_Color);
   
   if My_Color = 'w' then 
      Put("Vit");
   elsif My_Color = 'b' then
      Put("Svart");
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
      
      
      -- Avgör vilket fall som ska köra 
      case Actual_Game_Round_Case is
	 when 1 => 
	    Put("Schack Matt");
	    -- TODO: Skapa Game_Over;
	    -- Game_Over;
	 when 2 =>
	    Put("Schack");
	    -- TODO: Skapa Graphic_Display_Is_Check;
	    --Graphic_Display_Is_Check; 
	    --- TODO: Skapa Game_Play_A_Round;
	    Choose_Active_Chessman(X,Y);
	    Put_To_Socket(Socket, X, Y);
	 when 3 =>
	    null;
	 when 4 => 
	    Put("ååh det är första gången för dig...");
	    Choose_Active_Chessman(X,Y);
	    Put_To_Socket(Socket, X, Y);
	    Get_From_Socket(Socket, X, Y);
	    Put(X);
	    Put(Y);
	 when others =>
	    Put("FÄN det är fEL");
	    -- Raise Error 
      end case;
   end loop;
   
   
   
end Client_Main;
