# Ballerina Cloudmersive Virus Scan connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-cloudmersive.virusscan/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-cloudmersive.virusscan/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-cloudmersive.virusscan.svg)](https://github.com/ballerina-platform/module-ballerinax-cloudmersive.virusscan/commits/main)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/cloudmersive.virusscan.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%2Fcloudmersive.virusscan)

## Overview

The Cloudmersive Virus Scan connector lets Ballerina applications scan files, websites and cloud storage objects for viruses, malware and other content threats using the [Cloudmersive Virus Scan API](https://api.cloudmersive.com/docs/virus.asp). It supports version v1 of the API, which combines signature-based virus detection with configurable content policies such as blocking executables, scripts, macros and invalid files.

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

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`cloudmersive.virusscan` package](https://central.ballerina.io/ballerinax/cloudmersive.virusscan/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
