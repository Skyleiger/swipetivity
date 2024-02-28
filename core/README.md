# swipetivity-core

## Introduction

This is the backend, behind the swipetivity app. It is written in Java with the Spring Framework and provides the REST
API for the app.

## Usage

To run the backend, you need to have Java 17 installed. After that, you can build the project with Maven and run the
resulting JAR file.

```
./mvnw clean package
java -jar target/swipetivity-core.jar
```

Before running the backend, you need to have a MariaDB database running. You can configure the connection in
the `application.properties` file.
The database schema is created automatically when the application is starting.

Feel free to ask if you have any questions or problems.