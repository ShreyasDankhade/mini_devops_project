# # Use an official Python runtime as a base image
# FROM python:3.9-slim

# # Set the working directory inside the container
# WORKDIR /app

# # Copy the requirements file into the container
# COPY requirements.txt .

# # Install the dependencies specified in requirements.txt
# RUN pip install -r requirements.txt

# # Copy the rest of the application code into the container
# COPY . .

# # Set the command to run your application
# CMD ["python", "app.py"]

FROM public.ecr.aws/lambda/python:3.9

# Copy your application code
COPY main.py ${LAMBDA_TASK_ROOT}
COPY requirements.txt ${LAMBDA_TASK_ROOT}

# Install dependencies into the Lambda environment
RUN pip install -r requirements.txt --target ${LAMBDA_TASK_ROOT}

# Set the CMD to your handler (e.g., app.handler)
CMD ["app.handler"]
