with GAda.Core ;
with Gada.Text_IO ;

package body Rois is

   package Txt renames GAda.Text_IO ;

   -- Compte les appels pour prévenir les boucles infinies.
   Nb_Appels : Integer := 0 ;

   Max_Appels : constant Integer := 10000 ;

   procedure Compte_Appel is
   begin
      Nb_Appels := Nb_Appels + 1 ;
      if Nb_Appels > Max_Appels then
         raise Gada.Core.Boucle_Infinie ;
      end if ;
   end Compte_Appel ;

   type T_Info is record
      V1 : access String ;
      V2 : Integer ;
      V3 : Integer ;
   end record ;

   type T_Objects is array(Integer range 1..72) of T_Info ;

   Objects : T_Objects :=
     ( (new String'("Clodion le Chevelu"), 429, 447),
       (new String'("Mérovée"), 447, 456),
       (new String'("Childéric Ier"), 457, 481),
       (new String'("Clovis Ier"), 481, 511),
       (new String'("Childebert Ier"), 511, 558),
       (new String'("Clotaire Ier le Vieux"), 558, 561),
       (new String'("Caribert Ier"), 561, 567),
       (new String'("Chilpéric Ier"), 567, 584),
       (new String'("Clotaire II le Jeune"), 584, 629),
       (new String'("Dagobert Ier"), 629, 639),
       (new String'("Clovis II le Fainéant"), 639, 657),
       (new String'("Clotaire III"), 657, 673),
       (new String'("Childéric II"), 673, 675),
       (new String'("Thierry III"), 675, 691),
       (new String'("Clovis IV"), 691, 695),
       (new String'("Childebert III"), 695, 711),
       (new String'("Dagobert III"), 711, 715),
       (new String'("Chilpéric II"), 715, 721),
       (new String'("Thierry IV"), 720, 737),
       (new String'("Charles Martel"), 737, 741),
       (new String'("Childéric III le Fainéant"), 743, 751),
       (new String'("Pépin le Bref"), 751, 768),
       (new String'("Charles Ier le Grand (Charlemagne)"), 768, 814),
       (new String'("Louis Ier le Débonnaire"), 814, 840),
       (new String'("Charles II le Chauve"), 843, 877),
       (new String'("Louis II le Bègue"), 877, 879),
       (new String'("Louis III"), 879, 882),
       (new String'("Carloman"), 879, 884),
       (new String'("Charles le Gros"), 884, 888),
       (new String'("Eudes (ou Odo)"), 888, 898),
       (new String'("Charles III le Simple"), 898, 922),
       (new String'("Robert Ier"), 922, 923),
       (new String'("Raoul (ou Rodolphe)"), 923, 936),
       (new String'("Louis IV d'Outremer"), 936, 954),
       (new String'("Lothaire IV"), 954, 986),
       (new String'("Louis V le Fainéant"), 986, 987),
       (new String'("Hugues Capet"), 987, 996),
       (new String'("Robert II le Pieux"), 996, 1031),
       (new String'("Henri Ier"), 1031, 1060),
       (new String'("Philippe Ier"), 1060, 1108),
       (new String'("Louis VI le Gros"), 1108, 1137),
       (new String'("Louis VII le Jeune"), 1137, 1180),
       (new String'("Philippe II Auguste"), 1180, 1223),
       (new String'("Louis VIII le Lion"), 1223, 1226),
       (new String'("Louis IX (Saint-Louis)"), 1226, 1270),
       (new String'("Philippe III le Hardi"), 1270, 1285),
       (new String'("Philippe IV le Bel"), 1285, 1314),
       (new String'("Louis X le Hutin"), 1314, 1316),
       (new String'("Jean Ier Posthume"), 1316, 1316),
       (new String'("Philippe V le Long"), 1316, 1322),
       (new String'("Charle IV le Bel"), 1322, 1328),
       (new String'("Philippe VI"), 1328, 1350),
       (new String'("Jean II le Bon"), 1350, 1364),
       (new String'("Charles V le Sage"), 1364, 1380),
       (new String'("Charles VI le Fol"), 1380, 1422),
       (new String'("Charles VII le Victorieux"), 1422, 1461),
       (new String'("Louis XI le Prudent"), 1461, 1483),
       (new String'("Charles VIII l'Affable"), 1483, 1498),
       (new String'("Louis XII"), 1498, 1515),
       (new String'("François Ier"), 1515, 1547),
       (new String'("Henri II"), 1547, 1559),
       (new String'("François II"), 1559, 1560),
       (new String'("Charles IX"), 1560, 1574),
       (new String'("Henri III"), 1574, 1589),
       (new String'("Henri IV"), 1589, 1610),
       (new String'("Louis XIII"), 1610, 1643),
       (new String'("Louis XIV"), 1643, 1715),
       (new String'("Louis XV"), 1715, 1774),
       (new String'("Louis XVI"), 1774, 1791),
       (new String'("Louis XVIII"), 1814, 1824),
       (new String'("Charles X"), 1824, 1830),
       (new String'("Louis-Philippe Ier"), 1830, 1848)
     ) ;

   function Nb_Objects return Integer is
   begin
      Compte_Appel ;
      return Objects'Length ;
   end Nb_Objects ;

   function Nb_Rois return Integer renames Nb_Objects ;

   procedure Check_Range (No : Integer ; Msg : String) is
   begin
      Compte_Appel ;
      if No not in Objects'Range then
         -- CHANGE (message d'erreur)
         GAda.Core.Put_Err("ERREUR : Appel de " & Msg & " avec un numéro de roi égal à " & Integer'Image(No) &
			     " alors que les rois sont numérotés de 1 à " & Integer'Image(Nb_Objects)) ;
         raise Program_Error ;
      end if ;
   end Check_Range ;

   function Debut (Roi : Integer) return Integer is
   begin
      Check_Range(Roi, "Debut") ;
      return Objects(Roi).V2 ;
   end Debut ;
   
   function Fin (Roi : Integer) return Integer is
   begin
      Check_Range(Roi, "Fin") ;
      return Objects(Roi).V3 ;
   end Fin ;

   function Nom (Roi : Integer) return String is
   begin
      Check_Range(Roi, "Nom") ;
      return " " & Objects(Roi).V1.all & " " ;
   end Nom ;

end Rois ;

