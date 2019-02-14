with Passimu ;
with Stub_Generated ;
with GAda.Core ;
with Ada.Numerics.Elementary_Functions ;
with Ada.Numerics ;
with Ada.Calendar ; use Ada.calendar ;
with Airports ;
with Ada.Characters.Handling ;

package body Cartographie is

   package A renames Airports ;
   package S renames Stub_Generated ;
   package Txt renames GAda.Core ;
   package N renames Ada.Numerics.Elementary_Functions ;

   Eps : constant Float := 0.0001 ;
   DEps : constant Duration := 0.00001 ;
   Pi : constant Float := Ada.Numerics.Pi ;

   --
   -- Augmentation de la précision par interpolation
   --
   CXN : Float := 0.0 ;
   CYN : Float := 0.0 ;
   DeltaCX : Float := 0.0 ;
   DeltaCY : Float := 0.0 ;

   TimeN : Time := Time_Of(2000,1,1) ;
   DeltaT : Duration := 0.0 ;

   function Coords_Avion return T_Coords is
      Coords : S.T_Pair1 ;
      Result : T_Coords ;
      TimeN_1 : Time ;
      CXN_1 : Float ;
      CYN_1 : Float ;
   begin
      Passimu.Reel ;
      if (Clock - TimeN > S.Delai) or else Deltat < Deps then
         Coords := S.Coords_Avion ;
         Result := (Coords.T_Pair1_Fst, Coords.T_Pair1_Snd) ;

         CXN_1 := CXN ;
         CYN_1 := CYN ;
         TimeN_1 := TimeN ;

         CXN := Result.Long ;
         CYN := Result.Lat ;
         TimeN := Clock ;

         DeltaCX := CXN - CXN_1 ;
         DeltaCY := CYN - CYN_1 ;
         Deltat := TimeN - TimeN_1 ;
      else
         -- Interpole
         Result.Long := CXN + deltaCX * (Float(Clock - TimeN) / Float(Deltat)) ;
         Result.Lat  := CYN + deltaCY * (Float(Clock - TimeN) / Float(Deltat)) ;
         delay 0.004 ;
      end if ;

      return Result ;
   end Coords_Avion ;

   function Rad2Deg (A : Float) return Float is
   begin
      return A * 180.0 / Pi ;
   end Rad2deg ;

   function Cap_Vecteur (DX, DY : Float) return Float is
      Result : Float ;
   begin
      Result := Rad2Deg(N.ArcTan(DX, DY)) ;
      if Result < 0.0 then Result := Result + 360.0 ; end if ;
      return Result ;
   end Cap_Vecteur ;

   function SQRT (X : Float) return Float is
   begin
      if X < 0.0 then
         Txt.Put_Err ("Erreur : racine carrée d'un nombre négatif.") ;
         raise Program_Error ;
      end if ;
      
      return N.SQRT(X) ;
   end SQRT ;

   procedure Placer_Marque (Point : T_Coords) is
   begin
      S.Marquer (Point.Long, Point.Lat) ;
   end Placer_Marque ;


   function Trouve_Aeroport (Code : String) return Integer is
      NCode : String := Ada.Characters.Handling.To_Upper(Code) ;
   begin
      Passimu.Reel ;
      for I in A.Airports'First..A.Airports'Last - 1 loop
         if A.Airports(I).Oaci = NCode then return I ;
         end if ;
      end loop ;
      Txt.Put_Err ("L'aéroport " & NCode & " n'existe pas.") ;
      raise Program_Error ;
   end Trouve_Aeroport ;


   function Nom_Aeroport (Code : String) return String is
   begin
      return A.Airports(Trouve_Aeroport(Code)).Nom.all ;
   end Nom_Aeroport ;

   function Coords_Aeroport (Code : String) return T_Coords is
      Aero : A.Aeroport := A.Airports(Trouve_Aeroport(Code)) ;
   begin
      return (Aero.Long, Aero.Lat) ;
   end Coords_Aeroport ;

   function Nb_Aeroports return Integer is
   begin
      return A.Nb_Aeroports ;
   end Nb_Aeroports ;

   function Code_Aeroport (Numero : Integer) return String is
   begin
      if Numero <= 0 or Numero > A.Nb_Aeroports then
         Txt.Put_Err ("Il n'y a pas d'aéroport numéro " & Integer'Image(Numero)) ;
         raise Constraint_Error ;
      end if ;
      return A.Airports(Numero).Oaci ;
   end Code_Aeroport ;

   function Pays_Aeroport (Code : String) return String is
   begin
      return A.Airports(Trouve_Aeroport(Code)).Pays ;
   end Pays_Aeroport ;

end Cartographie ;
