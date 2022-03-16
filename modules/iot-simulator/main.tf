resource "aws_cloudformation_stack" "network" {
  name = "networking-stack"

  parameters = {
    UserEmail = var.user_email
  }

  template_body = file("${path.module}/template/iot-device-simulator.template")
}