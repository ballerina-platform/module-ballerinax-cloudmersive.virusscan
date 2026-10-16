// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/os;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? "https://api.cloudmersive.com/virus/scan" : "http://localhost:9090";
final string apiKey = isLiveServer ? os:getEnv("CLOUDMERSIVE_API_KEY") : "test_api_key";

final Client cloudmersive = check new ({apikey: apiKey}, serviceUrl = serviceUrl);

isolated function sampleFile() returns record {byte[] fileContent; string fileName;} => {fileContent: "sample file content".toBytes(), fileName: "sample.txt"};

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testScanFile() returns error? {
    VirusScanResult response = check cloudmersive->scanFile({inputFile: sampleFile()});
    test:assertTrue(response?.cleanResult is boolean);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testScanFileAdvanced() returns error? {
    VirusScanAdvancedResult response = check cloudmersive->scanFileAdvanced({inputFile: sampleFile()});
    test:assertTrue(response?.cleanResult is boolean);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testScanWebsite() returns error? {
    WebsiteScanResult response = check cloudmersive->scanWebsite({url: "https://www.example.com"});
    test:assertTrue(response?.cleanResult is boolean);
}

@test:Config {groups: ["mock_tests"]}
isolated function testScanAzureBlob() returns error? {
    CloudStorageVirusScanResult response = check cloudmersive->scanAzureBlob({connectionString: "conn", containerName: "container", blobPath: "sample.txt"});
    test:assertTrue(response?.successful is boolean);
}

@test:Config {groups: ["mock_tests"]}
isolated function testScanAzureBlobAdvanced() returns error? {
    CloudStorageAdvancedVirusScanResult response = check cloudmersive->scanAzureBlobAdvanced({connectionString: "conn", containerName: "container", blobPath: "sample.txt"});
    test:assertTrue(response?.successful is boolean);
}

@test:Config {groups: ["mock_tests"]}
isolated function testScanAzureBlobAdvancedBatchJob() returns error? {
    ScanCloudStorageBatchJobCreateResult response = check cloudmersive->scanAzureBlobAdvancedBatchJob({connectionString: "conn", containerName: "container", blobPath: "sample.txt"});
    test:assertTrue(response?.asyncJobID is string);
}

@test:Config {groups: ["mock_tests"]}
isolated function testScanAwsS3FileAdvancedBatchJob() returns error? {
    ScanCloudStorageBatchJobCreateResult response = check cloudmersive->scanAwsS3FileAdvancedBatchJob();
    test:assertTrue(response?.asyncJobID is string);
}

@test:Config {groups: ["mock_tests"]}
isolated function testScanGcpStorageFileAdvancedBatchJob() returns error? {
    ScanCloudStorageBatchJobCreateResult response = check cloudmersive->scanGcpStorageFileAdvancedBatchJob();
    test:assertTrue(response?.asyncJobID is string);
}

@test:Config {groups: ["mock_tests"]}
isolated function testScanAwsS3File() returns error? {
    CloudStorageVirusScanResult response = check cloudmersive->scanAwsS3File({accessKey: "key", secretKey: "secret", bucketRegion: "us-east-1", bucketName: "bucket", keyName: "sample.txt"});
    test:assertTrue(response?.successful is boolean);
}

@test:Config {groups: ["mock_tests"]}
isolated function testScanAwsS3FileAdvanced() returns error? {
    CloudStorageAdvancedVirusScanResult response = check cloudmersive->scanAwsS3FileAdvanced({accessKey: "key", secretKey: "secret", bucketRegion: "us-east-1", bucketName: "bucket", keyName: "sample.txt"});
    test:assertTrue(response?.successful is boolean);
}

@test:Config {groups: ["mock_tests"]}
isolated function testScanSharePointOnlineFile() returns error? {
    CloudStorageVirusScanResult response = check cloudmersive->scanSharePointOnlineFile({clientID: "id", clientSecret: "secret", sharepointDomainName: "contoso.sharepoint.com", siteID: "site", filePath: "/docs/sample.txt"});
    test:assertTrue(response?.successful is boolean);
}

@test:Config {groups: ["mock_tests"]}
isolated function testScanSharePointOnlineFileAdvanced() returns error? {
    CloudStorageAdvancedVirusScanResult response = check cloudmersive->scanSharePointOnlineFileAdvanced({clientID: "id", clientSecret: "secret", sharepointDomainName: "contoso.sharepoint.com", siteID: "site"});
    test:assertTrue(response?.successful is boolean);
}

@test:Config {groups: ["mock_tests"]}
isolated function testScanGcpStorageFile() returns error? {
    CloudStorageVirusScanResult response = check cloudmersive->scanGcpStorageFile({bucketName: "bucket", objectName: "sample.txt"}, {jsonCredentialFile: {fileContent: "{}".toBytes(), fileName: "credentials.json"}});
    test:assertTrue(response?.successful is boolean);
}

@test:Config {groups: ["mock_tests"]}
isolated function testScanGcpStorageFileAdvanced() returns error? {
    CloudStorageAdvancedVirusScanResult response = check cloudmersive->scanGcpStorageFileAdvanced({bucketName: "bucket", objectName: "sample.txt"}, {jsonCredentialFile: {fileContent: "{}".toBytes(), fileName: "credentials.json"}});
    test:assertTrue(response?.successful is boolean);
}

@test:Config {groups: ["mock_tests"]}
isolated function testGetAsyncJobStatus() returns error? {
    ScanCloudStorageJobStatusResult response = check cloudmersive->getAsyncJobStatus(asyncJobID = "3f1c2b8e-5d6a-4c1e-9a77-0b6d2f9d4a10");
    test:assertEquals(response?.asyncJobStatus, "COMPLETED");
}
