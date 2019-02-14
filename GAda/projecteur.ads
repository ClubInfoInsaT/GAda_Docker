package Projecteur is

   -- Projette le nombre de pubs indiqué
   procedure Pub (Nb : Integer) ;

   -- Projette le nombre de bandes-annonces indiqué
   procedure Annonce (Nb : Integer) ;

   -- Projette la séquence de logo du producteur du film
   procedure Producteur ;

   -- Projette tout le film
   procedure Film ;

   -- Projette le générique de fin
   procedure Generique ;


   -- Indique combien de pubs ont été diffusées
   function Combien_Pubs return Integer ;


end Projecteur ;
