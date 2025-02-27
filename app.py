import boto3
import pymysql
import os
import json

# AWS S3 and RDS details from Environment Variables
S3_BUCKET = os.getenv("S3_BUCKET")
S3_FILE_KEY = os.getenv("S3_FILE_KEY")
RDS_HOST = os.getenv("RDS_HOST")
RDS_USER = os.getenv("RDS_USER")
RDS_PASSWORD = os.getenv("RDS_PASSWORD")
RDS_DATABASE = os.getenv("RDS_DATABASE")


def lambda_handler(event, context):
    # Initialize S3 client
    s3 = boto3.client('s3')

    # Download file from S3
    response = s3.get_object(Bucket=S3_BUCKET, Key=S3_FILE_KEY)
    data = response['Body'].read().decode('utf-8')

    # Parse data (assuming it's JSON)
    records = json.loads(data)

    # Connect to RDS
    conn = pymysql.connect(
        host=RDS_HOST,
        user=RDS_USER,
        password=RDS_PASSWORD,
        database=RDS_DATABASE
    )
    cursor = conn.cursor()

    # Insert data into RDS (Assume 'users' table)
    for record in records:
        sql = "INSERT INTO users (name, email) VALUES (%s, %s)"
        cursor.execute(sql, (record['name'], record['email']))

    conn.commit()
    cursor.close()
    conn.close()

    return {"message": "Data Inserted Successfully"}
