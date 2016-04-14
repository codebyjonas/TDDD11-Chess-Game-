with Ada.Command_Line; use Ada.Command_Line;
with Ada.Text_IO;      use Ada.Text_IO;

with TJa.Sockets;      use TJa.Sockets;

procedure Server_Main is
   
   Listner              : Listener_Type;
   Socket_1, Socket_2   : Socket_Type;
   
   
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
   
   delay 1000000.0;
   
end Server_Main;
