--
-- Cet acteur permet d'accéder à la liste des rois de France depuis 400
--

package Rois is

   -- Chaque roi est identifié par un numéro
   -- La numérotation va de 1 à N (nombre de rois dans la liste).

   -- Nombre de rois présents dans la liste
   function Nb_Rois return Integer ;

   -- Renvoie le nom du roi dont on fournit le numéro.
   function Nom (Roi : Integer) return String ;

   -- Renvoie l'année de début du règne du roi dont on fournit le numéro.
   function Debut (Roi : Integer) return Integer ;
   
   -- Renvoie l'année de fin de règne du roi dont on fournit le numéro.
   function Fin (Roi : Integer) return Integer ;

end Rois ;

