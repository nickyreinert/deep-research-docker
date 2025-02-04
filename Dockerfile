# Use the official Node.js image as a base
FROM node:latest

# Install git inside the container
RUN apt-get update && apt-get install -y git

# Set the working directory inside the container
WORKDIR /usr/src/app

# Ensure the container can use SSH for GitHub (for private repos)
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh

# Expose the port (change if needed)
EXPOSE 3000

# Run a shell by default so we can exec into the container
CMD ["/bin/bash"]