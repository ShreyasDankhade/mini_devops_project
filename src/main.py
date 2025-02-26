import os
import boto3
import pymysql
import logging

# Set up logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)


def read_data_from_s3(bucket_name, object_key):
    """
    Reads an object from S3 and returns its content as a string.
    """
    s3 = boto3.client('s3')
    response = s3.get_object(Bucket=bucket_name, Key=object_key)
    data = response['Body'].read().decode('utf-8')
    return data


def push_data_to_rds(data):
    """
    Connects to an RDS database and inserts the provided data into the 'data_table' table.
    Adjust the SQL query if your table structure is different.
    """
    connection = pymysql.connect(
        host=os.environ['RDS_HOST'],
        user=os.environ['RDS_USER'],
        password=os.environ['RDS_PASSWORD'],
        database=os.environ['RDS_DB']
    )
    try:
        with connection.cursor() as cursor:
            # Update the table name and column names as necessary
            sql = "INSERT INTO data_table (data) VALUES (%s)"
            cursor.execute(sql, (data,))
        connection.commit()
    except Exception as e:
        logger.error("Error inserting data into RDS: %s", e)
        raise e
    finally:
        connection.close()


def handler(event, context):
    """
    AWS Lambda handler function.
    Reads data from S3 and pushes it to RDS.
    """
    logger.info("Lambda function started.")

    # Retrieve configuration from environment variables
    s3_bucket = os.environ.get('S3_BUCKET')
    s3_object_key = os.environ.get('S3_OBJECT_KEY')

    if not s3_bucket or not s3_object_key:
        raise Exception(
            "S3_BUCKET and S3_OBJECT_KEY environment variables must be set.")

    try:
        logger.info("Reading data from S3 bucket '%s', key '%s'.",
                    s3_bucket, s3_object_key)
        data = read_data_from_s3(s3_bucket, s3_object_key)
    except Exception as e:
        logger.error("Failed to read data from S3: %s", e)
        raise e

    try:
        logger.info("Pushing data to RDS.")
        push_data_to_rds(data)
    except Exception as e:
        logger.error("Failed to push data to RDS: %s", e)
        raise e

    logger.info("Data successfully transferred from S3 to RDS.")
    return {
        "statusCode": 200,
        "body": "Data successfully transferred from S3 to RDS"
    }


# For local testing
if __name__ == '__main__':
    # Set these values to test locally; in Lambda, use environment variables.
    os.environ['S3_BUCKET'] = 'go-digital-devops'
    os.environ['S3_OBJECT_KEY'] = 'sample-data.txt'
    os.environ['RDS_HOST'] = 'go-digital-db.c5oicwa8wscl.ap-south-1.rds.amazonaws.com'
    os.environ['RDS_USER'] = 'admin'
    os.environ['RDS_PASSWORD'] = 'go-digital-db'
    os.environ['RDS_DB'] = 'go-digital-db'

    # Simulate a Lambda event
    result = handler({}, None)
    print(result)
