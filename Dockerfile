FROM maven:3.8.1-adoptopenjdk-11 as base
WORKDIR /app
COPY . .
RUN mvn clean install

FROM tomcat:8.0-alpine
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY --from=base /app/target/WebApp.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8085
CMD ["catalina.sh","run"]

