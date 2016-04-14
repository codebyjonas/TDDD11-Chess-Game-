with Ada.Text_IO;		use Ada.Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;

-- TJa Bibloteket
with TJa.Window.Elementary;     use TJa.Window.Elementary;
with TJa.Keyboard;              use TJa.Keyboard;
with TJa.Keyboard.Keys;         use TJa.Keyboard.Keys;
with TJa.Window.Graphic;        use TJa.Window.Graphic; 
with TJa.Window.Text;           use TJa.Window.Text;

-- Chess Game Packages
with Chess_Game_Graphic;        use Chess_Game_Graphic;

package Chess_Game_Handling is
   
   -- Datatyper
   type Chessman_Type is private;
   
   -- Procedurer och Funktioner
   procedure Choose_Active_Chessman(Active_Chessman : out Chessman_Type);
   procedure Put_To_Socket(Item : in Chessman_Type); 
   procedure Get_From_Socket(Item : out Chessman_Type);
private
   
   
   -- Datatypen för spelpjäsen
   -- X,Y : Positionn
   -- Uniq_ID : Unikt IDx
   -- Type_Of_Man : Typ av pjäs (bonde,..)
   -- Associated_Team : Tillhör lag (svart,vit)
   type Chessman_Type is
      record
	 X,Y, Uniq_ID                 : Integer;
	 Type_Of_Man, Associated_Team : Character;
      end record;
	 
   
end Chess_Game_Handling;