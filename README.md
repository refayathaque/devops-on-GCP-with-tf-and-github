Code divided by projects (not in the GCP resource hierarchy "project" sense), project naming convention is: "demo-" followed by a number, info below will delineate what each project does, state associated deliverables and have related notes and links

Naming convention:

- GCP resources: e.g., demo-2, `this-bucket-does-something`, service-to-query-sql, database-for-cars (kebab-case)
- tf resources: e.g., pubsub_demo_service, `database_for_cars`, demo_5_pubsub_topic (snake_case)
- java files/projects: no dashes or underscores (because I personally don't know what's allowed and what's not)
- React demos' resources: `PascaleCase`, e.g., Demo1
- tasks's status indicated with ✅/❌/🚧

## _demo-1_

Objective: Make an unauth'ed GET request to API Gateway, API Gateway forwards request to Java Spring Boot Cloud Run service, service responds with "hello world"\
Tasks & notes:

1. Hit service URL to make sure everything is working and the container returns a string ✅\
   _Not using a custom "demo-1" container image, using some derivative of "hello-world" from ready-to-containerize dir (I say derivative because the service returns "Hello Docker World")_
2. Configure tf and API Gateway OpenAPI `spec.yaml`, using [this](https://cloud.google.com/api-gateway/docs/get-started-cloud-run) as guide ✅

## _demo-2_

Objective: Spring Boot Cloud Run service responds with message received from Pub/Sub, check service logs to validate, Pub/Sub message should be logged - using code (with modifications, e.g., not using jib to build, so had to create a Dockerfile) from [here](https://github.com/GoogleCloudPlatform/java-docs-samples/tree/master/run/pubsub)\
Tasks & notes:

- Run `docker build -t demo-2 .` to validate Dockerfile ✅\
   _this is actually useless from config validation perspective, when running tf you could still get the Cloud Run service provisioning to error_
- Create cloud-run, cloud-build, source-repo, iam, provider, vars, pubsub tf files ✅
- Push container image to Container Registry ✅
- Run tf code ✅\
   _pom.xml `artifactId` and `name` is **demo2**, same as what's in Dockerfile preceding `.jar` and also on the top of Java files (e.g., `package com.example.demo2;`) this consistency is important otherwise you'll get errors when building the service_
- Publish a message with command `gcloud pubsub topics publish demo-2-topic --message "World"` and validate in Cloud Run service logs ✅
- Add `cloudbuild.yaml` to source code and validate in Cloud Build that container image is built and pushed to Container Registry ✅
- Make changes to source code and validate in Cloud Run service logs that Cloud Build built a new image ✅\
   _[Step 6](https://dzone.com/articles/cicd-using-google-cloud-build-and-google-cloud-run)_\
   _[Deploying a new revision of an existing service](https://cloud.google.com/run/docs/deploying#revision)_\
   _[How to set up IAM resources](https://stackoverflow.com/a/62783880)_

## _demo-3_ (on hold)

Objective: Design a Cloud DLP transformation for a sample dataset. Create Cloud DLP templates to store the transformation configuration. _I.e., what's [here](https://cloud.google.com/architecture/creating-cloud-dlp-de-identification-transformation-templates-pii-dataset)_\
Tasks and notes:

- Write tf code for buckets - The first bucket stores the sample dataset and the second bucket stores temporary data for the automated pipeline ✅
- Download sample files ✅
- Create a dataset in BigQuery where the Cloud DLP pipeline can store the de-identified (tokenized) data - Write tf code for dataset and table ✅\
   _A [dataset](https://cloud.google.com/bigquery/docs/datasets-intro#datasets) is contained within a specific project. Datasets are top-level containers that are used to organize and control access to your tables and views. A table or view must belong to a dataset, so you need to create at least one dataset before loading data into BigQuery._
- Create a key encryption key (KEK) using Cloud Build - Write tf code 🚧

## _demo-4_

Something to do with networking - VPCs, etc.

# Infrastructure for React apps:

## _Demo1_

Objective: Allow users to create, list, update and destroy buckets (Essentially creating a proper backend with API Gateway and multiple microservices for each operation type)\
Tasks and notes:

- To understand how to build node.js container images with express.js, create a simple one and deploy using gcloud commands - use [this](https://cloud.google.com/run/docs/quickstarts/build-and-deploy/nodejs) as guide
- Create 4 service accounts (for each microservice) (with custom roles if need be) to only do the above
- Create 5 dummy buckets so there is something to GET when the app first loads
- Create a `.js` file to test SDK locally before implementing in microservices
- Create 4 node.js containerized images that will serve as the microservices\
  _GET_\
  _POST_\
  _PUT/PATCH_\
  _DESTROY_\
