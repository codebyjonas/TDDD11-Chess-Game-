
package body Chess_Analysis_Package is
   
  
   procedure Zero_Procedure(Board: in out Board_Type) is
      
   begin
      
      for I in Board'range loop
	 for J in Board'Range loop
	    Board(I)(J) := 0;
	 end loop;
      end loop;
      
      end Zero_Procedure;
   
   procedure Reset(Board: in out Board_Type) is
      
   begin
      -- Nedan har vi gjort svarta--
      Zero_Procedure(Board);
      for I in 1..5 loop
	 Board(I)(1) := (-1)*I;
      end loop;
	 for I in reverse 1..3 loop
	    Board(9-I)(1) := (-1)*I;
	 end loop;
	 for I in Height_Type'Range loop
	    Board(I)(2) := -6;
	 end loop;
	 
	 -- Nedan har vi gjort vita--
	 
	 
	  for I in 1..5 loop
	 Board(I)(8) := I;
      end loop;
	 for I in reverse 1..3 loop
	    Board(9-I)(8) := I;
	 end loop;
	 for I in Height_Type'Range loop
	    Board(I)(7) := 6;
	 end loop;
       
   end Reset;
   
   
   procedure Move(Board : in out Board_Type; In_Coordinate, Out_Coordinate : in Coordinate_Type) is
   begin
      Board(Out_Coordinate(1))(Out_Coordinate(2)):= Board(In_Coordinate(1))(In_Coordinate(2));
      Board(In_Coordinate(1))(In_Coordinate(2)):= 0;
   end Move;
   
   
   
   procedure Print_Board(Board: in Board_Type) is
      
   begin
      
      for I in Height_Type'Range loop
	 for J in Board'Range loop
	    Put(Board(J)(I), Width=>3);
	    Put(' ');
	 end loop;
	 New_Line;
      end loop;
      
   end Print_Board;
   
   function "="(Left, Right : in Coordinate_Type) return Boolean is
      
   begin
      
      if Left(1) = Right(1) and Left(2) = Right(2) then
	 return True;
      else 
	 return False;
      end if;
      
   end "=";
      
      procedure Zero_Possible(Possible : in out Possible_Moves_Type) is
      begin
	 for I in 1..Possible'length loop
	    Possible(I)(1):= 0;
            Possible(I)(2) := 0;
	 end loop;
	 end Zero_Possible;
   
   procedure Search_And_Destroy(Coordinate: in Coordinate_Type; Possible_Moves : in out Possible_Moves_Type) is
      
   begin
      
      for I in 1..Possible_Moves'length loop
	 if Possible_Moves(I) = Coordinate then
	    Possible_Moves(I)(1):= 0;
	    Possible_Moves(I)(2):= 0;
	 end if;
	 
      end loop;
   end Search_And_Destroy;
   
   
    function Possible_Moves(Coordinate: in Coordinate_Type; Board : in Board_Type; Tur : in boolean) return Possible_Moves_Type is
   
   function Tower_Move(Coordinate : in Coordinate_Type; Board: in Board_Type; Turn : in Integer) return Possible_Moves_Type is
      Possible_Moves: Possible_Moves_Type;
      Counter : Integer:=1;
      X, Y : Integer;
        
   begin
        X :=Coordinate(1) ;
	    Y := Coordinate(2);
	    
      
      Zero_Possible(Possible_Moves);
    
     
      -- Checkar uppåt
      for I in reverse 1..Y-1 loop

	 if  Board(X)(I) /= 0 then
	    if Board(X)(I) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
	       exit;
	    elsif  Board(X)(I) * Turn < 0  then       -- spelare olika log, kan knocka men inte bakom
	       Possible_Moves(Counter)(1) := X;
	       Possible_Moves(Counter)(2) := I;
	       Counter := Counter+1;
	       exit;
	    end if;
	 end if;
	 Possible_Moves(Counter)(1) := X;
	 Possible_Moves(Counter)(2) := I;
	 Counter := Counter+1;
      end loop;
      
      
     --Chexkar nedåt
        for I in Y+1..Board'length loop
	if  Board(X)(I) /= 0 then
	   if Board(X)(I) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
	      exit;
	      elsif  Board(X)(I) * Turn < 0  then       -- spelare olika log, kan knocka men inte bakom
		 Possible_Moves(Counter)(1) := X;
		 Possible_Moves(Counter)(2) := I;
		 Counter := Counter+1;
		 exit;
	   end if;
	end if;
	 Possible_Moves(Counter)(1) := X;
		 Possible_Moves(Counter)(2) := I;
		 Counter := Counter+1;
	end loop;
	
	-- Checkar höger
	for I in X+1..Board'Length loop
	   if Board(I)(Y) /= 0 then
	      if Board(I)(Y) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
		 exit;
	      elsif  Board(I)(Y) * Turn < 0 then         -- spelare olika log, kan knocka men inte bakom
		 Possible_Moves(Counter)(1) := I;
		 Possible_Moves(Counter)(2) := Y;
		 Counter := Counter+1;
		 exit;
	      end if;
	   end if;
	   	 Possible_Moves(Counter)(1) := I;
		 Possible_Moves(Counter)(2) := Y;
		 Counter := Counter+1;
	end loop;
	
	-- Checkar vänster
	for I in reverse 1..X-1 loop
	   		 
	   if Board(I)(Y) /= 0 then
	      if Board(I)(Y) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
		 exit;
	      elsif  Board(I)(Y) * Turn < 0 then        -- spelare olika log, kan knocka men inte bakom
		 Possible_Moves(Counter)(1) := I;
		 Possible_Moves(Counter)(2) := Y;
		 Counter := Counter+1;
        
		 exit;
	      end if;
	   end if;
	    Possible_Moves(Counter)(1) := I;
		 Possible_Moves(Counter)(2) := Y;
		 Counter := Counter+1;
	end loop;
	
	return Possible_Moves;
	
   end Tower_Move;
   
   function Bishop_Move(Coordinate: in Coordinate_Type; Board: in Board_Type; Turn: in Integer) return Possible_Moves_Type is
      Possible_Moves: Possible_Moves_Type;
      X, Y, Z : Integer;
      Counter : Integer:=1;
   begin
      
      X :=Coordinate(1);
      Y := Coordinate(2);
      
      Zero_Possible(Possible_Moves);
      
      
       -- Vänster Uppåt
      
      if X < Y then
	 Z := X;
      else 
	 Z := Y;
      end if;
      
     
      for I in reverse 1..Z-1 loop
	 
	 if Board(X-Z+I)(Y-Z+I) /= 0 then
	    if Board(X-Z+I)(Y-Z+I) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
	       exit;
	    elsif  Board(X-Z+I)(Y-Z+I) * Turn < 0 then        -- spelare olika log, kan knocka men inte bakom
	       Possible_Moves(Counter)(1) := X-Z+I ;
	       Possible_Moves(Counter)(2) := Y-Z+I;
	       Counter := Counter+1;
	       exit;
	    end if;
	 end if;
	 Possible_Moves(Counter)(1) := X-Z+I;
	 Possible_Moves(Counter)(2) := Y-Z+I;
	 Counter := Counter+1;
      end loop;
      
      
      --  Höger uppåt
      if 9-X < Y then
	 Z := 9-X;
      else 
	 Z := Y;
      end if;
      
      for I in reverse 1..Z-1 loop
	 
	 if Board(X+Z-I)(Y-Z+I) /= 0 then
	    if Board(X+Z-I)(Y-Z+I) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
	       exit;
	    elsif  Board(X+Z-I)(Y-Z+I) * Turn < 0 then        -- spelare olika log, kan knocka men inte bakom
	       Possible_Moves(Counter)(1) := X+Z-I ;
	       Possible_Moves(Counter)(2) := Y-Z+I;
	       Counter := Counter+1;
	       exit;
	    end if;
	 end if;
	 Possible_Moves(Counter)(1) := X+Z-I;
	 Possible_Moves(Counter)(2) := Y-Z+I;
	 Counter := Counter+1;
      end loop;
      
      
      --  Höger nedåt
      if 9-X < 9-Y then
	 Z := 9-X;
      else 
	 Z := 9-Y;
      end if;
      
      for I in reverse 1..Z-1 loop
	 
	 if Board(X+Z-I)(Y+Z-I) /= 0 then
	    if Board(X+Z-I)(Y+Z-I) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
	       exit;
	    elsif  Board(X+Z-I)(Y+Z-I) * Turn < 0 then        -- spelare olika log, kan knocka men inte bakom
	       Possible_Moves(Counter)(1) := X+Z-I ;
	       Possible_Moves(Counter)(2) := Y+Z-I;
	       Counter := Counter+1;
	       exit;
	    end if;
	 end if;
	 Possible_Moves(Counter)(1) := X+Z-I;
	 Possible_Moves(Counter)(2) := Y+Z-I;
	 Counter := Counter+1;
      end loop;
      
      
      
      --  Vänster nedåt
      if X < 9-Y then
	 Z := X;
      else 
	 Z := 9-Y;
      end if;
      
      for I in reverse 1..Z-1 loop
	 
	 if Board(X-Z+I)(Y+Z-I) /= 0 then
	    if Board(X-Z+I)(Y+Z-I) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
	       exit;
	    elsif  Board(X-Z+I)(Y+Z-I) * Turn < 0 then        -- spelare olika log, kan knocka men inte bakom
	       Possible_Moves(Counter)(1) := X-Z+I ;
	       Possible_Moves(Counter)(2) := Y+Z-I;
	       Counter := Counter+1;
	       exit;
	    end if;
	 end if;
	 Possible_Moves(Counter)(1) := X-Z+I;
	 Possible_Moves(Counter)(2) := Y+Z-I;
	 Counter := Counter+1;
      end loop;
      return Possible_Moves;
      
   end Bishop_Move;
   
   
   function Queen_Move(Coordinate: in Coordinate_Type; Board: in Board_Type; Turn: in Integer) return Possible_Moves_Type is
      
      function "+"(Left1, Right : in Possible_Moves_Type) return Possible_Moves_Type is
	 Counter : Integer:=1;
	 Left : Possible_Moves_type;
      begin
	 Left:= Left1;
	 
	 
	 for I in 1..Left'Length loop
	    if Left(I)(1) = 0 then
	       exit;
	    end if;
	    Counter:= Counter +1;
	 end loop;
	 
	 for I in Counter..Right'Length loop
	    Left(I)(1) := Right(I-Counter+1)(1);
	    Left(I)(2) := Right(I-Counter+1)(2);
	 end loop;
	 return Left;
      end "+";
      
      
      Pos1 : Possible_Moves_Type;
      Pos2 : Possible_Moves_Type;
   begin
      
      Pos1:= Tower_Move(Coordinate, Board, Turn);
      Pos2:= Bishop_Move(Coordinate, Board, Turn);
      
      return  Pos1 + Pos2;
      end Queen_Move;
      
      function Pawn_Move(Coordinate: in Coordinate_Type; Board: in Board_Type; Turn: in Integer) return Possible_Moves_Type is
	 X,Y, Counter : Integer;
	 Possible_Array : Possible_Moves_Type;
	 
      begin
	 X := Coordinate(1);
	 Y := Coordinate(2);
	 Counter := 1;
	 
	 Zero_Possible(Possible_Array);
	 
	 if Board(X)(Y)* Turn  > 0 then
	 
	 if Board(X)(Y-1*Turn) = 0 then 
	    Possible_Array(Counter)(1) := X;
	    Possible_Array(Counter)(2) := Y-turn;
	    Counter := Counter +1;
	    
	    if Board(X)(Y-2*Turn) = 0 then 
	       Possible_Array(Counter)(1) := X;
	       Possible_Array(Counter)(2) := Y-2*turn;
	       Counter := Counter +1;

	    end if;
	 end if;
	 
	  if X /= 1 and Y /=1 and Y /=8 then
	     if Board(X-1)(Y-Turn)*Turn < 0 then
		Possible_Array(Counter)(1) := X-1;
		Possible_Array(Counter)(2) := Y-Turn;
		Counter := Counter + 1;
	     end if;
	  end if;
	  
	   if X /= 8 and Y /=1 and Y /=8 then
	     if Board(X+1)(Y-Turn)*Turn < 0 then
		Possible_Array(Counter)(1) := X+1;
		Possible_Array(Counter)(2) := Y-Turn;
		Counter := Counter + 1;
	     end if;
	  end if;
	    
	 end if;
	  
	  return Possible_Array;
	    
      
      end Pawn_Move;
      
      function King_Move(Coordinate: in Coordinate_Type; Board: in Board_Type; Turn: in Integer) return Possible_Moves_Type is
	 
	 X,Y, Counter: Integer;
	 Possible_Moves: Possible_Moves_Type;
	 
      begin
	 
	 X := Coordinate(1);
	 Y := Coordinate(2);
	 Counter := 1;
	 
	 Zero_Possible(Possible_Moves);
	 
	 --Kollar uppåt-- 
	 if Y > 1 then
	 if Board(X)(Y-1)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X;
	    Possible_Moves(Counter)(2) := Y-1;
	    Counter := Counter + 1;
	 end if;
	 end if;
	 
	 --Kollar nedåt-- 
	  if Y < 8 then
	 if Board(X)(Y+1)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X;
	    Possible_Moves(Counter)(2) := Y+1;
	    Counter := Counter + 1;
	 end if;
	 end if;
	 
	 --Kollar vänster-- 
	  if X > 1 then
	 if Board(X-1)(Y)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X-1;
	    Possible_Moves(Counter)(2) := Y;
	    Counter := Counter + 1;
	 end if;
	 end if;
	 
	  --Kollar höger-- 
	  if X < 8 then
	 if Board(X+1)(Y)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X+1;
	    Possible_Moves(Counter)(2) := Y;
	    Counter := Counter + 1;
	 end if;
	 end if;
	 
	 --Kollar snett uppåt vänster--
	 if X > 1 and Y > 1 then
	    if Board(X-1)(Y-1)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X-1;
	    Possible_Moves(Counter)(2) := Y-1;
	    Counter := Counter + 1;
	    end if;
	 end if;
	 
	  --Kollar snett uppåt höger--
	 if X < 8 and Y > 1 then
	    if Board(X+1)(Y-1)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X+1;
	    Possible_Moves(Counter)(2) := Y-1;
	    Counter := Counter + 1;
	    end if;
	 end if;
	 
	  --Kollar snett nedåt vänster--
	 if X > 1 and Y < 8 then
	    if Board(X-1)(Y+1)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X-1;
	    Possible_Moves(Counter)(2) := Y+1;
	    Counter := Counter + 1;
	    end if;
	 end if;
	 
	  --Kollar snett nedåt höger--
	 if X < 8 and Y < 8 then
	    if Board(X+1)(Y+1)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X+1;
	    Possible_Moves(Counter)(2) := Y+1;
	    Counter := Counter + 1;
	    end if;
	 end if;
	    
	 return Possible_Moves;
	 
      end King_Move;
      
       function Knight_Move(Coordinate: in Coordinate_Type; Board: in Board_Type; Turn: in Integer) return Possible_Moves_Type is
	 
	 X,Y, Counter: Integer;
	 Possible_Moves: Possible_Moves_Type;
	 
      begin
	 
	 X := Coordinate(1);
	 Y := Coordinate(2);
	 Counter := 1;
	 
	 Zero_Possible(Possible_Moves);
	 
	 --Kollar uppåt höger-- 
	 if X < 8 and Y > 2 then
	 if Board(X+1)(Y-2)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X+1;
	    Possible_Moves(Counter)(2) := Y-2;
	    Counter := Counter + 1;
	 end if;
	 end if;
	 
	 --Kollar lägre uppåt höger-- 
	  if X < 7 and Y > 1 then
	 if Board(X+2)(Y-1)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X+2;
	    Possible_Moves(Counter)(2) := Y-1;
	    Counter := Counter + 1;
	 end if;
	 end if;
	 
	 --Kollar övre nedåt höger-- 
	  if X < 7 and Y < 8 then
	 if Board(X+2)(Y+1)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X+2;
	    Possible_Moves(Counter)(2) := Y+1;
	    Counter := Counter + 1;
	 end if;
	 end if;
	 
	  --Kollar nedåt höger-- 
	  if X < 8 and Y < 7 then
	 if Board(X+1)(Y+2)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X+1;
	    Possible_Moves(Counter)(2) := Y+2;
	    Counter := Counter + 1;
	 end if;
	 end if;
	 
	 --Kollar uppåt vänster--
	 if X > 1 and Y > 2 then
	    if Board(X-1)(Y-2)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X-1;
	    Possible_Moves(Counter)(2) := Y-2;
	    Counter := Counter + 1;
	    end if;
	 end if;
	 
	  --Kollar lägre uppåt vänster--
	 if X > 2 and Y > 1 then
	    if Board(X-2)(Y-1)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X-2;
	    Possible_Moves(Counter)(2) := Y-1;
	    Counter := Counter + 1;
	    end if;
	 end if;
	 
	  --Kollar övre nedåt vänster--
	 if X > 2 and Y < 8 then
	    if Board(X-2)(Y+1)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X-2;
	    Possible_Moves(Counter)(2) := Y+1;
	    Counter := Counter + 1;
	    end if;
	 end if;
	 
	  --Kollar snett nedåt höger--
	 if X > 1 and Y < 7 then
	    if Board(X-1)(Y+2)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X-1;
	    Possible_Moves(Counter)(2) := Y+2;
	    Counter := Counter + 1;
	    end if;
	 end if;
	    
	 return Possible_Moves;
	 
	 end Knight_Move;
	 
	 Possible_Moves: Possible_Moves_Type;
	 Turn : Integer;
	 
      begin
	 Zero_Possible(Possible_Moves);
	  
	 if Tur then
	    Turn := 1;     -- Vits tur
	 elsif not Tur then
	    Turn := -1;   -- Svarts tur
	 end if;
	 
	 if Board(Coordinate(1))(Coordinate(2)) = 0 then
	    return Possible_Moves;                                           -- Ingen på plats
	 elsif Board(Coordinate(1))(Coordinate(2)) = Turn * 1 then
	    return Tower_Move(Coordinate, Board, Turn);
	   elsif Board(Coordinate(1))(Coordinate(2)) = Turn * 2 then
	   return Knight_Move(Coordinate, Board, Turn);
	     elsif Board(Coordinate(1))(Coordinate(2)) = Turn *3 then
	        return Bishop_Move(Coordinate, Board, Turn);
	 elsif Board(Coordinate(1))(Coordinate(2)) = Turn *4 then
	    return Queen_Move(Coordinate, Board, Turn);
	     elsif Board(Coordinate(1))(Coordinate(2)) = Turn * 5 then
	  return King_Move(Coordinate, Board, Turn);
	 elsif Board(Coordinate(1))(Coordinate(2)) = Turn *6 then
	    return Pawn_Move(Coordinate, Board, Turn);
	 end if;
	 
	 return Possible_Moves;
      end Possible_Moves;
      
      
      procedure Put_Array(A : in  Possible_Moves_Type) is     -- Skriver ut array med möjliga drag-- 
      begin
	 for I in  Possible_Moves_Type'Range loop
	    Put(A(I)(1), 3);
	    Put(A(I)(2), 3);
	    New_Line;
	 end loop;
	 
      end Put_Array;
      
      
      
      -- Första parametern representerar en spelare och functionen returnerar vilken coordinat denne står på
        function Search_Player(Player : in Integer;
			     Board : in Board_type) return Coordinate_Type is
	 Coordinate : Coordinate_Type;
      begin
	 
	 for X in 1..Board'Length loop
	    for Y in 1..Board'Length loop
	       if Board(X)(Y) = Player then
		  Coordinate(1):=X;
		  Coordinate(2):=Y;
		  return Coordinate;
	       else 
		  Coordinate(1):= 0;
		  Coordinate(2):=0;
	       end if;
	    end loop;
	 end loop;
	 return Coordinate;
end Search_Player;
      
      
      
      
      -- Letar i första parrametern efter den cordinat som skickas in som andra parameter. 
      function Search_Coordinates(Moves_Array : in Possible_Moves_Type;
			    Coordinate : in Coordinate_Type)
			   return Boolean is
   
begin
   
   for I in 1..Moves_Array'Length loop
      if Moves_Array(I) = Coordinate then
	 return True;
      end if;
   end loop;
   return False;
   end Search_Coordinates;

      
      
      -- kollar alla nuvarande positioner och möjliga drag för motståndarens för varje pjäs och om någon av dem kan nå kungen.
     	   function Schack(Board : in Board_Type; Tur : in Boolean) return Boolean is
	 Not_Tur : Boolean;
        Turn : Integer;
	 King_Coordinates, Coordinates : Coordinate_Type;
	 Moves_Array : Possible_Moves_type;
      begin

	 if Tur then
	    Turn := 1;
	    Not_Tur := False;
	 else
	    Turn := -1;
	    Not_Tur := True;
	 end if;
	 
	 --Hittar var på brädet kungen står
	 King_Coordinates:= Search_Player(Turn*5, Board); 
	 
	-- Kontrollerar Alla Positioner Om De Kan Nå kungen
	 for Y in Board'Range loop
	    for X in Board'Range loop
	       Coordinates(1):=X;
	       Coordinates(2):=Y;
	       Moves_Array:= Possible_Moves(Coordinates, Board, Not_Tur);
	       if Search_Coordinates(Moves_Array, King_Coordinates) then
		  return True;
	       end if;
	    end loop;
	 end loop;
	 return False;
      end Schack; 
      
      
      function Final_Possible_Moves(Coordinate: in Coordinate_Type; Board : in Board_Type; Tur : in boolean) return Possible_Moves_Type is
      	 
	   function Tower_Move(Coordinate : in Coordinate_Type; Board: in Board_Type; Turn : in Integer) return Possible_Moves_Type is
      Possible_Moves: Possible_Moves_Type;
      Counter : Integer:=1;
      X, Y : Integer;
        
   begin
        X :=Coordinate(1) ;
	    Y := Coordinate(2);
	    
      
      Zero_Possible(Possible_Moves);
    
     
      -- Checkar uppåt
      for I in reverse 1..Y-1 loop

	 if  Board(X)(I) /= 0 then
	    if Board(X)(I) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
	       exit;
	    elsif  Board(X)(I) * Turn < 0  then       -- spelare olika log, kan knocka men inte bakom
	       Possible_Moves(Counter)(1) := X;
	       Possible_Moves(Counter)(2) := I;
	       Counter := Counter+1;
	       exit;
	    end if;
	 end if;
	 Possible_Moves(Counter)(1) := X;
	 Possible_Moves(Counter)(2) := I;
	 Counter := Counter+1;
      end loop;
      
      
     --Chexkar nedåt
        for I in Y+1..Board'length loop
	if  Board(X)(I) /= 0 then
	   if Board(X)(I) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
	      exit;
	      elsif  Board(X)(I) * Turn < 0  then       -- spelare olika log, kan knocka men inte bakom
		 Possible_Moves(Counter)(1) := X;
		 Possible_Moves(Counter)(2) := I;
		 Counter := Counter+1;
		 exit;
	   end if;
	end if;
	 Possible_Moves(Counter)(1) := X;
		 Possible_Moves(Counter)(2) := I;
		 Counter := Counter+1;
	end loop;
	
	-- Checkar höger
	for I in X+1..Board'Length loop
	   if Board(I)(Y) /= 0 then
	      if Board(I)(Y) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
		 exit;
	      elsif  Board(I)(Y) * Turn < 0 then         -- spelare olika log, kan knocka men inte bakom
		 Possible_Moves(Counter)(1) := I;
		 Possible_Moves(Counter)(2) := Y;
		 Counter := Counter+1;
		 exit;
	      end if;
	   end if;
	   	 Possible_Moves(Counter)(1) := I;
		 Possible_Moves(Counter)(2) := Y;
		 Counter := Counter+1;
	end loop;
	
	-- Checkar vänster
	for I in reverse 1..X-1 loop
	   		 
	   if Board(I)(Y) /= 0 then
	      if Board(I)(Y) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
		 exit;
	      elsif  Board(I)(Y) * Turn < 0 then        -- spelare olika log, kan knocka men inte bakom
		 Possible_Moves(Counter)(1) := I;
		 Possible_Moves(Counter)(2) := Y;
		 Counter := Counter+1;
        
		 exit;
	      end if;
	   end if;
	    Possible_Moves(Counter)(1) := I;
		 Possible_Moves(Counter)(2) := Y;
		 Counter := Counter+1;
	end loop;
	
	return Possible_Moves;
	
   end Tower_Move;
   
   function Bishop_Move(Coordinate: in Coordinate_Type; Board: in Board_Type; Turn: in Integer) return Possible_Moves_Type is
      Possible_Moves: Possible_Moves_Type;
      X, Y, Z : Integer;
      Counter : Integer:=1;
   begin
      
      X :=Coordinate(1);
      Y := Coordinate(2);
      
      Zero_Possible(Possible_Moves);
      
      
       -- Vänster Uppåt
      
      if X < Y then
	 Z := X;
      else 
	 Z := Y;
      end if;
      
     
      for I in reverse 1..Z-1 loop
	 
	 if Board(X-Z+I)(Y-Z+I) /= 0 then
	    if Board(X-Z+I)(Y-Z+I) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
	       exit;
	    elsif  Board(X-Z+I)(Y-Z+I) * Turn < 0 then        -- spelare olika log, kan knocka men inte bakom
	       Possible_Moves(Counter)(1) := X-Z+I ;
	       Possible_Moves(Counter)(2) := Y-Z+I;
	       Counter := Counter+1;
	       exit;
	    end if;
	 end if;
	 Possible_Moves(Counter)(1) := X-Z+I;
	 Possible_Moves(Counter)(2) := Y-Z+I;
	 Counter := Counter+1;
      end loop;
      
      
      --  Höger uppåt
      if 9-X < Y then
	 Z := 9-X;
      else 
	 Z := Y;
      end if;
      
      for I in reverse 1..Z-1 loop
	 
	 if Board(X+Z-I)(Y-Z+I) /= 0 then
	    if Board(X+Z-I)(Y-Z+I) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
	       exit;
	    elsif  Board(X+Z-I)(Y-Z+I) * Turn < 0 then        -- spelare olika log, kan knocka men inte bakom
	       Possible_Moves(Counter)(1) := X+Z-I ;
	       Possible_Moves(Counter)(2) := Y-Z+I;
	       Counter := Counter+1;
	       exit;
	    end if;
	 end if;
	 Possible_Moves(Counter)(1) := X+Z-I;
	 Possible_Moves(Counter)(2) := Y-Z+I;
	 Counter := Counter+1;
      end loop;
      
      
      --  Höger nedåt
      if 9-X < 9-Y then
	 Z := 9-X;
      else 
	 Z := 9-Y;
      end if;
      
      for I in reverse 1..Z-1 loop
	 
	 if Board(X+Z-I)(Y+Z-I) /= 0 then
	    if Board(X+Z-I)(Y+Z-I) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
	       exit;
	    elsif  Board(X+Z-I)(Y+Z-I) * Turn < 0 then        -- spelare olika log, kan knocka men inte bakom
	       Possible_Moves(Counter)(1) := X+Z-I ;
	       Possible_Moves(Counter)(2) := Y+Z-I;
	       Counter := Counter+1;
	       exit;
	    end if;
	 end if;
	 Possible_Moves(Counter)(1) := X+Z-I;
	 Possible_Moves(Counter)(2) := Y+Z-I;
	 Counter := Counter+1;
      end loop;
      
      
      
      --  Vänster nedåt
      if X < 9-Y then
	 Z := X;
      else 
	 Z := 9-Y;
      end if;
      
      for I in reverse 1..Z-1 loop
	 
	 if Board(X-Z+I)(Y+Z-I) /= 0 then
	    if Board(X-Z+I)(Y+Z-I) * Turn > 0 then      -- Spelarna är i samma lag o knockas inte
	       exit;
	    elsif  Board(X-Z+I)(Y+Z-I) * Turn < 0 then        -- spelare olika log, kan knocka men inte bakom
	       Possible_Moves(Counter)(1) := X-Z+I ;
	       Possible_Moves(Counter)(2) := Y+Z-I;
	       Counter := Counter+1;
	       exit;
	    end if;
	 end if;
	 Possible_Moves(Counter)(1) := X-Z+I;
	 Possible_Moves(Counter)(2) := Y+Z-I;
	 Counter := Counter+1;
      end loop;
      return Possible_Moves;
      
   end Bishop_Move;
   
   
   function Queen_Move(Coordinate: in Coordinate_Type; Board: in Board_Type; Turn: in Integer) return Possible_Moves_Type is
      
      function "+"(Left1, Right : in Possible_Moves_Type) return Possible_Moves_Type is
	 Counter : Integer:=1;
	 Left : Possible_Moves_type;
      begin
	 Left:= Left1;
	 
	 
	 for I in 1..Left'Length loop
	    if Left(I)(1) = 0 then
	       exit;
	    end if;
	    Counter:= Counter +1;
	 end loop;
	 
	 for I in Counter..Right'Length loop
	    Left(I)(1) := Right(I-Counter+1)(1);
	    Left(I)(2) := Right(I-Counter+1)(2);
	 end loop;
	 return Left;
      end "+";
      
      
      Pos1 : Possible_Moves_Type;
      Pos2 : Possible_Moves_Type;
   begin
      
      Pos1:= Tower_Move(Coordinate, Board, Turn);
      Pos2:= Bishop_Move(Coordinate, Board, Turn);
      
      return  Pos1 + Pos2;
      end Queen_Move;
      
      function Pawn_Move(Coordinate: in Coordinate_Type; Board: in Board_Type; Turn: in Integer) return Possible_Moves_Type is
	 X,Y, Counter : Integer;
	 Possible_Array : Possible_Moves_Type;
	 
      begin
	 X := Coordinate(1);
	 Y := Coordinate(2);
	 Counter := 1;
	 
	 Zero_Possible(Possible_Array);
	 
	 if Board(X)(Y)* Turn  > 0 then
	 
	 if Board(X)(Y-1*Turn) = 0 then 
	    Possible_Array(Counter)(1) := X;
	    Possible_Array(Counter)(2) := Y-turn;
	    Counter := Counter +1;
	    
	    if (Y=2 and Turn < 0) or (Y = 7 and Turn > 0) then 
	    if Board(X)(Y-2*Turn) = 0 then 
	       Possible_Array(Counter)(1) := X;
	       Possible_Array(Counter)(2) := Y-2*turn;
	       Counter := Counter +1;
	    end if;
	    end if;
	    
	    
	 end if;
	 
	  if X /= 1 and Y /=1 and Y /=8 then
	     if Board(X-1)(Y-Turn)*Turn < 0 then
		Possible_Array(Counter)(1) := X-1;
		Possible_Array(Counter)(2) := Y-Turn;
		Counter := Counter + 1;
	     end if;
	  end if;
	  
	   if X /= 8 and Y /=1 and Y /=8 then
	     if Board(X+1)(Y-Turn)*Turn < 0 then
		Possible_Array(Counter)(1) := X+1;
		Possible_Array(Counter)(2) := Y-Turn;
		Counter := Counter + 1;
	     end if;
	  end if;
	    
	 end if;
	  
	  return Possible_Array;
	    
      
      end Pawn_Move;
      
      function King_Move(Coordinate: in Coordinate_Type; Board: in Board_Type; Turn: in Integer) return Possible_Moves_Type is
	 
	 X,Y, Counter: Integer;
	 Possible_Moves: Possible_Moves_Type;
	 
      begin
	 
	 X := Coordinate(1);
	 Y := Coordinate(2);
	 Counter := 1;
	 
	 Zero_Possible(Possible_Moves);
	 
	 --Kollar uppåt-- 
	 if Y > 1 then
	 if Board(X)(Y-1)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X;
	    Possible_Moves(Counter)(2) := Y-1;
	    Counter := Counter + 1;
	 end if;
	 end if;
	 
	 --Kollar nedåt-- 
	  if Y < 8 then
	 if Board(X)(Y+1)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X;
	    Possible_Moves(Counter)(2) := Y+1;
	    Counter := Counter + 1;
	 end if;
	 end if;
	 
	 --Kollar vänster-- 
	  if X > 1 then
	 if Board(X-1)(Y)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X-1;
	    Possible_Moves(Counter)(2) := Y;
	    Counter := Counter + 1;
	 end if;
	 end if;
	 
	  --Kollar höger-- 
	  if X < 8 then
	 if Board(X+1)(Y)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X+1;
	    Possible_Moves(Counter)(2) := Y;
	    Counter := Counter + 1;
	 end if;
	 end if;
	 
	 --Kollar snett uppåt vänster--
	 if X > 1 and Y > 1 then
	    if Board(X-1)(Y-1)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X-1;
	    Possible_Moves(Counter)(2) := Y-1;
	    Counter := Counter + 1;
	    end if;
	 end if;
	 
	  --Kollar snett uppåt höger--
	 if X < 8 and Y > 1 then
	    if Board(X+1)(Y-1)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X+1;
	    Possible_Moves(Counter)(2) := Y-1;
	    Counter := Counter + 1;
	    end if;
	 end if;
	 
	  --Kollar snett nedåt vänster--
	 if X > 1 and Y < 8 then
	    if Board(X-1)(Y+1)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X-1;
	    Possible_Moves(Counter)(2) := Y+1;
	    Counter := Counter + 1;
	    end if;
	 end if;
	 
	  --Kollar snett nedåt höger--
	 if X < 8 and Y < 8 then
	    if Board(X+1)(Y+1)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X+1;
	    Possible_Moves(Counter)(2) := Y+1;
	    Counter := Counter + 1;
	    end if;
	 end if;
	    
	 return Possible_Moves;
	 
      end King_Move;
      
       function Knight_Move(Coordinate: in Coordinate_Type; Board: in Board_Type; Turn: in Integer) return Possible_Moves_Type is
	 
	 X,Y, Counter: Integer;
	 Possible_Moves: Possible_Moves_Type;
	 
      begin
	 
	 X := Coordinate(1);
	 Y := Coordinate(2);
	 Counter := 1;
	 
	 Zero_Possible(Possible_Moves);
	 
	 --Kollar uppåt höger-- 
	 if X < 8 and Y > 2 then
	 if Board(X+1)(Y-2)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X+1;
	    Possible_Moves(Counter)(2) := Y-2;
	    Counter := Counter + 1;
	 end if;
	 end if;
	 
	 --Kollar lägre uppåt höger-- 
	  if X < 7 and Y > 1 then
	 if Board(X+2)(Y-1)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X+2;
	    Possible_Moves(Counter)(2) := Y-1;
	    Counter := Counter + 1;
	 end if;
	 end if;
	 
	 --Kollar övre nedåt höger-- 
	  if X < 7 and Y < 8 then
	 if Board(X+2)(Y+1)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X+2;
	    Possible_Moves(Counter)(2) := Y+1;
	    Counter := Counter + 1;
	 end if;
	 end if;
	 
	  --Kollar nedåt höger-- 
	  if X < 8 and Y < 7 then
	 if Board(X+1)(Y+2)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X+1;
	    Possible_Moves(Counter)(2) := Y+2;
	    Counter := Counter + 1;
	 end if;
	 end if;
	 
	 --Kollar uppåt vänster--
	 if X > 1 and Y > 2 then
	    if Board(X-1)(Y-2)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X-1;
	    Possible_Moves(Counter)(2) := Y-2;
	    Counter := Counter + 1;
	    end if;
	 end if;
	 
	  --Kollar lägre uppåt vänster--
	 if X > 2 and Y > 1 then
	    if Board(X-2)(Y-1)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X-2;
	    Possible_Moves(Counter)(2) := Y-1;
	    Counter := Counter + 1;
	    end if;
	 end if;
	 
	  --Kollar övre nedåt vänster--
	 if X > 2 and Y < 8 then
	    if Board(X-2)(Y+1)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X-2;
	    Possible_Moves(Counter)(2) := Y+1;
	    Counter := Counter + 1;
	    end if;
	 end if;
	 
	  --Kollar snett nedåt höger--
	 if X > 1 and Y < 7 then
	    if Board(X-1)(Y+2)*Turn <= 0 then
	    Possible_Moves(Counter)(1) := X-1;
	    Possible_Moves(Counter)(2) := Y+2;
	    Counter := Counter + 1;
	    end if;
	 end if;
	    
	 return Possible_Moves;
	 
	 end Knight_Move;
	 
	Final_Possible_Moves: Possible_Moves_Type;
	 Turn : Integer;
	 Fake_Board : Board_Type;
      begin
	 Zero_Possible(Final_Possible_Moves);
	  
	 if Tur then
	    Turn := 1;     -- Vits tur
	 elsif not Tur then
	    Turn := -1;   -- Svarts tur
	 end if;
	 
	 if Board(Coordinate(1))(Coordinate(2)) = 0 then
	    return Final_Possible_Moves;                                           -- Ingen på plats
	 elsif Board(Coordinate(1))(Coordinate(2)) = Turn * 1 then
	    Final_Possible_Moves:= Tower_Move(Coordinate, Board, Turn);
	   elsif Board(Coordinate(1))(Coordinate(2)) = Turn * 2 then
	      Final_Possible_Moves:= Knight_Move(Coordinate, Board, Turn);
	 elsif Board(Coordinate(1))(Coordinate(2)) = Turn *3 then
	    Final_Possible_Moves:= Bishop_Move(Coordinate, Board, Turn);
	 elsif Board(Coordinate(1))(Coordinate(2)) = Turn *4 then
	    Final_Possible_Moves:= Queen_Move(Coordinate, Board, Turn);
	 elsif Board(Coordinate(1))(Coordinate(2)) = Turn * 5 then
	    Final_Possible_Moves:= King_Move(Coordinate, Board, Turn);
	 elsif Board(Coordinate(1))(Coordinate(2)) = Turn *6 then
	    Final_Possible_Moves:= Pawn_Move(Coordinate, Board, Turn);
	 end if;
	 
	 for I in 1..Final_Possible_Moves'Length loop
	    Fake_Board:=Board;
	    if Final_Possible_Moves(I)(1) /= 0 then
	    Fake_Board(Final_Possible_Moves(I)(1))(Final_Possible_Moves(I)(2)):= Fake_Board(Coordinate(1))(Coordinate(2));
		       Fake_Board(Coordinate(1))(Coordinate(2)):=0;
		       if Schack(Fake_Board, Tur) then
	    Final_Possible_Moves(I)(1):=0;
	    Final_Possible_Moves(I)(2):=0;
		       end if;
	    end if;
	    
	 end loop;
	 
	 
	 
	 return Final_Possible_Moves;
      end Final_Possible_Moves;
      
      function "="(Left, Right : in Possible_Moves_Type) return Boolean is
	 
      begin
	 
	 for I in 1..Right'Length loop
	    if not (Left(I) = Right(I)) then
	       return False;
	    end if;
	 end loop;
	 
	 return True;
      end "=";
      
	
	 
	 
	 
      
      function Check_Mate(Board : in Board_Type; Tur : in Boolean) return Boolean is
	 

     Turn : Integer;
	 King_Coordinates, Coordinates : Coordinate_Type;
     Moves_Array, Zero_Array : Possible_Moves_type;
      begin
	 
      Zero_Possible(Zero_Array);
	 if Tur then
	    Turn := 1;

	 else
	    Turn := -1;
	 end if;
	 
	 --Hittar var på brädet kungen står
	 King_Coordinates:= Search_Player(Turn*5, Board); 
	 
	-- Kontrollerar Alla Positioner Om De Kan Nå kungen
	 for Y in Board'Range loop
	    for X in Board'Range loop
	       Coordinates(1):=X;
	       Coordinates(2):=Y;
	       Moves_Array:=Final_Possible_Moves(Coordinates, Board, Tur);
	       if not (Moves_Array = Zero_Array) then
		  return False;
	       end if;
	    end loop;
	 end loop;
	 return true;
      end Check_Mate;
      
      function Till_Filip(Moves: in Possible_Moves_Type; Board: in Board_Type) return Return_Type is
	 
	 Return_Array : Return_Type;
	 
      begin
	 
	 for I in 1..Moves'Length loop
	    Return_Array(I)(1) := Moves(I)(1);
	    Return_Array(I)(2) := Moves(I)(2);
	    Return_Array(I)(3) := Board(Moves(I)(1))(Moves(I)(1));
	 end loop;
	 
	 return Return_Array;
	 
      end Till_Filip;
      
      function Check_Case(Active_Board: in Board_Type; Active_Player: in Boolean) return Integer is
	 
      begin
	 
	 if Check_Mate(Active_Board, Active_Player) then
	    return 1;
	 elsif Schack(Active_Board, Active_Player) then
	    return 2;
	 else 
	    return  3;
	 end if;
      end Check_Case;
      
end Chess_Analysis_Package;

   
   
   
   
 
