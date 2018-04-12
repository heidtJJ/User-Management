# User-Management
Build a new web app and name it UserManagement, with servlets/JSP to (1) sign up a user, (2) log in, (3) log out. Once a user is signed up successfully, they will be considered logged in, and shown a landing page of your design. When a user logs in successfully, the same landing page should also be shown. Once a user is logged out, any subsequent attempt to access any servlet will force the user to go to the login page. When a user attempts to sign up, they must not have existed on the server, their password must be good enough (subject to the following password rules: at least 8 characters long, at least one capital, one digit, one special symbol), and the repeat password must be the same as the created password. 

The UserManagement must not save the user's passwords directly as plain text as the server might be hacked, and thus, passwords might be stolen; instead, hash the password and save the hash value.

All data must be stored in a mysql database.

You must defend against SQL Injection attacks.

The user management pages must consider common user errors and handle them in the most user friendly ways. In particular, when the user commits an error and is required to correct it, the system must preserve their work.

When a user connects from a different IP address, force them to log in again, even if their session is still alive.

<strong>Assigned by Prof. Daqing Hou, Enterprise Software Development</strong>
