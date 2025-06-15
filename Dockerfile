# Use an official Node.js runtime as a parent image
# Using a specific version is good practice for reproducibility
FROM node:18-alpine

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
# This step is separated to leverage Docker's layer caching
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy the rest of the application source code to the working directory
COPY . .

# Expose port 3000 to the outside world
EXPOSE 3000

# Define the command to run the application
CMD [ "node", "app.js" ]
