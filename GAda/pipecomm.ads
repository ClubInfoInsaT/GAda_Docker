--
-- Communication de données via un PIPE
--
-- On n'utilise pas Ada.Sequential_IO parce que le but est de communiquer avec du Caml à l'autre bout.
--

with Ada.Streams.Stream_IO ;

package PipeComm is

   subtype Byte is Ada.Streams.Stream_Element ;

   -- À appeler en premier : ouverture des PIPES
   -- Penser à appeler Init_IN en premier d'un côté et Init_OUT en premier de l'autre (sinon blocage).
   -- Appels bloquants
   procedure Init_IN  (Name : String) ;
   procedure Init_OUT (Name : String) ;

   -- Écriture (n'envoie rien tant que le flush n'a pas eu lieu)
   procedure Put_Byte (X : Byte) ;
   procedure Put (X : Boolean) ;
   procedure Put (X : Integer) ;
   procedure Put (X : Float) ;
   procedure Put (X : Character) ;
   procedure Put (X : String) ;
   procedure Flush ;

   -- Lecture
   procedure Receive ; -- Bloquant, à faire avant les GET
   function Get_Byte return Byte ;
   function Get return Boolean ;
   function Get return Integer ;
   function Get return Float ;
   function Get return Character ;

   -- Deux fois la même fonction
   function Get return String ;
   function SGet return String ;

   -- Terminé
   procedure Close ;


   -- Génériques
   generic
      type T1 is private ;
      type T2 is private ;

      type Pr is private ;
      with function Get1 (A : in Pr) return T1 ;
      with function Get2 (A : in Pr) return T2 ;

      with procedure Put1 (X : T1) ;
      with procedure Put2 (Y : T2) ;
   procedure Put_Pair (PP : Pr) ;


   -- Les paires n'existent pas en Ada.
   -- Heureusement que le code final sera généré !
   generic
      type T1 is private ;
      type T2 is private ;

      type Pr is private ;
      with procedure Set1 (A : out Pr ; X : T1) ;
      with procedure Set2 (A : out Pr ; X : T2) ;

      with function Get1 return T1 ;
      with function Get2 return T2 ;
   function Get_Pair return Pr ;

   generic
      type T is private ;
      type Ta is array (Positive range <>) of T ;
      with procedure PutT (X : T) ;
   procedure Put_Array (X : Ta) ;

   generic
      type T is private ;
      type Ta is array (Positive range <>) of T ;
      with function GetT return T ;
   function Get_Array return Ta ;

   -- Tableaux
   type Ints is array (Positive range <>) of Integer ;
   type Floats is array (Positive range <>) of Float ;
   type Bools is array (Positive range <>) of Boolean ;

   procedure Put_Ints (X : Ints) ;
   function  Get_Ints return Ints ;

   procedure Put_Floats (X : Floats) ;
   function Get_Floats return Floats ;

   procedure Put_Bools (X : Bools) ;
   function Get_Bools return Bools ;

end PipeComm ;
