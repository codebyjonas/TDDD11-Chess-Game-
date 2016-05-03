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

-- Chess Game Packages
with Chess_Game_Graphic;        use Chess_Game_Graphic;

package Chess_Game_Handling is
   
   -- Datatyper

   --  type Cordinate_Array is private;
   --  type Cordinate_Type is private;
   
    type Cordinate_Type is
      record
	 X, Y, Chess_Type : Integer;
      end record;
    
    type Cordinate_Array is 
      array (1..28) of Cordinate_Type;
   
   -- Procedurer och Funktioner
   procedure Choose_Active_Chessman(X,Y : out Integer);
   procedure Put_To_Socket(Socket : in Socket_Type; 
			   X,Y    : in Integer); 
   procedure Get_From_Socket(Socket           : in Socket_Type; 
			     X, Y, Chess_Type : out Integer);
   procedure Get_Possible_Moves_From_Socket(Socket              : in Socket_Type; 
					    Possible_Move_Array : out Cordinate_Array);
   procedure Mark_Positions( Cordinates : in Cordinate_Array);
   procedure Unmark_Positions(X, Y       :in out Integer;
			     Cordinates : in Cordinate_Array);
   procedure Choose_Your_Play( X, Y           : out Integer;
			       Possible_Moves : in Cordinate_Array);
   function Move_Okey (X, Y           : in Integer;
		       Possible_Moves : in Cordinate_Array) return Boolean;
   -- procedure Any_Possible_Moves(Active_Socket  : in Socket_Type;
   -- Possible_Moves : in Cordinate_Array);
   
   procedure Play_Round(Socket : in Socket_Type;
   			X1, Y1 : out  Integer);
   
   -- TMP och TEST funktioner
   procedure Put( Item : in Cordinate_Array);
   
   
   	 

  
private   
   
end Chess_Game_Handling;
