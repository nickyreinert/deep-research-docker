#!/bin/bash

# Set variables
CONTAINER_NAME="deep-research-container"
IMAGE_NAME="deep-research-image"
REPO_URL="git@github.com:dzhng/deep-research.git"
HOST_DIR="deep-research"  # Clones repo here on the host
CONTAINER_DIR="/usr/src/app"

# check if .env.local exists
if [ ! -f "$(pwd)/.env.local" ]; then
    cp "$(pwd)/.env.example" "$(pwd)/.env.local"

    echo "Please fill in the values for FIRECRAWL_KEY and OPENAI_KEY in the .env.local file"
    echo "You can get the FIRECRAWL_KEY from https://firecrawl.com"
    echo "You can get the OPENAI_KEY from https://platform.openai.com"
    
    read -p "Enter FIRECRAWL_KEY: " FIRECRAWL_KEY
    read -p "Enter OPENAI_KEY: " OPENAI_KEY

    # write them to .env.local
    echo "FIRECRAWL_KEY=$FIRECRAWL_KEY" >> "$(pwd)/.env.local"
    echo "OPENAI_KEY=$OPENAI_KEY" >> "$(pwd)/.env.local"

fi

# Step 1: Clone the repository on the host
if [ ! -d "$HOST_DIR/.git" ]; then
    echo "Cloning the repository on the host..."
    git clone "$REPO_URL" "$HOST_DIR"
else
    echo "Repository already exists, pulling latest changes..."
    cd "$HOST_DIR" && git pull origin main
    docker stop "$CONTAINER_NAME" && docker rm "$CONTAINER_NAME"
    cd ..
fi

# Step 2: Build the Docker image
echo "Building the Docker image..."
docker build -t "$IMAGE_NAME" .

# Step 3: Run the container with the host directory mounted
echo "Starting the Docker container..."
docker run -itd --name "$CONTAINER_NAME" \
    -v "$(pwd)/$HOST_DIR:/usr/src/app" \
    "$IMAGE_NAME"

cp .env.local $HOST_DIR/.env.local

# Step 4: Install npm dependencies inside the container
echo "Installing dependencies inside the container..."
docker exec -it "$CONTAINER_NAME" bash -c "cd $CONTAINER_DIR && npm install"

echo "Starting the app..."
docker exec -it "$CONTAINER_NAME" bash -c "cd $CONTAINER_DIR && npm start"
