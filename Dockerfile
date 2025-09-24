# 1. Sử dụng OpenJDK 17 làm base image
FROM eclipse-temurin:17-jdk-alpine

# 2. Tạo thư mục app trong container
WORKDIR /app

# 3. Copy file pom.xml và source code
COPY pom.xml .
COPY src ./src

# 4. Build project với Maven (tạo fat jar)
RUN ./mvnw clean package -DskipTests

# 5. Copy file jar ra thư mục app (jar nằm trong target/)
RUN cp target/*.jar app.jar

# 6. Mở port 8080 (Spring Boot default)
EXPOSE 8080

# 7. Chạy ứng dụng
ENTRYPOINT ["java","-jar","app.jar"]
