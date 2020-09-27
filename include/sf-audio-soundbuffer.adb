with Interfaces.C.Strings;

package body Sf.Audio.SoundBuffer is
   use Interfaces.C.Strings;

   -- ////////////////////////////////////////////////////////////
   -- /// Create a new sound buffer and load it from a file
   -- ///
   -- /// \param Filename : Path of the music file to open
   -- ///
   -- /// \return A new sfSoundBuffer object (NULL if failed)
   -- ///
   -- ////////////////////////////////////////////////////////////
   function sfSoundBuffer_CreateFromFile (Filename : String) return sfSoundBuffer_Ptr is
      function Internal (Filename : chars_ptr) return sfSoundBuffer_Ptr;
      pragma Import (C, Internal, "sfSoundBuffer_createFromFile");
      Temp : chars_ptr         := New_String (Filename);
      R    : sfSoundBuffer_Ptr := Internal (Temp);
   begin
      Free (Temp);
      return R;
   end sfSoundBuffer_CreateFromFile;

   -- ////////////////////////////////////////////////////////////
   -- /// Save a sound buffer to a file
   -- ///
   -- /// \param SoundBuffer : Sound buffer to save
   -- /// \param Filename :    Path of the sound file to write
   -- ///
   -- /// \return sfTrue if saving has been successful
   -- ///
   -- ////////////////////////////////////////////////////////////
   function sfSoundBuffer_SaveToFile (SoundBuffer : sfSoundBuffer_Ptr; Filename : String) return sfBool is
      function Internal (SoundBuffer : sfSoundBuffer_Ptr; Filename : chars_ptr) return sfBool;
      pragma Import (C, Internal, "sfSoundBuffer_saveToFile");
      Temp : chars_ptr := New_String (Filename);
      R    : sfBool    := Internal (SoundBuffer, Temp);
   begin
      Free (Temp);
      return R;
   end sfSoundBuffer_SaveToFile;

end Sf.Audio.SoundBuffer;
