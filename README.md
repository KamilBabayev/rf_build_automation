# rf_build_automation
Build automation for Robot Framework container

1. Stage: Syntax and Lint testing

Description:
Here we are running simple code checks for ansible scripts.

2. Stage: Build robot-framework container

Description:
On this stage we are building docker container from a Dockerfile, which contains Robot Framework and Ansible packages.

3. Stage: Testing

Description:
Running test cases for a simple checks to ensure that docker container works properly.

4. Stage: Approve

Description:
Approval stage, which waiting for approve from repository owner in a Jenkins.
Repository owner must login to a Jenkins and click on approve(or decline) button in a Jenkins job (robot-framework-build).

5. Stage: Publishing image for community usage

Description:
On this stage we are define a GIT repository and subdirectory where our update will be pushed.

6. Stage: Upload to registry

Description:
Pushing our successful Jenkins build to a GIT repository. 
