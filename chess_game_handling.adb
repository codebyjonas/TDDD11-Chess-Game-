
package body Chess_Game_Handling is
   
   --INTERNA funktioner
 
   procedure Position_2_Coordinates( X, Y : in out Integer) is
   begin      
      if X = Offset_X + 1 and Y = Offset_Y + 1 then
	 X := X - Offset_X;
	 Y := Y - Offset_Y; 
      elsif X = Offset_X + 1 then 
	 X := X - Offset_X;
	 Y := (Y - 1 - Offset_Y) / 5 + 1;
      elsif Y = Offset_Y + 1 then
	 X := (X - 1 - Offset_X) / 10 + 1;
	 Y := Y - Offset_Y;
      else
	 X := (X - 1 - Offset_X) / 10 + 1;
	 Y := (Y - 1 - Offset_Y) / 5 + 1;
      end if;
   end Position_2_Coordinates;
   
   procedure Coordinates_2_Position(X , Y : in out Integer) is
   begin
      if X = 1 and Y = 1 then
	 X := X + Offset_X;
	 Y := Y + Offset_Y; 
      elsif X = 1 then 
	 X := X + Offset_X;
	 Y := (Y - 1) * 5 + 1 + Offset_Y;
      elsif Y = 1 then
	 X := (X - 1) * 10 + 1  + Offset_X;
	 Y := Y + Offset_Y;
      else
	 X := (X - 1) * 10 + 1 + Offset_X;
	 Y := (Y - 1) * 5 + 1 + Offset_Y;
       end if;
   end Coordinates_2_Position;
   
   
   -- Fråga Magnus om
   --  procedure Big_Cursor(X, Y, Chessman : in Integer := 0; Key : out Key_Type) is
   --     X_Tmp : Integer := X;
   --     Y_Tmp : Integer := Y;
   --  begin
   --     loop
   --  	 Get_Immediate(Key);
   --  	 Graphic_Mark_Position(X_Tmp, Y_Tmp, Chessman);
   --  	 delay 0.5;
   --  	 Graphic_Mark_Position(X_Tmp, Y_Tmp, Chessman, Highlight_Colour_Contrast, Highlight_Colour);
   --  	 delay 0.5;
   --     end loop;
   --  end Big_Cursor;
   
   procedure Move_Around_On_Game_Board(Socket : in out Socket_Type;
				       X,Y : in out Integer;
                                       Possible_Moves : in Cordinate_Array) is
                                                    
      Key       : Key_Type;
      Graphic_X : Integer := X; 
      Graphic_Y : Integer := Y;
      Chess_Piece_On_Cursor : Integer;
   begin
      --- Tänk på Sizen sen
      
      Put_Line(Socket, 1);
      Put_Line(Socket, Graphic_X);
      Put_Line(Socket, Graphic_Y);
      Get(Socket, Chess_Piece_On_Cursor);
      Coordinates_2_Position(Graphic_X, Graphic_Y);	 
      Goto_XY(Graphic_X, Graphic_Y);
      Position_2_Coordinates(Graphic_X, Graphic_Y);
      Graphic_Mark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor);
      loop
	
	 Get_Immediate(Key);
	 if Is_Up_Arrow(Key) then
	     Graphic_Unmark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor);
		  
	   
	    Graphic_Y := Graphic_Y - 1;
	    if Graphic_Y < 1 then
	       Graphic_Y := 8;
	    end if;
      elsif Is_Down_Arrow(Key) then
	    Graphic_Unmark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor);
	    Graphic_Y := Graphic_Y + 1;
	    if Graphic_Y > 8 then
	       Graphic_Y := 1;
	    end if;
	 elsif Is_Right_Arrow(Key) then
	    Graphic_Unmark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor);
	    Graphic_X := Graphic_X + 1;
	    if Graphic_X > 8 then
	       Graphic_X := 1;
	    end if;
	 elsif Is_Left_Arrow(Key) then   
	     Graphic_Unmark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor);
	    Graphic_X := Graphic_X - 1;
	    if Graphic_X < 1 then
	       Graphic_X := 8;
	    end if;
	 elsif Is_Return(Key) then
	    Graphic_Unmark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor);
	    X := Graphic_X;
	    Y := Graphic_Y;
	    Put(Socket, 0);
	    return;
	 end if;
	 	 
	 Put_Line(Socket, 1);
	 Put_Line(Socket, Graphic_X);
	 Put_Line(Socket, Graphic_Y);
	 Get(Socket, Chess_Piece_On_Cursor);
	   Coordinates_2_Position(Graphic_X, Graphic_Y);	 
	   Goto_XY(Graphic_X, Graphic_Y);
	   Position_2_Coordinates(Graphic_X, Graphic_Y);
	 Graphic_Mark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor);
      end loop;
   end Move_Around_On_Game_Board;
   
   
   -- PUBLIKA Funktioner, Samma ordning som i Ads

   procedure Choose_Active_Chessman(Socket : in out Socket_Type;
				    X,Y : out Integer;
                                    Possible_Moves : in Cordinate_Array) is
                                    
   begin
      -- Positonera markören 
      X := 6;
      Y := 6;
      Move_Around_On_Game_Board(Socket, X, Y, Possible_Moves);
     
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
      Get(Socket, Chess_Type);
   end Get_From_Socket;
   
   procedure Get_Possible_Moves_From_Socket(Socket: in Socket_Type; Possible_Move_Array: out Cordinate_Array) is
      X, Y, Chess_Type : Integer;
   begin
      for I in Cordinate_Array'Range loop 
         Get_From_Socket(Socket, X, Y, Chess_Type);
	 Possible_Move_Array(I).X := X;
	 Possible_Move_Array(I).Y := Y;
	 Possible_Move_Array(I).Chess_Type := Chess_Type;
      end loop;
   end Get_Possible_Moves_From_Socket;
   
   procedure Mark_Positions(Cordinates : in Cordinate_Array) is
      X , Y, C : Integer;
   begin
      for I in Cordinate_Array'Range loop
	 if Cordinates(I).X /= 0 and Cordinates(I).Y /= 0 then
	    X := Cordinates(I).X;
	    Y := Cordinates(I).Y;
	    C := Cordinates(I).Chess_Type;
	    Graphic_Mark_Position(X,Y,C);
	    Position_2_Coordinates(X,Y);
	 end if;
      end loop;
   end Mark_Positions;
   
   procedure Unmark_Positions(X, Y       : in out Integer;
			      Coordinates : in out Cordinate_Array) Is
   begin
      Graphic_Unmark_Position(X, Y);
      for I in Coordinates'Range loop
	 if Coordinates(I).X/=0 then
	    Graphic_Unmark_Position(Coordinates(I).X, Coordinates(I).Y);
	 end if;
      end loop;
   end Unmark_Positions;
   
   function Move_Okey(X, Y            : in Integer;
		       Possible_Moves : in Cordinate_Array) return boolean is
      
   begin
      for I in Possible_Moves'Range loop
	 if X = Possible_Moves(I).X and Y = Possible_Moves(I).Y then
	    return True;
	 end if;
      end loop;
      Beep;
      return False;
   end Move_Okey;
   			 			 
   
   procedure Choose_Your_Play(Socket         : in out Socket_Type;	   	  			  X, Y           : out Integer;					              Possible_Moves : in Cordinate_Array) is 
   begin
      -- Center on Game Field
      X := 6;
      Y := 6;
      Move_Around_On_Game_Board(Socket, X, Y, Possible_Moves);
      
      if Move_Okey(X, Y, Possible_Moves) = False then
	 Choose_Your_Play(Socket, X, Y, Possible_Moves);
      end if;
   end Choose_Your_Play;
   
   --- Försök till att inte kunna välja en pjäs utan möjliga drag. 
   function Check_If_Any_Possible_Moves(Active_Socket : in Socket_Type;
   					          Possible_Moves : in Cordinate_Array) return boolean is
      
   begin
      
      for I in Possible_Moves'Range loop
   	 if Possible_Moves(I).X /= 0 then
   	    return True; 	 
   	 end if;	 
      end loop;
      
      return False;
      
   end Check_If_Any_Possible_Moves;
   
   procedure Play_Round(Socket: in out Socket_Type;
   			X1, Y1 : out  Integer) is
      
      Possible_Moves                      : Cordinate_Array;
      X2, Y2, Choosen_Chess_Piece         : Integer;
     
   begin
      for I in Possible_Moves'Range loop
	 Possible_Moves(I).X := 0;
	 Possible_Moves(I).Y := 0;
	 Possible_Moves(I).Chess_Type := 0;
      end loop;
      loop
         Choose_Active_Chessman(Socket, X1, Y1, Possible_Moves);
	 Put_To_Socket(Socket, X1, Y1);
         Get_Possible_Moves_From_Socket(Socket, Possible_Moves);
	 if Check_If_Any_Possible_Moves(Socket, Possible_Moves) = True then
	    Put_Line(Socket, 1);
	    exit;
	 end if;
	 Put_Line(Socket, 0);
      end loop;
         
      -- Put_Array(Possible_Moves);
        
     
      Get(Socket, Choosen_Chess_Piece);
      Graphic_Mark_Position(X1, Y1, Choosen_Chess_Piece);
      Mark_Positions(Possible_Moves);
      -- Put_Chessman(Chessman_Number_2_Character(Choosen_Chess_Piece), X1, Y1); 
    
      Choose_Your_Play(Socket, X2, Y2, Possible_Moves);
      Unmark_Positions(X1, Y1, Possible_Moves);
      Graphic_Move_Chess_Piece(X2, Y2, Choosen_Chess_Piece);
      Put_To_Socket(Socket, X2, Y2);
      
   end Play_Round;
   
   procedure Settings is
   begin
      Set_Default_Text_Modes(Off, Off, On);
      Cursor_Invisible;
   end Settings;
   
   procedure Other_Player_Locked(Socket : in Socket_Type) is
      
      Key: Key_Type;	
      
   begin
      Goto_XY(10,2);
      Put("Hallå där, Det är motspelarerna tur. Tryck enter efter motspelaren har gjort sitt drag.");
      loop
	 Get_Immediate(Key);
	 
	 if Is_Return(Key) then
	    exit;
	 end if;
      end loop;
  
   end Other_Player_Locked;
   
   
   
   -- TMP och TEST funktioner
   procedure Put( Item : in Cordinate_Array) is
   begin
      for I in 1..28 loop 
	 Put(Item(I).X, 2);
	 Put(Item(I).Y, 2);
      end loop;
   end Put;
   
end Chess_Game_Handling;
