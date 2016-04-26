
package body Chess_Game_Handling is
   
   --INTERNA funktioner
   procedure Position_2_Cordinates( X, Y : in out Integer) is
   begin      
      -- Gör till "Riktiga" Kordinater, simpelt nu
      X := X - 1;
      Y := Y - 1;
   end Position_2_Cordinates;
   
   procedure Cordinates_2_Position(X , Y : in out Integer) is
   begin
      X := X + 1;
      Y := Y + 1;
   end Cordinates_2_Position;
   
   procedure Move_Around_On_Game_Board(X,Y : in out Integer) is
      Key       : Key_Type;
      Graphic_X : Integer := X; 
      Graphic_Y : Integer := Y;
   begin
      --- Tänk på Sizen sen
      -- TODO: När man går utanför spelplanen ska man hoppas in från andra sidan
     
      loop
	 Get_Immediate(Key);
	 if Is_Up_Arrow(Key) then
	    Graphic_Y := Graphic_Y - 1;
	 elsif Is_Down_Arrow(Key) then
	    Graphic_Y := Graphic_Y + 1;
	 elsif Is_Right_Arrow(Key) then
	    Graphic_X := Graphic_X + 1;
	 elsif Is_Left_Arrow(Key) then   
	    Graphic_X := Graphic_X - 1;
	 elsif Is_Return(Key) then
	    X := Graphic_X;
	    Y := Graphic_Y;
	    return;
	 end if;
	 Goto_XY(Graphic_X, Graphic_Y);
      end loop;
   end Move_Around_On_Game_Board;
   
   -- PUBLIKA Funktioner, Samma ordning som i Ads

   procedure Choose_Active_Chessman(X,Y : out Integer) is
   begin
      -- Positonera markören 
      X := 6;
      Y := 6;
      Move_Around_On_Game_Board(X, Y);
      Graphic_Mark_Position(X, Y);
      Position_2_Cordinates(X, Y);
      
   end Choose_Active_Chessman;
   
   procedure Put_To_Socket(Socket : in Socket_Type;
			     X, Y : in Integer) is
      
   begin
      Put_Line(Socket, X);
      Put_Line(Socket, Y);
   end Put_To_Socket;
   
   procedure Get_From_Socket(Socket : in Socket_Type;
			     X, Y, Chess_Type   : out Integer) is
   begin
      Get(Socket, X);
      Get(Socket, Y);
     -- Get(Socket, Chess_Type);
   end Get_From_Socket;
   
   procedure Get_Possible_Moves_From_Socket(Socket: in Socket_Type; Possible_Move_Array: out Cordinate_Array) is
      X, Y, Chess_Type : Integer;
   begin
      for I in Cordinate_Array'Range loop 
         Get_From_Socket(Socket, X, Y, Chess_Type);
	 Possible_Move_Array(I).X := X;
	 Possible_Move_Array(I).Y := Y;
	-- Possible_Move_Array(I).Chess_Type := Chess_Type;
      end loop;
   end Get_Possible_Moves_From_Socket;
   
   procedure Mark_Positions(Cordinates : in Cordinate_Array) is
      X , Y : Integer;
   begin
      for I in Cordinate_Array'Range loop
	 if Cordinates(I).X /= 0 and Cordinates(I).Y /= 0 then
	    X := Cordinates(I).X;
	    Y := Cordinates(I).Y;
	    Cordinates_2_Position(X,Y);
	    Graphic_Mark_Position(X,Y);
	 end if;
      end loop;
   end Mark_Positions;
   
   procedure Unmark_Position(X, Y : in out Integer) is
      
   begin
      Cordinates_2_Position(X,Y);
      Goto_XY(X, Y);
      Put(' ');
      
   end Unmark_Position;
   
   function Move_Okey(X, Y : in Integer;
		       Possible_Moves : in Cordinate_Array) return boolean is
      
   begin
      for I in Possible_Moves'Range loop
	 
	 if X = Possible_Moves(I).X and Y = Possible_Moves(I).Y then
	    return True;
	 end if;
      end loop;
      
      return False;
      
   end Move_Okey;
       
   
   procedure Choose_Your_Play(X, Y : out Integer;
                              Possible_Moves : in Cordinate_Array) is 
   begin
      -- Center on Game Field
      X := 6;
      Y := 6;
      Move_Around_On_Game_Board(X, Y);
      Position_2_Cordinates(X, Y);
      if Move_Okey(X, Y, Possible_Moves) = False then
	 Choose_Your_Play(X, Y, Possible_Moves);
      end if;
      
   end Choose_Your_Play;
   
   -- TMP och TEST funktioner
   procedure Put( Item : in Cordinate_Array) is
   begin
      for I in 1..28 loop 
	 Put(Item(I).X, 2);
	 Put(Item(I).Y, 2);
      end loop;
   end Put;
   
end Chess_Game_Handling;
