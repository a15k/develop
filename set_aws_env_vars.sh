#!/bin/sh
export AWS_ACCESS_KEY_ID=`aws configure get aws_access_key_id --profile a15k`
export AWS_SECRET_ACCESS_KEY=`aws configure get aws_secret_access_key --profile a15k`
