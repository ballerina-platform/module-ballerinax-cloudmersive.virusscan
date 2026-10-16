# Cloud blob batch scan

This example scans a file stored in Azure Blob Storage without downloading it. It starts an advanced scan as a batch job, polls the job status until it completes, and reports whether the blob is clean. Batch jobs need a Cloudmersive Managed Instance or Private Cloud.

## Prerequisites

- Ballerina Swan Lake 2201.12.0 or later
- A Cloudmersive API key for a Managed Instance or Private Cloud
- An Azure Storage connection string and the container and path of the blob to scan
- Create a `Config.toml` in this directory:

  ```toml
  apiKey = "<Cloudmersive API key>"
  azureConnectionString = "<Azure Storage connection string>"
  containerName = "<Container name>"
  blobPath = "<Blob path>"
  maxPolls = 10
  ```

## Run the example

```bash
bal run
```
