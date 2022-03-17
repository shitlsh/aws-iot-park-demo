resource "aws_cloudformation_stack" "network" {
  name = "aws_cloudformation_stack_tshi"
  on_failure = "ROLLBACK"
  capabilities = ["CAPABILITY_IAM"]

  parameters = {
    UserEmail = var.user_email
  }

  template_body = file("${path.module}/template/iot-device-simulator.template")
}