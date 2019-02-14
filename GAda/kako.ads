package Kako is

   -- Retourne le nombre de contacts enregistrés dans son répertoire personnel
   function NB_Contact return Integer ;

   -- Retourne le nom du contact indiqué (1 <= Id <= Nb_Contact)
   function Nom_Contact (Id: Integer) return String ;

   -- Sélectionne le contact indiqué (1 <= Id <= Nb_Contact)
   procedure Selectionner_Contact(Id : Integer) ;

   -- Indique si le contact donné est sélectionné
   function Est_Selectionne(Id : Integer) return Boolean ;

   -- Envoie un SMS au contact indiqué
   procedure Envoyer_SMS_Contact (Id_Contact : Integer ; Message : String) ;


   type T_Distance is record
      -- Indique si la localisation a réussi
      Trouve : Boolean ;

      -- Distance en mètres
      Dist : Float ;
   end record ;

   -- Localise un KakoPhone à partir de son numéro de carte SIM.
   -- Renvoie un record de type T_Distance donnant la distance
   -- du kakophone par rapport à soi-même.
   --
   -- Lorsque la localisation n'est pas possible (ce n'est pas un KakoPhone, ou
   -- la localisation n'a pas été autorisée par le propriétaire du KakoPhone)
   -- l'attribut Trouve vaut false. Sinon il vaut true.
   function Distance(Num_SIM : Integer) return T_Distance ;

   -- Renvoie le numéro SIM du contact indiqué (1 <= Id <= Nb_Contact)
   function SIM_Contact(Id : Integer) return Integer ;

end Kako ;

