# Pub/Sub

- Pub/Sub enables you to create systems of event producers and consumers, called publishers and subscribers. Publishers communicate with subscribers asynchronously by broadcasting events, rather than by synchronous remote procedure calls (RPCs).
- Publishers send events to the Pub/Sub service, without regard to how or when these events will be processed. Pub/Sub then delivers events to all services that need to react to them. Compared to systems communicating through RPCs, where publishers must wait for subscribers to receive the data, such asynchronous integration increases the flexibility and robustness of the system overall.

- Pub/Sub is intended for [service-to-service communication rather than communication with end-user or IoT clients](https://cloud.google.com/pubsub/docs/overview#service-to-service_vs_service-to-client_communication). Other patterns are better supported by other products:

  - Client-server: To send messages between a mobile/web app and a service, use products that include Firebase Realtime Database and Firebase Cloud Messaging.
  - IoT-client-service: To send messages between an IoT app and a service, use Cloud IoT Core
  - Asynchronous service calls: Use Cloud Tasks

- Pub/Sub has many [integrations](https://cloud.google.com/pubsub/docs/overview#integrations) with other Google Cloud products to create a fully featured messaging system:

- Core concepts
  - Topic: A named resource to which messages are sent by publishers.
  - Subscription: A named resource representing the stream of messages from a single, specific topic, to be delivered to the subscribing application. For more details about subscriptions and message delivery semantics, see the [Subscriber Guide](https://cloud.google.com/pubsub/subscriber).
  - Message: The combination of data and (optional) attributes that a publisher sends to a topic and is eventually delivered to subscribers.
  - Message attribute: A key-value pair that a publisher can define for a message. For example, key iana.org/language_tag and value en could be added to messages to mark them as readable by an English-speaking subscriber.
  - Publisher: An application that creates and sends messages to a topic(s).
  - Subscriber: An application with a subscription to a topic(s) to receive messages from it.
  - Acknowledgement (or "ack"): A signal sent by a subscriber to Pub/Sub after it has received a message successfully. Acked messages are removed from the subscription's message queue.
  - Push and pull: The two message delivery methods. A subscriber receives messages either by Pub/Sub pushing them to the subscriber's chosen endpoint, or by the subscriber pulling them from the service.

## [Publishers](https://cloud.google.com/pubsub/docs/publisher)

- A publisher application creates and sends messages to a topic. Pub/Sub offers at-least-once message delivery and best-effort ordering to existing subscribers, as explained in the Subscriber Overview.
- The general flow for a publisher application is:
  - Create a message containing your data.
  - Send a request to the Pub/Sub Server to publish the message to the desired topic.
- A message consists of fields with the message data and metadata. Specify at least one of the following in the message:
  - The message data
  - An ordering key
  - Attributes with additional metadata
  - If you're using the REST API, the message data must be base64-encoded.
  - The Pub/Sub service adds the following fields to the message:
    - A message ID unique to the topic
    - A timestamp for when the Pub/Sub service receives the message

## Subscriptions

- To receive messages published to a topic, you must create a subscription to that topic. Only messages published to the topic after the subscription is created are available to subscriber applications. The subscription connects the topic to a subscriber application that receives and processes messages published to the topic.
  - _A topic can have multiple subscriptions, but a given subscription belongs to a single topic_.
- [Push/Pull delivery](https://cloud.google.com/pubsub/docs/subscriber#push_pull)
  - In pull delivery, your subscriber application initiates requests to the Pub/Sub server to retrieve messages.
  - In push delivery, Pub/Sub initiates requests to your subscriber application to deliver messages.
  - Table in link above offers some guidance in choosing the appropriate delivery mechanism for your application.
- When Pub/Sub delivers a message to a push endpoint, Pub/Sub sends the message in the body of a POST request. The body of the request is a JSON object and the message data is in the message.data field. The message data is base64-encoded. The following [example](https://cloud.google.com/pubsub/docs/push#receiving_messages) is the body of a POST request to a push endpoint:

```
{
    "message": {
        "attributes": {
            "key": "value"
        },
        "data": "SGVsbG8gQ2xvdWQgUHViL1N1YiEgSGVyZSBpcyBteSBtZXNzYWdlIQ==",
        "messageId": "2070443601311540",
        "message_id": "2070443601311540",
        "publishTime": "2021-02-26T19:13:55.749Z",
        "publish_time": "2021-02-26T19:13:55.749Z",
    },
   "subscription": "projects/myproject/subscriptions/mysubscription"
}
```

## [Auth](https://cloud.google.com/pubsub/docs/push#setting_up_for_push_authentication)

- Cloud Run and App Engine automatically authenticate HTTP calls by verifying Pub/Sub-generated tokens. The only configuration required of the user is that the necessary IAM roles be granted to the caller account. For example, you can authorize or revoke permission to call a particular Cloud Run endpoint for an account. For details, see the following tutorials:
  - [Using Cloud Pub/Sub with Cloud Run Tutorial](https://cloud.google.com/run/docs/tutorials/pubsub#integrating-pubsub)
  - [Triggering from Cloud Pub/Sub push](https://cloud.google.com/run/docs/events/pubsub-push)
