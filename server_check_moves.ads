with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package Server_Check_Moves is
   
   -- Data Typer 
   --- Gör privat senare
   type Height_Type is
     array(1..8) of Integer;
   
   type Board_Type is
     array(1..8) of Height_Type;
   
   type Coordinate_Type is
     array(1..2) of Integer;
   
   type Possible_Moves_Type is
     array(1..28) of Coordinate_Type;
   
   function Possible_Moves(Coordinate: in Coordinate_Type; 
			   Board : in Board_Type; 
			   Tur : in boolean) return Possible_Moves_Type;
   
   
private
   
end Server_Check_Moves;


