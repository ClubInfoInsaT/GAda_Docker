with Ada.Sequential_IO ;

package body Wav is
   
   -- 8 bits
   type Unsigned is mod 2 ** 8 ;
   package S is new Ada.Sequential_IO(Unsigned) ;
      
   procedure Write_Tab(File : S.File_Type ; Tab : T_Sound) is
      Byte : Unsigned ;
   begin
      for Pos in Tab'Range loop
	 Byte := Unsigned(Tab(Pos)) ;
	 S.Write(File, Byte) ;
      end loop ;
   end Write_Tab ;
   
   Bad_Integer_Value: exception ;
   
   procedure Write_LE(File : S.File_Type ; Val : Integer ; Size : Integer) is
      Byte : Unsigned ;
      Count : Integer := Size ;
      Value : Integer := Val ;
   begin
      while Count > 0 loop
	 Byte := Unsigned (Value mod 256) ;
	 Value := Value / 256 ;
	 S.Write(File, Byte) ;
	 Count := Count - 1 ;
      end loop ;
      
      if Value /= 0 then 
	 raise Bad_Integer_Value ;
      end if ;
   end Write_LE ;
   
   -- http://fr.wikipedia.org/wiki/WAVEform_audio_format
   procedure Write_Header(File : S.File_Type ; Tab : T_Sound ; Freq : Integer) is
      Canaux : Integer := 1 ;
      BitsPerSample : Integer := 8 ;
      BytePerBloc : Integer := Canaux * BitsPerSample / 8 ;
      BytePerSec : Integer := BytePerBloc * Freq ;

      DataSize : Integer := Tab'Length * BitsPerSample / 8 ;
      FileSize : Integer := DataSize + 44 ;
      
   begin
      --
      -- Fichier WAVE
      --
      
      -- "RIFF"
      Write_Tab(File, (16#52#,16#49#,16#46#,16#46#) ) ;
      
      Write_LE(File, FileSize - 8, 4) ;
      
      -- "WAVE"
      Write_Tab(File, (16#57#,16#41#,16#56#,16#45#) ) ;
      
      --
      -- Format AUDIO
      --
      
      -- "fmt "
      Write_Tab(File, (16#66#,16#6D#,16#74#,16#20#) ) ;
      Write_LE(File, 16, 4) ;
      
      -- Audioformat (1 = PCM)
      Write_LE(File, 1, 2) ;
      
      -- Canaux
      Write_LE(File, Canaux, 2) ;
      
      -- Frequence
      Write_LE(File, Freq, 4) ;
      
      -- BytePerSec, ...
      Write_LE(File, BytePerSec, 4) ;
      Write_LE(File, BytePerBloc, 2) ;
      Write_LE(File, BitsPerSample, 2) ;
      
      --
      -- DATA
      --
      Write_Tab(File, (16#64#,16#61#,16#74#,16#61#)) ;
      Write_LE(File, DataSize, 4) ;
   end Write_Header ;
   
   Bad_Frequency : exception ;
   
   procedure Creer_Fichier (Nom : String ; Tab : T_Sound ; Freq : Integer) is
      File : S.File_Type ;
   begin
      
      if Freq /= 11025 and Freq /= 22050 and Freq /= 44100 then
	 raise Bad_Frequency ;
      end if ;
      
      S.Create (File, S.Out_File, Nom, "") ;
      
      Write_Header(File, Tab, Freq) ;
      Write_Tab(File, Tab) ;
      
      S.Close (File) ;

   end Creer_Fichier ;
   
end Wav ;
