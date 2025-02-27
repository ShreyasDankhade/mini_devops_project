# Use official Python runtime as base image
FROM python:3.9

# Set working directory
WORKDIR /app

# Copy the application files
COPY app.py .

# Install dependencies
RUN pip install boto3 pymysql

# Define entrypoint
CMD ["python", "app.py"]
