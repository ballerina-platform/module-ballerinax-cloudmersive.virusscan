# Upload threat screening

This example screens an uploaded file before it is accepted. It runs the basic virus scan, applies the strict advanced policy (no executables, scripts or HTML) to files that pass, reports any threats found, and then scans the website the file was linked from.

## Prerequisites

- Ballerina Swan Lake 2201.12.0 or later
- A Cloudmersive API key
- Create a `Config.toml` in this directory:

  ```toml
  apiKey = "<Cloudmersive API key>"
  filePath = "<Path to the file to scan>"
  websiteUrl = "<URL of the website to scan>"
  allowMacros = false
  ```

## Run the example

```bash
bal run
```
