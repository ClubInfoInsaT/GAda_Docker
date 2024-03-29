-----------------------------------------------------------------------
--         Simple JPEG Library - a libjpeg binding for ADA V2        --
--                                                                   --
--                        Copyright (C) 2002                         --
--                           Freydiere P.                            --
--                                                                   --
-- This library is free software; you can redistribute it and/or     --
-- modify it under the terms of the GNU General Public               --
-- License as published by the Free Software Foundation; either      --
-- version 2 of the License, or (at your option) any later version.  --
--                                                                   --
-- This library is distributed in the hope that it will be useful,   --
-- but WITHOUT ANY WARRANTY; without even the implied warranty of    --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
-- General Public License for more details.                          --
--                                                                   --
-- You should have received a copy of the GNU General Public         --
-- License along with this library; if not, write to the             --
-- Free Software Foundation, Inc., 59 Temple Place - Suite 330,      --
-- Boston, MA 02111-1307, USA.                                       --
--                                                                   --
-- As a special exception, if other files instantiate generics from  --
-- this unit, or you link this unit with other files to produce an   --
-- executable, this  unit  does not  by itself cause  the resulting  --
-- executable to be covered by the GNU General Public License. This  --
-- exception does not however invalidate any other reasons why the   --
-- executable file  might be covered by the  GNU Public License.     --
-----------------------------------------------------------------------

with Interfaces;
with Interfaces.C;
with Interfaces.C.Pointers;

with Text_IO; use Text_IO;

package body Simple_Jpeg_Lib is

   package Component_Array_Ptr is new Interfaces.C.Pointers (
      Index => Natural,
      Element => Byte,
      Element_Array => Component_Array,
      Default_Terminator => 0);

   subtype Component_Ptr is Component_Array_Ptr.Pointer;

   procedure JPEG_Err_Exit (Info : System.Address);
   pragma Convention (C, JPEG_Err_Exit);

   --- C procedure for opening a JPEG File
   function C_Open_Jpeg
     (C          : Interfaces.C.char_array;
      P          : Jpeg_Exit_Error_Handler_Access;
      Scaledenom : in Interfaces.C.int)
      return       Jpeg_Handle_Decompress;
   pragma Import (C, C_Open_Jpeg, "open_jpeg");

   --- C procedure for getting the next pixels row
   function C_Get_Row (I : in Jpeg_Handle_Decompress) return Component_Ptr;
   pragma Import (C, C_Get_Row, "get_row");

   --- C procedure for closing the JPEG File ..
   function C_Close_Jpeg
     (I    : Jpeg_Handle_Decompress)
      return Interfaces.C.int;
   pragma Import (C, C_Close_Jpeg, "close_decompress_jpeg");

   function C_Get_Image_Width
     (I    : Jpeg_Handle_Decompress)
      return Interfaces.C.int;
   pragma Import (C, C_Get_Image_Width, "get_image_width");

   function C_Get_Image_Height
     (I    : Jpeg_Handle_Decompress)
      return Interfaces.C.int;
   pragma Import (C, C_Get_Image_Height, "get_image_height");

   function C_Get_Image_Num_Components
     (I    : Jpeg_Handle_Decompress)
      return Interfaces.C.int;
   pragma Import (C, C_Get_Image_Num_Components, "get_image_num_components");

   --- Function to create JPEG Files

   function C_Create_Jpeg
     (C                             : Interfaces.C.char_array;
      P                             : Jpeg_Exit_Error_Handler_Access;
      Width, Height, Nb_Composantes : Interfaces.C.int)
      return                          Jpeg_Handle_Compress;
   pragma Import (C, C_Create_Jpeg, "create_jpeg");

   function C_Write_Row
     (I    : Jpeg_Handle_Compress;
      M    : System.Address)
      return Interfaces.C.int;
   pragma Import (C, C_Write_Row, "write_row");

   function C_Close_Compress_Jpeg
     (C    : Jpeg_Handle_Compress)
      return Interfaces.C.int;
   pragma Import (C, C_Close_Compress_Jpeg, "close_compress_jpeg");

   --- Memory Jpeg Creation functions
   --- thoses functions create a Memory Jpeg File

   function C_Create_Jpeg_Memory
     (BufferSize                    : in Interfaces.C.int;
      P                             : Jpeg_Exit_Error_Handler_Access;
      Width, Height, Nb_Composantes : Interfaces.C.int)
      return                          Jpeg_Handle_Memory_Compress;

   pragma Import (C, C_Create_Jpeg_Memory, "create_jpeg_memory");

   function C_Write_Memory_Row
     (I    : Jpeg_Handle_Memory_Compress;
      M    : System.Address)
      return Interfaces.C.int;
   pragma Import (C, C_Write_Memory_Row, "write_memory_row");

   function C_Close_Compress_Memory_Jpeg
     (C    : Jpeg_Handle_Memory_Compress)
      return Jpeg_Memory_Buffer;
   pragma Import
     (C,
      C_Close_Compress_Memory_Jpeg,
      "close_compress_memory_jpeg");

   function C_Get_Jpeg_Memory_Buffer_Size
     (J    : Jpeg_Memory_Buffer)
      return Interfaces.C.int;
   pragma Import
     (C,
      C_Get_Jpeg_Memory_Buffer_Size,
      "get_jpeg_memory_buffer_size");

   function C_Get_Jpeg_Memory_Buffer
     (J    : Jpeg_Memory_Buffer)
      return Component_Ptr;
   pragma Import (C, C_Get_Jpeg_Memory_Buffer, "get_jpeg_memory_buffer");

   procedure C_Free_Jpeg_Memory_Buffer (J : Jpeg_Memory_Buffer);
   pragma Import (C, C_Free_Jpeg_Memory_Buffer, "free_jpeg_memory_buffer");

   ---------------------------------------
   -- Thick Binding Implementation Part --
   ---------------------------------------

   -------------------
   -- Get_Line_Size --
   -------------------
   function Get_Line_Size
     (JpegType : Jpeg_Type;
      Width    : Dimension)
      return     Natural
   is
   begin
      case JpegType is
         when RVB =>
            return 3 * Width; -- 3 bytes per line
         when Grey =>
            return Width; -- 1 byte per line
      end case;
   end Get_Line_Size;

   ----------------
   -- Close_Jpeg --
   ----------------
   procedure Close_Jpeg (J : in out Jpeg_Handle_Decompress) is
      use Interfaces.C;
      Ret : int;
   begin
      Ret := C_Close_Jpeg (J);
      if Ret /= 0 then
         raise Jpeg_Exception;
      end if;
   end Close_Jpeg;

   ---------------
   -- Open_Jpeg --
   ---------------
   procedure Open_Jpeg
     (Nom         : in String;
      J           : out Jpeg_Handle_Decompress;
      Scale_Denom : in Integer)
   is
      use Interfaces.C;
      use System;
   begin

      J :=
         C_Open_Jpeg
           (Interfaces.C.To_C (Nom),
            JPEG_Err_Exit'Access,
            int (Scale_Denom));
      if Address (J) = Null_Address then
         raise Jpeg_Exception;
      end if;

   end Open_Jpeg;

   --------------------
   -- Read_Next_Line --
   --------------------
   function Read_Next_Line
     (J    : in Jpeg_Handle_Decompress)
      return Component_Array
   is
      use Interfaces.C;
      use Component_Array_Ptr; -- for component operators
      Components    : Component_Array_Ptr.Pointer;
      Width, Height : Dimension;
      Jt            : Jpeg_Type;
      Nbcomposantes : Natural;
   begin
      Components := C_Get_Row (J);
      if Components = null then
         raise Jpeg_Exception;
      end if;

      Get_Image_Info (J, Width, Height, Jt);
      case Jt is
         when RVB =>
            Nbcomposantes := 3;
         when Grey =>
            Nbcomposantes := 1;
      end case;

      return Value (Components, ptrdiff_t (Width * Nbcomposantes));
   end Read_Next_Line;

   --------------------
   -- Create_Jpeg    --
   --------------------

   procedure Close_Jpeg (J : in out Jpeg_Handle_Compress) is
      use Interfaces.C;
      Ret : int;
   begin
      Ret := C_Close_Compress_Jpeg (J);
   end Close_Jpeg;

   -----------------
   -- Create_Jpeg --
   -----------------
   procedure Create_Jpeg
     (Nom           : in String;
      J             : out Jpeg_Handle_Compress;
      Width, Height : Dimension;
      JpegType      : Jpeg_Type)
   is
      use Interfaces.C;
      use System;
      JPtr          : Jpeg_Handle_Compress;
      C_Width       : int := int (Width);
      C_Height      : int := int (Height);
      Nbcomposantes : int := 3; -- by default, color values
   begin
      if jpegtype = Grey then
         Nbcomposantes := 1;
      end if;

      JPtr :=
         C_Create_Jpeg
           (Interfaces.C.To_C (Nom),
            JPEG_Err_Exit'Access,
            C_Width,
            C_Height,
            Nbcomposantes);

      if Address (JPtr) = Null_Address then
         raise Jpeg_Exception;
      end if;
      J := JPtr;
   end Create_Jpeg;

   ----------------
   -- Write_Line --
   ----------------
   procedure Write_Line
     (J          : in Jpeg_Handle_Compress;
      Components : in Component_Array)
   is
      use Interfaces.C;
      Ret : int;
   begin
      declare
      -- Create a constrainted temporary array for
      -- passing values to C's procedure
         Temparr : Component_Array (Components'Range) :=
            Components (Components'Range);
      begin
         Ret := C_Write_Row (J, Temparr (Components'First)'Address);
         if Ret > 0 then
            raise Jpeg_Exception;
         end if;
      end;
   end Write_Line;

   --------------------
   -- Get_Image_Info --
   --------------------
   procedure Get_Image_Info
     (J             : in Jpeg_Handle_Decompress;
      Width, Height : out Dimension;
      Jpegtype      : out Jpeg_Type)
   is
      use Interfaces.C;
      C_Width, C_Height, Nbcomposantes : int;
   begin
      C_Width       := C_Get_Image_Width (J);
      C_Height      := C_Get_Image_Height (J);
      Nbcomposantes := C_Get_Image_Num_Components (J);

      Height := Dimension (C_Height);
      Width  := Dimension (C_Width);
      case Nbcomposantes is
         when 3 =>
            JpegType := RVB;
         when 1 =>
            JpegType := Grey;
         when others =>
            raise Unknown_Jpeg_Type;
      end case;

   end Get_Image_Info;

   -------------------
   -- JPEG_Err_Exit --
   -------------------

   procedure JPEG_Err_Exit (Info : System.Address) is

   begin

      null;

      -- raise Jpeg_Exception;
      -- Raise option removed because of issues on Windows plate-forme
   end JPEG_Err_Exit;

   ------------------------
   -- Create_Jpeg_Memory --
   ------------------------

   --- Create in memory jpeg
   procedure Create_Jpeg_Memory
     (BufferSize    : in Natural;
      J             : out Jpeg_Handle_Memory_Compress;
      Width, Height : in Dimension;
      Jpegtype      : in Jpeg_Type)
   is
      use Interfaces.C;
      use System;
      Jptr          : Jpeg_Handle_Memory_Compress;
      NbComposantes : int := 3; --by default
      C_Width       : int := int (Width);
      C_Height      : int := int (Height);

   begin

      if Jpegtype = Grey then
         NbComposantes := 1;
      end if;

      Jptr :=
         C_Create_Jpeg_Memory
           (Interfaces.C.int (BufferSize),
            JPEG_Err_Exit'Access,
            C_Width,
            C_Height,
            NbComposantes);

      if Address (Jptr) = Null_Address then
         raise Jpeg_Exception;
      end if;
      J := Jptr;
      null;
   end Create_Jpeg_Memory;

   ----------------
   -- Write_Line --
   ----------------
   procedure Write_Line
     (J          : in Jpeg_Handle_Memory_Compress;
      Components : in Component_Array)
   is
      use Interfaces.C;
      Ret : int;
   begin
      declare
      -- Create a constrainted temporary array for
      -- passing values to C's procedure
         Temparr : Component_Array (Components'Range) :=
            Components (Components'Range);
      begin
         Ret := C_Write_Memory_Row (J, Temparr (Components'First)'Address);
         if Ret > 0 then
            raise Jpeg_Exception;
         end if;
      end;
   end Write_Line;

   ----------------
   -- Close_Jpeg --
   ----------------
   function Close_Jpeg
     (J    : in Jpeg_Handle_Memory_Compress)
      return Jpeg_Memory_Buffer
   is
      Result : Jpeg_Memory_Buffer;
   begin
      Result := C_Close_Compress_Memory_Jpeg (J);
      return Result;
   end Close_Jpeg;

   --------------
   -- Get_Size --
   --------------
   function Get_Size (J : in Jpeg_Memory_Buffer) return Natural is
      Result : Natural;
   begin
      Result := Natural (C_Get_Jpeg_Memory_Buffer_Size (J));
      return Result;
   end Get_Size;

   ----------------
   -- Get_Buffer --
   ----------------
   function Get_Buffer (J : in Jpeg_Memory_Buffer) return Byte_Array is
      use Interfaces.C;
   begin
      declare
         Arr : Component_Array :=
            Component_Array_Ptr.Value
              (C_Get_Jpeg_Memory_Buffer (J),
               ptrdiff_t (Get_Size (J)));
      begin
         return Byte_Array (Arr);
      end;
   end Get_Buffer;

   -----------------
   -- Free_Buffer --
   -----------------
   procedure Free_Buffer (J : in Jpeg_Memory_Buffer) is
   begin
      C_Free_Jpeg_Memory_Buffer (J);
   end Free_Buffer;

end Simple_Jpeg_Lib;
