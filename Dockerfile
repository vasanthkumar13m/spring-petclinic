FROM eclipse-temurin:25-jre
LABEL maintainer="Vasanth Kumar"
WORKDIR /app
COPY json-java.jar json-java.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "json-java.jar"]
