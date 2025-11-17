module "vpc"{
    source = "terraform-aws-modules/vpc/aws"

    name = "terraform-vpc"
    cidr = "10.0.0.0/16"
    
    azs = ["us-east-1a", "us-east-1b"]
    public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

    enable_vpn_gateway = true
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Terraform = "true"
        Environment = "dev"
    }

}

