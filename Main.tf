provider "aws" {
  access_key = "AKIAQUL35WNR7VMCLGVB"
  secret_key = "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"
  region     = "us-west-1"
}

variable "instance_type" {
  description = "value"
  type        = map(string)
  default     = {
    "dev"   = "t2.micro"
    "stage" = "t2.medium"
    "prod"  = "t2.xlarge"
  }
}

resource "aws_instance" "webserver" {
  ami           = "ami-0ca77f0088718ec1f"
  instance_type = "t2.micro"  # This default value will be overridden based on the workspace
  key_name      = "TerraformYnov"
  security_groups = ["default"]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = filebase64("C:/Users/Noor/.ssh/TerraformYnov.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "C:\\Users\\Noor\\Desktop\\Terraform\\10_hello_files\\app.py"
    destination = "/home/ec2-user/app.py"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/app.py",
      "/home/ec2-user/app.py &",
    ]
  }
}

