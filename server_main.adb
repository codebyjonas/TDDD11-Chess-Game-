 


With Ada.Command_Line;       use Ada.Command_Line;
with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with Chess_Analysis_Package; use Chess_Analysis_Package;
with TJa.Sockets;            use TJa.Sockets;

procedure Server_Main is
   
      
       
      -- #####
      --Våra Underbar Variabler
      -- ####
      Listner                               : Listener_Type;
      Socket_1, Socket_2, Active_Socket     : Socket_Type;
      X, Y, Actual_Game_Round_Case, Choosen_Chess_Piece, Possible_Move_Indicator, Still_Moving_Indicator, Moving_X, Moving_Y  : Integer := 0;
      Active_Board                          : Board_Type;
      Active_Player                         : Boolean; -- True for White
      Coordinate_1, Coordinate_2            : Coordinate_Type;
      Possible_Array                        : Possible_Moves_Type; -- Borde heta Possible_Moves_Array, är ingen Data Typ

begin
   -- #####
   -- Start UP and Resets
   -- #####
   Reset(Active_Board);
   Active_Player := true; 
   
   
   -- Start Server with two sockets
   Initiate(Listner, Natural'Value(Argument(1)), Localhost => False);
   
   Wait_For_Connection(Listner, Socket_1); 
   Put_Line("Klient 1 ansluten");
   Wait_For_Connection(Listner, Socket_2);
   Put_Line("Klient 2 ansluten");
   
   -- Tilldela Klient 1 Vit och 2 Svart
   Put_Line(Socket_1, 'w');
   Put_Line(Socket_2, 'b');
   
   
   
   -- #####
   -- Main Loop
   -- #####
   
   Actual_Game_Round_Case := 4;
   loop
      -- Döda om Schack Matt
      if Actual_Game_Round_Case = 1 then
	 if Active_Player then 
	    Active_Socket := Socket_1;
	    Put_Line(Socket_2, 6);
	 elsif not Active_Player then
	    Active_Socket := Socket_2;
	    Put_Line(Socket_1, 6);	    
	 end if;
	 
      end if;
      
      
      if Active_Player then 
	 Active_Socket := Socket_1;
	 Put_Line(Socket_2, 5);
      elsif not Active_Player then
	 Active_Socket := Socket_2;
	 Put_Line(Socket_1, 5);	    
      end if;
      
      if Actual_Game_Round_Case /= 4 then
	 Put_Line(Active_Socket, Actual_Game_Round_Case);
	  Coordinate_To_Integers(Coordinate_1, X, Y);
         Put_Line(Active_Socket, X);
	 Put_Line(Active_Socket, Y);
	  Coordinate_To_Integers(Coordinate_2, X, Y);
	 Put_Line(Active_Socket, X);
	 Put_Line(Active_Socket, Y);
	 Put_Line(Active_Socket, Choosen_Chess_Piece);
      else
         Put_Line(Active_Socket, Actual_Game_Round_Case);
      end if;
      
      -- Väntar på val av pjäs
      Possible_Move_Indicator := 0;
      loop
	 loop 
	    Get(Active_Socket, Still_Moving_Indicator);
	    if Still_Moving_Indicator = 0 then
	       exit;
	    end if;
	    Get(Active_Socket, Moving_X);
	    Get(Active_Socket, Moving_Y);
	    Integers_To_Coordinate(Coordinate_1, Moving_X, Moving_Y);
	    Put_Line(Active_Socket, Get_Choosen_Chess_Piece(Coordinate_1, Active_Board));
	 end loop;
	 Get(Active_Socket, X); 
	 Get(Active_Socket, Y);
	 Integers_To_Coordinate(Coordinate_1, X, Y);
	 Possible_Array := Final_Possible_Moves(Coordinate_1, Active_Board, Active_Player);
	 Put(Active_Socket, Create_Array_With_Chessman_And_Position(Possible_Array, Active_Board));
	 Get(Active_Socket, Possible_Move_Indicator);
	 if Possible_Move_Indicator = 1  then
	    exit;
	 end if;
      end loop;
      
      Integers_To_Coordinate(Coordinate_1, X, Y);
      
      --Tar reda på vilken typ av pjäs spelaren har valt och skickar till socket
      Choosen_Chess_Piece := Get_Choosen_Chess_Piece(Coordinate_1, Active_Board); 
      Put_Line(Active_Socket, Choosen_Chess_Piece);
	 
       --Hämta X,Y från klient (Vilken position som Användaren valt)
      loop 
	 Get(Active_Socket, Still_Moving_Indicator);
	 if Still_Moving_Indicator = 0 then
	    exit;
	 end if;
	 Get(Active_Socket, Moving_X);
	 Get(Active_Socket, Moving_Y);
	 Integers_To_Coordinate(Coordinate_2, Moving_X, Moving_Y);
	 Put_Line(Active_Socket, Get_Choosen_Chess_Piece(Coordinate_2, Active_Board));
      end loop;  
	 
      -- Spelarens drag
      Get(Active_Socket, X);
      Get(Active_Socket, Y);
      Integers_To_Coordinate(Coordinate_2, X, Y);
      Move(Active_Board, Coordinate_1, Coordinate_2);
      
      -- Byt spelare
      if Active_Player then
	 Active_Player := False;
      elsif not Active_Player then
	 Active_Player := True; 
      end if;
      Actual_Game_Round_Case := Check_Case(Active_Board, Active_Player);
   end loop;
   
end Server_Main;
