#/bin/bash

aws s3api create-bucket --bucket $bucket --acl private --region $region

aws s3api put-public-access-block \
    --bucket $bucket \
    --public-access-block-configuration BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true

aws s3api put-bucket-encryption \
    --bucket $bucket \
    --server-side-encryption-configuration '{"Rules": [{"ApplyServerSideEncryptionByDefault": {"SSEAlgorithm": "aws:kms"}}]}'