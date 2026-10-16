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

import ballerina/http;

listener http:Listener ep0 = new (9090);

service / on ep0 {
    resource function get cloud\-storage/batch\-job/status(@http:Query {name: "AsyncJobID"} string asyncJobID) returns ScanCloudStorageJobStatusResult|xml {
        ScanCloudStorageJobStatusResult result = {successful: true, asyncJobID: asyncJobID, asyncJobStatus: "COMPLETED", jobDuration: "00:00:03", result: {successful: true, cleanResult: true, foundViruses: [], verifiedFileFormat: "pdf", fileSize: 20480}};
        return result;
    }

    resource function post cloud\-storage/aws\-s3/single(@http:Header string accessKey, @http:Header string secretKey, @http:Header string bucketRegion, @http:Header string bucketName, @http:Header string keyName, @http:Header string? roleArn) returns CloudStorageVirusScanResultXmlOk {
        CloudStorageVirusScanResult result = {successful: true, cleanResult: true, foundViruses: [], verifiedFileFormat: "docx", fileSize: 20480};
        return {body: result};
    }

    resource function post cloud\-storage/aws\-s3/single/advanced(@http:Header string accessKey, @http:Header string secretKey, @http:Header string bucketRegion, @http:Header string bucketName, @http:Header string keyName, @http:Header string? roleArn, @http:Header boolean? allowExecutables, @http:Header boolean? allowInvalidFiles, @http:Header boolean? allowScripts, @http:Header boolean? allowPasswordProtectedFiles, @http:Header boolean? allowMacros, @http:Header boolean? allowXmlExternalEntities, @http:Header boolean? allowInsecureDeserialization, @http:Header boolean? allowHtml, @http:Header boolean? allowUnsafeArchives, @http:Header boolean? allowOleEmbeddedObject, @http:Header boolean? allowUnwantedAction, @http:Header string? options, @http:Header string? restrictFileTypes) returns CloudStorageAdvancedVirusScanResultXmlOk {
        CloudStorageAdvancedVirusScanResult result = {successful: true, cleanResult: true, foundViruses: [], containsExecutable: false, containsScript: false, containsMacros: false, verifiedFileFormat: "pdf", fileSize: 20480, contentInformation: {hashSHA1: "2fd4e1c67a2d28fced849ee1bb76e7391b93eb12", containsImage: true}};
        return {body: result};
    }

    resource function post cloud\-storage/aws\-s3/single/advanced/batch\-job() returns ScanCloudStorageBatchJobCreateResultXmlOk {
        ScanCloudStorageBatchJobCreateResult result = {successful: true, asyncJobID: "3f1c2b8e-5d6a-4c1e-9a77-0b6d2f9d4a10"};
        return {body: result};
    }

    resource function post cloud\-storage/azure\-blob/single(@http:Header string connectionString, @http:Header string containerName, @http:Header string blobPath) returns CloudStorageVirusScanResultXmlOk {
        CloudStorageVirusScanResult result = {successful: true, cleanResult: true, foundViruses: [], verifiedFileFormat: "docx", fileSize: 20480};
        return {body: result};
    }

    resource function post cloud\-storage/azure\-blob/single/advanced(@http:Header string connectionString, @http:Header string containerName, @http:Header string blobPath, @http:Header boolean? allowExecutables, @http:Header boolean? allowInvalidFiles, @http:Header boolean? allowScripts, @http:Header boolean? allowPasswordProtectedFiles, @http:Header boolean? allowMacros, @http:Header boolean? allowXmlExternalEntities, @http:Header boolean? allowInsecureDeserialization, @http:Header boolean? allowHtml, @http:Header boolean? allowUnsafeArchives, @http:Header boolean? allowOleEmbeddedObject, @http:Header boolean? allowUnwantedAction, @http:Header string? options, @http:Header string? restrictFileTypes) returns CloudStorageAdvancedVirusScanResultXmlOk {
        CloudStorageAdvancedVirusScanResult result = {successful: true, cleanResult: true, foundViruses: [], containsExecutable: false, containsScript: false, containsMacros: false, verifiedFileFormat: "pdf", fileSize: 20480, contentInformation: {hashSHA1: "2fd4e1c67a2d28fced849ee1bb76e7391b93eb12", containsImage: true}};
        return {body: result};
    }

    resource function post cloud\-storage/azure\-blob/single/advanced/batch\-job(@http:Header string connectionString, @http:Header string containerName, @http:Header string blobPath, @http:Header boolean? allowExecutables, @http:Header boolean? allowInvalidFiles, @http:Header boolean? allowScripts, @http:Header boolean? allowPasswordProtectedFiles, @http:Header boolean? allowMacros, @http:Header boolean? allowXmlExternalEntities, @http:Header boolean? allowInsecureDeserialization, @http:Header boolean? allowHtml, @http:Header boolean? allowUnsafeArchives, @http:Header boolean? allowOleEmbeddedObject, @http:Header boolean? allowUnwantedAction, @http:Header string? options, @http:Header string? restrictFileTypes) returns ScanCloudStorageBatchJobCreateResultXmlOk {
        ScanCloudStorageBatchJobCreateResult result = {successful: true, asyncJobID: "3f1c2b8e-5d6a-4c1e-9a77-0b6d2f9d4a10"};
        return {body: result};
    }

    resource function post cloud\-storage/gcp\-storage/single(@http:Header string bucketName, @http:Header string objectName, http:Request request) returns CloudStorageVirusScanResultXmlOk {
        CloudStorageVirusScanResult result = {successful: true, cleanResult: true, foundViruses: [], verifiedFileFormat: "docx", fileSize: 20480};
        return {body: result};
    }

    resource function post cloud\-storage/gcp\-storage/single/advanced(@http:Header string bucketName, @http:Header string objectName, @http:Header boolean? allowExecutables, @http:Header boolean? allowInvalidFiles, @http:Header boolean? allowScripts, @http:Header boolean? allowPasswordProtectedFiles, @http:Header boolean? allowMacros, @http:Header boolean? allowXmlExternalEntities, @http:Header boolean? allowInsecureDeserialization, @http:Header boolean? allowHtml, @http:Header boolean? allowUnsafeArchives, @http:Header boolean? allowOleEmbeddedObject, @http:Header boolean? allowUnwantedAction, @http:Header string? options, @http:Header string? restrictFileTypes, http:Request request) returns CloudStorageAdvancedVirusScanResultXmlOk {
        CloudStorageAdvancedVirusScanResult result = {successful: true, cleanResult: true, foundViruses: [], containsExecutable: false, containsScript: false, containsMacros: false, verifiedFileFormat: "pdf", fileSize: 20480, contentInformation: {hashSHA1: "2fd4e1c67a2d28fced849ee1bb76e7391b93eb12", containsImage: true}};
        return {body: result};
    }

    resource function post cloud\-storage/gcp\-storage/single/advanced/batch\-job() returns ScanCloudStorageBatchJobCreateResultXmlOk {
        ScanCloudStorageBatchJobCreateResult result = {successful: true, asyncJobID: "3f1c2b8e-5d6a-4c1e-9a77-0b6d2f9d4a10"};
        return {body: result};
    }

    resource function post cloud\-storage/sharepoint\-online/site/advanced(@http:Header string clientID, @http:Header string clientSecret, @http:Header string sharepointDomainName, @http:Header string siteID, @http:Header string? tenantID, @http:Header string? filePath, @http:Header string? itemID, @http:Header boolean? allowExecutables, @http:Header boolean? allowInvalidFiles, @http:Header boolean? allowScripts, @http:Header boolean? allowPasswordProtectedFiles, @http:Header boolean? allowMacros, @http:Header boolean? allowXmlExternalEntities, @http:Header boolean? allowInsecureDeserialization, @http:Header boolean? allowHtml, @http:Header boolean? allowUnsafeArchives, @http:Header boolean? allowOleEmbeddedObject, @http:Header boolean? allowUnwantedAction, @http:Header string? restrictFileTypes) returns CloudStorageAdvancedVirusScanResultXmlOk {
        CloudStorageAdvancedVirusScanResult result = {successful: true, cleanResult: true, foundViruses: [], containsExecutable: false, containsScript: false, containsMacros: false, verifiedFileFormat: "pdf", fileSize: 20480, contentInformation: {hashSHA1: "2fd4e1c67a2d28fced849ee1bb76e7391b93eb12", containsImage: true}};
        return {body: result};
    }

    resource function post cloud\-storage/sharepoint\-online/site/single(@http:Header string clientID, @http:Header string clientSecret, @http:Header string sharepointDomainName, @http:Header string siteID, @http:Header string? tenantID, @http:Header string filePath, @http:Header string? itemID) returns CloudStorageVirusScanResultXmlOk {
        CloudStorageVirusScanResult result = {successful: true, cleanResult: true, foundViruses: [], verifiedFileFormat: "docx", fileSize: 20480};
        return {body: result};
    }

    # Scan a file for viruses
    #
    # + return - OK 
    resource function post file(http:Request request) returns VirusScanResultXmlOk {
        VirusScanResult result = {cleanResult: true, foundViruses: []};
        return {body: result};
    }

    # Advanced Scan a file for viruses
    #
    # + fileName - Optional: specify the original file name of the file being scanned.  By default the file name is taken from inputFile parameter, but if this is not provided, or you wish to override it, you can specify the original file name using this parameter
    # + allowExecutables - Set to false to block executable files (program code) from being allowed in the input file.  Default is false (recommended)
    # + allowInvalidFiles - Set to false to block invalid files, such as a PDF file that is not really a valid PDF file, or a Word Document that is not a valid Word Document.  Default is false (recommended)
    # + allowScripts - Set to false to block script files, such as a PHP files, Python scripts, BAT scripts, JS scripts, and other malicious content or security threats that can be embedded in the file.  Set to true to allow these file types.  Default is false (recommended)
    # + allowPasswordProtectedFiles - Set to false to block password protected and encrypted files, such as encrypted zip and rar files, and other files that seek to circumvent scanning through passwords.  Set to true to allow these file types.  Default is false (recommended)
    # + allowMacros - Set to false to block macros and other threats embedded in document files, such as Word, Excel and PowerPoint embedded Macros (including support for .DOCX, .XLSX, .PPTX, .DOC and .XLS), and other files that contain embedded content threats.  Set to true to allow these file types.  Default is false (recommended)
    # + allowXmlExternalEntities - Set to false to block XML External Entities and other threats embedded in XML files, and other files that contain embedded content threats.  Set to true to allow these file types.  Default is false (recommended)
    # + allowInsecureDeserialization - Set to false to block Insecure Deserialization and other threats embedded in JSON and other object serialization files, and other files that contain embedded content threats.  Set to true to allow these file types.  Default is false (recommended)
    # + allowHtml - Set to false to block HTML input in the top level file; HTML can contain XSS, scripts, local file accesses and other threats.  Set to true to allow these file types.  Default is false (recommended) [for API keys created prior to the release of this feature default is true for backward compatability].  If set to true, HTML files containing script tags will be allowed, but ContainsScript will be set to true if script tags are present
    # + allowUnsafeArchives - Set to false to block unsafe archives such as Zip Bombs, and other archives that can cause unsafe extraction outcomes.  Default is false (recommended).  If set to true, unsafe archives will be allowed
    # + allowOleEmbeddedObject - Set to false to block OLE embedded objects, which can contain vulnerabilities and executable code.  Default is false (recommended).  If set to true, OLE embedded objects will be allowed
    # + allowUnwantedAction - Set to false to block unwanted or undesired actions, which can contain execute or open links or content when the file is viewed.  Default is false (recommended).  If set to true, unwanted actions will be allowed
    # + options - Comma separated set of configuration operations.  Include permitJavascriptAndHtmlInPDFs to allow JavaScript and HTML in PDF files.  Include permitJavascriptInHtml to allow JavaScript in HTML files.  Include blockOfficeXmlOleEmbeddedFile to block embedded OLE files in Office Documents using the modern file format.  Include blockInvalidUris to block invalid URIs in Office documents.  Include permitAuthenticodeSignedExecutables to allow executables if they have a valid Authenticode signature.  Include scanMultipartFile to scan multi-part files such as split zip files.  Include ignoreRestrictFileTypesForAttachments to ignore restrictFileTypes setting for file attachments.  Include permitJavascript, permitShellScript, permitPython, permitPhp, permitBatScript, permitVbScript, permitPowershellScript to allow specific script types.  Include permitElf, permitExe, permitDll, permitSys, permitAnyWindowsExecutable, permitMsi, permitMacho, permitJar, permitApk, permitClass, permitLnk to allow specific executable types.  Include permitMacroWithoutAutoExecute to allow macros that do not automatically execute.  Default is no options
    # + restrictFileTypes - Specify a restricted set of file formats to allow as clean as a comma-separated list of file formats, such as .pdf,.docx,.png would allow only PDF, PNG and Word document files.  All files must pass content verification against this list of file formats, if they do not, then the result will be returned as CleanResult=false.  Set restrictFileTypes parameter to null or empty string to disable; default is disabled
    # + return - OK 
    resource function post file/advanced(@http:Header string? fileName, @http:Header boolean? allowExecutables, @http:Header boolean? allowInvalidFiles, @http:Header boolean? allowScripts, @http:Header boolean? allowPasswordProtectedFiles, @http:Header boolean? allowMacros, @http:Header boolean? allowXmlExternalEntities, @http:Header boolean? allowInsecureDeserialization, @http:Header boolean? allowHtml, @http:Header boolean? allowUnsafeArchives, @http:Header boolean? allowOleEmbeddedObject, @http:Header boolean? allowUnwantedAction, @http:Header string? options, @http:Header string? restrictFileTypes, http:Request request) returns VirusScanAdvancedResultXmlOk {
        VirusScanAdvancedResult result = {cleanResult: true, containsExecutable: false, containsInvalidFile: false, containsScript: false, containsPasswordProtectedFile: false, containsMacros: false, containsXmlExternalEntities: false, containsInsecureDeserialization: false, containsHtml: false, containsUnsafeArchive: false, containsOleEmbeddedObject: false, containsRestrictedFileFormat: false, containsUnwantedAction: false, verifiedFileFormat: "pdf", foundViruses: [], contentInformation: {hashSHA1: "2fd4e1c67a2d28fced849ee1bb76e7391b93eb12", containsJSON: false, containsXML: false, containsImage: true, isAuthenticodeSigned: false}};
        return {body: result};
    }

    # Scan a website for malicious content and threats
    #
    # + return - OK 
    resource function post website(@http:Payload WebsiteScanRequest|xml|map<string> payload) returns WebsiteScanResultXmlOk {
        WebsiteScanResult result = {cleanResult: true, websiteThreatType: "None", websiteHttpResponseCode: 200, foundViruses: []};
        return {body: result};
    }
}

// Service-mode response types. `bal openapi --mode client` collapses 4XX/5XX
// to `error` and never emits these, so they are defined here for the mock only.
public type CloudStorageAdvancedVirusScanResultXmlOk record {|
    *http:Ok;
    CloudStorageAdvancedVirusScanResult|xml body;
|};

public type CloudStorageVirusScanResultXmlOk record {|
    *http:Ok;
    CloudStorageVirusScanResult|xml body;
|};

public type ScanCloudStorageBatchJobCreateResultXmlOk record {|
    *http:Ok;
    ScanCloudStorageBatchJobCreateResult|xml body;
|};

public type VirusScanAdvancedResultXmlOk record {|
    *http:Ok;
    VirusScanAdvancedResult|xml body;
|};

public type VirusScanResultXmlOk record {|
    *http:Ok;
    VirusScanResult|xml body;
|};

public type WebsiteScanResultXmlOk record {|
    *http:Ok;
    WebsiteScanResult|xml body;
|};
