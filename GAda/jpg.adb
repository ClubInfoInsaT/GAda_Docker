with Simple_Jpeg_Lib ;
use  Simple_Jpeg_Lib ;

with GAda.Core ;
with Ada.Strings.Hash ;
with Ada.Unchecked_Deallocation ;

with Ada.Containers ;
use  Ada.Containers ;
with Ada.Streams.Stream_IO ;

package body JPG is

   package Txt renames GAda.Core ;
   package Fil renames Ada.Streams.Stream_IO ;

   type T_Imgptr is access T_Image ;
   procedure Free is new Ada.Unchecked_Deallocation(T_image, T_Imgptr);

   -- Hashcode du nom de la dernière image chargée
   Checksum_Image : Ada.Containers.Hash_Type := Ada.Strings.Hash("bla") ;


   -- Compteur : combien de fois on a chargé cette image
   Compte_Image : Integer := 0 ;

   function Lire_Image (Nom_Image : String) return T_Image is
      Handle : Jpeg_Handle_Decompress;
      JPType : Jpeg_Type ;
      Larg, Haut : Natural ;

      My_File    : Ada.Streams.Stream_IO.FILE_TYPE;
   begin
      -- Test si l'image existe
      begin
         Fil.Open(My_File, Fil.In_File, Nom_Image);
         Fil.Close(My_File) ;
      exception
         when Fil.Name_Error =>
            Txt.Put_Err("Le fichier '" & Nom_Image &
                        "' est introuvable. Est-il dans le bon dossier ?") ;
            Txt.Put_Err("") ;
            Txt.Put_Err("Essayez en plaçant l'image à la racine de votre dossier personnel (votre HOME)") ;
            Txt.Put_Err("");
            raise Program_Error ;

      end ;


      if Ada.Strings.Hash(Nom_Image) = Checksum_Image then
         Compte_Image := Compte_Image + 1 ;
         if Compte_Image >= 101 then
            Txt.Put_Err("Cela fait la 101ème fois que votre programme " &
                        "appelle Lire_Image(" & Nom_Image &
                        ") et ça fait trop.") ;
            Txt.Put_Line("Essayer de n'appeler Lire_Image qu'une seule fois " &
                         "pour chaque image.") ;
            Txt.New_Line ;
            raise Program_Error ;
         end if ;
   else
      Compte_Image := 0 ;
      Checksum_Image := Ada.Strings.Hash(Nom_Image) ;
   end if ;

      Open_Jpeg(Nom_Image, Handle, 1) ;
      Get_Image_Info(Handle, Larg, Haut, JPType) ;
      declare
         Matrice : T_Imgptr := new T_Image(0..Haut - 1, 0..Larg - 1) ;
      begin
         --
         -- Remplissage de la matrice ligne par ligne
         --
      for Ligne in Matrice'Range(1) loop
         declare
            Ligne_JPG : Component_Array :=  Read_Next_Line (Handle) ;
            Rouge, Vert, Bleu : Integer ;
            Gray : Integer ;
            Indice : Natural := Ligne_JPG'First;
         begin
            for Colonne in Matrice'Range(2) loop
               case JPType is
                  when RVB =>
                     -- Trois couleurs à récupérer
                     Rouge := Integer(Ligne_JPG(Indice)) ;
                     Indice := Indice + 1 ;
                     Vert := Integer(Ligne_JPG(Indice)) ;
                     Indice := Indice + 1 ;
                     Bleu := Integer(Ligne_JPG(Indice)) ;
                     Indice := Indice + 1 ;

                     Matrice(Ligne, Colonne) := (Rouge, Vert, Bleu) ;

                  when Grey =>
                     Gray := Integer(Ligne_JPG(Indice)) ;
                     Indice := Indice + 1 ;

                     Matrice(Ligne, Colonne) := (Gray, Gray, Gray) ;
               end case ;
            end loop ;
         end ;
      end loop ;

      Close_Jpeg (Handle) ;

      return Matrice.all ;
      end ;

   end Lire_Image ;

   procedure Ecrire_Fichier (Nom_Image : in String ;
                             Matrice   : in T_Image ) is
      Handle : Jpeg_Handle_Compress ;
   begin
      Create_Jpeg (Nom_Image, Handle,
                   Matrice'Length(2), Matrice'Length(1), RVB) ;

      -- Écriture du fichier ligne par ligne
      for Ligne in Matrice'Range(1) loop
         declare
            Taille_Ligne : Integer := Matrice'Length(2) * 3 ;
            Ligne_JPG : Component_Array (1..Taille_Ligne);
            Rouge, Vert, Bleu : Integer ;
            Indice : Natural := Ligne_JPG'First;
         begin
            for Colonne in Matrice'Range(2) loop
               -- Trois couleurs à caser
               Rouge := Matrice(Ligne, Colonne).Rouge ;
               Ligne_JPG(Indice) := Byte(Rouge) ;
               Indice := Indice + 1 ;

               Vert  := Matrice(Ligne, Colonne).Vert ;
               Ligne_JPG(Indice) := Byte(Vert) ;
               Indice := Indice + 1 ;

               Bleu  := Matrice(Ligne, Colonne).Bleu ;
               Ligne_JPG(Indice) := Byte(Bleu) ;
               Indice := Indice + 1 ;
            end loop ;
            Write_Line (Handle, Ligne_JPG) ;
         end ;
      end loop ;

      Close_Jpeg (Handle) ;
   end Ecrire_Fichier ;

end JPG ;
