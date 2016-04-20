with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Projekt_Analys is
   
   
   type Height_Type is
     array(1..8) of Integer;
   
   type Board_Type is
     array(1..8) of Height_Type;
   
   type Coordinate_Type is
     array(1..2) of Integer;
   
   type Possible_Moves_Type is
     array(1..28) of Coordinate_Type;
   
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
   
   function Tower_Move(Coordinate : in Coordinate_Type; Board: in Board_Type; Turn : in Integer) return Possible_Moves_Type is
      Possible_Moves: Possible_Moves_Type;
      Counter : Integer:=1;
      X, Y : Integer;
      
      --  function Standard_Tower_Moves(Coordinate : in Coordinate_Type; Board: in Board_Type; Turn : in Integer) return Possible_Moves_Type is
      --  	Possible_Moves : Possible_Moves_Type; 
      --  	Coordinate_2 : Coordinate_Type;
      --  begin
      --  	 Zero_Possible(Possible_Moves);
      --  	 for I in 1..Board'length loop
      --  	    Coordinate_2(1):= I;
      --  	    Coordinate_2(2):= Coordinate(2);     -- Sätter de Horizontella koordinaterna
      --  	    Possible_Moves(I) :=Coordinate_2;
      --  	 end loop;
	 
      --  	  for I in 1..Board'length loop
      --  	    Coordinate_2(1):=Coordinate(1);
      --  	    Coordinate_2(2):= I;
      --  	    Possible_Moves(I+8) :=Coordinate_2;        -- Sätter de lodrätakoordinaterna
      --  	 end loop;
	 
      --  	 Search_And_Destroy(Coordinate, Possible_Moves);
	 
      --  	 return Possible_Moves;
      --  	 end Standard_Tower_Moves;
        
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
      
      function Possible_Moves(Coordinate: in Coordinate_Type; Board : in Board_Type; Tur : in boolean) return Possible_Moves_Type is
	 
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
	  --  elsif Board(Coordinate(1))(Coordinate(2)) = Turn * 2 then
	  --   return Knight_Move(Coordinate, Board, Turn);
	     elsif Board(Coordinate(1))(Coordinate(2)) = Turn *3 then
	        return Bishop_Move(Coordinate, Board, Turn);
	 elsif Board(Coordinate(1))(Coordinate(2)) = Turn *4 then
	    return Queen_Move(Coordinate, Board, Turn);
	    --  elsif Board(Coordinate(1))(Coordinate(2)) = Turn * 5 then
	 --     return King_Move(Coordinate, Board, Turn);
	 elsif Board(Coordinate(1))(Coordinate(2)) = Turn *6 then
	    return Pawn_Move(Coordinate, Board, Turn);
	 end if;
	 
	 return Possible_Moves;
      end Possible_Moves;
      
      
      procedure Put_Array(A : in  Possible_Moves_Type) is
      begin
	 for I in  Possible_Moves_Type'Range loop
	    Put(A(I)(1), 3);
	    Put(A(I)(2), 3);
	    New_Line;
	 end loop;
	 
      end Put_Array;
      
      
      Board : Board_Type;
      Counter: Boolean:=true;
      Coordinate_1, Coordinate_2, Coordinate_3 : Coordinate_Type;
      A,B : Possible_Moves_Type;
begin
   
   Reset(Board);
  
   
   
   Counter:= true;
   
   
   Coordinate_1(1):= 4;
   Coordinate_1(2) := 8;
   
   Coordinate_2(1):= 5;
   Coordinate_2(2) := 5;
   
   Coordinate_3(1) := 5;
   Coordinate_3(2) := 5;
   

   
 Move(Board, Coordinate_1, Coordinate_2);

   
    Print_Board(Board);

   A := Possible_Moves(Coordinate_3, Board, Counter);
   Put_Array(A);
   
   end Projekt_Analys;
   
   
   
   
   