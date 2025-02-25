import boto3
import pymysql
import os


def read_data_from_s3(bucket_name, object_key):
    # Create an S3 client using boto3
    s3 = boto3.client('s3')
    response = s3.get_object(Bucket=bucket_name, Key=object_key)
    data = response['Body'].read().decode('utf-8')
    return data


def push_data_to_rds(data):
    # Connect to the RDS instance using environment variables
    connection = pymysql.connect(
        host=os.environ['go-digital-db.c5oicwa8wscl.ap-south-1.rds.amazonaws.com'],
        user=os.environ['admin'],
        password=os.environ['go-digital-db'],
        database=os.environ['go-digital-db']
    )
    try:
        with connection.cursor() as cursor:
            # Example: Insert data into a table named `data_table`
            sql = "INSERT INTO data_table (data) VALUES (%s)"
            cursor.execute(sql, (data,))
        connection.commit()
    finally:
        connection.close()


if __name__ == "__main__":
    # Read required values from environment variables
    bucket = os.environ.get('go-digital-devops')
    key = os.environ.get('S3_OBJECT_KEY')

    if not bucket or not key:
        raise Exception(
            "S3_BUCKET and S3_OBJECT_KEY environment variables must be set.")

    data = read_data_from_s3(bucket, key)
    push_data_to_rds(data)
    print("Data successfully transferred from S3 to RDS")
