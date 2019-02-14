--
-- Cet acteur est disponible sur les serveurs KakoPhone
--
package Serv is

   type T_Coords is record
      Longitude : Float ;
      Latitude  : Float ;
   end record ;

   -- Renvoie le numéro de la station de base où la carte SIM indiquée s'est connectée en dernier.
   function Station_Connectee (SIM : Integer) return Integer ;

   -- Renvoie les coordonnées de la station de base
   function Coordonnees (No_Station : Integer) return T_Coords ;

   -- Indique si l'étiquette indiquée est considérée perdue
   function Perdue (No_Etiquette : Integer) return Boolean ;

   -- Donne l'email du propriétaire de l'étiquette
   function Adresse (No_Etiquette : Integer) return String ;

   -- Envoie un email au destinataire indiqué
   procedure Email (Destinataire : String ; Message : String) ;

   -- Transforme un réel en chaîne de caractères sans exposant
   -- (à la différence de Float'Image qui met toujours un exposant).
   function Image (Arg : Float) return String ;


end Serv ;


