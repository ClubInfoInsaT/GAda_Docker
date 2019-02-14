with Pipecomm ;
with GAda.Core ;
with Ada.Command_Line ;

package body Pipestub is

   package P renames Pipecomm ;
   package Txt renames GAda.Core ;

   Connected : Boolean := False ;

   procedure CheckInit is
   begin
      if not Connected then

         if Ada.Command_Line.Argument_Count /= 2 then
            Txt.New_Line ;
            Txt.Put_Err ("Pour exécuter votre programme, vous devez le télécharger") ;
            Txt.Put_Err (" sur l'ordinateur embarqué à bord de l'avion.") ;
            Txt.Put_Err ("Pour cela, cliquez sur l'exécutable 'upload-exe' (cf. le sujet du TP)") ;
            Txt.New_Line ;
            raise Program_Error ;
         else
            Pipecomm.Init_out(Ada.Command_Line.Argument (1)) ;
            Pipecomm.Init_in(Ada.Command_Line.Argument (2)) ;
         end if ;

         Connected := True ;
      end if ;

   end CheckInit ;

   procedure Tail is
      One : Character  ;
      NI, NJ : Integer ;
   begin
      P.Receive ;

      One := P.Get ;
      if One /= '1' then raise ProtocolError ;
      end if ;

      NI := P.Get ;
      for I in 1..NI loop
         Txt.Put_Line (P.SGet) ;
      end loop ;

      NJ := P.Get ;
      if NJ > 0 then Txt.Put_Err ("") ; end if ;
      for J in 1..NJ loop
         Txt.Put_Err (P.SGet) ;
      end loop ;

      if NJ > 0 then
         Txt.Put_Err ("") ;
         raise Program_Error ;
      end if ;

   end Tail ;

end Pipestub ;
