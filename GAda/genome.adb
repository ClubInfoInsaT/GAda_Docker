with GAda.Text_IO ;

package body Genome is

   package Txt renames GAda.Text_Io ;

   function Lire_ADN (Nom_Fichier : String) return T_Sequence_ADN is
      Result : T_Sequence_ADN(1..60) :=
        (A, C, C, A, G, T, A, C, C, C, A, C, C, T, G, G, T, A, C, C,
         C, G, T, T, A, T, T, T, G, C, C, A, A, C, G, T, T, A, G, C,
         C, T, G, A, A, C, A, T, C, G, T, A, T, C, G, G, T, A, C, C) ;
   begin
      Txt.Put_Line ("Le fichier " & Nom_Fichier & " n'est pas lu, j'utilise toujours la meme sequence ADN") ;

      return Result ;
   end Lire_ADN ;


   function Lire_AA (Nom_Fichier : String) return T_Sequence_AA is
      Result : T_Sequence_AA(1..8) :=
        (Thr, Trp, Tyr, Pro, Leu, Phe, Ala, Asn) ;
   begin
      Txt.Put_Line ("Le fichier " & Nom_Fichier & " n'est pas lu, j'utilise toujours la meme sequence d'acide amines") ;
      return Result ;
   end Lire_AA ;

end Genome ;
