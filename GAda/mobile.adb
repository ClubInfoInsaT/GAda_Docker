with GAda.Text_IO ;
with Ada.Calendar ; use Ada.Calendar ;

package body Mobile is

   package Txt renames GAda.Text_IO ;

   function No_SIM return Integer is
   begin
      return 35205 ;
   end No_SIM ;

   procedure Transmettre_Vers_Serveur (Etiquette : Integer ; Sim : Integer) is
   begin
      Txt.Put_Line("Message transmis vers le serveur : étiquette " & Integer'Image(Etiquette) & " détectée " &
                   "par le mobile avec carte SIM " & Integer'Image(SIM)) ;
   end Transmettre_Vers_Serveur ;

   procedure Pause (Secondes : Integer) is
   begin
      if Secondes > 0 then delay Duration(Secondes) ;
      end if ;
   end Pause ;

   function Distance_A_Etiquette (Etiquette : Integer) return float is
   begin
      return (Float(Etiquette mod 17) * 28.72 + Float(Etiquette) / 123.4) ;
   end Distance_A_Etiquette;

end Mobile ;
