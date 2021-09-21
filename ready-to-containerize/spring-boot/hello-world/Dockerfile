FROM openjdk:8-jdk-alpine
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]

# docker build -t hello-world
# This command builds an image and tags it as "hello-world"
# docker run --publish 8080:8080 hello-world
# Start the container and expose port 8080 to port 8080 on the host.