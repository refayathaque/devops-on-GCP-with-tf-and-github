notes below are from another repo, so some files/general things might not make sense

# [Cloud Run](https://cloud.google.com/run/docs/quickstarts)

- Cloud Run is a managed compute platform that enables you to run containers that are invocable via requests or events. Cloud Run is serverless: it abstracts away all infrastructure management, so you can focus on what matters most — building great applications.

## [Tutorial for setting up a node.js service to be invoked by pub/sub](https://cloud.google.com/run/docs/tutorials/pubsub)

- Corresponding tf scripts available in following files: `iam.tf`, `pubsub.tf`, `cloud-run.tf`

## Creating a basic Java Spring Boot container and pushing to Container Registry

- Largely based off of [this tutorial](https://cloud.google.com/run/docs/quickstarts/build-and-deploy/java)
- Create a Spring Boot application from scratch - https://cloud.google.com/run/docs/quickstarts/build-and-deploy/java#writing
  - Name of project should be all lower case, e.g., `basicspringbootcontainer`
- Copy main java file from tutorial
  - Change class name from `HelloworldApplication` to `${spring_project_name}Application`, also change controller class name to `${spring_project_name}Controller`
- Set `server.port=${PORT:8080}` in `application.properties`
- Add whatever dependencies you **might** need in the `pom.xml`
- In the `.java` files add the package on top of everything, e.g., `package com.example.${spring_project_name};`
  - This may/may not be a requirement, if you see an error like this in the log you need to add
    - `** WARNING ** : Your ApplicationContext is unlikely to start due to a `@ComponentScan` of the default package.`
      - https://stackoverflow.com/questions/41729712/spring-application-does-not-start-outside-of-a-package
- Add `Dockerfile` based on what's [here](https://cloud.google.com/run/docs/quickstarts/build-and-deploy/java#containerizing)
  - Replace all occurances of `helloworld` with `${spring_project_name}`
- Push to Container Registry
  - `gcloud builds submit --tag gcr.io/${project_id}/${spring_project_name}`
- _Deployment is done with tf_, look for cloud run resource named `basicspringbootcontainer`
  - Also has configuration to make service publically accessible

<!-- commands -->
<!-- gcloud pubsub topics publish ${topic} --message "World" -->

### Helpful links:

- Good Cloud Run [guide](https://ruanmartinelli.com/posts/terraform-cloud-run) for easy _public_ service configuration
