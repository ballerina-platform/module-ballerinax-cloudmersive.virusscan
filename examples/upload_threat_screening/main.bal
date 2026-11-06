import ballerina/io;
import ballerinax/cloudmersive.virusscan;

configurable string apiKey = ?;
configurable string filePath = ?;
configurable string websiteUrl = ?;
configurable boolean allowMacros = false;

public function main() returns error? {
    virusscan:Client scanner = check new ({apikey: apiKey});

    // Step 1: Run the basic virus scan on the uploaded file.
    byte[] content = check io:fileReadBytes(filePath);
    virusscan:VirusScanResult basic = check scanner->scanFile({inputFile: {fileContent: content, fileName: filePath}});
    boolean clean = basic.cleanResult ?: false;
    io:println("Basic scan clean: ", clean);

    // Step 2: Apply a strict advanced policy only if the basic scan passed.
    if clean {
        virusscan:VirusScanAdvancedResult advanced = check scanner->scanFileAdvanced(
            {inputFile: {fileContent: content, fileName: filePath}},
            {allowExecutables: false, allowScripts: false, allowMacros, allowHtml: false});
        boolean advancedClean = advanced.cleanResult ?: false;
        io:println("Advanced scan clean: ", advancedClean);
        io:println("Verified file format: ", advanced.verifiedFileFormat ?: "unknown");
        if !advancedClean {
            foreach virusscan:VirusFound virus in advanced.foundViruses ?: [] {
                io:println("Threat found: ", virus.virusName ?: "unknown");
            }
            map<boolean?> findings = {
                "executable": advanced.containsExecutable,
                "script": advanced.containsScript,
                "macros": advanced.containsMacros,
                "html": advanced.containsHtml,
                "invalid file": advanced.containsInvalidFile,
                "restricted file format": advanced.containsRestrictedFileFormat,
                "unwanted action": advanced.containsUnwantedAction,
                "OLE embedded object": advanced.containsOleEmbeddedObject,
                "XML external entities": advanced.containsXmlExternalEntities,
                "insecure deserialization": advanced.containsInsecureDeserialization,
                "unsafe archive": advanced.containsUnsafeArchive,
                "password-protected file": advanced.containsPasswordProtectedFile
            };
            foreach [string, boolean?] [name, present] in findings.entries() {
                if present == true {
                    io:println("Finding: contains ", name);
                }
            }
        }
    } else {
        virusscan:VirusFound[] found = basic.foundViruses ?: [];
        foreach virusscan:VirusFound virus in found {
            io:println("Threat found: ", virus.virusName ?: "unknown");
        }
    }

    // Step 3: Check the page the file was linked from.
    virusscan:WebsiteScanResult website = check scanner->scanWebsite({url: websiteUrl});
    io:println("Website clean: ", website.cleanResult ?: false, ", threat type: ", website.websiteThreatType ?: "None");
}
