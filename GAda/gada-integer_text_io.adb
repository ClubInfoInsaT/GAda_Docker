with Ada.Integer_Text_IO;
with GAda.Text_IO;

package body GAda.Integer_Text_IO is
	function FGet return Integer is
		Result,Last : Integer;
		begin
			declare
	 	 		Tape : constant String := GAda.Text_IO.FGet ;
      	begin
         if Tape'Length = 0 then return FGet ;
         elsif Tape="(plus de lignes)" then return 0;
				 else
            Ada.Integer_Text_IO.Get(Tape, Result, Last) ;
            return Result ;
         end if ;
      exception when others =>
--         GAda.Text_IO.Put("Erreur, ce n'est pas un entier : " & Tape) ;
         -- Pour brouiller les pistes et virer le warning.
         if 1 = 1 then return FGet ;
         else return FGet ;
         end if ;
			end;
	end FGet;

	procedure Put(Aff: in Integer) is 
		begin
			GAda.Text_IO.Put(Integer'Image(Aff));
	end Put;
	
	procedure Get(Item : out Integer) is
		begin
		Item:=FGet;
	end Get;
end GAda.Integer_Text_IO;
