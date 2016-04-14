--Gnatmake för hela bibloteket: gnatmake $(~TDDD11/TJa-lib/bin/tja_config) program.adb


with Ada.Command_Line; use Ada.Command_Line;
with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

with TJa.Sockets;      use TJa.Sockets;

procedure Server_Main is
   
   Listner              : Listener_Type;
   Socket_1, Socket_2   : Socket_Type;
   X, Y                 : Integer;
   
begin
   
   -- TODO: Skapa Error vid fel argument
   -- Start Server with two sockets
   Initiate(Listner, Natural'Value(Argument(1)), Localhost => True);
   
   Wait_For_Connection(Listner, Socket_1); 
   Put_Line("Klient 1 ansluten");
   Wait_For_Connection(Listner, Socket_2);
   Put_Line("Klient 2 ansluten");
   
   -- Tilldela Klient 1 Vit och 2 Svart
   Put_Line(Socket_1, 'w');
   Put_Line(Socket_2, 'b');
   
   -- Set Actual_Game_Round_Case
   --- 1. Schack Matt
   --- 2. Schack
   --- 3. Regular
   --- 4. First Round 
   Put_Line(Socket_1, 4);
   Put_Line(Socket_2, 3); 
   
   --Hämta X,Y från klient
   Get(Socket_1, X);
   Get(Socket_1, Y);
   Put(X);
   Put(Y);
   -- To do: Skapa en funktion som returnerar möjliga drag
   
   -- Tmp 
   Put_Line(Socket_1, 4);
   Put_Line(Socket_1, 8);
   
   for I in 1..26 loop
      Put_Line(Socket_1, 0);
   end loop;
   
   delay 1000000.0;
   
end Server_Main;
