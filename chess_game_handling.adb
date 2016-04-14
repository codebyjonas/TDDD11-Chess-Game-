
package body Chess_Game_Handling is
   
   --INTERNA funktioner
   procedure Position_2_Cordinates( X, Y : in out Integer) is
   begin      
      -- Gör till "Riktiga" Kordinater, simpelt nu
      X := X - 1;
      Y := Y - 1;
      
      Goto_XY(12, 2);
      Put(X);
      Put(Y);
   end Position_2_Cordinates;
   
   
   -- Samma ordning som i Ads

   procedure Choose_Active_Chessman(X,Y : out Integer) is
      Key                  : Key_Type;
      Graphic_X, Graphic_Y : Integer := 6;
      Black, White         : Character;
   begin
    -- Set_Buffer_Mode(Off);
     --Set_Echo_Mode(Off);
      
      -- Positonera markören 
      --- Tänk på Sizen sen
      -- TODO: När man går utanför spelplanen ska man hoppas in från andra sidan
      Goto_XY(Graphic_X, Graphic_Y);
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
	    Graphic_Mark_Position(Graphic_X, Graphic_Y);
	    Position_2_Cordinates(Graphic_X, Graphic_Y);
	    X := Graphic_X;
	    Y := Graphic_Y;
	    exit;
	 end if;
	 Goto_XY(Graphic_X, Graphic_Y);
	 
      end loop;
   end Choose_Active_Chessman;
   
   procedure Put_To_Socket(Socket : in Socket_Type;
			     X, Y : in Integer) is
      
   begin
      Put_Line(Socket, X);
      Put_Line(Socket, Y);
      
   end Put_To_Socket;
   
   procedure Get_From_Socket(Socket : in Socket_Type;
			     X, Y   : out Integer) is
   begin
      Get(Socket, X);
      Get(Socket, Y);
   end Get_From_Socket;
   
   procedure Get_Possible_Moves_From_Socket(Socket: in Socket_Type;					       				  			Possible_Move_Array: out Cordinate_Array) is
      x, y : Integer;
   begin
      for I in 1..28 loop 
         Get_From_Socket(Socket, x, y);
	 Possible_Move_Array(I).X := x;
	 Possible_Move_Array(I).Y := y;
      end loop;
          
   end Get_Possible_Moves_From_Socket;
   
  
   
end Chess_Game_Handling;
