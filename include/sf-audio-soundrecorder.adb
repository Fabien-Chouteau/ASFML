with Interfaces.C.Strings; use Interfaces.C;

with System;

with Ada.Strings.Unbounded;

package body Sf.Audio.SoundRecorder is


  --//////////////////////////////////////////////////////////
  --/ @brief Get a list of the names of all availabe audio capture devices
  --/
  --/ This function returns an array of strings (null terminated),
  --/ containing the names of all availabe audio capture devices.
  --/ If no devices are available then NULL is returned.
  --/
  --/ @param count Pointer to a variable that will be filled with the number of modes in the array
  --/
  --/ @return An array of strings containing the names
  --/
  --//////////////////////////////////////////////////////////
  function sfSoundRecorder_getAvailableDevices return sfArrayOfStrings is

     function Internal (count : access sfSize_t) return Standard.System.Address;
     pragma Import (C, Internal, "sfSoundRecorder_getAvailableDevices");

     count : aliased sfSize_t;
     result : Standard.System.Address := Internal (count'access);

   begin
      declare
         subtype availableDevicesType is Strings.Chars_Ptr_Array (0 .. size_t (count) - 1);
         cAvailableDevices : availableDevicesType;
         pragma Import (Ada, cAvailableDevices);
         for cAvailableDevices'Address use result;

         AdaAvailableDevices : sfArrayOfStrings (0 .. count - 1);

      begin
         for i in availableDevicesType'Range loop
            AdaAvailableDevices(sfSize_t(i)) := Ada.Strings.Unbounded.To_Unbounded_String
               (Interfaces.C.Strings.Value (cAvailableDevices(i)));
         end loop;

         return AdaAvailableDevices;
      end;
   end sfSoundRecorder_getAvailableDevices;


   --//////////////////////////////////////////////////////////
   --/ @brief Get the name of the default audio capture device
   --/
   --/ This function returns the name of the default audio
   --/ capture device. If none is available, NULL is returned.
   --/
   --/ @return The name of the default audio capture device (null terminated)
   --/
   --//////////////////////////////////////////////////////////
   function sfSoundRecorder_getDefaultDevice return String is
      function Internal return Interfaces.C.Strings.chars_ptr;
      pragma Import (C, Internal, "sfSoundRecorder_getDefaultDevice");
  begin

     return Interfaces.C.Strings.Value (Internal);
  end sfSoundRecorder_getDefaultDevice;

  --//////////////////////////////////////////////////////////
  --/ @brief Set the audio capture device
  --/
  --/ This function sets the audio capture device to the device
  --/ with the given name. It can be called on the fly (i.e:
  --/ while recording). If you do so while recording and
  --/ opening the device fails, it stops the recording.
  --/
  --/ @param soundRecorder Sound recorder object
  --/ @param name          The name of the audio capture device
  --/
  --/ @return sfTrue, if it was able to set the requested device
  --/
  --//////////////////////////////////////////////////////////
  function sfSoundRecorder_setDevice
    (soundRecorder : sfSoundRecorder_Ptr; name : String)
    return sfBool is

     function Internal
        (soundRecorder : sfSoundRecorder_Ptr; name : Interfaces.C.Strings.chars_ptr)
        return sfBool;
      pragma Import (C, Internal, "sfSoundRecorder_setDevice");

      Temp : Interfaces.C.Strings.chars_ptr := Interfaces.C.Strings.New_String (name);
      Result : sfBool := Internal (soundRecorder, Temp);
   begin
      Interfaces.C.Strings.Free (Temp);
      return Result;
  end sfSoundRecorder_setDevice;

  --//////////////////////////////////////////////////////////
  --/ @brief Get the name of the current audio capture device
  --/
  --/ @param soundRecorder Sound recorder object
  --/
  --/ @return The name of the current audio capture device
  --/
  --//////////////////////////////////////////////////////////
  function sfSoundRecorder_getDevice (soundRecorder : sfSoundRecorder_Ptr) return String is
     function Internal (soundRecorder : sfSoundRecorder_Ptr) return Interfaces.C.Strings.chars_ptr;
     pragma Import (C, Internal, "sfSoundRecorder_getDevice");
  begin

     return Interfaces.C.Strings.Value (Internal (soundRecorder));
  end sfSoundRecorder_getDevice;

end Sf.Audio.SoundRecorder;
