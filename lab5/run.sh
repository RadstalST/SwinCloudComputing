#!/bin/bash
AWS_PROFILE=$1

echo "AWS_PROFILE is $AWS_PROFILE"
echo "retiving \"Lab VPC\""
VPC_ID=$(aws ec2 describe-vpcs --filters Name=tag:Name,Values="Lab VPC" --profile $AWS_PROFILE | \
python get_vpc_id.py)
echo "VPC_ID=$VPC_ID"


echo "creating DB security group"
DB_SC_ID=$(aws --profile $AWS_PROFILE ec2 create-security-group \
--description 'Permit access from Web Security Group' \
--group-name 'DB Security Group' --vpc-id $VPC_ID |\
python get_security_group_id.py
)
echo "DB_SC_ID=$DB_SC_ID"

echo "retiving \"Web Security Group\""
WEB_SC_ID=$(aws ec2 --profile $AWS_PROFILE describe-security-groups --filters Name=tag:Name,Values="Web Security Group"\
| python get_group_id.py
)
echo "WEB_SC_ID=$WEB_SC_ID"

echo "creating security-group-ingress for $DB_SC_ID to 3306 from $WEB_SC_ID"
aws --profile $AWS_PROFILE ec2 authorize-security-group-ingress --group-id $DB_SC_ID \
--protocol tcp --port 3306 --source-group $WEB_SC_ID

echo "retriving private subnets"
PRIVATE_SUBNET_1_ID=$(
    aws --profile $AWS_PROFILE ec2 describe-subnets --filters Name=cidr-block,Values=10.0.1.0/24 Name=vpc-id,Values=$VPC_ID\
    |python parse_json.py Subnets 0 SubnetId
)
echo "PRIVATE_SUBNET_1_ID=$PRIVATE_SUBNET_1_ID"

PRIVATE_SUBNET_2_ID=$(
    aws --profile $AWS_PROFILE ec2 describe-subnets --filters Name=cidr-block,Values=10.0.3.0/24 Name=vpc-id,Values=$VPC_ID\
    |python parse_json.py Subnets 0 SubnetId
)
echo "PRIVATE_SUBNET_2_ID=$PRIVATE_SUBNET_2_ID"

echo "creating subnet group from $PRIVATE_SUBNET_1_ID and $PRIVATE_SUBNET_2_ID"

aws --profile $AWS_PROFILE rds create-db-subnet-group \
--db-subnet-group-name 'DB-Subnet-Group' \
--db-subnet-group-description 'DB Subnet Group' \
--subnet-ids "[\"$PRIVATE_SUBNET_2_ID\",\"$PRIVATE_SUBNET_1_ID\"]"

DBSubnetGroupName="db-subnet-group"
echo "DBSubnetGroupName = $DBSubnetGroupName"


aws --profile $AWS_PROFILE rds create-db-instance \
--db-instance-identifier lab-db --db-name lab \
--db-instance-class db.t3.micro --engine mysql \
--master-username main --master-user-password lab-password \
--allocated-storage 20 --storage-type gp2 --multi-az \
--vpc-security-group-ids $DB_SC_ID \
--db-subnet-group-name db-subnet-group --backup-retention-period 0


## wait for creation
endpoint_created='creating'
while [ "$endpoint_created" == "creating" ]; 
do
    endpoint_created=$(aws --profile $AWS_PROFILE rds describe-db-instances --db-instance-identifier lab-db | python parse_json.py DBInstances 0 DBInstanceStatus)
    echo "db creation status $endpoint_created"
    echo "wait 10 sec"
    sleep 10
done

LAB_ENDPOINT=$(aws --profile $AWS_PROFILE rds describe-db-instances --db-instance-identifier lab-db \
 | python parse_json.py DBInstances 0 Endpoint Address)

echo "LAB_ENDPOINT = $LAB_ENDPOINT"



