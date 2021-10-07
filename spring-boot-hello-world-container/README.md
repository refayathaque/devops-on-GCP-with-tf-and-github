guides:

- https://spring.io/guides/gs/spring-boot-docker/
- https://docs.docker.com/language/java/run-containers/
- https://docs.docker.com/engine/reference/commandline/build/
- https://www.docker.com/sites/default/files/d8/2019-09/docker-cheat-sheet.pdf
- https://cloud.google.com/container-registry/docs/pushing-and-pulling#pushing_an_image_to_a_registry
- https://github.com/GoogleCloudPlatform/cloud-build-samples/tree/main/maven-example
- https://cloud.google.com/build/docs/building/build-java

generated with spring [initalizr](https://start.spring.io)

- kept all defaults except for Dependencies (added Spring Web) and Java version (selected 8)

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

pushing container image to Container Registry:

- `docker build -t hello-world .`
- `docker image ls`
- `docker tag hello-world gcr.io/${projectId}/hello-world`
- `docker push gcr.io/${projectId}/hello-world`

when provisioning associated resources like cloud run, cloud build, etc. with, push the container image to Container Registry manually by running commands above **prior to** running tf code - be sure to update the cloud-run.tf file with the image full repository name (e.g., gcr.io/${projectId}/hello-world)

things to change in files when using this as a template

- instances of "hello-world", to whatever you want to call this project
- instances of ${project_id}, to your own project id
