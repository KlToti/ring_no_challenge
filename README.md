# Ring Number Challenge

## Challenge description

As a team, you should coordinate to deploy a server in each of your individual accounts. Each server will contain a file at your own defined location. The file need to contain a number. Every 10 seconds(or 1 minute if you are using `cron`), the servers will increment the value of the file and pass it along to the next one.

For example, Server 1 contains a file with the value 10, it will increment it to 11 and send that file to Server 2. Server 2 will increment the valeur in the file to 12 and send it to Server 3, and so on.


# Team work

Project tasks were distributed over 5 members of the group. 
To deliver tasks [Trello app](https://trello.com/b/ufyjRrXX/ring-number-challenge) was used and [Lucidcharts](https://lucid.app/lucidchart/69dfa177-b7da-431e-8789-5d5189e043ab/edit?invitationId=inv_6e2d77ba-a32e-4c27-9828-61600a988c29&page=0_0#) and Miro Boardto visualize our solution and brainstorm.
[Github](https://github.com/KlToti/ring_no_challenge) was crucial to deliver and maintain code.

# Goals
* __Security__
* __Think outside the box__ 


# Approach 


![Alt text](https://github.com/KlToti/ring_no_challenge/blob/main/image.png)


## Resources 

Infrastructure can be found [here](https://github.com/KlToti/ring_no_challenge/tree/yeli/infra/Yelizaveta) 

| Name | Type |
|------|------|
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | data source |
| [aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route_table.internet_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_subnet.public_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |

## Inputs

| Name | Description | Type |
|------|-------------|------|
| <a name="forward_bucket_id"></a> [forward\_bucket\_id](#input\_project\_name) | next person's AWS ID | `string` | 
| <a name="donor_bucket_id"></a> [donor\_bucket\_id](#donor\_project\_name) | previous person's ID | `string` | 
| <a name="account_id"></a> [account\_id](#account\_id\_) | user's account ID | `string` | 


# Challenges

* Roles and policies
*![image](https://user-images.githubusercontent.com/79509008/197157044-ffbf57ea-f0d3-458b-9eaa-b38a9cb1bd07.png)


# Further improvements

* Improve efficiency : 5 instances and 1 bucket __or__ 1 instance and 5 bucket
* Automation



