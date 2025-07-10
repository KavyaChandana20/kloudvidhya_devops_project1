Prerequisites:
Before starting, ensure the following:

You have two AWS EC2 instances (Amazon Linux 2)

One instance for Jenkins Server, another for Ansible Controller

You have:

AWS IAM User credentials (Access Key, Secret Key)

AWS Key Pair (.pem file)

Proper Security Groups with inbound ports open:

SSH (22), HTTP (80), HTTPS (443), Jenkins (8080)


1.Terraform

Installation:
wget https://releases.hashicorp.com/terraform/1.12.2/terraform_1.12.2_linux_amd64.zip
unzip terraform_1.12.2_linux_amd64.zip

Configuration:
Create a folder terraform/ with files:
main.tf: define provider and resources
variables.tf: input variables
outputs.tf: output instance info
terraform.tf: variable value

Commands:
terraform init
terraform plan
terraform apply

2.Ansible

Installation (on Ansible Controller EC2):
sudo yum update -y
sudo amazon-linux-extras enable ansible2
sudo yum install -y ansible

Create inventory file:
sudo vi /etc/ansible/hosts

Create playbooks in ansible_playbooks/ directory:
vi install_jenkins.yml

Run the playbook:
ansible-playbook install_jenkins.yml


3.Jenkins

Installation (on Jenkins EC2 instance):
sudo yum update -y
sudo yum install java-17-openjdk -y

wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

sudo yum install -y jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

Initial Admin Password:
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

Access Jenkins UI at: http://<jenkins_public_ip>:8080

4.Docker

Installation:
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
docker version

5.AWS CLI & ECR

AWS CLI Installation:
sudo yum update -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

Configure AWS CLI:
aws configure
AWS Access Key ID:
Secret Access Key:
Region (e.g. ap-south-1):
Output format - leave it blank, just hit enter

Docker ECR Login:
aws ecr get-login-password | docker login --username AWS --password-stdin <account_id>.dkr.ecr.<region>.amazonaws.com


6.Git & GitHub Integration

Git Installation:
sudo yum install git -y

Connect Local Repo to GitHub:
git init
git remote add origin https://github.com/<your-username>/<repo-name>.git
git pull origin main --allow-unrelated-histories
git add .
git commit -m "commit message"
git push -u origin main

7.Required Environment Variables:
export AWS_ACCESS_KEY_ID=your_access_key
export AWS_SECRET_ACCESS_KEY=your_secret_key
export AWS_DEFAULT_REGION=ap-south-1


