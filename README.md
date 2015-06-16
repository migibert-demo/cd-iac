# cd-iac
Infrastructure as Code for continuous delivery demo.

This repository contains the configuration that bootstraps a cd-demo environment.

In cd-demo, we will demonstrate a continous delivery platform using go-cd. Our platform will build some applications with dependencies between each other and automate as much as possible the workflow of a change including cross team validations with both automated and manual testing.

We have those environments:
- cd : this is the one that hosts our cd platform
- integration: on this environment, acceptance tests and developers/integratos validate the feature
- qa : on this environment, business stakeholders validate the features
- staging : on this environment, we test our applications behaviour with load test, stress test, security test. It has to look like a production environment.
- production : do I really need to talk about this ?

Step 1: Create your infrastructure with terraform
-> Source your creds (sample format in terraform/sample_creds)
-> Run `terraform apply` (take care about setting router_id and keypair_name variables) from terraform directory
-> Check that your machines spawned

Step 2: Provision your machines
-> From this project's root directory, run provision_orchestrator.sh which take two arguments: your private key and the user with which you will connect orchestration machine via SSH.
