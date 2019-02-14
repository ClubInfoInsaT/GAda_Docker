with SudoGrille ;
with Gada.Text_IO ;

package body Support is

   package G renames SudoGrille ;
   package Txt renames GAda.Text_IO ;

   type Un_Resultat is record
      Combien : Integer ;
      Valeur  : Integer ;
   end record ;

   -- Compte le nombre de valeurs possibles dans une case et renvoie l'une des valeurs possibles.
   function Compte_Possibles (Possibles : G.Les_Chiffres_Possibles) return Un_Resultat is
      Compteur : Integer := 0 ;
      Valeur : Integer ;
   begin
      -- Combien de possibles
      for I in Possibles'Range loop
         if Possibles(I) then
            Compteur := Compteur + 1 ;
            Valeur := I ;
         end if ;
      end loop ;

      G.Failif(Compteur = 0, "Aucune possibilité dans cette case.") ;

      return (Compteur, Valeur) ;
   end Compte_Possibles ;

   -- Calcule la somme du nombre de valeurs possibles de la grille.
   function Total_Possibles (Grille : G.Une_Grille) return Integer is
      Total : Integer := 0 ;
   begin
      for Ligne in Grille'Range(1) loop
         for Colonne in Grille'Range(2) loop
            Total := Total + Compte_Possibles(Grille(Ligne, Colonne)).Combien ;
         end loop ;
      end loop ;

      return Total ;
   end Total_Possibles ;

   --
   -- Propage une case déterminée dans les trois maisons.
   --
   procedure Propage(Grille : in out G.Une_Grille ; Ligne, Colonne : Integer ; Valeur : Integer) is
      DepLigne : Integer ;
      DepCol : Integer ;
   begin
      -- Propage sur toute la ligne. Attention à ne pas interdire la valeur dans la case d'où l'on vient.
      for NCol in Grille'Range(2) loop
         if NCol /= Colonne then
               Grille(Ligne, NCol)(Valeur) := False ;
            end if ;
      end loop ;

      -- Propage sur toute la colonne. Attention à ne pas interdire la valeur dans la case d'où l'on vient.
      for NLig in Grille'Range(1) loop
         if NLig /= Ligne then
            Grille(NLig, Colonne)(Valeur) := False ;
         end if ;
      end loop ;

      DepLigne := 3 * ((Ligne - 1) / 3) + 1 ;
      DepCol   := 3 * ((Colonne - 1) / 3) + 1 ;

      -- Propage sur tout la sous-grille. Attention à ne pas interdire la valeur dans la case d'où l'on vient.
      for NLig in DepLigne..DepLigne+2 loop
         for NCol in DepCol..DepCol+2 loop
            if NLig /= Ligne or NCol /= Colonne then
               Grille(NLig, NCol)(Valeur) := False ;
            end if ;
         end loop ;
      end loop ;

   end Propage ;


   Ancien_Compte : Integer ;
   Nouveau_Compte : Integer := G.Taille * G.Taille * G.Taille ;

   procedure Propage_Tout (Grille : in out SudoGrille.Une_Grille ; Continue : in out Boolean) is
      Seul : Un_Resultat ;

   begin
      -- Propage les contraintes liées au cases seules.
      for Ligne in Grille'Range(1) loop
         for Colonne in Grille'Range(2) loop
            Seul := Compte_Possibles(Grille(Ligne, Colonne)) ;
            if Seul.Combien = 1 then
               Propage(Grille, Ligne, Colonne, Seul.Valeur) ;
            end if ;
         end loop ;
      end loop ;

      Ancien_Compte := Nouveau_Compte ;
      Nouveau_Compte := Total_Possibles(Grille) ;

      Continue := Nouveau_Compte > G.Taille * G.Taille and Nouveau_Compte /= Ancien_Compte ;

   end Propage_Tout ;

end Support ;
