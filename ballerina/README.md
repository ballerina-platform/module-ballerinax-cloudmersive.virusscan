## Overview

The Cloudmersive Virus Scan connector lets Ballerina applications scan files, websites and cloud storage objects for viruses, malware and other content threats using the [Cloudmersive Virus Scan API](https://api.cloudmersive.com/docs/virus.asp). It supports version v1 of the API, which combines signature-based virus detection with configurable content policies such as blocking executables, scripts, macros and invalid files.

### Key features

- Scan uploaded files for viruses and malware
- Apply advanced threat rules that block executables, scripts, macros, HTML and unsafe archives, or restrict accepted file types
- Scan websites for malware, phishing and forced downloads
- Scan files in Azure Blob Storage, AWS S3, Google Cloud Storage and SharePoint Online without downloading them
- Run cloud storage scans as batch jobs and retrieve their status and results

## Setup guide

To use the connector, you need a Cloudmersive API key.

1. Sign up for a [Cloudmersive account](https://account.cloudmersive.com/signup) and sign in to the [Cloudmersive management portal](https://account.cloudmersive.com/).

2. Open the **API Keys** page and create a new API key, or copy an existing one.

> **Note:** Batch job operations require a Cloudmersive Managed Instance or Private Cloud deployment.

## Quickstart

To use the Cloudmersive Virus Scan connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerina/io;
import ballerinax/cloudmersive.virusscan;
```

### Step 2: Create a `Config.toml` file

```toml
apiKey = "<Cloudmersive API key>"
```

### Step 3: Create a client

```ballerina
configurable string apiKey = ?;

final virusscan:Client scanner = check new ({apikey: apiKey});
```

### Step 4: Invoke an operation

```ballerina
public function main() returns error? {
    byte[] content = check io:fileReadBytes("sample.pdf");
    virusscan:VirusScanResult _ = check scanner->scanFile({inputFile: {fileContent: content, fileName: "sample.pdf"}});
}
```

## Examples

The Cloudmersive Virus Scan connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-cloudmersive.virusscan/tree/main/examples/), covering the following use cases:

1. [Upload threat screening](https://github.com/ballerina-platform/module-ballerinax-cloudmersive.virusscan/tree/main/examples/upload_threat_screening) - Scans an uploaded file with the basic and advanced scans, reports threats, and checks the linked website.
2. [Cloud blob batch scan](https://github.com/ballerina-platform/module-ballerinax-cloudmersive.virusscan/tree/main/examples/cloud_blob_batch_scan) - Starts an advanced Azure Blob scan as a batch job and polls its status until it completes.
