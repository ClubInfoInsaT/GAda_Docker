--
-- Cet acteur permet de créer des fichiers de son .wav
--

package Wav is
   
   subtype T_Echantillon is Integer range 0..255 ;
   
   -- Ce type permet de représenter un ensemble d'échantillons de sons sur 8bits.
   type T_Sound is array(Integer range <>) of T_Echantillon ;
   
   -- Crée un nouveau fichier WAV contenant les échantillons fournis.
   -- Nom = nom du fichier
   -- Tab = tableau contenant le son échantillonné
   -- Freq : fréquence d'échantillonnage. Choisir 11025, 22050, ou 44100
   procedure Creer_Fichier (Nom : String ; Tab : T_Sound ; Freq : Integer) ;
   
   
     
end Wav ;
