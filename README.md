UniFi Network Server Docker Setup (Beta Release)

This repository contains the Docker setup to self-host a beta UniFi Network Server. This Dockerfile will pull the early release version of UniFi Controller software and set up the required environment for hosting your own UniFi Network Server.

Requirements

1. Docker installed on your system.
2. Adequate system resources to run the UniFi Controller (e.g., 2 GB of RAM or more recommended).

Build and Run Instructions

Step 1: Clone the Repository

First, clone this repository:

```sh
git clone https://github.com/PCW-Life/unifi-controller.git
cd unifi-controller
```
### Step 1: Build the Docker Image

To build the Docker image using the provided Dockerfile, run:

```sh
docker build -t unifi-controller-beta:latest .
```

### Step 2:  Run the Container

After the image is built, run it using:

```sh
docker run -d –name unifi-controller-beta 
-p 8080:8080 
-p 8443:8443 
-p 8880:8880 
-p 8843:8843 
-p 6789:6789 
unifi-controller-beta:latest
```

##Ports Explanation:

8080: Device communication
8443: Controller GUI/API as HTTPS
8880: HTTP portal redirect
8843: HTTPS portal
6789: Speed Test

# Updating the UniFi Network Server

## To update the UniFi Network Server to the latest beta version:

### Step 1. Stop the running container:

```sh
docker stop unifi-controller-beta
```

### Step 2. Remove the container:

```sh
docker rm unifi-controller-beta
```
### Step 3. Pull the latest image from the Docker Hub:

```sh
docker pull unifi-controller-beta:latest
```

### Step 5. Re-run the container:

```sh
docker run -d –name unifi-controller-beta 
-p 8080:8080 
-p 8443:8443 
-p 8880:8880 
-p 8843:8843 
-p 6789:6789 
unifi-controller-beta:latest
```
### Explanation:
1. **Base Image**:
   - We’re using `openjdk:8-jdk` since the UniFi Network Server requires Java 8 to run.

2. **Environment Variables**:
   - `UNIFI_VERSION=latest`: This ensures the latest version of UniFi is pulled.
   - `DEBIAN_FRONTEND=noninteractive`: Prevents prompts during package installations.

3. **RUN Commands**:
   - Install necessary tools (wget, gnupg).
   - Add UniFi repository key and configure the package source to point to the beta channel.
   - Install UniFi and clean up to keep the Docker image smaller.

4. **Expose Ports**:
   - The required ports (8080, 8443, 8880, 8843, 6789) are exposed so that the UniFi controller can communicate as expected.

5. **Start Command**:
   - The container starts by running `ace.jar`, which is the core of the UniFi Network Server.

# Contributing

Feel free to open a pull request or issue if you would like to contribute to the development or report a bug.

# License

This project is licensed under the MIT License.


## Additional Resources

For more information and help with the UniFi Network Server, you can refer to the following resources:

- [UniFi Network Controller User Guide](https://www.ui.com/download/unifi)
- [UniFi Community Forums](https://community.ui.com/)
- [Docker Documentation](https://docs.docker.com/)
- [GitHub Issues](https://github.com/PCW-Life/unifi-controller/issues)
- [Updating and Installing Self-Hosted UniFi Network Servers (Linux)](https://help.ui.com/hc/en-us/articles/220066768-Updating-and-Installing-Self-Hosted-UniFi-Network-Servers-Linux)

## Author
PCW-Life
