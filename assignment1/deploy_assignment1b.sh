# aws --profile sandbox2 cloudformation delete-stack --stack-name assignment1b

aws --profile sandbox2\
    cloudformation deploy \
    --template-file ./assignment1b.yaml \
    --stack-name assignment1b2