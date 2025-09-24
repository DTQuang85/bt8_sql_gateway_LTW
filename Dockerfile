# Dockerfile cho Spring Boot + JSP trên Render

# 1. Base image: OpenJDK 17 + Alpine (nhẹ)
FROM eclipse-temurin:17-jdk-alpine

# 2. Cài Maven
RUN apk add --no-cache maven bash

# 3. Tạo thư mục app trong container
WORKDIR /app

# 4. Copy project
COPY pom.xml .
COPY src ./src

# 5. Build Spring Boot fat jar (bỏ test để nhanh)
RUN mvn clean package -DskipTests

# 6. Copy file jar ra app.jar
RUN cp target/*.jar app.jar

# 7. Expose port 8080 (Spring Boot default)
EXPOSE 8080

# 8. Run app
ENTRYPOINT ["java","-jar","app.jar"]
