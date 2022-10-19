import json
import boto3
import urllib
#import requests
import os
import time

### environment variables
#forward_account_id = os.environ.get("forward_account_id")
account_id = os.environ.get("account_id")
forward_account_id = str(247548036690)
#account_id = str(247548036690)

#bucket names
bucket_name = f'{account_id}-ring-no-challange-talent-academy-project-oct-2022'
forward_bucket_name = f'{forward_account_id}-ring-no-challange-talent-academy-project-oct-2022'

#get public ip address from my account with tag name
def get_public_ip():
    ec2 = boto3.resource('ec2')
    running_instances = ec2.instances.filter(Filters=[
        {'Name': 'instance-state-name',
        'Values': ['running']},
        {'Name': "tag:Name", "Values": ["Ring_no_challange_webserver"]}])
    public_ips = [instance.public_ip_address for instance in running_instances]
    public_ip = public_ips[0]
    return public_ip

def lambda_handler(event,context):
    s3_client = boto3.client('s3')
    #bucket_name = event['Records'][0]['s3']['bucket']['name']
    key = "test.json"
    key = urllib.parse.unquote_plus(key,encoding='utf-8')

    sts = boto3.client("sts")
    account= sts.get_caller_identity()["Account"]
    message = 'A new file was edit!'

    response = s3_client.get_object(Bucket=bucket_name,Key = key)

    content = response["Body"].read().decode()
    data = json.loads(content)
    print(type(data), data)
    #assume the value has 'number' as a key in the json file
    if data['max_value']< 20:
        value = data['number']
    #integrate the fuction by incrementing it by one     
        new_value = value +1
        print(f'New value:{new_value}')
        new_jsonFile = "/tmp/testX.json"
        
        # assign the values to the number and to account record ()
        data['number'] = int(new_value) 
        data[account] = int(new_value) 

        print(f'New data to send:" {data}')
    
        with open(new_jsonFile,"w") as jsonFile:
            body=json.dumps(data)
            jsonFile.write(body)
        print('Data should be in file')
    #put the updated file in the bucket
    # TO-DO:define the target bucket 
    #next_s3 = boto3.resource('s3') 
    
    # next_s3 = boto3.resource (
    #     service_name = 's3',
    #     region_name = var.region,
    #     aws_access_key_id = var.aws_access_key_id,
    #     aws_secret_access_key = var.aws_secret_access_key
        print('I will wait 10 seconds')
        time.sleep(10)
        print('I am back again')
    #send file to my webserver
        send_to_server(body)
        s3_client.upload_file(new_jsonFile, forward_bucket_name, "testX.json")
        return f"Uploaded file to {forward_account_id}"
    else:
        return f"Maximum number reached. The value {data['number']} was reached. Transferring stopped."

    #keep as environment variable, just in case
    #os.environ["MY_RING_WEB_SERVER"] = public_ip

    #response = s3_client.put_object(Body=body, Bucket=forward_bucket_name, Key = new_jsonFile)
    
def send_to_server(data):
    public_ip = str(get_public_ip())
    print('This is my public ip : ', public_ip)
    #resp = requests.post(public_ip, json=data)
    #print(resp) #response from web_server