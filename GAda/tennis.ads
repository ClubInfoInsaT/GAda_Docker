--
-- Cet acteur contient un classement des joueurs de tennis.
--

package Tennis is

   type T_Entree is record
      -- Le nom du joueur de tennis (sur 22 caractères)
      Nom : String(1..22) ;
      
      -- Son pays (sur 3 caractères)
      Pays : String(1..3) ;
      
      -- Évolution de son classement : +1 signifie qu'il a amélioré sa position de 1 depuis le dernier classement.
      Move : Integer ;
   end record ;
   
   -- Constante pour représenter un joueur inconnu
   Inconnu : constant String(1..22) := (others => '-') ;
   
   -- Tableau des meilleurs joueurs, classés à partir du premier
   type T_Classement is array(Integer range <>) of T_Entree ;
   
   
   -- Cette fonction renvoie un tableau des joueurs (classement masculin).
   function Joueurs return T_Classement ;
   
   -- Cette fonction renvoie un tableau des joueuses (classement féminin).
   function Joueuses return T_Classement ;
   
   
   -- Type utilisé à la question 2
   type T_Resultat is record
      Succes : Boolean ;
      Numero : Integer ;
   end record ;
   
end Tennis ;
