--
-- Cet acteur permet d'accéder à la liste des communes françaises de plusieurs départements.
-- (Les départements 31 à 50)
--

package Villes is
   
   -- Chaque ville est identifée par un numéro
   -- La numérotation va de 1 à N (nombre de villes)
   
   -- Nombre de villes présentes dans la liste (plus de 7000)
   function Nb_Villes return Integer ;
   
   -- Renvoie le nom de la ville dont on fournit le numéro
   function Denomination (No : Integer) return String ;
   
   
   -- Fiche d'information pour chaque ville
   type T_Fiche is record
      -- Numéro de département
      Departement : Integer ;
      Code_Postal : Integer ;
      
      -- Population en 2010
      Pop2010 : Integer ;
      
      -- Population en 1999
      Pop1999 : Integer ;
      
      -- Surface de la commune (en km2)
      Surface : Float ;
      
      -- Coordonnées
      Longitude : Float ;
      Latitude  : Float ;
      
      -- Altitude du point le plus bas de la commune
      Alt_Bas : Integer ;
      
      -- Altitude du point le plus haut de la commune
      Alt_Haute : Integer ;
   end record ;
   
   -- Renvoie la fiche de la ville dont on fournit le numéro
   function Fiche_Ville(No : Integer) return T_Fiche ;
   
end Villes ;
