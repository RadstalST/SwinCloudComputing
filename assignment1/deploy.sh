aws cloudformation delete-stack --stack-name assignment1a

aws --profile sandbox \
    cloudformation deploy \
    --template-file ./cloudformation_cheating.yaml \
    --stack-name assignment1a 