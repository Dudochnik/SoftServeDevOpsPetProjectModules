data "archive_file" "this" {
  source_file = "${path.module}/route53_change_records.py"
  output_path = "${path.module}/route53_change_records.zip"
  type = "zip"
}
