package body Chess_Game_Graphic is
   
   -- INTERNA PROCEDURER och FUNKTIONER
   procedure Position_2_Coordinates( X, Y : in out Integer) is
   begin      
      if X = 1 and Y = 1 then
	 X := X;
	 Y := Y; 
      elsif X = 1 then 
	 X := X;
	 Y := (Y - 1) / 5 + 1;
      elsif Y = 1 then
	 X := (X - 1) / 10 + 1 ;
	 Y := Y;
      else
	 X := (X - 1) / 10 + 1;
	 Y := (Y - 1) / 5 + 1;
       end if;
   end Position_2_Coordinates;
   
   procedure Coordinates_2_Position(X , Y : in out Integer) is
   begin
      if X = 1 and Y = 1 then
	 X := X;
	 Y := Y; 
      elsif X = 1 then 
	 X := X;
	 Y := (Y - 1) * 5 + 1;
      elsif Y = 1 then
	 X := (X - 1) * 10 + 1 ;
	 Y := Y;
      else
	 X := (X - 1) * 10 + 1;
	 Y := (Y - 1) * 5 + 1;
      end if;
   end Coordinates_2_Position;
   
   
   
   -- Alla pjäser Put 
   procedure Put_Chessman( Chessman : in Character; 
			   X, Y     : in out Integer; 
			   F_Colour : in Colour_Type := Foreground_Colour; 
			   B_Colour : in Colour_Type := Background_Colour) is
   begin
      -- Set_Foreground_Colour(F_Colour);
      -- Set_Background_Colour(B_Colour);
      case Chessman is
	 when 'K' =>
	    Goto_XY(X,Y);
	    Put("   WWW    ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("   )▣(    ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("   |▣|    ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("   |▣|    ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("  / ▣ \    ");
	    Y := Y + 1;
	 when 'Q' =>
	    Goto_XY(X,Y);
	    Put("   _+_    ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("   )▣(    ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("   |▣|    ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("   |▣|    ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("  / ▣ \   ");
	    Y := Y + 1;
	 when 'R' =>
	    Goto_XY(X,Y);
	    Put("   ___    ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("  |▣|▣|   ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("   |▣|    ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("   |▣|    ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("  / ▣ \   ");
	 when 'B' =>
	    Goto_XY(X,Y);
	    Put("           ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("   (◉)     ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("   |▣|    ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("   |▣|    ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("  / ▣ \   ");
	 when 'k' =>
	    Goto_XY(X,Y);
	    Put("          ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("   _,,    ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("  ''- \~  ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("   |▣|    ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("  / ▣ \   ");
	    
	 when 'P' =>
	    Goto_XY(X,Y);
	    Put("          ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("    ()    ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("    )(    ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("   /  \   ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("          ");
	 when others =>
	    Put("Error");
      end case;
   end Put_Chessman;
   
   
   
   procedure Draw_Outlines_Game_Board(V_Size, H_Size : in Natural) is 
   begin
      -- First Row
      Put(Upper_Left_Corner);
      Put(Horisontal_Line, V_Size - 2);
      Put(Upper_Right_Corner);
      
      -- Left and Right  borders
      for I in 1..H_Size - 1 loop
	 Goto_XY(1, I + 1);
	 Put(Vertical_Line);
	 Goto_XY(V_Size, I + 1);
	 Put(Vertical_Line);
      end loop;
      
      -- Last Row
      Goto_XY(1, H_Size);
      Put(Lower_Left_Corner);
      Put(Horisontal_Line, V_Size - 2);
      Put(Lower_Right_Corner);
      
   end Draw_Outlines_Game_Board;
   

   
   
   -- TODO: Color Game Board
   procedure Colour_Game_Board(Size : in Integer := 8) is
   begin
      for X in 1..Size loop
	 for Y in 1..Size loop
	    if (X + Y) mod 2 = 0 then
	       Graphic_Mark_Position(X, Y, Foreground_Colour);
	    else
	       Graphic_Mark_Position(X, Y, Background_Colour);
	    end if;
	    
	 end loop;
      end loop;
   end Colour_Game_Board;
   
   procedure Put_Chessmen_On_Board is
      Size     : Integer := 8;
      G_X, G_Y : Integer;
   begin
      for X in 1..Size loop
	 for Y in 1..Size loop
	    
	    Goto_XY(X, Y);
	    -- Sätt Bakgrundsfärger
	    if (X + Y) mod 2 = 0 then
	       Set_Background_Colour(Foreground_Colour);
	    else
	       Set_Background_Colour(Background_Colour);
	    end if;
	    
	    -- Sätt Pjäsfärger
	    if Y = 1 or Y = 2 then
	       Set_Foreground_Colour(Black_Chessman);
	    else
	       Set_Foreground_Colour(White_Chessman);
	    end if;
	    
	    if Y = 1 or Y = Size   then
	       if X= 1 or X = Size   then 
		  G_X := X;
		  G_Y := Y;
		  Coordinates_2_Position(G_X, G_Y);
		  Put_Chessman('R', G_X, G_Y);
	       end if;
	       if X= 2 or X = Size - 1 then 
		  G_X := X;
		  G_Y := Y;
		  Coordinates_2_Position(G_X, G_Y);
		  Put_Chessman('k', G_X, G_Y);
	       end if;
	       if X= 3 or X = Size - 2 then 
		  G_X := X;
		  G_Y := Y;
		  Coordinates_2_Position(G_X, G_Y);
		  Put_Chessman('B', G_X, G_Y);
	       end if;
	       if X= 4 then 
		  G_X := X;
		  G_Y := Y;
		  Coordinates_2_Position(G_X, G_Y);
		  Put_Chessman('K', G_X, G_Y);
	       end if;
	       if X = 5 then
		  G_X := X;
		  G_Y := Y;
		  Coordinates_2_Position(G_X, G_Y);
		  Put_Chessman('Q', G_X, G_Y);
	       end if;
	    end if;
	    -- Andra och nästa sida raden 1 rads marginal
	    if Y = 2 or Y = (Size - 1) then
		  G_X := X;
		  G_Y := Y;
		  Coordinates_2_Position(G_X, G_Y);
		  Put_Chessman('P', G_X, G_Y);
	    end if;
	 end loop;
      end loop;
      
   end Put_Chessmen_On_Board;
   
  
   
   
   -- PUBLIKA PROCEDURER och FUNKTIONER
   --- Samma ordning som i Ads
   procedure Draw_Complete_Game_Board is
      V_Size : Natural := 80;
      H_Size : Natural := 40;
   begin
      Clear_Window;
      Draw_Outlines_Game_Board(V_Size, H_Size);
      Colour_Game_Board;
      Put_Chessmen_On_Board;
   end Draw_Complete_Game_Board;
   
   -- TODO: VETA vilken chessman vi skriver över 
   
   procedure Graphic_Mark_Position(X, Y : in Integer; Colour : in Colour_Type := Highlight_Colour) is
      G_X : Integer := X;
      G_Y : Integer := Y;
   begin
      Coordinates_2_Position(G_X,G_Y);
      Goto_XY(G_X,G_Y);
      Set_Background_Colour(Colour);
      Goto_XY(G_X,G_Y);
      Put("          ");
      G_Y := G_Y + 1;
      Goto_XY(G_X,G_Y);
      Put("          ");
      G_Y:= G_Y + 1;
      Goto_XY(G_X,G_Y);
      Put("          ");
      G_Y:= G_Y + 1;
      Goto_XY(G_X,G_Y);
      Put("          ");
      G_Y:= G_Y + 1;
      Goto_XY(G_X,G_Y);
      Put("          ");
      Set_Background_Colour(Background_Colour);
   end Graphic_Mark_Position;
   
   
   procedure Graphic_Move_Chess_Piece(X, Y, Choosen_Chess_Piece: in Integer) is
      X_G : Integer := X;
      Y_G : Integer := Y;
   begin
      Coordinates_2_Position(X_G,Y_G);
      
      if Choosen_Chess_Piece < 0 then
	 Set_Foreground_Colour(White_Chessman);
      else
	 Set_Foreground_Colour(Black_Chessman);
      end if;
      
      Put(Choosen_Chess_Piece);
      
      case Choosen_Chess_Piece is
	 when abs(1) => 
	    Put_Chessman('R', X_G, Y_G);
	 when abs(2) =>
	    Put_Chessman('k', X_G, Y_G);
	 when abs(3) =>
	    Put_Chessman('B', X_G, Y_G);
	 when abs(4) =>
	    Put_Chessman('K', X_G, Y_G);
	 when abs(5) =>
	    Put_Chessman('Q', X_G, Y_G);
	 when abs(6) =>
	    Put_Chessman('P', X_G, Y_G);
	 when others =>
	    Put("Error Choosen_Chess_Piece");
      end case;
      
      
       
   end Graphic_Move_Chess_Piece;
   
   procedure Graphic_Unmark_Position(X, Y : in out Integer) is
      
   begin
      Coordinates_2_Position(X,Y);
      Put("          ");
      Y := Y + 1;
      Goto_XY(X, Y);
      Put("          ");
      Y := Y + 1;
      Goto_XY(X, Y);
      Put("          ");
      Y := Y + 1;
      Goto_XY(X, Y);
      Put("          ");
      Y := Y + 1;
      Goto_XY(X, Y);
      Put("          ");
      Position_2_Coordinates(X,Y);
   end Graphic_Unmark_Position;
   
   
end Chess_Game_Graphic;
