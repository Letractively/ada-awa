## Introduction ##
The <b>Users.Module</b> manages the creation, update, removal and authentication of users
in an application.  The module provides the foundations for user management in
a web application.

A user can register himself by using a subscription form.  In that case, a verification mail
is sent and the user has to follow the verification link defined in the mail to finish
the registration process.  The user will authenticate using a password.

A user can also use an OpenID account and be automatically registered.

A user can have one or several permissions that allow to protect the application data.
User permissions are managed by the <b>Permissions.Module</b>.

## Configuration ##
The **users** module uses a set of configuration properties to configure the OpenID
integration.

<table width='100%'>
<tr>
<th width='30%' align='left'>Name</th>
<th width='70%' align='left'>Description</th>
</tr>
<tr>
<td>login</td>
<td>This bean is used by the login form</td>
</tr>
<tr>
<td>register</td>
<td>This bean is used by the registration form</td>
</tr>
<tr>
<td>resetPassword</td>
<td>This bean is used by the reset password form</td>
</tr>
<tr>
<td>lostPassword</td>
<td>This bean is used by the lost password form</td>
</tr>
<tr>
<td>logout</td>
<td>This bean is used by the logout process</td>
</tr>
<tr>
<td>user</td>
<td>This bean allows to provide information about the current logged user.</td>
</tr>
</table><h3>Configuration</h3><table width='100%'>
<tr>
<th width='30%' align='left'>Name</th>
<th width='70%' align='left'>Description</th>
</tr>
<tr>
<td>openid.realm</td>
<td>
The REALM URL used by OpenID providers to verify the validity of the verification callback.<br>
</td>
</tr>
<tr>
<td></td>
<td><tt>#{app_url_base}#{contextPath}/auth</tt></td>
</tr>
<tr>
<td>openid.callback_url</td>
<td>
The verification callback URI used by the OpenID provider to redirect the user<br>
after authentication.<br>
</td>
</tr>
<tr>
<td></td>
<td><tt>#{app_url_base}#{contextPath}/auth/verify</tt></td>
</tr>
<tr>
<td>openid.success_url</td>
<td>
The URI where the user is redirected after a successful authentication.<br>
</td>
</tr>
<tr>
<td></td>
<td><tt>#{contextPath}/workspaces/main.html</tt></td>
</tr>
<tr>
<td>auth.url.orange</td>
<td>Orange OpenID access point</td>
</tr>
<tr>
<td></td>
<td><tt><a href='http://openid.orange.fr'>http://openid.orange.fr</a></tt></td>
</tr>
<tr>
<td>auth.provider.orange</td>
<td>Auth provider to use for Orange</td>
</tr>
<tr>
<td></td>
<td><tt>openid</tt></td>
</tr>
<tr>
<td>auth.url.yahoo</td>
<td>Yahoo! OpenID access point</td>
</tr>
<tr>
<td></td>
<td><tt><a href='http://open.login.yahooapis.com/openid20/www.yahoo.com/xrds'>http://open.login.yahooapis.com/openid20/www.yahoo.com/xrds</a></tt></td>
</tr>
<tr>
<td>auth.provider.yahoo</td>
<td>Auth provider to use for Yahoo!</td>
</tr>
<tr>
<td></td>
<td><tt>openid</tt></td>
</tr>
<tr>
<td>auth.url.google</td>
<td>Google OpenID access point</td>
</tr>
<tr>
<td></td>
<td><tt><a href='https://www.google.com/accounts/o8/id'>https://www.google.com/accounts/o8/id</a></tt></td>
</tr>
<tr>
<td>auth.provider.google</td>
<td>Auth provider to use for Google</td>
</tr>
<tr>
<td></td>
<td><tt>openid</tt></td>
</tr>
<tr>
<td>auth.url.facebook</td>
<td>Facebook OAuth access point</td>
</tr>
<tr>
<td></td>
<td><tt><a href='https://www.facebook.com/dialog/oauth'>https://www.facebook.com/dialog/oauth</a></tt></td>
</tr>
<tr>
<td>auth.provider.facebook</td>
<td>Auth provider to use for Facebook</td>
</tr>
<tr>
<td></td>
<td><tt>facebook</tt></td>
</tr>
<tr>
<td>facebook.callback_url</td>
<td>Facebook verify callback</td>
</tr>
<tr>
<td></td>
<td><tt>#{app_oauth_url_base}#{contextPath}/auth/verify</tt></td>
</tr>
<tr>
<td>facebook.request_url</td>
<td>Facebook request OAuth token access point</td>
</tr>
<tr>
<td></td>
<td><tt><a href='https://graph.facebook.com/oauth/access_token'>https://graph.facebook.com/oauth/access_token</a></tt></td>
</tr>
<tr>
<td>facebook.scope</td>
<td>Facebook permission scope</td>
</tr>
<tr>
<td></td>
<td><tt>read_stream,email</tt></td>
</tr>
<tr>
<td>facebook.client_id</td>
<td>Facebook API client ID</td>
</tr>
<tr>
<td></td>
<td><tt>#{app_facebook_client_id}</tt></td>
</tr>
<tr>
<td>facebook.secret</td>
<td>Facebook API secret</td>
</tr>
<tr>
<td></td>
<td><tt>#{app_facebook_secret}</tt></td>
</tr>
<tr>
<td>auth.url.google-plus</td>
<td>Google+ OAuth access point</td>
</tr>
<tr>
<td></td>
<td><tt><a href='https://accounts.google.com/o/oauth2/auth'>https://accounts.google.com/o/oauth2/auth</a></tt></td>
</tr>
<tr>
<td>auth.provider.google-plus</td>
<td>Auth provider to use for Google+</td>
</tr>
<tr>
<td></td>
<td><tt>google-plus</tt></td>
</tr>
<tr>
<td>google-plus.issuer</td>
<td>Google+ issuer identification</td>
</tr>
<tr>
<td></td>
<td><tt>accounts.google.com</tt></td>
</tr>
<tr>
<td>google-plus.callback_url</td>
<td>Google+ verify callback</td>
</tr>
<tr>
<td></td>
<td><tt>#{app_oauth_url_base}#{contextPath}/auth/verify</tt></td>
</tr>
<tr>
<td>google-plus.request_url</td>
<td>Google+ request OAuth token access point</td>
</tr>
<tr>
<td></td>
<td><tt><a href='https://accounts.google.com/o/oauth2/token'>https://accounts.google.com/o/oauth2/token</a></tt></td>
</tr>
<tr>
<td>google-plus.scope</td>
<td>Google+ permission scope</td>
</tr>
<tr>
<td></td>
<td><tt>openid profile email</tt></td>
</tr>
<tr>
<td>google-plus.client_id</td>
<td>Google+ API client ID</td>
</tr>
<tr>
<td></td>
<td><tt>#{app_google_plus_client_id}</tt></td>
</tr>
<tr>
<td>google-plus.secret</td>
<td>Google+ API secret</td>
</tr>
<tr>
<td></td>
<td><tt>#{app_google_plus_secret}</tt></td>
</tr>
</table>


## Introduction ##
The **users** module provides a **users** service which controls the user data model.

## Events ##
The **users** module exposes a number of events which are posted when some action
are performed at the service level.

### user-register ###
This event is posted when a new user is registered in the application.
It can be used to send a registration email.

### user-create ###
This event is posted when a new user is created.  It can be used to trigger
the pre-initialization of the application for the new user.

### user-lost-password ###
This event is posted when a user asks for a password reset through an
anonymous form.  It is intended to be used to send the reset password email.

### user-reset-password ###
This event is posted when a user has successfully reset his password.
It can be used to send an email.


<table width='100%'>
<tr>
<th width='30%' align='left'>Name</th>
<th width='70%' align='left'>Description</th>
</tr>
<tr>
<td>login</td>
<td>This bean is used by the login form</td>
</tr>
<tr>
<td>register</td>
<td>This bean is used by the registration form</td>
</tr>
<tr>
<td>resetPassword</td>
<td>This bean is used by the reset password form</td>
</tr>
<tr>
<td>lostPassword</td>
<td>This bean is used by the lost password form</td>
</tr>
<tr>
<td>logout</td>
<td>This bean is used by the logout process</td>
</tr>
<tr>
<td>user</td>
<td>This bean allows to provide information about the current logged user.</td>
</tr>
</table><h3>Configuration</h3><table width='100%'>
<tr>
<th width='30%' align='left'>Name</th>
<th width='70%' align='left'>Description</th>
</tr>
<tr>
<td>openid.realm</td>
<td>
The REALM URL used by OpenID providers to verify the validity of the verification callback.<br>
</td>
</tr>
<tr>
<td></td>
<td><tt>#{app_url_base}#{contextPath}/auth</tt></td>
</tr>
<tr>
<td>openid.callback_url</td>
<td>
The verification callback URI used by the OpenID provider to redirect the user<br>
after authentication.<br>
</td>
</tr>
<tr>
<td></td>
<td><tt>#{app_url_base}#{contextPath}/auth/verify</tt></td>
</tr>
<tr>
<td>openid.success_url</td>
<td>
The URI where the user is redirected after a successful authentication.<br>
</td>
</tr>
<tr>
<td></td>
<td><tt>#{contextPath}/workspaces/main.html</tt></td>
</tr>
<tr>
<td>auth.url.orange</td>
<td>Orange OpenID access point</td>
</tr>
<tr>
<td></td>
<td><tt><a href='http://openid.orange.fr'>http://openid.orange.fr</a></tt></td>
</tr>
<tr>
<td>auth.provider.orange</td>
<td>Auth provider to use for Orange</td>
</tr>
<tr>
<td></td>
<td><tt>openid</tt></td>
</tr>
<tr>
<td>auth.url.yahoo</td>
<td>Yahoo! OpenID access point</td>
</tr>
<tr>
<td></td>
<td><tt><a href='http://open.login.yahooapis.com/openid20/www.yahoo.com/xrds'>http://open.login.yahooapis.com/openid20/www.yahoo.com/xrds</a></tt></td>
</tr>
<tr>
<td>auth.provider.yahoo</td>
<td>Auth provider to use for Yahoo!</td>
</tr>
<tr>
<td></td>
<td><tt>openid</tt></td>
</tr>
<tr>
<td>auth.url.google</td>
<td>Google OpenID access point</td>
</tr>
<tr>
<td></td>
<td><tt><a href='https://www.google.com/accounts/o8/id'>https://www.google.com/accounts/o8/id</a></tt></td>
</tr>
<tr>
<td>auth.provider.google</td>
<td>Auth provider to use for Google</td>
</tr>
<tr>
<td></td>
<td><tt>openid</tt></td>
</tr>
<tr>
<td>auth.url.facebook</td>
<td>Facebook OAuth access point</td>
</tr>
<tr>
<td></td>
<td><tt><a href='https://www.facebook.com/dialog/oauth'>https://www.facebook.com/dialog/oauth</a></tt></td>
</tr>
<tr>
<td>auth.provider.facebook</td>
<td>Auth provider to use for Facebook</td>
</tr>
<tr>
<td></td>
<td><tt>facebook</tt></td>
</tr>
<tr>
<td>facebook.callback_url</td>
<td>Facebook verify callback</td>
</tr>
<tr>
<td></td>
<td><tt>#{app_oauth_url_base}#{contextPath}/auth/verify</tt></td>
</tr>
<tr>
<td>facebook.request_url</td>
<td>Facebook request OAuth token access point</td>
</tr>
<tr>
<td></td>
<td><tt><a href='https://graph.facebook.com/oauth/access_token'>https://graph.facebook.com/oauth/access_token</a></tt></td>
</tr>
<tr>
<td>facebook.scope</td>
<td>Facebook permission scope</td>
</tr>
<tr>
<td></td>
<td><tt>read_stream,email</tt></td>
</tr>
<tr>
<td>facebook.client_id</td>
<td>Facebook API client ID</td>
</tr>
<tr>
<td></td>
<td><tt>#{app_facebook_client_id}</tt></td>
</tr>
<tr>
<td>facebook.secret</td>
<td>Facebook API secret</td>
</tr>
<tr>
<td></td>
<td><tt>#{app_facebook_secret}</tt></td>
</tr>
<tr>
<td>auth.url.google-plus</td>
<td>Google+ OAuth access point</td>
</tr>
<tr>
<td></td>
<td><tt><a href='https://accounts.google.com/o/oauth2/auth'>https://accounts.google.com/o/oauth2/auth</a></tt></td>
</tr>
<tr>
<td>auth.provider.google-plus</td>
<td>Auth provider to use for Google+</td>
</tr>
<tr>
<td></td>
<td><tt>google-plus</tt></td>
</tr>
<tr>
<td>google-plus.issuer</td>
<td>Google+ issuer identification</td>
</tr>
<tr>
<td></td>
<td><tt>accounts.google.com</tt></td>
</tr>
<tr>
<td>google-plus.callback_url</td>
<td>Google+ verify callback</td>
</tr>
<tr>
<td></td>
<td><tt>#{app_oauth_url_base}#{contextPath}/auth/verify</tt></td>
</tr>
<tr>
<td>google-plus.request_url</td>
<td>Google+ request OAuth token access point</td>
</tr>
<tr>
<td></td>
<td><tt><a href='https://accounts.google.com/o/oauth2/token'>https://accounts.google.com/o/oauth2/token</a></tt></td>
</tr>
<tr>
<td>google-plus.scope</td>
<td>Google+ permission scope</td>
</tr>
<tr>
<td></td>
<td><tt>openid profile email</tt></td>
</tr>
<tr>
<td>google-plus.client_id</td>
<td>Google+ API client ID</td>
</tr>
<tr>
<td></td>
<td><tt>#{app_google_plus_client_id}</tt></td>
</tr>
<tr>
<td>google-plus.secret</td>
<td>Google+ API secret</td>
</tr>
<tr>
<td></td>
<td><tt>#{app_google_plus_secret}</tt></td>
</tr>
</table>


## Model ##
![http://ada-awa.googlecode.com/svn/wiki/awa_user_model.png](http://ada-awa.googlecode.com/svn/wiki/awa_user_model.png)



---

[Generated by Dynamo](http://code.google.com/p/ada-gen) _from awa-users-modules.ads_