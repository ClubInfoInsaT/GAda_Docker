--
-- Pilotage des robots
--
package EcoRobot is

   -- Renvoie le nombre de robots de la grille
   -- Les robots sont numérotés de 1 à N.
   function Nombre_Robots return Integer ;


   -- Attend que l'utilisateur appuie sur "entrée"
   -- (L'utilisation de cette procédure est purement facultatif)
   procedure Attendre_Entree ;


   -- Indique si le robot NUM a atteint la cible.
   function Robot_Content (Num : Integer) return Boolean ;

   -- Indique le nombre de robots ayant atteint la cible
   function Nb_Robots_Contents return Integer ;


   -- Renvoie l'abscisse (X) du robot NUM
   function Abscisse (Num : Integer) return Integer ;

   -- Renvoie l'ordonnée (Y) du robot NUM
   function Ordonnee (Num : Integer) return Integer ;


   --
   -- Demande au robot NUM de se déplacer vers la case indiquée,
   -- qui doit être une case adjacente à celle du robot,
   -- horizontalement ou verticalement. (Le robot ne se déplace
   -- pas en diagonale).
   --
   -- La case (0,0) est en haut à gauche.
   -- L'axe des Y est croissant vers le bas.
   --
   procedure Step (Num : Integer ; X, Y : Integer) ;


   -- Liste des directions (à utiliser dans la mission 1)
   Nord      : constant Integer := 1 ;
   Est       : constant Integer := 2 ;
   Sud       : constant Integer := 3 ;
   Ouest     : constant Integer := 4 ;


   -- Liste des objets
   Rien      : constant Character := 'Z' ;
   Billets   : constant Character := 'B' ;
   Cible     : constant Character := 'C' ;
   Robot     : constant Character := 'R' ;
   -- Dehors signifie que la case est en dehors des limites du plateau
   Dehors    : constant Character := 'X' ;

   --
   -- Renvoie le code de l'objet (selon la liste ci-dessus)
   -- qui se situe sur la case indiquée.
   --
   function Scan (X, Y : Integer) return Character ;


   ---------------------------------------------------------
   --  La suite n'est utile que pour les missions 2 et 3  --
   ---------------------------------------------------------

   --
   -- Chaque robot a une préférence pour effectuer sa chorégraphie
   -- de la mission 2.
   --
   -- Le type T_Preference contient 4 attributs entiers dont les valeurs
   -- sont toujours de 1 à 4.
   -- Par exemple, si Bord_Sud vaut 1 et Bord_Ouest vaut 2, cela signifie que
   -- la chorégraphie doit commencer par le bord sud puis aller ensuite au
   -- bord ouest (puis le bord ayant la valeur 3 et enfin celui ayant la valeur 4).
   --
   -- Tous les robots n'ont pas les mêmes préférences. Voir la fonction ci-dessous.
   --
   type T_Preference is record
      Bord_Nord  : Integer ;
      Bord_Sud   : Integer ;
      Bord_Est   : Integer ;
      Bord_Ouest : Integer ;
   end record ;

   -- Renvoie les préférences du robot NUM.
   function Preferences (Num : Integer) return T_Preference ;


   --------------------------------------------------
   --  La suite n'est utile que pour la mission 3  --
   --------------------------------------------------

   --
   -- Le robot peut maintenant laisser des post-it sur son passage.
   -- Mais il ne peut laisser qu'un seul post-it sur chaque case.
   --
   -- Le post-it peut contenir quatre booléens, un entier et un caractère.
   --

   type T_PostIt is record
      BooA : Boolean ;
      BooB : Boolean ;
      BooC : Boolean ;
      BooD : Boolean ;
      IVal : Integer ;
      CVal : Character ;
   end record ;

   -- Au début, toutes les cases contiennent un post-it
   -- (False, False, False, False, 0, '0')


   -- Dépose un post-it sur la case où se trouve le robot NUM.
   -- Détruit le post-it présent précédemment.
   procedure Depose_PostIt (Num : Integer ; PostIt : T_PostIt) ;


   -- Lit le post-it présent sur la case du robot NUM
   function Lit_PostIt (Num : Integer) return T_PostIt ;


end EcoRobot ;
