--
-- Acteur permettant de manipuler un jeu de cartes.
--
package Jeu_De_Cartes is

   -- La 'couleur' d'une carte est le symbole qu'elle porte
   type T_Couleur is (Trefle, Pique, Coeur, Carreau) ;

   -- Une carte est caractérisée par sa couleur et sa valeur.
   -- La valeur est un entier :
   --   1 = As
   --   2..10 = les cartes numérotées de 2 à 10
   --   11 = Valet
   --   12 = Dame
   --   13 = Roi
   type T_Carte is record
      Valeur  : Integer ;
      Couleur : T_Couleur ;
   end record ;

   -- Un ensemble de cartes
   type T_Cartes is array (Integer range <>) of T_Carte ;

   -- Affiche une carte (en texte), par exemple "As de Coeur".
   procedure Afficher_Carte(Carte : T_Carte) ;

   -- Cette procédure prend en argument un ensemble de cartes et le mélange.
   procedure Melanger (Cartes : in out T_Cartes) ;

end Jeu_De_Cartes ;
