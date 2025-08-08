# Stage 1: Build
FROM node:18-alpine as builder
WORKDIR /app

# Copy package.json and package-lock.json to leverage Docker cache
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy the build folder from the builder stage to the Nginx html folder
COPY --from=builder /app/build /usr/share/nginx/html

# Expose port 3000
EXPOSE 3000

# Run Nginx and bind it to port 3000
CMD ["nginx", "-g", "daemon off;", "-p", "3000"]
