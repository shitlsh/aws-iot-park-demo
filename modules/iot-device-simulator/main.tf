resource "aws_cloudformation_stack" "network" {
  name = "aws-cloudformation-stack-tshi"
  on_failure = "ROLLBACK"
  capabilities = ["CAPABILITY_IAM"]

  parameters = {
    UserEmail = var.user_email
  }

  template_url = "https://s3.amazonaws.com/solutions-reference/iot-device-simulator/latest/iot-device-simulator.template"
}