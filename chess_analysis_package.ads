with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package Chess_Analysis_Package is

   type Coordinate_Type is    -- Var tvungen att låta dessa ligga utanför private för att få det att funka. Kan vi lösa detta? 
     array(1..2) of Integer;
   
     type Height_Type is
     array(1..8) of Integer;
   
   type Board_Type is
     array(1..8) of Height_Type;
   
   type Possible_Moves_Type is
     array(1..28) of Coordinate_Type;
   
   type Filip_Type is
     array(1..3) of Integer; 
   
   type Return_Type is
     array(1..28) of Filip_Type;
   
   
   

   procedure Zero_Procedure(Board: in out Board_Type);
   procedure Reset(Board: in out Board_Type);
   procedure Move(Board : in out Board_Type; In_Coordinate, Out_Coordinate : in Coordinate_Type);
   procedure Print_Board(Board: in Board_Type);
   function "="(Left, Right : in Coordinate_Type) return Boolean;
   procedure Zero_Possible(Possible : in out Possible_Moves_Type);
   procedure Search_And_Destroy(Coordinate: in Coordinate_Type; Possible_Moves : in out Possible_Moves_Type);
   function Possible_Moves(Coordinate: in Coordinate_Type; Board : in Board_Type; Tur : in boolean) return Possible_Moves_Type;
   procedure Put_Array(A : in  Possible_Moves_Type);
   function Schack(Board : in Board_Type; Tur : in Boolean) return Boolean;
   function Final_Possible_Moves(Coordinate: in Coordinate_Type; Board : in Board_Type; Tur : in boolean) return Possible_Moves_Type;
   function Check_Mate(Board : in Board_Type; Tur : in Boolean) return Boolean;
   
   
   
   -- Till Fillip o Jonas;
   
    function Till_Filip(Moves: in Possible_Moves_Type; Board: in Board_Type) return Return_Type;
    function Check_Case(Active_Board: in Board_Type; Active_Player: in Boolean) return Integer;
    
    function Get_Choosen_Chess_Piece(In_Coordinate : in Coordinate_Type; 
				     Board : in Board_Type) return Integer;
   
   end Chess_Analysis_Package;
