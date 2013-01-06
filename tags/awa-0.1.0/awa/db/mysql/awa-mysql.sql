/* File generated automatically by dynamo */
/* Blog  */
CREATE TABLE blog (
  /* the blog identifier */
  `id` BIGINT NOT NULL,
  /*  */
  `version` int ,
  /* the blog name */
  `name` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`id`)
);
/* Post in a blog */
CREATE TABLE blog_post (
  /* the post identifier */
  `id` BIGINT NOT NULL,
  /*  */
  `version` int ,
  /* the post title */
  `title` VARCHAR(256) NOT NULL,
  /* the uri */
  `uri` VARCHAR(256) ,
  /* the blog text content */
  `text` VARCHAR(60000) ,
  /* the post creation date */
  `create_date` DATETIME NOT NULL,
  /*  */
  `author_id` INTEGER NOT NULL,
  /*  */
  `blog_id` INTEGER NOT NULL,
  PRIMARY KEY (`id`)
);
/*  */
CREATE TABLE comments (
  /*  */
  `id` INTEGER ,
  /*  */
  `version` int ,
  /*  */
  `date` TIMESTAMP NOT NULL,
  /*  */
  `message` VARCHAR(65000) NOT NULL,
  /*  */
  `entity_id` INTEGER NOT NULL,
  /*  */
  `user_fk` INTEGER NOT NULL,
  /*  */
  `entity__type_fk` INTEGER NOT NULL,
  PRIMARY KEY (`id`)
);
/* Email address */
CREATE TABLE email (
  /* the email id */
  `id` BIGINT NOT NULL,
  /*  */
  `version` int ,
  /* the email address */
  `email` VARCHAR(256) ,
  /* the user identifier */
  `user_id` BIGINT ,
  PRIMARY KEY (`id`)
);
/* Record representing a user */
CREATE TABLE user (
  /* the user id */
  `id` BIGINT NOT NULL,
  /*  */
  `version` int ,
  /* the open id */
  `openid` VARCHAR(256) ,
  /* the user name */
  `name` VARCHAR(256) ,
  /* the user first name */
  `first_name` VARCHAR(256) ,
  /* the user last name */
  `last_name` VARCHAR(256) ,
  /* the user last name */
  `password` VARCHAR(256) ,
  /* the user country */
  `country` VARCHAR(256) ,
  /*  */
  `email_id` INTEGER NOT NULL,
  PRIMARY KEY (`id`)
);
/* Defines an access key */
CREATE TABLE access_key (
  /* the email id */
  `id` BIGINT NOT NULL,
  /*  */
  `version` int ,
  /* the access key */
  `access_key` VARCHAR(256) ,
  /* the user identifier */
  `user_id` BIGINT ,
  PRIMARY KEY (`id`)
);
/* Defines an user session */
CREATE TABLE session (
  /* the user session id */
  `ID` BIGINT NOT NULL,
  /*  */
  `version` int ,
  /* the session start date */
  `START_DATE` DATETIME NOT NULL,
  /* the session start date */
  `END_DATE` DATETIME ,
  /* the IP address */
  `IP_ADDRESS` VARCHAR(255) NOT NULL,
  /* the user identifier */
  `USER_ID` BIGINT NOT NULL,
  /* the authentication session identifier */
  `AUTH_ID` BIGINT ,
  /* the session type */
  `TYPE` INTEGER NOT NULL,
  PRIMARY KEY (`ID`)
);
/* Access control */
CREATE TABLE acl (
  /* the unique ACL id */
  `id` BIGINT NOT NULL,
  /* the entity type */
  `entity_type` INTEGER ,
  /* the user identifier */
  `user_id` BIGINT ,
  /* the entity identifier */
  `entity_id` BIGINT ,
  /* whether the entity is writeable */
  `writeable` TINYINT ,
  PRIMARY KEY (`id`)
);
INSERT INTO entity_type (name) VALUES
("blog")
,("blog_post")
,("comments")
,("email")
,("user")
,("access_key")
,("session")
,("acl")
;