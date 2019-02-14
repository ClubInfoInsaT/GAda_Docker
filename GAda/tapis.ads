package Tapis is


   -- Fait avancer le tapis de quelques centimètres
   procedure Avancer ;


   -- Renvoie Vrai si un produit se trouve dans la zone de mesure
   function Produit_Dans_Zone return Boolean ;


   -- Dirige le produit (présent dans la zone de mesure) vers la sortie normale si Poubelle est Faux
   --  ou vers la poubelle si Poubelle est Vrai
   procedure Aiguiller_Produit (Poubelle : Boolean) ;


   -- Renvoie Vrai s'il ne reste aucun produit sur le tapis, Faux s'il reste des produits
   function Est_Vide return Boolean ;


end Tapis ;

