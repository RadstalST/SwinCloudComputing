# assignment 1a

serve httpd webserver using ec2 and upload php file to EC2 instances 



## 1. SSH

```bash

ssh -i keypair_path.pem ec2-user@instance_publicname
```

eg
>```bash
>ssh -i ./keypair/myKeypPair.pem ec2-user@ec2-52-91-135-72.compute-1.amazonaws.com
>```