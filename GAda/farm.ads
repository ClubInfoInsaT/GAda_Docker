--
-- Ce package permet de programmer un jeu de gestion de ferme.
--

package Farm is
   
   -- Les différents type d'animaux
   type T_Animal is (Canard, Vache, Poule, Mouton) ;
   
   -- Un enclos de la ferme.
   type T_Enclos is record
      
      -- Superficie exploitable de l'enclos en m2
      Superficie : Float ;
      
      -- Type d'animal présent dans l'enclos
      Animal: T_Animal ;
	
      -- Nombre d'animaux dans cet enclos
      -- Si l'enclos est inoccupé, ce nombre vaut zéro.
      Bebetes: Integer ;
      
   end record ;
   -- Les enclos sont ombragés. 
   -- Les animaux ont de l'eau, de la paille, et accès à internet.

   
   -- Type pour représenter une liste d'enclos
   type T_Liste_Enclos is array(Integer range <>) of T_Enclos ;
   
   -- Les enclos sont rectangulaires et bien alignés sous forme de quadrillage.
   -- L'ensemble de la ferme ressemble donc à une matrice. C'est une heureuse coïncidence.
   
   -- Un plan de la ferme sous forme de matrice.
   type T_Plan is array(Integer range <>, Integer range <>) of T_Enclos ;
   
   -- Ce record rassemble toutes les informations utiles au jeu.
   type T_Jeu is record
      Score : Integer ;
      
      -- Argent du joueur, en Chbufs (monnaie locale).
      Argent: Integer ;
      
      -- Nombre d'enclos occupés
      Nombre_Enclos: Integer ;
      
      -- Plan de la ferme. Les enclos sont organisés en 6 rangées de 4 enclos.
      Plan: T_Plan(1..6, 1..4) ;
   end record ;
   
end Farm ;

-- Précision importante : sur une même rangée, les enclos inoccupés sont toujours à droite des enclos occupés.

