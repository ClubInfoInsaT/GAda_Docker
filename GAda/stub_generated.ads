with Pipecomm ;

package Stub_generated is 

   package P renames Pipecomm ;

   procedure Check ;

   Delai : Duration := 0.030000 ;

   type T_Pair1 is record
      T_Pair1_fst : Float ;
      T_Pair1_snd : Float ;
   end record ;

    procedure Put_T_Pair1 (X : T_Pair1) ;
    function  Get_T_Pair1 return T_Pair1 ;

   -- Fonctions et procédures utiles 

   function  Test_Fingerprint  return Integer ;
   procedure AA_Roulage  ;
   procedure AA_Decollage  ;
   procedure AA_Atterrissage  ;
   procedure Pivoter_Train_Avant (X1 : Float) ;
   procedure Mvt_Train (X1 : Boolean) ;
   function  Vol_Carburant  return Float ;
   procedure Brancher_Tuyau  ;
   procedure Debrancher_Tuyau  ;
   procedure Ouvrir_Vanne  ;
   procedure Fermer_Vanne  ;
   procedure Decoller  ;
   procedure Atterrir  ;
   procedure Rouler_Vers (X1 : Character) ;
   procedure Parcourir_Piste  ;
   procedure Freiner  ;
   procedure Regler_Reacteur (X1 : Integer) ;
   function  Cap  return Float ;
   procedure Nom_Compagnie (X1 : String) ;
   procedure Incliner_Gouverne (X1 : Float) ;
   procedure Attendre (X1 : Float) ;
   procedure Marquer (X1 : Float ; X2 : Float) ;
   function  Coords_Avion  return T_Pair1 ;

end Stub_generated ;
