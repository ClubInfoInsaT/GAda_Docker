--
-- Cet acteur permet d'accéder à la liste des présidents des États-Unis
--

package Presidents is

   -- Chaque président est numéroté
   -- La numérotation va de 1 à N (nombre de présidents répertoriés).
   -- La liste est dans l'ordre chronologique.

   -- Nombre de présidents présents dans la liste
   function Nb_Presidents return Integer ;

   -- Renvoie le nom du n-eme président.
   function Nom (No : Integer) return String ;

   type T_Infos is record
      -- Année de prise de fonction - début de la présidence
      Debut : Integer ;

      -- Année de fin de la présidence
      Fin : Integer ;

      -- Parti politique, avec la convention suivante :
      --   'F' Fédéraliste
      --   'B' Républicain-démocrate
      --   'R' Républicain
      --   'D' Démocrate
      --   'W' Whig
      Parti : Character ;

      -- Indique si ce président a été au bout de son mandat
      Mandat_Complet : Boolean ;
   end record ;

   -- Renvoie les informations concernant le N-eme président
   function Infos (No : Integer) return T_Infos ;

end Presidents ;

