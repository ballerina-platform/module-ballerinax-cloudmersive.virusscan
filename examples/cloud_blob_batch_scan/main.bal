import ballerina/io;
import ballerina/lang.runtime;
import ballerinax/cloudmersive.virusscan;

configurable string apiKey = ?;
configurable string azureConnectionString = ?;
configurable string containerName = ?;
configurable string blobPath = ?;
configurable int maxPolls = 10;

public function main() returns error? {
    virusscan:Client scanner = check new ({apikey: apiKey});

    // Step 1: Start an advanced scan of the blob as a batch job.
    virusscan:ScanCloudStorageBatchJobCreateResult job = check scanner->scanAzureBlobAdvancedBatchJob(
        {connectionString: azureConnectionString, containerName, blobPath, allowExecutables: false});
    string jobId = job.asyncJobID ?: "";
    if jobId == "" {
        return error("The batch job was not created");
    }
    io:println("Batch job started: ", jobId);

    // Step 2: Poll the job until it finishes.
    foreach int attempt in 1 ... maxPolls {
        virusscan:ScanCloudStorageJobStatusResult status = check scanner->getAsyncJobStatus(asyncJobID = jobId);
        if status.successful != true {
            return error("Batch job status lookup failed: " + (status.errorMessage ?: "no details"));
        }
        string state = status.asyncJobStatus ?: "UNKNOWN";
        io:println("Attempt ", attempt, ": ", state);
        if state == "COMPLETED" {
            virusscan:CloudStorageAdvancedVirusScanResult? result = status.result;
            if result is () {
                return error("The completed batch job returned no scan result");
            }
            boolean? clean = result.cleanResult;
            if clean is () {
                return error("The scan result has no clean verdict");
            }
            io:println("Blob clean: ", clean);
            return;
        }
        if state == "FAILED" {
            return error("Batch job failed: " + (status.errorMessage ?: "no details"));
        }
        runtime:sleep(5);
    }
    return error("The batch job did not finish within the polling limit");
}
