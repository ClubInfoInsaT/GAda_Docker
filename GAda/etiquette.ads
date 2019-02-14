package Etiquette is

   -- Les étiquettes sont numérotées de 1 à ...
   Nb_Etiquettes : constant Integer := 4_000 ;

   -- Indique si le numéro d'étiquette est actif
   function Numero_Actif (No : Integer) return Boolean ;

   -- Désactive le numéro d'étiquette
   procedure Desactive (No : Integer) ;

   -- Si le numéro est actif, renvoie l'âge de l'étiquette correspondante
   -- en nombre de jours.
   -- Si le numéro est inactif, renvoie 0.
   function Age (No : Integer) return Integer ;

end Etiquette ;
