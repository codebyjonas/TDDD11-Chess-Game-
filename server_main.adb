


With Ada.Command_Line;       use Ada.Command_Line;
with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with Chess_Analysis_Package; use Chess_Analysis_Package;
with TJa.Sockets;            use TJa.Sockets;

procedure Server_Main is
   
     procedure Put(Socket: in Socket_Type; Possible_Array: in Return_Type) is
      
   begin
      
      for I in Possible_Array'Range loop
	 Put_Line(Socket, Possible_Array(I)(1));  -- Funkar det att använda Put_Line så här? 
	 Put_Line(Socket, Possible_Array(I)(2));
	 Put_Line(Socket, Possible_Array(I)(3));

      end loop;
      
      end Put;
      
      
      -- #####
      --Våra Underbar Variabler
      -- ####
      Listner                               : Listener_Type;
      Socket_1, Socket_2, Active_Socket     : Socket_Type;
      X, Y, Actual_Game_Round_Case, Player, Choosen_Chess_Piece, Possible_Move_Indicator  : Integer;
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
   
   
   -- Skickar info till klient om att det är första rundan.
   
   -- #####
   -- Main Loop
   -- #####
   
   Actual_Game_Round_Case := 4;
   loop
   
  
   
 
   -- Kolla Efter Schack Schack matt
   
      if Active_Player then 
	 Active_Socket := Socket_1;
	 elsif not Active_Player then
	    Active_Socket := Socket_2;
      end if;
      
      -- Gör draget som tidigare spelare gjorde
      if Actual_Game_Round_Case /= 4 then
	 Put_Line(Active_Socket, Actual_Game_Round_Case);
         Put_Line(Active_Socket, Coordinate_1(1));
	 Put_Line(Active_Socket, Coordinate_1(2));
	 Put_Line(Active_Socket, Coordinate_2(1));
	 Put_Line(Active_Socket, Coordinate_2(2));
	 Put_Line(Active_Socket, Choosen_Chess_Piece);
      else
         Put_Line(Active_Socket, Actual_Game_Round_Case);
      end if;
      
      

      -- Väntar på val av pjäs
      Possible_Move_Indicator := 0;
      loop
        Get(Active_Socket, X); 
        Get(Active_Socket, Y);
	Coordinate_1(1) := X;   -- X och Y är koordinaten för den pjäs som spelaren vill undersöka möjliga drag för
        Coordinate_1(2) := Y;
	Possible_Array :=Final_Possible_Moves(Coordinate_1, Active_Board, Active_Player);
	 --Skickar möjliga drag tillsammans med pjäs till Filip och Co:--
 
	Put(Active_Socket, Create_Array_With_Chessman_And_Position(Possible_Array, Active_Board));
	Get(Active_Socket, Possible_Move_Indicator);
       if Possible_Move_Indicator = 1  then
	  exit;
	end if;
	
      end loop;
      Coordinate_1(1) := X;   -- X och Y är koordinaten för den pjäs som spelaren vill undersöka möjliga drag för. 
      Coordinate_1(2) := Y;    
     
      
      --Tar reda på vilken typ av pjäs spelaren har valt och skickar till socket
       Choosen_Chess_Piece := Get_Choosen_Chess_Piece(Coordinate_1, Active_Board); 
       Put_Line(Active_Socket, Choosen_Chess_Piece);
      
 
	 
	 --Hämta X,Y från klient (Vilken position som Användaren valt)
      Get(Active_Socket, X);
      Get(Active_Socket, Y);
      Coordinate_2(1) := X;
      Coordinate_2(2) := Y;
      
      -- Flyttar vald pjäs från först vald position (Coord.1) till ny position som finns med i listan över möjliga drag (Coord. 2)
      Move(Active_Board, Coordinate_1, Coordinate_2);

      
      if Active_Player then
	 Active_Player := False;
      elsif not Active_Player then
	 Active_Player := True; 
      end if;
      Actual_Game_Round_Case := Check_Case(Active_Board, Active_Player);
     end loop;

      delay 1000.0;
   
end Server_Main;
