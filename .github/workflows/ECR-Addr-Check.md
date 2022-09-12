## ECR Address Validation check
1. [General Info](#general-info)
2. [Usage](#usage)

### General Info
***
This GitHub Actions workflow is designed to run across multiple repositories under ntwrk1 organization ,it runs when any activity on a pull request in the workflow's repository occurs. 

### Usage
***
This check logic is triggered by any Pull_request event. When this happens, the check validates the organization certified ECR address used in Dockerfile, it ensure and allows merges PR which are using organization ECR address rest are denied collects all relevant information and dispatches this to the .github repository of your organization. Here, all central workflow files configured with the repository_dispatch event and org-workflow-bot type are triggered.
