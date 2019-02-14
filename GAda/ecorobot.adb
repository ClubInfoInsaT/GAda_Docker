with EKStub_Generated ;
with GAda.Core ;
with Ada.Numerics.Elementary_Functions ;
with Ada.Calendar ; use Ada.calendar ;

package body EcoRobot is

   package S renames EKStub_Generated ;
   package Txt renames GAda.Core ;
   package N renames Ada.Numerics.Elementary_Functions ;

   DEps : constant Duration := 0.00001 ;
   Eps : constant Float := 0.01 ;

   type T_Coords is record
      X : Integer ;
      Y : Integer ;
   end record ;

   procedure Attendre_Entree is
   begin
      Txt.Put_Line ("Appuyez sur entrée : [zappé pour accélérer]") ;
      declare
         -- S : String := Txt.FGet ;
      begin
         null ;
      end ;
   end Attendre_Entree ;

   Nb_Robots : Integer := S.Nb_Robots ;

   function Nombre_Robots return Integer is
   begin
      return Nb_Robots ;
   end Nombre_Robots ;

   function Scan (X, Y : Integer) return Character renames S.Scan ;

   function Etat (Numero : Integer) return Integer renames S.Etat ;

   function Robot_Content (Num : Integer) return Boolean is
   begin
      return Etat(Num) = 2 ;
   end Robot_Content ;

   function Nb_Robots_Contents return Integer renames S.Nb_Contents ;

   function Energie (Numero : Integer) return Integer renames S.Energie ;

   function Loc_Robot (Numero : Integer) return T_Coords is
      Res : S.T_Pair1 := S.Loc_Robot (Numero) ;
   begin
      return (Res.T_Pair1_Fst, Res.T_Pair1_Snd) ;
   end Loc_Robot ;

   function Preferences (Num : Integer) return T_Preference is
      Res : S.T_Pair2 := S.Prefs (Num) ;
   begin
      return (Res.T_Pair2_Fst.T_Pair1_Fst,
              Res.T_Pair2_Fst.T_Pair1_Snd,
              Res.T_Pair2_Snd.T_Pair1_Fst,
              Res.T_Pair2_Snd.T_Pair1_Snd) ;
   end Preferences ;

   function Abscisse (Num : Integer) return Integer is
   begin
      return Loc_Robot (Num).X ;
   end Abscisse ;

   function Ordonnee (Num : Integer) return Integer is
   begin
      return Loc_Robot (Num).Y ;
   end Ordonnee ;

   -- Renvoie les coordonnées d'une cible du plateau
   Ll_Cible : T_Coords ;
   Ll_Cible_Ok : Boolean := False ;

   function Loc_Cible return T_Coords is
   begin
      if Ll_Cible_Ok then return Ll_Cible ;
      end if ;

      declare
         Res : S.T_Pair1 := S.Loc_Cible ;
      begin
         Ll_Cible := (Res.T_Pair1_Fst, Res.T_Pair1_Snd) ;
         Ll_Cible_Ok := True ;
         return Ll_Cible ;
      end ;
   end Loc_Cible ;

   procedure Step (Num : Integer ; X, Y : Integer) is
   begin
      Txt.Put_Line ("Déplacement du robot numéro " & Integer'Image(Num) & " vers la case " &
                    Integer'Image(X) & ", " & Integer'Image(Y)) ;
      S.Step (Num, X, Y) ;
   end Step ;

   function SQRT (X : Float) return Float renames N.SQRT ;

   procedure Depose_PostIt (Num : Integer ; PostIt : T_PostIt) is
      P : T_Postit := Postit ;
   begin
      S.Put_Postit (Num, (((P.BooA,P.BooB),(P.BooC,P.BooD)),(P.IVal,P.Cval))) ;
   end Depose_Postit ;


   function Lit_Postit (Num : Integer) return T_Postit Is
      Res : S.T_Pair6 := S.Lit_Postit(Num) ;
   begin
      return (Res.T_Pair6_Fst.T_Pair4_Fst.T_Pair3_Fst,
              Res.T_Pair6_Fst.T_Pair4_Fst.T_Pair3_Snd,
              Res.T_Pair6_Fst.T_Pair4_Snd.T_Pair3_Fst,
              Res.T_Pair6_Fst.T_Pair4_Snd.T_Pair3_Snd,
              Res.T_Pair6_Snd.T_Pair5_Fst,
              Res.T_Pair6_Snd.T_Pair5_Snd) ;
   end Lit_Postit ;


begin
   S.Check ;
end EcoRobot ;
