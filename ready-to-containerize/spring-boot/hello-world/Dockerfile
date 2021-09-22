FROM openjdk:8-jdk-alpine
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]

# code above, and steps below, found in https://spring.io/guides/gs/spring-boot-docker/
# docker build -t hello-world
# This command builds an image and tags it as "hello-world"
# docker run --publish 8080:8080 hello-world
# Start the container and expose port 8080 to port 8080 on the host.

# if code above doesn't work try what's below, taken from https://github.com/GoogleCloudPlatform/cloud-build-samples/blob/main/maven-example/Dockerfile
# FROM openjdk:8-jdk-alpine
# ARG JAR_FILE=JAR_FILE_MUST_BE_SPECIFIED_AS_BUILD_ARG
# COPY ${JAR_FILE} app.jar
# ENTRYPOINT ["java", "-Djava.security.edg=file:/dev/./urandom","-jar","/app.jar"]