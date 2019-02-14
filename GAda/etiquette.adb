with GAda.Text_IO ;

package body Etiquette is

   type T_Cases is array(1..Nb_Etiquettes) of Integer ;

   Memoire : T_Cases := (Others => -1) ;
   Initf : Boolean := False ;

   procedure Init is
   begin
      if not Initf then
         Initf := True ;
         for No in Memoire'Range loop
            Memoire(NO) := (No * 137 mod 3791) - 853 ;
         end loop ;
      end if ;
   end Init ;

   function Numero_Actif (No : Integer) return Boolean is
   begin
      Init ;
      return Memoire(No) >= 0 ;
   end Numero_Actif ;

   procedure Desactive (No : Integer) is
   begin
      Init ;
      Memoire(No) := -1 ;
   end Desactive ;

   function Age (No : Integer) return Integer is
      Age : Integer ;
   begin
      Init ;
      Age := Memoire(No) ;
      if Age < 0 then
         Age := 0 ;
      end if ;
      return Age ;
   end Age ;

end Etiquette ;
