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
-> Run `terraform apply` (take care about setting router_id and keypair_name variables)
-> Check that your machines spawned

Step 2: Provision your machines
-> SSH into your "orchestrator" machine through its floating ip, this is the one we will use to provision the rest of the infrastructure
-> Go into `/etc/provisioning` and run `terraform output output | python gen_inventory.py` to generate an ansible inventory file
-> Go into the ansible directory and run `ansible-playbook -i inventory provision_continuous_delivery.yml`