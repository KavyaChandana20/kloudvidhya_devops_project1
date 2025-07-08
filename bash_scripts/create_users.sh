#!/bin/bash

echo "Is this Instance A (Ansible) or Instance B (Jenkins)?"
read -p "Enter role (ansible/jenkins): " ROLE

if [[ "$ROLE" == "ansible" ]]; then
  useradd -m -s /bin/bash ansible
  echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ansible
elif [[ "$ROLE" == "jenkins" ]]; then
  useradd -m -s /bin/bash jenkins
  echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/jenkins
else
  echo "Invalid role."
  exit 1
fi

