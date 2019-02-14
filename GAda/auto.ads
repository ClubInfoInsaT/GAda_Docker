--
-- Cet acteur permet de vérifier le comportement d'une voiture autonome.
--
package Auto is
   
   -- Indique la destination voulue au calculateur d'itinéraire (le GPS).
   -- Longitude, Latitude.
   procedure Fixer_Destination (Long : Float ; Lat : Float) ;
   
   -- Renvoie la vitesse actuelle de la voiture, en km/h.
   function Vitesse return Float ;
   
   -- Renvoie la durée écoulée depuis le début du trajet (depuis Fixer_Destination)
   function Date return Float ;
   
   -- Indique si la voiture est arrivée à destination
   function Arrivee return Boolean ;
   
   -- Active ou désactive le mode prudent (selon que Prudent est vrai ou faux).
   -- Le mode prudent limite la vitesse à 60km/h.
   procedure Regler_Mode (Prudent : Boolean) ;
   
   -- Représente une action effectuée par la voiture : tourner, freiner, etc.
   type T_Action is record
      
      -- Direction des roues en degrés
      --    Négatif = à gauche
      --    Positif = à droite
      --          0 = tout droit
      Direction : Float ;
      
      -- Action sur l'accélérateur (entre 0 et 10)
      --   0 = pas d'accélération
      --  10 = accélération maximale
      Accelere : Integer ;
      
      -- Action sur les freins (entre 0 et 10)
      --   0 = pas de freinage
      --  10 = freinage maximal
      Freinage : Integer ;
      
      -- Ce booléen indique si cette action est une action d'urgence (évitement d'urgence, freinage d'urgence, etc.)
      Urgence : Boolean ;
      
   end record ;
   
   -- Renvoie l'action effectuée en ce moment par la voiture.
   function Action_Courante return T_Action ; 
   
   -- Attend quelques millisecondes.
   -- La voiture commence alors une nouvelle action.
   procedure Attend_Ms ;
   
            
end Auto ;
