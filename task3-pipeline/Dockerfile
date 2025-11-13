FROM maven:3.9.6-eclipse-temurin-17

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn -q -DskipTests package

EXPOSE 8080

CMD ["java", "-cp", "target/classes", "com.example.devops.SimpleCalculate"]

