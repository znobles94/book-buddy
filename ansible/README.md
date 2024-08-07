# Installation

### Purpose
This is mostly just for running on an individual instance and setting up an AMI from that.
Instances should be cycled out frequently enough that having an AMI should suffice.

### Run on instance
```
ansible-playbook --connection=local --inventory 127.0.0.1, playbook.yml
```

### Creating AMI
After running the playbook on the instance, go ahead and run the terraform in `terraform/global/ami` and input the instance ID to create the instance's AMI. You'll want to tag it appropriately for lookup in the web AMI data source.
