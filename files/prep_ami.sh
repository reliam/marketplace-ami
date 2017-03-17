#!/bin/bash

# http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/building-shared-amis.html

sudo shred -u /etc/ssh/*_key /etc/ssh/*_key.pub
sudo shred -u /root/.*history /home/ec2-user/.*history
sudo rm /root/.ssh/authorized_keys /home/ec2-user/.ssh/authorized_keys
