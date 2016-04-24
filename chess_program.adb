with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Chess_Analysis_Package; use Chess_Analysis_Package;

procedure Chess_Program is 

    Board : Board_Type;
    Counter: Boolean;
    Coordinate_1, Coordinate_2: Coordinate_Type;
    A : Possible_Moves_Type;
   
begin
   
   Reset(Board);
   
   Counter:= true;
   
   -- Position P1--
   Coordinate_1(1):= 2;
   Coordinate_1(2) := 8;
   
   -- Position P2-- 
   Coordinate_2(1):= 5;
   Coordinate_2(2) := 5;
   
   --Flyttar pjäs på plats P1 till position P2. På P1 fås istället en 0a--
   Move(Board, Coordinate_1, Coordinate_2);
   
   Print_Board(Board);
   
   -- Tar fram möjliga drag för pjäs på position P2--
   A := Possible_Moves(Coordinate_2, Board, Counter);
   
   -- Skriver ut arrayen av möjliga drag-- 
   Put_Array(A);
   
   end Chess_Program;
