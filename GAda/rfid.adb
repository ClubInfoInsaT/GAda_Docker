with Ada.Calendar ; use Ada.Calendar ;
with Gada.Core ;

package body RFID is

   package Txt renames Gada.Core ;

   Freq_Base : Float := 205.0E6 ;
   Freq_Step : Float := 15.0E6 ;

   function Frequence (No_Frequence : Integer) return Float is
   begin
      if No_Frequence < 1 or No_Frequence > Nb_Frequences then
         Txt.Put_Err("Erreur lors de l'appel à RFID.Frequence() : la fréquence numéro " &
                     Integer'Image(No_Frequence) & " n'existe pas.") ;
         raise Mauvais_Numero_De_Frequence ;
      end if ;

      return Freq_Base + Freq_Step * Float(No_Frequence) ;
   end Frequence ;

   Start : constant Time := Clock ;

   function Signal_Present (Freq : Float) return Boolean is
      Duree : Integer := Integer((Clock - Start) / 2.5511) ;
   begin
      return
        Integer((Freq - Freq_Base) / Freq_Step) mod Nb_Frequences
        = Duree * 2193 mod (Nb_Frequences * 2) ;
   end Signal_Present ;

   function Etiquette_Detectee (Freq : Float) return Integer is
   begin
      if Signal_Present(Freq) Then
         return 4000 + Integer(Freq / 1.0E6) ;
      else
         return -9000 ;
      end if ;
   end Etiquette_Detectee ;

end RFID ;
