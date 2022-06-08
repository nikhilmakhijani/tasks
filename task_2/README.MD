# Export Compute Engine Metadata

This script takes three inputs from user: Project ID, Instance name and Zone. It fetches metadata from the VM, saves it as JSON file on the device with the name `<INSTANCE_NAME>.json` then provides user with a list of keys present and provides user with an option to query keys.

## Usage

```
bash exportmetadata.sh <PROJECT_ID> <INSTANCE_NAME> <ZONE_NAME>
```

## Requirements

1) gcloud and jq should be installed.
2) Create a service account with appropriate permissions and download the key.
3) Activate service account using gcloud auth activate-service-account SERVICE_ACCOUNT@DOMAIN.COM --key-file=/path/key.json.
4) Three required inputs `<PROJECT_ID> <INSTANCE_NAME> <ZONE_NAME>`.
