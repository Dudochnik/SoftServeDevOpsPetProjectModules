resource "aws_autoscaling_notification" "this" {
  group_names = var.autoscaling_groups
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH"
  ]
  topic_arn = aws_sns_topic.this.arn
}

resource "aws_sns_topic" "this" {
  name = "asg-update-dns"
  display_name = "asg-update-dns"
}

resource "aws_iam_policy" "this" {
  name = "route53_change_records_lambda"
  path = "/"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:*",
          "ec2:DescribeInstances",
          "route53:ListHostedZonesByName",
          "route53:ChangeResourceRecordSets"
        ]
        Effect = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "this" {
  name = "route53_lambda"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = aws_iam_policy.this.arn
  role = aws_iam_role.this.name
}

resource "aws_lambda_function" "this" {
  function_name = "route53_change_records_set"
  handler = "route53_change_records.lambda_handler"
  role = aws_iam_role.this.arn
  runtime = "python3.8"
  filename = data.archive_file.this.output_path
  source_code_hash = filebase64sha256(data.archive_file.this.output_path)
}

resource "aws_sns_topic_subscription" "this" {
  endpoint = aws_lambda_function.this.arn
  protocol = "lambda"
  topic_arn = aws_sns_topic.this.arn
}

resource "aws_lambda_permission" "this" {
  statement_id = "AllowExecutionFromSNS"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.arn
  principal = "sns.amazonaws.com"
  source_arn = aws_sns_topic.this.arn
}
