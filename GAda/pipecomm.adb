--
-- Principe du protocole :
-- Chaque paquet envoyé (par flush) est de la forme
--   MARK_DEBUT | TAILLE DES DONNEES | DONNEES | MARK_FIN
--    1B             5B                  nB        1B
--
-- Les entiers sont sur 5B : signe puis valeur absolue en little-endian
-- (ben oui, Ada c'est vachement pas pratique pour manipuler les bits)
--

with Ada.Streams ;
use Ada.Streams ;

with Ada.Text_IO ;
with Interfaces ; use Interfaces ;

with Ada.Interrupts, Ada.Interrupts.Names ;

package body PipeComm is

   Init_Msg : constant String := "CAML-Air Protocol" ;

   package S renames Ada.Streams.Stream_IO ;
   package Txt renames Ada.Text_IO ;

   subtype SEA   is Ada.Streams.Stream_Element_Array ;
   subtype Index is Ada.Streams.Stream_Element_Offset ;

   Mark_Debut : constant Byte := 50 ;
   Mark_Fin   : constant Byte := 51 ;

   Taille_Entete : constant := 6 ;

   -- La taille des tampons doit être suffisamment grande pour les plus grands paquets
   -- (on ne s'amuse pas à découper les paquets trop grands, tant pis c'est comme ça)
   Buffer_IN  : SEA(1..50000) ; -- 50KB
   Buffer_OUT : SEA(1..50000) ; -- 50KB

   Last_In   : Index ; -- Dernier élément inséré dans Buffer_IN
   Paquet_In : Index ; -- Position du marqueur de fin du paquet courant (index_in)
   Index_In  : Index ; -- Curseur de lecture
   Index_Out : Index ;

   Chin      : S.File_Type ;
   Chout     : S.File_Type ;

   Capture_Sigpipe : Boolean := False ;

   procedure Init_Sigpipe is
   begin
      if not Capture_Sigpipe then
         Ada.Interrupts.Detach_Handler (Ada.Interrupts.Names.SIGPIPE) ;
         Capture_Sigpipe := True ;
      end if ;
   end Init_Sigpipe ;

   --
   procedure Init_IN  (Name : String) is
   begin
      Init_Sigpipe ;
      Index_In := 1 ;
      Last_In := 0 ;
      Paquet_In := 1 ;
      Txt.Put ("Ouverture du pipe IN '" & Name & "'  ...  ") ;
      S.Open(Chin, S.In_File, Name) ;

      --Txt.Put ("Receive....") ;
      Receive ;
      --Txt.Put_Line ("OK") ;

      declare
         Msg : String := Get ;
      begin
         if msg /= init_msg then
            Txt.Put_Line ("Pipecomm.Init_in: message recu = " & Msg & " au lieu de " & Init_Msg) ;
            raise Program_Error ;
         end if ;
      end ;


      Txt.Put_Line ("OK") ;
   end Init_IN ;

   --
   procedure Start is
   begin
      -- Oui, c'est inutile de le faire à chaque fois, mais c'est comme ça aussi.
      Buffer_Out(1) := Mark_Debut ;
      Index_Out := Taille_Entete + 1 ;
   end Start ;

   --
   procedure Init_OUT (Name : String) is
   begin
      Init_Sigpipe ;
      Index_Out := 0 ;
      Txt.Put ("Ouverture du pipe OUT '" & Name & "'  ...  ") ;
      S.Open(Chout, S.Out_File, Name) ;
      Start ;

      Put (Init_Msg) ;
      Flush ;
      Txt.Put_Line ("OK") ;
   end Init_OUT ;

   --
   procedure Close is
   begin
      S.Close(Chin) ;
      S.Close(Chout) ;
   end Close ;

   --
   procedure Put_Byte (X : Byte) is
   begin
      Buffer_Out(Index_Out) := X ;
      Index_Out := Index_Out + 1 ;
   end Put_Byte ;

   --
   procedure Flush is
      Length_Data : Index := Index_Out - Taille_Entete - 1 ;
      Last : Index ;
   begin
      Put_Byte(Mark_Fin) ;
      Last := Index_Out - 1 ;
      Index_Out := 2 ;
      Put(Integer(Length_Data)) ;
      S.Write (Chout, Buffer_Out(1..Last)) ;
      S.Flush (Chout) ;
      --Txt.Put_Line("Un paquet de " & Integer'Image(Integer(Last)) & " octets envoyés !") ;
      Start ;
   end Flush ;

   --
   procedure Put (X : Boolean) is
   begin
      if X then Put_Byte(1) ; else Put_Byte(0) ; end if ;
   end Put ;

   -- 1 octet pour le signe : -0-  +1+
   -- 4 octets pour la valeur absolue, little endian
   procedure Put (X : Integer) is
      Reste : Integer ;
      Val   : Byte ;
   begin
      if X < 0 then
         Reste := -X ;
         Put_Byte (0) ; -- Negatif
      else
         Reste := X ;
         Put_Byte (1) ; -- Positif
      end if ;

      pragma Assert(Reste >= 0) ;

      for I in 1..4 loop
         Val := Byte(Reste mod 256) ;
         Reste := Reste / 256 ;
         Put_Byte(Val) ;
      end loop ;
   end Put ;

   pragma Assert (Float'Machine_Radix = 2) ;

   -- En caml un int a 30 bits (sans le signe)
   Precision : constant := Float(2**29) ;

   -- deux entiers : la fraction * precision, puis l'exposant
   procedure Put (X : Float) is
      Frac : Float ;
   begin
      Frac := Float'Fraction(X) ;
      Put(Integer(Float'Rounding(Frac * Precision))) ;
      Put(Float'Exponent(X)) ;
   end Put ;

   --
   procedure Put (X : Character) is
   begin
      Put_Byte(Character'Pos(X)) ;
   end Put ;

   -- 2 octets pour la longueur (little endian)
   -- puis les caractères

   -- Génériques
   procedure Put_Pair (PP : Pr) is
   begin
      Put1 (Get1(PP)) ;
      Put2 (Get2(PP)) ;
   end Put_Pair ;

   procedure Put_Array (X : Ta) is
      Length : Natural := X'Length ;
      Hi : Byte ;
      Lo : Byte ;
   begin
      -- Txt.Put_Line ("Envoi d'un tableau de taille " & Integer'Image(Length)) ;
      Lo := Byte(Length mod 256) ;
      Hi := Byte(Length / 256) ;
      Put_Byte(Lo) ;
      Put_Byte(Hi) ;
      for I in X'Range loop
         PutT(X(I)) ;
      end loop ;
   end Put_Array ;

   procedure Put_String is new Put_Array(Character, String, Put) ;
   procedure Put (X : String) renames Put_String ;


   procedure Put_Int_Array is new Put_Array(Integer, Ints, Put) ;
   procedure Put_Ints (X : Ints) renames Put_Int_Array ;

   procedure Put_Float_Array is new Put_Array(Float, Floats, Put) ;
   procedure Put_Floats (X : Floats) renames Put_Float_Array ;

   procedure Put_Bool_Array is new Put_Array(Boolean, Bools, Put) ;
   procedure Put_Bools (X : Bools) renames Put_Bool_Array ;

   --
   function Get_Byte return Byte is
      Val : Byte := Buffer_In(Index_In) ;
   begin
      pragma Assert (Index_In <= Paquet_In) ;
      Index_In := Index_In + 1 ;
      -- Txt.Put_Line ("Byte Lu : " & Byte'Image(Val)) ;
      return Val ;
   end Get_Byte ;

   function Min (A : Index ; B : Integer) return Index is
   begin
      if Integer(A) < B then return A ;
      else return Index(B) ;
      end if ;
   end Min ;

   -- Garantit que N octets sont disponibles en lecture.
   procedure Remplir (N : Integer) is
      Disponibles : Integer ;
      Stockage    : Integer ;
      Last        : Index ;
      Recus       : Integer ;
      Decalage    : Index ;
      Expected_End : Index ;
   begin
      Disponibles := Integer(Last_In - Index_In + 1) ;
      -- Optimisation
      if Disponibles = 0 then
         Last_In := 0 ;
         Index_In := 1 ;
         Paquet_In := 1 ;
      end if ;

      -- Txt.Put_Line ("Disponibles : " & Integer'Image(Disponibles) & "    Voulus : " & Integer'Image(N)) ;
      if Disponibles < N then
         -- Il faut remplir...
         -- A-t-on seulement la place de stockage ?
         Stockage := Integer(Buffer_In'Last - Last_In) ;

         if N - Disponibles > Stockage then
            -- Crotte, il faut tout décaler
            -- Txt.Put_Line ("Youpi, un décalage !") ;
            -- On remet Index_In en 1 (on efface ce qui est avant)
            Decalage := Index_In - 1 ;
            for X in Index_In..Last_In loop
               Buffer_In(X - Decalage) := Buffer_In(X) ;
            end loop ;
            Index_In := 1 ; -- == Index_In - Decalage
            Last_In := Last_In - Decalage ;
         end if ;

         --Txt.Put_Line ("Read.") ;

         Expected_End := Min (Buffer_In'Last, Integer(Index_In) + N - 1) ;

         -- Attention, sur un pipe,
         -- cet abruti se croit obligé de remplir complètement le buffer.
         S.Read (Chin, Buffer_In(Last_In+1 .. Expected_End), Last) ;

         -- Combien en a-t-on récupéré ?
         Recus := Integer(Last - Last_In) ;
         --Txt.Put_Line("Recus : " & Integer'Image(Recus)) ;

         -- Si recus <= 0, c'est probablement un broken pipe.
         if Recus <= 0 then raise Program_Error ; end if ;
         Last_In := Last ;

         -- On recommence jusqu'à être sûr qu'on en a assez
         -- Garantie de terminaison : 'Disponibles' est strictement croissant
         Remplir(N) ;

      else
         -- Rien à faire il y a tout ce qu'il faut.
         null ;
      end if ;
   end Remplir ;

   procedure Receive is
      Length : Integer ;
      Mark   : Byte ;
   begin
      -- On vérifie que l'on a tout lu du paquet précédent.
      if Index_In /= Paquet_In then raise Program_Error ; end if ;

      -- On vérifie qu'il y a bien la marque de fin
      if Last_In > 0 then
         if Get_Byte /= Mark_Fin then raise Program_Error ; end if ;
      end if ;

      Remplir(Taille_Entete + 1) ;
      -- En attendant de connaître la taille, position provisoire de la fin du paquet.
      Paquet_In := Last_In ;

      Mark := Get_Byte ;
      pragma Assert (Mark = Mark_Debut) ;
      Length := Get + 1 ; -- +1 pour la marque finale
      -- Txt.Put_Line (Integer'Image(Length) & " octets voulus.") ;
      Remplir(Length) ;
      Paquet_In := Index_In + Index(Length) - 1 ;
      if Buffer_In(Paquet_In) /= Mark_Fin then raise Program_Error ; end if ;
   end Receive ;

   --
   function Get return Boolean is
   begin
      return Get_Byte = 1 ;
   end Get ;

   --
   function Get return Integer is
      Sign : Byte ;
      Val  : Integer ;
      Mul  : Integer ;
   begin
      Sign := Get_Byte ;
      Val := 0 ;
      Mul := 1 ;
      for I in 1..4 loop
         Val := Val + Mul * Integer(Get_Byte) ;
         Mul := Mul * 256 ;
      end loop ;
      if Sign = 0 then Val := - Val ;
      end if ;
      return Val ;
   end Get ;

   --
   function Get return Float is
      IFrac : Integer ;
      Frac : Float ;
      Exp  : Integer ;
   begin
      IFrac := Get ;
      Frac := Float(IFrac) / Precision ;
      Exp  := Get ;
      return Float'Compose(Frac, Exp) ;
   end Get ;

   --
   function Get return Character is
   begin
      return Character'Val(Get_Byte) ;
   end Get ;

   --
   function Get_Array return Ta is
      Length : Integer ;
      Hi, Lo : Byte ;
   begin
      Lo := Get_Byte ;
      Hi := Get_Byte ;
      Length := Integer(Lo) + Integer(Hi) * 256 ;
      declare
         Result : Ta(1..Length) ;
      begin
         for I in Result'Range loop
            Result(I) := GetT ;
         end loop ;
         return Result ;
      end ;
   end Get_Array ;

   function Get_String is new Get_Array(Character, String, Get) ;
   function Get return String renames Get_String ;
   function SGet return String renames Get_String ;

   function Get_Pair return Pr is
      PP : Pr ;
   begin
      Set1 (PP, Get1) ;
      Set2 (PP, Get2) ;
      return PP ;
   end Get_Pair ;

   function Get_Int_Array is new Get_Array(Integer, Ints, Get) ;
   function Get_Ints return Ints renames Get_Int_Array ;

   function Get_Float_Array is new Get_Array(Float, Floats, Get) ;
   function Get_Floats return Floats renames Get_Float_Array ;

   function Get_Bool_Array is new Get_Array(Boolean, Bools, Get) ;
   function Get_Bools return Bools renames Get_Bool_Array ;

end PipeComm ;
