--
-- Cet acteur permet d'accéder à quelques fonctions du téléphone mobile
--

package Mobile is

   -- Renvoie le numéro de carte SIM installée à bord du téléphone
   function No_SIM return Integer ;

   -- Indique au serveur qu'une étiquette a été détectée.
   -- Pour permettre au serveur de localiser l'émetteur, il faut donner le numéro de carte SIM.
   procedure Transmettre_Vers_Serveur (Etiquette : Integer ; Sim : Integer) ;

   -- Le programme fait une pause du nombre de secondes indiquées
   procedure Pause (Secondes : Integer) ;

   -- Indique la distance en mètres à laquelle se trouve une étiquette
   function Distance_A_Etiquette (Etiquette : Integer) return float;

end Mobile ;
