with Ada.Numerics.Discrete_Random ;
with GAda.Text_IO ;

package body Jeu_De_Cartes is

   package Int_Aleatoire is new Ada.Numerics.Discrete_Random(Positive) ;
   package Txt renames GAda.Text_IO ;

   Graine : Int_Aleatoire.Generator ;

   procedure Melanger (Cartes : in out T_Cartes) is
      Carte1, Carte2 : Integer ;
      ZoCarte : T_Carte ;
   begin
      -- Algo : on permute un certain nombre de fois.
      for NPermute in 1..Cartes'Length loop

         -- Choper deux cartes à permuter
         Carte1 := Int_Aleatoire.Random(Graine) mod Cartes'Length ;
         Carte2 := Int_Aleatoire.Random(Graine) mod Cartes'Length ;

         if Carte2 = Carte1 then
            Carte2 := (Carte1 + 1) mod Cartes'Length ;
         end if ;

         Carte1 := Cartes'First + Carte1 ;
         Carte2 := Cartes'First + Carte2 ;

         -- Permuter
         ZoCarte := Cartes(Carte1) ;
         Cartes(Carte1) := Cartes(Carte2) ;
         Cartes(Carte2) := ZoCarte ;
      end loop ;
   end Melanger ;

   procedure Afficher_Carte(Carte : T_Carte) is
   begin
      case Carte.Valeur is
         when 1 => Txt.Put("As") ;
         when 2..10 => Txt.Put(Integer'Image(Carte.Valeur)) ;
         when 11 => Txt.Put("Valet") ;
         when 12 => Txt.Put("Dame") ;
         when 13 => Txt.Put("Roi") ;
         when others => Txt.Put("Valeur inconnue !") ;
      end case ;

      case Carte.Couleur is
         when Trefle  => Txt.Put_Line(" de Trefle") ;
         when Pique   => Txt.Put_Line(" de Pique") ;
         when Coeur   => Txt.Put_Line(" de Coeur") ;
         when Carreau => Txt.Put_Line(" de Carreau") ;
      end case ;
   end Afficher_Carte ;


end Jeu_De_Cartes ;

