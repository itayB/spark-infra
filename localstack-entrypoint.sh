#!/bin/bash
set -x
awslocal s3 mb s3://my-test-bucket
set +x
#aws --endpoint-url=http://localhost:4572 s3api list-buckets
#aws --endpoint-url=http://localhost:4572 s3 cp s3/ s3://my-test-bucket --recursive
#aws --endpoint-url=http://localhost:4572 s3 ls s3://my-test-bucket/ --recursive

