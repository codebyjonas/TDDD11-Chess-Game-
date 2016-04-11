with Ada.Command_Line; use Ada.Command_Line;
with Ada.Text_IO;      use Ada.Text_IO;

with TJa.Sockets;      use TJa.Sockets;


procedure Client_Main is
   
   Socket : Socket_Type;
   
begin
  
   Initiate(Socket);
   
   -- Anslut till Server 
   Connect(Socket, Argument(1), Positive'Value(Argument(2))); 
   
   -- Black or White 
   
end Client_Main;
