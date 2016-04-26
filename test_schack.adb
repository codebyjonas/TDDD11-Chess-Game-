with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

with Chess_Analysis_Package; use Chess_Analysis_Package;
   
procedure Test_Schack is   
   
   --     type Height_Type is
   --    array(1..8) of Integer;
   
   --  type Board_Type is
   --    array(1..8) of Height_Type;
   
   --  type Coordinate_Type is
   --    array(1..2) of Integer;
   
   --  type Possible_Moves_Type is
   --    array(1..28) of Coordinate_Type;
   
--     procedure Zero_Procedure(Board: in out Board_Type) is
      
--     begin
      
--        for I in Board'range loop
--  	 for J in Board'Range loop
--  	    Board(I)(J) := 0;
--  	 end loop;
--        end loop;
      
--        end Zero_Procedure;
   
--     procedure Reset(Board: in out Board_Type) is
      
--     begin
--        -- Nedan har vi gjort svarta--
--        Zero_Procedure(Board);
--        for I in 1..5 loop
--  	 Board(I)(1) := (-1)*I;
--        end loop;
--  	 for I in reverse 1..3 loop
--  	    Board(9-I)(1) := (-1)*I;
--  	 end loop;
--  	 for I in Height_Type'Range loop
--  	    Board(I)(2) := -6;
--  	 end loop;
	 
--  	 -- Nedan har vi gjort vita--
	 
	 
--  	  for I in 1..5 loop
--  	 Board(I)(8) := I;
--        end loop;
--  	 for I in reverse 1..3 loop
--  	    Board(9-I)(8) := I;
--  	 end loop;
--  	 for I in Height_Type'Range loop
--  	    Board(I)(7) := 6;
--  	 end loop;
       
--     end Reset;
   
--     procedure Move(Board : in out Board_Type; In_Coordinate, Out_Coordinate : in Coordinate_Type) is
--     begin
      
--        Board(Out_Coordinate(1))(Out_Coordinate(2)):= Board(In_Coordinate(1))(In_Coordinate(2));
--        Board(In_Coordinate(1))(In_Coordinate(2)):= 0;
--     end Move;
   
   
   
--     procedure Print_Board(Board: in Board_Type) is
      
--     begin
      
--        for I in Height_Type'Range loop
--  	 for J in Board'Range loop
--  	    Put(Board(J)(I), Width=>3);
--  	    Put(' ');
--  	 end loop;
--  	 New_Line;
--        end loop;
      
--     end Print_Board;
   
--     function "="(Left, Right : in Coordinate_Type) return Boolean is
      
--     begin
      
--        if Left(1) = Right(1) and Left(2) = Right(2) then
--  	 return True;
--        else 
--  	 return False;
--        end if;
--     end "=";
      
--        procedure Zero_Possible(Possible : in out Possible_Moves_Type) is
--        begin
--  	 for I in 1..Possible'length loop
--  	    Possible(I)(1):= 0;
--              Possible(I)(2) := 0;
--  	 end loop;
--  	 end Zero_Possible;
	 
	 
	  
--        function Search_Player(Player : in Integer;
--  			     Board : in Board_type) return Coordinate_Type is
--  	 Coordinate : Coordinate_Type;
--        begin
	 
--  	 for X in 1..Board'Length loop
--  	    for Y in 1..Board'Length loop
--  	       if Board(X)(Y) = Player then
--  		  Coordinate(1):=X;
--  		  Coordinate(2):=Y;
--  		  return Coordinate;
--  	       else 
--  		  Coordinate(1):= 0;
--  		  Coordinate(2):=0;
--  	       end if;
--  	    end loop;
--  	 end loop;
--  	 return Coordinate;
--  end Search_Player;


--  function Search_Coordinates(Moves_Array : in Possible_Moves_Type;
--  			    Coordinate : in Coordinate_Type)
--  			   return Boolean is
   
--  begin
   
--     for I in 1..Moves_Array'Length loop
--        if Moves_Array(I) = Coordinate then
--  	 return True;
--        end if;
--     end loop;
--     return False;
--     end Search_Coordinates;

      
    
      
	       
      
   
   --  procedure Put_Array(A : in  Possible_Moves_Type) is
   --  begin
   --     for I in  Possible_Moves_Type'Range loop
   --  	 Put(A(I)(1), 3);
   --  	 Put(A(I)(2), 3);
   --  	 New_Line;
   --     end loop;
      
   --  end Put_Array;
   
   procedure Put_Player(Board : in out Board_Type;
			X, Y, Player : in Integer) is
      
   begin
      
      Board(X)(Y) := Player;
   end Put_Player;
   
   
   
   
   
   --     procedure Search_And_Destroy(Coordinate: in Coordinate_Type; Possible_Moves : in out Possible_Moves_Type) is
      
--     begin
      
--        for I in 1..Possible_Moves'length loop
--  	 if Possible_Moves(I) = Coordinate then
--  	    Possible_Moves(I)(1):= 0;
--  	    Possible_Moves(I)(2):= 0;
--  	 end if;
	 
--        end loop;
--        end Search_And_Destroy;
   
--     function Tower_Move(Coordinate : in Coordinate_Type; Board: in Board_Type; Turn : in Integer) return Possible_Moves_Type is
--        Possible_Moves: Possible_Moves_Type;
--        Counter : Integer:=1;
--        X, Y : Integer;
      
   
        
--     begin
--          X :=Coordinate(1) ;
--  	    Y := Coordinate(2);
	    
      
--        Zero_Possible(Possible_Moves);
    
     
--        -- Checkar uppåt
--        for I in reverse 1..Y-1 loop

--  	 if  Board(X)(I) /= 0 then
--  	    if Board(X)(I) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
--  	       exit;
--  	    elsif  Board(X)(I) * Turn < 0  then       -- spelare olika log, kan knocka men inte bakom
--  	       Possible_Moves(Counter)(1) := X;
--  	       Possible_Moves(Counter)(2) := I;
--  	       Counter := Counter+1;
--  	       exit;
--  	    end if;
--  	 end if;
--  	 Possible_Moves(Counter)(1) := X;
--  	 Possible_Moves(Counter)(2) := I;
--  	 Counter := Counter+1;
--        end loop;
      
      
--       --Chexkar nedåt
--          for I in Y+1..Board'length loop
--  	if  Board(X)(I) /= 0 then
--  	   if Board(X)(I) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
--  	      exit;
--  	      elsif  Board(X)(I) * Turn < 0  then       -- spelare olika log, kan knocka men inte bakom
--  		 Possible_Moves(Counter)(1) := X;
--  		 Possible_Moves(Counter)(2) := I;
--  		 Counter := Counter+1;
--  		 exit;
--  	   end if;
--  	end if;
--  	 Possible_Moves(Counter)(1) := X;
--  		 Possible_Moves(Counter)(2) := I;
--  		 Counter := Counter+1;
--  	end loop;
	
--  	-- Checkar höger
--  	for I in X+1..Board'Length loop
--  	   if Board(I)(Y) /= 0 then
--  	      if Board(I)(Y) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
--  		 exit;
--  	      elsif  Board(I)(Y) * Turn < 0 then         -- spelare olika log, kan knocka men inte bakom
--  		 Possible_Moves(Counter)(1) := I;
--  		 Possible_Moves(Counter)(2) := Y;
--  		 Counter := Counter+1;
--  		 exit;
--  	      end if;
--  	   end if;
--  	   	 Possible_Moves(Counter)(1) := I;
--  		 Possible_Moves(Counter)(2) := Y;
--  		 Counter := Counter+1;
--  	end loop;
	
--  	-- Checkar vänster
--  	for I in reverse 1..X-1 loop
	   		 
--  	   if Board(I)(Y) /= 0 then
--  	      if Board(I)(Y) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
--  		 exit;
--  	      elsif  Board(I)(Y) * Turn < 0 then        -- spelare olika log, kan knocka men inte bakom
--  		 Possible_Moves(Counter)(1) := I;
--  		 Possible_Moves(Counter)(2) := Y;
--  		 Counter := Counter+1;
        
--  		 exit;
--  	      end if;
--  	   end if;
--  	    Possible_Moves(Counter)(1) := I;
--  		 Possible_Moves(Counter)(2) := Y;
--  		 Counter := Counter+1;
--  	end loop;
	
--  	return Possible_Moves;
--     end Tower_Move;
   
   
   
   
   
--     function Bishop_Move(Coordinate: in Coordinate_Type; Board: in Board_Type; Turn: in Integer) return Possible_Moves_Type is
--        Possible_Moves: Possible_Moves_Type;
--        X, Y, Z : Integer;
--        Counter : Integer:=1;
--     begin
      
--        X :=Coordinate(1);
--        Y := Coordinate(2);
      
--        Zero_Possible(Possible_Moves);
      
      
--         -- Vänster Uppåt
      
--        if X < Y then
--  	 Z := X;
--        else 
--  	 Z := Y;
--        end if;
      
     
--        for I in reverse 1..Z-1 loop
	 
--  	 if Board(X-Z+I)(Y-Z+I) /= 0 then
--  	    if Board(X-Z+I)(Y-Z+I) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
--  	       exit;
--  	    elsif  Board(X-Z+I)(Y-Z+I) * Turn < 0 then        -- spelare olika log, kan knocka men inte bakom
--  	       Possible_Moves(Counter)(1) := X-Z+I ;
--  	       Possible_Moves(Counter)(2) := Y-Z+I;
--  	       Counter := Counter+1;
--  	       exit;
--  	    end if;
--  	 end if;
--  	 Possible_Moves(Counter)(1) := X-Z+I;
--  	 Possible_Moves(Counter)(2) := Y-Z+I;
--  	 Counter := Counter+1;
--        end loop;
      
      
--        --  Höger uppåt
--        if 9-X < Y then
--  	 Z := 9-X;
--        else 
--  	 Z := Y;
--        end if;
      
--        for I in reverse 1..Z-1 loop
	 
--  	 if Board(X+Z-I)(Y-Z+I) /= 0 then
--  	    if Board(X+Z-I)(Y-Z+I) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
--  	       exit;
--  	    elsif  Board(X+Z-I)(Y-Z+I) * Turn < 0 then        -- spelare olika log, kan knocka men inte bakom
--  	       Possible_Moves(Counter)(1) := X+Z-I ;
--  	       Possible_Moves(Counter)(2) := Y-Z+I;
--  	       Counter := Counter+1;
--  	       exit;
--  	    end if;
--  	 end if;
--  	 Possible_Moves(Counter)(1) := X+Z-I;
--  	 Possible_Moves(Counter)(2) := Y-Z+I;
--  	 Counter := Counter+1;
--        end loop;
      
      
--        --  Höger nedåt
--        if 9-X < 9-Y then
--  	 Z := 9-X;
--        else 
--  	 Z := 9-Y;
--        end if;
      
--        for I in reverse 1..Z-1 loop
	 
--  	 if Board(X+Z-I)(Y+Z-I) /= 0 then
--  	    if Board(X+Z-I)(Y+Z-I) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
--  	       exit;
--  	    elsif  Board(X+Z-I)(Y+Z-I) * Turn < 0 then        -- spelare olika log, kan knocka men inte bakom
--  	       Possible_Moves(Counter)(1) := X+Z-I ;
--  	       Possible_Moves(Counter)(2) := Y+Z-I;
--  	       Counter := Counter+1;
--  	       exit;
--  	    end if;
--  	 end if;
--  	 Possible_Moves(Counter)(1) := X+Z-I;
--  	 Possible_Moves(Counter)(2) := Y+Z-I;
--  	 Counter := Counter+1;
--        end loop;
      
      
      
--        --  Vänster nedåt
--        if X < 9-Y then
--  	 Z := X;
--        else 
--  	 Z := 9-Y;
--        end if;
      
--        for I in reverse 1..Z-1 loop
	 
--  	 if Board(X-Z+I)(Y+Z-I) /= 0 then
--  	    if Board(X-Z+I)(Y+Z-I) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
--  	       exit;
--  	    elsif  Board(X-Z+I)(Y+Z-I) * Turn < 0 then        -- spelare olika log, kan knocka men inte bakom
--  	       Possible_Moves(Counter)(1) := X-Z+I ;
--  	       Possible_Moves(Counter)(2) := Y+Z-I;
--  	       Counter := Counter+1;
--  	       exit;
--  	    end if;
--  	 end if;
--  	 Possible_Moves(Counter)(1) := X-Z+I;
--  	 Possible_Moves(Counter)(2) := Y+Z-I;
--  	 Counter := Counter+1;
--        end loop;
--        return Possible_Moves;
      
--     end Bishop_Move;
   
   
--     function Queen_Move(Coordinate: in Coordinate_Type; Board: in Board_Type; Turn: in Integer) return Possible_Moves_Type is
      
--        function "+"(Left1, Right : in Possible_Moves_Type) return Possible_Moves_Type is
--  	 Counter : Integer:=1;
--  	 Left : Possible_Moves_type;
--        begin
--  	 Left:= Left1;
	 
	 
--  	 for I in 1..Left'Length loop
--  	    if Left(I)(1) = 0 then
--  	       exit;
--  	    end if;
--  	    Counter:= Counter +1;
--  	 end loop;
	 
--  	 for I in Counter..Right'Length loop
--  	    Left(I)(1) := Right(I-Counter+1)(1);
--  	    Left(I)(2) := Right(I-Counter+1)(2);
--  	 end loop;
--  	 return Left;
--        end "+";
      
      
--        Pos1 : Possible_Moves_Type;
--        Pos2 : Possible_Moves_Type;
--     begin
      
--        Pos1:= Tower_Move(Coordinate, Board, Turn);
--        Pos2:= Bishop_Move(Coordinate, Board, Turn);
      
--        return  Pos1 + Pos2;
--        end Queen_Move;
      
--        function Pawn_Move(Coordinate: in Coordinate_Type; Board: in Board_Type; Turn: in Integer) return Possible_Moves_Type is
--  	 X,Y, Counter : Integer;
--  	 Possible_Array : Possible_Moves_Type;
	 
--        begin
--  	 X := Coordinate(1);
--  	 Y := Coordinate(2);
--  	 Counter := 1;
	 
--  	 Zero_Possible(Possible_Array);
	 
--  	 if Board(X)(Y)* Turn  > 0 then
	 
--  	 if Board(X)(Y-1*Turn) = 0 then 
--  	    Possible_Array(Counter)(1) := X;
--  	    Possible_Array(Counter)(2) := Y-turn;
--  	    Counter := Counter +1;
	    
--  	    if Board(X)(Y-2*Turn) = 0 then 
--  	       Possible_Array(Counter)(1) := X;
--  	       Possible_Array(Counter)(2) := Y-2*turn;
--  	       Counter := Counter +1;

--  	    end if;
--  	 end if;
	 
--  	  if X /= 1 and Y /=1 and Y /=8 then
--  	     if Board(X-1)(Y-Turn)*Turn < 0 then
--  		Possible_Array(Counter)(1) := X-1;
--  		Possible_Array(Counter)(2) := Y-Turn;
--  		Counter := Counter + 1;
--  	     end if;
--  	  end if;
	  
--  	   if X /= 8 and Y /=1 and Y /=8 then
--  	     if Board(X+1)(Y-Turn)*Turn < 0 then
--  		Possible_Array(Counter)(1) := X+1;
--  		Possible_Array(Counter)(2) := Y-Turn;
--  		Counter := Counter + 1;
--  	     end if;
--  	  end if;
	    
--  	 end if;
	  
--  	  return Possible_Array;
	    
      
--        end Pawn_Move;
      
--        function Possible_Moves(Coordinate: in Coordinate_Type; Board : in Board_Type; Tur : in boolean) return Possible_Moves_Type is
	 
--  	 Possible_Moves: Possible_Moves_Type;
--  	 Turn : Integer;
--  	 Test_Board : Board_Type;
	

	 
--        begin
--  	 Zero_Possible(Possible_Moves);
	  
--  	 if Tur then
--  	    Turn := 1;     -- Vits tur
--  	 elsif not Tur then
--  	    Turn := -1;   -- Svarts tur
--  	 end if;
	 
	    
	 

--  	 if Board(Coordinate(1))(Coordinate(2)) = 0 then
--  	    return Possible_Moves;                                           -- Ingen på plats
--  	 elsif Board(Coordinate(1))(Coordinate(2)) = Turn * 1 then
--  	    Possible_Moves:= Tower_Move(Coordinate, Board, Turn);
--  	  --  elsif Board(Coordinate(1))(Coordinate(2)) = Turn * 2 then
--  	  --   Possible_Moves:= Knight_Move(Coordinate, Board, Turn);
--  	     elsif Board(Coordinate(1))(Coordinate(2)) = Turn *3 then
--  	        Possible_Moves:= Bishop_Move(Coordinate, Board, Turn);
--  	 elsif Board(Coordinate(1))(Coordinate(2)) = Turn *4 then
--  	    Possible_Moves := Queen_Move(Coordinate, Board, Turn);
--  	    --  elsif Board(Coordinate(1))(Coordinate(2)) = Turn * 5 then
--  	 --     Possible_Move:= King_Move(Coordinate, Board, Turn);
--  	 elsif Board(Coordinate(1))(Coordinate(2)) = Turn *6 then
--  	    Possible_Moves:= Pawn_Move(Coordinate, Board, Turn);
--  	 end if;
	 
--  	 -- Kolla nu om nåågon av dessa moves sätter dig i schack
	 
	 
--  	 --  for I in 1..Possible_Moves'Length loop
--  	 --     Test_Board:= Board;
--  	 --     Move(Test_Board, Coordinate, Possible_Moves(I));
--  	 --     if Schack(Test_Board, Tur) then
--  	 --        Search_And_Destroy( Possible_Moves(I), Possible_Moves);
--  	 --     end if;
--  	 --  end loop;
	 	 
--  	 return Possible_Moves;
--        end Possible_Moves;
      
     
--  	   function Schack(Board : in Board_Type; Tur : in Boolean) return Boolean is
	 

--  	 Not_Tur : Boolean;
--          Turn : Integer;
--  	 King_Coordinates, Coordinates : Coordinate_Type;
--  	 Moves_Array : Possible_Moves_type;
--        begin

--  	 if Tur then
--  	    Turn := 1;
--  	    Not_Tur := False;
--  	 else
--  	    Turn := -1;
--  	    Not_Tur := True;
--  	 end if;
	 
--  	 --Hittar var på brädet kungen står
--  	 King_Coordinates:= Search_Player(Turn*5, Board); 
	 
--  	-- Kontrollerar Alla Positioner Om De Kan Nå kungen
--  	 for Y in Board'Range loop
--  	    for X in Board'Range loop
--  	       Coordinates(1):=X;
--  	       Coordinates(2):=Y;
--  	       Moves_Array:= Possible_Moves(Coordinates, Board, Not_Tur);
--  	       if Search_Coordinates(Moves_Array, King_Coordinates) then
--  		  return True;
--  	       end if;
--  	    end loop;
--  	 end loop;
--  	 return False;
--        end Schack;
	 
      
      
      Board : Board_Type;
      Counter: Boolean:=true;
      Coordinate : Coordinate_Type;
      A : Possible_Moves_Type;
begin
   
 
   -- Schack test
   
   Counter := True;         -- vems tur , true = vit
   
   Zero_Procedure(Board);        -- Nollar brädet
--  Reset(Board);              -- ställer om brädet
   Put_Player(Board, 7, 7, 5); -- säter ut spelare (x-kord, Y-kord, vilken spelar)
  Put_Player(Board, 1, 7 , -1);
  Put_Player(Board, 2, 8 , -1);
  Put_Player(Board, 2, 2 , 6);
  Put_Player(Board, 7, 5 , -2);
  
   
    Coordinate(1) := 7;
   Coordinate(2) := 7;
   
   Print_Board(Board);
   
  Put_Array(Final_Possible_Moves(Coordinate, Board, Counter));
   
  if Check_mate(Board, Counter) then
     Put("SCAKCKK!!!!!!!!! MATE !!!!!!!!!!!!!!!!!");
  end if;
  
end Test_schack;
   
   
   
