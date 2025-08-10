# Use official Tomcat image with Java 11
FROM tomcat:9.0-jdk11-openjdk

# Remove default ROOT webapp
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy your WAR file into Tomcat's webapps folder as ROOT.war
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]
