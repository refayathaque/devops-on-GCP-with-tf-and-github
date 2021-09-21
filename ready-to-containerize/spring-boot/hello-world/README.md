guides:

- https://spring.io/guides/gs/spring-boot-docker/
- https://docs.docker.com/language/java/run-containers/
- https://docs.docker.com/engine/reference/commandline/build/
- https://www.docker.com/sites/default/files/d8/2019-09/docker-cheat-sheet.pdf
- https://cloud.google.com/container-registry/docs/pushing-and-pulling#pushing_an_image_to_a_registry

main files to look at:

- `src/main/java/com/example/demo/DemoApplication.java`
- `pom.xml`
- `Dockerfile`

building and running this app locally (on http://localhost:8080) with Maven and Apache Tomcat:

- `mvn package && java -jar target/${artifactId}-${version}.jar`
  - command is from [guide](https://spring.io/guides/gs/spring-boot-docker/), `artifactId` and `version` values are in `pom.xml`

pushing image to Container Registry:

- `docker build -t hello-world`
- `docker image ls`
- `docker tag hello-world gcr.io/${projectId}/hello-world`
- `docker push gcr.io/${projectId}/hello-world`
