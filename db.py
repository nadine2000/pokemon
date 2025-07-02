import boto3
from botocore.exceptions import ClientError

dynamodb = boto3.resource('dynamodb',  region_name="us-west-2")
table_name = 'pokemons'


def get_table():
    try:
        table = dynamodb.Table(table_name)
        table.load()
        return table
    except ClientError as e:
        if e.response['Error']['Code'] == 'ResourceNotFoundException':
            return create_table()
        else:
            raise e


def create_table():
    print("Creating Pokemon table in DynamoDB...")
    table = dynamodb.create_table(
        TableName=table_name,
        KeySchema=[
            {
                'AttributeName': 'name',
                'KeyType': 'HASH'
            }
        ],
        AttributeDefinitions=[
            {
                'AttributeName': 'name',
                'AttributeType': 'S'
            }
        ],
        BillingMode='PAY_PER_REQUEST'
    )

    table.wait_until_exists()
    print(f"Table {table_name} created successfully!")
    return table


def get_pokemon_from_db(name):
    table = get_table()
    response = table.get_item(Key={'name': name})
    return response.get('Item')



def add_pokemon_to_db(pokemon):
    table = get_table()
    response = table.put_item(Item=pokemon)
    return response
