# Running Tests

## Prerequisites

To run the tests against the live Cloudmersive API, you need an API key (see the [setup guide](../README.md#setup-guide)).

## Running Tests

The tests run against a mock server by default, and cover every operation except the live-only scans of cloud storage, which need real storage credentials.

1. To run the tests against the mock server:

    ```bash
    bal test --groups mock_tests
    ```

2. To run the file and website scans against the live API:

    ```bash
    export IS_LIVE_SERVER=true
    export CLOUDMERSIVE_API_KEY=<Cloudmersive API key>
    bal test --groups live_tests
    ```
