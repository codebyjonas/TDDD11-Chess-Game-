--Gnatmake för hela bibloteket: gnatmake $(~TDDD11/TJa-lib/bin/tja_config) din_fil.adb


With Ada.Command_Line; use Ada.Command_Line;
with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Chess_Analysis_Package; use Chess_Analysis_Package;
with TJa.Sockets;      use TJa.Sockets;

procedure Server_Main is
   
     procedure Put(Socket: in Socket_Type; Possible_Array: in Possible_Moves_Type) is
      
   begin
      
      for I in Possible_Array'Range loop
	 Put_Line(Socket, Possible_Array(I)(1));  -- Funkar det att använda Put_Line så här? 
	 Put_Line(Socket, Possible_Array(I)(2));
	 if Possible_Array(I)(1) = 0 and Possible_Array(I)(2) = 0 then exit;   --Om två nollor skickas finns inga fler möjliga drag. 
	 end if;
      end loop;
      
      end Put;
   
   Listner              : Listener_Type;
   Socket_1, Socket_2, Socket_3   : Socket_Type;
   X, Y, Actual_Game_Round_Case, Player  : Integer;
   Board : Board_Type;
    Counter: Boolean;
    Coordinate_1, Coordinate_2: Coordinate_Type;
    Possible_Array : Possible_Moves_Type;
   
begin
   
   Reset(Board);
   
   Counter:= true; 
   
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
   
   Put_Line(Socket_1, 4); -- Skickar info till klient om att det är första rundan.
   
  -- loop
      if Counter then 
	 Socket_3 := Socket_1;
	 elsif not Counter then
	    Socket_3 := Socket_2;
      end if;
      
      Get(Socket_3, X); -- Get_Line? 
      Get(Socket_3,Y);
      
      Coordinate_1(1) := X;   -- X och Y är koordinaten för den pjäs som spelaren vill undersöka möjliga drag för. 
      Coordinate_1(2) := Y;
      
      Possible_Array := Possible_Moves(Coordinate_1, Board, Counter);
      
      Put(Socket_3, Possible_Array); 
   
  -- loop 
      -- ? Behöver kanske en variabeler som håller koll på om det är spelare 1 eller 2 som spelare, upp till er Joel och DJ BEAR
      --- ELLER DET BEHÖVS! 
   
      -- TODO: Skapa en funktionen som väljer vilket "Case" rundan är och skickar med till klienten
      -- Set Actual_Game_Round_Case
      --- 1. Schack Matt
      --- 2. Schack
      --- 3. Regular
      --- 4. First Round 
	 
                 --Tillfällig funktion som håller koll på vems tur det är och skickar vilket game case det är till rätt socket.//Filip
      --  if Player=1 then 
      --  	 case Actual_Game_Round_Case is
      --            when 1=>
      --  	       Put_Line(Socket_1, 1);
      --  	    when 2=>
      --  	       Put_Line(Socket_1, 2);
      --  	    when 3=>
      --  	        Put_Line(Socket_1, 3);
      --  	    when 4=>
      --  	       Put_Line(Socket_1, 4);
      --  	 end case;	
      --  	 Player=2; --Byter spelare till nästa loop
      --  else
      --  	 case Actual_Game_Round_Case is
      --  	    when 1=>
      --  	       Put_Line(Socket_2, 1);
      --  	    when 2=>
      --  	       Put_Line(Socket_2, 2);
      --  	    when 3=>
      --  	        Put_Line(Socket_2, 3);
      --  	    when 4=>
      --  	       Put_Line(Socket_2,4);
      --  	 end case; 
      --  	 Player=1;--Byter spelare till nästa loop
      --  end if;
	  
	 
	 --Hämta X,Y från klient (Vilken position som Användaren valt)
      Get(Socket_3, X);
      Get(Socket_3, Y);
      Coordinate_2(1) := X;
      Coordinate_2(2) := Y;
      
      -- Flyttar vald pjäs från först vald position (Coord.1) till ny position som finns med i listan över möjliga drag (Coord. 2)
      Move(Board, Coordinate_1, Coordinate_2);
      
      if Counter then
	 Counter := False;
      elsif not Counter then
	 Counter := True; 
      end if;
      
 -- end loop;
      
      
      -- end loop;
      delay 1000.0;
   
end Server_Main;
