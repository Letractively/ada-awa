/* Copied from awa-mysql.sql*/
/* File generated automatically by dynamo */
/*  */
CREATE TABLE awa_message (
  /* the message identifier */
  `id` BIGINT NOT NULL,
  /* the message creation date */
  `create_date` DATETIME NOT NULL,
  /* the message priority */
  `priority` INTEGER NOT NULL,
  /* the message count */
  `count` INTEGER NOT NULL,
  /* the message parameters */
  `parameters` VARCHAR(255) BINARY NOT NULL,
  /* the server identifier which processes the message */
  `server_id` INTEGER NOT NULL,
  /* the task identfier on the server which processes the message */
  `task_id` INTEGER NOT NULL,
  /* the message status */
  `status` TINYINT NOT NULL,
  /* the message processing date */
  `processing_date` DATETIME ,
  /*  */
  `version` INTEGER NOT NULL,
  /* the entity identifier to which this event is associated. */
  `entity_id` BIGINT NOT NULL,
  /* the entity type of the entity identifier to which this event is associated. */
  `entity_type` INTEGER NOT NULL,
  /* the date and time when the event was finished to be processed. */
  `finish_date` DATETIME ,
  /*  */
  `queue_id` BIGINT NOT NULL,
  /* the message type */
  `message_type_id` BIGINT NOT NULL,
  /* the optional user who triggered the event message creation */
  `user_id` BIGINT ,
  /* the optional user session that triggered the message creation */
  `session_id` BIGINT ,
  PRIMARY KEY (`id`)
);
/*  */
CREATE TABLE awa_message_type (
  /*  */
  `id` BIGINT NOT NULL,
  /* the message type name */
  `name` VARCHAR(255) BINARY NOT NULL,
  PRIMARY KEY (`id`)
);
/* The message queue tracks the event messages that must be dispatched by
a given server. */
CREATE TABLE awa_queue (
  /*  */
  `id` BIGINT NOT NULL,
  /*  */
  `server_id` INTEGER NOT NULL,
  /* the message queue name */
  `name` VARCHAR(255) BINARY NOT NULL,
  PRIMARY KEY (`id`)
);
/* The ACL table records permissions which are granted for a user to access a given database entity. */
CREATE TABLE awa_acl (
  /* the ACL identifier */
  `id` BIGINT NOT NULL,
  /* the entity identifier to which the ACL applies */
  `entity_id` BIGINT NOT NULL,
  /* the writeable flag */
  `writeable` TINYINT NOT NULL,
  /*  */
  `user_id` BIGINT NOT NULL,
  /* the entity type concerned by the ACL. */
  `entity_type` INTEGER NOT NULL,
  PRIMARY KEY (`id`)
);
/*  */
CREATE TABLE awa_access_key (
  /* the secure access key. */
  `access_key` VARCHAR(255) BINARY NOT NULL,
  /* the access key expiration date. */
  `expire_date` DATETIME NOT NULL,
  /* the access key identifier. */
  `id` BIGINT NOT NULL,
  /*  */
  `version` INTEGER NOT NULL,
  /*  */
  `user_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`)
);
/* The Email entity defines the user email addresses.
The user has a primary email address that is obtained
from the registration process (either through a form
submission or through OpenID authentication). */
CREATE TABLE awa_email (
  /* the email address. */
  `email` VARCHAR(255) BINARY NOT NULL,
  /* the last mail delivery status (if known). */
  `status` TINYINT NOT NULL,
  /* the date when the last email error was detected. */
  `last_error_date` DATETIME NOT NULL,
  /*  */
  `version` INTEGER NOT NULL,
  /* the email primary key. */
  `id` BIGINT NOT NULL,
  /* the user. */
  `user_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`)
);
/*  */
CREATE TABLE awa_session (
  /*  */
  `start_date` DATETIME NOT NULL,
  /*  */
  `end_date` DATETIME ,
  /*  */
  `ip_address` VARCHAR(255) BINARY NOT NULL,
  /*  */
  `stype` TINYINT NOT NULL,
  /*  */
  `version` INTEGER NOT NULL,
  /*  */
  `server_id` INTEGER NOT NULL,
  /*  */
  `id` BIGINT NOT NULL,
  /*  */
  `auth_id` BIGINT ,
  /*  */
  `user_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`)
);
/* The User entity represents a user that can access and use the application.
 */
CREATE TABLE awa_user (
  /* the user first name. */
  `first_name` VARCHAR(255) BINARY NOT NULL,
  /* the user last name. */
  `last_name` VARCHAR(255) BINARY NOT NULL,
  /* the user password hash. */
  `password` VARCHAR(255) BINARY NOT NULL,
  /* the user OpenID identifier. */
  `open_id` VARCHAR(255) BINARY NOT NULL,
  /* the user country. */
  `country` VARCHAR(255) BINARY NOT NULL,
  /* the user display name. */
  `name` VARCHAR(255) BINARY NOT NULL,
  /* version number. */
  `version` INTEGER NOT NULL,
  /* the user identifier. */
  `id` BIGINT NOT NULL,
  /*  */
  `email_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`)
);
INSERT INTO entity_type (name) VALUES
("awa_message")
,("awa_message_type")
,("awa_queue")
,("awa_acl")
,("awa_access_key")
,("awa_email")
,("awa_session")
,("awa_user")
;
/* Copied from ado-mysql.sql*/
/* File generated automatically by dynamo */
/* Entity types */
CREATE TABLE entity_type (
  /* the entity type identifier */
  `id` INTEGER  AUTO_INCREMENT,
  /* the entity type name (table name) */
  `name` VARCHAR(127) UNIQUE NOT NULL,
  PRIMARY KEY (`id`)
);
/* Sequence generator */
CREATE TABLE sequence (
  /* the sequence name */
  `name` VARCHAR(127) NOT NULL,
  /* the sequence record version */
  `version` int ,
  /* the sequence value */
  `value` BIGINT ,
  /* the sequence block size */
  `block_size` BIGINT ,
  PRIMARY KEY (`name`)
);
INSERT INTO entity_type (name) VALUES
("entity_type")
,("sequence")
;
/* Copied from awa-settings-mysql.sql*/
/* File generated automatically by dynamo */
/* The global setting holds some generic
application configuration parameter
which can be stored in the database.

The global setting can be specific to a server. */
CREATE TABLE awa_global_setting (
  /* the global setting identifier. */
  `id` BIGINT NOT NULL,
  /* the global setting value. */
  `value` VARCHAR(255) BINARY NOT NULL,
  /* the global setting optimistic lock version. */
  `version` INTEGER NOT NULL,
  /* the server to which this global setting applies. */
  `server_id` INTEGER NOT NULL,
  /* the setting that corresponds to this global setting. */
  `setting_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`)
);
/* The setting table defines all the possible settings
that an application manages.  This table is automatically
populated when an application starts. It is not modified.
 */
CREATE TABLE awa_setting (
  /* the setting identifier. */
  `id` BIGINT NOT NULL,
  /* the setting name. */
  `name` VARCHAR(255) BINARY NOT NULL,
  PRIMARY KEY (`id`)
);
/* The user setting holds the setting value for a given user.
It is created the first time a user changes the default
setting value. It is updated when the user modifies the setting.

 */
CREATE TABLE awa_user_setting (
  /* the user setting identifier. */
  `id` BIGINT NOT NULL,
  /* the setting value. */
  `value` VARCHAR(255) BINARY NOT NULL,
  /* the setting optimistic lock version. */
  `version` INTEGER NOT NULL,
  /* the setting that correspond to the value. */
  `setting_id` BIGINT NOT NULL,
  /* the user to which the setting value is associated. */
  `user_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`)
);
INSERT INTO entity_type (name) VALUES
("awa_global_setting")
,("awa_setting")
,("awa_user_setting")
;
