-----------------------------------------------------------------------
--  awa-tags -- Tags management
--  Copyright (C) 2013 Stephane Carrez
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

--  == Introduction ==
--  The <b>Tags</b> module allows to associate general purpose tags to any database entity.
--  It provides a JSF component that allows to insert easily a list of tags in a page and
--  in a form.  An application can use the bean types defined in <tt>AWA.Tags.Beans</tt>
--  to define the tags and it will use the <tt>awa:tagList</tt> component to display them.
--
--  == Model ==
--  [http://ada-awa.googlecode.com/svn/wiki/awa_tags_model.png]
--
--  @include awa-tags-modules.ads
--  @include awa-tags-beans.ads
--  @include awa-tags-components.ads
--
package AWA.Tags is

   pragma Pure;

end AWA.Tags;