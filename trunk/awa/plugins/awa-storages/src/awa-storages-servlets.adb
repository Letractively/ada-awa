-----------------------------------------------------------------------
--  awa-storages-servlets -- Serve files saved in the storage service
--  Copyright (C) 2012 Stephane Carrez
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--
--  Licensed under the Apache License, Version 2.0 (the "License");
--  you may not use this file except in compliance with the License.
--  You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
--  Unless required by applicable law or agreed to in writing, software
--  distributed under the License is distributed on an "AS IS" BASIS,
--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--  See the License for the specific language governing permissions and
--  limitations under the License.
-----------------------------------------------------------------------
with Ada.Strings.Unbounded;
with Ada.Calendar;

with Util.Log.Loggers;
with Util.Strings;

with ADO.Objects;

with ASF.Streams;

with AWA.Storages.Services;
with AWA.Storages.Modules;
package body AWA.Storages.Servlets is

   Log : constant Util.Log.Loggers.Logger := Util.Log.Loggers.Create ("AWA.Storages.Servlets");

   --  ------------------------------
   --  Called by the servlet container to indicate to a servlet that the servlet
   --  is being placed into service.
   --  ------------------------------
   overriding
   procedure Initialize (Server  : in out Storage_Servlet;
                         Context : in ASF.Servlets.Servlet_Registry'Class) is
   begin
      null;
   end Initialize;

   --  ------------------------------
   --  Called by the server (via the service method) to allow a servlet to handle
   --  a GET request.
   --
   --  Overriding this method to support a GET request also automatically supports
   --  an HTTP HEAD request. A HEAD request is a GET request that returns no body
   --  in the response, only the request header fields.
   --
   --  When overriding this method, read the request data, write the response headers,
   --  get the response's writer or output stream object, and finally, write the
   --  response data. It's best to include content type and encoding.
   --  When using a PrintWriter object to return the response, set the content type
   --  before accessing the PrintWriter object.
   --
   --  The servlet container must write the headers before committing the response,
   --  because in HTTP the headers must be sent before the response body.
   --
   --  Where possible, set the Content-Length header (with the
   --  Response.Set_Content_Length method), to allow the servlet container
   --  to use a persistent connection to return its response to the client,
   --  improving performance. The content length is automatically set if the entire
   --  response fits inside the response buffer.
   --
   --  When using HTTP 1.1 chunked encoding (which means that the response has a
   --  Transfer-Encoding header), do not set the Content-Length header.
   --
   --  The GET method should be safe, that is, without any side effects for which
   --  users are held responsible. For example, most form queries have no side effects.
   --  If a client request is intended to change stored data, the request should use
   --  some other HTTP method.
   --
   --  The GET method should also be idempotent, meaning that it can be safely repeated.
   --  Sometimes making a method safe also makes it idempotent. For example, repeating
   --  queries is both safe and idempotent, but buying a product online or modifying
   --  data is neither safe nor idempotent.
   --
   --  If the request is incorrectly formatted, Do_Get  returns an HTTP "Bad Request"
   --  ------------------------------
   overriding
   procedure Do_Get (Server   : in Storage_Servlet;
                     Request  : in out ASF.Requests.Request'Class;
                     Response : in out ASF.Responses.Response'Class) is
      URI     : constant String := Request.Get_Path_Info;
      Data    : ADO.Blob_Ref;
      Mime    : Ada.Strings.Unbounded.Unbounded_String;
      Name    : Ada.Strings.Unbounded.Unbounded_String;
      Date    : Ada.Calendar.Time;
      Manager : constant Services.Storage_Service_Access := Storages.Modules.Get_Storage_Manager;
      Id      : ADO.Identifier;
      Pos     : Natural;
   begin
      if URI'Length <= 1 or else URI (URI'First) /= '/' then
         Log.Info ("Invalid storage URI: {0}", URI);
         Response.Send_Error (ASF.Responses.SC_NOT_FOUND);
         return;
      end if;

      --  Extract the storage identifier from the URI.
      Pos := Util.Strings.Index (URI, '/', URI'First + 1);
      if Pos <= 0 then
         Pos := URI'Last;
      else
         Pos := Pos - 1;
      end if;
      Id := ADO.Identifier'Value (URI (URI'First + 1 .. Pos));

      Log.Info ("GET storage file {0}", URI);
      Manager.Load (From => Id, Name => Name, Mime => Mime, Date => Date, Into => Data);

      --  Send the file.
      Response.Set_Content_Type (Ada.Strings.Unbounded.To_String (Mime));
      if Ada.Strings.Unbounded.Length (Name) > 0 then
         Response.Add_Header ("Content-Disposition",
                              "attachment; filename=" & Ada.Strings.Unbounded.To_String (Name));
      end if;
      declare
         Output : ASF.Streams.Print_Stream := Response.Get_Output_Stream;
      begin
         Output.Write (Data.Value.Data);
      end;

   exception
      when ADO.Objects.NOT_FOUND | Constraint_Error =>
         Log.Info ("Storage file {0} not found", URI);
         Response.Send_Error (ASF.Responses.SC_NOT_FOUND);
         return;
   end Do_Get;

end AWA.Storages.Servlets;
