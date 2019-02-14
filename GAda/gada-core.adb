with GAda.Text_IO;

package body GAda.Core is
	procedure Put_Err(Item: String) is
		begin
		GAda.Text_IO.Put_Line("TECHIO> success false");
		GAda.Text_IO.Put_Line("[Error] : "& Item);
	end Put_Err;

	procedure Put(Item: String) renames GAda.Text_IO.Put;
	procedure Put_Line(Item: String) renames GAda.Text_IO.Put_Line;
	procedure New_Line renames GAda.Text_IO.New_Line;
end GAda.Core;
