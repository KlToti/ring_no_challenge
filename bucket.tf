#1.create a new bucket
#2.get notification
#3. get file from bucket
#4.modify it
#5.put it in the bucket

resource "aws_s3_bucket" "ring_bucket" {
  bucket =  var.bucket_name

    #metadata
  lifecycle {
      prevent_destroy = true
    }

    tags = {
        Name = var.bucket_name
        Environment = "Test"
        Team = "Talent-Academy"
        Owner = var.owner_name
    }
}

resource "aws_s3_bucket_versioning" "version_my_bucket" {
  bucket = aws_s3_bucket.ring_bucket.id

  versioning_configuration {
    status = "Disabled"                                 #Disabled to allow overwriting of files, one file name
  }
}





