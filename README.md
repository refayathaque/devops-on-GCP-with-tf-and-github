Code divided by projects (not in the GCP resource hierarchy "project" sense), project naming convention is: "demo-" followed by a number, info below will delineate what each project does, state associated deliverables & have related notes & links

Naming convention:

- GCP resources: e.g., demo-2, `this-bucket-does-something`, service-to-query-sql, database-for-cars (kebab-case)
- tf resources: e.g., pubsub_demo_service, `database_for_cars`, demo_5_pubsub_topic (snake_case)
- java files/projects: no dashes or underscores (because I personally don't know what's allowed & what's not)
- React demos' resources: e.g., react-demo-1
- everything else: `kebab-case`
- tasks's status indicated with ✅/❌/🚧

## _demo-1_

Objective: Make an unauth'ed GET request to API Gateway, API Gateway forwards request to Java Spring Boot Cloud Run service, service responds with "hello world"\
Tasks & notes:

1. Hit service URL to make sure everything is working & the container returns a string ✅\
   _Not using a custom "demo-1" container image, using some derivative of "hello-world" from ready-to-containerize dir (I say derivative because the service returns "Hello Docker World")_
2. Configure tf & API Gateway OpenAPI `spec.yaml`, using [this](https://cloud.google.com/api-gateway/docs/get-started-cloud-run) as guide ✅

## _demo-2_

Objective: Spring Boot Cloud Run service responds with message received from Pub/Sub, check service logs to validate, Pub/Sub message should be logged - using code (with modifications, e.g., not using jib to build, so had to create a Dockerfile) from [here](https://github.com/GoogleCloudPlatform/java-docs-samples/tree/master/run/pubsub)\
Tasks & notes:

- Run `docker build -t demo-2 .` to validate Dockerfile ✅\
   _this is actually useless from config validation perspective, when running tf you could still get the Cloud Run service provisioning to error_
- Create cloud-run, cloud-build, source-repo, iam, provider, vars, pubsub tf files ✅
- Push container image to Container Registry ✅
- Run tf code ✅\
   _pom.xml `artifactId` & `name` is **demo2**, same as what's in Dockerfile preceding `.jar` & also on the top of Java files (e.g., `package com.example.demo2;`) this consistency is important otherwise you'll get errors when building the service_
- Publish a message with comm& `gcloud pubsub topics publish demo-2-topic --message "World"` & validate in Cloud Run service logs ✅
- Add `cloudbuild.yaml` to source code & validate in Cloud Build that container image is built & pushed to Container Registry ✅
- Make changes to source code & validate in Cloud Run service logs that Cloud Build built a new image ✅\
   _[Step 6](https://dzone.com/articles/cicd-using-google-cloud-build-&-google-cloud-run)_\
   _[Deploying a new revision of an existing service](https://cloud.google.com/run/docs/deploying#revision)_\
   _[How to set up IAM resources](https://stackoverflow.com/a/62783880)_

## _demo-3_

Objective: Inspect a BigQuery table using the Data Loss Prevention API using Pub/Sub for job notifications.\
Tasks & notes:

- Get sample data from [here](https://cloud.google.com/architecture/creating-cloud-dlp-de-identification-transformation-templates-pii-dataset#downloading_the_sampledatas)
- Create tf resources for bucket & object, object will be a single csv file from the sample data retrieved above
- Create tf resources for BigQuery dataset, table & load job
  - _Get table schema from [here](https://github.com/GoogleCloudPlatform/dlp-dataflow-deidentification/tree/master/terraform_setup) (repo is assoicated with Cloud Architecture Center tutorial, link above in "Get sample data from")_
  - [Load jobs](https://cloud.google.com/bigquery/docs/loading-data). Load data from Cloud Storage or from a local file by creating a load job. The records can be in Avro, CSV, JSON, ORC, or Parquet format.
- Create tf IAM resources for BigQuery to access sample data object in bucket & execute load job
  - "When you load data into BigQuery, you need permissions to run a load job & permissions that let you load data into new or existing BigQuery tables & partitions. If you are loading data from Cloud Storage, you also need permissions to access to the bucket that contains your data." - [Doc](https://cloud.google.com/bigquery/docs/loading-data-cloud-storage-csv#required_permissions)
- Create tf resources for Pub/Sub topic & subscription
- Deploy infrastructure pieces made thus far to be able to perform local testing
- Create, test & deploy container image (to Container Registry) using code found [here](https://github.com/googleapis/java-dlp/blob/main/samples/snippets/src/main/java/dlp/snippets/InspectBigQueryTable.java) - parent repo [link](https://github.com/googleapis/java-dlp) for other DLP samples
- Create tf resources for Cloud Run service & figure out how to invoke service

## _demo-4_

Something to do with networking - VPCs, etc.

# Infrastructure for React apps, i.e., backends for frontend apps:

### How to build a simple node.js microservice, based on stuff from [here](https://expressjs.com/en/starter/installing.html), [here](https://cloud.google.com/run/docs/quickstarts/build-&-deploy/nodejs) & [here](https://github.com/GoogleCloudPlatform/nodejs-docs-samples/blob/9804b07efb2fb207c2e3515e844431c130e6c7b2/run/helloworld/Dockerfile)

- create a folder, cd into that folder, run `npm init` (just hit enter through everything)
- at the bottom of the `package.json` file add property `"type": "module"`
- run `npm install express --save`
- create an `index.js` file with the following content inside

```
import express from 'express'
const app = express();
app.get('/', (req, res) => {
  const name = process.env.NAME || 'World';
  res.send(`Hello ${name}!`);
});
const port = process.env.PORT || 8080;
app.listen(port, () => {
  console.log(`helloworld: listening on port ${port}`);
});
```

- create a `Dockerfile` with the following content inside
  - actually this is [not necessary](https://cloud.google.com/run/docs/deploying-source-code) - "If a Dockerfile is present in the source code directory, the uploaded source code is built using that Dockerfile. If no Dockerfile is present in the source code directory, Google Cloud buildpacks automatically detects the language you are using & fetches the dependencies of the code to make a production-ready container image, using a secure base image managed by Google. (Each time you deploy, any needed security fixes are automatically picked up from the base image.)"

```
FROM node:14-slim
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --only=production
COPY . ./
CMD [ "node", "index.js" ]
```

- run `gcloud run deploy`

## _react-demo-1_

Objective: Allow users to create, list, update & destroy buckets (Essentially creating a proper backend with API Gateway & multiple microservices for each operation type)\
Tasks & notes:

- To underst& how to build node.js container images with express.js, create a simple one & deploy using gcloud comm&s - use [this](https://cloud.google.com/run/docs/quickstarts/build-&-deploy/nodejs) as guide ✅\
   *Get Dockerfile from [here](https://github.com/GoogleCloudPlatform/nodejs-docs-samples/blob/9804b07efb2fb207c2e3515e844431c130e6c7b2/run/helloworld/Dockerfile)*✅\
- Create 4 service accounts (for each microservice) (with custom roles if need be) to only do the above
- Create 5 dummy buckets so there is something to GET when the app first loads
- Create a `.js` file to test SDK locally before implementing in microservices ✅
- Create 4 node.js containerized images that will serve as the microservices\
  _GET_\
  _POST_\
  _PUT/PATCH_\
  _DESTROY_
