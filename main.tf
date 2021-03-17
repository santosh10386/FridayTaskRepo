############# configure the AWS provider 
provider "aws"{
	access_key = var.access_key
	secret_key = var.secret_key
	region = var.region
}

############## create S3 Bucket
############## the resource will create all the bucket in the variable in array 
variable "s3_bucket_names" {
	type = list
	default = ["crazy-wether-hourly","crazy-wether-daily","crazy-wether-weekly"]
}

############# Creat a resource for AWS s3 bucket
resource "aws_s3_bucket" "b" {
	count = length(var.s3_bucket_names)
	bucket = element(var.s3_bucket_names, count.index)
	acl = "public-read-write"
	policy = file("bucket-policy.json")

	website {
    		index_document = "index.html"
    		error_document = "error.html"

    		routing_rules = <<EOF
	EOF
  	}
}

