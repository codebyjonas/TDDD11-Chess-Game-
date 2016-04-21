--Gnatmake för hela bibloteket: gnatmake $(~TDDD11/TJa-lib/bin/tja_config) Din_fil.adb


With Ada.Command_Line;    use Ada.Command_Line;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

with TJa.Sockets;         use TJa.Sockets;

with Server_Check_Moves;  use Server_Check_Moves;

procedure Server_Main is
   
   Listner                               : Listener_Type;
   Socket_1, Socket_2, Actual_Socket     : Socket_Type;
   X, Y, Actual_Game_Round_Case          : Integer;
   Active_Board                          : Board_Type;
   Active_Coordinate                     : Coordinate_Type;
   Active_Player                         : Boolean := True; -- True: Vit osv
   Possible_Moves_Array                  : Possible_Moves_Type;
   Player                                : Integer := 1;
begin
   
   -- TODO: Skapa Error vid fel argument
   -- Start Server with two sockets
   Initiate(Listner, Natural'Value(Argument(1)), Localhost => True);
   
   Wait_For_Connection(Listner, Socket_1); 
   Put_Line("Klient 1 ansluten");
   Wait_For_Connection(Listner, Socket_2);
   Put_Line("Klient 2 ansluten");
   
   -- Tilldela Klient 1 Vit och 2 Svart
   Put_Line(Socket_1, 'w');
   Put_Line(Socket_2, 'b');
  
   
  -- loop 
      -- ? Behöver kanske en variabeler som håller koll på om det är spelare 1 eller 2 som spelare, upp till er Joel och DJ BEAR
      --- ELLER DET BEHÖVS! 
   if Player = 1 then
      Actual_Socket := Socket_1;
   else
      Actual_Socket := Socket_2;
   end if;
   
      -- TODO: Skapa en funktionen som väljer vilket "Case" rundan är och skickar med till klienten
      -- Set Actual_Game_Round_Case
      --- 1. Schack Matt
      --- 2. Schack
      --- 3. Regular
      --- 4. First Round 
	     
   
      --  	 case Actual_Game_Round_Case is
      --            when 1=>
      --  	       Put_Line(Actual_Socket, 1);
      --  	    when 2=>
      --  	       Put_Line(Actual_Socket, 2);
      --  	    when 3=>
      --  	        Put_Line(Actual_Socket, 3);
      --  	    when 4=>
      --  	       Put_Line(Actual_Socket, 4);
      --  	 end case;	
     
      
       Put_Line(Socket_1, 4);
       
	  
	 
	 --Hämta X,Y från klient (Vilken position som Användaren valt)
      Get(Socket_1, X);
      Get(Socket_1, Y);
      
      -- Gör till Kordinate
      Active_Coordinate(1) := X;
      Active_Coordinate(2) := Y;
     
      
      Possible_Moves_Array := Possible_Moves(Active_Coordinate, Active_Board, Active_Player);
      
      -- GÖr till UNDERFUNKTION!!!!
      for I in Possible_Moves_Type'Range loop
	 Put_Line(Socket_1,  Possible_Moves_Array(I)(1));
	 Put_Line(Socket_1,  Possible_Moves_Array(I)(2));
      end loop;
      
      
      -- Här hämtar vi draget som klienten skickar, kommer dock inte vara validerat i dagsläget
      Get(Socket_1, X);
      Get(Socket_1, Y);
      Put(X, 2);
      Put(Y, 2);
      
      --  --Byter spelare till nästa loop
      -- if Player = 1 then
      --    Player = 2;
      -- else
      --    Player = 1;
      -- end if;
      
      -- end loop;
      delay 1000.0;
   
end Server_Main;
