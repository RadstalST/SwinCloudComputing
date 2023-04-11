# assignment1a

serve httpd webserver using ec2 and upload php file to EC2 instances 

## steps
1. create keypair // or use vockey
2. edit keypairname for ec2 instance in cloudformation template
3. upload cloudformation stack to aws cloudformation
4. upload webserver php file to ec2 instances
  1. photouploader.php
  2. photolookup.php
5. profit


## to SSH

```bash

ssh -i keypair_path.pem ec2-user@instance_publicname
```

eg
>```bash
>ssh -i ./keypair/myKeypPair.pem ec2-user@ec2-52-91-135-72.compute-1.amazonaws.com
>```


# Resources 

[the over complicated but standard cloudformation practice
](https://reflectoring.io/aws-cloudformation-deploy-docker-image/)


# assigment1b

## steps
1. deploy cloudformation stack
2. wait for RDS instance to be ready
3. SSH into Webserver Instance and edit DB_endpoint in /var/www/html/cos80001/photoalbum/constraints.php
4. SSH into TestInstance and then ping to Webserver using private IP address.
4. open webserver publicname in browser and enjoy

## Rubrics Checklist
### Architecture
- [X] VPC with 2 public and 2 private subnets
- [X] Correct Public and Private Routing tables with correct subnet associations
- [X] Security groups properly configured and attached.
- [ ] Network ACL properly configured and attached
- [X] Correct Web server and Test instances running in correct subnets
- [ ] Database schema as specified
- [ ] Database running in correct subnets
- [X] S3 objects publicly accessible, using proper access policy
### Functionality
- [ ] album.php page displayed from EC2 Web server
- [ ] Provided URL is persistent (Elastic IP Association)
- [ ] Photos loaded from S3 with matching metadata from RDS
- [ ] Web server instance reachable from Test instance via ICMP

