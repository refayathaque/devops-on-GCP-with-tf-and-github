# [IAM](https://cloud.google.com/iam/docs/overview)

- Lets you adopt the security **principle of least privilege**, which states that nobody should have more permissions than they actually need.
- You manage access control by defining **who (identity) has what access (role) for which resource**. For example, Compute Engine virtual machine instances, Google Kubernetes Engine (GKE) clusters, and Cloud Storage buckets are all Google Cloud resources. The organizations, folders, and projects that you use to organize your resources are also resources.
- Permission to access a resource isn't granted directly to the end user. Instead, **permissions are grouped into roles, and roles are granted to authenticated members.**
- **Policy** defines and enforces what roles are granted to which members, and this policy is _attached to a resource_.
  - When an authenticated member attempts to access a resource, **IAM checks the resource's policy to determine whether the action is permitted.**
- [Overview diagram](https://cloud.google.com/iam/img/iam-overview-basics.svg)

## Member (aka identities)

- Can be a _Google Account (for end users), a service account (for apps and virtual machines), a Google group, or a Google Workspace or Cloud Identity domain_ that can access a resource. The identity of a member is an email address associated with a user, service account, or Google group; or a domain name associated with Google Workspace or Cloud Identity domains.
- [Types of members](https://cloud.google.com/iam/docs/overview#concepts_related_identity)
- [Service account](https://cloud.google.com/iam/docs/service-accounts#what_are_service_accounts)
  - Account for an _application instead of an individual end user._ When you run code that's hosted on Google Cloud, the code runs as the account you specify. You can create as many service accounts as needed to represent the different logical components of your application.
  - Special kind of account used by an application or a virtual machine (VM) instance, not a person. _Applications use service accounts to make authorized API calls, authorized as either the service account itself_, or as Google Workspace or Cloud Identity users through domain-wide delegation.
  - For example, a Compute Engine VM can run as a service account, and that _account can be given permissions to access the resources it needs._ This way the service account is the identity of the service, and the service account's permissions control which resources the service can access.
  - Do not have passwords, and cannot log in via browsers or cookies.
  - Associated with **private/public RSA key-pairs that are used for authentication** to Google.
    - Each service account is associated with two sets of public/private RSA key pairs that are used to authenticate to Google: [Google-managed keys, and user-managed keys](https://cloud.google.com/iam/docs/service-accounts#service_account_keys).
    - Need to have `service-account-key` as JSON file (I think this is an example of user-managed keys...not entirely sure...) when using Terraform to make infrastructure-related API calls from local machine to GCP
  - [Types](https://cloud.google.com/iam/docs/service-accounts#types)
    - [Google-managed service accounts](https://cloud.google.com/iam/docs/service-accounts#google-managed)
      - Some Google Cloud services need access to your resources so that they can act on your behalf. _For example, when you use Cloud Run to run a container, the service needs access to any Pub/Sub topics that can trigger the container. To meet this need, Google creates and manages service accounts for many Google Cloud services._
      - Not listed in the Service accounts page in the Cloud Console.
  - **Both identities and resources**
    - Because service accounts are identities, you can _let a service account access resources in your project by granting it a role, just like you would for any other member._ For example, if you want to let your application's service account access objects in a Cloud Storage bucket, you can grant the service account the Storage Object Viewer role (roles/storage.objectViewer) on the bucket.
    - Service accounts are also _resources that accept IAM policies. As a result, you can let other members access a service account by granting them a role on the service account, or on one of the service account's parent resources._
- Group
  - Named collection of Google Accounts and service accounts. Every Google group has a unique email address that's associated with the group.
  - Convenient way to apply an access policy to a collection of users. You can _grant and change access controls for a whole group at once_ instead of granting or changing access controls one at a time for individual users or service accounts.
  - You can also easily add members to and remove members from a Google group _instead of updating an IAM policy to add or remove users._

## Role

- Collection of permissions. Permissions determine what operations are allowed on a resource. When you _grant a role to a member (via policies)_, you grant all the permissions that the role contains.
- **Permissions**
  - Determine what operations are allowed on a resource. In the IAM world, permissions are represented in the form of `service.resource.verb`, for example, `pubsub.subscriptions.consume`.
  - Often correspond one-to-one with REST API methods. That is, each Google Cloud service has an associated set of permissions for each REST API method that it exposes. The caller of that method needs those permissions to call that method. For example, if you use Pub/Sub, and you need to call the `topics.publish()` method, you must have the `pubsub.topics.publish` permission for that topic.
- Kinds of roles
  - Basic
    - Roles historically available in the Google Cloud Console. These roles are Owner, Editor, and Viewer.
      - _Do not grant basic roles unless there is no alternative. Instead, grant the most limited predefined roles or custom roles that meet your needs._
  - Predefined
    - Roles that give _finer-grained access control_ than the basic roles. For example, the predefined role Pub/Sub Publisher (roles/pubsub.publisher) provides access to only publish messages to a Pub/Sub topic.
    - [List of all](https://cloud.google.com/iam/docs/understanding-roles#predefined_roles)
  - Custom
    - Roles that you create to tailor permissions to the needs of your organization when predefined roles don't meet your needs.
    - [Creating](https://cloud.google.com/iam/docs/creating-custom-roles)
- [Product-specific IAM documentation](https://cloud.google.com/iam/docs/understanding-roles#product_specific_documentation)

## Policy

- Grant roles to users by creating an IAM policy, which is a _collection of statements that define who has what type of access._
- Collection of _role bindings that bind one or more members to individual roles._ When you want to define who (member) has what type of access (role) on a resource, you create a policy and _attach it to the resource_.
- Used to _enforce access control whenever that resource is accessed._
- The policy controls access to the resource itself, _as well as any descendants of that resource that inherit the policy._
- You can attach only **one IAM policy to each resource.**

```
  {
  "bindings": [
    {
      "role": "roles/storage.objectAdmin",
       "members": [
         "user:ali@example.com",
         "serviceAccount:my-other-app@appspot.gserviceaccount.com",
         "group:admins@example.com",
         "domain:google.com"
       ]
    },
    {
      "role": "roles/storage.objectViewer",
      "members": [
        "user:maria@example.com"
      ]
    }
  ]
}
```

- In addition to `member` and `role`, you can have `condition`, `etag` and `version` (the latter two are considered metadata)
  - Condition, which is an _optional logic expression that further constrains the role binding based on attributes about the request_, such as its origin, the target resource, and so on. Conditions are typically used to control whether access is granted based on the context for a request.
    - If a role binding contains a condition, it is referred to as a _conditional role binding._
    - Some Google Cloud services [do not accept conditions in IAM policies.](https://cloud.google.com/iam/docs/conditions-overview#resources)
    - [Example](https://cloud.google.com/iam/docs/policies#conditional-bindings)
    - Conditional role bindings _do not override role bindings with no conditions._ If a member is bound to a role, and the role binding does not have a condition, then the member always has that role. Adding the member to a conditional role binding for the same role has no effect.
      - [Example](https://cloud.google.com/iam/docs/policies#conditional-and-unconditional)
  - Etag field, which is used for concurrency control, and ensures that policies are updated consistently.
  - [Version field, which specifies the schema version for a given policy.](https://cloud.google.com/iam/docs/policies#valid)
  - [Policy inheritance](https://cloud.google.com/iam/docs/policies#inheritance)
    - term that describes how policies apply to resources beneath their level in the resource hierarchy. Effective policy is the term that describes how all parent policies in the resource hierarchy are inherited for a resource. It is the _union of the following: policy set on the resource and policies set on all of resource's ancestry resource levels in the hierarchy_
    - [Example](https://cloud.google.com/iam/docs/policies#example-inheritance)
  - [**Best practices**](https://cloud.google.com/iam/docs/policies#policy-best-practices)
    - When _managing multiple user accounts with the same access configurations, use Google groups instead._ Put each individual user account into the group, and grant the intended roles to the group instead of individual user accounts.

## Resource hierarchy

- Organization is the root node in the hierarchy.
  - Folders are children of the organization.
    - Projects are children of the organization, or of a folder.
      - Resources for each service are descendants of projects.
- _Each resource has exactly one parent._
  - [Diagram](https://cloud.google.com/iam/img/policy-inheritance.svg)
- You can set an IAM policy at any level in the resource hierarchy: the organization level, the folder level, the project level, or the resource level.
  - **Resources inherit the policies of all of their parent resources. The effective policy for a resource is the union of the policy set on that resource and the policies inherited from higher up in the hierarchy.**
  - Policy inheritance is **transitive; in other words, resources inherit policies from the project, which inherit policies from folders, which inherit policies from the organization. Therefore, the organization-level policies also apply at the resource level.**