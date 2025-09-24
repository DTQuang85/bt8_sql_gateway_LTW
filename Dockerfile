# Dockerfile
FROM eclipse-temurin:17-jre-alpine

# Thư mục làm việc
WORKDIR /app

# Copy file JAR
COPY target/tuan7-0.0.1-SNAPSHOT.jar app.jar

# Tạo user không phải root để chạy ứng dụng
RUN addgroup -S spring && adduser -S spring -G spring
USER spring

# Expose port
EXPOSE 8080

# Chạy ứng dụng
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
