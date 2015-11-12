**Module name** Users

**Package** AWA.Users


# Introduction #

  * The **users** module manages the users allowed to use the application.
  * A user can register by using a login/password subscription form.
  * A user can use an OpenID and be automatically registered.
  * A user can have one or several permissions that allow to protect the application data.

# Model #

  * The database keeps track of user information necessary for the application,
  * A user has a name, a first name, at least one email address, a country and a language,
  * A user that authenticate with OpenID has an OpenID identifier,
  * Otherwise, a user has a password,
  * A user can be associated with an authentication key to help in a mail authentication (lost password process),
  * A user can have one or several access rights that control and protect the application data.

```
package AWA.Users.Models
```

# Logic #

The **users** controller provides the following operations:

  * Create a new user,
  * Authenticate a user,
  * Update the user information,
  * Deletes a user (close account).

The **users** is stateless and shared by several requests.

```
package AWA.Users.Services
```


## Login Form ##

A form to allow users to login.  The form proposes an OpenID login as well as a classical user/password login.

```
/auth/login.html
```

After a login is successful, the user is redirected to an application specific page.

## Registration Form ##

A form to allow a user to register.

```
/auth/register.html
```

## Logout Action ##

The logout action closes the current session and drops any cookie used by the authentication.

```
/auth/logout.html
```

## Close Account Form ##

To use the close account page, the user should be authenticated.  When closing the account, the user has to confirm
the close and s/he will be redirected to an application specific page.  The current session will be closed.

```
/user/close-account.html
```

# References #

  * [Mail](Module.md)
  * [Permissions](Module.md)