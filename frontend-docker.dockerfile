# Stage 1: Build the Angular app
FROM node:18 AS build

# Set the working directory
WORKDIR /rp-app

# Copy package.json and package-lock.json to install dependencies
COPY rp-app-frontend/package*.json ./

# Install dependencies
RUN npm install

# Copy the entire Angular project into the container
COPY rp-app-frontend ./

# Build the Angular app with production settings
RUN npm run build -- --configuration=production

# Stage 2: Set up the Node.js server to serve the built files
FROM node:18

# Set the working directory in the container
WORKDIR /rp-app

# Copy the build files from the previous stage
COPY --from=build /rp-app/dist/rp-app-frontend ./dist

# Copy the server.js file to the container
COPY server.js .

# Install only production dependencies (Express)
RUN npm install express

# Expose the port the app runs on
EXPOSE 8080

# Start the Node.js server
CMD ["node", "server.js"]
