with Ada.Calendar ; use Ada.Calendar ;
with Gada.Text_IO ;
with Ada.Float_Text_Io ;
with Ada.Strings, Ada.Strings.Fixed ;

package body Serv is

   Last : constant Time := Clock ;

   package Txt renames Gada.Text_IO ;

   function Station_Connectee (SIM : in Integer) return Integer is
      Duree : Integer := Integer ((Clock - Last) / 2.5511) ;
   begin
      return 120 + (Duree mod 20) ;
   end Station_Connectee ;

   Coords : array (0..5) of T_Coords := ( (43.571655,1.466549),
                                            (43.604449,1.443499),
                                            (43.612133,1.454295),
                                            (43.612928,1.431942),
                                            (43.583294,1.434397),
                                            (43.591953,1.459136)) ;

   -- Renvoie les coordonnées de la station de base
   function Coordonnees (No_Station : in Integer) return T_Coords is
   begin
      return Coords(No_Station mod Coords'Length) ;
   end Coordonnees ;

   function Perdue (No_Etiquette : Integer) return Boolean is
   begin
      return No_Etiquette /= 2000 ;
   end Perdue ;


   function Adresse (No_Etiquette : Integer) return String is
   begin
      return "john.doe@sapajou.fr" ;
   end Adresse ;

   -- Envoie un email au destinataire indiqué
   procedure Email (Destinataire : String ; Message : String) is
   begin
      Txt.Put_Line("--------------------------------------------") ;
      Txt.Put_Line("-- Message envoyé à : " & Destinataire & " --") ;
      Txt.Put_Line("--------------------------------------------") ;
      Txt.Put_Line(Message) ;
      Txt.New_Line ;
      Txt.New_Line ;
   end Email ;

   function Image (Arg: Float) return String is
      Result : String(1..100) ;
   begin
      Ada.Float_Text_Io.Put(To => Result ,
                            Item => Arg ,
                            Exp => 0) ;
      return Ada.Strings.Fixed.Trim(Result, Ada.Strings.Left) ;
   end Image ;

end Serv ;
