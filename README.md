# Dynamic-Web-Java

## 1. Project Overview

**Dynamic-Web-Java** is a web development project built using the Java programming language.

The project aims to create a dynamic web application using Java, JSP, HTML, CSS, and JavaScript.

## 2. Technologies Used

- **Java:** Programming language used to develop the application.
- **JSP:** Used to create dynamic web pages.
- **HTML:** Defines the structure of web pages.
- **CSS:** Used to style and design web pages.
- **JavaScript:** Adds interactive features to web pages.
- **Apache Tomcat:** Web server used to run the application.
- **Maven:** Manages project dependencies and builds.
- **Eclipse IDE:** Development environment used to write and manage the code.

## 3. Project Structure

```text
Dynamic-Web-Java/
│
├── src/
│   └── main/
│       ├── java/
│       │   └── ...
│       └── webapp/
│           ├── WEB-INF/
│           │   └── web.xml
│           ├── css/
│           ├── js/
│           └── index.jsp
│
├── README.md
├── .gitignore
└── pom.xml
```

## 4. Folder and File Descriptions

### 4.1. `Dynamic-Web-Java/`

This is the main project directory.

It contains all the folders and files required for the web application.

### 4.2. `src/`

This folder contains the project's source files.

It is where the application's source code is stored.

### 4.3. `src/main/`

This folder contains the main components of the application.

It separates Java source code from web resources.

### 4.4. `src/main/java/`

This folder contains Java classes.

It is used to write the application's business logic and processing operations.

Examples:
- Java classes.
- Servlets.
- Data management classes.

### 4.5. `src/main/webapp/`

This folder contains the web resources of the application.

It includes JSP pages, CSS files, JavaScript files, and web configuration resources.

### 4.6. `src/main/webapp/WEB-INF/`

This folder contains the web application's configuration files.

Its contents cannot be accessed directly through a web browser.

### 4.7. `src/main/webapp/WEB-INF/web.xml`

This is the web application deployment descriptor.

It can be used to configure:
- Servlets.
- Application URL mappings.
- Welcome pages.
- Application settings.

### 4.8. `src/main/webapp/css/`

This folder contains CSS files.

CSS is used to control the visual appearance of web pages, including:
- Colors.
- Fonts.
- Sizes.
- Layouts.
- Page design.

### 4.9. `src/main/webapp/js/`

This folder contains JavaScript files.

JavaScript is used to add interactivity and dynamic features to web pages.

### 4.10. `src/main/webapp/index.jsp`

This is the application's home page.

It displays HTML content and can also generate dynamic content using JSP.

### 4.11. `README.md`

This file provides information about the project.

It explains:
- Project overview.
- Technologies used.
- Folder structure.
- Installation instructions.
- General application functionality.

### 4.12. `.gitignore`

This file tells Git which files and folders should not be uploaded to GitHub.

Examples include:
- Compiled files.
- Temporary files.
- Local Eclipse settings.
- Generated build folders.

### 4.13. `pom.xml`

This is the Maven configuration file.

It is used to manage:
- Project dependencies.
- External Java libraries.
- Project information.
- Build configuration.
- WAR file generation.

## 5. Installation and Execution

Follow these steps to run the project:

1. Install Java JDK.
2. Install Eclipse IDE.
3. Install Apache Tomcat.
4. Import the project into Eclipse as an existing Maven project.
5. Check the dependencies in `pom.xml`.
6. Configure Apache Tomcat in Eclipse.
7. Deploy and run the project on Tomcat.
8. Open the application in a web browser.

## 6. Learning Objectives

This project helps developers understand:

- The structure of a Java Web project.
- The separation between Java code and web resources.
- How JSP and Servlets work.
- How to use Apache Tomcat.
- How to manage dependencies with Maven.
- How to use Git and GitHub for version control.

## 7. Author

**Tolotraniaina Henri**

## 8. GitHub Repository

[Dynamic-Web-Java](https://github.com/TolotraniainaHenri/Dynamic-Web-Java)
