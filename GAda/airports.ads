--
-- Liste des aéroports, générée à partir de liste_aeroports.ml
--

package Airports is

Nb_Aeroports : constant Integer := 37 ;

subtype taita is String(1..3) ;
subtype toaci is String(1..4) ;
subtype tpays is String(1..2) ;
type tnom is access String ;

type aeroport is record
  Aita : taita ;
  OACI : toaci ;
  Lat  : Float ;
  Long : Float ;
  Nom  : tnom ;
  Ville : tnom ;
  Pays  : tpays ;
end record ;

Airports : array (1..Nb_Aeroports+1) of aeroport
  := (
        ("BOD", "LFBD", 44.828330, -0.715560, new String'("Merignac"), new String'("Bordeaux"), "FR"),
        ("TLS", "LFBO", 43.628890, 1.363610, new String'("Blagnac"), new String'("Toulouse"), "FR"),
        ("CFE", "LFLC", 45.786390, 3.169170, new String'("Auvergne"), new String'("Clermont Ferrand"), "FR"),
        ("LYS", "LFLL", 45.726110, 5.090830, new String'("Saint Exupery"), new String'("Lyon"), "FR"),
        ("GNB", "LFLS", 45.362780, 5.329170, new String'("Saint Geoirs"), new String'("Grenoble"), "FR"),
        ("EBU", "LFMH", 45.540280, 4.296390, new String'("Boutheon"), new String'("St.-Etienne"), "FR"),
        ("MRS", "LFML", 43.435560, 5.213610, new String'("Provence"), new String'("Marseille"), "FR"),
        ("NCE", "LFMN", 43.660560, 7.217500, new String'("Cote D Azur"), new String'("Nice"), "FR"),
        ("MPL", "LFMT", 43.576110, 3.962780, new String'("Mediterranee"), new String'("Montpellier"), "FR"),
        ("BVA", "LFOB", 49.454440, 2.112780, new String'("Tille"), new String'("Beauvais"), "FR"),
        ("LBG", "LFPB", 48.969440, 2.441390, new String'("Le Bourget"), new String'("Paris"), "FR"),
        ("CDG", "LFPG", 49.012780, 2.550000, new String'("Charles De Gaulle"), new String'("Paris"), "FR"),
        ("ORY", "LFPO", 48.725280, 2.359440, new String'("Orly"), new String'("Paris"), "FR"),
        ("BES", "LFRB", 48.447780, -4.418330, new String'("Guipavas"), new String'("Brest"), "FR"),
        ("NTE", "LFRS", 47.153060, -1.610560, new String'("Nantes Atlantique"), new String'("Nantes"), "FR"),
        ("MZM", "LFSF", 49.071670, 6.131670, new String'("Frescaty"), new String'("Metz"), "FR"),
        ("EPL", "LFSG", 48.324720, 6.069720, new String'("Mirecourt"), new String'("Epinal"), "FR"),
        ("ENC", "LFSN", 48.691940, 6.230280, new String'("Essey"), new String'("Nancy"), "FR"),
        ("RHE", "LFSR", 49.310000, 4.050000, new String'("Champagne"), new String'("Reims"), "FR"),
        ("SXB", "LFST", 48.538060, 7.628060, new String'("Entzheim"), new String'("Strasbourg"), "FR"),
        ("LGW", "EGKK", 51.148060, -0.190280, new String'("Gatwick"), new String'("London"), "UK"),
        ("LHR", "EGLL", 51.477500, -0.461390, new String'("Heathrow"), new String'("London"), "UK"),
        ("BHX", "EGBB", 52.453610, -1.747780, new String'("Birmingham"), new String'("Birmingham"), "UK"),
        ("CIA", "LIRA", 41.799170, 12.594720, new String'("Ciampino"), new String'("Rome"), "IT"),
        ("FCO", "LIRF", 41.812780, 12.253060, new String'("Fiumicino"), new String'("Rome"), "IT"),
        ("BCN", "LEBL", 41.296940, 2.078330, new String'("Barcelona"), new String'("Barcelona"), "ES"),
        ("MAD", "LEMD", 40.472220, -3.560830, new String'("Barajas"), new String'("Madrid"), "ES"),
        ("TOJ", "LETO", 40.486670, -3.458060, new String'("Torrejon"), new String'("Madrid"), "ES"),
        ("BRU", "EBBR", 50.902220, 4.498610, new String'("Brussels Natl"), new String'("Brussels"), "BE"),
        ("CRL", "EBCI", 50.459170, 4.453610, new String'("Brussels South"), new String'("Charleroi"), "BE"),
        ("LGG", "EBLG", 50.637220, 5.443060, new String'("Liege"), new String'("Liege"), "BE"),
        ("LUX", "ELLX", 49.626390, 6.211390, new String'("Findel International Airport"), new String'("Luxemburg"), "LU"),
        ("VCE", "LIPZ", 45.505000, 12.351670, new String'("Venezia Tessera"), new String'("Venice"), "IT"),
        ("FLR", "LIRQ", 43.809720, 11.205000, new String'("Peretola"), new String'("Firenze"), "IT"),
        ("SXF", "EDDB", 52.380000, 13.522500, new String'("Schonefeld"), new String'("Berlin"), "DE"),
        ("THF", "EDDI", 52.472780, 13.403890, new String'("Tempelhof"), new String'("Berlin"), "DE"),
        ("TXL", "EDDT", 52.559440, 13.287500, new String'("Tegel"), new String'("Berlin"), "DE"),
        ("@@@", "@@@@", 0.000000, 0.000000, new String'("@@"), new String'("@@@"), "@@")
      ) ;

end Airports ;
