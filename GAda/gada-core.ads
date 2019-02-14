with GAda.Text_IO;
package GAda.Core is
	procedure Put_Err(Item:in String);
	procedure Put(Item:in String);
	procedure Put_Line(Item:in String);
	procedure New_Line;


	Boucle_Infinie : exception ;
  Fenetre_Fermee : exception ;
end GAda.Core;
