# # Stage 1: Build
# FROM node:18-alpine as builder
# WORKDIR /app

# # Copy package.json and package-lock.json to leverage Docker cache
# COPY package*.json ./

# # Install dependencies
# RUN npm install

# # Copy the rest of the application code
# COPY . .

# # Build the application
# RUN npm run build

# # Stage 2: Serve with Nginx
# FROM nginx:alpine

# COPY --from=builder /app /app

# # Expose port 3000
# EXPOSE 3000

# # Run Nginx and bind it to port 3000
# CMD ["nginx", "-g", "daemon off;", "-p", "3000"]

# Stage 1: Build the React application
FROM node:18-alpine as builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Serve the built application with Nginx
FROM nginx:alpine

COPY --from=builder /app/build /usr/share/nginx/html

# Optional: Copy a custom Nginx configuration if needed
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]


# # Stage 1: Build
# FROM node:18-alpine AS builder
# WORKDIR /app

# # Copy only package files first for caching
# COPY package*.json ./

# RUN npm install

# # Copy the rest of the source code
# COPY . .

# RUN npm run build

# # Stage 2: Serve
# FROM node:18-alpine
# WORKDIR /app

# COPY --from=builder /app /app

# EXPOSE 3000
# CMD ["node", "dist/server.js"]  # Adjust for your entry point
