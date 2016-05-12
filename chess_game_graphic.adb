package body Chess_Game_Graphic is
   
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
	    Put("  / ▣ \   ");
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
	    Put("          ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("   (◉)    ");
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
   
   procedure Game_Board_Border_And_Shadow is
      H_Size : Integer := 80;
      V_Size : Integer := 40;
      X      : Integer := Offset_X;
      Y      : Integer := Offset_Y;
   begin
      -- Border
      Set_Background_Colour(Background_Colour);
      Set_Foreground_Colour(Foreground_Colour);
      Goto_XY(X - 1, Y);
      -- Horizontal 
      for I in 1..H_Size + 4 loop
	 case I is
	    when 7 => 
	       Put('A');
	    when 17 =>
	       Put('B');
	    when 27 => 
	       Put('C');
	    when 37 =>
	       Put('D');
     	    when 47 => 
	       Put('E');
	    when 57 =>
	       Put('F');
     	    when 67 => 
	       Put('G');
	    when 77 =>
	       Put('H');
	    when others =>
	       Put(' ');
	 end case;
      end loop;
      
            
      Goto_XY(X - 1, Y + V_Size + 1);
      for I in 1..H_Size + 4 loop
	 Put(' ');
      end loop;
      
      
      
      -- Vertical Border
      for I in 1..V_Size loop
	 Goto_XY(X - 1,Y + I);
	 Put(' ');
	 case I is
	    when 3 => 
	      Put('8');
	    when 8 =>
	       Put('7');
	    when 13 =>
	       Put('6');
	    when 18 =>
	       Put('5');
	    when 23 =>
	       Put('4');
	    when 28 =>
	       Put('3');
	    when 33 =>
	       Put('2');
	    when 38 =>
	       Put('1');
	    when others =>
	       Put(' ');
	 end case;
	 Goto_XY(X + H_Size + 1, Y + I);
	 Put("  ");
	 Put(Vertical_Line);
      end loop;
      
      -- Shadow
      Set_Background_Colour(Black);
      for I in 0..V_Size loop
	 Goto_XY(X + H_Size + 3, Y + I + 1);
	 Put("  ");
      end loop;
      Goto_XY(X + 1, Y + V_Size + 2);
      for I in 1..H_Size + 4 loop
	 Put(' ');
      end loop;
      
   end Game_Board_Border_And_Shadow;
   
   
   
   -- PUBLIKA PROCEDURER och FUNKTIONER
   --- Samma ordning som i Ads
   procedure Draw_Complete_Game_Board is
      V_Size : Natural := 80;
      H_Size : Natural := 40;
   begin
      Colour_Game_Board;
      Put_Chessmen_On_Board;
      Game_Board_Border_And_Shadow;
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
      if Chessman < 0 then
         Set_Foreground_Colour(Black_Chessman);
      elsif Chessman > 0 then
	 Set_Foreground_Colour(White_Chessman);
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
   procedure Graphic_Unmark_Position(X, Y : in out Integer;
                                     Chessman : in Integer := 0) is
      
   begin
      if Black_Or_White_Square(X, Y) = 'w' then
	 Set_Background_Colour(Foreground_Colour);
      else
	 Set_Background_Colour(Background_Colour);
      end if;
      Coordinates_2_Position(X,Y);
      Put_Chessman(Chessman_Number_2_Character(Chessman), X, Y);
      if Chessman < 0 then
         Set_Foreground_Colour(Black_Chessman);
      elsif Chessman > 0 then
	 Set_Foreground_Colour(White_Chessman);
      end if;
      Position_2_Coordinates(X,Y);
   end Graphic_Unmark_Position;
   
   
   ----- INFO Box -----
   procedure Draw_Box(X, Y, H_Size, V_Size : in Integer; 
		      Foreground_Colour    : in Colour_Type := White;
		      Background_Colour    : in Colour_Type := Blue) is
   begin
      Set_Foreground_Colour(Foreground_Colour);
      Set_Background_Colour(Background_Colour);
      
      -- Box
      Goto_XY(X,Y);
      for I in 1..V_Size loop
	 for J in 1..H_Size loop
	    Put(' ');
	 end loop;
	 Goto_XY(X, I+Y);
      end loop;
      
      -- Shadow
      Set_Background_Colour(Black);
      for I in 1..V_Size loop
	 Goto_XY(X + H_Size, Y + I);
	 Put("  ");
      end loop;
      Goto_XY(X + 1, Y + V_Size);
      for I in 1..H_Size loop
	 Put(' ');
      end loop;
      
      
      -- Inner Border
      Set_Background_Colour(Background_Colour);
      Set_Foreground_Colour(Foreground_Colour);
      Goto_XY(X,Y);
      Put(Upper_Left_Corner);
      Put(Horisontal_Line, H_Size - 2);
      Put(Upper_Right_Corner);
      
      for I in 1..V_Size - 1 loop
	 Goto_XY(X,Y + I);
	 Put(Vertical_Line);
	 Goto_XY(X + H_Size - 1, Y + I);
	 Put(Vertical_Line);
      end loop;
      
      Goto_XY(X, Y + V_Size - 1);
      Put(Lower_Left_Corner);
      Put(Horisontal_Line, H_Size - 2);
      Put(Lower_Right_Corner);
   end Draw_Box;
   
   procedure Draw_Complete_Info_Box is
      X      : Integer := 100;
      Y      : Integer := 5;
      H_Size : Integer := 40;
      V_Size : Integer := 20;
   begin
      Draw_Box(X, Y, H_Size, V_Size);
      X := X + 1;
      Y := Y + 1;
      Goto_XY(X, Y);
      Put("######################################");
      Y := Y + 1;
      Goto_XY(X,Y);
      Put("########## ADA Chess Game ###########");
   end Draw_Complete_Info_Box;
   
   procedure Put_To_Info_Box( Text : in String; Row : in Integer) is 
      X : Integer := 102;
      Y : Integer := 7;
   begin
      Set_Background_Colour(Blue);
      Set_Foreground_Colour(White);
      Y := Y + Row;
      Goto_XY(X, Y);
      Put(Text);
   end Put_To_Info_Box;
      
   
   -- Outer Box
   procedure Draw_Outer_Box is
      X      : Integer := 3;
      Y      : Integer := 2;
      H_Size : Integer := 144;
      V_Size : Integer := 49;
   begin
      Clear_Window;
      Draw_Box(X, Y, H_Size, V_Size, White, Cyan);
      
   end Draw_Outer_Box;
   
   
end Chess_Game_Graphic;
