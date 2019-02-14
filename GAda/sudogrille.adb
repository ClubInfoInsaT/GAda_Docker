with GAda.Text_IO ;
with Gada.Core ;
with GAda.Graphics ;
with GAda.Advanced_Graphics ;

package body SudoGrille is

   package Txt renames Gada.Text_IO ;
   package Gr renames GAda.Graphics ;
   package AGr renames GAda.Advanced_Graphics ;

   type Une_Grille_Brute is array (1..Taille, 1..Taille) of Integer ;

   -- Détermine une case
   function Fixe(Valeur : Integer) return Les_Chiffres_Possibles is
      Resultat : Les_Chiffres_Possibles := (others => False) ;
   begin
      Resultat(Valeur) := True ;
      return Resultat ;
   end Fixe ;


   function Fabrique (Niveau : Un_Niveau) return Une_Grille is
      Grille_Brute : Une_Grille_Brute ;
      Result : Une_Grille ;
   begin
      case Niveau is
         when Piece_Of_Cake =>
           -------------------------------------------------------------
           Grille_Brute :=
             ((9, 0, 1, 0, 0, 0, 8, 0, 3),
              (2, 0, 0, 9, 0, 0, 5, 0, 0),
              (6, 5, 7, 8, 0, 3, 4, 0, 0),
              (0, 8, 0, 0, 7, 4, 0, 0, 9),
              (0, 7, 0, 3, 0, 2, 0, 8, 0),
              (4, 0, 0, 1, 9, 0, 0, 3, 0),
              (0, 0, 3, 7, 0, 6, 9, 4, 0),
              (0, 0, 6, 0, 0, 9, 0, 0, 2),
              (8, 0, 4, 0, 0, 0, 1, 0, 7)) ;

           -------------------------------------------------------------

         when Moyen =>
            -------------------------------------------------------------
            Grille_Brute :=
              ((4, 0, 0, 3, 0, 0, 0, 5, 0),
               (0, 1, 0, 0, 0, 0, 0, 0, 2),
               (0, 0, 0, 2, 5, 9, 0, 4, 8),
               (0, 0, 0, 8, 2, 0, 6, 7, 0),
               (0, 0, 6, 0, 0, 0, 2, 0, 0),
               (0, 2, 4, 0, 6, 7, 0, 0, 0),
               (7, 9, 0, 1, 3, 2, 0, 0, 0),
               (6, 0, 0, 0, 0, 0, 0, 2, 0),
               (0, 3, 0, 0, 0, 4, 0, 0, 7)) ;

            -------------------------------------------------------------


         when Difficile =>
            -------------------------------------------------------------
            Grille_Brute :=
              ((0, 0, 1, 0, 0, 0, 8, 0, 3),
               (2, 0, 0, 9, 0, 0, 5, 0, 0),
               (6, 0, 0, 8, 0, 3, 0, 0, 0),
               (0, 8, 0, 0, 7, 0, 0, 0, 9),
               (0, 7, 0, 3, 0, 2, 0, 8, 0),
               (0, 0, 0, 0, 9, 0, 0, 0, 0),
               (0, 0, 3, 0, 0, 6, 0, 4, 0),
               (0, 0, 0, 0, 0, 9, 0, 0, 2),
               (0, 0, 4, 0, 0, 0, 1, 0, 7)) ;

            -------------------------------------------------------------


         when Diabolique =>
            -------------------------------------------------------------
            Grille_Brute :=
              ((0, 0, 1, 0, 0, 8, 0, 0, 0),
               (3, 0, 0, 4, 5, 2, 9, 1, 0),
               (0, 0, 7, 9, 0, 0, 5, 0, 0),
               (0, 0, 4, 5, 7, 0, 0, 0, 0),
               (0, 0, 2, 3, 0, 1, 7, 0, 0),
               (0, 0, 0, 0, 8, 4, 3, 0, 0),
               (0, 0, 3, 0, 0, 5, 2, 0, 0),
               (0, 5, 6, 8, 2, 3, 0, 0, 9),
               (0, 0, 0, 6, 0, 0, 8, 0, 0)) ;

            -------------------------------------------------------------
      end case ;

      for Ligne in Grille_Brute'Range loop
         for Colonne in Grille_Brute'Range loop
            declare
               Possibles : Les_Chiffres_Possibles := (others => False) ;
            begin
               if Grille_Brute(Ligne, Colonne) > 0 then
                  Possibles(Grille_Brute(Ligne, Colonne)) := True ;
               else
                  Possibles := (others => True) ;
               end if ;
               Result(Ligne, Colonne) := Possibles ;
            end ;
         end loop ;
      end loop ;

      return Result ;

   end Fabrique ;

   function Chiffre (X : Integer) return String is
      S : constant String := Integer'Image(X) ;
      I : constant Integer := S'Last ;
   begin
      return S(I..I) ;
   end Chiffre ;

   TiLettre : constant Integer := 10 ;
   TiMarge  : constant Integer := 4 ;
   Cell : constant Integer := TiLettre * 3 + 4 * TiMarge ;

   procedure Dessine_Case(X, Y : Integer ; Possibles : Les_Chiffres_Possibles) is
      Nb_Possibles : Integer := 0 ;
      Vu : Integer := 0 ;
      Larg : Integer := Cell - 2 * TiMarge ;
      PX, PY : Integer ;
   begin

      Gr.ColorRectangle(X + TiMarge, Y - TiMarge - Larg, Larg, Larg, (225,225,255)) ;

      -- Combien de possibles
      for I in Possibles'Range loop
         if Possibles(I) then
            Nb_Possibles := Nb_Possibles + 1 ;
            Vu := I ;
         end if ;
      end loop ;

      if Nb_Possibles = 1 then
         Gr.ColorPoint(-1,-1,(0,0,120)) ;
         AGr.Put_Text(X + TiMarge + 4, Y,  --  - TiMarge,
                      Chiffre(Vu), (Larg * 8) / 10) ;
      else
         for I in Possibles'Range loop
            PX := X + TiMarge + ((I - 1) mod 3) * (TiLettre + TiMarge) ;
            PY := Y - (TiMarge + ((I - 1) / 3) * (TiLettre + TiMarge)) ;
            Gr.ColorPoint(-1,-1,(200,0,0)) ;
            if Possibles(I) then
               AGr.Put_Text(PX, PY, Chiffre(I), (TiLettre * 95) / 100) ;
            end if ;
            --if not Possibles(I) then
            --   Gr.ColorPoint(-1,-1,(125,125,125)) ;
            --   AGr.Put_Text(PX, PY, "X", (TiLettre * 95) / 100) ;
            --end if ;
         end loop ;
      end if ;

   end Dessine_Case ;

   Fenetre_Ouverte : Boolean := False ;

   procedure Affiche (Grille : Une_Grille) is
      Marge : constant Integer := 30 ;
      Size  : constant Integer := Cell * Taille + (2 + (Taille - 1) / SousTaille) * Marge ;
   begin
      if not Fenetre_Ouverte then
         Gr.Resize(Size, Size) ;
         Fenetre_Ouverte := True ;
      end if ;

      Gr.BlackPoint(-1,-1) ;

      for Ligne in Grille'Range(1) loop
         for Colonne in Grille'Range(2) loop
            Dessine_Case(Marge/2 + (Colonne - 1) * Cell + Marge * ((Colonne - 1) / SousTaille) ,
                         Size - (Marge + (Ligne - 1) * Cell + Marge * ((Ligne - 1) / SousTaille)),
                         Grille(Ligne, Colonne)) ;
         end loop ;
      end loop ;

   end Affiche ;


   procedure Attend_Entree is
   begin
      Txt.Put("Appuyez sur ENTREE : ") ;
      Txt.Put(Txt.FGet) ;
   end Attend_Entree ;

   procedure Failif (Echoue : Boolean ; Message : String) is
   begin
      if Echoue then
         GAda.Core.Put_Err("Failif : " & Message) ;
      end if ;
   end Failif ;

end SudoGrille ;

