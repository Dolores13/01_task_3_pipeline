# TASK 3 - DEVOPS PIPELINE: SIMPLE CALCULATOR 
This repsiitory contains my work for the Task 3, the objective of which was to create a simple web and building a small DevOps pipeline around it.
Everything was done step by step and focused on learning the fundamentals of the DevOps phases, which were: code, CI (Build + test), security, container, IaC, Deploy and Monitoring

# 1 PHASE SOURCE CODE MANAGEMENT: CREATE WEB WITH JAVE > MAVEN > GIT > GITHUB.
I created a simple Java calculator introducing a function to be able to use HTML and Javascript helped me create the frontend. 
The application is a simple calculator where you tell it the numbers you want to calculate and the operation you want to perform, and it automatically returns the result, displaying the operation.
I used Maven commands like the JUnit test:
  -mvn clean test
  -mv package
  -java -cp target/classes com.example.devops.SimpleCalculate

I used Git for version control:
  -git add .
  -git commit -m "menssage"
  -git push
Also, I added a GitHub all my project with "git push" 

# 2 PHASE AUTOMATED BUILDS AND TESTING: GITHUB ACTIONS
I added a GitHub Actions workflow so that every time I push code:
-the project is built with Maven
-the tests run
-Snyk scans the dependencies
-Dockers building the imagin 

# 3 PHASE SECURITY SCANNING 
Snyck checks for security issues in the Maven dependencies. I only had to create a token in Snyk and save it as a GitHub secret.
Ther results appear in GitHub under: Security > Code Scanning Alerts

# 4 PHASE CONTAINERISATION: DOCKER
I wrote a Dockerfile so the calculator can run inside a container, this was useful to learn how to package an application.
I used the commands: 
  - docker build -t calculator-app docker run -p 9090:9090 cualculator-app
