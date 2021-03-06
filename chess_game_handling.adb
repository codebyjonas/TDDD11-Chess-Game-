

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
      null;
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
   
   procedure Move_Around_On_Game_Board(Socket : in out Socket_Type;
				       X1, Y1 : in Integer;
				       X2, Y2 : out Integer;
                                       Possible_Moves : in Cordinate_Array;
				       First_Time : in out Boolean) is
                                                    
      Key       : Key_Type;
      Graphic_X : Integer := X1; 
      Graphic_Y : Integer := Y1;
      Chess_Piece_On_Cursor, Chess_Piece_On_Cursor_2, X3, Y3 : Integer;
      On_Cursor : Boolean := True;
   begin
      
      Put_Line(Socket, 1);
      Put_Line(Socket, Graphic_X);
      Put_Line(Socket, Graphic_Y);
      Get(Socket, Chess_Piece_On_Cursor);
      Coordinates_2_Position(Graphic_X, Graphic_Y);	 
      Goto_XY(Graphic_X, Graphic_Y);
      Position_2_Coordinates(Graphic_X, Graphic_Y);
      Graphic_Mark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor, Secondary_Highlight_Colour, Secondary_Highlight_Colour_Contrast);
      if First_Time then
         Chess_Piece_On_Cursor_2 := Chess_Piece_On_Cursor;
      end if;   
      
      loop
	 		 
	 Get_Immediate(Key);
	 if Is_Up_Arrow(Key) then
	    if First_Time and Graphic_X = X1 and Graphic_Y = Y1 then
               Graphic_Unmark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor_2);
	    elsif Graphic_X = X1 and Graphic_Y = Y1 then
	       Graphic_Mark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor);
            end if;  
	    
	    if (Graphic_X /= X1) or (Graphic_Y /= Y1) then
	       for I in Possible_Moves'Range loop
		  if Graphic_X = Possible_Moves(I).X and Graphic_Y = Possible_Moves(I).Y then 		     
		     Graphic_Mark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor);
		     exit;
	          end if;
		  if I = Possible_Moves'Length then
		     Graphic_Unmark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor);
		  end if;
	       end loop;
	       
	    end if;		  	   
	    Graphic_Y := Graphic_Y - 1;
	    if Graphic_Y < 1 then
	       Graphic_Y := 8;
	    end if;
	 elsif Is_Down_Arrow(Key) then
	    if First_Time and Graphic_X = X1 and Graphic_Y = Y1 then
               Graphic_Unmark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor_2);
	    elsif Graphic_X = X1 and Graphic_Y = Y1 then
	       Graphic_Mark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor);
            end if;  
	    if (Graphic_X /= X1) or (Graphic_Y /= Y1) then
	       for I in Possible_Moves'Range loop
		  if Graphic_X = Possible_Moves(I).X and Graphic_Y = Possible_Moves(I).Y then 		    
		     Graphic_Mark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor);
		     exit;  		     
	          end if;
		  if I = Possible_Moves'Length then
		     Graphic_Unmark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor);
		  end if;
	       end loop;
	       	       
	    end if;
	    Graphic_Y := Graphic_Y + 1;
	    if Graphic_Y > 8 then
	       Graphic_Y := 1;
	    end if;
	 elsif Is_Right_Arrow(Key) then
	    if First_Time and Graphic_X = X1 and Graphic_Y = Y1 then
               Graphic_Unmark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor_2);
	    elsif Graphic_X = X1 and Graphic_Y = Y1 then
	       Graphic_Mark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor);
            end if;  
	    if (Graphic_X /= X1) or (Graphic_Y /= Y1) then
	       for I in Possible_Moves'Range loop
		  if Graphic_X = Possible_Moves(I).X and Graphic_Y = Possible_Moves(I).Y then 
		     Graphic_Mark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor);
		     exit;  		     
	          end if;
		  if I = Possible_Moves'Length then
		     Graphic_Unmark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor);
		  end if;
	       end loop;

	       
	    end if;
	    Graphic_X := Graphic_X + 1;
	    if Graphic_X > 8 then
	       Graphic_X := 1;
	    end if;
	 elsif Is_Left_Arrow(Key) then 
	    if First_Time and Graphic_X = X1 and Graphic_Y = Y1 then
               Graphic_Unmark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor_2);
	    elsif Graphic_X = X1 and Graphic_Y = Y1 then
	       Graphic_Mark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor);
            end if;  
	    if (Graphic_X /= X1) or (Graphic_Y /= Y1) then
	       for I in Possible_Moves'Range loop
		  if Graphic_X = Possible_Moves(I).X and Graphic_Y = Possible_Moves(I).Y then 
		     Graphic_Mark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor);
		     exit;  		     
	          end if;
		  if I = Possible_Moves'Length then
		     Graphic_Unmark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor);
		  end if;
	       end loop;
	       
      	    end if;
	    Graphic_X := Graphic_X - 1;
	    if Graphic_X < 1 then
	       Graphic_X := 8;
	    end if;
	 elsif Is_Return(Key) then
	    
	    if Move_Okey(Graphic_X, Graphic_Y, Possible_Moves) = True and First_Time = False then
	       Graphic_Unmark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor);
	       X2 := Graphic_X;
	       Y2 := Graphic_Y;
	       Put(Socket, 0);
	       return;
	    elsif First_Time = True then
	       Graphic_Unmark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor);
	       X2 := Graphic_X;
	       Y2 := Graphic_Y;
	       Put(Socket, 0);
	       return;
	    end if;
	 end if;
	 
	 --if First_Time = True then
	    --  X3 := X1;
	    --  Y3 := Y1;
	    --  Graphic_Unmark_Position(X3, Y3, Chess_Piece_On_Cursor_2);
	 --end if;
	 
	 
	 Put_Line(Socket, 1);
	 Put_Line(Socket, Graphic_X);
	 Put_Line(Socket, Graphic_Y);
	 Get(Socket, Chess_Piece_On_Cursor);
	 Coordinates_2_Position(Graphic_X, Graphic_Y);	 
	 Goto_XY(Graphic_X, Graphic_Y);
	 Position_2_Coordinates(Graphic_X, Graphic_Y);
	 Graphic_Mark_Position(Graphic_X, Graphic_Y, Chess_Piece_On_Cursor, Secondary_Highlight_Colour, Secondary_Highlight_Colour_Contrast);
      end loop;
   end Move_Around_On_Game_Board;
   
   
   -- PUBLIKA Funktioner, Samma ordning som i Ads

   procedure Choose_Active_Chessman(Socket : in out Socket_Type;
				    X1, Y1 : in Integer; 
				    X2, Y2 : out Integer;
                                    Possible_Moves : in Cordinate_Array;
				    First_Time : in out Boolean) is
                                    
   begin
      -- Positonera markören 
      --  X := 6;
      --  Y := 6;
      Move_Around_On_Game_Board(Socket, X1, Y1, X2, Y2, Possible_Moves, First_Time);
     
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
	    Graphic_Unmark_Position(Coordinates(I).X, Coordinates(I).Y, Coordinates(I).Chess_Type);
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
   			 			 
   
   procedure Choose_Your_Play(Socket         : in out Socket_Type;
			      X1, Y1         : in Integer;
			      X2, Y2         : out Integer;						  Possible_Moves : in Cordinate_Array;
			      First_Time     : in out Boolean) is 
   begin
      -- Center on Game Field
      --  X := 6;
      --  Y := 6;
      Move_Around_On_Game_Board(Socket, X1, Y1, X2, Y2, Possible_Moves, First_Time);
      
      if Move_Okey(X2, Y2, Possible_Moves) = False then
	 Choose_Your_Play(Socket, X1, Y1, X2, Y2, Possible_Moves, First_Time);
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
      First_Time                          : Boolean;
     
   begin
      for I in Possible_Moves'Range loop
	 Possible_Moves(I).X := 0;
	 Possible_Moves(I).Y := 0;
	 Possible_Moves(I).Chess_Type := 0;
      end loop;
      loop
	 First_Time := True;
         Choose_Active_Chessman(Socket, 4, 4, X1, Y1, Possible_Moves, First_Time);
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
      First_Time := False;
      Choose_Your_Play(Socket, X1, Y1, X2, Y2, Possible_Moves, First_Time);
      Unmark_Positions(X1, Y1, Possible_Moves);
      Graphic_Move_Chess_Piece(X2, Y2, Choosen_Chess_Piece);
      Put_To_Socket(Socket, X2, Y2);
      
   end Play_Round;
   
   procedure Settings is
   begin
      Set_Default_Text_Modes(Off, Off, On);
      Cursor_Invisible;
   end Settings;
   
   procedure Offset_Input is
   begin
      Goto_XY(1, 60);
      Set_Background_Colour(White);
      Set_Foreground_Colour(White);
   end Offset_Input;
   
end Chess_Game_Handling;
