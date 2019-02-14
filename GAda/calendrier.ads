--
--  Représente un calendrier
--
package Calendrier is

   -- Jours de la semaine
   type T_Nom_Jour is (Lun, Mar, Mer, Jeu, Ven, Sam, Dim) ;

   -- Phase de la lune
   type T_Lune is (Nouvelle_Lune, Pleine_Lune, Premier_Quartier, Dernier_Quartier, Intermediaire) ;
   
   -- Pour mesurer la durée du jour
   type T_Duree is record
      Heures : Integer ;
      Minutes : Integer ;
   end record ;

   
   -- Un jour dans un mois
   type T_Jour is record
      
      -- Jour de la semaine
      Nom_Jour : T_Nom_Jour ;

      -- Duree du jour en heures (entre le lever et le coucher du soleil)
      Duree_Jour : T_Duree ;

      -- Phase de la lune
      Phase_Lune : T_Lune ;
   end record ;
   
   
   -- Un tableau de jours
   type Tab_Jours is array(Integer range <>) of T_Jour ;
   
   
   type T_Mois is record
      -- Nom du mois sur 20 caractères.
      Nom_Mois : String(1..20) ;
      
      Nombre_Jours : Integer ;

      -- Tableau des jours de ce mois.
      -- Le tableau contient toujours 31 cases, mais si le mois a moins de 31 jours,
      -- les dernières cases ne doivent pas être prises en compte.
      Jours : Tab_Jours(1..31) ;

   end record ;

   type T_Annee is array(Integer range <>) of T_Mois ;
   
   -- Cette fonction renvoie le calendrier de l'année 2042
   -- Les cases du tableau sont numérotées de 1 à 12.
   function Cal2042 return T_Annee ;

end Calendrier ;
