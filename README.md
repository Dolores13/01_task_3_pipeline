# TASK 3 - DEVOPS PIPELINE: SIMPLE CALCULATOR 
This repsiitory contains my work for the Task 3, the objective of which was to create a simple web and building a small DevOps pipeline around it.
Everything was done step by step and focused on learning the fundamentals of the DevOps phases, which were: code, CI (Build + test), security, container, IaC, Deploy and Monitoring

## 1 PHASE SOURCE CODE MANAGEMENT: CREATE WEB WITH JAVA > MAVEN > GIT > GITHUB.
I created a simple Java calculator introducing a function to be able to use HTML and Javascript helped me create the frontend. 
The application is a simple calculator where you tell it the numbers you want to calculate and the operation you want to perform, and it automatically returns the result, displaying the operation.
I used Maven commands like the JUnit test:
  
  - mvn clean test
  - mv package
  - java -cp target/classes com.example.devops.SimpleCalculate

I used Git for version control:
  
  - git add .
  - git commit -m "message"
  - git push
  
Also, I added a GitHub all my project with "git push" 

## 2 PHASE AUTOMATED BUILDS AND TESTING: GITHUB ACTIONS
I added a GitHub Actions workflow so that every time I push code:

- the project is built with Maven
- the tests run
- Snyk scans the dependencies
- Dockers building the imagin 

## 3 PHASE SECURITY SCANNING: SNYK
Snyck checks for security issues in the Maven dependencies. I only had to create a token in Snyk and save it as a GitHub secret.
Ther results appear in GitHub under: Security > Code Scanning Alerts

## 4 PHASE CONTAINERISATION: DOCKER
I wrote a Dockerfile so the calculator can run inside a container, this was useful to learn how to package an application.
I used the commands: 

  - docker build -t calculator-app
  - docker run -p 9090:9090 cualculator-app

## 5 PHASE DEPLOYMENT TO A CLOUD PLATAFORM: TERRAFORM >> AWS
For the infrastructure part, I used Terraform to create:

- A VPC (using a module)
- Public subnets
- A security group
- An EC2 instance

In the EC2 instance, a user-data script installs Docker, Git and Nginx, clones this repository, builds the Docker image and starts the container automatically.

The command I used was: 

- terraform init
- terraform validate
- terraform plan
- terraform apply or terraform apply -auto-approve

## 6 PHASE MONITORING: CLOUDWATCH

I enabled monitoring on the EC2 instance and also created a CloudWatch alarm with Terraform, also the alarm triggers when CPU usage is too high.

## SUMAMARY

This project helped me understand the main stages of a DevOps pipeline:

- writing code  
- running tests automatically  
- scanning for security issues  
- packaging with Docker  
- deploying infrastructure with Terraform  
- running everything in AWS  
- adding basic monitoring  

## MADE BY:

Maria Dolores Martos Cabrera  
Postgraduate in DevOps Engineering – ATU Donegal

