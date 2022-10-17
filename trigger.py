import json
import boto3
import urllib

def lambda_handler(event,context):
    s3_client = boto3.client('s3')
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']
    key = urllib.parse.unquote_plus(key,encoding='utf-8')

    sts = boto3.client("sts")
    account= sts.get_caller_identity()["Account"]
    message = 'A new file was edit!'

    response = s3_client.get_object(Bucket=bucket_name,Key = key)

    content = response["Body"].read().decode()
    data = json.loads(content)
    #assume the value has 'number' as a key in the json file
    value = data['number']

    #integrate the fuction by incrementing it by one 

    new_value = value +1
    new_data = {'number': int(new_value), 'account_id' : account }
    with open(content, "w") as jsonFile:
        body= json.dump(new_data, jsonFile)

    #put the updated file in the bucket
    # TO-DO:define the target bucket by using .arn (Amazon Resource Name)
    response = s3.client.put_object(Body = body, Bucket = var.next_bucket, Key = content)


