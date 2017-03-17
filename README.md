## Getting Started

This repo contains automation scripts for provisioning infrastructure and creating turnkey Amazon Machine Images. So far the repo contains two different tools:

 - [Packer](https://www.packer.io)
 - [Ansible](https://www.ansible.com)

In the future we will be adding Terraform and Cloudformation templates to assist with building larger infrastructure. The project so far is really creating the building blocks of AMI's.

## How It Works

Everything is based off of Ansible, so you need to have a working playbook. Create any playbooks you need in the root directory of this repo; *be sure to make use of [ansible roles](https://blog.lzahq.tech/2016/07/18/Building-Modular-Ansible-Roles-for-Automating-Everything/) to help break down your environment into reusable modules.*

The playbook must be able to configure a fresh Amazon Linux system for your desired application.

When you have a working Ansible Playbook, use Packer to build an AMI for it.

Copy the `env` file to a hidden dotfile and then edit it, filling in the values for your VPC ID, subnet ID, build name, description, and your target playbook. This file should not be included in configuration management as it will require different info per the account:

```
$ cp env .env
$ vim .env
# Edit the .env file per your VPC and AMI requirements. Example:
export PACKER_VPC='vpc-707gb11d'
export PACKER_SUBNET='subnet-f0514bqd'
export PACKER_BUILD='reliam-wordpress-ami'
export PACKER_DESC='Reliam Wordpress Official'
export PACKER_PLAYBOOK='wordpress-setup.yml'
```

Source the file so the environment variables hit your shell session:

```
$ source .env
```

Execute the Packer build AMI:

```
packer build ami_builder.yml
```

The returned AMI is ready for use. When a new instance of said AMI is launched, it will boot up, fetch the target playbook, and execute it, building itself out.
