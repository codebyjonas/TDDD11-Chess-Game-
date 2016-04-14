with Chess_Game_Graphic;            use Chess_Game_Graphic;
with Chess_Game_Handling;           use Chess_Game_Handling;
procedure Tmp_Main_Graphic is
   Active_Chessman : Chessman_Type; 
begin
   Draw_Complete_Game_Board;
   Choose_Active_Chessman(Active_Chessman); 
end Tmp_Main_Graphic;

