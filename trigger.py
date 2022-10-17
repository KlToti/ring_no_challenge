import json
import boto3
import urllib

def lambda_handler(event,context):
    s3_client = boto3.client('s3')
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']
    key = urllib.parse.unquote_plus(key,encoding='utf-8')

    message = 'A new file was edit!'

    response = s3_client.get_object(Bucket=bucket_name,Key = key)

    content = response["Body"].read().decode()
    content = json.loads(content)
    #assume the value has 'number' as a key in the json file
    value = content['number']

    #integrate the fuction by using lambda again from Pauleen or just increment it by one here

    new_value = value +1
    with open("next_number.json", "w") as jsonFile:
        new_data =json.dumps(new_value, jsonFile)

    #put the updated file in the bucket
    # TO-DO:define the target bucket by using .arn (Amazon Resource Name)
    #response = s3.client.put_object(Body = new_data, Bucket = '',Key ='next_number')


