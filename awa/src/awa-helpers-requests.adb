-----------------------------------------------------------------------
--  awa-helpers-requests -- Helpers for AWA applications
--  Copyright (C) 2011, 2012, 2013 Stephane Carrez
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

with ASF.Contexts.Faces;
package body AWA.Helpers.Requests is

   --  ------------------------------
   --  Get the parameter identified by the given name and return it as an identifier.
   --  Returns NO_IDENTIFIER if the parameter does not exist or is not valid.
   --  ------------------------------
   function Get_Parameter (Name : in String) return ADO.Identifier is
      Ctx  : constant ASF.Contexts.Faces.Faces_Context_Access := ASF.Contexts.Faces.Current;
      P    : constant String := Ctx.Get_Parameter (Name);
   begin
      if P = "" then
         return ADO.NO_IDENTIFIER;
      else
         return ADO.Identifier'Value (P);
      end if;
   exception
      when others =>
         return ADO.NO_IDENTIFIER;
   end Get_Parameter;

   --  ------------------------------
   --  Get the parameter identified by the given name and return it as an integer.
   --  Returns the default value if the parameter does not exist or is not valid.
   --  ------------------------------
   function Get_Parameter (Name    : in String;
                           Default : in Integer) return Integer is
      Ctx  : constant ASF.Contexts.Faces.Faces_Context_Access := ASF.Contexts.Faces.Current;
      P    : constant String := Ctx.Get_Parameter (Name);
   begin
      if P = "" then
         return Default;
      else
         return Integer'Value (P);
      end if;
   exception
      when others =>
         return Default;
   end Get_Parameter;

end AWA.Helpers.Requests;