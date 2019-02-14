package Pipestub is

   ProtocolError : exception ;
   BadFingerprint : exception ;

   procedure CheckInit ;

   -- Données récupérées en sortie du protocole
   procedure Tail ;

end Pipestub ;
