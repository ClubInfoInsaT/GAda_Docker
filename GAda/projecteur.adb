with GAda.Text_IO ;

package body Projecteur is

   package Txt renames GAda.Text_IO ;

   Compteur_Pub : Integer := 0 ;

   function Combien_Pubs return Integer is
   begin
      return Compteur_Pub ;
   end Combien_Pubs ;

   procedure Pub (Nb : Integer) is
   begin
      for I in 1..Nb loop
         Txt.Put ("Projection de la PUB ") ;

         case Compteur_Pub mod 7 is
            when 0 => Txt.Put_Line ("Burger King.") ;
            when 1 => Txt.Put_Line ("Atos Origin.") ;
            when 2 => Txt.Put_Line ("Unilog.") ;
            when 3 => Txt.Put_Line ("Capgemini.") ;
            when 4 => Txt.Put_Line ("Sopra Group.") ;
            when 5 => Txt.Put_Line ("FNAC.") ;
            when 6 => Txt.Put_Line ("FACOM.") ;
            when others => Txt.Put_Line ("Pepsi.") ;
         end case ;
         delay (0.6) ;

         Compteur_Pub := Compteur_Pub + 1 ;
      end loop ;
   end Pub ;


   Compteur_Annonce : Integer := 0 ;

   procedure Annonce (Nb : Integer) is
   begin
      for I in 1..Nb loop
         Txt.Put ("Projection de la BANDE-ANNONCE de : ") ;

         case Compteur_Annonce mod 6 is
            when 0 => Txt.Put_Line ("Les rois de la glisse") ;
            when 1 => Txt.Put_Line ("Le rêve de Cassandre") ;
            when 2 => Txt.Put_Line ("Stardust le mystère de l'étoile") ;
            when 3 => Txt.Put_Line ("Bienvenue chez les Robinson") ;
            when 4 => Txt.Put_Line ("Ratatouille") ;
            when 5 => Txt.Put_Line ("Après l'Hégémonie") ;
            when others => Txt.Put_Line ("Spiderman 6") ;
         end case ;
         delay (0.6) ;

         Compteur_Annonce := Compteur_Annonce + 1 ;
      end loop ;
   end Annonce ;

   procedure Producteur is
   begin
      Txt.Put_Line ("Projection du logo du producteur : Buena Vista International") ;
      delay (0.6) ;
   end Producteur;

   procedure Film is
   begin
      Txt.Put_Line ("Projection du film <<Le Premier Cri>>") ;
      delay (0.6) ;
   end Film ;

   procedure Generique is
   begin
      Txt.Put_Line ("Projection du générique de fin.") ;
      delay (0.6) ;
   end Generique ;


end Projecteur ;
