--
-- Cet acteur permet de lire des fichiers contenant un génome
-- ou contenant une séquence d'acides aminés.
--

package Genome is

   -- Une base ADN et une séquence ADN
   type T_Base is (A, C, G, T) ;
   type T_Sequence_ADN is array (Integer range <>) of T_Base ;


   -- Un acide aminé et une séquence d'AA
   type T_AA is (Ala, Lys, Arg, Met, Asn, Phe, Asp, Pro, Cys, Sec, Gln,
                  Ser, Glu, Thr, Gly, Trp, His, Tyr, Ile, Val, Leu, Inconnu) ;

   type T_Sequence_AA is array (Integer range <>) of T_AA ;


   -- Lit un fichier d'ADN et renvoie son contenu (le tableau commence à 1)
   function Lire_ADN (Nom_Fichier : String) return T_Sequence_ADN ;

   -- Lit un fichier d'acide aminés et renvoie son contenu (le tableau commence à 1)
   function Lire_AA (Nom_Fichier : String) return T_Sequence_AA ;

end Genome ;




