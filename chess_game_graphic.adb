package body Chess_Game_Graphic is
   
   -- INTERNA PROCEDURER och FUNKTIONER
   
   
   procedure Draw_Outlines_Game_Board(Size : in Integer) is 
   begin
      -- First Row
      Put(Upper_Left_Corner);
      Put(Horisontal_Line, Size - 2);
      Put(Upper_Right_Corner);
      
      -- Left and Right  borders
      for I in 1..Size - 1 loop
	 Goto_XY(1, I + 1);
	 Put(Vertical_Line);
	 Goto_XY(Size, I + 1);
	 Put(Vertical_Line);
      end loop;
      
      -- Last Row
      Goto_XY(1,Size);
      Put(Lower_Left_Corner);
      Put(Horisontal_Line, Size - 2);
      Put(Lower_Right_Corner);
      
   end Draw_Outlines_Game_Board;
   

   
   
   -- TODO: Color Game Board
   procedure Color_Game_Board(Size : in Integer) is
   begin
      null;
   end Color_Game_Board;
   
   procedure Put_Chessmen_On_Board(Size : in Integer) is
   begin
      for X in 1..Size loop
	 for Y in 1..Size loop
	    -- Kan bli lite "tufft" för datorn att hela tiden flytta markören, vi får titta på det
	    Goto_XY(X,Y);
	    
	    -- TODO: Svart eller vit pjäs?
	    
	    -- Första och Sista raden 1 rads marginal 
	    if Y = 2 or Y = Size - 1  then
	       if X = 2 or X = Size - 1  then 
		 --- Kanske göra underfuntkioner när vi börjar rita
		 Put("♖");
	       end if;
	       if X = 3 or X = Size - 2 then 
		 Put("♘");
	       end if;
	       if X = 4 or X = Size - 3 then 
		 Put("♗");
	       end if;
	       if X = 5 then 
		  Put("♕");
	       end if;
	       
	       if X = 6 then
		  Put("♔");
	       end if;
	    end if;
	    
	    -- Andra och nästa sida raden 1 rads marginal
	    if Y = 3 or Y = Size - 2 then
	       if X > 1  and X /= Size then
		  Put("♙");
 	       end if;
	    end if;
	 end loop;
      end loop;
      
   end Put_Chessmen_On_Board;
   
  
   
   
   -- PUBLIKA PROCEDURER och FUNKTIONER
   --- Samma ordning som i Ads
   procedure Draw_Complete_Game_Board(Size : in Integer := 10) is
   begin
      Clear_Window;
      Draw_Outlines_Game_Board(Size);
      Put_Chessmen_On_Board(Size);
   end Draw_Complete_Game_Board;
   
   -- TODO: VETA vilken chessman vi skriver över 
   
   procedure Graphic_Mark_Position(X, Y : in Integer) is
   begin
      Goto_XY(X,Y);
      Set_Background_Colour(Highlight_Colour);
      Put(' ');
      Set_Background_Colour(Background_Colour);
   end Graphic_Mark_Position;
   
   procedure Graphic_Unmark_Position(X, Y : in Integer) is
      
   begin
      null;
      
   end Graphic_Unmark_Position;
   
   procedure Move_Chess_Piece(X, Y: in Integer) is
      
   begin
      --Cordinates_2_Position(X, Y); //Funkar ej ty dubbelpaketreferens
      Goto_XY(X+1, Y+1);
      Put("♙");
       
   end Move_Chess_Piece;
   
   procedure Remove_Chess_Piece(X, Y : in Integer) is
      
   begin
      Goto_XY(X, Y);
      Put(' ');
      
   end Remove_Chess_Piece;
   
   
end Chess_Game_Graphic;
