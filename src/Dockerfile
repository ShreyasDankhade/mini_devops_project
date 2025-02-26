# Build the Docker image
FROM public.ecr.aws/lambda/python:3.9

# Copy your application code
COPY main.py ${LAMBDA_TASK_ROOT}
COPY requirements.txt ${LAMBDA_TASK_ROOT}

# Install dependencies into the Lambda environment
RUN pip install -r requirements.txt --target ${LAMBDA_TASK_ROOT}

# Set the CMD to your handler (e.g., app.handler)
CMD ["main.handler"]
