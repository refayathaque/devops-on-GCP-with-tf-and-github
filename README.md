Code divided by projects (not in the GCP resource hierarchy "project" sense), project naming convention is: "demo-" followed by a number, info below will delineate what each project does, state associated deliverables and have related notes and links

Naming convention:

- GCP resources: e.g., demo-2, `this-bucket-does-something`, service-to-query-sql, database-for-cars
- tf resources: e.g., pubsub_demo_service, `database_for_cars`, demo_5_pubsub_topic
- java files/projects: no dashes or underscores (because I personally don't know what's allowed and what's not)
- tasks's status indicated with ✅/❌/🚧

## _demo-1_

Objective: React app makes unauth'ed GET to API Gateway, API Gateway forwards request to Spring Boot Cloud Run service, service responds with "Hello World", React app displays response data\
Tasks & notes:

1. Hit service URL to make sure everything is working and the container returns a string ✅\
   _Not using a custom "demo-1" container image, using "hello-world" in ready-to-containerize dir_

## _demo-2_

Objective: Spring Boot Cloud Run service responds with message received from Pub/Sub, check service logs to validate, Pub/Sub message should be logged - using code (with modifications, e.g., not using jib to build, so had to create a Dockerfile) from [here](https://github.com/GoogleCloudPlatform/java-docs-samples/tree/master/run/pubsub)\
Tasks & notes:

1. Run `docker build -t demo-2 .` to validate Dockerfile ✅\
   _this is actually useless from config validation perspective, when running tf you could still get the Cloud Run service provisioning to error_
2. Create cloud-run, cloud-build, source-repo, iam, provider, vars, pubsub tf files ✅
3. Push container image to Container Registry ✅
4. Run tf code ✅\
   _pom.xml `artifactId` and `name` is **demo2**, same as what's in Dockerfile preceding `.jar` and also on the top of Java files (e.g., `package com.example.demo2;`) this consistency is important otherwise you'll get errors when building the service_
5. Publish a message with command `gcloud pubsub topics publish demo-2-topic --message "World"` and validate in Cloud Run service logs ✅
6. Add `cloudbuild.yaml` to source code and validate in Cloud Build that container image is built and pushed to Container Registry ✅
7. Make changes to source code and validate in Cloud Run service logs that Cloud Build built a new image ✅\
   _[Step 6](https://dzone.com/articles/cicd-using-google-cloud-build-and-google-cloud-run)_\
   _[Deploying a new revision of an existing service](https://cloud.google.com/run/docs/deploying#revision)_\
   _[How to set up IAM resources](https://stackoverflow.com/a/62783880)_

## _demo-3_

Objective: Design a Cloud DLP transformation for a sample dataset. Create Cloud DLP templates to store the transformation configuration. _I.e., what's [here](https://cloud.google.com/architecture/creating-cloud-dlp-de-identification-transformation-templates-pii-dataset)_
Tasks and notes:

1. Write tf code for buckets - The first bucket stores the sample dataset and the second bucket stores temporary data for the automated pipeline ✅

## _demo-4_

Objective: Set up API Gateway with GET that returns "hello world" from Java Spring Boot Cloud Run service
Tasks and notes:

1. Write tf code
