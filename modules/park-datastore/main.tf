resource "aws_dynamodb_table" "park_db" {
  name         = "aws-iot-park-db"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "docType"
  attribute {
    name = "docType"
    type = "S"
  }

  range_key = "docSortKey"
  attribute {
    name = "docSortKey"
    type = "S"
  }
}

resource "aws_iot_topic_rule" "park-datastore-rule" {
  name        = "putDataInDBRule"
  enabled     = true
  sql         = "SELECT *, topic(2) as clientId FROM 'park-camera/+/putCarInOutInfo'"
  sql_version = "2016-03-23"

  dynamodb {
    role_arn        = aws_iam_role.iam_role_for_datastore.arn
    hash_key_field  = aws_dynamodb_table.park_db.hash_key
    hash_key_value  = "${clientId}"
    range_key_field = aws_dynamodb_table.park_db.range_key
    range_key_value = "${timestamp()}"
    table_name      = aws_dynamodb_table.park_db.name
  }
}

resource "aws_iam_role" "iam_role_for_datastore" {

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "iot.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "iam_policy_for_datastore_rule" {
  role = aws_iam_role.iam_role_for_datastore.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": [
            "dynamodb:PutItem"
        ],
        "Resource": "${aws_dynamodb_table.park_db.arn}"
    }
  ]
}
EOF
}