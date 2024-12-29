# Use the base Python image
FROM python:3.12.1-slim

# Set the working directory inside the container
WORKDIR /app

# Install MySQL client and other necessary system dependencies
# Install necessary system dependencies
RUN apt-get update && apt-get install -y \
    pkg-config \
    default-libmysqlclient-dev \
    gcc \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*


# Copy the requirements file and install Python dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire application code into the container
COPY . /app/

# Expose the port the application will run on
EXPOSE 8000

# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh

# Make the script executable
RUN chmod +x /entrypoint.sh

# Use the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]

# Command to run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

