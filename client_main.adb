with Ada.Command_Line;      use Ada.Command_Line;
with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;

with TJa.Sockets;           use TJa.Sockets;
with TJa.Window.Elementary; use TJa.Window.Elementary;
with TJa.Window.Text;       use TJa.Window.Text;
with TJa.Keyboard;          use TJa.Keyboard;
with TJa.Keyboard.Keys;     use TJa.Keyboard.Keys;
with Chess_Game_Handling;   use Chess_Game_Handling;
with Chess_Game_Graphic;    use Chess_Game_Graphic;

procedure Client_Main is
   
   procedure Other_Player_Moves(Other_Player_X1, Other_Player_Y1, Other_Player_X2, Other_Player_Y2, Choosen_Chess_Piece : in out Integer) is
   begin
      Graphic_Unmark_Position(Other_Player_X1, Other_Player_Y1);
      Graphic_Move_Chess_Piece(Other_Player_X2, Other_Player_Y2, Choosen_Chess_Piece);
   end Other_Player_Moves;
   
   -- Grafiska Underfunktioner
   procedure Draw_Is_Size_Ok_Box is
      X      : Integer := 52;
      Y      : Integer := 14;
      H_Size : Integer := 40;
      V_Size : Integer := 20;
      Key    : Key_Type;
   begin
      Draw_Box(52, 14, 40, 20);
      X := X + 1;
      Y := Y + 1;
      Goto_XY(X, Y);
      Put("######################################");
      Y := Y + 1;
      Goto_XY(X,Y);
      Put("#### Welcome To ADA Chess Game! ######"); 
      Y := Y + 1;
      Goto_XY(X,Y);
      Put("######################################");
      Y := Y + 2;
      Goto_XY(X,Y);
      Put(" Make sure you fit all of the game");
      Y := Y + 1;
      Goto_XY(X,Y);
      Put(" area inside of your terminal.");
      Y := Y + 2;
      Goto_XY(X, Y);
      Put(" Enter if OK!");
      Y := Y + 2;
      -- Ok box
      Draw_Box(62, 26, 20, 5, White, red);
      Y := Y + 4;
      X := X + 10;
      Goto_XY(X , Y);
      Put("        OK!       ");
      -- Wait for ok
      loop
	 Get_Immediate(Key);
	 if Is_Return(Key) then
	    exit;
	 end if;
      end loop;
   end Draw_Is_Size_Ok_Box;
   
   procedure Display_Waiting_Message is
      X : Integer := 62;
      Y : Integer := 26;
   begin
      Goto_XY(X, Y);
      Set_Background_Colour(Blue);
      Put("                    ");
      Y := Y + 1;
      Goto_XY(X,Y);
      Put("                      ");
      Y := Y + 1;
      Goto_XY(X,Y);
      Put("   Loading Game...    ");
      Y := Y + 1;
      Goto_XY(X,Y);
      Put("                      ");
      Y := Y + 1;
      Goto_XY(X,Y);
      Put("                      ");
      Y := Y + 1;
      Goto_XY(X,Y);
      Put("                      ");
   end Display_Waiting_Message;
   
   procedure Message_Black_Or_White( Socket : in Socket_Type) is
      My_Colour : Character;
   begin
      Get(Socket, My_Colour);
      if My_Colour = 'w' then
	 Put_To_Info_Box("You play as white! Good luck!        ", 1);
	 Put_To_Info_Box("Ps. White starts                     ", 2);
      else
	 Put_To_Info_Box("You play as black! Good luck!        ", 1);
      end if;
   end Message_Black_Or_White;
   
   -- Alerts
   procedure Alert_Your_Turn( On : in Boolean) is
      Active_Colour : Colour_Type;
      X             : Integer    := 100;
      Y             : Integer    := 27;
   begin
      if On then
	 Active_Colour := Bright_Green;
      else
	 Active_Colour := Green;
      end if;
      Draw_Box(X, Y, 40, 5, White, Active_Colour);
      X := X + 1;
      Y := Y + 2;
      Goto_XY(X,Y);
      if On then
	 Put("        Your turn, Good luck!        ");
      else
	 Put("       Waiting for opponent...       ");
      end if;
   end Alert_Your_Turn;
   
   procedure Alert_Check( On : in Boolean) is
      Active_Colour : Colour_Type;
      Text_Colour   : Colour_Type := White;
      X             : Integer     := 100;
      Y             : Integer     := 34;
   begin
      if On then
	 Active_Colour := Bright_Yellow;
	 Text_Colour   := Black;
      else
	 Active_Colour := Yellow;
      end if;
      Draw_Box(X, Y, 40, 5, Text_Colour, Active_Colour);
      X := X + 1;
      Y := Y + 2;
      Goto_XY(X,Y);
      if On then
	 Put("           Warning, check!           ");
      else
	 Put("             No check...             ");
      end if;
   end Alert_Check;
   
   -- Game Over
  procedure Game_Over( Results : in Character) is
      X, Y, I : Integer := 1;
      Colour  : Colour_Type;
   begin
      Set_Background_Colour(White);
      Draw_Outer_Box;
      
      if Results = 'w' then
	 -- Black, Red, Green, Yellow, Blue, Magenta, Cyan, White
	 loop
	    case I is
	       when 1 => Colour := Black;
	       when 2 => Colour := Bright_Red;
	       when 3 => Colour := Bright_Green;
	       when 4 => Colour := Bright_Yellow;
	       when 5 => Colour := Bright_Blue;
	       when 6 => Colour := Bright_Cyan;
	       when 7 => Colour := White;
	       when others => I := 1;
	    end case;
	    
	    I := I + 1;
	    delay 0.2;
	    
	    Set_Foreground_Colour(Colour);
	    X := 23;
	    Y := 20;
	    Goto_XY(X,Y);
	    
	    -- Print out "Congratulations"
	    Put(" _____  _____  _   _  _____ ______   ___  _____  _   _  _       ___  _____  _____  _____  _   _  _____ ");
	    Y := Y + 1;  
	    Goto_XY(X,Y);
	    Put("/  __ \|  _  || \ | ||  __ \| ___ \ / _ \|_   _|| | | || |     / _ \|_   _||_   _||  _  || \ | |/  ___|");
	    Y := Y + 1;  
	    Goto_XY(X,Y);
	    Put("| /  \/| | | ||  \| || |  \/| |_/ // /_\ \ | |  | | | || |    / /_\ \ | |    | |  | | | ||  \| |\ `--. ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("| |    | | | || . ` || | __ |    / |  _  | | |  | | | || |    |  _  | | |    | |  | | | || . ` | `--. \");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("| \__/\\ \_/ /| |\  || |_\ \| |\ \ | | | | | |  | |_| || |____| | | | | |   _| |_ \ \_/ /| |\  |/\__/ /");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put(" \____/ \___/ \_| \_/ \____/\_| \_|\_| |_/ \_/   \___/ \_____/\_| |_/ \_/   \___/  \___/ \_| \_/\____/ ");
	    
	    -- Print You Win
	    Y := Y + 3;
	    X := X + 25;
	    Goto_XY(X,Y);
	    Put("__   __ _____  _   _   _    _  _____  _   _  _  ");
	    Y := Y + 1;  
	    Goto_XY(X,Y);
	    Put("\ \ / /|  _  || | | | | |  | ||_   _|| \ | || |");
	    Y := Y + 1;  
	    Goto_XY(X,Y);
	    Put(" \ V / | | | || | | | | |  | |  | |  |  \| || | ");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("  \ /  | | | || | | | | |/\| |  | |  | . ` || |");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("  | |  \ \_/ /| |_| | \  /\  / _| |_ | |\  ||_|");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("  \_/   \___/  \___/   \/  \/  \___/ \_| \_/(_)");
	 end loop;
      else
	 loop
	    case I is
	       when 1 => Colour := Black; 
	       when 2 => Colour := Bright_Red;
	       when 3 => Colour := Bright_Green;
	       when 4 => Colour := Bright_Yellow;
	       when 5 => Colour := Bright_Blue;
	       when 6 => Colour := Bright_Cyan;
	       when 7 => Colour := White;
	       when others => I := 1;
	    end case;
	    I := I + 1;
	    delay 0.2;
	    Set_Foreground_Colour(Colour);
	    X := 43;
	    Y := 20;
	    Goto_XY(X,Y);
	    -- Print out "Congratulations"
	    Put(" _____   ___  ___  ___ _____   _____  _   _  _____ ______  _");
	    Y := Y + 1;  
	    Goto_XY(X,Y);
	    Put("|  __ \ / _ \ |  \/  ||  ___| |  _  || | | ||  ___|| ___ \| |");
	    Y := Y + 1;  
	    Goto_XY(X,Y);
	    Put("| |  \// /_\ \| .  . || |__   | | | || | | || |__  | |_/ /| |");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("| | __ |  _  || |\/| ||  __|  | | | || | | ||  __| |    / | |");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("| |_\ \| | | || |  | || |___  \ \_/ /\ \_/ /| |___ | |\ \ |_|");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put(" \____/\_| |_/\_|  |_/\____/   \___/  \___/ \____/ \_| \_|(_) ");
	    
	    -- Print You Win
	    Y := Y + 3;
	    X := X + 5;
	    Goto_XY(X,Y);
	    Put("__   __ _____  _   _   _      _____  _____  _____  _ ");
	    Y := Y + 1;  
	    Goto_XY(X,Y);
	    Put("\ \ / /|  _  || | | | | |    |  _  |/  ___||  ___|| |");
	    Y := Y + 1;  
	    Goto_XY(X,Y);
	    Put(" \ V / | | | || | | | | |    | | | |\ `--. | |__  | |");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("  \ /  | | | || | | | | |    | | | | `--. \|  __| | |");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("  | |  \ \_/ /| |_| | | |____\ \_/ //\__/ /| |___ |_|");
	    Y := Y + 1;
	    Goto_XY(X,Y);
	    Put("  \_/   \___/  \___/  \_____/ \___/ \____/ \____/ (_)");
	 end loop;
      end if;
   end Game_Over;

   -- TATA43 - analys
   Socket                       : Socket_Type;
   My_Color, Results            : Character;
   Actual_Game_Round_Case, X1, Y1, Chess_Type, Other_Player_X1, Other_Player_Y1, Other_Player_X2, Other_Player_Y2, Choosen_Chess_Piece : Integer;
   
begin
   
   Settings;
     
   Initiate(Socket);
   
   -- Game Play
   -- Draw Outer Box
   Draw_Outer_Box;
   Draw_Is_Size_Ok_Box;
   Display_Waiting_Message;
   Connect(Socket, Argument(1), Positive'Value(Argument(2))); 
   Draw_Complete_Game_Board; 
   Draw_Complete_Info_Box;
   Message_Black_Or_White(Socket);
   
   loop
      -- Hämta Typ av runda:
      --- 1. Schack Matt
      --- 2. Schack
      --- 3. Regular
      --- 4. First Round 
      Get(Socket, Actual_Game_Round_Case);
      if Actual_Game_Round_Case < 4 then
	 Get(Socket, Other_Player_X1);
	 Get(Socket, Other_Player_Y1);
	 Get(Socket, Other_Player_X2);
	 Get(Socket, Other_Player_Y2);
	 Get(Socket, Choosen_Chess_Piece);
	 Other_Player_Moves(Other_Player_X1, Other_Player_Y1, Other_Player_X2, Other_Player_Y2, Choosen_Chess_Piece);
      end if;
      
      -- Avgör vilket fall som ska köra 
      case Actual_Game_Round_Case is
	 when 1 => 
	    Alert_Check(False);
	    Put_Line(Socket, 1);
	    -- TODO: Vem vann?
	    Results := 'l';
	    delay 1.0;
	    Game_Over(Results);
	 when 2 =>
	    Alert_Your_Turn(False);
	    Alert_Check(True);
	    -- TODO: Skapa Graphic_Display_Is_Check;
	    --Graphic_Display_Is_Check; 
	    Play_Round(Socket, X1, Y1);
	 when 3 =>
	    Put_To_Info_Box("Your turn                            ", 2);
	    Alert_Your_Turn(True);
	    Play_Round(Socket, X1, Y1);
	 when 4 => 
	    Alert_Your_Turn(True);
	    Alert_Check(False);
	    Play_Round(Socket, X1, Y1);
	 when 5 =>
	    Alert_Your_Turn(False);
	    Alert_Check(False);
	    Put_To_Info_Box("Waiting for opponent                 ", 2);
	    Offset_Input;
	 when 6 =>
	    delay 1.0;
	    Results := 'w';
	    Game_Over(Results);
	 when others =>
	    Put("Error Actual_Game_Round_Case");
	    -- Raise Error 
      end case;
   end loop;
   
   
   
end Client_Main;
