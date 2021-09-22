Code divided by projects (not in the GCP resource hierarchy "project" sense), project naming convention is: "demo-" followed by a number, info below will delineate what each project does, state associated deliverables and have related notes and links

## _demo-1_

React app makes unauth'ed GET to API Gateway, API Gateway forwards request to Spring Boot Cloud Run service, service responds with "Hello World", React app displays response data
| Deliverables | Status (✅/❌/🚧) | Notes | Links |
| ------------ | ------ | ------ | ----------- |
| Hit service URL to make sure everything is working and the container returns a string | ✅ | Not using a custom "demo-1" container image, using "hello-world" in ready-to-containerize dir | none |
| Do another thing | ✅ | It was also very hard! | bye |
| Do another thing | 🚧 | Still working on it | bye |

## _demo-2_

Spring Boot Cloud Run service responds with message received from Pub/Sub, check service logs to validate, Pub/Sub message should be logged

- using code (with modifications, e.g., not using jib to build, so had to create a Dockerfile) from [here](https://github.com/GoogleCloudPlatform/java-docs-samples/tree/master/run/pubsub)

| Deliverables                                                                                                                    | Status (✅/❌/🚧) | Notes                                                                                                                                                                                                                                                  | Links |
| ------------------------------------------------------------------------------------------------------------------------------- | ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----- |
| Run `docker build -t demo-2 .` to validate Dockerfile                                                                           | ✅                | this is actually useless from config validation perspective, when running tf you could still get the Cloud Run service provisioning to error                                                                                                           | none  |
| Create cloud-run, cloud-build, source-repo, iam, provider, vars, pubsub tf files                                                | ✅                | none                                                                                                                                                                                                                                                   | none  |
| Push container image to Container Registry                                                                                      | ✅                | none                                                                                                                                                                                                                                                   | none  |
| Run tf code                                                                                                                     | ✅                | pom.xml `artifactId` and `name` is **demo2**, same as what's in Dockerfile preceding `.jar` and also on the top of Java files (e.g., `package com.example.demo2;`) this consistency is important otherwise you'll get errors when building the service | none  |
| Publish a message with command `gcloud pubsub topics publish demo-pic --message "World"` and validate in Cloud Run service logs | ✅                | none                                                                                                                                                                                                                                                   | none  |
