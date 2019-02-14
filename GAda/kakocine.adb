with GAda.Core ;
with Projecteur ;

package body KakoCine is

   Erreur : exception ;

   package Txt renames GAda.Core ;

   function Titre_Du_Film (No_Film : Integer) return String is
   begin
      case No_Film is
         when 1 => return "Bienvenue chez les Robinson" ;
         when 2 => return "Les rois de la glisse" ;
         when 3 => return "Le rêve de Cassandre" ;
         when 4 => return "Le premier cri" ;
         when 5 => return "Ratatouille" ;
         when 6 => return "Stardust le mystère de l'étoile" ;
         when others =>
            Txt.Put_err ("Aucun film ne porte le numéro " & Integer'Image(No_Film)) ;
            raise Erreur ;
      end case ;
   end Titre_Du_Film ;


   function Film_De_La_Salle (No_Salle : Integer) return String is
   begin
      case No_Salle is
         when 1 => return (Titre_Du_Film(3)) ;
         when 2 => return (Titre_Du_Film(4)) ;
         when 3 => return (Titre_Du_Film(5)) ;
         when 4 => return (Titre_Du_Film(2)) ;
         when 5 => return (Titre_Du_Film(3)) ;
         when 6 => return (Titre_Du_Film(2)) ;
         when 7 => return (Titre_Du_Film(1)) ;
         when 8 => return (Titre_Du_Film(6)) ;
         when others =>
            Txt.Put_err ("Aucune salle ne porte le numéro " & Integer'Image(No_Salle)) ;
            raise Erreur ;
      end case ;
   end Film_De_La_Salle ;

   function Salle_Du_Film (No_Film : Integer) return Integer is
   begin
      case No_Film is
         when 1 => return 7 ;
         when 2 => return 4 ;
         when 3 => return 5 ;
         when 4 => return 2 ;
         when 5 => return 3 ;
         when 6 => return 8 ;
         when others =>
            Txt.Put_err ("Aucun film ne porte le numéro " & Integer'Image(No_Film)) ;
            raise Erreur ;
      end case ;
      end Salle_Du_Film ;

      function Tout_Le_Monde_Present (No_Salle : Integer) return Boolean is
      begin
         return Projecteur.Combien_Pubs >= 3 ;
      end Tout_Le_Monde_Present ;

      function Tout_Le_Monde_Sorti (No_Salle : Integer) return Boolean is
      begin
         return (Projecteur.Combien_Pubs = 0) or (Projecteur.Combien_Pubs >= 4) ;
      end Tout_Le_Monde_Sorti ;

      function Valeur_Clavier (No_Salle : Integer ; No_Fauteuil : Integer) return Integer is
         -- Attention, (note_max - 1) pas multiple de 4 ou de 5, sinon ça marche pas
         Note_Max : Integer := 2 + ((No_Salle * No_Salle + 2) mod 8) ;
      begin
         if No_Fauteuil mod 5 = 0 then return 0 ;
         elsif No_Fauteuil mod 4 = 0 then return 10 ;
         else return 2 + (No_Fauteuil mod (Note_Max - 1)) ;
         end if ;
      end Valeur_Clavier ;

      function Nb_Clients return Integer is
      begin
         return 168 ;
      end Nb_Clients ;


      function Heure_Debut (No_Salle : Integer) return Float is
         Titre : String := Film_De_La_Salle (No_Salle) ;
         Delt : Float := Float(Titre'Length) / 6.0 ;
      begin
         return 16.0 + Delt ;
      end Heure_Debut ;

      function Heure_Fin (No_Salle : Integer) return Float is
         Titre : String := Film_De_La_Salle (No_Salle) ;
         Duree : Float := 65.0 + 3.5 * float(Titre'Length) ;
      begin
         return Heure_Debut (No_Salle) + Duree / 60.0 ;
      end Heure_Fin ;


      procedure Mouvements_Client (No_Client : in Integer ; Salle : out Integer ; Entree, Sortie : out Float) is
         Rclient : Float := Float(No_Client) / Float(Nb_Clients) ;
         Deltin : Float := 0.5 - (Rclient * Rclient) ;
         Deltout : Float := 0.5 - (Rclient * Rclient * Rclient) ;

      begin
         if (No_Client > Nb_Clients) or (No_Client <= 0) Then
            Txt.Put_err ("Aucun client ne porte le numéro " & Integer'Image(No_Client)) ;
            raise Erreur ;
         end if ;

         Salle := 1 + ((7 * No_Client) mod Nb_De_Salles) ;
         Entree := Heure_Debut (Salle) + Deltin ;
         Sortie := Heure_Fin (Salle) + Deltout ;

      end Mouvements_Client ;


end KakoCine ;
