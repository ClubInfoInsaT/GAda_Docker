--
-- Cet acteur permet de connaitre les paliers a effectuer en fonction
-- de la duree et de la profondeur de la plongee.
--
package Plongee is

   -- Ignorez cette ligne 'pragma' (qui, pour information, permet d'initialiser la table automatiquement)
   pragma Elaborate_Body ;



   -- Ce type represente une profondeur comptee par intervalles de 10 mètres.
   -- La profondeur max est donc de 60 mètres.
   subtype T_Profondeur is Integer range 0..6 ;


   -- Ce type represente une duree comptee par intervalles de 10 minutes.
   -- La duree max est donc de 360 minutes.
   subtype T_Duree is Integer range 0..36 ;


   -- Sequence des paliers a effectuer a la remontee.
   -- (Le plongeur commence bien sur par le palier le plus profond)
   -- Si un palier vaut 0, c'est qu'il est inutile.
   type T_Sequence is record
         Trois   : Natural ;
         Six     : Natural ;
         Neuf    : Natural ;
         Douze   : Natural ;
         Quinze  : Natural ;
   end record ;


   -- 'Definis' indique si la sequence de paliers est definie.
   -- Lorsque 'definis' est FAUX, c'est qu'il n'est pas autorise' de plonger
   -- a la profondeur indiquee pendant la duree indiquee.
   type T_Resultat is record
      Definis  : Boolean ;
      Sequence : T_Sequence ;
   end record ;


   -- La table des paliers

   type T_Paliers is array (Integer range <>, Integer range <>) of T_Resultat ;

   Table : T_Paliers (T_Profondeur, T_Duree) ;

end Plongee ;
