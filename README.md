# pokemon


aws ec2 create-key-pair \
    --key-name mykey \
    --key-type rsa \
    --query 'KeyMaterial' \
    --output text > mykey.pem


cd terraform
terraform init
terraform plan -var="key_name=mykey"
terraform apply -var="key_name=mykey"

ssh -i mykey.pem ubuntu@<public_ip>