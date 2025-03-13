# Use Node.js base image
FROM node:14

# Set the working directory
WORKDIR /app

# Copy the package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the app code
COPY . .

# Expose the port
EXPOSE 8080

# Run the app
CMD ["node", "server.js"]
