
#!/bin/bash
set -eux

# Update system packages
apt-get update -y
apt-get upgrade -y

# Install Docker, Git and Nginx
apt-get install -y docker.io git nginx

# Enable and start Docker service
systemctl enable docker
systemctl start docker

# Enable and start Nginx service
systemctl enable nginx
systemctl start nginx

# Move to working directory
cd /opt

# Clone your GitHub repository (public)
git clone https://github.com/Dolores13/01_task_3_pipeline.git

# Navigate to the folder that contains the Dockerfile
cd 01_task_3_pipeline/task3-pipeline

# Build the Docker image using the existing Dockerfile
docker build -t calculator-app:latest .

# Run the application container in the background publishing port 9090
docker run -d --name calculator-container -p 9090:9090 calculator-app:latest || true
