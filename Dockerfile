#FROM openjdk:19
#EXPOSE 8080
#ADD target/virtualfaker.jar virtualfaker.jar
#ENTRYPOINT ["java", "-jar", "/virtualfaker.jar"]

# Etapa de construcción
FROM maven:latest AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Etapa de empaquetado (runtime)
FROM openjdk:19-jdk-slim
WORKDIR /app
# Copia el JAR de la etapa 'build' a la etapa actual
COPY --from=build /app/target/virtualfaker.jar virtualfaker.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","virtualfaker.jar"]