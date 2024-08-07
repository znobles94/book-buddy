resource "aws_ami_from_instance" "webapp-ami-latest" {
    name = "webapp-ami-latest-${timestamp()}"
    source_instance_id = var.instance_id
}
