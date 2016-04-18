--Gnatmake för hela bibloteket: gnatmake $(~TDDD11/TJa-lib/bin/tja_config) din_fil.adb


With Ada.Command_Line; use Ada.Command_Line;
with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

with TJa.Sockets;      use TJa.Sockets;

procedure Server_Main is
   
   Listner              : Listener_Type;
   Socket_1, Socket_2   : Socket_Type;
   X, Y, Actual_Game_Round_Case, Player  : Integer;
   
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
   
      -- TODO: Skapa en funktionen som väljer vilket "Case" rundan är och skickar med till klienten
      -- Set Actual_Game_Round_Case
      --- 1. Schack Matt
      --- 2. Schack
      --- 3. Regular
      --- 4. First Round 
	 
                 --Tillfällig funktion som håller koll på vems tur det är och skickar vilket game case det är till rätt socket.
      --  if Player=1 then --Skapa variabel Player_1 som kan anta värdena 1 och 2, som anger vems tur det är
      --  	 case Actual_Game_Round_Case is
      --            when 1=>
      --  	       Put_Line(Socket_1, 1);
      --  	    when 2=>
      --  	       Put_Line(Socket_1, 2);
      --  	    when 3=>
      --  	        Put_Line(Socket_1, 3);
      --  	    when 4=>
      --  	       Put_Line(Socket_1,4);
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
      
       Put_Line(Socket_1, 4);
       Put_Line(Socket_2, 3);
	  
	 
	 --Hämta X,Y från klient (Vilken position som Användaren valt)
      Get(Socket_1, X);
      Get(Socket_1, Y);
      Put(X);
      Put(Y);
      
      -- To do: Skapa en funktion som returnerar möjliga drag
      -- TODO: Skapa en Put för Cordinates_Array? som består av de möjliga dragen, DEN MÅSTE se LIKADAN ut som den i chess_game_handling
      --Antar att det har skickats in en Cordinate_Array med möjliga drag och skickar dom till spelare 1 //Filip
      --  for I in 1..28 loop
      --  	 Put_Line(Socket_1, Cordinate_Array(I).X);
      --  	 Put_Line(Socket_1, Cordinate_Array(I).Y);
      --  end loop;
	    
      
      -- TEMPORÄR KOD, simulerar ett output av en Cordinate_Array, 
      for I in 1..28 loop
	 Put_Line(Socket_1, 1);
	 Put_Line(Socket_1, 1);
      end loop;
      -- END TEMPORÄR KOD
      
      
      -- Här hämtar vi draget som klienten skickar, kommer dock inte vara validerat i dagsläget
      Get(Socket_1, X);
      Get(Socket_1, Y);
      Put(X, 2);
      Put(Y, 2);
      
      
      -- end loop;
      delay 1000.0;
   
end Server_Main;
