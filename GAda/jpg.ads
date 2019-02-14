--
-- Ce package permet de lire une image contenue dans un fichier JPG
-- ou d'écrire une image vers un fichier JPG.
--
-- (Utilise simple_jpeg_lib et libjpeg)
--

with GAda.Graphics ;

package JPG is

   --
   -- Une image est une matrice dont chaque case représente un point coloré.
   --
   type T_Image is array(Natural range <>, Natural range <>) of GAda.Graphics.T_Couleur ;


   --
   -- Lit un fichier contenant une image JPEG et renvoie une matrice
   -- contenant les pixels de l'image.
   --
   -- Les lignes et colonnes commencent à zéro.
   -- L'origine de la matrice (0,0) est située en haut à gauche de l'image.
   -- Comme d'habitude, le premier indice est le numéro de ligne, le deuxième indice le numéro de colonne.
   --
   function Lire_Image (Nom_Image : String) return T_Image ;

   
   
   --
   -- Crée sur le disque dur un fichier JPG contenant l'image
   -- Vous n'avez en principe pas besoin de cette procedure pendant les TPs.
   --
   procedure Ecrire_Fichier (Nom_Image : String ; Matrice : T_Image) ;

end JPG ;
