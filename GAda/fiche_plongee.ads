--
-- Acteur représentant certaines informations des fiches de sécurité en plongée.
--
package Fiche_Plongee is
   
   -- Trigramme pour nommer chaque plongeur
   subtype T_Trigramme is String(1..3) ;
      
   -- Role du plongeur dans sa palanquée.
   type T_Role is (Ens, Eleve, GP, Enca, Auto) ;
   
   
   type T_Plongeur is record
      -- Ce booléen indique si la case du tableau est utilisée.
      -- S'il est faux, les autres attributs n'ont pas de signification
      -- car ou bien le plongeur est absent, ou bien la ligne de la fiche est vide.
      Present: Boolean ;
      
      -- Informations utiles lorsque le plongeur est présent.      
      Nom: T_Trigramme ;
      Profondeur_Max_Autorisee: Integer ;
      Role: T_Role ;
   end record ;
   
   
   -- Ensemble de plongeurs
   type T_Tab_Plongeurs is array(Integer range <>) of T_Plongeur ;
   
   
   -- Nombre maximal de plongeurs dans une palanquée
   Max_Plongeurs: Integer := 5 ;
      
   type T_Palanq is record
      -- Durée passée au fond, en minutes
      Duree_Reelle_Fond: Integer ;
      
      -- Profondeur maximale de plongée, en mètres
      Profondeur_Reelle: Integer ;
      
      -- Tableau des plongeurs
      Plongeurs: T_Tab_Plongeurs(1..Max_Plongeurs) ;
   end record ;
   
   
   type T_Tab_Palanquees is array(Integer range <>) of T_Palanq ;
   
   
   -- Nombre maximal de palanquées inscrites sur la fiche 
   Max_Palanquees: Integer := 10 ;
   
   
   type T_Fiche_Secu is record
      
      -- Directeur de plongée
      Directeur: T_Trigramme ;
      
      -- Tableau contenant les palanquées.
      -- Toutes les cases ne sont pas utilisées.
      Tab_Palanquees: T_Tab_Palanquees(1..Max_Palanquees) ;
      
      -- Nombre exact de palanquées utilisées dans le tableau.
      -- Les cases utilisées sont les cases de 1 à Nb\_Palanquees.
      NB_Palanquees: Integer ;
      
      -- Temps maximal autorisé par le directeur de plongée, en minutes
      Temps_Plongee_Max_Autorise: Integer ;
   end record ;
   
end Fiche_Plongee ;
   
   
