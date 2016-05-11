with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with TJa.Sockets;            use TJa.Sockets;

package Chess_Analysis_Package is

   type Coordinate_Type is private;
   
     type Height_Type is private;
   
   type Board_Type is private;
   
   type Possible_Moves_Type is private;
   
   type Coordinate_And_Chessman_Type is private;
  
   
   type Return_Type is private;
   
   
   

   procedure Zero_Procedure(Board: in out Board_Type);
   procedure Reset(Board: in out Board_Type);
   procedure Move(Board : in out Board_Type; In_Coordinate, Out_Coordinate : in Coordinate_Type);
 
   function "="(Left, Right : in Coordinate_Type) return Boolean;
   procedure Zero_Possible(Possible : in out Possible_Moves_Type);
   procedure Search_And_Destroy(Coordinate: in Coordinate_Type; Possible_Moves : in out Possible_Moves_Type);
   function Possible_Moves(Coordinate: in Coordinate_Type; Board : in Board_Type; Tur : in boolean) return Possible_Moves_Type;
   function Schack(Board : in Board_Type; Tur : in Boolean) return Boolean;
   function Final_Possible_Moves(Coordinate: in Coordinate_Type; Board : in Board_Type; Tur : in boolean) return Possible_Moves_Type;
   function Check_Mate(Board : in Board_Type; Tur : in Boolean) return Boolean;
   
    function  Create_Array_With_Chessman_And_Position(Moves: in Possible_Moves_Type; Board: in Board_Type) return Return_Type;
    function Check_Case(Active_Board: in Board_Type; Active_Player: in Boolean) return Integer;
    
    
    procedure Put(Socket: in Socket_Type; Possible_Array: in Return_Type);
    
    function Get_Choosen_Chess_Piece(In_Coordinate : in Coordinate_Type; 
				     Board : in Board_Type) return Integer;
    
    procedure Integers_To_Coordinate(Coordinate: out Coordinate_Type;
				      X, Y: in Integer);
    
    procedure Coordinate_To_Integers(Coordinate: in Coordinate_Type;
					X, Y: out Integer);
    
private
   
    type Coordinate_Type is 
     array(1..2) of Integer;
   
     type Height_Type is
     array(1..8) of Integer;
   
   type Board_Type is
     array(1..8) of Height_Type;
   
   type Possible_Moves_Type is
     array(1..28) of Coordinate_Type;
   
     type Coordinate_And_Chessman_Type is
     array(1..3) of Integer; 
   
   type Return_Type is
     array(1..28) of Coordinate_And_Chessman_Type;
    
end Chess_Analysis_Package;
