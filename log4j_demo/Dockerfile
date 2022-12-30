## make this docker as secure as possible

# we need maven to build the application
FROM maven:3.6-openjdk-17-slim

## copy files
ADD src src
ADD pom.xml pom.xml

# build the application
RUN mvn clean package

# rename the artifact 
RUN mv ./target/*jar /opt/app.jar

CMD ["java" ,"-jar", "/opt/app.jar"]


## though we need maven to build the application we dont need it to run the it
## so we can make a multi-stage dockerfile to minimize the size