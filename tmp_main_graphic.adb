with Chess_Game_Graphic;            use Chess_Game_Graphic;
with Chess_Game_Handling;           use Chess_Game_Handling;
procedure Tmp_Main_Graphic is
   X,Y : Integer; 
begin
   Draw_Complete_Game_Board;
   Choose_Active_Chessman(X,Y); 
end Tmp_Main_Graphic;

