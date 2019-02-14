with GAda.Core ;
with Gada.Text_IO ;

package body Auto is
   
   package Txt renames GAda.Text_IO ;
   
   -- Compte les appels pour prévenir les boucles infinies.
   Nb_Appels : Integer := 0 ;

   Max_Appels : constant Integer := 400_000 ;

   procedure Compte_Appel is
   begin
      Nb_Appels := Nb_Appels + 1 ;
      if Nb_Appels > Max_Appels then
         raise Gada.Core.Boucle_Infinie ;
      end if ;
   end Compte_Appel ;
   
   --
   -- Générateur aléatoire (déterministe).
   -- On pourrait utiliser Ada.Numerics.Discrete_Random.
   --
   Current_Alea : Integer := 0 ;
   
   Alea_A : Integer := 1103515245 ;
   Alea_C : Integer := 12345 ;
   Alea_M : Integer := 2**26 ;
   
   DateNow : Float := 0.0 ;
   
   function Tirage return Natural is
   begin
      -- Txt.Put_Line("Alea = " & Integer'Image(Current_Alea)) ;
      Current_Alea := abs((Alea_A * Current_Alea + Alea_C) mod Alea_M) ;
      return Current_Alea ;
   end Tirage ;
   
   function IAlea (Min, Max : Integer) return Integer is
      Len : Integer := Max - Min + 1 ;
   begin
      return Min + (Tirage mod Len) ;
   end IAlea ;
   
   function FAlea (Min, Max : Float) return Float is
      Imin : Integer := Integer(Min * 100.0) ;
      Imax : Integer := Integer(Max * 100.0) ;
   begin
      return Float(IAlea(IMin, Imax)) / 100.0 ;
   end FAlea ;
   
   -- Action = ARRET
   Arret : T_Action := ( Direction => 0.0,
                         Accelere => 0,
                         Freinage => 0,
                         Urgence => False) ;
   
   -- Valeurs courantes
   Current : T_Action := Arret ;
   
   Vitesse_Max : Float := 90.0 ;
   Vitesse_Now : Float := 0.0 ;
   
   A_Destination : Boolean := False ;
   
   procedure Next_Action is
      Accel : Integer := IAlea(0, 10) ;
      Frein : Integer := IAlea(0, 10) ;
      Choix : Integer := IAlea(0,100) ;
   begin
      Compte_Appel ;
      
      -- Une fois sur 100 on créé un conflit.
      if Choix < 49 then Frein := 0 ;
      elsif Choix < 100 then Accel := 0 ;
      end if ;
      
      Current := ( Direction => FAlea(-30.0,30.0),
                   Accelere  => Accel,
                   Freinage  => Frein,      
                   Urgence   => IAlea(0,100) < 4) ;
      
      Vitesse_Now := FAlea (0.0, Vitesse_Max) ;
      
      A_Destination := IAlea(0,100) = 1 ;
   end Next_Action ;

   
   procedure Fixer_Destination (Long : Float ; Lat : Float) is
      Initiator : Integer := Integer (532.0 * (Long * Long * Long - 0.911 * Lat)) ;
   begin
      Compte_Appel ;
      A_Destination := False ;
      Vitesse_Now := 0.0 ;
      DateNow := 0.0 ;
      Current := Arret ;
      Current_Alea := Initiator ;
      -- Txt.Put_Line("Initiator = " & Integer'Image(Initiator) & "  Premier tir = " & Integer'Image(IAlea(0,10000))) ;
      Next_Action ;
   end Fixer_Destination ;
      
   function Vitesse return Float is
   begin
      Compte_Appel ;
      return Vitesse_Now ;
   end Vitesse ;
   
   procedure Regler_Mode (Prudent : Boolean) is
   begin
      Compte_Appel ;
            
      if Prudent then
         Vitesse_Max := 60.0 ;
      else
         Vitesse_Max := 90.0 ;
      end if ;
      
      -- Pour être bien observable, le changement de mode consomme du générateur aléatoire.
      -- De plus, il calcule la vitesse après avoir fixé la vitesse max.
      Next_Action ;

   end Regler_Mode ;
   
   function Arrivee return Boolean is
   begin
      Compte_Appel ;
      return A_Destination ;
   end Arrivee ;
   
   function Action_Courante return T_Action is
   begin
      Compte_Appel ;
      return Current ;
   end Action_Courante ;
   
   function Date return Float is
   begin
      return DateNow ;
   end Date ;
   
   procedure Attend_Ms is
   begin
      Compte_Appel ;
      DateNow := DateNow + 0.019 ;
      Next_Action ;
   end Attend_Ms ;
   
end Auto ;
