{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "StateBucketObjectAccess",
            "Effect": "Allow",
            "Action": [
                "s3:PutObjectAcl",
                "s3:PutObject",
                "s3:GetObject"
            ],
            "Resource": "arn:aws:s3:::terraform-state-bucket-name/<acctid>/*"
        },
        {
            "Sid": "StateBucketList",
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::terraform-state-bucket-name",
            "Condition": {
                "StringLike": {
                    "s3:prefix": [
                        "<acctid>/*"
                    ]
                }
            }
        },
        {
            "Sid": "DynamoDBAccess",
            "Effect": "Allow",
            "Action": [
                "dynamodb:PutItem",
                "dynamodb:GetItem",
                "dynamodb:DeleteItem"
            ],
            "Resource": "arn:aws:dynamodb:<region>:<acctid>:table/terraform-state-lock-table-name"
        }
    ]
}
