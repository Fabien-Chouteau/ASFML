--//////////////////////////////////////////////////////////
-- //
-- // SFML - Simple and Fast Multimedia Library
-- // Copyright (C) 2007-2009 Laurent Gomila (laurent.gom@gmail.com)
-- //
-- // This software is provided 'as-is', without any express or implied warranty.
-- // In no event will the authors be held liable for any damages arising from the use of this software.
-- //
-- // Permission is granted to anyone to use this software for any purpose,
-- // including commercial applications, and to alter it and redistribute it freely,
-- // subject to the following restrictions:
-- //
-- // 1. The origin of this software must not be misrepresented;
-- //    you must not claim that you wrote the original software.
-- //    If you use this software in a product, an acknowledgment
-- //    in the product documentation would be appreciated but is not required.
-- //
-- // 2. Altered source versions must be plainly marked as such,
-- //    and must not be misrepresented as being the original software.
-- //
-- // 3. This notice may not be removed or altered from any source distribution.
-- //
--//////////////////////////////////////////////////////////

--//////////////////////////////////////////////////////////

--//////////////////////////////////////////////////////////
with Interfaces.C.Strings;

package body Sf.Network.Ftp is
   use Interfaces.C.Strings;

   --//////////////////////////////////////////////////////////
   --/ Get the full message contained in the response
   --/
   --/ @param FtpListingResponse   Ftp listing response
   --/
   --/ @return The response message
   --/
   --//////////////////////////////////////////////////////////
   function sfFtpListingResponse_GetMessage (FtpListingResponse : sfFtpListingResponse_Ptr) return String is
      function Internal (FtpListingResponse : sfFtpListingResponse_Ptr) return chars_ptr;
      pragma Import (C, Internal, "sfFtpListingResponse_getMessage");
      Temp : chars_ptr := Internal (FtpListingResponse);
      R    : String    := Value (Temp);
   begin
      Free (Temp);
      return R;
   end sfFtpListingResponse_GetMessage;

   --//////////////////////////////////////////////////////////
   --/ @brief Return a directory/file name contained in a FTP listing response
   --/
   --/ @param ftpListingResponse Ftp listing response
   --/ @param index              Index of the name to get (in range [0 .. getCount])
   --/
   --/ @return The requested name
   --/
   --//////////////////////////////////////////////////////////
   function sfFtpListingResponse_GetName (FtpListingResponse : sfFtpListingResponse_Ptr; Index : sfSize_t) return String is
      function Internal (FtpListingResponse : sfFtpListingResponse_Ptr; Index : sfSize_t) return chars_ptr;
      pragma Import (C, Internal, "sfFtpListingResponse_getName");
      Temp : chars_ptr := Internal (FtpListingResponse, Index);
      R    : String    := Value (Temp);
   begin
      Free (Temp);
      return R;
   end sfFtpListingResponse_GetName;

   --//////////////////////////////////////////////////////////
   --/ Get the full message contained in the response
   --/
   --/ @param FtpDirectoryResponse   Ftp directory response
   --/
   --/ @return The response message
   --/
   --//////////////////////////////////////////////////////////
   function sfFtpDirectoryResponse_GetMessage (FtpDirectoryResponse : sfFtpDirectoryResponse_Ptr) return String is
      function Internal (FtpDirectoryResponse : sfFtpDirectoryResponse_Ptr) return chars_ptr;
      pragma Import (C, Internal, "sfFtpDirectoryResponse_getMessage");
      Temp : chars_ptr := Internal (FtpDirectoryResponse);
      R    : String    := Value (Temp);
   begin
      Free (Temp);
      return R;
   end sfFtpDirectoryResponse_GetMessage;

   --//////////////////////////////////////////////////////////
   --/ Get the directory returned in the response
   --/
   --/ @param FtpDirectoryResponse   Ftp directory response
   --/
   --/ @return Directory name
   --/
   --//////////////////////////////////////////////////////////
   function sfFtpDirectoryResponse_GetDirectory (FtpDirectoryResponse : sfFtpDirectoryResponse_Ptr) return String is
      function Internal (FtpDirectoryResponse : sfFtpDirectoryResponse_Ptr) return chars_ptr;
      pragma Import (C, Internal, "sfFtpDirectoryResponse_getDirectory");
      Temp : chars_ptr := Internal (FtpDirectoryResponse);
      R    : String    := Value (Temp);
   begin
      Free (Temp);
      return R;
   end sfFtpDirectoryResponse_GetDirectory;

   --//////////////////////////////////////////////////////////
   --/ Get the full message contained in the response
   --/
   --/ @param FtpResponse   Ftp response
   --/
   --/ @return The response message
   --/
   --//////////////////////////////////////////////////////////
   function sfFtpResponse_GetMessage (FtpResponse : sfFtpResponse_Ptr) return String is
      function Internal (FtpResponse : sfFtpResponse_Ptr) return chars_ptr;
      pragma Import (C, Internal, "sfFtpResponse_getMessage");
      Temp : chars_ptr := Internal (FtpResponse);
      R    : String    := Value (Temp);
   begin
      Free (Temp);
      return R;
   end sfFtpResponse_GetMessage;

   function sfFtp_Login
     (ftp      : sfFtp_Ptr;
      name     : String;
      password : String)
      return     sfFtpResponse_Ptr
   is
      function Internal
        (Ftp      : sfFtp_Ptr;
         UserName : chars_ptr;
         Password : chars_ptr)
         return     sfFtpResponse_Ptr;
      pragma Import (C, Internal, "sfFtp_login");
      Temp1 : chars_ptr         := New_String (name);
      Temp2 : chars_ptr         := New_String (password);
      R     : sfFtpResponse_Ptr := Internal (Ftp, Temp1, Temp2);
   begin
      Free (Temp1);
      Free (Temp2);
      return R;
   end sfFtp_Login;

   --//////////////////////////////////////////////////////////
   --/ Get the contents of the given directory
   --/ (subdirectories and files)
   --/
   --/ @param Ftp         Ftp instance
   --/ @param Directory   Directory to list ("" by default, the current one)
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function sfFtp_GetDirectoryListing (Ftp : sfFtp_Ptr; Directory : String) return sfFtpListingResponse_Ptr is
      function Internal (Ftp : sfFtp_Ptr; Directory : chars_ptr) return sfFtpListingResponse_Ptr;
      pragma Import (C, Internal, "sfFtp_getDirectoryListing");
      Temp : chars_ptr                := New_String (Directory);
      R    : sfFtpListingResponse_Ptr := Internal (Ftp, Temp);
   begin
      Free (Temp);
      return R;
   end sfFtp_GetDirectoryListing;

   --//////////////////////////////////////////////////////////
   --/ Change the current working directory
   --/
   --/ @param Ftp         Ftp instance
   --/ @param Directory   New directory, relative to the current one
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function sfFtp_ChangeDirectory (Ftp : sfFtp_Ptr; Directory : String) return sfFtpResponse_Ptr is
      function Internal (Ftp : sfFtp_Ptr; Directory : chars_ptr) return sfFtpResponse_Ptr;
      pragma Import (C, Internal, "sfFtp_changeDirectory");
      Temp : chars_ptr         := New_String (Directory);
      R    : sfFtpResponse_Ptr := Internal (Ftp, Temp);
   begin
      Free (Temp);
      return R;
   end sfFtp_ChangeDirectory;


   --//////////////////////////////////////////////////////////
   --/ @brief Create a new directory
   --/
   --/ The new directory is created as a child of the current
   --/ working directory.
   --/
   --/ @param ftp  Ftp object
   --/ @param name Name of the directory to create
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function sfFtp_CreateDirectory (Ftp : sfFtp_Ptr; Name : String) return sfFtpResponse_Ptr is
      function Internal (Ftp : sfFtp_Ptr; Name : chars_ptr) return sfFtpResponse_Ptr;
      pragma Import (C, Internal, "sfFtp_createDirectory");
      Temp : chars_ptr         := New_String (Name);
      R    : sfFtpResponse_Ptr := Internal (Ftp, Temp);
   begin
      Free (Temp);
      return R;
   end sfFtp_CreateDirectory;

   --//////////////////////////////////////////////////////////
   --/ Remove an existing directory
   --/
   --/ @param Ftp    Ftp instance
   --/ @param Name   Name of the directory to remove
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function sfFtp_DeleteDirectory (Ftp : sfFtp_Ptr; Name : String) return sfFtpResponse_Ptr is
      function Internal (Ftp : sfFtp_Ptr; Name : chars_ptr) return sfFtpResponse_Ptr;
      pragma Import (C, Internal, "sfFtp_deleteDirectory");
      Temp : chars_ptr         := New_String (Name);
      R    : sfFtpResponse_Ptr := Internal (Ftp, Temp);
   begin
      Free (Temp);
      return R;
   end sfFtp_DeleteDirectory;

   --//////////////////////////////////////////////////////////
   --/ Rename a file
   --/
   --/ @param Ftp       Ftp instance
   --/ @param File      File to rename
   --/ @param NewName   New name
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function sfFtp_RenameFile
     (Ftp     : sfFtp_Ptr;
      File    : String;
      NewName : String)
      return    sfFtpResponse_Ptr
   is
      function Internal
        (Ftp     : sfFtp_Ptr;
         File    : chars_ptr;
         NewName : chars_ptr)
         return    sfFtpResponse_Ptr;
      pragma Import (C, Internal, "sfFtp_renameFile");
      Temp1 : chars_ptr         := New_String (File);
      Temp2 : chars_ptr         := New_String (NewName);
      R     : sfFtpResponse_Ptr := Internal (Ftp, Temp1, Temp2);
   begin
      Free (Temp1);
      Free (Temp2);
      return R;
   end sfFtp_RenameFile;

   --//////////////////////////////////////////////////////////
   --/ Remove an existing file
   --/
   --/ @param Ftp    Ftp instance
   --/ @param Name   File to remove
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function sfFtp_DeleteFile (Ftp : sfFtp_Ptr; Name : String) return sfFtpResponse_Ptr is
      function Internal (Ftp : sfFtp_Ptr; Name : chars_ptr) return sfFtpResponse_Ptr;
      pragma Import (C, Internal, "sfFtp_deleteFile");
      Temp : chars_ptr         := New_String (Name);
      R    : sfFtpResponse_Ptr := Internal (Ftp, Temp);
   begin
      Free (Temp);
      return R;
   end sfFtp_DeleteFile;

   function sfFtp_download
     (ftp        : sfFtp_Ptr;
      remoteFile : String;
      localPath  : String;
      mode       : sfFtpTransferMode) return sfFtpResponse_Ptr
   is
      function Internal
        (ftp         : sfFtp_Ptr;
         remoteFile  : chars_ptr;
         localPath   : chars_ptr;
         mode        : sfFtpTransferMode)
         return        sfFtpResponse_Ptr;
      pragma Import (C, Internal, "sfFtp_download");
      Temp1 : chars_ptr         := New_String (remoteFile);
      Temp2 : chars_ptr         := New_String (localPath);
      R     : sfFtpResponse_Ptr := Internal (ftp, Temp1, Temp2, Mode);
   begin
      Free (Temp1);
      Free (Temp2);
      return R;
   end sfFtp_Download;

   function sfFtp_upload
     (ftp        : sfFtp_Ptr;
      localFile  : String;
      remotePath : String;
      mode       : sfFtpTransferMode) return sfFtpResponse_Ptr
   is
      function Internal
        (ftp        : sfFtp_Ptr;
         localFile  : chars_ptr;
         remotePath : chars_ptr;
         mode       : sfFtpTransferMode)
         return      sfFtpResponse_Ptr;
      pragma Import (C, Internal, "sfFtp_upload");
      Temp1 : chars_ptr         := New_String (LocalFile);
      Temp2 : chars_ptr         := New_String (remotePath);
      R     : sfFtpResponse_Ptr := Internal (Ftp, Temp1, Temp2, Mode);
   begin
      Free (Temp1);
      Free (Temp2);
      return R;
   end sfFtp_Upload;

   --//////////////////////////////////////////////////////////
   --/ @brief Send a command to the FTP server
   --/
   --/ While the most often used commands are provided as
   --/ specific functions, this function can be used to send
   --/ any FTP command to the server. If the command requires
   --/ one or more parameters, they can be specified in
   --/ @a parameter. Otherwise you should pass NULL.
   --/ If the server returns information, you can extract it
   --/ from the response using sfResponse_getMessage().
   --/
   --/ @param ftp       Ftp object
   --/ @param command   Command to send
   --/ @param parameter Command parameter
   --/
   --/ @return Server response to the request
   --/
   --//////////////////////////////////////////////////////////
   function sfFtp_sendCommand
     (ftp       : sfFtp_Ptr;
      command   : String;
      parameter : String)
     return      sfFtpResponse_Ptr is
      function Internal
        (Ftp       : sfFtp_Ptr;
         command   : chars_ptr;
         parameter : chars_ptr)
        return      sfFtpResponse_Ptr;
      pragma Import (C, Internal, "sfFtp_sendCommand");
      Temp1 : chars_ptr         := New_String (command);
      Temp2 : chars_ptr         := New_String (parameter);
      R     : sfFtpResponse_Ptr := Internal (Ftp, Temp1, Temp2);
   begin
      Free (Temp1);
      Free (Temp2);
      return R;
   end sfFtp_sendCommand;

end Sf.Network.Ftp;
