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
   
   
   
   
end Server_Main;
