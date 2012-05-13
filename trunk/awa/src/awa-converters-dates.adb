-----------------------------------------------------------------------
--  awa-converters-dates -- Date Converters
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
with Ada.Calendar;
with Ada.Exceptions;
with Ada.Strings.Unbounded;

with Util.Locales;
with Util.Log.Loggers;
with Util.Dates.Formats;
with Util.Properties.Bundles;
with Util.Beans.Objects.Time;

with ASF.Locales;
with ASF.Utils;
with ASF.Applications.Main;
package body AWA.Converters.Dates is

   --  The logger
   Log : constant Util.Log.Loggers.Logger := Util.Log.Loggers.Create ("AWA.Converters.Dates");

   ONE_HOUR : constant Duration := 3600.0;
   ONE_DAY  : constant Duration := 24 * ONE_HOUR;

   --  ------------------------------
   --  Convert the object value into a string.  The object value is associated
   --  with the specified component.
   --  If the string cannot be converted, the Invalid_Conversion exception should be raised.
   --  ------------------------------
   overriding
   function To_String (Convert   : in Relative_Date_Converter;
                       Context   : in ASF.Contexts.Faces.Faces_Context'Class;
                       Component : in ASF.Components.Base.UIComponent'Class;
                       Value     : in Util.Beans.Objects.Object) return String is
      Bundle  : ASF.Locales.Bundle;
      Locale  : constant Util.Locales.Locale := Context.Get_Locale;
   begin
      begin
         Context.Get_Application.Load_Bundle (Name   => "dates",
                                              Locale => Util.Locales.To_String (Locale),
                                              Bundle => Bundle);

      exception
         when E : Util.Properties.Bundles.NO_BUNDLE =>
            Component.Log_Error ("Cannot localize dates: {0}",
                                 Ada.Exceptions.Exception_Message (E));
      end;

      --  Convert the value as a date here so that we can raise an Invalid_Conversion exception.
      declare
         use Ada.Calendar;

         Date    : constant Ada.Calendar.Time := Util.Beans.Objects.Time.To_Time (Value);
         Now     : constant Ada.Calendar.Time := Ada.Calendar.Clock;
         Dt      : constant Duration := Now - Date;
         Values  : ASF.Utils.Object_Array (1 .. 1);
         Result  : Ada.Strings.Unbounded.Unbounded_String;
      begin
         if Dt < 60.0 then
            return Bundle.Get ("date_moment_ago");

         elsif Dt < 120.0 then
            return Bundle.Get ("date_minute_ago");

         elsif Dt < ONE_HOUR then
            Values (1) := Util.Beans.Objects.To_Object (Natural (Dt / 60.0));
            ASF.Utils.Formats.Format (Bundle.Get ("date_minutes_ago"),
                                      Values, Result);

         elsif Dt < 2 * ONE_HOUR then
            Values (1) := Util.Beans.Objects.To_Object (Natural (Dt / 60.0));
            ASF.Utils.Formats.Format (Bundle.Get ("date_hour_ago"),
                                      Values, Result);

         elsif Dt < ONE_DAY then
            Values (1) := Util.Beans.Objects.To_Object (Natural (Dt / ONE_HOUR));
            ASF.Utils.Formats.Format (Bundle.Get ("date_hours_ago"),
                                      Values, Result);

         elsif Dt < 2 * ONE_DAY then
            Values (1) := Util.Beans.Objects.To_Object (Natural (Dt / ONE_HOUR));
            ASF.Utils.Formats.Format (Bundle.Get ("date_day_ago"),
                                      Values, Result);

         elsif Dt < 7 * ONE_DAY then
            Values (1) := Util.Beans.Objects.To_Object (Natural (Dt / ONE_DAY));
            ASF.Utils.Formats.Format (Bundle.Get ("date_days_ago"),
                                      Values, Result);

         else
            declare
               use ASF.Converters.Dates;

               Pattern : constant String
                 := Date_Converter'Class (Convert).Get_Pattern (Context, Component);
            begin
               return Util.Dates.Formats.Format (Pattern, Date, Bundle);
            end;
         end if;
         return Ada.Strings.Unbounded.To_String (Result);
      end;

   exception
      when E : others =>
         raise ASF.Converters.Invalid_Conversion with Ada.Exceptions.Exception_Message (E);

   end To_String;

end AWA.Converters.Dates;
