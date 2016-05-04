package body Chess_Game_Graphic is
   
   procedure Position_2_Coordinates( X, Y : in out Integer) is
   begin      
      if X = Offset_X and Y = Offset_Y then
	 X := X - Offset_X;
	 Y := Y - Offset_Y; 
      elsif X = Offset_X then 
	 X := X - Offset_X;
	 Y := (Y - 1 - Offset_X) / 5 + 1;
      elsif Y = Offset_Y then
	 X := (X - 1 - Offset_X) / 10 + 1;
	 Y := Y + Offset_X;
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
   
   function Black_Or_White_Square(X, Y : in Integer) return Character is 
   begin
     if (X+Y) mod 2 = 0 then
	return 'w';
     else
	return 'b';
     end if;
   end Black_Or_White_Square;
   
   function Chessman_Number_2_Character( Item : in Integer) return Character is
   begin
      case abs(Item) is
	 when 1 => 
	    return 'R';
	 when 2 =>
	    return 'k'; 
	 when 3 =>
	    return 'B';
	 when 4 =>
	    return 'K'; 
	 when 5 =>
	    return 'Q'; 
	 when 6 =>
	    return 'P'; 
	 when 0 =>
	    return '0';
	 when others =>
	    Put("Error Chessman_Numbe_2Characere");
	    return '!';
      end case;
   end Chessman_Number_2_Character;
   
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
	 when '0' =>
	    Goto_XY(X,Y);
	    Put("          ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("          ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("          ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("          ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("          ");
	 when others =>
	    Put("Error Put Chessman");
      end case;
   end Put_Chessman;
   
   

   
   
   -- TODO: Color Game Board
   procedure Colour_Game_Board(Size : in Integer := 8) is
   begin
      for X in 1..Size loop
	 for Y in 1..Size loop
	       Graphic_Mark_Position(X, Y, 0, Foreground_Colour, Background_Colour);
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
      Colour_Game_Board;
      Put_Chessmen_On_Board;
   end Draw_Complete_Game_Board;
   
   -- TODO: VETA vilken chessman vi skriver över 
   
   procedure Graphic_Mark_Position(X, Y            : in Integer; 
				   Chessman        : in Integer     := 0; 
				   Colour          : in Colour_Type := Highlight_Colour;
				   Colour_Contrast : in Colour_Type := Highlight_Colour_Contrast) is
      G_X : Integer := X;
      G_Y : Integer := Y;
   begin
      if Black_Or_White_Square(X, Y) = 'w' then
	 Set_Background_Colour(Colour);
      else
	 Set_Background_Colour(Colour_Contrast);
      end if;
      Coordinates_2_Position(G_X,G_Y);
      Put_Chessman(Chessman_Number_2_Character(Chessman), G_X, G_Y);
      Set_Background_Colour(Background_Colour);
   end Graphic_Mark_Position;
   
   
   procedure Graphic_Move_Chess_Piece(X, Y, Choosen_Chess_Piece : in Integer) is
      X_G : Integer := X;
      Y_G : Integer := Y;
   begin
      if Black_Or_White_Square(X, Y) = 'w' then
	 Set_Background_Colour(Foreground_Colour);
      else
	 Set_Background_Colour(Background_Colour);
      end if;
      
      Coordinates_2_Position(X_G,Y_G);
      
      if Choosen_Chess_Piece > 0 then
	 Set_Foreground_Colour(White_Chessman);
      else
	 Set_Foreground_Colour(Black_Chessman);
      end if;
      
      Put_Chessman(Chessman_Number_2_Character(Choosen_Chess_Piece), X_G, Y_G);
       
   end Graphic_Move_Chess_Piece;
   
   
   -- SJUKT onödig funktion, samma som Mark position fast lite annorlunda
   procedure Graphic_Unmark_Position(X, Y : in out Integer) is
      
   begin
      if Black_Or_White_Square(X, Y) = 'w' then
	 Set_Background_Colour(Foreground_Colour);
      else
	 Set_Background_Colour(Background_Colour);
      end if;
      Coordinates_2_Position(X,Y);
      Put_Chessman('0', X, Y);
      Position_2_Coordinates(X,Y);
   end Graphic_Unmark_Position;
      
   
   
end Chess_Game_Graphic;
