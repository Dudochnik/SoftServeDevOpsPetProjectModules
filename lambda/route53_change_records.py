import boto3
import json

ec2 = boto3.client('ec2')
route53 = boto3.client('route53')

def lambda_handler(event, context):
    message = json.loads(event['Records'][0]['Sns']['Message'])
    if 'Event' in message.keys() and message['Event'] == "autoscaling:EC2_INSTANCE_LAUNCH":
        instance_id = message['EC2InstanceId']
        reservation = ec2.describe_instances(InstanceIds=[instance_id]).get("Reservations")[0]
        instance = reservation['Instances'][0]
        instance_zone = instance['Placement']['AvailabilityZone']
        #print(instance_zone)
        for tag in instance['Tags']:
            if tag['Key'] == 'Domain':
                domain_name = tag['Value']
                break
        hosted_zone_id = route53.list_hosted_zones_by_name(DNSName=domain_name, MaxItems='1')['HostedZones'][0]['Id'].replace('/hostedzone/', '')
        #print(hosted_zone_id)
        #print(instance.get("PrivateIpAddress"))
        response = route53.change_resource_record_sets(
            HostedZoneId=hosted_zone_id,
            ChangeBatch={
                'Changes': [
                    {
                        'Action': 'UPSERT',
                        'ResourceRecordSet': {
                            'Name': instance_zone+'.'+domain_name,
                            'Type': 'A',
                            'TTL': 60,
                            'ResourceRecords': [
                                {
                                    'Value': instance.get("PrivateIpAddress")
                                },
                            ]
                        }
                    },
                ]
            }
        )
    return event
