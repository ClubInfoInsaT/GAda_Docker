with Ada.Text_IO;
with ada.io_exceptions ;
use Ada.Text_IO;
package body GAda.Text_IO is
	
	-- Nombre d'étapes
	Steps : Integer;
	
	-- Nombre Max d'étapes
	Steps_Max : Integer := 20 ;
  -- Affiche le message sans passer à la ligne
  procedure Put (Aff: in String) renames Ada.Text_IO.Put;
  -- Affiche le message et passe à la ligne
  procedure Put_Line (Aff: in String) renames Ada.Text_IO.Put_Line;

  -- Passe à la ligne
  procedure New_Line is
		begin
		 Ada.Text_IO.New_Line;
	end New_Line;

  -- Lit et retourne une chaîne
  function Fget return String is
   begin
			Steps := Steps +1;
			if (Steps <= Steps_Max) then
	      return Get_Line ;
			else
				return "(plus de lignes)";
			end if;
   exception
      when ADA.IO_EXCEPTIONS.END_ERROR => return "(plus de lignes)" ;
	 -- attention, risque de mauvais comportement avec fget-integer qui va boucler sans cesse sur la fin du fichier.
   end FGet ;


	
  -- Lit une chaîne (version originale)
  procedure Get (Item : out String) is
    size: Integer;
    begin
    Ada.Text_IO.get_line(Item,size);
  end Get;

  -- Pour les caractères
  procedure Put (Aff : in Character) renames Ada.Text_IO.Put; 

  procedure Put_Line (Aff : in Character) is
    begin
      Ada.Text_IO.Put(Aff);
      Ada.Text_IO.New_Line;
  end Put_Line;

  -- Prend une chaîne de caractère X et renvoie une chaîne de caractère
  -- de type String(1..N), où N est le second argument.
  -- Si X est trop petit, en ajoutant des espaces ;
  -- Si X est trop grand, en tronquant le texte.
  function Normalise (X : String ; N : Integer) return String is
    retour: String(1..N) := (others =>' ');
    begin
    if N<=(X'length) then
      retour:=X(X'First..N);
    else
      retour(retour'First..X'length) := X;
    end if;
    return retour;
  end Normalise;

  -- Retourne au début de la ligne courante et écrit le message indiqué.
  -- Utile pour afficher l'évolution d'une variable.
  procedure Replace (Aff : in String) is
    begin
		Ada.Text_IO.Put("\033[1A");
		Ada.Text_IO.Put("\033[K");
    Ada.Text_IO.Put(Aff);
  end Replace;

begin
	Steps:=0;	
end GAda.Text_IO ;

