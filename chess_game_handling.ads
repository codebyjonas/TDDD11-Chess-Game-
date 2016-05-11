--Ada packages
with Ada.Text_IO;		use Ada.Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;

-- TJa Bibloteket
with TJa.Window.Elementary;     use TJa.Window.Elementary;
with TJa.Keyboard;              use TJa.Keyboard;
with TJa.Keyboard.Keys;         use TJa.Keyboard.Keys;
with TJa.Window.Graphic;        use TJa.Window.Graphic; 
with TJa.Window.Text;           use TJa.Window.Text;
with TJa.Sockets;               use TJa.Sockets;
with TJa.Misc;                  use TJa.Misc;

-- Chess Game Packages
with Chess_Game_Graphic;        use Chess_Game_Graphic;

package Chess_Game_Handling is
   
   -- Grafiska konstanter
   Offset_X          : constant Integer := 10;
   Offset_Y          : constant Integer := 5;
   
   -- Datatyper

   --  type Cordinate_Array is private;
   --  type Cordinate_Type is private;
   
    type Cordinate_Type is private;
    
    type Cordinate_Array is private;
   
   -- Procedurer och Funktioner
    procedure Choose_Active_Chessman(Socket : in out Socket_Type;
				     X1, Y1 : in Integer;
				     X2, Y2 : out Integer;
				     Possible_Moves : in Cordinate_Array;
				     First_Time : in out Boolean);
   procedure Put_To_Socket(Socket : in Socket_Type; 
			   X,Y    : in Integer); 
   procedure Get_From_Socket(Socket           : in Socket_Type; 
			     X, Y, Chess_Type : out Integer);
   procedure Get_Possible_Moves_From_Socket(Socket              : in Socket_Type; 
					    Possible_Move_Array : out Cordinate_Array);
   procedure Mark_Positions( Cordinates : in Cordinate_Array);
   procedure Unmark_Positions(X, Y       :in out Integer;
			     Coordinates : in out Cordinate_Array);
   procedure Choose_Your_Play( Socket         : in out Socket_Type;
			       X1, Y1         : in Integer;
			       X2, Y2         : out Integer;
			       Possible_Moves : in Cordinate_Array;
			       First_Time     : in out Boolean);
   function Move_Okey (X, Y           : in Integer;
		       Possible_Moves : in Cordinate_Array) return Boolean;
   -- procedure Any_Possible_Moves(Active_Socket  : in Socket_Type;
   -- Possible_Moves : in Cordinate_Array);
   
   procedure Play_Round(Socket : in out Socket_Type;
   			X1, Y1 : out  Integer);
   
   procedure Settings;
   procedure Offset_Input;
  
private   
    
    type Cordinate_Type is
      record
	 X, Y, Chess_Type : Integer;
      end record;
    
    type Cordinate_Array is 
      array (1..28) of Cordinate_Type;

end Chess_Game_Handling;
