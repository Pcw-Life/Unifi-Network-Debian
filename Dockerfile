# Use a base image with Java installed, as UniFi Network Server requires Java
FROM openjdk:8-jdk

# Set environment variables
ENV UNIFI_VERSION=latest
ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install dependencies
RUN apt-get update && \
    apt-get install -y wget gnupg && \
    wget -qO - https://dl.ui.com/unifi/unifi-repo.gpg | apt-key add - && \
    echo 'deb https://www.ui.com/download/unifi/debian beta ubiquiti' | tee /etc/apt/sources.list.d/unifi.list && \
    apt-get update && \
    apt-get install -y unifi && \
    apt-get clean

# Download the latest image/logo from UniFi website and save it to the web directory
RUN wget https://dl.ui.com/images/unifi-app-logo.png -O /usr/lib/unifi/images/unifi-logo.png

# Expose necessary ports
EXPOSE 8080 8443 8880 8843 6789

# Copy the nightly update script
COPY nightly-update.sh /usr/local/bin/nightly-update.sh
RUN chmod +x /usr/local/bin/nightly-update.sh

# Add a cron job to check for updates nightly
RUN echo "0 2 * * * /usr/local/bin/nightly-update.sh" > /etc/cron.d/unifi-nightly-update

# Start the UniFi Network Server
CMD ["java", "-jar", "/usr/lib/unifi/lib/ace.jar", "start"]