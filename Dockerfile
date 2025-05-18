#get Base image  for maven building
FROM maven:3.8.3-openjdk-17 AS builder

# Make a  directory for app 
WORKDIR /app

# Copy everything from files
copy . .

# Build maven for jar files
RUN mvn clean install -DskipTests=true

# Get base image to run java app

FROM openjdk:17-alpine

#copy previous build files form builder
COPY --from=builder /app/target/*.jar /app/target/expenseapp.jar

#expose a port to run
EXPOSE 8080

#Entry point to app
ENTRYPOINT [ "java","-jar","/app/target/expenseapp.jar" ]
