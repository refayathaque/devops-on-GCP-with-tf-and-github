// https://stackoverflow.com/a/68783000
// So, on top of what other suggested of using "type": "module" on package.json you also need to specify the file extension import {urls} from './helpers.js'
import vars from "./vars.js";
import { Storage } from "@google-cloud/storage";

const { keyFilename } = vars;
const storage = new Storage({
  keyFilename,
});

function listBucketsTransformed() {
  async function fetchBuckets() {
    const response = await storage.getBuckets();
    const [buckets] = response;
    // response gives data we want in an array inside of another array [[]], the array we want has an index of 0, so we're destructuring that out and giving that array the name "buckets"
    buckets.forEach((bucket) => {
      // console.log(bucket.name);
      console.log(bucket.metadata);
      // console.log(bucket);
      // ^ to see everything that's in the Bucket object
    });
  }
  fetchBuckets().catch(console.error);
}

function listBuckets() {
  async function fetchBuckets() {
    const response = await storage.getBuckets();
    console.log(response);
  }
  fetchBuckets().catch(console.error);
}

listBucketsTransformed();
// listBuckets();

// https://github.com/googleapis/nodejs-storage/blob/main/samples/listBuckets.js
