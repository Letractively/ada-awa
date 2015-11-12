## Introduction ##
The **blogs** plugin is a small blog application which allows users to publish articles.
A user may own several blogs, each blog having a name and its own base URI.  Within a blog,
the user may write articles and publish them.  Once published, the articles are visible to
anonymous users.

The **blogs** plugin uses the [AWA\_Tags](AWA_Tags.md) and [AWA\_Comments](AWA_Comments.md) modules to allow to associate
tags to a post and allow users to comment on the articles.

## Model ##
![http://ada-awa.googlecode.com/svn/wiki/awa_blogs_model.png](http://ada-awa.googlecode.com/svn/wiki/awa_blogs_model.png)

## Integration ##
The <tt>Blog_Module</tt> manages the creation, update, removal of blog posts in an application.
It provides operations that are used by the blog beans or other services to create and update
posts.  An instance of the <tt>Blog_Module</tt> must be declared and registered in the
AWA application.  The module instance can be defined as follows:

```
  type Application is new AWA.Applications.Application with record
     Blog_Module : aliased AWA.Blogs.Modules.Blog_Module;
  end record;
```

And registered in the `Initialize_Modules` procedure by using:

```
  Register (App    => App.Self.all'Access,
            Name   => AWA.Blogs.Modules.NAME,
            URI    => "blogs",
            Module => App.Blog_Module'Access);
```
## Blog Beans ##
Several bean types are provided to represent and manage the blogs and their posts.
The blog module registers the bean constructors when it is initialized.
To use them, one must declare a bean definition in the application XML configuration.

## Ada Beans ##
<table width='100%'>
<tr>
<th width='30%' align='left'>Name</th>
<th width='70%' align='left'>Description</th>
</tr>
<tr>
<td>post</td>
<td>This bean describes a blog post for the creation or the update</td>
</tr>
<tr>
<td>postList</td>
<td>This bean describes a blog post for the creation or the update</td>
</tr>
<tr>
<td>postStatusList</td>
<td>A localized list of post statuses to be used for a f:selectItems</td>
</tr>
<tr>
<td>adminBlog</td>
<td>The list of blogs and posts that the current user can access and update.</td>
</tr>
<tr>
<td>blog</td>
<td>Information about the current blog.</td>
</tr>
<tr>
<td>blogTagSearch</td>
<td>The blog tag search bean.</td>
</tr>
<tr>
<td>blogTagCloud</td>
<td>A list of tags associated with all post entities.</td>
</tr>
<tr>
<td>postComments</td>
<td>A list of comments associated with a post.</td>
</tr>
<tr>
<td>postNewComment</td>
<td>
The bean to allow a user to post a new comment.  This is a specific bean because<br>
the permission to create a new post is different from other permissions.  If the permission<br>
is granted, the comment will be created and put in the COMMENT_WAITING state.<br>
An email will be sent to the post author for approval.<br>
</td>
</tr>
<tr>
<td>blogPublishComment</td>
<td>
The bean to allow the blog administrator to change the publication status of a comment.<br>
</td>
</tr>
<tr>
<td>commentEdit</td>
<td>
The bean to allow a user to edit the comment.  This is a specific bean because<br>
the permission to edit the comment is different from other permissions.<br>
</td>
</tr>
</table><h3>Permissions</h3><table width='100%'>
<tr>
<th width='20%' align='left'>Name</th>
<th width='10%' align='left'>Name</th>
<th width='70%' align='left'>Description</th>
</tr>
<tr>
<td>blog-create</td>
<td>awa_workspace</td>
<td>Permission to create a new blog.</td>
</tr>
<tr>
<td>blog-delete</td>
<td>awa_blog</td>
<td>Permission to delete a blog.</td>
</tr>
<tr>
<td>blog-create-post</td>
<td>awa_blog</td>
<td>Permission to create a new post.</td>
</tr>
<tr>
<td>blog-update-post</td>
<td>awa_blog</td>
<td>Permission to modify a post.</td>
</tr>
<tr>
<td>blog-delete-post</td>
<td>awa_blog</td>
<td>Permission to delete a post.</td>
</tr>
<tr>
<td>blog-add-comment</td>
<td>awa_post</td>
<td></td>
</tr>
<tr>
<td>blog-publish-comment</td>
<td>awa_blog</td>
<td>Permission to change the publish status of a comment.</td>
</tr>
</table>


## Queries ##
<h4>AWA.Blogs.Models.Admin_Post_Info</h4><p>The Admin_Post_Info describes a post in the administration interface.</p><table width='100%'>
<tr>
<th width='15%' align='left'>Type</th>
<th width='15%' align='left'>Ada</th>
<th width='20%' align='left'>Name</th>
<th width='50%' align='left'>Description</th>
</tr>
<tr>
<td></td>
<td>Identifier</td>
<td></td>
<td>the post identifier.</td>
</tr>
<tr>
<td></td>
<td>String</td>
<td></td>
<td>the post title.</td>
</tr>
<tr>
<td></td>
<td>String</td>
<td></td>
<td>the post uri.</td>
</tr>
<tr>
<td></td>
<td>Date</td>
<td></td>
<td>the post publish date.</td>
</tr>
<tr>
<td></td>
<td>AWA.Blogs.Models.Post_Status_Type</td>
<td></td>
<td>the post status.</td>
</tr>
<tr>
<td></td>
<td>String</td>
<td></td>
<td>the user name.</td>
</tr>
<tr>
<td></td>
<td>Natural</td>
<td></td>
<td>the number of comments for this post.</td>
</tr>
</table>



<h4>AWA.Blogs.Models.Post_Info</h4><p>The Post_Info describes a post to be displayed in the blog page</p><table width='100%'>
<tr>
<th width='15%' align='left'>Type</th>
<th width='15%' align='left'>Ada</th>
<th width='20%' align='left'>Name</th>
<th width='50%' align='left'>Description</th>
</tr>
<tr>
<td></td>
<td>Identifier</td>
<td></td>
<td>the post identifier.</td>
</tr>
<tr>
<td></td>
<td>String</td>
<td></td>
<td>the post title.</td>
</tr>
<tr>
<td></td>
<td>String</td>
<td></td>
<td>the post uri.</td>
</tr>
<tr>
<td></td>
<td>Date</td>
<td></td>
<td>the post publish date.</td>
</tr>
<tr>
<td></td>
<td>String</td>
<td></td>
<td>the user name.</td>
</tr>
<tr>
<td></td>
<td>String</td>
<td></td>
<td>the post text.</td>
</tr>
<tr>
<td></td>
<td>Natural</td>
<td></td>
<td>the number of comments for this post.</td>
</tr>
</table>



<h4>AWA.Blogs.Models.Comment_Info</h4><p>The comment information.</p><table width='100%'>
<tr>
<th width='15%' align='left'>Type</th>
<th width='15%' align='left'>Ada</th>
<th width='20%' align='left'>Name</th>
<th width='50%' align='left'>Description</th>
</tr>
<tr>
<td></td>
<td>Identifier</td>
<td></td>
<td>the comment identifier.</td>
</tr>
<tr>
<td></td>
<td>Identifier</td>
<td></td>
<td>the post identifier.</td>
</tr>
<tr>
<td></td>
<td>String</td>
<td></td>
<td>the post title.</td>
</tr>
<tr>
<td></td>
<td>String</td>
<td></td>
<td>the comment author's name.</td>
</tr>
<tr>
<td></td>
<td>String</td>
<td></td>
<td>the comment author's email.</td>
</tr>
<tr>
<td></td>
<td>Date</td>
<td></td>
<td>the comment date.</td>
</tr>
<tr>
<td></td>
<td>AWA.Comments.Models.Status_Type</td>
<td></td>
<td>the comment status.</td>
</tr>
</table>



<h4>AWA.Blogs.Models.Blog_Info</h4><p>The list of blogs.</p><table width='100%'>
<tr>
<th width='15%' align='left'>Type</th>
<th width='15%' align='left'>Ada</th>
<th width='20%' align='left'>Name</th>
<th width='50%' align='left'>Description</th>
</tr>
<tr>
<td></td>
<td>Identifier</td>
<td></td>
<td>the blog identifier.</td>
</tr>
<tr>
<td></td>
<td>String</td>
<td></td>
<td>the blog title.</td>
</tr>
<tr>
<td></td>
<td>String</td>
<td></td>
<td>the blog uuid.</td>
</tr>
<tr>
<td></td>
<td>Date</td>
<td></td>
<td>the blog creation date.</td>
</tr>
<tr>
<td></td>
<td>Integer</td>
<td></td>
<td>the number of posts published.</td>
</tr>
</table>






---

[Generated by Dynamo](http://code.google.com/p/ada-gen) _from awa-blogs.ads_