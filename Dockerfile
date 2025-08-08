# Stage 1: Build
FROM node:18-alpine as builder
WORKDIR /app
COPY . .
WORKDIR /app
RUN npm install 
RUN npm start 
# Stage 2: Serve
FROM nginx:alpine
COPY --from=builder /app
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]
