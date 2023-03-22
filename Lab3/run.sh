aws ec2 describe-instances

aws ec2 describe-volumes --volume-ids vol-020d5e4125bebbddc
aws ec2 create-volume --volume-type gp2 \
    --size 1 --availability-zone us-east-1a \
    --tag-specifications 'ResourceType=volume,Tags=[{Key=Name,Value=My Volume}]'

aws ec2 attach-volume --device /dev/sdf \
    --instance-id i-0dc228dbc73bd4f22 \
    --volume-id vol-07a5ed01fed89bda2

aws ec2 describe-volumes --volume-ids vol-07a5ed01fed89bda2

## on the instance
sudo mkfs -t ext3 /dev/sdf
sudo mkdir /mnt/data-store
sudo mount /dev/sdf /mnt/data-store
#To configure the Linux instance to mount this volume when the instance is started, you must add a line to /etc/fstab.
echo "/dev/sdf   /mnt/data-store ext3 defaults,noatime 1 2" | sudo tee -a /etc/fstab
cat /etc/fstab

sudo sh -c "echo some text has been written > /mnt/data-store/file.txt"
cat /mnt/data-store/file.txt

## on bastion

aws ec2 create-snapshots --instance-specification \
InstanceId=i-0dc228dbc73bd4f22,ExcludeBootVolume=true \
--tag-specifications 'ResourceType=snapshot,Tags=[{Key=Name,Value=My Snapshot}]'

aws ec2 describe-snapshots --snapshot-ids snap-097504ff8bb9d1ece
## on ec2 
sudo rm /mnt/data-store/file.txt

## on bastion
# create a volume from the snapshot
aws ec2 create-volume \
--snapshot-id snap-097504ff8bb9d1ece \
--availability-zone us-east-1a \
--tag-specifications 'ResourceType=volume,Tags=[{Key=Name,Value=Restored Volume}]'
# attach the volume to the instance
aws ec2 attach-volume --device /dev/sdg \
--instance-id i-0dc228dbc73bd4f22 \
--volume-id vol-081f4cd3e1a4bfd16

## on ec2
sudo mkdir /mnt/data-store2
sudo mount /dev/sdg /mnt/data-store2
