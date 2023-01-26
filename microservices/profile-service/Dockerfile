FROM anapsix/alpine-java:8
VOLUME /tmp
# ADD account-service-0.0.1-SNAPSHOT.jar app.jar
RUN bash -c 'touch /app.jar'
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

# FROM openjdk:8-jre
# VOLUME /tmp
# ADD account-service-0.0.1-SNAPSHOT.jar app.jar
# MAINTAINER David Flemström <dflemstr@spotify.com>
# RUN bash -c 'touch /app.jar'
# ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

# Add Maven dependencies (not shaded into the artifact; Docker-cached)
# ADD target/lib           /usr/share/myservice/lib
# Add the service itself
# ARG JAR_FILE
# ADD target/${JAR_FILE} /usr/share/myservice/myservice.jar
