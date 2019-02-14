--
-- Cet acteur permet de représenter une grille de Sudoku en cours de résolution
--
package SudoGrille is

   -- La taille d'une grille de Sudoku est de 9x9
   Taille : constant Integer := 9 ;

   -- La taille d'une sous-grille est de 3x3
   SousTaille : constant Integer := 3 ;

   -----------------------------
   --        TYPES            --
   -----------------------------

   -- Chaque case de la grille de Sudoku contient un tableau 'Les_Chiffres_Possibles' de 9 booléens.
   -- Par exemple le tableau [ True ; True ; False ; False ; ... ]
   --   indique que les chiffes 1 et 2 sont possibles dans la case, les chiffres 3 et 4 sont impossibles, etc.
   -- Ce tableau contient toujours 9 cases numérotées de 1 à 9.
   type Les_Chiffres_Possibles is array (Integer range 1..Taille) of Boolean ;

   -- Une grille de Sudoku : dans chaque case on indique les chiffres possibles.
   -- Les dimensions de la grille sont toujours les mêmes : 9 lignes et 9 colonnes numérotées de 1 à 9
   type Une_Grille is array (Integer range 1..Taille, Integer range 1..Taille) of Les_Chiffres_Possibles ;

   -- Pour déclarer une variable de type Une_Grille, on écrit :
   -- Ma_Variable_Grille_De_Sudoku : Une_Grille ;
   -- (Ne pas préciser la taille de la matrice car elle est déjà contenue dans la définition du type Une_Grille).



   -- La grille est initialisée automatiquement par l'acteur avec la fonction 'Fabrique', ci-dessous.
   -- On doit lui donner le niveau de difficulté souhaité.
   type Un_Niveau is (Piece_Of_Cake, Moyen, Difficile, Diabolique) ;


   ---------------------------------------
   --         SOUS-PROGRAMMES           --
   ---------------------------------------

   -- Attend que l'utilisateur appuie sur la touche 'Entree'
   procedure Attend_Entree ;


   -- Fabrique une grille de Sudoku du niveau indiqué.
   -- Les cases déjà remplies sont initialisées avec une seule valeur possible sur les 9.
   -- Les cases vides sont initialisées avec toutes les valeurs possibles (1..9).
   function Fabrique (Niveau : Un_Niveau) return Une_Grille ;


   -- Affiche la grille indiquée
   procedure Affiche (Grille : Une_Grille) ;


   -- Si Echoue vaut TRUE, fait échouer le programme en affichant le message.
   procedure Failif (Echoue : Boolean ; Message : String) ;

   --
   -- Pour la deuxième partie
   --

   -- Renvoie un tableau 'Les_Chiffres_Possibles' où toutes les cases sauf une sont à False.
   -- La case 'Valeur' est à True.
   function Fixe(Valeur : Integer) return Les_Chiffres_Possibles ;



end SudoGrille ;
