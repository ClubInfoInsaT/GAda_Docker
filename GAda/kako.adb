with GAda.Core ;

package body Kako is

   Package Txt renames GAda.Core ;

   Max_Contacts : constant Integer := 7 ;

   function NB_Contact return Integer is
   begin
      return Max_Contacts ;
   end NB_Contact ;

   procedure Check_Contact (Call: String ; Id : Integer) is
   begin
      if Id < 1 or Id > Max_Contacts then
         Txt.Put_Err("Appel a '" & Call & "' avec un numero de contact inconnu : " & Integer'Image(Id)) ;
         raise Program_Error ;
      end if ;
   end Check_Contact ;

   function Nom_Contact (Id: Integer) return String is
   begin
      Check_Contact("Nom_Contact", Id) ;
      case Id is
         when 1 => return "Barack" ;
         when 2 => return "Kate" ;
         when 3 => return "Carla" ;
         when 4 => return "Britney" ;
         when 5 => return "Sinclair" ;
         when 6 => return "Franck" ;
         when 7 => return "Dionysos" ;
         when others => return "[ERREUR - Numero de contact inconnu : " & Integer'Image(Id) & "]" ;
      end case ;

   end Nom_Contact ;

   type T_Selections is array (1..Max_Contacts) of Boolean ;
   Selectionnes : T_Selections := (others => False) ;

   procedure Selectionner_Contact(Id : Integer) is
   begin
      Check_Contact("Selectionner_Contact", Id) ;
      Selectionnes(Id) := True ;
   end Selectionner_Contact ;

   function Est_Selectionne(Id : Integer) return Boolean is
   begin
      Check_Contact("Est_Selectionne", Id) ;
      return Selectionnes(Id) ;
   end Est_Selectionne ;

   procedure Envoyer_SMS_Contact (Id_Contact : Integer ; Message : String) is
   begin
      Check_Contact("Envoyer_SMS_Contact", Id_contact) ;
      Txt.Put_Line ("SMS envoye a " & (Nom_Contact(Id_Contact)) & " : " & Message) ;
   end Envoyer_SMS_Contact ;


   function Distance(Num_SIM : in Integer) return T_Distance is
   begin
      if Num_SIM < 100000 then
         Txt.Put_Err("Appel a 'Distance' avec un numero qui n'est pas un numero de carte SIM : " &
                     Integer'Image(Num_SIM)) ;
         raise Program_Error ;
      end if ;
      if Num_SIM mod 3 = 0 then return (False, -1.0) ;
      else return (True, Float(Num_SIM - 100000)**3/113.0) ;
      end if ;
   end Distance ;

   function SIM_Contact(Id : Integer) return Integer is
   begin
      Check_Contact("SIM_Contact", Id) ;
      return 100000 + ((Id * Id * 91) mod 71) ;
   end SIM_Contact ;


end Kako ;
