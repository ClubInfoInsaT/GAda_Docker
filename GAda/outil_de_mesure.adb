
with Ada.Numerics.Float_Random;
use Ada.Numerics.Float_Random;

package body Outil_De_Mesure is
   
   Largeur_Normale : constant Float := 23.7 ; 
   Hauteur_Normale : constant Float := 600.0 ; 
   Longueur_Normale : constant Float := 852.4 ; 
   
   Erreur : constant Float := 0.60;

   Gen : Generator;

   -- Renvoie la i-ème dimension du produit dans le tapis, en mm
   -- I=1 correponds à la largeur, I=2 à la hauteur et I=3 à la profondeur
   Function Dim(I: Integer) return Float is
      Resultat : Float;
   begin
      -- On centre la valeur sur la mesure normale
      -- La valeur retournée est entre mesure-(erreur/2.0) et mesure+(erreur/2.0)
      -- Random renvoie un float entre 0 et 1
      case I is
	 when 1 =>
	    Resultat := Longueur_Normale - (Erreur/2.0) + Random(Gen)*Erreur;
	 when 2 =>
	    Resultat := Hauteur_Normale - (Erreur/2.0) + Random(Gen)*Erreur;
	 when 3=>
	    Resultat := Largeur_Normale - (Erreur/2.0) + Random(Gen)*Erreur;
	 when others =>
	    Resultat:=0.0;
      end case;
      
      return Resultat;
   end Dim;

begin
   Reset(gen);
end Outil_De_Mesure;
