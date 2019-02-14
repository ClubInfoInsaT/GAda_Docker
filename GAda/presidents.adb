with GAda.Core ;
with Gada.Text_IO ;

package body Presidents is

   package Txt renames GAda.Text_IO ;

   -- Compte les appels pour prévenir les boucles infinies.
   Nb_Appels : Integer := 0 ;

   Max_Appels : constant Integer := 10000 ;

   procedure Compte_Appel is
   begin
      Nb_Appels := Nb_Appels + 1 ;
      if Nb_Appels > Max_Appels then
         raise Gada.Core.Boucle_Infinie ;
      end if ;
   end Compte_Appel ;

   type T_Info is record
      V1 : access String ;
      V2 : Integer ;
      V3 : Integer ;
      V4 : Character ;
      V5 : Boolean ;
   end record ;

   type T_Objects is array(Integer range <>) of T_Info ;

   Objects : T_Objects :=
     (1 => (new String'("George Washington"), 1789, 1797, 'F', true),
      2 => (new String'("John Adams"), 1797, 1801, 'F', true),
      3 => (new String'("Thomas Jefferson"), 1801, 1809, 'B', true),
      4 => (new String'("James Madison"), 1809, 1817, 'B', true),
      5 => (new String'("James Monroe"), 1817, 1825, 'B', true),
      6 => (new String'("John Q. Adams"), 1825, 1829, 'R', true),
      7 => (new String'("Andrew Jackson"), 1829, 1837, 'D', true),
      8 => (new String'("Martin Van Buren"), 1837, 1841, 'D', true),
      9 => (new String'("William H. Harrison"), 1841, 1841, 'W', false),
      10 => (new String'("John Tyler"), 1841, 1845, 'W', true),
      11 => (new String'("James K. Polk"), 1845, 1849, 'D', true),
      12 => (new String'("Zachary Taylor"), 1849, 1850, 'W', false),
      13 => (new String'("Millard Fillmore"), 1850, 1853, 'W', true),
      14 => (new String'("Franklin Pierce"), 1853, 1857, 'D', true),
      15 => (new String'("James Buchanan"), 1857, 1861, 'D', true),
      16 => (new String'("Abraham Lincoln"), 1861, 1865, 'R', false),
      17 => (new String'("Andrew Johnson"), 1865, 1869, 'D', true),
      18 => (new String'("Ulysses S. Grant"), 1869, 1877, 'R', true),
      19 => (new String'("Rutherford B. Hayes"), 1877, 1881, 'R', true),
      20 => (new String'("James A. Garfield"), 1881, 1881, 'R', false),
      21 => (new String'("Chester A. Arthur"), 1881, 1885, 'R', true),
      22 => (new String'("S. Grover Cleveland"), 1885, 1889, 'D', true),
      23 => (new String'("Benjamin Harrison"), 1889, 1893, 'R', true),
      24 => (new String'("S. Grover Cleveland"), 1893, 1897, 'D', true),
      25 => (new String'("William McKinley"), 1897, 1901, 'R', false),
      26 => (new String'("Theodore Roosevelt"), 1901, 1909, 'R', true),
      27 => (new String'("William H. Taft"), 1909, 1913, 'R', true),
      28 => (new String'("T. Woodrow Wilson"), 1913, 1921, 'D', true),
      29 => (new String'("Warren G. Harding"), 1921, 1923, 'R', false),
      30 => (new String'("J. Calvin Coolidge"), 1923, 1929, 'R', true),
      31 => (new String'("Herbert C. Hoover"), 1929, 1933, 'R', true),
      32 => (new String'("Franklin D. Roosevelt"), 1933, 1945, 'D', false),
      33 => (new String'("Harry S. Truman"), 1945, 1953, 'D', true),
      34 => (new String'("Dwight D. Eisenhower"), 1953, 1961, 'R', true),
      35 => (new String'("John F. Kennedy"), 1961, 1963, 'D', false),
      36 => (new String'("Lyndon B. Johnson"), 1963, 1969, 'D', true),
      37 => (new String'("Richard M. Nixon"), 1969, 1974, 'R', false),
      38 => (new String'("Gerald R. Ford"), 1974, 1977, 'R', true),
      39 => (new String'("Jimmy Carter"), 1977, 1981, 'D', true),
      40 => (new String'("Ronald W. Reagan"), 1981, 1989, 'R', true),
      41 => (new String'("George H. W. Bush"), 1989, 1993, 'R', true),
      42 => (new String'("Bill Clinton"), 1993, 2001, 'D', true),
      43 => (new String'("George W. Bush"), 2001, 2009, 'R', true),
      44 => (new String'("Barack Obama"), 2008, 2016, 'D', true),
      45 => (new String'("Donald Trump"), 2017, 2020, 'R', true)
     ) ;
   
     function Nb_Objects return Integer is
     begin
	Compte_Appel ;
	return Objects'Length ;
     end Nb_Objects ;

     function Nb_Presidents return Integer renames Nb_Objects ;

     procedure Check_Range (No : Integer ; Msg : String) is
     begin
	Compte_Appel ;
	if No not in Objects'Range then
	   -- CHANGE (message d'erreur)
	   GAda.Core.Put_Err("ERREUR : Appel de " & Msg & " avec un numéro de président égal à " & Integer'Image(No) &
			       " alors que les présidents sont numérotés de 1 à " & Integer'Image(Nb_Objects)) ;
	   raise Program_Error ;
	end if ;
     end Check_Range ;

   function Infos (No : Integer) return T_Infos is
   begin
      Check_Range(No, "Infos") ;
      return (Objects(No).V2, Objects(No).V3, Objects(No).V4, Objects(No).V5) ;
   end Infos ;

   function Nom (No : Integer) return String is
   begin
      Check_Range(No, "Nom") ;
      return " " & Objects(No).V1.all & " " ;
   end Nom ;

end Presidents ;
