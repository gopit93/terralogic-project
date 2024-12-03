# Use the official Node.js image
FROM node:16

# Create and set the working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the source code
COPY . .

# Expose the port used by the app
EXPOSE 3000

# Start the application
CMD ["node", "index.js"]
