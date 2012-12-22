/* File generated automatically by dynamo */
/* The uri member holds the URI if the storage type is URL.

When storage is FILE, the local file path is built by using
the workspace identifier and the storage identifier. */
CREATE TABLE awa_storage (
  /* the storage identifier */
  `id` BIGINT PRIMARY KEY,
  /*  */
  `version` INTEGER ,
  /* the storage URI */
  `uri` VARCHAR(255) NOT NULL,
  /* the storage type which defines where the content is stored */
  `storage` TINYINT NOT NULL,
  /* the storage creation date */
  `create_date` DATETIME NOT NULL,
  /* the file name */
  `name` VARCHAR(255) NOT NULL,
  /* the file size */
  `file_size` INTEGER NOT NULL,
  /* the mime type */
  `mime_type` VARCHAR(255) NOT NULL,
  /*  */
  `owner_id` BIGINT NOT NULL,
  /*  */
  `store_data_id` BIGINT ,
  /*  */
  `folder_id` BIGINT ,
  /*  */
  `workspace_id` BIGINT NOT NULL,
  /*  */
  `original_id` BIGINT 
);
/* The storage data is created only if the storage type
is set to DATABASE.  It holds the file content in the blob. */
CREATE TABLE awa_storage_data (
  /* the storage data identifier */
  `id` BIGINT PRIMARY KEY,
  /* the storage content */
  `data`  NOT NULL,
  /*  */
  `version` INTEGER NOT NULL
);
/*  */
CREATE TABLE awa_storage_folder (
  /* the storage folder identifier */
  `id` BIGINT PRIMARY KEY,
  /*  */
  `name` VARCHAR(255) NOT NULL,
  /*  */
  `version` INTEGER NOT NULL,
  /* the folder creation date */
  `create_date` DATETIME NOT NULL,
  /*  */
  `owner_id` BIGINT NOT NULL,
  /*  */
  `workspace_id` BIGINT NOT NULL
);
/* The local store record is created when a copy of the data is needed on the local file system.
The creation date refers to the date when the data was copied to the local file system.
The expiration date indicates a date after which the local file can be removed
from the local file system. */
CREATE TABLE awa_store_local (
  /* the local store identifier */
  `id` BIGINT PRIMARY KEY,
  /* the local store path */
  `path` VARCHAR(255) NOT NULL,
  /* the creation date */
  `create_date` DATETIME NOT NULL,
  /* the local store expiration date */
  `expire_date` DATETIME NOT NULL,
  /*  */
  `version` INTEGER NOT NULL,
  /*  */
  `store_version` INTEGER NOT NULL,
  /* the shared flag which indicates whether this local store can be shared by several clients. */
  `shared` TINYINT NOT NULL,
  /*  */
  `storage_id` BIGINT 
);
INSERT INTO entity_type (name) VALUES ("awa_storage");
INSERT INTO entity_type (name) VALUES ("awa_storage_data");
INSERT INTO entity_type (name) VALUES ("awa_storage_folder");
INSERT INTO entity_type (name) VALUES ("awa_store_local");
