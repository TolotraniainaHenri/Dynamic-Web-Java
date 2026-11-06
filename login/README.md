# LoginSecure
### Secure JSP Authentication System

**A Java Web Application using JSP, Apache Tomcat, CSV Storage, and BCrypt Password Hashing.**

---

## 1. Project Overview

LoginSecure is a simple web-based authentication system developed using JavaServer Pages (JSP), HTML, CSS, and Apache Tomcat.

The application allows users to securely log in using their email address and password. User credentials are stored in a CSV file, while passwords are protected using the BCrypt hashing algorithm.

The project also implements session management to prevent unauthorized access to protected pages.

The main objective is to demonstrate the fundamentals of web authentication, password security, and session management without using Servlets, Filters, or a database.

## 2. Technologies Used

| Technology | Purpose |
|---|---|
| Java | Server-side programming |
| JSP | Dynamic web page processing |
| HTML5 | Web page structure |
| CSS3 | User interface styling |
| JavaScript | Interactive password visibility |
| BCrypt | Password hashing and verification |
| CSV | User credential storage |
| Apache Tomcat 10 | Web application server |
| Eclipse IDE | Development environment |

**External dependency:** jBCrypt 0.4 (`org.mindrot.jbcrypt.BCrypt`).

## 3. Project Structure

```text
LoginSecure/
│
├── Java Resources/
│
├── WebContent/
│   │
│   ├── login.jsp
│   ├── home.jsp
│   ├── logout.jsp
│   │
│   ├── css/
│   │   └── style.css
│   │
│   └── WEB-INF/
│       ├── web.xml
│       └── users.csv
```

## 4. File and Component Explanations

### 4.1 `Java Resources/`

This directory contains the Java resources associated with the project.

The current implementation uses JSP directly for server-side processing. It does not require custom Java Servlets, DAO classes, or authentication Filters.

### 4.2 `WebContent/login.jsp`

**Purpose: User Authentication**

This is the main login page of the application.

Its responsibilities include:

- Displaying the login form.
- Receiving the user's email and password.
- Reading registered user information from `users.csv`.
- Comparing the submitted email with the stored email.
- Verifying the submitted password using BCrypt.
- Creating a user session after successful authentication.
- Redirecting authenticated users to `home.jsp`.
- Displaying an error message when authentication fails.
- Preventing authenticated users from returning to the login page unnecessarily.

**Authentication process:**

1. The user enters an email address and password.
2. The application reads the CSV file.
3. The submitted email is compared with the stored email.
4. BCrypt verifies the submitted password against the stored hash.
5. If both credentials are valid, a new session is created.
6. The user is redirected to the protected home page.

### 4.3 `WebContent/home.jsp`

**Purpose: Protected User Dashboard**

This page is accessible only to authenticated users.

Its responsibilities include:

- Checking whether a valid user session exists.
- Redirecting unauthenticated users to `login.jsp`.
- Displaying the authenticated user's email address.
- Providing access to the logout functionality.
- Setting HTTP cache-control headers to reduce the risk of displaying previously cached protected content.

**Access control:**

If the session does not contain the `email` attribute, the application redirects the visitor to the login page.

### 4.4 `WebContent/logout.jsp`

**Purpose: Secure Session Termination**

This page handles user logout.

Its responsibilities include:

- Invalidating the current HTTP session.
- Removing session-based authentication information.
- Setting cache-control headers to prevent caching.
- Redirecting the user to `login.jsp`.

After logout, the user must authenticate again to access protected pages.

### 4.5 `WebContent/css/style.css`

**Purpose: User Interface and Visual Design**

This file controls the application's visual appearance.

It contains:

- Dark premium interface styling.
- Black and charcoal background colors.
- Gold accent colors.
- Login form layout and spacing.
- Input field styling.
- Button design and hover effects.
- Password visibility icon positioning.
- Error message styling.
- Responsive layout for smaller screens.
- Smooth interface animations.

The CSS is separated from the JSP files to improve maintainability and code organization.

### 4.6 `WebContent/WEB-INF/web.xml`

**Purpose: Web Application Configuration**

This is the deployment descriptor of the application.

It defines the web application configuration, including:

- Application deployment settings.
- Welcome page configuration.
- Web application metadata.

The `WEB-INF` directory is not directly accessible through normal browser URLs.

### 4.7 `WebContent/WEB-INF/users.csv`

**Purpose: User Credential Storage**

This file stores registered user email addresses and their BCrypt password hashes.

Example structure:

```csv
email,passwordHash
admin@gmail.com,$2a$12$exampleAdminHash
user@gmail.com,$2a$12$exampleUserHash
```

**Important:** The password column contains BCrypt hashes, not original passwords.

BCrypt uses a salt and a configurable computational cost to make password guessing more difficult.

The application uses `BCrypt.checkpw()` to verify passwords during login.

## 5. Main Security Features

### 5.1 BCrypt Password Hashing

Passwords are not stored as plain text.

BCrypt transforms passwords into secure password hashes before storage.

During authentication, the submitted password is checked against the stored hash.

### 5.2 Session Management

The application uses the HTTP session to identify authenticated users.

The authenticated user's email is stored in the session:

```java
session.setAttribute("email", email);
```

The session is checked before displaying protected content.

### 5.3 Session Invalidation

When the user logs out, the session is destroyed:

```java
session.invalidate();
```

This removes the authentication state associated with that session.

### 5.4 Protected Pages

The home page checks the session before displaying its content.

Unauthenticated users are redirected to the login page.

### 5.5 Cache Protection

The application uses HTTP response headers:

```java
response.setHeader(
    "Cache-Control",
    "no-cache, no-store, must-revalidate"
);

response.setHeader("Pragma", "no-cache");

response.setDateHeader("Expires", 0);
```

These headers instruct browsers not to store protected page responses in their normal HTTP cache.

### 5.6 Password Visibility

The login form includes an eye icon that allows users to show or hide their password.

This functionality is implemented using JavaScript and Font Awesome.

## 6. Application Workflow

```text
                 START
                   |
                   v
              Login Page
                   |
                   v
          Enter Email and Password
                   |
                   v
             Read users.csv
                   |
                   v
          Compare Email and Hash
                   |
                   v
          Are Credentials Valid?
              /          \
            NO            YES
            |              |
            v              v
       Show Error     Create Session
            |              |
            |              v
            |         Open home.jsp
            |              |
            |              v
            |          User Logout
            |              |
            |              v
            |      Invalidate Session
            |              |
            |              v
            |        Return to Login
            |              |
            +--------------+
```

## 7. Installation and Setup

### Requirements

- Java Development Kit (JDK).
- Eclipse IDE for Enterprise Java and Web Developers.
- Apache Tomcat 10.x.
- jBCrypt 0.4 library.

### Setup Instructions

1. Import the `LoginSecure` project into Eclipse.
2. Configure Apache Tomcat as the application server.
3. Add the jBCrypt JAR dependency to the project.
4. Place the JAR file inside `WEB-INF/lib`.
5. Configure the `users.csv` file inside `WEB-INF`.
6. Ensure that the CSV contains valid BCrypt password hashes.
7. Start the Tomcat server.
8. Open the application in your browser.

**Application URL:**

```text
http://localhost:8080/LoginSecure/
```

## 8. Current Project Limitations

This project is designed as an educational authentication system.

The current implementation does not include:

- User registration.
- Password recovery.
- Email verification.
- Database integration.
- User roles and permissions.
- Multi-factor authentication.
- Account lockout after repeated failed login attempts.

The CSV storage approach is suitable for a small demonstration but is not recommended for production applications.

## 9. Future Improvements

Possible future enhancements include:

- Implementing secure user registration.
- Adding password recovery through email verification.
- Replacing CSV storage with MySQL or PostgreSQL.
- Implementing role-based access control.
- Adding account lockout and login rate limiting.
- Using HTTPS for encrypted communication.
- Moving authentication logic into dedicated Java classes.
- Implementing Servlet and Filter-based architecture.
- Adding automated security tests.

## 10. Learning Objectives

Through this project, developers can understand:

- How JSP handles server-side authentication.
- How passwords can be protected using BCrypt.
- How CSV files can be used for basic data storage.
- How HTTP sessions manage authenticated users.
- How to protect pages against unauthorized access.
- How to invalidate sessions during logout.
- How HTML, CSS, JavaScript, and JSP work together.

---

## Author's Note

LoginSecure is a foundational project designed to explore the essential concepts of secure web authentication using Java technologies.

It provides a starting point for developing more advanced authentication systems with database integration, registration, password recovery, and improved security architecture.

**Project:** LoginSecure  
**Platform:** Java Web Application  
**Server:** Apache Tomcat 10.x  
**Architecture:** JSP-based authentication  
**Storage:** CSV  
**Password Security:** BCrypt

*Developed for educational and learning purposes.*
