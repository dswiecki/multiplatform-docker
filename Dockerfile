FROM gradle:7.3.0-jdk17 as builder

COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon

FROM eclipse-temurin:17-jre-jammy

RUN mkdir /app

COPY --from=builder /home/gradle/src/build/libs/multiplatform-docker-0.0.1-SNAPSHOT.jar /app/multiplatform-docker-0.0.1-SNAPSHOT.jar

EXPOSE 8080

CMD java -jar /app/multiplatform-docker-0.0.1-SNAPSHOT.jar

