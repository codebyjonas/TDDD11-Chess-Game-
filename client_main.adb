with Ada.Command_Line;    use Ada.Command_Line;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;

with TJa.Sockets;         use TJa.Sockets;

-- TODO Skapa paket
with Chess_Game_Handling; use Chess_Game_Handling;
with Chess_Game_Graphic;  use Chess_Game_Graphic;

procedure Client_Main is
   
   procedure Play_Round(Socket: in Socket_Type;
			X,  Y : in out Integer) is
      Possible_Moves : Cordinate_Array;
   begin
      --Här borde vi  ha två x- och y-koordinater. Ett par för vald pjäs och ett par för valt drag.
       Choose_Active_Chessman(X, Y);
       Put_To_Socket(Socket, X, Y);
       Get_Possible_Moves_From_Socket(Socket, Possible_Moves);
       Mark_Positions(Possible_Moves);
       Choose_Your_Play(X, Y);
       --Lägg till funktion Check_If_Move_Ok eller liknande
       Move_Chess_Piece(X, Y);
       Put_To_Socket(Socket, X, Y);
       
   end Play_Round;
   
   
   Socket                       : Socket_Type;
   My_Color                     : Character;
   Actual_Game_Round_Case, X, Y : Integer;
   
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
   delay 2.0;
   
   
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
	    Put_Line(Socket, 1);
	    -- TODO: Skapa Game_Over;
	    -- Game_Over;
	 when 2 =>
	    Put("Schack");
	    -- TODO: Skapa Graphic_Display_Is_Check;
	    --Graphic_Display_Is_Check; 
	    Play_Round(Socket, X, Y);
	 when 3 =>
	    Play_Round(Socket, X, Y);
	 when 4 => 
	    Put("ååh det är första gången för dig...");
	    Play_Round(Socket, X, Y);
	 when others =>
	    Put("FÄN det är fEL");
	    -- Raise Error 
      end case;
   end loop;
   
   
   
end Client_Main;
