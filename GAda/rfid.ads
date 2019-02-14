--
-- Cet acteur permet de communiquer avec les puces RFID.
--
package RFID is

   -- Nombre de fréquences utilisées par nos émetteurs
   Nb_Frequences : constant Integer := 64 ;

   -- Retourne la fréquence en Hz correspondant au numéro de fréquence indiqué.
   -- Les fréquences sont numérotées de 1 à Nb_Frequences
   function Frequence (No_Frequence : Integer) return Float ;

   -- Indique si un signal est présent sur la fréquence donnée en Hz.
   function Signal_Present (Freq : Float) return Boolean ;

   -- Lit le numéro d'étiquette reçu sur la fréquence donnée en Hz.
   -- Renvoie n'importe quoi si aucun signal n'est présent sur la fréquence.
   function Etiquette_Detectee (Freq : Float) return Integer ;


   -- Erreur levée lorsqu'on utilise un numéro de fréquence hors de l'intervalle 1..Nb_Frequences
   Mauvais_Numero_De_Frequence : exception ;

end RFID ;
