/*
 *  awa-storages -- Storages and folders
 *  Copyright (C) 2012 Stephane Carrez
 *  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
var AWA = {};

function init_folder_list(id, idCreate, idCurrent) {
    $(id).list({
        actionId: null,
        itemPrefix: 'folder-',
        editUrl: contextPath + '/storages/forms/create-folder-form.html',
        currentItem: '#folder-' + idCurrent,
        selectAction: function(element, item) {
            var id = element.getSelectedId(item);
            return ASF.Update(this, contextPath + '/storages/lists/documents.html?folderId=' + id, '#document-list-editor');
        }
    });
}