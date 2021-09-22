guides:

- https://spring.io/guides/gs/spring-boot-docker/
- https://docs.docker.com/language/java/run-containers/
- https://docs.docker.com/engine/reference/commandline/build/
- https://www.docker.com/sites/default/files/d8/2019-09/docker-cheat-sheet.pdf
- https://cloud.google.com/container-registry/docs/pushing-and-pulling#pushing_an_image_to_a_registry
- https://github.com/GoogleCloudPlatform/cloud-build-samples/tree/main/maven-example
- https://cloud.google.com/build/docs/building/build-java

main files to look at:

- `src/main/java/com/example/demo/DemoApplication.java`
- `pom.xml`
- `Dockerfile`
- `cloudbuild.yaml`

building and running this app locally (on http://localhost:8080) with Maven and Apache Tomcat:

- `mvn package && java -jar target/${artifactId}-${version}.jar`
  - command is from [guide](https://spring.io/guides/gs/spring-boot-docker/), `artifactId` and `version` values are in `pom.xml`

building container image and running it locally on Docker

- `docker build -t hello-world`
  - command builds an image and tags it as "hello-world"
- `docker run --publish 8080:8080 hello-world`
  - start the container and expose port 8080 to port 8080 on the host.

pushing image to Container Registry:

- `docker build -t hello-world`
- `docker image ls`
- `docker tag hello-world gcr.io/${projectId}/hello-world`
- `docker push gcr.io/${projectId}/hello-world`
