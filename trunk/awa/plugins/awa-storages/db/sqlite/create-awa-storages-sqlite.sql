/* Copied from awa-storages-sqlite.sql*/
/* File generated automatically by dynamo */
/* The database storage data when the storage type is DATABASE. */
CREATE TABLE awa_storage (
  /* the storage identifier */
  `id` INTEGER PRIMARY KEY,
  /* the storage data version. */
  `version` int ,
  /* the local store creation date */
  `create_date` DATETIME NOT NULL,
  /* the storage type. */
  `storage_type` INTEGER NOT NULL,
  /* the storage specific URI */
  `uri` VARCHAR(256) NOT NULL,
  /* the storage that this local store refers to. */
  `storage_id` INTEGER NOT NULL,
  /* the workspace that this storage belongs to. */
  `workspace_id` INTEGER NOT NULL
);
/* The database storage data when the storage type is DATABASE. */
CREATE TABLE awa_storage_data (
  /* the storage data identifier */
  `id` INTEGER PRIMARY KEY,
  /* the storage data version. */
  `version` int ,
  /* the storage data when the storage type is DATABASE. */
  `data` BLOB NOT NULL
);
/* The local store record is created when a copy of the data
is needed on the local file system.  The creation date refers to the date when
the data was copied on the local file system.  The expiration date indicates a
date after which the local file can be removed from the local file system. */
CREATE TABLE awa_store_local (
  /* the local storage identifier */
  `id` INTEGER PRIMARY KEY,
  /* the local storage version. */
  `version` int ,
  /* the local store creation date */
  `create_date` DATETIME NOT NULL,
  /* the local store expiration date */
  `expire_date` DATETIME NOT NULL,
  /* the local store path */
  `path` VARCHAR(256) NOT NULL,
  /* the storage version that this local store represents */
  `store_version` INTEGER NOT NULL,
  /* whether the local store file can be shared or not */
  `shared` TINYINT NOT NULL,
  /* the storage that this local store refers to. */
  `storage_id` INTEGER NOT NULL
);
INSERT INTO entity_type (name) VALUES ("awa_storage");
INSERT INTO entity_type (name) VALUES ("awa_storage_data");
INSERT INTO entity_type (name) VALUES ("awa_store_local");
