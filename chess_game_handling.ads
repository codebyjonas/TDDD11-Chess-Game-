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
   
   -- Procedurer och Funktioner
   procedure Choose_Active_Chessman(X,Y : out Integer);
   procedure Put_To_Socket(Socket : in Socket_Type;
			   X,Y : in Integer); 
   procedure Get_From_Socket(Socket : in Socket_Type;
			     X, Y   : out Integer);
   procedure Play_Round(Socket: in Socket_Type;
			X, Y: in out Integer);
private
   
   
   -- Datatypen för spelpjäsen
   -- X,Y : Positionn
   -- Uniq_ID : Unikt IDx
   -- Type_Of_Man : Typ av pjäs (bonde,..)
   -- Associated_Team : Tillhör lag (svart,vit)
   	 
   
end Chess_Game_Handling;
