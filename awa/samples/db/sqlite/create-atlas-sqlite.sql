/* Copied from ado-sqlite.sql*/
/* File generated automatically by dynamo */
/* Entity types */
CREATE TABLE entity_type (
  /* the entity type identifier */
  `ID` INTEGER PRIMARY KEY AUTOINCREMENT,
  /* the entity type name (table name) */
  `name` VARCHAR(127) UNIQUE NOT NULL
);
/* Sequence generator */
CREATE TABLE sequence (
  /* the sequence name */
  `name` VARCHAR(127) PRIMARY KEY,
  /* the sequence record version */
  `version` int ,
  /* the sequence value */
  `value` BIGINT ,
  /* the sequence block size */
  `block_size` BIGINT 
);
INSERT INTO entity_type (name) VALUES ("entity_type");
INSERT INTO entity_type (name) VALUES ("sequence");
/* Copied from awa-sqlite.sql*/
/* File generated automatically by dynamo */
/*  */
CREATE TABLE awa_message (
  /* the message identifier */
  `id` BIGINT PRIMARY KEY,
  /* the message creation date */
  `create_date` DATETIME NOT NULL,
  /* the message priority */
  `priority` INTEGER NOT NULL,
  /* the message count */
  `count` INTEGER NOT NULL,
  /* the message parameters */
  `parameters` VARCHAR(255) NOT NULL,
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
  `session_id` BIGINT 
);
/*  */
CREATE TABLE awa_message_type (
  /*  */
  `id` BIGINT PRIMARY KEY,
  /* the message type name */
  `name` VARCHAR(255) NOT NULL
);
/* The message queue tracks the event messages that must be dispatched by
a given server. */
CREATE TABLE awa_queue (
  /*  */
  `id` BIGINT PRIMARY KEY,
  /*  */
  `server_id` INTEGER NOT NULL,
  /* the message queue name */
  `name` VARCHAR(255) NOT NULL
);
/* The ACL table records permissions which are granted for a user to access a given database entity. */
CREATE TABLE awa_acl (
  /* the ACL identifier */
  `id` BIGINT PRIMARY KEY,
  /* the entity identifier to which the ACL applies */
  `entity_id` BIGINT NOT NULL,
  /* the writeable flag */
  `writeable` TINYINT NOT NULL,
  /*  */
  `user_id` BIGINT NOT NULL,
  /* the entity type concerned by the ACL. */
  `entity_type` INTEGER NOT NULL
);
/*  */
CREATE TABLE awa_access_key (
  /* the secure access key. */
  `access_key` VARCHAR(255) NOT NULL,
  /* the access key expiration date. */
  `expire_date` DATE NOT NULL,
  /* the access key identifier. */
  `id` BIGINT PRIMARY KEY,
  /*  */
  `version` INTEGER NOT NULL,
  /*  */
  `user_id` BIGINT NOT NULL
);
/* The Email entity defines the user email addresses.
The user has a primary email address that is obtained
from the registration process (either through a form
submission or through OpenID authentication). */
CREATE TABLE awa_email (
  /* the email address. */
  `email` VARCHAR(255) NOT NULL,
  /* the last mail delivery status (if known). */
  `status` TINYINT NOT NULL,
  /* the date when the last email error was detected. */
  `last_error_date` DATETIME NOT NULL,
  /*  */
  `version` INTEGER NOT NULL,
  /* the email primary key. */
  `id` BIGINT PRIMARY KEY,
  /* the user. */
  `user_id` BIGINT NOT NULL
);
/*  */
CREATE TABLE awa_session (
  /*  */
  `start_date` DATETIME NOT NULL,
  /*  */
  `end_date` DATETIME ,
  /*  */
  `ip_address` VARCHAR(255) NOT NULL,
  /*  */
  `stype` TINYINT NOT NULL,
  /*  */
  `version` INTEGER NOT NULL,
  /*  */
  `server_id` INTEGER NOT NULL,
  /*  */
  `id` BIGINT PRIMARY KEY,
  /*  */
  `auth_id` BIGINT ,
  /*  */
  `user_id` BIGINT NOT NULL
);
/* The User entity represents a user that can access and use the application.
 */
CREATE TABLE awa_user (
  /* the user first name. */
  `first_name` VARCHAR(255) NOT NULL,
  /* the user last name. */
  `last_name` VARCHAR(255) NOT NULL,
  /* the user password hash. */
  `password` VARCHAR(255) NOT NULL,
  /* the user OpenID identifier. */
  `open_id` VARCHAR(255) NOT NULL,
  /* the user country. */
  `country` VARCHAR(255) NOT NULL,
  /* the user display name. */
  `name` VARCHAR(255) NOT NULL,
  /* version number. */
  `version` INTEGER NOT NULL,
  /* the user identifier. */
  `id` BIGINT PRIMARY KEY,
  /*  */
  `email_id` BIGINT NOT NULL
);
INSERT INTO entity_type (name) VALUES ("awa_message");
INSERT INTO entity_type (name) VALUES ("awa_message_type");
INSERT INTO entity_type (name) VALUES ("awa_queue");
INSERT INTO entity_type (name) VALUES ("awa_acl");
INSERT INTO entity_type (name) VALUES ("awa_access_key");
INSERT INTO entity_type (name) VALUES ("awa_email");
INSERT INTO entity_type (name) VALUES ("awa_session");
INSERT INTO entity_type (name) VALUES ("awa_user");
/* Copied from awa-workspaces-sqlite.sql*/
/* File generated automatically by dynamo */
/* The workspace controls the features available in the application
for a set of users: the workspace members.  A user could create
several workspaces and be part of several workspaces that other
users have created. */
CREATE TABLE awa_workspace (
  /* the workspace identifier */
  `id` BIGINT PRIMARY KEY,
  /*  */
  `version` INTEGER NOT NULL,
  /*  */
  `create_date` DATETIME NOT NULL,
  /*  */
  `owner_id` BIGINT NOT NULL
);
/*  */
CREATE TABLE awa_workspace_feature (
  /*  */
  `id` BIGINT PRIMARY KEY,
  /*  */
  `limit` INTEGER NOT NULL,
  /*  */
  `workspace_id` BIGINT NOT NULL
);
/* The workspace member indicates the users who
are part of the workspace. */
CREATE TABLE awa_workspace_member (
  /*  */
  `id` BIGINT PRIMARY KEY,
  /*  */
  `member_id` BIGINT NOT NULL,
  /*  */
  `workspace_id` BIGINT NOT NULL
);
INSERT INTO entity_type (name) VALUES ("awa_workspace");
INSERT INTO entity_type (name) VALUES ("awa_workspace_feature");
INSERT INTO entity_type (name) VALUES ("awa_workspace_member");
/* Copied from awa-tags-sqlite.sql*/
/* File generated automatically by dynamo */
/* The tag definition. */
CREATE TABLE awa_tag (
  /* the tag identifier */
  `id` BIGINT PRIMARY KEY,
  /* the tag name */
  `name` VARCHAR(255) NOT NULL
);
/*  */
CREATE TABLE awa_tagged_entity (
  /* the tag entity identifier */
  `id` BIGINT PRIMARY KEY,
  /* Title: Tag model
Date: 2013-02-23the database entity to which the tag is associated */
  `for_entity_id` BIGINT NOT NULL,
  /* the entity type */
  `entity_type` INTEGER NOT NULL,
  /*  */
  `tag_id` BIGINT NOT NULL
);
INSERT INTO entity_type (name) VALUES ("awa_tag");
INSERT INTO entity_type (name) VALUES ("awa_tagged_entity");
/* Copied from awa-comments-sqlite.sql*/
/* File generated automatically by dynamo */
/* The Comment table records a user comment associated with a database entity.
The comment can be associated with any other database record. */
CREATE TABLE awa_comment (
  /* the comment publication date */
  `create_date` DATETIME NOT NULL,
  /* the comment message. */
  `message` TEXT NOT NULL,
  /* the entity identifier to which this comment is associated */
  `entity_id` BIGINT ,
  /* the comment identifier */
  `id` BIGINT PRIMARY KEY,
  /* the optimistic lock version. */
  `version` INTEGER NOT NULL,
  /* the entity type that identifies the table to which the comment is associated. */
  `entity_type` INTEGER NOT NULL,
  /* the comment status to decide whether the comment is visible (published) or not. */
  `status` integer NOT NULL,
  /* the comment format type. */
  `format` integer NOT NULL,
  /*  */
  `author_id` BIGINT NOT NULL
);
INSERT INTO entity_type (name) VALUES ("awa_comment");
/* Copied from awa-blogs-sqlite.sql*/
/* File generated automatically by dynamo */
/*  */
CREATE TABLE awa_blog (
  /* the blog identifier */
  `id` BIGINT PRIMARY KEY,
  /* the blog name */
  `name` VARCHAR(255) NOT NULL,
  /* the version */
  `version` INTEGER NOT NULL,
  /* the blog uuid */
  `uid` VARCHAR(255) NOT NULL,
  /* the blog creation date */
  `create_date` DATETIME NOT NULL,
  /* the date when the blog was updated */
  `update_date` DATETIME NOT NULL,
  /* The blog base URL. */
  `url` VARCHAR(255) NOT NULL,
  /* the workspace that this blog belongs to */
  `workspace_id` BIGINT NOT NULL
);
/*  */
CREATE TABLE awa_post (
  /* the post identifier */
  `id` BIGINT PRIMARY KEY,
  /* the post title */
  `title` VARCHAR(255) NOT NULL,
  /* the post text content */
  `text` TEXT NOT NULL,
  /* the post creation date */
  `create_date` DATETIME NOT NULL,
  /* the post URI */
  `uri` VARCHAR(255) NOT NULL,
  /*  */
  `version` INTEGER NOT NULL,
  /* the post publication date */
  `publish_date` DATETIME ,
  /* the post status */
  `status` TINYINT NOT NULL,
  /*  */
  `allow_comments` TINYINT NOT NULL,
  /*  */
  `author_id` BIGINT NOT NULL,
  /*  */
  `blog_id` BIGINT NOT NULL
);
INSERT INTO entity_type (name) VALUES ("awa_blog");
INSERT INTO entity_type (name) VALUES ("awa_post");
/* Copied from awa-storages-sqlite.sql*/
/* File generated automatically by dynamo */
/* The uri member holds the URI if the storage type is URL.

When storage is FILE, the local file path is built by using
the workspace identifier and the storage identifier. */
CREATE TABLE awa_storage (
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
  /* the storage URI */
  `uri` VARCHAR(255) NOT NULL,
  /*  */
  `version` INTEGER NOT NULL,
  /* the storage identifier */
  `id` BIGINT PRIMARY KEY,
  /*  */
  `original_id` BIGINT ,
  /*  */
  `store_data_id` BIGINT ,
  /*  */
  `owner_id` BIGINT NOT NULL,
  /*  */
  `workspace_id` BIGINT NOT NULL,
  /*  */
  `folder_id` BIGINT 
);
/* The storage data is created only if the storage type
is set to DATABASE.  It holds the file content in the blob. */
CREATE TABLE awa_storage_data (
  /* the storage data identifier */
  `id` BIGINT PRIMARY KEY,
  /*  */
  `version` INTEGER NOT NULL,
  /* the storage content */
  `data` LONGBLOB NOT NULL
);
/*  */
CREATE TABLE awa_storage_folder (
  /* the storage folder identifier */
  `id` BIGINT PRIMARY KEY,
  /*  */
  `version` INTEGER NOT NULL,
  /* the folder creation date */
  `create_date` DATETIME NOT NULL,
  /*  */
  `name` VARCHAR(255) NOT NULL,
  /*  */
  `workspace_id` BIGINT NOT NULL,
  /*  */
  `owner_id` BIGINT NOT NULL
);
/* The local store record is created when a copy of the data is needed on the local file system.
The creation date refers to the date when the data was copied to the local file system.
The expiration date indicates a date after which the local file can be removed
from the local file system. */
CREATE TABLE awa_store_local (
  /* the local store identifier */
  `id` BIGINT PRIMARY KEY,
  /*  */
  `version` INTEGER NOT NULL,
  /*  */
  `store_version` INTEGER NOT NULL,
  /* the shared flag which indicates whether this local store can be shared by several clients. */
  `shared` TINYINT NOT NULL,
  /* the local store path */
  `path` VARCHAR(255) NOT NULL,
  /* the local store expiration date */
  `expire_date` DATE NOT NULL,
  /* the creation date */
  `create_date` DATETIME NOT NULL,
  /*  */
  `storage_id` BIGINT 
);
INSERT INTO entity_type (name) VALUES ("awa_storage");
INSERT INTO entity_type (name) VALUES ("awa_storage_data");
INSERT INTO entity_type (name) VALUES ("awa_storage_folder");
INSERT INTO entity_type (name) VALUES ("awa_store_local");
/* Copied from awa-images-sqlite.sql*/
/* File generated automatically by dynamo */
/* An image that was uploaded by a user in an image folder. */
CREATE TABLE awa_image (
  /* the image identifier. */
  `id` BIGINT PRIMARY KEY,
  /* the image version. */
  `version` int ,
  /* the image width. */
  `width` INTEGER NOT NULL,
  /* the image height. */
  `height` INTEGER NOT NULL,
  /* the image thumbnail height. */
  `thumb_height` INTEGER NOT NULL,
  /* the image thumbnail width. */
  `thumb_width` INTEGER NOT NULL,
  /* the thumbnail image to display the image is an image selector. */
  `thumbnail_id` INTEGER ,
  /* the image storage file. */
  `storage_id` INTEGER NOT NULL
);
INSERT INTO entity_type (name) VALUES ("awa_image");
/* Copied from awa-votes-sqlite.sql*/
/* File generated automatically by dynamo */
/*  */
CREATE TABLE awa_rating (
  /* the rating identifier */
  `id` BIGINT PRIMARY KEY,
  /* the rating taking into account all votes */
  `rating` INTEGER NOT NULL,
  /* the number of votes */
  `vote_count` INTEGER NOT NULL,
  /*  */
  `for_entity_id` BIGINT NOT NULL,
  /* the entity type */
  `for_entity_type` INTEGER NOT NULL
);
/* The vote table tracks a vote action by a user on a given database entity.
The primary key is made of the user, the entity id and entity type.
 */
CREATE TABLE awa_vote (
  /*  */
  `rating` INTEGER NOT NULL,
  /*  */
  `id` BIGINT PRIMARY KEY,
  /*  */
  `entity_id` BIGINT NOT NULL,
  /*  */
  `user_id` BIGINT NOT NULL
);
INSERT INTO entity_type (name) VALUES ("awa_rating");
INSERT INTO entity_type (name) VALUES ("awa_vote");
/* Copied from awa-questions-sqlite.sql*/
/* File generated automatically by dynamo */
/* The answer table gives a list of anwsers to the question.
Ranking is updating according to users voting for the anwser.
 */
CREATE TABLE awa_answer (
  /* the answer creation date. */
  `create_date` DATETIME NOT NULL,
  /* the date when the answer was edited. */
  `edit_date` DATETIME ,
  /* the answer text. */
  `answer` TEXT NOT NULL,
  /* the anwser rank number. */
  `rank` INTEGER NOT NULL,
  /* the answer identifier. */
  `id` BIGINT PRIMARY KEY,
  /*  */
  `version` INTEGER NOT NULL,
  /* the user who wrote the answer. */
  `author_id` BIGINT NOT NULL,
  /*  */
  `question_id` BIGINT NOT NULL
);
/* The question table holds a single question asked by a user to the community.
The short description is used to give an overview of the question in long lists
while the description contains the full question text.  The rating is updating
according to users voting for the question. */
CREATE TABLE awa_question (
  /* the date when the question was created. */
  `create_date` DATETIME NOT NULL,
  /* the question title. */
  `title` VARCHAR(255) NOT NULL,
  /* the full description. */
  `description` TEXT NOT NULL,
  /* the date when the question was edited. */
  `edit_date` DATETIME ,
  /* Title: Questions and Answers model
Date: 2014-01-01
the question short description. */
  `short_description` VARCHAR(255) NOT NULL,
  /* the question rating. */
  `rating` INTEGER NOT NULL,
  /* the question identifier. */
  `id` BIGINT PRIMARY KEY,
  /* the optimistic locking version. */
  `version` INTEGER NOT NULL,
  /* the user who asked the question. */
  `author_id` BIGINT NOT NULL,
  /*  */
  `workspace_id` BIGINT NOT NULL,
  /*  */
  `accepted_answer_id` BIGINT 
);
INSERT INTO entity_type (name) VALUES ("awa_answer");
INSERT INTO entity_type (name) VALUES ("awa_question");
/* Copied from atlas-sqlite.sql*/
/* File generated automatically by dynamo */
/* The Mblog table holds the message posted by users.
Once posted, the message is not supposed to be changed. */
CREATE TABLE mblog (
  /*  */
  `id` BIGINT PRIMARY KEY,
  /*  */
  `version` INTEGER NOT NULL,
  /* the microblog message */
  `message` VARCHAR(255) NOT NULL,
  /*  */
  `creation_date` DATETIME NOT NULL,
  /* the post author */
  `author_id` BIGINT NOT NULL
);
/* the table that contains the reviews made by users. */
CREATE TABLE atlas_review (
  /* the review identifier */
  `id` BIGINT PRIMARY KEY,
  /*  */
  `version` INTEGER NOT NULL,
  /* the review title. */
  `title` VARCHAR(255) NOT NULL,
  /* the review description */
  `text` VARCHAR(65535) NOT NULL,
  /* the review creation date. */
  `create_date` DATETIME NOT NULL,
  /* whether comments are allowed. */
  `allow_comments` INTEGER NOT NULL,
  /* the site, article or application being reviewed. */
  `site` VARCHAR(255) NOT NULL,
  /*  */
  `reviewer_id` BIGINT NOT NULL
);
INSERT INTO entity_type (name) VALUES ("mblog");
INSERT INTO entity_type (name) VALUES ("atlas_review");
