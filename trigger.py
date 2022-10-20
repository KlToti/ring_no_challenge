import json
import boto3
import urllib
#import requests
import os
import time

### environment variables
forward_account_id = os.environ.get("forward_account_id")
account_id = os.environ.get("account_id")
#forward_account_id = str(247548036690)
#account_id = str(247548036690)

#bucket names
bucket_name = f'{account_id}-ring-no-challange-talent-academy-project-oct-2022'
forward_bucket_name = f'{forward_account_id}-ring-no-challange-talent-academy-project-oct-2022'

max_value = 100

def lambda_handler(event,context):
    s3_client = boto3.client('s3')
    key = "test.json"
    key = urllib.parse.unquote_plus(key,encoding='utf-8')


    response = s3_client.get_object(Bucket=bucket_name,Key=key)

    content = response["Body"].read().decode()
    print(type(content), content)
    data = json.loads(content)
    print(type(data), data)
    #assume the value has 'number' as a key in the json file
    
    if data['number']< data['max_value']:
        value = data['number']
        #integrate the fuction by incrementing it by one     
        new_value = value +1
        print(f'New value:{new_value}')
        new_jsonFile = "/tmp/testX.json"
        
        # assign the values to the number and to account record ()
        data['number'] = int(new_value) 
        data[account_id] = int(new_value) 

        print(f'New data to send: {data}')
    
        #with open(new_jsonFile,"w") as jsonFile:
        body=json.dumps(data).encode('utf-8')       # no longer needed to put in a folder, need in bytes
        print('Data should be in file')
        print('I will wait 10 seconds')
        time.sleep(10)
        print('I am back again')
        #send file to my webserver
        #send_to_server(body)
        s3_client.put_object(Body=body, Bucket=forward_bucket_name, Key="test.json")
        return f"Uploaded file to {forward_account_id}"
    else:
        return f"Maximum number reached. The value {data['number']} was reached. Transferring stopped."

    