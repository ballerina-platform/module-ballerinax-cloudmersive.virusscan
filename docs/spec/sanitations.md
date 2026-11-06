_Author_:  @DimuthuMadushan \
_Created_: 2026/10/16 \
_Updated_: 2026/10/16 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Cloudmersive Virus Scan. 
The OpenAPI specification is obtained from at [wso2/api-specs](https://github.com/wso2/api-specs/blob/main/openapi/cloudmersive/virusscan/v1/openapi.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.


1. Update the API Paths
- **Original**: Paths included common prefix `/virus/scan` in each endpoint.
- **Updated**: Common prefix removed from endpoints as it is now in the base URL.
- **Reason**: Simplifies API paths and avoids duplication.
<!-- auto-generated -->

2. Remove empty `consumes` arrays from operations
- **Original**: `scanAwsS3FileAdvancedBatchJob`, `scanGcpStorageFileAdvancedBatchJob` and `getAsyncJobStatus` declared `"consumes": []`.
- **Updated**: The empty `consumes` arrays are deleted from the original spec so the operations fall back to the document defaults.
- **Reason**: An empty per-operation `consumes` overrides the global media types and makes the operation bind as a generic `http:Response`.

3. Fix the doubled slash in the base URL (aligned spec, re-apply after a re-align)
- **Original**: `bal openapi align` folds the common `/virus/scan` prefix into the server URL and produces `https://api.cloudmersive.com//virus/scan`.
- **Updated**: The server URL in `aligned_ballerina_openapi.json` is edited to `https://api.cloudmersive.com/virus/scan`.
- **Reason**: The double slash would be sent on every request. This is a hand edit to the aligned spec and must be re-applied after a re-align.

4. Batch-job operations for AWS S3 and GCP Storage have no parameters (known limitation, not changed)
- **Original**: `/virus/scan/cloud-storage/aws-s3/single/advanced/batch-job` and `/virus/scan/cloud-storage/gcp-storage/single/advanced/batch-job` declare no headers or request body, unlike their Azure Blob counterpart.
- **Updated**: Left as given. The generated `scanAwsS3FileAdvancedBatchJob` and `scanGcpStorageFileAdvancedBatchJob` methods accept only free-form headers.
- **Reason**: The vendor documentation was not available to confirm the credential and scan option headers, so none were invented.

5. Replace the generic response descriptions
- **Original**: All 15 operations returned the placeholder response description `OK` on their `200` response.
- **Updated**: Each `200` response description in the original spec now states the operation-specific result, for example "Virus scan result for the Azure Blob, including whether it is clean and any viruses found" or "Batch job created for the AWS S3 file scan, with the job ID to use when checking its status".
- **Reason**: `OK` carries no information and becomes the `# + return - OK` doc comment on every generated client method.

6. Point the server host at the public-cloud endpoint
- **Original**: The Swagger `host` was `testapi.cloudmersive.com`, a test endpoint.
- **Updated**: `host` is changed to `api.cloudmersive.com` in the original spec, so the generated client defaults to `https://api.cloudmersive.com/virus/scan`.
- **Reason**: The public Cloudmersive cloud API is served from `api.cloudmersive.com`.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json -o ballerina --mode client --client-methods remote --license docs/license.txt
```
