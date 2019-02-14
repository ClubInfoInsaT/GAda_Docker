with Ada.Text_IO ;
with PipeStub ;

package body Stub_generated is 

   package Txt renames Ada.Text_IO ;

    function RFst_T_Pair1 (X : T_Pair1) return Float is
    begin
       return X.T_Pair1_fst ;
    end RFst_T_Pair1 ;

    function RSnd_T_Pair1 (X : T_Pair1) return Float is
    begin
       return X.T_Pair1_snd ;
    end RSnd_T_Pair1 ;

    procedure WFst_T_Pair1 (X : out T_Pair1 ; V : Float) is
    begin
       X.T_Pair1_fst := V ;
    end WFst_T_Pair1 ;

    procedure WSnd_T_Pair1 (X : out T_Pair1 ; V : Float) is
    begin
       X.T_Pair1_snd := V ;
    end WSnd_T_Pair1 ;

    procedure Put_T_Pair1_x is new P.Put_Pair (Float, Float, T_Pair1, RFst_T_Pair1, RSnd_T_Pair1, P.Put, P.Put) ;
    procedure Put_T_Pair1 (X : T_Pair1) renames Put_T_Pair1_x ;

    function Get_T_Pair1_x is new P.Get_Pair (Float, Float, T_Pair1, WFst_T_Pair1, WSnd_T_Pair1, P.Get, P.Get) ;
    function Get_T_Pair1 return T_Pair1 renames Get_T_Pair1_x;


   -- Fonctions et procédures utiles 

   function  Test_Fingerprint  return Integer is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2001) ;
      P.Flush ;
      PipeStub.tail ;
      return P.Get ;
   end Test_Fingerprint ;

   procedure AA_Roulage  is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2002) ;
      P.Flush ;
      PipeStub.tail ;
   end AA_Roulage ;

   procedure AA_Decollage  is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2003) ;
      P.Flush ;
      PipeStub.tail ;
   end AA_Decollage ;

   procedure AA_Atterrissage  is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2004) ;
      P.Flush ;
      PipeStub.tail ;
   end AA_Atterrissage ;

   procedure Pivoter_Train_Avant (X1 : Float) is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2005) ;
      P.Put (X1) ;
      P.Flush ;
      PipeStub.tail ;
   end Pivoter_Train_Avant ;

   procedure Mvt_Train (X1 : Boolean) is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2006) ;
      P.Put (X1) ;
      P.Flush ;
      PipeStub.tail ;
   end Mvt_Train ;

   function  Vol_Carburant  return Float is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2007) ;
      P.Flush ;
      PipeStub.tail ;
      return P.Get ;
   end Vol_Carburant ;

   procedure Brancher_Tuyau  is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2008) ;
      P.Flush ;
      PipeStub.tail ;
   end Brancher_Tuyau ;

   procedure Debrancher_Tuyau  is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2009) ;
      P.Flush ;
      PipeStub.tail ;
   end Debrancher_Tuyau ;

   procedure Ouvrir_Vanne  is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2010) ;
      P.Flush ;
      PipeStub.tail ;
   end Ouvrir_Vanne ;

   procedure Fermer_Vanne  is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2011) ;
      P.Flush ;
      PipeStub.tail ;
   end Fermer_Vanne ;

   procedure Decoller  is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2012) ;
      P.Flush ;
      PipeStub.tail ;
   end Decoller ;

   procedure Atterrir  is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2013) ;
      P.Flush ;
      PipeStub.tail ;
   end Atterrir ;

   procedure Rouler_Vers (X1 : Character) is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2014) ;
      P.Put (X1) ;
      P.Flush ;
      PipeStub.tail ;
   end Rouler_Vers ;

   procedure Parcourir_Piste  is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2015) ;
      P.Flush ;
      PipeStub.tail ;
   end Parcourir_Piste ;

   procedure Freiner  is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2016) ;
      P.Flush ;
      PipeStub.tail ;
   end Freiner ;

   procedure Regler_Reacteur (X1 : Integer) is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2017) ;
      P.Put (X1) ;
      P.Flush ;
      PipeStub.tail ;
   end Regler_Reacteur ;

   function  Cap  return Float is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2018) ;
      P.Flush ;
      PipeStub.tail ;
      return P.Get ;
   end Cap ;

   procedure Nom_Compagnie (X1 : String) is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2019) ;
      P.Put (X1) ;
      P.Flush ;
      PipeStub.tail ;
   end Nom_Compagnie ;

   procedure Incliner_Gouverne (X1 : Float) is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2020) ;
      P.Put (X1) ;
      P.Flush ;
      PipeStub.tail ;
   end Incliner_Gouverne ;

   procedure Attendre (X1 : Float) is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2021) ;
      P.Put (X1) ;
      P.Flush ;
      PipeStub.tail ;
   end Attendre ;

   procedure Marquer (X1 : Float ; X2 : Float) is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2022) ;
      P.Put (X1) ;
      P.Put (X2) ;
      P.Flush ;
      PipeStub.tail ;
   end Marquer ;

   function  Coords_Avion  return T_Pair1 is
   begin
      PipeStub.CheckInit ;
      P.Put ('0') ;
      P.Put (2023) ;
      P.Flush ;
      PipeStub.tail ;
      return Get_T_Pair1 ;
   end Coords_Avion ;

   procedure Check is
   begin
      if Test_Fingerprint /= 162460752 then raise PipeStub.BadFingerprint ;
      end if ;
   end Check ;


end Stub_generated ;
