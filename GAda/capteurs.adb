with GAda.Text_IO;               -- with GAda.Text_IO;

package body capteurs is
        package Txt renames GAda.Text_IO;


        ----------------------------------------------------------------------------------------------------
        -- Les types
        ----------------------------------------------------------------------------------------------------
        type T_Temps is array (1..8, 0..9) of Float;
        type T_Trajets is array (1..8) of Integer;                      -- Permet de savoir dans quelle colonne il faut aller chercher les temps pour chaque nageur


        ----------------------------------------------------------------------------------------------------
        -- Les variables
        ----------------------------------------------------------------------------------------------------
        Temps : T_Temps :=
        -- Plot (0)   Trajet 1        Trajet 2        Trajet 3        Trajet 4        Trajet 5        Trajet 6        Trajet 7        Trajet 8        Fin de la course (9)    TOTAL
        ((1.0,                  1.0,            1.0,            1.0,            0.01,           0.01,           0.02,           1.0,            1.0,            Float'Last),                    --
         (2.0,                  1.1,            1.0,            1.0,            1.0,            1.0,            1.0,            1.0,            1.0,            Float'Last),                    --
         (1.0,                  0.5,            0.5,            0.9,            0.5,            1.5,            1.5,            1.5,            1.9,            Float'Last),                    --
         (4.0,                  0.5,            0.5,            0.7,            0.5,            1.5,            0.5,            0.5,            0.5,            Float'Last),                    --
         (1.0,                  0.01,           0.01,           0.01,           0.01,           0.01,           0.01,           1.0,            1.0,            Float'Last),                    --
         (1.0,                  1.0,            0.02,           0.02,           1.0,            2.0,            1.0,            1.0,            2.0,            Float'Last),                    --
         (0.01,                 1.0,            1.0,            1.0,            2.0,            2.0,            2.0,            1.0,            2.0,            Float'Last),                    --
         (0.3,                  1.0,            1.0,            1.0,            0.02,           2.0,            0.02,           1.0,            2.0,            Float'Last));                   --

        Trajet_Actuel : T_Trajets := (0, 0, 0, 0, 0, 0, 0, 0);

        Commence : Boolean := False;

        -- La course commence vers 14H00
        Date_Initiale : constant Float := 14.0 * 3600.0 ;
        Date : Float := Date_Initiale ;

        ----------------------------------------------------------------------------------------------------
        -- Les fonctions
        ----------------------------------------------------------------------------------------------------

        function Trouver return T_Evenement is
                Nageur_Min : Integer := -1 ;
                Temps_Min : Float := Float'Last;
        begin
                -- On cherche l'evenement qui va arriver le plus tot
                for Nageur in 1..8 loop--Temps'Range (1)
                        if Temps(Nageur, Trajet_Actuel(Nageur)) < Temps_Min then
                                Nageur_Min := Nageur;
                                Temps_Min := Temps(Nageur, Trajet_Actuel(Nageur));
                        end if;
                end loop;

                if Nageur_Min = -1 then
                   Txt.Put_Line("La course est terminee. Plus d'evenements.") ;
                   raise Program_Error ;
                end if ;


                -- On attend le temps necessaire pour l'arrivee de cet evenement puis on retranche le temps attendu a tous les autres evenements
                delay (Duration(Temps_Min));
                Date := Date + Temps_Min ;

                for Nageur in 1..8 loop--Temps'Range (1)
                        Temps(Nageur, Trajet_Actuel(Nageur)) := Temps(Nageur, Trajet_Actuel(Nageur)) - Temps_Min;
                end loop;

                -- On change le trajet du nageur a l'origine de l'evenement, on verifie egalement si il a termine la course
                if Trajet_Actuel(Nageur_Min) /= 9 then
                        Trajet_Actuel(Nageur_Min) := Trajet_Actuel(Nageur_Min) + 1;                     -- On change simplement le trajet qu'il faut regarder pour le nageur
                end if;

                -- On retourne l'action uniquement apres l'attente
                case Trajet_Actuel(Nageur_Min)-1 is                                                                     -- L'action zero correspond au temps de depart
                        when 0 =>       return (Capteur_Plot, Nageur_Min, Date);
                        when 1 | 3 | 5 | 7 =>   return (Capteur_Sud, Nageur_Min, Date);
                        when 2 | 4 | 6 | 8 =>   return (Capteur_Nord, Nageur_Min, Date);
                        when others =>  raise Program_Error ;
                end case;
        end Trouver;

        function Course_Terminee return Boolean is
        begin
           for Pos in Trajet_Actuel'Range loop
              if Trajet_Actuel(Pos) /= 9 then
                 return False ;
              end if ;
           end loop ;
           return True ;
        end Course_Terminee ;


        function Attend_Signal return T_Evenement is
           Evt : T_Evenement ;
        begin
           if not(Commence) then
              Commence := True;
              Evt := (Signal_Feu, 0, Date) ;
           elsif Course_Terminee then
                 Evt := (Bouton_Fin, 0, Date + 1.2) ;
              else
                 Evt := Trouver ;
           end if;

           Txt.Put_Line("Evenement : " & T_Capteur'Image(Evt.Emetteur) & "  couloir " & Integer'Image(Evt.Num) & "  date = " & Float'Image(Evt.Date - Date_Initiale) & " s") ;

           return Evt ;
        end Attend_Signal ;

end capteurs;
