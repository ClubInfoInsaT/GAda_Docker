package KakoCine is

--
-- *** ATTENTION ***
-- Certaines actions ne sont pas utiles pour votre sujet de contrôle,
-- mais sont utiles pour d'autres élèves ayant un autre sujet.
--
-- Il est donc normal de ne pas se servir de toutes les actions.
--








   -- *** Avez-vous lu l'avertissement ci-dessus ? ***


   -- Nombre de films différents à l'affiche
   -- Les films sont numérotés à partir de 1
   Nb_De_Films : constant Integer := 6 ;

   -- Nombre de salles du cinéma
   -- Les salles sont numérotées à partir de 1
   Nb_De_Salles : constant Integer := 8 ;

   -- Renvoie le titre du film projeté dans la salle indiquée
   function Film_De_La_Salle (No_Salle : Integer) return String ;

   -- Renvoie le titre du film dont le numéro est donné
   function Titre_Du_Film (No_Film : Integer) return String ;

   -- Renvoie le numéro de salle où le film indiqué est projeté en ce moment
   -- Le film est repéré par son numéro
   function Salle_Du_Film (No_Film : Integer) return Integer ;


   -- Indique si tout les clients ayant acheté un ticket pour cette séance sont présents
   function Tout_Le_Monde_Present (No_Salle : Integer) return Boolean ;

   -- Indique si tout le monde est sorti
   function Tout_Le_Monde_Sorti (No_Salle : Integer) return Boolean ;


   -- Le nombre de sièges de chaque salle (toutes les salles ont la même capacité)
   -- Les sièges sont numérotés à partir de 1
   Nb_Sieges : constant Integer := 80 ;

   -- Renvoie la valeur du clavier situé au fauteuil indiqué
   function Valeur_Clavier (No_Salle : Integer ; No_Fauteuil : Integer) return Integer ;


   -- Renvoie l'heure théorique du début du film de la salle indiquée
   function Heure_Debut (No_Salle : Integer) return Float ;

   -- Renvoie l'heure théorique de fin du film de la salle indiquée
   function Heure_Fin (No_Salle : Integer) return Float ;

   -- Renvoie le nombre de clients de la journée
   -- Les clients sont numérotés à partir de 1
   function Nb_Clients return Integer ;

   -- Renvoie la salle du client indiqué, et ses heures d'entrée et de sortie de la salle
   procedure Mouvements_Client (No_Client : in Integer ; Salle : out Integer ; Entree, Sortie : out Float) ;


end KakoCine ;
