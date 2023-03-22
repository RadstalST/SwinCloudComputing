# assignment 1a

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