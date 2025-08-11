# Use the official Tomcat image as the base
FROM tomcat:9.0-jdk11

# Copy your WAR file into the Tomcat webapps directory
COPY abc.war /usr/local/tomcat/webapps/

# Start the Tomcat server
CMD ["catalina.sh", "run"]
