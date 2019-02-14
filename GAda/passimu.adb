with GAda.Core ;

package body Passimu is

   Package Txt renames GAda.Core ;

   Fatal_Error : exception ;

   En_Simu : Boolean := False ;
   En_Reel : Boolean := False ;

   procedure Erreur is
   begin
      Txt.Put_Err ("Erreur : vous ne devez pas mélanger l'acteur SIMULATION avec les autres acteurs INSA-Air.") ;
      raise Fatal_Error ;
   end Erreur ;

   procedure Simu is
   begin
      En_Simu := True ;
      if En_Reel then Erreur ;
      end if ;
   end Simu ;

   procedure Reel is
   begin
      En_Reel := True ;
      if En_Simu then Erreur ;
      end if ;
   end Reel ;


end Passimu ;
