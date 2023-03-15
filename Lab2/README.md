# Lab2.1 

This lab is about creating AWS VPC and EC2 instances. The lab created 4 subnets.
- 2 public subnets
- 2 private subnets
then create Internet Gateway and NAT Gateway.Finally, create 2 EC2 instances in one of the public subnet.

## description
The AWS CloudFormation template written in YAML format. It defines the creation of an Amazon Virtual Private Cloud (VPC) that contains two public subnets and two private subnets distributed across two availability zones in the US East region. It also sets up a public and private route table and creates a NAT Gateway to provide internet access to the private subnets. The VPC is configured with DNS support and DNS hostnames enabled. Additionally, the template sets up an internet gateway and a security group that allows SSH and HTTP traffic. The resources are defined using AWS CloudFormation intrinsic functions such as !Ref, !Sub, and !GetAtt.
## Prerequisites
AWS account
