resource "aws_iam_role" "lambda-role" {
  name = "lambda-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "lambda-policy" {
  name = "lambda-policy-dynamodb-cloudwatch"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : ["dynamodb:*"],
        "Resource" : var.table_arn
      },
      {
        "Action" : ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"],
        "Resource" : "arn:aws:logs:*:*:*",
        "Effect" : "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda-policy-attach" {
  policy_arn = aws_iam_policy.lambda-policy.arn
  role       = aws_iam_role.lambda-role.name
}
