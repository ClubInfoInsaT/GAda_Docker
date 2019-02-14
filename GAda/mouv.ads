
package Mouv is

   -- Une position sur le plan.
   -- L'axe des Y est vers le haut.
   type T_Pos is record
      X : Integer ;
      Y : Integer ;
   end record ;

   -- Quatre directions possibles.
   -- None signifie "pas de direction".
   type T_Direction is (Up, Down, Left, Right, None) ;

   -- Une séquence de mouvements.
   type T_Sequence is array(Integer range <>) of T_Direction ;

end Mouv ;

