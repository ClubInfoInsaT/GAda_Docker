--
-- Cet acteur permet de recevoir des signaux provenant des capteurs situés autour du bassin.
--
package Capteurs is

   -- Énumération des différentes sortes de capteurs
   -- |   Capteur\_Plot  : capteur situé sur le plot de départ
   -- |   Capteur\_Nord  : capteur situé à l'extrémité Nord du bassin
   -- |   Capteur\_Sud   : capteur situé à l'extrémité Sud  du bassin
   -- |   Signal\_Feu    : signal émis au moment du départ
   -- |   Bouton\_Fin    : bouton de fin de course, activé par l'arbitre
   type T_Capteur is (Capteur_Plot, Capteur_Nord, Capteur_Sud, Signal_Feu, Bouton_Fin) ;


   -- Un évènement est un signal émis par un capteur
   -- Numero est le numéro de couloir du capteur (pour les capteurs Plot, Nord, Sud)
   -- Date est la date de l'évènement, en secondes depuis minuit.
   type T_Evenement is record
      Emetteur : T_Capteur ;
      Num      : Integer ;
      Date     : Float ;
   end record ;


   -- Attend en bloquant le programme jusqu'à ce qu'un évènement se déclenche,
   -- et renvoie l'évènement qui s'est produit.
   -- Les évènements arrivent forcément dans l'ordre chronologique.
   function Attend_Signal return T_Evenement ;

end Capteurs ;
