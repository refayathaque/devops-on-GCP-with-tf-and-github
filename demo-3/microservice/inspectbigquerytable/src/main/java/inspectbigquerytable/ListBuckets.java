package inspectbigquerytable;

import com.google.api.gax.paging.Page;
import com.google.cloud.storage.Bucket;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;

public class ListBuckets {
  public static void main(String[] args) {
    String projectId = "wbtg63wxu";

    Storage storage = StorageOptions.newBuilder().setProjectId(projectId).build().getService();
    Page<Bucket> buckets = storage.list();

    for (Bucket bucket : buckets.iterateAll()) {
      System.out.println(bucket.getName());
    }
  }
}

// https://github.com/googleapis/google-cloud-java/blob/HEAD/google-cloud-examples/src/main/java/com/google/cloud/examples/storage/buckets/ListBuckets.java