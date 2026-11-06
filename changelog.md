# Changelog

All notable changes to this project are documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- `scanFile` and `scanFileAdvanced`, which scan an uploaded file, with the `ScanFileRequest` and `ScanFileAdvancedHeaders` records. They return the existing `VirusScanResult` and `VirusScanAdvancedResult` records.
- `scanGcpStorageFile` and `scanGcpStorageFileAdvanced`, which scan a file in Google Cloud Storage, with the `ScanGcpStorageFileRequest`, `ScanGcpStorageFileHeaders` and `ScanGcpStorageFileAdvancedHeaders` records.
- `scanSharePointOnlineFile` and `scanSharePointOnlineFileAdvanced`, which scan a file in a SharePoint Online site, with the `ScanSharePointOnlineFileHeaders` and `ScanSharePointOnlineFileAdvancedHeaders` records.
- Batch jobs for cloud storage scans: `scanAzureBlobAdvancedBatchJob`, `scanAwsS3FileAdvancedBatchJob`, `scanGcpStorageFileAdvancedBatchJob` and `getAsyncJobStatus`, with the records they use (`ScanAzureBlobAdvancedBatchJobHeaders`, `GetAsyncJobStatusQueries`, `ScanCloudStorageBatchJobCreateResult`, `ScanCloudStorageJobStatusResult`).
- New scan options on `scanAzureBlobAdvanced` and `scanAwsS3FileAdvanced`: `allowXmlExternalEntities`, `allowHtml`, `allowUnsafeArchives`, `allowInsecureDeserialization`, `allowOleEmbeddedObject`, `allowUnwantedAction` and `options`. `scanAwsS3File` and `scanAwsS3FileAdvanced` also take an optional `roleArn`.
- New fields on the scan results:
  - `CloudStorageVirusScanResult`: `containsExecutable`, `containsInvalidFile`, `containsScript`, `containsPasswordProtectedFile`, `containsRestrictedFileFormat`, `containsMacros`, `containsXmlExternalEntities`, `containsInsecureDeserialization`, `containsHtml`, `containsUnsafeArchive`, `containsOleEmbeddedObject`, `containsContentModerationRejection` and `verifiedFileFormat`.
  - `CloudStorageAdvancedVirusScanResult`: `containsXmlExternalEntities`, `containsInsecureDeserialization`, `containsHtml`, `containsUnsafeArchive`, `containsOleEmbeddedObject` and `contentInformation`.
  - `VirusScanAdvancedResult`: `containsInsecureDeserialization`, `containsHtml`, `containsUnsafeArchive`, `containsOleEmbeddedObject`, `containsUnwantedAction` and `contentInformation`.
- The `AdditionalAdvancedScanInformation` record, the type of `contentInformation`.
- A `headers` parameter on every remote method.
- New `ConnectionConfig` fields, taken from `http:ClientConfiguration`: `followRedirects`, `cookieConfig`, `socketConfig` and `laxDataBinding`.

### Changed

- **Breaking:** the remote methods are renamed:
  - `scanCloudStorageScanAzureBlob` is now `scanAzureBlob`.
  - `scanCloudStorageScanAzureBlobAdvanced` is now `scanAzureBlobAdvanced`.
  - `scanCloudStorageScanAwsS3file` is now `scanAwsS3File`.
  - `scanCloudStorageScanAwsS3fileAdvanced` is now `scanAwsS3FileAdvanced`.
- **Breaking:** the cloud storage scan methods take their connection details and scan options as a typed headers record (`ScanAzureBlobHeaders`, `ScanAzureBlobAdvancedHeaders`, `ScanAwsS3FileHeaders` and `ScanAwsS3FileAdvancedHeaders`) instead of positional parameters:

    ```ballerina
    // 1.5.2
    virusscan:CloudStorageVirusScanResult result = check cl->scanCloudStorageScanAzureBlob(connectionString, "files", "report.pdf");
    ```

    ```ballerina
    // 2.0.0
    virusscan:CloudStorageVirusScanResult result = check cl->scanAzureBlob({connectionString, containerName: "files", blobPath: "report.pdf"});
    ```

- **Breaking:** record fields use camel case, mapped to the API's Pascal-case JSON names with `@jsondata:Name`. For example, `VirusScanResult.CleanResult` is now `cleanResult`, and `WebsiteScanResult.FoundViruses` is now `foundViruses`.
- **Breaking:** `WebsiteScanResult.websiteThreatType` is the union `"None"|"Malware"|"Phishing"|"ForcedDownload"|"UnableToConnect"` (was `string`).
- **Breaking:** `WebsiteScanResult.websiteHttpResponseCode` is an `int:Signed32` (was `int`).
- **Breaking:** `WebsiteScanResult.foundViruses` is `VirusFound[]` (was `VirusFound[]?`). With `laxDataBinding` (on by default) a `null` in the response is treated as an absent field.
- **Breaking:** the default `serviceUrl` is `https://api.cloudmersive.com/virus/scan`, Cloudmersive's production endpoint (was the test endpoint `https://testapi.cloudmersive.com/`). A custom `serviceUrl` must now include the `/virus/scan` path.
- **Breaking:** `ConnectionConfig.http1Settings` is now `http:ClientHttp1Settings` (was the connector's own `ClientHttp1Settings`).
- `ConnectionConfig.timeout` defaults to 30 seconds (was 60).

### Removed

- **Breaking:** the connector's own `ClientHttp1Settings` and `ProxyConfig` records. Use `http:ClientHttp1Settings` and `http:ProxyConfig` instead.
